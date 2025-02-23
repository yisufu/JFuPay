<?php

namespace app\api\controller;

use Throwable;
use think\Response;
use think\facade\Cache;
use app\common\library\Upload;
use app\common\controller\Frontend;

class Ajax extends Frontend
{
    protected array $noNeedLogin = ['area', 'buildSuffixSvg', 'getMerchantQrcode'];

    protected array $noNeedPermission = ['upload'];

    public function initialize(): void
    {
        parent::initialize();
    }

    // 获取收款码信息
    public function getMerchantQrcode()
    {
        $uuid = $this->request->param('uuid');
        if (!$uuid) {
            $this->error('参数错误');
        }

        // 检查访问频率
        $ip = $this->request->ip();
        $userAgent = $this->request->header('user-agent');
        $key = 'qrcode_visit_' . md5($ip . $userAgent);
        
        // 检查是否在封禁期
        $banKey = 'qrcode_ban_' . md5($ip . $userAgent);
        if (Cache::get($banKey)) {
            $this->error('访问过于频繁，请稍后再试');
        }
        
        // 获取访问次数
        $visits = Cache::get($key, 0);
        if ($visits >= 10) {
            // 设置10分钟封禁
            Cache::set($banKey, 1, 600);
            $this->error('访问过于频繁，请稍后再试');
        }
        
        // 增加访问次数，设置1分钟过期
        Cache::set($key, $visits + 1, 60);

        $model = new \app\common\model\Qrcode();
        $merchant = $model->where('uuid', $uuid)
            ->field([
                'id',
                'name',
                'uuid',
                'channel',
                'min_amount',
                'max_amount',
                'fixed_amount',
                'expired_time'
            ])
            ->find();

        if (!$merchant) {
            $this->error('收款码不存在');
        }
        //是否限制浏览器
        $merchant['Browser'] = true;
        // 网站名称
        $merchant['website_name'] = get_sys_config('site_name');
        
        //访问一次增加一次访问记录
        $logModel = new \app\common\model\Qrcodelog();
        $logModel->save([
            'qrcode_id' => $merchant['id'],
            'ip' => $ip,
            'user_agent' => $userAgent,
            'device' => $this->getDeviceType(),
            'create_time' => time()
        ]);

        $this->success('获取成功', $merchant);
    }

    /**
     * 获取设备类型
     */
    protected function getDeviceType(): string
    {
        $userAgent = strtolower($this->request->header('user-agent'));
        
        if (strpos($userAgent, 'mobile') !== false 
            || strpos($userAgent, 'android') !== false 
            || strpos($userAgent, 'iphone') !== false
            || strpos($userAgent, 'ipad') !== false) {
            return 'mobile';
        }
        
        return 'pc';
    }

    public function upload(): void
    {
        $file   = $this->request->file('file');
        $driver = $this->request->param('driver', 'local');
        $topic  = $this->request->param('topic', 'default');
        try {
            $upload     = new Upload();
            $attachment = $upload
                ->setFile($file)
                ->setDriver($driver)
                ->setTopic($topic)
                ->upload(null, 0, $this->auth->id);
            unset($attachment['create_time'], $attachment['quote']);
        } catch (Throwable $e) {
            $this->error($e->getMessage());
        }

        $this->success(__('File uploaded successfully'), [
            'file' => $attachment ?? []
        ]);
    }

    /**
     * 省份地区数据
     * @throws Throwable
     */
    public function area(): void
    {
        $this->success('', get_area());
    }

    public function buildSuffixSvg(): Response
    {
        $suffix     = $this->request->param('suffix', 'file');
        $background = $this->request->param('background');
        $content    = build_suffix_svg((string)$suffix, (string)$background);
        return response($content, 200, ['Content-Length' => strlen($content)])->contentType('image/svg+xml');
    }
}