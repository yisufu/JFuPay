<template>
    <div class="default-main ba-table-box">
        <el-alert class="ba-table-alert" v-if="baTable.table.remark" :title="baTable.table.remark" type="info" show-icon />

        <!-- 表格顶部菜单 -->
        <!-- 自定义按钮请使用插槽，甚至公共搜索也可以使用具名插槽渲染，参见文档 -->
        <TableHeader
            :buttons="['refresh', 'add', 'edit', 'delete', 'comSearch', 'quickSearch', 'columnDisplay']"
            :quick-search-placeholder="t('Quick search placeholder', { fields: t('channel.quick Search Fields') })"
        ></TableHeader>

        <!-- 表格 -->
        <!-- 表格列有多种自定义渲染方式，比如自定义组件、具名插槽等，参见文档 -->
        <!-- 要使用 el-table 组件原有的属性，直接加在 Table 标签上即可 -->
        <Table ref="tableRef"></Table>

        <!-- 表单 -->
        <PopupForm />

        <!-- 配置弹窗 -->
        <ConfigForm
            v-model="configVisible"
            :channel-id="currentRow?.id"
            :plugin-id="currentRow?.plugin_id"
            :config="currentRow?.config"
            @success="handleConfigSuccess"
        />
    </div>
</template>

<script setup lang="ts">
import { onMounted, provide, ref } from 'vue'
import { useI18n } from 'vue-i18n'
import { ElMessage, ElMessageBox } from 'element-plus'
import PopupForm from './popupForm.vue'
import ConfigForm from './configForm.vue'
import { baTableApi } from '/@/api/common'
import { defaultOptButtons } from '/@/components/table'
import TableHeader from '/@/components/table/header/index.vue'
import Table from '/@/components/table/index.vue'
import baTableClass from '/@/utils/baTable'

defineOptions({
    name: 'channel',
})

const { t } = useI18n()
const tableRef = ref()
const configVisible = ref(false)
const currentRow = ref<any>(null)

interface ChannelRow extends TableRow {
    id: number
    name: string
    plugin_id: number
    min_amount: number
    max_amount: number
    priority: number
    status: number
    remark: string
    config: string
    create_time: string
    update_time: string
    plugin?: {
        plugin_name: string
    }
}

const optButtons = [
    {
        render: 'tipButton',
        name: 'edit',
        title: t('Edit'),
        type: 'primary',
        icon: 'fa fa-pencil',
        class: 'table-row-edit',
        click: (row: TableRow) => {
            baTable.toggleForm('Edit', [row.id])
        },
    },
    // {
    //     render: 'tipButton',
    //     name: 'delete',
    //     title: t('Delete'),
    //     type: 'danger',
    //     icon: 'fa fa-trash',
    //     class: 'table-row-delete',
    //     click: (row: TableRow) => {
    //         baTable.toggleForm('Delete', [row.id])
    //     }
    // },
    {
        render: 'tipButton',
        name: 'config',
        title: '配置支付参数',
        type: 'success',
        icon: 'fa fa-cog',
        class: 'table-row-config',
        click: (row: TableRow) => {
            currentRow.value = row
            configVisible.value = true
        },
    },
    // {
    //     render: 'tipButton',
    //     name: 'test',
    //     title: '测试支付',
    //     type: 'warning',
    //     icon: 'fa fa-credit-card',
    //     class: 'table-row-test',
    //     click: (row: TableRow) => {
    //         testPay(row)
    //     }
    // },
    {
        render: 'tipButton',
        name: 'copy',
        title: '复制通道',
        type: 'info',
        icon: 'fa fa-copy',
        class: 'table-row-copy',
        click: (row: TableRow) => {
            copyChannel(row)
        },
    },
] as OptButton[]

/**
 * baTable 内包含了表格的所有数据且数据具备响应性，然后通过 provide 注入给了后代组件
 */
const baTable = new baTableClass(
    new baTableApi('/admin/Channel/'),
    {
        pk: 'id',
        column: [
            { type: 'selection', align: 'center', operator: false },
            { label: t('channel.id'), prop: 'id', align: 'center', width: 70, operator: 'RANGE', sortable: 'custom' },
            { label: t('channel.name'), prop: 'name', align: 'center', operatorPlaceholder: t('Fuzzy query'), operator: 'LIKE', sortable: false },
            {
                label: t('channel.plugin__plugin_name'),
                prop: 'plugin.plugin_name',
                align: 'center',
                operatorPlaceholder: t('Fuzzy query'),
                render: 'tags',
                operator: 'LIKE',
            },
            { label: t('channel.min_amount'), prop: 'min_amount', align: 'center', operator: 'RANGE', sortable: false },
            { label: t('channel.max_amount'), prop: 'max_amount', align: 'center', operator: 'RANGE', sortable: false },
            { label: t('channel.priority'), prop: 'priority', align: 'center', operator: 'RANGE', sortable: false },
            {
                label: t('channel.status'),
                prop: 'status',
                align: 'center',
                render: 'tag',
                operator: 'eq',
                sortable: false,
                replaceValue: { '0': t('channel.status 0'), '1': t('channel.status 1') },
                custom: {
                    '0': 'danger',
                    '1': 'success'
                }
            },
            { label: t('channel.remark'), prop: 'remark', align: 'center', operatorPlaceholder: t('Fuzzy query'), operator: 'LIKE', sortable: false },
            {
                label: t('channel.create_time'),
                prop: 'create_time',
                align: 'center',
                render: 'datetime',
                operator: 'RANGE',
                sortable: 'custom',
                width: 160,
                timeFormat: 'yyyy-mm-dd hh:MM:ss',
            },
            { label: t('Operate'), align: 'center', width: 200, render: 'buttons', buttons: optButtons, operator: false },
        ],
        dblClickNotEditColumn: [undefined],
    },
    {
        defaultItems: { status: '1' },
    }
)

provide('baTable', baTable)

// 处理配置保存成功
const handleConfigSuccess = (data: any) => {
    baTable.form.operate = 'Edit'
    baTable.form.operateIds = [data.id]
    baTable.form.items = { ...currentRow.value, config: data.config }
    baTable.onSubmit()
}

// 测试支付
const testPay = async (row: TableRow) => {
    try {
        const res = await baTable.api.postData('testPay', { id: row.id })
        if (res.code === 1) {
            ElMessage.success('测试支付请求成功')
        }
    } catch (err) {
        console.error('测试支付失败:', err)
    }
}

// 复制通道
const copyChannel = (row: TableRow) => {
    ElMessageBox.prompt('请输入新的通道名称', '复制通道', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        inputPattern: /\S+/,
        inputErrorMessage: '通道名称不能为空',
        inputValue: row.name + '_复制',
    })
        .then(({ value: newName }) => {
            // 创建新的通道数据
            const newData = {
                name: newName,
                plugin_id: row.plugin_id,
                config: row.config,
                min_amount: row.min_amount,
                max_amount: row.max_amount,
                priority: row.priority,
                status: row.status,
                remark: row.remark,
            }

            // 使用 baTable 的 API 创建新记录
            baTable.api
                .postData('add', newData)
                .then((res) => {
                    if (res.code === 1) {
                        ElMessage.success('复制成功')
                        // 刷新表格数据
                        baTable.getIndex()
                    } else {
                        ElMessage.error(res.msg || '复制失败')
                    }
                })
                .catch((err) => {
                    console.error('复制通道失败:', err)
                    ElMessage.error('复制失败')
                })
        })
        .catch(() => {
            // 用户取消操作
        })
}

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
