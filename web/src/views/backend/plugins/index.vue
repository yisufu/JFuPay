<template>
    <div class="default-main ba-table-box">
        <el-alert class="ba-table-alert" v-if="baTable.table.remark" :title="baTable.table.remark" type="info" show-icon />

        <!-- 表格顶部菜单 -->
        <!-- 自定义按钮请使用插槽，甚至公共搜索也可以使用具名插槽渲染，参见文档 -->
        <TableHeader
            :buttons="['refresh', 'add', 'edit', 'delete', 'comSearch', 'quickSearch', 'columnDisplay']"
            :quick-search-placeholder="t('Quick search placeholder', { fields: t('plugins.quick Search Fields') })"
        >
          
                <el-button v-blur class="table-header-operate" type="primary" @click="syncPlugins">
                    <Icon color="#ffffff" name="fa fa-refresh" />
                    <span class="table-header-operate-text">{{ t('同步插件') }}</span>
                </el-button>
           
        </TableHeader>

        <!-- 表格 -->
        <!-- 表格列有多种自定义渲染方式，比如自定义组件、具名插槽等，参见文档 -->
        <!-- 要使用 el-table 组件原有的属性，直接加在 Table 标签上即可 -->
        <Table ref="tableRef"></Table>

        <!-- 表单 -->
        <PopupForm />
    </div>
</template>

<script setup lang="ts">
import { onMounted, provide, ref } from 'vue'
import { useI18n } from 'vue-i18n'
import { ElMessage } from 'element-plus'
import PopupForm from './popupForm.vue'
import { baTableApi } from '/@/api/common'
import { defaultOptButtons } from '/@/components/table'
import TableHeader from '/@/components/table/header/index.vue'
import Table from '/@/components/table/index.vue'
import baTableClass from '/@/utils/baTable'

defineOptions({
    name: 'plugins',
})

const { t } = useI18n()
const tableRef = ref()
const optButtons: OptButton[] = defaultOptButtons(['edit', 'delete'])

/**
 * baTable 内包含了表格的所有数据且数据具备响应性，然后通过 provide 注入给了后代组件
 */
const baTable = new baTableClass(
    new baTableApi('/admin/Plugins/'),
    {
        pk: 'id',
        column: [
            { type: 'selection', align: 'center', operator: false },
            { label: t('plugins.id'), prop: 'id', align: 'center', width: 70, operator: 'RANGE', sortable: 'custom' },
            { label: t('plugins.plugin_name'), prop: 'plugin_name', align: 'center', operatorPlaceholder: t('Fuzzy query'), operator: 'LIKE', sortable: false },
            { label: t('plugins.class_name'), prop: 'class_name', align: 'center', operatorPlaceholder: t('Fuzzy query'), operator: 'LIKE', sortable: false },
            { label: t('plugins.author'), prop: 'author', align: 'center', operatorPlaceholder: t('Fuzzy query'), operator: 'LIKE', sortable: false },
            { label: t('plugins.status'), prop: 'status', align: 'center', render: 'switch', operator: 'eq', sortable: false, replaceValue: { '0': t('plugins.status 0'), '1': t('plugins.status 1') } },
            { label: t('plugins.update_time'), prop: 'update_time', align: 'center', render: 'datetime', operator: 'RANGE', sortable: 'custom', width: 160, timeFormat: 'yyyy-mm-dd hh:MM:ss' },
            { label: t('plugins.create_time'), prop: 'create_time', align: 'center', render: 'datetime', operator: 'RANGE', sortable: 'custom', width: 160, timeFormat: 'yyyy-mm-dd hh:MM:ss' },
            { label: t('Operate'), align: 'center', width: 100, render: 'buttons', buttons: optButtons, operator: false },
        ],
        dblClickNotEditColumn: [undefined, 'status'],
    },
    {
        defaultItems: { status: '1' },
    }
)

provide('baTable', baTable)

const syncPlugins = () => {
    baTable.api
        .postData('syncLocalPlugins', {})
        .then((res: ApiResponse) => {
            baTable.getIndex()
        })
        .catch((err) => {
            console.error(err)
            ElMessage.error('同步失败')
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

<style scoped lang="scss">
.table-header-operate {
    margin-left: 12px;
}
</style>
