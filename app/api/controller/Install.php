<?php
declare (strict_types=1);

namespace app\api\controller;

use ba\Version;
use think\App;
use think\facade\Db;
use think\facade\Config;
use app\common\controller\Api;
use think\db\exception\PDOException;
use app\admin\model\Admin as AdminModel;

/**
 * 安装控制器
 */
class Install extends Api
{
    protected bool $useSystemSettings = false;

    /**
     * 环境检查状态
     */
    static string $ok   = 'ok';
    static string $fail = 'fail';
    static string $warn = 'warn';

    /**
     * 安装锁文件名称
     */
    static string $lockFileName = 'install.lock';

    /**
     * 配置文件
     */
    static string $dbConfigFileName    = 'database.php';
    static string $buildConfigFileName = 'buildadmin.php';

    /**
     * 自动构建的前端文件的 outDir 相对于根目录
     */
    static string $distDir = 'web' . DIRECTORY_SEPARATOR . 'dist';

    /**
     * 需要的依赖版本
     */
    static array $needDependentVersion = [
        'php'  => '7.4.0',
        'mysql' => '5.7.0'
    ];

    /**
     * 安装完成标记
     */
    static string $InstallationCompletionMark = 'install-end';

    /**
     * 临时安装锁标记
     */
    static string $InstallationTempMark = 'installing';

    /**
     * 构造方法
     * @param App $app
     */
    public function __construct(App $app)
    {
        parent::__construct($app);
        // 检查是否可以访问API
        if (!$this->canAccessApi() && !in_array($this->request->action(), ['checkEnv','envBaseCheck'])) {
            $this->error(__('Please complete the installation first'));
        }
    }

    /**
     * 检查环境
     */
    public function checkEnv()
    {
        if ($this->isInstallComplete()) {
            $this->error('系统已安装,如需重新安装请删除install.lock文件');
        }

        $envCheck = [];

        // 检查PHP版本
        $phpVersion = phpversion();
        $phpVersionCompare = Version::compare(self::$needDependentVersion['php'], $phpVersion);
        $envCheck['php_version'] = [
            'name' => 'PHP版本',
            'required' => '>= ' . self::$needDependentVersion['php'],
            'current' => $phpVersion,
            'status' => $phpVersionCompare ? 'ok' : 'fail'
        ];

        // 检查PDO扩展
        $pdoCheck = extension_loaded("PDO") && extension_loaded('pdo_mysql');
        $envCheck['pdo'] = [
            'name' => 'PDO扩展',
            'required' => '已安装',
            'current' => $pdoCheck ? '已安装' : '未安装',
            'status' => $pdoCheck ? 'ok' : 'fail'
        ];

        // 检查Curl扩展
        $curlCheck = extension_loaded("curl");
        $envCheck['curl'] = [
            'name' => 'Curl扩展',
            'required' => '已安装',
            'current' => $curlCheck ? '已安装' : '未安装',
            'status' => $curlCheck ? 'ok' : 'fail'
        ];

        // 检查目录权限
        $publicWritable = is_writable(public_path());
        $envCheck['public_writable'] = [
            'name' => 'public目录权限',
            'required' => '可写',
            'current' => $publicWritable ? '可写' : '不可写',
            'status' => $publicWritable ? 'ok' : 'fail'
        ];

        $this->success('环境检查完成', $envCheck);
    }

    /**
     * 测试数据库连接
     */
    public function testDatabase()
    {
        $params = $this->request->post();
        $database = [
            'hostname' => $params['hostname'] ?? '127.0.0.1',
            'username' => $params['username'] ?? '',
            'password' => $params['password'] ?? '',
            'hostport' => $params['hostport'] ?? '3306',
            'database' => '',
        ];

        try {
            $connect = $this->connectDb($database);
            if ($connect['code'] == 0) {
                $this->error($connect['msg']);
            }
            $this->success('数据库连接成功', [
                'databases' => $connect['databases']
            ]);
        } catch (\Exception $e) {
            $this->error('数据库连接失败：' . $e->getMessage());
        }
    }

