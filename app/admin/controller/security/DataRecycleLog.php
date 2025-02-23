<?php

namespace app\admin\controller\security;

use Throwable;
use ba\TableManager;
use think\facade\Db;
use app\common\controller\Backend;
use app\admin\model\DataRecycleLog as DataRecycleLogModel;

class DataRecycleLog extends Backend
{
    /**
     * @var object
     * @phpstan-var DataRecycleLogModel
     */
    protected object $model;

    // 排除字段
    protected string|array $preExcludeFields = [];

    protected string|array $quickSearchField = 'recycle.name';

    protected array $withJoinTable = ['recycle', 'admin'];

    public function initialize(): void
    {
        parent::initialize();
        $this->model = new DataRecycleLogModel();
    }

    /**
     * 还原
     * @throws Throwable
     */
    public function restore(): void
    {
        $ids  = $this->request->param('ids/a', []);
        $data = $this->model->where('id', 'in', $ids)->select();
        if (!$data) {
            $this->error(__('Record not found'));
        }

        $count = 0;
        $this->model->startTrans();
        try {
            foreach ($data as $row) {
                $recycleData = json_decode($row['data'], true);
                if (is_array($recycleData) && Db::connect(TableManager::getConnection($row->connection))->name($row->data_table)->insert($recycleData)) {
                    $row->delete();
                    $count++;
                }
            }
            $this->model->commit();
        } catch (Throwable $e) {
            $this->model->rollback();
            $this->error($e->getMessage());
        }

        if ($count) {
            $this->success();
        } else {
            $this->error(__('No rows were restore'));
        }
    }

    /**
     * 详情
     * @throws Throwable
     */
    public function info(): void
    {
        $pk  = $this->model->getPk();
        $id  = $this->request->param($pk);
        $row = $this->model
            ->withJoin($this->withJoinTable, $this->withJoinType)
            ->where('data_recycle_log.id', $id)
            ->find();
        if (!$row) {
            $this->error(__('Record not found'));
        }
        $data = $this->jsonToArray($row['data']);
        if (is_array($data)) {
            foreach ($data as $key => $item) {
                $data[$key] = $this->jsonToArray($item);
            }
        }
        $row['data'] = $data;

        $this->success('', [
            'row' => $row
        ]);
    }

    protected function jsonToArray($value = '')
    {
        if (!is_string($value)) {
            return $value;
        }
        $data = json_decode($value, true);
        if (($data && is_object($data)) || (is_array($data) && !empty($data))) {
            return $data;
        }
        return $value;
    }
}