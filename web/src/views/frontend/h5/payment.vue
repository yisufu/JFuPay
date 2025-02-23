<template>
    <div class="wrap">
        <!-- 错误提示 -->
        <div class="error-notice" v-if="showError">
            <div class="error-content">
                <i class="el-icon-warning"></i>
                <p class="error-title">{{ errorTitle }}</p>
                <p class="error-desc">{{ errorDesc }}</p>
            </div>
        </div>

        <template v-else>
            <div class="box-pay">
                <!-- 商户信息 -->
                <div class="title">
                    <div class="merchant-avatar">
                        <img src="/@/assets/ic_shop_blue.png" alt="商户" />
                    </div>
                    <div class="label">付款给</div>
                    <div class="shopname">{{ merchantName }}</div>
                </div>

                <!-- 金额输入区域 -->
                <div class="input">
                    <div class="label">付款金额</div>
                    <div class="money">
                        <span class="money_icon">¥</span>
                        <input id="money_num" type="text" v-model="amount" readonly placeholder="0.00" />
                    </div>

                    <!-- 金额错误提示 -->
                    <div class="amount-error" v-if="amountError">
                        <i class="el-icon-warning-outline"></i>
                        <span>{{ amountError }}</span>
                    </div>

                    <!-- 金额限制提示 -->
                    <div class="amount-limit" v-if="showAmountLimit">
                        <template v-if="fixedAmount > 0">
                            固定支付金额: ¥{{ fixedAmount }}
                        </template>
                    </div>

                    <!-- 备注区域 -->
                    <div class="remark" v-if="!remark" @click="remarkEdit">
                        <span>添加备注</span>
                    </div>
                    <div class="remark" v-else>
                        <span>备注：</span>
                        <span>{{ remark }}</span>
                        <span class="btn-edit-remark" @click="remarkEdit">修改</span>
                    </div>
                </div>
            </div>

            <!-- 数字键盘 -->
            <div class="table_font">
                <div class="brand">{{ websiteName }} 提供技术支持</div>
                <table cellspacing="5" cellpadding="0" border="0">
                    <tr>
                        <td class="click_num" @click="inputNumber('1')">1</td>
                        <td class="click_num" @click="inputNumber('2')">2</td>
                        <td class="click_num" @click="inputNumber('3')">3</td>
                        <td class="deleateNum" @click="deleteNumber">
                            <img src="/@/assets/ic_backspace.png" alt="删除" class="delete-icon" />
                        </td>
                    </tr>
                    <tr>
                        <td class="click_num" @click="inputNumber('4')">4</td>
                        <td class="click_num" @click="inputNumber('5')">5</td>
                        <td class="click_num" @click="inputNumber('6')">6</td>
                        <td rowspan="3" class="sure_button" @click="handlePay" :class="{ disabled: !canSubmit }">付款</td>
                    </tr>
                    <tr>
                        <td class="click_num" @click="inputNumber('7')">7</td>
                        <td class="click_num" @click="inputNumber('8')">8</td>
                        <td class="click_num" @click="inputNumber('9')">9</td>
                    </tr>
                    <tr>
                        <td colspan="2" class="click_num" @click="inputNumber('0')">0</td>
                        <td class="click_num" @click="inputNumber('.')">.</td>
                    </tr>
                </table>
            </div>

            <!-- 备注弹窗 -->
            <div v-if="showRemarkDialog" class="dialog-mask" @touchmove.prevent>
                <div class="dialog-remark">
                    <div class="dialog-header">
                        <span>添加备注</span>
                        <i class="close-icon el-icon-close" @click="remarkCancel"></i>
                    </div>
                    <div class="dialog-body">
                        <div class="remark-input">
                            <textarea 
                                v-model="remarkTemp"
                                placeholder="添加备注"
                                @focus="handleRemarkFocus"
                                @blur="handleRemarkBlur"
                                enterkeyhint="done"
                            ></textarea>
                        </div>
                    </div>
                    <div class="dialog-footer">
                        <button class="cancel-btn" @click="remarkCancel">取消</button>
                        <button class="confirm-btn" @click="remarkConfirm">确定</button>
                    </div>
                </div>
            </div>
        </template>
    </div>
</template>

<script setup lang="ts">
import { ref, computed, watch, nextTick, onMounted, onBeforeUnmount } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { ElMessage } from 'element-plus'
import { getMerchantQrcode, createPay } from '/@/api/backend/pay'

// 商户信息
const route = useRoute()
const merchantName = ref('')
const minAmount = ref(0)
const maxAmount = ref(0)
const fixedAmount = ref(0)
const uuid = ref('')
const websiteName = ref('')

