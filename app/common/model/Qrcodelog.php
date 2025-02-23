<?php

namespace app\common\model;

use think\Model;

/**
 * Qrcodelog
 */
class Qrcodelog extends Model
{
    // 表名
    protected $name = 'qrcode_log';

    // 自动写入时间戳字段
    protected $autoWriteTimestamp = true;
    protected $updateTime = false;


    public function qrcode(): \think\model\relation\BelongsTo
    {
        return $this->belongsTo(\app\common\model\Qrcode::class, 'qrcode_id', 'id');
    }
}