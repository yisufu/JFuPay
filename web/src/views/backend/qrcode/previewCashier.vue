<template>
    <el-dialog
        class="cashier-preview-dialog"
        :model-value="modelValue"
        @close="$emit('update:modelValue', false)"
        title="收银台链接"
        width="500px"
        :close-on-click-modal="false"
        align-center
    >
        <div class="cashier-container">
            <!-- 链接区域 -->
            <div class="link-section">
                <div class="section-title">收银台链接</div>
                <div class="link-box">
                    <el-input
                        ref="inputRef"
                        v-model="cashierUrl"
                        readonly
                        class="link-input"
                    >
                        <template #append>
                            <el-button @click="handleCopy">
                                <i class="fa fa-copy"></i>
                                <span>复制</span>
                            </el-button>
                        </template>
                    </el-input>
                </div>
            </div>

            <!-- 商户信息 -->
            <div class="info-section">
                <div class="section-title">商户信息</div>
                <div class="info-item">
                    <span class="label">商户名称：</span>
                    <span class="value">{{ cashierData?.name }}</span>
                </div>
                <div class="info-item" v-if="cashierData?.fixed_amount">
                    <span class="label">固定金额：</span>
                    <span class="value">¥{{ cashierData.fixed_amount }}</span>
                </div>
                <template v-else>
                    <div class="info-item">
                        <span class="label">最小金额：</span>
                        <span class="value">¥{{ cashierData?.min_amount || '不限制' }}</span>
                    </div>
                    <div class="info-item">
                        <span class="label">最大金额：</span>
                        <span class="value">¥{{ cashierData?.max_amount || '不限制' }}</span>
                    </div>
                </template>
                <div class="info-item">
                    <span class="label">备注信息：</span>
                    <span class="value">{{ cashierData?.remark || '无' }}</span>
                </div>
            </div>
        </div>
    </el-dialog>
</template>

<script setup lang="ts">
import { computed, ref } from 'vue'
import { ElMessage } from 'element-plus'

const props = defineProps({
    modelValue: {
        type: Boolean,
        default: false
    },
    cashierData: {
        type: Object,
        default: () => ({})
    }
})

const emit = defineEmits(['update:modelValue'])
const inputRef = ref()

// 生成收银台链接
const cashierUrl = computed(() => {
    return `http://192.168.31.7:1818/pc/cashier?uuid=${props.cashierData?.uuid || ''}`
})

// 复制链接
const handleCopy = () => {
    // 创建临时输入框
    const input = document.createElement('input')
    input.value = cashierUrl.value
    document.body.appendChild(input)
    input.select()
    
    try {
        document.execCommand('copy')
        ElMessage.success('链接已复制到剪贴板')
    } catch (err) {
        ElMessage.error('复制失败，请手动复制')
    } finally {
        document.body.removeChild(input)
    }
}
</script>

<style scoped lang="scss">
.cashier-container {
    padding: 20px;
}

.section-title {
    font-size: 16px;
    font-weight: 500;
    color: #333;
    margin-bottom: 16px;
    display: flex;
    align-items: center;

    &::before {
        content: '';
        width: 4px;
        height: 16px;
        background: #1677ff;
        margin-right: 8px;
        border-radius: 2px;
    }
}

.link-section {
    margin-bottom: 24px;

    .link-box {
        background: #f8f9fa;
        border-radius: 8px;
        padding: 12px;

        :deep(.el-input-group__append) {
            padding: 0;
            border: none;
            background: none;

            .el-button {
                border: none;
                height: 32px;
                padding: 0 16px;
                border-radius: 0 4px 4px 0;

                i {
                    margin-right: 4px;
                }
            }
        }
    }
}

.info-section {
    background: #f8f9fa;
    border-radius: 8px;
    padding: 16px;

    .info-item {
        display: flex;
        margin-bottom: 12px;
        font-size: 14px;
        line-height: 1.6;

        &:last-child {
            margin-bottom: 0;
        }

        .label {
            color: #666;
            width: 84px;
            flex-shrink: 0;
        }

        .value {
            color: #333;
            flex: 1;
        }
    }
}
</style> 