<template>
    <!-- 移动端访问提示 -->
    <div v-if="isMobile" class="mobile-tips">
        <div class="tips-content">
            <i class="fa fa-desktop"></i>
            <p>请使用电脑访问此页面</p>
            <p class="sub-text">为了更好的支付体验，请使用电脑浏览器访问</p>
        </div>
    </div>

    <!-- PC 收银台界面 -->
    <div v-else class="cashier-page">
        <!-- 开发中提示 -->
        <!-- <el-alert
            title="线上收银台开发中，暂不可用"
            type="warning"
            :closable="false"
            show-icon
            style="position: fixed; top: 0; left: 0; right: 0; z-index: 9999;"
        /> -->

        <!-- 顶部导航 -->
        <div class="cashier-header">
            <div class="header-content">
                <div class="title">收银台</div>
                <div class="countdown" v-if="countdown > 0">
                    <span class="label">支付剩余时间</span>
                    <span class="time">{{ formatCountdown(countdown) }}</span>
                </div>
            </div>
        </div>

        <!-- 主要内容区 -->
        <div class="cashier-content">
            <div class="content-wrapper">
                <!-- 支付金额展示 -->
                <div class="amount-section">
                    <div class="amount-value">
                        <span class="currency">¥</span>
                        <span class="number">{{ formatAmount(amount) }}</span>
                    </div>
                    <div class="order-no">订单编号：{{ orderNo }}</div>
                </div>

                <!-- 支付方式列表 -->
                <div class="payment-methods">
                    <div class="methods-list">
                        <div 
                            v-for="method in paymentMethods" 
                            :key="method.id"
                            class="method-item"
                            :class="{ active: selectedMethod === method.id }"
                            @click="selectMethod(method)"
                        >
                            <div class="method-icon">
                                <img :src="method.icon" :alt="method.name" />
                            </div>
                            <div class="method-name">{{ method.name }}</div>
                            <div class="method-select">
                                <div class="radio" :class="{ checked: selectedMethod === method.id }"></div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- 支付提示区域 -->
                <div class="payment-tips" v-if="selectedMethod">
                    <div class="tips-content">
                        <template v-if="selectedMethod === 'wxpay'">
                            <p>使用微信App扫码完成支付</p>
                        </template>
                        <template v-else-if="selectedMethod === 'alipay'">
                            <p>使用支付宝App扫码完成支付</p>
                        </template>
                        <template v-else-if="selectedMethod === 'bank'">
                            <p>请选择网上银行进行支付</p>
                            <p class="sub-tips">企业网银支付需额外支付手续费</p>
                        </template>
                    </div>
                </div>

                <!-- 支付按钮 -->
                <div class="payment-action">
                    <el-button 
                        type="primary" 
                        size="large" 
                        class="pay-button"
                        :disabled="!selectedMethod"
                        @click="handlePay"
                    >
                        立即支付
                    </el-button>
                </div>
            </div>
        </div>
    </div>
</template>

<script setup lang="ts">
import { ref, onMounted, onUnmounted } from 'vue'
import { useRoute } from 'vue-router'
import { ElMessage } from 'element-plus'
import { getMerchantQrcode } from '/@/api/backend/pay'

// 检测是否为移动设备
const isMobile = ref(false)
const checkDevice = () => {
    isMobile.value = /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent)
}

// 页面数据
const route = useRoute()
const merchantName = ref('')
const amount = ref(0)
const orderNo = ref('')
const createTime = ref(0)
const selectedMethod = ref('')
const countdown = ref(300) // 5分钟倒计时
let timer: ReturnType<typeof setInterval> | null = null

// 支付方式列表
const paymentMethods = ref([
    {
        id: 'wxpay',
        name: '微信支付',
        icon: '/src/assets/cashier/new_wx_pay.png'
    },
    {
        id: 'alipay',
        name: '支付宝',
        icon: '/src/assets/cashier/zfb_pay.png'
    },
    {
        id: 'quickpass',
        name: '银联快捷',
        icon: '/src/assets/cashier/quickpass_pay.png'
    },
    {
        id: 'quick',
        name: '快捷支付',
        icon: '/src/assets/cashier/quick_pay.png'
    },
    {
        id: 'bank',
        name: '网银支付',
        icon: '/src/assets/cashier/net_bank_pay.png'
    }
])

// 格式化金额
const formatAmount = (value: number) => {
    return value.toFixed(2)
}

// 格式化时间
const formatTime = (timestamp: number) => {
    const date = new Date(timestamp * 1000)
    return date.toLocaleString()
}

// 格式化倒计时
const formatCountdown = (seconds: number) => {
    const minutes = Math.floor(seconds / 60)
    const remainingSeconds = seconds % 60
    return `${String(minutes).padStart(2, '0')}:${String(remainingSeconds).padStart(2, '0')}`
}

// 选择支付方式
const selectMethod = (method: any) => {
    selectedMethod.value = method.id
}

