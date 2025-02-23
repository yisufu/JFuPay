<?php

namespace plugins\Yisufu\inc;
use Exception;

/**
 * @see https://open.yisufu.cn
 */
class YsfpayClient
{
    //接口地址
    private $gateway_url = 'https://openapi.yisufu.cn';
    
    //private $gateway_url =  'https://workerman.yisufu.cn/api/network/unified';

    //商户编号
    private $open_userid;

	//应用APPID
    //private $app_id;
    
    //应用私钥
    private $merchant_private_key;

    //平台公钥
    private $platform_public_key;

    private $sign_type = 'RSA2';

    public function __construct($open_userid, $merchant_private_key, $platform_public_key, $isTest = false)
    {
        $this->open_userid = $open_userid;
        $this->merchant_private_key = $merchant_private_key;
        $this->platform_public_key = $platform_public_key;
        if($isTest) $this->gateway_url = 'https://test-api.yisufu.cn/api/network/unified';
    }

    //请求API接口并解析返回数据
    public function execute($service,$res_body)
    {
        $requrl = $this->gateway_url;
        
        $params = [
            'open_userid' => $this->open_userid,
			'res_body' => $res_body, // 保持原始数组格式
            'service' => $service,
            'sign_type' => $this->sign_type,
            'version' => '2.0',
            
        ];
		// res_body 删除空值
        foreach ($params['res_body'] as $k => $v){
            if($v == '') unset($params['res_body'][$k]);
        }
		// // res_body 格式化json
        ksort($params['res_body']);
        $params['res_body'] = json_encode($params['res_body'], JSON_UNESCAPED_UNICODE|JSON_UNESCAPED_SLASHES);
        $params['sign'] = $this->generateSign($params);
        $response = get_curl($requrl, http_build_query($params));
        $result = json_decode($response, true);
        //var_dump($response);
		if(isset($result['rsp_code']) && $result['rsp_code']==0000){
			return $result;
		}elseif(isset($result['rsp_msg'])){
		    throw new Exception($result['rsp_msg']);
		}else{
			throw new Exception('未知错误,请联系客服');
		}
    }


    //请求参数签名
	private function generateSign($param)
	{
		// param 排序
        ksort($param);
		$sign_true = $this->rsaPrivateSign($param);
        return $sign_true;
	}


	//应用私钥签名
	private function rsaPrivateSign($data)
	{
		$priKey = $this->merchant_private_key;
		$json = json_encode($data,JSON_UNESCAPED_UNICODE|JSON_UNESCAPED_SLASHES);
        $res = "-----BEGIN RSA PRIVATE KEY-----\n" .
            wordwrap($priKey, 64, "\n", true) .
            "\n-----END RSA PRIVATE KEY-----";
		$pkeyid = openssl_pkey_get_private($res);
		if(!$pkeyid){
			throw new Exception('签名失败，应用私钥不正确');
		}
		openssl_sign($json, $signature, $pkeyid, OPENSSL_ALGO_SHA256);
		$signature = base64_encode($signature);
		return $signature;
	}

    //验签方法
	public function verifySign($param,$sign)
	{
	   // param 排序
        ksort($param);
	    $sign_true = $this->rsaPubilcSign($param,$sign);
	    return $sign_true ? true : false;
	}

	//平台公钥验签
	private function rsaPubilcSign($data, $signature)
	{
	    ksort($data);
	    $pubKey = $this->platform_public_key;
        $res = "-----BEGIN PUBLIC KEY-----\n" .
            wordwrap($pubKey, 64, "\n", true) .
            "\n-----END PUBLIC KEY-----";
		$pubkeyid = openssl_pkey_get_public($res);
		if(!$pubkeyid){
			throw new Exception('验签失败，平台公钥不正确');
		}
         //调用openssl内置方法验签，返回bool值
        return (@openssl_verify(json_encode($data), base64_decode($signature), $pubkeyid, OPENSSL_ALGO_SHA256) === 1);
    }

}