// 金额输入
const amount = ref('')
const dotAdded = ref(false)
const decimalCount = ref(0)

// 支付渠道
const selectedChannel = ref(0)
const channels = ref([
    {
        id: 1,
        name: '微信支付商户直连',
        desc: '微信官方商户号直连支付',
        icon: '/assets/images/pay/wxpay.png',
    },
    {
        id: 2,
        name: '支付宝商户直连',
        desc: '支付宝官方商户号直连支付',
        icon: '/assets/images/pay/alipay.png',
    },
    {
        id: 3,
        name: '易速付',
        desc: '第三方聚合支付通道',
        icon: '/assets/images/pay/yisufu.png',
    },
    {
        id: 4,
        name: '汇付天下',
        desc: '第三方聚合支付通道',
        icon: '/assets/images/pay/huifu.png',
    },
])

// 备注
const remark = ref('')
const remarkTemp = ref('')
const showRemarkDialog = ref(false)

// 金额错误信息
const amountError = ref('')

// 错误提示相关
const showError = ref(false)
const errorTitle = ref('')
const errorDesc = ref('')

// 添加 loading 状态
const loading = ref(false)

// 获取收款码信息
const getMerchantInfo = async () => {
    try {
        const uuidParam = route.query.uuid
        if (!uuidParam || typeof uuidParam !== 'string') {
            showError.value = true
            errorTitle.value = '参数错误'
            errorDesc.value = '收款码不存在或已失效'
            return
        }
        const res = await getMerchantQrcode(uuidParam)
        if (res.code === 1) {
            merchantName.value = res.data.name
            minAmount.value = res.data.min_amount
            maxAmount.value = res.data.max_amount
            fixedAmount.value = res.data.fixed_amount
            uuid.value = res.data.uuid
            websiteName.value = res.data.website_name || ''

            // 如果有固定金额,直接设置
            if (fixedAmount.value > 0) {
                amount.value = fixedAmount.value.toString()
            }
        } else {
            showError.value = true
            errorTitle.value = '获取收款码失败'
            errorDesc.value = res.msg || '收款码不存在或已失效'
        }
    } catch (error) {
        console.error('获取商户信息失败:', error)
        showError.value = true
        errorTitle.value = '系统错误'
        errorDesc.value = '获取收款码信息失败,请稍后重试'
    }
}

// 在页面加载时获取商户信息
onMounted(() => {
    getMerchantInfo()
})

onBeforeUnmount(() => {
    // No need to remove event listeners as we're not using visualViewport
})

// 修改金额验证逻辑
const canSubmit = computed(() => {
    const amountNum = parseFloat(amount.value || '0')
    
    // 如果有固定金额,只允许输入固定金额
    if (fixedAmount.value > 0) {
        return amountNum === fixedAmount.value
    }
    
    // 只验证金额是否大于0
    return amount.value && amountNum > 0
})

// 监听金额变化
watch(
    () => parseFloat(amount.value || '0'),
    (newAmount) => {
        amountError.value = ''
    }
)

// 修改输入数字的逻辑
const inputNumber = (num: string) => {
    // 如果有固定金额,禁止输入
    if (fixedAmount.value > 0) {
        return
    }

    // 清除错误信息
    amountError.value = ''

    // 处理小数点
    if (num === '.') {
        if (!amount.value) {
            amount.value = '0.'
            dotAdded.value = true
        } else if (!dotAdded.value) {
            amount.value += '.'
            dotAdded.value = true
        }
        return
    }

    // 处理数字
    if (dotAdded.value) {
        if (decimalCount.value < 2) {
            const newAmount = amount.value + num
            const amountNum = parseFloat(newAmount)
            
            // 验证最大金额
            if (maxAmount.value > 0 && amountNum > maxAmount.value) {
                amountError.value = `金额不能超过${maxAmount.value}元`
                return
            }
            
            amount.value = newAmount
            decimalCount.value++
        }
    } else {
        const newAmount = amount.value === '' ? num : amount.value + num
        const amountNum = parseFloat(newAmount)
        
        // 验证最大金额
        if (maxAmount.value > 0 && amountNum > maxAmount.value) {
            amountError.value = `金额不能超过${maxAmount.value}元`
            return
        }
        
        amount.value = newAmount
    }
}

// 修改删除数字的逻辑
const deleteNumber = () => {
    // 如果有固定金额,禁止删除
    if (fixedAmount.value > 0) {
        return
    }
    
    if (!amount.value) return

    const lastChar = amount.value.slice(-1)
    amount.value = amount.value.slice(0, -1)

    if (lastChar === '.') {
        dotAdded.value = false
    } else if (dotAdded.value) {
        decimalCount.value--
    }

    if (amount.value === '0') {
        amount.value = ''
    }
}

