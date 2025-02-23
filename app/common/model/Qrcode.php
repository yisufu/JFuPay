<?php

namespace app\common\model;

use think\Model;

/**
 * Qrcode
 */
class Qrcode extends Model
{
    // 表名
    protected $name = 'qrcode';

    // 自动写入时间戳字段
    protected $autoWriteTimestamp = true;

    // 追加属性
    protected $append = [
        'channelTable',
    ];

    // 字段类型转换
    protected $type = [
        'expired_time' => 'timestamp:Y-m-d H:i:s',
    ];

    protected static function onAfterInsert($model): void
    {
        if (is_null($model->weigh)) {
            $pk = $model->getPk();
            if (strlen($model[$pk]) >= 19) {
                $model->where($pk, $model[$pk])->update(['weigh' => $model->count()]);
            } else {
                $model->where($pk, $model[$pk])->update(['weigh' => $model[$pk]]);
            }
        }
    }

    public function getChannelTableAttr($value, $row): array
    {
        return [
            'name' => \app\common\model\Channel::whereIn('id', $row['channel'])->column('name'),
        ];
    }

    public function getChannelAttr($value): array
    {
        if ($value === '' || $value === null) return [];
        if (!is_array($value)) {
            return explode(',', $value);
        }
        return $value;
    }

    public function setChannelAttr($value): string
    {
        return is_array($value) ? implode(',', $value) : $value;
    }

    public function getMinAmountAttr($value): ?float
    {
        return is_null($value) ? null : (float)$value;
    }

    public function getMaxAmountAttr($value): ?float
    {
        return is_null($value) ? null : (float)$value;
    }

    public function getFixedAmountAttr($value): ?float
    {
        return is_null($value) ? null : (float)$value;
    }

    public function template(): \think\model\relation\BelongsTo
    {
        return $this->belongsTo(\app\common\model\Template::class, 'template_id', 'id');
    }

    public function merchant(): \think\model\relation\BelongsTo
    {
        return $this->belongsTo(\app\admin\model\User::class, 'merchant_id', 'id');
    }
}