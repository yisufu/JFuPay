<template>
    <!-- 对话框表单 -->
    <!-- 建议使用 Prettier 格式化代码 -->
    <!-- el-form 内可以混用 el-form-item、FormItem、ba-input 等输入组件 -->
    <el-dialog
        class="ba-operate-dialog"
        :close-on-click-modal="false"
        :model-value="['Add', 'Edit', 'Config'].includes(baTable.form.operate!)"
        @close="baTable.toggleForm"
        width="50%"
    >
        <template #header>
            <div class="title" v-drag="['.ba-operate-dialog', '.el-dialog__header']" v-zoom="'.ba-operate-dialog'">
                {{ baTable.form.operate === 'Config' ? '配置支付参数' : (baTable.form.operate ? t(baTable.form.operate) : '') }}
            </div>
        </template>
        <el-scrollbar v-loading="baTable.form.loading" class="ba-table-form-scrollbar">
            <div
                class="ba-operate-form"
                :class="'ba-' + baTable.form.operate + '-form'"
                :style="config.layout.shrink ? '':'width: calc(100% - ' + baTable.form.labelWidth! / 2 + 'px)'"
            >
                <el-form
                    v-if="!baTable.form.loading"
                    ref="formRef"
                    @submit.prevent=""
                    @keyup.enter="baTable.onSubmit(formRef)"
                    :model="baTable.form.items"
                    :label-position="config.layout.shrink ? 'top' : 'right'"
                    :label-width="baTable.form.labelWidth + 'px'"
                    :rules="rules"
                >
                    <!-- 添加模式显示基本信息 -->
                    <template v-if="baTable.form.operate === 'Add'">
                        <el-alert
                            type="info"
                            :closable="false"
                            show-icon
                            style="margin-bottom: 20px;"
                        >
                            <p>请先添加基本参数，保存后在右侧操作栏配置支付参数</p>
                        </el-alert>
                        <FormItem :label="t('channel.name')" type="string" v-model="baTable.form.items!.name" prop="name" :placeholder="t('Please input field', { field: t('channel.name') })" />
                        <FormItem 
                            :label="t('channel.plugin_id')" 
                            type="remoteSelect" 
                            v-model="baTable.form.items!.plugin_id" 
                            prop="plugin_id" 
                            :input-attr="{ 
                                pk: 'plugins.id', 
                                field: 'plugin_name', 
                                remoteUrl: '/admin/Plugins/index'
                            }" 
                            :placeholder="t('Please select field', { field: t('channel.plugin_id') })" 
                        />
                        <FormItem :label="t('channel.min_amount')" type="number" v-model="baTable.form.items!.min_amount" prop="min_amount" :input-attr="{ step: 0.01, precision: 2 }" :placeholder="t('Please input field', { field: t('channel.min_amount') })" />
                        <FormItem :label="t('channel.max_amount')" type="number" v-model="baTable.form.items!.max_amount" prop="max_amount" :input-attr="{ step: 0.01, precision: 2 }" :placeholder="t('Please input field', { field: t('channel.max_amount') })" />
                        <FormItem :label="t('channel.priority')" type="number" v-model="baTable.form.items!.priority" prop="priority" :input-attr="{ step: 1 }" :placeholder="t('Please input field', { field: t('channel.priority') })" />
                        <FormItem :label="t('channel.status')" type="radio" v-model="baTable.form.items!.status" prop="status" :input-attr="{ content: { '0': t('channel.status 0'), '1': t('channel.status 1') } }" :placeholder="t('Please select field', { field: t('channel.status') })" />
                        <FormItem :label="t('channel.remark')" type="string" v-model="baTable.form.items!.remark" prop="remark" :placeholder="t('Please input field', { field: t('channel.remark') })" />
                    </template>

                    <!-- 配置模式显示支付参数配置 -->
                    <template v-if="baTable.form.operate === 'Config'">
                        <template v-if="pluginConfig.inputs">
                            <div v-for="(item, key) in pluginConfig.inputs" :key="key">
                                <FormItem 
                                    :label="item.name" 
                                    :type="getFormType(item.type)" 
                                    v-model="configValues[key]" 
                                    :prop="'config.' + key"
                                    :input-attr="getInputAttr(item)"
                                    :placeholder="item.note || t('Please input field', { field: item.name })"
                                />
                            </div>
                        </template>
                    </template>

                    <!-- 编辑模式显示所有字段 -->
                    <template v-if="baTable.form.operate === 'Edit'">
                        <FormItem :label="t('channel.name')" type="string" v-model="baTable.form.items!.name" prop="name" :placeholder="t('Please input field', { field: t('channel.name') })" />
                        <FormItem 
                            :label="t('channel.plugin_id')" 
                            type="remoteSelect" 
                            v-model="baTable.form.items!.plugin_id" 
                            prop="plugin_id" 
                            :input-attr="{ 
                                pk: 'plugins.id', 
                                field: 'plugin_name', 
                                remoteUrl: '/admin/Plugins/index',
                                onChange: handlePluginChange 
                            }" 
                            :placeholder="t('Please select field', { field: t('channel.plugin_id') })" 
                        />
                        <!-- <template v-if="pluginConfig.inputs">
                            <el-divider content-position="left">支付参数配置</el-divider>
                            <div v-for="(item, key) in pluginConfig.inputs" :key="key">
                                <FormItem 
                                    :label="item.name" 
                                    :type="getFormType(item.type)" 
                                    v-model="configValues[key]" 
                                    :prop="'config.' + key"
                                    :input-attr="getInputAttr(item)"
                                    :placeholder="item.note || t('Please input field', { field: item.name })"
                                />
                            </div>
                        </template> -->
                      
                        <FormItem :label="t('channel.min_amount')" type="number" v-model="baTable.form.items!.min_amount" prop="min_amount" :input-attr="{ step: 0.01, precision: 2 }" :placeholder="t('Please input field', { field: t('channel.min_amount') })" />
                        <FormItem :label="t('channel.max_amount')" type="number" v-model="baTable.form.items!.max_amount" prop="max_amount" :input-attr="{ step: 0.01, precision: 2 }" :placeholder="t('Please input field', { field: t('channel.max_amount') })" />
                        <FormItem :label="t('channel.priority')" type="number" v-model="baTable.form.items!.priority" prop="priority" :input-attr="{ step: 1 }" :placeholder="t('Please input field', { field: t('channel.priority') })" />
                        <FormItem :label="t('channel.status')" type="radio" v-model="baTable.form.items!.status" prop="status" :input-attr="{ content: { '0': t('channel.status 0'), '1': t('channel.status 1') } }" :placeholder="t('Please select field', { field: t('channel.status') })" />
                        <FormItem :label="t('channel.remark')" type="string" v-model="baTable.form.items!.remark" prop="remark" :placeholder="t('Please input field', { field: t('channel.remark') })" />
                    </template>
                </el-form>
            </div>
        </el-scrollbar>
        <template #footer>
            <div :style="'width: calc(100% - ' + baTable.form.labelWidth! / 1.8 + 'px)'">
                <el-button @click="baTable.toggleForm()">{{ t('Cancel') }}</el-button>
                <el-button v-blur :loading="baTable.form.submitLoading" @click="baTable.onSubmit(formRef)" type="primary">
                    {{ baTable.form.operateIds && baTable.form.operateIds.length > 1 ? t('Save and edit next item') : t('Save') }}
                </el-button>
            </div>
        </template>
    </el-dialog>
