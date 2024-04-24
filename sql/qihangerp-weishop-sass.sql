/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 80200
 Source Host           : localhost:3306
 Source Schema         : qihangerp-weishop-sass

 Target Server Type    : MySQL
 Target Server Version : 80200
 File Encoding         : 65001

 Date: 24/04/2024 21:05:23
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for erp_after_sale
-- ----------------------------
DROP TABLE IF EXISTS `erp_after_sale`;
CREATE TABLE `erp_after_sale`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `type` int NULL DEFAULT NULL COMMENT '类型（10退货；20换货；80补发；99订单拦截；）',
  `shop_id` int NULL DEFAULT NULL COMMENT '店铺id',
  `shop_type` int NULL DEFAULT NULL COMMENT '店铺类型',
  `after_sale_order_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '售后单号',
  `order_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '订单号',
  `sub_order_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '子订单号',
  `product_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品spuid',
  `sku_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品skuid',
  `count` int NULL DEFAULT NULL COMMENT '数量',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品标题',
  `img` varchar(555) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品图片',
  `sku_info` varchar(2550) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'sku描述',
  `sku_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'sku编码',
  `erp_goods_id` int NULL DEFAULT NULL COMMENT 'ERP商品id',
  `erp_sku_id` int NULL DEFAULT NULL COMMENT 'ERP商品skuId',
  `return_info` varchar(2550) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '退回人信息json',
  `return_waybill_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '退回快递单号',
  `return_company` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '退回物流公司名称',
  `receiver_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '收件人姓名',
  `receiver_tel` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '收件人联系电话',
  `receiver_province` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '省',
  `receiver_city` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '市',
  `receiver_town` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '区',
  `receiver_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '收件人详细地址',
  `ship_waybill_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '发货快递单号（补发、换货发货、拦截订单发货）',
  `ship_company` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '发货快递公司',
  `status` int NULL DEFAULT NULL COMMENT '状态:1已发出；2已完成(已收货);3已入库',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `create_time` datetime NULL DEFAULT NULL,
  `create_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `update_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '售后处理表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of erp_after_sale
-- ----------------------------

-- ----------------------------
-- Table structure for erp_goods
-- ----------------------------
DROP TABLE IF EXISTS `erp_goods`;
CREATE TABLE `erp_goods`  (
  `id` bigint NOT NULL COMMENT '主键id',
  `tenant_id` bigint NOT NULL COMMENT '租户id',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '商品名称',
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '商品图片地址',
  `number` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '商品编号',
  `unit_name` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '单位名称',
  `category_id` bigint NULL DEFAULT 0 COMMENT '商品分类ID',
  `bar_code` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '条码',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '备注',
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '状态1销售中2已下架',
  `length` float NOT NULL DEFAULT 0 COMMENT '衣长/裙长/裤长',
  `height` float NOT NULL DEFAULT 0 COMMENT '高度/袖长',
  `width` float NOT NULL DEFAULT 0 COMMENT '宽度/胸阔(围)',
  `width1` float NOT NULL DEFAULT 0 COMMENT '肩阔',
  `width2` float NOT NULL DEFAULT 0 COMMENT '腰阔',
  `width3` float NOT NULL DEFAULT 0 COMMENT '臀阔',
  `weight` float NOT NULL DEFAULT 0 COMMENT '重量',
  `disable` tinyint(1) NULL DEFAULT 0 COMMENT '1启用   0禁用',
  `period` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '保质期',
  `pur_price` decimal(8, 2) NULL DEFAULT 0.00 COMMENT '预计采购价格',
  `whole_price` decimal(8, 2) NULL DEFAULT 0.00 COMMENT '建议批发价',
  `retail_price` decimal(8, 2) NULL DEFAULT 0.00 COMMENT '建议零售价',
  `unit_cost` decimal(8, 2) NULL DEFAULT NULL COMMENT '单位成本',
  `supplier_id` bigint NULL DEFAULT 0 COMMENT '供应商id',
  `brand_id` bigint NULL DEFAULT 0 COMMENT '品牌id',
  `attr1` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '属性1：季节',
  `attr2` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '属性2：分类',
  `attr3` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '属性3：风格',
  `attr4` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '属性4：年份',
  `attr5` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '属性5：面料',
  `link_url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '外链url',
  `low_qty` int NULL DEFAULT 0 COMMENT '最低库存（预警）',
  `high_qty` int NULL DEFAULT 0 COMMENT '最高库存（预警）',
  `create_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `number`(`number`) USING BTREE,
  INDEX `id`(`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '商品库存管理' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of erp_goods
-- ----------------------------
INSERT INTO `erp_goods` VALUES (1781988656060411906, 100, '男士流行夏季牛仔裤黑色', NULL, 'NZK000232', '', 1781968397051912193, '', '', 1, 0, 0, 0, 0, 0, 0, 0, 0, '0', 120.00, 0.00, 0.00, NULL, 1781960910751948802, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, '15818590119', '2024-04-21 18:09:38', NULL, NULL);

-- ----------------------------
-- Table structure for erp_goods_brand
-- ----------------------------
DROP TABLE IF EXISTS `erp_goods_brand`;
CREATE TABLE `erp_goods_brand`  (
  `id` bigint NOT NULL COMMENT '主键ID',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '品牌名',
  `status` int NOT NULL COMMENT '状态',
  `tenant_id` bigint NOT NULL COMMENT '租户id（sys_user_id）',
  `create_by` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  `update_by` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of erp_goods_brand
-- ----------------------------
INSERT INTO `erp_goods_brand` VALUES (1, '梦小妮', 1, 100, 'admin', '2023-12-29 13:44:29', 'admin', '2023-12-29 13:44:29');

-- ----------------------------
-- Table structure for erp_goods_category
-- ----------------------------
DROP TABLE IF EXISTS `erp_goods_category`;
CREATE TABLE `erp_goods_category`  (
  `id` bigint NOT NULL,
  `number` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '分类编码',
  `name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '分类名称',
  `remark` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `top_id` bigint NULL DEFAULT NULL COMMENT '最顶级id',
  `parent_id` bigint NULL DEFAULT NULL COMMENT '上架分类id',
  `path` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '分类路径',
  `sort` int NULL DEFAULT 0 COMMENT '排序值',
  `image` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '图片',
  `is_delete` tinyint(1) NULL DEFAULT 0 COMMENT '0正常  1删除',
  `tenant_id` bigint NULL DEFAULT NULL COMMENT '租户id',
  `create_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of erp_goods_category
-- ----------------------------
INSERT INTO `erp_goods_category` VALUES (1, 'NVZHUANG', '女装', NULL, NULL, 0, '0', 0, '', 0, NULL, 'admin', '2023-12-29 14:42:36', NULL, NULL);
INSERT INTO `erp_goods_category` VALUES (2, 'MAOYI', '毛衣/针织衫', NULL, NULL, 1, '0|1', 0, NULL, 0, NULL, 'admin', '2023-12-29 14:42:36', NULL, NULL);
INSERT INTO `erp_goods_category` VALUES (3, 'TXU', 'T恤', NULL, NULL, 1, '0|1', 0, NULL, 0, NULL, 'admin', '2023-12-29 14:42:36', NULL, NULL);
INSERT INTO `erp_goods_category` VALUES (4, 'LIANYIQUN', '连衣裙', NULL, NULL, 1, '0|1', 0, NULL, 0, NULL, 'admin', '2023-12-29 14:42:36', NULL, NULL);
INSERT INTO `erp_goods_category` VALUES (5, 'XIUXIANKU', '休闲裤', NULL, NULL, 1, '0|1', 0, NULL, 0, NULL, 'admin', '2023-12-29 14:42:36', NULL, NULL);
INSERT INTO `erp_goods_category` VALUES (6, 'WAITAO', '外套', NULL, NULL, 1, '0|1', 0, NULL, 0, NULL, 'admin', '2023-12-29 14:42:36', NULL, NULL);
INSERT INTO `erp_goods_category` VALUES (7, 'ZHENZHIPJ', '内衣/背心', NULL, NULL, 1, '0|1', 0, NULL, 0, NULL, 'admin', '2023-12-29 14:42:36', NULL, NULL);
INSERT INTO `erp_goods_category` VALUES (8, 'SUOZHI', '半身裙', NULL, NULL, 1, '0|1', 0, NULL, 0, NULL, 'admin', '2023-12-29 14:42:36', NULL, NULL);
INSERT INTO `erp_goods_category` VALUES (9, NULL, '衬衫', NULL, NULL, 1, '0|1', 0, NULL, 0, NULL, 'admin', '2023-12-29 14:42:36', NULL, NULL);
INSERT INTO `erp_goods_category` VALUES (10, NULL, '箱包', NULL, NULL, 0, '0|1', 0, NULL, 0, NULL, 'admin', '2023-12-29 14:42:36', NULL, NULL);
INSERT INTO `erp_goods_category` VALUES (11, NULL, '双肩包', NULL, NULL, 10, '0|10', 0, NULL, 0, NULL, 'admin', '2023-12-29 14:42:36', NULL, NULL);
INSERT INTO `erp_goods_category` VALUES (12, NULL, '单肩包', NULL, NULL, 10, '0|10', 0, NULL, 0, NULL, 'admin', '2023-12-29 14:42:36', NULL, NULL);
INSERT INTO `erp_goods_category` VALUES (13, NULL, '套装', NULL, NULL, 1, '0|1', 0, NULL, 0, NULL, 'admin', '2023-12-29 14:42:36', NULL, NULL);
INSERT INTO `erp_goods_category` VALUES (14, NULL, '短裙', NULL, NULL, 10, '0|8', 0, NULL, 1, NULL, 'admin', '2023-12-29 14:42:36', NULL, NULL);
INSERT INTO `erp_goods_category` VALUES (15, NULL, '半身裙', NULL, NULL, 10, '0|8', 0, NULL, 1, NULL, 'admin', '2023-12-29 14:42:36', NULL, NULL);
INSERT INTO `erp_goods_category` VALUES (16, NULL, '连衣裙', NULL, NULL, 10, '0|1', 0, NULL, 1, NULL, 'admin', '2023-12-29 14:42:36', NULL, NULL);
INSERT INTO `erp_goods_category` VALUES (17, NULL, '针织裤', NULL, NULL, 10, '0|1', 0, NULL, 1, NULL, 'admin', '2023-12-29 14:42:36', NULL, NULL);
INSERT INTO `erp_goods_category` VALUES (18, NULL, '针织短裙', NULL, NULL, 10, '0|1', 0, NULL, 1, NULL, 'admin', '2023-12-29 14:42:36', NULL, NULL);
INSERT INTO `erp_goods_category` VALUES (19, NULL, '针织外套', NULL, NULL, 10, '0|1', 0, NULL, 1, NULL, 'admin', '2023-12-29 14:42:36', NULL, NULL);
INSERT INTO `erp_goods_category` VALUES (20, NULL, '针织背心', NULL, NULL, 10, '0|1', 0, NULL, 1, NULL, 'admin', '2023-12-29 14:42:36', NULL, NULL);
INSERT INTO `erp_goods_category` VALUES (21, NULL, 'T恤衫', NULL, NULL, 10, '0|8', 0, NULL, 1, NULL, 'admin', '2023-12-29 14:42:36', NULL, NULL);
INSERT INTO `erp_goods_category` VALUES (22, NULL, '梭织衬衫', NULL, NULL, 10, '0|8', 0, NULL, 1, NULL, 'admin', '2023-12-29 14:42:36', NULL, NULL);
INSERT INTO `erp_goods_category` VALUES (23, 'BAIHUO', '百货', NULL, NULL, 0, '0', 0, NULL, 0, NULL, 'admin', '2023-12-29 14:42:36', NULL, NULL);
INSERT INTO `erp_goods_category` VALUES (24, NULL, '调味调料', NULL, NULL, 23, '0|23', 0, NULL, 0, NULL, 'admin', '2023-12-29 14:42:36', NULL, NULL);
INSERT INTO `erp_goods_category` VALUES (25, NULL, '小百货', NULL, NULL, 23, '0|23', 0, NULL, 0, NULL, 'admin', '2023-12-29 14:42:36', NULL, NULL);
INSERT INTO `erp_goods_category` VALUES (26, 'NIUZAI', '牛仔裤', NULL, NULL, 1, '0|1|26', 0, NULL, 0, NULL, 'admin', '2023-12-29 14:42:36', NULL, NULL);
INSERT INTO `erp_goods_category` VALUES (27, NULL, '牛仔短裤', NULL, NULL, 26, '0|26', 0, NULL, 0, NULL, 'admin', '2023-12-29 14:42:36', NULL, NULL);
INSERT INTO `erp_goods_category` VALUES (28, NULL, '阔腿裤', NULL, NULL, 26, '0|26', 0, NULL, 0, NULL, 'admin', '2023-12-29 14:42:36', NULL, NULL);
INSERT INTO `erp_goods_category` VALUES (29, NULL, '喇叭裤', NULL, NULL, 26, '0|26', 0, NULL, 0, NULL, 'admin', '2023-12-29 14:42:36', NULL, NULL);
INSERT INTO `erp_goods_category` VALUES (30, NULL, '哈伦裤', '哈伦萝卜老爹裤', NULL, 26, '0|26', 0, NULL, 0, NULL, 'admin', '2023-12-29 14:42:36', NULL, NULL);
INSERT INTO `erp_goods_category` VALUES (31, NULL, '铅笔裤', '小脚裤、紧身裤、铅笔裤', NULL, 26, '0|26', 0, NULL, 0, NULL, 'admin', '2023-12-29 14:42:36', NULL, NULL);
INSERT INTO `erp_goods_category` VALUES (32, NULL, '直筒裤', '小直筒烟管裤', NULL, 26, '0|26', 0, NULL, 0, NULL, 'admin', '2023-12-29 14:42:36', NULL, NULL);
INSERT INTO `erp_goods_category` VALUES (33, NULL, '背带裤', '', NULL, 26, '0|26', 0, NULL, 0, NULL, 'admin', '2023-12-29 14:42:36', NULL, NULL);
INSERT INTO `erp_goods_category` VALUES (1781916938344173569, 'A0222D', '男装', NULL, 0, 0, '', 0, NULL, 0, 100, '手动添加', '2024-04-21 13:24:39', NULL, NULL);
INSERT INTO `erp_goods_category` VALUES (1781917406537551873, 'A220252', '上衣1', NULL, 1781916938344173569, 1781916938344173569, '', 4, NULL, 0, 100, '手动添加', '2024-04-21 13:26:31', '手动更新', '2024-04-21 16:39:10');
INSERT INTO `erp_goods_category` VALUES (1781968290021662722, 'KUZI', '裤子', NULL, 1781916938344173569, 1781916938344173569, '', 0, NULL, 0, 100, '手动添加', '2024-04-21 16:48:42', NULL, NULL);
INSERT INTO `erp_goods_category` VALUES (1781968397051912193, 'nzk', '牛仔裤', NULL, 1781916938344173569, 1781968290021662722, '', 0, NULL, 0, 100, '手动添加', '2024-04-21 16:49:08', NULL, NULL);

-- ----------------------------
-- Table structure for erp_goods_category_attribute
-- ----------------------------
DROP TABLE IF EXISTS `erp_goods_category_attribute`;
CREATE TABLE `erp_goods_category_attribute`  (
  `id` bigint NOT NULL COMMENT '主键id',
  `category_id` bigint NOT NULL,
  `type` int NOT NULL DEFAULT 0 COMMENT '类型：0属性1规格',
  `title` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '\'属性名\'',
  `code` char(5) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '固定值color颜色size尺码style款式',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 117 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of erp_goods_category_attribute
-- ----------------------------
INSERT INTO `erp_goods_category_attribute` VALUES (114, 1, 1, '颜色', 'color');
INSERT INTO `erp_goods_category_attribute` VALUES (115, 1, 1, '尺码', 'size');
INSERT INTO `erp_goods_category_attribute` VALUES (116, 1, 1, '款式', 'style');
INSERT INTO `erp_goods_category_attribute` VALUES (1781941806087319554, 1781916938344173569, 1, '颜色', 'color');
INSERT INTO `erp_goods_category_attribute` VALUES (1781941897267294210, 1781916938344173569, 1, '尺码', 'size');

-- ----------------------------
-- Table structure for erp_goods_category_attribute_value
-- ----------------------------
DROP TABLE IF EXISTS `erp_goods_category_attribute_value`;
CREATE TABLE `erp_goods_category_attribute_value`  (
  `id` bigint NOT NULL COMMENT '主键，属性值id',
  `category_attribute_id` bigint NULL DEFAULT NULL COMMENT '属性id',
  `value` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '属性值文本',
  `sku_code` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '生成SKU的编码',
  `order_num` int NULL DEFAULT 0,
  `is_delete` int NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of erp_goods_category_attribute_value
-- ----------------------------
INSERT INTO `erp_goods_category_attribute_value` VALUES (308, 114, '黑色', '01', 999, 0);
INSERT INTO `erp_goods_category_attribute_value` VALUES (309, 114, '米杏', '02', 0, 0);
INSERT INTO `erp_goods_category_attribute_value` VALUES (310, 114, '芒果黄', '03', 0, 0);
INSERT INTO `erp_goods_category_attribute_value` VALUES (311, 114, '中花灰', '04', 0, 0);
INSERT INTO `erp_goods_category_attribute_value` VALUES (312, 114, '浅杏', '05', 0, 0);
INSERT INTO `erp_goods_category_attribute_value` VALUES (313, 114, '中粉', '06', 0, 0);
INSERT INTO `erp_goods_category_attribute_value` VALUES (314, 114, '烟灰色', '07', 88, 0);
INSERT INTO `erp_goods_category_attribute_value` VALUES (315, 114, '秋香绿', '08', 0, 0);
INSERT INTO `erp_goods_category_attribute_value` VALUES (316, 114, '花兰', '09', 0, 0);
INSERT INTO `erp_goods_category_attribute_value` VALUES (317, 114, '杏色', '10', 698, 0);
INSERT INTO `erp_goods_category_attribute_value` VALUES (318, 114, '芥黄', '11', 0, 0);
INSERT INTO `erp_goods_category_attribute_value` VALUES (319, 114, '深蓝色', '12', 993, 0);
INSERT INTO `erp_goods_category_attribute_value` VALUES (320, 114, '大红', '13', 0, 0);
INSERT INTO `erp_goods_category_attribute_value` VALUES (321, 114, '彩兰', '14', 0, 0);
INSERT INTO `erp_goods_category_attribute_value` VALUES (322, 114, '白色', '15', 99, 0);
INSERT INTO `erp_goods_category_attribute_value` VALUES (323, 114, '花米驼', '16', 0, 0);
INSERT INTO `erp_goods_category_attribute_value` VALUES (324, 114, '粉红', '17', 0, 0);
INSERT INTO `erp_goods_category_attribute_value` VALUES (325, 114, '黄杏', '18', 0, 0);
INSERT INTO `erp_goods_category_attribute_value` VALUES (326, 114, '橙红', '19', 0, 0);
INSERT INTO `erp_goods_category_attribute_value` VALUES (327, 114, '木绿', '20', 0, 0);
INSERT INTO `erp_goods_category_attribute_value` VALUES (328, 114, '草绿', '21', 0, 0);
INSERT INTO `erp_goods_category_attribute_value` VALUES (329, 114, '早红', '22', 0, 0);
INSERT INTO `erp_goods_category_attribute_value` VALUES (330, 114, '咖啡', '23', 0, 0);
INSERT INTO `erp_goods_category_attribute_value` VALUES (331, 114, '灰色', '24', 99, 0);
INSERT INTO `erp_goods_category_attribute_value` VALUES (332, 114, '浅绿', '25', 0, 0);
INSERT INTO `erp_goods_category_attribute_value` VALUES (333, 114, '大红色', '26', 99, 0);
INSERT INTO `erp_goods_category_attribute_value` VALUES (334, 114, '桔色', '27', 0, 0);
INSERT INTO `erp_goods_category_attribute_value` VALUES (335, 114, '卡其', '28', 992, 0);
INSERT INTO `erp_goods_category_attribute_value` VALUES (336, 114, '蓝灰色', '29', 996, 0);
INSERT INTO `erp_goods_category_attribute_value` VALUES (337, 114, '湖蓝', '30', 0, 0);
INSERT INTO `erp_goods_category_attribute_value` VALUES (338, 114, '咖啡色', '31', 99, 0);
INSERT INTO `erp_goods_category_attribute_value` VALUES (339, 114, '蓝绿', '32', 0, 0);
INSERT INTO `erp_goods_category_attribute_value` VALUES (340, 115, '均码', '00', 0, 0);
INSERT INTO `erp_goods_category_attribute_value` VALUES (341, 115, 'S', '01', 88, 0);
INSERT INTO `erp_goods_category_attribute_value` VALUES (342, 115, 'M', '02', 87, 0);
INSERT INTO `erp_goods_category_attribute_value` VALUES (343, 115, 'L', '03', 86, 0);
INSERT INTO `erp_goods_category_attribute_value` VALUES (344, 115, 'XL', '04', 85, 0);
INSERT INTO `erp_goods_category_attribute_value` VALUES (345, 115, '2XL', '05', 84, 0);
INSERT INTO `erp_goods_category_attribute_value` VALUES (346, 115, '3XL', '06', 0, 0);
INSERT INTO `erp_goods_category_attribute_value` VALUES (347, 115, '4XL', '07', 0, 0);
INSERT INTO `erp_goods_category_attribute_value` VALUES (348, 115, '5XL', '08', 0, 0);
INSERT INTO `erp_goods_category_attribute_value` VALUES (349, 114, '雾霾蓝', '33', 0, 0);
INSERT INTO `erp_goods_category_attribute_value` VALUES (350, 114, '浅粉红', '34', 0, 0);
INSERT INTO `erp_goods_category_attribute_value` VALUES (351, 114, '蓝色', '35', 998, 0);
INSERT INTO `erp_goods_category_attribute_value` VALUES (352, 114, '花色', '36', 0, 0);
INSERT INTO `erp_goods_category_attribute_value` VALUES (353, 114, '香槟色', '37', 0, 0);
INSERT INTO `erp_goods_category_attribute_value` VALUES (354, 114, '紫色', '38', 0, 0);
INSERT INTO `erp_goods_category_attribute_value` VALUES (355, 114, '砖红色', '39', 0, 0);
INSERT INTO `erp_goods_category_attribute_value` VALUES (356, 114, '复古蓝', '40', 995, 0);
INSERT INTO `erp_goods_category_attribute_value` VALUES (357, 114, '烟灰', '41', 0, 0);
INSERT INTO `erp_goods_category_attribute_value` VALUES (358, 114, '橙黄', '42', 0, 0);
INSERT INTO `erp_goods_category_attribute_value` VALUES (359, 114, '黄色', '43', 0, 0);
INSERT INTO `erp_goods_category_attribute_value` VALUES (360, 114, '梅子色', '56', 0, 0);
INSERT INTO `erp_goods_category_attribute_value` VALUES (361, 114, '浅蓝色', '50', 994, 0);
INSERT INTO `erp_goods_category_attribute_value` VALUES (362, 114, '宝蓝色', '44', 99, 0);
INSERT INTO `erp_goods_category_attribute_value` VALUES (363, 114, '浅黄', '45', 0, 0);
INSERT INTO `erp_goods_category_attribute_value` VALUES (364, 114, '浅紫', '49', 0, 0);
INSERT INTO `erp_goods_category_attribute_value` VALUES (365, 114, '酒红', '57', 99, 0);
INSERT INTO `erp_goods_category_attribute_value` VALUES (366, 114, '米白', '47', 99, 0);
INSERT INTO `erp_goods_category_attribute_value` VALUES (367, 114, '复古蓝九分', '48', 88, 0);
INSERT INTO `erp_goods_category_attribute_value` VALUES (368, 114, '卡灰', '51', 992, 0);
INSERT INTO `erp_goods_category_attribute_value` VALUES (369, 114, '玫红', '52', 0, 0);
INSERT INTO `erp_goods_category_attribute_value` VALUES (370, 114, '彩蓝', '53', 0, 0);
INSERT INTO `erp_goods_category_attribute_value` VALUES (371, 114, '青蓝淡黄', '54', 0, 0);
INSERT INTO `erp_goods_category_attribute_value` VALUES (372, 114, '紫白', '55', 0, 0);
INSERT INTO `erp_goods_category_attribute_value` VALUES (373, 114, '碳灰', '58', 0, 0);
INSERT INTO `erp_goods_category_attribute_value` VALUES (374, 114, '深蓝色加绒', '59', 794, 0);
INSERT INTO `erp_goods_category_attribute_value` VALUES (375, 114, '深紫色', '60', 99, 0);
INSERT INTO `erp_goods_category_attribute_value` VALUES (376, 114, '橙色', '61', 0, 0);
INSERT INTO `erp_goods_category_attribute_value` VALUES (377, 114, '墨绿色', '62', 99, 0);
INSERT INTO `erp_goods_category_attribute_value` VALUES (378, 114, '桃粉色', '63', 0, 0);
INSERT INTO `erp_goods_category_attribute_value` VALUES (379, 114, '蓝灰色九分', '64', 88, 0);
INSERT INTO `erp_goods_category_attribute_value` VALUES (380, 114, '黑色九分', '65', 88, 0);
INSERT INTO `erp_goods_category_attribute_value` VALUES (381, 114, '新洋米', '67', 0, 0);
INSERT INTO `erp_goods_category_attribute_value` VALUES (382, 114, '藏蓝色', '68', 99, 0);
INSERT INTO `erp_goods_category_attribute_value` VALUES (383, 114, '深蓝九分', '69', 88, 0);
INSERT INTO `erp_goods_category_attribute_value` VALUES (384, 114, '深蓝长款', '70', 88, 0);
INSERT INTO `erp_goods_category_attribute_value` VALUES (385, 114, '米白色', '71', 0, 0);
INSERT INTO `erp_goods_category_attribute_value` VALUES (386, 114, '军绿色', '72', 0, 0);
INSERT INTO `erp_goods_category_attribute_value` VALUES (387, 114, '柠檬黄', '73', 0, 0);
INSERT INTO `erp_goods_category_attribute_value` VALUES (388, 114, '灰紫', '74', 0, 0);
INSERT INTO `erp_goods_category_attribute_value` VALUES (389, 114, '黑灰色', '75', 997, 0);
INSERT INTO `erp_goods_category_attribute_value` VALUES (390, 114, '焦糖红', '76', 0, 0);
INSERT INTO `erp_goods_category_attribute_value` VALUES (391, 114, '酱紫', '78', 0, 0);
INSERT INTO `erp_goods_category_attribute_value` VALUES (392, 114, '红杏', '46', 0, 0);
INSERT INTO `erp_goods_category_attribute_value` VALUES (393, 114, '银灰', '79', 0, 0);
INSERT INTO `erp_goods_category_attribute_value` VALUES (394, 115, 'XS', '09', 89, 0);
INSERT INTO `erp_goods_category_attribute_value` VALUES (395, 114, '无色', '00', 0, 0);
INSERT INTO `erp_goods_category_attribute_value` VALUES (396, 114, '条纹', '80', 0, 0);
INSERT INTO `erp_goods_category_attribute_value` VALUES (397, 114, '花色/彩色', '81', 0, 0);
INSERT INTO `erp_goods_category_attribute_value` VALUES (398, 114, '波点', '82', 0, 0);
INSERT INTO `erp_goods_category_attribute_value` VALUES (399, 114, '字母', '83', 0, 0);
INSERT INTO `erp_goods_category_attribute_value` VALUES (400, 114, '绿色', '84', 0, 0);
INSERT INTO `erp_goods_category_attribute_value` VALUES (401, 115, '25', '25', 69, 0);
INSERT INTO `erp_goods_category_attribute_value` VALUES (402, 115, '26', '26', 68, 0);
INSERT INTO `erp_goods_category_attribute_value` VALUES (403, 115, '27', '27', 67, 0);
INSERT INTO `erp_goods_category_attribute_value` VALUES (404, 115, '28', '28', 66, 0);
INSERT INTO `erp_goods_category_attribute_value` VALUES (405, 115, '29', '29', 65, 0);
INSERT INTO `erp_goods_category_attribute_value` VALUES (406, 115, '30', '30', 64, 0);
INSERT INTO `erp_goods_category_attribute_value` VALUES (407, 115, '31', '31', 63, 0);
INSERT INTO `erp_goods_category_attribute_value` VALUES (408, 115, '32', '32', 62, 0);
INSERT INTO `erp_goods_category_attribute_value` VALUES (409, 114, '黑色加绒', '101', 799, 0);
INSERT INTO `erp_goods_category_attribute_value` VALUES (410, 114, '黑灰色加绒', '175', 798, 0);
INSERT INTO `erp_goods_category_attribute_value` VALUES (411, 114, '蓝灰色加绒', '129', 797, 0);
INSERT INTO `erp_goods_category_attribute_value` VALUES (412, 114, '复古蓝加绒', '140', 796, 0);
INSERT INTO `erp_goods_category_attribute_value` VALUES (413, 114, '浅蓝色加绒', '150', 795, 0);
INSERT INTO `erp_goods_category_attribute_value` VALUES (414, 116, '默认', NULL, 0, 0);
INSERT INTO `erp_goods_category_attribute_value` VALUES (415, 116, '加长裤', 'JC', 66, 0);
INSERT INTO `erp_goods_category_attribute_value` VALUES (416, 116, '长裤', 'CK', 68, 0);
INSERT INTO `erp_goods_category_attribute_value` VALUES (417, 116, '九分', 'JF', 88, 0);
INSERT INTO `erp_goods_category_attribute_value` VALUES (418, 116, '八分', 'BF', 86, 0);
INSERT INTO `erp_goods_category_attribute_value` VALUES (419, 116, '九分加绒', 'JFR', 87, 0);
INSERT INTO `erp_goods_category_attribute_value` VALUES (420, 116, '单裤', 'D', 0, 0);
INSERT INTO `erp_goods_category_attribute_value` VALUES (421, 116, '加绒', 'R', 0, 0);
INSERT INTO `erp_goods_category_attribute_value` VALUES (422, 116, '长裤加绒', 'CR', 65, 0);
INSERT INTO `erp_goods_category_attribute_value` VALUES (423, 116, '加长裤加绒', 'JCR', 67, 0);
INSERT INTO `erp_goods_category_attribute_value` VALUES (1673551873, 1781941806087319554, '红色', '00', 0, 0);

-- ----------------------------
-- Table structure for erp_goods_inventory
-- ----------------------------
DROP TABLE IF EXISTS `erp_goods_inventory`;
CREATE TABLE `erp_goods_inventory`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `goodsId` int NOT NULL COMMENT '商品id',
  `goodsNumber` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '商品编码',
  `specId` int NOT NULL COMMENT '商品规格id',
  `specNumber` varchar(25) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '' COMMENT '规格编码（唯一）',
  `currentQty` bigint NOT NULL DEFAULT 0 COMMENT '当前库存',
  `lockedQty` bigint NOT NULL DEFAULT 0 COMMENT '锁定库存',
  `isDelete` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0正常  1删除',
  `createTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `createBy` varchar(25) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `updateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `updateBy` varchar(25) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `specIdIndex`(`specId`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '商品库存表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of erp_goods_inventory
-- ----------------------------
INSERT INTO `erp_goods_inventory` VALUES (6, 9, 'HN8026', 32, '2720210080260105', 8, 0, 0, '2024-01-16 14:51:50', 'admin', '2024-01-16 15:05:44', 'admin');

-- ----------------------------
-- Table structure for erp_goods_inventory_detail
-- ----------------------------
DROP TABLE IF EXISTS `erp_goods_inventory_detail`;
CREATE TABLE `erp_goods_inventory_detail`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `inventoryId` bigint NOT NULL COMMENT '商品库存id',
  `inQty` int NOT NULL DEFAULT 0 COMMENT '入库数量',
  `originQty` bigint NOT NULL COMMENT '入库前数量',
  `currentQty` bigint NOT NULL DEFAULT 0 COMMENT '当前库存数量',
  `purPrice` double NULL DEFAULT 0 COMMENT '采购价',
  `entryId` bigint NOT NULL COMMENT '入库单id',
  `entryItemId` bigint NOT NULL COMMENT '入库单itemId',
  `remark` varchar(250) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '备注',
  `specId` int NOT NULL COMMENT '规格id',
  `goodsId` int NOT NULL COMMENT '商品id',
  `inLocation` int NOT NULL COMMENT '入库仓位id',
  `createTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `createBy` varchar(25) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '创建人',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '商品库存明细表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of erp_goods_inventory_detail
-- ----------------------------
INSERT INTO `erp_goods_inventory_detail` VALUES (7, 6, 10, 0, 8, NULL, 8, 4, NULL, 32, 9, 20, '2024-01-16 14:51:50', 'admin');

-- ----------------------------
-- Table structure for erp_goods_sku
-- ----------------------------
DROP TABLE IF EXISTS `erp_goods_sku`;
CREATE TABLE `erp_goods_sku`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `goods_id` bigint NOT NULL COMMENT '商品id',
  `tenant_id` bigint NOT NULL COMMENT '租户id',
  `spec_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '规格名',
  `spec_num` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '规格编码',
  `color_id` int NULL DEFAULT 0 COMMENT '颜色id',
  `color_value` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '颜色值',
  `color_image` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '颜色图片',
  `size_id` int NULL DEFAULT 0 COMMENT '尺码id',
  `size_value` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '尺码值',
  `style_id` int NULL DEFAULT 0 COMMENT '款式id',
  `style_value` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '款式值',
  `bar_code` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '库存条形码',
  `pur_price` decimal(8, 2) NULL DEFAULT 0.00 COMMENT '预计采购价',
  `whole_price` decimal(8, 2) NULL DEFAULT 0.00 COMMENT '建议批发价',
  `retail_price` decimal(8, 2) NULL DEFAULT 0.00 COMMENT '建议零售价',
  `unit_cost` decimal(8, 2) NULL DEFAULT 0.00 COMMENT '单位成本',
  `remark` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '备注',
  `status` tinyint(1) NULL DEFAULT 1 COMMENT '状态',
  `low_qty` int NULL DEFAULT 0 COMMENT '最低库存（预警）',
  `high_qty` int NULL DEFAULT 0 COMMENT '最高库存（预警）',
  `disable` tinyint(1) NULL DEFAULT 0 COMMENT '0启用   1禁用',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `id`(`id`) USING BTREE,
  INDEX `number`(`spec_num`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1781988656068800514 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '商品规格库存管理' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of erp_goods_sku
-- ----------------------------
INSERT INTO `erp_goods_sku` VALUES (1781988656068800513, 1781988656060411906, 100, '', 'NZK00023200', 1673551873, '红色', NULL, 0, '', 0, '', NULL, 105.00, 0.00, 0.00, 0.00, '', 1, 0, 0, 0);

-- ----------------------------
-- Table structure for erp_goods_sku_attr
-- ----------------------------
DROP TABLE IF EXISTS `erp_goods_sku_attr`;
CREATE TABLE `erp_goods_sku_attr`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `goods_id` bigint NOT NULL,
  `type` char(5) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `k` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `kid` bigint NULL DEFAULT NULL,
  `vid` bigint NULL DEFAULT NULL,
  `v` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `img` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1781988656135909378 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of erp_goods_sku_attr
-- ----------------------------
INSERT INTO `erp_goods_sku_attr` VALUES (1781988656135909377, 1781988656060411906, 'color', '颜色', 1781941806087319554, 1673551873, NULL, NULL);

-- ----------------------------
-- Table structure for erp_logistics_company
-- ----------------------------
DROP TABLE IF EXISTS `erp_logistics_company`;
CREATE TABLE `erp_logistics_company`  (
  `id` bigint NOT NULL COMMENT '主键ID',
  `platform_id` bigint NULL DEFAULT NULL COMMENT '平台id',
  `shop_id` bigint NULL DEFAULT NULL COMMENT '店铺ID',
  `tenant_id` bigint NULL DEFAULT NULL COMMENT '租户id',
  `logistics_id` bigint NULL DEFAULT NULL COMMENT '物流公司id（值来自于平台返回）',
  `code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '物流公司编码（值来自于平台返回）',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '物流公司名称（值来自于平台返回）',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `status` int NULL DEFAULT NULL COMMENT '状态（1启用0禁用）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of erp_logistics_company
-- ----------------------------
INSERT INTO `erp_logistics_company` VALUES (1782018513779572737, NULL, NULL, 100, NULL, 'SF', '顺丰', NULL, 1);

-- ----------------------------
-- Table structure for erp_order
-- ----------------------------
DROP TABLE IF EXISTS `erp_order`;
CREATE TABLE `erp_order`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '订单id，自增',
  `order_num` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '订单编号（第三方平台订单号）',
  `shop_type` int NOT NULL COMMENT '店铺类型',
  `shop_id` int NOT NULL COMMENT '店铺ID',
  `remark` varchar(1000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '订单备注',
  `buyer_memo` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '买家留言信息',
  `seller_memo` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '卖家留言信息',
  `tag` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '标签',
  `refund_status` int NOT NULL COMMENT '售后状态 1：无售后或售后关闭，2：售后处理中，3：退款中，4： 退款成功 ',
  `order_status` int NOT NULL COMMENT '订单状态1：待发货，2：已发货，3：已完成',
  `goods_amount` double NULL DEFAULT NULL COMMENT '订单商品金额',
  `amount` double NOT NULL COMMENT '订单实际金额',
  `receiver_name` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '收件人姓名',
  `receiver_mobile` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '收件人手机号',
  `address` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '收件人地址',
  `province` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '省',
  `city` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '市',
  `town` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '区',
  `order_time` datetime NULL DEFAULT NULL COMMENT '订单时间',
  `ship_type` int NOT NULL COMMENT '发货类型（0仓库发货；1供应商代发）',
  `shipping_time` datetime NULL DEFAULT NULL COMMENT '发货时间',
  `shipping_number` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '快递单号',
  `shipping_company` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '物流公司',
  `shipping_man` varchar(25) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '发货人',
  `shipping_cost` decimal(10, 2) NULL DEFAULT NULL COMMENT '发货费用',
  `has_push_erp` int NULL DEFAULT 0 COMMENT '是否推送到ERP',
  `length` float NULL DEFAULT 0 COMMENT '长',
  `width` float NULL DEFAULT 0 COMMENT '宽',
  `height` float NULL DEFAULT 0 COMMENT '高',
  `weight` float NULL DEFAULT NULL COMMENT '重量',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `create_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `update_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `order_sn_index`(`order_num`) USING BTREE,
  INDEX `shopid_index`(`shop_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1778674707316772867 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '订单表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of erp_order
-- ----------------------------
INSERT INTO `erp_order` VALUES (1778674706280779778, '3718586550340945408', 5, 6, NULL, NULL, NULL, NULL, 1, 0, 99.9, 99.9, '张*', '153****8788', '****', '安徽省', '合肥市', '庐江县', '1970-01-18 15:19:15', -1, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, NULL, '2024-04-12 14:41:11', '手动确认', NULL, NULL);
INSERT INTO `erp_order` VALUES (1778674706557603842, '3718586568279724288', 5, 6, NULL, NULL, NULL, NULL, 1, 0, 99.9, 99.9, '王**', '152****2706', '****', '河南省', '开封市', '禹王台区', '1970-01-18 15:20:24', -1, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, NULL, '2024-04-12 14:41:11', '手动确认', NULL, NULL);
INSERT INTO `erp_order` VALUES (1778674706641489922, '3718587018572858624', 5, 6, NULL, NULL, NULL, NULL, 1, 0, 1098.9, 1, '阿*', '139****6961', '****', '云南省', '昭通市', '昭阳区', '1970-01-18 15:49:02', -1, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, NULL, '2024-04-12 14:41:11', '手动确认', NULL, NULL);
INSERT INTO `erp_order` VALUES (1778674706716987394, '3718587542502772992', 5, 6, NULL, NULL, NULL, NULL, 1, 0, 9.9, 9.9, '吴*', '131****1805', '****', '江苏省', '苏州市', '姑苏区', '1970-01-18 16:22:20', -1, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, NULL, '2024-04-12 14:41:11', '手动确认', NULL, NULL);
INSERT INTO `erp_order` VALUES (1778674706788290561, '3718587809541260800', 5, 6, NULL, NULL, NULL, NULL, 1, 0, 99.9, 99.9, '耿*', '136****6190', '****', '北京市', '北京市', '丰台区', '1970-01-18 16:39:19', -1, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, NULL, '2024-04-12 14:41:11', '手动确认', NULL, NULL);
INSERT INTO `erp_order` VALUES (1778674706922508289, '3718587810203962368', 5, 6, NULL, NULL, NULL, NULL, 1, 0, 99.9, 99.9, '忻*', '139****5732', '****', '贵州省', '贵阳市', '云岩区', '1970-01-18 16:39:22', -1, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, NULL, '2024-04-12 14:41:11', '手动确认', NULL, NULL);
INSERT INTO `erp_order` VALUES (1778674707065114625, '3718587814527504384', 5, 6, NULL, NULL, NULL, NULL, 1, 0, 99.9, 99.9, '王**', '136****6620', '****', '北京市', '北京市', '朝阳区', '1970-01-18 16:39:38', -1, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, NULL, '2024-04-12 14:41:11', '手动确认', NULL, NULL);
INSERT INTO `erp_order` VALUES (1778674707132223490, '3718587815659965440', 5, 6, NULL, NULL, NULL, NULL, 1, 0, 99.9, 99.9, '崔*', '133****5865', '****', '湖北省', '恩施土家族苗族自治州', '建始县', '1970-01-18 16:39:42', -1, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, NULL, '2024-04-12 14:41:11', '手动确认', NULL, NULL);
INSERT INTO `erp_order` VALUES (1778674707245469697, '3718587822346996736', 5, 6, NULL, NULL, NULL, NULL, 1, 0, 99.9, 99.9, '赵**', '134****1877', '****', '北京市', '北京市', '东城区', '1970-01-18 16:40:08', -1, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, NULL, '2024-04-12 14:41:11', '手动确认', NULL, NULL);
INSERT INTO `erp_order` VALUES (1778674707316772866, '3718588207135065344', 5, 6, NULL, NULL, NULL, NULL, 1, 0, 99.9, 99.9, '冯**', '156****2268', '****', '贵州省', '遵义市', '红花岗区', '1970-01-18 17:04:36', -1, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, NULL, '2024-04-12 14:41:11', '手动确认', NULL, NULL);

-- ----------------------------
-- Table structure for erp_order_item
-- ----------------------------
DROP TABLE IF EXISTS `erp_order_item`;
CREATE TABLE `erp_order_item`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id，自增',
  `order_id` bigint NOT NULL COMMENT '订单ID（o_order外键）',
  `order_num` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '订单号（第三方平台）',
  `sub_order_num` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '子订单号（第三方平台）',
  `sku_id` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '第三方平台skuId',
  `erp_goods_id` bigint NOT NULL DEFAULT 0 COMMENT 'erp系统商品id',
  `erp_sku_id` bigint NOT NULL DEFAULT 0 COMMENT 'erp系统商品规格id',
  `goods_title` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '商品标题',
  `goods_img` varchar(300) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '商品图片',
  `goods_num` varchar(35) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '商品编码',
  `goods_spec` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '商品规格',
  `sku_num` varchar(35) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '商品规格编码',
  `goods_price` double NOT NULL COMMENT '商品单价',
  `item_amount` double NULL DEFAULT NULL COMMENT '子订单金额',
  `quantity` int NOT NULL COMMENT '商品数量',
  `remark` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '备注',
  `refund_count` int NULL DEFAULT 0 COMMENT '已退货数量',
  `refund_status` int NULL DEFAULT NULL COMMENT '售后状态 1：无售后或售后关闭，2：售后处理中，3：退款中，4： 退款成功 ',
  `has_push_erp` int NULL DEFAULT 0 COMMENT '是否推送到ERP',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `create_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `update_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `goodId_index`(`erp_goods_id`) USING BTREE,
  INDEX `order_id`(`order_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1778674707337744386 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '订单明细表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of erp_order_item
-- ----------------------------
INSERT INTO `erp_order_item` VALUES (1778674706394025985, 1778674706280779778, '3718586550340945408', '1773651223083716609', '2069165392', 0, 0, '泷御堂 冲饮谷物  赤小豆薏米芡实茯苓330g*罐', 'https://store.mp.video.tencent-cloud.com/161/20304/snscosdownload/SH/reserved/65f29bc400032a7c023ca7e6b960b01e000000a000004f50', '', '[{\"attr_key\":\"净含量\",\"attr_value\":\"拍3罐送1罐到手4罐\"},{\"attr_key\":\"主播承诺\",\"attr_value\":\"7天升级30天试喝及运费险\"}]', '', 99.9, 99.9, 1, NULL, 0, 1, 0, NULL, NULL, NULL, NULL);
INSERT INTO `erp_order_item` VALUES (1778674706591158273, 1778674706557603842, '3718586568279724288', '1773651221921894401', '2069165392', 0, 0, '泷御堂 冲饮谷物  赤小豆薏米芡实茯苓330g*罐', 'https://store.mp.video.tencent-cloud.com/161/20304/snscosdownload/SH/reserved/65f29bc400032a7c023ca7e6b960b01e000000a000004f50', '', '[{\"attr_key\":\"净含量\",\"attr_value\":\"拍3罐送1罐到手4罐\"},{\"attr_key\":\"主播承诺\",\"attr_value\":\"7天升级30天试喝及运费险\"}]', '', 99.9, 99.9, 1, NULL, 0, 1, 0, NULL, NULL, NULL, NULL);
INSERT INTO `erp_order_item` VALUES (1778674706662461441, 1778674706641489922, '3718587018572858624', '1773651220827181058', '2069165392', 0, 0, '泷御堂 冲饮谷物  赤小豆薏米芡实茯苓330g*罐', 'https://store.mp.video.tencent-cloud.com/161/20304/snscosdownload/SH/reserved/65f29bc400032a7c023ca7e6b960b01e000000a000004f50', '', '[{\"attr_key\":\"净含量\",\"attr_value\":\"拍3罐送1罐到手4罐\"},{\"attr_key\":\"主播承诺\",\"attr_value\":\"7天升级30天试喝及运费险\"}]', '', 99.9, 1, 11, NULL, 0, 1, 0, NULL, NULL, NULL, NULL);
INSERT INTO `erp_order_item` VALUES (1778674706725376001, 1778674706716987394, '3718587542502772992', '1773651219568889858', '2086367126', 0, 0, '泷御堂 冲饮谷物  赤小豆薏米芡实茯苓茶330g*罐', 'https://store.mp.video.tencent-cloud.com/161/20304/snscosdownload/SH/reserved/65f292760001000d22cbd8f9727c0d15000000a000004f50', '', '[{\"attr_key\":\"净含量\",\"attr_value\":\"1罐体验装【贵在运费】(5%人选择)\"}]', '', 9.9, 9.9, 1, NULL, 0, 1, 0, NULL, NULL, NULL, NULL);
INSERT INTO `erp_order_item` VALUES (1778674706800873474, 1778674706788290561, '3718587809541260800', '1773651218511925250', '2069165392', 0, 0, '泷御堂 冲饮谷物  赤小豆薏米芡实茯苓330g*罐', 'https://store.mp.video.tencent-cloud.com/161/20304/snscosdownload/SH/reserved/65f29bc400032a7c023ca7e6b960b01e000000a000004f50', '', '[{\"attr_key\":\"净含量\",\"attr_value\":\"拍3罐送1罐到手4罐\"},{\"attr_key\":\"主播承诺\",\"attr_value\":\"7天升级30天试喝及运费险\"}]', '', 99.9, 99.9, 1, NULL, 0, 1, 0, NULL, NULL, NULL, NULL);
INSERT INTO `erp_order_item` VALUES (1778674706985422850, 1778674706922508289, '3718587810203962368', '1773651217396240385', '2069165392', 0, 0, '泷御堂 冲饮谷物  赤小豆薏米芡实茯苓330g*罐', 'https://store.mp.video.tencent-cloud.com/161/20304/snscosdownload/SH/reserved/65f29bc400032a7c023ca7e6b960b01e000000a000004f50', '', '[{\"attr_key\":\"净含量\",\"attr_value\":\"拍3罐送1罐到手4罐\"},{\"attr_key\":\"主播承诺\",\"attr_value\":\"7天升级30天试喝及运费险\"}]', '', 99.9, 99.9, 1, NULL, 0, 1, 0, NULL, NULL, NULL, NULL);
INSERT INTO `erp_order_item` VALUES (1778674707102863361, 1778674707065114625, '3718587814527504384', '1773651216045674498', '2069165392', 0, 0, '泷御堂 冲饮谷物  赤小豆薏米芡实茯苓330g*罐', 'https://store.mp.video.tencent-cloud.com/161/20304/snscosdownload/SH/reserved/65f29bc400032a7c023ca7e6b960b01e000000a000004f50', '', '[{\"attr_key\":\"净含量\",\"attr_value\":\"拍3罐送1罐到手4罐\"},{\"attr_key\":\"主播承诺\",\"attr_value\":\"7天升级30天试喝及运费险\"}]', '', 99.9, 99.9, 1, NULL, 0, 1, 0, NULL, NULL, NULL, NULL);
INSERT INTO `erp_order_item` VALUES (1778674707182555138, 1778674707132223490, '3718587815659965440', '1773651214967738370', '2069165392', 0, 0, '泷御堂 冲饮谷物  赤小豆薏米芡实茯苓330g*罐', 'https://store.mp.video.tencent-cloud.com/161/20304/snscosdownload/SH/reserved/65f29bc400032a7c023ca7e6b960b01e000000a000004f50', '', '[{\"attr_key\":\"净含量\",\"attr_value\":\"拍3罐送1罐到手4罐\"},{\"attr_key\":\"主播承诺\",\"attr_value\":\"7天升级30天试喝及运费险\"}]', '', 99.9, 99.9, 1, NULL, 0, 1, 0, NULL, NULL, NULL, NULL);
INSERT INTO `erp_order_item` VALUES (1778674707270635522, 1778674707245469697, '3718587822346996736', '1773651213856247809', '2069165392', 0, 0, '泷御堂 冲饮谷物  赤小豆薏米芡实茯苓330g*罐', 'https://store.mp.video.tencent-cloud.com/161/20304/snscosdownload/SH/reserved/65f29bc400032a7c023ca7e6b960b01e000000a000004f50', '', '[{\"attr_key\":\"净含量\",\"attr_value\":\"拍3罐送1罐到手4罐\"},{\"attr_key\":\"主播承诺\",\"attr_value\":\"7天升级30天试喝及运费险\"}]', '', 99.9, 99.9, 1, NULL, 0, 1, 0, NULL, NULL, NULL, NULL);
INSERT INTO `erp_order_item` VALUES (1778674707337744385, 1778674707316772866, '3718588207135065344', '1773651212711202818', '2069165392', 0, 0, '泷御堂 冲饮谷物  赤小豆薏米芡实茯苓330g*罐', 'https://store.mp.video.tencent-cloud.com/161/20304/snscosdownload/SH/reserved/65f29bc400032a7c023ca7e6b960b01e000000a000004f50', '', '[{\"attr_key\":\"净含量\",\"attr_value\":\"拍3罐送1罐到手4罐\"},{\"attr_key\":\"主播承诺\",\"attr_value\":\"7天升级30天试喝及运费险\"}]', '', 99.9, 99.9, 1, NULL, 0, 1, 0, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for erp_order_shipping
-- ----------------------------
DROP TABLE IF EXISTS `erp_order_shipping`;
CREATE TABLE `erp_order_shipping`  (
  `id` bigint NOT NULL,
  `shop_id` int NULL DEFAULT NULL COMMENT '店铺id',
  `order_id` bigint NULL DEFAULT NULL COMMENT 'o_order表id',
  `order_num` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '订单编号',
  `ship_type` int NULL DEFAULT NULL COMMENT '发货类型（1订单发货2商品补发3商品换货）',
  `ship_company` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '物流公司',
  `ship_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '物流单号',
  `ship_fee` decimal(6, 0) NULL DEFAULT NULL COMMENT '物流费用',
  `ship_time` datetime NULL DEFAULT NULL COMMENT '发货时间',
  `ship_operator` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '发货操作人',
  `ship_status` int NULL DEFAULT NULL COMMENT '物流状态（1运输中2已完成）',
  `package_weight` float NULL DEFAULT NULL COMMENT '包裹重量',
  `package_length` float NULL DEFAULT NULL COMMENT '包裹长度',
  `package_width` float NULL DEFAULT NULL COMMENT '包裹宽度',
  `package_height` float NULL DEFAULT NULL COMMENT '包裹高度',
  `packsge_operator` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '打包操作人',
  `packsge_time` datetime NULL DEFAULT NULL COMMENT '打包时间',
  `packages` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '包裹内容JSON',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `create_time` datetime NULL DEFAULT NULL,
  `create_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `update_by` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '发货记录表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of erp_order_shipping
-- ----------------------------
INSERT INTO `erp_order_shipping` VALUES (1774281299046006785, 1, NULL, '233', 1, 'SF', '323323', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '手动发货', '2024-03-31 11:43:21', NULL, NULL, NULL);
INSERT INTO `erp_order_shipping` VALUES (1774284255539507201, 2, 1771780749159133187, '285501634587', 1, 'SF', '344344334', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '手动发货', '2024-03-31 11:55:06', NULL, NULL, NULL);

-- ----------------------------
-- Table structure for erp_purchase_order
-- ----------------------------
DROP TABLE IF EXISTS `erp_purchase_order`;
CREATE TABLE `erp_purchase_order`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `tenant_id` bigint NOT NULL COMMENT '租户id',
  `supplier_id` bigint NOT NULL COMMENT '供应商id',
  `order_no` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '' COMMENT '订单编号',
  `order_date` date NOT NULL COMMENT '订单日期',
  `order_time` bigint NOT NULL COMMENT '订单创建时间',
  `order_amount` decimal(10, 2) NOT NULL COMMENT '订单总金额',
  `ship_amount` decimal(6, 2) NOT NULL COMMENT '物流费用',
  `remark` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '备注',
  `status` tinyint(1) NOT NULL DEFAULT 0 COMMENT '订单状态 0待审核1已审核101供应商已确认102供应商已发货2已收货3已入库',
  `audit_user` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '采购单审核人',
  `audit_time` bigint NULL DEFAULT 0 COMMENT '审核时间',
  `supplier_confirm_time` datetime NULL DEFAULT NULL COMMENT '供应商确认时间',
  `supplier_delivery_time` datetime NULL DEFAULT NULL COMMENT '供应商发货时间',
  `received_time` datetime NULL DEFAULT NULL COMMENT '收货时间',
  `stock_in_time` datetime NULL DEFAULT NULL COMMENT '入库时间',
  `create_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1782030968597573635 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '采购订单' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of erp_purchase_order
-- ----------------------------
INSERT INTO `erp_purchase_order` VALUES (466, 0, 33, 'PUR20240116144408', '2024-01-16', 1705387448, 190.00, 0.00, NULL, 3, '启航', 1705387461, '2024-01-16 14:44:30', '2024-01-16 14:49:49', '2024-01-16 00:00:00', '2024-01-16 14:50:58', 'admin', '2024-01-16 14:44:09', 'admin', '2024-01-16 14:50:58');
INSERT INTO `erp_purchase_order` VALUES (467, 0, 33, 'PUR20240128113656', '2024-01-28', 1706413016, 42.00, 10.00, NULL, 102, '启航', 1706413030, '2024-01-28 11:42:19', '2024-01-28 12:07:32', NULL, NULL, 'admin', '2024-01-28 11:36:56', 'admin', '2024-01-28 12:07:32');
INSERT INTO `erp_purchase_order` VALUES (1782030968597573634, 100, 1781960910751948802, 'PUR20240421205746', '2024-04-21', 1713704266, 1050.00, 20.00, NULL, 2, '启航', 1713705287, '2024-04-21 21:19:07', '2024-04-21 21:19:59', '2024-04-21 08:00:00', NULL, '15818590119', '2024-04-21 20:57:46', '15818590119', '2024-04-21 21:40:14');

-- ----------------------------
-- Table structure for erp_purchase_order_item
-- ----------------------------
DROP TABLE IF EXISTS `erp_purchase_order_item`;
CREATE TABLE `erp_purchase_order_item`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `tenant_id` bigint NULL DEFAULT NULL COMMENT '租户id',
  `supplier_id` bigint NULL DEFAULT NULL COMMENT '供应商id',
  `order_id` bigint NULL DEFAULT 0 COMMENT '订单id',
  `order_no` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '订单编号',
  `trans_type` char(15) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '0' COMMENT '150501采购 150502退货',
  `amount` double NULL DEFAULT 0 COMMENT '购货金额',
  `order_date` date NULL DEFAULT NULL COMMENT '订单日期',
  `remark` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '备注',
  `goods_id` bigint NULL DEFAULT 0 COMMENT '商品ID',
  `goods_num` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '商品编码',
  `goods_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '商品名称',
  `spec_id` bigint NULL DEFAULT 0 COMMENT '商品规格id',
  `spec_num` varchar(25) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '商品规格编码',
  `color_value` varchar(25) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '颜色',
  `color_image` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '图片',
  `size_value` varchar(25) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '尺码',
  `style_value` varchar(25) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '款式',
  `price` decimal(8, 2) NULL DEFAULT 0.00 COMMENT '单价',
  `dis_amount` decimal(8, 2) NULL DEFAULT 0.00 COMMENT '折扣额',
  `dis_rate` decimal(8, 2) NULL DEFAULT 0.00 COMMENT '折扣率',
  `quantity` bigint NOT NULL DEFAULT 0 COMMENT '数量(采购单据)',
  `inQty` bigint NOT NULL DEFAULT 0 COMMENT '已入库数量',
  `locationId` int NULL DEFAULT NULL COMMENT '入库的仓库id',
  `is_delete` tinyint(1) NULL DEFAULT 0 COMMENT '1删除 0正常',
  `status` int NULL DEFAULT 0 COMMENT '状态（同billStatus）0待审核1正常2已作废3已入库',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `type`(`trans_type`) USING BTREE,
  INDEX `billdate`(`order_date`) USING BTREE,
  INDEX `invId`(`goods_id`) USING BTREE,
  INDEX `transType`(`trans_type`) USING BTREE,
  INDEX `iid`(`order_id`) USING BTREE,
  INDEX `id`(`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1782030968731791363 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '采购订单明细' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of erp_purchase_order_item
-- ----------------------------
INSERT INTO `erp_purchase_order_item` VALUES (1962, NULL, NULL, 466, 'PUR20240116144408', 'Purchase', 190, '2024-01-16', '', 9, 'HN8026', 'HN8026牛仔短裤', 32, '2720210080260105', '黑色', 'https://cbu01.alicdn.com/img/ibank/O1CN01AfNgvA2FOyAvwXZxv_!!2208857268871-0-cib.jpg', '2XL', '', 19.00, 0.00, 0.00, 10, 0, NULL, 0, 0);
INSERT INTO `erp_purchase_order_item` VALUES (1963, NULL, NULL, 467, 'PUR20240128113656', 'Purchase', 42, '2024-01-28', '', 29, 'HNP182', 'HNP182弹力紧身贴标牛仔短裤女ins', 438, 'HNP1825004', '浅蓝色', 'https://cbu01.alicdn.com/img/ibank/O1CN01yp4pfJ2FOyGRQhOVF_!!2208857268871-0-cib.jpg', 'XL', '', 21.00, 0.00, 0.00, 2, 0, NULL, 0, 0);
INSERT INTO `erp_purchase_order_item` VALUES (1782030968731791362, 100, 1781960910751948802, 1782030968597573634, 'PUR20240421205746', 'Purchase', 1050, '2024-04-21', '', 1781988656060412000, 'NZK000232', '男士流行夏季牛仔裤黑色', 1781988656068800500, 'NZK00023200', '红色', NULL, '', '', 105.00, 0.00, 0.00, 10, 0, NULL, 0, 0);

-- ----------------------------
-- Table structure for erp_purchase_order_payable
-- ----------------------------
DROP TABLE IF EXISTS `erp_purchase_order_payable`;
CREATE TABLE `erp_purchase_order_payable`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `tenant_id` bigint NOT NULL COMMENT '租户id',
  `supplier_id` bigint NOT NULL COMMENT '供应商id',
  `supplier_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '供应商名称',
  `amount` decimal(10, 2) NOT NULL COMMENT '应付金额',
  `date` date NOT NULL COMMENT '应付日期',
  `invoice_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '发票号码',
  `purchase_order_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '采购单号',
  `purchase_desc` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '采购说明',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `status` int NOT NULL COMMENT '状态（0已生成1已结算)',
  `create_time` datetime NULL DEFAULT NULL COMMENT '订单创建时间',
  `create_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `update_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '采购单应付款' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of erp_purchase_order_payable
-- ----------------------------
INSERT INTO `erp_purchase_order_payable` VALUES (1, 0, 33, '中山裤豪', 52.00, '2024-01-28', NULL, 'PUR20240128113656', '{采购商品总数量:2,不同款式:1,不同SKU:1,商品总价:42.00,运费:10}', NULL, 1, '2024-01-28 12:07:32', 'admin', NULL, NULL);

-- ----------------------------
-- Table structure for erp_purchase_order_ship
-- ----------------------------
DROP TABLE IF EXISTS `erp_purchase_order_ship`;
CREATE TABLE `erp_purchase_order_ship`  (
  `id` bigint NOT NULL COMMENT '采购单ID（主键）',
  `tenant_id` bigint NULL DEFAULT NULL COMMENT '租户id',
  `supplier_id` bigint NULL DEFAULT NULL COMMENT '供应商id',
  `order_id` bigint NULL DEFAULT NULL COMMENT '订单id',
  `ship_company` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '物流公司',
  `ship_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '物流单号',
  `freight` decimal(6, 0) NULL DEFAULT NULL COMMENT '运费',
  `ship_time` datetime NULL DEFAULT NULL COMMENT '发货时间',
  `receipt_time` datetime NULL DEFAULT NULL COMMENT '收货时间',
  `create_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `status` int NULL DEFAULT NULL COMMENT '状态（0未收货1已收货2已入库）',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '说明',
  `back_count` int NULL DEFAULT NULL COMMENT '退回数量',
  `stock_in_time` datetime NULL DEFAULT NULL COMMENT '入库时间',
  `stock_in_count` int NULL DEFAULT NULL COMMENT '入库数量',
  `update_by` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `order_date` date NULL DEFAULT NULL COMMENT '采购订单日期',
  `order_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '采购订单编号',
  `order_spec_unit` int NULL DEFAULT NULL COMMENT '采购订单商品规格数',
  `order_goods_unit` int NULL DEFAULT NULL COMMENT '采购订单商品数',
  `order_spec_unit_total` int NULL DEFAULT NULL COMMENT '采购订单总件数',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '采购订单物流表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of erp_purchase_order_ship
-- ----------------------------
INSERT INTO `erp_purchase_order_ship` VALUES (466, NULL, NULL, NULL, '菜鸟速递', 'CN223533300022', 0, '2024-01-16 00:00:00', '2024-01-16 00:00:00', 'admin', '2024-01-16 14:49:49', 2, NULL, 0, '2024-01-16 14:50:58', 0, 'admin', '2024-01-16 14:50:58', '2024-01-16', 'PUR20240116144408', 1, 1, 10);
INSERT INTO `erp_purchase_order_ship` VALUES (467, NULL, NULL, NULL, '菜鸟速递', 'CN345565767', 10, '2024-01-28 00:00:00', NULL, 'admin', '2024-01-28 12:07:32', 0, NULL, 0, NULL, 0, NULL, NULL, '2024-01-28', 'PUR20240128113656', 1, 1, 2);
INSERT INTO `erp_purchase_order_ship` VALUES (1782036559596474370, 100, 1781960910751948802, 1782030968597573634, '顺丰', 'SF522000', 20, '2024-04-21 08:00:00', '2024-04-21 08:00:00', '15818590119', '2024-04-21 21:19:59', 2, NULL, 0, '2024-04-21 22:21:58', 0, '15818590119', '2024-04-21 22:21:58', '2024-04-21', 'PUR20240421205746', 1, 1, 10);

-- ----------------------------
-- Table structure for erp_refund
-- ----------------------------
DROP TABLE IF EXISTS `erp_refund`;
CREATE TABLE `erp_refund`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `refund_num` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '' COMMENT '退货单号',
  `refund_type` int NULL DEFAULT NULL COMMENT '类型(10-退货 20-换货 30-维修 40-大家电安装 50-大家电移机 60-大家电增值服务 70-上门维修 90-优鲜赔 80-补发商品 100-试用收回 11-仅退款)',
  `shop_id` int NULL DEFAULT NULL COMMENT '店铺id',
  `shop_type` int NULL DEFAULT NULL COMMENT '店铺类型',
  `refund_fee` float NOT NULL COMMENT '退款金额',
  `refund_reason` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '退款原因',
  `order_num` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '' COMMENT '源订单号',
  `order_item_num` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '子订单号或id',
  `sku_id` bigint NULL DEFAULT NULL COMMENT '源skuId',
  `erp_goods_id` bigint NULL DEFAULT NULL COMMENT 'erp商品id',
  `erp_sku_id` bigint NULL DEFAULT NULL COMMENT 'erp sku id',
  `sku_num` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT 'sku编码',
  `goods_name` varchar(55) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '商品名称',
  `goods_sku` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '商品sku',
  `goods_image` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '商品图片',
  `quantity` bigint NULL DEFAULT NULL COMMENT '退货数量',
  `return_logistics_company` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '退货物流公司',
  `return_logistics_code` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '退货物流单号',
  `receive_time` datetime NULL DEFAULT NULL COMMENT '收货时间',
  `remark` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '备注',
  `contactPerson` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '发货人',
  `mobile` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '发货人手机号',
  `address` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '发货地址',
  `status` int NOT NULL COMMENT '状态（10001待审核10002等待买家退货10005等待卖家收货14000拒绝退款10011退款关闭10010退款完成）',
  `create_time` datetime NOT NULL COMMENT '订单创建时间',
  `create_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `update_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1771749215664414723 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '退换货表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of erp_refund
-- ----------------------------
INSERT INTO `erp_refund` VALUES (1771749215664414722, '149005526432678759', 11, 1, 1, 0, NULL, '2090155476352675987', '2090155476353675987', 5222928542211, 0, 0, 'ZH-SF-04-DS-F1-QM23-NT2(R)', '曲美家居现代轻奢简约床头柜床边高脚储物柜卧室置物储藏柜', '颜色分类:石墨黑-右;安装方式:组装', 'https://img.alicdn.com/bao/uploaded/i1/351855490/O1CN012NaoeQ1qQTGEg68L3_!!351855490.jpg', 1, NULL, NULL, NULL, '', '', '', '', 10010, '2024-03-24 12:01:45', 'REFUND_MESSAGE', NULL, NULL);

-- ----------------------------
-- Table structure for erp_shop
-- ----------------------------
DROP TABLE IF EXISTS `erp_shop`;
CREATE TABLE `erp_shop`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `tenant_id` bigint NULL DEFAULT NULL COMMENT '租户id',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '店铺名',
  `type` int NOT NULL COMMENT '对应第三方平台Id',
  `url` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '店铺url',
  `sort` int NOT NULL DEFAULT 9 COMMENT '排序',
  `status` int NULL DEFAULT 0 COMMENT '状态（1正常2已删除）',
  `modify_on` bigint NOT NULL COMMENT '更新时间',
  `remark` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '描述',
  `seller_id` bigint NOT NULL DEFAULT 0 COMMENT '第三方平台店铺id，淘宝天猫开放平台使用',
  `app_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'Appkey',
  `app_sercet` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'Appsercet',
  `access_token` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '第三方平台sessionKey（access_token）',
  `expires_in` bigint NULL DEFAULT NULL COMMENT '到期',
  `access_token_begin` bigint NULL DEFAULT NULL COMMENT 'access_token开始时间',
  `refresh_token` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '刷新token',
  `refresh_token_timeout` bigint NULL DEFAULT NULL COMMENT '刷新token过期时间',
  `api_request_url` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '请求url',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1781998402943377410 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '数据中心-店铺' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of erp_shop
-- ----------------------------
INSERT INTO `erp_shop` VALUES (6, 100, '视频号小店', 5, NULL, 9, 0, 1713696491, '啊啊啊v', 0, '3333232', '01', '', NULL, NULL, NULL, NULL, 'https://api.weixin.qq.com');

-- ----------------------------
-- Table structure for erp_shop_goods
-- ----------------------------
DROP TABLE IF EXISTS `erp_shop_goods`;
CREATE TABLE `erp_shop_goods`  (
  `id` bigint NOT NULL,
  `shop_id` bigint NULL DEFAULT NULL COMMENT '店铺id',
  `tenant_id` bigint NULL DEFAULT NULL COMMENT '租户id',
  `product_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '平台商品id',
  `out_product_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商家编码id',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品标题',
  `sub_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `head_imgs` varchar(2550) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '主图集合',
  `head_img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '第一张主图',
  `desc_info` varchar(5000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品详情字符串',
  `attrs` varchar(2550) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '属性字符串',
  `status` int NULL DEFAULT NULL COMMENT '状态',
  `edit_status` int NULL DEFAULT NULL COMMENT '编辑状态',
  `min_price` int NULL DEFAULT NULL COMMENT '商品 SKU 最小价格（单位：分）',
  `spu_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品编码',
  `product_type` int NULL DEFAULT NULL COMMENT '商品类型。1: 小店普通自营商品；2: 福袋抽奖商品；3: 直播间闪电购商品。注意: 福袋抽奖、直播间闪电购类型的商品为只读数据，不支持编辑、上架操作，不支持用data_type=2的参数获取。',
  `edit_time` int NULL DEFAULT NULL COMMENT '商品草稿最近一次修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of erp_shop_goods
-- ----------------------------
INSERT INTO `erp_shop_goods` VALUES (1773592665390514178, 6, 100, NULL, NULL, '2024春季农家燕麦麸皮 高纤高蛋白营养 500g/罐', NULL, '[\"https://mmecimage.cn/p/wx2b826d52663c3ac5/HARN-Ewu9KkyLbQ-i1dzG59Ipxaw0KClDQNn3hhHkA\",\"https://mmecimage.cn/p/wx2b826d52663c3ac5/HNTp4qhlDC5kLroYp101uOiUKRsRT80lqEgjTh9CTg\",\"https://mmecimage.cn/p/wx2b826d52663c3ac5/HNgPr5tM10t4f0CYz_N2Rnm0uIqlA29Cn3jv9Sb6Bw\",\"https://mmecimage.cn/p/wx2b826d52663c3ac5/HHOtQob6n82y6ijcRwWQCvjaAKNu8ZolouugfAKNTg\",\"https://mmecimage.cn/p/wx2b826d52663c3ac5/HLKaJe2eR_YipU8DX4LRyzyNm60j2T2APKqvvYamoA\",\"https://mmecimage.cn/p/wx2b826d52663c3ac5/HBFvYUZTgdpcakf6aeSqe-cd-rJOHvN_MUD92oO1rA\",\"https://mmecimage.cn/p/wx2b826d52663c3ac5/HP84p2a6MjxCbuEdefZWkUpbZKBA8co8_6B_w5LOjQ\",\"https://mmecimage.cn/p/wx2b826d52663c3ac5/HD4wfyh4AFwMJkwsV3zgzVtOZnD50fhW3ixMzUaN_w\",\"https://mmecimage.cn/p/wx2b826d52663c3ac5/HGrC9ZiOuk9MKbnJBowwWNVBZ9uUjg_STZzXNzy8PQ\"]', 'https://mmecimage.cn/p/wx2b826d52663c3ac5/HARN-Ewu9KkyLbQ-i1dzG59Ipxaw0KClDQNn3hhHkA', '{\"imgs\":[\"https://mmecimage.cn/p/wx2b826d52663c3ac5/HIGYaktEgmvz24ajkAAJhH6uDC-osnqovWosa9-gWQ\",\"https://mmecimage.cn/p/wx2b826d52663c3ac5/HNEZI4nbU-Qg9_XXRyBMl1cFbpND5wyrivAE0W9pvg\",\"https://mmecimage.cn/p/wx2b826d52663c3ac5/HLaoM9JsWEDaLK42wKhlM15ku7ETEh0-eiqCtiOFUA\",\"https://mmecimage.cn/p/wx2b826d52663c3ac5/HDOIzQv4eyOCdJfqieclsx6KFEQcIxEawnNA5aUIkg\",\"https://mmecimage.cn/p/wx2b826d52663c3ac5/HGGR-iLCrzMW6SDIwvjqXrKtslGvRqM0k-89VekSgw\",\"https://mmecimage.cn/p/wx2b826d52663c3ac5/HDsg1cgCeLjvTQ4RmcTrMuO7_Bykmeq1rRL8kPvADw\",\"https://mmecimage.cn/p/wx2b826d52663c3ac5/HIEQxLpTnn0YZIPkwZ_jAhxECgkhM95APxAfLyfeyw\",\"https://mmecimage.cn/p/wx2b826d52663c3ac5/HMRpnoTmc64dZpoJSIDSNidgYL5yX_B6s0zofo2dhA\",\"https://mmecimage.cn/p/wx2b826d52663c3ac5/HERmb7JpfCsBcIk1EKo8pg_wX9FbQny-0MsVBPGBgQ\",\"https://mmecimage.cn/p/wx2b826d52663c3ac5/HEf7XxCWlxOPXxUtH0GhT4EVbCrDXu-6nzJheY_v2w\"],\"desc\":\"\"}', '[{\"attr_key\":\"品牌\",\"attr_value\":\"麦趣丰\"},{\"attr_key\":\"生产企业名称\",\"attr_value\":\"山东维美食品有限公司\"},{\"attr_key\":\"配料表\",\"attr_value\":\"燕麦\"},{\"attr_key\":\"保质期\",\"attr_value\":\"240 天\"},{\"attr_key\":\"净含量\",\"attr_value\":\"500 g\"}]', 5, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `erp_shop_goods` VALUES (1773592726853844994, 6, 100, NULL, NULL, '泷御堂 冲饮谷物  赤小豆薏米芡实茯苓茶330g*罐', NULL, '[\"https://mmecimage.cn/p/wx2b826d52663c3ac5/HOHUsPL5lXYMi6uiTIqNoTN7aVVLFstOylGkv2Rupg\",\"https://mmecimage.cn/p/wx2b826d52663c3ac5/HCgV2IEsYtkzBdKOSWF5UChZ6lzW8n4o-jvtK7jrGQ\",\"https://mmecimage.cn/p/wx2b826d52663c3ac5/HCsvjx2CqjmYumW4sW335BuS5FZtwC6ctueDYc9J9A\",\"https://mmecimage.cn/p/wx2b826d52663c3ac5/HFn92-3enHPQ_DFgNDPDqlg9gUxHt14JavVGhMx_Jg\",\"https://mmecimage.cn/p/wx2b826d52663c3ac5/HMP2oduzl5c8wFyoZDHTMguBi2vMrxRX3kucG1IENQ\",\"https://mmecimage.cn/p/wx2b826d52663c3ac5/HHbxEwPTrADwThr_5f3BUuthfqOPZdjHR3NDUA7pFA\",\"https://mmecimage.cn/p/wx2b826d52663c3ac5/HPhYUEDpnVO1jiGSHHmagyQOIdPYpau2oyjXZz7eyg\",\"https://mmecimage.cn/p/wx2b826d52663c3ac5/HEavquNbjGtBOK9pSfKiN7_IRQQZIXBuQqp5-NqnOA\",\"https://mmecimage.cn/p/wx2b826d52663c3ac5/HDmtDkNUi_aTtPbCeRPuECHm4d8u5IGw8i6-wRXnMQ\"]', 'https://mmecimage.cn/p/wx2b826d52663c3ac5/HOHUsPL5lXYMi6uiTIqNoTN7aVVLFstOylGkv2Rupg', '{\"imgs\":[\"https://mmecimage.cn/p/wx2b826d52663c3ac5/HCHck7lcuqJ-0jBEa4uLrpE4bpuR3276H5mG6r8YVA\",\"https://mmecimage.cn/p/wx2b826d52663c3ac5/HBCUz-BSyK8uE8kjyVFUN_E3Y1rYVS5sQ4gZpNud3g\",\"https://mmecimage.cn/p/wx2b826d52663c3ac5/HLDZzs9U0mZ1o90Ao3_fbVx92Be6qmDx4_0hOmLNKg\",\"https://mmecimage.cn/p/wx2b826d52663c3ac5/HN8FBEj5-OB9ikg2_BGssLp0o2FOfQmFCIyLOj-q-Q\",\"https://mmecimage.cn/p/wx2b826d52663c3ac5/HCzULR3SSfXACWAffBG77GQYx4lDkzqBkm2fcPOuqg\",\"https://mmecimage.cn/p/wx2b826d52663c3ac5/HCjS8dONFVTAukX0-_q5-cozvhQzbYUwp3iBieGvrw\",\"https://mmecimage.cn/p/wx2b826d52663c3ac5/HDLWNouDSg64CY_SmSVHH92_B9FVNk82Mdh0UujfaQ\",\"https://mmecimage.cn/p/wx2b826d52663c3ac5/HJZ9uhZ-R90QOp9nD7oIl_Ru61tDzm-SgdtbSvl2kw\"],\"desc\":\"\"}', '[{\"attr_key\":\"品牌\",\"attr_value\":\"泷御堂\"},{\"attr_key\":\"生产企业名称\",\"attr_value\":\"安徽意茗堂生物科技有限公司\"},{\"attr_key\":\"配料表\",\"attr_value\":\"赤小豆、慧米、芡实、茯苓\"},{\"attr_key\":\"保质期\",\"attr_value\":\"12 月\"},{\"attr_key\":\"净含量\",\"attr_value\":\"330 g\"}]', 5, NULL, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for erp_shop_goods_sku
-- ----------------------------
DROP TABLE IF EXISTS `erp_shop_goods_sku`;
CREATE TABLE `erp_shop_goods_sku`  (
  `id` bigint NOT NULL,
  `shop_goods_id` bigint NULL DEFAULT NULL COMMENT '外键id',
  `tenant_id` bigint NULL DEFAULT NULL COMMENT '租户id',
  `product_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '平台商品id',
  `sku_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'skuID',
  `out_sku_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商家自定义skuID。如果添加时没录入，回包可能不包含该字段',
  `thumb_img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'sku小图',
  `sale_price` int NULL DEFAULT NULL COMMENT '售卖价格，以分为单位',
  `stock_num` int NULL DEFAULT NULL COMMENT 'sku库存',
  `sku_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'sku编码',
  `status` int NULL DEFAULT NULL COMMENT 'sku状态',
  `sku_attrs` varchar(2550) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'sku_attrs',
  `sku_deliver_info` varchar(2550) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'sku_deliver_info',
  `erp_goods_id` bigint NULL DEFAULT NULL COMMENT 'erp系统商品id',
  `erp_goods_sku_id` bigint NULL DEFAULT NULL COMMENT 'erp系统商品skuid',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of erp_shop_goods_sku
-- ----------------------------
INSERT INTO `erp_shop_goods_sku` VALUES (1773592677457526786, 1773592665390514178, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 5, '[{\"attr_key\":\"净含量\",\"attr_value\":\"拍3罐送1罐到手4斤\"},{\"attr_key\":\"主播承诺\",\"attr_value\":\"7天升级30天试喝及运费险\"}]', '{\"stock_type\":0,\"full_payment_presale_delivery_type\":0,\"presale_begin_time\":0,\"presale_end_time\":0,\"full_payment_presale_delivery_time\":0}', NULL, NULL);
INSERT INTO `erp_shop_goods_sku` VALUES (1773592726975479809, 1773592726853844994, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 5, '[{\"attr_key\":\"净含量\",\"attr_value\":\"4罐99.9【平均24.9/罐】(97%人选择)1个周期\"}]', '{\"stock_type\":0,\"full_payment_presale_delivery_type\":0,\"presale_begin_time\":0,\"presale_end_time\":0,\"full_payment_presale_delivery_time\":0}', NULL, NULL);
INSERT INTO `erp_shop_goods_sku` VALUES (1773592727050977281, 1773592726853844994, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 5, '[{\"attr_key\":\"净含量\",\"attr_value\":\"3罐89.9【平均29/罐】(50%人选择)\"}]', '{\"stock_type\":0,\"full_payment_presale_delivery_type\":0,\"presale_begin_time\":0,\"presale_end_time\":0,\"full_payment_presale_delivery_time\":0}', NULL, NULL);
INSERT INTO `erp_shop_goods_sku` VALUES (1773592727147446274, 1773592726853844994, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 5, '[{\"attr_key\":\"净含量\",\"attr_value\":\"2罐69.9【平均34.5/罐】(35%人选择)\"}]', '{\"stock_type\":0,\"full_payment_presale_delivery_type\":0,\"presale_begin_time\":0,\"presale_end_time\":0,\"full_payment_presale_delivery_time\":0}', NULL, NULL);
INSERT INTO `erp_shop_goods_sku` VALUES (1773592727227138049, 1773592726853844994, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 5, '[{\"attr_key\":\"净含量\",\"attr_value\":\"1罐体验装【贵在运费】(5%人选择)\"}]', '{\"stock_type\":0,\"full_payment_presale_delivery_type\":0,\"presale_begin_time\":0,\"presale_end_time\":0,\"full_payment_presale_delivery_time\":0}', NULL, NULL);

-- ----------------------------
-- Table structure for erp_shop_order
-- ----------------------------
DROP TABLE IF EXISTS `erp_shop_order`;
CREATE TABLE `erp_shop_order`  (
  `id` bigint NOT NULL,
  `shop_id` int NULL DEFAULT NULL COMMENT '店铺id',
  `order_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '订单号',
  `openid` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '买家身份标识',
  `create_time` int NULL DEFAULT NULL COMMENT '秒级时间戳',
  `update_time` int NULL DEFAULT NULL COMMENT '秒级时间戳',
  `unionid` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `status` int NULL DEFAULT NULL COMMENT '状态10	待付款；20	待发货；21	部分发货；30	待收货；100	完成；200	全部商品售后之后，订单取消；250	未付款用户主动取消或超时未付款订单自动取消；',
  `aftersale_detail` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '售后信息json',
  `pay_info` varchar(5500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '支付信息json',
  `product_price` int NULL DEFAULT NULL COMMENT '商品总价，单位为分',
  `order_price` int NULL DEFAULT NULL COMMENT '订单金额，单位为分，order_price=original_order_price-discounted_price-deduction_price-change_down_price',
  `freight` int NULL DEFAULT NULL COMMENT '运费，单位为分',
  `discounted_price` int NULL DEFAULT NULL COMMENT '优惠券优惠金额，单位为分',
  `user_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '收货人姓名',
  `postal_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '邮编',
  `province_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '省份',
  `city_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '城市',
  `county_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '区',
  `detail_info` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '详细地址',
  `tel_number` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '联系方式\r\n',
  `house_number` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '门牌号码',
  `virtual_order_tel_number` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '虚拟发货订单联系方式(deliver_method=1时返回)',
  `tel_number_ext_info` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '额外的联系方式信息（虚拟号码相关）',
  `use_tel_number` int NULL DEFAULT NULL COMMENT '0：不使用虚拟号码，1：使用虚拟号码',
  `hash_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '标识当前店铺下一个唯一的用户收货地址',
  `delivery_product_info` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '发货物流信息JSON',
  `ship_done_time` int NULL DEFAULT NULL COMMENT '发货完成时间，秒级时间戳',
  `ewaybill_order_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '电子面单代发时的订单密文\r\n',
  `settle_info` varchar(2550) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '结算信息json',
  `confirm_status` int NULL DEFAULT 0 COMMENT '订单确认状态（0未确认1已确认）',
  `confirm_time` datetime NULL DEFAULT NULL COMMENT '确认时间',
  `erp_send_status` int NULL DEFAULT NULL COMMENT 'erp发货状态',
  `erp_send_time` datetime NULL DEFAULT NULL COMMENT 'ERP发货时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of erp_shop_order
-- ----------------------------
INSERT INTO `erp_shop_order` VALUES (1773651199826300930, 6, '3718590468852683008', 'oAv1969ctu4B_MrW17zk7JChQrBA', 1710907087, 1711280945, NULL, 100, '{\"aftersale_order_list\":[],\"on_aftersale_order_cnt\":0}', '{\"payment_method\":1,\"prepay_id\":\"up_wx20115809263560bdc3bda251ae3eee0000\",\"prepay_time\":1710907089,\"pay_time\":1710907097,\"transaction_id\":\"4332301095202403202057439992\"}', 9990, 9990, 0, NULL, '张**', '156400', '黑龙江省', '佳木斯市', '同江市', '****', '139****1755', '', '', 'null', 0, '60e36c9691eef079a45fb629c78b88ef', '[{\"waybill_id\":\"312317650762748\",\"delivery_id\":\"YD\",\"product_infos\":[{\"product_id\":\"10000103058379\",\"sku_id\":\"2069165392\",\"product_cnt\":1}],\"delivery_name\":\"韵达速递\",\"delivery_time\":1710921324,\"deliver_type\":1}]', 1710921324, 'ofeIxD4qpxEIdkUmusYuJAvWi-H4cgngomdmkZ5Dt41LPpun-Yf2ROm0cO8Adz5_jsw4DNRn5D_w', '{\"predict_commission_fee\":99}', 0, NULL, NULL, NULL);
INSERT INTO `erp_shop_order` VALUES (1773651201164283905, 6, '3718590165614464000', 'oAv196-Xw4whjGQr4GF2D1lUS0vw', 1710905931, 1711510929, NULL, 30, '{\"aftersale_order_list\":[],\"on_aftersale_order_cnt\":0}', '{\"payment_method\":1,\"prepay_id\":\"up_wx201138523358325a5c59a03b72a8900000\",\"prepay_time\":1710905932,\"pay_time\":1710905946,\"transaction_id\":\"4348501112202403200062879930\"}', 9990, 9990, 0, NULL, '风**', '541004', '广西壮族自治区', '桂林市', '七星区', '****', '189****5671', '', '', 'null', 0, 'd1d18fd116ecbfb5a084db703652bbf2', '[{\"waybill_id\":\"312317507518865\",\"delivery_id\":\"YD\",\"product_infos\":[{\"product_id\":\"10000103058379\",\"sku_id\":\"2069165392\",\"product_cnt\":1}],\"delivery_name\":\"韵达速递\",\"delivery_time\":1710906129,\"deliver_type\":1}]', 1710906129, 'ofBnDflYHmXX3vPIhJblDq6wq4O4z3OggOGTJljLlnEM4YzvNVPTX7AR3q2zz48dbs46F9oNaN0w', '{\"predict_commission_fee\":99}', 0, NULL, NULL, NULL);
INSERT INTO `erp_shop_order` VALUES (1773651202531627010, 6, '3718589880635884800', 'oAv196_dDA-D0ZAJYtZxZ5Tsq-pw', 1710904844, 1711510862, NULL, 30, '{\"aftersale_order_list\":[],\"on_aftersale_order_cnt\":0}', '{\"payment_method\":1,\"prepay_id\":\"up_wx20112045176075a813e14d5103ac360000\",\"prepay_time\":1710904845,\"pay_time\":1710904852,\"transaction_id\":\"4337401091202403206248549568\"}', 9990, 9990, 0, NULL, '周**', '516400', '广东省', '汕尾市', '海丰县', '****', '139****2585', '', '', 'null', 0, 'da3bf96aca5d34d9e3ec017711621933', '[{\"waybill_id\":\"73610448785703\",\"delivery_id\":\"ZTO\",\"product_infos\":[{\"product_id\":\"10000103058379\",\"sku_id\":\"2069165392\",\"product_cnt\":1}],\"delivery_name\":\"中通快递\",\"delivery_time\":1710906061,\"deliver_type\":1}]', 1710906061, 'of0P-Z4yhGNWPrBNEo7_lsU1SmlDdPtKsnOLMhXG4APpvl-4yPjGXI4THGYDUF5Jr6e9tF4Jmc_Q', '{\"predict_commission_fee\":99}', 0, NULL, NULL, NULL);
INSERT INTO `erp_shop_order` VALUES (1773651203651506177, 6, '3718589605759552512', 'oAv1963oP6e80PmR0O3WFwVsMjgI', 1710903795, 1711510789, NULL, 30, '{\"aftersale_order_list\":[],\"on_aftersale_order_cnt\":0}', '{\"payment_method\":1,\"prepay_id\":\"up_wx20110316854964035140248b3568880000\",\"prepay_time\":1710903797,\"pay_time\":1710903805,\"transaction_id\":\"4323001101202403206838631886\"}', 9990, 9990, 0, NULL, '杨**', '523000', '广东省', '东莞市', '南城街道', '****', '131****9856', '', '', 'null', 0, 'd840df43d3db15177add62845ef6f4d9', '[{\"waybill_id\":\"312317506583169\",\"delivery_id\":\"YD\",\"product_infos\":[{\"product_id\":\"10000103058379\",\"sku_id\":\"2069165392\",\"product_cnt\":1}],\"delivery_name\":\"韵达速递\",\"delivery_time\":1710905989,\"deliver_type\":1}]', 1710905989, 'ofkbBWSIJgWEGlEETB2I9eyh57RBtnEfsgSR8mezOEF4mS7XdSOVT-IsKy5N5D6qUAMSAR0TKkJA', '{\"predict_commission_fee\":99}', 0, NULL, NULL, NULL);
INSERT INTO `erp_shop_order` VALUES (1773651204742025218, 6, '3718589592043128064', 'oAv196_qiMGLFlRYUrVporaKPzLo', 1710903743, 1711510790, NULL, 30, '{\"aftersale_order_list\":[],\"on_aftersale_order_cnt\":0}', '{\"payment_method\":1,\"prepay_id\":\"up_wx201102245184580c3862e9bad7827c0000\",\"prepay_time\":1710903744,\"pay_time\":1710903759,\"transaction_id\":\"4302201086202403208840994399\"}', 9990, 9990, 0, NULL, '李', '200135', '上海市', '上海市', '浦东新区', '****', '151****0907', '', '', 'null', 0, '8f7bbb970f4b8135917c7ab8ad604f09', '[{\"waybill_id\":\"312317506512381\",\"delivery_id\":\"YD\",\"product_infos\":[{\"product_id\":\"10000103058379\",\"sku_id\":\"2069165392\",\"product_cnt\":1}],\"delivery_name\":\"韵达速递\",\"delivery_time\":1710905989,\"deliver_type\":1}]', 1710905989, 'of4-1Cwj9aGErR9HppkMCnNgRPGDuMXKVe6Z-gm5_ccKqVhIdVeETP5aUPvneZGeUQyn1Jk9SH8g', '{\"predict_commission_fee\":99}', 0, NULL, NULL, NULL);
INSERT INTO `erp_shop_order` VALUES (1773651205966761986, 6, '3718589309525299200', 'oAv1969jKGQpCmYc1SSbPMuWLXUc', 1710902665, 1711510789, NULL, 30, '{\"aftersale_order_list\":[],\"on_aftersale_order_cnt\":0}', '{\"payment_method\":1,\"prepay_id\":\"up_wx20104426595065d78a9492c283f27a0000\",\"prepay_time\":1710902666,\"pay_time\":1710902672,\"transaction_id\":\"4347100965202403202814722381\"}', 9990, 9990, 0, NULL, '王*', '201900', '上海市', '上海市', '宝山区', '****', '139****3668', '', '', 'null', 0, '4570669245c3fe8bd0e0b173d2bf4810', '[{\"waybill_id\":\"312317506523860\",\"delivery_id\":\"YD\",\"product_infos\":[{\"product_id\":\"10000103058379\",\"sku_id\":\"2069165392\",\"product_cnt\":1}],\"delivery_name\":\"韵达速递\",\"delivery_time\":1710905989,\"deliver_type\":1}]', 1710905989, 'ofJ8FkFDNTi0o-2Kza85q3-jQ6A_Kl_QJk7XYZja1tgNFz2Vl3cEhVNiDo4-5DouC1K-eunIllMA', '{\"predict_commission_fee\":99}', 0, NULL, NULL, NULL);
INSERT INTO `erp_shop_order` VALUES (1773651207095029762, 6, '3718589294961886464', 'oAv196y7xzoB4jtnMbZ_8_m2jeOY', 1710902609, 1711510790, NULL, 30, '{\"aftersale_order_list\":[],\"on_aftersale_order_cnt\":0}', '{\"payment_method\":1,\"prepay_id\":\"up_wx20104331088708d417c64b1b0184960000\",\"prepay_time\":1710902611,\"pay_time\":1710902620,\"transaction_id\":\"4346701109202403209988609214\"}', 9990, 9990, 0, NULL, '李**', '200050', '上海市', '上海市', '长宁区', '****', '181****9671', '', '', 'null', 0, 'a2615ec5565c3e3d407e45d1ea7f5f2a', '[{\"waybill_id\":\"312317506578945\",\"delivery_id\":\"YD\",\"product_infos\":[{\"product_id\":\"10000103058379\",\"sku_id\":\"2069165392\",\"product_cnt\":1}],\"delivery_name\":\"韵达速递\",\"delivery_time\":1710905989,\"deliver_type\":1}]', 1710905989, 'of0ByBqSq6e3Ye3a1bma4KP4uiKBfRZ_n_lhkvLJDpslARp1Vx3oXm9cOLmrQ94ZZCvSkM0qZ8Dg', '{\"predict_commission_fee\":99}', 0, NULL, NULL, NULL);
INSERT INTO `erp_shop_order` VALUES (1773651208210714625, 6, '3718589016159424768', 'oAv19634S2V5xCQ1zC9CK3OfyfiQ', 1710901546, 1711510790, NULL, 30, '{\"aftersale_order_list\":[],\"on_aftersale_order_cnt\":0}', '{\"payment_method\":1,\"prepay_id\":\"up_wx20102547465198d959aca9d05bf4d90000\",\"prepay_time\":1710901547,\"pay_time\":1710901554,\"transaction_id\":\"4342301109202403207545671962\"}', 9990, 9990, 0, NULL, '卢**', '530012', '广西壮族自治区', '南宁市', '兴宁区', '****', '138****5202', '', '13877165202', 'null', 0, '9a9334f61deee413c7579cc7797dfe76', '[{\"waybill_id\":\"312317506455252\",\"delivery_id\":\"YD\",\"product_infos\":[{\"product_id\":\"10000103058379\",\"sku_id\":\"2069165392\",\"product_cnt\":1}],\"delivery_name\":\"韵达速递\",\"delivery_time\":1710905989,\"deliver_type\":1}]', 1710905989, 'ofZdjluGp7LFmJA9HxxGsqcgcHySzhWQ1yw76nuvkZcS4NZeQKds94thoZQ0C1oOoJMwkQNAb0xw', '{\"predict_commission_fee\":99}', 0, NULL, NULL, NULL);
INSERT INTO `erp_shop_order` VALUES (1773651209330593793, 6, '3718588644526002432', 'oAv196_7aFUZPJalgmLxL_iWw804', 1710900128, 1711510790, NULL, 30, '{\"aftersale_order_list\":[],\"on_aftersale_order_cnt\":0}', '{\"payment_method\":1,\"prepay_id\":\"up_wx20100209893206a12375aa409b48bb0000\",\"prepay_time\":1710900130,\"pay_time\":1710900140,\"transaction_id\":\"4341200952202403200383974611\"}', 9990, 9990, 0, NULL, '马**', '101100', '北京市', '北京市', '通州区', '****', '183****6247', '', '', 'null', 0, '1b704e24c12cf7062ee5736e7551429a', '[{\"waybill_id\":\"312317506509480\",\"delivery_id\":\"YD\",\"product_infos\":[{\"product_id\":\"10000103058379\",\"sku_id\":\"2069165392\",\"product_cnt\":1}],\"delivery_name\":\"韵达速递\",\"delivery_time\":1710905989,\"deliver_type\":1}]', 1710905989, 'ofLFnCZuN2by9AcKov46K5tJm1_mG0bBQbXQ-_cUpATAtdYqQOtzeRBYQ04D_HDZy2hxy0QD5PzA', '{\"predict_commission_fee\":99}', 0, NULL, NULL, NULL);
INSERT INTO `erp_shop_order` VALUES (1773651210421112833, 6, '3718588590994097408', 'oAv196zhzMf97Ba2R8xdQ0QZxnKs', 1710899924, 1710900826, NULL, 250, '{\"aftersale_order_list\":[],\"on_aftersale_order_cnt\":0}', '{\"prepay_id\":\"up_wx20095845672477c9ce9c4315ec892c0000\",\"prepay_time\":1710899925}', 9990, 9990, 0, NULL, '幸*', '543200', '广西壮族自治区', '梧州市', '岑溪市', '****', '182****6206', '', '', 'null', 0, 'd839bebe74d2c0f69bb659ed50726e11', '[]', 0, 'ofRpFXMXe91gV1dn-cpRjsVM35DtD8SKNaIGhmSGSi-GtHwBkt6aIV87SGxa-3CEfaVc1JKUTevA', '{\"predict_commission_fee\":0}', 0, NULL, NULL, NULL);
INSERT INTO `erp_shop_order` VALUES (1773651211620683777, 6, '3718588208610936064', 'oAv196xSiMAiXvclFVbm3uQtFiMk', 1710898465, 1711510861, NULL, 30, '{\"aftersale_order_list\":[],\"on_aftersale_order_cnt\":0}', '{\"payment_method\":1,\"prepay_id\":\"up_wx200934271410802829cd13e6d377c20000\",\"prepay_time\":1710898467,\"pay_time\":1710898475,\"transaction_id\":\"4305500964202403207977225252\"}', 9990, 9990, 0, NULL, '王**', '361001', '福建省', '厦门市', '思明区', '****', '137****5379', '', '', 'null', 0, '5391edd5cb004407c49340082782bdfa', '[{\"waybill_id\":\"73610448785566\",\"delivery_id\":\"ZTO\",\"product_infos\":[{\"product_id\":\"10000103058379\",\"sku_id\":\"2069165392\",\"product_cnt\":1}],\"delivery_name\":\"中通快递\",\"delivery_time\":1710906061,\"deliver_type\":1}]', 1710906061, 'of9UExPPPXndZlepNABvZdWT2c8mlrxKRiYI22tfavxYnl_FlimXLP4T7mBcNYEeixdBBISBdGJA', '{\"predict_commission_fee\":99}', 0, NULL, NULL, NULL);
INSERT INTO `erp_shop_order` VALUES (1773651212686036993, 6, '3718588207135065344', 'oAv1965NJAgLllnVsL1sqtLu_eYc', 1710898460, 1710899360, NULL, 250, '{\"aftersale_order_list\":[],\"on_aftersale_order_cnt\":0}', '{\"prepay_id\":\"up_wx20093421419085b90d7f5497a5e3170000\",\"prepay_time\":1710898461}', 9990, 9990, 0, NULL, '冯**', '563000', '贵州省', '遵义市', '红花岗区', '****', '156****2268', '', '15608522268', 'null', 0, 'b89011e707f7538071a8f39c5364f380', '[]', 0, 'ofwqKwLKOxvcPzpqCQ0Bt00U8Z8fiSQk-G6KM2AO7ml5VFXvDhNsb52AWxYQ_h0WDwhpzPsJG9Og', '{\"predict_commission_fee\":0}', 1, '2024-04-12 14:41:11', NULL, NULL);
INSERT INTO `erp_shop_order` VALUES (1773651213822693377, 6, '3718587822346996736', 'oAv196wFsnkezeypRf0egcDMGiWM', 1710896992, 1710898600, NULL, 200, '{\"aftersale_order_list\":[{\"aftersale_order_id\":\"2000000376158056\",\"status\":13}],\"on_aftersale_order_cnt\":0}', '{\"payment_method\":1,\"prepay_id\":\"up_wx20090953417027afb2603f0b09c7fb0000\",\"prepay_time\":1710896993,\"pay_time\":1710897001,\"transaction_id\":\"4331701107202403200001411174\"}', 9990, 9990, 0, NULL, '赵**', '100010', '北京市', '北京市', '东城区', '****', '134****1877', '', '', 'null', 0, '05bae94246e4ad5e05f1cfb5cfcdabd6', '[]', 0, 'ofIj04A4BImnu3akL1Jq5Web4yULuKS6G3O91u5HVEj62aCmbPEpFgwhM0JWXapPCi-jgV9-49ng', '{\"predict_commission_fee\":0}', 1, '2024-04-12 14:41:11', NULL, NULL);
INSERT INTO `erp_shop_order` VALUES (1773651214942572545, 6, '3718587815659965440', 'oAv196291g5xNrw1spVQpjXhoXg0', 1710896966, 1710897868, NULL, 250, '{\"aftersale_order_list\":[],\"on_aftersale_order_cnt\":0}', '{\"prepay_id\":\"up_wx20090927863922d6ba03e28352d80e0000\",\"prepay_time\":1710896968}', 9990, 9990, 0, NULL, '崔*', '445300', '湖北省', '恩施土家族苗族自治州', '建始县', '****', '133****5865', '', '', 'null', 0, '43d9d5270bc81462f94547083e6f1ecd', '[]', 0, 'of_9-SntfOwUc_ivgA-GyQxaNuCyBtJSWOEwvNsWZSdxOnC58AZV7y9mVgCoK8eEJKepOGwg5ciQ', '{\"predict_commission_fee\":0}', 1, '2024-04-12 14:41:11', NULL, NULL);
INSERT INTO `erp_shop_order` VALUES (1773651216016314369, 6, '3718587814527504384', 'oAv1965374koR_XZBopbQIgbwvYg', 1710896962, 1711161629, NULL, 100, '{\"aftersale_order_list\":[],\"on_aftersale_order_cnt\":0}', '{\"payment_method\":1,\"prepay_id\":\"up_wx20090923692523ec3d6e1ed350c68a0000\",\"prepay_time\":1710896963,\"pay_time\":1710896972,\"transaction_id\":\"4317200957202403206956316633\"}', 9990, 9990, 0, NULL, '王**', '100020', '北京市', '北京市', '朝阳区', '****', '136****6620', '', '', 'null', 0, 'abed73df538b1b73d8e60a3bd15836c8', '[{\"waybill_id\":\"312317506527084\",\"delivery_id\":\"YD\",\"product_infos\":[{\"product_id\":\"10000103058379\",\"sku_id\":\"2069165392\",\"product_cnt\":1}],\"delivery_name\":\"韵达速递\",\"delivery_time\":1710905989,\"deliver_type\":1}]', 1710905989, 'of31XR_nQ-ipiULDnExMHqt2Nm3TWsinqzjDYw60zSAnM361_3JAI6V_i6wFGe0T2GfbyDES4h8A', '{\"predict_commission_fee\":99}', 1, '2024-04-12 14:41:11', NULL, NULL);
INSERT INTO `erp_shop_order` VALUES (1773651217362685954, 6, '3718587810203962368', 'oAv196z-7_wGiRBgD8b1Ob3LTuSQ', 1710896946, 1711510789, NULL, 30, '{\"aftersale_order_list\":[],\"on_aftersale_order_cnt\":0}', '{\"payment_method\":1,\"prepay_id\":\"up_wx200909072119543b9b208278195da40000\",\"prepay_time\":1710896947,\"pay_time\":1710896954,\"transaction_id\":\"4313501099202403202886208440\"}', 9990, 9990, 0, NULL, '忻*', '550001', '贵州省', '贵阳市', '云岩区', '****', '139****5732', '', '', 'null', 0, '1e90e5b3739a2e46587e0de50ed28879', '[{\"waybill_id\":\"312317506456736\",\"delivery_id\":\"YD\",\"product_infos\":[{\"product_id\":\"10000103058379\",\"sku_id\":\"2069165392\",\"product_cnt\":1}],\"delivery_name\":\"韵达速递\",\"delivery_time\":1710905989,\"deliver_type\":1}]', 1710905989, 'ofbNlHM1Uwy9tTtGAuieftzGiYjpBfQGsnHGNYyTMfcPSQ0oJvdf5-iqL2-4iK_-xoxbWgc8UqOA', '{\"predict_commission_fee\":99}', 1, '2024-04-12 14:41:11', NULL, NULL);
INSERT INTO `erp_shop_order` VALUES (1773651218482565122, 6, '3718587809541260800', 'oAv1960PTbIGg1azMM97-Yb1BILM', 1710896943, 1711692550, NULL, 200, '{\"aftersale_order_list\":[{\"aftersale_order_id\":\"2000000387777830\",\"status\":14}],\"on_aftersale_order_cnt\":0}', '{\"payment_method\":1,\"prepay_id\":\"up_wx200909048136598e32c836acdd7fce0000\",\"prepay_time\":1710896945,\"pay_time\":1710896952,\"transaction_id\":\"4326500957202403203893580121\"}', 9990, 9990, 0, NULL, '耿*', '100071', '北京市', '北京市', '丰台区', '****', '136****6190', '', '', 'null', 0, '72ef646c988a5284a2790d3aa2477dad', '[{\"waybill_id\":\"312317506638952\",\"delivery_id\":\"YD\",\"product_infos\":[{\"product_id\":\"10000103058379\",\"sku_id\":\"2069165392\",\"product_cnt\":1}],\"delivery_name\":\"韵达速递\",\"delivery_time\":1710905989,\"deliver_type\":1}]', 1710905989, 'ofFXYhtxh8BiP2LmchmbuhbYisvOgAgOUryV0F15xG8o0SIp1NITD4vbSATpaoRhYp_trkhgrUaA', '{\"predict_commission_fee\":0}', 1, '2024-04-12 14:41:11', NULL, NULL);
INSERT INTO `erp_shop_order` VALUES (1773651219539529730, 6, '3718587542502772992', 'oAv196_y-DtYDOLcAI27-wOQyI4M', 1710895924, 1711591705, NULL, 30, '{\"aftersale_order_list\":[],\"on_aftersale_order_cnt\":0}', '{\"payment_method\":1,\"prepay_id\":\"up_wx20085206263250579fa283be7dc8e20000\",\"prepay_time\":1710895926,\"pay_time\":1710896086,\"transaction_id\":\"4311100949202403208635067416\"}', 990, 990, 0, NULL, '吴*', '215000', '江苏省', '苏州市', '姑苏区', '****', '131****1805', '', '', 'null', 0, '5a32b39d6fe49c2cbbeaa498788c154f', '[{\"waybill_id\":\"318890755728720\",\"delivery_id\":\"YD\",\"product_infos\":[{\"product_id\":\"10000104315300\",\"sku_id\":\"2086367126\",\"product_cnt\":1}],\"delivery_name\":\"韵达速递\",\"delivery_time\":1710986905,\"deliver_type\":1}]', 1710986905, 'ofK-HQreW8UkLCXw-zFmtdIMY8QpqFqK9i923uHIa7txGXok4EeLDgFNn96yGLh8eU2LIIjwikPA', '{\"predict_commission_fee\":9}', 1, '2024-04-12 14:41:11', NULL, NULL);
INSERT INTO `erp_shop_order` VALUES (1773651220789432322, 6, '3718587018572858624', 'oAv1962vGm4-XWRG9ma4_S_yCVA4', 1710893926, 1710916555, NULL, 200, '{\"aftersale_order_list\":[{\"aftersale_order_id\":\"2000000376505279\",\"status\":13}],\"on_aftersale_order_cnt\":0}', '{\"payment_method\":1,\"prepay_id\":\"up_wx20081903030176f28c94820f0507750000\",\"prepay_time\":1710893943,\"pay_time\":1710893948,\"transaction_id\":\"4336600964202403204980463253\"}', 109890, 100, 0, NULL, '阿*', '657000', '云南省', '昭通市', '昭阳区', '****', '139****6961', '', '13512120557', 'null', 0, 'd25a0ad0da52d5f279aad62152a4ba53', '[]', 0, 'ofGKBzBVIOKCbWhuAzmzE2XxfAF-E9wkCgc8JxviQzRb4gezkLahY55ckCgjhKu9FMHQRUYMkcIw', '{\"predict_commission_fee\":0}', 1, '2024-04-12 14:41:11', NULL, NULL);
INSERT INTO `erp_shop_order` VALUES (1773651221888339969, 6, '3718586568279724288', 'oAv1966osuFsbYH6YSExD6uKr3WY', 1710892208, 1711510790, NULL, 30, '{\"aftersale_order_list\":[],\"on_aftersale_order_cnt\":0}', '{\"payment_method\":1,\"prepay_id\":\"up_wx20075009764726ff1a9fc3b58ae4400000\",\"prepay_time\":1710892209,\"pay_time\":1710892227,\"transaction_id\":\"4335800950202403200637254989\"}', 9990, 9990, 0, NULL, '王**', '475000', '河南省', '开封市', '禹王台区', '****', '152****2706', '', '', 'null', 0, '4f1ffa0a6c31d9bebc1c30440544d7b2', '[{\"waybill_id\":\"312317506457252\",\"delivery_id\":\"YD\",\"product_infos\":[{\"product_id\":\"10000103058379\",\"sku_id\":\"2069165392\",\"product_cnt\":1}],\"delivery_name\":\"韵达速递\",\"delivery_time\":1710905989,\"deliver_type\":1}]', 1710905989, 'ofmS5hUKMgVF7Htd3qfQ3G_wXgz3x-C2R6n6BUinYFVeKjBZ2guWU1YHcAVbKnzinff0FerdU79Q', '{\"predict_commission_fee\":99}', 1, '2024-04-12 14:41:11', NULL, NULL);
INSERT INTO `erp_shop_order` VALUES (1773651223045967873, 6, '3718586550340945408', 'oAv1964cOETzaRR_Swm2LXxmBypY', 1710892139, 1711510790, NULL, 30, '{\"aftersale_order_list\":[],\"on_aftersale_order_cnt\":0}', '{\"payment_method\":1,\"prepay_id\":\"up_wx2007490139983219e20e83520865070000\",\"prepay_time\":1710892141,\"pay_time\":1710892148,\"transaction_id\":\"4307200968202403207539523408\"}', 9990, 9990, 0, NULL, '张*', '231500', '安徽省', '合肥市', '庐江县', '****', '153****8788', '', '', 'null', 0, '934fd91e344f6a1bf99e1c3105dd6344', '[{\"waybill_id\":\"312317506455345\",\"delivery_id\":\"YD\",\"product_infos\":[{\"product_id\":\"10000103058379\",\"sku_id\":\"2069165392\",\"product_cnt\":1}],\"delivery_name\":\"韵达速递\",\"delivery_time\":1710905989,\"deliver_type\":1}]', 1710905989, 'of1oLHaoKiJqqNvZ2oAdPPFO_ABYUwSB-yoigQlISLILJx6x_DXmqhSCux2OTZ_-frSVwyHgfqoQ', '{\"predict_commission_fee\":99}', 1, '2024-04-12 14:41:11', NULL, NULL);

-- ----------------------------
-- Table structure for erp_shop_order_item
-- ----------------------------
DROP TABLE IF EXISTS `erp_shop_order_item`;
CREATE TABLE `erp_shop_order_item`  (
  `id` bigint NOT NULL,
  `wei_order_id` bigint NULL DEFAULT NULL COMMENT '外键id',
  `product_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品spuid',
  `sku_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品skuid\r\n',
  `thumb_img` varchar(550) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'sku小图',
  `sku_cnt` int NULL DEFAULT NULL COMMENT 'sku数量',
  `sale_price` int NULL DEFAULT NULL COMMENT '售卖单价（单位：分）',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品标题',
  `on_aftersale_sku_cnt` int NULL DEFAULT NULL COMMENT '正在售后/退款流程中的 sku 数量',
  `finish_aftersale_sku_cnt` int NULL DEFAULT NULL COMMENT '完成售后/退款的 sku 数量',
  `sku_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品编码',
  `market_price` int NULL DEFAULT NULL COMMENT '市场单价（单位：分）',
  `sku_attrs` varchar(2550) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'sku属性JSON',
  `real_price` int NULL DEFAULT NULL COMMENT 'sku实付总价，取estimate_price和change_price中较小值',
  `out_product_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品外部spuid',
  `out_sku_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品外部skuid',
  `is_discounted` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否有优惠金额，非必填，默认为false',
  `estimate_price` int NULL DEFAULT NULL COMMENT '优惠后sku总价，非必填，is_discounted为true时有值',
  `is_change_price` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否修改过价格，非必填，默认为false',
  `change_price` int NULL DEFAULT NULL COMMENT '改价后sku总价，非必填，is_change_price为true时有值',
  `out_warehouse_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '区域库存id',
  `sku_deliver_info` varchar(2550) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品发货信息JSON',
  `extra_service` varchar(2550) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品额外服务信息JSON',
  `use_deduction` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否使用了会员积分抵扣\r\n',
  `deduction_price` int NULL DEFAULT NULL COMMENT '会员积分抵扣金额，单位为分',
  `order_product_coupon_info_list` varchar(2550) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品优惠券信息，逐步替换 order.order_detail.coupon_info',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of erp_shop_order_item
-- ----------------------------
INSERT INTO `erp_shop_order_item` VALUES (1773651199977295874, 1773651199826300930, '10000103058379', '2069165392', 'https://store.mp.video.tencent-cloud.com/161/20304/snscosdownload/SH/reserved/65f29bc400032a7c023ca7e6b960b01e000000a000004f50', 1, 9990, '泷御堂 冲饮谷物  赤小豆薏米芡实茯苓330g*罐', 0, 0, '', 9990, '[{\"attr_key\":\"净含量\",\"attr_value\":\"拍3罐送1罐到手4罐\"},{\"attr_key\":\"主播承诺\",\"attr_value\":\"7天升级30天试喝及运费险\"}]', 9990, NULL, NULL, 'null', NULL, 'null', NULL, '', '{\"stock_type\":0}', '{\"seven_day_return\":1,\"freight_insurance\":1}', 'null', NULL, '[]');
INSERT INTO `erp_shop_order_item` VALUES (1773651201202032641, 1773651201164283905, '10000103058379', '2069165392', 'https://store.mp.video.tencent-cloud.com/161/20304/snscosdownload/SH/reserved/65f29bc400032a7c023ca7e6b960b01e000000a000004f50', 1, 9990, '泷御堂 冲饮谷物  赤小豆薏米芡实茯苓330g*罐', 0, 0, '', 9990, '[{\"attr_key\":\"净含量\",\"attr_value\":\"拍3罐送1罐到手4罐\"},{\"attr_key\":\"主播承诺\",\"attr_value\":\"7天升级30天试喝及运费险\"}]', 9990, NULL, NULL, 'null', NULL, 'null', NULL, '', '{\"stock_type\":0}', '{\"seven_day_return\":1,\"freight_insurance\":1}', 'null', NULL, '[]');
INSERT INTO `erp_shop_order_item` VALUES (1773651202577764353, 1773651202531627010, '10000103058379', '2069165392', 'https://store.mp.video.tencent-cloud.com/161/20304/snscosdownload/SH/reserved/65f29bc400032a7c023ca7e6b960b01e000000a000004f50', 1, 9990, '泷御堂 冲饮谷物  赤小豆薏米芡实茯苓330g*罐', 0, 0, '', 9990, '[{\"attr_key\":\"净含量\",\"attr_value\":\"拍3罐送1罐到手4罐\"},{\"attr_key\":\"主播承诺\",\"attr_value\":\"7天升级30天试喝及运费险\"}]', 9990, NULL, NULL, 'null', NULL, 'null', NULL, '', '{\"stock_type\":0}', '{\"seven_day_return\":1,\"freight_insurance\":1}', 'null', NULL, '[]');
INSERT INTO `erp_shop_order_item` VALUES (1773651203689254913, 1773651203651506177, '10000103058379', '2069165392', 'https://store.mp.video.tencent-cloud.com/161/20304/snscosdownload/SH/reserved/65f29bc400032a7c023ca7e6b960b01e000000a000004f50', 1, 9990, '泷御堂 冲饮谷物  赤小豆薏米芡实茯苓330g*罐', 0, 0, '', 9990, '[{\"attr_key\":\"净含量\",\"attr_value\":\"拍3罐送1罐到手4罐\"},{\"attr_key\":\"主播承诺\",\"attr_value\":\"7天升级30天试喝及运费险\"}]', 9990, NULL, NULL, 'null', NULL, 'null', NULL, '', '{\"stock_type\":0}', '{\"seven_day_return\":1,\"freight_insurance\":1}', 'null', NULL, '[]');
INSERT INTO `erp_shop_order_item` VALUES (1773651204817522690, 1773651204742025218, '10000103058379', '2069165392', 'https://store.mp.video.tencent-cloud.com/161/20304/snscosdownload/SH/reserved/65f29bc400032a7c023ca7e6b960b01e000000a000004f50', 1, 9990, '泷御堂 冲饮谷物  赤小豆薏米芡实茯苓330g*罐', 0, 0, '', 9990, '[{\"attr_key\":\"净含量\",\"attr_value\":\"拍3罐送1罐到手4罐\"},{\"attr_key\":\"主播承诺\",\"attr_value\":\"7天升级30天试喝及运费险\"}]', 9990, NULL, NULL, 'null', NULL, 'null', NULL, '', '{\"stock_type\":0}', '{\"seven_day_return\":1,\"freight_insurance\":1}', 'null', NULL, '[]');
INSERT INTO `erp_shop_order_item` VALUES (1773651206088396801, 1773651205966761986, '10000103058379', '2069165392', 'https://store.mp.video.tencent-cloud.com/161/20304/snscosdownload/SH/reserved/65f29bc400032a7c023ca7e6b960b01e000000a000004f50', 1, 9990, '泷御堂 冲饮谷物  赤小豆薏米芡实茯苓330g*罐', 0, 0, '', 9990, '[{\"attr_key\":\"净含量\",\"attr_value\":\"拍3罐送1罐到手4罐\"},{\"attr_key\":\"主播承诺\",\"attr_value\":\"7天升级30天试喝及运费险\"}]', 9990, NULL, NULL, 'null', NULL, 'null', NULL, '', '{\"stock_type\":0}', '{\"seven_day_return\":1,\"freight_insurance\":1}', 'null', NULL, '[]');
INSERT INTO `erp_shop_order_item` VALUES (1773651207124389889, 1773651207095029762, '10000103058379', '2069165392', 'https://store.mp.video.tencent-cloud.com/161/20304/snscosdownload/SH/reserved/65f29bc400032a7c023ca7e6b960b01e000000a000004f50', 1, 9990, '泷御堂 冲饮谷物  赤小豆薏米芡实茯苓330g*罐', 0, 0, '', 9990, '[{\"attr_key\":\"净含量\",\"attr_value\":\"拍3罐送1罐到手4罐\"},{\"attr_key\":\"主播承诺\",\"attr_value\":\"7天升级30天试喝及运费险\"}]', 9990, NULL, NULL, 'null', NULL, 'null', NULL, '', '{\"stock_type\":0}', '{\"seven_day_return\":1,\"freight_insurance\":1}', 'null', NULL, '[]');
INSERT INTO `erp_shop_order_item` VALUES (1773651208265240577, 1773651208210714625, '10000103058379', '2069165392', 'https://store.mp.video.tencent-cloud.com/161/20304/snscosdownload/SH/reserved/65f29bc400032a7c023ca7e6b960b01e000000a000004f50', 1, 9990, '泷御堂 冲饮谷物  赤小豆薏米芡实茯苓330g*罐', 0, 0, '', 9990, '[{\"attr_key\":\"净含量\",\"attr_value\":\"拍3罐送1罐到手4罐\"},{\"attr_key\":\"主播承诺\",\"attr_value\":\"7天升级30天试喝及运费险\"}]', 9990, NULL, NULL, 'null', NULL, 'null', NULL, '', '{\"stock_type\":0}', '{\"seven_day_return\":1,\"freight_insurance\":1}', 'null', NULL, '[]');
INSERT INTO `erp_shop_order_item` VALUES (1773651209368342530, 1773651209330593793, '10000103058379', '2069165392', 'https://store.mp.video.tencent-cloud.com/161/20304/snscosdownload/SH/reserved/65f29bc400032a7c023ca7e6b960b01e000000a000004f50', 1, 9990, '泷御堂 冲饮谷物  赤小豆薏米芡实茯苓330g*罐', 0, 0, '', 9990, '[{\"attr_key\":\"净含量\",\"attr_value\":\"拍3罐送1罐到手4罐\"},{\"attr_key\":\"主播承诺\",\"attr_value\":\"7天升级30天试喝及运费险\"}]', 9990, NULL, NULL, 'null', NULL, 'null', NULL, '', '{\"stock_type\":0}', '{\"seven_day_return\":1,\"freight_insurance\":1}', 'null', NULL, '[]');
INSERT INTO `erp_shop_order_item` VALUES (1773651210479833090, 1773651210421112833, '10000103058379', '2069165392', 'https://store.mp.video.tencent-cloud.com/161/20304/snscosdownload/SH/reserved/65f29bc400032a7c023ca7e6b960b01e000000a000004f50', 1, 9990, '泷御堂 冲饮谷物  赤小豆薏米芡实茯苓330g*罐', 0, 0, '', 9990, '[{\"attr_key\":\"净含量\",\"attr_value\":\"拍3罐送1罐到手4罐\"},{\"attr_key\":\"主播承诺\",\"attr_value\":\"7天升级30天试喝及运费险\"}]', 9990, NULL, NULL, 'null', NULL, 'null', NULL, '', '{\"stock_type\":0}', '{\"seven_day_return\":1,\"freight_insurance\":1}', 'null', NULL, '[]');
INSERT INTO `erp_shop_order_item` VALUES (1773651211645849602, 1773651211620683777, '10000103058379', '2069165392', 'https://store.mp.video.tencent-cloud.com/161/20304/snscosdownload/SH/reserved/65f29bc400032a7c023ca7e6b960b01e000000a000004f50', 1, 9990, '泷御堂 冲饮谷物  赤小豆薏米芡实茯苓330g*罐', 0, 0, '', 9990, '[{\"attr_key\":\"净含量\",\"attr_value\":\"拍3罐送1罐到手4罐\"},{\"attr_key\":\"主播承诺\",\"attr_value\":\"7天升级30天试喝及运费险\"}]', 9990, NULL, NULL, 'null', NULL, 'null', NULL, '', '{\"stock_type\":0}', '{\"seven_day_return\":1,\"freight_insurance\":1}', 'null', NULL, '[]');
INSERT INTO `erp_shop_order_item` VALUES (1773651212711202818, 1773651212686036993, '10000103058379', '2069165392', 'https://store.mp.video.tencent-cloud.com/161/20304/snscosdownload/SH/reserved/65f29bc400032a7c023ca7e6b960b01e000000a000004f50', 1, 9990, '泷御堂 冲饮谷物  赤小豆薏米芡实茯苓330g*罐', 0, 0, '', 9990, '[{\"attr_key\":\"净含量\",\"attr_value\":\"拍3罐送1罐到手4罐\"},{\"attr_key\":\"主播承诺\",\"attr_value\":\"7天升级30天试喝及运费险\"}]', 9990, NULL, NULL, 'null', NULL, 'null', NULL, '', '{\"stock_type\":0}', '{\"seven_day_return\":1,\"freight_insurance\":1}', 'null', NULL, '[]');
INSERT INTO `erp_shop_order_item` VALUES (1773651213856247809, 1773651213822693377, '10000103058379', '2069165392', 'https://store.mp.video.tencent-cloud.com/161/20304/snscosdownload/SH/reserved/65f29bc400032a7c023ca7e6b960b01e000000a000004f50', 1, 9990, '泷御堂 冲饮谷物  赤小豆薏米芡实茯苓330g*罐', 0, 1, '', 9990, '[{\"attr_key\":\"净含量\",\"attr_value\":\"拍3罐送1罐到手4罐\"},{\"attr_key\":\"主播承诺\",\"attr_value\":\"7天升级30天试喝及运费险\"}]', 9990, NULL, NULL, 'null', NULL, 'null', NULL, '', '{\"stock_type\":0}', '{\"seven_day_return\":1,\"freight_insurance\":1}', 'null', NULL, '[]');
INSERT INTO `erp_shop_order_item` VALUES (1773651214967738370, 1773651214942572545, '10000103058379', '2069165392', 'https://store.mp.video.tencent-cloud.com/161/20304/snscosdownload/SH/reserved/65f29bc400032a7c023ca7e6b960b01e000000a000004f50', 1, 9990, '泷御堂 冲饮谷物  赤小豆薏米芡实茯苓330g*罐', 0, 0, '', 9990, '[{\"attr_key\":\"净含量\",\"attr_value\":\"拍3罐送1罐到手4罐\"},{\"attr_key\":\"主播承诺\",\"attr_value\":\"7天升级30天试喝及运费险\"}]', 9990, NULL, NULL, 'null', NULL, 'null', NULL, '', '{\"stock_type\":0}', '{\"seven_day_return\":1,\"freight_insurance\":1}', 'null', NULL, '[]');
INSERT INTO `erp_shop_order_item` VALUES (1773651216045674498, 1773651216016314369, '10000103058379', '2069165392', 'https://store.mp.video.tencent-cloud.com/161/20304/snscosdownload/SH/reserved/65f29bc400032a7c023ca7e6b960b01e000000a000004f50', 1, 9990, '泷御堂 冲饮谷物  赤小豆薏米芡实茯苓330g*罐', 0, 0, '', 9990, '[{\"attr_key\":\"净含量\",\"attr_value\":\"拍3罐送1罐到手4罐\"},{\"attr_key\":\"主播承诺\",\"attr_value\":\"7天升级30天试喝及运费险\"}]', 9990, NULL, NULL, 'null', NULL, 'null', NULL, '', '{\"stock_type\":0}', '{\"seven_day_return\":1,\"freight_insurance\":1}', 'null', NULL, '[]');
INSERT INTO `erp_shop_order_item` VALUES (1773651217396240385, 1773651217362685954, '10000103058379', '2069165392', 'https://store.mp.video.tencent-cloud.com/161/20304/snscosdownload/SH/reserved/65f29bc400032a7c023ca7e6b960b01e000000a000004f50', 1, 9990, '泷御堂 冲饮谷物  赤小豆薏米芡实茯苓330g*罐', 0, 0, '', 9990, '[{\"attr_key\":\"净含量\",\"attr_value\":\"拍3罐送1罐到手4罐\"},{\"attr_key\":\"主播承诺\",\"attr_value\":\"7天升级30天试喝及运费险\"}]', 9990, NULL, NULL, 'null', NULL, 'null', NULL, '', '{\"stock_type\":0}', '{\"seven_day_return\":1,\"freight_insurance\":1}', 'null', NULL, '[]');
INSERT INTO `erp_shop_order_item` VALUES (1773651218511925250, 1773651218482565122, '10000103058379', '2069165392', 'https://store.mp.video.tencent-cloud.com/161/20304/snscosdownload/SH/reserved/65f29bc400032a7c023ca7e6b960b01e000000a000004f50', 1, 9990, '泷御堂 冲饮谷物  赤小豆薏米芡实茯苓330g*罐', 0, 1, '', 9990, '[{\"attr_key\":\"净含量\",\"attr_value\":\"拍3罐送1罐到手4罐\"},{\"attr_key\":\"主播承诺\",\"attr_value\":\"7天升级30天试喝及运费险\"}]', 9990, NULL, NULL, 'null', NULL, 'null', NULL, '', '{\"stock_type\":0}', '{\"seven_day_return\":1,\"freight_insurance\":1}', 'null', NULL, '[]');
INSERT INTO `erp_shop_order_item` VALUES (1773651219568889858, 1773651219539529730, '10000104315300', '2086367126', 'https://store.mp.video.tencent-cloud.com/161/20304/snscosdownload/SH/reserved/65f292760001000d22cbd8f9727c0d15000000a000004f50', 1, 990, '泷御堂 冲饮谷物  赤小豆薏米芡实茯苓茶330g*罐', 0, 0, '', 990, '[{\"attr_key\":\"净含量\",\"attr_value\":\"1罐体验装【贵在运费】(5%人选择)\"}]', 990, NULL, NULL, 'null', NULL, 'null', NULL, '', '{\"stock_type\":0}', '{\"seven_day_return\":1,\"freight_insurance\":1}', 'null', NULL, '[]');
INSERT INTO `erp_shop_order_item` VALUES (1773651220827181058, 1773651220789432322, '10000103058379', '2069165392', 'https://store.mp.video.tencent-cloud.com/161/20304/snscosdownload/SH/reserved/65f29bc400032a7c023ca7e6b960b01e000000a000004f50', 11, 9990, '泷御堂 冲饮谷物  赤小豆薏米芡实茯苓330g*罐', 0, 11, '', 9990, '[{\"attr_key\":\"净含量\",\"attr_value\":\"拍3罐送1罐到手4罐\"},{\"attr_key\":\"主播承诺\",\"attr_value\":\"7天升级30天试喝及运费险\"}]', 100, NULL, NULL, 'null', NULL, 'true', 100, '', '{\"stock_type\":0}', '{\"seven_day_return\":1,\"freight_insurance\":1}', 'null', NULL, '[]');
INSERT INTO `erp_shop_order_item` VALUES (1773651221921894401, 1773651221888339969, '10000103058379', '2069165392', 'https://store.mp.video.tencent-cloud.com/161/20304/snscosdownload/SH/reserved/65f29bc400032a7c023ca7e6b960b01e000000a000004f50', 1, 9990, '泷御堂 冲饮谷物  赤小豆薏米芡实茯苓330g*罐', 0, 0, '', 9990, '[{\"attr_key\":\"净含量\",\"attr_value\":\"拍3罐送1罐到手4罐\"},{\"attr_key\":\"主播承诺\",\"attr_value\":\"7天升级30天试喝及运费险\"}]', 9990, NULL, NULL, 'null', NULL, 'null', NULL, '', '{\"stock_type\":0}', '{\"seven_day_return\":1,\"freight_insurance\":1}', 'null', NULL, '[]');
INSERT INTO `erp_shop_order_item` VALUES (1773651223083716609, 1773651223045967873, '10000103058379', '2069165392', 'https://store.mp.video.tencent-cloud.com/161/20304/snscosdownload/SH/reserved/65f29bc400032a7c023ca7e6b960b01e000000a000004f50', 1, 9990, '泷御堂 冲饮谷物  赤小豆薏米芡实茯苓330g*罐', 0, 0, '', 9990, '[{\"attr_key\":\"净含量\",\"attr_value\":\"拍3罐送1罐到手4罐\"},{\"attr_key\":\"主播承诺\",\"attr_value\":\"7天升级30天试喝及运费险\"}]', 9990, NULL, NULL, 'null', NULL, 'null', NULL, '', '{\"stock_type\":0}', '{\"seven_day_return\":1,\"freight_insurance\":1}', 'null', NULL, '[]');

-- ----------------------------
-- Table structure for erp_shop_platform
-- ----------------------------
DROP TABLE IF EXISTS `erp_shop_platform`;
CREATE TABLE `erp_shop_platform`  (
  `id` int NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '平台名',
  `code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '平台编码',
  `app_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `app_secret` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `redirect_uri` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '平台回调uri',
  `server_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '接口访问地址',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of erp_shop_platform
-- ----------------------------
INSERT INTO `erp_shop_platform` VALUES (5, '视频号小店', 'WEI', '', NULL, NULL, 'https://api.weixin.qq.com');

-- ----------------------------
-- Table structure for erp_shop_pull_lasttime
-- ----------------------------
DROP TABLE IF EXISTS `erp_shop_pull_lasttime`;
CREATE TABLE `erp_shop_pull_lasttime`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `shop_id` int NULL DEFAULT NULL COMMENT '店铺id',
  `pull_type` enum('ORDER','REFUND') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '类型（ORDER:订单，REFUND:退款）',
  `lasttime` datetime NULL DEFAULT NULL COMMENT '最后更新时间',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '店铺更新最后时间记录' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of erp_shop_pull_lasttime
-- ----------------------------
INSERT INTO `erp_shop_pull_lasttime` VALUES (1, 1, 'ORDER', '2024-04-06 12:59:30', '2024-03-23 15:56:13', '2024-04-11 16:42:42');
INSERT INTO `erp_shop_pull_lasttime` VALUES (2, 1, 'REFUND', '2024-03-28 09:03:50', '2024-03-24 13:03:54', '2024-04-06 15:35:16');
INSERT INTO `erp_shop_pull_lasttime` VALUES (3, 2, 'ORDER', '2024-04-01 00:33:33', '2024-03-10 13:00:07', '2024-04-01 20:35:54');
INSERT INTO `erp_shop_pull_lasttime` VALUES (4, 2, 'REFUND', '2024-03-24 13:48:33', '2024-03-24 13:50:24', NULL);

-- ----------------------------
-- Table structure for erp_shop_pull_logs
-- ----------------------------
DROP TABLE IF EXISTS `erp_shop_pull_logs`;
CREATE TABLE `erp_shop_pull_logs`  (
  `id` bigint NOT NULL COMMENT '主键Id',
  `shop_id` int NULL DEFAULT NULL COMMENT '店铺id',
  `shop_type` int NOT NULL COMMENT '平台id',
  `pull_type` enum('ORDER','REFUND','GOODS') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '类型（ORDER订单，GOODS商品，REFUND退款）',
  `pull_way` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '拉取方式（主动拉取、定时任务）',
  `pull_params` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '拉取参数',
  `pull_result` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '拉取结果',
  `pull_time` datetime NULL DEFAULT NULL COMMENT '拉取时间',
  `duration` bigint NULL DEFAULT NULL COMMENT '耗时（毫秒）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '更新日志表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of erp_shop_pull_logs
-- ----------------------------
INSERT INTO `erp_shop_pull_logs` VALUES (1771373938119639041, 2, 2, 'GOODS', '主动拉取', '{WareStatusValue:8,PageNo:1,PageSize:100}', '{successTotal:61}', '2024-03-23 11:10:10', 22115);
INSERT INTO `erp_shop_pull_logs` VALUES (1771423380642209794, 2, 2, 'ORDER', '主动拉取', '{startTime:2024-03-10T11:59:58,endTime:2024-03-11T11:59:58}', '{insertSuccess:14,hasExistOrder:4,totalError:0}', '2024-03-23 14:26:59', 927);
INSERT INTO `erp_shop_pull_logs` VALUES (1771445830457229314, 1, 1, 'ORDER', '主动拉取', '{startTime:2024-03-22T15:56:09.353561200,endTime:2024-03-23T15:56:09.353561200}', '{insertSuccess:25,hasExistOrder:2,totalError:0}', '2024-03-23 15:56:09', 3181);
INSERT INTO `erp_shop_pull_logs` VALUES (1771446958322380802, 1, 1, 'ORDER', '主动拉取', '{startTime:2024-03-23T14:56:09,endTime:2024-03-23T16:00:41.205604700}', '{insertSuccess:0,hasExistOrder:0,totalError:0}', '2024-03-23 16:00:41', 219);
INSERT INTO `erp_shop_pull_logs` VALUES (1771447441799819265, 1, 1, 'ORDER', '主动拉取', '{startTime:2024-03-23T15:00:41,endTime:2024-03-23T16:02:36.495455100}', '{insertSuccess:0,hasExistOrder:0,totalError:0}', '2024-03-23 16:02:36', 227);
INSERT INTO `erp_shop_pull_logs` VALUES (1771447509432971265, 1, 1, 'ORDER', '主动拉取', '{startTime:2024-03-23T15:02:36,endTime:2024-03-23T16:02:52.700359100}', '{insertSuccess:0,hasExistOrder:0,totalError:0}', '2024-03-23 16:02:53', 122);
INSERT INTO `erp_shop_pull_logs` VALUES (1771453852395032578, 2, 2, 'ORDER', '主动拉取', '{startTime:2024-03-11T10:59:58,endTime:2024-03-12T10:59:58}', '{insertSuccess:19,hasExistOrder:5,totalError:0}', '2024-03-23 16:28:04', 1086);
INSERT INTO `erp_shop_pull_logs` VALUES (1771542266519748610, 1, 1, 'REFUND', '主动拉取', '{startTime:2024-03-22T22:19:19.564048,endTime:2024-03-23T22:19:19.564048}', '{insertSuccess:0,hasExistOrder:5,totalError:0}', '2024-03-23 22:19:17', 7557);
INSERT INTO `erp_shop_pull_logs` VALUES (1771542873649504258, 1, 1, 'REFUND', '主动拉取', '{startTime:2024-03-22T22:21:48.244864800,endTime:2024-03-23T22:21:48.244864800}', '{insert:0,update:5,fail:0}', '2024-03-23 22:21:48', 1183);
INSERT INTO `erp_shop_pull_logs` VALUES (1771543300528988161, 1, 1, 'REFUND', '主动拉取', '{startTime:2024-03-23T21:21:48,endTime:2024-03-23T22:22:56.873263500}', '{insert:0,update:0,fail:0}', '2024-03-23 22:22:40', 51238);
INSERT INTO `erp_shop_pull_logs` VALUES (1771764678028984322, 2, 2, 'ORDER', '主动拉取', '{startTime:2024-03-12T09:59:58,endTime:2024-03-13T09:59:58}', '{insertSuccess:15,hasExistOrder:5,totalError:0}', '2024-03-24 13:03:11', 925);
INSERT INTO `erp_shop_pull_logs` VALUES (1771764854827368449, 1, 1, 'REFUND', '主动拉取', '{startTime:2024-03-23T13:03:49.686601100,endTime:2024-03-24T13:03:49.686601100}', '{insert:8,update:0,fail:0}', '2024-03-24 13:03:44', 9665);
INSERT INTO `erp_shop_pull_logs` VALUES (1771776559355596801, 2, 2, 'REFUND', '主动拉取', '{ApplyTimeBegin:2024-03-23 13:48:33,ApplyTimeEnd:2024-03-24 13:48:33,PageIndex:1,PageSize:100}', '{total:0,hasExist:2,totalError:0}', '2024-03-24 13:48:29', 115059);
INSERT INTO `erp_shop_pull_logs` VALUES (1771780749221974017, 2, 2, 'ORDER', '主动拉取', '{startTime:2024-03-13T08:59:58,endTime:2024-03-14T08:59:58}', '{insertSuccess:11,hasExistOrder:2,totalError:0}', '2024-03-24 14:07:03', 635);
INSERT INTO `erp_shop_pull_logs` VALUES (1774759644818296834, 1, 1, 'ORDER', '主动拉取', '{startTime:2024-03-30T15:02:53,endTime:2024-03-31T15:02:53}', '{insert:26,update:4,fail:0}', '2024-04-01 19:23:25', 41837);
INSERT INTO `erp_shop_pull_logs` VALUES (1774767536929636354, 1, 1, 'ORDER', '主动拉取', '{startTime:2024-03-30T23:02:53,endTime:2024-03-31T23:02:53}', '{insert:0,update:29,fail:2}', '2024-04-01 19:53:48', 101220);
INSERT INTO `erp_shop_pull_logs` VALUES (1774769574707183617, 1, 1, 'ORDER', '主动拉取', '{startTime:2024-03-31T22:02:53,endTime:2024-04-01T20:03:24.419567600}', '{insert:16,update:0,fail:2}', '2024-04-01 20:03:24', 10733);
INSERT INTO `erp_shop_pull_logs` VALUES (1774775846177284098, 2, 2, 'ORDER', '主动拉取', '{startTime:2024-03-31T07:59:58,endTime:2024-04-01T07:59:58}', '{insertSuccess:0,hasExistOrder:0,totalError:18}', '2024-04-01 20:28:21', 9622);
INSERT INTO `erp_shop_pull_logs` VALUES (1774776246171250689, 2, 2, 'ORDER', '主动拉取', '{startTime:2024-04-01T06:59:58,endTime:2024-04-01T20:30:03.390426800}', '{insertSuccess:0,hasExistOrder:0,totalError:29}', '2024-04-01 20:30:03', 2281);
INSERT INTO `erp_shop_pull_logs` VALUES (1774776521405673473, 2, 2, 'ORDER', '主动拉取', '{startTime:2024-04-01T19:30:03,endTime:2024-04-01T20:30:39.555646}', '{insertSuccess:0,hasExistOrder:0,totalError:1}', '2024-04-01 20:30:40', 31565);
INSERT INTO `erp_shop_pull_logs` VALUES (1774777121220485121, 2, 2, 'ORDER', '主动拉取', '{startTime:2024-04-01T19:30:40,endTime:2024-04-01T20:33:33.074052300}', '{insertSuccess:1,hasExistOrder:0,totalError:0}', '2024-04-01 20:33:33', 1173);
INSERT INTO `erp_shop_pull_logs` VALUES (1774777706028097537, 2, 2, 'ORDER', '主动拉取', '{startTime:2024-03-31T00:33:33,endTime:2024-04-01T00:33:33}', '{insertSuccess:17,hasExistOrder:0,totalError:0}', '2024-04-01 20:35:53', 1037);
INSERT INTO `erp_shop_pull_logs` VALUES (1775086019864023041, 1, 1, 'ORDER', '主动拉取', '{startTime:2024-04-01T19:03:24,endTime:2024-04-02T16:59:29.818708500}', '{insert:28,update:3,fail:1}', '2024-04-02 16:59:30', 91604);
INSERT INTO `erp_shop_pull_logs` VALUES (1776459777702916098, 1, 1, 'ORDER', '主动拉取', '{startTime:2024-04-02T15:59:30,endTime:2024-04-03T15:59:30}', '{insert:10,update:3,fail:0}', '2024-04-06 11:59:47', 3669);
INSERT INTO `erp_shop_pull_logs` VALUES (1776506026682490881, 1, 1, 'REFUND', '主动拉取', '{startTime:2024-03-24T12:03:50,endTime:2024-03-25T12:03:50}', '{insert:4,update:0,fail:0}', '2024-04-06 15:03:36', 942);
INSERT INTO `erp_shop_pull_logs` VALUES (1776506535749361665, 1, 1, 'REFUND', '主动拉取', '{startTime:2024-03-25T11:03:50,endTime:2024-03-26T11:03:50}', '{insert:15,update:1,fail:0}', '2024-04-06 15:05:36', 2724);
INSERT INTO `erp_shop_pull_logs` VALUES (1776508693022527489, 1, 1, 'REFUND', '主动拉取', '{startTime:2024-03-26T10:03:50,endTime:2024-03-27T10:03:50}', '{insert:3,update:0,fail:0}', '2024-04-06 15:11:46', 146852);
INSERT INTO `erp_shop_pull_logs` VALUES (1776513990025854977, 1, 1, 'REFUND', '主动拉取', '{startTime:2024-03-27T09:03:50,endTime:2024-03-28T09:03:50}', '{insert:14,update:0,fail:0}', '2024-04-06 15:35:13', 2860);
INSERT INTO `erp_shop_pull_logs` VALUES (1778341762576093185, 1, 1, 'ORDER', '主动拉取', '{startTime:2024-04-03T14:59:30,endTime:2024-04-04T14:59:30}', '{insert:14,update:4,fail:0}', '2024-04-11 16:34:41', 209606);
INSERT INTO `erp_shop_pull_logs` VALUES (1778342150444355585, 1, 1, 'ORDER', '主动拉取', '{startTime:2024-04-04T13:59:30,endTime:2024-04-05T13:59:30}', '{insert:12,update:0,fail:0}', '2024-04-11 16:38:30', 73180);
INSERT INTO `erp_shop_pull_logs` VALUES (1778342898620108802, 1, 1, 'ORDER', '主动拉取', '{startTime:2024-04-05T12:59:30,endTime:2024-04-06T12:59:30}', '{insert:6,update:0,fail:0}', '2024-04-11 16:39:54', 167361);

-- ----------------------------
-- Table structure for erp_shop_refund
-- ----------------------------
DROP TABLE IF EXISTS `erp_shop_refund`;
CREATE TABLE `erp_shop_refund`  (
  `id` bigint NOT NULL,
  `shop_id` int NULL DEFAULT NULL COMMENT '店铺id',
  `after_sale_order_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '售后单号',
  `status` varchar(55) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '售后单当前状态，参考：AfterSaleStatus',
  `openid` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '买家身份标识',
  `unionid` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '买家在开放平台的唯一标识符，若当前视频号小店已绑定到微信开放平台账号下会返回',
  `product_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品spuid',
  `sku_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品skuid',
  `count` int NULL DEFAULT NULL COMMENT '售后数量',
  `fast_refund` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否极速退款RefundInfo',
  `refund_reason` int NULL DEFAULT NULL COMMENT '标明售后单退款直接原因, 枚举值参考 RefundReason',
  `refund_amount` int NULL DEFAULT NULL COMMENT '退款金额（分）',
  `return_waybill_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '快递单号',
  `return_delivery_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '物流公司id',
  `return_delivery_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '物流公司名称',
  `merchant_upload_info` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '售后相关商品信息JSON',
  `create_time` int NULL DEFAULT NULL COMMENT '售后单创建时间戳',
  `update_time` int NULL DEFAULT NULL COMMENT '售后单更新时间戳',
  `reason` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '退款原因',
  `reason_text` varchar(2550) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '退款原因解释',
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '售后类型。REFUND:退款；RETURN:退货退款。',
  `order_id` varchar(55) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '订单号，该字段可用于获取订单',
  `details` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT 'detail json',
  `complaint_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '纠纷id，该字段可用于获取纠纷信息',
  `refund_resp` varchar(2550) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '微信支付退款的响应',
  `confirm_status` int NULL DEFAULT NULL COMMENT '确认状态9退货已签收8已拦截',
  `confirm_time` datetime NULL DEFAULT NULL COMMENT '确认时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '视频号小店退款' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of erp_shop_refund
-- ----------------------------

-- ----------------------------
-- Table structure for erp_supplier
-- ----------------------------
DROP TABLE IF EXISTS `erp_supplier`;
CREATE TABLE `erp_supplier`  (
  `id` bigint NOT NULL,
  `tenant_id` bigint NOT NULL COMMENT '租户id',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '供应商名称',
  `number` varchar(18) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '供应商编码',
  `tax_rate` double NULL DEFAULT 0 COMMENT '税率',
  `amount` double NULL DEFAULT 0 COMMENT '期初应付款',
  `period_money` double NULL DEFAULT 0 COMMENT '期初预付款',
  `dif_money` double NULL DEFAULT 0 COMMENT '初期往来余额',
  `begin_date` date NULL DEFAULT NULL COMMENT '余额日期',
  `remark` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注',
  `place` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '职位',
  `contact_man` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '联系人',
  `contact` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '联系方式',
  `province` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '省',
  `city` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '市',
  `county` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '区县',
  `address` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '收货地址详情',
  `pinYin` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '',
  `disable` tinyint(1) NULL DEFAULT 0 COMMENT '1启用   0禁用',
  `is_delete` tinyint(1) NULL DEFAULT 0 COMMENT '0正常 1删除',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `create_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `update_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `id`(`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of erp_supplier
-- ----------------------------
INSERT INTO `erp_supplier` VALUES (1, 0, '自营仓库', 'A0001', 0, 0, 0, 0, NULL, '', '', NULL, '15000000000', NULL, NULL, NULL, NULL, '', 0, 0, '2023-12-29 11:01:02', NULL, NULL, NULL);
INSERT INTO `erp_supplier` VALUES (13, 0, '可可家一号店', '6972501884875', 0, 0, 0, 0, NULL, '', '', NULL, '15815252000', NULL, NULL, NULL, NULL, '', 1, 1, '2023-12-29 11:01:03', NULL, NULL, NULL);
INSERT INTO `erp_supplier` VALUES (14, 0, '衫人家', '6972501884876', 0, 0, 0, 0, NULL, '', '', NULL, '15815252000', NULL, NULL, NULL, NULL, '', 1, 1, '2023-12-29 11:01:03', NULL, NULL, NULL);
INSERT INTO `erp_supplier` VALUES (15, 0, '依依', 'ZB001', 0, 0, 0, 0, NULL, '', '', NULL, '13000000000', NULL, NULL, NULL, NULL, '', 0, 0, '2023-12-29 11:01:03', NULL, NULL, NULL);
INSERT INTO `erp_supplier` VALUES (16, 0, '念念', 'ZB002', 0, 0, 0, 0, NULL, '', '', NULL, '13000000000', NULL, NULL, NULL, NULL, '', 0, 0, '2023-12-29 11:01:03', NULL, NULL, NULL);
INSERT INTO `erp_supplier` VALUES (17, 0, '华衣服饰', 'ZB003', 0, 0, 0, 0, NULL, '', '', NULL, '13000000000', NULL, NULL, NULL, NULL, '', 0, 0, '2023-12-29 11:01:03', NULL, NULL, NULL);
INSERT INTO `erp_supplier` VALUES (18, 0, '小颖家', 'ZB004', 0, 0, 0, 0, NULL, '', '', NULL, '13000000000', NULL, NULL, NULL, NULL, '', 0, 0, '2023-12-29 11:01:03', NULL, NULL, NULL);
INSERT INTO `erp_supplier` VALUES (19, 0, '森庄农品旗舰店', 'TM-SZNPQJD', 0, 0, 0, 0, NULL, '', '', NULL, '13600000000', NULL, NULL, NULL, NULL, '', 1, 1, '2023-12-29 11:01:03', NULL, NULL, NULL);
INSERT INTO `erp_supplier` VALUES (20, 0, '小仙', 'XFZ001', 0, 0, 0, 0, NULL, '', '', NULL, '18516258530', '上海', '上海市', '松江区', '上海市松江区中山街道松江万达广场一号楼417', '', 0, 0, '2023-12-29 11:01:03', NULL, NULL, NULL);
INSERT INTO `erp_supplier` VALUES (21, 0, '岳鑫', '', 0, 0, 0, 0, NULL, '', '', NULL, '15081033273', '河北省', '邯郸市', '黄粱梦镇', '河北省 邯郸市 丛台区 黄粱梦镇黄粱梦村', '', 0, 0, '2023-12-29 11:01:03', NULL, NULL, NULL);
INSERT INTO `erp_supplier` VALUES (22, 0, '三夫食品专营店', 'SFSP', 0, 0, 0, 0, NULL, '', '', NULL, '13600000000', NULL, NULL, NULL, NULL, '', 1, 1, '2023-12-29 11:01:03', NULL, NULL, NULL);
INSERT INTO `erp_supplier` VALUES (23, 0, '安琪酵母旗舰店', 'ANQIJM', 0, 0, 0, 0, NULL, '', '', NULL, '13600000000', NULL, NULL, NULL, NULL, '', 1, 1, '2023-12-29 11:01:03', NULL, NULL, NULL);
INSERT INTO `erp_supplier` VALUES (24, 0, '慈溪市观海卫滕洋电器厂', '1688', 0, 0, 0, 0, NULL, '', '', NULL, '13000001111', NULL, NULL, NULL, NULL, '', 1, 1, '2023-12-29 11:01:03', NULL, NULL, NULL);
INSERT INTO `erp_supplier` VALUES (25, 0, '小熊驾到旗舰店', 'XXJD', 0, 0, 0, 0, NULL, '', '', NULL, '13600000000', NULL, NULL, NULL, NULL, '', 1, 1, '2023-12-29 11:01:03', NULL, NULL, NULL);
INSERT INTO `erp_supplier` VALUES (26, 0, '韩牛服饰', 'HN', 0, 0, 0, 0, NULL, '', '', NULL, '13249571426', NULL, NULL, NULL, NULL, '', 0, 0, '2023-12-29 11:01:03', NULL, NULL, NULL);
INSERT INTO `erp_supplier` VALUES (27, 0, '深圳市罗湖区晨蝶衣服装厂', 'CDYFZC', 0, 0, 0, 0, NULL, '', '', NULL, '13600000000', NULL, NULL, NULL, NULL, '', 1, 1, '2023-12-29 11:01:03', NULL, NULL, NULL);
INSERT INTO `erp_supplier` VALUES (28, 0, '广州衣菲妮服装厂', 'YIFEINI', 0, 0, 0, 0, NULL, '', '', NULL, '13600000000', NULL, NULL, NULL, NULL, '', 1, 1, '2023-12-29 11:01:03', NULL, NULL, NULL);
INSERT INTO `erp_supplier` VALUES (29, 0, '中山欧熙妮服饰有限公司', 'ZSOXNFS', 0, 0, 0, 0, NULL, '', '', NULL, '13600000000', NULL, NULL, NULL, NULL, '', 0, 0, '2023-12-29 11:01:03', NULL, NULL, NULL);
INSERT INTO `erp_supplier` VALUES (30, 0, '零零伊', NULL, 0, 0, 0, 0, NULL, '', '抖音', NULL, 'fsd1027', NULL, NULL, NULL, '', '', 0, 0, '2023-12-29 11:01:03', NULL, NULL, NULL);
INSERT INTO `erp_supplier` VALUES (31, 0, '中山市金客隆服饰有限公司', 'JKL', 0, 0, 0, 0, NULL, '', '', NULL, '13600000000', NULL, NULL, NULL, NULL, '', 0, 0, '2023-12-29 11:01:04', NULL, NULL, NULL);
INSERT INTO `erp_supplier` VALUES (32, 0, '广州柚柚子服饰商行', 'GZYYZ', 0, 0, 0, 0, NULL, '', '', NULL, '18557527708', NULL, NULL, NULL, NULL, '', 0, 0, '2023-12-29 11:01:04', NULL, NULL, NULL);
INSERT INTO `erp_supplier` VALUES (33, 0, '中山裤豪', 'ZSKH', 0, 0, 0, 0, NULL, '档口微信18928102400陈小姐工厂微信18022115438何超贤 ', '', NULL, '18928102400', NULL, NULL, NULL, '中山市沙溪镇水牛城三区二楼35-38卡', '', 0, 0, '2023-12-29 11:01:04', NULL, NULL, NULL);
INSERT INTO `erp_supplier` VALUES (1781960910751948802, 100, '账单122', 'AD23', 0, 0, 0, 0, NULL, '', '', '启航', '154855545', NULL, NULL, NULL, NULL, '', 1, 0, '2024-04-21 16:19:23', '手动添加', '2024-04-21 16:26:45', '手动更新');

-- ----------------------------
-- Table structure for erp_supplier_agent_shipping
-- ----------------------------
DROP TABLE IF EXISTS `erp_supplier_agent_shipping`;
CREATE TABLE `erp_supplier_agent_shipping`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `shop_id` int NOT NULL COMMENT '店铺ID',
  `shop_type` int NOT NULL COMMENT '店铺平台',
  `supplier_id` int NOT NULL COMMENT '供应商ID',
  `erp_order_id` bigint NOT NULL COMMENT 'erp订单ID',
  `erp_order_item_id` bigint NOT NULL COMMENT '子订单ID',
  `order_num` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '订单编号',
  `order_date` datetime NOT NULL COMMENT '订单日期',
  `goods_id` bigint NOT NULL DEFAULT 0 COMMENT 'erp系统商品id',
  `spec_id` bigint NOT NULL DEFAULT 0 COMMENT 'erp系统商品规格id',
  `goods_title` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '商品标题',
  `goods_img` varchar(300) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '商品图片',
  `goods_num` varchar(35) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '商品编码',
  `goods_spec` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '商品规格',
  `spec_num` varchar(35) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '商品规格编码',
  `goods_price` double NOT NULL COMMENT '商品单价',
  `quantity` int NOT NULL COMMENT '商品数量',
  `item_amount` double NULL DEFAULT NULL COMMENT '子订单金额',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '说明',
  `ship_company` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '物流公司',
  `ship_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '物流单号',
  `ship_cost` decimal(6, 0) NULL DEFAULT NULL COMMENT '运费',
  `ship_time` datetime NULL DEFAULT NULL COMMENT '运送时间',
  `status` int NULL DEFAULT NULL COMMENT '状态（0未发货1已发货2已结算）',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `create_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `update_by` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '供应商代发货表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of erp_supplier_agent_shipping
-- ----------------------------
INSERT INTO `erp_supplier_agent_shipping` VALUES (1, 6, 4, 26, 17, 14, '1635222253871665598', '2022-08-05 18:48:51', 9, 40, '8026牛仔短裤', 'https://cbu01.alicdn.com/img/ibank/O1CN01PHFmsX2FOyB14fPie_!!2208857268871-0-cib.jpg', '272021008026', '浅蓝色,L', '2720210080260303', 16, 1, 29.92, NULL, '菜鸟速递', 'CN52500021', 2, '2024-01-28 00:00:00', 1, '2024-01-28 19:55:37', 'admin', 'admin', '2024-01-28 21:06:44');

-- ----------------------------
-- Table structure for fms_payable_agent_ship
-- ----------------------------
DROP TABLE IF EXISTS `fms_payable_agent_ship`;
CREATE TABLE `fms_payable_agent_ship`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `order_num` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '订单号',
  `shop_id` int NOT NULL COMMENT '店铺id',
  `supplier_id` int NOT NULL COMMENT '供应商id',
  `supplier_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '供应商名称',
  `date` date NOT NULL COMMENT '日期',
  `ship_company` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '物流公司',
  `ship_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '物流单号',
  `amount` decimal(10, 2) NOT NULL COMMENT '应付总金额',
  `ship_amount` decimal(5, 2) NOT NULL COMMENT '物流费用',
  `goods_amount` decimal(10, 2) NOT NULL COMMENT '商品金额',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `status` int NOT NULL COMMENT '状态（0已生成1已结算)',
  `create_time` datetime NULL DEFAULT NULL COMMENT '订单创建时间',
  `create_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `update_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '财务管理-应付款-代发账单' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of fms_payable_agent_ship
-- ----------------------------
INSERT INTO `fms_payable_agent_ship` VALUES (2, '1635222253871665598', 6, 26, '韩牛服饰', '2024-01-28', '菜鸟速递', 'CN52500021', 17.00, 2.00, 15.00, NULL, 0, '2024-01-28 21:06:44', 'admin', NULL, NULL);

-- ----------------------------
-- Table structure for fms_payable_ship_fee
-- ----------------------------
DROP TABLE IF EXISTS `fms_payable_ship_fee`;
CREATE TABLE `fms_payable_ship_fee`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `logistics_company` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '物流公司',
  `logistics_company_id` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '物流公司id',
  `logistics_num` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '物流单号',
  `order_num` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '订单号',
  `shop_id` int NULL DEFAULT NULL COMMENT '店铺id',
  `amount` decimal(10, 2) NOT NULL COMMENT '应付金额',
  `date` date NOT NULL COMMENT '应付日期',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `status` int NOT NULL COMMENT '状态（0已生成1已结算)',
  `create_time` datetime NULL DEFAULT NULL COMMENT '订单创建时间',
  `create_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `update_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '更新人',
  `length` float NULL DEFAULT 0 COMMENT '长',
  `width` float NULL DEFAULT 0 COMMENT '宽',
  `height` float NULL DEFAULT 0 COMMENT '高',
  `weight` float NULL DEFAULT NULL COMMENT '重量',
  `receiver_name` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '收件人姓名',
  `receiver_phone` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '收件人手机号',
  `province` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '省',
  `city` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '市',
  `town` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '区',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '财务管理-应付款-物流费用' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of fms_payable_ship_fee
-- ----------------------------
INSERT INTO `fms_payable_ship_fee` VALUES (1, '33', '中山裤豪', '', 'PUR20240128113656', NULL, 52.00, '2024-01-28', NULL, 0, '2024-01-28 12:07:32', 'admin', NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for scm_purchase_contract
-- ----------------------------
DROP TABLE IF EXISTS `scm_purchase_contract`;
CREATE TABLE `scm_purchase_contract`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `contact_id` bigint NULL DEFAULT NULL COMMENT '供应商id',
  `bill_no` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '单据编号',
  `contractNo` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `billDate` date NULL DEFAULT NULL COMMENT '单据日期',
  `userId` smallint NULL DEFAULT 0 COMMENT '制单人id',
  `userName` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '制单人',
  `transType` char(15) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '0' COMMENT '交易类型:BUY购货 BUYR退货 SALE销售 SALER退销 OTHER其他入库',
  `transTypeName` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '交易类型名称',
  `totalAmount` decimal(10, 2) NULL DEFAULT NULL COMMENT '购货总金额',
  `disRate` double NULL DEFAULT 0 COMMENT '整单折扣率',
  `disAmount` double NULL DEFAULT 0 COMMENT '整单折扣金额',
  `amount` double NULL DEFAULT 0 COMMENT '折扣后金额',
  `totalDiscount` double NULL DEFAULT 0 COMMENT '总折扣（计算商品折扣和整单折扣之和）',
  `totalQuantity` bigint NULL DEFAULT 0 COMMENT '总数量',
  `qualifiedQuantity` bigint NULL DEFAULT 0 COMMENT '合格数量',
  `inQuantity` bigint NULL DEFAULT 0 COMMENT '已入库数量(已出库数量)',
  `rpAmount` double NULL DEFAULT 0 COMMENT '本次付款',
  `arrears` double NULL DEFAULT 0 COMMENT '本次欠款',
  `freight` double NULL DEFAULT 0 COMMENT '运费',
  `description` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '备注',
  `billType` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT 'PO采购订单 OI其他入库 PUR采购入库 BAL初期余额',
  `billStatus` tinyint(1) NULL DEFAULT 0 COMMENT '订单状态 0待审核1正常2已作废3已入库 11已验货',
  `isDelete` tinyint(1) NULL DEFAULT 0 COMMENT '1删除  0正常',
  `checkName` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '采购单审核人',
  `checked` tinyint(1) NULL DEFAULT 0 COMMENT '采购单审核状态0待审核1已审核',
  `createTime` bigint NULL DEFAULT NULL COMMENT '创建时间',
  `modifyTime` bigint NULL DEFAULT NULL COMMENT '更新时间',
  `salesId` smallint NULL DEFAULT NULL,
  `customerFree` double NULL DEFAULT 0 COMMENT '客户承担费用',
  `hxStateCode` tinyint NULL DEFAULT 0 COMMENT '核销状态 0未付款  1部分付款  2全部付款',
  `hxAmount` double NULL DEFAULT 0 COMMENT '本次核销金额',
  `payment` double NULL DEFAULT 0 COMMENT '本次预收款',
  `srcOrderNo` varchar(1000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '订单编号',
  `srcOrderId` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '订单id',
  `logisticsNo` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '快递物流单号（）',
  `logisticsCompany` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '物流公司',
  `logisticsCompanyCode` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '物流公司代码',
  `logisticsNumber` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '物流单号',
  `locationId` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '仓库id多个,分割',
  `inLocationId` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '调入仓库ID多个,分割',
  `outLocationId` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '调出仓库ID多个,分割',
  `serialno` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '序列号',
  `checkoutName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '检验人',
  `checkoutTime` bigint NULL DEFAULT 0 COMMENT '检验时间',
  `checkoutStatus` int NULL DEFAULT 0 COMMENT '0 未检验  1已检验',
  `qualifiedStatus` int NULL DEFAULT 0 COMMENT '0为合格数量为0,1为合格数量不为0',
  `stockInName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '入库人',
  `stockInTime` bigint NULL DEFAULT 0 COMMENT '入库时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '采购单' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of scm_purchase_contract
-- ----------------------------

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept`  (
  `dept_id` bigint NOT NULL AUTO_INCREMENT COMMENT '部门id',
  `parent_id` bigint NULL DEFAULT 0 COMMENT '父部门id',
  `ancestors` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '祖级列表',
  `dept_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '部门名称',
  `order_num` int NULL DEFAULT 0 COMMENT '显示顺序',
  `leader` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '负责人',
  `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '联系电话',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '部门状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`dept_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 200 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '部门表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES (100, 0, '0', '至简科技', 0, '至简', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2023-08-07 19:31:37', '', NULL);
INSERT INTO `sys_dept` VALUES (101, 100, '0,100', '深圳总公司', 1, '至简', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2023-08-07 19:31:37', '', NULL);
INSERT INTO `sys_dept` VALUES (102, 100, '0,100', '长沙分公司', 2, '至简', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2023-08-07 19:31:37', '', NULL);
INSERT INTO `sys_dept` VALUES (103, 101, '0,100,101', '研发部门', 1, '至简', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2023-08-07 19:31:37', '', NULL);
INSERT INTO `sys_dept` VALUES (104, 101, '0,100,101', '市场部门', 2, '至简', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2023-08-07 19:31:37', '', NULL);
INSERT INTO `sys_dept` VALUES (105, 101, '0,100,101', '测试部门', 3, '至简', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2023-08-07 19:31:37', '', NULL);
INSERT INTO `sys_dept` VALUES (106, 101, '0,100,101', '财务部门', 4, '至简', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2023-08-07 19:31:37', '', NULL);
INSERT INTO `sys_dept` VALUES (107, 101, '0,100,101', '运维部门', 5, '至简', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2023-08-07 19:31:37', '', NULL);
INSERT INTO `sys_dept` VALUES (108, 102, '0,100,102', '市场部门', 1, '至简', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2023-08-07 19:31:37', '', NULL);
INSERT INTO `sys_dept` VALUES (109, 102, '0,100,102', '财务部门', 2, '至简', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2023-08-07 19:31:37', '', NULL);

-- ----------------------------
-- Table structure for sys_dict_data
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_data`;
CREATE TABLE `sys_dict_data`  (
  `dict_code` bigint NOT NULL AUTO_INCREMENT COMMENT '字典编码',
  `dict_sort` int NULL DEFAULT 0 COMMENT '字典排序',
  `dict_label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典标签',
  `dict_value` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典键值',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典类型',
  `css_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
  `list_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '表格回显样式',
  `is_default` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'N' COMMENT '是否默认（Y是 N否）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '字典数据表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_dict_data
-- ----------------------------
INSERT INTO `sys_dict_data` VALUES (1, 1, '男', '0', 'sys_user_sex', '', '', 'Y', '0', 'admin', '2023-08-07 19:31:38', '', NULL, '性别男');
INSERT INTO `sys_dict_data` VALUES (2, 2, '女', '1', 'sys_user_sex', '', '', 'N', '0', 'admin', '2023-08-07 19:31:38', '', NULL, '性别女');
INSERT INTO `sys_dict_data` VALUES (3, 3, '未知', '2', 'sys_user_sex', '', '', 'N', '0', 'admin', '2023-08-07 19:31:38', '', NULL, '性别未知');
INSERT INTO `sys_dict_data` VALUES (4, 1, '显示', '0', 'sys_show_hide', '', 'primary', 'Y', '0', 'admin', '2023-08-07 19:31:38', '', NULL, '显示菜单');
INSERT INTO `sys_dict_data` VALUES (5, 2, '隐藏', '1', 'sys_show_hide', '', 'danger', 'N', '0', 'admin', '2023-08-07 19:31:38', '', NULL, '隐藏菜单');
INSERT INTO `sys_dict_data` VALUES (6, 1, '正常', '0', 'sys_normal_disable', '', 'primary', 'Y', '0', 'admin', '2023-08-07 19:31:38', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (7, 2, '停用', '1', 'sys_normal_disable', '', 'danger', 'N', '0', 'admin', '2023-08-07 19:31:38', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (8, 1, '正常', '0', 'sys_job_status', '', 'primary', 'Y', '0', 'admin', '2023-08-07 19:31:38', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (9, 2, '暂停', '1', 'sys_job_status', '', 'danger', 'N', '0', 'admin', '2023-08-07 19:31:38', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (10, 1, '默认', 'DEFAULT', 'sys_job_group', '', '', 'Y', '0', 'admin', '2023-08-07 19:31:38', '', NULL, '默认分组');
INSERT INTO `sys_dict_data` VALUES (11, 2, '系统', 'SYSTEM', 'sys_job_group', '', '', 'N', '0', 'admin', '2023-08-07 19:31:38', '', NULL, '系统分组');
INSERT INTO `sys_dict_data` VALUES (12, 1, '是', 'Y', 'sys_yes_no', '', 'primary', 'Y', '0', 'admin', '2023-08-07 19:31:38', '', NULL, '系统默认是');
INSERT INTO `sys_dict_data` VALUES (13, 2, '否', 'N', 'sys_yes_no', '', 'danger', 'N', '0', 'admin', '2023-08-07 19:31:38', '', NULL, '系统默认否');
INSERT INTO `sys_dict_data` VALUES (14, 1, '通知', '1', 'sys_notice_type', '', 'warning', 'Y', '0', 'admin', '2023-08-07 19:31:38', '', NULL, '通知');
INSERT INTO `sys_dict_data` VALUES (15, 2, '公告', '2', 'sys_notice_type', '', 'success', 'N', '0', 'admin', '2023-08-07 19:31:38', '', NULL, '公告');
INSERT INTO `sys_dict_data` VALUES (16, 1, '正常', '0', 'sys_notice_status', '', 'primary', 'Y', '0', 'admin', '2023-08-07 19:31:38', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (17, 2, '关闭', '1', 'sys_notice_status', '', 'danger', 'N', '0', 'admin', '2023-08-07 19:31:38', '', NULL, '关闭状态');
INSERT INTO `sys_dict_data` VALUES (18, 99, '其他', '0', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2023-08-07 19:31:38', '', NULL, '其他操作');
INSERT INTO `sys_dict_data` VALUES (19, 1, '新增', '1', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2023-08-07 19:31:38', '', NULL, '新增操作');
INSERT INTO `sys_dict_data` VALUES (20, 2, '修改', '2', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2023-08-07 19:31:38', '', NULL, '修改操作');
INSERT INTO `sys_dict_data` VALUES (21, 3, '删除', '3', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2023-08-07 19:31:38', '', NULL, '删除操作');
INSERT INTO `sys_dict_data` VALUES (22, 4, '授权', '4', 'sys_oper_type', '', 'primary', 'N', '0', 'admin', '2023-08-07 19:31:38', '', NULL, '授权操作');
INSERT INTO `sys_dict_data` VALUES (23, 5, '导出', '5', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2023-08-07 19:31:38', '', NULL, '导出操作');
INSERT INTO `sys_dict_data` VALUES (24, 6, '导入', '6', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2023-08-07 19:31:38', '', NULL, '导入操作');
INSERT INTO `sys_dict_data` VALUES (25, 7, '强退', '7', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2023-08-07 19:31:38', '', NULL, '强退操作');
INSERT INTO `sys_dict_data` VALUES (26, 8, '生成代码', '8', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2023-08-07 19:31:38', '', NULL, '生成操作');
INSERT INTO `sys_dict_data` VALUES (27, 9, '清空数据', '9', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2023-08-07 19:31:38', '', NULL, '清空操作');
INSERT INTO `sys_dict_data` VALUES (28, 1, '成功', '0', 'sys_common_status', '', 'primary', 'N', '0', 'admin', '2023-08-07 19:31:38', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (29, 2, '失败', '1', 'sys_common_status', '', 'danger', 'N', '0', 'admin', '2023-08-07 19:31:38', '', NULL, '停用状态');

-- ----------------------------
-- Table structure for sys_dict_type
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_type`;
CREATE TABLE `sys_dict_type`  (
  `dict_id` bigint NOT NULL AUTO_INCREMENT COMMENT '字典主键',
  `dict_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典名称',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典类型',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_id`) USING BTREE,
  UNIQUE INDEX `dict_type`(`dict_type`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '字典类型表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_dict_type
-- ----------------------------
INSERT INTO `sys_dict_type` VALUES (1, '用户性别', 'sys_user_sex', '0', 'admin', '2023-08-07 19:31:38', '', NULL, '用户性别列表');
INSERT INTO `sys_dict_type` VALUES (2, '菜单状态', 'sys_show_hide', '0', 'admin', '2023-08-07 19:31:38', '', NULL, '菜单状态列表');
INSERT INTO `sys_dict_type` VALUES (3, '系统开关', 'sys_normal_disable', '0', 'admin', '2023-08-07 19:31:38', '', NULL, '系统开关列表');
INSERT INTO `sys_dict_type` VALUES (4, '任务状态', 'sys_job_status', '0', 'admin', '2023-08-07 19:31:38', '', NULL, '任务状态列表');
INSERT INTO `sys_dict_type` VALUES (5, '任务分组', 'sys_job_group', '0', 'admin', '2023-08-07 19:31:38', '', NULL, '任务分组列表');
INSERT INTO `sys_dict_type` VALUES (6, '系统是否', 'sys_yes_no', '0', 'admin', '2023-08-07 19:31:38', '', NULL, '系统是否列表');
INSERT INTO `sys_dict_type` VALUES (7, '通知类型', 'sys_notice_type', '0', 'admin', '2023-08-07 19:31:38', '', NULL, '通知类型列表');
INSERT INTO `sys_dict_type` VALUES (8, '通知状态', 'sys_notice_status', '0', 'admin', '2023-08-07 19:31:38', '', NULL, '通知状态列表');
INSERT INTO `sys_dict_type` VALUES (9, '操作类型', 'sys_oper_type', '0', 'admin', '2023-08-07 19:31:38', '', NULL, '操作类型列表');
INSERT INTO `sys_dict_type` VALUES (10, '系统状态', 'sys_common_status', '0', 'admin', '2023-08-07 19:31:38', '', NULL, '登录状态列表');

-- ----------------------------
-- Table structure for sys_logininfor
-- ----------------------------
DROP TABLE IF EXISTS `sys_logininfor`;
CREATE TABLE `sys_logininfor`  (
  `info_id` bigint NOT NULL AUTO_INCREMENT COMMENT '访问ID',
  `user_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '用户账号',
  `ipaddr` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '登录IP地址',
  `login_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '登录地点',
  `browser` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '浏览器类型',
  `os` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '操作系统',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '登录状态（0成功 1失败）',
  `msg` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '提示消息',
  `login_time` datetime NULL DEFAULT NULL COMMENT '访问时间',
  PRIMARY KEY (`info_id`) USING BTREE,
  INDEX `idx_sys_logininfor_s`(`status`) USING BTREE,
  INDEX `idx_sys_logininfor_lt`(`login_time`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 43 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '系统访问记录' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_logininfor
-- ----------------------------
INSERT INTO `sys_logininfor` VALUES (1, 'admin', '127.0.0.1', '内网IP', 'Chrome 11', 'Windows 10', '0', '登录成功', '2024-01-13 19:29:08');
INSERT INTO `sys_logininfor` VALUES (2, 'admin', '127.0.0.1', '内网IP', 'Chrome 11', 'Windows 10', '0', '登录成功', '2024-01-13 20:22:02');
INSERT INTO `sys_logininfor` VALUES (3, 'admin', '127.0.0.1', '内网IP', 'Chrome 11', 'Windows 10', '0', '登录成功', '2024-01-13 22:30:52');
INSERT INTO `sys_logininfor` VALUES (4, 'admin', '127.0.0.1', '内网IP', 'Chrome 11', 'Windows 10', '0', '登录成功', '2024-01-14 00:01:24');
INSERT INTO `sys_logininfor` VALUES (5, 'admin', '127.0.0.1', '内网IP', 'Chrome 11', 'Windows 10', '0', '登录成功', '2024-01-14 10:00:50');
INSERT INTO `sys_logininfor` VALUES (6, 'admin', '127.0.0.1', '内网IP', 'Chrome 11', 'Windows 10', '0', '登录成功', '2024-01-14 11:05:33');
INSERT INTO `sys_logininfor` VALUES (7, 'admin', '127.0.0.1', '内网IP', 'Chrome 11', 'Windows 10', '0', '登录成功', '2024-01-14 11:57:27');
INSERT INTO `sys_logininfor` VALUES (8, 'admin', '127.0.0.1', '内网IP', 'Chrome 11', 'Windows 10', '0', '登录成功', '2024-01-14 12:57:19');
INSERT INTO `sys_logininfor` VALUES (9, 'admin', '127.0.0.1', '内网IP', 'Chrome 11', 'Windows 10', '0', '登录成功', '2024-01-14 14:52:13');
INSERT INTO `sys_logininfor` VALUES (10, 'admin', '127.0.0.1', '内网IP', 'Chrome 11', 'Windows 10', '0', '登录成功', '2024-01-14 16:15:12');
INSERT INTO `sys_logininfor` VALUES (11, 'admin', '127.0.0.1', '内网IP', 'Chrome 11', 'Windows 10', '0', '登录成功', '2024-01-14 18:51:18');
INSERT INTO `sys_logininfor` VALUES (12, 'admin', '127.0.0.1', '内网IP', 'Chrome 11', 'Windows 10', '0', '登录成功', '2024-01-15 11:38:23');
INSERT INTO `sys_logininfor` VALUES (13, 'admin', '127.0.0.1', '内网IP', 'Chrome 11', 'Windows 10', '0', '登录成功', '2024-01-15 14:35:52');
INSERT INTO `sys_logininfor` VALUES (14, 'admin', '127.0.0.1', '内网IP', 'Chrome 11', 'Windows 10', '0', '登录成功', '2024-01-15 18:32:32');
INSERT INTO `sys_logininfor` VALUES (15, 'admin', '127.0.0.1', '内网IP', 'Chrome 11', 'Windows 10', '0', '登录成功', '2024-01-15 19:02:57');
INSERT INTO `sys_logininfor` VALUES (16, 'admin', '127.0.0.1', '内网IP', 'Chrome 11', 'Windows 10', '0', '登录成功', '2024-01-15 19:45:03');
INSERT INTO `sys_logininfor` VALUES (17, 'admin', '127.0.0.1', '内网IP', 'Chrome 11', 'Windows 10', '0', '登录成功', '2024-01-15 20:38:14');
INSERT INTO `sys_logininfor` VALUES (18, 'admin', '127.0.0.1', '内网IP', 'Chrome 11', 'Windows 10', '0', '登录成功', '2024-01-15 21:13:41');
INSERT INTO `sys_logininfor` VALUES (19, 'admin', '127.0.0.1', '内网IP', 'Chrome 11', 'Windows 10', '0', '登录成功', '2024-01-16 09:11:56');
INSERT INTO `sys_logininfor` VALUES (20, 'admin', '127.0.0.1', '内网IP', 'Chrome 11', 'Windows 10', '0', '登录成功', '2024-01-16 13:42:46');
INSERT INTO `sys_logininfor` VALUES (21, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-18 17:26:16');
INSERT INTO `sys_logininfor` VALUES (22, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-18 18:56:13');
INSERT INTO `sys_logininfor` VALUES (23, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '1', 'Unable to connect to Redis; nested exception is org.springframework.data.redis.connection.PoolException: Could not get a resource from the pool; nested exception is io.lettuce.core.RedisConnectionException: Unable to connect to 127.0.0.1/<unresolved>:6379', '2024-01-19 14:23:14');
INSERT INTO `sys_logininfor` VALUES (24, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-19 14:23:48');
INSERT INTO `sys_logininfor` VALUES (25, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-19 14:35:47');
INSERT INTO `sys_logininfor` VALUES (26, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-27 20:22:04');
INSERT INTO `sys_logininfor` VALUES (27, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-27 21:01:21');
INSERT INTO `sys_logininfor` VALUES (28, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-28 11:03:32');
INSERT INTO `sys_logininfor` VALUES (29, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-28 12:38:55');
INSERT INTO `sys_logininfor` VALUES (30, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-28 13:09:27');
INSERT INTO `sys_logininfor` VALUES (31, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-28 14:33:07');
INSERT INTO `sys_logininfor` VALUES (32, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-28 19:19:58');
INSERT INTO `sys_logininfor` VALUES (33, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-17 10:09:48');
INSERT INTO `sys_logininfor` VALUES (34, 'admin', '127.0.0.1', '内网IP', 'Chrome 11', 'Windows 10', '0', '登录成功', '2024-03-17 16:50:42');
INSERT INTO `sys_logininfor` VALUES (35, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-03-18 08:22:39');
INSERT INTO `sys_logininfor` VALUES (36, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-03-18 08:42:43');
INSERT INTO `sys_logininfor` VALUES (37, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-03-18 18:29:41');
INSERT INTO `sys_logininfor` VALUES (38, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-03-24 18:44:22');
INSERT INTO `sys_logininfor` VALUES (39, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-03-24 19:30:24');
INSERT INTO `sys_logininfor` VALUES (40, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-03-24 20:26:51');
INSERT INTO `sys_logininfor` VALUES (41, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-03-24 22:49:19');
INSERT INTO `sys_logininfor` VALUES (42, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-04-01 15:37:17');

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `menu_id` bigint NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
  `menu_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '菜单名称',
  `parent_id` bigint NULL DEFAULT 0 COMMENT '父菜单ID',
  `order_num` int NULL DEFAULT 0 COMMENT '显示顺序',
  `path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '路由地址',
  `component` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '组件路径',
  `query` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '路由参数',
  `is_frame` int NULL DEFAULT 1 COMMENT '是否为外链（0是 1否）',
  `is_cache` int NULL DEFAULT 0 COMMENT '是否缓存（0缓存 1不缓存）',
  `menu_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '菜单类型（M目录 C菜单 F按钮）',
  `visible` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '菜单状态（0显示 1隐藏）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '菜单状态（0正常 1停用）',
  `perms` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '权限标识',
  `icon` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '#' COMMENT '菜单图标',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2087 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '菜单权限表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1, '系统管理', 0, 99, 'system', '', '', 1, 0, 'M', '0', '0', '', 'system', 'admin', '2023-12-27 15:00:27', 'admin', '2024-04-20 22:21:25', '系统管理目录');
INSERT INTO `sys_menu` VALUES (2, '采购管理', 0, 1, 'scm', '', '', 1, 0, 'M', '0', '0', '', 'server', 'admin', '2023-12-27 15:00:27', 'admin', '2024-04-21 10:50:57', '至简官网地址');
INSERT INTO `sys_menu` VALUES (3, '订单管理', 0, 2, 'order', '', '', 1, 0, 'M', '0', '0', '', 'shopping', 'admin', '2023-12-29 16:53:03', 'admin', '2024-04-10 11:02:32', '');
INSERT INTO `sys_menu` VALUES (4, '发货管理', 0, 3, 'ship', '', '', 1, 0, 'M', '0', '0', '', 'excel', 'admin', '2024-01-01 14:08:04', 'admin', '2024-04-10 11:10:31', '');
INSERT INTO `sys_menu` VALUES (5, '售后管理', 0, 4, 'after_sale', NULL, NULL, 1, 0, 'M', '0', '0', '', 'clipboard', 'admin', '2024-01-03 14:23:55', 'admin', '2024-04-10 11:17:29', '');
INSERT INTO `sys_menu` VALUES (6, '库存管理', 0, 5, 'wms', '', '', 1, 0, 'M', '0', '0', '', 'chart', 'admin', '2023-12-31 12:14:33', 'admin', '2024-04-21 15:12:25', '');
INSERT INTO `sys_menu` VALUES (7, '店铺管理', 0, 6, 'shop', '', '', 1, 0, 'M', '0', '0', '', 'theme', 'admin', '2023-12-29 17:07:23', 'admin', '2024-04-10 10:56:43', '');
INSERT INTO `sys_menu` VALUES (8, '商品管理', 0, 9, 'goods', '', '', 1, 0, 'M', '0', '0', '', 'theme', 'admin', '2023-12-29 13:29:44', '', '', '');
INSERT INTO `sys_menu` VALUES (100, '用户管理', 1, 1, 'user', 'system/user/index', '', 1, 0, 'C', '0', '0', 'system:user:list', 'user', 'admin', '2023-12-27 15:00:27', '', '', '用户管理菜单');
INSERT INTO `sys_menu` VALUES (101, '角色管理', 1, 2, 'role', 'system/role/index', '', 1, 0, 'C', '0', '0', 'system:role:list', 'peoples', 'admin', '2023-12-27 15:00:27', '', '', '角色管理菜单');
INSERT INTO `sys_menu` VALUES (102, '菜单管理', 1, 3, 'menu', 'system/menu/index', '', 1, 0, 'C', '0', '0', 'system:menu:list', 'tree-table', 'admin', '2023-12-27 15:00:27', '', '', '菜单管理菜单');
INSERT INTO `sys_menu` VALUES (103, '部门管理', 1, 4, 'dept', 'system/dept/index', '', 1, 0, 'C', '0', '0', 'system:dept:list', 'tree', 'admin', '2023-12-27 15:00:27', '', '', '部门管理菜单');
INSERT INTO `sys_menu` VALUES (104, '岗位管理', 1, 5, 'post', 'system/post/index', '', 1, 0, 'C', '0', '0', 'system:post:list', 'post', 'admin', '2023-12-27 15:00:27', '', '', '岗位管理菜单');
INSERT INTO `sys_menu` VALUES (105, '字典管理', 1, 6, 'dict', 'system/dict/index', '', 1, 0, 'C', '0', '0', 'system:dict:list', 'dict', 'admin', '2023-12-27 15:00:27', '', '', '字典管理菜单');
INSERT INTO `sys_menu` VALUES (1000, '用户查询', 100, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:user:query', '#', 'admin', '2023-12-27 15:00:27', '', '', '');
INSERT INTO `sys_menu` VALUES (1001, '用户新增', 100, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:user:add', '#', 'admin', '2023-12-27 15:00:27', '', '', '');
INSERT INTO `sys_menu` VALUES (1002, '用户修改', 100, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:user:edit', '#', 'admin', '2023-12-27 15:00:27', '', '', '');
INSERT INTO `sys_menu` VALUES (1003, '用户删除', 100, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:user:remove', '#', 'admin', '2023-12-27 15:00:27', '', '', '');
INSERT INTO `sys_menu` VALUES (1004, '用户导出', 100, 5, '', '', '', 1, 0, 'F', '0', '0', 'system:user:export', '#', 'admin', '2023-12-27 15:00:27', '', '', '');
INSERT INTO `sys_menu` VALUES (1005, '用户导入', 100, 6, '', '', '', 1, 0, 'F', '0', '0', 'system:user:import', '#', 'admin', '2023-12-27 15:00:27', '', '', '');
INSERT INTO `sys_menu` VALUES (1006, '重置密码', 100, 7, '', '', '', 1, 0, 'F', '0', '0', 'system:user:resetPwd', '#', 'admin', '2023-12-27 15:00:27', '', '', '');
INSERT INTO `sys_menu` VALUES (1007, '角色查询', 101, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:role:query', '#', 'admin', '2023-12-27 15:00:27', '', '', '');
INSERT INTO `sys_menu` VALUES (1008, '角色新增', 101, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:role:add', '#', 'admin', '2023-12-27 15:00:27', '', '', '');
INSERT INTO `sys_menu` VALUES (1009, '角色修改', 101, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:role:edit', '#', 'admin', '2023-12-27 15:00:27', '', '', '');
INSERT INTO `sys_menu` VALUES (1010, '角色删除', 101, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:role:remove', '#', 'admin', '2023-12-27 15:00:27', '', '', '');
INSERT INTO `sys_menu` VALUES (1011, '角色导出', 101, 5, '', '', '', 1, 0, 'F', '0', '0', 'system:role:export', '#', 'admin', '2023-12-27 15:00:27', '', '', '');
INSERT INTO `sys_menu` VALUES (1012, '菜单查询', 102, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:query', '#', 'admin', '2023-12-27 15:00:27', '', '', '');
INSERT INTO `sys_menu` VALUES (1013, '菜单新增', 102, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:add', '#', 'admin', '2023-12-27 15:00:27', '', '', '');
INSERT INTO `sys_menu` VALUES (1014, '菜单修改', 102, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:edit', '#', 'admin', '2023-12-27 15:00:27', '', '', '');
INSERT INTO `sys_menu` VALUES (1015, '菜单删除', 102, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:remove', '#', 'admin', '2023-12-27 15:00:27', '', '', '');
INSERT INTO `sys_menu` VALUES (1016, '部门查询', 103, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:query', '#', 'admin', '2023-12-27 15:00:27', '', '', '');
INSERT INTO `sys_menu` VALUES (1017, '部门新增', 103, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:add', '#', 'admin', '2023-12-27 15:00:27', '', '', '');
INSERT INTO `sys_menu` VALUES (1018, '部门修改', 103, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:edit', '#', 'admin', '2023-12-27 15:00:27', '', '', '');
INSERT INTO `sys_menu` VALUES (1019, '部门删除', 103, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:remove', '#', 'admin', '2023-12-27 15:00:27', '', '', '');
INSERT INTO `sys_menu` VALUES (1020, '岗位查询', 104, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:post:query', '#', 'admin', '2023-12-27 15:00:27', '', '', '');
INSERT INTO `sys_menu` VALUES (1021, '岗位新增', 104, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:post:add', '#', 'admin', '2023-12-27 15:00:27', '', '', '');
INSERT INTO `sys_menu` VALUES (1022, '岗位修改', 104, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:post:edit', '#', 'admin', '2023-12-27 15:00:27', '', '', '');
INSERT INTO `sys_menu` VALUES (1023, '岗位删除', 104, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:post:remove', '#', 'admin', '2023-12-27 15:00:27', '', '', '');
INSERT INTO `sys_menu` VALUES (1024, '岗位导出', 104, 5, '', '', '', 1, 0, 'F', '0', '0', 'system:post:export', '#', 'admin', '2023-12-27 15:00:27', '', '', '');
INSERT INTO `sys_menu` VALUES (1025, '字典查询', 105, 1, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:query', '#', 'admin', '2023-12-27 15:00:27', '', '', '');
INSERT INTO `sys_menu` VALUES (1026, '字典新增', 105, 2, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:add', '#', 'admin', '2023-12-27 15:00:27', '', '', '');
INSERT INTO `sys_menu` VALUES (1027, '字典修改', 105, 3, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:edit', '#', 'admin', '2023-12-27 15:00:27', '', '', '');
INSERT INTO `sys_menu` VALUES (1028, '字典删除', 105, 4, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:remove', '#', 'admin', '2023-12-27 15:00:27', '', '', '');
INSERT INTO `sys_menu` VALUES (1029, '字典导出', 105, 5, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:export', '#', 'admin', '2023-12-27 15:00:27', '', '', '');
INSERT INTO `sys_menu` VALUES (2005, '供应商管理', 2, 9, 'supplier/list', 'scm/supplier/index', '', 1, 0, 'C', '0', '0', 'scm:supplier', 'qq', 'admin', '2023-12-29 09:14:02', 'admin', '2024-04-21 11:13:49', '');
INSERT INTO `sys_menu` VALUES (2007, '商品管理', 8, 1, 'goods_list', 'goods/index', '', 1, 0, 'C', '0', '0', 'goods:list', 'theme', 'admin', '2023-12-29 13:31:01', 'admin', '2023-12-29 15:02:40.869685', '');
INSERT INTO `sys_menu` VALUES (2008, '商品分类', 8, 88, 'category', 'goods/category/index', '', 1, 0, 'C', '0', '0', 'goods:category', 'tree-table', 'admin', '2023-12-29 13:32:41', 'admin', '2024-04-21 14:41:32', '');
INSERT INTO `sys_menu` VALUES (2009, '品牌管理', 8, 99, 'brand', 'goods/brand/index', '', 1, 0, 'C', '0', '0', 'goods:brand', 'clipboard', 'admin', '2023-12-29 13:34:49', 'admin', '2024-04-21 14:41:04', '');
INSERT INTO `sys_menu` VALUES (2010, '采购管理', 2, 1, 'purchase/order', 'scm/purchase/order', '', 1, 0, 'C', '0', '0', 'scm:purchase:order', 'button', 'admin', '2023-12-29 16:35:55', 'admin', '2024-04-21 10:53:43', '');
INSERT INTO `sys_menu` VALUES (2012, '采购物流管理', 2, 2, 'purchase/ship', 'scm/purchase/ship', '', 1, 0, 'C', '0', '0', 'scm:purchase:ship', 'component', 'admin', '2023-12-29 16:45:42', 'admin', '2024-04-21 11:06:08', '');
INSERT INTO `sys_menu` VALUES (2019, '采购账单管理', 2, 3, 'purchase_bill', 'scm/purchase/bill', '', 1, 0, 'C', '0', '0', '', 'money', 'admin', '2023-12-29 17:09:32', 'admin', '2024-04-24 20:32:27', '');
INSERT INTO `sys_menu` VALUES (2021, '创建采购单', 2, 101, 'purchase/order/create', 'scm/purchase/order/create', '', 1, 0, 'C', '1', '0', '', 'edit', 'admin', '2023-12-29 21:23:45', 'admin', '2024-04-21 11:44:03', '');
INSERT INTO `sys_menu` VALUES (2025, '采购订单详情', 2, 102, 'purchase/order/detail', 'scm/purchase/order/detail', '', 1, 0, 'C', '1', '0', '', 'button', 'admin', '2023-12-30 17:08:01', 'admin', '2024-04-21 11:04:50', '');
INSERT INTO `sys_menu` VALUES (2027, '入库管理', 6, 0, 'stock_in_entry/list', 'wms/stockInEntry', '', 1, 0, 'C', '0', '0', 'wms:stock_in_entry:list', 'stockin', 'admin', '2023-12-31 12:27:37', 'admin', '2024-01-14 15:12:48', '');
INSERT INTO `sys_menu` VALUES (2028, '生成采购入库单', 2, 103, 'purchase/ship/create_stock_in_entry', 'scm/purchase/ship/create_stock_in_entry', '', 1, 0, 'C', '1', '0', '', 'button', 'admin', '2023-12-31 12:31:32', 'admin', '2024-04-21 11:05:53', '');
INSERT INTO `sys_menu` VALUES (2029, '店铺售后导入', 5, 2, 'shop_refund', 'shop/refund/index', '', 1, 0, 'C', '0', '0', '', 'clipboard', 'admin', '2023-12-31 17:29:03', 'admin', '2024-04-10 11:19:00', '');
INSERT INTO `sys_menu` VALUES (2033, '订单管理', 3, 1, 'list', 'order/index', '', 1, 0, 'C', '0', '0', '', 'list', 'admin', '2023-12-31 20:05:05', 'admin', '2024-04-21 11:16:48', '');
INSERT INTO `sys_menu` VALUES (2035, '订单退货', 5, 4, 'order_returned', 'afterSale/returned', '', 1, 0, 'C', '0', '0', '', 'upload', 'admin', '2024-01-01 14:13:47', 'admin', '2024-04-10 11:29:27', '');
INSERT INTO `sys_menu` VALUES (2036, '网店订单导入', 3, 2, 'shop_order', 'shop/order/index', '', 1, 1, 'C', '0', '0', '', 'excel', 'admin', '2024-01-01 14:14:42', 'admin', '2024-04-21 10:54:35', '');
INSERT INTO `sys_menu` VALUES (2041, '订单补发', 5, 6, 'order_ship_again', 'afterSale/shipAgain', NULL, 1, 0, 'C', '0', '0', '', 'checkbox', 'admin', '2024-01-02 14:11:34', 'admin', '2024-04-10 11:28:26', '');
INSERT INTO `sys_menu` VALUES (2042, '订单拦截', 5, 3, 'order_intercept', 'afterSale/intercept', NULL, 1, 0, 'C', '0', '0', '', 'edit', 'admin', '2024-01-02 14:11:56', 'admin', '2024-04-10 11:28:32', '');
INSERT INTO `sys_menu` VALUES (2044, '订单换货', 5, 5, 'order_exchange', 'afterSale/exchange', NULL, 1, 0, 'C', '0', '0', '', 'skill', 'admin', '2024-01-03 09:18:53', 'admin', '2024-04-10 11:30:38', '');
INSERT INTO `sys_menu` VALUES (2046, '出库管理', 6, 5, 'stockOut', 'wms/stockOutEntry', NULL, 1, 0, 'C', '0', '0', '', 'link', 'admin', '2024-01-03 11:00:53', 'admin', '2024-01-12 15:52:19', '');
INSERT INTO `sys_menu` VALUES (2047, '库存查询', 6, 6, 'goodsInventory', 'goods/goodsInventory', NULL, 1, 0, 'C', '0', '0', '', 'monitor', 'admin', '2024-01-03 11:01:14', 'admin', '2024-01-09 17:55:33', '');
INSERT INTO `sys_menu` VALUES (2049, '打包发货', 4, 3, 'shipping', 'shipping/index', NULL, 1, 0, 'C', '0', '0', '', 'guide', 'admin', '2024-01-03 14:09:18', 'admin', '2024-04-10 11:10:56', '');
INSERT INTO `sys_menu` VALUES (2051, '发货记录', 4, 4, 'logistics', 'shipping/index', NULL, 1, 0, 'C', '0', '0', '', 'email', 'admin', '2024-01-03 14:13:12', 'admin', '2024-04-12 14:47:08', '');
INSERT INTO `sys_menu` VALUES (2054, '售后处理', 5, 1, 'refund_list', 'refund/index', NULL, 1, 0, 'C', '0', '0', '', 'size', 'admin', '2024-01-03 14:24:36', 'admin', '2024-04-21 11:10:44', '');
INSERT INTO `sys_menu` VALUES (2059, '备货清单', 4, 1, 'stocking', 'shipping/stocking/', '', 1, 0, 'C', '0', '0', '', 'component', 'admin', '2024-01-09 11:51:52', 'admin', '2024-04-10 11:10:25', '');
INSERT INTO `sys_menu` VALUES (2060, '拣货出库', 4, 2, 'stockout', 'wms/orderShipping/stockOut', NULL, 1, 0, 'C', '0', '0', '', 'bug', 'admin', '2024-01-09 13:39:00', 'admin', '2024-04-21 10:55:21', '');
INSERT INTO `sys_menu` VALUES (2061, '仓位管理', 6, 9, 'stock_location', 'wms/location', NULL, 1, 0, 'C', '0', '0', '', 'education', 'admin', '2024-01-09 13:54:30', 'admin', '2024-04-21 11:11:41', '');
INSERT INTO `sys_menu` VALUES (2062, '代发账单管理', 4, 4, 'agent_ship_bill', 'shipping/agent/shipBill', NULL, 1, 0, 'C', '0', '0', '', 'money', 'admin', '2024-01-12 18:35:02', 'admin', '2024-04-24 20:48:33', '');
INSERT INTO `sys_menu` VALUES (2063, '物流费用', 4, 100, 'shipFee', 'fms/payable/shipFee', NULL, 1, 0, 'C', '0', '0', '', 'guide', 'admin', '2024-01-12 18:35:31', 'admin', '2024-04-21 11:10:14', '');
INSERT INTO `sys_menu` VALUES (2066, '添加商品', 8, 2, 'create', 'goods/create', NULL, 1, 0, 'C', '1', '0', '', 'component', 'admin', '2024-01-14 19:42:11', 'admin', '2024-04-10 11:33:33', '');
INSERT INTO `sys_menu` VALUES (2067, '商品SKU管理', 8, 3, 'sku_list', 'goods/spec', NULL, 1, 0, 'C', '0', '0', '', 'theme', 'admin', '2024-01-16 14:17:39', 'admin', '2024-04-10 11:34:08', '');
INSERT INTO `sys_menu` VALUES (2068, '店铺商品管理', 7, 1, 'shop_goods/list', 'shop/goods', NULL, 1, 0, 'C', '0', '0', '', 'example', 'admin', '2024-01-28 11:23:36', 'admin', '2024-04-10 10:58:48', '');
INSERT INTO `sys_menu` VALUES (2072, '店铺管理', 7, 2, 'list', 'shop/index', NULL, 1, 0, 'C', '0', '0', '', 'clipboard', 'admin', '2024-01-28 11:29:21', 'admin', '2024-04-10 11:00:21', '');
INSERT INTO `sys_menu` VALUES (2078, '快递公司管理', 4, 9, 'logistics_company', 'shipping/logistics_company', NULL, 1, 0, 'C', '0', '0', '', 'email', 'admin', '2024-04-10 11:13:02', 'admin', '2024-04-21 11:10:03', '');
INSERT INTO `sys_menu` VALUES (2081, '订单导入日志', 3, 9, 'log', NULL, NULL, 1, 0, 'C', '0', '0', NULL, 'component', 'admin', '2024-04-21 11:08:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2082, '售后设置', 5, 10, 'set', NULL, NULL, 1, 0, 'C', '0', '0', NULL, '404', 'admin', '2024-04-21 11:11:09', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2083, '库存日志', 6, 99, 'logs', NULL, NULL, 1, 0, 'C', '0', '0', NULL, 'bug', 'admin', '2024-04-21 11:12:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2085, '商品分类属性', 8, 90, 'category_attr', 'goods/category/categoryAttribute', NULL, 1, 0, 'C', '1', '0', '', '404', 'admin', '2024-04-21 14:29:04', 'admin', '2024-04-21 14:40:53', '');
INSERT INTO `sys_menu` VALUES (2086, '分类属性值', 8, 91, 'category_attr_val', 'goods/category/categoryAttributeValue', NULL, 1, 0, 'C', '1', '0', '', 'clipboard', 'admin', '2024-04-21 15:13:03', 'admin', '2024-04-21 15:13:54', '');

-- ----------------------------
-- Table structure for sys_oper_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_oper_log`;
CREATE TABLE `sys_oper_log`  (
  `oper_id` bigint NOT NULL AUTO_INCREMENT COMMENT '日志主键',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '模块标题',
  `business_type` int NULL DEFAULT 0 COMMENT '业务类型（0其它 1新增 2修改 3删除）',
  `method` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '方法名称',
  `request_method` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '请求方式',
  `operator_type` int NULL DEFAULT 0 COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
  `oper_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '操作人员',
  `dept_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '部门名称',
  `oper_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '请求URL',
  `oper_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '主机地址',
  `oper_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '操作地点',
  `oper_param` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '请求参数',
  `json_result` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '返回参数',
  `status` int NULL DEFAULT 0 COMMENT '操作状态（0正常 1异常）',
  `error_msg` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '错误消息',
  `oper_time` datetime NULL DEFAULT NULL COMMENT '操作时间',
  `cost_time` bigint NULL DEFAULT 0 COMMENT '消耗时间',
  PRIMARY KEY (`oper_id`) USING BTREE,
  INDEX `idx_sys_oper_log_bt`(`business_type`) USING BTREE,
  INDEX `idx_sys_oper_log_s`(`status`) USING BTREE,
  INDEX `idx_sys_oper_log_ot`(`oper_time`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 174 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '操作日志记录' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_oper_log
-- ----------------------------
INSERT INTO `sys_oper_log` VALUES (1, '淘宝订单', 1, 'com.qihang.erp.api.controller.TaoOrderController.add()', 'POST', 1, 'admin', NULL, '/tao/order', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"params\":{},\"taoOrderItemList\":[]}', '{\"msg\":\"请添加商品\",\"code\":506}', 0, NULL, '2024-01-13 20:31:20', 31);
INSERT INTO `sys_oper_log` VALUES (2, '淘宝退款订单', 1, 'com.qihang.erp.api.controller.TaoOrderRefundController.add()', 'POST', 1, 'admin', NULL, '/tao/taoRefund', '127.0.0.1', '内网IP', '{\"afterSalesType\":1,\"num\":1,\"oid\":\"3238963057148759844\",\"params\":{},\"refundFee\":82.21,\"tid\":\"3238963057148759844\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-01-13 20:58:32', 25131);
INSERT INTO `sys_oper_log` VALUES (3, '淘宝退款订单', 1, 'com.qihang.erp.api.controller.TaoOrderRefundController.add()', 'POST', 1, 'admin', NULL, '/tao/taoRefund', '127.0.0.1', '内网IP', '{\"afterSalesType\":9,\"num\":1,\"oid\":\"3238963057148759844\",\"params\":{},\"refundFee\":82.21,\"refundId\":\"11\",\"tid\":\"3238963057148759844\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-01-13 21:00:25', 7879);
INSERT INTO `sys_oper_log` VALUES (4, '淘宝退款订单', 1, 'com.qihang.erp.api.controller.TaoOrderRefundController.add()', 'POST', 1, 'admin', NULL, '/tao/taoRefund', '127.0.0.1', '内网IP', '{\"afterSalesType\":9,\"num\":1,\"oid\":\"3238963057148759844\",\"params\":{},\"refundFee\":82.21,\"refundId\":\"11\",\"tid\":\"3238963057148759844\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-01-13 21:00:32', 0);
INSERT INTO `sys_oper_log` VALUES (5, '淘宝退款订单', 1, 'com.qihang.erp.api.controller.TaoOrderRefundController.add()', 'POST', 1, 'admin', NULL, '/tao/taoRefund', '127.0.0.1', '内网IP', '{\"afterSalesType\":9,\"num\":1,\"oid\":\"3238963057148759844\",\"params\":{},\"refundFee\":82.21,\"refundId\":\"11\",\"tid\":\"3238963057148759844\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-01-13 21:00:36', 0);
INSERT INTO `sys_oper_log` VALUES (6, '淘宝退款订单', 1, 'com.qihang.erp.api.controller.TaoOrderRefundController.add()', 'POST', 1, 'admin', NULL, '/tao/taoRefund', '127.0.0.1', '内网IP', '{\"afterSalesType\":3,\"num\":1,\"oid\":\"3238963057148759844\",\"params\":{},\"refundFee\":82.21,\"refundId\":\"2323\",\"tid\":\"3238963057148759844\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-01-13 21:01:10', 0);
INSERT INTO `sys_oper_log` VALUES (7, '淘宝退款订单', 1, 'com.qihang.erp.api.controller.TaoOrderRefundController.add()', 'POST', 1, 'admin', NULL, '/tao/taoRefund', '127.0.0.1', '内网IP', '{\"afterSalesType\":9,\"num\":1,\"oid\":\"3238963057148759844\",\"params\":{},\"refundFee\":82.21,\"refundId\":\"dd\",\"tid\":\"3238963057148759844\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-01-13 21:01:56', 0);
INSERT INTO `sys_oper_log` VALUES (8, '淘宝退款订单', 1, 'com.qihang.erp.api.controller.TaoOrderRefundController.add()', 'POST', 1, 'admin', NULL, '/tao/taoRefund', '127.0.0.1', '内网IP', '{\"afterSalesType\":1,\"num\":1,\"oid\":\"3198002834286896419\",\"params\":{},\"refundFee\":24,\"refundId\":\"205639742516891964\",\"tid\":\"3198002834286896419\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-01-13 21:03:29', 0);
INSERT INTO `sys_oper_log` VALUES (9, '淘宝退款订单', 1, 'com.qihang.erp.api.controller.TaoOrderRefundController.add()', 'POST', 1, 'admin', NULL, '/tao/taoRefund', '127.0.0.1', '内网IP', '{\"afterSalesType\":1,\"num\":1,\"oid\":\"3198002834286896419\",\"params\":{},\"refundFee\":24,\"refundId\":\"205639742516891964\",\"tid\":\"3198002834286896419\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-01-13 21:12:45', 24108);
INSERT INTO `sys_oper_log` VALUES (10, '淘宝退款订单', 1, 'com.qihang.erp.api.controller.TaoOrderRefundController.add()', 'POST', 1, 'admin', NULL, '/tao/taoRefund', '127.0.0.1', '内网IP', '{\"afterSalesType\":1,\"num\":1,\"oid\":\"3198002834286896419\",\"params\":{},\"refundFee\":24,\"refundId\":\"205639742516891964\",\"tid\":\"3198002834286896419\"}', '{\"msg\":\"子订单已经在售后中！请勿重复提交！\",\"code\":502}', 0, NULL, '2024-01-13 21:14:10', 6809);
INSERT INTO `sys_oper_log` VALUES (11, '代码生成', 3, 'com.zhijian.generator.controller.GenController.remove()', 'DELETE', 1, 'admin', NULL, '/tool/gen/46,47,48,49,50,51', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-01-13 21:27:42', 16);
INSERT INTO `sys_oper_log` VALUES (12, '代码生成', 6, 'com.zhijian.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', NULL, '/tool/gen/importTable', '127.0.0.1', '内网IP', '{\"tables\":\"s_tao_order_refund\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-01-13 21:27:53', 107);
INSERT INTO `sys_oper_log` VALUES (13, '代码生成', 2, 'com.zhijian.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', NULL, '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"refund\",\"className\":\"STaoOrderRefund\",\"columns\":[{\"capJavaField\":\"Id\",\"columnId\":1156,\"columnName\":\"id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2024-01-13 21:27:53\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":52,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"RefundId\",\"columnComment\":\"退款id\",\"columnId\":1157,\"columnName\":\"refund_id\",\"columnType\":\"varchar(50)\",\"createBy\":\"admin\",\"createTime\":\"2024-01-13 21:27:53\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"refundId\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":52,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"AfterSalesType\",\"columnComment\":\"类型（1退货3换货）\",\"columnId\":1158,\"columnName\":\"after_sales_type\",\"columnType\":\"int\",\"createBy\":\"admin\",\"createTime\":\"2024-01-13 21:27:53\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"select\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"afterSalesType\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":52,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"ShopId\",\"columnComment\":\"店铺id\",\"columnId\":1159,\"columnName\":\"shopId\",\"columnType\":\"int\",\"createBy\":\"admin\",\"createTime\":\"2024-01-13 21:27:53\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"shopId\",\"javaType\":\"Long\",\"list\"', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-01-13 21:28:07', 71);
INSERT INTO `sys_oper_log` VALUES (14, '代码生成', 2, 'com.zhijian.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', NULL, '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"refund\",\"className\":\"TaoOrderRefund\",\"columns\":[{\"capJavaField\":\"Id\",\"columnId\":1156,\"columnName\":\"id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2024-01-13 21:27:53\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":52,\"updateBy\":\"\",\"updateTime\":\"2024-01-13 21:28:07\",\"usableColumn\":false},{\"capJavaField\":\"RefundId\",\"columnComment\":\"退款id\",\"columnId\":1157,\"columnName\":\"refund_id\",\"columnType\":\"varchar(50)\",\"createBy\":\"admin\",\"createTime\":\"2024-01-13 21:27:53\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"refundId\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":52,\"updateBy\":\"\",\"updateTime\":\"2024-01-13 21:28:07\",\"usableColumn\":false},{\"capJavaField\":\"AfterSalesType\",\"columnComment\":\"类型（1退货3换货）\",\"columnId\":1158,\"columnName\":\"after_sales_type\",\"columnType\":\"int\",\"createBy\":\"admin\",\"createTime\":\"2024-01-13 21:27:53\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"select\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"afterSalesType\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":52,\"updateBy\":\"\",\"updateTime\":\"2024-01-13 21:28:07\",\"usableColumn\":false},{\"capJavaField\":\"ShopId\",\"columnComment\":\"店铺id\",\"columnId\":1159,\"columnName\":\"shopId\",\"columnType\":\"int\",\"createBy\":\"admin\",\"createTime\":\"2024-01-13 21:27:53\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-01-13 21:28:16', 54);
INSERT INTO `sys_oper_log` VALUES (15, '代码生成', 8, 'com.zhijian.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', NULL, '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"s_tao_order_refund\"}', NULL, 0, NULL, '2024-01-13 21:28:31', 385);
INSERT INTO `sys_oper_log` VALUES (16, '淘宝退款订单', 1, 'com.qihang.erp.api.controller.TaoOrderRefundController.add()', 'POST', 1, 'admin', NULL, '/tao/taoRefund', '127.0.0.1', '内网IP', '{\"afterSalesType\":3,\"createBy\":\"admin\",\"goodsTitle\":\"8026牛仔短裤\",\"num\":1,\"oid\":3198002834286896419,\"params\":{},\"productImgUrl\":\"https://cbu01.alicdn.com/img/ibank/O1CN01PHFmsX2FOyB14fPie_!!2208857268871-0-cib.jpg\",\"refundFee\":24,\"refundId\":\"205639742516891970\",\"skuInfo\":\"颜色分类：浅蓝色;尺寸：2XL[121-125斤]\",\"tid\":3198002834286896419}', '{\"msg\":\"子订单已经在售后中！请勿重复提交！\",\"code\":502}', 0, NULL, '2024-01-13 21:43:22', 13894);
INSERT INTO `sys_oper_log` VALUES (17, '淘宝退款订单', 1, 'com.qihang.erp.api.controller.TaoOrderRefundController.add()', 'POST', 1, 'admin', NULL, '/tao/taoRefund', '127.0.0.1', '内网IP', '{\"afterSalesType\":3,\"createBy\":\"admin\",\"goodsTitle\":\"8026牛仔短裤\",\"num\":1,\"oid\":3198002834286896419,\"params\":{},\"productImgUrl\":\"https://cbu01.alicdn.com/img/ibank/O1CN01PHFmsX2FOyB14fPie_!!2208857268871-0-cib.jpg\",\"refundFee\":24,\"refundId\":\"205639742516891970\",\"skuInfo\":\"颜色分类：浅蓝色;尺寸：2XL[121-125斤]\",\"tid\":3198002834286896419}', '{\"msg\":\"子订单已经在售后中！请勿重复提交！\",\"code\":502}', 0, NULL, '2024-01-13 21:43:44', 13860);
INSERT INTO `sys_oper_log` VALUES (18, '淘宝退款订单', 1, 'com.qihang.erp.api.controller.TaoOrderRefundController.add()', 'POST', 1, 'admin', NULL, '/tao/taoRefund', '127.0.0.1', '内网IP', '{\"afterSalesType\":3,\"createBy\":\"admin\",\"goodsTitle\":\"8026牛仔短裤\",\"num\":1,\"oid\":3198002834286896419,\"params\":{},\"productImgUrl\":\"https://cbu01.alicdn.com/img/ibank/O1CN01PHFmsX2FOyB14fPie_!!2208857268871-0-cib.jpg\",\"refundFee\":24,\"refundId\":\"205639742516891970\",\"skuInfo\":\"颜色分类：浅蓝色;尺寸：2XL[121-125斤]\",\"tid\":3198002834286896419}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLSyntaxErrorException: Unknown column \'updateTime\' in \'field list\'\r\n### The error may exist in file [D:\\projects\\qihang.ecom.erp\\ecerp-api\\target\\classes\\mapper\\tao\\TaoOrderMapper.xml]\r\n### The error may involve com.qihang.erp.api.mapper.TaoOrderMapper.updateTaoOrderItem-Inline\r\n### The error occurred while setting parameters\r\n### SQL: update s_tao_order_item      SET refundStatus = ?,         updateTime = ?,         updateBy = ?          where id = ?\r\n### Cause: java.sql.SQLSyntaxErrorException: Unknown column \'updateTime\' in \'field list\'\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: Unknown column \'updateTime\' in \'field list\'', '2024-01-13 21:44:19', 16613);
INSERT INTO `sys_oper_log` VALUES (19, '淘宝退款订单', 1, 'com.qihang.erp.api.controller.TaoOrderRefundController.add()', 'POST', 1, 'admin', NULL, '/tao/taoRefund', '127.0.0.1', '内网IP', '{\"afterSalesType\":3,\"createBy\":\"admin\",\"goodsTitle\":\"8026牛仔短裤\",\"num\":1,\"oid\":3198002834286896419,\"params\":{},\"productImgUrl\":\"https://cbu01.alicdn.com/img/ibank/O1CN01PHFmsX2FOyB14fPie_!!2208857268871-0-cib.jpg\",\"refundFee\":24,\"refundId\":\"205639742516891970\",\"skuInfo\":\"颜色分类：浅蓝色;尺寸：2XL[121-125斤]\",\"tid\":3198002834286896419}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-01-13 21:46:58', 17009);
INSERT INTO `sys_oper_log` VALUES (20, '淘宝退款订单', 2, 'com.qihang.erp.api.controller.TaoOrderRefundController.edit()', 'PUT', 1, 'admin', NULL, '/tao/taoRefund', '127.0.0.1', '内网IP', '{\"afterSalesType\":1,\"auditStatus\":0,\"createBy\":\"admin\",\"createTime\":\"2024-01-13 21:46:51\",\"created\":1705153607,\"erpGoodsId\":0,\"erpGoodsSpecId\":0,\"goodsNumber\":\"2720218026\",\"goodsTitle\":\"8026牛仔短裤\",\"id\":29,\"logisticsCode\":\"SF10235566202\",\"logisticsCompany\":\"顺丰快递\",\"num\":1,\"oid\":3198002834286896600,\"params\":{},\"productImgUrl\":\"https://cbu01.alicdn.com/img/ibank/O1CN01PHFmsX2FOyB14fPie_!!2208857268871-0-cib.jpg\",\"refundFee\":24,\"refundId\":\"205639742516891970\",\"sendTime\":\"2024-01-13\",\"shopId\":6,\"skuId\":42,\"skuInfo\":\"颜色分类：浅蓝色;尺寸：2XL[121-125斤]\",\"specNumber\":\"2720210080260305\",\"status\":1,\"tid\":3198002834286896600,\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-01-13 22:53:43', 37654);
INSERT INTO `sys_oper_log` VALUES (21, '淘宝退款订单', 2, 'com.qihang.erp.api.controller.TaoOrderRefundController.edit()', 'PUT', 1, 'admin', NULL, '/tao/taoRefund', '127.0.0.1', '内网IP', '{\"afterSalesType\":1,\"auditStatus\":0,\"createBy\":\"admin\",\"createTime\":\"2024-01-13 21:46:51\",\"created\":1705153607,\"erpGoodsId\":0,\"erpGoodsSpecId\":0,\"goodsNumber\":\"2720218026\",\"goodsTitle\":\"8026牛仔短裤\",\"id\":29,\"logisticsCode\":\"SF100255698552\",\"logisticsCompany\":\"顺丰物流\",\"num\":1,\"oid\":3198002834286896600,\"params\":{},\"productImgUrl\":\"https://cbu01.alicdn.com/img/ibank/O1CN01PHFmsX2FOyB14fPie_!!2208857268871-0-cib.jpg\",\"refundFee\":24,\"refundId\":\"205639742516891970\",\"sendTime\":\"2024-01-13\",\"shopId\":6,\"skuId\":42,\"skuInfo\":\"颜色分类：浅蓝色;尺寸：2XL[121-125斤]\",\"specNumber\":\"2720210080260305\",\"status\":1,\"tid\":3198002834286896600,\"updateBy\":\"admin\"}', NULL, 1, 'nested exception is org.apache.ibatis.reflection.ReflectionException: There is no getter for property named \'orderTimeId\' in \'class com.qihang.erp.api.domain.ErpOrderReturned\'', '2024-01-13 23:15:25', 29);
INSERT INTO `sys_oper_log` VALUES (22, '淘宝退款订单', 2, 'com.qihang.erp.api.controller.TaoOrderRefundController.edit()', 'PUT', 1, 'admin', NULL, '/tao/taoRefund', '127.0.0.1', '内网IP', '{\"afterSalesType\":1,\"auditStatus\":0,\"createBy\":\"admin\",\"createTime\":\"2024-01-13 21:46:51\",\"created\":1705153607,\"erpGoodsId\":0,\"erpGoodsSpecId\":0,\"goodsNumber\":\"2720218026\",\"goodsTitle\":\"8026牛仔短裤\",\"id\":29,\"logisticsCode\":\"SF100255698552\",\"logisticsCompany\":\"顺丰物流\",\"num\":1,\"oid\":3198002834286896600,\"params\":{},\"productImgUrl\":\"https://cbu01.alicdn.com/img/ibank/O1CN01PHFmsX2FOyB14fPie_!!2208857268871-0-cib.jpg\",\"refundFee\":24,\"refundId\":\"205639742516891970\",\"sendTime\":\"2024-01-13\",\"shopId\":6,\"skuId\":42,\"skuInfo\":\"颜色分类：浅蓝色;尺寸：2XL[121-125斤]\",\"specNumber\":\"2720210080260305\",\"status\":1,\"tid\":3198002834286896600,\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-01-13 23:17:14', 134);
INSERT INTO `sys_oper_log` VALUES (23, '淘宝退款订单', 2, 'com.qihang.erp.api.controller.TaoOrderRefundController.edit()', 'PUT', 1, 'admin', NULL, '/tao/taoRefund', '127.0.0.1', '内网IP', '{\"afterSalesType\":1,\"auditStatus\":0,\"createTime\":\"2023-02-21 18:08:29\",\"erpGoodsId\":9,\"erpGoodsSpecId\":42,\"id\":27,\"logisticsCode\":\"YT7054813104977\",\"logisticsCompany\":\"圆通速递\",\"num\":1,\"oid\":3198002834286896600,\"params\":{},\"refundFee\":24,\"refundId\":\"205639742516891964\",\"sendTime\":\"2023-02-21 18:09:17\",\"shopId\":6,\"specNumber\":\"2720210080260305\",\"status\":1,\"tid\":3198002834286896600,\"updateBy\":\"admin\"}', NULL, 1, '\r\n### Error querying database.  Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'s_tao_order a on a.id = b.order_id\n        where b.order_item_num = \'31980028342\' at line 4\r\n### The error may exist in file [D:\\projects\\qihang.ecom.erp\\ecerp-api\\target\\classes\\mapper\\api\\ErpOrderMapper.xml]\r\n### The error may involve com.qihang.erp.api.mapper.ErpOrderMapper.selectOrderItemByOrderItemNum-Inline\r\n### The error occurred while setting parameters\r\n### SQL: select         b.id as sub_id, b.order_item_num as sub_order_item_num,b.supplier_id as sub_supplier_id,b.order_id as sub_order_id, b.goods_id as sub_goods_id, b.spec_id as sub_spec_id, b.goods_title as sub_goods_title, b.goods_img as sub_goods_img, b.goods_num as sub_goods_num, b.goods_spec as sub_goods_spec, b.spec_num as sub_spec_num, b.goods_price as sub_goods_price, b.item_amount as sub_item_amount, b.quantity as sub_quantity, b.remark as sub_remark, b.is_gift as sub_is_gift, b.refund_count as sub_refund_count, b.refund_status as sub_refund_status, b.create_time as sub_create_time, b.create_by as sub_create_by, b.update_time as sub_update_time, b.update_by as sub_update_by         from  erp_order_item b         left s_tao_order a on a.id = b.order_id         where b.order_item_num = ? and shop_id = ?\r\n### Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'s_tao_order a on a.id = b.order_id\n        where b.order_item_num = \'31980028342\' at line 4\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'s_tao_order a on a.id = b.order_id\n        where b.order_item_num = \'31980028342\' at line 4', '2024-01-14 10:03:29', 139555);
INSERT INTO `sys_oper_log` VALUES (24, '淘宝退款订单', 2, 'com.qihang.erp.api.controller.TaoOrderRefundController.edit()', 'PUT', 1, 'admin', NULL, '/tao/taoRefund', '127.0.0.1', '内网IP', '{\"afterSalesType\":1,\"auditStatus\":0,\"createTime\":\"2023-02-21 18:08:29\",\"erpGoodsId\":9,\"erpGoodsSpecId\":42,\"id\":27,\"logisticsCode\":\"YT7054813104977\",\"logisticsCompany\":\"圆通速递\",\"num\":1,\"oid\":3198002834286896600,\"params\":{},\"refundFee\":24,\"refundId\":\"205639742516891964\",\"sendTime\":\"2023-02-21 18:09:17\",\"shopId\":6,\"specNumber\":\"2720210080260305\",\"status\":1,\"tid\":3198002834286896600,\"updateBy\":\"admin\"}', NULL, 1, '\r\n### Error querying database.  Cause: java.sql.SQLSyntaxErrorException: Unknown column \'shop_id\' in \'where clause\'\r\n### The error may exist in file [D:\\projects\\qihang.ecom.erp\\ecerp-api\\target\\classes\\mapper\\api\\ErpOrderMapper.xml]\r\n### The error may involve com.qihang.erp.api.mapper.ErpOrderMapper.selectOrderItemByOrderItemNum-Inline\r\n### The error occurred while setting parameters\r\n### SQL: select         b.id as sub_id, b.order_item_num as sub_order_item_num,b.supplier_id as sub_supplier_id,b.order_id as sub_order_id, b.goods_id as sub_goods_id, b.spec_id as sub_spec_id, b.goods_title as sub_goods_title, b.goods_img as sub_goods_img, b.goods_num as sub_goods_num, b.goods_spec as sub_goods_spec, b.spec_num as sub_spec_num, b.goods_price as sub_goods_price, b.item_amount as sub_item_amount, b.quantity as sub_quantity, b.remark as sub_remark, b.is_gift as sub_is_gift, b.refund_count as sub_refund_count, b.refund_status as sub_refund_status, b.create_time as sub_create_time, b.create_by as sub_create_by, b.update_time as sub_update_time, b.update_by as sub_update_by         from  erp_order_item b         left join s_tao_order a on a.id = b.order_id         where b.order_item_num = ? and shop_id = ?\r\n### Cause: java.sql.SQLSyntaxErrorException: Unknown column \'shop_id\' in \'where clause\'\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: Unknown column \'shop_id\' in \'where clause\'', '2024-01-14 10:03:45', 86);
INSERT INTO `sys_oper_log` VALUES (25, '淘宝退款订单', 2, 'com.qihang.erp.api.controller.TaoOrderRefundController.edit()', 'PUT', 1, 'admin', NULL, '/tao/taoRefund', '127.0.0.1', '内网IP', '{\"afterSalesType\":1,\"auditStatus\":0,\"createTime\":\"2023-02-21 18:08:29\",\"erpGoodsId\":9,\"erpGoodsSpecId\":42,\"id\":27,\"logisticsCode\":\"YT7054813104977\",\"logisticsCompany\":\"圆通速递\",\"num\":1,\"oid\":3198002834286896600,\"params\":{},\"refundFee\":24,\"refundId\":\"205639742516891964\",\"sendTime\":\"2023-02-21 18:09:17\",\"shopId\":6,\"specNumber\":\"2720210080260305\",\"status\":1,\"tid\":3198002834286896600,\"updateBy\":\"admin\"}', NULL, 1, '\r\n### Error querying database.  Cause: java.sql.SQLSyntaxErrorException: Unknown column \'a.shop_id\' in \'where clause\'\r\n### The error may exist in file [D:\\projects\\qihang.ecom.erp\\ecerp-api\\target\\classes\\mapper\\api\\ErpOrderMapper.xml]\r\n### The error may involve com.qihang.erp.api.mapper.ErpOrderMapper.selectOrderItemByOrderItemNum-Inline\r\n### The error occurred while setting parameters\r\n### SQL: select         b.id as sub_id, b.order_item_num as sub_order_item_num,b.supplier_id as sub_supplier_id,b.order_id as sub_order_id, b.goods_id as sub_goods_id, b.spec_id as sub_spec_id, b.goods_title as sub_goods_title, b.goods_img as sub_goods_img, b.goods_num as sub_goods_num, b.goods_spec as sub_goods_spec, b.spec_num as sub_spec_num, b.goods_price as sub_goods_price, b.item_amount as sub_item_amount, b.quantity as sub_quantity, b.remark as sub_remark, b.is_gift as sub_is_gift, b.refund_count as sub_refund_count, b.refund_status as sub_refund_status, b.create_time as sub_create_time, b.create_by as sub_create_by, b.update_time as sub_update_time, b.update_by as sub_update_by         from  erp_order_item b         left join s_tao_order a on a.id = b.order_id         where b.order_item_num = ? and a.shop_id = ?\r\n### Cause: java.sql.SQLSyntaxErrorException: Unknown column \'a.shop_id\' in \'where clause\'\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: Unknown column \'a.shop_id\' in \'where clause\'', '2024-01-14 10:04:18', 65);
INSERT INTO `sys_oper_log` VALUES (26, '淘宝退款订单', 2, 'com.qihang.erp.api.controller.TaoOrderRefundController.edit()', 'PUT', 1, 'admin', NULL, '/tao/taoRefund', '127.0.0.1', '内网IP', '{\"afterSalesType\":1,\"auditStatus\":0,\"createTime\":\"2023-02-21 18:08:29\",\"erpGoodsId\":9,\"erpGoodsSpecId\":42,\"id\":27,\"logisticsCode\":\"YT7054813104977\",\"logisticsCompany\":\"圆通速递\",\"num\":1,\"oid\":3198002834286896600,\"params\":{},\"refundFee\":24,\"refundId\":\"205639742516891964\",\"sendTime\":\"2023-02-21 18:09:17\",\"shopId\":6,\"specNumber\":\"2720210080260305\",\"status\":1,\"tid\":3198002834286896600,\"updateBy\":\"admin\"}', '{\"msg\":\"数据错误：ErpOrderItem未找到！\",\"code\":521}', 0, NULL, '2024-01-14 10:05:11', 46);
INSERT INTO `sys_oper_log` VALUES (27, '拼多多订单退款', 1, 'com.qihang.erp.api.controller.PddOrderRefundController.add()', 'POST', 1, 'admin', NULL, '/pdd/pddRefund', '127.0.0.1', '内网IP', '{\"afterSalesType\":2,\"discountAmount\":null,\"goodsImage\":\"https://img.pddpic.com/mms-material-img/2022-07-23/b68b46a8-b269-4328-8909-7facf0a6354a.jpeg\",\"goodsName\":\"牛仔短裤辣妹高腰裤短款弹力紧身a字型抽绳绑带纯欲风学生潮流夏\",\"goodsPrice\":null,\"goodsSpec\":\"深灰色 黑灰色,S\",\"id\":15745472193,\"orderAmount\":null,\"orderItemId\":3490,\"orderSn\":\"230405-342695669310441\",\"params\":{},\"quantity\":1,\"refundAmount\":32,\"refundQty\":1}', NULL, 1, 'nested exception is org.apache.ibatis.reflection.ReflectionException: There is no getter for property named \'skuNumber\' in \'class com.qihang.erp.api.domain.PddOrderRefund\'', '2024-01-14 11:58:09', 25929);
INSERT INTO `sys_oper_log` VALUES (28, '拼多多订单退款', 1, 'com.qihang.erp.api.controller.PddOrderRefundController.add()', 'POST', 1, 'admin', NULL, '/pdd/pddRefund', '127.0.0.1', '内网IP', '{\"afterSalesType\":2,\"discountAmount\":null,\"goodsImage\":\"https://img.pddpic.com/mms-material-img/2022-07-23/b68b46a8-b269-4328-8909-7facf0a6354a.jpeg\",\"goodsName\":\"牛仔短裤辣妹高腰裤短款弹力紧身a字型抽绳绑带纯欲风学生潮流夏\",\"goodsPrice\":null,\"goodsSpec\":\"深灰色 黑灰色,S\",\"id\":15745472193,\"orderAmount\":null,\"orderItemId\":3490,\"orderSn\":\"230405-342695669310441\",\"params\":{},\"quantity\":1,\"refundAmount\":32,\"refundQty\":1}', NULL, 1, 'nested exception is org.apache.ibatis.reflection.ReflectionException: There is no getter for property named \'spec_number\' in \'class com.qihang.erp.api.domain.PddOrderRefund\'', '2024-01-14 12:00:40', 18382);
INSERT INTO `sys_oper_log` VALUES (29, '拼多多订单退款', 1, 'com.qihang.erp.api.controller.PddOrderRefundController.add()', 'POST', 1, 'admin', NULL, '/pdd/pddRefund', '127.0.0.1', '内网IP', '{\"afterSalesType\":2,\"discountAmount\":null,\"goodsImage\":\"https://img.pddpic.com/mms-material-img/2022-07-23/b68b46a8-b269-4328-8909-7facf0a6354a.jpeg\",\"goodsName\":\"牛仔短裤辣妹高腰裤短款弹力紧身a字型抽绳绑带纯欲风学生潮流夏\",\"goodsPrice\":null,\"goodsSpec\":\"深灰色 黑灰色,S\",\"id\":15745472193,\"orderAmount\":null,\"orderItemId\":3490,\"orderSn\":\"230405-342695669310441\",\"params\":{},\"quantity\":1,\"refundAmount\":32,\"refundQty\":1}', NULL, 1, 'nested exception is org.apache.ibatis.reflection.ReflectionException: There is no getter for property named \'spec_number\' in \'class com.qihang.erp.api.domain.PddOrderRefund\'', '2024-01-14 12:02:11', 12582);
INSERT INTO `sys_oper_log` VALUES (30, '拼多多订单退款', 1, 'com.qihang.erp.api.controller.PddOrderRefundController.add()', 'POST', 1, 'admin', NULL, '/pdd/pddRefund', '127.0.0.1', '内网IP', '{\"afterSalesType\":2,\"discountAmount\":null,\"goodsImage\":\"https://img.pddpic.com/mms-material-img/2022-07-23/b68b46a8-b269-4328-8909-7facf0a6354a.jpeg\",\"goodsName\":\"牛仔短裤辣妹高腰裤短款弹力紧身a字型抽绳绑带纯欲风学生潮流夏\",\"goodsPrice\":null,\"goodsSpec\":\"深灰色 黑灰色,S\",\"id\":15745472193,\"orderAmount\":null,\"orderItemId\":3490,\"orderSn\":\"230405-342695669310441\",\"params\":{},\"quantity\":1,\"refundAmount\":32,\"refundQty\":1}', NULL, 1, 'nested exception is org.apache.ibatis.reflection.ReflectionException: There is no getter for property named \'spec_number\' in \'class com.qihang.erp.api.domain.PddOrderRefund\'', '2024-01-14 12:05:49', 4496);
INSERT INTO `sys_oper_log` VALUES (31, '拼多多订单退款', 1, 'com.qihang.erp.api.controller.PddOrderRefundController.add()', 'POST', 1, 'admin', NULL, '/pdd/pddRefund', '127.0.0.1', '内网IP', '{\"afterSalesType\":2,\"discountAmount\":null,\"goodsImage\":\"https://img.pddpic.com/mms-material-img/2022-07-23/b68b46a8-b269-4328-8909-7facf0a6354a.jpeg\",\"goodsName\":\"牛仔短裤辣妹高腰裤短款弹力紧身a字型抽绳绑带纯欲风学生潮流夏\",\"goodsPrice\":null,\"goodsSpec\":\"深灰色 黑灰色,S\",\"id\":15745472193,\"orderAmount\":null,\"orderItemId\":3490,\"orderSn\":\"230405-342695669310441\",\"params\":{},\"quantity\":1,\"refundAmount\":32,\"refundQty\":1}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'after_sale_reason\' doesn\'t have a default value\r\n### The error may exist in file [D:\\projects\\qihang.ecom.erp\\ecerp-api\\target\\classes\\mapper\\pdd\\PddOrderRefundMapper.xml]\r\n### The error may involve com.qihang.erp.api.mapper.PddOrderRefundMapper.insertPddOrderRefund-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into s_pdd_order_refund          ( id,             order_sn,             shopId,             after_sales_type,             after_sales_status,                          confirm_time,             created_time,             discount_amount,             order_amount,             refund_amount,             goods_image,             goods_id,             sku_id,             goods_name,             goods_number,             spec_number,             goods_spec,             quantity,             goods_price,                                                    audit_status )           values ( ?,             ?,             ?,             ?,             ?,                          ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,                                                    ? )\r\n### Cause: java.sql.SQLException: Field \'after_sale_reason\' doesn\'t have a default value\n; Field \'after_sale_reason\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'after_sale_reason\' doesn\'t have a default value', '2024-01-14 12:08:09', 7758);
INSERT INTO `sys_oper_log` VALUES (32, '拼多多订单退款', 1, 'com.qihang.erp.api.controller.PddOrderRefundController.add()', 'POST', 1, 'admin', NULL, '/pdd/pddRefund', '127.0.0.1', '内网IP', '{\"afterSalesType\":2,\"discountAmount\":null,\"goodsImage\":\"https://img.pddpic.com/mms-material-img/2022-07-23/b68b46a8-b269-4328-8909-7facf0a6354a.jpeg\",\"goodsName\":\"牛仔短裤辣妹高腰裤短款弹力紧身a字型抽绳绑带纯欲风学生潮流夏\",\"goodsPrice\":null,\"goodsSpec\":\"深灰色 黑灰色,S\",\"id\":15745472193,\"orderAmount\":null,\"orderItemId\":3490,\"orderSn\":\"230405-342695669310441\",\"params\":{},\"quantity\":1,\"refundAmount\":32,\"refundQty\":1}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'15745472193\' for key \'s_pdd_order_refund.PRIMARY\'\r\n### The error may exist in file [D:\\projects\\qihang.ecom.erp\\ecerp-api\\target\\classes\\mapper\\pdd\\PddOrderRefundMapper.xml]\r\n### The error may involve com.qihang.erp.api.mapper.PddOrderRefundMapper.insertPddOrderRefund-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into s_pdd_order_refund          ( id,             order_sn,             shopId,             after_sales_type,             after_sales_status,                          confirm_time,             created_time,             discount_amount,             order_amount,             refund_amount,             goods_image,             goods_id,             sku_id,             goods_name,             goods_number,             spec_number,             goods_spec,             quantity,             goods_price,                                                    audit_status )           values ( ?,             ?,             ?,             ?,             ?,                          ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,                                                    ? )\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'15745472193\' for key \'s_pdd_order_refund.PRIMARY\'\n; Duplicate entry \'15745472193\' for key \'s_pdd_order_refund.PRIMARY\'; nested exception is java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'15745472193\' for key \'s_pdd_order_refund.PRIMARY\'', '2024-01-14 12:09:02', 4150);
INSERT INTO `sys_oper_log` VALUES (33, '拼多多订单退款', 1, 'com.qihang.erp.api.controller.PddOrderRefundController.add()', 'POST', 1, 'admin', NULL, '/pdd/pddRefund', '127.0.0.1', '内网IP', '{\"afterSalesType\":2,\"discountAmount\":null,\"goodsImage\":\"https://img.pddpic.com/mms-material-img/2022-07-23/b68b46a8-b269-4328-8909-7facf0a6354a.jpeg\",\"goodsName\":\"牛仔短裤辣妹高腰裤短款弹力紧身a字型抽绳绑带纯欲风学生潮流夏\",\"goodsPrice\":null,\"goodsSpec\":\"深灰色 黑灰色,S\",\"id\":1,\"orderAmount\":null,\"orderItemId\":3490,\"orderSn\":\"230405-342695669310441\",\"params\":{},\"quantity\":1,\"refundAmount\":32,\"refundQty\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-01-14 12:09:37', 18522);
INSERT INTO `sys_oper_log` VALUES (34, '抖店订单退款', 1, 'com.qihang.erp.api.controller.DouOrderRefundController.add()', 'POST', 1, 'admin', NULL, '/dou/douRefund', '127.0.0.1', '内网IP', '{\"aftersaleId\":7149891465417507000,\"aftersaleType\":1,\"comboAmount\":29.9,\"comboNum\":1,\"goodsSpec\":\"\\t浅蓝色;L\",\"orderAmount\":null,\"orderId\":\"5030436502888242865\",\"params\":{},\"productName\":\"\\t【夏款清仓】牛仔短裤女夏高腰宽松毛边牛仔裤甜欲风辣妹阔腿新款\",\"productPic\":\"http://img.huayiyungou.com/niuzaiduanku/HN8026.jpg\",\"subOrderId\":\"\\t5030436502888242865\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-01-14 13:43:00', 16479);
INSERT INTO `sys_oper_log` VALUES (35, '菜单管理', 2, 'com.zhijian.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"shop/goods\",\"createTime\":\"2023-12-29 17:02:42\",\"icon\":\"color\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2016,\"menuName\":\"店铺商品管理\",\"menuType\":\"C\",\"orderNum\":9,\"params\":{},\"parentId\":2014,\"path\":\"shop/goods\",\"perms\":\"shop:goods\",\"query\":\"\",\"status\":\"1\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-01-14 14:04:20', 15);
INSERT INTO `sys_oper_log` VALUES (36, '菜单管理', 2, 'com.zhijian.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"\",\"createTime\":\"2023-12-31 12:14:33\",\"icon\":\"stock\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2026,\"menuName\":\"库存管理\",\"menuType\":\"M\",\"orderNum\":5,\"params\":{},\"parentId\":0,\"path\":\"wms\",\"perms\":\"\",\"query\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-01-14 15:07:56', 7);
INSERT INTO `sys_oper_log` VALUES (37, '菜单管理', 2, 'com.zhijian.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"\",\"createTime\":\"2023-12-31 12:14:33\",\"icon\":\"stock1\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2026,\"menuName\":\"库存管理\",\"menuType\":\"M\",\"orderNum\":5,\"params\":{},\"parentId\":0,\"path\":\"wms\",\"perms\":\"\",\"query\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-01-14 15:10:51', 9);
INSERT INTO `sys_oper_log` VALUES (38, '菜单管理', 2, 'com.zhijian.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"wms/stockInEntry\",\"createTime\":\"2023-12-31 12:27:37\",\"icon\":\"stockin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2027,\"menuName\":\"入库管理\",\"menuType\":\"C\",\"orderNum\":0,\"params\":{},\"parentId\":2026,\"path\":\"stock_in_entry/list\",\"perms\":\"wms:stock_in_entry:list\",\"query\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-01-14 15:12:48', 9);
INSERT INTO `sys_oper_log` VALUES (39, '商品分类', 1, 'com.qihang.erp.api.controller.ErpGoodsCategoryController.add()', 'POST', 1, 'admin', NULL, '/goods/category', '127.0.0.1', '内网IP', '{\"createTime\":\"2024-01-14 19:33:40\",\"id\":34,\"name\":\"男装\",\"number\":\"NANZ\",\"params\":{},\"parentId\":0}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-01-14 19:33:40', 94);
INSERT INTO `sys_oper_log` VALUES (40, '商品分类', 1, 'com.qihang.erp.api.controller.ErpGoodsCategoryController.add()', 'POST', 1, 'admin', NULL, '/goods/category', '127.0.0.1', '内网IP', '{\"createTime\":\"2024-01-14 19:33:56\",\"id\":35,\"name\":\"牛仔裤\",\"number\":\"NZK\",\"params\":{},\"parentId\":34}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-01-14 19:33:56', 7);
INSERT INTO `sys_oper_log` VALUES (41, '商品分类', 2, 'com.qihang.erp.api.controller.ErpGoodsCategoryController.edit()', 'PUT', 1, 'admin', NULL, '/goods/category', '127.0.0.1', '内网IP', '{\"createTime\":\"2024-01-14 19:33:57\",\"id\":35,\"isDelete\":0,\"name\":\"牛仔裤2\",\"number\":\"NZK\",\"params\":{},\"parentId\":34,\"path\":\"\",\"sort\":0,\"updateTime\":\"2024-01-14 19:34:07\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-01-14 19:34:07', 9);
INSERT INTO `sys_oper_log` VALUES (42, '商品分类', 3, 'com.qihang.erp.api.controller.ErpGoodsCategoryController.remove()', 'DELETE', 1, 'admin', NULL, '/goods/category/35', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-01-14 19:34:12', 9);
INSERT INTO `sys_oper_log` VALUES (43, '商品分类', 3, 'com.qihang.erp.api.controller.ErpGoodsCategoryController.remove()', 'DELETE', 1, 'admin', NULL, '/goods/category/34', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-01-14 19:34:17', 9);
INSERT INTO `sys_oper_log` VALUES (44, '菜单管理', 1, 'com.zhijian.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"goods/create\",\"createBy\":\"admin\",\"icon\":\"component\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"添加商品\",\"menuType\":\"C\",\"orderNum\":2,\"params\":{},\"parentId\":2006,\"path\":\"create\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-01-14 19:42:11', 17);
INSERT INTO `sys_oper_log` VALUES (45, '商品管理', 1, 'com.qihang.erp.api.controller.GoodsController.add()', 'POST', 1, 'admin', NULL, '/goods/goods', '127.0.0.1', '内网IP', '{\"categoryId\":2,\"colorValues\":[413,412],\"image\":\"http://\",\"name\":\"asaa\",\"number\":\"dsfds\",\"params\":{},\"purPrice\":122.9,\"sizeValues\":[408,407,406,405],\"specList\":[{\"colorId\":413,\"colorValue\":\"浅蓝色加绒\",\"purPrice\":null,\"sizeId\":408,\"sizeValue\":\"32\",\"styleValue\":\"\"},{\"colorId\":413,\"colorValue\":\"浅蓝色加绒\",\"purPrice\":null,\"sizeId\":407,\"sizeValue\":\"31\",\"styleValue\":\"\"},{\"colorId\":413,\"colorValue\":\"浅蓝色加绒\",\"purPrice\":null,\"sizeId\":406,\"sizeValue\":\"30\",\"styleValue\":\"\"},{\"colorId\":413,\"colorValue\":\"浅蓝色加绒\",\"purPrice\":null,\"sizeId\":405,\"sizeValue\":\"29\",\"styleValue\":\"\"},{\"colorId\":412,\"colorValue\":\"复古蓝加绒\",\"purPrice\":null,\"sizeId\":408,\"sizeValue\":\"32\",\"styleValue\":\"\"},{\"colorId\":412,\"colorValue\":\"复古蓝加绒\",\"purPrice\":null,\"sizeId\":407,\"sizeValue\":\"31\",\"styleValue\":\"\"},{\"colorId\":412,\"colorValue\":\"复古蓝加绒\",\"purPrice\":null,\"sizeId\":406,\"sizeValue\":\"30\",\"styleValue\":\"\"},{\"colorId\":412,\"colorValue\":\"复古蓝加绒\",\"purPrice\":null,\"sizeId\":405,\"sizeValue\":\"29\",\"styleValue\":\"\"}],\"supplierId\":33}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-01-14 21:23:20', 28844);
INSERT INTO `sys_oper_log` VALUES (46, '商品管理', 1, 'com.qihang.erp.api.controller.GoodsController.add()', 'POST', 1, 'admin', NULL, '/goods/goods', '127.0.0.1', '内网IP', '{\"categoryId\":2,\"colorValues\":[413,412],\"image\":\"aa\",\"name\":\"aa\",\"number\":\"aa\",\"params\":{},\"purPrice\":233,\"sizeValues\":[408,407,406],\"specList\":[{\"colorId\":413,\"colorValue\":\"浅蓝色加绒\",\"purPrice\":null,\"sizeId\":408,\"sizeValue\":\"32\",\"specNum\":\"1223\",\"styleValue\":\"\"},{\"colorId\":413,\"colorValue\":\"浅蓝色加绒\",\"purPrice\":null,\"sizeId\":407,\"sizeValue\":\"31\",\"specNum\":\"232\",\"styleValue\":\"\"},{\"colorId\":413,\"colorValue\":\"浅蓝色加绒\",\"purPrice\":null,\"sizeId\":406,\"sizeValue\":\"30\",\"specNum\":\"232\",\"styleValue\":\"\"},{\"colorId\":412,\"colorValue\":\"复古蓝加绒\",\"purPrice\":null,\"sizeId\":408,\"sizeValue\":\"32\",\"specNum\":\"232\",\"styleValue\":\"\"},{\"colorId\":412,\"colorValue\":\"复古蓝加绒\",\"purPrice\":null,\"sizeId\":407,\"sizeValue\":\"31\",\"specNum\":\"34\",\"styleValue\":\"\"},{\"colorId\":412,\"colorValue\":\"复古蓝加绒\",\"purPrice\":null,\"sizeId\":406,\"sizeValue\":\"30\",\"specNum\":\"34\",\"styleValue\":\"\"}],\"supplierId\":33}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-01-14 21:28:22', 5230);
INSERT INTO `sys_oper_log` VALUES (47, '商品管理', 1, 'com.qihang.erp.api.controller.GoodsController.add()', 'POST', 1, 'admin', NULL, '/goods/goods', '127.0.0.1', '内网IP', '{\"categoryId\":2,\"colorValues\":[413,412],\"image\":\"ASDF\",\"name\":\"ASFD\",\"number\":\"AF02551\",\"params\":{},\"purPrice\":12,\"sizeValues\":[408,406],\"specList\":[{\"colorId\":413,\"colorValue\":\"浅蓝色加绒\",\"purPrice\":null,\"sizeId\":408,\"sizeValue\":\"32\",\"specNum\":\"AF0255115032\",\"styleValue\":\"\"},{\"colorId\":413,\"colorValue\":\"浅蓝色加绒\",\"purPrice\":null,\"sizeId\":406,\"sizeValue\":\"30\",\"specNum\":\"AF0255115030\",\"styleValue\":\"\"},{\"colorId\":412,\"colorValue\":\"复古蓝加绒\",\"purPrice\":null,\"sizeId\":408,\"sizeValue\":\"32\",\"specNum\":\"AF0255114032\",\"styleValue\":\"\"},{\"colorId\":412,\"colorValue\":\"复古蓝加绒\",\"purPrice\":null,\"sizeId\":406,\"sizeValue\":\"30\",\"specNum\":\"AF0255114030\",\"styleValue\":\"\"}],\"supplierId\":33}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-01-14 21:32:30', 19313);
INSERT INTO `sys_oper_log` VALUES (48, '商品管理', 1, 'com.qihang.erp.api.controller.GoodsController.add()', 'POST', 1, 'admin', NULL, '/goods/goods', '127.0.0.1', '内网IP', '{\"categoryId\":2,\"colorValues\":[413,412],\"createBy\":\"admin\",\"createTime\":\"2024-01-14 21:52:29\",\"id\":71,\"image\":\"aaa\",\"name\":\"aaa\",\"number\":\"aaaaa\",\"params\":{},\"purPrice\":12,\"sizeValues\":[406,405],\"specList\":[{\"colorId\":413,\"colorValue\":\"浅蓝色加绒\",\"sizeId\":406,\"sizeValue\":\"30\",\"specNum\":\"aaaaa15030\",\"styleValue\":\"\"},{\"colorId\":413,\"colorValue\":\"浅蓝色加绒\",\"sizeId\":405,\"sizeValue\":\"29\",\"specNum\":\"aaaaa15029\",\"styleValue\":\"\"},{\"colorId\":412,\"colorValue\":\"复古蓝加绒\",\"sizeId\":406,\"sizeValue\":\"30\",\"specNum\":\"aaaaa14030\",\"styleValue\":\"\"},{\"colorId\":412,\"colorValue\":\"复古蓝加绒\",\"sizeId\":405,\"sizeValue\":\"29\",\"specNum\":\"aaaaa14029\",\"styleValue\":\"\"}],\"supplierId\":33}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-01-14 21:52:45', 22292);
INSERT INTO `sys_oper_log` VALUES (49, '代码生成', 6, 'com.zhijian.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', NULL, '/tool/gen/importTable', '127.0.0.1', '内网IP', '{\"tables\":\"sys_oss\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-01-15 15:25:41', 370);
INSERT INTO `sys_oper_log` VALUES (50, '代码生成', 8, 'com.zhijian.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', NULL, '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"sys_oss\"}', NULL, 0, NULL, '2024-01-15 15:25:45', 417);
INSERT INTO `sys_oper_log` VALUES (51, '商品管理', 1, 'com.qihang.erp.api.controller.GoodsController.add()', 'POST', 1, 'admin', NULL, '/goods/goods', '127.0.0.1', '内网IP', '{\"categoryId\":2,\"colorImages\":{\"412\":\"http://localhost:8080/preview/images/49\",\"413\":\"http://localhost:8080/preview/images/48\"},\"colorNames\":{\"412\":\"复古蓝加绒\",\"413\":\"浅蓝色加绒\"},\"colorValues\":[413,412],\"createBy\":\"admin\",\"image\":\"http://localhost:8080/preview/images/47\",\"name\":\"测试测试\",\"number\":\"A0012D\",\"params\":{},\"purPrice\":12,\"sizeValues\":[408,407],\"specList\":[{\"colorId\":413,\"colorValue\":\"浅蓝色加绒\",\"sizeId\":408,\"sizeValue\":\"32\",\"specNum\":\"A0012D15032\",\"styleValue\":\"\"},{\"colorId\":413,\"colorValue\":\"浅蓝色加绒\",\"sizeId\":407,\"sizeValue\":\"31\",\"specNum\":\"A0012D15031\",\"styleValue\":\"\"},{\"colorId\":412,\"colorValue\":\"复古蓝加绒\",\"sizeId\":408,\"sizeValue\":\"32\",\"specNum\":\"A0012D14032\",\"styleValue\":\"\"},{\"colorId\":412,\"colorValue\":\"复古蓝加绒\",\"sizeId\":407,\"sizeValue\":\"31\",\"specNum\":\"A0012D14031\",\"styleValue\":\"\"}],\"supplierId\":33}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-01-16 10:29:29', 127497);
INSERT INTO `sys_oper_log` VALUES (52, '商品管理', 1, 'com.qihang.erp.api.controller.GoodsController.add()', 'POST', 1, 'admin', NULL, '/goods/goods', '127.0.0.1', '内网IP', '{\"categoryId\":2,\"colorImages\":{\"412\":\"http://localhost:8080/preview/images/49\",\"413\":\"http://localhost:8080/preview/images/48\"},\"colorValues\":[413,412],\"createBy\":\"admin\",\"createTime\":\"2024-01-16 10:34:33\",\"id\":74,\"image\":\"http://localhost:8080/preview/images/47\",\"name\":\"测试测试\",\"number\":\"A0012D\",\"params\":{},\"purPrice\":12,\"sizeValues\":[408,407],\"specList\":[{\"colorId\":413,\"colorValue\":\"浅蓝色加绒\",\"sizeId\":408,\"sizeValue\":\"32\",\"specNum\":\"A0012D15032\",\"styleValue\":\"\"},{\"colorId\":413,\"colorValue\":\"浅蓝色加绒\",\"sizeId\":407,\"sizeValue\":\"31\",\"specNum\":\"A0012D15031\",\"styleValue\":\"\"},{\"colorId\":412,\"colorValue\":\"复古蓝加绒\",\"sizeId\":408,\"sizeValue\":\"32\",\"specNum\":\"A0012D14032\",\"styleValue\":\"\"},{\"colorId\":412,\"colorValue\":\"复古蓝加绒\",\"sizeId\":407,\"sizeValue\":\"31\",\"specNum\":\"A0012D14031\",\"styleValue\":\"\"}],\"supplierId\":33}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-01-16 10:34:33', 262);
INSERT INTO `sys_oper_log` VALUES (53, '菜单管理', 2, 'com.zhijian.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"\",\"createTime\":\"2023-12-27 15:00:27\",\"icon\":\"tool\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":3,\"menuName\":\"系统工具\",\"menuType\":\"M\",\"orderNum\":101,\"params\":{},\"parentId\":0,\"path\":\"tool\",\"perms\":\"\",\"query\":\"\",\"status\":\"1\",\"updateBy\":\"admin\",\"visible\":\"1\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-01-16 10:44:35', 314);
INSERT INTO `sys_oper_log` VALUES (54, '菜单管理', 2, 'com.zhijian.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"\",\"createTime\":\"2023-12-27 15:00:27\",\"icon\":\"tool\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":3,\"menuName\":\"系统工具\",\"menuType\":\"M\",\"orderNum\":101,\"params\":{},\"parentId\":0,\"path\":\"tool\",\"perms\":\"\",\"query\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"1\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-01-16 10:45:25', 26);
INSERT INTO `sys_oper_log` VALUES (55, '淘宝订单', 2, 'com.qihang.erp.api.controller.TaoOrderController.confirmOrder()', 'POST', 1, 'admin', NULL, '/tao/order/confirmOrder', '127.0.0.1', '内网IP', '{\"address\":\"吉林吉林省松原市扶余市 三井子镇 里\",\"auditStatus\":0,\"auditTime\":\"2022-07-31\",\"buyerName\":\"\",\"city\":\"\",\"closeReason\":\"\",\"createTime\":\"2022-07-31 18:13:59\",\"discountAmount\":0,\"discountRemark\":\"\",\"id\":\"1631273557325601885\",\"isMerge\":0,\"logisticsCode\":\"432700565699461\",\"logisticsCompany\":\"韵达速递\",\"orderCreateTime\":\"2022-07-31\",\"orderModifyTime\":\"2022-07-31\",\"orderSource\":0,\"params\":{},\"payAmount\":28.9,\"payTime\":\"2022-07-31\",\"phone\":\"18704389133\",\"province\":\"吉林\",\"receiver\":\"王淑芳\",\"sellerMemo\":\"\",\"sendStatus\":0,\"sendTime\":\"2022-07-31\",\"shipType\":0,\"shippingFee\":0,\"shopId\":6,\"status\":3,\"statusStr\":\"等待买家确认收货\",\"taoOrderItemList\":[],\"totalAmount\":28.9,\"updateBy\":\"admin\",\"updateTime\":\"2022-07-31 19:55:48\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-01-16 13:44:26', 127);
INSERT INTO `sys_oper_log` VALUES (56, '仓库订单发货', 1, 'com.qihang.erp.api.controller.WmsOrderShippingController.stockingAdd()', 'POST', 1, 'admin', NULL, '/wms/shipping/stockingAdd', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2024-01-16 14:10:02.57\",\"ids\":[11],\"stockOutNum\":\"202401161410022\"}', '{\"msg\":\"商品库存不足！\",\"code\":503}', 0, NULL, '2024-01-16 14:10:05', 39);
INSERT INTO `sys_oper_log` VALUES (57, '代码生成', 6, 'com.zhijian.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', NULL, '/tool/gen/importTable', '127.0.0.1', '内网IP', '{\"tables\":\"erp_goods_spec\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-01-16 14:12:38', 220);
INSERT INTO `sys_oper_log` VALUES (58, '代码生成', 2, 'com.zhijian.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', NULL, '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"goodsSpec\",\"className\":\"ErpGoodsSpec\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"主键id\",\"columnId\":1205,\"columnName\":\"id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2024-01-16 14:12:38\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":54,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"GoodsId\",\"columnComment\":\"商品id\",\"columnId\":1206,\"columnName\":\"goods_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2024-01-16 14:12:38\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"goodsId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":54,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"SpecName\",\"columnComment\":\"规格名\",\"columnId\":1207,\"columnName\":\"spec_name\",\"columnType\":\"varchar(50)\",\"createBy\":\"admin\",\"createTime\":\"2024-01-16 14:12:38\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"specName\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":54,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"SpecNum\",\"columnComment\":\"规格编码\",\"columnId\":1208,\"columnName\":\"spec_num\",\"columnType\":\"varchar(25)\",\"createBy\":\"admin\",\"createTime\":\"2024-01-16 14:12:38\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"specNum\",\"javaType\":\"St', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-01-16 14:12:56', 122);
INSERT INTO `sys_oper_log` VALUES (59, '代码生成', 8, 'com.zhijian.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', NULL, '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"erp_goods_spec\"}', NULL, 0, NULL, '2024-01-16 14:13:01', 653);
INSERT INTO `sys_oper_log` VALUES (60, '菜单管理', 1, 'com.zhijian.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"goods/spec\",\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"商品规格查询\",\"menuType\":\"C\",\"orderNum\":3,\"params\":{},\"parentId\":2006,\"path\":\"spec_list\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-01-16 14:17:39', 29);
INSERT INTO `sys_oper_log` VALUES (61, '菜单管理', 2, 'com.zhijian.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"goods/spec\",\"createTime\":\"2024-01-16 14:17:39\",\"icon\":\"theme\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2067,\"menuName\":\"商品规格查询\",\"menuType\":\"C\",\"orderNum\":3,\"params\":{},\"parentId\":2006,\"path\":\"spec_list\",\"perms\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-01-16 14:18:10', 13);
INSERT INTO `sys_oper_log` VALUES (62, '采购订单', 1, 'com.qihang.erp.api.controller.ScmPurchaseOrderController.add()', 'POST', 1, 'admin', NULL, '/purchase/purchaseOrder', '127.0.0.1', '内网IP', '{\"contactId\":33,\"createBy\":\"admin\",\"goodsList\":[{\"amount\":190,\"colorImage\":\"https://cbu01.alicdn.com/img/ibank/O1CN01AfNgvA2FOyAvwXZxv_!!2208857268871-0-cib.jpg\",\"colorValue\":\"黑色\",\"goodsId\":9,\"id\":32,\"name\":\"HN8026牛仔短裤\",\"number\":\"HN8026\",\"purPrice\":19,\"qty\":10,\"sizeValue\":\"2XL\",\"specNum\":\"2720210080260105\",\"styleValue\":\"\"}],\"orderAmount\":190,\"orderDate\":\"2024-01-16 00:00:00\",\"params\":{}}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-01-16 14:44:08', 86);
INSERT INTO `sys_oper_log` VALUES (63, '采购订单', 2, 'com.qihang.erp.api.controller.ScmPurchaseOrderController.edit()', 'PUT', 1, 'admin', NULL, '/purchase/purchaseOrder', '127.0.0.1', '内网IP', '{\"auditUser\":\"启航\",\"id\":466,\"optionType\":\"audit\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-01-16 14:44:21', 14);
INSERT INTO `sys_oper_log` VALUES (64, '采购订单', 2, 'com.qihang.erp.api.controller.ScmPurchaseOrderController.edit()', 'PUT', 1, 'admin', NULL, '/purchase/purchaseOrder', '127.0.0.1', '内网IP', '{\"auditUser\":\"启航\",\"confirmUser\":\"启航\",\"id\":466,\"optionType\":\"confirm\",\"totalAmount\":190,\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-01-16 14:44:30', 48);
INSERT INTO `sys_oper_log` VALUES (65, '采购订单', 2, 'com.qihang.erp.api.controller.ScmPurchaseOrderController.edit()', 'PUT', 1, 'admin', NULL, '/purchase/purchaseOrder', '127.0.0.1', '内网IP', '{\"auditUser\":\"启航\",\"id\":466,\"optionType\":\"SupplierShip\",\"shipCompany\":\"菜鸟速递\",\"shipCost\":0,\"shipNo\":\"CN223533300022\",\"supplierDeliveryTime\":\"2024-01-16 00:00:00\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-01-16 14:49:49', 24);
INSERT INTO `sys_oper_log` VALUES (66, '采购订单物流', 2, 'com.qihang.erp.api.controller.ScmPurchaseOrderShipController.confirmReceipt()', 'PUT', 1, 'admin', NULL, '/purchase/PurchaseOrderShip', '127.0.0.1', '内网IP', '{\"backCount\":0,\"createBy\":\"admin\",\"createTime\":\"2024-01-16 14:49:49\",\"freight\":0,\"id\":466,\"orderDate\":\"2024-01-16\",\"orderGoodsUnit\":1,\"orderNo\":\"PUR20240116144408\",\"orderSpecUnit\":1,\"orderSpecUnitTotal\":10,\"params\":{},\"receiptTime\":\"2024-01-16 00:00:00\",\"shipCompany\":\"菜鸟速递\",\"shipNo\":\"CN223533300022\",\"shipTime\":\"2024-01-16\",\"status\":0,\"stockInCount\":0,\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-01-16 14:50:46', 16);
INSERT INTO `sys_oper_log` VALUES (67, '采购订单物流', 2, 'com.qihang.erp.api.controller.ScmPurchaseOrderShipController.createStockInEntry()', 'POST', 1, 'admin', NULL, '/purchase/PurchaseOrderShip/createStockInEntry', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2024-01-16 14:44:09\",\"goodsList\":[{\"colorImage\":\"https://cbu01.alicdn.com/img/ibank/O1CN01AfNgvA2FOyAvwXZxv_!!2208857268871-0-cib.jpg\",\"colorValue\":\"黑色\",\"goodsId\":9,\"goodsName\":\"HN8026牛仔短裤\",\"goodsNum\":\"HN8026\",\"id\":1962,\"inQty\":10,\"orderId\":466,\"params\":{},\"quantity\":10,\"remark\":\"\",\"sizeValue\":\"2XL\",\"specId\":32,\"specNum\":\"2720210080260105\",\"styleValue\":\"\"}],\"id\":466,\"params\":{},\"updateBy\":\"admin\",\"updateTime\":\"2024-01-16 14:50:46\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-01-16 14:50:57', 39);
INSERT INTO `sys_oper_log` VALUES (68, '入库单', 2, 'com.qihang.erp.api.controller.WmsStockInEntryController.stockIn()', 'POST', 1, 'admin', NULL, '/wms/WmsStockInEntry/stockIn', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2024-01-16 14:50:58\",\"id\":8,\"no\":\"20240116145057\",\"params\":{},\"sourceGoodsUnit\":1,\"sourceId\":466,\"sourceNo\":\"PUR20240116144408\",\"sourceSpecUnit\":1,\"sourceSpecUnitTotal\":10,\"sourceType\":1,\"status\":0,\"stockInOperator\":\"启航\",\"stockInOperatorId\":1,\"stockInTime\":\"2024-01-16 00:00:00\",\"updateBy\":\"admin\",\"wmsStockInEntryItemList\":[{\"colorImage\":\"https://cbu01.alicdn.com/img/ibank/O1CN01AfNgvA2FOyAvwXZxv_!!2208857268871-0-cib.jpg\",\"colorValue\":\"黑色\",\"createBy\":\"admin\",\"createTime\":\"2024-01-16 14:50:58\",\"entryId\":8,\"goodsId\":9,\"goodsName\":\"HN8026牛仔短裤\",\"goodsNum\":\"HN8026\",\"id\":4,\"inQuantity\":0,\"locationId\":20,\"locationNum\":\"A01-1-16\",\"originalQuantity\":10,\"params\":{},\"quantity\":10,\"remark\":\"\",\"sizeValue\":\"2XL\",\"sourceId\":466,\"sourceItemId\":1962,\"sourceType\":1,\"specId\":32,\"specNum\":\"2720210080260105\",\"status\":0,\"styleValue\":\"\",\"totalQuantity\":10}]}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-01-16 14:51:50', 42);
INSERT INTO `sys_oper_log` VALUES (69, '仓库订单发货', 1, 'com.qihang.erp.api.controller.WmsOrderShippingController.stockingAdd()', 'POST', 1, 'admin', NULL, '/wms/shipping/stockingAdd', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2024-01-16 14:52:27.889\",\"ids\":[11],\"stockOutNum\":\"202401161452276\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-01-16 14:52:29', 30);
INSERT INTO `sys_oper_log` VALUES (70, '出库单', 1, 'com.qihang.erp.api.controller.WmsStockOutEntryController.stockOut()', 'POST', 1, 'admin', NULL, '/wms/stockOutEntry/stockOut', '127.0.0.1', '内网IP', '{\"entryId\":2,\"entryItemId\":8,\"inventoryDetailId\":7,\"operatorId\":1,\"operatorName\":\"admin\",\"outQty\":1,\"specId\":32}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-01-16 14:52:43', 45);
INSERT INTO `sys_oper_log` VALUES (71, '出库单', 1, 'com.qihang.erp.api.controller.WmsStockOutEntryController.stockOut()', 'POST', 1, 'admin', NULL, '/wms/stockOutEntry/stockOut', '127.0.0.1', '内网IP', '{\"entryId\":2,\"entryItemId\":8,\"inventoryDetailId\":7,\"operatorId\":1,\"operatorName\":\"admin\",\"outQty\":1,\"specId\":32}', '{\"msg\":\"状态错误！\",\"code\":502}', 0, NULL, '2024-01-16 14:53:11', 8);
INSERT INTO `sys_oper_log` VALUES (72, '淘宝订单', 2, 'com.qihang.erp.api.controller.TaoOrderController.confirmOrder()', 'POST', 1, 'admin', NULL, '/tao/order/confirmOrder', '127.0.0.1', '内网IP', '{\"address\":\"上海上海 上海市 徐汇区 天平路街道 建国西路382号三楼4室 \",\"auditStatus\":0,\"auditTime\":\"2022-08-13\",\"buyerName\":\"\",\"city\":\"\",\"closeReason\":\"\",\"createTime\":\"2022-08-13 19:09:13\",\"discountAmount\":0,\"discountRemark\":\"\",\"id\":\"1642473483353670599\",\"isMerge\":0,\"logisticsCode\":\"432723807526979\",\"logisticsCompany\":\"韵达速递\",\"orderCreateTime\":\"2022-08-13\",\"orderModifyTime\":\"2022-08-13\",\"orderSource\":0,\"params\":{},\"payAmount\":29.92,\"payTime\":\"2022-08-13\",\"phone\":\"17321293202\",\"province\":\"上海\",\"receiver\":\"戴志兰\",\"sellerMemo\":\"\",\"sendStatus\":0,\"sendTime\":\"2022-08-13\",\"shipType\":0,\"shippingFee\":0,\"shopId\":6,\"status\":3,\"statusStr\":\"等待买家确认收货\",\"taoOrderItemList\":[],\"totalAmount\":29.92,\"updateBy\":\"admin\",\"updateTime\":\"2022-08-13 21:23:33\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-01-16 15:04:52', 73);
INSERT INTO `sys_oper_log` VALUES (73, '仓库订单发货', 1, 'com.qihang.erp.api.controller.WmsOrderShippingController.stockingAdd()', 'POST', 1, 'admin', NULL, '/wms/shipping/stockingAdd', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2024-01-16 15:04:59.9\",\"ids\":[12],\"stockOutNum\":\"202401161504597\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-01-16 15:05:01', 14);
INSERT INTO `sys_oper_log` VALUES (74, '出库单', 1, 'com.qihang.erp.api.controller.WmsStockOutEntryController.stockOut()', 'POST', 1, 'admin', NULL, '/wms/stockOutEntry/stockOut', '127.0.0.1', '内网IP', '{\"entryId\":3,\"entryItemId\":9,\"inventoryDetailId\":7,\"operatorId\":1,\"operatorName\":\"admin\",\"outQty\":1,\"specId\":32}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-01-16 15:06:05', 43952);
INSERT INTO `sys_oper_log` VALUES (75, '菜单管理', 2, 'com.zhijian.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"bill/orderShipCost\",\"createTime\":\"2024-01-12 18:35:31\",\"icon\":\"guide\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2063,\"menuName\":\"发货物流账单\",\"menuType\":\"C\",\"orderNum\":3,\"params\":{},\"parentId\":2018,\"path\":\"orderShipCost\",\"perms\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-01-16 15:28:42', 33);
INSERT INTO `sys_oper_log` VALUES (76, '菜单管理', 2, 'com.zhijian.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2024-01-12 18:35:55\",\"icon\":\"example\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2064,\"menuName\":\"店铺账单管理\",\"menuType\":\"M\",\"orderNum\":4,\"params\":{},\"parentId\":2018,\"path\":\"s\",\"perms\":\"\",\"status\":\"1\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-01-16 15:28:47', 12);
INSERT INTO `sys_oper_log` VALUES (77, '菜单管理', 2, 'com.zhijian.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2024-01-12 18:35:02\",\"icon\":\"theme\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2062,\"menuName\":\"代发账单管理\",\"menuType\":\"C\",\"orderNum\":2,\"params\":{},\"parentId\":2018,\"path\":\"d\",\"perms\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-01-16 15:29:08', 13);
INSERT INTO `sys_oper_log` VALUES (78, '店铺订单', 2, 'com.qihang.erp.api.controller.ErpOrderController.ship()', 'POST', 1, 'admin', NULL, '/api/order/ship', '127.0.0.1', '内网IP', '{\"address\":\"上海上海 上海市 徐汇区 天平路街道 建国西路382号三楼4室 \",\"amount\":29.92,\"city\":\"\",\"confirmTime\":\"2024-01-16\",\"country\":\"中国\",\"createBy\":\"admin\",\"createTime\":\"2024-01-16 15:04:52\",\"discountAmount\":0,\"erpOrderItemList\":[{\"createBy\":\"admin\",\"createTime\":\"2024-01-16 15:04:52\",\"goodsId\":9,\"goodsImg\":\"https://cbu01.alicdn.com/img/ibank/O1CN01AfNgvA2FOyAvwXZxv_!!2208857268871-0-cib.jpg\",\"goodsNum\":\"272021008026\",\"goodsPrice\":29.92,\"goodsSpec\":\"黑色,2XL\",\"goodsTitle\":\"8026牛仔短裤\",\"id\":13,\"isGift\":0,\"itemAmount\":29.92,\"orderId\":16,\"orderItemNum\":\"1642473483353670599\",\"params\":{},\"quantity\":1,\"refundCount\":0,\"refundStatus\":1,\"specId\":32,\"specNum\":\"2720210080260105\",\"supplierId\":26}],\"goodsAmount\":29.92,\"height\":19.0,\"id\":16,\"length\":20.0,\"orderNum\":\"1642473483353670599\",\"orderStatus\":2,\"params\":{},\"payTime\":\"2022-08-13\",\"postage\":0,\"province\":\"上海\",\"receiverName\":\"戴志兰\",\"receiverPhone\":\"17321293202\",\"refundStatus\":1,\"shipType\":0,\"shippingCompany\":\"菜鸟速递\",\"shippingCost\":3,\"shippingMan\":\"启航\",\"shippingNumber\":\"CN2210003552\",\"shopId\":6,\"shopType\":4,\"town\":\"\",\"updateBy\":\"admin\",\"updateTime\":\"2024-01-16 15:05:56\",\"weight\":409.0,\"width\":56.0}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-01-16 15:42:53', 17950);
INSERT INTO `sys_oper_log` VALUES (79, '代码生成', 6, 'com.zhijian.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', NULL, '/tool/gen/importTable', '127.0.0.1', '内网IP', '{\"tables\":\"s_shop_setting\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-01-18 17:42:22', 344);
INSERT INTO `sys_oper_log` VALUES (80, '代码生成', 2, 'com.zhijian.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', NULL, '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"shopSetting\",\"className\":\"ShopSetting\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"主键\",\"columnId\":1226,\"columnName\":\"id\",\"columnType\":\"int\",\"createBy\":\"admin\",\"createTime\":\"2024-01-18 17:42:22\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isPk\":\"1\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":55,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Name\",\"columnComment\":\"配置名\",\"columnId\":1227,\"columnName\":\"name\",\"columnType\":\"varchar(50)\",\"createBy\":\"admin\",\"createTime\":\"2024-01-18 17:42:22\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"name\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":55,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"AppKey\",\"columnComment\":\"appKey\",\"columnId\":1228,\"columnName\":\"app_key\",\"columnType\":\"varchar(50)\",\"createBy\":\"admin\",\"createTime\":\"2024-01-18 17:42:22\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"appKey\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":55,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"AppSecret\",\"columnComment\":\"appSecret\",\"columnId\":1229,\"columnName\":\"app_secret\",\"columnType\":\"varchar(50)\",\"createBy\":\"admin\",\"createTime\":\"2024-01-18 17:42:22\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"appSecre', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-01-18 17:43:02', 109);
INSERT INTO `sys_oper_log` VALUES (81, '代码生成', 8, 'com.zhijian.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', NULL, '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"s_shop_setting\"}', NULL, 0, NULL, '2024-01-18 17:43:15', 534);
INSERT INTO `sys_oper_log` VALUES (82, '店铺', 2, 'com.qihang.erp.api.controller.ShopController.edit()', 'PUT', 1, 'admin', NULL, '/shop/shop', '127.0.0.1', '内网IP', '{\"appSercet\":\"\",\"appkey\":\"\",\"company\":\"华衣云商\",\"ename\":\"douyin\",\"id\":22,\"isDelete\":0,\"isShow\":1,\"modifyOn\":1653672695,\"name\":\"梦小妮牛仔裤\",\"nickName\":\"抖音-梦小妮\",\"orderNum\":87,\"params\":{},\"sellerUserId\":0,\"sellerUserIdStr\":\"0\",\"sessionKey\":\"\",\"type\":6,\"url\":\"http://openapi.jinritemai.com\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-01-18 19:46:21', 21);
INSERT INTO `sys_oper_log` VALUES (83, '店铺', 2, 'com.qihang.erp.api.controller.ShopController.edit()', 'PUT', 1, 'admin', NULL, '/shop/shop', '127.0.0.1', '内网IP', '{\"apiRequestUrl\":\"http://gw.api.taobao.com/router/rest\",\"appSercet\":\"7b0769269b0c0ca88949791c14eb3a5c\",\"appkey\":\"31014100\",\"company\":\"煜梦服饰\",\"ename\":\"taobao\",\"id\":6,\"isDelete\":0,\"isShow\":1,\"modifyOn\":0,\"name\":\"梦小妮牛仔裤\",\"nickName\":\"淘宝-梦小妮\",\"orderNum\":98,\"params\":{},\"remark\":\"\",\"sellerUserId\":2200787809358,\"sellerUserIdStr\":\"0\",\"sessionKey\":\"610140071d1070a37cecea89f1c1f3d6e5d19bf4b58dd942200787809358\",\"type\":4,\"url\":\"\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-01-18 19:56:00', 28);
INSERT INTO `sys_oper_log` VALUES (84, '店铺', 2, 'com.qihang.erp.api.controller.ShopController.edit()', 'PUT', 1, 'admin', NULL, '/shop/shop', '127.0.0.1', '内网IP', '{\"apiRequestUrl\":\"http://gw.api.taobao.com/router/rest\",\"appSercet\":\"7b0769269b0c0ca88949791c14eb3a5c\",\"appkey\":\"31014100\",\"company\":\"煜梦服饰\",\"ename\":\"taobao\",\"id\":6,\"isDelete\":0,\"isShow\":1,\"modifyOn\":0,\"name\":\"梦小妮牛仔裤\",\"nickName\":\"淘宝-梦小妮\",\"orderNum\":98,\"params\":{},\"remark\":\"\",\"sellerUserId\":2200787809358,\"sellerUserIdStr\":\"0\",\"sessionKey\":\"610140071d1070a37cecea89f1c1f3d6e5d19bf4b58dd942200787809358\",\"type\":4,\"url\":\"\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-01-18 19:57:45', 27);
INSERT INTO `sys_oper_log` VALUES (85, '菜单管理', 2, 'com.zhijian.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"\",\"createTime\":\"2023-12-29 17:07:23\",\"icon\":\"money\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2018,\"menuName\":\"财务管理\",\"menuType\":\"M\",\"orderNum\":6,\"params\":{},\"parentId\":0,\"path\":\"fms\",\"perms\":\"\",\"query\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-01-28 11:21:32', 18);
INSERT INTO `sys_oper_log` VALUES (86, '菜单管理', 2, 'com.zhijian.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"scm/purchase/cost\",\"createTime\":\"2023-12-29 17:09:32\",\"icon\":\"shopping\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2019,\"menuName\":\"采购账单管理\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2018,\"path\":\"purchase\",\"perms\":\"\",\"query\":\"\",\"status\":\"1\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-01-28 11:22:15', 10);
INSERT INTO `sys_oper_log` VALUES (87, '菜单管理', 1, 'com.zhijian.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"icon\":\"example\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"应收管理\",\"menuType\":\"M\",\"orderNum\":1,\"params\":{},\"parentId\":2018,\"path\":\"receivable\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-01-28 11:23:36', 10);
INSERT INTO `sys_oper_log` VALUES (88, '菜单管理', 1, 'com.zhijian.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"icon\":\"checkbox\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"商品销售收入\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2068,\"path\":\"order\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-01-28 11:24:35', 9);
INSERT INTO `sys_oper_log` VALUES (89, '菜单管理', 2, 'com.zhijian.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2024-01-28 11:24:35\",\"icon\":\"checkbox\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2069,\"menuName\":\"订单应收\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2068,\"path\":\"order\",\"perms\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-01-28 11:25:16', 10);
INSERT INTO `sys_oper_log` VALUES (90, '菜单管理', 1, 'com.zhijian.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"icon\":\"bug\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"退款款项\",\"menuType\":\"M\",\"orderNum\":2,\"params\":{},\"parentId\":2068,\"path\":\"refund\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-01-28 11:26:55', 7);
INSERT INTO `sys_oper_log` VALUES (91, '菜单管理', 2, 'com.zhijian.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2024-01-28 11:24:35\",\"icon\":\"checkbox\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2069,\"menuName\":\"订单收入\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2068,\"path\":\"order\",\"perms\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-01-28 11:27:25', 11);
INSERT INTO `sys_oper_log` VALUES (92, '菜单管理', 1, 'com.zhijian.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"icon\":\"cascader\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"平台服务费\",\"menuType\":\"M\",\"orderNum\":3,\"params\":{},\"parentId\":2068,\"path\":\"service_fee\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-01-28 11:28:03', 8);
INSERT INTO `sys_oper_log` VALUES (93, '菜单管理', 1, 'com.zhijian.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"icon\":\"clipboard\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"应付管理\",\"menuType\":\"M\",\"orderNum\":2,\"params\":{},\"parentId\":2018,\"path\":\"payable\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-01-28 11:29:21', 7);
INSERT INTO `sys_oper_log` VALUES (94, '菜单管理', 2, 'com.zhijian.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2024-01-12 18:35:02\",\"icon\":\"theme\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2062,\"menuName\":\"代发账单\",\"menuType\":\"C\",\"orderNum\":2,\"params\":{},\"parentId\":2072,\"path\":\"d\",\"perms\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-01-28 11:29:56', 9);
INSERT INTO `sys_oper_log` VALUES (95, '菜单管理', 1, 'com.zhijian.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"icon\":\"component\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"采购应付\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2072,\"path\":\"purchase\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-01-28 11:30:49', 23);
INSERT INTO `sys_oper_log` VALUES (96, '菜单管理', 2, 'com.zhijian.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"bill/orderShipCost\",\"createTime\":\"2024-01-12 18:35:31\",\"icon\":\"guide\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2063,\"menuName\":\"物流费用\",\"menuType\":\"C\",\"orderNum\":3,\"params\":{},\"parentId\":2072,\"path\":\"orderShipCost\",\"perms\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-01-28 11:31:38', 9);
INSERT INTO `sys_oper_log` VALUES (97, '菜单管理', 1, 'com.zhijian.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"icon\":\"cascader\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"采购退货\",\"menuType\":\"C\",\"orderNum\":2,\"params\":{},\"parentId\":2072,\"path\":\"return\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-01-28 11:32:21', 9);
INSERT INTO `sys_oper_log` VALUES (98, '菜单管理', 2, 'com.zhijian.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2024-01-12 18:35:02\",\"icon\":\"theme\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2062,\"menuName\":\"代发账单\",\"menuType\":\"C\",\"orderNum\":3,\"params\":{},\"parentId\":2072,\"path\":\"daifa\",\"perms\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-01-28 11:32:39', 8);
INSERT INTO `sys_oper_log` VALUES (99, '菜单管理', 2, 'com.zhijian.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"bill/orderShipCost\",\"createTime\":\"2024-01-12 18:35:31\",\"icon\":\"guide\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2063,\"menuName\":\"物流费用\",\"menuType\":\"C\",\"orderNum\":3,\"params\":{},\"parentId\":2072,\"path\":\"shipCost\",\"perms\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-01-28 11:32:53', 8);
INSERT INTO `sys_oper_log` VALUES (100, '菜单管理', 1, 'com.zhijian.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"icon\":\"cascader\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"营销费用\",\"menuType\":\"C\",\"orderNum\":5,\"params\":{},\"parentId\":2072,\"path\":\"market_fee\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-01-28 11:33:37', 10);
INSERT INTO `sys_oper_log` VALUES (101, '菜单管理', 1, 'com.zhijian.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"icon\":\"clipboard\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"其他费用\",\"menuType\":\"C\",\"orderNum\":6,\"params\":{},\"parentId\":2072,\"path\":\"other_fee\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-01-28 11:34:01', 6);
INSERT INTO `sys_oper_log` VALUES (102, '菜单管理', 1, 'com.zhijian.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"icon\":\"druid\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"存货报表\",\"menuType\":\"C\",\"orderNum\":3,\"params\":{},\"parentId\":2018,\"path\":\"inventory_report\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-01-28 11:36:05', 9);
INSERT INTO `sys_oper_log` VALUES (103, '采购订单', 1, 'com.qihang.erp.api.controller.ScmPurchaseOrderController.add()', 'POST', 1, 'admin', NULL, '/purchase/purchaseOrder', '127.0.0.1', '内网IP', '{\"contactId\":33,\"createBy\":\"admin\",\"goodsList\":[{\"amount\":42,\"colorImage\":\"https://cbu01.alicdn.com/img/ibank/O1CN01yp4pfJ2FOyGRQhOVF_!!2208857268871-0-cib.jpg\",\"colorValue\":\"浅蓝色\",\"goodsId\":29,\"id\":438,\"name\":\"HNP182弹力紧身贴标牛仔短裤女ins\",\"number\":\"HNP182\",\"purPrice\":21,\"qty\":2,\"sizeValue\":\"XL\",\"specNum\":\"HNP1825004\",\"styleValue\":\"\"}],\"orderAmount\":42,\"orderDate\":\"2024-01-28 00:00:00\",\"params\":{}}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-01-28 11:36:56', 30);
INSERT INTO `sys_oper_log` VALUES (104, '采购订单', 2, 'com.qihang.erp.api.controller.ScmPurchaseOrderController.edit()', 'PUT', 1, 'admin', NULL, '/purchase/purchaseOrder', '127.0.0.1', '内网IP', '{\"auditUser\":\"启航\",\"id\":467,\"optionType\":\"audit\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-01-28 11:37:11', 11);
INSERT INTO `sys_oper_log` VALUES (105, '采购订单', 2, 'com.qihang.erp.api.controller.ScmPurchaseOrderController.edit()', 'PUT', 1, 'admin', NULL, '/purchase/purchaseOrder', '127.0.0.1', '内网IP', '{\"auditUser\":\"启航\",\"confirmUser\":\"启航\",\"id\":467,\"optionType\":\"confirm\",\"totalAmount\":42,\"updateBy\":\"admin\"}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLSyntaxErrorException: Table \'qihang-erp.scm_purchase_order_cost\' doesn\'t exist\r\n### The error may exist in file [D:\\projects\\qihang.ecom.erp\\ecerp-api\\target\\classes\\mapper\\api\\ScmPurchaseOrderCostMapper.xml]\r\n### The error may involve com.qihang.erp.api.mapper.ScmPurchaseOrderCostMapper.insertScmPurchaseOrderCost-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into scm_purchase_order_cost          ( id,             order_amount,             order_date,             order_no,             order_spec_unit,             order_goods_unit,             order_spec_unit_total,             actual_amount,             freight,             confirm_user,             confirm_time,             create_by,             pay_amount,                          pay_count,                          status )           values ( ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,                          ?,                          ? )\r\n### Cause: java.sql.SQLSyntaxErrorException: Table \'qihang-erp.scm_purchase_order_cost\' doesn\'t exist\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: Table \'qihang-erp.scm_purchase_order_cost\' doesn\'t exist', '2024-01-28 11:37:18', 14);
INSERT INTO `sys_oper_log` VALUES (106, '采购订单', 2, 'com.qihang.erp.api.controller.ScmPurchaseOrderController.edit()', 'PUT', 1, 'admin', NULL, '/purchase/purchaseOrder', '127.0.0.1', '内网IP', '{\"auditUser\":\"启航\",\"confirmUser\":\"启航\",\"id\":467,\"optionType\":\"confirm\",\"totalAmount\":42,\"updateBy\":\"admin\"}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLSyntaxErrorException: Table \'qihang-erp.scm_purchase_order_cost\' doesn\'t exist\r\n### The error may exist in file [D:\\projects\\qihang.ecom.erp\\ecerp-api\\target\\classes\\mapper\\api\\ScmPurchaseOrderCostMapper.xml]\r\n### The error may involve com.qihang.erp.api.mapper.ScmPurchaseOrderCostMapper.insertScmPurchaseOrderCost-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into scm_purchase_order_cost          ( id,             order_amount,             order_date,             order_no,             order_spec_unit,             order_goods_unit,             order_spec_unit_total,             actual_amount,             freight,             confirm_user,             confirm_time,             create_by,             pay_amount,                          pay_count,                          status )           values ( ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,                          ?,                          ? )\r\n### Cause: java.sql.SQLSyntaxErrorException: Table \'qihang-erp.scm_purchase_order_cost\' doesn\'t exist\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: Table \'qihang-erp.scm_purchase_order_cost\' doesn\'t exist', '2024-01-28 11:39:26', 6);
INSERT INTO `sys_oper_log` VALUES (107, '采购订单', 2, 'com.qihang.erp.api.controller.ScmPurchaseOrderController.edit()', 'PUT', 1, 'admin', NULL, '/purchase/purchaseOrder', '127.0.0.1', '内网IP', '{\"auditUser\":\"启航\",\"confirmUser\":\"启航\",\"id\":467,\"optionType\":\"confirm\",\"totalAmount\":42,\"updateBy\":\"admin\"}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLSyntaxErrorException: Table \'qihang-erp.scm_purchase_order_cost\' doesn\'t exist\r\n### The error may exist in file [D:\\projects\\qihang.ecom.erp\\ecerp-api\\target\\classes\\mapper\\api\\ScmPurchaseOrderCostMapper.xml]\r\n### The error may involve com.qihang.erp.api.mapper.ScmPurchaseOrderCostMapper.insertScmPurchaseOrderCost-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into scm_purchase_order_cost          ( id,             order_amount,             order_date,             order_no,             order_spec_unit,             order_goods_unit,             order_spec_unit_total,             actual_amount,             freight,             confirm_user,             confirm_time,             create_by,             pay_amount,                          pay_count,                          status )           values ( ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,                          ?,                          ? )\r\n### Cause: java.sql.SQLSyntaxErrorException: Table \'qihang-erp.scm_purchase_order_cost\' doesn\'t exist\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: Table \'qihang-erp.scm_purchase_order_cost\' doesn\'t exist', '2024-01-28 11:39:48', 7);
INSERT INTO `sys_oper_log` VALUES (108, '采购订单', 2, 'com.qihang.erp.api.controller.ScmPurchaseOrderController.edit()', 'PUT', 1, 'admin', NULL, '/purchase/purchaseOrder', '127.0.0.1', '内网IP', '{\"auditUser\":\"启航\",\"confirmUser\":\"启航\",\"id\":467,\"optionType\":\"confirm\",\"totalAmount\":42,\"updateBy\":\"admin\"}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLSyntaxErrorException: Table \'qihang-erp.scm_purchase_order_cost\' doesn\'t exist\r\n### The error may exist in file [D:\\projects\\qihang.ecom.erp\\ecerp-api\\target\\classes\\mapper\\api\\ScmPurchaseOrderCostMapper.xml]\r\n### The error may involve com.qihang.erp.api.mapper.ScmPurchaseOrderCostMapper.insertScmPurchaseOrderCost-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into scm_purchase_order_cost          ( id,             order_amount,             order_date,             order_no,             order_spec_unit,             order_goods_unit,             order_spec_unit_total,             actual_amount,             freight,             confirm_user,             confirm_time,             create_by,             pay_amount,                          pay_count,                          status )           values ( ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,                          ?,                          ? )\r\n### Cause: java.sql.SQLSyntaxErrorException: Table \'qihang-erp.scm_purchase_order_cost\' doesn\'t exist\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: Table \'qihang-erp.scm_purchase_order_cost\' doesn\'t exist', '2024-01-28 11:41:41', 61065);
INSERT INTO `sys_oper_log` VALUES (109, '采购订单', 2, 'com.qihang.erp.api.controller.ScmPurchaseOrderController.edit()', 'PUT', 1, 'admin', NULL, '/purchase/purchaseOrder', '127.0.0.1', '内网IP', '{\"auditUser\":\"启航\",\"confirmUser\":\"启航\",\"id\":467,\"optionType\":\"confirm\",\"totalAmount\":42,\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-01-28 11:42:19', 7648);
INSERT INTO `sys_oper_log` VALUES (110, '采购订单', 2, 'com.qihang.erp.api.controller.ScmPurchaseOrderController.edit()', 'PUT', 1, 'admin', NULL, '/purchase/purchaseOrder', '127.0.0.1', '内网IP', '{\"auditUser\":\"启航\",\"confirmUser\":\"启航\",\"id\":467,\"optionType\":\"SupplierShip\",\"shipCompany\":\"德邦快递\",\"shipCost\":0,\"shipNo\":\"DFB455552202632\",\"supplierDeliveryTime\":\"2024-01-28 00:00:00\",\"totalAmount\":42,\"updateBy\":\"admin\"}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLSyntaxErrorException: Table \'qihang-erp.scm_purchase_order_cost\' doesn\'t exist\r\n### The error may exist in file [D:\\projects\\qihang.ecom.erp\\ecerp-api\\target\\classes\\mapper\\api\\ScmPurchaseOrderCostMapper.xml]\r\n### The error may involve com.qihang.erp.api.mapper.ScmPurchaseOrderCostMapper.updateScmPurchaseOrderCost-Inline\r\n### The error occurred while setting parameters\r\n### SQL: update scm_purchase_order_cost          SET freight = ?          where id = ?\r\n### Cause: java.sql.SQLSyntaxErrorException: Table \'qihang-erp.scm_purchase_order_cost\' doesn\'t exist\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: Table \'qihang-erp.scm_purchase_order_cost\' doesn\'t exist', '2024-01-28 11:43:43', 39170);
INSERT INTO `sys_oper_log` VALUES (111, '采购订单', 2, 'com.qihang.erp.api.controller.ScmPurchaseOrderController.edit()', 'PUT', 1, 'admin', NULL, '/purchase/purchaseOrder', '127.0.0.1', '内网IP', '{\"auditUser\":\"启航\",\"confirmUser\":\"启航\",\"id\":467,\"optionType\":\"SupplierShip\",\"shipCompany\":\"德邦快递\",\"shipCost\":0,\"shipNo\":\"DFB455552202632\",\"supplierDeliveryTime\":\"2024-01-28 00:00:00\",\"totalAmount\":42,\"updateBy\":\"admin\"}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLSyntaxErrorException: Table \'qihang-erp.scm_purchase_order_cost\' doesn\'t exist\r\n### The error may exist in file [D:\\projects\\qihang.ecom.erp\\ecerp-api\\target\\classes\\mapper\\api\\ScmPurchaseOrderCostMapper.xml]\r\n### The error may involve com.qihang.erp.api.mapper.ScmPurchaseOrderCostMapper.updateScmPurchaseOrderCost-Inline\r\n### The error occurred while setting parameters\r\n### SQL: update scm_purchase_order_cost          SET freight = ?          where id = ?\r\n### Cause: java.sql.SQLSyntaxErrorException: Table \'qihang-erp.scm_purchase_order_cost\' doesn\'t exist\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: Table \'qihang-erp.scm_purchase_order_cost\' doesn\'t exist', '2024-01-28 11:43:54', 15);
INSERT INTO `sys_oper_log` VALUES (112, '代码生成', 6, 'com.zhijian.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', NULL, '/tool/gen/importTable', '127.0.0.1', '内网IP', '{\"tables\":\"fms_payable_purchase\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-01-28 11:50:56', 66);
INSERT INTO `sys_oper_log` VALUES (113, '代码生成', 2, 'com.zhijian.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', NULL, '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"payablePurchase\",\"className\":\"FmsPayablePurchase\",\"columns\":[{\"capJavaField\":\"Id\",\"columnId\":1239,\"columnName\":\"id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2024-01-28 11:50:56\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isPk\":\"1\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":56,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"SupplierId\",\"columnComment\":\"供应商id\",\"columnId\":1240,\"columnName\":\"supplier_id\",\"columnType\":\"int\",\"createBy\":\"admin\",\"createTime\":\"2024-01-28 11:50:56\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"supplierId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":56,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"SupplierName\",\"columnComment\":\"供应商名称\",\"columnId\":1241,\"columnName\":\"supplier_name\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2024-01-28 11:50:56\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"supplierName\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":56,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Amount\",\"columnComment\":\"应付金额\",\"columnId\":1242,\"columnName\":\"amount\",\"columnType\":\"decimal(10,2)\",\"createBy\":\"admin\",\"createTime\":\"2024-01-28 11:50:56\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaFiel', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-01-28 11:51:30', 34);
INSERT INTO `sys_oper_log` VALUES (114, '代码生成', 8, 'com.zhijian.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', NULL, '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"fms_payable_purchase\"}', NULL, 0, NULL, '2024-01-28 11:51:53', 337);
INSERT INTO `sys_oper_log` VALUES (115, '菜单管理', 2, 'com.zhijian.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"fms/payable/purchase\",\"createTime\":\"2024-01-28 11:30:49\",\"icon\":\"component\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2073,\"menuName\":\"采购应付\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2072,\"path\":\"purchase\",\"perms\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-01-28 11:55:53', 15);
INSERT INTO `sys_oper_log` VALUES (116, '采购订单', 2, 'com.qihang.erp.api.controller.ScmPurchaseOrderController.edit()', 'PUT', 1, 'admin', NULL, '/purchase/purchaseOrder', '127.0.0.1', '内网IP', '{\"auditUser\":\"启航\",\"id\":467,\"optionType\":\"SupplierShip\",\"shipCompany\":\"菜鸟速递\",\"shipCost\":10,\"shipNo\":\"CN345565767\",\"supplierDeliveryTime\":\"2024-01-28 00:00:00\",\"updateBy\":\"admin\"}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'id\' doesn\'t have a default value\r\n### The error may exist in file [D:\\projects\\qihang.ecom.erp\\ecerp-api\\target\\classes\\mapper\\fms\\FmsPayablePurchaseMapper.xml]\r\n### The error may involve com.qihang.erp.api.mapper.FmsPayablePurchaseMapper.insertFmsPayablePurchase-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into fms_payable_purchase          ( supplier_id,             supplier_name,             amount,             date,                          purchase_order_no,             purchase_desc,                          status,             create_time,             create_by )           values ( ?,             ?,             ?,             ?,                          ?,             ?,                          ?,             ?,             ? )\r\n### Cause: java.sql.SQLException: Field \'id\' doesn\'t have a default value\n; Field \'id\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'id\' doesn\'t have a default value', '2024-01-28 12:07:03', 19882);
INSERT INTO `sys_oper_log` VALUES (117, '采购订单', 2, 'com.qihang.erp.api.controller.ScmPurchaseOrderController.edit()', 'PUT', 1, 'admin', NULL, '/purchase/purchaseOrder', '127.0.0.1', '内网IP', '{\"auditUser\":\"启航\",\"id\":467,\"optionType\":\"SupplierShip\",\"shipCompany\":\"菜鸟速递\",\"shipCost\":10,\"shipNo\":\"CN345565767\",\"supplierDeliveryTime\":\"2024-01-28 00:00:00\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-01-28 12:07:31', 26);
INSERT INTO `sys_oper_log` VALUES (118, '定时任务', 2, 'com.zhijian.quartz.controller.SysJobController.edit()', 'PUT', 1, 'admin', NULL, '/monitor/job', '127.0.0.1', '内网IP', '{\"concurrent\":\"1\",\"createBy\":\"admin\",\"createTime\":\"2023-08-07 19:31:38\",\"cronExpression\":\"0/10 * * * * ?\",\"invokeTarget\":\"ryTask.ryNoParams\",\"jobGroup\":\"DEFAULT\",\"jobId\":1,\"jobName\":\"系统默认（无参）\",\"misfirePolicy\":\"1\",\"nextValidTime\":\"2024-01-28 13:30:00\",\"params\":{},\"remark\":\"\",\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-01-28 13:29:54', 14);
INSERT INTO `sys_oper_log` VALUES (119, '定时任务', 2, 'com.zhijian.quartz.controller.SysJobController.changeStatus()', 'PUT', 1, 'admin', NULL, '/monitor/job/changeStatus', '127.0.0.1', '内网IP', '{\"jobId\":1,\"misfirePolicy\":\"0\",\"params\":{},\"status\":\"1\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-01-28 13:30:18', 7);
INSERT INTO `sys_oper_log` VALUES (120, '定时任务', 1, 'com.zhijian.quartz.controller.SysJobController.add()', 'POST', 1, 'admin', NULL, '/monitor/job', '127.0.0.1', '内网IP', '{\"concurrent\":\"1\",\"cronExpression\":\"0/30 * * * * ?\",\"invokeTarget\":\"inventoryReportTask\",\"jobGroup\":\"SYSTEM\",\"jobName\":\"库存存货日报生成\",\"misfirePolicy\":\"1\",\"nextValidTime\":\"2024-01-28 13:33:00\",\"params\":{},\"status\":\"0\"}', NULL, 1, 'No bean named \'inventoryReportTask\' available', '2024-01-28 13:32:30', 0);
INSERT INTO `sys_oper_log` VALUES (121, '定时任务', 1, 'com.zhijian.quartz.controller.SysJobController.add()', 'POST', 1, 'admin', NULL, '/monitor/job', '127.0.0.1', '内网IP', '{\"concurrent\":\"1\",\"cronExpression\":\"0/30 * * * * ?\",\"invokeTarget\":\"inventoryReportTask\",\"jobGroup\":\"SYSTEM\",\"jobName\":\"库存存货日报生成\",\"misfirePolicy\":\"1\",\"nextValidTime\":\"2024-01-28 13:34:30\",\"params\":{},\"status\":\"0\"}', NULL, 1, 'No bean named \'inventoryReportTask\' available', '2024-01-28 13:34:11', 0);
INSERT INTO `sys_oper_log` VALUES (122, '定时任务', 1, 'com.zhijian.quartz.controller.SysJobController.add()', 'POST', 1, 'admin', NULL, '/monitor/job', '127.0.0.1', '内网IP', '{\"concurrent\":\"1\",\"cronExpression\":\"0/30 * * * * ?\",\"invokeTarget\":\"inventoryReportTask\",\"jobGroup\":\"SYSTEM\",\"jobName\":\"库存存货日报生成\",\"misfirePolicy\":\"1\",\"nextValidTime\":\"2024-01-28 13:36:00\",\"params\":{},\"status\":\"0\"}', NULL, 1, 'No bean named \'inventoryReportTask\' available', '2024-01-28 13:35:34', 1);
INSERT INTO `sys_oper_log` VALUES (123, '定时任务', 1, 'com.zhijian.quartz.controller.SysJobController.add()', 'POST', 1, 'admin', NULL, '/monitor/job', '127.0.0.1', '内网IP', '{\"concurrent\":\"1\",\"cronExpression\":\"0/30 * * * * ?\",\"invokeTarget\":\"inventoryReportTask\",\"jobGroup\":\"SYSTEM\",\"jobName\":\"库存存货日报生成\",\"misfirePolicy\":\"1\",\"nextValidTime\":\"2024-01-28 13:36:00\",\"params\":{},\"status\":\"0\"}', NULL, 1, 'No bean named \'inventoryReportTask\' available', '2024-01-28 13:35:44', 1);
INSERT INTO `sys_oper_log` VALUES (124, '定时任务', 1, 'com.zhijian.quartz.controller.SysJobController.add()', 'POST', 1, 'admin', NULL, '/monitor/job', '127.0.0.1', '内网IP', '{\"concurrent\":\"1\",\"cronExpression\":\"0/30 * * * * ?\",\"invokeTarget\":\"inventoryReportTask.run()\",\"jobGroup\":\"SYSTEM\",\"jobName\":\"库存存货日报生成\",\"misfirePolicy\":\"1\",\"nextValidTime\":\"2024-01-28 13:40:30\",\"params\":{},\"status\":\"0\"}', NULL, 1, 'No bean named \'inventoryReportTask\' available', '2024-01-28 13:40:24', 1);
INSERT INTO `sys_oper_log` VALUES (125, '定时任务', 1, 'com.zhijian.quartz.controller.SysJobController.add()', 'POST', 1, 'admin', NULL, '/monitor/job', '127.0.0.1', '内网IP', '{\"concurrent\":\"1\",\"cronExpression\":\"0/30 * * * * ?\",\"invokeTarget\":\"inventoryReportTask.run()\",\"jobGroup\":\"SYSTEM\",\"jobName\":\"库存存货日报生成\",\"misfirePolicy\":\"1\",\"nextValidTime\":\"2024-01-28 13:42:00\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"新增任务\'库存存货日报生成\'失败，目标字符串不在白名单内\",\"code\":500}', 0, NULL, '2024-01-28 13:41:58', 7);
INSERT INTO `sys_oper_log` VALUES (126, '定时任务', 1, 'com.zhijian.quartz.controller.SysJobController.add()', 'POST', 1, 'admin', NULL, '/monitor/job', '127.0.0.1', '内网IP', '{\"concurrent\":\"1\",\"createBy\":\"admin\",\"cronExpression\":\"0/30 * * * * ?\",\"invokeTarget\":\"inventoryReportTask.run()\",\"jobGroup\":\"SYSTEM\",\"jobId\":100,\"jobName\":\"库存存货日报生成\",\"misfirePolicy\":\"1\",\"nextValidTime\":\"2024-01-28 13:45:00\",\"params\":{},\"status\":\"1\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-01-28 13:44:43', 114);
INSERT INTO `sys_oper_log` VALUES (127, '定时任务', 2, 'com.zhijian.quartz.controller.SysJobController.changeStatus()', 'PUT', 1, 'admin', NULL, '/monitor/job/changeStatus', '127.0.0.1', '内网IP', '{\"jobId\":100,\"misfirePolicy\":\"0\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-01-28 13:44:54', 13);
INSERT INTO `sys_oper_log` VALUES (128, '定时任务', 2, 'com.zhijian.quartz.controller.SysJobController.changeStatus()', 'PUT', 1, 'admin', NULL, '/monitor/job/changeStatus', '127.0.0.1', '内网IP', '{\"jobId\":100,\"misfirePolicy\":\"0\",\"params\":{},\"status\":\"1\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-01-28 13:47:14', 28);
INSERT INTO `sys_oper_log` VALUES (129, '代码生成', 3, 'com.zhijian.generator.controller.GenController.remove()', 'DELETE', 1, 'admin', NULL, '/tool/gen/52,53,54,55,56', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-01-28 14:33:26', 10);
INSERT INTO `sys_oper_log` VALUES (130, '代码生成', 6, 'com.zhijian.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', NULL, '/tool/gen/importTable', '127.0.0.1', '内网IP', '{\"tables\":\"fms_inventory_report,fms_inventory_report_detail,fms_receivable_order\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-01-28 14:33:45', 96);
INSERT INTO `sys_oper_log` VALUES (131, '代码生成', 2, 'com.zhijian.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', NULL, '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"receivableOrder\",\"className\":\"FmsReceivableOrder\",\"columns\":[{\"capJavaField\":\"Id\",\"columnId\":1275,\"columnName\":\"id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2024-01-28 14:33:45\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":59,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Date\",\"columnComment\":\"日期\",\"columnId\":1276,\"columnName\":\"date\",\"columnType\":\"date\",\"createBy\":\"admin\",\"createTime\":\"2024-01-28 14:33:45\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"datetime\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"date\",\"javaType\":\"Date\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":59,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"OrderNum\",\"columnComment\":\"订单号\",\"columnId\":1277,\"columnName\":\"order_num\",\"columnType\":\"varchar(50)\",\"createBy\":\"admin\",\"createTime\":\"2024-01-28 14:33:45\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"orderNum\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":true,\"tableId\":59,\"updateBy\":\"\",\"usableColumn\":true},{\"capJavaField\":\"OrderId\",\"columnComment\":\"订单id\",\"columnId\":1278,\"columnName\":\"order_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2024-01-28 14:33:45\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"orderId\",\"javaType\":\"Long\",\"list\":true', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-01-28 14:34:14', 47);
INSERT INTO `sys_oper_log` VALUES (132, '代码生成', 2, 'com.zhijian.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', NULL, '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"reportDetail\",\"className\":\"FmsInventoryReportDetail\",\"columns\":[{\"capJavaField\":\"Id\",\"columnId\":1263,\"columnName\":\"id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2024-01-28 14:33:45\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isPk\":\"1\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":58,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"ReportId\",\"columnComment\":\"Report外键ID\",\"columnId\":1264,\"columnName\":\"report_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2024-01-28 14:33:45\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"reportId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":58,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Date\",\"columnComment\":\"日期\",\"columnId\":1265,\"columnName\":\"date\",\"columnType\":\"date\",\"createBy\":\"admin\",\"createTime\":\"2024-01-28 14:33:45\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"datetime\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"date\",\"javaType\":\"Date\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":58,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"GoodsId\",\"columnComment\":\"商品id\",\"columnId\":1266,\"columnName\":\"goods_id\",\"columnType\":\"int\",\"createBy\":\"admin\",\"createTime\":\"2024-01-28 14:33:45\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"goodsId\",\"javaType\":\"Long\",\"list\":t', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-01-28 14:34:44', 26);
INSERT INTO `sys_oper_log` VALUES (133, '代码生成', 2, 'com.zhijian.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', NULL, '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"inventoryReport\",\"className\":\"FmsInventoryReport\",\"columns\":[{\"capJavaField\":\"Id\",\"columnId\":1253,\"columnName\":\"id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2024-01-28 14:33:45\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isPk\":\"1\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":57,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Date\",\"columnComment\":\"日期\",\"columnId\":1254,\"columnName\":\"date\",\"columnType\":\"date\",\"createBy\":\"admin\",\"createTime\":\"2024-01-28 14:33:45\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"datetime\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"date\",\"javaType\":\"Date\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":57,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Total\",\"columnComment\":\"库存总数量\",\"columnId\":1255,\"columnName\":\"total\",\"columnType\":\"int\",\"createBy\":\"admin\",\"createTime\":\"2024-01-28 14:33:45\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"total\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":57,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"GoodsCount\",\"columnComment\":\"商品总数\",\"columnId\":1256,\"columnName\":\"goods_count\",\"columnType\":\"int\",\"createBy\":\"admin\",\"createTime\":\"2024-01-28 14:33:45\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"goodsCount\",\"javaType\":\"Long\",\"list\":true,\"params\"', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-01-28 14:35:19', 17);
INSERT INTO `sys_oper_log` VALUES (134, '代码生成', 8, 'com.zhijian.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', NULL, '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"fms_inventory_report,fms_receivable_order\"}', NULL, 0, NULL, '2024-01-28 14:35:30', 314);
INSERT INTO `sys_oper_log` VALUES (135, '菜单管理', 2, 'com.zhijian.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"fms/receivable/order\",\"createTime\":\"2024-01-28 11:24:35\",\"icon\":\"checkbox\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2069,\"menuName\":\"订单收入\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2068,\"path\":\"order\",\"perms\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-01-28 14:48:11', 18);
INSERT INTO `sys_oper_log` VALUES (136, '菜单管理', 2, 'com.zhijian.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"fms/inventoryReport\",\"createTime\":\"2024-01-28 11:36:05\",\"icon\":\"druid\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2077,\"menuName\":\"存货报表\",\"menuType\":\"C\",\"orderNum\":3,\"params\":{},\"parentId\":2018,\"path\":\"inventory_report\",\"perms\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-01-28 14:49:01', 11);
INSERT INTO `sys_oper_log` VALUES (137, '代码生成', 6, 'com.zhijian.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', NULL, '/tool/gen/importTable', '127.0.0.1', '内网IP', '{\"tables\":\"fms_payable_ship_fee\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-01-28 15:11:12', 66);
INSERT INTO `sys_oper_log` VALUES (138, '代码生成', 2, 'com.zhijian.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', NULL, '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"shipFee\",\"className\":\"FmsPayableShipFee\",\"columns\":[{\"capJavaField\":\"Id\",\"columnId\":1295,\"columnName\":\"id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2024-01-28 15:11:12\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":60,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"LogisticsCompany\",\"columnComment\":\"物流公司\",\"columnId\":1296,\"columnName\":\"logistics_company\",\"columnType\":\"varchar(50)\",\"createBy\":\"admin\",\"createTime\":\"2024-01-28 15:11:12\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"logisticsCompany\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":60,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"LogisticsCompanyId\",\"columnComment\":\"物流公司id\",\"columnId\":1297,\"columnName\":\"logistics_company_id\",\"columnType\":\"varchar(10)\",\"createBy\":\"admin\",\"createTime\":\"2024-01-28 15:11:12\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"logisticsCompanyId\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":60,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"LogisticsNum\",\"columnComment\":\"物流单号\",\"columnId\":1298,\"columnName\":\"logistics_num\",\"columnType\":\"varchar(50)\",\"createBy\":\"admin\",\"createTime\":\"2024-01-28 15:11:12\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-01-28 15:11:39', 45);
INSERT INTO `sys_oper_log` VALUES (139, '代码生成', 8, 'com.zhijian.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', NULL, '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"fms_payable_ship_fee\"}', NULL, 0, NULL, '2024-01-28 15:11:48', 204);
INSERT INTO `sys_oper_log` VALUES (140, '菜单管理', 2, 'com.zhijian.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"fms/payable/shipFee\",\"createTime\":\"2024-01-12 18:35:31\",\"icon\":\"guide\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2063,\"menuName\":\"物流费用\",\"menuType\":\"C\",\"orderNum\":3,\"params\":{},\"parentId\":2072,\"path\":\"shipFee\",\"perms\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-01-28 15:16:13', 20);
INSERT INTO `sys_oper_log` VALUES (141, '菜单管理', 2, 'com.zhijian.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2024-01-28 11:28:03\",\"icon\":\"cascader\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2071,\"menuName\":\"平台服务费\",\"menuType\":\"M\",\"orderNum\":3,\"params\":{},\"parentId\":2068,\"path\":\"service_fee\",\"perms\":\"\",\"status\":\"1\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-01-28 19:35:31', 28);
INSERT INTO `sys_oper_log` VALUES (142, '菜单管理', 2, 'com.zhijian.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2024-01-28 11:34:01\",\"icon\":\"clipboard\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2076,\"menuName\":\"其他费用\",\"menuType\":\"C\",\"orderNum\":6,\"params\":{},\"parentId\":2072,\"path\":\"other_fee\",\"perms\":\"\",\"status\":\"1\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-01-28 19:49:00', 11);
INSERT INTO `sys_oper_log` VALUES (143, '淘宝订单', 2, 'com.qihang.erp.api.controller.TaoOrderController.confirmOrder()', 'POST', 1, 'admin', NULL, '/tao/order/confirmOrder', '127.0.0.1', '内网IP', '{\"address\":\"上海上海 上海市 徐汇区 华泾镇 华发路368弄 馨宁公寓馨宁公寓368弄23号楼1501\",\"auditStatus\":0,\"auditTime\":\"2022-08-05\",\"buyerName\":\"\",\"city\":\"\",\"closeReason\":\"\",\"createTime\":\"2022-08-05 18:48:51\",\"discountAmount\":0,\"discountRemark\":\"\",\"id\":\"1635222253871665598\",\"isMerge\":0,\"logisticsCode\":\"432709738409767\",\"logisticsCompany\":\"韵达速递\",\"orderCreateTime\":\"2022-08-05\",\"orderModifyTime\":\"2022-08-05\",\"orderSource\":0,\"params\":{},\"payAmount\":29.92,\"payTime\":\"2022-08-05\",\"phone\":\"15635244122\",\"province\":\"上海\",\"receiver\":\"小红\",\"sellerMemo\":\"\",\"sendStatus\":0,\"sendTime\":\"2022-08-05\",\"shipType\":1,\"shippingFee\":0,\"shopId\":6,\"status\":3,\"statusStr\":\"等待买家确认收货\",\"taoOrderItemList\":[],\"totalAmount\":29.92,\"updateBy\":\"admin\",\"updateTime\":\"2022-08-05 19:49:12\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-01-28 19:55:37', 69);
INSERT INTO `sys_oper_log` VALUES (144, '供应商代发货', 2, 'com.qihang.erp.api.controller.ScmSupplierAgentShippingController.edit()', 'PUT', 1, 'admin', NULL, '/scm/agentShipping', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2024-01-28 19:55:37\",\"erpOrderId\":17,\"erpOrderItemId\":14,\"goodsId\":9,\"goodsImg\":\"https://cbu01.alicdn.com/img/ibank/O1CN01PHFmsX2FOyB14fPie_!!2208857268871-0-cib.jpg\",\"goodsNum\":\"272021008026\",\"goodsPrice\":16,\"goodsSpec\":\"浅蓝色,L\",\"goodsTitle\":\"8026牛仔短裤\",\"id\":1,\"itemAmount\":29.92,\"orderDate\":\"2022-08-05\",\"orderNum\":\"1635222253871665598\",\"params\":{},\"quantity\":1,\"shipCompany\":\"菜鸟速递\",\"shipCost\":3,\"shipNo\":\"CN4550110\",\"shipTime\":\"2024-01-28\",\"shopId\":6,\"shopType\":4,\"specId\":40,\"specNum\":\"2720210080260303\",\"status\":0,\"supplierId\":26,\"updateTime\":\"2024-01-28 20:40:06\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-01-28 20:40:06', 326903);
INSERT INTO `sys_oper_log` VALUES (145, '代码生成', 6, 'com.zhijian.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', NULL, '/tool/gen/importTable', '127.0.0.1', '内网IP', '{\"tables\":\"fms_payable_agent_ship\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-01-28 20:48:33', 156);
INSERT INTO `sys_oper_log` VALUES (146, '代码生成', 2, 'com.zhijian.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', NULL, '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"agentShip\",\"className\":\"FmsPayableAgentShip\",\"columns\":[{\"capJavaField\":\"Id\",\"columnId\":1318,\"columnName\":\"id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2024-01-28 20:48:33\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":61,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"OrderNum\",\"columnComment\":\"订单号\",\"columnId\":1319,\"columnName\":\"order_num\",\"columnType\":\"varchar(50)\",\"createBy\":\"admin\",\"createTime\":\"2024-01-28 20:48:33\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"orderNum\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":true,\"tableId\":61,\"updateBy\":\"\",\"usableColumn\":true},{\"capJavaField\":\"ShopId\",\"columnComment\":\"店铺id\",\"columnId\":1320,\"columnName\":\"shop_id\",\"columnType\":\"int\",\"createBy\":\"admin\",\"createTime\":\"2024-01-28 20:48:33\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"shopId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":61,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"SupplierId\",\"columnComment\":\"供应商id\",\"columnId\":1321,\"columnName\":\"supplier_id\",\"columnType\":\"int\",\"createBy\":\"admin\",\"createTime\":\"2024-01-28 20:48:33\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"supplierId\",\"javaType\":\"Long\",\"lis', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-01-28 20:48:59', 43);
INSERT INTO `sys_oper_log` VALUES (147, '代码生成', 8, 'com.zhijian.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', NULL, '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"fms_payable_agent_ship\"}', NULL, 0, NULL, '2024-01-28 20:49:04', 287);
INSERT INTO `sys_oper_log` VALUES (148, '菜单管理', 2, 'com.zhijian.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"fms/payable/agentShip\",\"createTime\":\"2024-01-12 18:35:02\",\"icon\":\"theme\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2062,\"menuName\":\"代发账单\",\"menuType\":\"C\",\"orderNum\":3,\"params\":{},\"parentId\":2072,\"path\":\"agentShip\",\"perms\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-01-28 20:57:14', 23);
INSERT INTO `sys_oper_log` VALUES (149, '供应商代发货', 2, 'com.qihang.erp.api.controller.ScmSupplierAgentShippingController.edit()', 'PUT', 1, 'admin', NULL, '/scm/agentShipping', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2024-01-28 19:55:37\",\"erpOrderId\":17,\"erpOrderItemId\":14,\"goodsId\":9,\"goodsImg\":\"https://cbu01.alicdn.com/img/ibank/O1CN01PHFmsX2FOyB14fPie_!!2208857268871-0-cib.jpg\",\"goodsNum\":\"272021008026\",\"goodsPrice\":16,\"goodsSpec\":\"浅蓝色,L\",\"goodsTitle\":\"8026牛仔短裤\",\"id\":1,\"itemAmount\":29.92,\"orderDate\":\"2022-08-05\",\"orderNum\":\"1635222253871665598\",\"params\":{},\"quantity\":1,\"shipCompany\":\"菜鸟速递\",\"shipCost\":2.0,\"shipNo\":\"CN52500021\",\"shipTime\":\"2024-01-28\",\"shopId\":6,\"shopType\":4,\"specId\":40,\"specNum\":\"2720210080260303\",\"status\":0,\"supplierId\":26,\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-01-28 21:06:20', 504629);
INSERT INTO `sys_oper_log` VALUES (150, '供应商代发货', 2, 'com.qihang.erp.api.controller.ScmSupplierAgentShippingController.edit()', 'PUT', 1, 'admin', NULL, '/scm/agentShipping', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2024-01-28 19:55:37\",\"erpOrderId\":17,\"erpOrderItemId\":14,\"goodsId\":9,\"goodsImg\":\"https://cbu01.alicdn.com/img/ibank/O1CN01PHFmsX2FOyB14fPie_!!2208857268871-0-cib.jpg\",\"goodsNum\":\"272021008026\",\"goodsPrice\":16,\"goodsSpec\":\"浅蓝色,L\",\"goodsTitle\":\"8026牛仔短裤\",\"id\":1,\"itemAmount\":29.92,\"orderDate\":\"2022-08-05\",\"orderNum\":\"1635222253871665598\",\"params\":{},\"quantity\":1,\"shipCompany\":\"菜鸟速递\",\"shipCost\":2.0,\"shipNo\":\"CN52500021\",\"shipTime\":\"2024-01-28\",\"shopId\":6,\"shopType\":4,\"specId\":40,\"specNum\":\"2720210080260303\",\"status\":0,\"supplierId\":26,\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-01-28 21:06:44', 8276);
INSERT INTO `sys_oper_log` VALUES (151, '店铺', 2, 'com.qihang.erp.api.controller.ShopController.edit()', 'PUT', 1, 'admin', NULL, '/shop/shop', '127.0.0.1', '内网IP', '{\"apiRequestUrl\":\"2\",\"appSercet\":\"36a12497-fb9d-4b54-8cd1-fd1617346687\",\"appkey\":\"7249607407477720636\",\"company\":\"华衣云商\",\"ename\":\"douyin\",\"id\":22,\"isDelete\":0,\"isShow\":1,\"modifyOn\":1653672695,\"name\":\"梦小妮牛仔裤\",\"nickName\":\"抖音-梦小妮\",\"orderNum\":87,\"params\":{},\"sellerUserId\":0,\"sellerUserIdStr\":\"0\",\"sessionKey\":\"\",\"type\":6,\"url\":\"http://openapi.jinritemai.com\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-02-17 10:47:35', 17);
INSERT INTO `sys_oper_log` VALUES (152, '店铺', 2, 'com.qihang.erp.api.controller.ShopController.edit()', 'PUT', 1, 'admin', NULL, '/shop/shop', '127.0.0.1', '内网IP', '{\"apiRequestUrl\":\"2\",\"appSercet\":\"36a12497-fb9d-4b54-8cd1-fd1617346687\",\"appkey\":\"7249607407477720636\",\"company\":\"华衣云商\",\"ename\":\"douyin\",\"id\":22,\"isDelete\":0,\"isShow\":1,\"modifyOn\":1653672695,\"name\":\"梦小妮牛仔裤\",\"nickName\":\"抖音-梦小妮\",\"orderNum\":87,\"params\":{},\"sellerUserId\":4463798,\"sellerUserIdStr\":\"0\",\"sessionKey\":\"\",\"type\":6,\"url\":\"http://openapi.jinritemai.com\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-02-17 11:54:47', 16);
INSERT INTO `sys_oper_log` VALUES (153, '菜单管理', 2, 'com.zhijian.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"\",\"createTime\":\"2023-12-27 15:00:27\",\"icon\":\"server\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":4,\"menuName\":\"采购管理\",\"menuType\":\"M\",\"orderNum\":1,\"params\":{},\"parentId\":0,\"path\":\"scm\",\"perms\":\"\",\"query\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-03-24 19:30:46', 14);
INSERT INTO `sys_oper_log` VALUES (154, '菜单管理', 2, 'com.zhijian.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"\",\"createTime\":\"2023-12-29 16:53:03\",\"icon\":\"shopping\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2014,\"menuName\":\"订单管理\",\"menuType\":\"M\",\"orderNum\":2,\"params\":{},\"parentId\":0,\"path\":\"sale\",\"perms\":\"\",\"query\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-03-24 19:31:53', 10);
INSERT INTO `sys_oper_log` VALUES (155, '菜单管理', 2, 'com.zhijian.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"sale/order/index\",\"createTime\":\"2023-12-31 20:05:05\",\"icon\":\"list\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2033,\"menuName\":\"订单查询\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2014,\"path\":\"order/list\",\"perms\":\"\",\"query\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-03-24 19:32:00', 5);
INSERT INTO `sys_oper_log` VALUES (156, '菜单管理', 2, 'com.zhijian.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"sale/order/create\",\"createTime\":\"2023-12-31 20:01:22\",\"icon\":\"documentation\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2030,\"menuName\":\"手动创建订单\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2014,\"path\":\"order/create\",\"perms\":\"\",\"query\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"1\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-03-24 19:32:32', 9);
INSERT INTO `sys_oper_log` VALUES (157, '菜单管理', 2, 'com.zhijian.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"\",\"createTime\":\"2024-01-01 14:14:42\",\"icon\":\"excel\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2036,\"menuName\":\"网店订单导入\",\"menuType\":\"C\",\"orderNum\":2,\"params\":{},\"parentId\":2014,\"path\":\"shop_order\",\"perms\":\"\",\"query\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-03-24 19:33:50', 7);
INSERT INTO `sys_oper_log` VALUES (158, '菜单管理', 2, 'com.zhijian.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"shop/order/import\",\"createTime\":\"2024-01-01 14:14:42\",\"icon\":\"excel\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2036,\"menuName\":\"网店订单导入\",\"menuType\":\"C\",\"orderNum\":2,\"params\":{},\"parentId\":2014,\"path\":\"shopOrder/import\",\"perms\":\"\",\"query\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-03-24 19:36:40', 7);
INSERT INTO `sys_oper_log` VALUES (159, '菜单管理', 2, 'com.zhijian.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"shop/order/import\",\"createTime\":\"2024-01-01 14:14:42\",\"icon\":\"excel\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2036,\"menuName\":\"网店订单导入\",\"menuType\":\"C\",\"orderNum\":2,\"params\":{},\"parentId\":2014,\"path\":\"shopOrder/import\",\"perms\":\"\",\"query\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-03-24 19:36:40', 7);
INSERT INTO `sys_oper_log` VALUES (160, '菜单管理', 2, 'com.zhijian.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"shop/order/index\",\"createTime\":\"2024-01-01 14:14:42\",\"icon\":\"excel\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2036,\"menuName\":\"网店订单导入\",\"menuType\":\"C\",\"orderNum\":2,\"params\":{},\"parentId\":2014,\"path\":\"shopOrder/import\",\"perms\":\"\",\"query\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-03-24 19:39:56', 7);
INSERT INTO `sys_oper_log` VALUES (161, '菜单管理', 2, 'com.zhijian.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"sale/returned\",\"createTime\":\"2024-01-03 14:24:36\",\"icon\":\"size\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2054,\"menuName\":\"售后管理\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2053,\"path\":\"returned\",\"perms\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-03-24 20:27:33', 7);
INSERT INTO `sys_oper_log` VALUES (162, '菜单管理', 2, 'com.zhijian.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"\",\"createTime\":\"2023-12-31 17:29:03\",\"icon\":\"clipboard\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2029,\"menuName\":\"店铺售后管理\",\"menuType\":\"M\",\"orderNum\":2,\"params\":{},\"parentId\":2053,\"path\":\"refund\",\"perms\":\"\",\"query\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-03-24 20:27:41', 7);
INSERT INTO `sys_oper_log` VALUES (163, '菜单管理', 2, 'com.zhijian.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"sale/returned\",\"createTime\":\"2024-01-03 14:24:36\",\"icon\":\"size\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2054,\"menuName\":\"售后管理\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2053,\"path\":\"refund_list\",\"perms\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-03-24 20:28:24', 7);
INSERT INTO `sys_oper_log` VALUES (164, '菜单管理', 2, 'com.zhijian.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"shop/refund/index\",\"createTime\":\"2023-12-31 17:29:03\",\"icon\":\"clipboard\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2029,\"menuName\":\"店铺售后导入\",\"menuType\":\"C\",\"orderNum\":2,\"params\":{},\"parentId\":2053,\"path\":\"shop_refund\",\"perms\":\"\",\"query\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-03-24 20:29:07', 7);
INSERT INTO `sys_oper_log` VALUES (165, '菜单管理', 2, 'com.zhijian.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"scm/agentShipping\",\"createTime\":\"2024-01-06 23:57:14\",\"icon\":\"clipboard\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2057,\"menuName\":\"供应商代发管理\",\"menuType\":\"C\",\"orderNum\":99,\"params\":{},\"parentId\":2034,\"path\":\"supplier/agentShipping\",\"perms\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-03-24 20:30:29', 11);
INSERT INTO `sys_oper_log` VALUES (166, '菜单管理', 2, 'com.zhijian.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"shop/order/index\",\"createTime\":\"2024-01-01 14:14:42\",\"icon\":\"excel\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2036,\"menuName\":\"网店订单导入\",\"menuType\":\"C\",\"orderNum\":2,\"params\":{},\"parentId\":2014,\"path\":\"shop_order\",\"perms\":\"\",\"query\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-03-24 20:35:32', 6);
INSERT INTO `sys_oper_log` VALUES (167, '菜单管理', 2, 'com.zhijian.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"fms/payable/purchase\",\"createTime\":\"2024-01-28 11:30:49\",\"icon\":\"component\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2073,\"menuName\":\"采购应付\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":4,\"path\":\"purchase\",\"perms\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-03-24 21:07:23', 5);
INSERT INTO `sys_oper_log` VALUES (168, '菜单管理', 2, 'com.zhijian.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"fms/payable/agentShip\",\"createTime\":\"2024-01-12 18:35:02\",\"icon\":\"theme\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2062,\"menuName\":\"代发账单\",\"menuType\":\"C\",\"orderNum\":3,\"params\":{},\"parentId\":4,\"path\":\"agentShip\",\"perms\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-03-24 21:07:38', 10);
INSERT INTO `sys_oper_log` VALUES (169, '菜单管理', 2, 'com.zhijian.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"fms/payable/shipFee\",\"createTime\":\"2024-01-12 18:35:31\",\"icon\":\"guide\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2063,\"menuName\":\"物流费用\",\"menuType\":\"C\",\"orderNum\":3,\"params\":{},\"parentId\":2034,\"path\":\"shipFee\",\"perms\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-03-24 21:07:53', 7);
INSERT INTO `sys_oper_log` VALUES (170, '菜单管理', 2, 'com.zhijian.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"\",\"createTime\":\"2023-12-29 17:07:23\",\"icon\":\"money\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2018,\"menuName\":\"财务管理\",\"menuType\":\"M\",\"orderNum\":6,\"params\":{},\"parentId\":0,\"path\":\"fms\",\"perms\":\"\",\"query\":\"\",\"status\":\"1\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-03-24 21:08:38', 8);
INSERT INTO `sys_oper_log` VALUES (171, '菜单管理', 2, 'com.zhijian.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"\",\"createTime\":\"2023-12-27 15:00:27\",\"icon\":\"tool\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":3,\"menuName\":\"系统工具\",\"menuType\":\"M\",\"orderNum\":101,\"params\":{},\"parentId\":0,\"path\":\"tool\",\"perms\":\"\",\"query\":\"\",\"status\":\"1\",\"updateBy\":\"admin\",\"visible\":\"1\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-03-24 21:08:58', 8);
INSERT INTO `sys_oper_log` VALUES (172, '菜单管理', 2, 'com.zhijian.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"\",\"createTime\":\"2023-12-27 15:00:27\",\"icon\":\"tool\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":3,\"menuName\":\"系统工具\",\"menuType\":\"M\",\"orderNum\":101,\"params\":{},\"parentId\":0,\"path\":\"tool\",\"perms\":\"\",\"query\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"1\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-03-24 21:09:13', 8);
INSERT INTO `sys_oper_log` VALUES (173, '菜单管理', 2, 'com.zhijian.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"\",\"createTime\":\"2023-12-27 15:00:27\",\"icon\":\"monitor\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2,\"menuName\":\"系统监控\",\"menuType\":\"M\",\"orderNum\":100,\"params\":{},\"parentId\":0,\"path\":\"monitor\",\"perms\":\"\",\"query\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"1\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2024-03-24 21:09:18', 8);

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `role_id` bigint NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色名称',
  `role_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色权限字符串',
  `role_sort` int NOT NULL COMMENT '显示顺序',
  `data_scope` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '1' COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
  `menu_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '菜单树选择项是否关联显示',
  `dept_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '部门树选择项是否关联显示',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '超级管理员', 'admin', 1, '1', 1, 1, '0', '0', 'admin', '2023-08-07 19:31:37', '', NULL, '超级管理员');
INSERT INTO `sys_role` VALUES (2, '普通角色', 'common', 2, '2', 1, 1, '0', '0', 'admin', '2023-08-07 19:31:37', 'admin', '2024-04-10 11:38:52', '普通角色');

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `menu_id` bigint NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`, `menu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色和菜单关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `user_id` bigint NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `dept_id` bigint NULL DEFAULT NULL COMMENT '部门ID',
  `user_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户账号',
  `nick_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户昵称',
  `user_type` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '00' COMMENT '用户类型（00系统用户）',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '用户邮箱',
  `phonenumber` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '手机号码',
  `sex` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '用户性别（0男 1女 2未知）',
  `avatar` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '头像地址',
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '密码',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '帐号状态（0正常 1停用）',
  `expiration_date` date NULL DEFAULT NULL COMMENT '到期日期',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `login_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '最后登录IP',
  `login_date` datetime NULL DEFAULT NULL COMMENT '最后登录时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 101 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 103, 'admin', '启航', '00', 'ry@163.com', '15888888888', '1', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '2024-04-30', '0', '127.0.0.1', '2024-04-24 20:28:34', 'admin', '2023-08-07 19:31:37', '', '2024-04-24 20:28:33', '管理员');
INSERT INTO `sys_user` VALUES (100, NULL, '15818590119', 'BUZD', '00', '2855@qq.com', '15658900660', '2', '', '$2a$10$ihW7y3A357sHY0Qgl43JMOgxfe749oRelpp9brl1xN0cZHTky4Uxm', '0', '2024-05-11', '0', '127.0.0.1', '2024-04-24 21:03:55', 'admin', '2024-04-21 10:36:49', '', '2024-04-24 21:03:55', NULL);

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `role_id` bigint NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`, `role_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户和角色关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES (1, 1);
INSERT INTO `sys_user_role` VALUES (2, 1);

-- ----------------------------
-- Table structure for wms_goods_bad_stock
-- ----------------------------
DROP TABLE IF EXISTS `wms_goods_bad_stock`;
CREATE TABLE `wms_goods_bad_stock`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `goodsId` int NOT NULL COMMENT '商品id',
  `specId` int NOT NULL COMMENT '商品规格id',
  `specNumber` varchar(25) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '' COMMENT '规格编码（唯一）',
  `sourceId` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '' COMMENT '来源ID（type==1时 order_send_return主键id）',
  `type` int NOT NULL COMMENT '类型（1退货报损3待退还供应商）',
  `locationId` int NOT NULL DEFAULT 0 COMMENT '仓位',
  `quantity` int NOT NULL DEFAULT 0 COMMENT '数量',
  `lossAmount` double NOT NULL DEFAULT 0 COMMENT '损失金额（最大成本）',
  `isDelete` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0正常  1删除',
  `result` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '处理结果',
  `resultTime` datetime NULL DEFAULT NULL COMMENT '处理时间',
  `reason` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '理由',
  `status` tinyint NOT NULL DEFAULT 0 COMMENT '是否处理0未处理1已处理',
  `createTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `modifyTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '不良品库存' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of wms_goods_bad_stock
-- ----------------------------
INSERT INTO `wms_goods_bad_stock` VALUES (1, 13, 88, '28202206810101', '20', 1, 0, 1, 29, 0, '计入损失', '2022-10-03 17:39:32', '货物损坏，供应商拒收，消费者退款成功', 1, '2022-10-03 17:39:32', '2022-10-03 17:39:32');
INSERT INTO `wms_goods_bad_stock` VALUES (2, 33, 497, 'HN08017503', '76', 1, 0, 1, 28, 0, '计入损失', '2022-10-16 18:00:00', '货物损坏，供应商拒收，消费者退款成功', 1, '2022-10-16 18:00:00', '2022-10-16 18:00:00');
INSERT INTO `wms_goods_bad_stock` VALUES (3, 33, 502, 'HN08012903', '249', 1, 0, 1, 28, 0, '计入损失', '2022-11-07 09:42:33', '货物损坏，供应商拒收，消费者退款成功', 1, '2022-11-07 09:42:33', '2022-11-07 09:42:33');
INSERT INTO `wms_goods_bad_stock` VALUES (4, 15, 119, '28202106610102', '174', 1, 0, 1, 29, 0, '计入损失', '2022-11-07 09:43:20', '货物损坏，供应商拒收，消费者退款成功', 1, '2022-11-07 09:43:20', '2022-11-07 09:43:20');
INSERT INTO `wms_goods_bad_stock` VALUES (5, 37, 558, 'HN1062904', '327', 1, 0, 1, 31, 0, '计入损失', '2022-12-08 10:08:14', '货物损坏，供应商拒收，消费者退款成功', 1, '2022-12-08 10:08:14', '2022-12-08 10:08:14');

-- ----------------------------
-- Table structure for wms_goods_bad_stock_log
-- ----------------------------
DROP TABLE IF EXISTS `wms_goods_bad_stock_log`;
CREATE TABLE `wms_goods_bad_stock_log`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `stockId` bigint NOT NULL COMMENT '商品id',
  `specId` int NOT NULL COMMENT '商品规格id',
  `locationId` int NOT NULL COMMENT '所在仓位',
  `type` int NOT NULL COMMENT '类型1入库2出库',
  `quantity` bigint NOT NULL DEFAULT 0 COMMENT '数量',
  `remark` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '备注',
  `createTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '不良品库存日志' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of wms_goods_bad_stock_log
-- ----------------------------
INSERT INTO `wms_goods_bad_stock_log` VALUES (1, 1, 88, 0, 1, 1, '退货不良品入库SKU :28202206810101退货单号:BAD221003173932494', '2022-10-03 17:39:32');
INSERT INTO `wms_goods_bad_stock_log` VALUES (2, 2, 497, 0, 1, 1, '退货不良品入库SKU :HN08017503退货单号:BAD221016180000005', '2022-10-16 18:00:00');
INSERT INTO `wms_goods_bad_stock_log` VALUES (3, 3, 502, 0, 1, 1, '退货不良品入库SKU :HN08012903退货单号:BAD221107094233114', '2022-11-07 09:42:33');
INSERT INTO `wms_goods_bad_stock_log` VALUES (4, 4, 119, 0, 1, 1, '退货不良品入库SKU :28202106610102退货单号:BAD221107094320707', '2022-11-07 09:43:20');
INSERT INTO `wms_goods_bad_stock_log` VALUES (5, 5, 558, 0, 1, 1, '退货不良品入库SKU :HN1062904退货单号:BAD221208100814778', '2022-12-08 10:08:14');

-- ----------------------------
-- Table structure for wms_order_shipping
-- ----------------------------
DROP TABLE IF EXISTS `wms_order_shipping`;
CREATE TABLE `wms_order_shipping`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `shop_id` int NOT NULL COMMENT '店铺ID',
  `shop_type` int NOT NULL COMMENT '店铺平台',
  `order_num` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '订单编号',
  `erp_order_id` bigint NULL DEFAULT NULL COMMENT 'erp订单ID',
  `erp_order_item_id` bigint NOT NULL COMMENT 'erp子订单ID',
  `order_date` datetime NOT NULL COMMENT '订单日期',
  `goods_id` bigint NOT NULL DEFAULT 0 COMMENT 'erp系统商品id',
  `spec_id` bigint NOT NULL DEFAULT 0 COMMENT 'erp系统商品规格id',
  `goods_title` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '商品标题',
  `goods_img` varchar(300) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '商品图片',
  `goods_num` varchar(35) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '商品编码',
  `goods_spec` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '商品规格',
  `spec_num` varchar(35) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '商品规格编码',
  `quantity` int NOT NULL COMMENT '商品数量',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '说明',
  `ship_company` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '物流公司',
  `ship_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '物流单号',
  `ship_cost` decimal(6, 0) NULL DEFAULT NULL COMMENT '运费',
  `ship_time` datetime NULL DEFAULT NULL COMMENT '发货时间',
  `out_operator` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '出库人',
  `out_position` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '出库仓位',
  `out_time` datetime NULL DEFAULT NULL COMMENT '出库时间',
  `status` int NULL DEFAULT NULL COMMENT '状态（0未处理1出库中2已出库3已发货）',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `create_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `update_by` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '仓库订单发货表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of wms_order_shipping
-- ----------------------------
INSERT INTO `wms_order_shipping` VALUES (11, 6, 4, '1631273557325601885', 15, 12, '2022-07-31 18:14:00', 9, 32, '8026牛仔短裤', 'https://cbu01.alicdn.com/img/ibank/O1CN01AfNgvA2FOyAvwXZxv_!!2208857268871-0-cib.jpg', '272021008026', '黑色,2XL', '2720210080260105', 1, NULL, NULL, NULL, NULL, NULL, 'admin', '20', '2024-01-16 14:52:43', 2, '2024-01-16 13:44:26', 'admin', 'admin', '2024-01-16 14:52:43');
INSERT INTO `wms_order_shipping` VALUES (12, 6, 4, '1642473483353670599', 16, 13, '2022-08-13 19:09:13', 9, 32, '8026牛仔短裤', 'https://cbu01.alicdn.com/img/ibank/O1CN01AfNgvA2FOyAvwXZxv_!!2208857268871-0-cib.jpg', '272021008026', '黑色,2XL', '2720210080260105', 1, NULL, NULL, NULL, NULL, NULL, 'admin', '20', '2024-01-16 15:05:47', 3, '2024-01-16 15:04:52', 'admin', 'admin', '2024-01-16 15:42:53');

-- ----------------------------
-- Table structure for wms_stock_in_entry
-- ----------------------------
DROP TABLE IF EXISTS `wms_stock_in_entry`;
CREATE TABLE `wms_stock_in_entry`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `tenant_id` bigint NOT NULL COMMENT '租户id',
  `no` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '' COMMENT '单据编号',
  `source_no` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '来源单号',
  `source_id` bigint NULL DEFAULT NULL COMMENT '来源单id',
  `source_type` int NOT NULL COMMENT '来源类型（1采购订单2退货订单）',
  `source_goods_unit` int NULL DEFAULT NULL COMMENT '采购订单商品数',
  `source_spec_unit_total` int NULL DEFAULT NULL COMMENT '采购订单总件数',
  `source_spec_unit` int NULL DEFAULT NULL COMMENT '采购订单商品规格数',
  `remark` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '备注',
  `stock_in_operator_id` int NULL DEFAULT NULL COMMENT '操作入库人id',
  `stock_in_operator` varchar(25) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '操作入库人',
  `stock_in_time` datetime NULL DEFAULT NULL COMMENT '入库时间',
  `status` int NOT NULL DEFAULT 0 COMMENT '状态（0待入库1部分入库2全部入库）',
  `create_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1782052120938168322 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '入库单' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of wms_stock_in_entry
-- ----------------------------
INSERT INTO `wms_stock_in_entry` VALUES (8, 0, '20240116145057', 'PUR20240116144408', 466, 1, 1, 10, 1, NULL, 1, 'admin', '2024-01-16 00:00:00', 2, 'admin', '2024-01-16 14:50:58', 'admin', '2024-01-16 14:52:10');
INSERT INTO `wms_stock_in_entry` VALUES (1782052120938168321, 100, '20240421222145', 'PUR20240421205746', 1782036559596474370, 1, 1, 10, 1, NULL, NULL, NULL, NULL, 0, '15818590119', '2024-04-21 22:21:49', NULL, NULL);

-- ----------------------------
-- Table structure for wms_stock_in_entry_item
-- ----------------------------
DROP TABLE IF EXISTS `wms_stock_in_entry_item`;
CREATE TABLE `wms_stock_in_entry_item`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `tenant_id` bigint NOT NULL COMMENT '租户id',
  `entry_id` bigint NOT NULL COMMENT '入库单id',
  `source_type` int NULL DEFAULT NULL COMMENT '来源类型（1采购订单2退货订单）',
  `source_id` bigint NULL DEFAULT NULL COMMENT '来源单id',
  `source_item_id` bigint NOT NULL COMMENT '来源单itemId',
  `goods_id` bigint NOT NULL COMMENT '商品id',
  `goods_num` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '商品编码',
  `goods_name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '商品名称',
  `spec_id` bigint NOT NULL COMMENT '商品规格id',
  `spec_num` varchar(25) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '商品规格编码',
  `color_value` varchar(55) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '颜色',
  `color_image` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '图片',
  `size_value` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '尺码',
  `style_value` varchar(55) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '款式',
  `original_quantity` bigint NULL DEFAULT NULL COMMENT '原始数量',
  `in_quantity` bigint NOT NULL COMMENT '入库数量',
  `remark` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '备注',
  `location_id` int NULL DEFAULT NULL COMMENT '入库仓位',
  `location_num` varchar(25) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '入库仓位编码',
  `status` int NULL DEFAULT 0 COMMENT '状态（0待入库1部分入库2全部入库）',
  `create_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `specIndex`(`spec_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1782052151443341315 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '入库单明细' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of wms_stock_in_entry_item
-- ----------------------------
INSERT INTO `wms_stock_in_entry_item` VALUES (4, 0, 8, 1, 466, 1962, 9, 'HN8026', 'HN8026牛仔短裤', 32, '2720210080260105', '黑色', 'https://cbu01.alicdn.com/img/ibank/O1CN01AfNgvA2FOyAvwXZxv_!!2208857268871-0-cib.jpg', '2XL', '', 10, 10, '', NULL, NULL, 2, 'admin', '2024-01-16 14:50:58', 'admin', '2024-01-16 14:52:10');
INSERT INTO `wms_stock_in_entry_item` VALUES (1782052151443341314, 100, 1782052120938168321, 1, 1782036559596474370, 1782030968731791400, 1781988656060412000, 'NZK000232', '男士流行夏季牛仔裤黑色', 1781988656068800500, 'NZK00023200', '红色', NULL, '', '', 10, 0, '', NULL, NULL, 0, '15818590119', '2024-04-21 22:21:55', NULL, NULL);

-- ----------------------------
-- Table structure for wms_stock_location
-- ----------------------------
DROP TABLE IF EXISTS `wms_stock_location`;
CREATE TABLE `wms_stock_location`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `number` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '货架编号',
  `name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '货架名称',
  `parent_id` int NOT NULL COMMENT '上级id',
  `depth` int NULL DEFAULT 1 COMMENT '层级深度1级2级3级',
  `parent_id1` int NOT NULL COMMENT '一级类目id',
  `parent_id2` int NOT NULL COMMENT '二级类目id',
  `address` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '地址',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `isDelete` int NOT NULL DEFAULT 0 COMMENT '0正常  1删除',
  `create_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '仓库货架表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of wms_stock_location
-- ----------------------------
INSERT INTO `wms_stock_location` VALUES (1, '001', '深圳虚拟仓库', 0, 1, 0, 0, NULL, NULL, 0, 'admin', '2022-03-07 20:06:10', NULL, '2022-03-07 20:06:10');
INSERT INTO `wms_stock_location` VALUES (2, 'A', 'A区', 1, 2, 1, 0, NULL, NULL, 0, 'admin', '2022-03-07 20:06:24', NULL, '2022-03-07 20:06:24');
INSERT INTO `wms_stock_location` VALUES (3, 'B', 'B区', 1, 2, 1, 0, NULL, NULL, 0, 'admin', '2022-03-07 20:06:38', NULL, '2022-03-07 20:06:38');
INSERT INTO `wms_stock_location` VALUES (4, 'C', 'C区', 1, 2, 1, 0, NULL, NULL, 0, 'admin', '2022-03-07 20:06:47', NULL, '2022-03-07 20:06:47');
INSERT INTO `wms_stock_location` VALUES (5, 'A01-1-01', 'A01-1-01', 2, 3, 1, 2, NULL, NULL, 0, 'admin', '2022-03-07 20:12:39', NULL, '2022-03-07 20:12:39');
INSERT INTO `wms_stock_location` VALUES (6, 'A01-1-02', 'A01-1-02', 2, 3, 1, 2, NULL, NULL, 0, 'admin', '2022-03-07 20:12:39', NULL, '2022-03-07 20:12:39');
INSERT INTO `wms_stock_location` VALUES (7, 'A01-1-03', 'A01-1-03', 2, 3, 1, 2, NULL, NULL, 0, 'admin', '2022-03-07 20:12:39', NULL, '2022-03-07 20:12:39');
INSERT INTO `wms_stock_location` VALUES (8, 'A01-1-04', 'A01-1-04', 2, 3, 1, 2, NULL, NULL, 0, 'admin', '2022-03-07 20:12:39', NULL, '2022-03-07 20:12:39');
INSERT INTO `wms_stock_location` VALUES (9, 'A01-1-05', 'A01-1-05', 2, 3, 1, 2, NULL, NULL, 0, 'admin', '2022-03-07 20:12:39', NULL, '2022-03-07 20:12:39');
INSERT INTO `wms_stock_location` VALUES (10, 'A01-1-06', 'A01-1-06', 2, 3, 1, 2, NULL, NULL, 0, 'admin', '2022-03-07 20:12:39', NULL, '2022-03-07 20:12:39');
INSERT INTO `wms_stock_location` VALUES (11, 'A01-1-07', 'A01-1-07', 2, 3, 1, 2, NULL, NULL, 0, 'admin', '2022-03-07 20:12:39', NULL, '2022-03-07 20:12:39');
INSERT INTO `wms_stock_location` VALUES (12, 'A01-1-08', 'A01-1-08', 2, 3, 1, 2, NULL, NULL, 0, 'admin', '2022-03-07 20:12:39', NULL, '2022-03-07 20:12:39');
INSERT INTO `wms_stock_location` VALUES (13, 'A01-1-09', 'A01-1-09', 2, 3, 1, 2, NULL, NULL, 0, 'admin', '2022-03-07 20:12:39', NULL, '2022-03-07 20:12:39');
INSERT INTO `wms_stock_location` VALUES (14, 'A01-1-10', 'A01-1-10', 2, 3, 1, 2, NULL, NULL, 0, 'admin', '2022-03-07 20:12:39', NULL, '2022-03-07 20:12:39');
INSERT INTO `wms_stock_location` VALUES (15, 'A01-1-11', 'A01-1-11', 2, 3, 1, 2, NULL, NULL, 0, 'admin', '2022-03-07 20:12:39', NULL, '2022-03-07 20:12:39');
INSERT INTO `wms_stock_location` VALUES (16, 'A01-1-12', 'A01-1-12', 2, 3, 1, 2, NULL, NULL, 0, 'admin', '2022-03-07 20:12:39', NULL, '2022-03-07 20:12:39');
INSERT INTO `wms_stock_location` VALUES (17, 'A01-1-13', 'A01-1-13', 2, 3, 1, 2, NULL, NULL, 0, 'admin', '2022-03-07 20:12:39', NULL, '2022-03-07 20:12:39');
INSERT INTO `wms_stock_location` VALUES (18, 'A01-1-14', 'A01-1-14', 2, 3, 1, 2, NULL, NULL, 0, 'admin', '2022-03-07 20:12:39', NULL, '2022-03-07 20:12:39');
INSERT INTO `wms_stock_location` VALUES (19, 'A01-1-15', 'A01-1-15', 2, 3, 1, 2, NULL, NULL, 0, 'admin', '2022-03-07 20:12:39', NULL, '2022-03-07 20:12:39');
INSERT INTO `wms_stock_location` VALUES (20, 'A01-1-16', 'A01-1-16', 2, 3, 1, 2, NULL, NULL, 0, 'admin', '2022-03-07 20:12:39', NULL, '2022-03-07 20:12:39');

-- ----------------------------
-- Table structure for wms_stock_out_entry
-- ----------------------------
DROP TABLE IF EXISTS `wms_stock_out_entry`;
CREATE TABLE `wms_stock_out_entry`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `stockOutNum` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '出库单编号',
  `sourceNo` varchar(35) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '来源单据号',
  `sourceId` bigint NULL DEFAULT NULL COMMENT '来源单据Id',
  `stockOutType` int NOT NULL DEFAULT 1 COMMENT '出库类型1订单拣货出库2采购退货出库3盘点出库4报损出库',
  `status` int NOT NULL COMMENT '状态：0待出库1部分出库2全部出库',
  `printStatus` int NOT NULL COMMENT '打印状态：是否打印1已打印0未打印',
  `printTime` datetime NULL DEFAULT NULL COMMENT '打印时间',
  `createTime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建日期',
  `createBy` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `updateTime` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `updateBy` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `completeTime` datetime NULL DEFAULT NULL COMMENT '完成出库时间',
  `stockOutOperatorId` int NULL DEFAULT 0 COMMENT '出库操作人userid',
  `stockOutOperatorName` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '出库操作人',
  `stockOutTime` datetime NULL DEFAULT NULL COMMENT '出库时间',
  `remark` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '备注',
  `isDelete` tinyint NOT NULL DEFAULT 0 COMMENT '是否删除0未删除1已删除',
  `goodsUnit` int NOT NULL COMMENT '商品数',
  `specUnit` int NOT NULL COMMENT '商品规格数',
  `specUnitTotal` int NOT NULL COMMENT '总件数',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '出库单' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of wms_stock_out_entry
-- ----------------------------
INSERT INTO `wms_stock_out_entry` VALUES (2, '202401161452276', NULL, NULL, 1, 0, 0, NULL, '2024-01-16 14:52:29', 'admin', '2024-01-16 14:52:29', NULL, NULL, 0, NULL, NULL, NULL, 0, 1, 1, 1);
INSERT INTO `wms_stock_out_entry` VALUES (3, '202401161504597', NULL, NULL, 1, 0, 0, NULL, '2024-01-16 15:05:02', 'admin', '2024-01-16 15:05:01', NULL, NULL, 0, NULL, NULL, NULL, 0, 1, 1, 1);

-- ----------------------------
-- Table structure for wms_stock_out_entry_item
-- ----------------------------
DROP TABLE IF EXISTS `wms_stock_out_entry_item`;
CREATE TABLE `wms_stock_out_entry_item`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `entryId` bigint NOT NULL COMMENT '出库单id',
  `sourceOrderId` bigint NOT NULL COMMENT '来源订单id',
  `sourceOrderNo` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '' COMMENT '来源订单号',
  `sourceOrderItemId` bigint NOT NULL COMMENT '来源订单itemId出库对应的itemId，如：order_item表id、invoice_info表id',
  `goodsId` int NOT NULL COMMENT '商品id',
  `specId` int NOT NULL COMMENT '商品规格id',
  `specNum` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '' COMMENT '规格编码',
  `originalQuantity` bigint NOT NULL COMMENT '总数量',
  `outQuantity` bigint NOT NULL DEFAULT 0 COMMENT '已出库数量',
  `completeTime` datetime NULL DEFAULT NULL COMMENT '完成出库时间',
  `pickedTime` datetime NULL DEFAULT NULL COMMENT '完成拣货时间',
  `status` int NOT NULL DEFAULT 0 COMMENT '状态：0待出库1部分出库2全部出库',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `specIndex`(`specId`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '出库单明细' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of wms_stock_out_entry_item
-- ----------------------------
INSERT INTO `wms_stock_out_entry_item` VALUES (8, 2, 15, '1631273557325601885', 12, 9, 32, '2720210080260105', 1, 1, '2024-01-16 14:52:43', '2024-01-16 14:52:43', 2);
INSERT INTO `wms_stock_out_entry_item` VALUES (9, 3, 16, '1642473483353670599', 13, 9, 32, '2720210080260105', 1, 1, '2024-01-16 15:05:37', '2024-01-16 15:05:36', 2);

-- ----------------------------
-- Table structure for wms_stock_out_entry_item_detail
-- ----------------------------
DROP TABLE IF EXISTS `wms_stock_out_entry_item_detail`;
CREATE TABLE `wms_stock_out_entry_item_detail`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `entryId` bigint NOT NULL COMMENT '出库单ID',
  `entryItemId` bigint NOT NULL DEFAULT 0 COMMENT '出库单ItemID',
  `goodsInventoryId` bigint NOT NULL DEFAULT 0 COMMENT '库存ID',
  `goodsInventoryDetailId` bigint NOT NULL DEFAULT 0 COMMENT '库存详情ID',
  `quantity` bigint NOT NULL DEFAULT 0 COMMENT '出库数量',
  `locationId` int NULL DEFAULT NULL COMMENT '出库仓位ID',
  `stockOutOperatorId` int NULL DEFAULT 0 COMMENT '出库操作人userid',
  `stockOutOperatorName` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '出库操作人',
  `stockOutTime` datetime NULL DEFAULT NULL COMMENT '出库时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `goods_stock_info_item_id_index`(`goodsInventoryDetailId`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '出库明细详情' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of wms_stock_out_entry_item_detail
-- ----------------------------
INSERT INTO `wms_stock_out_entry_item_detail` VALUES (4, 2, 8, 6, 7, 1, 20, 1, 'admin', '2024-01-16 14:52:43');
INSERT INTO `wms_stock_out_entry_item_detail` VALUES (5, 3, 9, 6, 7, 1, 20, 1, 'admin', '2024-01-16 15:05:32');

SET FOREIGN_KEY_CHECKS = 1;
