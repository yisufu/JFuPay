# JFuPay 数据库配置指南

本文档提供了 JFuPay 系统数据库配置的详细说明，包括如何修改数据库名称、表前缀等。

## 数据库要求

- MySQL 5.7+ 或 MariaDB 10.2+
- 字符集：utf8mb4
- 排序规则：utf8mb4_unicode_ci

## 数据库配置步骤

### 1. 创建数据库

登录MySQL：

```bash
mysql -u root -p
```

创建新数据库：

```sql
CREATE DATABASE jfupay CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
```

创建数据库用户并授权（可选，建议生产环境使用）：

```sql
CREATE USER 'jfupay_user'@'localhost' IDENTIFIED BY '安全密码';
GRANT ALL PRIVILEGES ON jfupay.* TO 'jfupay_user'@'localhost';
FLUSH PRIVILEGES;
```

### 2. 修改数据库配置文件

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

### 3. 修改SQL文件中的数据库名

在导入数据库之前，您需要修改SQL文件中的数据库名称引用：

1. 打开 `JFuPay.sql` 文件
2. 查找以下内容并修改：
   - `USE \`JFuPay\`;` 修改为 `USE \`jfupay\`;`
   - `数据库： \`JFuPay\`` 修改为 `数据库： \`jfupay\``

您可以使用文本编辑器的查找替换功能，将所有 `JFuPay` 替换为 `jfupay`（注意大小写）。

### 4. 修改表前缀（可选）

默认表前缀为 `pay_`，如果需要修改，请执行以下步骤：

#### 4.1 修改SQL文件中的表前缀

在导入数据库之前，使用文本编辑器打开 `JFuPay.sql` 文件，将所有 `pay_` 替换为您想要的前缀，例如 `jfu_`。

注意替换以下内容：
- 表名：如 `CREATE TABLE \`pay_admin\`` 
- 表数据插入：如 `INSERT INTO \`pay_admin\``
- 外键引用：如 `REFERENCES \`pay_admin\``

#### 4.2 修改配置文件中的表前缀

编辑 `config/database.php` 文件，找到以下行：

```php
// 数据库表前缀
'prefix'         => 'pay_',
```

将其修改为您的新前缀：

```php
// 数据库表前缀
'prefix'         => 'jfu_',
```

### 5. 导入数据库

#### 方法一：使用命令行导入

```bash
mysql -u用户名 -p密码 jfupay < JFuPay.sql
```

#### 方法二：使用phpMyAdmin导入

1. 登录phpMyAdmin
2. 选择您创建的数据库
3. 点击"导入"选项卡
4. 选择JFuPay.sql文件并导入

### 6. 验证数据库连接

完成上述步骤后，您可以通过以下方式验证数据库连接是否正常：

1. 访问网站首页，检查是否有数据库连接错误
2. 尝试登录后台（默认账号：admin，密码：123456）
3. 如果出现错误，检查PHP错误日志或开启调试模式（在`.env`文件中设置`APP_DEBUG = true`）

## 数据库结构说明

JFuPay系统主要包含以下数据表：

- `pay_admin`: 管理员信息
- `pay_order`: 支付订单
- `pay_channel`: 支付通道
- `pay_qrcode`: 收款码
- `pay_plugins`: 支付插件
- `pay_template`: 收款码模板
- `pay_user`: 商户用户

## 数据库备份与恢复

### 备份数据库

```bash
# 使用mysqldump备份
mysqldump -u用户名 -p密码 jfupay > jfupay_backup_$(date +%Y%m%d).sql
```

### 恢复数据库

```bash
# 恢复备份
mysql -u用户名 -p密码 jfupay < jfupay_backup_20240101.sql
```

## 常见问题

### 1. 导入SQL文件时出现错误

- 检查SQL文件格式是否正确
- 确认数据库字符集为utf8mb4
- 检查SQL文件大小，如果过大可能需要调整MySQL配置

### 2. 数据库连接失败

- 验证数据库连接信息是否正确
- 确认数据库用户是否有足够权限
- 检查MySQL服务是否正常运行

### 3. 表前缀修改后系统无法正常工作

- 确认是否完全替换了SQL文件中的所有表前缀
- 检查配置文件中的表前缀设置是否正确
- 检查是否有硬编码的表名引用

---

如有其他数据库相关问题，请联系技术支持。 