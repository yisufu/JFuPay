<template>
    <el-dialog
        class="ba-operate-dialog"
        :close-on-click-modal="false"
        :model-value="modelValue"
        @close="closeForm"
        title="配置支付参数"
        width="50%"
    >
        <el-scrollbar v-loading="loading" class="ba-table-form-scrollbar">
            <div class="ba-operate-form ba-config-form">
                <el-alert
                    v-if="!pluginConfig.inputs"
                    type="info"
                    :closable="false"
                    show-icon
                    style="margin-bottom: 20px;"
                >
                    <p>正在加载支付插件配置...</p>
                </el-alert>
                <el-form
                    v-else
                    ref="formRef"
                    :model="formData"
                    label-position="right"
                    label-width="120px"
                >
                    <div v-for="(item, key) in pluginConfig.inputs" :key="key">
                        <FormItem 
                            :label="item.name" 
                            :type="getFormType(item.type)" 
                            v-model="configValues[key]" 
                            :prop="key"
                            :input-attr="getInputAttr(item)"
                            :placeholder="item.note || t('Please input field', { field: item.name })"
                        />
                    </div>
                </el-form>
            </div>
        </el-scrollbar>
        <template #footer>
            <div class="dialog-footer">
                <el-button @click="closeForm">{{ t('Cancel') }}</el-button>
                <el-button type="primary" @click="submitForm" :loading="submitLoading">
                    {{ t('Save') }}
                </el-button>
            </div>
        </template>
    </el-dialog>
</template>

<script setup lang="ts">
import { ref, reactive, watch } from 'vue'
import { useI18n } from 'vue-i18n'
import type { FormInstance } from 'element-plus'
import { ElMessage } from 'element-plus'
import FormItem from '/@/components/formItem/index.vue'
import { getPluginConfig } from '/@/api/backend/pay'

const props = defineProps({
    modelValue: {
        type: Boolean,
        default: false
    },
    channelId: {
        type: [String, Number],
        default: ''
    },
    pluginId: {
        type: [String, Number],
        default: ''
    },
    config: {
        type: String,
        default: ''
    }
})

const emit = defineEmits(['update:modelValue', 'success'])
const { t } = useI18n()

const formRef = ref<FormInstance>()
const loading = ref(false)
const submitLoading = ref(false)
const pluginConfig = ref<any>({})
const configValues = reactive<Record<string, any>>({})

// 监听弹窗显示状态
watch(() => props.modelValue, (val) => {
    if (val && props.pluginId) {
        // 清空旧的配置
        Object.keys(configValues).forEach(key => delete configValues[key])
        // 加载插件配置
        loadPluginConfig()
        // 如果有已保存的配置，解析并显示
        if (props.config) {
            try {
                const savedConfig = JSON.parse(props.config)
                Object.assign(configValues, savedConfig)
            } catch (e) {
                console.error('解析配置失败:', e)
            }
        }
    }
})

// 加载插件配置
const loadPluginConfig = async () => {
    loading.value = true
    try {
        const res = await getPluginConfig(Number(props.pluginId))
        pluginConfig.value = res.data.info || {}
    } catch (err) {
        console.error('获取插件配置失败:', err)
        ElMessage.error('获取插件配置失败')
    } finally {
        loading.value = false
    }
}

// 获取表单类型
const getFormType = (type: string) => {
    switch (type) {
        case 'textarea':
            return 'textarea'
        case 'select':
            return 'select'
        default:
            return 'string'
    }
}

// 获取输入属性
const getInputAttr = (item: any) => {
    const attr: any = {}
    if (item.type === 'textarea') {
        attr.rows = 3
    } else if (item.type === 'select' && item.options) {
        attr.content = item.options
    }
    return attr
}

// 关闭表单
const closeForm = () => {
    emit('update:modelValue', false)
    // 清空配置值
    Object.keys(configValues).forEach(key => delete configValues[key])
}

// 提交表单
const submitForm = async () => {
    submitLoading.value = true
    try {
        emit('success', {
            id: props.channelId,
            config: JSON.stringify(configValues)
        })
        closeForm()
    } catch (err) {
        console.error('保存失败:', err)
        ElMessage.error('保存失败')
    } finally {
        submitLoading.value = false
    }
}
</script>

<style scoped lang="scss">
.dialog-footer {
    padding-top: 20px;
    text-align: right;
}
</style> 