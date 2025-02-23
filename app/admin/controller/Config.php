<?php

namespace app\admin\controller;

use app\common\controller\Backend;

/**
 * 系统配置
 */
class Config extends Backend
{
    protected $noNeedLogin = [];
    protected $noNeedRight = [];

    /**
     * 获取系统配置
     */
    public function getSystemConfig()
    {
        $config = [
            'basic' => [
                'name' => '基础配置',
                'items' => [
                    [
                        'name' => 'site_name',
                        'title' => '网站名称',
                        'type' => 'string',
                        'value' => '',
                    ],
                    [
                        'name' => 'system_public_key',
                        'title' => '系统RSA2公钥',
                        'type' => 'textarea',
                        'value' => '',
                        'note' => '用于与商户通信的RSA2公钥',
                    ],
                    [
                        'name' => 'system_private_key',
                        'title' => '系统RSA2私钥',
                        'type' => 'textarea',
                        'value' => '',
                        'note' => '用于与商户通信的RSA2私钥',
                    ],
                ]
            ],
        ];
        
        $this->success('获取成功', ['config' => $config]);
    }

    /**
     * 保存系统配置
     */
    public function saveSystemConfig()
    {
        $params = $this->request->post();
        if (!$params) {
            $this->error('参数错误');
        }

        // 验证RSA2密钥对
        if (!empty($params['system_private_key']) && !empty($params['system_public_key'])) {
            try {
                $privateKey = "-----BEGIN RSA PRIVATE KEY-----\n" . 
                    wordwrap($params['system_private_key'], 64, "\n", true) . 
                    "\n-----END RSA PRIVATE KEY-----";
                
                $publicKey = "-----BEGIN PUBLIC KEY-----\n" . 
                    wordwrap($params['system_public_key'], 64, "\n", true) . 
                    "\n-----END PUBLIC KEY-----";
                
                // 测试签名和验证
                $testData = 'test';
                $privateKeyResource = openssl_get_privatekey($privateKey);
                openssl_sign($testData, $signature, $privateKeyResource, OPENSSL_ALGO_SHA256);
                openssl_free_key($privateKeyResource);
                
                $publicKeyResource = openssl_get_publickey($publicKey);
                $verify = openssl_verify($testData, $signature, $publicKeyResource, OPENSSL_ALGO_SHA256);
                openssl_free_key($publicKeyResource);
                
                if ($verify !== 1) {
                    $this->error('RSA2密钥对不匹配');
                }
            } catch (\Exception $e) {
                $this->error('RSA2密钥格式错误: ' . $e->getMessage());
            }
        }

        // 保存配置
        foreach ($params as $key => $value) {
            \think\facade\Config::set($key, $value, 'system');
        }
        
        $this->success('保存成功');
    }
} 