    /**
     * 安装系统
     */
    public function install()
    {
        if ($this->isInstallComplete()) {
            $this->error('系统已安装,如需重新安装请删除install.lock文件');
        }

        $params = $this->request->post();
        
        // 验证参数
        $validateRule = [
            'hostname' => 'require',
            'username' => 'require',
            'password' => 'require',
            'database' => 'require',
            'prefix' => 'require',
            'adminname' => 'require',
            'adminpassword' => 'require|min:6',
            'sitename' => 'require'
        ];
        
        $validate = validate($validateRule);
        if (!$validate->check($params)) {
            $this->error($validate->getError());
        }

        try {
            // 连接数据库
            $database = [
                'hostname' => $params['hostname'],
                'username' => $params['username'],
                'password' => $params['password'],
                'hostport' => $params['hostport'] ?? '3306',
                'database' => $params['database'],
                'prefix' => $params['prefix']
            ];

            $connect = $this->connectDb($database);
            if ($connect['code'] == 0) {
                $this->error($connect['msg']);
            }

            // 创建数据库
            if (!in_array($database['database'], $connect['databases'])) {
                $sql = "CREATE DATABASE IF NOT EXISTS `{$database['database']}` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci";
                $connect['pdo']->exec($sql);
            }

            // 导入SQL
            $sqlFile = root_path() . 'install.sql';
            if (is_file($sqlFile)) {
                $sql = file_get_contents($sqlFile);
                $sql = str_replace('__PREFIX__', $database['prefix'], $sql);
                $connect['pdo']->exec($sql);
            }

            // 修改管理员信息
            $adminModel = new AdminModel();
            $admin = $adminModel->where('username', 'admin')->find();
            $admin->username = $params['adminname'];
            $admin->nickname = ucfirst($params['adminname']);
            $admin->save();
            
            if (isset($params['adminpassword']) && $params['adminpassword']) {
                $adminModel->resetPassword($admin->id, $params['adminpassword']);
            }

            // 修改站点名称
            \app\admin\model\Config::where('name', 'site_name')->update([
                'value' => $params['sitename']
            ]);

            // 写入安装锁定文件
            file_put_contents(public_path() . self::$lockFileName, self::$InstallationCompletionMark);

            $this->success('安装成功');
        } catch (\Exception $e) {
            $this->error('安装失败：' . $e->getMessage());
        }
    }

    /**
     * 检查是否已安装
     */
    protected function isInstallComplete(): bool
    {
        if (is_file(public_path() . self::$lockFileName)) {
            $contents = @file_get_contents(public_path() . self::$lockFileName);
            // 只有包含完整安装标记的才算安装完成
            if ($contents == self::$InstallationCompletionMark) {
                return true;
            }
        }
        return false;
    }

    /**
     * 检查是否可以访问API
     */
    protected function canAccessApi(): bool
    {
        if (is_file(public_path() . self::$lockFileName)) {
            $contents = @file_get_contents(public_path() . self::$lockFileName);
            return in_array($contents, [self::$InstallationTempMark, self::$InstallationCompletionMark]);
        }
        // 如果文件不存在,创建临时安装锁
        $result = @file_put_contents(public_path() . self::$lockFileName, self::$InstallationTempMark);
        return $result !== false;
    }

    /**
     * 连接数据库
     */
    private function connectDb(array $database, bool $returnPdo = true): array
    {
        try {
            $dbConfig = Config::get('database');
            $dbConfig['connections']['mysql'] = array_merge($dbConfig['connections']['mysql'], $database);
            Config::set(['connections' => $dbConfig['connections']], 'database');

            $connect = Db::connect('mysql');
            $connect->execute("SELECT 1");
        } catch (PDOException $e) {
            $errorMsg = $e->getMessage();
            return [
                'code' => 0,
                'msg'  => '数据库连接失败：' . mb_convert_encoding($errorMsg ?: 'unknown', 'UTF-8', 'UTF-8,GBK,GB2312,BIG5')
            ];
        }

        $databases = [];
        // 不需要的数据表
        $databasesExclude = ['information_schema', 'mysql', 'performance_schema', 'sys'];
        $res = $connect->query("SHOW DATABASES");
        foreach ($res as $row) {
            if (!in_array($row['Database'], $databasesExclude)) {
                $databases[] = $row['Database'];
            }
        }

        return [
            'code'      => 1,
            'msg'       => '',
            'databases' => $databases,
            'pdo'       => $returnPdo ? $connect->getPdo() : '',
        ];
    }

    public function baseConfig(): void
    {
        if ($this->isInstallComplete()) {
            $this->error(__('The system has completed installation. If you need to reinstall, please delete the %s file first', ['public/' . self::$lockFileName]));
        }

        // ... existing code ...

        // 建立临时安装锁文件(如果不存在)
        if (!is_file(public_path() . self::$lockFileName)) {
            $result = @file_put_contents(public_path() . self::$lockFileName, self::$InstallationTempMark);
            if (!$result) {
                $this->error(__('File has no write permission:%s', ['public/' . self::$lockFileName]));
            }
        }

        $this->success('', [
            'rootPath'            => $rootPath,
            'executionWebCommand' => $envOk
        ]);
    }
}
