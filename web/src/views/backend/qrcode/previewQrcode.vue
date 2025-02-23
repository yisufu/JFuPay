<template>
    <el-dialog
        class="qrcode-preview-dialog"
        :model-value="modelValue"
        @close="$emit('update:modelValue', false)"
        title="收款码预览"
        width="400px"
        :close-on-click-modal="false"
        align-center
    >
        <div class="qrcode-container" ref="qrcodeRef">
            <!-- 商户信息 -->
            <div class="merchant-info">
                <div class="merchant-logo">
                    <i class="fa fa-shopping-bag"></i>
                </div>
                <div class="merchant-name">{{ qrcodeData?.name }}</div>
            </div>

            <!-- 金额信息 -->
            <div class="amount-info" v-if="qrcodeData?.fixed_amount">
                <div class="amount-label">付款金额</div>
                <div class="amount-value">
                    <span class="currency">¥</span>
                    <span class="number">{{ qrcodeData.fixed_amount }}</span>
                </div>
            </div>

            <!-- 二维码区域 -->
            <div class="qrcode-wrapper">
                <div class="qrcode-box">
                    <img :src="qrcodeUrl" class="qrcode-image" alt="收款码" />
                </div>
                <div class="qrcode-tip">
                    <i class="fa fa-info-circle"></i>
                    <span>扫一扫向商家付款</span>
                </div>
            </div>
        </div>

        <!-- 将操作按钮移到底部 -->
        <template #footer>
            <div class="dialog-footer">
                <el-button type="primary" @click="handleSave" class="action-button">
                    <i class="fa fa-download"></i>
                    <span>保存二维码</span>
                </el-button>
                <el-button type="success" @click="handleCopy" class="action-button">
                    <i class="fa fa-copy"></i>
                    <span>复制链接</span>
                </el-button>
            </div>
        </template>

        <PreviewCashier
            v-model="showCashier"
            :cashier-data="cashierData"
        />
    </el-dialog>
</template>

<script setup lang="ts">
import { ref, watch, computed } from 'vue'
import QRCode from 'qrcode'
import { ElMessage } from 'element-plus'
import html2canvas from 'html2canvas'
import PreviewCashier from './previewCashier.vue'

const props = defineProps({
    modelValue: {
        type: Boolean,
        default: false
    },
    qrcodeData: {
        type: Object,
        default: () => ({})
    }
})

const emit = defineEmits(['update:modelValue'])
const qrcodeRef = ref<HTMLElement>()

// 生成二维码URL
const qrcodeUrl = ref('')
const qrcodeBase64 = ref('')  // 新增：存储base64格式的二维码数据

const baseUrl = computed(() => window.location.origin + '/h5/payment')

const showCashier = ref(false)
const cashierData = ref({})

// 保存二维码
const handleSave = async () => {
    try {
        const qrcodeElement = document.querySelector('.qrcode-image') as HTMLImageElement
        const actionsElement = document.querySelector('.qrcode-actions') as HTMLElement

        // 隐藏操作按钮
        if (actionsElement) {
            actionsElement.style.display = 'none'
        }

        // 等待图片加载完成
        if (qrcodeElement && !qrcodeElement.complete) {
            await new Promise((resolve) => {
                qrcodeElement.onload = resolve
            })
        }

        const canvas = await html2canvas(document.querySelector('.qrcode-container') as HTMLElement)
        const imgUrl = canvas.toDataURL('image/png')
        
        // 创建下载链接
        const link = document.createElement('a')
        link.download = '收款码.png'
        link.href = imgUrl
        link.click()

        // 恢复操作按钮显示
        if (actionsElement) {
            actionsElement.style.display = 'block'
        }

        ElMessage.success('保存成功')
    } catch (error) {
        console.error('保存失败:', error)
        ElMessage.error('保存失败')
    }
}

// 复制链接
const handleCopy = () => {
    const url = `${baseUrl.value}?uuid=${props.qrcodeData?.uuid || ''}`
    navigator.clipboard.writeText(url).then(() => {
        ElMessage.success('链接已复制到剪贴板')
    }).catch(() => {
        ElMessage.error('复制失败')
    })
}

const optButtons = [
    {
        text: '保存二维码',
        type: 'primary',
        icon: 'fa fa-download',
        handler: handleSave
    },
    {
        text: '复制链接',
        type: 'default',
        icon: 'fa fa-copy',
        handler: handleCopy
    },
    {
        text: '生成收银台',
        type: 'success',
        icon: 'fa fa-link',
        handler: () => {
            cashierData.value = props.qrcodeData
            showCashier.value = true
        }
    }
]

