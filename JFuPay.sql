-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- 主机： localhost
-- 生成日期： 2025-02-19 04:16:31
-- 服务器版本： 8.0.25
-- PHP 版本： 7.4.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- 数据库： `JFuPay`
--

-- --------------------------------------------------------

--
-- 表的结构 `pay_admin`
--

CREATE TABLE `pay_admin` (
  `id` int UNSIGNED NOT NULL COMMENT 'ID',
  `username` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '用户名',
  `nickname` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '昵称',
  `avatar` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '头像',
  `email` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '邮箱',
  `mobile` varchar(11) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '手机',
  `login_failure` tinyint UNSIGNED NOT NULL DEFAULT '0' COMMENT '登录失败次数',
  `last_login_time` bigint UNSIGNED DEFAULT NULL COMMENT '上次登录时间',
  `last_login_ip` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '上次登录IP',
  `password` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '密码',
  `salt` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '密码盐',
  `motto` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '签名',
  `status` enum('0','1') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1' COMMENT '状态:0=禁用,1=启用',
  `update_time` bigint UNSIGNED DEFAULT NULL COMMENT '更新时间',
  `create_time` bigint UNSIGNED DEFAULT NULL COMMENT '创建时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='管理员表' ROW_FORMAT=DYNAMIC;

--
-- 转存表中的数据 `pay_admin`
--

INSERT INTO `pay_admin` (`id`, `username`, `nickname`, `avatar`, `email`, `mobile`, `login_failure`, `last_login_time`, `last_login_ip`, `password`, `salt`, `motto`, `status`, `update_time`, `create_time`) VALUES
(1, 'admin', 'Admin', '', 'admin@buildadmin.com', '18888888888', 0, 1739909047, '192.168.31.7', '84976123288ddafabcb7ec7a69273dd2', 'vWYejhuFxfmUgIin', '', '1', 1739909047, 1739733640);

-- --------------------------------------------------------

--
-- 表的结构 `pay_admin_group`
--

CREATE TABLE `pay_admin_group` (
  `id` int UNSIGNED NOT NULL COMMENT 'ID',
  `pid` int UNSIGNED NOT NULL DEFAULT '0' COMMENT '上级分组',
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '组名',
  `rules` text COLLATE utf8mb4_unicode_ci COMMENT '权限规则ID',
  `status` enum('0','1') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1' COMMENT '状态:0=禁用,1=启用',
  `update_time` bigint UNSIGNED DEFAULT NULL COMMENT '更新时间',
  `create_time` bigint UNSIGNED DEFAULT NULL COMMENT '创建时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='管理分组表' ROW_FORMAT=DYNAMIC;

--
-- 转存表中的数据 `pay_admin_group`
--

INSERT INTO `pay_admin_group` (`id`, `pid`, `name`, `rules`, `status`, `update_time`, `create_time`) VALUES
(1, 0, '超级管理组', '*', '1', 1739733640, 1739733640),
(2, 1, '一级管理员', '1,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,77,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,89', '1', 1739733640, 1739733640),
(3, 2, '二级管理员', '21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43', '1', 1739733640, 1739733640),
(4, 3, '三级管理员', '55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75', '1', 1739733640, 1739733640);

-- --------------------------------------------------------

--
-- 表的结构 `pay_admin_group_access`
--

CREATE TABLE `pay_admin_group_access` (
  `uid` int UNSIGNED NOT NULL COMMENT '管理员ID',
  `group_id` int UNSIGNED NOT NULL COMMENT '分组ID'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='管理分组映射表' ROW_FORMAT=DYNAMIC;

--
-- 转存表中的数据 `pay_admin_group_access`
--

INSERT INTO `pay_admin_group_access` (`uid`, `group_id`) VALUES
(1, 1);

-- --------------------------------------------------------

--
-- 表的结构 `pay_admin_log`
--

CREATE TABLE `pay_admin_log` (
  `id` int UNSIGNED NOT NULL COMMENT 'ID',
  `admin_id` int UNSIGNED NOT NULL DEFAULT '0' COMMENT '管理员ID',
  `username` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '管理员用户名',
  `url` varchar(1500) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '操作Url',
  `title` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '日志标题',
  `data` longtext COLLATE utf8mb4_unicode_ci COMMENT '请求数据',
  `ip` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'IP',
  `useragent` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'User-Agent',
  `create_time` bigint UNSIGNED DEFAULT NULL COMMENT '创建时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='管理员日志表' ROW_FORMAT=DYNAMIC;

--
-- 转存表中的数据 `pay_admin_log`
--

INSERT INTO `pay_admin_log` (`id`, `admin_id`, `username`, `url`, `title`, `data`, `ip`, `useragent`, `create_time`) VALUES
(1, 1, 'admin', '/admin/Index/login', '登录', '{\"username\":\"admin\",\"password\":\"***\",\"keep\":\"1\",\"captchaId\":\"49f02552-236b-4ff8-9bbd-381bf2ad4e52\",\"captchaInfo\":\"\"}', '127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36', 1739733802),
-- --------------------------------------------------------

--
-- 表的结构 `pay_admin_rule`
--

CREATE TABLE `pay_admin_rule` (
  `id` int UNSIGNED NOT NULL COMMENT 'ID',
  `pid` int UNSIGNED NOT NULL DEFAULT '0' COMMENT '上级菜单',
  `type` enum('menu_dir','menu','button') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'menu' COMMENT '类型:menu_dir=菜单目录,menu=菜单项,button=页面按钮',
  `title` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '标题',
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '规则名称',
  `path` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '路由路径',
  `icon` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '图标',
  `menu_type` enum('tab','link','iframe') COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '菜单类型:tab=选项卡,link=链接,iframe=Iframe',
  `url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'Url',
  `component` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '组件路径',
  `keepalive` tinyint UNSIGNED NOT NULL DEFAULT '0' COMMENT '缓存:0=关闭,1=开启',
  `extend` enum('none','add_rules_only','add_menu_only') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'none' COMMENT '扩展属性:none=无,add_rules_only=只添加为路由,add_menu_only=只添加为菜单',
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '备注',
  `weigh` int NOT NULL DEFAULT '0' COMMENT '权重',
  `status` enum('0','1') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1' COMMENT '状态:0=禁用,1=启用',
  `update_time` bigint UNSIGNED DEFAULT NULL COMMENT '更新时间',
  `create_time` bigint UNSIGNED DEFAULT NULL COMMENT '创建时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='菜单和权限规则表' ROW_FORMAT=DYNAMIC;

--
-- 转存表中的数据 `pay_admin_rule`
--

INSERT INTO `pay_admin_rule` (`id`, `pid`, `type`, `title`, `name`, `path`, `icon`, `menu_type`, `url`, `component`, `keepalive`, `extend`, `remark`, `weigh`, `status`, `update_time`, `create_time`) VALUES
(1, 0, 'menu', '控制台', 'dashboard', 'dashboard', 'fa fa-dashboard', 'tab', '', '/src/views/backend/dashboard.vue', 1, 'none', 'Remark lang', 999, '1', 1739733640, 1739733640),
(2, 0, 'menu_dir', '权限管理', 'auth', 'auth', 'fa fa-group', NULL, '', '', 0, 'none', '', 100, '1', 1739733640, 1739733640),
(3, 2, 'menu', '角色组管理', 'auth/group', 'auth/group', 'fa fa-group', 'tab', '', '/src/views/backend/auth/group/index.vue', 1, 'none', 'Remark lang', 99, '1', 1739733640, 1739733640),
(4, 3, 'button', '查看', 'auth/group/index', '', '', NULL, '', '', 0, 'none', '', 0, '1', 1739733640, 1739733640),
(5, 3, 'button', '添加', 'auth/group/add', '', '', NULL, '', '', 0, 'none', '', 0, '1', 1739733640, 1739733640),
(6, 3, 'button', '编辑', 'auth/group/edit', '', '', NULL, '', '', 0, 'none', '', 0, '1', 1739733640, 1739733640),
(7, 3, 'button', '删除', 'auth/group/del', '', '', NULL, '', '', 0, 'none', '', 0, '1', 1739733640, 1739733640),
(8, 2, 'menu', '管理员管理', 'auth/admin', 'auth/admin', 'el-icon-UserFilled', 'tab', '', '/src/views/backend/auth/admin/index.vue', 1, 'none', '', 98, '1', 1739733640, 1739733640),
(9, 8, 'button', '查看', 'auth/admin/index', '', '', NULL, '', '', 0, 'none', '', 0, '1', 1739733640, 1739733640),
(10, 8, 'button', '添加', 'auth/admin/add', '', '', NULL, '', '', 0, 'none', '', 0, '1', 1739733640, 1739733640),
(11, 8, 'button', '编辑', 'auth/admin/edit', '', '', NULL, '', '', 0, 'none', '', 0, '1', 1739733640, 1739733640),
(12, 8, 'button', '删除', 'auth/admin/del', '', '', NULL, '', '', 0, 'none', '', 0, '1', 1739733640, 1739733640),
(13, 2, 'menu', '菜单规则管理', 'auth/rule', 'auth/rule', 'el-icon-Grid', 'tab', '', '/src/views/backend/auth/rule/index.vue', 1, 'none', '', 97, '1', 1739733640, 1739733640),
(14, 13, 'button', '查看', 'auth/rule/index', '', '', NULL, '', '', 0, 'none', '', 0, '1', 1739733640, 1739733640),
(15, 13, 'button', '添加', 'auth/rule/add', '', '', NULL, '', '', 0, 'none', '', 0, '1', 1739733640, 1739733640),
(16, 13, 'button', '编辑', 'auth/rule/edit', '', '', NULL, '', '', 0, 'none', '', 0, '1', 1739733640, 1739733640),
(17, 13, 'button', '删除', 'auth/rule/del', '', '', NULL, '', '', 0, 'none', '', 0, '1', 1739733640, 1739733640),
(18, 13, 'button', '快速排序', 'auth/rule/sortable', '', '', NULL, '', '', 0, 'none', '', 0, '1', 1739733640, 1739733640),
(19, 2, 'menu', '管理员日志管理', 'auth/adminLog', 'auth/adminLog', 'el-icon-List', 'tab', '', '/src/views/backend/auth/adminLog/index.vue', 1, 'none', '', 96, '1', 1739733640, 1739733640),
(20, 19, 'button', '查看', 'auth/adminLog/index', '', '', NULL, '', '', 0, 'none', '', 0, '1', 1739733640, 1739733640),
(21, 0, 'menu_dir', '会员管理', 'user', 'user', 'fa fa-drivers-license', NULL, '', '', 0, 'none', '', 95, '1', 1739733640, 1739733640),
(22, 21, 'menu', '会员管理', 'user/user', 'user/user', 'fa fa-user', 'tab', '', '/src/views/backend/user/user/index.vue', 1, 'none', '', 94, '1', 1739733640, 1739733640),
(23, 22, 'button', '查看', 'user/user/index', '', '', NULL, '', '', 0, 'none', '', 0, '1', 1739733640, 1739733640),
(24, 22, 'button', '添加', 'user/user/add', '', '', NULL, '', '', 0, 'none', '', 0, '1', 1739733640, 1739733640),
(25, 22, 'button', '编辑', 'user/user/edit', '', '', NULL, '', '', 0, 'none', '', 0, '1', 1739733640, 1739733640),
(26, 22, 'button', '删除', 'user/user/del', '', '', NULL, '', '', 0, 'none', '', 0, '1', 1739733640, 1739733640),
(27, 21, 'menu', '会员分组管理', 'user/group', 'user/group', 'fa fa-group', 'tab', '', '/src/views/backend/user/group/index.vue', 1, 'none', '', 93, '1', 1739733640, 1739733640),
(28, 27, 'button', '查看', 'user/group/index', '', '', NULL, '', '', 0, 'none', '', 0, '1', 1739733640, 1739733640),
(29, 27, 'button', '添加', 'user/group/add', '', '', NULL, '', '', 0, 'none', '', 0, '1', 1739733640, 1739733640),
(30, 27, 'button', '编辑', 'user/group/edit', '', '', NULL, '', '', 0, 'none', '', 0, '1', 1739733640, 1739733640),
(31, 27, 'button', '删除', 'user/group/del', '', '', NULL, '', '', 0, 'none', '', 0, '1', 1739733640, 1739733640),
(32, 21, 'menu', '会员规则管理', 'user/rule', 'user/rule', 'fa fa-th-list', 'tab', '', '/src/views/backend/user/rule/index.vue', 1, 'none', '', 92, '1', 1739733640, 1739733640),
(33, 32, 'button', '查看', 'user/rule/index', '', '', NULL, '', '', 0, 'none', '', 0, '1', 1739733640, 1739733640),
(34, 32, 'button', '添加', 'user/rule/add', '', '', NULL, '', '', 0, 'none', '', 0, '1', 1739733640, 1739733640),
(35, 32, 'button', '编辑', 'user/rule/edit', '', '', NULL, '', '', 0, 'none', '', 0, '1', 1739733640, 1739733640),
(36, 32, 'button', '删除', 'user/rule/del', '', '', NULL, '', '', 0, 'none', '', 0, '1', 1739733640, 1739733640),
(37, 32, 'button', '快速排序', 'user/rule/sortable', '', '', NULL, '', '', 0, 'none', '', 0, '1', 1739733640, 1739733640),
(38, 21, 'menu', '会员余额管理', 'user/moneyLog', 'user/moneyLog', 'el-icon-Money', 'tab', '', '/src/views/backend/user/moneyLog/index.vue', 1, 'none', '', 91, '1', 1739733640, 1739733640),
(39, 38, 'button', '查看', 'user/moneyLog/index', '', '', NULL, '', '', 0, 'none', '', 0, '1', 1739733640, 1739733640),
(40, 38, 'button', '添加', 'user/moneyLog/add', '', '', NULL, '', '', 0, 'none', '', 0, '1', 1739733640, 1739733640),
(41, 21, 'menu', '会员积分管理', 'user/scoreLog', 'user/scoreLog', 'el-icon-Discount', 'tab', '', '/src/views/backend/user/scoreLog/index.vue', 1, 'none', '', 90, '1', 1739733640, 1739733640),
(42, 41, 'button', '查看', 'user/scoreLog/index', '', '', NULL, '', '', 0, 'none', '', 0, '1', 1739733640, 1739733640),
(43, 41, 'button', '添加', 'user/scoreLog/add', '', '', NULL, '', '', 0, 'none', '', 0, '1', 1739733640, 1739733640),
(44, 0, 'menu_dir', '常规管理', 'routine', 'routine', 'fa fa-cogs', NULL, '', '', 0, 'none', '', 89, '1', 1739733640, 1739733640),
(45, 44, 'menu', '系统配置', 'routine/config', 'routine/config', 'el-icon-Tools', 'tab', '', '/src/views/backend/routine/config/index.vue', 1, 'none', '', 88, '1', 1739733640, 1739733640),
(46, 45, 'button', '查看', 'routine/config/index', '', '', NULL, '', '', 0, 'none', '', 0, '1', 1739733640, 1739733640),
(47, 45, 'button', '编辑', 'routine/config/edit', '', '', NULL, '', '', 0, 'none', '', 0, '1', 1739733640, 1739733640),
(48, 44, 'menu', '附件管理', 'routine/attachment', 'routine/attachment', 'fa fa-folder', 'tab', '', '/src/views/backend/routine/attachment/index.vue', 1, 'none', 'Remark lang', 87, '1', 1739733640, 1739733640),
(49, 48, 'button', '查看', 'routine/attachment/index', '', '', NULL, '', '', 0, 'none', '', 0, '1', 1739733640, 1739733640),
(50, 48, 'button', '编辑', 'routine/attachment/edit', '', '', NULL, '', '', 0, 'none', '', 0, '1', 1739733640, 1739733640),
(51, 48, 'button', '删除', 'routine/attachment/del', '', '', NULL, '', '', 0, 'none', '', 0, '1', 1739733640, 1739733640),
(52, 44, 'menu', '个人资料', 'routine/adminInfo', 'routine/adminInfo', 'fa fa-user', 'tab', '', '/src/views/backend/routine/adminInfo.vue', 1, 'none', '', 86, '1', 1739733640, 1739733640),
(53, 52, 'button', '查看', 'routine/adminInfo/index', '', '', NULL, '', '', 0, 'none', '', 0, '1', 1739733640, 1739733640),
(54, 52, 'button', '编辑', 'routine/adminInfo/edit', '', '', NULL, '', '', 0, 'none', '', 0, '1', 1739733640, 1739733640),
(55, 0, 'menu_dir', '数据安全管理', 'security', 'security', 'fa fa-shield', NULL, '', '', 0, 'none', '', 85, '1', 1739733640, 1739733640),
(56, 55, 'menu', '数据回收站', 'security/dataRecycleLog', 'security/dataRecycleLog', 'fa fa-database', 'tab', '', '/src/views/backend/security/dataRecycleLog/index.vue', 1, 'none', '', 84, '1', 1739733640, 1739733640),
(57, 56, 'button', '查看', 'security/dataRecycleLog/index', '', '', NULL, '', '', 0, 'none', '', 0, '1', 1739733640, 1739733640),
(58, 56, 'button', '删除', 'security/dataRecycleLog/del', '', '', NULL, '', '', 0, 'none', '', 0, '1', 1739733640, 1739733640),
(59, 56, 'button', '还原', 'security/dataRecycleLog/restore', '', '', NULL, '', '', 0, 'none', '', 0, '1', 1739733640, 1739733640),
(60, 56, 'button', '查看详情', 'security/dataRecycleLog/info', '', '', NULL, '', '', 0, 'none', '', 0, '1', 1739733640, 1739733640),
(61, 55, 'menu', '敏感数据修改记录', 'security/sensitiveDataLog', 'security/sensitiveDataLog', 'fa fa-expeditedssl', 'tab', '', '/src/views/backend/security/sensitiveDataLog/index.vue', 1, 'none', '', 83, '1', 1739733640, 1739733640),
(62, 61, 'button', '查看', 'security/sensitiveDataLog/index', '', '', NULL, '', '', 0, 'none', '', 0, '1', 1739733640, 1739733640),
(63, 61, 'button', '删除', 'security/sensitiveDataLog/del', '', '', NULL, '', '', 0, 'none', '', 0, '1', 1739733640, 1739733640),
(64, 61, 'button', '回滚', 'security/sensitiveDataLog/rollback', '', '', NULL, '', '', 0, 'none', '', 0, '1', 1739733640, 1739733640),
(65, 61, 'button', '查看详情', 'security/sensitiveDataLog/info', '', '', NULL, '', '', 0, 'none', '', 0, '1', 1739733640, 1739733640),
(66, 55, 'menu', '数据回收规则管理', 'security/dataRecycle', 'security/dataRecycle', 'fa fa-database', 'tab', '', '/src/views/backend/security/dataRecycle/index.vue', 1, 'none', 'Remark lang', 82, '1', 1739733640, 1739733640),
(67, 66, 'button', '查看', 'security/dataRecycle/index', '', '', NULL, '', '', 0, 'none', '', 0, '1', 1739733640, 1739733640),
(68, 66, 'button', '添加', 'security/dataRecycle/add', '', '', NULL, '', '', 0, 'none', '', 0, '1', 1739733640, 1739733640),
(69, 66, 'button', '编辑', 'security/dataRecycle/edit', '', '', NULL, '', '', 0, 'none', '', 0, '1', 1739733640, 1739733640),
(70, 66, 'button', '删除', 'security/dataRecycle/del', '', '', NULL, '', '', 0, 'none', '', 0, '1', 1739733640, 1739733640),
(71, 55, 'menu', '敏感字段规则管理', 'security/sensitiveData', 'security/sensitiveData', 'fa fa-expeditedssl', 'tab', '', '/src/views/backend/security/sensitiveData/index.vue', 1, 'none', 'Remark lang', 81, '1', 1739733640, 1739733640),
(72, 71, 'button', '查看', 'security/sensitiveData/index', '', '', NULL, '', '', 0, 'none', '', 0, '1', 1739733640, 1739733640),
(73, 71, 'button', '添加', 'security/sensitiveData/add', '', '', NULL, '', '', 0, 'none', '', 0, '1', 1739733640, 1739733640),
(74, 71, 'button', '编辑', 'security/sensitiveData/edit', '', '', NULL, '', '', 0, 'none', '', 0, '1', 1739733640, 1739733640),
(75, 71, 'button', '删除', 'security/sensitiveData/del', '', '', NULL, '', '', 0, 'none', '', 0, '1', 1739733640, 1739733640),
(77, 45, 'button', '添加', 'routine/config/add', '', '', NULL, '', '', 0, 'none', '', 0, '1', 1739733640, 1739733640),
(78, 0, 'menu', '模块市场', 'moduleStore/moduleStore', 'moduleStore', 'el-icon-GoodsFilled', 'tab', '', '/src/views/backend/module/index.vue', 1, 'none', '', 86, '1', 1739733640, 1739733640),
(79, 78, 'button', '查看', 'moduleStore/moduleStore/index', '', '', NULL, '', '', 0, 'none', '', 0, '1', 1739733640, 1739733640),
(80, 78, 'button', '安装', 'moduleStore/moduleStore/install', '', '', NULL, '', '', 0, 'none', '', 0, '1', 1739733640, 1739733640),
(81, 78, 'button', '调整状态', 'moduleStore/moduleStore/changeState', '', '', NULL, '', '', 0, 'none', '', 0, '1', 1739733640, 1739733640),
(82, 78, 'button', '卸载', 'moduleStore/moduleStore/uninstall', '', '', NULL, '', '', 0, 'none', '', 0, '1', 1739733640, 1739733640),
(83, 78, 'button', '更新', 'moduleStore/moduleStore/update', '', '', NULL, '', '', 0, 'none', '', 0, '1', 1739733640, 1739733640),
(84, 0, 'menu', 'CRUD代码生成', 'crud/crud', 'crud/crud', 'fa fa-code', 'tab', '', '/src/views/backend/crud/index.vue', 1, 'none', '', 80, '1', 1739733640, 1739733640),
(85, 84, 'button', '查看', 'crud/crud/index', '', '', NULL, '', '', 0, 'none', '', 0, '1', 1739733640, 1739733640),
(86, 84, 'button', '生成', 'crud/crud/generate', '', '', NULL, '', '', 0, 'none', '', 0, '1', 1739733640, 1739733640),
(87, 84, 'button', '删除', 'crud/crud/delete', '', '', NULL, '', '', 0, 'none', '', 0, '1', 1739733640, 1739733640),
(88, 45, 'button', '删除', 'routine/config/del', '', '', NULL, '', '', 0, 'none', '', 0, '1', 1739733640, 1739733640),
(89, 1, 'button', '查看', 'dashboard/index', '', '', NULL, '', '', 0, 'none', '', 0, '1', 1739733640, 1739733640),
(90, 0, 'menu', '插件管理', 'plugins', 'plugins', 'el-icon-Menu', 'tab', '', '/src/views/backend/plugins/index.vue', 1, 'none', '', 0, '1', 1739735893, 1739734511),
(91, 90, 'button', '查看', 'plugins/index', '', '', NULL, '', '', 0, 'none', '', 0, '1', 1739734511, 1739734511),
(92, 90, 'button', '添加', 'plugins/add', '', '', NULL, '', '', 0, 'none', '', 0, '1', 1739734511, 1739734511),
(93, 90, 'button', '编辑', 'plugins/edit', '', '', NULL, '', '', 0, 'none', '', 0, '1', 1739734511, 1739734511),
(94, 90, 'button', '删除', 'plugins/del', '', '', NULL, '', '', 0, 'none', '', 0, '1', 1739734511, 1739734511),
(95, 90, 'button', '快速排序', 'plugins/sortable', '', '', NULL, '', '', 0, 'none', '', 0, '1', 1739734511, 1739734511),
(96, 0, 'menu', '通道配置', 'channel', 'channel', 'el-icon-Postcard', 'tab', '', '/src/views/backend/channel/index.vue', 1, 'none', '', 0, '1', 1739742569, 1739736296),
(97, 96, 'button', '查看', 'channel/index', '', '', NULL, '', '', 0, 'none', '', 0, '1', 1739736296, 1739736296),
(98, 96, 'button', '添加', 'channel/add', '', '', NULL, '', '', 0, 'none', '', 0, '1', 1739736296, 1739736296),
(99, 96, 'button', '编辑', 'channel/edit', '', '', NULL, '', '', 0, 'none', '', 0, '1', 1739736296, 1739736296),
(100, 96, 'button', '删除', 'channel/del', '', '', NULL, '', '', 0, 'none', '', 0, '1', 1739736296, 1739736296),
(101, 96, 'button', '快速排序', 'channel/sortable', '', '', NULL, '', '', 0, 'none', '', 0, '1', 1739736296, 1739736296),
(102, 0, 'menu', '订单管理', 'order', 'order', 'el-icon-Fold', 'tab', '', '/src/views/backend/order/index.vue', 1, 'none', '', 0, '1', 1739742554, 1739742270),
(103, 102, 'button', '查看', 'order/index', '', '', NULL, '', '', 0, 'none', '', 0, '1', 1739742270, 1739742270),
(104, 102, 'button', '添加', 'order/add', '', '', NULL, '', '', 0, 'none', '', 0, '1', 1739742270, 1739742270),
(105, 102, 'button', '编辑', 'order/edit', '', '', NULL, '', '', 0, 'none', '', 0, '1', 1739742270, 1739742270),
(106, 102, 'button', '删除', 'order/del', '', '', NULL, '', '', 0, 'none', '', 0, '1', 1739742270, 1739742270),
(107, 102, 'button', '快速排序', 'order/sortable', '', '', NULL, '', '', 0, 'none', '', 0, '1', 1739742270, 1739742270),
(133, 0, 'menu', '收款码模板', 'template', 'template', '', 'tab', '', '/src/views/backend/template/index.vue', 0, 'none', '', 0, '0', 1739852871, 1739747822),
(134, 133, 'button', '查看', 'template/index', '', '', NULL, '', '', 0, 'none', '', 0, '1', 1739747822, 1739747822),
(135, 133, 'button', '添加', 'template/add', '', '', NULL, '', '', 0, 'none', '', 0, '1', 1739747822, 1739747822),
(136, 133, 'button', '编辑', 'template/edit', '', '', NULL, '', '', 0, 'none', '', 0, '1', 1739747822, 1739747822),
(137, 133, 'button', '删除', 'template/del', '', '', NULL, '', '', 0, 'none', '', 0, '1', 1739747822, 1739747822),
(138, 133, 'button', '快速排序', 'template/sortable', '', '', NULL, '', '', 0, 'none', '', 0, '1', 1739747822, 1739747822),
(139, 0, 'menu', '收款码管理', 'qrcode', 'qrcode', 'el-icon-Cellphone', 'tab', '', '/src/views/backend/qrcode/index.vue', 1, 'none', '', 0, '1', 1739870374, 1739750397),
(140, 139, 'button', '查看', 'qrcode/index', '', '', NULL, '', '', 0, 'none', '', 0, '1', 1739750397, 1739750397),
(141, 139, 'button', '添加', 'qrcode/add', '', '', NULL, '', '', 0, 'none', '', 0, '1', 1739750397, 1739750397),
(142, 139, 'button', '编辑', 'qrcode/edit', '', '', NULL, '', '', 0, 'none', '', 0, '1', 1739750397, 1739750397),
(143, 139, 'button', '删除', 'qrcode/del', '', '', NULL, '', '', 0, 'none', '', 0, '1', 1739750397, 1739750397),
(144, 139, 'button', '快速排序', 'qrcode/sortable', '', '', NULL, '', '', 0, 'none', '', 0, '1', 1739750397, 1739750397),
(145, 0, 'menu', '访问记录', 'qrcodelog', 'qrcodelog', 'el-icon-Memo', 'tab', '', '/src/views/backend/qrcodelog/index.vue', 1, 'none', '', 0, '1', 1739870294, 1739808030),
(146, 145, 'button', '查看', 'qrcodelog/index', '', '', NULL, '', '', 0, 'none', '', 0, '1', 1739808030, 1739808030),
(147, 145, 'button', '添加', 'qrcodelog/add', '', '', NULL, '', '', 0, 'none', '', 0, '1', 1739808030, 1739808030),
(148, 145, 'button', '编辑', 'qrcodelog/edit', '', '', NULL, '', '', 0, 'none', '', 0, '1', 1739808030, 1739808030),
(149, 145, 'button', '删除', 'qrcodelog/del', '', '', NULL, '', '', 0, 'none', '', 0, '1', 1739808030, 1739808030),
(150, 145, 'button', '快速排序', 'qrcodelog/sortable', '', '', NULL, '', '', 0, 'none', '', 0, '1', 1739808030, 1739808030);

-- --------------------------------------------------------

--
-- 表的结构 `pay_area`
--

CREATE TABLE `pay_area` (
  `id` int UNSIGNED NOT NULL COMMENT 'ID',
  `pid` int UNSIGNED DEFAULT NULL COMMENT '父id',
  `shortname` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '简称',
  `name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '名称',
  `mergename` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '全称',
  `level` tinyint UNSIGNED DEFAULT NULL COMMENT '层级:1=省,2=市,3=区/县',
  `pinyin` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '拼音',
  `code` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '长途区号',
  `zip` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '邮编',
  `first` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '首字母',
  `lng` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '经度',
  `lat` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '纬度'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='省份地区表' ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- 表的结构 `pay_attachment`
--

CREATE TABLE `pay_attachment` (
  `id` int UNSIGNED NOT NULL COMMENT 'ID',
  `topic` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '细目',
  `admin_id` int UNSIGNED NOT NULL DEFAULT '0' COMMENT '上传管理员ID',
  `user_id` int UNSIGNED NOT NULL DEFAULT '0' COMMENT '上传用户ID',
  `url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '物理路径',
  `width` int UNSIGNED NOT NULL DEFAULT '0' COMMENT '宽度',
  `height` int UNSIGNED NOT NULL DEFAULT '0' COMMENT '高度',
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '原始名称',
  `size` int UNSIGNED NOT NULL DEFAULT '0' COMMENT '大小',
  `mimetype` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'mime类型',
  `quote` int UNSIGNED NOT NULL DEFAULT '0' COMMENT '上传(引用)次数',
  `storage` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '存储方式',
  `sha1` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'sha1编码',
  `create_time` bigint UNSIGNED DEFAULT NULL COMMENT '创建时间',
  `last_upload_time` bigint UNSIGNED DEFAULT NULL COMMENT '最后上传时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='附件表' ROW_FORMAT=DYNAMIC;

--
-- 转存表中的数据 `pay_attachment`
--

INSERT INTO `pay_attachment` (`id`, `topic`, `admin_id`, `user_id`, `url`, `width`, `height`, `name`, `size`, `mimetype`, `quote`, `storage`, `sha1`, `create_time`, `last_upload_time`) VALUES
(1, 'default', 1, 0, '/storage/default/20250217/xmwechat-instal40b5bd76e13dc67d6257f3cb67874df5d16f3990.zip', 0, 0, 'xmwechat-install.zip', 9663, 'application/zip', 2, 'local', '40b5bd76e13dc67d6257f3cb67874df5d16f3990', 1739747348, 1739747381);

-- --------------------------------------------------------

--
-- 表的结构 `pay_captcha`
--

CREATE TABLE `pay_captcha` (
  `key` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '验证码Key',
  `code` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '验证码(加密后)',
  `captcha` text COLLATE utf8mb4_unicode_ci COMMENT '验证码数据',
  `create_time` bigint UNSIGNED DEFAULT NULL COMMENT '创建时间',
  `expire_time` bigint UNSIGNED DEFAULT NULL COMMENT '过期时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='验证码表' ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- 表的结构 `pay_channel`
--

CREATE TABLE `pay_channel` (
  `id` int NOT NULL COMMENT 'ID',
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '通道名称',
  `plugin_id` int NOT NULL COMMENT '关联插件ID',
  `config` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '支付参数配置信息',
  `min_amount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '最小支付金额',
  `max_amount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '最大支付金额',
  `priority` int NOT NULL DEFAULT '0' COMMENT '优先级',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态:0=禁用,1=启用',
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注说明',
  `create_time` int NOT NULL COMMENT '创建时间',
  `update_time` int NOT NULL COMMENT '更新时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='支付通道配置表' ROW_FORMAT=DYNAMIC;

--
-- 转存表中的数据 `pay_channel`
--
DELETE FROM `pay_channel`;
-- --------------------------------------------------------

--
-- 表的结构 `pay_config`
--

CREATE TABLE `pay_config` (
  `id` int UNSIGNED NOT NULL COMMENT 'ID',
  `name` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '变量名',
  `group` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '分组',
  `title` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '变量标题',
  `tip` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '变量描述',
  `type` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '变量输入组件类型',
  `value` longtext COLLATE utf8mb4_unicode_ci COMMENT '变量值',
  `content` longtext COLLATE utf8mb4_unicode_ci COMMENT '字典数据',
  `rule` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '验证规则',
  `extend` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '扩展属性',
  `allow_del` tinyint UNSIGNED NOT NULL DEFAULT '0' COMMENT '允许删除:0=否,1=是',
  `weigh` int NOT NULL DEFAULT '0' COMMENT '权重'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='系统配置' ROW_FORMAT=DYNAMIC;

--
-- 转存表中的数据 `pay_config`
--

INSERT INTO `pay_config` (`id`, `name`, `group`, `title`, `tip`, `type`, `value`, `content`, `rule`, `extend`, `allow_del`, `weigh`) VALUES
(1, 'config_group', 'basics', 'Config group', '', 'array', '[{\"key\":\"basics\",\"value\":\"Basics\"},{\"key\":\"mail\",\"value\":\"Mail\"},{\"key\":\"config_quick_entrance\",\"value\":\"Config Quick entrance\"},{\"key\":\"contact\",\"value\":\"\\u8054\\u7cfb\\u65b9\\u5f0f\"}]', NULL, 'required', '', 0, -1),
(2, 'site_name', 'basics', 'Site Name', '', 'string', 'JFuPay', NULL, 'required', '', 0, 99),
(3, 'record_number', 'basics', 'Record number', '域名备案号', 'string', '渝ICP备8888888号-1', NULL, '', '', 0, 0),
(4, 'version', 'basics', 'Version number', '系统版本号', 'string', 'v1.0.0', NULL, 'required', '', 0, 0),
(5, 'time_zone', 'basics', 'time zone', '', 'string', 'Asia/Shanghai', NULL, 'required', '', 0, 0),
(6, 'no_access_ip', 'basics', 'No access ip', '禁止访问站点的ip列表,一行一个', 'textarea', '', NULL, '', '', 0, 0),
(7, 'smtp_server', 'mail', 'smtp server', '', 'string', 'smtp.qq.com', NULL, '', '', 0, 9),
(8, 'smtp_port', 'mail', 'smtp port', '', 'string', '465', NULL, '', '', 0, 8),
(9, 'smtp_user', 'mail', 'smtp user', '', 'string', NULL, NULL, '', '', 0, 7),
(10, 'smtp_pass', 'mail', 'smtp pass', '', 'string', NULL, NULL, '', '', 0, 6),
(11, 'smtp_verification', 'mail', 'smtp verification', '', 'select', 'SSL', '{\"SSL\":\"SSL\",\"TLS\":\"TLS\"}', '', '', 0, 5),
(12, 'smtp_sender_mail', 'mail', 'smtp sender mail', '', 'string', NULL, NULL, 'email', '', 0, 4),
(13, 'config_quick_entrance', 'config_quick_entrance', 'Config Quick entrance', '', 'array', '[{\"key\":\"\\u6570\\u636e\\u56de\\u6536\\u89c4\\u5219\\u914d\\u7f6e\",\"value\":\"security\\/dataRecycle\"},{\"key\":\"\\u654f\\u611f\\u6570\\u636e\\u89c4\\u5219\\u914d\\u7f6e\",\"value\":\"security\\/sensitiveData\"}]', NULL, '', '', 0, 0),
(14, 'backend_entrance', 'basics', 'Backend entrance', '', 'string', '/admin', NULL, 'required', '', 0, 1),
(15, 'contact_qq', 'contact', '联系QQ', '联系QQ', 'string', '', NULL, '', '', 1, 5),
(16, 'contact_wechat', 'contact', '联系微信', '联系微信', 'string', '', NULL, '', '', 1, 4),
(17, 'contact_email', 'contact', '联系邮箱', '联系邮箱', 'string', '', NULL, '', '', 1, 3);

-- --------------------------------------------------------

--
-- 表的结构 `pay_crud_log`
--

CREATE TABLE `pay_crud_log` (
  `id` int UNSIGNED NOT NULL COMMENT 'ID',
  `table_name` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '数据表名',
  `table` text COLLATE utf8mb4_unicode_ci COMMENT '数据表数据',
  `fields` text COLLATE utf8mb4_unicode_ci COMMENT '字段数据',
  `status` enum('delete','success','error','start') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'start' COMMENT '状态:delete=已删除,success=成功,error=失败,start=生成中',
  `connection` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '数据库连接配置标识',
  `create_time` bigint UNSIGNED DEFAULT NULL COMMENT '创建时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='CRUD记录表' ROW_FORMAT=DYNAMIC;

--
-- 转存表中的数据 `pay_crud_log`
--

INSERT INTO `pay_crud_log` (`id`, `table_name`, `table`, `fields`, `status`, `connection`, `create_time`) VALUES
(1, 'plugins', '{\"name\":\"plugins\",\"comment\":\"插件列表\",\"quickSearchField\":[\"id\"],\"defaultSortField\":\"id\",\"formFields\":[\"plugin_name\",\"class_name\",\"author\",\"website\",\"status\"],\"columnFields\":[\"id\",\"plugin_name\",\"class_name\",\"author\",\"status\",\"update_time\",\"create_time\"],\"defaultSortType\":\"desc\",\"generateRelativePath\":\"plugins\",\"isCommonModel\":\"1\",\"modelFile\":\"app\\/common\\/model\\/Plugins.php\",\"controllerFile\":\"app\\/admin\\/controller\\/Plugins.php\",\"validateFile\":\"app\\/common\\/validate\\/Plugins.php\",\"webViewsDir\":\"web\\/src\\/views\\/backend\\/plugins\",\"databaseConnection\":null,\"designChange\":[],\"rebuild\":\"No\"}', '[{\"title\":\"主键\",\"name\":\"id\",\"comment\":\"ID\",\"designType\":\"pk\",\"formBuildExclude\":\"1\",\"table\":{\"width\":\"70\",\"operator\":\"RANGE\",\"sortable\":\"custom\"},\"form\":[],\"type\":\"int\",\"length\":\"10\",\"precision\":\"0\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"1\",\"unsigned\":\"1\",\"autoIncrement\":\"1\"},{\"title\":\"字符串\",\"name\":\"plugin_name\",\"comment\":\"插件名称\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[\"required\"],\"validatorMsg\":\"\"},\"type\":\"varchar\",\"length\":\"255\",\"precision\":\"0\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\"},{\"title\":\"字符串\",\"name\":\"class_name\",\"comment\":\"类名\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[\"required\"],\"validatorMsg\":\"\"},\"type\":\"varchar\",\"length\":\"255\",\"precision\":\"0\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\"},{\"title\":\"字符串\",\"name\":\"author\",\"comment\":\"作者\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[\"required\"],\"validatorMsg\":\"\"},\"type\":\"varchar\",\"length\":\"255\",\"precision\":\"0\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\"},{\"title\":\"字符串\",\"name\":\"website\",\"comment\":\"网站\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[\"required\"],\"validatorMsg\":\"\"},\"type\":\"varchar\",\"length\":\"255\",\"precision\":\"0\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\"},{\"title\":\"状态\",\"name\":\"status\",\"comment\":\"状态:0=禁用,1=启用\",\"designType\":\"switch\",\"table\":{\"render\":\"switch\",\"operator\":\"eq\",\"sortable\":\"false\"},\"form\":{\"validator\":[\"required\"],\"validatorMsg\":\"\"},\"type\":\"tinyint\",\"length\":\"1\",\"precision\":\"0\",\"default\":\"1\",\"defaultType\":\"INPUT\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"1\",\"autoIncrement\":\"\"},{\"title\":\"修改时间\",\"name\":\"update_time\",\"comment\":\"修改时间\",\"designType\":\"timestamp\",\"formBuildExclude\":\"1\",\"table\":{\"render\":\"datetime\",\"operator\":\"RANGE\",\"sortable\":\"custom\",\"width\":\"160\",\"timeFormat\":\"yyyy-mm-dd hh:MM:ss\"},\"form\":{\"validator\":[\"date\"],\"validatorMsg\":\"\"},\"type\":\"bigint\",\"length\":\"16\",\"precision\":\"0\",\"defaultType\":\"NULL\",\"null\":\"1\",\"primaryKey\":\"\",\"unsigned\":\"1\",\"autoIncrement\":\"\"},{\"title\":\"创建时间\",\"name\":\"create_time\",\"comment\":\"创建时间\",\"designType\":\"timestamp\",\"formBuildExclude\":\"1\",\"table\":{\"render\":\"datetime\",\"operator\":\"RANGE\",\"sortable\":\"custom\",\"width\":\"160\",\"timeFormat\":\"yyyy-mm-dd hh:MM:ss\"},\"form\":{\"validator\":[\"date\"],\"validatorMsg\":\"\"},\"type\":\"bigint\",\"length\":\"16\",\"precision\":\"0\",\"defaultType\":\"NULL\",\"null\":\"1\",\"primaryKey\":\"\",\"unsigned\":\"1\",\"autoIncrement\":\"\"}]', 'success', 'mysql', 1739734511),
(2, 'channel', '{\"name\":\"channel\",\"comment\":\"支付通道配置表\",\"quickSearchField\":[\"id\"],\"defaultSortField\":\"id\",\"formFields\":[\"name\",\"plugin_id\",\"config\",\"min_amount\",\"max_amount\",\"priority\",\"status\",\"remark\"],\"columnFields\":[\"id\",\"name\",\"plugin_id\",\"min_amount\",\"max_amount\",\"priority\",\"status\",\"remark\",\"create_time\",\"update_time\"],\"defaultSortType\":\"desc\",\"generateRelativePath\":\"channel\",\"isCommonModel\":\"1\",\"modelFile\":\"app\\/common\\/model\\/Channel.php\",\"controllerFile\":\"app\\/admin\\/controller\\/Channel.php\",\"validateFile\":\"app\\/common\\/validate\\/Channel.php\",\"webViewsDir\":\"web\\/src\\/views\\/backend\\/channel\",\"databaseConnection\":null,\"designChange\":[],\"rebuild\":\"Yes\"}', '[{\"name\":\"id\",\"type\":\"int\",\"dataType\":\"int\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"1\",\"unsigned\":\"\",\"autoIncrement\":\"1\",\"comment\":\"ID\",\"designType\":\"pk\",\"table\":{\"width\":\"70\",\"operator\":\"RANGE\",\"sortable\":\"custom\"},\"form\":[]},{\"name\":\"name\",\"type\":\"varchar\",\"dataType\":\"varchar(100)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"通道名称\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"remark\",\"type\":\"varchar\",\"dataType\":\"varchar(255)\",\"default\":\"\",\"defaultType\":\"NULL\",\"null\":\"1\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"备注说明\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"plugin_id\",\"type\":\"int\",\"dataType\":\"int\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"关联插件ID\",\"designType\":\"remoteSelect\",\"table\":{\"operator\":\"LIKE\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\",\"select-multi\":\"\",\"remote-pk\":\"id\",\"remote-field\":\"plugin_name\",\"remote-table\":\"plugins\",\"remote-controller\":\"app\\/admin\\/controller\\/Plugins.php\",\"remote-model\":\"app\\/common\\/model\\/Plugins.php\",\"relation-fields\":\"plugin_name\",\"remote-url\":\"\",\"remote-primary-table-alias\":\"\",\"remote-source-config-type\":\"crud\"}},{\"name\":\"config\",\"type\":\"text\",\"dataType\":\"text\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"支付参数配置信息\",\"designType\":\"textarea\",\"table\":{\"operator\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\",\"rows\":\"3\"}},{\"name\":\"min_amount\",\"type\":\"decimal\",\"dataType\":\"decimal(10,2)\",\"default\":\"0.00\",\"defaultType\":\"INPUT\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"最小支付金额\",\"designType\":\"number\",\"table\":{\"render\":\"none\",\"operator\":\"RANGE\",\"sortable\":\"false\"},\"form\":{\"validator\":[\"number\"],\"validatorMsg\":\"\",\"step\":\"1\"}},{\"name\":\"max_amount\",\"type\":\"decimal\",\"dataType\":\"decimal(10,2)\",\"default\":\"0.00\",\"defaultType\":\"INPUT\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"最大支付金额\",\"designType\":\"number\",\"table\":{\"render\":\"none\",\"operator\":\"RANGE\",\"sortable\":\"false\"},\"form\":{\"validator\":[\"number\"],\"validatorMsg\":\"\",\"step\":\"1\"}},{\"name\":\"priority\",\"type\":\"int\",\"dataType\":\"int\",\"default\":\"0\",\"defaultType\":\"INPUT\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"优先级(数字越大优先级越高)\",\"designType\":\"number\",\"table\":{\"render\":\"none\",\"operator\":\"RANGE\",\"sortable\":\"false\"},\"form\":{\"validator\":[\"number\"],\"validatorMsg\":\"\",\"step\":\"1\"}},{\"name\":\"status\",\"type\":\"tinyint\",\"dataType\":\"tinyint(1)\",\"default\":\"1\",\"defaultType\":\"INPUT\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"状态:0=禁用,1=启用\",\"designType\":\"radio\",\"table\":{\"render\":\"tag\",\"operator\":\"eq\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"create_time\",\"type\":\"int\",\"dataType\":\"int\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"创建时间\",\"designType\":\"timestamp\",\"table\":{\"render\":\"datetime\",\"operator\":\"RANGE\",\"sortable\":\"custom\",\"width\":\"160\",\"timeFormat\":\"yyyy-mm-dd hh:MM:ss\"},\"form\":{\"validator\":[\"date\"],\"validatorMsg\":\"\"}},{\"name\":\"update_time\",\"type\":\"int\",\"dataType\":\"int\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"更新时间\",\"designType\":\"timestamp\",\"table\":{\"render\":\"datetime\",\"operator\":\"RANGE\",\"sortable\":\"custom\",\"width\":\"160\",\"timeFormat\":\"yyyy-mm-dd hh:MM:ss\"},\"form\":{\"validator\":[\"date\"],\"validatorMsg\":\"\"}}]', 'success', 'mysql', 1739736296),
(3, 'channel', '{\"name\":\"channel\",\"comment\":\"支付通道配置表\",\"quickSearchField\":[\"id\"],\"defaultSortField\":\"id\",\"formFields\":[\"name\",\"plugin_id\",\"config\",\"min_amount\",\"max_amount\",\"priority\",\"status\",\"remark\"],\"columnFields\":[\"id\",\"name\",\"plugin_id\",\"min_amount\",\"max_amount\",\"priority\",\"status\",\"remark\",\"create_time\",\"update_time\"],\"defaultSortType\":\"desc\",\"generateRelativePath\":\"channel\",\"isCommonModel\":\"1\",\"modelFile\":\"app\\/common\\/model\\/Channel.php\",\"controllerFile\":\"app\\/admin\\/controller\\/Channel.php\",\"validateFile\":\"app\\/common\\/validate\\/Channel.php\",\"webViewsDir\":\"web\\/src\\/views\\/backend\\/channel\",\"databaseConnection\":null,\"designChange\":[{\"type\":\"change-field-order\",\"index\":\"8\",\"newName\":\"\",\"oldName\":\"remark\",\"after\":\"status\",\"sync\":\"1\"},{\"type\":\"change-field-attr\",\"index\":\"6\",\"oldName\":\"priority\",\"newName\":\"\",\"sync\":\"1\"}],\"rebuild\":\"Yes\",\"empty\":\"1\"}', '[{\"name\":\"id\",\"type\":\"int\",\"dataType\":\"int\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"1\",\"unsigned\":\"\",\"autoIncrement\":\"1\",\"comment\":\"ID\",\"designType\":\"pk\",\"table\":{\"width\":\"70\",\"operator\":\"RANGE\",\"sortable\":\"custom\"},\"form\":[]},{\"name\":\"name\",\"type\":\"varchar\",\"dataType\":\"varchar(100)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"通道名称\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"plugin_id\",\"type\":\"int\",\"dataType\":\"int\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"关联插件ID\",\"designType\":\"remoteSelect\",\"table\":{\"operator\":\"LIKE\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\",\"select-multi\":\"\",\"remote-pk\":\"id\",\"remote-field\":\"plugin_name\",\"remote-table\":\"plugins\",\"remote-controller\":\"app\\/admin\\/controller\\/Plugins.php\",\"remote-model\":\"app\\/common\\/model\\/Plugins.php\",\"relation-fields\":\"plugin_name\",\"remote-url\":\"\",\"remote-primary-table-alias\":\"\",\"remote-source-config-type\":\"crud\"}},{\"name\":\"config\",\"type\":\"text\",\"dataType\":\"text\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"支付参数配置信息\",\"designType\":\"textarea\",\"table\":{\"operator\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\",\"rows\":\"3\"}},{\"name\":\"min_amount\",\"type\":\"decimal\",\"dataType\":\"decimal(10,2)\",\"default\":\"0.00\",\"defaultType\":\"INPUT\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"最小支付金额\",\"designType\":\"number\",\"table\":{\"render\":\"none\",\"operator\":\"RANGE\",\"sortable\":\"false\"},\"form\":{\"validator\":[\"number\"],\"validatorMsg\":\"\",\"step\":\"1\"}},{\"name\":\"max_amount\",\"type\":\"decimal\",\"dataType\":\"decimal(10,2)\",\"default\":\"0.00\",\"defaultType\":\"INPUT\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"最大支付金额\",\"designType\":\"number\",\"table\":{\"render\":\"none\",\"operator\":\"RANGE\",\"sortable\":\"false\"},\"form\":{\"validator\":[\"number\"],\"validatorMsg\":\"\",\"step\":\"1\"}},{\"name\":\"priority\",\"type\":\"int\",\"dataType\":\"int\",\"default\":\"0\",\"defaultType\":\"INPUT\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"优先级\",\"designType\":\"number\",\"table\":{\"render\":\"none\",\"operator\":\"RANGE\",\"sortable\":\"false\"},\"form\":{\"validator\":[\"number\"],\"validatorMsg\":\"\",\"step\":\"1\"}},{\"name\":\"status\",\"type\":\"tinyint\",\"dataType\":\"tinyint(1)\",\"default\":\"1\",\"defaultType\":\"INPUT\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"状态:0=禁用,1=启用\",\"designType\":\"radio\",\"table\":{\"render\":\"tag\",\"operator\":\"eq\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"remark\",\"type\":\"varchar\",\"dataType\":\"varchar(255)\",\"default\":\"\",\"defaultType\":\"NULL\",\"null\":\"1\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"备注说明\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"create_time\",\"type\":\"int\",\"dataType\":\"int\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"创建时间\",\"designType\":\"timestamp\",\"table\":{\"render\":\"datetime\",\"operator\":\"RANGE\",\"sortable\":\"custom\",\"width\":\"160\",\"timeFormat\":\"yyyy-mm-dd hh:MM:ss\"},\"form\":{\"validator\":[\"date\"],\"validatorMsg\":\"\"}},{\"name\":\"update_time\",\"type\":\"int\",\"dataType\":\"int\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"更新时间\",\"designType\":\"timestamp\",\"table\":{\"render\":\"datetime\",\"operator\":\"RANGE\",\"sortable\":\"custom\",\"width\":\"160\",\"timeFormat\":\"yyyy-mm-dd hh:MM:ss\"},\"form\":{\"validator\":[\"date\"],\"validatorMsg\":\"\"}}]', 'success', 'mysql', 1739736350),
(4, 'order', '{\"name\":\"order\",\"comment\":\"支付订单表\",\"quickSearchField\":[\"id\"],\"defaultSortField\":\"id\",\"formFields\":[\"order_no\",\"trade_no\",\"channel_id\",\"amount\",\"currency\",\"client_ip\",\"device\",\"subject\",\"body\",\"extra\",\"merchant_id\",\"merchant_order_no\",\"notify_url\",\"return_url\",\"status\",\"pay_time\",\"pay_amount\",\"refund_amount\",\"notify_time\",\"notify_status\",\"notify_count\",\"error_msg\",\"user_agent\",\"source\"],\"columnFields\":[\"id\",\"order_no\",\"trade_no\",\"channel_id\",\"amount\",\"currency\",\"subject\",\"merchant_id\",\"merchant_order_no\",\"status\",\"pay_time\",\"notify_time\",\"notify_status\",\"notify_count\",\"create_time\",\"update_time\",\"source\"],\"defaultSortType\":\"desc\",\"generateRelativePath\":\"order\",\"isCommonModel\":\"1\",\"modelFile\":\"app\\/common\\/model\\/Order.php\",\"controllerFile\":\"app\\/admin\\/controller\\/Order.php\",\"validateFile\":\"app\\/common\\/validate\\/Order.php\",\"webViewsDir\":\"web\\/src\\/views\\/backend\\/order\",\"databaseConnection\":null,\"designChange\":[{\"type\":\"add-field\",\"index\":\"25\",\"newName\":\"source\",\"oldName\":\"\",\"after\":\"source\",\"sync\":\"1\"},{\"type\":\"del-field\",\"oldName\":\"source\",\"newName\":\"\",\"sync\":\"1\"}],\"rebuild\":\"Yes\"}', '[{\"name\":\"id\",\"type\":\"int\",\"dataType\":\"int\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"1\",\"unsigned\":\"1\",\"autoIncrement\":\"1\",\"comment\":\"订单ID\",\"designType\":\"pk\",\"table\":{\"width\":\"70\",\"operator\":\"RANGE\",\"sortable\":\"custom\"},\"form\":[]},{\"name\":\"order_no\",\"type\":\"varchar\",\"dataType\":\"varchar(32)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"订单号\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"trade_no\",\"type\":\"varchar\",\"dataType\":\"varchar(64)\",\"default\":\"\",\"defaultType\":\"NULL\",\"null\":\"1\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"交易号(第三方支付平台)\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"channel_id\",\"type\":\"int\",\"dataType\":\"int\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"支付通道ID\",\"designType\":\"remoteSelect\",\"table\":{\"operator\":\"LIKE\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\",\"select-multi\":\"\",\"remote-pk\":\"id\",\"remote-field\":\"name\",\"remote-table\":\"channel\",\"remote-controller\":\"app\\/admin\\/controller\\/Channel.php\",\"remote-model\":\"app\\/common\\/model\\/Channel.php\",\"relation-fields\":\"name\",\"remote-url\":\"\",\"remote-primary-table-alias\":\"\",\"remote-source-config-type\":\"crud\"}},{\"name\":\"amount\",\"type\":\"decimal\",\"dataType\":\"decimal(10,2)\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"支付金额\",\"designType\":\"number\",\"table\":{\"render\":\"none\",\"operator\":\"RANGE\",\"sortable\":\"false\"},\"form\":{\"validator\":[\"number\"],\"validatorMsg\":\"\",\"step\":\"1\"}},{\"name\":\"currency\",\"type\":\"varchar\",\"dataType\":\"varchar(3)\",\"default\":\"CNY\",\"defaultType\":\"INPUT\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"货币类型\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"client_ip\",\"type\":\"varchar\",\"dataType\":\"varchar(45)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"客户端IP\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"device\",\"type\":\"varchar\",\"dataType\":\"varchar(64)\",\"default\":\"\",\"defaultType\":\"NULL\",\"null\":\"1\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"设备信息\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"subject\",\"type\":\"varchar\",\"dataType\":\"varchar(255)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"商品标题\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"body\",\"type\":\"varchar\",\"dataType\":\"varchar(255)\",\"default\":\"\",\"defaultType\":\"NULL\",\"null\":\"1\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"商品描述\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"extra\",\"type\":\"text\",\"dataType\":\"text\",\"default\":\"\",\"defaultType\":\"NULL\",\"null\":\"1\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"额外参数\",\"designType\":\"textarea\",\"table\":{\"operator\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\",\"rows\":\"3\"}},{\"name\":\"merchant_id\",\"type\":\"int\",\"dataType\":\"int\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"商户ID\",\"designType\":\"remoteSelect\",\"table\":{\"operator\":\"LIKE\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\",\"select-multi\":\"\",\"remote-pk\":\"id\",\"remote-field\":\"username\",\"remote-table\":\"user\",\"remote-controller\":\"app\\/admin\\/controller\\/user\\/User.php\",\"remote-model\":\"app\\/admin\\/model\\/User.php\",\"relation-fields\":\"username\",\"remote-url\":\"\",\"remote-primary-table-alias\":\"\",\"remote-source-config-type\":\"crud\"}},{\"name\":\"merchant_order_no\",\"type\":\"varchar\",\"dataType\":\"varchar(32)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"商户订单号\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"notify_url\",\"type\":\"varchar\",\"dataType\":\"varchar(255)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"异步通知地址\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"return_url\",\"type\":\"varchar\",\"dataType\":\"varchar(255)\",\"default\":\"\",\"defaultType\":\"NULL\",\"null\":\"1\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"同步跳转地址\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"status\",\"type\":\"tinyint\",\"dataType\":\"tinyint(1)\",\"default\":\"0\",\"defaultType\":\"INPUT\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"状态:0=未支付,1=已支付,2=已关闭,3=已退款,4=部分退款\",\"designType\":\"radio\",\"table\":{\"render\":\"tag\",\"operator\":\"eq\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"pay_time\",\"type\":\"int\",\"dataType\":\"int\",\"default\":\"\",\"defaultType\":\"NULL\",\"null\":\"1\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"支付时间\",\"designType\":\"timestamp\",\"table\":{\"render\":\"datetime\",\"operator\":\"RANGE\",\"sortable\":\"custom\",\"width\":\"160\",\"timeFormat\":\"yyyy-mm-dd hh:MM:ss\"},\"form\":{\"validator\":[\"date\"],\"validatorMsg\":\"\"}},{\"name\":\"pay_amount\",\"type\":\"decimal\",\"dataType\":\"decimal(10,2)\",\"default\":\"\",\"defaultType\":\"NULL\",\"null\":\"1\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"实际支付金额\",\"designType\":\"number\",\"table\":{\"render\":\"none\",\"operator\":\"RANGE\",\"sortable\":\"false\"},\"form\":{\"validator\":[\"number\"],\"validatorMsg\":\"\",\"step\":\"1\"}},{\"name\":\"refund_amount\",\"type\":\"decimal\",\"dataType\":\"decimal(10,2)\",\"default\":\"0.00\",\"defaultType\":\"INPUT\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"已退款金额\",\"designType\":\"number\",\"table\":{\"render\":\"none\",\"operator\":\"RANGE\",\"sortable\":\"false\"},\"form\":{\"validator\":[\"number\"],\"validatorMsg\":\"\",\"step\":\"1\"}},{\"name\":\"notify_time\",\"type\":\"int\",\"dataType\":\"int\",\"default\":\"\",\"defaultType\":\"NULL\",\"null\":\"1\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"通知时间\",\"designType\":\"timestamp\",\"table\":{\"render\":\"datetime\",\"operator\":\"RANGE\",\"sortable\":\"custom\",\"width\":\"160\",\"timeFormat\":\"yyyy-mm-dd hh:MM:ss\"},\"form\":{\"validator\":[\"date\"],\"validatorMsg\":\"\"}},{\"name\":\"notify_status\",\"type\":\"tinyint\",\"dataType\":\"tinyint(1)\",\"default\":\"0\",\"defaultType\":\"INPUT\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"通知状态:0=未通知,1=通知成功,2=通知失败\",\"designType\":\"radio\",\"table\":{\"render\":\"tag\",\"operator\":\"eq\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"notify_count\",\"type\":\"int\",\"dataType\":\"int\",\"default\":\"0\",\"defaultType\":\"INPUT\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"通知次数\",\"designType\":\"number\",\"table\":{\"render\":\"none\",\"operator\":\"RANGE\",\"sortable\":\"false\"},\"form\":{\"validator\":[\"number\"],\"validatorMsg\":\"\",\"step\":\"1\"}},{\"name\":\"error_msg\",\"type\":\"varchar\",\"dataType\":\"varchar(255)\",\"default\":\"\",\"defaultType\":\"NULL\",\"null\":\"1\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"错误信息\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"user_agent\",\"type\":\"varchar\",\"dataType\":\"varchar(255)\",\"default\":\"\",\"defaultType\":\"NULL\",\"null\":\"1\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"User Agent\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"title\":\"单选框\",\"name\":\"source\",\"dataType\":\"enum(\'1\',\'2\')\",\"comment\":\"来源:1=收款码,2=API\",\"designType\":\"radio\",\"table\":{\"render\":\"tag\",\"operator\":\"eq\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"},\"type\":\"enum\",\"length\":\"0\",\"precision\":\"0\",\"defaultType\":\"INPUT\",\"null\":\"1\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"default\":\"1\"},{\"name\":\"create_time\",\"type\":\"int\",\"dataType\":\"int\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"创建时间\",\"designType\":\"timestamp\",\"table\":{\"render\":\"datetime\",\"operator\":\"RANGE\",\"sortable\":\"custom\",\"width\":\"160\",\"timeFormat\":\"yyyy-mm-dd hh:MM:ss\"},\"form\":{\"validator\":[\"date\"],\"validatorMsg\":\"\"}},{\"name\":\"update_time\",\"type\":\"int\",\"dataType\":\"int\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"更新时间\",\"designType\":\"timestamp\",\"table\":{\"render\":\"datetime\",\"operator\":\"RANGE\",\"sortable\":\"custom\",\"width\":\"160\",\"timeFormat\":\"yyyy-mm-dd hh:MM:ss\"},\"form\":{\"validator\":[\"date\"],\"validatorMsg\":\"\"}}]', 'success', 'mysql', 1739742270),
(5, 'template', '{\"name\":\"template\",\"comment\":\"收款码模板\",\"quickSearchField\":[\"id\"],\"defaultSortField\":\"weigh\",\"formFields\":[\"name\",\"thumb\",\"background\",\"qrcode_width\",\"qrcode_height\",\"qrcode_x\",\"qrcode_y\",\"font_family\",\"font_size\",\"font_color\",\"amount_x\",\"amount_y\",\"merchant_x\",\"merchant_y\",\"order_x\",\"order_y\",\"time_x\",\"time_y\",\"extra_config\",\"weigh\",\"status\",\"type\"],\"columnFields\":[\"id\",\"name\",\"thumb\",\"background\",\"qrcode_width\",\"qrcode_height\",\"qrcode_x\",\"qrcode_y\",\"font_family\",\"font_size\",\"font_color\",\"amount_x\",\"amount_y\",\"merchant_x\",\"merchant_y\",\"order_x\",\"order_y\",\"time_x\",\"time_y\",\"weigh\",\"status\",\"create_time\",\"update_time\",\"type\"],\"defaultSortType\":\"desc\",\"generateRelativePath\":\"template\",\"isCommonModel\":\"1\",\"modelFile\":\"app\\/common\\/model\\/Template.php\",\"controllerFile\":\"app\\/admin\\/controller\\/Template.php\",\"validateFile\":\"app\\/common\\/validate\\/Template.php\",\"webViewsDir\":\"web\\/src\\/views\\/backend\\/template\",\"databaseConnection\":null,\"designChange\":[{\"type\":\"add-field\",\"index\":\"3\",\"newName\":\"type\",\"oldName\":\"\",\"after\":\"type\",\"sync\":\"1\"},{\"type\":\"del-field\",\"oldName\":\"type\",\"newName\":\"\",\"sync\":\"1\"},{\"type\":\"change-field-order\",\"index\":\"3\",\"newName\":\"\",\"oldName\":\"thumb\",\"after\":\"type\",\"sync\":\"1\"}],\"rebuild\":\"Yes\"}', '[{\"name\":\"id\",\"type\":\"int\",\"dataType\":\"int\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"1\",\"unsigned\":\"1\",\"autoIncrement\":\"1\",\"comment\":\"ID\",\"designType\":\"pk\",\"table\":{\"width\":\"70\",\"operator\":\"RANGE\",\"sortable\":\"custom\"},\"form\":[]},{\"name\":\"name\",\"type\":\"varchar\",\"dataType\":\"varchar(100)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"模板名称\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"title\":\"单选框\",\"name\":\"type\",\"dataType\":\"enum(\'normal\',\'custom\')\",\"comment\":\"模板类型:normal=普通,custom=自定义\",\"designType\":\"radio\",\"table\":{\"render\":\"tag\",\"operator\":\"eq\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"},\"type\":\"enum\",\"length\":\"0\",\"precision\":\"0\",\"defaultType\":\"INPUT\",\"null\":\"1\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"default\":\"normal\"},{\"name\":\"thumb\",\"type\":\"varchar\",\"dataType\":\"varchar(255)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"缩略图\",\"designType\":\"image\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\",\"image-multi\":\"\"}},{\"name\":\"background\",\"type\":\"varchar\",\"dataType\":\"varchar(255)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"背景图片\",\"designType\":\"image\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\",\"image-multi\":\"\"}},{\"name\":\"qrcode_width\",\"type\":\"int\",\"dataType\":\"int\",\"default\":\"200\",\"defaultType\":\"INPUT\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"二维码宽度\",\"designType\":\"number\",\"table\":{\"render\":\"none\",\"operator\":\"RANGE\",\"sortable\":\"false\"},\"form\":{\"validator\":[\"number\"],\"validatorMsg\":\"\",\"step\":\"1\"}},{\"name\":\"qrcode_height\",\"type\":\"int\",\"dataType\":\"int\",\"default\":\"200\",\"defaultType\":\"INPUT\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"二维码高度\",\"designType\":\"number\",\"table\":{\"render\":\"none\",\"operator\":\"RANGE\",\"sortable\":\"false\"},\"form\":{\"validator\":[\"number\"],\"validatorMsg\":\"\",\"step\":\"1\"}},{\"name\":\"qrcode_x\",\"type\":\"int\",\"dataType\":\"int\",\"default\":\"0\",\"defaultType\":\"INPUT\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"二维码X坐标\",\"designType\":\"number\",\"table\":{\"render\":\"none\",\"operator\":\"RANGE\",\"sortable\":\"false\"},\"form\":{\"validator\":[\"number\"],\"validatorMsg\":\"\",\"step\":\"1\"}},{\"name\":\"qrcode_y\",\"type\":\"int\",\"dataType\":\"int\",\"default\":\"0\",\"defaultType\":\"INPUT\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"二维码Y坐标\",\"designType\":\"number\",\"table\":{\"render\":\"none\",\"operator\":\"RANGE\",\"sortable\":\"false\"},\"form\":{\"validator\":[\"number\"],\"validatorMsg\":\"\",\"step\":\"1\"}},{\"name\":\"font_family\",\"type\":\"varchar\",\"dataType\":\"varchar(50)\",\"default\":\"Arial\",\"defaultType\":\"INPUT\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"字体\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"font_size\",\"type\":\"int\",\"dataType\":\"int\",\"default\":\"12\",\"defaultType\":\"INPUT\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"字体大小\",\"designType\":\"number\",\"table\":{\"render\":\"none\",\"operator\":\"RANGE\",\"sortable\":\"false\"},\"form\":{\"validator\":[\"number\"],\"validatorMsg\":\"\",\"step\":\"1\"}},{\"name\":\"font_color\",\"type\":\"varchar\",\"dataType\":\"varchar(20)\",\"default\":\"#000000\",\"defaultType\":\"INPUT\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"字体颜色\",\"designType\":\"color\",\"table\":{\"render\":\"color\",\"operator\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"amount_x\",\"type\":\"int\",\"dataType\":\"int\",\"default\":\"0\",\"defaultType\":\"INPUT\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"金额X坐标\",\"designType\":\"number\",\"table\":{\"render\":\"none\",\"operator\":\"RANGE\",\"sortable\":\"false\"},\"form\":{\"validator\":[\"number\"],\"validatorMsg\":\"\",\"step\":\"1\"}},{\"name\":\"amount_y\",\"type\":\"int\",\"dataType\":\"int\",\"default\":\"0\",\"defaultType\":\"INPUT\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"金额Y坐标\",\"designType\":\"number\",\"table\":{\"render\":\"none\",\"operator\":\"RANGE\",\"sortable\":\"false\"},\"form\":{\"validator\":[\"number\"],\"validatorMsg\":\"\",\"step\":\"1\"}},{\"name\":\"merchant_x\",\"type\":\"int\",\"dataType\":\"int\",\"default\":\"0\",\"defaultType\":\"INPUT\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"商户名称X坐标\",\"designType\":\"number\",\"table\":{\"render\":\"none\",\"operator\":\"RANGE\",\"sortable\":\"false\"},\"form\":{\"validator\":[\"number\"],\"validatorMsg\":\"\",\"step\":\"1\"}},{\"name\":\"merchant_y\",\"type\":\"int\",\"dataType\":\"int\",\"default\":\"0\",\"defaultType\":\"INPUT\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"商户名称Y坐标\",\"designType\":\"number\",\"table\":{\"render\":\"none\",\"operator\":\"RANGE\",\"sortable\":\"false\"},\"form\":{\"validator\":[\"number\"],\"validatorMsg\":\"\",\"step\":\"1\"}},{\"name\":\"order_x\",\"type\":\"int\",\"dataType\":\"int\",\"default\":\"0\",\"defaultType\":\"INPUT\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"订单号X坐标\",\"designType\":\"number\",\"table\":{\"render\":\"none\",\"operator\":\"RANGE\",\"sortable\":\"false\"},\"form\":{\"validator\":[\"number\"],\"validatorMsg\":\"\",\"step\":\"1\"}},{\"name\":\"order_y\",\"type\":\"int\",\"dataType\":\"int\",\"default\":\"0\",\"defaultType\":\"INPUT\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"订单号Y坐标\",\"designType\":\"number\",\"table\":{\"render\":\"none\",\"operator\":\"RANGE\",\"sortable\":\"false\"},\"form\":{\"validator\":[\"number\"],\"validatorMsg\":\"\",\"step\":\"1\"}},{\"name\":\"time_x\",\"type\":\"int\",\"dataType\":\"int\",\"default\":\"0\",\"defaultType\":\"INPUT\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"时间X坐标\",\"designType\":\"number\",\"table\":{\"render\":\"none\",\"operator\":\"RANGE\",\"sortable\":\"false\"},\"form\":{\"validator\":[\"number\"],\"validatorMsg\":\"\",\"step\":\"1\"}},{\"name\":\"time_y\",\"type\":\"int\",\"dataType\":\"int\",\"default\":\"0\",\"defaultType\":\"INPUT\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"时间Y坐标\",\"designType\":\"number\",\"table\":{\"render\":\"none\",\"operator\":\"RANGE\",\"sortable\":\"false\"},\"form\":{\"validator\":[\"number\"],\"validatorMsg\":\"\",\"step\":\"1\"}},{\"name\":\"extra_config\",\"type\":\"text\",\"dataType\":\"text\",\"default\":\"\",\"defaultType\":\"NULL\",\"null\":\"1\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"额外配置JSON\",\"designType\":\"textarea\",\"table\":{\"operator\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\",\"rows\":\"3\"}},{\"name\":\"weigh\",\"type\":\"int\",\"dataType\":\"int\",\"default\":\"0\",\"defaultType\":\"INPUT\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"权重\",\"designType\":\"weigh\",\"table\":{\"operator\":\"RANGE\",\"sortable\":\"custom\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"status\",\"type\":\"tinyint\",\"dataType\":\"tinyint(1)\",\"default\":\"1\",\"defaultType\":\"INPUT\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"状态:0=禁用,1=启用\",\"designType\":\"radio\",\"table\":{\"render\":\"tag\",\"operator\":\"eq\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"create_time\",\"type\":\"int\",\"dataType\":\"int\",\"default\":\"\",\"defaultType\":\"NULL\",\"null\":\"1\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"创建时间\",\"designType\":\"timestamp\",\"table\":{\"render\":\"datetime\",\"operator\":\"RANGE\",\"sortable\":\"custom\",\"width\":\"160\",\"timeFormat\":\"yyyy-mm-dd hh:MM:ss\"},\"form\":{\"validator\":[\"date\"],\"validatorMsg\":\"\"}},{\"name\":\"update_time\",\"type\":\"int\",\"dataType\":\"int\",\"default\":\"\",\"defaultType\":\"NULL\",\"null\":\"1\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"更新时间\",\"designType\":\"timestamp\",\"table\":{\"render\":\"datetime\",\"operator\":\"RANGE\",\"sortable\":\"custom\",\"width\":\"160\",\"timeFormat\":\"yyyy-mm-dd hh:MM:ss\"},\"form\":{\"validator\":[\"date\"],\"validatorMsg\":\"\"}}]', 'success', 'mysql', 1739747822),
(6, 'qrcode', '{\"name\":\"qrcode\",\"comment\":\"收款码表\",\"quickSearchField\":[\"id\"],\"defaultSortField\":\"weigh\",\"formFields\":[\"name\",\"template_id\",\"merchant_id\",\"channel\",\"min_amount\",\"max_amount\",\"fixed_amount\",\"expired_time\",\"notify_url\",\"return_url\",\"remark\",\"status\",\"weigh\"],\"columnFields\":[\"id\",\"name\",\"template_id\",\"merchant_id\",\"channel\",\"min_amount\",\"max_amount\",\"fixed_amount\",\"remark\",\"status\",\"create_time\",\"update_time\"],\"defaultSortType\":\"desc\",\"generateRelativePath\":\"qrcode\",\"isCommonModel\":\"1\",\"modelFile\":\"app\\/common\\/model\\/Qrcode.php\",\"controllerFile\":\"app\\/admin\\/controller\\/Qrcode.php\",\"validateFile\":\"app\\/common\\/validate\\/Qrcode.php\",\"webViewsDir\":\"web\\/src\\/views\\/backend\\/qrcode\",\"databaseConnection\":null,\"designChange\":[{\"type\":\"change-field-attr\",\"index\":\"4\",\"oldName\":\"channel\",\"newName\":\"\",\"sync\":\"1\"},{\"type\":\"change-field-name\",\"index\":\"4\",\"oldName\":\"channels\",\"newName\":\"channel\",\"sync\":\"1\"},{\"type\":\"change-field-order\",\"index\":\"11\",\"newName\":\"\",\"oldName\":\"remark\",\"after\":\"return_url\",\"sync\":\"1\"}],\"rebuild\":\"Yes\"}', '[{\"name\":\"id\",\"type\":\"int\",\"dataType\":\"int\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"1\",\"unsigned\":\"1\",\"autoIncrement\":\"1\",\"comment\":\"ID\",\"designType\":\"pk\",\"table\":{\"width\":\"70\",\"operator\":\"RANGE\",\"sortable\":\"custom\"},\"form\":[]},{\"name\":\"name\",\"type\":\"varchar\",\"dataType\":\"varchar(100)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"收款码名称\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"template_id\",\"type\":\"int\",\"dataType\":\"int\",\"default\":\"0\",\"defaultType\":\"INPUT\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"1\",\"autoIncrement\":\"\",\"comment\":\"模板ID\",\"designType\":\"remoteSelect\",\"table\":{\"operator\":\"LIKE\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\",\"select-multi\":\"\",\"remote-pk\":\"id\",\"remote-field\":\"name\",\"remote-table\":\"template\",\"remote-controller\":\"app\\/admin\\/controller\\/Template.php\",\"remote-model\":\"app\\/common\\/model\\/Template.php\",\"relation-fields\":\"name\",\"remote-url\":\"\",\"remote-primary-table-alias\":\"\",\"remote-source-config-type\":\"crud\"}},{\"name\":\"merchant_id\",\"type\":\"int\",\"dataType\":\"int\",\"default\":\"0\",\"defaultType\":\"INPUT\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"1\",\"autoIncrement\":\"\",\"comment\":\"商户ID\",\"designType\":\"remoteSelect\",\"table\":{\"operator\":\"LIKE\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\",\"select-multi\":\"\",\"remote-pk\":\"id\",\"remote-field\":\"username\",\"remote-table\":\"user\",\"remote-controller\":\"app\\/admin\\/controller\\/user\\/User.php\",\"remote-model\":\"app\\/admin\\/model\\/User.php\",\"relation-fields\":\"username\",\"remote-url\":\"\",\"remote-primary-table-alias\":\"\",\"remote-source-config-type\":\"crud\"}},{\"title\":\"远程下拉（关联多选）\",\"name\":\"channel\",\"comment\":\"渠道\",\"designType\":\"remoteSelects\",\"tableBuildExclude\":\"1\",\"table\":{\"operator\":\"LIKE\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\",\"select-multi\":\"1\",\"remote-pk\":\"id\",\"remote-field\":\"name\",\"remote-table\":\"channel\",\"remote-controller\":\"app\\/admin\\/controller\\/Channel.php\",\"remote-model\":\"app\\/common\\/model\\/Channel.php\",\"relation-fields\":\"name\",\"remote-url\":\"\",\"remote-primary-table-alias\":\"\",\"remote-source-config-type\":\"crud\"},\"type\":\"varchar\",\"length\":\"500\",\"precision\":\"0\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\"},{\"name\":\"min_amount\",\"type\":\"decimal\",\"dataType\":\"decimal(10,2)\",\"default\":\"0.00\",\"defaultType\":\"INPUT\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"最小金额\",\"designType\":\"number\",\"table\":{\"render\":\"none\",\"operator\":\"RANGE\",\"sortable\":\"false\"},\"form\":{\"validator\":[\"number\"],\"validatorMsg\":\"\",\"step\":\"1\"}},{\"name\":\"max_amount\",\"type\":\"decimal\",\"dataType\":\"decimal(10,2)\",\"default\":\"0.00\",\"defaultType\":\"INPUT\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"最大金额\",\"designType\":\"number\",\"table\":{\"render\":\"none\",\"operator\":\"RANGE\",\"sortable\":\"false\"},\"form\":{\"validator\":[\"number\"],\"validatorMsg\":\"\",\"step\":\"1\"}},{\"name\":\"fixed_amount\",\"type\":\"decimal\",\"dataType\":\"decimal(10,2)\",\"default\":\"0.00\",\"defaultType\":\"INPUT\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"固定金额(0为不限制)\",\"designType\":\"number\",\"table\":{\"render\":\"none\",\"operator\":\"RANGE\",\"sortable\":\"false\"},\"form\":{\"validator\":[\"number\"],\"validatorMsg\":\"\",\"step\":\"1\"}},{\"name\":\"expired_time\",\"type\":\"int\",\"dataType\":\"int\",\"default\":\"0\",\"defaultType\":\"INPUT\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"过期时间(0永久)\",\"designType\":\"timestamp\",\"table\":{\"render\":\"datetime\",\"operator\":\"RANGE\",\"sortable\":\"custom\",\"width\":\"160\",\"timeFormat\":\"yyyy-mm-dd hh:MM:ss\"},\"form\":{\"validator\":[\"date\"],\"validatorMsg\":\"\"}},{\"name\":\"notify_url\",\"type\":\"varchar\",\"dataType\":\"varchar(255)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"通知地址\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"return_url\",\"type\":\"varchar\",\"dataType\":\"varchar(255)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"跳转地址\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"remark\",\"type\":\"varchar\",\"dataType\":\"varchar(255)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"备注\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"status\",\"type\":\"tinyint\",\"dataType\":\"tinyint(1)\",\"default\":\"1\",\"defaultType\":\"INPUT\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"状态:0=禁用,1=启用\",\"designType\":\"radio\",\"table\":{\"render\":\"tag\",\"operator\":\"eq\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"weigh\",\"type\":\"int\",\"dataType\":\"int\",\"default\":\"0\",\"defaultType\":\"INPUT\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"权重\",\"designType\":\"weigh\",\"table\":{\"operator\":\"RANGE\",\"sortable\":\"custom\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"create_time\",\"type\":\"int\",\"dataType\":\"int\",\"default\":\"0\",\"defaultType\":\"INPUT\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"1\",\"autoIncrement\":\"\",\"comment\":\"创建时间\",\"designType\":\"timestamp\",\"table\":{\"render\":\"datetime\",\"operator\":\"RANGE\",\"sortable\":\"custom\",\"width\":\"160\",\"timeFormat\":\"yyyy-mm-dd hh:MM:ss\"},\"form\":{\"validator\":[\"date\"],\"validatorMsg\":\"\"}},{\"name\":\"update_time\",\"type\":\"int\",\"dataType\":\"int\",\"default\":\"0\",\"defaultType\":\"INPUT\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"1\",\"autoIncrement\":\"\",\"comment\":\"更新时间\",\"designType\":\"timestamp\",\"table\":{\"render\":\"datetime\",\"operator\":\"RANGE\",\"sortable\":\"custom\",\"width\":\"160\",\"timeFormat\":\"yyyy-mm-dd hh:MM:ss\"},\"form\":{\"validator\":[\"date\"],\"validatorMsg\":\"\"}}]', 'success', 'mysql', 1739750397),
(7, 'qrcode_log', '{\"name\":\"qrcode_log\",\"comment\":\"收款码访问记录表\",\"quickSearchField\":[\"id\"],\"defaultSortField\":\"id\",\"formFields\":[\"qrcode_id\",\"ip\",\"user_agent\",\"device\"],\"columnFields\":[\"id\",\"qrcode_id\",\"ip\",\"user_agent\",\"device\",\"create_time\"],\"defaultSortType\":\"desc\",\"generateRelativePath\":\"qrcodelog\",\"isCommonModel\":\"1\",\"modelFile\":\"app\\/common\\/model\\/Qrcodelog.php\",\"controllerFile\":\"app\\/admin\\/controller\\/Qrcodelog.php\",\"validateFile\":\"app\\/common\\/validate\\/Qrcodelog.php\",\"webViewsDir\":\"web\\/src\\/views\\/backend\\/qrcodelog\",\"databaseConnection\":null,\"designChange\":[],\"rebuild\":\"Yes\"}', '[{\"name\":\"id\",\"type\":\"int\",\"dataType\":\"int\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"1\",\"unsigned\":\"1\",\"autoIncrement\":\"1\",\"comment\":\"ID\",\"designType\":\"pk\",\"table\":{\"width\":\"70\",\"operator\":\"RANGE\",\"sortable\":\"custom\"},\"form\":[]},{\"name\":\"qrcode_id\",\"type\":\"int\",\"dataType\":\"int\",\"default\":\"0\",\"defaultType\":\"INPUT\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"1\",\"autoIncrement\":\"\",\"comment\":\"收款码ID\",\"designType\":\"remoteSelect\",\"table\":{\"operator\":\"LIKE\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\",\"select-multi\":\"\",\"remote-pk\":\"id\",\"remote-field\":\"name\",\"remote-table\":\"qrcode\",\"remote-controller\":\"app\\/admin\\/controller\\/Qrcode.php\",\"remote-model\":\"app\\/common\\/model\\/Qrcode.php\",\"relation-fields\":\"name\",\"remote-url\":\"\",\"remote-primary-table-alias\":\"\",\"remote-source-config-type\":\"crud\"}},{\"name\":\"ip\",\"type\":\"varchar\",\"dataType\":\"varchar(50)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"访问IP\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"user_agent\",\"type\":\"varchar\",\"dataType\":\"varchar(255)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"浏览器标识\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"device\",\"type\":\"varchar\",\"dataType\":\"varchar(20)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"设备类型\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"create_time\",\"type\":\"int\",\"dataType\":\"int\",\"default\":\"0\",\"defaultType\":\"INPUT\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"1\",\"autoIncrement\":\"\",\"comment\":\"创建时间\",\"designType\":\"timestamp\",\"table\":{\"render\":\"datetime\",\"operator\":\"RANGE\",\"sortable\":\"custom\",\"width\":\"160\",\"timeFormat\":\"yyyy-mm-dd hh:MM:ss\"},\"form\":{\"validator\":[\"date\"],\"validatorMsg\":\"\"}}]', 'success', 'mysql', 1739808030);

-- --------------------------------------------------------

--
-- 表的结构 `pay_migrations`
--

CREATE TABLE `pay_migrations` (
  `version` bigint NOT NULL,
  `migration_name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `start_time` timestamp NULL DEFAULT NULL,
  `end_time` timestamp NULL DEFAULT NULL,
  `breakpoint` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 转存表中的数据 `pay_migrations`
--

INSERT INTO `pay_migrations` (`version`, `migration_name`, `start_time`, `end_time`, `breakpoint`) VALUES
(20230620180908, 'Install', '2025-02-16 19:20:40', '2025-02-16 19:20:40', 0),
(20230620180916, 'InstallData', '2025-02-16 19:20:40', '2025-02-16 19:20:40', 0),
(20230622221507, 'Version200', '2025-02-16 19:20:40', '2025-02-16 19:20:40', 0),
(20230719211338, 'Version201', '2025-02-16 19:20:40', '2025-02-16 19:20:40', 0),
(20230905060702, 'Version202', '2025-02-16 19:20:40', '2025-02-16 19:20:40', 0),
(20231112093414, 'Version205', '2025-02-16 19:20:40', '2025-02-16 19:20:40', 0),
(20231229043002, 'Version206', '2025-02-16 19:20:40', '2025-02-16 19:20:40', 0);

-- --------------------------------------------------------

--
-- 表的结构 `pay_order`
--

CREATE TABLE `pay_order` (
  `id` int UNSIGNED NOT NULL COMMENT '订单ID',
  `order_no` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '订单号',
  `trade_no` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '交易号(第三方支付平台)',
  `channel_id` int NOT NULL COMMENT '支付通道ID',
  `channel_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '支付方式',
  `qrcode_id` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '收款码id',
  `amount` decimal(10,2) NOT NULL COMMENT '支付金额',
  `currency` varchar(3) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'CNY' COMMENT '货币类型',
  `client_ip` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '客户端IP',
  `device` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '设备信息',
  `subject` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '商品标题',
  `body` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '商品描述',
  `extra` text COLLATE utf8mb4_unicode_ci COMMENT '额外参数',
  `merchant_id` int NOT NULL COMMENT '商户ID',
  `merchant_order_no` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '商户订单号',
  `notify_url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '异步通知地址',
  `return_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '同步跳转地址',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态:0=未支付,1=已支付,2=已关闭,3=已退款,4=部分退款',
  `pay_time` int DEFAULT NULL COMMENT '支付时间',
  `pay_amount` decimal(10,2) DEFAULT NULL COMMENT '实际支付金额',
  `refund_amount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '已退款金额',
  `notify_time` int DEFAULT NULL COMMENT '通知时间',
  `notify_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '通知状态:0=未通知,1=通知成功,2=通知失败',
  `notify_count` int NOT NULL DEFAULT '0' COMMENT '通知次数',
  `error_msg` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '错误信息',
  `user_agent` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'User Agent',
  `source` enum('1','2') COLLATE utf8mb4_unicode_ci DEFAULT '1' COMMENT '来源:1=收款码,2=API',
  `create_time` int NOT NULL COMMENT '创建时间',
  `update_time` int NOT NULL COMMENT '更新时间',
  `ip` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'IP'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='支付订单表' ROW_FORMAT=DYNAMIC;

--
-- 转存表中的数据 `pay_order`
--
DELETE FROM `ysf_chanpay_ordernel_id`;
-- --------------------------------------------------------

--
-- 表的结构 `pay_plugins`
--

CREATE TABLE `pay_plugins` (
  `id` int UNSIGNED NOT NULL COMMENT 'ID',
  `plugin_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '插件名称',
  `class_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '类名',
  `author` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '作者',
  `website` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '网站',
  `status` tinyint UNSIGNED NOT NULL DEFAULT '1' COMMENT '状态:0=禁用,1=启用',
  `update_time` bigint UNSIGNED DEFAULT NULL COMMENT '修改时间',
  `create_time` bigint UNSIGNED DEFAULT NULL COMMENT '创建时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='插件列表' ROW_FORMAT=DYNAMIC;

--
-- 转存表中的数据 `pay_plugins`
--

INSERT INTO `pay_plugins` (`id`, `plugin_name`, `class_name`, `author`, `website`, `status`, `update_time`, `create_time`) VALUES
(2, '易速付', 'Yisufu', '浪寒云', 'https://open.yisufu.cn', 1, 1739735802, 1739735802),
(10, '彩虹易支付', 'Epay', '彩虹', '', 1, 1739896469, 1739896469),
(11, '支付宝官方支付', 'Alipay', '支付宝', 'https://b.alipay.com/signing/productSetV2.htm', 1, 1739896470, 1739896470);

-- --------------------------------------------------------

--
-- 表的结构 `pay_qrcode`
--

CREATE TABLE `pay_qrcode` (
  `id` int UNSIGNED NOT NULL COMMENT 'ID',
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '收款码名称',
  `template_id` int UNSIGNED DEFAULT '0' COMMENT '模板ID',
  `merchant_id` int UNSIGNED NOT NULL DEFAULT '0' COMMENT '商户ID',
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '收款码标识',
  `channel` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '渠道',
  `min_amount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '最小金额',
  `max_amount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '最大金额',
  `fixed_amount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '固定金额(0为不限制)',
  `expired_time` int NOT NULL DEFAULT '0' COMMENT '过期时间(0永久)',
  `notify_url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '通知地址',
  `return_url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '跳转地址',
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '备注',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态:0=禁用,1=启用',
  `weigh` int NOT NULL DEFAULT '0' COMMENT '权重',
  `create_time` int UNSIGNED NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int UNSIGNED NOT NULL DEFAULT '0' COMMENT '更新时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='收款码表' ROW_FORMAT=DYNAMIC;

--
-- 转存表中的数据 `pay_qrcode`
--

INSERT INTO `pay_qrcode` (`id`, `name`, `template_id`, `merchant_id`, `uuid`, `channel`, `min_amount`, `max_amount`, `fixed_amount`, `expired_time`, `notify_url`, `return_url`, `remark`, `status`, `weigh`, `create_time`, `update_time`) VALUES
(1, 'demo', NULL, 1, 'a65f29cd-173b-440d-b4d6-e31ab9b6f', '2,6,9,7', 1.00, 20000.00, 0.00, 0, '', '', '', 1, 1, 1739751340, 1739905336);

-- --------------------------------------------------------

--
-- 表的结构 `pay_qrcode_log`
--

CREATE TABLE `pay_qrcode_log` (
  `id` int UNSIGNED NOT NULL COMMENT 'ID',
  `qrcode_id` int UNSIGNED NOT NULL DEFAULT '0' COMMENT '收款码ID',
  `ip` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '访问IP',
  `user_agent` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '浏览器标识',
  `device` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '设备类型',
  `create_time` int UNSIGNED NOT NULL DEFAULT '0' COMMENT '创建时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='收款码访问记录表' ROW_FORMAT=DYNAMIC;

--
-- 转存表中的数据 `pay_qrcode_log`
--

INSERT INTO `pay_qrcode_log` (`id`, `qrcode_id`, `ip`, `user_agent`, `device`, `create_time`) VALUES
(1, 1, '', '', '', 1739808042),

-- --------------------------------------------------------

--
-- 表的结构 `pay_security_data_recycle`
--

CREATE TABLE `pay_security_data_recycle` (
  `id` int UNSIGNED NOT NULL COMMENT 'ID',
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '规则名称',
  `controller` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '控制器',
  `controller_as` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '控制器别名',
  `data_table` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '对应数据表',
  `connection` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '数据库连接配置标识',
  `primary_key` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '数据表主键',
  `status` enum('0','1') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1' COMMENT '状态:0=禁用,1=启用',
  `update_time` bigint UNSIGNED DEFAULT NULL COMMENT '更新时间',
  `create_time` bigint UNSIGNED DEFAULT NULL COMMENT '创建时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='回收规则表' ROW_FORMAT=DYNAMIC;

--
-- 转存表中的数据 `pay_security_data_recycle`
--

INSERT INTO `pay_security_data_recycle` (`id`, `name`, `controller`, `controller_as`, `data_table`, `connection`, `primary_key`, `status`, `update_time`, `create_time`) VALUES
(1, '管理员', 'auth/Admin.php', 'auth/admin', 'admin', '', 'id', '1', 1739733640, 1739733640),
(2, '管理员日志', 'auth/AdminLog.php', 'auth/adminlog', 'admin_log', '', 'id', '1', 1739733640, 1739733640),
(3, '菜单规则', 'auth/Menu.php', 'auth/menu', 'menu_rule', '', 'id', '1', 1739733640, 1739733640),
(4, '系统配置项', 'routine/Config.php', 'routine/config', 'config', '', 'id', '1', 1739733640, 1739733640),
(5, '会员', 'user/User.php', 'user/user', 'user', '', 'id', '1', 1739733640, 1739733640),
(6, '数据回收规则', 'security/DataRecycle.php', 'security/datarecycle', 'security_data_recycle', '', 'id', '1', 1739733640, 1739733640);

-- --------------------------------------------------------

--
-- 表的结构 `pay_security_data_recycle_log`
--

CREATE TABLE `pay_security_data_recycle_log` (
  `id` int UNSIGNED NOT NULL COMMENT 'ID',
  `admin_id` int UNSIGNED NOT NULL DEFAULT '0' COMMENT '操作管理员',
  `recycle_id` int UNSIGNED NOT NULL DEFAULT '0' COMMENT '回收规则ID',
  `data` text COLLATE utf8mb4_unicode_ci COMMENT '回收的数据',
  `data_table` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '数据表',
  `connection` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '数据库连接配置标识',
  `primary_key` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '数据表主键',
  `is_restore` tinyint UNSIGNED NOT NULL DEFAULT '0' COMMENT '是否已还原:0=否,1=是',
  `ip` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '操作者IP',
  `useragent` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'User-Agent',
  `create_time` bigint UNSIGNED DEFAULT NULL COMMENT '创建时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='数据回收记录表' ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- 表的结构 `pay_security_sensitive_data`
--

CREATE TABLE `pay_security_sensitive_data` (
  `id` int UNSIGNED NOT NULL COMMENT 'ID',
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '规则名称',
  `controller` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '控制器',
  `controller_as` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '控制器别名',
  `data_table` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '对应数据表',
  `connection` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '数据库连接配置标识',
  `primary_key` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '数据表主键',
  `data_fields` text COLLATE utf8mb4_unicode_ci COMMENT '敏感数据字段',
  `status` enum('0','1') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1' COMMENT '状态:0=禁用,1=启用',
  `update_time` bigint UNSIGNED DEFAULT NULL COMMENT '更新时间',
  `create_time` bigint UNSIGNED DEFAULT NULL COMMENT '创建时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='敏感数据规则表' ROW_FORMAT=DYNAMIC;

--
-- 转存表中的数据 `pay_security_sensitive_data`
--

INSERT INTO `pay_security_sensitive_data` (`id`, `name`, `controller`, `controller_as`, `data_table`, `connection`, `primary_key`, `data_fields`, `status`, `update_time`, `create_time`) VALUES
(1, '管理员数据', 'auth/Admin.php', 'auth/admin', 'admin', '', 'id', '{\"username\":\"用户名\",\"mobile\":\"手机\",\"password\":\"密码\",\"status\":\"状态\"}', '1', 1739733640, 1739733640),
(2, '会员数据', 'user/User.php', 'user/user', 'user', '', 'id', '{\"username\":\"用户名\",\"mobile\":\"手机号\",\"password\":\"密码\",\"status\":\"状态\",\"email\":\"邮箱地址\"}', '1', 1739733640, 1739733640),
(3, '管理员权限', 'auth/Group.php', 'auth/group', 'admin_group', '', 'id', '{\"rules\":\"权限规则ID\"}', '1', 1739733640, 1739733640);

-- --------------------------------------------------------

--
-- 表的结构 `pay_security_sensitive_data_log`
--

CREATE TABLE `pay_security_sensitive_data_log` (
  `id` int UNSIGNED NOT NULL COMMENT 'ID',
  `admin_id` int UNSIGNED NOT NULL DEFAULT '0' COMMENT '操作管理员',
  `sensitive_id` int UNSIGNED NOT NULL DEFAULT '0' COMMENT '敏感数据规则ID',
  `data_table` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '数据表',
  `connection` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '数据库连接配置标识',
  `primary_key` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '数据表主键',
  `data_field` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '被修改字段',
  `data_comment` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '被修改项',
  `id_value` int NOT NULL DEFAULT '0' COMMENT '被修改项主键值',
  `before` text COLLATE utf8mb4_unicode_ci COMMENT '修改前',
  `after` text COLLATE utf8mb4_unicode_ci COMMENT '修改后',
  `ip` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '操作者IP',
  `useragent` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'User-Agent',
  `is_rollback` tinyint UNSIGNED NOT NULL DEFAULT '0' COMMENT '是否已回滚:0=否,1=是',
  `create_time` bigint UNSIGNED DEFAULT NULL COMMENT '创建时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='敏感数据修改记录' ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- 表的结构 `pay_template`
--

CREATE TABLE `pay_template` (
  `id` int UNSIGNED NOT NULL COMMENT 'ID',
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '模板名称',
  `type` enum('normal','custom') COLLATE utf8mb4_unicode_ci DEFAULT 'normal' COMMENT '模板类型:normal=普通,custom=自定义',
  `thumb` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '缩略图',
  `background` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '背景图片',
  `qrcode_width` int NOT NULL DEFAULT '200' COMMENT '二维码宽度',
  `qrcode_height` int NOT NULL DEFAULT '200' COMMENT '二维码高度',
  `qrcode_x` int NOT NULL DEFAULT '0' COMMENT '二维码X坐标',
  `qrcode_y` int NOT NULL DEFAULT '0' COMMENT '二维码Y坐标',
  `font_family` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Arial' COMMENT '字体',
  `font_size` int NOT NULL DEFAULT '12' COMMENT '字体大小',
  `font_color` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '#000000' COMMENT '字体颜色',
  `amount_x` int NOT NULL DEFAULT '0' COMMENT '金额X坐标',
  `amount_y` int NOT NULL DEFAULT '0' COMMENT '金额Y坐标',
  `merchant_x` int NOT NULL DEFAULT '0' COMMENT '商户名称X坐标',
  `merchant_y` int NOT NULL DEFAULT '0' COMMENT '商户名称Y坐标',
  `order_x` int NOT NULL DEFAULT '0' COMMENT '订单号X坐标',
  `order_y` int NOT NULL DEFAULT '0' COMMENT '订单号Y坐标',
  `time_x` int NOT NULL DEFAULT '0' COMMENT '时间X坐标',
  `time_y` int NOT NULL DEFAULT '0' COMMENT '时间Y坐标',
  `extra_config` text COLLATE utf8mb4_unicode_ci COMMENT '额外配置JSON',
  `weigh` int NOT NULL DEFAULT '0' COMMENT '权重',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态:0=禁用,1=启用',
  `create_time` int DEFAULT NULL COMMENT '创建时间',
  `update_time` int DEFAULT NULL COMMENT '更新时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='收款码模板' ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- 表的结构 `pay_test_build`
--

CREATE TABLE `pay_test_build` (
  `id` int UNSIGNED NOT NULL COMMENT 'ID',
  `title` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '标题',
  `keyword_rows` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '关键词',
  `content` text COLLATE utf8mb4_unicode_ci COMMENT '内容',
  `views` int UNSIGNED NOT NULL DEFAULT '0' COMMENT '浏览量',
  `likes` int UNSIGNED NOT NULL DEFAULT '0' COMMENT '有帮助数',
  `dislikes` int UNSIGNED NOT NULL DEFAULT '0' COMMENT '无帮助数',
  `note_textarea` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '备注',
  `status` enum('0','1') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1' COMMENT '状态:0=隐藏,1=正常',
  `weigh` int NOT NULL DEFAULT '0' COMMENT '权重',
  `update_time` bigint UNSIGNED DEFAULT NULL COMMENT '更新时间',
  `create_time` bigint UNSIGNED DEFAULT NULL COMMENT '创建时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='知识库表' ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- 表的结构 `pay_token`
--

CREATE TABLE `pay_token` (
  `token` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'Token',
  `type` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '类型',
  `user_id` int UNSIGNED NOT NULL DEFAULT '0' COMMENT '用户ID',
  `create_time` bigint UNSIGNED DEFAULT NULL COMMENT '创建时间',
  `expire_time` bigint UNSIGNED DEFAULT NULL COMMENT '过期时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户Token表' ROW_FORMAT=DYNAMIC;

--
-- 转存表中的数据 `pay_token`
--

INSERT INTO `pay_token` (`token`, `type`, `user_id`, `create_time`, `expire_time`) VALUES
('025114507aca9ebf5ac1578d2e0773a49579e0d6', 'admin', 1, 1739905056, 1740164256),
('1c34348063eb71c598323543231c8608f0a5e4de', 'admin-refresh', 1, 1739733802, 1742325802),
('1cc2791706bf86a77fe48f2f78370be851cca33a', 'admin', 1, 1739733802, 1739993002);

-- --------------------------------------------------------

--
-- 表的结构 `pay_user`
--

CREATE TABLE `pay_user` (
  `id` int UNSIGNED NOT NULL COMMENT 'ID',
  `group_id` int UNSIGNED NOT NULL DEFAULT '0' COMMENT '分组ID',
  `username` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '用户名',
  `nickname` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '昵称',
  `email` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '邮箱',
  `mobile` varchar(11) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '手机',
  `avatar` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '头像',
  `gender` tinyint UNSIGNED NOT NULL DEFAULT '0' COMMENT '性别:0=未知,1=男,2=女',
  `birthday` date DEFAULT NULL COMMENT '生日',
  `money` int UNSIGNED NOT NULL DEFAULT '0' COMMENT '余额',
  `score` int UNSIGNED NOT NULL DEFAULT '0' COMMENT '积分',
  `last_login_time` bigint UNSIGNED DEFAULT NULL COMMENT '上次登录时间',
  `last_login_ip` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '上次登录IP',
  `login_failure` tinyint UNSIGNED NOT NULL DEFAULT '0' COMMENT '登录失败次数',
  `join_ip` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '加入IP',
  `join_time` bigint UNSIGNED DEFAULT NULL COMMENT '加入时间',
  `motto` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '签名',
  `password` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '密码',
  `salt` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '密码盐',
  `status` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '状态',
  `update_time` bigint UNSIGNED DEFAULT NULL COMMENT '更新时间',
  `create_time` bigint UNSIGNED DEFAULT NULL COMMENT '创建时间',
  `public_key` text COLLATE utf8mb4_unicode_ci COMMENT '商户公钥',
  `private_key` text COLLATE utf8mb4_unicode_ci COMMENT '商户私钥'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='会员表' ROW_FORMAT=DYNAMIC;

--
-- 转存表中的数据 `pay_user`
--

INSERT INTO `pay_user` (`id`, `group_id`, `username`, `nickname`, `email`, `mobile`, `avatar`, `gender`, `birthday`, `money`, `score`, `last_login_time`, `last_login_ip`, `login_failure`, `join_ip`, `join_time`, `motto`, `password`, `salt`, `status`, `update_time`, `create_time`, `public_key`, `private_key`) VALUES
(1, 1, 'user', 'User', '18888888888@qq.com', '18888888888', '', 2, '2025-02-17', 0, 0, NULL, '', 0, '', NULL, '', '4256dfdefeb8168c1bd5e3774dbe98e9', 'SLbixXmwlCs6zFcJ', 'enable', 1739733640, 1739733640, 'MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAsbU6Kj2kBrxqgU1OAG1ru+yUaXY5lfpbdSrAsIT3evBp917OS3mGTo/C+BAynkxkZOodm3QA1/UaSALKpBpCE9aeDZQuWs6qgk1pKlsFd+HB1+NUN6/oG79qxLSH1ylB39TPWTruXdFAqkVbWMnCeWVYYJV3l0OxzfHCmNHGa2qn1fA2Eu+zmtaaOQtl//lDZlrIL2PzrsY3sQ4t3kIGvH/DoFiOOA+5L5+Q4mPbd1aE7eKpDaI+eP9V+27AI4ensuC76PonsV7nAqBhpKdH2fsdRzrTrKg1t2AQMoBqEVuJGube+5BzvmOSuaY/mu40ME+i+zT/5a32d7H/xPYQdQIDAQAB', 'MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCxtToqPaQGvGqBTU4AbWu77JRpdjmV+lt1KsCwhPd68Gn3Xs5LeYZOj8L4EDKeTGRk6h2bdADX9RpIAsqkGkIT1p4NlC5azqqCTWkqWwV34cHX41Q3r+gbv2rEtIfXKUHf1M9ZOu5d0UCqRVtYycJ5ZVhglXeXQ7HN8cKY0cZraqfV8DYS77Oa1po5C2X/+UNmWsgvY/OuxjexDi3eQga8f8OgWI44D7kvn5DiY9t3VoTt4qkNoj54/1X7bsAjh6ey4Lvo+iexXucCoGGkp0fZ+x1HOtOsqDW3YBAygGoRW4ka5t77kHO+Y5K5pj+a7jQwT6L7NP/lrfZ3sf/E9hB1AgMBAAECggEAP6B8r+0cEpFZrOwp1ntXDJUbWltLKQjXwC7LiShCl9EGj9xxDpL3ZJ+SllDuXsFJXNx6N1Okja4jd88QEQuZxxKbyo7YvgirAjaHRfQLFC5PwmWRnNKtz2mM59sfnAkYnfTLPM6d1Bd9CLoGh9bNe7uulf5OMGm7etpp61+IpKKVliAtX7/csgl2F6Efo5KzrkWKHkUsxBZVOoNlsUIC0v0/xJrugkoqtwteDmVzbHql/wRWwfBr/O+G0paX1Dvu85HAWLEgV5ZdJpz/AHWbspeBMjOhJnAXrpHWlnWQYT8QwZ8767PG1bwlzKAzOBLaOP2WTWPMMef01Fx8EEHOoQKBgQDdlxR9CeFy92FugCsxiG5ZTDu8TOajb+2YhcnImEMFRTZMJKZ6Y/9OrgwDpfFWiiDLS4CbGvdYaff70D6cE2sMfMuKmQAhGYdevW1G2pQ6UMHZxcAwzY2DHXzfkEXrJEyVx6Tm+rtEH2h7ZvLKDu5wt7ac+Gp8o8Cj0ZPQenvXGQKBgQDNTa/4Agby7br4f9Yvz8+GGj0nRUOkvVK7gOyzKafQLNkhZ+tXk4OUna3l3tXNDW/Tbcs3lnz4C5COrTfcSe/Gj8PfFHVLw8pCAtKI4wH6KzjZ94lfIaQSyUNpzFP421Mz3EkkO4f4lgjw2K9hbRRppuElOWppiQkwhPWbNtG7vQKBgQDMkqY/qdeRpAE3WuyFlkcJ+e9MMFLdoH/hx+I6Zxe4zeUK9usbIyaZJOXCmHjuRCdyiAn7KDIiVfKzb9Xdka/Kn4vqMMaFyGPJe2hfeXxPOi89NevxIlP7MEYQv8lNBP4PaXk8JU6t3bE//BM5p/9J4NGeqVjmKOe4Vcv5NJsQQQKBgD18wvMYSFSBdrnuL4vqRVD4ktAsInI4cYrOthWCqEvk4rLqmMWF3KaqAucRsh7To2ZDP9XKMGtpq0XQAybqzfE+JX+udOLYJL9YcQ2mT3VJdKFzTaU8QhOOS65oD848gdLKau17FuIQrWTUwNIBBVgPLucjJwesjyAE8jomVPJRAoGBAKIkOVC1eE6M1VcKYBTRIN4imLKL40PcOLGgqT0ExsxakQmnuN0vNqijP9EjvBvEeXH4eCI+SmGJWdWI2mRx/HHNpnyxntbpnKhvZwI75QwKqMIyVAO5z1s/Yrd2BNESrLo6HFlbGd+ysyjUNfhrVKFhdvdi/6teAYHGx1G7MciS');

-- --------------------------------------------------------

--
-- 表的结构 `pay_user_group`
--

CREATE TABLE `pay_user_group` (
  `id` int UNSIGNED NOT NULL COMMENT 'ID',
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '组名',
  `rules` text COLLATE utf8mb4_unicode_ci COMMENT '权限节点',
  `status` enum('0','1') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1' COMMENT '状态:0=禁用,1=启用',
  `update_time` bigint UNSIGNED DEFAULT NULL COMMENT '更新时间',
  `create_time` bigint UNSIGNED DEFAULT NULL COMMENT '创建时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='会员组表' ROW_FORMAT=DYNAMIC;

--
-- 转存表中的数据 `pay_user_group`
--

INSERT INTO `pay_user_group` (`id`, `name`, `rules`, `status`, `update_time`, `create_time`) VALUES
(1, '默认分组', '*', '1', 1739733640, 1739733640);

-- --------------------------------------------------------

--
-- 表的结构 `pay_user_money_log`
--

CREATE TABLE `pay_user_money_log` (
  `id` int UNSIGNED NOT NULL COMMENT 'ID',
  `user_id` int UNSIGNED NOT NULL DEFAULT '0' COMMENT '会员ID',
  `money` int NOT NULL DEFAULT '0' COMMENT '变更余额',
  `before` int NOT NULL DEFAULT '0' COMMENT '变更前余额',
  `after` int NOT NULL DEFAULT '0' COMMENT '变更后余额',
  `memo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` bigint UNSIGNED DEFAULT NULL COMMENT '创建时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='会员余额变动表' ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- 表的结构 `pay_user_rule`
--

CREATE TABLE `pay_user_rule` (
  `id` int UNSIGNED NOT NULL COMMENT 'ID',
  `pid` int UNSIGNED NOT NULL DEFAULT '0' COMMENT '上级菜单',
  `type` enum('route','menu_dir','menu','nav_user_menu','nav','button') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'menu' COMMENT '类型:route=路由,menu_dir=菜单目录,menu=菜单项,nav_user_menu=顶栏会员菜单下拉项,nav=顶栏菜单项,button=页面按钮',
  `title` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '标题',
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '规则名称',
  `path` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '路由路径',
  `icon` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '图标',
  `menu_type` enum('tab','link','iframe') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'tab' COMMENT '菜单类型:tab=选项卡,link=链接,iframe=Iframe',
  `url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'Url',
  `component` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '组件路径',
  `no_login_valid` tinyint UNSIGNED NOT NULL DEFAULT '0' COMMENT '未登录有效:0=否,1=是',
  `extend` enum('none','add_rules_only','add_menu_only') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'none' COMMENT '扩展属性:none=无,add_rules_only=只添加为路由,add_menu_only=只添加为菜单',
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '备注',
  `weigh` int NOT NULL DEFAULT '0' COMMENT '权重',
  `status` enum('0','1') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1' COMMENT '状态:0=禁用,1=启用',
  `update_time` bigint UNSIGNED DEFAULT NULL COMMENT '更新时间',
  `create_time` bigint UNSIGNED DEFAULT NULL COMMENT '创建时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='会员菜单权限规则表' ROW_FORMAT=DYNAMIC;

--
-- 转存表中的数据 `pay_user_rule`
--

INSERT INTO `pay_user_rule` (`id`, `pid`, `type`, `title`, `name`, `path`, `icon`, `menu_type`, `url`, `component`, `no_login_valid`, `extend`, `remark`, `weigh`, `status`, `update_time`, `create_time`) VALUES
(1, 0, 'menu_dir', '我的账户', 'account', 'account', 'fa fa-user-circle', 'tab', '', '', 0, 'none', '', 98, '1', 1739733640, 1739733640),
(2, 1, 'menu', '账户概览', 'account/overview', 'account/overview', 'fa fa-home', 'tab', '', '/src/views/frontend/user/account/overview.vue', 0, 'none', '', 99, '1', 1739733640, 1739733640),
(3, 1, 'menu', '个人资料', 'account/profile', 'account/profile', 'fa fa-user-circle-o', 'tab', '', '/src/views/frontend/user/account/profile.vue', 0, 'none', '', 98, '1', 1739733640, 1739733640),
(4, 1, 'menu', '修改密码', 'account/changePassword', 'account/changePassword', 'fa fa-shield', 'tab', '', '/src/views/frontend/user/account/changePassword.vue', 0, 'none', '', 97, '1', 1739733640, 1739733640),
(5, 1, 'menu', '积分记录', 'account/integral', 'account/integral', 'fa fa-tag', 'tab', '', '/src/views/frontend/user/account/integral.vue', 0, 'none', '', 96, '1', 1739733640, 1739733640),
(6, 1, 'menu', '余额记录', 'account/balance', 'account/balance', 'fa fa-money', 'tab', '', '/src/views/frontend/user/account/balance.vue', 0, 'none', '', 95, '1', 1739733640, 1739733640);

-- --------------------------------------------------------

--
-- 表的结构 `pay_user_score_log`
--

CREATE TABLE `pay_user_score_log` (
  `id` int UNSIGNED NOT NULL COMMENT 'ID',
  `user_id` int UNSIGNED NOT NULL DEFAULT '0' COMMENT '会员ID',
  `score` int NOT NULL DEFAULT '0' COMMENT '变更积分',
  `before` int NOT NULL DEFAULT '0' COMMENT '变更前积分',
  `after` int NOT NULL DEFAULT '0' COMMENT '变更后积分',
  `memo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` bigint UNSIGNED DEFAULT NULL COMMENT '创建时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='会员积分变动表' ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- 表的结构 `pay_wechat_offiaccount_autoreply`
--

CREATE TABLE `pay_wechat_offiaccount_autoreply` (
  `id` int UNSIGNED NOT NULL COMMENT 'ID',
  `keyword` varchar(100) DEFAULT '' COMMENT '关键词',
  `type` enum('follow','keyword','default') DEFAULT 'keyword' COMMENT '类型：follow=关注回复；keyword=关键词回复；invalidword=无效词回复',
  `msg_type` enum('text','image','voice','video','news') DEFAULT 'text' COMMENT '消息类型：text=文本；image=图片；voice=语音；news=图文',
  `status` enum('0','1') DEFAULT '0' COMMENT '状态:0=禁用;1=启用',
  `reply_content` text COMMENT '回复内容',
  `create_time` bigint UNSIGNED DEFAULT NULL COMMENT '创建时间',
  `update_time` bigint UNSIGNED DEFAULT NULL COMMENT '更新时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='公众号自动回复';

--
-- 转存表中的数据 `pay_wechat_offiaccount_autoreply`
--

INSERT INTO `pay_wechat_offiaccount_autoreply` (`id`, `keyword`, `type`, `msg_type`, `status`, `reply_content`, `create_time`, `update_time`) VALUES
(5, '你好', 'keyword', 'text', '1', '你好呀', 1692594168, 1693809641),
(6, '', 'follow', 'text', '1', '&lt;a href=&quot;https://buildadmin.com&quot;&gt;BuildAdmin&lt;/a&gt;\n\n欢迎使用流行技术栈快速创建商业级后台管理系统', 1692596134, 1693979021),
(7, '', 'default', 'text', '1', '你好，这是默认回复哦～', 1693467221, 1693467221),
(8, '哈哈', 'keyword', 'text', '1', '哈哈哈哈哈哈哈哈哈', 1693975726, 1693975726);

-- --------------------------------------------------------

--
-- 表的结构 `pay_wechat_offiaccount_material`
--

CREATE TABLE `pay_wechat_offiaccount_material` (
  `id` int UNSIGNED NOT NULL COMMENT 'ID',
  `event_key` varchar(100) DEFAULT '' COMMENT '事件Key',
  `type` enum('image','video','voice','news','text') DEFAULT 'text' COMMENT '类型',
  `content` text COMMENT '内容',
  `create_time` bigint UNSIGNED DEFAULT NULL COMMENT '创建时间',
  `update_time` bigint UNSIGNED DEFAULT NULL COMMENT '更新时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='微信公众号素材';

--
-- 转储表的索引
--

--
-- 表的索引 `pay_admin`
--
ALTER TABLE `pay_admin`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- 表的索引 `pay_admin_group`
--
ALTER TABLE `pay_admin_group`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `pay_admin_group_access`
--
ALTER TABLE `pay_admin_group_access`
  ADD KEY `uid` (`uid`),
  ADD KEY `group_id` (`group_id`);

--
-- 表的索引 `pay_admin_log`
--
ALTER TABLE `pay_admin_log`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `pay_admin_rule`
--
ALTER TABLE `pay_admin_rule`
  ADD PRIMARY KEY (`id`),
  ADD KEY `pid` (`pid`);

--
-- 表的索引 `pay_area`
--
ALTER TABLE `pay_area`
  ADD PRIMARY KEY (`id`),
  ADD KEY `pid` (`pid`);

--
-- 表的索引 `pay_attachment`
--
ALTER TABLE `pay_attachment`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `pay_captcha`
--
ALTER TABLE `pay_captcha`
  ADD PRIMARY KEY (`key`);

--
-- 表的索引 `pay_channel`
--
ALTER TABLE `pay_channel`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `pay_config`
--
ALTER TABLE `pay_config`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- 表的索引 `pay_crud_log`
--
ALTER TABLE `pay_crud_log`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `pay_migrations`
--
ALTER TABLE `pay_migrations`
  ADD PRIMARY KEY (`version`);

--
-- 表的索引 `pay_order`
--
ALTER TABLE `pay_order`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `pay_plugins`
--
ALTER TABLE `pay_plugins`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `pay_qrcode`
--
ALTER TABLE `pay_qrcode`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `pay_qrcode_log`
--
ALTER TABLE `pay_qrcode_log`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `pay_security_data_recycle`
--
ALTER TABLE `pay_security_data_recycle`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `pay_security_data_recycle_log`
--
ALTER TABLE `pay_security_data_recycle_log`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `pay_security_sensitive_data`
--
ALTER TABLE `pay_security_sensitive_data`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `pay_security_sensitive_data_log`
--
ALTER TABLE `pay_security_sensitive_data_log`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `pay_template`
--
ALTER TABLE `pay_template`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `pay_test_build`
--
ALTER TABLE `pay_test_build`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `pay_token`
--
ALTER TABLE `pay_token`
  ADD PRIMARY KEY (`token`);

--
-- 表的索引 `pay_user`
--
ALTER TABLE `pay_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- 表的索引 `pay_user_group`
--
ALTER TABLE `pay_user_group`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `pay_user_money_log`
--
ALTER TABLE `pay_user_money_log`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `pay_user_rule`
--
ALTER TABLE `pay_user_rule`
  ADD PRIMARY KEY (`id`),
  ADD KEY `pid` (`pid`);

--
-- 表的索引 `pay_user_score_log`
--
ALTER TABLE `pay_user_score_log`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `pay_wechat_offiaccount_autoreply`
--
ALTER TABLE `pay_wechat_offiaccount_autoreply`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- 表的索引 `pay_wechat_offiaccount_material`
--
ALTER TABLE `pay_wechat_offiaccount_material`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- 在导出的表使用AUTO_INCREMENT
--

--
-- 使用表AUTO_INCREMENT `pay_admin`
--
ALTER TABLE `pay_admin`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID', AUTO_INCREMENT=2;

--
-- 使用表AUTO_INCREMENT `pay_admin_group`
--
ALTER TABLE `pay_admin_group`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID', AUTO_INCREMENT=5;

--
-- 使用表AUTO_INCREMENT `pay_admin_log`
--
ALTER TABLE `pay_admin_log`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID', AUTO_INCREMENT=323;

--
-- 使用表AUTO_INCREMENT `pay_admin_rule`
--
ALTER TABLE `pay_admin_rule`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID', AUTO_INCREMENT=151;

--
-- 使用表AUTO_INCREMENT `pay_area`
--
ALTER TABLE `pay_area`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID';

--
-- 使用表AUTO_INCREMENT `pay_attachment`
--
ALTER TABLE `pay_attachment`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID', AUTO_INCREMENT=2;

--
-- 使用表AUTO_INCREMENT `pay_channel`
--
ALTER TABLE `pay_channel`
  MODIFY `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID', AUTO_INCREMENT=10;

--
-- 使用表AUTO_INCREMENT `pay_config`
--
ALTER TABLE `pay_config`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID', AUTO_INCREMENT=18;

--
-- 使用表AUTO_INCREMENT `pay_crud_log`
--
ALTER TABLE `pay_crud_log`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID', AUTO_INCREMENT=8;

--
-- 使用表AUTO_INCREMENT `pay_order`
--
ALTER TABLE `pay_order`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '订单ID', AUTO_INCREMENT=98;

--
-- 使用表AUTO_INCREMENT `pay_plugins`
--
ALTER TABLE `pay_plugins`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID', AUTO_INCREMENT=12;

--
-- 使用表AUTO_INCREMENT `pay_qrcode`
--
ALTER TABLE `pay_qrcode`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID', AUTO_INCREMENT=2;

--
-- 使用表AUTO_INCREMENT `pay_qrcode_log`
--
ALTER TABLE `pay_qrcode_log`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID', AUTO_INCREMENT=87;

--
-- 使用表AUTO_INCREMENT `pay_security_data_recycle`
--
ALTER TABLE `pay_security_data_recycle`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID', AUTO_INCREMENT=7;

--
-- 使用表AUTO_INCREMENT `pay_security_data_recycle_log`
--
ALTER TABLE `pay_security_data_recycle_log`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID';

--
-- 使用表AUTO_INCREMENT `pay_security_sensitive_data`
--
ALTER TABLE `pay_security_sensitive_data`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID', AUTO_INCREMENT=4;

--
-- 使用表AUTO_INCREMENT `pay_security_sensitive_data_log`
--
ALTER TABLE `pay_security_sensitive_data_log`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID';

--
-- 使用表AUTO_INCREMENT `pay_template`
--
ALTER TABLE `pay_template`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID', AUTO_INCREMENT=12;

--
-- 使用表AUTO_INCREMENT `pay_test_build`
--
ALTER TABLE `pay_test_build`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID';

--
-- 使用表AUTO_INCREMENT `pay_user`
--
ALTER TABLE `pay_user`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID', AUTO_INCREMENT=2;

--
-- 使用表AUTO_INCREMENT `pay_user_group`
--
ALTER TABLE `pay_user_group`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID', AUTO_INCREMENT=2;

--
-- 使用表AUTO_INCREMENT `pay_user_money_log`
--
ALTER TABLE `pay_user_money_log`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID';

--
-- 使用表AUTO_INCREMENT `pay_user_rule`
--
ALTER TABLE `pay_user_rule`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID', AUTO_INCREMENT=7;

--
-- 使用表AUTO_INCREMENT `pay_user_score_log`
--
ALTER TABLE `pay_user_score_log`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID';

--
-- 使用表AUTO_INCREMENT `pay_wechat_offiaccount_autoreply`
--
ALTER TABLE `pay_wechat_offiaccount_autoreply`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID', AUTO_INCREMENT=9;

--
-- 使用表AUTO_INCREMENT `pay_wechat_offiaccount_material`
--
ALTER TABLE `pay_wechat_offiaccount_material`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID';
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
