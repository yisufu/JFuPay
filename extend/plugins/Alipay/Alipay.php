<?php
namespace plugins\Alipay;

use Exception;

class Alipay
{
	static public array $info = [
		'name'        => 'Alipay', //支付插件英文名称，需和目录名称一致，不能有重复
		'showname'    => '支付宝官方支付', //支付插件显示名称
		'author'      => '支付宝', //支付插件作者
		'link'        => 'https://b.alipay.com/signing/productSetV2.htm', //支付插件作者链接
		'types'       => ['alipay'], //支付插件支持的支付方式，可选的有alipay,qqpay,wxpay,bank
		'inputs' => [ //支付插件要求传入的参数以及参数显示名称，可选的有appid,appkey,appsecret,appurl,appmchid
			'appid' => [
				'name' => '应用APPID',
				'type' => 'input',
				'note' => '',
			],
			'appkey' => [
				'name' => '支付宝公钥',
				'type' => 'textarea',
				'note' => '填错也可以支付成功但会无法回调，如果用公钥证书模式此处留空',
			],
			'appsecret' => [
				'name' => '应用私钥',
				'type' => 'textarea',
				'note' => '',
			],
			'appmchid' => [
				'name' => '卖家支付宝用户ID',
				'type' => 'input',
				'note' => '可留空，默认为商户签约账号',
			],
             //选择支付方式
            'paymode' => [
                'name' => '支付方式',
                'type' => 'select',
                'note' => '',
                'options' => [
                    '1' => '电脑网站支付',
                    '2' => '手机网站支付',
                    '3' => '当面付扫码',
                    '4' => '订单码支付',
                ]
            ]

		],
	];

    private function alipay_config($channel)
    {
        $alipay_config = [
            //应用ID
            'app_id' => $channel['appid'],

            //支付宝公钥
            'alipay_public_key' => $channel['appkey'],

            //应用私钥
            'app_private_key' => $channel['appsecret'],

            //签名方式,默认为RSA2
            'sign_type' => "RSA2",

            //编码格式
            'charset' => "UTF-8",

            //支付宝网关
            'gateway_url' => "https://openapi.alipay.com/gateway.do",

            //日志记录位置
            'log_path' => dirname(__FILE__).'/log/',
        ];
        return $alipay_config;

    }

	public function pay($params){

        $channel_id = $params['channel_id'] ?? 0;
        $channel_type = $params['channel_type'] ?? '';
        $amount = $params['amount'] ?? 0;
        $order_no = $params['order_no'] ?? '';
        $config = $params['config'] ?? [];
        if (empty($config['paymode'])){
            return [
                'code' => 1,
                'msg' => '请选择支付方式',
            ];
        }
        $paymode= $config['paymode'];
		if($paymode=='1'){
			return $this->qrcodepc($params);
		} elseif($paymode=='2'){
            return $this->submitwap($params);
		}elseif($paymode=='3'){
            return $this->qrcode($params);
		}else{
            return $this->qrcode($params);
        }
	}