// 选择支付渠道
const selectChannel = (channel: any) => {
    selectedChannel.value = channel.id
}

// 处理支付
const handlePay = async () => {
    if (!amount.value) {
        ElMessage.error('请输入支付金额')
        return
    }

    try {
        loading.value = true
        const res = await createPay({
            uuid: uuid.value,
            amount: amount.value,
            remark: remark.value
        })

        if (res.code === 1) {
            const payUrl = res.data.pay_url

            window.location.href = payUrl
        } else {
            ElMessage.error(res.msg || '支付失败')
        }
    } catch (error: any) {
        console.error('支付请求失败:', error)
        ElMessage.error(error.message || '支付请求失败')
    } finally {
        loading.value = false
    }
}

// 打开备注弹窗
const remarkEdit = () => {
    remarkTemp.value = remark.value
    showRemarkDialog.value = true
}

// 关闭备注弹窗
const remarkCancel = () => {
    showRemarkDialog.value = false
}

// 确认备注
const remarkConfirm = () => {
    remark.value = remarkTemp.value
    remarkCancel()
}

// 是否显示金额限制提示
const showAmountLimit = computed(() => {
    return fixedAmount.value > 0
})

// 处理备注输入框焦点
const handleRemarkFocus = () => {
    // 记录当前滚动位置
    const scrollTop = document.documentElement.scrollTop || document.body.scrollTop
    
    // 设置视口
    const metaEl = document.querySelector('meta[name="viewport"]')
    if (metaEl) {
        metaEl.setAttribute('content', 'width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no')
    }
    
    // 固定页面位置
    document.body.style.position = 'fixed'
    document.body.style.width = '100%'
    document.body.style.top = `-${scrollTop}px`
}

// 处理备注输入框失焦
const handleRemarkBlur = () => {
    // 恢复视口设置
    const metaEl = document.querySelector('meta[name="viewport"]')
    if (metaEl) {
        metaEl.setAttribute('content', 'width=device-width, initial-scale=1.0')
    }
    
    // 恢复页面滚动
    const scrollTop = Math.abs(parseFloat(document.body.style.top))
    document.body.style.position = ''
    document.body.style.width = ''
    document.body.style.top = ''
    window.scrollTo(0, scrollTop)
}
</script>

<style scoped lang="scss">
.wrap {
    max-width: 600px;
    margin: 0 auto;
    position: absolute;
    left: 0;
    top: 0;
    right: 0;
    bottom: 0;
    width: 100%;
    height: 100%;
    overflow: hidden;
    background-color: #ededed;
    font-family: '微软雅黑';

    // 禁用页面缩放和选择
    touch-action: none;
    user-select: none;
    -webkit-touch-callout: none;
    -webkit-user-select: none;
    -webkit-tap-highlight-color: transparent;
}

.box-pay {
    width: 100%;
    box-sizing: border-box;
    position: absolute;
    left: 0;
    top: 0;
    right: 0;
    bottom: 282px;
    background: #f4f6f8;

    .title {
        color: #000;
        letter-spacing: 1px;
        padding: 36px 88px 10px 20px;
        margin: 0;
        position: absolute;
        width: 100%;
        height: 130px;
        box-sizing: border-box;

        .merchant-avatar {
            width: 52px;
            height: 52px;
            position: absolute;
            right: 20px;
            top: 36px;
            border-radius: 6px;
            background: #fff;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;

            img {
                width: 100%;
                height: 100%;
                object-fit: cover;
            }
        }

        .label {
            height: 20px;
            line-height: 20px;
            font-size: 14px;
            color: #666;
            margin-bottom: 4px;
        }

        .shopname {
            line-height: 28px;
            font-size: 26px;
            color: #171717;
            max-height: 56px;
            overflow: hidden;
        }
    }

    .input {
        padding: 30px 20px;
        position: absolute;
        width: 100%;
        box-sizing: border-box;
        left: 0;
        top: 130px;
        bottom: 0;
        right: 0;
        background: #fff;
        border-top-left-radius: 15px;
        border-top-right-radius: 15px;

        .label {
            height: 30px;
            line-height: 30px;
            font-size: 14px;
            color: #333;
            font-weight: 500;
            padding-left: 7px;
        }

        .money {
            display: flex;
            align-items: center;
            box-sizing: border-box;
            border-bottom: 1px solid #f6f6f6;
            position: relative;
            height: 72px;

            .money_icon {
                width: 36px;
                height: 36px;
                margin-right: 5px;
                font-size: 30px;
                font-weight: bold;
                color: #333;
                display: flex;
                align-items: center;
                justify-content: center;
            }

            input {
                flex: 1;
                border: none;
                outline: none;
                font-size: 44px;
                font-weight: bold;
                color: #000;
                background: transparent;
                padding: 0 5px;
            }
        }
    }
}

