# JFuPay - 多渠道聚合收款码系统

JFuPay是一个基于ThinkPHP 8.1框架开发的多渠道聚合收款码系统，支持支付宝、微信支付等多种支付方式，采用插件化架构设计，便于扩展不同的支付渠道。

## 系统特点

- **多渠道支付**：支持支付宝、微信支付等多种支付方式
- **智能通道选择**：根据优先级和轮询机制自动选择最佳支付通道
- **收款码管理**：支持创建和管理收款码，可设置金额限制和过期时间
- **插件化架构**：支付渠道通过插件方式实现，便于扩展
- **商户管理**：支持多商户管理，每个商户可拥有独立的收款码和订单
- **订单管理**：完整的订单创建、查询和统计功能
- **安全机制**：包含数据验证、签名验证等安全措施

## 安装步骤

### 环境要求

- PHP 8.0.2+
- MySQL 5.7+
- Composer
- 必要的PHP扩展：bcmath, iconv, json, gd等

### 安装流程

1. **克隆代码**

```bash
git clone https://github.com/yourusername/JFuPay.git
cd JFuPay
```

2. **安装依赖**

```bash
composer install
```

3. **配置数据库**

编辑 `.env` 文件，修改数据库配置：

```
APP_DEBUG = false

[DATABASE]
TYPE = mysql
HOSTNAME = 127.0.0.1
DATABASE = jfupay  # 修改为您的数据库名
USERNAME = root    # 修改为您的数据库用户名
PASSWORD = root    # 修改为您的数据库密码
HOSTPORT = 3306
CHARSET = utf8mb4
DEBUG = false
```

4. **导入数据库**

创建数据库：

```sql
CREATE DATABASE jfupay CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
```

导入SQL文件：

```bash
# 使用命令行导入
mysql -u用户名 -p密码 jfupay < JFuPay.sql

# 或者使用phpMyAdmin等工具导入JFuPay.sql文件
```

> 注意：导入前请确保SQL文件中的表前缀与您的配置一致，默认为`pay_`。如需修改，请全局替换SQL文件中的表前缀。

5. **配置Web服务器**

配置Nginx或Apache，将网站根目录指向`public`目录。

Nginx配置示例：

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

6. **设置目录权限**

```bash
chmod -R 755 .
chmod -R 777 runtime
chmod -R 777 public/storage
```

7. **访问后台**

访问 `http://yourdomain.com/admin` 进入后台管理界面。

默认管理员账号：
- 用户名：admin
- 密码：123456

## 配置支付渠道

1. 登录后台管理界面
2. 进入"插件管理"，同步本地插件
3. 进入"支付通道"，添加并配置支付通道
4. 进入"收款码管理"，创建新的收款码并绑定支付通道

## 使用说明

### 创建收款码

1. 登录后台，进入"收款码管理"
2. 点击"添加"，填写收款码信息
3. 选择支付通道，设置金额限制和过期时间
4. 保存后获取收款码链接或二维码

### 查看订单

1. 登录后台，进入"订单管理"
2. 可查看所有支付订单及状态
3. 支持按订单号、金额、时间等条件筛选

## 开发文档

### 插件开发

如需开发新的支付渠道插件，请参考`extend/plugins`目录下的示例插件，实现以下方法：

- `pay()`: 处理支付请求
- `notify()`: 处理支付回调通知

### API接口

系统提供标准的RESTful API接口，详细文档请参考`/api/doc`。

## 常见问题

1. **支付通知失败怎么办？**
   - 检查通知URL是否可以正常访问
   - 查看系统日志，确认通知内容是否正确
   - 检查服务器防火墙设置

2. **如何添加新的支付方式？**
   - 开发对应的支付插件
   - 在后台同步本地插件
   - 添加新的支付通道并选择对应插件

## 许可证

本项目采用Apache 2.0许可证，详情请参阅LICENSE文件。

## 联系方式

如有问题或建议，请提交Issue或联系开发者。

---

感谢使用JFuPay多渠道聚合收款码系统！ 