	//电脑网站支付扫码
	public function qrcodepc($params): array
    {
        $channel_id = $params['channel_id'] ?? 0;
        $channel_type = $params['channel_type'] ?? '';
        $amount = $params['amount'] ?? 0;
        $order_no = $params['order_no'] ?? '';
        $config = $params['config'] ?? [];

        //查询订单
        $order = \app\common\model\Order::where('order_no', $order_no)->find();

		if(checkmobile()){
            $alipay_config = $this->alipay_config($config);
			$alipay_config['notify_url'] =  $order['notify_url'];
			$alipay_config['pageMethod'] = '2';
			$bizContent = [
				'out_trade_no' => $order_no,
				'total_amount' => $amount,
				'subject' =>  $order['subject'],
				'qr_pay_mode' => '4'
			];
			if(!empty($config['appmchid'])){
				$bizContent['seller_id'] = $config['appmchid'];
			}
			$bizContent['business_params'] = ['mc_create_trade_ip' => request()->ip()];
			try{
				$aop = new \Alipay\AlipayTradeService($alipay_config);
				$url = $aop->pagePay($bizContent);
				$html = get_curl($url, 0, 0, 0, 0, 0, 0, 0, 1);
				$html = mb_convert_encoding($html, 'utf-8', 'gbk');
			}catch(Exception $e){
				return ['code'=>1,'msg'=>'支付宝下单失败！'.$e->getMessage()];
			}

			if(preg_match('!<input name="qrCode" type="hidden" value="(.*?)"!i', $html, $match)){
				$code_url = $match[1];
                return [
                    'code' => 200,
                    'trade_no' => '',
                    'pay_url' => $code_url,
                    'pay_data' => '',
                ];
			}else{
				return ['code'=>1,'msg'=>'支付宝下单失败！获取二维码失败'];
			}
	
		}else{
            return ['code'=>1,'msg'=>'支付宝下单失败！收款码暂不支持使用原生电脑支付'];
		}
	}


	//手机网站支付扫码跳转
    public function submitwap($params){
        return ['code'=>1,'msg'=>'支付宝下单失败！收款码暂不支持使用原生手机网站'];

	}

	//扫码支付
	public function qrcode($params){
        $channel_id = $params['channel_id'] ?? 0;
        $channel_type = $params['channel_type'] ?? '';
        $amount = $params['amount'] ?? 0;
        $order_no = $params['order_no'] ?? '';
        $config = $params['config'] ?? [];

        //查询订单
        $order = \app\common\model\Order::where('order_no', $order_no)->find();

		$alipay_config = $this->alipay_config($config);
        $alipay_config['notify_url'] =  $order['notify_url'];
		$bizContent = [
            'out_trade_no' => $order_no,
            'total_amount' => $amount,
            'subject' =>  $order['subject'],
		];
		if(!empty($channel['appmchid'])){
			$bizContent['seller_id'] = $channel['appmchid'];
		}
		if(!in_array('3',$config['paymode']) && in_array('8',$config['paymode'])){
			$bizContent['product_code'] = 'QR_CODE_OFFLINE';
		}
		$bizContent['business_params'] = ['mc_create_trade_ip' =>  request()->ip()];
		try{
			$aop = new \Alipay\AlipayTradeService($alipay_config);
			$result = $aop->qrPay($bizContent);
		}catch(Exception $e){
            return ['code'=>1,'msg'=>'支付宝下单失败！'.$e->getMessage()];
		}
		$code_url = $result['qr_code'];

        return [
            'code' => 200,
            'trade_no' => '',
            'pay_url' => $code_url,
            'pay_data' => $result,
        ];
	}




	//异步回调
	public function notify(){
		global $channel, $order;

        $alipay_config = $this->alipay_config($channel);
		$aop = new \Alipay\AlipayTradeService($alipay_config);

		$verify_result = $aop->check($_POST);

		if($verify_result) {//验证成功
			//商户订单号
			$out_trade_no = $_POST['out_trade_no'];

			//支付宝交易号
			$trade_no = $_POST['trade_no'];

			//买家支付宝
			$buyer_id = $_POST['buyer_id'];
			if(empty($buyer_id))$buyer_id = $_POST['buyer_open_id'];

			//交易金额
			$total_amount = $_POST['total_amount'];

			if($_POST['trade_status'] == 'TRADE_FINISHED') {
				//退款日期超过可退款期限后（如三个月可退款），支付宝系统发送该交易状态通知
			}
			else if ($_POST['trade_status'] == 'TRADE_SUCCESS') {
				if($out_trade_no == TRADE_NO && round($total_amount,2)==round($order['realmoney'],2)){
					processNotify($order, $trade_no, $buyer_id);
				}
			}
			return ['type'=>'html','data'=>'success'];
		}
		else {
			//验证失败
			return ['type'=>'html','data'=>'fail'];
		}
	}
}