<?php

return [
    'bind'    => [],
    'listen'  => [
        'AppInit'  => [],
        'HttpRun'  => [],
        'HttpEnd'  => [],
        'LogLevel' => [],
        'LogWrite' => [],
        // 添加收款码访问事件监听
        'QrcodeVisited' => ['app\\event\\QrcodeVisited'],
    ],
    'subscribe' => [],
]; 