// 加载订单数据
const loadOrderData = async () => {
    try {
        const uuid = route.query.uuid as string
        if (!uuid) {
            ElMessage.error('订单参数错误')
            return
        }

        const res = await getMerchantQrcode(uuid)
        if (res.code === 1) {
            const data = res.data
            merchantName.value = data.name
            amount.value = data.amount
            orderNo.value = data.order_no
            createTime.value = data.create_time
        } else {
            ElMessage.error(res.msg || '获取订单信息失败')
        }
    } catch (error) {
        console.error('加载订单数据失败:', error)
        ElMessage.error('加载订单数据失败')
    }
}

// 处理支付
const handlePay = () => {
    if (!selectedMethod.value) {
        ElMessage.warning('请选择支付方式')
        return
    }
    // TODO: 实现支付逻辑
}

// 开始倒计时
const startCountdown = () => {
    timer = setInterval(() => {
        if (countdown.value > 0) {
            countdown.value--
        } else {
            if (timer) {
                clearInterval(timer)
            }
            // TODO: 处理订单超时
        }
    }, 1000)
}

onMounted(() => {
    checkDevice()
    if (!isMobile.value) {
        loadOrderData()
        startCountdown()
    }
})

// 组件卸载时清除定时器
onUnmounted(() => {
    if (timer) {
        clearInterval(timer)
    }
})
</script>

<style scoped lang="scss">
// 移动端提示样式
.mobile-tips {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: #fff;
    display: flex;
    align-items: center;
    justify-content: center;
    z-index: 999;

    .tips-content {
        text-align: center;
        padding: 20px;

        i {
            font-size: 48px;
            color: #1677ff;
            margin-bottom: 16px;
        }

        p {
            margin: 8px 0;
            color: #333;
            font-size: 18px;

            &.sub-text {
                color: #666;
                font-size: 14px;
            }
        }
    }
}

// PC 收银台样式
.cashier-page {
    min-height: 100vh;
    background: #f5f5f5;
}

.cashier-header {
    background: #fff;
    border-bottom: 1px solid #f0f0f0;

    .header-content {
        max-width: 1200px;
        margin: 0 auto;
        height: 60px;
        display: flex;
        align-items: center;
        justify-content: space-between;
        padding: 0 24px;

        .title {
            font-size: 20px;
            font-weight: 500;
            color: #333;
        }

        .countdown {
            display: flex;
            align-items: center;
            
            .label {
                color: #666;
                margin-right: 8px;
            }

            .time {
                color: #ff4d4f;
                font-size: 16px;
                font-weight: 500;
            }
        }
    }
}

.cashier-content {
    padding: 32px 0;

    .content-wrapper {
        max-width: 800px;
        margin: 0 auto;
        background: #fff;
        border-radius: 8px;
        padding: 32px;
    }
}

.amount-section {
    text-align: center;
    margin-bottom: 40px;

    .amount-value {
        margin-bottom: 12px;

        .currency {
            font-size: 24px;
            color: #333;
            margin-right: 4px;
        }

        .number {
            font-size: 32px;
            font-weight: 500;
            color: #333;
        }
    }

    .order-no {
        color: #666;
        font-size: 14px;
    }
}

.payment-methods {
    margin-bottom: 32px;

    .methods-list {
        display: grid;
        grid-template-columns: repeat(3, 1fr);
        gap: 16px;

        .method-item {
            position: relative;
            padding: 24px;
            border: 1px solid #e8e8e8;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.3s;
            text-align: center;

            &:hover {
                border-color: #1677ff;
            }

            &.active {
                border-color: #1677ff;
                background: #f0f7ff;
            }

            .method-icon {
                width: 40px;
                height: 40px;
                margin: 0 auto 12px;

                img {
                    width: 100%;
                    height: 100%;
                    object-fit: contain;
                }
            }

            .method-name {
                font-size: 16px;
                color: #333;
            }

            .method-select {
                position: absolute;
                right: 12px;
                top: 12px;

                .radio {
                    width: 18px;
                    height: 18px;
                    border: 2px solid #d9d9d9;
                    border-radius: 50%;
                    position: relative;

                    &.checked {
                        border-color: #1677ff;

                        &::after {
                            content: '';
                            position: absolute;
                            width: 10px;
                            height: 10px;
                            background: #1677ff;
                            border-radius: 50%;
                            top: 50%;
                            left: 50%;
                            transform: translate(-50%, -50%);
                        }
                    }
                }
            }
        }
    }
}

.payment-tips {
    text-align: center;
    margin-bottom: 32px;
    padding: 24px;
    background: #fafafa;
    border-radius: 8px;

    .tips-content {
        p {
            margin: 0;
            color: #333;
            font-size: 16px;

            &.sub-tips {
                margin-top: 8px;
                color: #666;
                font-size: 14px;
            }
        }
    }
}

.payment-action {
    text-align: center;

    .pay-button {
        width: 200px;
        height: 44px;
        font-size: 16px;
    }
}
</style> 