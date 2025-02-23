<?php

namespace app\common\model;

use think\Model;

/**
 * Channel
 */
class Channel extends Model
{
    // 表名
    protected $name = 'channel';

    // 自动写入时间戳字段
    protected $autoWriteTimestamp = true;


    public function getMinAmountAttr($value): ?float
    {
        return is_null($value) ? null : (float)$value;
    }

    public function getMaxAmountAttr($value): ?float
    {
        return is_null($value) ? null : (float)$value;
    }

    public function plugin(): \think\model\relation\BelongsTo
    {
        return $this->belongsTo(\app\common\model\Plugins::class, 'plugin_id', 'id');
    }


}