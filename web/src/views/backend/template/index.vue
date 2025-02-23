<template>
    <div class="default-main ba-table-box">
        <el-alert class="ba-table-alert" v-if="baTable.table.remark" :title="baTable.table.remark" type="info" show-icon />

        <!-- 表格顶部菜单 -->
        <!-- 自定义按钮请使用插槽，甚至公共搜索也可以使用具名插槽渲染，参见文档 -->
        <TableHeader
            :buttons="['refresh', 'add', 'edit', 'delete', 'comSearch', 'quickSearch', 'columnDisplay']"
            :quick-search-placeholder="t('Quick search placeholder', { fields: t('template.quick Search Fields') })"
        ></TableHeader>

        <!-- 表格 -->
        <!-- 表格列有多种自定义渲染方式，比如自定义组件、具名插槽等，参见文档 -->
        <!-- 要使用 el-table 组件原有的属性，直接加在 Table 标签上即可 -->
        <Table ref="tableRef"></Table>

        <!-- 表单 -->
        <PopupForm />

        <!-- 预览对话框 -->
        <el-dialog v-model="previewVisible" title="预览模板" width="80%" :before-close="handleClosePreview">
            <PreviewTemplate :template-data="currentTemplate" />
        </el-dialog>
    </div>
</template>

<script setup lang="ts">
import { onMounted, provide, ref } from 'vue'
import { useI18n } from 'vue-i18n'
import PopupForm from './popupForm.vue'
import { baTableApi } from '/@/api/common'
import { defaultOptButtons } from '/@/components/table'
import TableHeader from '/@/components/table/header/index.vue'
import Table from '/@/components/table/index.vue'
import baTableClass from '/@/utils/baTable'
import PreviewTemplate from './previewTemplate.vue'

defineOptions({
    name: 'pay-template',
})

const { t } = useI18n()
const tableRef = ref()
const previewVisible = ref(false)
const currentTemplate = ref<any>(null)

const optButtons: OptButton[] = [
    {
        render: 'tipButton',
        name: 'preview',
        title: '预览模板',
        type: 'primary',
        icon: 'fa fa-eye',
        class: 'table-row-preview',
        click: (row: TableRow) => {
            console.log('Preview row:', row)
            // 确保所有必要的字段都存在
            currentTemplate.value = {
                ...row,
                background: row.background || '',
                qrcode_width: Number(row.qrcode_width) || 200,
                qrcode_height: Number(row.qrcode_height) || 200,
                qrcode_x: Number(row.qrcode_x) || 275,
                qrcode_y: Number(row.qrcode_y) || 400,
                font_family: row.font_family || 'Arial',
                font_size: Number(row.font_size) || 14,
                font_color: row.font_color || '#000000',
                amount_x: Number(row.amount_x) || 375,
                amount_y: Number(row.amount_y) || 300,
                merchant_x: Number(row.merchant_x) || 375,
                merchant_y: Number(row.merchant_y) || 600,
                order_x: Number(row.order_x) || 375,
                order_y: Number(row.order_y) || 650,
                time_x: Number(row.time_x) || 375,
                time_y: Number(row.time_y) || 700,
                status: Number(row.status) || 0
            }
            console.log('Processed template:', currentTemplate.value)
            previewVisible.value = true
        },
    },
    ...defaultOptButtons(['weigh-sort', 'edit', 'delete']),
]

/**
 * baTable 内包含了表格的所有数据且数据具备响应性，然后通过 provide 注入给了后代组件
 */
