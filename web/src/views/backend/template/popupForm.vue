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
                    <!-- 基本信息 -->
                    <el-divider content-position="left">基本信息</el-divider>
                    <el-row :gutter="20">
                        <el-col :span="12">
                            <FormItem :label="t('template.name')" type="string" v-model="baTable.form.items!.name" prop="name" :placeholder="t('Please input field', { field: t('template.name') })" />
                        </el-col>
                        <el-col :span="12">
                            <FormItem :label="t('template.type')" type="radio" v-model="baTable.form.items!.type" prop="type" :input-attr="{ content: { normal: t('template.type normal'), custom: t('template.type custom') } }" :placeholder="t('Please select field', { field: t('template.type') })" />
                        </el-col>
                    </el-row>
                    <el-row :gutter="20">
                        <el-col :span="12">
                            <FormItem :label="t('template.thumb')" type="image" v-model="baTable.form.items!.thumb" prop="thumb" />
                        </el-col>
                        <el-col :span="12">
                            <FormItem :label="t('template.background')" type="image" v-model="baTable.form.items!.background" prop="background" />
                        </el-col>
                    </el-row>

                    <!-- 二维码设置 -->
                    <el-divider content-position="left">二维码设置</el-divider>
                    <el-row :gutter="20">
                        <el-col :span="12">
                            <FormItem :label="t('template.qrcode_width')" type="number" v-model="baTable.form.items!.qrcode_width" prop="qrcode_width" :input-attr="{ step: 1 }" :placeholder="t('Please input field', { field: t('template.qrcode_width') })" />
                        </el-col>
                        <el-col :span="12">
                            <FormItem :label="t('template.qrcode_height')" type="number" v-model="baTable.form.items!.qrcode_height" prop="qrcode_height" :input-attr="{ step: 1 }" :placeholder="t('Please input field', { field: t('template.qrcode_height') })" />
                        </el-col>
                    </el-row>
                    <el-row :gutter="20">
                        <el-col :span="12">
                            <FormItem :label="t('template.qrcode_x')" type="number" v-model="baTable.form.items!.qrcode_x" prop="qrcode_x" :input-attr="{ step: 1 }" :placeholder="t('Please input field', { field: t('template.qrcode_x') })" />
                        </el-col>
                        <el-col :span="12">
                            <FormItem :label="t('template.qrcode_y')" type="number" v-model="baTable.form.items!.qrcode_y" prop="qrcode_y" :input-attr="{ step: 1 }" :placeholder="t('Please input field', { field: t('template.qrcode_y') })" />
                        </el-col>
                    </el-row>

                    <!-- 字体设置 -->
                    <el-divider content-position="left">字体设置</el-divider>
                    <el-row :gutter="20">
                        <el-col :span="8">
                            <FormItem :label="t('template.font_family')" type="string" v-model="baTable.form.items!.font_family" prop="font_family" :placeholder="t('Please input field', { field: t('template.font_family') })" />
                        </el-col>
                        <el-col :span="8">
                            <FormItem :label="t('template.font_size')" type="number" v-model="baTable.form.items!.font_size" prop="font_size" :input-attr="{ step: 1 }" :placeholder="t('Please input field', { field: t('template.font_size') })" />
                        </el-col>
                        <el-col :span="8">
                            <FormItem :label="t('template.font_color')" type="color" v-model="baTable.form.items!.font_color" prop="font_color" :placeholder="t('Please input field', { field: t('template.font_color') })" />
                        </el-col>
                    </el-row>

                    <!-- 元素位置 -->
                    <el-divider content-position="left">元素位置</el-divider>
                    <el-row :gutter="20">
                        <el-col :span="12">
                            <FormItem :label="t('template.amount_x')" type="number" v-model="baTable.form.items!.amount_x" prop="amount_x" :input-attr="{ step: 1 }" :placeholder="t('Please input field', { field: t('template.amount_x') })" />
                        </el-col>
                        <el-col :span="12">
                            <FormItem :label="t('template.amount_y')" type="number" v-model="baTable.form.items!.amount_y" prop="amount_y" :input-attr="{ step: 1 }" :placeholder="t('Please input field', { field: t('template.amount_y') })" />
                        </el-col>
                    </el-row>
                    <el-row :gutter="20">
                        <el-col :span="12">
                            <FormItem :label="t('template.merchant_x')" type="number" v-model="baTable.form.items!.merchant_x" prop="merchant_x" :input-attr="{ step: 1 }" :placeholder="t('Please input field', { field: t('template.merchant_x') })" />
                        </el-col>
                        <el-col :span="12">
                            <FormItem :label="t('template.merchant_y')" type="number" v-model="baTable.form.items!.merchant_y" prop="merchant_y" :input-attr="{ step: 1 }" :placeholder="t('Please input field', { field: t('template.merchant_y') })" />
                        </el-col>
                    </el-row>
                    <el-row :gutter="20">
                        <el-col :span="12">
                            <FormItem :label="t('template.order_x')" type="number" v-model="baTable.form.items!.order_x" prop="order_x" :input-attr="{ step: 1 }" :placeholder="t('Please input field', { field: t('template.order_x') })" />
                        </el-col>
                        <el-col :span="12">
                            <FormItem :label="t('template.order_y')" type="number" v-model="baTable.form.items!.order_y" prop="order_y" :input-attr="{ step: 1 }" :placeholder="t('Please input field', { field: t('template.order_y') })" />
                        </el-col>
                    </el-row>
                    <el-row :gutter="20">
                        <el-col :span="12">
                            <FormItem :label="t('template.time_x')" type="number" v-model="baTable.form.items!.time_x" prop="time_x" :input-attr="{ step: 1 }" :placeholder="t('Please input field', { field: t('template.time_x') })" />
                        </el-col>
                        <el-col :span="12">
                            <FormItem :label="t('template.time_y')" type="number" v-model="baTable.form.items!.time_y" prop="time_y" :input-attr="{ step: 1 }" :placeholder="t('Please input field', { field: t('template.time_y') })" />
                        </el-col>
                    </el-row>

                    <!-- 其他设置 -->
                    <el-divider content-position="left">其他设置</el-divider>
                    <el-row :gutter="20">
                        <el-col :span="24">
                            <FormItem :label="t('template.extra_config')" type="textarea" v-model="baTable.form.items!.extra_config" prop="extra_config" :input-attr="{ rows: 3 }" @keyup.enter.stop="" @keyup.ctrl.enter="baTable.onSubmit(formRef)" :placeholder="t('Please input field', { field: t('template.extra_config') })" />
                        </el-col>
                    </el-row>
                    <el-row :gutter="20">
                        <el-col :span="12">
                            <FormItem :label="t('template.weigh')" type="number" v-model="baTable.form.items!.weigh" prop="weigh" :input-attr="{ step: 1 }" :placeholder="t('Please input field', { field: t('template.weigh') })" />
                        </el-col>
                        <el-col :span="12">
                            <FormItem :label="t('template.status')" type="radio" v-model="baTable.form.items!.status" prop="status" :input-attr="{ content: { '0': t('template.status 0'), '1': t('template.status 1') } }" :placeholder="t('Please select field', { field: t('template.status') })" />
                        </el-col>
                    </el-row>
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
import { ElDivider } from 'element-plus'
import FormItem from '/@/components/formItem/index.vue'
import { useConfig } from '/@/stores/config'
import type baTableClass from '/@/utils/baTable'
import { buildValidatorData } from '/@/utils/validate'

