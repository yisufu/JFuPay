import createAxios from '/@/utils/axios'

/**
 * 获取插件配置信息
 * @param id 插件ID
 */
export function getPluginConfig(id: number) {
    return createAxios({
        url: '/admin/Plugins/getConfig',
        method: 'post',
        data: { id },
    })
}

// 获取商户收款码信息
export function getMerchantQrcode(uuid: string) {
    return createAxios({
        url: '/api/ajax/getMerchantQrcode',
        method: 'get',
        params: { uuid },
    })
}

// 发起支付
export function createPay(data: any) {
    return createAxios({
        url: '/api/Pay/createPay',
        method: 'post',
        data,
        headers: {
            'Pay-Type-H5': data.uuid,
        },
    })
}
