import { ElNotification } from 'element-plus'
import { defineStore } from 'pinia'
import { nextTick, reactive } from 'vue'
import { buildTerminalUrl } from '/@/api/common'
import { i18n } from '/@/lang/index'
import { STORE_TERMINAL } from '/@/stores/constant/cacheKey'
import { taskStatus } from '/@/stores/constant/terminalTaskStatus'
import type { Terminal } from '/@/stores/interface/index'
import { timeFormat } from '/@/utils/common'
import { uuid } from '/@/utils/random'
import { closeHotUpdate, openHotUpdate } from '/@/utils/vite'

export const useTerminal = defineStore(
    'terminal',
    () => {
        const state: Terminal = reactive({
            show: false,
            showDot: false,
            taskList: [],
            packageManager: 'pnpm',
            showConfig: false,
            automaticCleanupTask: '1',
            phpDevelopmentServer: false,
            npmRegistry: 'unknown',
            composerRegistry: 'unknown',
        })

        function init() {
            for (const key in state.taskList) {
                if (state.taskList[key].status == taskStatus.Connecting || state.taskList[key].status == taskStatus.Executing) {
                    state.taskList[key].status = taskStatus.Unknown
                }
            }
        }

        function toggle(val = !state.show) {
            state.show = val
            if (val) {
                toggleDot(false)
            }
        }

        function toggleDot(val = !state.showDot) {
            state.showDot = val
        }

        function toggleConfigDialog(val = !state.showConfig) {
            toggle(!val)
            state.showConfig = val
        }

        function changeRegistry(val: string, type: 'npm' | 'composer') {
            state[type == 'npm' ? 'npmRegistry' : 'composerRegistry'] = val
        }

        function changePackageManager(val: string) {
            state.packageManager = val
        }

        function changePHPDevelopmentServer(val: boolean) {
            state.phpDevelopmentServer = val
        }

        function changeAutomaticCleanupTask(val: '0' | '1') {
            state.automaticCleanupTask = val
        }

        function setTaskStatus(idx: number, status: number) {
            state.taskList[idx].status = status
            if ((status == taskStatus.Failed || status == taskStatus.Unknown) && state.taskList[idx].blockOnFailure) {
                setTaskShowMessage(idx, true)
            }
        }

        function taskCompleted(idx: number) {
            // 命令执行完毕，重新打开热更新
            openHotUpdate('terminal')

            if (typeof state.taskList[idx].callback != 'function') return

            const status = state.taskList[idx].status
            if (status == taskStatus.Failed || status == taskStatus.Unknown) {
                state.taskList[idx].callback(taskStatus.Failed)
            } else if (status == taskStatus.Success) {
                state.taskList[idx].callback(taskStatus.Success)
            }
        }

        function setTaskShowMessage(idx: number, val = !state.taskList[idx].showMessage) {
            state.taskList[idx].showMessage = val
        }

        function addTaskMessage(idx: number, message: string) {
            if (!state.show) toggleDot(true)
            state.taskList[idx].message = state.taskList[idx].message.concat(message)
            nextTick(() => {
                execMessageScrollbarKeep(state.taskList[idx].uuid)
            })
        }

        function addTask(command: string, blockOnFailure = true, extend = '', callback: Function = () => {}) {
            if (!state.show) toggleDot(true)
            state.taskList = state.taskList.concat({
                uuid: uuid(),
                createTime: timeFormat(),
                status: taskStatus.Waiting,
                command: command,
                message: [],
                showMessage: false,
                blockOnFailure: blockOnFailure,
                extend: extend,
                callback: callback,
            })

            // 清理任务列表
            if (parseInt(state.automaticCleanupTask) === 1) {
                clearSuccessTask()
            }

            // 检查是否有已经失败的任务
            if (state.show === false) {
                for (const key in state.taskList) {
                    if (state.taskList[key].status == taskStatus.Failed || state.taskList[key].status == taskStatus.Unknown) {
                        ElNotification({
                            type: 'error',
                            message: i18n.global.t('terminal.Newly added tasks will never start because they are blocked by failed tasks'),
                            zIndex: 9999,
                        })
                        break
                    }
                }
            }

            startTask()
        }

        function addTaskPM(command: string, blockOnFailure = true, extend = '', callback: Function = () => {}) {
            addTask(command + '.' + state.packageManager, blockOnFailure, extend, callback)
        }

        function delTask(idx: number) {
            if (state.taskList[idx].status != taskStatus.Connecting && state.taskList[idx].status != taskStatus.Executing) {
                state.taskList.splice(idx, 1)
            }
            startTask()
        }

        function startTask() {
            let taskKey = null

            // 寻找可以开始执行的命令
            for (const key in state.taskList) {
                if (state.taskList[key].status == taskStatus.Waiting) {
                    taskKey = parseInt(key)
                    break
                }
                if (state.taskList[key].status == taskStatus.Connecting || state.taskList[key].status == taskStatus.Executing) {
                    break
                }
                if (state.taskList[key].status == taskStatus.Success) {
                    continue
                }
                if (state.taskList[key].status == taskStatus.Failed || state.taskList[key].status == taskStatus.Unknown) {
                    if (state.taskList[key].blockOnFailure) {
                        break
                    } else {
                        continue
                    }
                }
            }
            if (taskKey !== null) {
                setTaskStatus(taskKey, taskStatus.Connecting)
                startEventSource(taskKey)
            }
        }

        function startEventSource(taskKey: number) {
            // 命令执行期间禁用热更新
            closeHotUpdate('terminal')

            window.eventSource = new EventSource(
                buildTerminalUrl(state.taskList[taskKey].command, state.taskList[taskKey].uuid, state.taskList[taskKey].extend)
            )
            window.eventSource.onmessage = function (e) {
                const data = JSON.parse(e.data)
                if (!data || !data.data) {
                    return
                }

                const taskIdx = findTaskIdxFromUuid(data.uuid)
                if (taskIdx === false) {
                    return
                }

                if (data.data == 'command-exec-error') {
                    setTaskStatus(taskIdx, taskStatus.Failed)
                    window.eventSource.close()
                    taskCompleted(taskIdx)
                    startTask()
                } else if (data.data == 'command-exec-completed') {
                    window.eventSource.close()
                    if (state.taskList[taskIdx].status != taskStatus.Success) {
                        setTaskStatus(taskIdx, taskStatus.Failed)
                    }
                    taskCompleted(taskIdx)
                    startTask()
                } else if (data.data == 'command-link-success') {
                    setTaskStatus(taskIdx, taskStatus.Executing)
                } else if (data.data == 'command-exec-success') {
                    setTaskStatus(taskIdx, taskStatus.Success)
                } else {
                    addTaskMessage(taskIdx, data.data)
                }
            }
            window.eventSource.onerror = function () {
                window.eventSource.close()
                const taskIdx = findTaskIdxFromGuess(taskKey)
                if (taskIdx === false) return
                setTaskStatus(taskIdx, taskStatus.Failed)
                taskCompleted(taskIdx)
            }
        }

        function retryTask(idx: number) {
            state.taskList[idx].message = []
            setTaskStatus(idx, taskStatus.Waiting)
            startTask()
        }

        function clearSuccessTask() {
            state.taskList = state.taskList.filter((item) => item.status != taskStatus.Success)
        }

        function findTaskIdxFromUuid(uuid: string) {
            for (const key in state.taskList) {
                if (state.taskList[key].uuid == uuid) {
                    return parseInt(key)
                }
            }
            return false
        }

        function findTaskIdxFromGuess(idx: number) {
            if (!state.taskList[idx]) {
                let taskKey = -1
                for (const key in state.taskList) {
                    if (state.taskList[key].status == taskStatus.Connecting || state.taskList[key].status == taskStatus.Executing) {
                        taskKey = parseInt(key)
                    }
                }
                return taskKey === -1 ? false : taskKey
            } else {
                return idx
            }
        }

        function execMessageScrollbarKeep(uuid: string) {
            const execMessageEl = document.querySelector('.exec-message-' + uuid) as Element
            if (execMessageEl && execMessageEl.scrollHeight) {
                execMessageEl.scrollTop = execMessageEl.scrollHeight
            }
        }

        return {
            state,
            init,
            toggle,
            toggleDot,
            setTaskStatus,
            setTaskShowMessage,
            addTaskMessage,
            addTask,
            addTaskPM,
            delTask,
            startTask,
            retryTask,
            clearSuccessTask,
            toggleConfigDialog,
            changeRegistry,
            changePackageManager,
            changePHPDevelopmentServer,
            changeAutomaticCleanupTask,
        }
    },
    {
        persist: {
            key: STORE_TERMINAL,
            pick: ['state.showDot', 'state.taskList', 'state.automaticCleanupTask', 'state.npmRegistry', 'state.composerRegistry'],
        },
    }
)