const baTable = new baTableClass(
    new baTableApi('/admin/Template/'),
    {
        pk: 'id',
        column: [
            { type: 'selection', align: 'center', operator: false, width: 50 },
            { label: t('template.id'), prop: 'id', align: 'center', width: 70, operator: 'RANGE', sortable: 'custom' },
            {
                label: t('template.name'),
                prop: 'name',
                align: 'center',
                width: 150,
                operatorPlaceholder: t('Fuzzy query'),
                operator: 'LIKE',
                sortable: false,
            },
            {
                label: t('template.type'),
                prop: 'type',
                align: 'center',
                width: 100,
                render: 'tag',
                operator: 'eq',
                sortable: false,
                replaceValue: { normal: t('template.type normal'), custom: t('template.type custom') },
            },
            { label: t('template.thumb'), prop: 'thumb', align: 'center', width: 100, render: 'image', operator: false },
            { label: t('template.background'), prop: 'background', align: 'center', width: 100, render: 'image', operator: false },
            { label: t('template.qrcode_width'), prop: 'qrcode_width', align: 'center', width: 100, operator: 'RANGE', sortable: false },
            { label: t('template.qrcode_height'), prop: 'qrcode_height', align: 'center', width: 100, operator: 'RANGE', sortable: false },
            { label: t('template.qrcode_x'), prop: 'qrcode_x', align: 'center', width: 120, operator: 'RANGE', sortable: false },
            { label: t('template.qrcode_y'), prop: 'qrcode_y', align: 'center', width: 120, operator: 'RANGE', sortable: false },
            {
                label: t('template.font_family'),
                prop: 'font_family',
                align: 'center',
                width: 70,
                operatorPlaceholder: t('Fuzzy query'),
                operator: 'LIKE',
                sortable: false,
            },
            { label: t('template.font_size'), prop: 'font_size', align: 'center', width: 70, operator: 'RANGE', sortable: false },
            { label: t('template.font_color'), prop: 'font_color', align: 'center', width: 100, render: 'color', operator: false },
            { label: t('template.amount_x'), prop: 'amount_x', align: 'center', width: 120, operator: 'RANGE', sortable: false },
            { label: t('template.amount_y'), prop: 'amount_y', align: 'center', width: 120, operator: 'RANGE', sortable: false },
            { label: t('template.merchant_x'), prop: 'merchant_x', align: 'center', width: 120, operator: 'RANGE', sortable: false },
            { label: t('template.merchant_y'), prop: 'merchant_y', align: 'center', width: 120, operator: 'RANGE', sortable: false },
            { label: t('template.order_x'), prop: 'order_x', align: 'center', width: 120, operator: 'RANGE', sortable: false },
            { label: t('template.order_y'), prop: 'order_y', align: 'center', width: 120, operator: 'RANGE', sortable: false },
            { label: t('template.time_x'), prop: 'time_x', align: 'center', width: 120, operator: 'RANGE', sortable: false },
            { label: t('template.time_y'), prop: 'time_y', align: 'center', width: 120, operator: 'RANGE', sortable: false },
            { label: t('template.weigh'), prop: 'weigh', align: 'center', width: 80, operator: 'RANGE', sortable: 'custom' },
            {
                label: t('template.status'),
                prop: 'status',
                align: 'center',
                width: 100,
                render: 'switch',
                operator: 'eq',
                sortable: false,
                replaceValue: { '0': t('template.status 0'), '1': t('template.status 1') },
            },
            {
                label: t('template.create_time'),
                prop: 'create_time',
                align: 'center',
                render: 'datetime',
                operator: 'RANGE',
                sortable: 'custom',
                width: 160,
                timeFormat: 'yyyy-mm-dd hh:MM:ss',
            },
            {
                label: t('template.update_time'),
                prop: 'update_time',
                align: 'center',
                render: 'datetime',
                operator: 'RANGE',
                sortable: 'custom',
                width: 160,
                timeFormat: 'yyyy-mm-dd hh:MM:ss',
            },
            { label: t('Operate'), align: 'center', width: 150, render: 'buttons', buttons: optButtons, operator: false },
        ],
        dblClickNotEditColumn: [undefined, 'status'],
        defaultOrder: { prop: 'weigh', order: 'desc' },
    },
    {
        defaultItems: {
            type: 'normal',
            qrcode_width: 200,
            qrcode_height: 200,
            font_family: 'Arial',
            font_size: 12,
            font_color: '#000000',
            status: '1',
        },
    }
)

provide('baTable', baTable)

onMounted(() => {
    baTable.table.ref = tableRef.value
    baTable.mount()
    baTable.getIndex()?.then(() => {
        baTable.initSort()
        baTable.dragSort()
    })
})

const handleClosePreview = () => {
    previewVisible.value = false
    currentTemplate.value = null
}
</script>

<style scoped lang="scss"></style>
