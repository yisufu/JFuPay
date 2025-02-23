<template>
    <div class="default-main ba-table-box">
        <el-alert class="ba-table-alert" v-if="baTable.table.remark" :title="baTable.table.remark" type="info" show-icon />

        <!-- 表格顶部菜单 -->
        <!-- 自定义按钮请使用插槽，甚至公共搜索也可以使用具名插槽渲染，参见文档 -->
        <TableHeader
            :buttons="['refresh', 'add', 'edit', 'delete', 'comSearch', 'quickSearch', 'columnDisplay']"
            :quick-search-placeholder="t('Quick search placeholder', { fields: t('qrcode.quick Search Fields') })"
        ></TableHeader>

        <!-- 表格 -->
        <!-- 表格列有多种自定义渲染方式，比如自定义组件、具名插槽等，参见文档 -->
        <!-- 要使用 el-table 组件原有的属性，直接加在 Table 标签上即可 -->
        <Table ref="tableRef"></Table>

        <!-- 表单 -->
        <PopupForm />

        <!-- 收款码预览对话框 -->
        <PreviewQrcode
            v-model="showQrcodePreview"
            :qrcode-data="currentQrcode"
        />

        <!-- 收银台预览对话框 -->
        <PreviewCashier
            v-model="showCashierPreview"
            :cashier-data="currentQrcode"
        />
    </div>
</template>

<script setup lang="ts">
import { onMounted, provide, ref } from 'vue'
import { useI18n } from 'vue-i18n'
import PopupForm from './popupForm.vue'
import PreviewQrcode from './previewQrcode.vue'
import PreviewCashier from './previewCashier.vue'
import { baTableApi } from '/@/api/common'
import { defaultOptButtons } from '/@/components/table'
import TableHeader from '/@/components/table/header/index.vue'
import Table from '/@/components/table/index.vue'
import baTableClass from '/@/utils/baTable'

defineOptions({
    name: 'qrcode',
})

const { t } = useI18n()
const tableRef = ref()
const showQrcodePreview = ref(false)
const currentQrcode = ref<any>(null)
const showCashierPreview = ref(false)

// 预览收款码
const previewQrcode = (row: TableRow) => {
    currentQrcode.value = row
    showQrcodePreview.value = true
}

// 显示收银台信息
const showCashierInfo = (row: TableRow) => {
    currentQrcode.value = row
    showCashierPreview.value = true
}

const optButtons: OptButton[] = [
    {
        render: 'tipButton',
        name: 'qrcode',
        title: '生成收款码',
        type: 'success',
        icon: 'fa fa-qrcode',
        class: 'table-row-qrcode',
        click: (row: TableRow) => {
            previewQrcode(row)
        }
    },
    {
        render: 'tipButton',
        name: 'cashier',
        title: '生成收银台',
        type: 'primary',
        icon: 'fa fa-link',
        class: 'table-row-cashier',
        click: (row: TableRow) => {
            showCashierInfo(row)
        }
    },
    ...defaultOptButtons(['weigh-sort', 'edit', 'delete'])
]

/**
 * baTable 内包含了表格的所有数据且数据具备响应性，然后通过 provide 注入给了后代组件
 */
const baTable = new baTableClass(
    new baTableApi('/admin/Qrcode/'),
    {
        pk: 'id',
        column: [
            { type: 'selection', align: 'center', operator: false },
            { label: t('qrcode.id'), prop: 'id', align: 'center', width: 70, operator: 'RANGE', sortable: 'custom' },
            {
                label: t('qrcode.name'),
                prop: 'name',
                align: 'center',
                width: 120,
                operatorPlaceholder: t('Fuzzy query'),
                operator: 'LIKE',
                sortable: false,
            },
            //{ label: t('qrcode.template_id'), prop: 'template_id', align: 'center', operatorPlaceholder: t('Fuzzy query'), operator: 'LIKE' },
            //{ label: t('qrcode.template__name'), prop: 'template.name', align: 'center', operatorPlaceholder: t('Fuzzy query'), render: 'tags', operator: 'LIKE' },
            { label: t('qrcode.merchant_id'), prop: 'merchant_id', align: 'center', operatorPlaceholder: t('Fuzzy query'), operator: 'LIKE' },
            {
                label: t('qrcode.merchant__username'),
                prop: 'merchant.username',
                align: 'center',
                operatorPlaceholder: t('Fuzzy query'),
                render: 'tags',
                operator: 'LIKE',
            },
            //{ label: t('qrcode.channel'), prop: 'channel', align: 'center', operatorPlaceholder: t('Fuzzy query'), operator: 'LIKE' },
            { label: t('qrcode.channeltable__name'), prop: 'channelTable.name', align: 'center', width: 120, render: 'tags', operator: false },
            {
                label: t('qrcode.channeltable__name'),
                prop: 'channel',
                align: 'center',
                operator: 'FIND_IN_SET',
                show: false,
                comSearchRender: 'remoteSelect',
                remote: { pk: 'channel.id', field: 'name', remoteUrl: '/admin/Channel/index', multiple: true },
            },
            { label: t('qrcode.min_amount'), prop: 'min_amount', align: 'center', width: 100, operator: 'RANGE', sortable: false },
            { label: t('qrcode.max_amount'), prop: 'max_amount', align: 'center', width: 100, operator: 'RANGE', sortable: false },
           // { label: t('qrcode.fixed_amount'), prop: 'fixed_amount', align: 'center', width: 150, operator: 'RANGE', sortable: false },
            { label: t('qrcode.remark'), prop: 'remark', align: 'center', operatorPlaceholder: t('Fuzzy query'), operator: 'LIKE', sortable: false },
            {
                label: t('qrcode.status'),
                prop: 'status',
                align: 'center',
                render: 'tag',
                operator: 'eq',
                sortable: false,
                replaceValue: { '0': t('qrcode.status 0'), '1': t('qrcode.status 1') },
            },
            {
                label: t('qrcode.create_time'),
                prop: 'create_time',
                align: 'center',
                render: 'datetime',
                operator: 'RANGE',
                sortable: 'custom',
                width: 160,
                timeFormat: 'yyyy-mm-dd hh:MM:ss',
            },
            {
                label: t('qrcode.update_time'),
                prop: 'update_time',
                align: 'center',
                render: 'datetime',
                operator: 'RANGE',
                sortable: 'custom',
                width: 160,
                timeFormat: 'yyyy-mm-dd hh:MM:ss',
            },
            { label: t('Operate'), align: 'center', width: 170, render: 'buttons', buttons: optButtons, operator: false },
        ],
        dblClickNotEditColumn: [undefined],
        defaultOrder: { prop: 'weigh', order: 'desc' },
    },
    {
        defaultItems: { expired_time: '0', status: '1' },
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
</script>

<style scoped lang="scss"></style>
