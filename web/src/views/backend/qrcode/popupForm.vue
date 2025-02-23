<template>
    <!-- 对话框表单 -->
    <!-- 建议使用 Prettier 格式化代码 -->
    <!-- el-form 内可以混用 el-form-item、FormItem、ba-input 等输入组件 -->
    <el-dialog
        class="ba-operate-dialog"
        :close-on-click-modal="false"
        :model-value="['Add', 'Edit'].includes(baTable.form.operate!)"
        @close="baTable.toggleForm"
        width="50%"
    >
        <template #header>
            <div class="title" v-drag="['.ba-operate-dialog', '.el-dialog__header']" v-zoom="'.ba-operate-dialog'">
                {{ baTable.form.operate ? t(baTable.form.operate) : '' }}
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
                    <FormItem :label="t('qrcode.name')" type="string" v-model="baTable.form.items!.name" prop="name" :placeholder="t('Please input field', { field: t('qrcode.name') })" />
                    
                    <!-- UUID字段 -->
                    <FormItem 
                        :label="t('qrcode.uuid')" 
                        type="string" 
                        v-model="baTable.form.items!.uuid" 
                        prop="uuid" 
                        :placeholder="t('Please input field', { field: t('qrcode.uuid') })"
                    >
                        <template #append>
                            <el-button type="primary" @click="generateUUID">生成</el-button>
                        </template>
                    </FormItem>

                    <!-- 暂时隐藏模板ID -->
                    <!-- <FormItem :label="t('qrcode.template_id')" type="remoteSelect" v-model="baTable.form.items!.template_id" prop="template_id" :input-attr="{ pk: 'template.id', field: 'name', remoteUrl: '/admin/Template/index' }" :placeholder="t('Please select field', { field: t('qrcode.template_id') })" /> -->
                    
                    <FormItem :label="t('qrcode.merchant_id')" type="remoteSelect" v-model="baTable.form.items!.merchant_id" prop="merchant_id" :input-attr="{ pk: 'user.id', field: 'username', remoteUrl: '/admin/user.User/index' }" :placeholder="t('Please select field', { field: t('qrcode.merchant_id') })" />
                    <FormItem :label="t('qrcode.channel')" type="remoteSelects" v-model="baTable.form.items!.channel" prop="channel" :input-attr="{ pk: 'channel.id', field: 'name', remoteUrl: '/admin/Channel/index' }" :placeholder="t('Please select field', { field: t('qrcode.channel') })" />
                    <FormItem :label="t('qrcode.min_amount')" type="number" v-model="baTable.form.items!.min_amount" prop="min_amount" :input-attr="{ step: 1 }" :placeholder="t('Please input field', { field: t('qrcode.min_amount') })" />
                    <FormItem :label="t('qrcode.max_amount')" type="number" v-model="baTable.form.items!.max_amount" prop="max_amount" :input-attr="{ step: 1 }" :placeholder="t('Please input field', { field: t('qrcode.max_amount') })" />
                    <FormItem :label="t('qrcode.fixed_amount')" type="number" v-model="baTable.form.items!.fixed_amount" prop="fixed_amount" :input-attr="{ step: 1 }" :placeholder="t('Please input field', { field: t('qrcode.fixed_amount') })" />
                    <FormItem :label="t('qrcode.expired_time')" type="datetime" v-model="baTable.form.items!.expired_time" prop="expired_time" :placeholder="t('Please select field', { field: t('qrcode.expired_time') })" />
                    <FormItem :label="t('qrcode.notify_url')" type="string" v-model="baTable.form.items!.notify_url" prop="notify_url" :placeholder="t('Please input field', { field: t('qrcode.notify_url') })" />
                    <FormItem :label="t('qrcode.return_url')" type="string" v-model="baTable.form.items!.return_url" prop="return_url" :placeholder="t('Please input field', { field: t('qrcode.return_url') })" />
                    <FormItem :label="t('qrcode.remark')" type="string" v-model="baTable.form.items!.remark" prop="remark" :placeholder="t('Please input field', { field: t('qrcode.remark') })" />
                    <FormItem :label="t('qrcode.status')" type="radio" v-model="baTable.form.items!.status" prop="status" :input-attr="{ content: { '0': t('qrcode.status 0'), '1': t('qrcode.status 1') } }" :placeholder="t('Please select field', { field: t('qrcode.status') })" />
                    <FormItem :label="t('qrcode.weigh')" type="number" v-model="baTable.form.items!.weigh" prop="weigh" :input-attr="{ step: 1 }" :placeholder="t('Please input field', { field: t('qrcode.weigh') })" />
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

    <!-- 收款码预览对话框 -->
    <PreviewQrcode
        v-model="showQrcodePreview"
        :qrcode-data="baTable.form.items"
    />
</template>

<script setup lang="ts">
import type { FormInstance, FormItemRule } from 'element-plus'
import { inject, reactive, ref } from 'vue'
import { useI18n } from 'vue-i18n'
import FormItem from '/@/components/formItem/index.vue'
import { useConfig } from '/@/stores/config'
import type baTableClass from '/@/utils/baTable'
import { buildValidatorData } from '/@/utils/validate'
import { ElMessage } from 'element-plus'
import { uuid } from '/@/utils/random'
import PreviewQrcode from './previewQrcode.vue'

const config = useConfig()
const formRef = ref<FormInstance>()
const baTable = inject('baTable') as baTableClass
const showQrcodePreview = ref(false)

const { t } = useI18n()

// 生成UUID函数
const generateUUID = () => {
    baTable.form.items!.uuid = uuid()
}

// 预览收款码
const previewQrcode = () => {
    if (!baTable.form.items?.uuid) {
        ElMessage.warning('请先生成UUID')
        return
    }
    showQrcodePreview.value = true
}

const rules: Partial<Record<string, FormItemRule[]>> = reactive({
    name: [buildValidatorData({ name: 'required', title: t('qrcode.name') })],
    uuid: [buildValidatorData({ name: 'required', title: t('qrcode.uuid') })],
    min_amount: [buildValidatorData({ name: 'number', title: t('qrcode.min_amount') })],
    max_amount: [buildValidatorData({ name: 'number', title: t('qrcode.max_amount') })],
    fixed_amount: [buildValidatorData({ name: 'number', title: t('qrcode.fixed_amount') })],
    expired_time: [buildValidatorData({ name: 'date', title: t('qrcode.expired_time') })],
    create_time: [buildValidatorData({ name: 'date', title: t('qrcode.create_time') })],
    update_time: [buildValidatorData({ name: 'date', title: t('qrcode.update_time') })],
})
</script>

<style scoped lang="scss">
// 删除旧的样式
</style>