// 监听数据变化，生成二维码
watch(() => props.qrcodeData, async (newData) => {
    if (newData?.uuid) {
        const paymentUrl = `${baseUrl.value}?uuid=${newData.uuid}`
        try {
            // 生成二维码的base64数据
            qrcodeBase64.value = await QRCode.toDataURL(paymentUrl, {
                width: 200,
                margin: 2,
                color: {
                    dark: '#000000',
                    light: '#ffffff'
                }
            })
            // 创建一个新的图片元素
            const img = new Image()
            img.src = qrcodeBase64.value
            // 等待图片加载完成
            await new Promise((resolve) => {
                img.onload = resolve
            })
            // 更新显示的二维码URL
            qrcodeUrl.value = qrcodeBase64.value
        } catch (err) {
            console.error('生成二维码失败:', err)
            ElMessage.error('生成二维码失败')
        }
    }
}, { immediate: true })
</script>

<style scoped lang="scss">
.qrcode-preview-dialog {
    :deep(.el-dialog__body) {
        padding: 0;
    }
}

.qrcode-container {
    background: #ffffff;
    border-radius: 12px;
    overflow: hidden;
    box-shadow: 0 4px 16px rgba(0, 0, 0, 0.06);
}

.merchant-info {
    background: linear-gradient(135deg, #1677ff 0%, #0056d9 100%);
    color: #ffffff;
    padding: 24px 20px;
    text-align: center;
    position: relative;
    overflow: hidden;

    &::after {
        content: '';
        position: absolute;
        bottom: -20px;
        left: 0;
        right: 0;
        height: 40px;
        background: #ffffff;
        border-radius: 50% 50% 0 0;
        box-shadow: 0 -4px 16px rgba(0, 0, 0, 0.1);
    }

    .merchant-logo {
        width: 64px;
        height: 64px;
        background: rgba(255, 255, 255, 0.15);
        backdrop-filter: blur(4px);
        border-radius: 50%;
        margin: 0 auto 16px;
        display: flex;
        align-items: center;
        justify-content: center;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        border: 2px solid rgba(255, 255, 255, 0.2);

        i {
            font-size: 30px;
            color: rgba(255, 255, 255, 0.9);
        }
    }

    .merchant-name {
        font-size: 20px;
        font-weight: 600;
        text-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        letter-spacing: 0.5px;
    }
}

.amount-info {
    padding: 24px 20px;
    text-align: center;
    background: #ffffff;
    position: relative;

    &::after {
        content: '';
        position: absolute;
        bottom: 0;
        left: 15%;
        right: 15%;
        height: 1px;
        background: linear-gradient(to right, transparent, #e8e8e8, transparent);
    }

    .amount-label {
        color: #666666;
        margin-bottom: 12px;
        font-size: 15px;
    }

    .amount-value {
        display: flex;
        align-items: baseline;
        justify-content: center;
        
        .currency {
            font-size: 24px;
            color: #333333;
            margin-right: 4px;
            font-weight: 500;
        }

        .number {
            font-size: 36px;
            font-weight: 600;
            color: #333333;
            line-height: 1;
        }
    }
}

.qrcode-wrapper {
    padding: 28px 20px;
    background: #ffffff;
    text-align: center;

    .qrcode-box {
        background: #ffffff;
        padding: 12px;
        border-radius: 12px;
        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
        display: inline-block;
        position: relative;

        &::before {
            content: '';
            position: absolute;
            top: -2px;
            left: -2px;
            right: -2px;
            bottom: -2px;
            background: linear-gradient(135deg, #1677ff22, #0056d922);
            border-radius: 14px;
            z-index: -1;
        }
    }

    .qrcode-image {
        width: 200px;
        height: 200px;
        display: block;
        border-radius: 6px;
    }

    .qrcode-tip {
        margin-top: 20px;
        color: #666666;
        font-size: 14px;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 6px;

        i {
            color: #1677ff;
            font-size: 16px;
        }
    }
}

.dialog-footer {
    display: flex;
    gap: 12px;
    justify-content: center;
    padding: 16px;
    background: #f8f9fa;
    border-top: 1px solid #ebeef5;

    .action-button {
        min-width: 100px;
        height: 32px;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 6px;
        font-size: 13px;
        font-weight: normal;
        padding: 0 16px;
        transition: all 0.2s ease;

        i {
            font-size: 14px;
        }

        &:hover {
            transform: translateY(-1px);
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
        }
    }
}
</style> 