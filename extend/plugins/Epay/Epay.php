<?php
namespace plugins\Epay;

use think\facade\Log;
use plugins\Epay\inc\EpayCore;
use Exception;
use think\facade\Db;

class Epay
{
	static public array $info = [
		'name'        => 'Epay', //支付插件英文名称，需和目录名称一致，不能有重复
		'showname'    => '彩虹易支付', //支付插件显示名称
		'author'      => '彩虹', //支付插件作者
		'link'        => '', //支付插件作者链接
		'types'       => ['alipay','qqpay','wxpay','bank','jdpay'], //支付插件支持的支付方式，可选的有alipay,qqpay,wxpay,bank
		'inputs' => [ //支付插件要求传入的参数以及参数显示名称，可选的有appid,appkey,appsecret,appurl,appmchid
			'appurl' => [
				'name' => '接口地址',
				'type' => 'input',
				'note' => '必须以http://或https://开头，以/结尾',
			],
			'appid' => [
				'name' => '商户ID',
				'type' => 'input',
				'note' => '',
			],
			'appkey' => [
				'name' => '商户密钥',
				'type' => 'input',
				'note' => '',
			],
		],
	];

	//mapi接口下单
    public function pay($params): array
    {
        $channel_type = $params['channel_type'] ?? '';
        $amount = $params['amount'] ?? 0;
        $order_no = $params['order_no'] ?? '';
        $config = $params['config'] ?? [];
        //查询订单
        $order = \app\common\model\Order::where('order_no', $order_no)->find();
        if (!$order){
            return ['code' => 1, 'msg' => '订单不存在'];
        }
        //支付API地址
        $epay_config['apiurl'] = $config['appurl'];
        //商户ID
        $epay_config['pid'] = $config['appid'];
        //商户KEY
        $epay_config['key'] = $config['appkey'];
		$parameter = array(
			"pid" => trim($epay_config['pid']),
			"type" => $channel_type,
			"device" => 'mobile',
			"clientip" => request()->ip(),
			"notify_url"	=> $order['notify_url'],
            "return_url"	=> $order['notify_url'],
			"out_trade_no"	=> $order_no,
			"name"	=> $order['subject'],
			"money"	=> $amount
		);
		//建立请求
		$epay = new EpayCore($epay_config);

        $result = $epay->apiPay($parameter);
        if(!$result){
            return ['code' => 1, 'msg' => '获取支付接口数据失败'];
        }
        //打印出来信息
        Log::record('支付接口返回数据：' . print_r($result, true), 'info');  // 记录到日志文件中


        if(isset($result['code']) && $result['code']==1){
            if(isset($result['payurl'])){
                $url = $result['payurl'];
            }elseif(isset($result['qrcode'])){
                $url = $result['qrcode'];
            }elseif(isset($result['urlscheme'])){
                $url = $result['urlscheme'];
            }else{
                return ['code' => 1, 'msg' => '未返回支付链接'];
            }
        }elseif(isset($result['msg'])){
            return ['code' => 1, 'msg' => $result['msg']];
        }else{
            return ['code' => 1, 'msg' => '获取支付接口数据失败'];
        }
        return [
            'code' => 200,
            'trade_no' => $result['trade_no'],
            'pay_url' => $url,
            'pay_data' => $result,
        ];
	}



	//异步回调
	public function notify($params, $channel){

        //支付API地址
        $epay_config['apiurl'] = $channel['appurl'];
        //商户ID
        $epay_config['pid'] = $channel['appid'];
        //商户KEY
        $epay_config['key'] = $channel['appkey'];

		//计算得出通知验证结果
		$epayNotify = new EpayCore($epay_config);
		$verify_result = $epayNotify->verifyNotify();

		if($verify_result) {//验证成功
			//商户订单号
			$out_trade_no = $params['out_trade_no'];

			//易支付交易号
			$trade_no = $params['trade_no'];

			//交易金额
			$money = $params['money'];

			if ($params['trade_status'] == 'TRADE_SUCCESS') {
                // 更新订单状态
                Db::name('order')->where('trade_no', $trade_no)->update([
                    'status' => 1,
                    'notify_count' => 1,
                    'pay_time' => time(),
                    'notify_time' => time(),
                    'pay_amount' => $money
                ]);
                return 'success';
			}
            return 'success';
		}
		else {
			//验证失败
            return 'sign fail';
		}
	}


}