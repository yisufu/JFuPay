<?php

namespace app\api\controller;

use app\common\controller\Frontend;
use app\common\model\Channel;
use app\common\model\Qrcode;
use Exception;
use think\facade\Db;

class Pay extends Frontend
{
    protected array $noNeedLogin = ['createPay', 'notify'];

    /**
     * 检测浏览器类型
     */
    protected function getBrowserType(): string
    {
        $userAgent = strtolower($this->request->header('user-agent'));
        
        if (str_contains( $userAgent, 'micromessenger' )) {
            return 'wxpay';
        } elseif (str_contains( $userAgent, 'alipay' )) {
            return 'alipay';
        }
        
        return 'bank';
    }

    /**
     * 创建支付订单
     */
    public function createPay()
    {
        // 获取参数
        $uuid = $this->request->param('uuid');
        $amount = $this->request->param('amount/f');
        $remark = $this->request->param('remark');
        
        if (!$uuid || !$amount) {
            $this->error('参数错误');
        }

        // 获取收款码信息
        $qrcode = Qrcode::where('uuid', $uuid)
            ->where('status', 1)
            ->find();
            
        if (!$qrcode) {
            $this->error('收款码不存在或已禁用');
        }

        // 获取 headers Pay-Type-H5 信息
        $channelTypeH5 = $this->request->header('Pay-Type-H5');
        if (!$channelTypeH5) {
            $this->error('收款码参数错误');
        }
        if ($channelTypeH5 != $qrcode->uuid){
            $this->error('收款码不匹配');
        }

        // 验证金额
        if ($qrcode->fixed_amount > 0 && $amount != $qrcode->fixed_amount) {
            $this->error('固定金额收款码，支付金额必须为：' . $qrcode->fixed_amount);
        }
        
        if ($qrcode->min_amount > 0 && $amount < $qrcode->min_amount) {
            $this->error('支付金额不能小于：' . $qrcode->min_amount);
        }
        
        if ($qrcode->max_amount > 0 && $amount > $qrcode->max_amount) {
            $this->error('支付金额不能大于：' . $qrcode->max_amount);
        }

        // 检查收款码是否过期
        if (!empty($qrcode->expired_time) && $qrcode->expired_time < time()) {
            $this->error('收款码已过期');
        }

        // 开启事务
        Db::startTrans();
        try {
            // 生成订单号
            $orderNo = $this->generateOrderNo();
            $ip = $this->request->ip();
            $userAgent = $this->request->header('user-agent');
            
            // 根据浏览器环境决定支付方式
            $channel_type = $this->getBrowserType();
            if ($channel_type == 'bank'){
                throw new \Exception('暂不支持该浏览器支付,请使用微信或支付宝扫码支付');
            }
            
            // 获取收款码中的渠道ID列表
            $channelIds = $qrcode->channel;
            if (empty($channelIds)) {
                throw new \Exception('收款码未配置支付通道');
            }
            
            // 获取可用的支付通道，按优先级降序排序
            $channels = Channel::whereIn('id', $channelIds)
                ->where('status', 1)
                ->order('priority desc, id asc')
                ->select();
                
            if ($channels->isEmpty()) {
                throw new \Exception('没有可用的支付通道');
            }
            
            // 获取当前收款码最近使用的通道ID
            $lastChannelId = Db::name('order')
                ->where('qrcode_id', $qrcode->id)
                ->order('id desc')
                ->value('channel_id');
            
            // 选择通道：如果有最近使用的通道，则选择优先级次高的通道；否则使用优先级最高的通道
            $selectedChannel = null;
            if ($lastChannelId) {
                $found = false;
                foreach ($channels as $channel) {
                    if ($found) {
                        $selectedChannel = $channel;
                        break;
                    }
                    if ($channel['id'] == $lastChannelId) {
                        $found = true;
                    }
                }
                // 如果没有找到下一个通道（说明上次使用的是优先级最低的），则使用优先级最高的
                if (!$selectedChannel) {
                    $selectedChannel = $channels[0];
                }
            } else {
                // 没有使用记录，使用优先级最高的通道
                $selectedChannel = $channels[0];
            }

            //检查备注是否为空
            if (empty($remark)) {
                $remark = $qrcode->name.'_收款码收款_订单号:' . $orderNo;
            }
            
            // 创建订单
            $order = [
                'order_no' => $orderNo,
                'merchant_order_no' => $this->generateOrderNo(),
                'qrcode_id' => $qrcode->id,
                'merchant_id' => $qrcode->merchant_id,
                'channel_type' => $channel_type,
                'channel_id' => $selectedChannel['id'],
                'amount' => $amount,
                'ip' => $ip,
                'user_agent' => $userAgent,
                'device' => $this->getDeviceType(),
                'subject' => $remark,
                'body' => $remark,
                'notify_url' => request()->domain().'/index.php/api/pay/notify/por/'.$orderNo.'/',
                'status' => 0,
                'source' => 1,
                'create_time' => time(),
                'update_time' => time(),
            ];
            
            // 插入订单记录
            Db::name('order')->insert($order);
            
            try {
                // 获取插件实例
                $className = "\\plugins\\" . $selectedChannel['plugin']['class_name'] . "\\" . $selectedChannel['plugin']['class_name'];
                if (!class_exists($className)) {
                    throw new \Exception('支付插件不存在');
                }
                
                $plugin = new $className();
                
                // 调用支付接口
                $result = $plugin->pay([
                    'channel_id' => $selectedChannel['id'],
                    'channel_type' => $channel_type,
                    'amount' => $amount,
                    'order_no' => $orderNo,
                    'config' => json_decode($selectedChannel['config'], true)
                ]);

                if (isset($result['code'])){
                    if ($result['code'] != 200){
                        throw new \Exception($result['msg']);
                    }

                } else {
                    throw new \Exception('支付插件内部错误');
                }
                
                if (empty($result['pay_url'])) {
                    throw new \Exception('获取支付链接失败');
                }
                
                // 更新交易号
                Db::name('order')->where('order_no', $orderNo)->update([
                    'trade_no' => $result['trade_no'] ?? '',
                   // 'pay_url' => $result['pay_url']
                ]);
                
                Db::commit();
            } catch (Exception $e) {
                throw new \Exception($e->getMessage() ?: '支付通道暂时不可用');
            }
            //$this->success('创建成功', $result);
        } catch (\Exception $e) {
            Db::rollback();
            $this->error($e->getMessage());
        }
        $this->success('创建成功', $result);
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

    /**
     * 生成订单号
     */
    protected function generateOrderNo(): string
    {
        return date('YmdHis') . mt_rand(1000, 9999);
    }

    /**
     * 支付通知
     */
    public function notify()
    {
        // 检查是否存在订单参数
        if (empty($this->request->param('por'))) {
            $this->error('缺少必要的参数');
        }
        // 查询订单是否存在
        $order = Db::name('order')
            ->where('order_no', $this->request->param('por'))
            ->find();
        if (!$order) {
            $this->error('订单不存在');
        }

        $channel = $order['channel_id'];
        
        // 获取通道信息
        $channelModel = Channel::where('id', $channel)->find();
        if (!$channelModel) {
            $this->error('通道不存在');
        }
        
        try {
            // 获取插件实例
            $className = "\\plugins\\" . $channelModel['plugin']['class_name'] . "\\" . $channelModel['plugin']['class_name'];
            if (!class_exists($className)) {
                throw new \Exception('支付插件不存在');
            }
            
            $plugin = new $className();
            
            // 验证通知
            $params = $plugin->notify($this->request->param(), json_decode($channelModel['config'], true));
            if (!$params) {
                throw new \Exception('通知验证失败');
            }
            
            if ($order['status'] != 0) {
                return 'success';
            }
            
            // 通知商户
            // if ($order['notify_url']) {
            //     $this->sendNotify($order);
            // }
            
            return 'success';
            
        } catch (\Exception $e) {
            \think\facade\Log::error('支付通知处理失败：' . $e->getMessage());
            return 'fail' . $e->getMessage();
        }
    }

    /**
     * 发送通知
     */
    protected function sendNotify($order)
    {
        $data = [
            'order_no' => $order['order_no'],
            'merchant_order_no' => $order['merchant_order_no'],
            'amount' => $order['amount'],
            'pay_amount' => $order['pay_amount'],
            'status' => $order['status'],
            'pay_time' => $order['pay_time'],
            'trade_no' => $order['trade_no'],
            'timestamp' => time()
        ];
        
        try {
            $client = new \GuzzleHttp\Client();
            $response = $client->post($order['notify_url'], [
                'form_params' => $data,
                'timeout' => 5
            ]);
            
            if ($response->getStatusCode() == 200 && $response->getBody() == 'success') {
                Db::name('order')->where('id', $order['id'])->update([
                    'notify_status' => 1
                ]);
            }
        } catch (\Exception $e) {
            \think\facade\Log::error('发送通知失败：' . $e->getMessage());
        }
    }
} 