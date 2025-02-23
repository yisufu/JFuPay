<?php

namespace app\admin\controller;

use Exception;
use Throwable;
use app\common\controller\Backend;

/**
 * 支付通道配置管理
 */
class Channel extends Backend
{
    /**
     * Channel模型对象
     * @var object
     * @phpstan-var \app\common\model\Channel
     */
    protected object $model;

    protected array|string $preExcludeFields = ['id', 'create_time', 'update_time'];

    protected array $withJoinTable = ['plugin'];

    protected string|array $quickSearchField = ['id'];

    /**
     * 需要处理的JSON字段
     */
    protected array $jsonFields = ['config'];

    public function initialize(): void
    {
        parent::initialize();
        $this->model = new \app\common\model\Channel();
    }

    /**
     * 添加
     */
    public function add(): void
    {
        if ($this->request->isPost()) {
            $data = $this->request->post();
            if (!$data) {
                $this->error(__('Parameter %s can not be empty', ['']));
            }

            $data = $this->excludeFields($data);
            if ($this->dataLimit && $this->dataLimitFieldAutoFill) {
                $data[$this->dataLimitField] = $this->auth->id;
            }

            $result = false;
            $this->model->startTrans();
            try {
                // 模型验证
                if ($this->modelValidate) {
                    $validate = str_replace("\\model\\", "\\validate\\", get_class($this->model));
                    if (class_exists($validate)) {
                        $validate = new $validate();
                        if ($this->modelSceneValidate) $validate->scene('add');
                        $validate->check($data);
                    }
                }
                // 处理JSON字段
                foreach ($this->jsonFields as $field) {
                    if (!empty($data[$field])) {
                        // 先解码 HTML 实体
                        $data[$field] = html_entity_decode($data[$field], ENT_QUOTES | ENT_HTML5, 'UTF-8');

                        // 验证是否为有效的JSON
                        $decoded = json_decode($data[$field], true);
                        if (json_last_error() !== JSON_ERROR_NONE) {
                            $this->error($field . '字段不是有效的JSON格式');
                        }
                        // 重新编码为JSON,确保格式统一
                        $data[$field] = json_encode($decoded, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
                    }
                }
                $result = $this->model->save($data);
                $this->model->commit();
            } catch (Throwable $e) {
                $this->model->rollback();
                $this->error($e->getMessage());
            }
            if ($result !== false) {
                $this->success(__('Added successfully'));
            } else {
                $this->error(__('No rows were added'));
            }
        }

        $this->error(__('Parameter error'));
    }

    /**
     * 编辑
     * @throws Throwable
     */
    public function edit(): void
    {
        $id = $this->request->param('id/d', 0);
        if (!$id) {
            $this->error('参数错误');
        }

        $row = $this->model->find($id);
        if (!$row) {
            $this->error('数据不存在');
        }

        if ($this->request->isPost()) {
            $data = $this->request->post();
            
            if (!empty($data)) {
                // 处理JSON字段
                foreach ($this->jsonFields as $field) {
                    if (!empty($data[$field])) {
                        // 先解码 HTML 实体
                        $data[$field] = html_entity_decode($data[$field], ENT_QUOTES | ENT_HTML5, 'UTF-8');
                        
                        // 验证是否为有效的JSON
                        $decoded = json_decode($data[$field], true);
                        if (json_last_error() !== JSON_ERROR_NONE) {
                            $this->error($field . '字段不是有效的JSON格式');
                        }
                        // 重新编码为JSON,确保格式统一
                        $data[$field] = json_encode($decoded, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
                    }
                }

                $result = $row->save($data);
                if ($result === false) {
                    $this->error('更新失败');
                }
                $this->success('更新成功');
            }
            $this->error('数据不能为空');
        }

        $this->success('获取成功', ['row' => $row]);
    }

    /**
     * 查看
     * @throws Throwable
     */
    public function index(): void
    {
        // 如果是 select 则转发到 select 方法，若未重写该方法，其实还是继续执行 index
        if ($this->request->param('select')) {
            $this->select();
        }

        /**
         * 1. withJoin 不可使用 alias 方法设置表别名，别名将自动使用关联模型名称（小写下划线命名规则）
         * 2. 以下的别名设置了主表别名，同时便于拼接查询参数等
         * 3. paginate 数据集可使用链式操作 each(function($item, $key) {}) 遍历处理
         */
        list($where, $alias, $limit, $order) = $this->queryBuilder();
        $res = $this->model
            ->withJoin($this->withJoinTable, $this->withJoinType)
            ->alias($alias)
            ->where($where)
            ->order($order)
            ->paginate($limit);
        $res->visible(['plugin' => ['plugin_name']]);

        $this->success('', [
            'list'   => $res->items(),
            'total'  => $res->total(),
            'remark' => get_route_remark(),
        ]);
    }

    /**
     * 测试支付
     * @throws Throwable
     */
    public function testPay(): void
    {
        $this->error('暂不支持测试支付');
        $id = $this->request->post('id/d', 0);
        if (!$id) {
            $this->error('参数错误');
        }

        $channel = $this->model->find($id);
        if (!$channel) {
            $this->error('支付通道不存在');
        }

        if ($channel['status'] != 1) {
            $this->error('支付通道未启用');
        }

        try {
            // 获取插件实例
            $className = "\\plugins\\" . $channel['plugin']['class_name'] . "\\" . $channel['plugin']['class_name'];
            if (!class_exists($className)) {
                throw new \Exception('支付插件不存在');
            }

            $plugin = new $className();
            
            // 测试支付金额
            $amount = $channel['min_amount'] ?: 0.01;
            
            // 生成测试订单号
            $orderNo = date('YmdHis') . mt_rand(1000, 9999);
            
            // 调用支付接口
            $result = $plugin->pay([
                'channel_id' => $channel['id'],
                'channel_type' => 'alipay',
                'amount' => $amount,
                'order_no' => $orderNo,
                'config' => json_decode($channel['config'], true)
            ]);
            if (isset($result['code'])){
                if ($result['code'] != 200){
                    throw new \Exception($result['msg']);
                }

            } else {
                throw new \Exception('支付插件内部错误');
            }
            $this->success('测试支付发起成功', $result);

        } catch (Exception $e) {
            $this->error('测试支付失败: ' . $e->getMessage());
        }
        $this->success('测试支付发起成功', $result);
    }

    /**
     * 若需重写查看、编辑、删除等方法，请复制 @see \app\admin\library\traits\Backend 中对应的方法至此进行重写
     */
}