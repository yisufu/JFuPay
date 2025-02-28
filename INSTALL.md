# JFuPay 安装指南

本文档提供了 JFuPay 多渠道聚合收款码系统的详细安装步骤。

## 环境准备

确保您的服务器满足以下要求：

- PHP 8.0.2 或更高版本
- MySQL 5.7 或更高版本
- Composer
- 必要的PHP扩展：bcmath, iconv, json, gd等

## 安装步骤

### 1. 获取源代码

```bash
git clone https://github.com/yourusername/JFuPay.git
cd JFuPay
```

或者直接下载源码包并解压到您的网站目录。

### 2. 安装依赖

```bash
composer install
```

### 3. 数据库配置

#### 3.1 创建数据库

登录MySQL：

```bash
mysql -u root -p
```

创建数据库：

```sql
CREATE DATABASE jfupay CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
```

> 您可以将 `jfupay` 替换为您想要的数据库名称。

#### 3.2 修改数据库配置

编辑项目根目录下的 `.env` 文件：

```
APP_DEBUG = false

[DATABASE]
TYPE = mysql
HOSTNAME = 127.0.0.1
DATABASE = jfupay  # 修改为您创建的数据库名
USERNAME = root    # 修改为您的数据库用户名
PASSWORD = root    # 修改为您的数据库密码
HOSTPORT = 3306
CHARSET = utf8mb4
DEBUG = false
```

#### 3.3 修改SQL文件中的数据库名（可选）

如果您使用了不同的数据库名，需要修改 `JFuPay.sql` 文件中的数据库名：

1. 打开 `JFuPay.sql` 文件
2. 查找 `USE \`JFuPay\`;` 或 `数据库： \`JFuPay\`` 这样的语句
3. 将其修改为您创建的数据库名，例如 `USE \`jfupay\`;`

#### 3.4 导入数据库

方法一：使用命令行导入

```bash
mysql -u用户名 -p密码 jfupay < JFuPay.sql
```

方法二：使用phpMyAdmin等工具导入

1. 登录phpMyAdmin
2. 选择您创建的数据库
3. 点击"导入"选项卡
4. 选择JFuPay.sql文件并导入

### 4. 修改表前缀（可选）

如果您需要修改表前缀（默认为`pay_`），请执行以下步骤：

1. 在SQL文件中全局替换表前缀：
   - 将 `pay_` 替换为您想要的前缀，例如 `jfu_`

2. 修改配置文件中的表前缀：
   - 编辑 `config/database.php` 文件
   - 修改 `'prefix' => 'pay_',` 为您的新前缀

### 5. 配置Web服务器

#### Apache配置

确保启用了mod_rewrite模块，并在网站根目录的.htaccess文件中添加：

```apache
<IfModule mod_rewrite.c>
  Options +FollowSymlinks -Multiviews
  RewriteEngine On

  RewriteCond %{REQUEST_FILENAME} !-d
  RewriteCond %{REQUEST_FILENAME} !-f
  RewriteRule ^(.*)$ index.php?/$1 [QSA,PT,L]
</IfModule>
```

#### Nginx配置

```nginx
server {
    listen 80;
    server_name yourdomain.com;
    root /path/to/JFuPay/public;
    index index.php index.html;

    location / {
        if (!-e $request_filename) {
            rewrite ^(.*)$ /index.php?s=$1 last;
            break;
        }
    }

    location ~ \.php$ {
        fastcgi_pass unix:/var/run/php/php8.0-fpm.sock;
        fastcgi_index index.php;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        include fastcgi_params;
    }
}
```

### 6. 设置目录权限

```bash
chmod -R 755 .
chmod -R 777 runtime
chmod -R 777 public/storage
```

### 7. 访问系统

访问 `http://yourdomain.com/admin` 进入后台管理界面。

默认管理员账号：
- 用户名：admin
- 密码：123456

## 常见问题

### 1. 数据库连接错误

- 检查数据库连接信息是否正确
- 确认MySQL服务是否正常运行
- 检查数据库用户是否有足够权限

### 2. 页面404错误

- 检查Web服务器配置是否正确
- 确认伪静态规则是否生效
- 检查URL重写模块是否启用

### 3. 权限问题

如果遇到文件写入错误，请确保以下目录有写入权限：

```bash
chmod -R 777 runtime
chmod -R 777 public/storage
```

### 4. 白屏或500错误

- 检查PHP错误日志
- 开启调试模式：修改`.env`文件中的`APP_DEBUG = true`
- 检查PHP版本是否满足要求

## 安装后配置

### 1. 同步支付插件

1. 登录后台
2. 进入"插件管理"
3. 点击"同步本地插件"按钮

### 2. 配置支付通道

1. 进入"支付通道"
2. 点击"添加"
3. 选择插件并填写配置信息

### 3. 创建收款码

1. 进入"收款码管理"
2. 点击"添加"
3. 填写收款码信息并选择支付通道

## 安全建议

1. 安装完成后修改默认管理员密码
2. 定期备份数据库
3. 保持系统和PHP版本更新
4. 使用HTTPS加密传输数据

---

如有其他安装问题，请联系技术支持或提交Issue。 