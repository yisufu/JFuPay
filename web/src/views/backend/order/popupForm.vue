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
                    <FormItem :label="t('order.order_no')" type="string" v-model="baTable.form.items!.order_no" prop="order_no" :placeholder="t('Please input field', { field: t('order.order_no') })" />
                    <FormItem :label="t('order.trade_no')" type="string" v-model="baTable.form.items!.trade_no" prop="trade_no" :placeholder="t('Please input field', { field: t('order.trade_no') })" />
                    <FormItem :label="t('order.channel_id')" type="remoteSelect" v-model="baTable.form.items!.channel_id" prop="channel_id" :input-attr="{ pk: 'channel.id', field: 'name', remoteUrl: '/admin/Channel/index' }" :placeholder="t('Please select field', { field: t('order.channel_id') })" />
                    <FormItem :label="t('order.amount')" type="number" v-model="baTable.form.items!.amount" prop="amount" :input-attr="{ step: 1 }" :placeholder="t('Please input field', { field: t('order.amount') })" />
                    <FormItem :label="t('order.currency')" type="string" v-model="baTable.form.items!.currency" prop="currency" :placeholder="t('Please input field', { field: t('order.currency') })" />
                    <FormItem :label="t('order.client_ip')" type="string" v-model="baTable.form.items!.client_ip" prop="client_ip" :placeholder="t('Please input field', { field: t('order.client_ip') })" />
                    <FormItem :label="t('order.device')" type="string" v-model="baTable.form.items!.device" prop="device" :placeholder="t('Please input field', { field: t('order.device') })" />
                    <FormItem :label="t('order.subject')" type="string" v-model="baTable.form.items!.subject" prop="subject" :placeholder="t('Please input field', { field: t('order.subject') })" />
                    <FormItem :label="t('order.body')" type="string" v-model="baTable.form.items!.body" prop="body" :placeholder="t('Please input field', { field: t('order.body') })" />
                    <FormItem :label="t('order.extra')" type="textarea" v-model="baTable.form.items!.extra" prop="extra" :input-attr="{ rows: 3 }" @keyup.enter.stop="" @keyup.ctrl.enter="baTable.onSubmit(formRef)" :placeholder="t('Please input field', { field: t('order.extra') })" />
                    <FormItem :label="t('order.merchant_id')" type="remoteSelect" v-model="baTable.form.items!.merchant_id" prop="merchant_id" :input-attr="{ pk: 'user.id', field: 'username', remoteUrl: '/admin/user.User/index' }" :placeholder="t('Please select field', { field: t('order.merchant_id') })" />
                    <FormItem :label="t('order.merchant_order_no')" type="string" v-model="baTable.form.items!.merchant_order_no" prop="merchant_order_no" :placeholder="t('Please input field', { field: t('order.merchant_order_no') })" />
                    <FormItem :label="t('order.notify_url')" type="string" v-model="baTable.form.items!.notify_url" prop="notify_url" :placeholder="t('Please input field', { field: t('order.notify_url') })" />
                    <FormItem :label="t('order.return_url')" type="string" v-model="baTable.form.items!.return_url" prop="return_url" :placeholder="t('Please input field', { field: t('order.return_url') })" />
                    <FormItem :label="t('order.status')" type="radio" v-model="baTable.form.items!.status" prop="status" :input-attr="{ content: { '0': t('order.status 0'), '1': t('order.status 1'), '2': t('order.status 2'), '3': t('order.status 3'), '4': t('order.status 4') } }" :placeholder="t('Please select field', { field: t('order.status') })" />
                    <FormItem :label="t('order.pay_time')" type="datetime" v-model="baTable.form.items!.pay_time" prop="pay_time" :placeholder="t('Please select field', { field: t('order.pay_time') })" />
                    <FormItem :label="t('order.pay_amount')" type="number" v-model="baTable.form.items!.pay_amount" prop="pay_amount" :input-attr="{ step: 1 }" :placeholder="t('Please input field', { field: t('order.pay_amount') })" />
                    <FormItem :label="t('order.refund_amount')" type="number" v-model="baTable.form.items!.refund_amount" prop="refund_amount" :input-attr="{ step: 1 }" :placeholder="t('Please input field', { field: t('order.refund_amount') })" />
                    <FormItem :label="t('order.notify_time')" type="datetime" v-model="baTable.form.items!.notify_time" prop="notify_time" :placeholder="t('Please select field', { field: t('order.notify_time') })" />
                    <FormItem :label="t('order.notify_status')" type="radio" v-model="baTable.form.items!.notify_status" prop="notify_status" :input-attr="{ content: { '0': t('order.notify_status 0'), '1': t('order.notify_status 1'), '2': t('order.notify_status 2') } }" :placeholder="t('Please select field', { field: t('order.notify_status') })" />
                    <FormItem :label="t('order.notify_count')" type="number" v-model="baTable.form.items!.notify_count" prop="notify_count" :input-attr="{ step: 1 }" :placeholder="t('Please input field', { field: t('order.notify_count') })" />
                    <FormItem :label="t('order.error_msg')" type="string" v-model="baTable.form.items!.error_msg" prop="error_msg" :placeholder="t('Please input field', { field: t('order.error_msg') })" />
                    <FormItem :label="t('order.user_agent')" type="string" v-model="baTable.form.items!.user_agent" prop="user_agent" :placeholder="t('Please input field', { field: t('order.user_agent') })" />
                    <FormItem :label="t('order.source')" type="radio" v-model="baTable.form.items!.source" prop="source" :input-attr="{ content: { '1': t('order.source 1'), '2': t('order.source 2') } }" :placeholder="t('Please select field', { field: t('order.source') })" />
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
import { inject, reactive, ref } from 'vue'
import { useI18n } from 'vue-i18n'
import FormItem from '/@/components/formItem/index.vue'
import { useConfig } from '/@/stores/config'
import type baTableClass from '/@/utils/baTable'
import { buildValidatorData } from '/@/utils/validate'

const config = useConfig()
const formRef = ref<FormInstance>()
const baTable = inject('baTable') as baTableClass

const { t } = useI18n()

const rules: Partial<Record<string, FormItemRule[]>> = reactive({
    amount: [buildValidatorData({ name: 'number', title: t('order.amount') })],
    pay_time: [buildValidatorData({ name: 'date', title: t('order.pay_time') })],
    pay_amount: [buildValidatorData({ name: 'number', title: t('order.pay_amount') })],
    refund_amount: [buildValidatorData({ name: 'number', title: t('order.refund_amount') })],
    notify_time: [buildValidatorData({ name: 'date', title: t('order.notify_time') })],
    notify_count: [buildValidatorData({ name: 'number', title: t('order.notify_count') })],
    create_time: [buildValidatorData({ name: 'date', title: t('order.create_time') })],
    update_time: [buildValidatorData({ name: 'date', title: t('order.update_time') })],
})
</script>

<style scoped lang="scss"></style>
