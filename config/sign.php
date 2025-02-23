<?php

return [
    // 系统 RSA2 公钥
    'public_key' => "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAk7A57tbnIiADaqfGhIzadAAPHBM6yXoz6v+uNf+EBJSuSY2VtJOnPjy//x1Pdb1igHNPdCiYf2/XCUeIVtoAAJ/HuEMEY7PP/lT7j/Fjj+fXrwhR681kN/EPdJWKtN+BoT9JtPViCgmF6L20yCmPXLEWxBvhGBssr8Olum4r+pWFQCroy+zoTp2tIEtTWGVvSiweRO+PIyVtw5oRaorYKliOo1zkfuUrPrbaL/xhLAOdz2CERJTJxKH4TmEDFVfjuDBEf7XaBfN1FKU6zAoudnU5HRk4ZqfAYtT7+8Ad5DgmTwf1EDok6M7hC9BUO2j7OYku2r7lyERIQk3ETwvuXwIDAQAB",

    // 系统 RSA2 私钥
    'private_key' => "MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCTsDnu1uciIANqp8aEjNp0AA8cEzrJejPq/641/4QElK5JjZW0k6c+PL//HU91vWKAc090KJh/b9cJR4hW2gAAn8e4QwRjs8/+VPuP8WOP59evCFHrzWQ38Q90lYq034GhP0m09WIKCYXovbTIKY9csRbEG+EYGyyvw6W6biv6lYVAKujL7OhOna0gS1NYZW9KLB5E748jJW3DmhFqitgqWI6jXOR+5Ss+ttov/GEsA53PYIRElMnEofhOYQMVV+O4MER/tdoF83UUpTrMCi52dTkdGThmp8Bi1Pv7wB3kOCZPB/UQOiTozuEL0FQ7aPs5iS7avuXIREhCTcRPC+5fAgMBAAECggEAFkYRtq+6lC731PIQwpTrrWsE3FsaFqDTi7Gb+JDcvEQgNP+hgGZ0ZrKK0lL9VOiHHpBFf2NP/IhFiiS7rz2Zmn5+hI+27cKEr/rpJcBmH6H7qW47zLBhWP6GMjMLhFPhHQyKdTw82P6ur3dM+JMsB/K9WD5MKHKQvsFnEULkZxpCFHnoTa97NpvIgd2SA3HBQ6mBFVE73IhpqdpbFoX7w3HmFeryOjWX08Yyth9L/dwcwZB0EqZc6NvaVNGWrvsKYxCY+5h+wv91ml6cAYGt/gyQy/Bczbof6FIZguUCDQdaQxSf8x4dORIvzCwwYmtUwTRYgAgjTjoI4uYt7L5XgQKBgQDrFpz0RxZsXw5SKwkJ9mIULLD6Zrg6kPMckQ3g2zjl4EgIEMCHqfl/Dwu96zYH1jmz1hGMdAJaUc+0XYhMn7M0CUX2txNY5hrEyf58YbrRwnFlJCLYGjkaw6WPKeKKGOAJuKcrTqKe+NyS5QhzTMWTbYD/NSx1jCEwUw7xJ1Hp8QKBgQCg01uwJvrtvXFVbKhw7rXX6ymWEVXcwvxjKlzRvc8+0GScVXWCGTLl22NAAMKQhmARnCOevYy/qA2L7Tj4v/wXOwLbMfWitFqW9ySO9nCHFVWZhy15G97osUN585MQKtQkMOCN4Y0neTvxkvD+fqbzBh/DX4VMU9PB679FCpuNTwKBgQCjk2N4sXIPzABp+hna/b327bXjNdAgqDUQ/nlaqQ8pHGriec2NWB8LYsu3xU8eGtihomUphpsQf3Z3uNEbB9Aod/9fkLl8lPexUB+sKlBUnehLCN7Z4T00u0eamvlPP8m72ekvwBJ1bRIFgCnmGFgtofctHLGnxO5e8pwl/kcH8QKBgQCK6qZ7POBotMeNk0LX8cnPDQkp4CV7gE2D1tbAMSUvy8/sHgFXdC67z0omwcFOF1QqQeWeu3o1HpM895bLfwHgiw+HiNr1RLYvSqEggAxpEmuTJumHgCSGeH+helzgjS4baMC+rUJBA35cx6E1Iu9QYkzTdNHuQUZbbigUGfqNDwKBgCbiYcoMAbM/HHtnTR3vwp0rAcsbL5Oj+v+cRvec8QshADbKGkrjWDDBOS8kVuqim+K/RCsEh6+Iba0e8PBkQthCPPjqKi8pJM1U2ePlpWv+yH5wXzf761q87yHHR9D3ht+9aqIlMI+IVaJcG54ie0Fvsn+MPlr5c/ofHavQgY+i",

    // 签名配置
    'sign_type' => 'RSA2', // 签名方式
    'sign_algorithm' => OPENSSL_ALGO_SHA256, // 签名算法
    'charset' => 'utf-8', // 字符集
    
    // 时间戳验证配置
    'timestamp_timeout' => 300, // 时间戳有效期（秒）
    
    // 签名字段配置
    'sign_field' => 'sign', // 签名字段名
    'exclude_fields' => ['sign'], // 签名时需要排除的字段
];
