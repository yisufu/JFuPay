<?php

namespace app\common\model;

use think\Model;

/**
 * Order
 */
class Order extends Model
{
    // 表名
    protected $name = 'order';

    // 自动写入时间戳字段
    protected $autoWriteTimestamp = true;

    // 字段类型转换
    protected $type = [
        'pay_time'    => 'timestamp:Y-m-d H:i:s',
        'notify_time' => 'timestamp:Y-m-d H:i:s',
    ];


    public function getAmountAttr($value): ?float
    {
        return is_null($value) ? null : (float)$value;
    }

    public function getPayAmountAttr($value): ?float
    {
        return is_null($value) ? null : (float)$value;
    }

    public function getRefundAmountAttr($value): ?float
    {
        return is_null($value) ? null : (float)$value;
    }

    public function channel(): \think\model\relation\BelongsTo
    {
        return $this->belongsTo(\app\common\model\Channel::class, 'channel_id', 'id');
    }

    public function merchant(): \think\model\relation\BelongsTo
    {
        return $this->belongsTo(\app\admin\model\User::class, 'merchant_id', 'id');
    }
}