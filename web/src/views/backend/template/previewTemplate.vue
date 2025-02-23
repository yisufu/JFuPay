<template>
    <div class="template-preview" v-if="templateData">
        <!-- 预览区域 -->
        <div class="preview-area">
            <div class="preview-container" :style="containerStyle">
                <!-- 背景图 -->
                <img v-if="templateData.background" :src="templateData.background" class="background-image" />

                <!-- 二维码区域 -->
                <div class="qrcode-area" :style="qrcodeStyle">
                    <img :src="qrcodeUrl" class="qrcode-image" />
                </div>

                <!-- 示例文本 -->
                <div class="text-layer">
                    <!-- 金额 -->
                    <div class="amount" :style="getTextStyle('amount')">¥ 88.88</div>
                    <!-- 商户名称 -->
                    <div class="merchant" :style="getTextStyle('merchant')">示例商户名称</div>
                    <!-- 订单号 -->
                    <div class="order" :style="getTextStyle('order')">订单号：2024021712345678</div>
                    <!-- 时间 -->
                    <div class="time" :style="getTextStyle('time')">2024-02-17 12:34:56</div>
                </div>
            </div>
        </div>

        <!-- 模板信息 -->
        <div class="template-info">
            <el-descriptions :column="2" border>
                <el-descriptions-item label="模板名称">{{ templateData.name }}</el-descriptions-item>
                <el-descriptions-item label="模板类型">{{ templateData.type === 'normal' ? '普通模板' : '自定义模板' }}</el-descriptions-item>
                <el-descriptions-item label="字体">{{ templateData.font_family }}</el-descriptions-item>
                <el-descriptions-item label="字体大小">{{ templateData.font_size }}px</el-descriptions-item>
                <el-descriptions-item label="字体颜色">
                    <el-color-picker :model-value="templateData.font_color" disabled />
                </el-descriptions-item>
                <el-descriptions-item label="状态">
                    <el-tag :type="templateData.status === 1 ? 'success' : 'danger'">
                        {{ templateData.status === 1 ? '启用' : '禁用' }}
                    </el-tag>
                </el-descriptions-item>
            </el-descriptions>

            <el-divider>二维码设置</el-divider>
            <el-descriptions :column="2" border>
                <el-descriptions-item label="宽度">{{ templateData.qrcode_width }}px</el-descriptions-item>
                <el-descriptions-item label="高度">{{ templateData.qrcode_height }}px</el-descriptions-item>
                <el-descriptions-item label="X坐标">{{ templateData.qrcode_x }}px</el-descriptions-item>
                <el-descriptions-item label="Y坐标">{{ templateData.qrcode_y }}px</el-descriptions-item>
            </el-descriptions>

            <el-divider>额外配置</el-divider>
            <pre class="extra-config">{{ formatConfig }}</pre>
        </div>
    </div>
    <div v-else class="template-preview-empty">
        <el-empty description="暂无模板数据" />
    </div>
</template>

<script setup lang="ts">
import { computed } from 'vue'
import { ElDescriptions, ElDescriptionsItem, ElDivider, ElColorPicker, ElTag, ElEmpty } from 'element-plus'
import { useSiteConfig } from '/@/stores/siteConfig'

const siteConfig = useSiteConfig()

// 获取完整图片URL
const getImageUrl = (path: string) => {
    if (!path) return ''
    if (path.startsWith('http')) return path
    return siteConfig.site_url + path
}

interface TemplateData {
    name: string
    type: string
    background?: string
    qrcode_width: number
    qrcode_height: number
    qrcode_x: number
    qrcode_y: number
    font_family: string
    font_size: number
    font_color: string
    amount_x: number
    amount_y: number
    merchant_x: number
    merchant_y: number
    order_x: number
    order_y: number
    time_x: number
    time_y: number
    status: number
    extra_config?: string
}

const props = defineProps<{
    templateData?: TemplateData
}>()

// 调试输出
console.log('Template Data:', props.templateData)
if (props.templateData?.background) {
    console.log('Background URL:', getImageUrl(props.templateData.background))
}

// 二维码URL
const qrcodeUrl = computed(() => {
    if (!props.templateData) return ''
    const { qrcode_width = 200, qrcode_height = 200 } = props.templateData
    return `https://api.qrserver.com/v1/create-qr-code/?size=${qrcode_width}x${qrcode_height}&data=demo`
})

// 容器样式
const containerStyle = computed(() => ({
    position: 'relative' as const
}))

// 二维码样式
const qrcodeStyle = computed(() => {
    if (!props.templateData) return {}
    return {
        position: 'absolute' as const,
        left: `${props.templateData.qrcode_x}px`,
        top: `${props.templateData.qrcode_y}px`,
        width: `${props.templateData.qrcode_width}px`,
        height: `${props.templateData.qrcode_height}px`
    }
})

// 获取文本样式
const getTextStyle = (type: 'amount' | 'merchant' | 'order' | 'time') => {
    if (!props.templateData) return {}
    
    const baseStyle = {
        fontFamily: props.templateData.font_family,
        fontSize: `${props.templateData.font_size}px`,
        color: props.templateData.font_color
    }

    const positions = {
        amount: {
            left: `${props.templateData.amount_x}px`,
            top: `${props.templateData.amount_y}px`
        },
        merchant: {
            left: `${props.templateData.merchant_x}px`,
            top: `${props.templateData.merchant_y}px`
        },
        order: {
            left: `${props.templateData.order_x}px`,
            top: `${props.templateData.order_y}px`
        },
        time: {
            left: `${props.templateData.time_x}px`,
            top: `${props.templateData.time_y}px`
        }
    }

    return {
        ...baseStyle,
        ...positions[type]
    }
}

// 格式化额外配置
const formatConfig = computed(() => {
    if (!props.templateData?.extra_config) return '{}'
    try {
        return JSON.stringify(JSON.parse(props.templateData.extra_config), null, 2)
    } catch (e) {
        return '{}'
    }
})
</script>

<style scoped lang="scss">
.template-preview {
    display: flex;
    gap: 20px;

    .preview-area {
        flex: 0 0 375px;
        background: #f5f5f5;
        padding: 20px;
        border-radius: 4px;
        overflow: hidden;

        .preview-container {
            background: #fff;
            box-shadow: 0 2px 12px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            position: relative;
            width: 750px;
            height: 1000px;
            transform: scale(0.5);
            transform-origin: top left;

            .background-image {
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                object-fit: cover;
            }

            .qrcode-area {
                position: absolute;
                display: flex;
                align-items: center;
                justify-content: center;
                background: #fff;
                border-radius: 4px;
                overflow: hidden;
                z-index: 1;

                .qrcode-image {
                    width: 100%;
                    height: 100%;
                    object-fit: contain;
                }
            }

            .text-layer {
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                pointer-events: none;
                z-index: 2;

                > div {
                    position: absolute;
                    transform: translate(-50%, -50%);
                    white-space: nowrap;
                }

                .amount {
                    font-weight: bold;
                    font-size: 24px;
                }
            }
        }
    }

    .template-info {
        flex: 1;
        min-width: 0;

        .el-descriptions {
            margin-bottom: 20px;
        }

        .extra-config {
            background: #f8f8f8;
            padding: 15px;
            border-radius: 4px;
            font-family: monospace;
            white-space: pre-wrap;
            word-break: break-all;
            margin: 0;
            font-size: 12px;
        }
    }
}

.template-preview-empty {
    display: flex;
    align-items: center;
    justify-content: center;
    min-height: 400px;
}
</style>
