<?php

namespace app\admin\controller;

use app\common\controller\Backend;

/**
 * 收款码模板
 */
class Template extends Backend
{
    /**
     * Template模型对象
     * @var object
     * @phpstan-var \app\common\model\Template
     */
    protected object $model;

    protected string|array $defaultSortField = 'weigh,desc';

    protected array|string $preExcludeFields = ['id', 'create_time', 'update_time'];

    protected string|array $quickSearchField = ['id'];

    public function initialize(): void
    {
        parent::initialize();
        $this->model = new \app\common\model\Template();
    }


    /**
     * 若需重写查看、编辑、删除等方法，请复制 @see \app\admin\library\traits\Backend 中对应的方法至此进行重写
     */
}