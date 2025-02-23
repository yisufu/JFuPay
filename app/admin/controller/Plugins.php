<?php

namespace app\admin\controller;

use app\common\controller\Backend;

/**
 * 插件列管理
 */
class Plugins extends Backend
{
    /**
     * Plugins模型对象
     * @var object
     * @phpstan-var \app\common\model\Plugins
     */
    protected object $model;

    protected array|string $preExcludeFields = ['id', 'update_time', 'create_time'];

    protected string|array $quickSearchField = ['id'];

    public function initialize(): void
    {
        parent::initialize();
        $this->model = new \app\common\model\Plugins();
    }


    /**
     * 若需重写查看、编辑、删除等方法，请复制 @see \app\admin\library\traits\Backend 中对应的方法至此进行重写
     */

    /**
     * 同步本地插件到数据库
     */
    public function syncLocalPlugins()
    {
        $pluginsPath = root_path() . 'extend/plugins/';
        $dirs = glob($pluginsPath . '*', GLOB_ONLYDIR);
        
        foreach ($dirs as $dir) {
            $pluginName = basename($dir);
            $classFile = $dir . '/' . $pluginName . '.php';
            
            if (file_exists($classFile)) {
                $className = "\\plugins\\{$pluginName}\\{$pluginName}";
                
                if (class_exists($className) && isset($className::$info)) {
                    $info = $className::$info;
                    
                    // 检查插件是否已存在
                    $exists = $this->model->where('plugin_name', $info['showname'])->find();
                    
                    $data = [
                        'plugin_name' => $info['showname'],
                        'class_name'  => $info['name'],
                        'author'      => $info['author'],
                        'website'     => $info['link']
                    ];
                    
                    if ($exists) {
                        // 更新现有记录
                        $this->model->where('plugin_name', $info['showname'])->update($data);
                    } else {
                        // 插入新记录
                        $this->model->save($data);
                    }
                }
            }
        }
        
        $this->success('本地插件同步成功');
    }

    /**
     * 获取插件配置信息
     */
    public function getConfig()
    {
        $id = $this->request->post('id');
        if (!$id) {
            $this->error('参数错误');
        }

        $plugin = $this->model->find($id);
        if (!$plugin) {
            $this->error('插件不存在');
        }

        // 构造完整的类名
        $className = "\\plugins\\" . $plugin['class_name'] . "\\" . $plugin['class_name'];
        if (!class_exists($className)) {
            $this->error('插件类不存在:' . $className);
        }

        $info = $className::$info;
        $this->success('获取成功', ['info' => $info]);
    }
}