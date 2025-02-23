<?php
/**
 * 本代码由 重庆浪寒云科技有限公司 开发
 * 官网 www.yisufu.cn
 * Date: 2025/2/17
 * author: langlang
 * Email: <yisufu@126.com>
 **/

namespace plugins\Yisufu;


use Exception;
use plugins\Yisufu\inc\YsfpayClient;
use think\facade\Db;

class Yisufu
{
    static public array $info = [
        'name'        => 'Yisufu', //支付插件英文名称，需和目录名称一致，不能有重复
        'showname'    => '易速付', //支付插件显示名称
        'author'      => '浪寒云', //支付插件作者
        'link'        => 'https://open.yisufu.cn', //支付插件作者链接
        'types'       => ['alipay','wxpay'],
        'inputs' => [
            'appid' => [
                'name' => '用户编号',
                'type' => 'input',
                'note' => '',
            ],
            'appkey' => [
                'name' => '应用私钥',
                'type' => 'textarea',
                'note' => '',
            ],
            'appsecret' => [
                'name' => '平台公钥',
                'type' => 'textarea',
                'note' => '',
            ],
            'appmchid' => [
                'name' => '子商户号',
                'type' => 'input',
                'note' => '指定子商户号交易，留空默认轮训',
            ],
            'appswitch' => [
                'name' => '环境选择',
                'type' => 'select',
                'options' => [0=>'生产环境',1=>'测试环境'],
            ],
            'select_wxpay' => [
                'name' => '微信支付方式',
                'type' => 'select',
                'options' => [  0=>'不开启', 1=>'扫码支付',2=>'小程序支付',3=>'公众号支付'],
            ],
            'select_alipay' => [
                'name' => '支付宝支付方式',
                'type' => 'select',
                'options' => [  0=>'不开启', 1=>'扫码支付',2=>'小程序支付'],
            ],
        ],
    ];

    /**
     * 支付方法
     */
    public function pay($params){
        $channel_id = $params['channel_id'] ?? 0;
        $channel_type = $params['channel_type'] ?? '';
        $amount = $params['amount'] ?? 0;
        $order_no = $params['order_no'] ?? '';
        $config = $params['config'] ?? [];

        if ($channel_type == 'wxpay'){
            if ($config['select_wxpay'] == 1 ){
                $type = 'WECHAT_NATIVE';
            }else if ($config['select_wxpay'] == 2){
                $type = 'WECHAT_H5';
            }else{
                $type = 'WECHAT_MP';
            }
        }elseif ($channel_type == 'alipay'){
            if ($config['select_alipay'] == 1 ){
                $type = 'ALIPAY';
            }else{
                $type = 'ALIPAY_H5';
            }
        }elseif ($channel_type == 'bank'){
            $type = 'CASHIER';
        }

        //查询订单
        $order = \app\common\model\Order::where('order_no', $order_no)->find();

        $client = new YsfpayClient($config['appid'], $config['appkey'], $config['appsecret'], $config['appswitch'] == 1);

        if (empty($config['appmchid'])) {
            $param = [
                'sub_type' => 'SYSTEM',
                'channel_type' => $type,
                'total_fee' => $amount,
                'pay_name' => $order['subject'],
                'pay_body' => $order['body'],
                'notify_url' =>  $order['notify_url'],
                'out_trade_no' => $order_no,
                'user_ip' => request()->ip(),
                'server_url' => request()->domain()
            ];
        } else {
            $param = [
                'sub_mch_id' => $config['appmchid'],
                'channel_type' => $type,
                'total_fee' => $amount,
                'pay_name' => $order['subject'],
                'pay_body' => $order['body'],
                'notify_url' =>  $order['notify_url'],
                'out_trade_no' => $order_no,
                'user_ip' => request()->ip(),
                'server_url' => request()->domain()
            ];
        }

        ksort($param);

        try {
            $result = $client->execute( 'gateway.unified.pay', $param );
        } catch (Exception $e) {
            return [
                'code' => 1,
                'msg' => $e->getMessage(),
            ];
        }
        $api_trade_no = $result['request_array']['system_order_id'];
        return [
            'code' => 200,
            'trade_no' => $api_trade_no,
            'pay_url' => $result['request_array']['pay_url'],
            'pay_data' => $result['request_array'],
        ];
    }

    /**
     * 通知
     */
    public function notify($params, $channel){

        $client = new YsfpayClient($channel['appid'],$channel['appkey'], $channel['appsecret'],$channel['appswitch'] == 1);

        $param = [
            'open_userid' => $channel['appid'],
            'out_trade_no' => $params['out_trade_no'],
            'system_order_id' => $params['system_order_id'],
            'pay_external_id' => $params['pay_external_id'],
            'total_fee' => $params['total_fee'],
        ];

        // 对参数进行排序
        ksort($param);

        // 验证签名
        $verify_result = $client->verifySign($param, $params['sign']);

        if($verify_result && $params['sign'] !=''){
            $out_trade_no = $params['out_trade_no'];
            $trade_no = $params['system_order_id'];
            if ($out_trade_no == $params['por']) {
                //processNotify($order, $trade_no);
                // 更新订单状态
                Db::name('order')->where('trade_no', $trade_no)->update([
                    'status' => 1,
                    'pay_time' => time(),
                    'notify_count' => 1,
                    'notify_time' => time(),
                    'pay_amount' => $params['total_fee']
                ]);
                return 'success';
            } else {
                // 订单信息校验失败
                return 'order fail';
            }
        } else {
            return 'sign fail';

        }
    }



}