</template>

<script setup lang="ts">
import type { FormInstance, FormItemRule } from 'element-plus'
import { inject, reactive, ref, watch } from 'vue'
import { useI18n } from 'vue-i18n'
import { ElDivider } from 'element-plus'
import FormItem from '/@/components/formItem/index.vue'
import { useConfig } from '/@/stores/config'
import type baTableClass from '/@/utils/baTable'
import { buildValidatorData } from '/@/utils/validate'
import { getPluginConfig } from '/@/api/backend/pay'

const config = useConfig()
const formRef = ref<FormInstance>()
const baTable = inject('baTable') as baTableClass
const { t } = useI18n()

// 插件配置信息
const pluginConfig = ref<any>({})
// 配置值
const configValues = reactive<any>({})

// 监听配置值变化，同步到form.items.config
watch(configValues, (newVal) => {
    baTable.form.items!.config = JSON.stringify(newVal)
}, { deep: true })

// 监听编辑状态，如果是编辑则解析已有配置
watch(() => baTable.form.items?.config, (newVal) => {
    if (newVal) {
        try {
            Object.assign(configValues, JSON.parse(newVal))
        } catch (e) {
            console.error('解析配置失败:', e)
        }
    }
}, { immediate: true })

// 处理插件选择变化
const handlePluginChange = async (id: number) => {
    if (!id) return
    try {
        const res = await getPluginConfig(id)
        pluginConfig.value = res.data.info || {}
        // 清空之前的配置
        Object.keys(configValues).forEach(key => delete configValues[key])
    } catch (err) {
        console.error('获取插件配置失败:', err)
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

const rules: Partial<Record<string, FormItemRule[]>> = reactive({
    name: [buildValidatorData({ name: 'required', title: t('channel.name') })],
    plugin_id: [buildValidatorData({ name: 'required', title: t('channel.plugin_id') })],
    min_amount: [buildValidatorData({ name: 'number', title: t('channel.min_amount') })],
    max_amount: [buildValidatorData({ name: 'number', title: t('channel.max_amount') })],
    priority: [buildValidatorData({ name: 'number', title: t('channel.priority') })],
})
</script>

<style scoped lang="scss">
.el-divider {
    margin: 20px 0;
    &::before {
        content: '';
        width: 4px;
        height: 14px;
        background: var(--el-color-primary);
        margin-right: 8px;
        display: inline-block;
        vertical-align: middle;
    }
}
</style>