const config = useConfig()
const formRef = ref<FormInstance>()
const baTable = inject('baTable') as baTableClass

const { t } = useI18n()

const rules: Partial<Record<string, FormItemRule[]>> = reactive({
    qrcode_width: [buildValidatorData({ name: 'number', title: t('template.qrcode_width') })],
    qrcode_height: [buildValidatorData({ name: 'number', title: t('template.qrcode_height') })],
    qrcode_x: [buildValidatorData({ name: 'number', title: t('template.qrcode_x') })],
    qrcode_y: [buildValidatorData({ name: 'number', title: t('template.qrcode_y') })],
    font_size: [buildValidatorData({ name: 'number', title: t('template.font_size') })],
    amount_x: [buildValidatorData({ name: 'number', title: t('template.amount_x') })],
    amount_y: [buildValidatorData({ name: 'number', title: t('template.amount_y') })],
    merchant_x: [buildValidatorData({ name: 'number', title: t('template.merchant_x') })],
    merchant_y: [buildValidatorData({ name: 'number', title: t('template.merchant_y') })],
    order_x: [buildValidatorData({ name: 'number', title: t('template.order_x') })],
    order_y: [buildValidatorData({ name: 'number', title: t('template.order_y') })],
    time_x: [buildValidatorData({ name: 'number', title: t('template.time_x') })],
    time_y: [buildValidatorData({ name: 'number', title: t('template.time_y') })],
    create_time: [buildValidatorData({ name: 'date', title: t('template.create_time') })],
    update_time: [buildValidatorData({ name: 'date', title: t('template.update_time') })],
})
</script>

<style scoped lang="scss">
.el-divider {
    margin: 25px 0;
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

.el-form {
    .el-row {
        margin-bottom: 15px;
        &:last-child {
            margin-bottom: 0;
        }
    }

    .el-divider + .el-row {
        margin-top: 20px;
    }
}

:deep(.el-form-item__content) {
    .ba-input {
        width: 100%;
    }
}

:deep(.el-divider__text) {
    font-size: 15px;
    font-weight: bold;
    color: var(--el-text-color-primary);
}
</style>