.table_font {
    width: 100%;
    height: 300px;
    position: absolute;
    bottom: 0;
    left: 0;
    right: 0;
    background-color: #f4f6f8;
    padding: 30px 5px 10px 5px;
    box-sizing: border-box;

    .brand {
        position: absolute;
        left: 0;
        top: 0;
        width: 100%;
        height: 32px;
        line-height: 34px;
        font-size: 14px;
        color: #ccc;
        text-align: center;
        letter-spacing: 2px;
    }

    table {
        width: 100%;
        height: 100%;

        td {
            vertical-align: middle;
            text-align: center;
            background: #fff;
            width: 25%;
            height: 16.66%;
            border-radius: 4px;

            &.click_num {
                color: #000;
                font-size: 26px;

                &:active {
                    background-color: #eee;
                    opacity: 0.75;
                }
            }

            &.sure_button {
                font-size: 18px;
                background: #0078ec;
                color: #fff;

                &:active {
                    opacity: 0.9;
                }

                &.disabled {
                    background: #ccc;
                    pointer-events: none;
                }
            }
        }
    }
}

// 备注弹窗样式
.dialog-mask {
    position: fixed;
    left: 0;
    right: 0;
    top: 0;
    bottom: 0;
    background: rgba(0, 0, 0, 0.5);
    z-index: 1000;
    display: flex;
    align-items: center;
    justify-content: center;
}

.dialog-remark {
    width: 90%;
    max-width: 320px;
    background: #fff;
    border-radius: 12px;
    position: relative;
    transform: translateY(0);
    transition: transform 0.3s ease;
}

.dialog-header {
    padding: 16px;
    text-align: center;
    border-bottom: 1px solid #eee;
    position: relative;
}

.dialog-header span {
    font-size: 16px;
    font-weight: 500;
    color: #333;
}

.close-icon {
    position: absolute;
    right: 16px;
    top: 50%;
    transform: translateY(-50%);
    font-size: 20px;
    color: #999;
    cursor: pointer;
}

.dialog-body {
    padding: 16px;
}

.remark-input {
    textarea {
        width: 100%;
        padding: 10px;
        border: 1px solid #eee;
        border-radius: 4px;
        font-size: 14px;
        line-height: 1.5;
        resize: none;
        
        &:focus {
            outline: none;
            border-color: #1677ff;
        }
    }
}

.dialog-footer {
    padding: 12px 16px;
    display: flex;
    justify-content: space-between;
    gap: 12px;
}

.cancel-btn,
.confirm-btn {
    flex: 1;
    height: 44px;
    border-radius: 22px;
    border: none;
    font-size: 16px;
    cursor: pointer;
}

.cancel-btn {
    background: #f5f5f5;
    color: #333;
}

.confirm-btn {
    background: #1677ff;
    color: #fff;
}

/* 适配底部安全区域 */
@supports (padding-bottom: env(safe-area-inset-bottom)) {
    .dialog-footer {
        padding-bottom: calc(12px + env(safe-area-inset-bottom));
    }
}

.remark {
    font-size: 13px;
    color: #999;
    width: 100%;
    margin: 20px 0;
    padding-left: 7px;

    .btn-edit-remark {
        padding-left: 10px;
        color: #006cdb;
    }
}

.delete-icon {
    width: 24px;
    height: 24px;
    object-fit: contain;
}

// 错误提示样式
.error-notice {
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: #fff;
    z-index: 100;
    display: flex;
    align-items: center;
    justify-content: center;

    .error-content {
        text-align: center;
        padding: 20px;

        i {
            font-size: 48px;
            color: #f56c6c;
            margin-bottom: 20px;
        }

        .error-title {
            font-size: 20px;
            color: #333;
            margin-bottom: 12px;
            font-weight: bold;
        }

        .error-desc {
            font-size: 14px;
            color: #666;
            line-height: 1.5;
        }
    }
}

.amount-error {
    margin: 8px 0 0 7px;
    display: flex;
    align-items: center;
    color: #f56c6c;
    font-size: 13px;
    line-height: 1;

    i {
        margin-right: 4px;
        font-size: 14px;
    }
}

.amount-limit {
    margin: 8px 0 0 7px;
    color: #909399;
    font-size: 12px;
    line-height: 1;
}
</style>
