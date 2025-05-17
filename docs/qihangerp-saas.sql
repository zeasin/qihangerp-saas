-- MySQL dump 10.13  Distrib 8.0.42, for macos15 (arm64)
--
-- Host: localhost    Database: qihangerp-saas
-- ------------------------------------------------------
-- Server version	8.0.42

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `erp_after_sale`
--

DROP TABLE IF EXISTS `erp_after_sale`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `erp_after_sale` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `type` int NOT NULL COMMENT '类型（10退货；20换货；80补发；99订单拦截；）',
  `shop_id` bigint NOT NULL COMMENT '店铺id',
  `shop_type` int NOT NULL COMMENT '店铺类型',
  `tenant_id` bigint NOT NULL COMMENT '租户id',
  `after_sale_order_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '售后单号',
  `order_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '订单号',
  `sub_order_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '子订单号',
  `product_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '商品spuid',
  `sku_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '商品skuid',
  `count` int DEFAULT NULL COMMENT '数量',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '商品标题',
  `img` varchar(555) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '商品图片',
  `sku_info` varchar(2550) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'sku描述',
  `sku_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'sku编码',
  `erp_goods_id` int DEFAULT NULL COMMENT 'ERP商品id',
  `erp_sku_id` int DEFAULT NULL COMMENT 'ERP商品skuId',
  `return_info` varchar(2550) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '退回人信息json',
  `return_waybill_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '退回快递单号',
  `return_company` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '退回物流公司名称',
  `receiver_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '收件人姓名',
  `receiver_tel` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '收件人联系电话',
  `receiver_province` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '省',
  `receiver_city` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '市',
  `receiver_town` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '区',
  `receiver_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '收件人详细地址',
  `ship_waybill_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '发货快递单号（补发、换货发货、拦截订单发货）',
  `ship_company` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '发货快递公司',
  `status` int DEFAULT NULL COMMENT '状态:1已发出；2已完成(已收货);3已入库',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  `create_time` datetime DEFAULT NULL,
  `create_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `update_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='售后处理表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `erp_after_sale`
--

LOCK TABLES `erp_after_sale` WRITE;
/*!40000 ALTER TABLE `erp_after_sale` DISABLE KEYS */;
/*!40000 ALTER TABLE `erp_after_sale` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `erp_goods`
--

DROP TABLE IF EXISTS `erp_goods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `erp_goods` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `tenant_id` bigint NOT NULL COMMENT '租户id',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '' COMMENT '商品名称',
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '商品图片地址',
  `number` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '' COMMENT '商品编号',
  `unit_name` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '' COMMENT '单位名称',
  `category_id` bigint DEFAULT '0' COMMENT '商品分类ID',
  `bar_code` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '' COMMENT '条码',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '' COMMENT '备注',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态1销售中2已下架',
  `length` float NOT NULL DEFAULT '0' COMMENT '衣长/裙长/裤长',
  `height` float NOT NULL DEFAULT '0' COMMENT '高度/袖长',
  `width` float NOT NULL DEFAULT '0' COMMENT '宽度/胸阔(围)',
  `width1` float NOT NULL DEFAULT '0' COMMENT '肩阔',
  `width2` float NOT NULL DEFAULT '0' COMMENT '腰阔',
  `width3` float NOT NULL DEFAULT '0' COMMENT '臀阔',
  `weight` float NOT NULL DEFAULT '0' COMMENT '重量',
  `disable` tinyint(1) DEFAULT '0' COMMENT '1启用   0禁用',
  `period` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '0' COMMENT '保质期',
  `pur_price` decimal(8,2) DEFAULT '0.00' COMMENT '预计采购价格',
  `whole_price` decimal(8,2) DEFAULT '0.00' COMMENT '建议批发价',
  `retail_price` decimal(8,2) DEFAULT '0.00' COMMENT '建议零售价',
  `unit_cost` decimal(8,2) DEFAULT NULL COMMENT '单位成本',
  `supplier_id` bigint DEFAULT '0' COMMENT '供应商id',
  `brand_id` bigint DEFAULT '0' COMMENT '品牌id',
  `attr1` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '属性1：季节',
  `attr2` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '属性2：分类',
  `attr3` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '属性3：风格',
  `attr4` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '属性4：年份',
  `attr5` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '属性5：面料',
  `link_url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '外链url',
  `low_qty` int DEFAULT '0' COMMENT '最低库存（预警）',
  `high_qty` int DEFAULT '0' COMMENT '最高库存（预警）',
  `create_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `number` (`number`) USING BTREE,
  KEY `id` (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='商品库存管理';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `erp_goods`
--

LOCK TABLES `erp_goods` WRITE;
/*!40000 ALTER TABLE `erp_goods` DISABLE KEYS */;
INSERT INTO `erp_goods` VALUES (1,100,'牛仔短裤女a字裤紧身夏高腰显瘦ins辣妹风外穿包臀直筒弹力热裤子','https://mmecimage.cn/p/wx82dd65f284dd6ee3/HBkkngG4j2Utl9HiMhfCsrBNvSN2MJFnzJR9oJH8PQ','10000227212454','',0,'','店铺商品同步',1,0,0,0,0,0,0,0,1,'0',0.00,0.00,89.00,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,0,0,'店铺商品同步','2025-05-17 16:07:03',NULL,NULL),(2,100,'夏季韩版ins黑灰高腰小个子牛仔半身裙女百搭显瘦包臀a字短裙子潮','https://mmecimage.cn/p/wx82dd65f284dd6ee3/HC7tyxMJYp0ui4hs75bVPBTLOpMsBKTzU9qH9lUl5Q','10000226806665','',0,'','店铺商品同步',1,0,0,0,0,0,0,0,1,'0',0.00,0.00,99.00,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,0,0,'店铺商品同步','2025-05-17 16:07:03',NULL,NULL);
/*!40000 ALTER TABLE `erp_goods` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `erp_goods_brand`
--

DROP TABLE IF EXISTS `erp_goods_brand`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `erp_goods_brand` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '品牌名',
  `status` int NOT NULL COMMENT '状态',
  `tenant_id` bigint NOT NULL COMMENT '租户id（sys_user_id）',
  `create_by` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_by` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `erp_goods_brand`
--

LOCK TABLES `erp_goods_brand` WRITE;
/*!40000 ALTER TABLE `erp_goods_brand` DISABLE KEYS */;
INSERT INTO `erp_goods_brand` VALUES (1,'梦小妮',1,100,'admin','2023-12-29 13:44:29','admin','2023-12-29 13:44:29');
/*!40000 ALTER TABLE `erp_goods_brand` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `erp_goods_category`
--

DROP TABLE IF EXISTS `erp_goods_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `erp_goods_category` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `number` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '分类编码',
  `name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '分类名称',
  `remark` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '备注',
  `top_id` bigint DEFAULT NULL COMMENT '最顶级id',
  `parent_id` bigint DEFAULT NULL COMMENT '上架分类id',
  `path` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '分类路径',
  `sort` int DEFAULT '0' COMMENT '排序值',
  `image` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '图片',
  `is_delete` tinyint(1) DEFAULT '0' COMMENT '0正常  1删除',
  `tenant_id` bigint DEFAULT NULL COMMENT '租户id',
  `create_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `erp_goods_category`
--

LOCK TABLES `erp_goods_category` WRITE;
/*!40000 ALTER TABLE `erp_goods_category` DISABLE KEYS */;
INSERT INTO `erp_goods_category` VALUES (1,'A0222D','女装',NULL,0,0,'',0,NULL,0,100,'手动添加','2024-04-21 13:24:39','手动更新','2025-05-07 17:33:01'),(2,'A220252','牛仔裤',NULL,1,1,'',4,NULL,0,100,'手动添加','2024-04-21 13:26:31','手动更新','2025-05-07 17:33:21'),(3,'KUZI','短裤',NULL,1,1,'',0,NULL,0,100,'手动添加','2024-04-21 16:48:42','手动更新','2025-05-07 17:33:30'),(4,'1','11111',NULL,0,0,'',0,NULL,0,104,'手动添加','2025-04-19 12:19:00',NULL,NULL),(5,'01','头盔',NULL,0,0,'',0,NULL,0,133,'手动添加','2025-05-07 16:22:00',NULL,NULL);
/*!40000 ALTER TABLE `erp_goods_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `erp_goods_category_attribute`
--

DROP TABLE IF EXISTS `erp_goods_category_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `erp_goods_category_attribute` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `category_id` bigint NOT NULL,
  `type` int NOT NULL DEFAULT '0' COMMENT '类型：0属性1规格',
  `title` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '''属性名''',
  `code` char(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '固定值color颜色size尺码style款式',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=222 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `erp_goods_category_attribute`
--

LOCK TABLES `erp_goods_category_attribute` WRITE;
/*!40000 ALTER TABLE `erp_goods_category_attribute` DISABLE KEYS */;
INSERT INTO `erp_goods_category_attribute` VALUES (114,1,1,'颜色','color'),(115,1,1,'尺码','size'),(116,1,1,'款式','style'),(200,1,1,'颜色','color'),(210,1,1,'尺码','size'),(221,4,1,'123','color');
/*!40000 ALTER TABLE `erp_goods_category_attribute` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `erp_goods_category_attribute_value`
--

DROP TABLE IF EXISTS `erp_goods_category_attribute_value`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `erp_goods_category_attribute_value` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键，属性值id',
  `category_attribute_id` bigint DEFAULT NULL COMMENT '属性id',
  `value` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '属性值文本',
  `sku_code` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '生成SKU的编码',
  `order_num` int DEFAULT '0',
  `is_delete` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=427 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `erp_goods_category_attribute_value`
--

LOCK TABLES `erp_goods_category_attribute_value` WRITE;
/*!40000 ALTER TABLE `erp_goods_category_attribute_value` DISABLE KEYS */;
INSERT INTO `erp_goods_category_attribute_value` VALUES (308,114,'黑色','01',999,0),(309,114,'米杏','02',0,0),(310,114,'芒果黄','03',0,0),(311,114,'中花灰','04',0,0),(312,114,'浅杏','05',0,0),(313,114,'中粉','06',0,0),(314,114,'烟灰色','07',88,0),(315,114,'秋香绿','08',0,0),(316,114,'花兰','09',0,0),(317,114,'杏色','10',698,0),(318,114,'芥黄','11',0,0),(319,114,'深蓝色','12',993,0),(320,114,'大红','13',0,0),(321,114,'彩兰','14',0,0),(322,114,'白色','15',99,0),(323,114,'花米驼','16',0,0),(324,114,'粉红','17',0,0),(325,114,'黄杏','18',0,0),(326,114,'橙红','19',0,0),(327,114,'木绿','20',0,0),(328,114,'草绿','21',0,0),(329,114,'早红','22',0,0),(330,114,'咖啡','23',0,0),(331,114,'灰色','24',99,0),(332,114,'浅绿','25',0,0),(333,114,'大红色','26',99,0),(334,114,'桔色','27',0,0),(335,114,'卡其','28',992,0),(336,114,'蓝灰色','29',996,0),(337,114,'湖蓝','30',0,0),(338,114,'咖啡色','31',99,0),(339,114,'蓝绿','32',0,0),(340,115,'均码','00',0,0),(341,115,'S','01',88,0),(342,115,'M','02',87,0),(343,115,'L','03',86,0),(344,115,'XL','04',85,0),(345,115,'2XL','05',84,0),(346,115,'3XL','06',0,0),(347,115,'4XL','07',0,0),(348,115,'5XL','08',0,0),(349,114,'雾霾蓝','33',0,0),(350,114,'浅粉红','34',0,0),(351,114,'蓝色','35',998,0),(352,114,'花色','36',0,0),(353,114,'香槟色','37',0,0),(354,114,'紫色','38',0,0),(355,114,'砖红色','39',0,0),(356,114,'复古蓝','40',995,0),(357,114,'烟灰','41',0,0),(358,114,'橙黄','42',0,0),(359,114,'黄色','43',0,0),(360,114,'梅子色','56',0,0),(361,114,'浅蓝色','50',994,0),(362,114,'宝蓝色','44',99,0),(363,114,'浅黄','45',0,0),(364,114,'浅紫','49',0,0),(365,114,'酒红','57',99,0),(366,114,'米白','47',99,0),(367,114,'复古蓝九分','48',88,0),(368,114,'卡灰','51',992,0),(369,114,'玫红','52',0,0),(370,114,'彩蓝','53',0,0),(371,114,'青蓝淡黄','54',0,0),(372,114,'紫白','55',0,0),(373,114,'碳灰','58',0,0),(374,114,'深蓝色加绒','59',794,0),(375,114,'深紫色','60',99,0),(376,114,'橙色','61',0,0),(377,114,'墨绿色','62',99,0),(378,114,'桃粉色','63',0,0),(379,114,'蓝灰色九分','64',88,0),(380,114,'黑色九分','65',88,0),(381,114,'新洋米','67',0,0),(382,114,'藏蓝色','68',99,0),(383,114,'深蓝九分','69',88,0),(384,114,'深蓝长款','70',88,0),(385,114,'米白色','71',0,0),(386,114,'军绿色','72',0,0),(387,114,'柠檬黄','73',0,0),(388,114,'灰紫','74',0,0),(389,114,'黑灰色','75',997,0),(390,114,'焦糖红','76',0,0),(391,114,'酱紫','78',0,0),(392,114,'红杏','46',0,0),(393,114,'银灰','79',0,0),(394,115,'XS','09',89,0),(395,114,'无色','00',0,0),(396,114,'条纹','80',0,0),(397,114,'花色/彩色','81',0,0),(398,114,'波点','82',0,0),(399,114,'字母','83',0,0),(400,114,'绿色','84',0,0),(401,115,'25','25',69,0),(402,115,'26','26',68,0),(403,115,'27','27',67,0),(404,115,'28','28',66,0),(405,115,'29','29',65,0),(406,115,'30','30',64,0),(407,115,'31','31',63,0),(408,115,'32','32',62,0),(409,114,'黑色加绒','101',799,0),(410,114,'黑灰色加绒','175',798,0),(411,114,'蓝灰色加绒','129',797,0),(412,114,'复古蓝加绒','140',796,0),(413,114,'浅蓝色加绒','150',795,0),(414,116,'默认',NULL,0,0),(415,116,'加长裤','JC',66,0),(416,116,'长裤','CK',68,0),(417,116,'九分','JF',88,0),(418,116,'八分','BF',86,0),(419,116,'九分加绒','JFR',87,0),(420,116,'单裤','D',0,0),(421,116,'加绒','R',0,0),(422,116,'长裤加绒','CR',65,0),(423,116,'加长裤加绒','JCR',67,0),(424,200,'红色','00',0,0),(425,221,'红色','XX',0,0),(426,221,'白色','XX',0,0);
/*!40000 ALTER TABLE `erp_goods_category_attribute_value` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `erp_goods_inventory`
--

DROP TABLE IF EXISTS `erp_goods_inventory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `erp_goods_inventory` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `goods_id` bigint NOT NULL COMMENT '商品id',
  `goods_num` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '商品编码',
  `sku_id` bigint NOT NULL COMMENT '商品规格id',
  `sku_code` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '规格编码（唯一）',
  `goods_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '商品名',
  `goods_img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '商品图片',
  `sku_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'SKU名',
  `quantity` bigint NOT NULL DEFAULT '0' COMMENT '当前库存',
  `is_delete` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常  1删除',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '创建人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `update_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '更新人',
  `tenant_id` bigint NOT NULL COMMENT '租户 id',
  `locked_qty` int NOT NULL DEFAULT '0' COMMENT '锁定的库存（订单发货出库就锁定库存）',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `specIdIndex` (`sku_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='商品库存表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `erp_goods_inventory`
--

LOCK TABLES `erp_goods_inventory` WRITE;
/*!40000 ALTER TABLE `erp_goods_inventory` DISABLE KEYS */;
INSERT INTO `erp_goods_inventory` VALUES (18,1,'10000227212454',1,'A20701','牛仔短裤女a字裤紧身夏高腰显瘦ins辣妹风外穿包臀直筒弹力热裤子','https://mmecimage.cn/p/wx82dd65f284dd6ee3/HBkkngG4j2Utl9HiMhfCsrBNvSN2MJFnzJR9oJH8PQ','S',0,0,'2025-05-17 08:07:03','同步店铺商品初始化商品 sku 库存','2025-05-17 08:07:03',NULL,100,0),(19,1,'10000227212454',2,'A20702','牛仔短裤女a字裤紧身夏高腰显瘦ins辣妹风外穿包臀直筒弹力热裤子','https://mmecimage.cn/p/wx82dd65f284dd6ee3/HBkkngG4j2Utl9HiMhfCsrBNvSN2MJFnzJR9oJH8PQ','M',0,0,'2025-05-17 08:07:03','同步店铺商品初始化商品 sku 库存','2025-05-17 08:07:03',NULL,100,0),(20,1,'10000227212454',3,'A20703','牛仔短裤女a字裤紧身夏高腰显瘦ins辣妹风外穿包臀直筒弹力热裤子','https://mmecimage.cn/p/wx82dd65f284dd6ee3/HBkkngG4j2Utl9HiMhfCsrBNvSN2MJFnzJR9oJH8PQ','L',0,0,'2025-05-17 08:07:03','同步店铺商品初始化商品 sku 库存','2025-05-17 08:07:03',NULL,100,0),(21,1,'10000227212454',4,'A20704','牛仔短裤女a字裤紧身夏高腰显瘦ins辣妹风外穿包臀直筒弹力热裤子','https://mmecimage.cn/p/wx82dd65f284dd6ee3/HBkkngG4j2Utl9HiMhfCsrBNvSN2MJFnzJR9oJH8PQ','XL',0,0,'2025-05-17 08:07:03','同步店铺商品初始化商品 sku 库存','2025-05-17 08:07:03',NULL,100,0),(22,1,'10000227212454',5,'A20705','牛仔短裤女a字裤紧身夏高腰显瘦ins辣妹风外穿包臀直筒弹力热裤子','https://mmecimage.cn/p/wx82dd65f284dd6ee3/HBkkngG4j2Utl9HiMhfCsrBNvSN2MJFnzJR9oJH8PQ','2XL',0,0,'2025-05-17 08:07:03','同步店铺商品初始化商品 sku 库存','2025-05-17 08:07:03',NULL,100,0),(23,2,'10000226806665',6,'A00111','夏季韩版ins黑灰高腰小个子牛仔半身裙女百搭显瘦包臀a字短裙子潮','https://mmecimage.cn/p/wx82dd65f284dd6ee3/HC7tyxMJYp0ui4hs75bVPBTLOpMsBKTzU9qH9lUl5Q','黑色 S',0,0,'2025-05-17 08:07:03','同步店铺商品初始化商品 sku 库存','2025-05-17 08:07:03',NULL,100,0),(24,2,'10000226806665',7,'A00112','夏季韩版ins黑灰高腰小个子牛仔半身裙女百搭显瘦包臀a字短裙子潮','https://mmecimage.cn/p/wx82dd65f284dd6ee3/HC7tyxMJYp0ui4hs75bVPBTLOpMsBKTzU9qH9lUl5Q','黑色 M',0,0,'2025-05-17 08:07:03','同步店铺商品初始化商品 sku 库存','2025-05-17 08:07:03',NULL,100,0),(25,2,'10000226806665',8,'A00113','夏季韩版ins黑灰高腰小个子牛仔半身裙女百搭显瘦包臀a字短裙子潮','https://mmecimage.cn/p/wx82dd65f284dd6ee3/HC7tyxMJYp0ui4hs75bVPBTLOpMsBKTzU9qH9lUl5Q','黑色 L',0,0,'2025-05-17 08:07:03','同步店铺商品初始化商品 sku 库存','2025-05-17 08:07:03',NULL,100,0),(26,2,'10000226806665',9,'A00114','夏季韩版ins黑灰高腰小个子牛仔半身裙女百搭显瘦包臀a字短裙子潮','https://mmecimage.cn/p/wx82dd65f284dd6ee3/HC7tyxMJYp0ui4hs75bVPBTLOpMsBKTzU9qH9lUl5Q','黑色 XL',0,0,'2025-05-17 08:07:03','同步店铺商品初始化商品 sku 库存','2025-05-17 08:07:03',NULL,100,0),(27,2,'10000226806665',10,'A00121','夏季韩版ins黑灰高腰小个子牛仔半身裙女百搭显瘦包臀a字短裙子潮','https://mmecimage.cn/p/wx82dd65f284dd6ee3/HC7tyxMJYp0ui4hs75bVPBTLOpMsBKTzU9qH9lUl5Q','黑灰 S',0,0,'2025-05-17 08:07:03','同步店铺商品初始化商品 sku 库存','2025-05-17 08:07:03',NULL,100,0),(28,2,'10000226806665',11,'A00122','夏季韩版ins黑灰高腰小个子牛仔半身裙女百搭显瘦包臀a字短裙子潮','https://mmecimage.cn/p/wx82dd65f284dd6ee3/HC7tyxMJYp0ui4hs75bVPBTLOpMsBKTzU9qH9lUl5Q','黑灰 M',0,0,'2025-05-17 08:07:03','同步店铺商品初始化商品 sku 库存','2025-05-17 08:07:03',NULL,100,0),(29,2,'10000226806665',12,'A00123','夏季韩版ins黑灰高腰小个子牛仔半身裙女百搭显瘦包臀a字短裙子潮','https://mmecimage.cn/p/wx82dd65f284dd6ee3/HC7tyxMJYp0ui4hs75bVPBTLOpMsBKTzU9qH9lUl5Q','黑灰 L',0,0,'2025-05-17 08:07:03','同步店铺商品初始化商品 sku 库存','2025-05-17 08:07:03',NULL,100,0),(30,2,'10000226806665',13,'A00124','夏季韩版ins黑灰高腰小个子牛仔半身裙女百搭显瘦包臀a字短裙子潮','https://mmecimage.cn/p/wx82dd65f284dd6ee3/HC7tyxMJYp0ui4hs75bVPBTLOpMsBKTzU9qH9lUl5Q','黑灰 XL',0,0,'2025-05-17 08:07:03','同步店铺商品初始化商品 sku 库存','2025-05-17 08:07:03',NULL,100,0),(31,2,'10000226806665',14,'A00131','夏季韩版ins黑灰高腰小个子牛仔半身裙女百搭显瘦包臀a字短裙子潮','https://mmecimage.cn/p/wx82dd65f284dd6ee3/HC7tyxMJYp0ui4hs75bVPBTLOpMsBKTzU9qH9lUl5Q','浅蓝 S',0,0,'2025-05-17 08:07:03','同步店铺商品初始化商品 sku 库存','2025-05-17 08:07:03',NULL,100,0),(32,2,'10000226806665',15,'A00132','夏季韩版ins黑灰高腰小个子牛仔半身裙女百搭显瘦包臀a字短裙子潮','https://mmecimage.cn/p/wx82dd65f284dd6ee3/HC7tyxMJYp0ui4hs75bVPBTLOpMsBKTzU9qH9lUl5Q','浅蓝 M',0,0,'2025-05-17 08:07:03','同步店铺商品初始化商品 sku 库存','2025-05-17 08:07:03',NULL,100,0),(33,2,'10000226806665',16,'A00133','夏季韩版ins黑灰高腰小个子牛仔半身裙女百搭显瘦包臀a字短裙子潮','https://mmecimage.cn/p/wx82dd65f284dd6ee3/HC7tyxMJYp0ui4hs75bVPBTLOpMsBKTzU9qH9lUl5Q','浅蓝 L',0,0,'2025-05-17 08:07:03','同步店铺商品初始化商品 sku 库存','2025-05-17 08:07:03',NULL,100,0),(34,2,'10000226806665',17,'A00134','夏季韩版ins黑灰高腰小个子牛仔半身裙女百搭显瘦包臀a字短裙子潮','https://mmecimage.cn/p/wx82dd65f284dd6ee3/HC7tyxMJYp0ui4hs75bVPBTLOpMsBKTzU9qH9lUl5Q','浅蓝 XL',0,0,'2025-05-17 08:07:03','同步店铺商品初始化商品 sku 库存','2025-05-17 08:07:03',NULL,100,0),(35,2,'10000226806665',18,'A00141','夏季韩版ins黑灰高腰小个子牛仔半身裙女百搭显瘦包臀a字短裙子潮','https://mmecimage.cn/p/wx82dd65f284dd6ee3/HC7tyxMJYp0ui4hs75bVPBTLOpMsBKTzU9qH9lUl5Q','深蓝 S',0,0,'2025-05-17 08:07:03','同步店铺商品初始化商品 sku 库存','2025-05-17 08:07:03',NULL,100,0),(36,2,'10000226806665',19,'A00142','夏季韩版ins黑灰高腰小个子牛仔半身裙女百搭显瘦包臀a字短裙子潮','https://mmecimage.cn/p/wx82dd65f284dd6ee3/HC7tyxMJYp0ui4hs75bVPBTLOpMsBKTzU9qH9lUl5Q','深蓝 M',0,0,'2025-05-17 08:07:03','同步店铺商品初始化商品 sku 库存','2025-05-17 08:07:03',NULL,100,0),(37,2,'10000226806665',20,'A00143','夏季韩版ins黑灰高腰小个子牛仔半身裙女百搭显瘦包臀a字短裙子潮','https://mmecimage.cn/p/wx82dd65f284dd6ee3/HC7tyxMJYp0ui4hs75bVPBTLOpMsBKTzU9qH9lUl5Q','深蓝 L',0,0,'2025-05-17 08:07:03','同步店铺商品初始化商品 sku 库存','2025-05-17 08:07:03',NULL,100,0),(38,2,'10000226806665',21,'A00144','夏季韩版ins黑灰高腰小个子牛仔半身裙女百搭显瘦包臀a字短裙子潮','https://mmecimage.cn/p/wx82dd65f284dd6ee3/HC7tyxMJYp0ui4hs75bVPBTLOpMsBKTzU9qH9lUl5Q','深蓝 XL',0,0,'2025-05-17 08:07:03','同步店铺商品初始化商品 sku 库存','2025-05-17 08:07:03',NULL,100,0);
/*!40000 ALTER TABLE `erp_goods_inventory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `erp_goods_inventory_batch`
--

DROP TABLE IF EXISTS `erp_goods_inventory_batch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `erp_goods_inventory_batch` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `inventory_id` bigint NOT NULL COMMENT '库存主键id',
  `batch_num` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '批次号',
  `origin_qty` bigint NOT NULL COMMENT '初始数量',
  `current_qty` bigint NOT NULL DEFAULT '0' COMMENT '当前数量',
  `pur_price` double DEFAULT '0' COMMENT '采购价',
  `pur_id` bigint NOT NULL COMMENT '采购单id',
  `pur_item_id` bigint NOT NULL COMMENT '采购单itemId',
  `remark` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  `sku_id` bigint NOT NULL COMMENT '规格id',
  `goods_id` bigint NOT NULL COMMENT '商品id',
  `sku_code` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'sku编码',
  `warehouse_id` bigint NOT NULL COMMENT '仓库id',
  `position_id` bigint NOT NULL COMMENT '仓位id',
  `position_num` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '仓位编码',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '创建人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `update_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='商品库存批次';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `erp_goods_inventory_batch`
--

LOCK TABLES `erp_goods_inventory_batch` WRITE;
/*!40000 ALTER TABLE `erp_goods_inventory_batch` DISABLE KEYS */;
/*!40000 ALTER TABLE `erp_goods_inventory_batch` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `erp_goods_inventory_operation`
--

DROP TABLE IF EXISTS `erp_goods_inventory_operation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `erp_goods_inventory_operation` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `goods_id` bigint NOT NULL COMMENT '商品id',
  `goods_num` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '商品编码',
  `sku_id` bigint NOT NULL COMMENT '商品规格id',
  `sku_code` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '规格编码（唯一）',
  `batch_id` bigint NOT NULL COMMENT '库存批次id',
  `batch_num` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '库存批次号',
  `type` int NOT NULL COMMENT '库存类型（1增加库存2减少库存3锁定库存）',
  `inventory_detail_id` bigint NOT NULL COMMENT '商品库存id（本表id减库存的时候关联）',
  `quantity` int NOT NULL DEFAULT '0' COMMENT '操作库存数量',
  `locked_quantity` int NOT NULL COMMENT '锁定库存数量（status变成已结算时把该字段值更新到quantity）',
  `price` double DEFAULT '0' COMMENT '价格（type=1采购价格；type=2出库时的价格）',
  `biz_type` int NOT NULL COMMENT '业务类型（10采购入库20采购退货30退货入库40订单出库）',
  `biz_id` bigint NOT NULL COMMENT '业务单id',
  `biz_num` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '业务单号',
  `biz_item_id` bigint NOT NULL COMMENT '业务单itemId',
  `status` int NOT NULL COMMENT '状态（0待结算1已结算）',
  `remark` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  `warehouse_id` bigint NOT NULL COMMENT '仓库id',
  `position_id` bigint NOT NULL COMMENT '仓位id',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '创建人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `update_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='仓库库存操作记录表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `erp_goods_inventory_operation`
--

LOCK TABLES `erp_goods_inventory_operation` WRITE;
/*!40000 ALTER TABLE `erp_goods_inventory_operation` DISABLE KEYS */;
/*!40000 ALTER TABLE `erp_goods_inventory_operation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `erp_goods_sku`
--

DROP TABLE IF EXISTS `erp_goods_sku`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `erp_goods_sku` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `goods_id` bigint NOT NULL COMMENT '商品id',
  `tenant_id` bigint NOT NULL COMMENT '租户id',
  `goods_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '商品名',
  `goods_num` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '商品编码',
  `spec_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '' COMMENT '规格名',
  `spec_num` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '规格编码',
  `color_id` int DEFAULT '0' COMMENT '颜色id',
  `color_label` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '颜色文本',
  `color_value` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '颜色值',
  `color_image` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '颜色图片',
  `size_id` int DEFAULT '0' COMMENT '尺码id',
  `size_label` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '尺码文本',
  `size_value` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '尺码值',
  `style_id` int DEFAULT '0' COMMENT '款式id',
  `style_label` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '款式文本',
  `style_value` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '款式值',
  `bar_code` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '库存条形码',
  `pur_price` decimal(8,2) DEFAULT '0.00' COMMENT '预计采购价',
  `whole_price` decimal(8,2) DEFAULT '0.00' COMMENT '建议批发价',
  `retail_price` decimal(8,2) DEFAULT '0.00' COMMENT '建议零售价',
  `unit_cost` decimal(8,2) DEFAULT '0.00' COMMENT '单位成本',
  `remark` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '' COMMENT '备注',
  `status` tinyint(1) DEFAULT '1' COMMENT '状态',
  `low_qty` int DEFAULT '0' COMMENT '最低库存（预警）',
  `high_qty` int DEFAULT '0' COMMENT '最高库存（预警）',
  `disable` tinyint(1) DEFAULT '0' COMMENT '0启用   1禁用',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `id` (`id`) USING BTREE,
  KEY `number` (`spec_num`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='商品规格';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `erp_goods_sku`
--

LOCK TABLES `erp_goods_sku` WRITE;
/*!40000 ALTER TABLE `erp_goods_sku` DISABLE KEYS */;
INSERT INTO `erp_goods_sku` VALUES (1,1,100,'牛仔短裤女a字裤紧身夏高腰显瘦ins辣妹风外穿包臀直筒弹力热裤子','10000227212454','S','A20701',0,'尺码','S','https://mmecimage.cn/p/wx82dd65f284dd6ee3/HBkkngG4j2Utl9HiMhfCsrBNvSN2MJFnzJR9oJH8PQ',0,NULL,NULL,0,NULL,NULL,NULL,0.00,0.00,89.00,0.00,'',1,0,0,0),(2,1,100,'牛仔短裤女a字裤紧身夏高腰显瘦ins辣妹风外穿包臀直筒弹力热裤子','10000227212454','M','A20702',0,'尺码','M','https://mmecimage.cn/p/wx82dd65f284dd6ee3/HBkkngG4j2Utl9HiMhfCsrBNvSN2MJFnzJR9oJH8PQ',0,NULL,NULL,0,NULL,NULL,NULL,0.00,0.00,89.00,0.00,'',1,0,0,0),(3,1,100,'牛仔短裤女a字裤紧身夏高腰显瘦ins辣妹风外穿包臀直筒弹力热裤子','10000227212454','L','A20703',0,'尺码','L','https://mmecimage.cn/p/wx82dd65f284dd6ee3/HBkkngG4j2Utl9HiMhfCsrBNvSN2MJFnzJR9oJH8PQ',0,NULL,NULL,0,NULL,NULL,NULL,0.00,0.00,89.00,0.00,'',1,0,0,0),(4,1,100,'牛仔短裤女a字裤紧身夏高腰显瘦ins辣妹风外穿包臀直筒弹力热裤子','10000227212454','XL','A20704',0,'尺码','XL','https://mmecimage.cn/p/wx82dd65f284dd6ee3/HBkkngG4j2Utl9HiMhfCsrBNvSN2MJFnzJR9oJH8PQ',0,NULL,NULL,0,NULL,NULL,NULL,0.00,0.00,89.00,0.00,'',1,0,0,0),(5,1,100,'牛仔短裤女a字裤紧身夏高腰显瘦ins辣妹风外穿包臀直筒弹力热裤子','10000227212454','2XL','A20705',0,'尺码','2XL','https://mmecimage.cn/p/wx82dd65f284dd6ee3/HBkkngG4j2Utl9HiMhfCsrBNvSN2MJFnzJR9oJH8PQ',0,NULL,NULL,0,NULL,NULL,NULL,0.00,0.00,89.00,0.00,'',1,0,0,0),(6,2,100,'夏季韩版ins黑灰高腰小个子牛仔半身裙女百搭显瘦包臀a字短裙子潮','10000226806665','黑色 S','A00111',0,'颜色','黑色','https://mmecimage.cn/p/wx82dd65f284dd6ee3/HBviRG_AELkO2KG1mE7Yy6nq6h9mhp51zPAKIU34tQ',0,'尺码','S',0,NULL,NULL,NULL,0.00,0.00,99.00,0.00,'',1,0,0,0),(7,2,100,'夏季韩版ins黑灰高腰小个子牛仔半身裙女百搭显瘦包臀a字短裙子潮','10000226806665','黑色 M','A00112',0,'颜色','黑色','https://mmecimage.cn/p/wx82dd65f284dd6ee3/HBviRG_AELkO2KG1mE7Yy6nq6h9mhp51zPAKIU34tQ',0,'尺码','M',0,NULL,NULL,NULL,0.00,0.00,99.00,0.00,'',1,0,0,0),(8,2,100,'夏季韩版ins黑灰高腰小个子牛仔半身裙女百搭显瘦包臀a字短裙子潮','10000226806665','黑色 L','A00113',0,'颜色','黑色','https://mmecimage.cn/p/wx82dd65f284dd6ee3/HBviRG_AELkO2KG1mE7Yy6nq6h9mhp51zPAKIU34tQ',0,'尺码','L',0,NULL,NULL,NULL,0.00,0.00,99.00,0.00,'',1,0,0,0),(9,2,100,'夏季韩版ins黑灰高腰小个子牛仔半身裙女百搭显瘦包臀a字短裙子潮','10000226806665','黑色 XL','A00114',0,'颜色','黑色','https://mmecimage.cn/p/wx82dd65f284dd6ee3/HBviRG_AELkO2KG1mE7Yy6nq6h9mhp51zPAKIU34tQ',0,'尺码','XL',0,NULL,NULL,NULL,0.00,0.00,99.00,0.00,'',1,0,0,0),(10,2,100,'夏季韩版ins黑灰高腰小个子牛仔半身裙女百搭显瘦包臀a字短裙子潮','10000226806665','黑灰 S','A00121',0,'颜色','黑灰','https://mmecimage.cn/p/wx82dd65f284dd6ee3/HEHGX3o_N2LjMf2Een41P9r3AR2d0eTtyi9F9CDLpA',0,'尺码','S',0,NULL,NULL,NULL,0.00,0.00,99.00,0.00,'',1,0,0,0),(11,2,100,'夏季韩版ins黑灰高腰小个子牛仔半身裙女百搭显瘦包臀a字短裙子潮','10000226806665','黑灰 M','A00122',0,'颜色','黑灰','https://mmecimage.cn/p/wx82dd65f284dd6ee3/HEHGX3o_N2LjMf2Een41P9r3AR2d0eTtyi9F9CDLpA',0,'尺码','M',0,NULL,NULL,NULL,0.00,0.00,99.00,0.00,'',1,0,0,0),(12,2,100,'夏季韩版ins黑灰高腰小个子牛仔半身裙女百搭显瘦包臀a字短裙子潮','10000226806665','黑灰 L','A00123',0,'颜色','黑灰','https://mmecimage.cn/p/wx82dd65f284dd6ee3/HEHGX3o_N2LjMf2Een41P9r3AR2d0eTtyi9F9CDLpA',0,'尺码','L',0,NULL,NULL,NULL,0.00,0.00,99.00,0.00,'',1,0,0,0),(13,2,100,'夏季韩版ins黑灰高腰小个子牛仔半身裙女百搭显瘦包臀a字短裙子潮','10000226806665','黑灰 XL','A00124',0,'颜色','黑灰','https://mmecimage.cn/p/wx82dd65f284dd6ee3/HEHGX3o_N2LjMf2Een41P9r3AR2d0eTtyi9F9CDLpA',0,'尺码','XL',0,NULL,NULL,NULL,0.00,0.00,99.00,0.00,'',1,0,0,0),(14,2,100,'夏季韩版ins黑灰高腰小个子牛仔半身裙女百搭显瘦包臀a字短裙子潮','10000226806665','浅蓝 S','A00131',0,'颜色','浅蓝','https://mmecimage.cn/p/wx82dd65f284dd6ee3/HIYiX-phXBu7QyEA3kYEXvMR67rApf_led1cIzWXfQ',0,'尺码','S',0,NULL,NULL,NULL,0.00,0.00,99.00,0.00,'',1,0,0,0),(15,2,100,'夏季韩版ins黑灰高腰小个子牛仔半身裙女百搭显瘦包臀a字短裙子潮','10000226806665','浅蓝 M','A00132',0,'颜色','浅蓝','https://mmecimage.cn/p/wx82dd65f284dd6ee3/HIYiX-phXBu7QyEA3kYEXvMR67rApf_led1cIzWXfQ',0,'尺码','M',0,NULL,NULL,NULL,0.00,0.00,99.00,0.00,'',1,0,0,0),(16,2,100,'夏季韩版ins黑灰高腰小个子牛仔半身裙女百搭显瘦包臀a字短裙子潮','10000226806665','浅蓝 L','A00133',0,'颜色','浅蓝','https://mmecimage.cn/p/wx82dd65f284dd6ee3/HIYiX-phXBu7QyEA3kYEXvMR67rApf_led1cIzWXfQ',0,'尺码','L',0,NULL,NULL,NULL,0.00,0.00,99.00,0.00,'',1,0,0,0),(17,2,100,'夏季韩版ins黑灰高腰小个子牛仔半身裙女百搭显瘦包臀a字短裙子潮','10000226806665','浅蓝 XL','A00134',0,'颜色','浅蓝','https://mmecimage.cn/p/wx82dd65f284dd6ee3/HIYiX-phXBu7QyEA3kYEXvMR67rApf_led1cIzWXfQ',0,'尺码','XL',0,NULL,NULL,NULL,0.00,0.00,99.00,0.00,'',1,0,0,0),(18,2,100,'夏季韩版ins黑灰高腰小个子牛仔半身裙女百搭显瘦包臀a字短裙子潮','10000226806665','深蓝 S','A00141',0,'颜色','深蓝','https://mmecimage.cn/p/wx82dd65f284dd6ee3/HEyF1uUGZf1uXwm2u-Rb2bViQ8kl7wxwPr8OMyEx6Q',0,'尺码','S',0,NULL,NULL,NULL,0.00,0.00,99.00,0.00,'',1,0,0,0),(19,2,100,'夏季韩版ins黑灰高腰小个子牛仔半身裙女百搭显瘦包臀a字短裙子潮','10000226806665','深蓝 M','A00142',0,'颜色','深蓝','https://mmecimage.cn/p/wx82dd65f284dd6ee3/HEyF1uUGZf1uXwm2u-Rb2bViQ8kl7wxwPr8OMyEx6Q',0,'尺码','M',0,NULL,NULL,NULL,0.00,0.00,99.00,0.00,'',1,0,0,0),(20,2,100,'夏季韩版ins黑灰高腰小个子牛仔半身裙女百搭显瘦包臀a字短裙子潮','10000226806665','深蓝 L','A00143',0,'颜色','深蓝','https://mmecimage.cn/p/wx82dd65f284dd6ee3/HEyF1uUGZf1uXwm2u-Rb2bViQ8kl7wxwPr8OMyEx6Q',0,'尺码','L',0,NULL,NULL,NULL,0.00,0.00,99.00,0.00,'',1,0,0,0),(21,2,100,'夏季韩版ins黑灰高腰小个子牛仔半身裙女百搭显瘦包臀a字短裙子潮','10000226806665','深蓝 XL','A00144',0,'颜色','深蓝','https://mmecimage.cn/p/wx82dd65f284dd6ee3/HEyF1uUGZf1uXwm2u-Rb2bViQ8kl7wxwPr8OMyEx6Q',0,'尺码','XL',0,NULL,NULL,NULL,0.00,0.00,99.00,0.00,'',1,0,0,0);
/*!40000 ALTER TABLE `erp_goods_sku` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `erp_goods_sku_attr`
--

DROP TABLE IF EXISTS `erp_goods_sku_attr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `erp_goods_sku_attr` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `goods_id` bigint NOT NULL,
  `type` char(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `k` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `kid` bigint DEFAULT NULL,
  `vid` bigint DEFAULT NULL,
  `v` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `img` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `erp_goods_sku_attr`
--

LOCK TABLES `erp_goods_sku_attr` WRITE;
/*!40000 ALTER TABLE `erp_goods_sku_attr` DISABLE KEYS */;
/*!40000 ALTER TABLE `erp_goods_sku_attr` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `erp_logistics_company`
--

DROP TABLE IF EXISTS `erp_logistics_company`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `erp_logistics_company` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `platform_id` bigint DEFAULT NULL COMMENT '平台id',
  `shop_id` bigint DEFAULT NULL COMMENT '店铺ID',
  `tenant_id` bigint DEFAULT NULL COMMENT '租户id',
  `logistics_id` bigint DEFAULT NULL COMMENT '物流公司id（值来自于平台返回）',
  `code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '物流公司编码（值来自于平台返回）',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '物流公司名称（值来自于平台返回）',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  `status` int DEFAULT NULL COMMENT '状态（1启用0禁用）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `erp_logistics_company`
--

LOCK TABLES `erp_logistics_company` WRITE;
/*!40000 ALTER TABLE `erp_logistics_company` DISABLE KEYS */;
INSERT INTO `erp_logistics_company` VALUES (1,NULL,NULL,100,NULL,'SF','顺丰',NULL,1),(2,NULL,NULL,105,NULL,'0001','申通',NULL,1);
/*!40000 ALTER TABLE `erp_logistics_company` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `erp_order`
--

DROP TABLE IF EXISTS `erp_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `erp_order` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '订单id，自增',
  `tenant_id` bigint NOT NULL COMMENT '租户id',
  `order_num` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '订单编号（第三方平台订单号）',
  `shop_type` int NOT NULL COMMENT '店铺类型',
  `shop_id` bigint NOT NULL COMMENT '店铺ID',
  `remark` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '订单备注',
  `buyer_memo` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '买家留言信息',
  `seller_memo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '卖家留言信息',
  `tag` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '标签',
  `refund_status` int NOT NULL COMMENT '售后状态 1：无售后或售后关闭，2：售后处理中，3：退款中，4： 退款成功 ',
  `order_status` int NOT NULL COMMENT '订单状态1：待发货，2：已发货，3：已完成',
  `goods_amount` double DEFAULT NULL COMMENT '订单商品金额',
  `amount` double NOT NULL COMMENT '订单实际金额',
  `receiver_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '收件人姓名',
  `receiver_mobile` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '收件人手机号',
  `address` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '收件人地址',
  `province` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '省',
  `city` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '市',
  `town` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '区',
  `order_time` datetime DEFAULT NULL COMMENT '订单时间',
  `ship_status` int NOT NULL DEFAULT '0' COMMENT '发货状态 0 待发货 1 部分发货 2全部发货',
  `has_push_erp` int DEFAULT '0' COMMENT '是否推送到ERP',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `create_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '创建人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `update_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '更新人',
  `ship_type` int NOT NULL DEFAULT '0' COMMENT '发货方式 0 自己发货1联合发货2供应商发货',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `order_sn_index` (`order_num`) USING BTREE,
  KEY `shopid_index` (`shop_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='订单表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `erp_order`
--

LOCK TABLES `erp_order` WRITE;
/*!40000 ALTER TABLE `erp_order` DISABLE KEYS */;
INSERT INTO `erp_order` VALUES (1,100,'3727945891454531072',5,6,NULL,NULL,NULL,NULL,11,11,44.5,44.5,'齐**','158****0119','****','广东省','深圳市','宝安区','2025-05-07 13:19:57',0,0,'2025-05-07 13:37:29','手动确认','2025-05-07 16:34:31',NULL,0),(2,100,'2009300499001',5,6,NULL,NULL,NULL,NULL,1,2,89,89,'启航','15818590119','','广东省','深圳市','宝安区','2025-05-16 09:00:21',2,0,'2025-05-16 09:00:26','手动确认','2025-05-17 12:32:58','手动填写供应商发货信息',2),(3,100,'1009930999302',5,6,NULL,NULL,NULL,NULL,1,2,99,99,'启航a','15818590111','北京政府大楼 100 号','北京市','市辖区','东城区','2025-05-16 14:55:08',2,0,'2025-05-16 14:55:12','手动确认','2025-05-16 17:53:55','手动发货',0);
/*!40000 ALTER TABLE `erp_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `erp_order_item`
--

DROP TABLE IF EXISTS `erp_order_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `erp_order_item` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id，自增',
  `tenant_id` bigint NOT NULL COMMENT '租户id',
  `shop_id` bigint NOT NULL COMMENT '店铺id',
  `order_id` bigint NOT NULL COMMENT '订单ID（o_order外键）',
  `order_num` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '订单号（第三方平台）',
  `sub_order_num` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '子订单号（第三方平台）',
  `sku_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '第三方平台skuId',
  `erp_goods_id` bigint NOT NULL DEFAULT '0' COMMENT 'erp系统商品id',
  `erp_sku_id` bigint NOT NULL DEFAULT '0' COMMENT 'erp系统商品规格id',
  `goods_title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '商品标题',
  `goods_img` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '商品图片',
  `goods_num` varchar(35) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '商品编码',
  `goods_spec` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '商品规格',
  `sku_num` varchar(35) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '商品规格编码',
  `goods_price` double NOT NULL COMMENT '商品单价',
  `item_amount` double DEFAULT NULL COMMENT '子订单金额',
  `quantity` int NOT NULL COMMENT '商品数量',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  `refund_count` int DEFAULT '0' COMMENT '已退货数量',
  `refund_status` int DEFAULT NULL COMMENT '售后状态 1：无售后或售后关闭，2：售后处理中，3：退款中，4： 退款成功 ',
  `has_push_erp` int DEFAULT '0' COMMENT '是否推送到ERP',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `create_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '创建人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `update_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '更新人',
  `ship_status` int NOT NULL DEFAULT '0' COMMENT '发货状态 0 待发货 1 已发货',
  `ship_type` int NOT NULL DEFAULT '0' COMMENT '发货方式 0 自己发货 2供应商发货',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `goodId_index` (`erp_goods_id`) USING BTREE,
  KEY `order_id` (`order_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='订单明细表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `erp_order_item`
--

LOCK TABLES `erp_order_item` WRITE;
/*!40000 ALTER TABLE `erp_order_item` DISABLE KEYS */;
INSERT INTO `erp_order_item` VALUES (1,100,6,1,'3727945891454531072','1912512446954844164','3387757956',0,0,'牛仔短裤女a字裤紧身夏高腰显瘦ins辣妹风外穿包臀直筒弹力热裤子','https://wst.wxapp.tc.qq.com/161/20304/snscosdownload/SZ/reserved/681ae501000026f90b46d9131a2b5515000000a000004f50',NULL,'[{\"attr_key\":\"尺码\",\"attr_value\":\"S\"}]','A20701',89,44.5,1,NULL,0,1,0,NULL,NULL,NULL,NULL,0,0),(2,100,6,2,'2009300499001','1912512446954844165','3387753301',1,5,'牛仔短裤女a字裤紧身夏高腰显瘦ins辣妹风外穿包臀直筒弹力热裤子','https://mmecimage.cn/p/wx82dd65f284dd6ee3/HBkkngG4j2Utl9HiMhfCsrBNvSN2MJFnzJR9oJH8PQ',NULL,'2XL','A20705',89,89,1,NULL,0,1,0,NULL,NULL,'2025-05-17 12:32:42','手动填写供应商发货信息',1,2),(3,100,6,3,'1009930999302','1912512446954844166','3386353837',2,7,'夏季韩版ins黑灰高腰小个子牛仔半身裙女百搭显瘦包臀a字短裙子潮','https://mmecimage.cn/p/wx82dd65f284dd6ee3/HBviRG_AELkO2KG1mE7Yy6nq6h9mhp51zPAKIU34tQ',NULL,'黑色 M','A00112',99,99,1,NULL,0,1,0,NULL,NULL,NULL,NULL,0,0);
/*!40000 ALTER TABLE `erp_order_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `erp_purchase_order`
--

DROP TABLE IF EXISTS `erp_purchase_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `erp_purchase_order` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `tenant_id` bigint NOT NULL COMMENT '租户id',
  `supplier_id` bigint NOT NULL COMMENT '供应商id',
  `order_no` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '订单编号',
  `order_date` date NOT NULL COMMENT '订单日期',
  `order_time` bigint NOT NULL COMMENT '订单创建时间',
  `order_amount` decimal(10,2) NOT NULL COMMENT '订单总金额',
  `ship_amount` decimal(6,2) NOT NULL COMMENT '物流费用',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '订单状态 0待审核1已审核101供应商已确认102供应商已发货2已收货3已入库',
  `audit_user` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '采购单审核人',
  `audit_time` bigint DEFAULT '0' COMMENT '审核时间',
  `supplier_confirm_time` datetime DEFAULT NULL COMMENT '供应商确认时间',
  `supplier_delivery_time` datetime DEFAULT NULL COMMENT '供应商发货时间',
  `received_time` datetime DEFAULT NULL COMMENT '收货时间',
  `stock_in_time` datetime DEFAULT NULL COMMENT '入库时间',
  `create_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=478 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='采购订单';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `erp_purchase_order`
--

LOCK TABLES `erp_purchase_order` WRITE;
/*!40000 ALTER TABLE `erp_purchase_order` DISABLE KEYS */;
INSERT INTO `erp_purchase_order` VALUES (466,0,33,'PUR20240116144408','2024-01-16',1705387448,190.00,0.00,NULL,3,'启航',1705387461,'2024-01-16 14:44:30','2024-01-16 14:49:49','2024-01-16 00:00:00','2024-01-16 14:50:58','admin','2024-01-16 14:44:09','admin','2024-01-16 14:50:58'),(1067,0,33,'PUR20240128113656','2024-01-28',1706413016,42.00,10.00,NULL,102,'启航',1706413030,'2024-01-28 11:42:19','2024-01-28 12:07:32',NULL,NULL,'admin','2024-01-28 11:36:56','admin','2024-01-28 12:07:32'),(477,100,1,'PUR20240421205746','2024-04-21',1713704266,1050.00,20.00,NULL,2,'启航',1713705287,'2024-04-21 21:19:07','2024-04-21 21:19:59','2024-04-21 08:00:00',NULL,'15818590119','2024-04-21 20:57:46','15818590119','2024-04-21 21:40:14');
/*!40000 ALTER TABLE `erp_purchase_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `erp_purchase_order_item`
--

DROP TABLE IF EXISTS `erp_purchase_order_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `erp_purchase_order_item` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `tenant_id` bigint DEFAULT NULL COMMENT '租户id',
  `supplier_id` bigint DEFAULT NULL COMMENT '供应商id',
  `order_id` bigint DEFAULT '0' COMMENT '订单id',
  `order_no` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '订单编号',
  `trans_type` char(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '150501采购 150502退货',
  `amount` double DEFAULT '0' COMMENT '购货金额',
  `order_date` date DEFAULT NULL COMMENT '订单日期',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '备注',
  `goods_id` bigint DEFAULT '0' COMMENT '商品ID',
  `goods_num` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '商品编码',
  `goods_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '商品名称',
  `spec_id` bigint DEFAULT '0' COMMENT '商品规格id',
  `spec_num` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '商品规格编码',
  `color_value` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '颜色',
  `color_image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '图片',
  `size_value` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '尺码',
  `style_value` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '款式',
  `price` decimal(8,2) DEFAULT '0.00' COMMENT '单价',
  `dis_amount` decimal(8,2) DEFAULT '0.00' COMMENT '折扣额',
  `dis_rate` decimal(8,2) DEFAULT '0.00' COMMENT '折扣率',
  `quantity` bigint NOT NULL DEFAULT '0' COMMENT '数量(采购单据)',
  `inQty` bigint NOT NULL DEFAULT '0' COMMENT '已入库数量',
  `locationId` int DEFAULT NULL COMMENT '入库的仓库id',
  `is_delete` tinyint(1) DEFAULT '0' COMMENT '1删除 0正常',
  `status` int DEFAULT '0' COMMENT '状态（同billStatus）0待审核1正常2已作废3已入库',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `type` (`trans_type`) USING BTREE,
  KEY `billdate` (`order_date`) USING BTREE,
  KEY `invId` (`goods_id`) USING BTREE,
  KEY `transType` (`trans_type`) USING BTREE,
  KEY `iid` (`order_id`) USING BTREE,
  KEY `id` (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1963 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='采购订单明细';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `erp_purchase_order_item`
--

LOCK TABLES `erp_purchase_order_item` WRITE;
/*!40000 ALTER TABLE `erp_purchase_order_item` DISABLE KEYS */;
INSERT INTO `erp_purchase_order_item` VALUES (1962,NULL,NULL,466,'PUR20240116144408','Purchase',190,'2024-01-16','',9,'HN8026','HN8026牛仔短裤',32,'2720210080260105','黑色','https://cbu01.alicdn.com/img/ibank/O1CN01AfNgvA2FOyAvwXZxv_!!2208857268871-0-cib.jpg','2XL','',19.00,0.00,0.00,10,0,NULL,0,0),(1963,NULL,NULL,467,'PUR20240128113656','Purchase',42,'2024-01-28','',29,'HNP182','HNP182弹力紧身贴标牛仔短裤女ins',438,'HNP1825004','浅蓝色','https://cbu01.alicdn.com/img/ibank/O1CN01yp4pfJ2FOyGRQhOVF_!!2208857268871-0-cib.jpg','XL','',21.00,0.00,0.00,2,0,NULL,0,0),(1362,100,1,477,'PUR20240421205746','Purchase',1050,'2024-04-21','',1781988656060412000,'NZK000232','男士流行夏季牛仔裤黑色',1781988656068800500,'NZK00023200','红色',NULL,'','',105.00,0.00,0.00,10,0,NULL,0,0);
/*!40000 ALTER TABLE `erp_purchase_order_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `erp_purchase_order_payable`
--

DROP TABLE IF EXISTS `erp_purchase_order_payable`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `erp_purchase_order_payable` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `tenant_id` bigint NOT NULL COMMENT '租户id',
  `supplier_id` bigint NOT NULL COMMENT '供应商id',
  `supplier_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '供应商名称',
  `amount` decimal(10,2) NOT NULL COMMENT '应付金额',
  `date` date NOT NULL COMMENT '应付日期',
  `invoice_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '发票号码',
  `purchase_order_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '采购单号',
  `purchase_desc` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '采购说明',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  `status` int NOT NULL COMMENT '状态（0已生成1已结算)',
  `create_time` datetime DEFAULT NULL COMMENT '订单创建时间',
  `create_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '创建人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `update_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='采购单应付款';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `erp_purchase_order_payable`
--

LOCK TABLES `erp_purchase_order_payable` WRITE;
/*!40000 ALTER TABLE `erp_purchase_order_payable` DISABLE KEYS */;
INSERT INTO `erp_purchase_order_payable` VALUES (1,0,33,'中山裤豪',52.00,'2024-01-28',NULL,'PUR20240128113656','{采购商品总数量:2,不同款式:1,不同SKU:1,商品总价:42.00,运费:10}',NULL,1,'2024-01-28 12:07:32','admin',NULL,NULL);
/*!40000 ALTER TABLE `erp_purchase_order_payable` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `erp_purchase_order_ship`
--

DROP TABLE IF EXISTS `erp_purchase_order_ship`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `erp_purchase_order_ship` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '采购单ID（主键）',
  `tenant_id` bigint DEFAULT NULL COMMENT '租户id',
  `supplier_id` bigint DEFAULT NULL COMMENT '供应商id',
  `order_id` bigint DEFAULT NULL COMMENT '订单id',
  `ship_company` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '物流公司',
  `ship_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '物流单号',
  `freight` decimal(6,0) DEFAULT NULL COMMENT '运费',
  `ship_time` datetime DEFAULT NULL COMMENT '发货时间',
  `receipt_time` datetime DEFAULT NULL COMMENT '收货时间',
  `create_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `status` int DEFAULT NULL COMMENT '状态（0未收货1已收货2已入库）',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '说明',
  `back_count` int DEFAULT NULL COMMENT '退回数量',
  `stock_in_time` datetime DEFAULT NULL COMMENT '入库时间',
  `stock_in_count` int DEFAULT NULL COMMENT '入库数量',
  `update_by` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `order_date` date DEFAULT NULL COMMENT '采购订单日期',
  `order_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '采购订单编号',
  `order_spec_unit` int DEFAULT NULL COMMENT '采购订单商品规格数',
  `order_goods_unit` int DEFAULT NULL COMMENT '采购订单商品数',
  `order_spec_unit_total` int DEFAULT NULL COMMENT '采购订单总件数',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=469 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='采购订单物流表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `erp_purchase_order_ship`
--

LOCK TABLES `erp_purchase_order_ship` WRITE;
/*!40000 ALTER TABLE `erp_purchase_order_ship` DISABLE KEYS */;
INSERT INTO `erp_purchase_order_ship` VALUES (466,NULL,NULL,NULL,'菜鸟速递','CN223533300022',0,'2024-01-16 00:00:00','2024-01-16 00:00:00','admin','2024-01-16 14:49:49',2,NULL,0,'2024-01-16 14:50:58',0,'admin','2024-01-16 14:50:58','2024-01-16','PUR20240116144408',1,1,10),(467,NULL,NULL,NULL,'菜鸟速递','CN345565767',10,'2024-01-28 00:00:00',NULL,'admin','2024-01-28 12:07:32',0,NULL,0,NULL,0,NULL,NULL,'2024-01-28','PUR20240128113656',1,1,2),(468,100,1,477,'顺丰','SF522000',20,'2024-04-21 08:00:00','2024-04-21 08:00:00','15818590119','2024-04-21 21:19:59',2,NULL,0,'2024-04-21 22:21:58',0,'15818590119','2024-04-21 22:21:58','2024-04-21','PUR20240421205746',1,1,10);
/*!40000 ALTER TABLE `erp_purchase_order_ship` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `erp_refund`
--

DROP TABLE IF EXISTS `erp_refund`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `erp_refund` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `refund_num` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '退货单号',
  `refund_type` int DEFAULT NULL COMMENT '类型(10-退货 20-换货 30-维修 40-大家电安装 50-大家电移机 60-大家电增值服务 70-上门维修 90-优鲜赔 80-补发商品 100-试用收回 11-仅退款)',
  `shop_id` int DEFAULT NULL COMMENT '店铺id',
  `shop_type` int DEFAULT NULL COMMENT '店铺类型',
  `refund_fee` float NOT NULL COMMENT '退款金额',
  `refund_reason` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '退款原因',
  `order_num` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '源订单号',
  `order_item_num` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '子订单号或id',
  `sku_id` bigint DEFAULT NULL COMMENT '源skuId',
  `erp_goods_id` bigint DEFAULT NULL COMMENT 'erp商品id',
  `erp_sku_id` bigint DEFAULT NULL COMMENT 'erp sku id',
  `sku_num` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'sku编码',
  `goods_name` varchar(55) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '商品名称',
  `goods_sku` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '商品sku',
  `goods_image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '商品图片',
  `quantity` bigint DEFAULT NULL COMMENT '退货数量',
  `return_logistics_company` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '退货物流公司',
  `return_logistics_code` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '退货物流单号',
  `receive_time` datetime DEFAULT NULL COMMENT '收货时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '备注',
  `contactPerson` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '发货人',
  `mobile` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '发货人手机号',
  `address` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '发货地址',
  `status` int NOT NULL COMMENT '状态（10001待审核10002等待买家退货10005等待卖家收货14000拒绝退款10011退款关闭10010退款完成）',
  `create_time` datetime NOT NULL COMMENT '订单创建时间',
  `create_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '创建人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `update_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='退换货表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `erp_refund`
--

LOCK TABLES `erp_refund` WRITE;
/*!40000 ALTER TABLE `erp_refund` DISABLE KEYS */;
INSERT INTO `erp_refund` VALUES (1,'149005526432678759',11,1,1,0,NULL,'2090155476352675987','2090155476353675987',5222928542211,0,0,'ZH-SF-04-DS-F1-QM23-NT2(R)','曲美家居现代轻奢简约床头柜床边高脚储物柜卧室置物储藏柜','颜色分类:石墨黑-右;安装方式:组装','https://img.alicdn.com/bao/uploaded/i1/351855490/O1CN012NaoeQ1qQTGEg68L3_!!351855490.jpg',1,NULL,NULL,NULL,'','','','',10010,'2024-03-24 12:01:45','REFUND_MESSAGE',NULL,NULL);
/*!40000 ALTER TABLE `erp_refund` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `erp_shipment`
--

DROP TABLE IF EXISTS `erp_shipment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `erp_shipment` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `tenant_id` bigint NOT NULL COMMENT '租户id',
  `shop_id` bigint NOT NULL COMMENT '店铺id',
  `shop_type` int NOT NULL COMMENT '店铺类型',
  `order_id` bigint NOT NULL COMMENT 'o_order表id',
  `order_num` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '订单编号',
  `order_time` datetime DEFAULT NULL COMMENT '订单时间',
  `shipper` int NOT NULL DEFAULT '0' COMMENT '发货方 0 仓库发货 1 供应商发货',
  `supplier_id` bigint NOT NULL DEFAULT '0' COMMENT '供应商ID',
  `supplier` varchar(55) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '供应商',
  `ship_type` int NOT NULL COMMENT '发货类型（1订单发货2商品补发3商品换货）',
  `ship_company` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '物流公司',
  `ship_company_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '物流公司code',
  `ship_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '物流单号',
  `ship_fee` decimal(6,0) NOT NULL DEFAULT '0' COMMENT '物流费用',
  `ship_time` datetime DEFAULT NULL COMMENT '发货时间',
  `ship_operator` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '发货操作人',
  `ship_status` int NOT NULL COMMENT '物流状态（0 待发货1已发货2已完成）',
  `package_weight` float NOT NULL COMMENT '包裹重量',
  `package_length` float NOT NULL COMMENT '包裹长度',
  `package_width` float NOT NULL COMMENT '包裹宽度',
  `package_height` float NOT NULL COMMENT '包裹高度',
  `packsge_operator` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '打包操作人',
  `packsge_time` datetime DEFAULT NULL COMMENT '打包时间',
  `packages` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '包裹内容JSON',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  `create_time` datetime DEFAULT NULL,
  `create_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `update_by` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='发货记录表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `erp_shipment`
--

LOCK TABLES `erp_shipment` WRITE;
/*!40000 ALTER TABLE `erp_shipment` DISABLE KEYS */;
INSERT INTO `erp_shipment` VALUES (1,100,6,5,3,'1009930999302','2025-05-16 14:55:08',0,0,NULL,1,'顺丰','SF','sf1209930009',0,'2025-05-16 17:53:55','a',1,0,0,0,0,'a',NULL,NULL,NULL,'2025-05-16 17:53:55','qihang',NULL,NULL),(2,100,6,5,2,'2009300499001','2025-05-16 09:00:21',1,1,'测试供应商',1,'顺丰','SF','SF12333112',0,'2025-05-17 12:32:23',NULL,1,0,0,0,0,'',NULL,NULL,'','2025-05-16 22:33:03','qihang','2025-05-17 12:32:49','手动填写供应商发货信息');
/*!40000 ALTER TABLE `erp_shipment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `erp_shipment_item`
--

DROP TABLE IF EXISTS `erp_shipment_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `erp_shipment_item` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id，自增',
  `tenant_id` bigint NOT NULL COMMENT '租户id',
  `shipper` int NOT NULL COMMENT '发货方 0 仓库发货 1 供应商发货',
  `supplier_id` bigint NOT NULL DEFAULT '0' COMMENT '供应商ID',
  `supplier` varchar(55) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '供应商',
  `shipment_id` bigint NOT NULL COMMENT '发货id',
  `shop_type` int NOT NULL COMMENT '店铺类型',
  `shop_id` bigint NOT NULL COMMENT '店铺id',
  `order_id` bigint NOT NULL COMMENT '订单 id',
  `order_num` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '订单编号',
  `order_time` datetime DEFAULT NULL COMMENT '订单时间',
  `order_item_id` bigint NOT NULL COMMENT '订单itemID（o_order_item外键）',
  `erp_goods_id` bigint NOT NULL DEFAULT '0' COMMENT 'erp系统商品id',
  `erp_sku_id` bigint NOT NULL DEFAULT '0' COMMENT 'erp系统商品规格id',
  `goods_title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '商品标题',
  `goods_img` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '商品图片',
  `goods_num` varchar(35) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '商品编码',
  `goods_spec` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '商品规格',
  `sku_num` varchar(35) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '商品规格编码',
  `quantity` int NOT NULL COMMENT '商品数量',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  `stock_status` int NOT NULL COMMENT '仓库状态 0 备货中 1 已出库 2 已发走',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `create_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '创建人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `update_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `goodId_index` (`erp_goods_id`) USING BTREE,
  KEY `order_id` (`order_item_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='发货明细表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `erp_shipment_item`
--

LOCK TABLES `erp_shipment_item` WRITE;
/*!40000 ALTER TABLE `erp_shipment_item` DISABLE KEYS */;
INSERT INTO `erp_shipment_item` VALUES (1,100,0,0,NULL,1,5,6,3,'1009930999302','2025-05-16 14:55:08',3,2,7,'夏季韩版ins黑灰高腰小个子牛仔半身裙女百搭显瘦包臀a字短裙子潮','https://mmecimage.cn/p/wx82dd65f284dd6ee3/HBviRG_AELkO2KG1mE7Yy6nq6h9mhp51zPAKIU34tQ',NULL,'黑色 M','A00112',1,NULL,0,'2025-05-16 17:53:55','qihang',NULL,NULL),(2,100,1,1,'测试供应商',2,5,6,2,'2009300499001','2025-05-16 09:00:21',2,1,5,'牛仔短裤女a字裤紧身夏高腰显瘦ins辣妹风外穿包臀直筒弹力热裤子','https://mmecimage.cn/p/wx82dd65f284dd6ee3/HBkkngG4j2Utl9HiMhfCsrBNvSN2MJFnzJR9oJH8PQ',NULL,'2XL','A20705',1,NULL,2,'2025-05-16 22:33:03','qihang','2025-05-17 12:32:40','手动填写供应商发货信息');
/*!40000 ALTER TABLE `erp_shipment_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `erp_shop`
--

DROP TABLE IF EXISTS `erp_shop`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `erp_shop` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `tenant_id` bigint DEFAULT NULL COMMENT '租户id',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '店铺名',
  `type` int NOT NULL COMMENT '对应第三方平台Id',
  `url` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '店铺url',
  `sort` int NOT NULL DEFAULT '9' COMMENT '排序',
  `status` int DEFAULT '0' COMMENT '状态（1正常2已删除）',
  `modify_on` bigint NOT NULL COMMENT '更新时间',
  `remark` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '描述',
  `seller_id` bigint NOT NULL DEFAULT '0' COMMENT '第三方平台店铺id，淘宝天猫开放平台使用',
  `app_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT 'Appkey',
  `app_sercet` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT 'Appsercet',
  `access_token` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '第三方平台sessionKey（access_token）',
  `expires_in` bigint DEFAULT NULL COMMENT '到期',
  `access_token_begin` bigint DEFAULT NULL COMMENT 'access_token开始时间',
  `refresh_token` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '刷新token',
  `refresh_token_timeout` bigint DEFAULT NULL COMMENT '刷新token过期时间',
  `api_request_url` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '请求url',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='数据中心-店铺';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `erp_shop`
--

LOCK TABLES `erp_shop` WRITE;
/*!40000 ALTER TABLE `erp_shop` DISABLE KEYS */;
INSERT INTO `erp_shop` VALUES (6,100,'启航电商的小店',5,NULL,9,0,1746583567,'个人店铺',0,'wx82dd65f284dd6ee3','a6054ccf2694e8dc51d2616e634cad39','92_7jp6yAXxM8jfJ6ZFlpbSvOT5ndyIi9cAkllyPU0cFRHW6kSOeYueFsDLQEspaFBkrMDsnuyeIqrCfEpbehrwbgP_goZgbFY7I_GeRm46Fg9r6iDvIpvq7GLOllMNYJaAAAITE',NULL,NULL,NULL,NULL,'https://api.weixin.qq.com'),(7,105,'微信小店',5,NULL,9,0,1744900783,NULL,0,'77777777','445245',NULL,NULL,NULL,NULL,NULL,NULL),(8,110,'store01',5,NULL,9,0,1745033126,'test',0,'store01id','sc555',NULL,NULL,NULL,NULL,NULL,NULL),(9,110,'22',5,NULL,9,0,1745033150,'222',0,'22','222',NULL,NULL,NULL,NULL,NULL,NULL),(10,115,'a',5,NULL,9,0,1745397127,'a',0,'a','a',NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `erp_shop` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `erp_shop_goods`
--

DROP TABLE IF EXISTS `erp_shop_goods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `erp_shop_goods` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `shop_id` bigint DEFAULT NULL COMMENT '店铺id',
  `tenant_id` bigint DEFAULT NULL COMMENT '租户id',
  `product_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '平台商品id',
  `out_product_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '商家编码id',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '商品标题',
  `sub_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `head_imgs` varchar(2550) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '主图集合',
  `head_img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '第一张主图',
  `desc_info` varchar(5000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '商品详情字符串',
  `attrs` varchar(2550) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '属性字符串',
  `status` int DEFAULT NULL COMMENT '状态',
  `edit_status` int DEFAULT NULL COMMENT '编辑状态',
  `min_price` int DEFAULT NULL COMMENT '商品 SKU 最小价格（单位：分）',
  `spu_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '商品编码',
  `product_type` int DEFAULT NULL COMMENT '商品类型。1: 小店普通自营商品；2: 福袋抽奖商品；3: 直播间闪电购商品。注意: 福袋抽奖、直播间闪电购类型的商品为只读数据，不支持编辑、上架操作，不支持用data_type=2的参数获取。',
  `edit_time` int DEFAULT NULL COMMENT '商品草稿最近一次修改时间',
  `erp_goods_id` bigint NOT NULL DEFAULT '0' COMMENT '商品库商品id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `erp_shop_goods`
--

LOCK TABLES `erp_shop_goods` WRITE;
/*!40000 ALTER TABLE `erp_shop_goods` DISABLE KEYS */;
INSERT INTO `erp_shop_goods` VALUES (1,6,100,'10000226806665','','夏季韩版ins黑灰高腰小个子牛仔半身裙女百搭显瘦包臀a字短裙子潮','','[\"https://mmecimage.cn/p/wx82dd65f284dd6ee3/HC7tyxMJYp0ui4hs75bVPBTLOpMsBKTzU9qH9lUl5Q\",\"https://mmecimage.cn/p/wx82dd65f284dd6ee3/HLSG8lDS5e-iniBAqfLe65XkNJrJ9PepNI-Vwe1HDg\",\"https://mmecimage.cn/p/wx82dd65f284dd6ee3/HEYO93L-Yvp1XhgN4kJipQ2bTuCY7fioB8vqVZHZcg\",\"https://mmecimage.cn/p/wx82dd65f284dd6ee3/HPjWLGJF5gQ_g-G9KMTvMIvwncK1_9XhjQzG-ZOMog\",\"https://mmecimage.cn/p/wx82dd65f284dd6ee3/HDCe9nlQzyWIozKFVuceo5dfy--6wXqvABX7vwlPpw\",\"https://mmecimage.cn/p/wx82dd65f284dd6ee3/HFAEfaFTGS299EbPH7nfGvdLRkEWu6LPSW8H0kogiw\"]','https://mmecimage.cn/p/wx82dd65f284dd6ee3/HC7tyxMJYp0ui4hs75bVPBTLOpMsBKTzU9qH9lUl5Q','{\"imgs\":[\"https://mmecimage.cn/p/wx82dd65f284dd6ee3/HKz3Geo5LgRBiMKuhEDgwQueqwL1roQ8UAATwcXWmg\",\"https://mmecimage.cn/p/wx82dd65f284dd6ee3/HLbV13GzXxE0JCUH07Nw4lPdLfqWXG91_jTgKQWesw\",\"https://mmecimage.cn/p/wx82dd65f284dd6ee3/HDgXv_uxU0l_H7mFMQnuG3zt7cedSofDEWVpcOEjNA\",\"https://mmecimage.cn/p/wx82dd65f284dd6ee3/HGKn464RK93iYYt8Vvr7VSsbodgbfzYXmiJiPjfXbw\",\"https://mmecimage.cn/p/wx82dd65f284dd6ee3/HF0-YsfdMWgPUE1AzMZg268nu8yUJ2CgjGNAd1TNPQ\",\"https://mmecimage.cn/p/wx82dd65f284dd6ee3/HGKbGduUar8JGqygnt8QOZDC5RE5DWA8zMlO7JPL8g\",\"https://mmecimage.cn/p/wx82dd65f284dd6ee3/HP-z9fTJc0SGVurqHsGMylb7G2TbqwiBlgm43VRunQ\",\"https://mmecimage.cn/p/wx82dd65f284dd6ee3/HFtrpgIOCVWsDG2we7QGj60ZOpPLNffW-w8bvX8kIA\",\"https://mmecimage.cn/p/wx82dd65f284dd6ee3/HOxMbc2e4fS5iTdge52kPYiDv4h2LRy_E6YMv0qxww\",\"https://mmecimage.cn/p/wx82dd65f284dd6ee3/HBwvCLpdttkZ0OxSaBlTgebXTpJ8IlAc8Rc85wPnUQ\",\"https://mmecimage.cn/p/wx82dd65f284dd6ee3/HN92eUd4vZg9lzMhcc2BhHqgBF00NZwyClKoiXSsEA\",\"https://mmecimage.cn/p/wx82dd65f284dd6ee3/HF2RXTJxt3lUI8d5mmi3MhmHYgcVy9mkPDElmKU_lw\",\"https://mmecimage.cn/p/wx82dd65f284dd6ee3/HPblH3kXsKC2Nj_vAPfBVdML_4GJXPNKkhbm_cC6bw\",\"https://mmecimage.cn/p/wx82dd65f284dd6ee3/HIlBO82le2x0EUskMgV-iY6bQuzIjDJ6eaAW78rkTA\",\"https://mmecimage.cn/p/wx82dd65f284dd6ee3/HHeduzQuXcv_k-8Zvqyi8p1luNSvRrpLwOV_uBIzWQ\",\"https://mmecimage.cn/p/wx82dd65f284dd6ee3/HJX8i_bYiCMxYfGKG9kdh3Mxq6-XC2s8da0SleSnyg\",\"https://mmecimage.cn/p/wx82dd65f284dd6ee3/HJzpXP6kzmYqUyLNELYPVKKmxeFtON1nmPjc5mlZ5g\"],\"desc\":\"\"}','[{\"attr_key\":\"面料材质\",\"attr_value\":\"聚酯纤维（涤纶）\"}]',5,NULL,9900,'',1,0,2),(2,6,100,'10000227212454','','牛仔短裤女a字裤紧身夏高腰显瘦ins辣妹风外穿包臀直筒弹力热裤子','','[\"https://mmecimage.cn/p/wx82dd65f284dd6ee3/HBkkngG4j2Utl9HiMhfCsrBNvSN2MJFnzJR9oJH8PQ\",\"https://mmecimage.cn/p/wx82dd65f284dd6ee3/HHigSEPtjoyz1dqKoPmZTGse3T6kL5CDMIQ_C6Wtzg\",\"https://mmecimage.cn/p/wx82dd65f284dd6ee3/HIvoI5H9sxwoJJMB8lUgK44UdPXiHYhWwVoQcITAi0E\",\"https://mmecimage.cn/p/wx82dd65f284dd6ee3/HFQneFzkUSPeC5u31OKHhWkOjgz4duZhZpcsGe-Eew0\"]','https://mmecimage.cn/p/wx82dd65f284dd6ee3/HBkkngG4j2Utl9HiMhfCsrBNvSN2MJFnzJR9oJH8PQ','{\"imgs\":[\"https://mmecimage.cn/p/wx82dd65f284dd6ee3/HITwxBQVQwnGwxiOqP3KqPwycbD2CUZeSypH6DmoMQ\",\"https://mmecimage.cn/p/wx82dd65f284dd6ee3/HJesY68fe9LErU9n9YXfLsvX1QoYhvQm9hs63YIek8U\",\"https://mmecimage.cn/p/wx82dd65f284dd6ee3/HPDGEUtxgMrb2yRCWhTutKLTmH2nf8OkwPBq5C8Yvw\",\"https://mmecimage.cn/p/wx82dd65f284dd6ee3/HJgzSAqt7Z7doY5ENdGAkRTeduCDQ3Fy34l_2KCJvw\",\"https://mmecimage.cn/p/wx82dd65f284dd6ee3/HB99itoZbJc6PdhSYweD2IWQ-kMqi4uD5bsYuKNlxA\",\"https://mmecimage.cn/p/wx82dd65f284dd6ee3/HMUUVdfsP6E4cyzQoMiQ7VtsHR9smh32bnZL9H9GoQ\",\"https://mmecimage.cn/p/wx82dd65f284dd6ee3/HAZMYUfLuASSuayVBrbKV-mU99JIRXQc5mVjD88WlQ\",\"https://mmecimage.cn/p/wx82dd65f284dd6ee3/HFVjKQnJ_KOSBnEw31d4mPxLXcazBE_vGsiwQ9vHjg\",\"https://mmecimage.cn/p/wx82dd65f284dd6ee3/HEjH9P2eKWMAZloOz0oGKTWr_NoH0OgzqvssM8CTXQ\",\"https://mmecimage.cn/p/wx82dd65f284dd6ee3/HLhq8Fi3U8DpTgilWVCJ4DGRa1i9B_EgVvU_gFGJqg\"],\"desc\":\"\"}','[{\"attr_key\":\"面料材质成分含量（%）\",\"attr_value\":\"50 %\"},{\"attr_key\":\"面料材质\",\"attr_value\":\"醋酯纤维\"}]',5,NULL,8900,'',1,0,1);
/*!40000 ALTER TABLE `erp_shop_goods` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `erp_shop_goods_sku`
--

DROP TABLE IF EXISTS `erp_shop_goods_sku`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `erp_shop_goods_sku` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `shop_goods_id` bigint NOT NULL COMMENT '外键id',
  `tenant_id` bigint DEFAULT NULL COMMENT '租户id',
  `shop_id` bigint NOT NULL COMMENT '店铺id',
  `product_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '平台商品id',
  `sku_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'skuID',
  `out_sku_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '商家自定义skuID。如果添加时没录入，回包可能不包含该字段',
  `thumb_img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'sku小图',
  `sale_price` int DEFAULT NULL COMMENT '售卖价格，以分为单位',
  `stock_num` int DEFAULT NULL COMMENT 'sku库存',
  `sku_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'sku编码',
  `status` int DEFAULT NULL COMMENT 'sku状态',
  `sku_attrs` varchar(2550) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'sku_attrs',
  `sku_deliver_info` varchar(2550) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'sku_deliver_info',
  `erp_goods_id` bigint NOT NULL DEFAULT '0' COMMENT 'erp系统商品id',
  `erp_goods_sku_id` bigint NOT NULL DEFAULT '0' COMMENT 'erp系统商品skuid',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `erp_shop_goods_sku`
--

LOCK TABLES `erp_shop_goods_sku` WRITE;
/*!40000 ALTER TABLE `erp_shop_goods_sku` DISABLE KEYS */;
INSERT INTO `erp_shop_goods_sku` VALUES (1,2,100,6,'10000227212454','3387757956','','https://mmecimage.cn/p/wx82dd65f284dd6ee3/HBkkngG4j2Utl9HiMhfCsrBNvSN2MJFnzJR9oJH8PQ',8900,10,'A20701',5,'[{\"attr_key\":\"尺码\",\"attr_value\":\"S\"}]','{\"stock_type\":0,\"full_payment_presale_delivery_type\":0,\"presale_begin_time\":0,\"presale_end_time\":0,\"full_payment_presale_delivery_time\":0}',1,1),(2,2,100,6,'10000227212454','3387796494','','https://mmecimage.cn/p/wx82dd65f284dd6ee3/HBkkngG4j2Utl9HiMhfCsrBNvSN2MJFnzJR9oJH8PQ',8900,10,'A20702',5,'[{\"attr_key\":\"尺码\",\"attr_value\":\"M\"}]','{\"stock_type\":0,\"full_payment_presale_delivery_type\":0,\"presale_begin_time\":0,\"presale_end_time\":0,\"full_payment_presale_delivery_time\":0}',1,2),(3,2,100,6,'10000227212454','3387719364','','https://mmecimage.cn/p/wx82dd65f284dd6ee3/HBkkngG4j2Utl9HiMhfCsrBNvSN2MJFnzJR9oJH8PQ',8900,10,'A20703',5,'[{\"attr_key\":\"尺码\",\"attr_value\":\"L\"}]','{\"stock_type\":0,\"full_payment_presale_delivery_type\":0,\"presale_begin_time\":0,\"presale_end_time\":0,\"full_payment_presale_delivery_time\":0}',1,3),(4,2,100,6,'10000227212454','3387885524','','https://mmecimage.cn/p/wx82dd65f284dd6ee3/HBkkngG4j2Utl9HiMhfCsrBNvSN2MJFnzJR9oJH8PQ',8900,10,'A20704',5,'[{\"attr_key\":\"尺码\",\"attr_value\":\"XL\"}]','{\"stock_type\":0,\"full_payment_presale_delivery_type\":0,\"presale_begin_time\":0,\"presale_end_time\":0,\"full_payment_presale_delivery_time\":0}',1,4),(5,2,100,6,'10000227212454','3387753301','','https://mmecimage.cn/p/wx82dd65f284dd6ee3/HBkkngG4j2Utl9HiMhfCsrBNvSN2MJFnzJR9oJH8PQ',8900,10,'A20705',5,'[{\"attr_key\":\"尺码\",\"attr_value\":\"2XL\"}]','{\"stock_type\":0,\"full_payment_presale_delivery_type\":0,\"presale_begin_time\":0,\"presale_end_time\":0,\"full_payment_presale_delivery_time\":0}',1,5),(6,1,100,6,'10000226806665','3386273694','','https://mmecimage.cn/p/wx82dd65f284dd6ee3/HBviRG_AELkO2KG1mE7Yy6nq6h9mhp51zPAKIU34tQ',9900,9,'A00111',5,'[{\"attr_key\":\"颜色\",\"attr_value\":\"黑色\"},{\"attr_key\":\"尺码\",\"attr_value\":\"S\"}]','{\"stock_type\":0,\"full_payment_presale_delivery_type\":0,\"presale_begin_time\":0,\"presale_end_time\":0,\"full_payment_presale_delivery_time\":0}',2,6),(7,1,100,6,'10000226806665','3386353837','','https://mmecimage.cn/p/wx82dd65f284dd6ee3/HBviRG_AELkO2KG1mE7Yy6nq6h9mhp51zPAKIU34tQ',9900,9,'A00112',5,'[{\"attr_key\":\"颜色\",\"attr_value\":\"黑色\"},{\"attr_key\":\"尺码\",\"attr_value\":\"M\"}]','{\"stock_type\":0,\"full_payment_presale_delivery_type\":0,\"presale_begin_time\":0,\"presale_end_time\":0,\"full_payment_presale_delivery_time\":0}',2,7),(8,1,100,6,'10000226806665','3386254387','','https://mmecimage.cn/p/wx82dd65f284dd6ee3/HBviRG_AELkO2KG1mE7Yy6nq6h9mhp51zPAKIU34tQ',9900,9,'A00113',5,'[{\"attr_key\":\"颜色\",\"attr_value\":\"黑色\"},{\"attr_key\":\"尺码\",\"attr_value\":\"L\"}]','{\"stock_type\":0,\"full_payment_presale_delivery_type\":0,\"presale_begin_time\":0,\"presale_end_time\":0,\"full_payment_presale_delivery_time\":0}',2,8),(9,1,100,6,'10000226806665','3386346869','','https://mmecimage.cn/p/wx82dd65f284dd6ee3/HBviRG_AELkO2KG1mE7Yy6nq6h9mhp51zPAKIU34tQ',9900,9,'A00114',5,'[{\"attr_key\":\"颜色\",\"attr_value\":\"黑色\"},{\"attr_key\":\"尺码\",\"attr_value\":\"XL\"}]','{\"stock_type\":0,\"full_payment_presale_delivery_type\":0,\"presale_begin_time\":0,\"presale_end_time\":0,\"full_payment_presale_delivery_time\":0}',2,9),(10,1,100,6,'10000226806665','3386289149','','https://mmecimage.cn/p/wx82dd65f284dd6ee3/HEHGX3o_N2LjMf2Een41P9r3AR2d0eTtyi9F9CDLpA',9900,9,'A00121',5,'[{\"attr_key\":\"颜色\",\"attr_value\":\"黑灰\"},{\"attr_key\":\"尺码\",\"attr_value\":\"S\"}]','{\"stock_type\":0,\"full_payment_presale_delivery_type\":0,\"presale_begin_time\":0,\"presale_end_time\":0,\"full_payment_presale_delivery_time\":0}',2,10),(11,1,100,6,'10000226806665','3386355827','','https://mmecimage.cn/p/wx82dd65f284dd6ee3/HEHGX3o_N2LjMf2Een41P9r3AR2d0eTtyi9F9CDLpA',9900,9,'A00122',5,'[{\"attr_key\":\"颜色\",\"attr_value\":\"黑灰\"},{\"attr_key\":\"尺码\",\"attr_value\":\"M\"}]','{\"stock_type\":0,\"full_payment_presale_delivery_type\":0,\"presale_begin_time\":0,\"presale_end_time\":0,\"full_payment_presale_delivery_time\":0}',2,11),(12,1,100,6,'10000226806665','3386307232','','https://mmecimage.cn/p/wx82dd65f284dd6ee3/HEHGX3o_N2LjMf2Een41P9r3AR2d0eTtyi9F9CDLpA',9900,9,'A00123',5,'[{\"attr_key\":\"颜色\",\"attr_value\":\"黑灰\"},{\"attr_key\":\"尺码\",\"attr_value\":\"L\"}]','{\"stock_type\":0,\"full_payment_presale_delivery_type\":0,\"presale_begin_time\":0,\"presale_end_time\":0,\"full_payment_presale_delivery_time\":0}',2,12),(13,1,100,6,'10000226806665','3386283916','','https://mmecimage.cn/p/wx82dd65f284dd6ee3/HEHGX3o_N2LjMf2Een41P9r3AR2d0eTtyi9F9CDLpA',9900,9,'A00124',5,'[{\"attr_key\":\"颜色\",\"attr_value\":\"黑灰\"},{\"attr_key\":\"尺码\",\"attr_value\":\"XL\"}]','{\"stock_type\":0,\"full_payment_presale_delivery_type\":0,\"presale_begin_time\":0,\"presale_end_time\":0,\"full_payment_presale_delivery_time\":0}',2,13),(14,1,100,6,'10000226806665','3386440065','','https://mmecimage.cn/p/wx82dd65f284dd6ee3/HIYiX-phXBu7QyEA3kYEXvMR67rApf_led1cIzWXfQ',9900,9,'A00131',5,'[{\"attr_key\":\"颜色\",\"attr_value\":\"浅蓝\"},{\"attr_key\":\"尺码\",\"attr_value\":\"S\"}]','{\"stock_type\":0,\"full_payment_presale_delivery_type\":0,\"presale_begin_time\":0,\"presale_end_time\":0,\"full_payment_presale_delivery_time\":0}',2,14),(15,1,100,6,'10000226806665','3386484403','','https://mmecimage.cn/p/wx82dd65f284dd6ee3/HIYiX-phXBu7QyEA3kYEXvMR67rApf_led1cIzWXfQ',9900,9,'A00132',5,'[{\"attr_key\":\"颜色\",\"attr_value\":\"浅蓝\"},{\"attr_key\":\"尺码\",\"attr_value\":\"M\"}]','{\"stock_type\":0,\"full_payment_presale_delivery_type\":0,\"presale_begin_time\":0,\"presale_end_time\":0,\"full_payment_presale_delivery_time\":0}',2,15),(16,1,100,6,'10000226806665','3386302555','','https://mmecimage.cn/p/wx82dd65f284dd6ee3/HIYiX-phXBu7QyEA3kYEXvMR67rApf_led1cIzWXfQ',9900,9,'A00133',5,'[{\"attr_key\":\"颜色\",\"attr_value\":\"浅蓝\"},{\"attr_key\":\"尺码\",\"attr_value\":\"L\"}]','{\"stock_type\":0,\"full_payment_presale_delivery_type\":0,\"presale_begin_time\":0,\"presale_end_time\":0,\"full_payment_presale_delivery_time\":0}',2,16),(17,1,100,6,'10000226806665','3386484402','','https://mmecimage.cn/p/wx82dd65f284dd6ee3/HIYiX-phXBu7QyEA3kYEXvMR67rApf_led1cIzWXfQ',9900,9,'A00134',5,'[{\"attr_key\":\"颜色\",\"attr_value\":\"浅蓝\"},{\"attr_key\":\"尺码\",\"attr_value\":\"XL\"}]','{\"stock_type\":0,\"full_payment_presale_delivery_type\":0,\"presale_begin_time\":0,\"presale_end_time\":0,\"full_payment_presale_delivery_time\":0}',2,17),(18,1,100,6,'10000226806665','3386365666','','https://mmecimage.cn/p/wx82dd65f284dd6ee3/HEyF1uUGZf1uXwm2u-Rb2bViQ8kl7wxwPr8OMyEx6Q',9900,9,'A00141',5,'[{\"attr_key\":\"颜色\",\"attr_value\":\"深蓝\"},{\"attr_key\":\"尺码\",\"attr_value\":\"S\"}]','{\"stock_type\":0,\"full_payment_presale_delivery_type\":0,\"presale_begin_time\":0,\"presale_end_time\":0,\"full_payment_presale_delivery_time\":0}',2,18),(19,1,100,6,'10000226806665','3386365667','','https://mmecimage.cn/p/wx82dd65f284dd6ee3/HEyF1uUGZf1uXwm2u-Rb2bViQ8kl7wxwPr8OMyEx6Q',9900,9,'A00142',5,'[{\"attr_key\":\"颜色\",\"attr_value\":\"深蓝\"},{\"attr_key\":\"尺码\",\"attr_value\":\"M\"}]','{\"stock_type\":0,\"full_payment_presale_delivery_type\":0,\"presale_begin_time\":0,\"presale_end_time\":0,\"full_payment_presale_delivery_time\":0}',2,19),(20,1,100,6,'10000226806665','3386437870','','https://mmecimage.cn/p/wx82dd65f284dd6ee3/HEyF1uUGZf1uXwm2u-Rb2bViQ8kl7wxwPr8OMyEx6Q',9900,9,'A00143',5,'[{\"attr_key\":\"颜色\",\"attr_value\":\"深蓝\"},{\"attr_key\":\"尺码\",\"attr_value\":\"L\"}]','{\"stock_type\":0,\"full_payment_presale_delivery_type\":0,\"presale_begin_time\":0,\"presale_end_time\":0,\"full_payment_presale_delivery_time\":0}',2,20),(21,1,100,6,'10000226806665','3386302556','','https://mmecimage.cn/p/wx82dd65f284dd6ee3/HEyF1uUGZf1uXwm2u-Rb2bViQ8kl7wxwPr8OMyEx6Q',9900,9,'A00144',5,'[{\"attr_key\":\"颜色\",\"attr_value\":\"深蓝\"},{\"attr_key\":\"尺码\",\"attr_value\":\"XL\"}]','{\"stock_type\":0,\"full_payment_presale_delivery_type\":0,\"presale_begin_time\":0,\"presale_end_time\":0,\"full_payment_presale_delivery_time\":0}',2,21);
/*!40000 ALTER TABLE `erp_shop_goods_sku` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `erp_shop_order`
--

DROP TABLE IF EXISTS `erp_shop_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `erp_shop_order` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `tenant_id` bigint NOT NULL COMMENT '租户id',
  `shop_id` bigint NOT NULL COMMENT '店铺id',
  `order_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '订单号',
  `openid` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '买家身份标识',
  `create_time` int DEFAULT NULL COMMENT '秒级时间戳',
  `update_time` int DEFAULT NULL COMMENT '秒级时间戳',
  `unionid` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `status` int DEFAULT NULL COMMENT '状态10	待付款；20	待发货；21	部分发货；30	待收货；100	完成；200	全部商品售后之后，订单取消；250	未付款用户主动取消或超时未付款订单自动取消；',
  `aftersale_detail` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '售后信息json',
  `pay_info` varchar(5500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '支付信息json',
  `product_price` int DEFAULT NULL COMMENT '商品总价，单位为分',
  `order_price` int DEFAULT NULL COMMENT '订单金额，单位为分，order_price=original_order_price-discounted_price-deduction_price-change_down_price',
  `freight` int DEFAULT NULL COMMENT '运费，单位为分',
  `discounted_price` int DEFAULT NULL COMMENT '优惠券优惠金额，单位为分',
  `user_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '收货人姓名',
  `postal_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '邮编',
  `province_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '省份',
  `city_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '城市',
  `county_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '区',
  `detail_info` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '详细地址',
  `tel_number` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '联系方式\r\n',
  `house_number` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '门牌号码',
  `virtual_order_tel_number` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '虚拟发货订单联系方式(deliver_method=1时返回)',
  `tel_number_ext_info` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '额外的联系方式信息（虚拟号码相关）',
  `use_tel_number` int DEFAULT NULL COMMENT '0：不使用虚拟号码，1：使用虚拟号码',
  `hash_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '标识当前店铺下一个唯一的用户收货地址',
  `delivery_product_info` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '发货物流信息JSON',
  `ship_done_time` int DEFAULT NULL COMMENT '发货完成时间，秒级时间戳',
  `ewaybill_order_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '电子面单代发时的订单密文\r\n',
  `settle_info` varchar(2550) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '结算信息json',
  `confirm_status` int DEFAULT '0' COMMENT '订单确认状态（0未确认1已确认）',
  `confirm_time` datetime DEFAULT NULL COMMENT '确认时间',
  `erp_send_status` int DEFAULT NULL COMMENT 'erp发货状态',
  `erp_send_time` datetime DEFAULT NULL COMMENT 'ERP发货时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `erp_shop_order`
--

LOCK TABLES `erp_shop_order` WRITE;
/*!40000 ALTER TABLE `erp_shop_order` DISABLE KEYS */;
INSERT INTO `erp_shop_order` VALUES (1,100,6,'3727945891454531072','oVlvg5LH7hSceF9MjGy5GgwLS8sE',1746595197,1746596098,NULL,250,'{\"aftersale_order_list\":[],\"on_aftersale_order_cnt\":0}','{\"prepay_id\":\"up_wx0713195870621235742aedee321e940000\",\"prepay_time\":1746595198}',4450,4450,0,NULL,'齐**','518101','广东省','深圳市','宝安区','****','158****0119','','','null',0,'d6a28f4a7ccba1863c22668754ce8b83','[]',0,'of-K9cW4L9xzEr--u7o_WMWVFqdcMgY4l7ttrFNkqs0dmBI22X9mEmsHGUvIlrz9bFCWwyD3pAfg','{\"predict_commission_fee\":0}',1,'2025-05-07 13:37:29',NULL,NULL),(2,100,6,'2009300499001',NULL,1747357221,0,NULL,20,NULL,NULL,8900,8900,0,0,'启航',NULL,'广东省','深圳市','宝安区','','15818590119',NULL,NULL,NULL,0,NULL,NULL,0,NULL,NULL,1,'2025-05-16 09:00:26',0,NULL),(3,100,6,'1009930999302',NULL,1747378508,0,NULL,20,NULL,NULL,9900,9900,0,0,'启航a',NULL,'北京市','市辖区','东城区','北京政府大楼 100 号','15818590111',NULL,NULL,NULL,0,NULL,NULL,0,NULL,NULL,1,'2025-05-16 14:55:12',0,NULL);
/*!40000 ALTER TABLE `erp_shop_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `erp_shop_order_item`
--

DROP TABLE IF EXISTS `erp_shop_order_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `erp_shop_order_item` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `tenant_id` bigint NOT NULL COMMENT '租户id',
  `shop_id` bigint DEFAULT NULL COMMENT '店铺id',
  `shop_order_id` bigint DEFAULT NULL COMMENT '外键id',
  `product_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '商品spuid',
  `sku_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '商品skuid\r\n',
  `thumb_img` varchar(550) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'sku小图',
  `sku_cnt` int DEFAULT NULL COMMENT 'sku数量',
  `sale_price` int DEFAULT NULL COMMENT '售卖单价（单位：分）',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '商品标题',
  `on_aftersale_sku_cnt` int DEFAULT NULL COMMENT '正在售后/退款流程中的 sku 数量',
  `finish_aftersale_sku_cnt` int DEFAULT NULL COMMENT '完成售后/退款的 sku 数量',
  `sku_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '商品编码',
  `market_price` int DEFAULT NULL COMMENT '市场单价（单位：分）',
  `sku_attrs` varchar(2550) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'sku属性JSON',
  `real_price` int DEFAULT NULL COMMENT 'sku实付总价，取estimate_price和change_price中较小值',
  `out_product_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '商品外部spuid',
  `out_sku_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '商品外部skuid',
  `is_discounted` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '是否有优惠金额，非必填，默认为false',
  `estimate_price` int DEFAULT NULL COMMENT '优惠后sku总价，非必填，is_discounted为true时有值',
  `is_change_price` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '是否修改过价格，非必填，默认为false',
  `change_price` int DEFAULT NULL COMMENT '改价后sku总价，非必填，is_change_price为true时有值',
  `out_warehouse_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '区域库存id',
  `sku_deliver_info` varchar(2550) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '商品发货信息JSON',
  `extra_service` varchar(2550) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '商品额外服务信息JSON',
  `use_deduction` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '是否使用了会员积分抵扣\r\n',
  `deduction_price` int DEFAULT NULL COMMENT '会员积分抵扣金额，单位为分',
  `order_product_coupon_info_list` varchar(2550) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '商品优惠券信息，逐步替换 order.order_detail.coupon_info',
  `erp_goods_id` bigint NOT NULL DEFAULT '0' COMMENT 'erp系统商品id',
  `erp_sku_id` bigint NOT NULL DEFAULT '0' COMMENT 'erp系统商品规格id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `erp_shop_order_item`
--

LOCK TABLES `erp_shop_order_item` WRITE;
/*!40000 ALTER TABLE `erp_shop_order_item` DISABLE KEYS */;
INSERT INTO `erp_shop_order_item` VALUES (2,100,6,1,'10000227212454','3387757956','https://wst.wxapp.tc.qq.com/161/20304/snscosdownload/SZ/reserved/681ae501000026f90b46d9131a2b5515000000a000004f50',1,4450,'牛仔短裤女a字裤紧身夏高腰显瘦ins辣妹风外穿包臀直筒弹力热裤子',0,0,'A20701',8900,'[{\"attr_key\":\"尺码\",\"attr_value\":\"S\"}]',4450,NULL,NULL,'null',4450,'null',NULL,'','{\"stock_type\":0}','{\"seven_day_return\":1,\"freight_insurance\":0}','null',NULL,'[]',0,0),(3,100,6,2,'10000227212454','3387753301','https://mmecimage.cn/p/wx82dd65f284dd6ee3/HBkkngG4j2Utl9HiMhfCsrBNvSN2MJFnzJR9oJH8PQ',1,8900,'牛仔短裤女a字裤紧身夏高腰显瘦ins辣妹风外穿包臀直筒弹力热裤子',0,0,'A20705',8900,'2XL',8900,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,5),(4,100,6,3,'10000226806665','3386353837','https://mmecimage.cn/p/wx82dd65f284dd6ee3/HBviRG_AELkO2KG1mE7Yy6nq6h9mhp51zPAKIU34tQ',1,9900,'夏季韩版ins黑灰高腰小个子牛仔半身裙女百搭显瘦包臀a字短裙子潮',0,0,'A00112',9900,'黑色 M',9900,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,2,7);
/*!40000 ALTER TABLE `erp_shop_order_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `erp_shop_platform`
--

DROP TABLE IF EXISTS `erp_shop_platform`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `erp_shop_platform` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '平台名',
  `code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '平台编码',
  `app_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `app_secret` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `redirect_uri` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '平台回调uri',
  `server_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '接口访问地址',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `erp_shop_platform`
--

LOCK TABLES `erp_shop_platform` WRITE;
/*!40000 ALTER TABLE `erp_shop_platform` DISABLE KEYS */;
INSERT INTO `erp_shop_platform` VALUES (5,'视频号小店','WEI','',NULL,NULL,'https://api.weixin.qq.com');
/*!40000 ALTER TABLE `erp_shop_platform` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `erp_shop_pull_lasttime`
--

DROP TABLE IF EXISTS `erp_shop_pull_lasttime`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `erp_shop_pull_lasttime` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `shop_id` bigint DEFAULT NULL COMMENT '店铺id',
  `tenant_id` bigint NOT NULL COMMENT '租户id',
  `pull_type` enum('ORDER','REFUND') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '类型（ORDER:订单，REFUND:退款）',
  `lasttime` datetime DEFAULT NULL COMMENT '最后更新时间',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='店铺更新最后时间记录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `erp_shop_pull_lasttime`
--

LOCK TABLES `erp_shop_pull_lasttime` WRITE;
/*!40000 ALTER TABLE `erp_shop_pull_lasttime` DISABLE KEYS */;
INSERT INTO `erp_shop_pull_lasttime` VALUES (1,1,100,'ORDER','2024-04-06 12:59:30','2024-03-23 15:56:13','2024-04-11 16:42:42'),(2,1,100,'REFUND','2024-03-28 09:03:50','2024-03-24 13:03:54','2024-04-06 15:35:16'),(3,2,100,'ORDER','2024-04-01 00:33:33','2024-03-10 13:00:07','2024-04-01 20:35:54'),(4,2,100,'REFUND','2024-03-24 13:48:33','2024-03-24 13:50:24',NULL),(5,6,100,'ORDER','2025-05-07 13:55:43','2025-04-16 22:24:35','2025-05-07 13:55:44'),(6,6,100,'REFUND','2025-05-06 13:37:01','2025-04-17 13:37:02',NULL),(7,6,1,'ORDER','2025-05-07 18:44:50','2025-05-07 16:33:06','2025-05-07 18:44:51'),(8,6,1,'REFUND','2025-05-07 10:47:26','2025-05-07 18:47:26',NULL);
/*!40000 ALTER TABLE `erp_shop_pull_lasttime` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `erp_shop_pull_logs`
--

DROP TABLE IF EXISTS `erp_shop_pull_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `erp_shop_pull_logs` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键Id',
  `shop_id` bigint NOT NULL COMMENT '店铺id',
  `tenant_id` bigint NOT NULL COMMENT '租户id',
  `shop_type` int NOT NULL COMMENT '平台id',
  `pull_type` enum('ORDER','REFUND','GOODS') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '类型（ORDER订单，GOODS商品，REFUND退款）',
  `pull_way` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '拉取方式（主动拉取、定时任务）',
  `pull_params` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '拉取参数',
  `pull_result` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '拉取结果',
  `pull_time` datetime DEFAULT NULL COMMENT '拉取时间',
  `duration` bigint DEFAULT NULL COMMENT '耗时（毫秒）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='更新日志表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `erp_shop_pull_logs`
--

LOCK TABLES `erp_shop_pull_logs` WRITE;
/*!40000 ALTER TABLE `erp_shop_pull_logs` DISABLE KEYS */;
INSERT INTO `erp_shop_pull_logs` VALUES (1,6,1,5,'ORDER','主动拉取','{startTime:2025-05-07T15:33:11,endTime:2025-05-07T18:44:50.345775861}','{insert:0,update:0,fail:0}','2025-05-07 18:44:50',631),(2,6,1,5,'REFUND','主动拉取','{startTime:2025-05-06T10:47:25.707072297,endTime:2025-05-07T10:47:25.707072297}','{insert:0,update:0,fail:0}','2025-05-07 18:47:25',596);
/*!40000 ALTER TABLE `erp_shop_pull_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `erp_shop_refund`
--

DROP TABLE IF EXISTS `erp_shop_refund`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `erp_shop_refund` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `tenant_id` bigint NOT NULL COMMENT '租户id',
  `shop_id` bigint NOT NULL COMMENT '店铺id',
  `after_sale_order_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '售后单号',
  `status` varchar(55) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '售后单当前状态，参考：AfterSaleStatus',
  `openid` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '买家身份标识',
  `unionid` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '买家在开放平台的唯一标识符，若当前视频号小店已绑定到微信开放平台账号下会返回',
  `product_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '商品spuid',
  `sku_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '商品skuid',
  `count` int DEFAULT NULL COMMENT '售后数量',
  `fast_refund` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '是否极速退款RefundInfo',
  `refund_reason` int DEFAULT NULL COMMENT '标明售后单退款直接原因, 枚举值参考 RefundReason',
  `refund_amount` int DEFAULT NULL COMMENT '退款金额（分）',
  `return_waybill_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '快递单号',
  `return_delivery_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '物流公司id',
  `return_delivery_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '物流公司名称',
  `merchant_upload_info` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '售后相关商品信息JSON',
  `create_time` int DEFAULT NULL COMMENT '售后单创建时间戳',
  `update_time` int DEFAULT NULL COMMENT '售后单更新时间戳',
  `reason` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '退款原因',
  `reason_text` varchar(2550) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '退款原因解释',
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '售后类型。REFUND:退款；RETURN:退货退款。',
  `order_id` varchar(55) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '订单号，该字段可用于获取订单',
  `details` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT 'detail json',
  `complaint_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '纠纷id，该字段可用于获取纠纷信息',
  `refund_resp` varchar(2550) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '微信支付退款的响应',
  `confirm_status` int DEFAULT NULL COMMENT '确认状态9退货已签收8已拦截',
  `confirm_time` datetime DEFAULT NULL COMMENT '确认时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='视频号小店退款';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `erp_shop_refund`
--

LOCK TABLES `erp_shop_refund` WRITE;
/*!40000 ALTER TABLE `erp_shop_refund` DISABLE KEYS */;
/*!40000 ALTER TABLE `erp_shop_refund` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `erp_supplier`
--

DROP TABLE IF EXISTS `erp_supplier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `erp_supplier` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `tenant_id` bigint NOT NULL COMMENT '租户id',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '供应商名称',
  `number` varchar(18) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '供应商编码',
  `tax_rate` double DEFAULT '0' COMMENT '税率',
  `amount` double DEFAULT '0' COMMENT '期初应付款',
  `period_money` double DEFAULT '0' COMMENT '期初预付款',
  `dif_money` double DEFAULT '0' COMMENT '初期往来余额',
  `begin_date` date DEFAULT NULL COMMENT '余额日期',
  `remark` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '备注',
  `place` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '职位',
  `contact_man` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '联系人',
  `contact` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '联系方式',
  `province` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '省',
  `city` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '市',
  `county` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '区县',
  `address` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '收货地址详情',
  `pinYin` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '',
  `disable` tinyint(1) DEFAULT '0' COMMENT '1启用   0禁用',
  `is_delete` tinyint(1) DEFAULT '0' COMMENT '0正常 1删除',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `create_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `update_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `id` (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `erp_supplier`
--

LOCK TABLES `erp_supplier` WRITE;
/*!40000 ALTER TABLE `erp_supplier` DISABLE KEYS */;
INSERT INTO `erp_supplier` VALUES (1,100,'测试供应商','AD23',0,0,0,0,NULL,'','','启航','154855545',NULL,NULL,NULL,NULL,'',1,0,'2024-04-21 16:19:23','手动添加','2025-05-07 17:32:31','手动更新');
/*!40000 ALTER TABLE `erp_supplier` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `erp_supplier_agent_shipping`
--

DROP TABLE IF EXISTS `erp_supplier_agent_shipping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `erp_supplier_agent_shipping` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `shop_id` int NOT NULL COMMENT '店铺ID',
  `shop_type` int NOT NULL COMMENT '店铺平台',
  `supplier_id` int NOT NULL COMMENT '供应商ID',
  `erp_order_id` bigint NOT NULL COMMENT 'erp订单ID',
  `erp_order_item_id` bigint NOT NULL COMMENT '子订单ID',
  `order_num` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '订单编号',
  `order_date` datetime NOT NULL COMMENT '订单日期',
  `goods_id` bigint NOT NULL DEFAULT '0' COMMENT 'erp系统商品id',
  `spec_id` bigint NOT NULL DEFAULT '0' COMMENT 'erp系统商品规格id',
  `goods_title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '商品标题',
  `goods_img` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '商品图片',
  `goods_num` varchar(35) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '商品编码',
  `goods_spec` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '商品规格',
  `spec_num` varchar(35) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '商品规格编码',
  `goods_price` double NOT NULL COMMENT '商品单价',
  `quantity` int NOT NULL COMMENT '商品数量',
  `item_amount` double DEFAULT NULL COMMENT '子订单金额',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '说明',
  `ship_company` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '物流公司',
  `ship_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '物流单号',
  `ship_cost` decimal(6,0) DEFAULT NULL COMMENT '运费',
  `ship_time` datetime DEFAULT NULL COMMENT '运送时间',
  `status` int DEFAULT NULL COMMENT '状态（0未发货1已发货2已结算）',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `create_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '创建人',
  `update_by` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `tenant_id` bigint NOT NULL COMMENT '租户id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='供应商代发货表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `erp_supplier_agent_shipping`
--

LOCK TABLES `erp_supplier_agent_shipping` WRITE;
/*!40000 ALTER TABLE `erp_supplier_agent_shipping` DISABLE KEYS */;
INSERT INTO `erp_supplier_agent_shipping` VALUES (1,6,4,26,17,14,'1635222253871665598','2022-08-05 18:48:51',9,40,'8026牛仔短裤','https://cbu01.alicdn.com/img/ibank/O1CN01PHFmsX2FOyB14fPie_!!2208857268871-0-cib.jpg','272021008026','浅蓝色,L','2720210080260303',16,1,29.92,NULL,'菜鸟速递','CN52500021',2,'2024-01-28 00:00:00',1,'2024-01-28 19:55:37','admin','admin','2024-01-28 21:06:44',0);
/*!40000 ALTER TABLE `erp_supplier_agent_shipping` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fms_payable_agent_ship`
--

DROP TABLE IF EXISTS `fms_payable_agent_ship`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fms_payable_agent_ship` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `order_num` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '订单号',
  `shop_id` int NOT NULL COMMENT '店铺id',
  `supplier_id` int NOT NULL COMMENT '供应商id',
  `supplier_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '供应商名称',
  `date` date NOT NULL COMMENT '日期',
  `ship_company` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '物流公司',
  `ship_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '物流单号',
  `amount` decimal(10,2) NOT NULL COMMENT '应付总金额',
  `ship_amount` decimal(5,2) NOT NULL COMMENT '物流费用',
  `goods_amount` decimal(10,2) NOT NULL COMMENT '商品金额',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  `status` int NOT NULL COMMENT '状态（0已生成1已结算)',
  `create_time` datetime DEFAULT NULL COMMENT '订单创建时间',
  `create_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '创建人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `update_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '更新人',
  `tenant_id` bigint NOT NULL COMMENT '租户id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='财务管理-应付款-代发账单';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fms_payable_agent_ship`
--

LOCK TABLES `fms_payable_agent_ship` WRITE;
/*!40000 ALTER TABLE `fms_payable_agent_ship` DISABLE KEYS */;
INSERT INTO `fms_payable_agent_ship` VALUES (2,'1635222253871665598',6,26,'韩牛服饰','2024-01-28','菜鸟速递','CN52500021',17.00,2.00,15.00,NULL,0,'2024-01-28 21:06:44','admin',NULL,NULL,0);
/*!40000 ALTER TABLE `fms_payable_agent_ship` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fms_payable_ship_fee`
--

DROP TABLE IF EXISTS `fms_payable_ship_fee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fms_payable_ship_fee` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `logistics_company` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '物流公司',
  `logistics_company_id` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '物流公司id',
  `logistics_num` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '物流单号',
  `order_num` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '订单号',
  `shop_id` int DEFAULT NULL COMMENT '店铺id',
  `amount` decimal(10,2) NOT NULL COMMENT '应付金额',
  `date` date NOT NULL COMMENT '应付日期',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  `status` int NOT NULL COMMENT '状态（0已生成1已结算)',
  `create_time` datetime DEFAULT NULL COMMENT '订单创建时间',
  `create_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '创建人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `update_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '更新人',
  `length` float DEFAULT '0' COMMENT '长',
  `width` float DEFAULT '0' COMMENT '宽',
  `height` float DEFAULT '0' COMMENT '高',
  `weight` float DEFAULT NULL COMMENT '重量',
  `receiver_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '收件人姓名',
  `receiver_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '收件人手机号',
  `province` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '省',
  `city` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '市',
  `town` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '区',
  `tenant_id` bigint NOT NULL COMMENT '租户id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='财务管理-应付款-物流费用';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fms_payable_ship_fee`
--

LOCK TABLES `fms_payable_ship_fee` WRITE;
/*!40000 ALTER TABLE `fms_payable_ship_fee` DISABLE KEYS */;
INSERT INTO `fms_payable_ship_fee` VALUES (1,'33','中山裤豪','','PUR20240128113656',NULL,52.00,'2024-01-28',NULL,0,'2024-01-28 12:07:32','admin',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,0);
/*!40000 ALTER TABLE `fms_payable_ship_fee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scm_purchase_contract`
--

DROP TABLE IF EXISTS `scm_purchase_contract`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `scm_purchase_contract` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `contact_id` bigint DEFAULT NULL COMMENT '供应商id',
  `bill_no` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '单据编号',
  `contractNo` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `billDate` date DEFAULT NULL COMMENT '单据日期',
  `userId` smallint DEFAULT '0' COMMENT '制单人id',
  `userName` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '制单人',
  `transType` char(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '交易类型:BUY购货 BUYR退货 SALE销售 SALER退销 OTHER其他入库',
  `transTypeName` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '交易类型名称',
  `totalAmount` decimal(10,2) DEFAULT NULL COMMENT '购货总金额',
  `disRate` double DEFAULT '0' COMMENT '整单折扣率',
  `disAmount` double DEFAULT '0' COMMENT '整单折扣金额',
  `amount` double DEFAULT '0' COMMENT '折扣后金额',
  `totalDiscount` double DEFAULT '0' COMMENT '总折扣（计算商品折扣和整单折扣之和）',
  `totalQuantity` bigint DEFAULT '0' COMMENT '总数量',
  `qualifiedQuantity` bigint DEFAULT '0' COMMENT '合格数量',
  `inQuantity` bigint DEFAULT '0' COMMENT '已入库数量(已出库数量)',
  `rpAmount` double DEFAULT '0' COMMENT '本次付款',
  `arrears` double DEFAULT '0' COMMENT '本次欠款',
  `freight` double DEFAULT '0' COMMENT '运费',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  `billType` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'PO采购订单 OI其他入库 PUR采购入库 BAL初期余额',
  `billStatus` tinyint(1) DEFAULT '0' COMMENT '订单状态 0待审核1正常2已作废3已入库 11已验货',
  `isDelete` tinyint(1) DEFAULT '0' COMMENT '1删除  0正常',
  `checkName` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '采购单审核人',
  `checked` tinyint(1) DEFAULT '0' COMMENT '采购单审核状态0待审核1已审核',
  `createTime` bigint DEFAULT NULL COMMENT '创建时间',
  `modifyTime` bigint DEFAULT NULL COMMENT '更新时间',
  `salesId` smallint DEFAULT NULL,
  `customerFree` double DEFAULT '0' COMMENT '客户承担费用',
  `hxStateCode` tinyint DEFAULT '0' COMMENT '核销状态 0未付款  1部分付款  2全部付款',
  `hxAmount` double DEFAULT '0' COMMENT '本次核销金额',
  `payment` double DEFAULT '0' COMMENT '本次预收款',
  `srcOrderNo` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '订单编号',
  `srcOrderId` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '订单id',
  `logisticsNo` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '快递物流单号（）',
  `logisticsCompany` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '物流公司',
  `logisticsCompanyCode` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '物流公司代码',
  `logisticsNumber` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '物流单号',
  `locationId` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '仓库id多个,分割',
  `inLocationId` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '调入仓库ID多个,分割',
  `outLocationId` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '调出仓库ID多个,分割',
  `serialno` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '序列号',
  `checkoutName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '检验人',
  `checkoutTime` bigint DEFAULT '0' COMMENT '检验时间',
  `checkoutStatus` int DEFAULT '0' COMMENT '0 未检验  1已检验',
  `qualifiedStatus` int DEFAULT '0' COMMENT '0为合格数量为0,1为合格数量不为0',
  `stockInName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '入库人',
  `stockInTime` bigint DEFAULT '0' COMMENT '入库时间',
  `tenant_id` bigint NOT NULL COMMENT '租户id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='采购单';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scm_purchase_contract`
--

LOCK TABLES `scm_purchase_contract` WRITE;
/*!40000 ALTER TABLE `scm_purchase_contract` DISABLE KEYS */;
/*!40000 ALTER TABLE `scm_purchase_contract` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_config`
--

DROP TABLE IF EXISTS `sys_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_config` (
  `config_id` int NOT NULL AUTO_INCREMENT COMMENT '参数主键',
  `config_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '参数名称',
  `config_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '参数键名',
  `config_value` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '参数键值',
  `config_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT 'N' COMMENT '系统内置（Y是 N否）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`config_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='参数配置表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_config`
--

LOCK TABLES `sys_config` WRITE;
/*!40000 ALTER TABLE `sys_config` DISABLE KEYS */;
INSERT INTO `sys_config` VALUES (1,'微信公众号关注回复消息','mp.subscribe.msg','感谢关注启航电商ERP公众号，希望启航电商ERP系统能给您的业务带来帮助！自行开发可以使用开源版本作为底座，获得教程及文档请回复：教程。如果需要商业版支持请回复：商业版本！需要交流加群请回复：交流加群。需要演示环境请回复：在线演示。','Y','admin','2023-08-07 19:31:38','',NULL,'蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow'),(2,'商业版本','mp.msg','感谢信任，商业版本请联系老齐，手机号：15818590119','Y','admin','2023-08-07 19:31:38','',NULL,'是否开启验证码功能（true开启，false关闭）'),(3,'教程','mp.msg','官方文档地址qihangerp.cn','Y','admin','2023-08-07 19:31:38','',NULL,'是否开启验证码功能（true开启，false关闭）'),(4,'交流加群','mp.msg','交流QQ群：60235114（交流群是为了聚集开发者交流，加群请star项目，否则不通过，谢谢-开发者不可能没有gitee账号吧）','Y','admin','2023-08-07 19:31:38','',NULL,'是否开启验证码功能（true开启，false关闭）'),(5,'购买','mp.msg','感谢信任，购买商业版请联系老齐，手机号：15818590119','Y','admin','2023-08-07 19:31:38','',NULL,'是否开启验证码功能（true开启，false关闭）'),(6,'部署','mp.msg','感谢信任，付费部署，收费2000，有需要请联系老齐，手机号：15818590119','Y','admin','2023-08-07 19:31:38','',NULL,'是否开启验证码功能（true开启，false关闭）'),(7,'在线演示','mp.msg','演示环境是基于saas模式的，用户之间数据相互隔离，目前仅支持微信小店平台，演示环境非商业版，请勿商业使用。访问http://erp.qihangerp.cn自行注册即可，目前还处于完善优化阶段，还有很多BUG，欢迎在此提BUG，一般24小时内修复。','Y','admin','2023-08-07 19:31:38','',NULL,'是否开启验证码功能（true开启，false关闭）');
/*!40000 ALTER TABLE `sys_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_dept`
--

DROP TABLE IF EXISTS `sys_dept`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_dept` (
  `dept_id` bigint NOT NULL AUTO_INCREMENT COMMENT '部门id',
  `parent_id` bigint DEFAULT '0' COMMENT '父部门id',
  `ancestors` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '祖级列表',
  `dept_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '部门名称',
  `order_num` int DEFAULT '0' COMMENT '显示顺序',
  `leader` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '负责人',
  `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '联系电话',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '邮箱',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '部门状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`dept_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=200 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='部门表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_dept`
--

LOCK TABLES `sys_dept` WRITE;
/*!40000 ALTER TABLE `sys_dept` DISABLE KEYS */;
INSERT INTO `sys_dept` VALUES (100,0,'0','至简科技',0,'至简','15888888888','ry@qq.com','0','0','admin','2023-08-07 19:31:37','',NULL),(101,100,'0,100','深圳总公司',1,'至简','15888888888','ry@qq.com','0','0','admin','2023-08-07 19:31:37','',NULL),(102,100,'0,100','长沙分公司',2,'至简','15888888888','ry@qq.com','0','0','admin','2023-08-07 19:31:37','',NULL),(103,101,'0,100,101','研发部门',1,'至简','15888888888','ry@qq.com','0','0','admin','2023-08-07 19:31:37','',NULL),(104,101,'0,100,101','市场部门',2,'至简','15888888888','ry@qq.com','0','0','admin','2023-08-07 19:31:37','',NULL),(105,101,'0,100,101','测试部门',3,'至简','15888888888','ry@qq.com','0','0','admin','2023-08-07 19:31:37','',NULL),(106,101,'0,100,101','财务部门',4,'至简','15888888888','ry@qq.com','0','0','admin','2023-08-07 19:31:37','',NULL),(107,101,'0,100,101','运维部门',5,'至简','15888888888','ry@qq.com','0','0','admin','2023-08-07 19:31:37','',NULL),(108,102,'0,100,102','市场部门',1,'至简','15888888888','ry@qq.com','0','0','admin','2023-08-07 19:31:37','',NULL),(109,102,'0,100,102','财务部门',2,'至简','15888888888','ry@qq.com','0','0','admin','2023-08-07 19:31:37','',NULL);
/*!40000 ALTER TABLE `sys_dept` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_dict_data`
--

DROP TABLE IF EXISTS `sys_dict_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_dict_data` (
  `dict_code` bigint NOT NULL AUTO_INCREMENT COMMENT '字典编码',
  `dict_sort` int DEFAULT '0' COMMENT '字典排序',
  `dict_label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '字典标签',
  `dict_value` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '字典键值',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '字典类型',
  `css_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
  `list_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '表格回显样式',
  `is_default` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT 'N' COMMENT '是否默认（Y是 N否）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_code`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='字典数据表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_dict_data`
--

LOCK TABLES `sys_dict_data` WRITE;
/*!40000 ALTER TABLE `sys_dict_data` DISABLE KEYS */;
INSERT INTO `sys_dict_data` VALUES (1,1,'男','0','sys_user_sex','','','Y','0','admin','2023-08-07 19:31:38','',NULL,'性别男'),(2,2,'女','1','sys_user_sex','','','N','0','admin','2023-08-07 19:31:38','',NULL,'性别女'),(3,3,'未知','2','sys_user_sex','','','N','0','admin','2023-08-07 19:31:38','',NULL,'性别未知'),(4,1,'显示','0','sys_show_hide','','primary','Y','0','admin','2023-08-07 19:31:38','',NULL,'显示菜单'),(5,2,'隐藏','1','sys_show_hide','','danger','N','0','admin','2023-08-07 19:31:38','',NULL,'隐藏菜单'),(6,1,'正常','0','sys_normal_disable','','primary','Y','0','admin','2023-08-07 19:31:38','',NULL,'正常状态'),(7,2,'停用','1','sys_normal_disable','','danger','N','0','admin','2023-08-07 19:31:38','',NULL,'停用状态'),(8,1,'正常','0','sys_job_status','','primary','Y','0','admin','2023-08-07 19:31:38','',NULL,'正常状态'),(9,2,'暂停','1','sys_job_status','','danger','N','0','admin','2023-08-07 19:31:38','',NULL,'停用状态'),(10,1,'默认','DEFAULT','sys_job_group','','','Y','0','admin','2023-08-07 19:31:38','',NULL,'默认分组'),(11,2,'系统','SYSTEM','sys_job_group','','','N','0','admin','2023-08-07 19:31:38','',NULL,'系统分组'),(12,1,'是','Y','sys_yes_no','','primary','Y','0','admin','2023-08-07 19:31:38','',NULL,'系统默认是'),(13,2,'否','N','sys_yes_no','','danger','N','0','admin','2023-08-07 19:31:38','',NULL,'系统默认否'),(14,1,'通知','1','sys_notice_type','','warning','Y','0','admin','2023-08-07 19:31:38','',NULL,'通知'),(15,2,'公告','2','sys_notice_type','','success','N','0','admin','2023-08-07 19:31:38','',NULL,'公告'),(16,1,'正常','0','sys_notice_status','','primary','Y','0','admin','2023-08-07 19:31:38','',NULL,'正常状态'),(17,2,'关闭','1','sys_notice_status','','danger','N','0','admin','2023-08-07 19:31:38','',NULL,'关闭状态'),(18,99,'其他','0','sys_oper_type','','info','N','0','admin','2023-08-07 19:31:38','',NULL,'其他操作'),(19,1,'新增','1','sys_oper_type','','info','N','0','admin','2023-08-07 19:31:38','',NULL,'新增操作'),(20,2,'修改','2','sys_oper_type','','info','N','0','admin','2023-08-07 19:31:38','',NULL,'修改操作'),(21,3,'删除','3','sys_oper_type','','danger','N','0','admin','2023-08-07 19:31:38','',NULL,'删除操作'),(22,4,'授权','4','sys_oper_type','','primary','N','0','admin','2023-08-07 19:31:38','',NULL,'授权操作'),(23,5,'导出','5','sys_oper_type','','warning','N','0','admin','2023-08-07 19:31:38','',NULL,'导出操作'),(24,6,'导入','6','sys_oper_type','','warning','N','0','admin','2023-08-07 19:31:38','',NULL,'导入操作'),(25,7,'强退','7','sys_oper_type','','danger','N','0','admin','2023-08-07 19:31:38','',NULL,'强退操作'),(26,8,'生成代码','8','sys_oper_type','','warning','N','0','admin','2023-08-07 19:31:38','',NULL,'生成操作'),(27,9,'清空数据','9','sys_oper_type','','danger','N','0','admin','2023-08-07 19:31:38','',NULL,'清空操作'),(28,1,'成功','0','sys_common_status','','primary','N','0','admin','2023-08-07 19:31:38','',NULL,'正常状态'),(29,2,'失败','1','sys_common_status','','danger','N','0','admin','2023-08-07 19:31:38','',NULL,'停用状态');
/*!40000 ALTER TABLE `sys_dict_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_dict_type`
--

DROP TABLE IF EXISTS `sys_dict_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_dict_type` (
  `dict_id` bigint NOT NULL AUTO_INCREMENT COMMENT '字典主键',
  `dict_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '字典名称',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '字典类型',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_id`) USING BTREE,
  UNIQUE KEY `dict_type` (`dict_type`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='字典类型表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_dict_type`
--

LOCK TABLES `sys_dict_type` WRITE;
/*!40000 ALTER TABLE `sys_dict_type` DISABLE KEYS */;
INSERT INTO `sys_dict_type` VALUES (1,'用户性别','sys_user_sex','0','admin','2023-08-07 19:31:38','',NULL,'用户性别列表'),(2,'菜单状态','sys_show_hide','0','admin','2023-08-07 19:31:38','',NULL,'菜单状态列表'),(3,'系统开关','sys_normal_disable','0','admin','2023-08-07 19:31:38','',NULL,'系统开关列表'),(4,'任务状态','sys_job_status','0','admin','2023-08-07 19:31:38','',NULL,'任务状态列表'),(5,'任务分组','sys_job_group','0','admin','2023-08-07 19:31:38','',NULL,'任务分组列表'),(6,'系统是否','sys_yes_no','0','admin','2023-08-07 19:31:38','',NULL,'系统是否列表'),(7,'通知类型','sys_notice_type','0','admin','2023-08-07 19:31:38','',NULL,'通知类型列表'),(8,'通知状态','sys_notice_status','0','admin','2023-08-07 19:31:38','',NULL,'通知状态列表'),(9,'操作类型','sys_oper_type','0','admin','2023-08-07 19:31:38','',NULL,'操作类型列表'),(10,'系统状态','sys_common_status','0','admin','2023-08-07 19:31:38','',NULL,'登录状态列表');
/*!40000 ALTER TABLE `sys_dict_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_license`
--

DROP TABLE IF EXISTS `sys_license`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_license` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `uuid` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'uuid',
  `time` bigint DEFAULT NULL COMMENT '时间戳',
  `startup_count` int DEFAULT '1' COMMENT '启动次数',
  `status` int DEFAULT '0' COMMENT '是否授权1已授权0未授权',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_license`
--

LOCK TABLES `sys_license` WRITE;
/*!40000 ALTER TABLE `sys_license` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_license` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_logininfor`
--

DROP TABLE IF EXISTS `sys_logininfor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_logininfor` (
  `info_id` bigint NOT NULL AUTO_INCREMENT COMMENT '访问ID',
  `user_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '用户账号',
  `ipaddr` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '登录IP地址',
  `login_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '登录地点',
  `browser` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '浏览器类型',
  `os` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '操作系统',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '登录状态（0成功 1失败）',
  `msg` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '提示消息',
  `login_time` datetime DEFAULT NULL COMMENT '访问时间',
  PRIMARY KEY (`info_id`) USING BTREE,
  KEY `idx_sys_logininfor_s` (`status`) USING BTREE,
  KEY `idx_sys_logininfor_lt` (`login_time`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='系统访问记录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_logininfor`
--

LOCK TABLES `sys_logininfor` WRITE;
/*!40000 ALTER TABLE `sys_logininfor` DISABLE KEYS */;
INSERT INTO `sys_logininfor` VALUES (1,'admin','127.0.0.1','内网IP','Chrome 11','Windows 10','0','登录成功','2024-01-13 19:29:08'),(2,'admin','127.0.0.1','内网IP','Chrome 11','Windows 10','0','登录成功','2024-01-13 20:22:02'),(3,'admin','127.0.0.1','内网IP','Chrome 11','Windows 10','0','登录成功','2024-01-13 22:30:52'),(4,'admin','127.0.0.1','内网IP','Chrome 11','Windows 10','0','登录成功','2024-01-14 00:01:24'),(5,'admin','127.0.0.1','内网IP','Chrome 11','Windows 10','0','登录成功','2024-01-14 10:00:50'),(6,'admin','127.0.0.1','内网IP','Chrome 11','Windows 10','0','登录成功','2024-01-14 11:05:33'),(7,'admin','127.0.0.1','内网IP','Chrome 11','Windows 10','0','登录成功','2024-01-14 11:57:27'),(8,'admin','127.0.0.1','内网IP','Chrome 11','Windows 10','0','登录成功','2024-01-14 12:57:19'),(9,'admin','127.0.0.1','内网IP','Chrome 11','Windows 10','0','登录成功','2024-01-14 14:52:13'),(10,'admin','127.0.0.1','内网IP','Chrome 11','Windows 10','0','登录成功','2024-01-14 16:15:12'),(11,'admin','127.0.0.1','内网IP','Chrome 11','Windows 10','0','登录成功','2024-01-14 18:51:18'),(12,'admin','127.0.0.1','内网IP','Chrome 11','Windows 10','0','登录成功','2024-01-15 11:38:23'),(13,'admin','127.0.0.1','内网IP','Chrome 11','Windows 10','0','登录成功','2024-01-15 14:35:52'),(14,'admin','127.0.0.1','内网IP','Chrome 11','Windows 10','0','登录成功','2024-01-15 18:32:32'),(15,'admin','127.0.0.1','内网IP','Chrome 11','Windows 10','0','登录成功','2024-01-15 19:02:57'),(16,'admin','127.0.0.1','内网IP','Chrome 11','Windows 10','0','登录成功','2024-01-15 19:45:03'),(17,'admin','127.0.0.1','内网IP','Chrome 11','Windows 10','0','登录成功','2024-01-15 20:38:14'),(18,'admin','127.0.0.1','内网IP','Chrome 11','Windows 10','0','登录成功','2024-01-15 21:13:41'),(19,'admin','127.0.0.1','内网IP','Chrome 11','Windows 10','0','登录成功','2024-01-16 09:11:56'),(20,'admin','127.0.0.1','内网IP','Chrome 11','Windows 10','0','登录成功','2024-01-16 13:42:46'),(21,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','0','登录成功','2024-01-18 17:26:16'),(22,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','0','登录成功','2024-01-18 18:56:13'),(23,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','Unable to connect to Redis; nested exception is org.springframework.data.redis.connection.PoolException: Could not get a resource from the pool; nested exception is io.lettuce.core.RedisConnectionException: Unable to connect to 127.0.0.1/<unresolved>:6379','2024-01-19 14:23:14'),(24,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','0','登录成功','2024-01-19 14:23:48'),(25,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','0','登录成功','2024-01-19 14:35:47'),(26,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','0','登录成功','2024-01-27 20:22:04'),(27,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','0','登录成功','2024-01-27 21:01:21'),(28,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','0','登录成功','2024-01-28 11:03:32'),(29,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','0','登录成功','2024-01-28 12:38:55'),(30,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','0','登录成功','2024-01-28 13:09:27'),(31,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','0','登录成功','2024-01-28 14:33:07'),(32,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','0','登录成功','2024-01-28 19:19:58'),(33,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','0','登录成功','2024-02-17 10:09:48'),(34,'admin','127.0.0.1','内网IP','Chrome 11','Windows 10','0','登录成功','2024-03-17 16:50:42'),(35,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','0','登录成功','2024-03-18 08:22:39'),(36,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','0','登录成功','2024-03-18 08:42:43'),(37,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','0','登录成功','2024-03-18 18:29:41'),(38,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','0','登录成功','2024-03-24 18:44:22'),(39,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','0','登录成功','2024-03-24 19:30:24'),(40,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','0','登录成功','2024-03-24 20:26:51'),(41,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','0','登录成功','2024-03-24 22:49:19'),(42,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','0','登录成功','2024-04-01 15:37:17');
/*!40000 ALTER TABLE `sys_logininfor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_menu`
--

DROP TABLE IF EXISTS `sys_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_menu` (
  `menu_id` bigint NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
  `menu_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '菜单名称',
  `parent_id` bigint DEFAULT '0' COMMENT '父菜单ID',
  `order_num` int DEFAULT '0' COMMENT '显示顺序',
  `path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '路由地址',
  `component` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '组件路径',
  `query` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '路由参数',
  `is_frame` int DEFAULT '1' COMMENT '是否为外链（0是 1否）',
  `is_cache` int DEFAULT '0' COMMENT '是否缓存（0缓存 1不缓存）',
  `menu_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '菜单类型（M目录 C菜单 F按钮）',
  `visible` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '菜单状态（0显示 1隐藏）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '菜单状态（0正常 1停用）',
  `perms` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '权限标识',
  `icon` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '#' COMMENT '菜单图标',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2091 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='菜单权限表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_menu`
--

LOCK TABLES `sys_menu` WRITE;
/*!40000 ALTER TABLE `sys_menu` DISABLE KEYS */;
INSERT INTO `sys_menu` VALUES (1,'系统管理',0,99,'system','','',1,0,'M','0','0','','system','admin','2023-12-27 15:00:27','admin','2024-04-20 22:21:25','系统管理目录'),(2,'采购管理',0,7,'scm','','',1,0,'M','1','0','','server','admin','2023-12-27 15:00:27','admin','2025-04-25 08:25:33','至简官网地址'),(3,'订单管理',0,2,'order','','',1,0,'M','0','0','','shopping','admin','2023-12-29 16:53:03','admin','2024-04-10 11:02:32',''),(4,'发货管理',0,3,'ship','','',1,0,'M','0','0','','excel','admin','2024-01-01 14:08:04','admin','2024-04-10 11:10:31',''),(5,'售后处理',0,4,'after_sale',NULL,NULL,1,0,'M','0','0','','clipboard','admin','2024-01-03 14:23:55','admin','2025-04-17 12:18:27',''),(6,'库存管理',0,5,'stock','','',1,0,'M','0','0','','chart','admin','2023-12-31 12:14:33','admin','2025-05-17 15:41:10',''),(7,'店铺管理',0,6,'shop','','',1,0,'M','0','0','','theme','admin','2023-12-29 17:07:23','admin','2024-04-10 10:56:43',''),(8,'商品管理',0,0,'goods','','',1,0,'M','0','0','','theme','admin','2023-12-29 13:29:44','admin','2025-04-15 22:06:08',''),(9,'费用管理',0,10,'fms','','',1,0,'M','1','0','','money','admin','2023-12-29 13:29:44','admin','2025-04-19 10:19:58',''),(100,'用户管理',1,1,'user','system/user/index','',1,0,'C','0','0','system:user:list','user','admin','2023-12-27 15:00:27','','','用户管理菜单'),(101,'角色管理',1,2,'role','system/role/index','',1,0,'C','0','0','system:role:list','peoples','admin','2023-12-27 15:00:27','','','角色管理菜单'),(102,'菜单管理',1,3,'menu','system/menu/index','',1,0,'C','0','0','system:menu:list','tree-table','admin','2023-12-27 15:00:27','','','菜单管理菜单'),(103,'部门管理',1,4,'dept','system/dept/index','',1,0,'C','0','0','system:dept:list','tree','admin','2023-12-27 15:00:27','','','部门管理菜单'),(105,'字典管理',1,6,'dict','system/dict/index','',1,0,'C','0','0','system:dict:list','dict','admin','2023-12-27 15:00:27','','','字典管理菜单'),(1000,'用户查询',100,1,'','','',1,0,'F','0','0','system:user:query','#','admin','2023-12-27 15:00:27','','',''),(1001,'用户新增',100,2,'','','',1,0,'F','0','0','system:user:add','#','admin','2023-12-27 15:00:27','','',''),(1002,'用户修改',100,3,'','','',1,0,'F','0','0','system:user:edit','#','admin','2023-12-27 15:00:27','','',''),(1003,'用户删除',100,4,'','','',1,0,'F','0','0','system:user:remove','#','admin','2023-12-27 15:00:27','','',''),(1004,'用户导出',100,5,'','','',1,0,'F','0','0','system:user:export','#','admin','2023-12-27 15:00:27','','',''),(1005,'用户导入',100,6,'','','',1,0,'F','0','0','system:user:import','#','admin','2023-12-27 15:00:27','','',''),(1006,'重置密码',100,7,'','','',1,0,'F','0','0','system:user:resetPwd','#','admin','2023-12-27 15:00:27','','',''),(1007,'角色查询',101,1,'','','',1,0,'F','0','0','system:role:query','#','admin','2023-12-27 15:00:27','','',''),(1008,'角色新增',101,2,'','','',1,0,'F','0','0','system:role:add','#','admin','2023-12-27 15:00:27','','',''),(1009,'角色修改',101,3,'','','',1,0,'F','0','0','system:role:edit','#','admin','2023-12-27 15:00:27','','',''),(1010,'角色删除',101,4,'','','',1,0,'F','0','0','system:role:remove','#','admin','2023-12-27 15:00:27','','',''),(1011,'角色导出',101,5,'','','',1,0,'F','0','0','system:role:export','#','admin','2023-12-27 15:00:27','','',''),(1012,'菜单查询',102,1,'','','',1,0,'F','0','0','system:menu:query','#','admin','2023-12-27 15:00:27','','',''),(1013,'菜单新增',102,2,'','','',1,0,'F','0','0','system:menu:add','#','admin','2023-12-27 15:00:27','','',''),(1014,'菜单修改',102,3,'','','',1,0,'F','0','0','system:menu:edit','#','admin','2023-12-27 15:00:27','','',''),(1015,'菜单删除',102,4,'','','',1,0,'F','0','0','system:menu:remove','#','admin','2023-12-27 15:00:27','','',''),(1016,'部门查询',103,1,'','','',1,0,'F','0','0','system:dept:query','#','admin','2023-12-27 15:00:27','','',''),(1017,'部门新增',103,2,'','','',1,0,'F','0','0','system:dept:add','#','admin','2023-12-27 15:00:27','','',''),(1018,'部门修改',103,3,'','','',1,0,'F','0','0','system:dept:edit','#','admin','2023-12-27 15:00:27','','',''),(1019,'部门删除',103,4,'','','',1,0,'F','0','0','system:dept:remove','#','admin','2023-12-27 15:00:27','','',''),(1025,'字典查询',105,1,'#','','',1,0,'F','0','0','system:dict:query','#','admin','2023-12-27 15:00:27','','',''),(1026,'字典新增',105,2,'#','','',1,0,'F','0','0','system:dict:add','#','admin','2023-12-27 15:00:27','','',''),(1027,'字典修改',105,3,'#','','',1,0,'F','0','0','system:dict:edit','#','admin','2023-12-27 15:00:27','','',''),(1028,'字典删除',105,4,'#','','',1,0,'F','0','0','system:dict:remove','#','admin','2023-12-27 15:00:27','','',''),(1029,'字典导出',105,5,'#','','',1,0,'F','0','0','system:dict:export','#','admin','2023-12-27 15:00:27','','',''),(2005,'供应商管理',8,99,'supplier/list','scm/supplier/index','',1,0,'C','0','0','scm:supplier','qq','admin','2023-12-29 09:14:02','admin','2025-04-19 10:39:19',''),(2007,'商品库',8,2,'goods_list','goods/index','',1,0,'C','0','0','goods:list','theme','admin','2023-12-29 13:31:01','admin','2025-04-17 12:16:02',''),(2008,'商品分类',8,88,'category','goods/category/index','',1,0,'C','0','0','goods:category','tree-table','admin','2023-12-29 13:32:41','admin','2024-04-21 14:41:32',''),(2009,'商品品牌',8,99,'brand','goods/brand/index','',1,0,'C','0','0','goods:brand','clipboard','admin','2023-12-29 13:34:49','admin','2025-04-15 22:08:24',''),(2010,'采购管理',2,1,'purchase/order','scm/purchase/order','',1,0,'C','0','0','scm:purchase:order','button','admin','2023-12-29 16:35:55','admin','2024-04-21 10:53:43',''),(2012,'采购物流管理',2,2,'purchase/ship','scm/purchase/ship','',1,0,'C','0','0','scm:purchase:ship','component','admin','2023-12-29 16:45:42','admin','2024-04-21 11:06:08',''),(2019,'采购账单管理',9,3,'purchase_bill','scm/purchase/bill','',1,0,'C','0','0','','money','admin','2023-12-29 17:09:32','admin','2025-04-17 12:24:24',''),(2021,'创建采购单',2,101,'purchase/order/create','scm/purchase/order/create','',1,0,'C','1','0','','edit','admin','2023-12-29 21:23:45','admin','2024-04-21 11:44:03',''),(2025,'采购订单详情',2,102,'purchase/order/detail','scm/purchase/order/detail','',1,0,'C','1','0','','button','admin','2023-12-30 17:08:01','admin','2024-04-21 11:04:50',''),(2027,'商品入库管理',6,10,'stock_in_entry/list','wms/stockInEntry','',1,0,'C','0','0','wms:stock_in_entry:list','stockin','admin','2023-12-31 12:27:37','admin','2025-05-17 15:43:29',''),(2028,'生成采购入库单',2,103,'purchase/ship/create_stock_in_entry','scm/purchase/ship/create_stock_in_entry','',1,0,'C','1','0','','button','admin','2023-12-31 12:31:32','admin','2024-04-21 11:05:53',''),(2029,'店铺售后管理',5,2,'shop_refund','shop/refund/index','',1,0,'C','0','0','','clipboard','admin','2023-12-31 17:29:03','admin','2025-04-17 12:20:16',''),(2033,'订单库',3,1,'list','order/index','',1,0,'C','0','0','','list','admin','2023-12-31 20:05:05','admin','2025-04-19 10:45:33',''),(2035,'订单退货',5,4,'order_returned','afterSale/returned','',1,0,'C','0','0','','upload','admin','2024-01-01 14:13:47','admin','2024-04-10 11:29:27',''),(2036,'店铺订单管理',3,10,'shop_order','shop/order/index','',1,1,'C','0','0','','excel','admin','2024-01-01 14:14:42','admin','2025-04-19 10:45:27',''),(2041,'订单补发',5,6,'order_ship_again','afterSale/shipAgain',NULL,1,0,'C','0','0','','checkbox','admin','2024-01-02 14:11:34','admin','2024-04-10 11:28:26',''),(2042,'订单拦截',5,3,'order_intercept','afterSale/intercept',NULL,1,0,'C','0','0','','edit','admin','2024-01-02 14:11:56','admin','2024-04-10 11:28:32',''),(2044,'订单换货',5,5,'order_exchange','afterSale/exchange',NULL,1,0,'C','0','0','','skill','admin','2024-01-03 09:18:53','admin','2024-04-10 11:30:38',''),(2046,'商品出库管理',6,25,'stockOut','wms/stockOutEntry',NULL,1,0,'C','0','0','','link','admin','2024-01-03 11:00:53','admin','2025-05-17 15:43:38',''),(2047,'商品库存查询',6,6,'goodsInventory','goods/goodsInventory',NULL,1,0,'C','0','0','','monitor','admin','2024-01-03 11:01:14','admin','2025-05-17 15:43:13',''),(2049,'打单&发货',4,10,'ewaybillPrint','shipping/ewaybillPrint/index',NULL,1,0,'C','0','0','','guide','admin','2024-01-03 14:09:18','admin','2025-04-26 15:55:30',''),(2051,'发货记录',4,104,'logs','shipping/logs/index',NULL,1,0,'C','0','0','','email','admin','2024-01-03 14:13:12','admin','2025-04-26 16:02:40',''),(2054,'售后处理',5,1,'refund_list','refund/index',NULL,1,0,'C','1','0','','size','admin','2024-01-03 14:24:36','admin','2025-04-17 12:17:13',''),(2059,'备货中',4,101,'stock_up','shipping/stock_up','',1,0,'C','0','0','','component','admin','2024-01-09 11:51:52','admin','2025-05-17 10:30:27',''),(2060,'拣货出库',4,102,'stockout','wms/orderShipping/stockOut',NULL,1,0,'C','0','1','','bug','admin','2024-01-09 13:39:00','admin','2025-05-17 13:42:01',''),(2061,'仓位管理',6,69,'stock_location','wms/location',NULL,1,0,'C','0','0','','education','admin','2024-01-09 13:54:30','admin','2025-05-17 15:42:20',''),(2062,'代发账单管理',9,4,'agent_ship_bill','shipping/agent/shipBill',NULL,1,0,'C','0','0','','money','admin','2024-01-12 18:35:02','admin','2025-04-17 12:23:33',''),(2063,'物流费用',9,100,'shipFee','fms/payable/shipFee',NULL,1,0,'C','0','0','','guide','admin','2024-01-12 18:35:31','admin','2025-04-17 12:23:45',''),(2066,'添加商品',8,2,'create','goods/create',NULL,1,0,'C','1','0','','component','admin','2024-01-14 19:42:11','admin','2024-04-10 11:33:33',''),(2067,'商品SKU管理',8,3,'sku_list','goods/spec',NULL,1,0,'C','1','0','','theme','admin','2024-01-16 14:17:39','admin','2025-04-15 22:07:31',''),(2068,'店铺商品管理',8,1,'shop_goods/list','shop/goods',NULL,1,0,'C','0','0','','example','admin','2024-01-28 11:23:36','admin','2025-04-17 12:15:54',''),(2072,'店铺管理',7,2,'list','shop/index',NULL,1,0,'C','0','0','','clipboard','admin','2024-01-28 11:29:21','admin','2024-04-10 11:00:21',''),(2081,'API拉取日志',7,999,'pull_log','shop/order/pull_log',NULL,1,0,'C','0','0','','component','admin','2024-04-21 11:08:55','admin','2025-05-07 11:09:40',''),(2082,'售后设置',5,10,'set',NULL,NULL,1,0,'C','0','1','','404','admin','2024-04-21 11:11:09','admin','2025-04-17 12:17:53',''),(2083,'库存日志',6,99,'logs',NULL,NULL,1,0,'C','0','1','','bug','admin','2024-04-21 11:12:07','admin','2025-05-17 15:43:01',''),(2085,'商品分类属性',8,90,'category_attr','goods/category/categoryAttribute',NULL,1,0,'C','1','0','','404','admin','2024-04-21 14:29:04','admin','2024-04-21 14:40:53',''),(2086,'分类属性值',8,91,'category_attr_val','goods/category/categoryAttributeValue',NULL,1,0,'C','1','0','','clipboard','admin','2024-04-21 15:13:03','admin','2024-04-21 15:13:54',''),(2088,'手动添加订单',3,9,'create','order/create',NULL,1,0,'C','1','1','','form','admin','2025-04-19 10:57:29','admin','2025-05-16 08:56:15',''),(2089,'手动添加店铺订单',3,11,'shop_order_create','shop/order/create',NULL,1,0,'C','1','0','','clipboard','admin','2025-04-26 10:02:11','admin','2025-04-26 10:02:59',''),(2090,'发货设置',4,105,'setting','shipping/set/index',NULL,1,0,'C','0','0',NULL,'dict','admin','2025-04-26 18:48:29','',NULL,'');
/*!40000 ALTER TABLE `sys_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_oper_log`
--

DROP TABLE IF EXISTS `sys_oper_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_oper_log` (
  `oper_id` bigint NOT NULL AUTO_INCREMENT COMMENT '日志主键',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '模块标题',
  `business_type` int DEFAULT '0' COMMENT '业务类型（0其它 1新增 2修改 3删除）',
  `method` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '方法名称',
  `request_method` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '请求方式',
  `operator_type` int DEFAULT '0' COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
  `oper_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '操作人员',
  `dept_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '部门名称',
  `oper_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '请求URL',
  `oper_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '主机地址',
  `oper_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '操作地点',
  `oper_param` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '请求参数',
  `json_result` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '返回参数',
  `status` int DEFAULT '0' COMMENT '操作状态（0正常 1异常）',
  `error_msg` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '错误消息',
  `oper_time` datetime DEFAULT NULL COMMENT '操作时间',
  `cost_time` bigint DEFAULT '0' COMMENT '消耗时间',
  PRIMARY KEY (`oper_id`) USING BTREE,
  KEY `idx_sys_oper_log_bt` (`business_type`) USING BTREE,
  KEY `idx_sys_oper_log_s` (`status`) USING BTREE,
  KEY `idx_sys_oper_log_ot` (`oper_time`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=174 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='操作日志记录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_oper_log`
--

LOCK TABLES `sys_oper_log` WRITE;
/*!40000 ALTER TABLE `sys_oper_log` DISABLE KEYS */;
INSERT INTO `sys_oper_log` VALUES (1,'淘宝订单',1,'com.qihang.erp.api.controller.TaoOrderController.add()','POST',1,'admin',NULL,'/tao/order','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"params\":{},\"taoOrderItemList\":[]}','{\"msg\":\"请添加商品\",\"code\":506}',0,NULL,'2024-01-13 20:31:20',31),(2,'淘宝退款订单',1,'com.qihang.erp.api.controller.TaoOrderRefundController.add()','POST',1,'admin',NULL,'/tao/taoRefund','127.0.0.1','内网IP','{\"afterSalesType\":1,\"num\":1,\"oid\":\"3238963057148759844\",\"params\":{},\"refundFee\":82.21,\"tid\":\"3238963057148759844\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-01-13 20:58:32',25131),(3,'淘宝退款订单',1,'com.qihang.erp.api.controller.TaoOrderRefundController.add()','POST',1,'admin',NULL,'/tao/taoRefund','127.0.0.1','内网IP','{\"afterSalesType\":9,\"num\":1,\"oid\":\"3238963057148759844\",\"params\":{},\"refundFee\":82.21,\"refundId\":\"11\",\"tid\":\"3238963057148759844\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-01-13 21:00:25',7879),(4,'淘宝退款订单',1,'com.qihang.erp.api.controller.TaoOrderRefundController.add()','POST',1,'admin',NULL,'/tao/taoRefund','127.0.0.1','内网IP','{\"afterSalesType\":9,\"num\":1,\"oid\":\"3238963057148759844\",\"params\":{},\"refundFee\":82.21,\"refundId\":\"11\",\"tid\":\"3238963057148759844\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-01-13 21:00:32',0),(5,'淘宝退款订单',1,'com.qihang.erp.api.controller.TaoOrderRefundController.add()','POST',1,'admin',NULL,'/tao/taoRefund','127.0.0.1','内网IP','{\"afterSalesType\":9,\"num\":1,\"oid\":\"3238963057148759844\",\"params\":{},\"refundFee\":82.21,\"refundId\":\"11\",\"tid\":\"3238963057148759844\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-01-13 21:00:36',0),(6,'淘宝退款订单',1,'com.qihang.erp.api.controller.TaoOrderRefundController.add()','POST',1,'admin',NULL,'/tao/taoRefund','127.0.0.1','内网IP','{\"afterSalesType\":3,\"num\":1,\"oid\":\"3238963057148759844\",\"params\":{},\"refundFee\":82.21,\"refundId\":\"2323\",\"tid\":\"3238963057148759844\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-01-13 21:01:10',0),(7,'淘宝退款订单',1,'com.qihang.erp.api.controller.TaoOrderRefundController.add()','POST',1,'admin',NULL,'/tao/taoRefund','127.0.0.1','内网IP','{\"afterSalesType\":9,\"num\":1,\"oid\":\"3238963057148759844\",\"params\":{},\"refundFee\":82.21,\"refundId\":\"dd\",\"tid\":\"3238963057148759844\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-01-13 21:01:56',0),(8,'淘宝退款订单',1,'com.qihang.erp.api.controller.TaoOrderRefundController.add()','POST',1,'admin',NULL,'/tao/taoRefund','127.0.0.1','内网IP','{\"afterSalesType\":1,\"num\":1,\"oid\":\"3198002834286896419\",\"params\":{},\"refundFee\":24,\"refundId\":\"205639742516891964\",\"tid\":\"3198002834286896419\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-01-13 21:03:29',0),(9,'淘宝退款订单',1,'com.qihang.erp.api.controller.TaoOrderRefundController.add()','POST',1,'admin',NULL,'/tao/taoRefund','127.0.0.1','内网IP','{\"afterSalesType\":1,\"num\":1,\"oid\":\"3198002834286896419\",\"params\":{},\"refundFee\":24,\"refundId\":\"205639742516891964\",\"tid\":\"3198002834286896419\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-01-13 21:12:45',24108),(10,'淘宝退款订单',1,'com.qihang.erp.api.controller.TaoOrderRefundController.add()','POST',1,'admin',NULL,'/tao/taoRefund','127.0.0.1','内网IP','{\"afterSalesType\":1,\"num\":1,\"oid\":\"3198002834286896419\",\"params\":{},\"refundFee\":24,\"refundId\":\"205639742516891964\",\"tid\":\"3198002834286896419\"}','{\"msg\":\"子订单已经在售后中！请勿重复提交！\",\"code\":502}',0,NULL,'2024-01-13 21:14:10',6809),(11,'代码生成',3,'com.zhijian.generator.controller.GenController.remove()','DELETE',1,'admin',NULL,'/tool/gen/46,47,48,49,50,51','127.0.0.1','内网IP','{}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-01-13 21:27:42',16),(12,'代码生成',6,'com.zhijian.generator.controller.GenController.importTableSave()','POST',1,'admin',NULL,'/tool/gen/importTable','127.0.0.1','内网IP','{\"tables\":\"s_tao_order_refund\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-01-13 21:27:53',107),(13,'代码生成',2,'com.zhijian.generator.controller.GenController.editSave()','PUT',1,'admin',NULL,'/tool/gen','127.0.0.1','内网IP','{\"businessName\":\"refund\",\"className\":\"STaoOrderRefund\",\"columns\":[{\"capJavaField\":\"Id\",\"columnId\":1156,\"columnName\":\"id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2024-01-13 21:27:53\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":52,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"RefundId\",\"columnComment\":\"退款id\",\"columnId\":1157,\"columnName\":\"refund_id\",\"columnType\":\"varchar(50)\",\"createBy\":\"admin\",\"createTime\":\"2024-01-13 21:27:53\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"refundId\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":52,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"AfterSalesType\",\"columnComment\":\"类型（1退货3换货）\",\"columnId\":1158,\"columnName\":\"after_sales_type\",\"columnType\":\"int\",\"createBy\":\"admin\",\"createTime\":\"2024-01-13 21:27:53\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"select\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"afterSalesType\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":52,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"ShopId\",\"columnComment\":\"店铺id\",\"columnId\":1159,\"columnName\":\"shopId\",\"columnType\":\"int\",\"createBy\":\"admin\",\"createTime\":\"2024-01-13 21:27:53\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"shopId\",\"javaType\":\"Long\",\"list\"','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-01-13 21:28:07',71),(14,'代码生成',2,'com.zhijian.generator.controller.GenController.editSave()','PUT',1,'admin',NULL,'/tool/gen','127.0.0.1','内网IP','{\"businessName\":\"refund\",\"className\":\"TaoOrderRefund\",\"columns\":[{\"capJavaField\":\"Id\",\"columnId\":1156,\"columnName\":\"id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2024-01-13 21:27:53\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":52,\"updateBy\":\"\",\"updateTime\":\"2024-01-13 21:28:07\",\"usableColumn\":false},{\"capJavaField\":\"RefundId\",\"columnComment\":\"退款id\",\"columnId\":1157,\"columnName\":\"refund_id\",\"columnType\":\"varchar(50)\",\"createBy\":\"admin\",\"createTime\":\"2024-01-13 21:27:53\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"refundId\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":52,\"updateBy\":\"\",\"updateTime\":\"2024-01-13 21:28:07\",\"usableColumn\":false},{\"capJavaField\":\"AfterSalesType\",\"columnComment\":\"类型（1退货3换货）\",\"columnId\":1158,\"columnName\":\"after_sales_type\",\"columnType\":\"int\",\"createBy\":\"admin\",\"createTime\":\"2024-01-13 21:27:53\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"select\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"afterSalesType\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":52,\"updateBy\":\"\",\"updateTime\":\"2024-01-13 21:28:07\",\"usableColumn\":false},{\"capJavaField\":\"ShopId\",\"columnComment\":\"店铺id\",\"columnId\":1159,\"columnName\":\"shopId\",\"columnType\":\"int\",\"createBy\":\"admin\",\"createTime\":\"2024-01-13 21:27:53\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-01-13 21:28:16',54),(15,'代码生成',8,'com.zhijian.generator.controller.GenController.batchGenCode()','GET',1,'admin',NULL,'/tool/gen/batchGenCode','127.0.0.1','内网IP','{\"tables\":\"s_tao_order_refund\"}',NULL,0,NULL,'2024-01-13 21:28:31',385),(16,'淘宝退款订单',1,'com.qihang.erp.api.controller.TaoOrderRefundController.add()','POST',1,'admin',NULL,'/tao/taoRefund','127.0.0.1','内网IP','{\"afterSalesType\":3,\"createBy\":\"admin\",\"goodsTitle\":\"8026牛仔短裤\",\"num\":1,\"oid\":3198002834286896419,\"params\":{},\"productImgUrl\":\"https://cbu01.alicdn.com/img/ibank/O1CN01PHFmsX2FOyB14fPie_!!2208857268871-0-cib.jpg\",\"refundFee\":24,\"refundId\":\"205639742516891970\",\"skuInfo\":\"颜色分类：浅蓝色;尺寸：2XL[121-125斤]\",\"tid\":3198002834286896419}','{\"msg\":\"子订单已经在售后中！请勿重复提交！\",\"code\":502}',0,NULL,'2024-01-13 21:43:22',13894),(17,'淘宝退款订单',1,'com.qihang.erp.api.controller.TaoOrderRefundController.add()','POST',1,'admin',NULL,'/tao/taoRefund','127.0.0.1','内网IP','{\"afterSalesType\":3,\"createBy\":\"admin\",\"goodsTitle\":\"8026牛仔短裤\",\"num\":1,\"oid\":3198002834286896419,\"params\":{},\"productImgUrl\":\"https://cbu01.alicdn.com/img/ibank/O1CN01PHFmsX2FOyB14fPie_!!2208857268871-0-cib.jpg\",\"refundFee\":24,\"refundId\":\"205639742516891970\",\"skuInfo\":\"颜色分类：浅蓝色;尺寸：2XL[121-125斤]\",\"tid\":3198002834286896419}','{\"msg\":\"子订单已经在售后中！请勿重复提交！\",\"code\":502}',0,NULL,'2024-01-13 21:43:44',13860),(18,'淘宝退款订单',1,'com.qihang.erp.api.controller.TaoOrderRefundController.add()','POST',1,'admin',NULL,'/tao/taoRefund','127.0.0.1','内网IP','{\"afterSalesType\":3,\"createBy\":\"admin\",\"goodsTitle\":\"8026牛仔短裤\",\"num\":1,\"oid\":3198002834286896419,\"params\":{},\"productImgUrl\":\"https://cbu01.alicdn.com/img/ibank/O1CN01PHFmsX2FOyB14fPie_!!2208857268871-0-cib.jpg\",\"refundFee\":24,\"refundId\":\"205639742516891970\",\"skuInfo\":\"颜色分类：浅蓝色;尺寸：2XL[121-125斤]\",\"tid\":3198002834286896419}',NULL,1,'\r\n### Error updating database.  Cause: java.sql.SQLSyntaxErrorException: Unknown column \'updateTime\' in \'field list\'\r\n### The error may exist in file [D:\\projects\\qihang.ecom.erp\\ecerp-api\\target\\classes\\mapper\\tao\\TaoOrderMapper.xml]\r\n### The error may involve com.qihang.erp.api.mapper.TaoOrderMapper.updateTaoOrderItem-Inline\r\n### The error occurred while setting parameters\r\n### SQL: update s_tao_order_item      SET refundStatus = ?,         updateTime = ?,         updateBy = ?          where id = ?\r\n### Cause: java.sql.SQLSyntaxErrorException: Unknown column \'updateTime\' in \'field list\'\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: Unknown column \'updateTime\' in \'field list\'','2024-01-13 21:44:19',16613),(19,'淘宝退款订单',1,'com.qihang.erp.api.controller.TaoOrderRefundController.add()','POST',1,'admin',NULL,'/tao/taoRefund','127.0.0.1','内网IP','{\"afterSalesType\":3,\"createBy\":\"admin\",\"goodsTitle\":\"8026牛仔短裤\",\"num\":1,\"oid\":3198002834286896419,\"params\":{},\"productImgUrl\":\"https://cbu01.alicdn.com/img/ibank/O1CN01PHFmsX2FOyB14fPie_!!2208857268871-0-cib.jpg\",\"refundFee\":24,\"refundId\":\"205639742516891970\",\"skuInfo\":\"颜色分类：浅蓝色;尺寸：2XL[121-125斤]\",\"tid\":3198002834286896419}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-01-13 21:46:58',17009),(20,'淘宝退款订单',2,'com.qihang.erp.api.controller.TaoOrderRefundController.edit()','PUT',1,'admin',NULL,'/tao/taoRefund','127.0.0.1','内网IP','{\"afterSalesType\":1,\"auditStatus\":0,\"createBy\":\"admin\",\"createTime\":\"2024-01-13 21:46:51\",\"created\":1705153607,\"erpGoodsId\":0,\"erpGoodsSpecId\":0,\"goodsNumber\":\"2720218026\",\"goodsTitle\":\"8026牛仔短裤\",\"id\":29,\"logisticsCode\":\"SF10235566202\",\"logisticsCompany\":\"顺丰快递\",\"num\":1,\"oid\":3198002834286896600,\"params\":{},\"productImgUrl\":\"https://cbu01.alicdn.com/img/ibank/O1CN01PHFmsX2FOyB14fPie_!!2208857268871-0-cib.jpg\",\"refundFee\":24,\"refundId\":\"205639742516891970\",\"sendTime\":\"2024-01-13\",\"shopId\":6,\"skuId\":42,\"skuInfo\":\"颜色分类：浅蓝色;尺寸：2XL[121-125斤]\",\"specNumber\":\"2720210080260305\",\"status\":1,\"tid\":3198002834286896600,\"updateBy\":\"admin\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-01-13 22:53:43',37654),(21,'淘宝退款订单',2,'com.qihang.erp.api.controller.TaoOrderRefundController.edit()','PUT',1,'admin',NULL,'/tao/taoRefund','127.0.0.1','内网IP','{\"afterSalesType\":1,\"auditStatus\":0,\"createBy\":\"admin\",\"createTime\":\"2024-01-13 21:46:51\",\"created\":1705153607,\"erpGoodsId\":0,\"erpGoodsSpecId\":0,\"goodsNumber\":\"2720218026\",\"goodsTitle\":\"8026牛仔短裤\",\"id\":29,\"logisticsCode\":\"SF100255698552\",\"logisticsCompany\":\"顺丰物流\",\"num\":1,\"oid\":3198002834286896600,\"params\":{},\"productImgUrl\":\"https://cbu01.alicdn.com/img/ibank/O1CN01PHFmsX2FOyB14fPie_!!2208857268871-0-cib.jpg\",\"refundFee\":24,\"refundId\":\"205639742516891970\",\"sendTime\":\"2024-01-13\",\"shopId\":6,\"skuId\":42,\"skuInfo\":\"颜色分类：浅蓝色;尺寸：2XL[121-125斤]\",\"specNumber\":\"2720210080260305\",\"status\":1,\"tid\":3198002834286896600,\"updateBy\":\"admin\"}',NULL,1,'nested exception is org.apache.ibatis.reflection.ReflectionException: There is no getter for property named \'orderTimeId\' in \'class com.qihang.erp.api.domain.ErpOrderReturned\'','2024-01-13 23:15:25',29),(22,'淘宝退款订单',2,'com.qihang.erp.api.controller.TaoOrderRefundController.edit()','PUT',1,'admin',NULL,'/tao/taoRefund','127.0.0.1','内网IP','{\"afterSalesType\":1,\"auditStatus\":0,\"createBy\":\"admin\",\"createTime\":\"2024-01-13 21:46:51\",\"created\":1705153607,\"erpGoodsId\":0,\"erpGoodsSpecId\":0,\"goodsNumber\":\"2720218026\",\"goodsTitle\":\"8026牛仔短裤\",\"id\":29,\"logisticsCode\":\"SF100255698552\",\"logisticsCompany\":\"顺丰物流\",\"num\":1,\"oid\":3198002834286896600,\"params\":{},\"productImgUrl\":\"https://cbu01.alicdn.com/img/ibank/O1CN01PHFmsX2FOyB14fPie_!!2208857268871-0-cib.jpg\",\"refundFee\":24,\"refundId\":\"205639742516891970\",\"sendTime\":\"2024-01-13\",\"shopId\":6,\"skuId\":42,\"skuInfo\":\"颜色分类：浅蓝色;尺寸：2XL[121-125斤]\",\"specNumber\":\"2720210080260305\",\"status\":1,\"tid\":3198002834286896600,\"updateBy\":\"admin\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-01-13 23:17:14',134),(23,'淘宝退款订单',2,'com.qihang.erp.api.controller.TaoOrderRefundController.edit()','PUT',1,'admin',NULL,'/tao/taoRefund','127.0.0.1','内网IP','{\"afterSalesType\":1,\"auditStatus\":0,\"createTime\":\"2023-02-21 18:08:29\",\"erpGoodsId\":9,\"erpGoodsSpecId\":42,\"id\":27,\"logisticsCode\":\"YT7054813104977\",\"logisticsCompany\":\"圆通速递\",\"num\":1,\"oid\":3198002834286896600,\"params\":{},\"refundFee\":24,\"refundId\":\"205639742516891964\",\"sendTime\":\"2023-02-21 18:09:17\",\"shopId\":6,\"specNumber\":\"2720210080260305\",\"status\":1,\"tid\":3198002834286896600,\"updateBy\":\"admin\"}',NULL,1,'\r\n### Error querying database.  Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'s_tao_order a on a.id = b.order_id\n        where b.order_item_num = \'31980028342\' at line 4\r\n### The error may exist in file [D:\\projects\\qihang.ecom.erp\\ecerp-api\\target\\classes\\mapper\\api\\ErpOrderMapper.xml]\r\n### The error may involve com.qihang.erp.api.mapper.ErpOrderMapper.selectOrderItemByOrderItemNum-Inline\r\n### The error occurred while setting parameters\r\n### SQL: select         b.id as sub_id, b.order_item_num as sub_order_item_num,b.supplier_id as sub_supplier_id,b.order_id as sub_order_id, b.goods_id as sub_goods_id, b.spec_id as sub_spec_id, b.goods_title as sub_goods_title, b.goods_img as sub_goods_img, b.goods_num as sub_goods_num, b.goods_spec as sub_goods_spec, b.spec_num as sub_spec_num, b.goods_price as sub_goods_price, b.item_amount as sub_item_amount, b.quantity as sub_quantity, b.remark as sub_remark, b.is_gift as sub_is_gift, b.refund_count as sub_refund_count, b.refund_status as sub_refund_status, b.create_time as sub_create_time, b.create_by as sub_create_by, b.update_time as sub_update_time, b.update_by as sub_update_by         from  erp_order_item b         left s_tao_order a on a.id = b.order_id         where b.order_item_num = ? and shop_id = ?\r\n### Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'s_tao_order a on a.id = b.order_id\n        where b.order_item_num = \'31980028342\' at line 4\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'s_tao_order a on a.id = b.order_id\n        where b.order_item_num = \'31980028342\' at line 4','2024-01-14 10:03:29',139555),(24,'淘宝退款订单',2,'com.qihang.erp.api.controller.TaoOrderRefundController.edit()','PUT',1,'admin',NULL,'/tao/taoRefund','127.0.0.1','内网IP','{\"afterSalesType\":1,\"auditStatus\":0,\"createTime\":\"2023-02-21 18:08:29\",\"erpGoodsId\":9,\"erpGoodsSpecId\":42,\"id\":27,\"logisticsCode\":\"YT7054813104977\",\"logisticsCompany\":\"圆通速递\",\"num\":1,\"oid\":3198002834286896600,\"params\":{},\"refundFee\":24,\"refundId\":\"205639742516891964\",\"sendTime\":\"2023-02-21 18:09:17\",\"shopId\":6,\"specNumber\":\"2720210080260305\",\"status\":1,\"tid\":3198002834286896600,\"updateBy\":\"admin\"}',NULL,1,'\r\n### Error querying database.  Cause: java.sql.SQLSyntaxErrorException: Unknown column \'shop_id\' in \'where clause\'\r\n### The error may exist in file [D:\\projects\\qihang.ecom.erp\\ecerp-api\\target\\classes\\mapper\\api\\ErpOrderMapper.xml]\r\n### The error may involve com.qihang.erp.api.mapper.ErpOrderMapper.selectOrderItemByOrderItemNum-Inline\r\n### The error occurred while setting parameters\r\n### SQL: select         b.id as sub_id, b.order_item_num as sub_order_item_num,b.supplier_id as sub_supplier_id,b.order_id as sub_order_id, b.goods_id as sub_goods_id, b.spec_id as sub_spec_id, b.goods_title as sub_goods_title, b.goods_img as sub_goods_img, b.goods_num as sub_goods_num, b.goods_spec as sub_goods_spec, b.spec_num as sub_spec_num, b.goods_price as sub_goods_price, b.item_amount as sub_item_amount, b.quantity as sub_quantity, b.remark as sub_remark, b.is_gift as sub_is_gift, b.refund_count as sub_refund_count, b.refund_status as sub_refund_status, b.create_time as sub_create_time, b.create_by as sub_create_by, b.update_time as sub_update_time, b.update_by as sub_update_by         from  erp_order_item b         left join s_tao_order a on a.id = b.order_id         where b.order_item_num = ? and shop_id = ?\r\n### Cause: java.sql.SQLSyntaxErrorException: Unknown column \'shop_id\' in \'where clause\'\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: Unknown column \'shop_id\' in \'where clause\'','2024-01-14 10:03:45',86),(25,'淘宝退款订单',2,'com.qihang.erp.api.controller.TaoOrderRefundController.edit()','PUT',1,'admin',NULL,'/tao/taoRefund','127.0.0.1','内网IP','{\"afterSalesType\":1,\"auditStatus\":0,\"createTime\":\"2023-02-21 18:08:29\",\"erpGoodsId\":9,\"erpGoodsSpecId\":42,\"id\":27,\"logisticsCode\":\"YT7054813104977\",\"logisticsCompany\":\"圆通速递\",\"num\":1,\"oid\":3198002834286896600,\"params\":{},\"refundFee\":24,\"refundId\":\"205639742516891964\",\"sendTime\":\"2023-02-21 18:09:17\",\"shopId\":6,\"specNumber\":\"2720210080260305\",\"status\":1,\"tid\":3198002834286896600,\"updateBy\":\"admin\"}',NULL,1,'\r\n### Error querying database.  Cause: java.sql.SQLSyntaxErrorException: Unknown column \'a.shop_id\' in \'where clause\'\r\n### The error may exist in file [D:\\projects\\qihang.ecom.erp\\ecerp-api\\target\\classes\\mapper\\api\\ErpOrderMapper.xml]\r\n### The error may involve com.qihang.erp.api.mapper.ErpOrderMapper.selectOrderItemByOrderItemNum-Inline\r\n### The error occurred while setting parameters\r\n### SQL: select         b.id as sub_id, b.order_item_num as sub_order_item_num,b.supplier_id as sub_supplier_id,b.order_id as sub_order_id, b.goods_id as sub_goods_id, b.spec_id as sub_spec_id, b.goods_title as sub_goods_title, b.goods_img as sub_goods_img, b.goods_num as sub_goods_num, b.goods_spec as sub_goods_spec, b.spec_num as sub_spec_num, b.goods_price as sub_goods_price, b.item_amount as sub_item_amount, b.quantity as sub_quantity, b.remark as sub_remark, b.is_gift as sub_is_gift, b.refund_count as sub_refund_count, b.refund_status as sub_refund_status, b.create_time as sub_create_time, b.create_by as sub_create_by, b.update_time as sub_update_time, b.update_by as sub_update_by         from  erp_order_item b         left join s_tao_order a on a.id = b.order_id         where b.order_item_num = ? and a.shop_id = ?\r\n### Cause: java.sql.SQLSyntaxErrorException: Unknown column \'a.shop_id\' in \'where clause\'\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: Unknown column \'a.shop_id\' in \'where clause\'','2024-01-14 10:04:18',65),(26,'淘宝退款订单',2,'com.qihang.erp.api.controller.TaoOrderRefundController.edit()','PUT',1,'admin',NULL,'/tao/taoRefund','127.0.0.1','内网IP','{\"afterSalesType\":1,\"auditStatus\":0,\"createTime\":\"2023-02-21 18:08:29\",\"erpGoodsId\":9,\"erpGoodsSpecId\":42,\"id\":27,\"logisticsCode\":\"YT7054813104977\",\"logisticsCompany\":\"圆通速递\",\"num\":1,\"oid\":3198002834286896600,\"params\":{},\"refundFee\":24,\"refundId\":\"205639742516891964\",\"sendTime\":\"2023-02-21 18:09:17\",\"shopId\":6,\"specNumber\":\"2720210080260305\",\"status\":1,\"tid\":3198002834286896600,\"updateBy\":\"admin\"}','{\"msg\":\"数据错误：ErpOrderItem未找到！\",\"code\":521}',0,NULL,'2024-01-14 10:05:11',46),(27,'拼多多订单退款',1,'com.qihang.erp.api.controller.PddOrderRefundController.add()','POST',1,'admin',NULL,'/pdd/pddRefund','127.0.0.1','内网IP','{\"afterSalesType\":2,\"discountAmount\":null,\"goodsImage\":\"https://img.pddpic.com/mms-material-img/2022-07-23/b68b46a8-b269-4328-8909-7facf0a6354a.jpeg\",\"goodsName\":\"牛仔短裤辣妹高腰裤短款弹力紧身a字型抽绳绑带纯欲风学生潮流夏\",\"goodsPrice\":null,\"goodsSpec\":\"深灰色 黑灰色,S\",\"id\":15745472193,\"orderAmount\":null,\"orderItemId\":3490,\"orderSn\":\"230405-342695669310441\",\"params\":{},\"quantity\":1,\"refundAmount\":32,\"refundQty\":1}',NULL,1,'nested exception is org.apache.ibatis.reflection.ReflectionException: There is no getter for property named \'skuNumber\' in \'class com.qihang.erp.api.domain.PddOrderRefund\'','2024-01-14 11:58:09',25929),(28,'拼多多订单退款',1,'com.qihang.erp.api.controller.PddOrderRefundController.add()','POST',1,'admin',NULL,'/pdd/pddRefund','127.0.0.1','内网IP','{\"afterSalesType\":2,\"discountAmount\":null,\"goodsImage\":\"https://img.pddpic.com/mms-material-img/2022-07-23/b68b46a8-b269-4328-8909-7facf0a6354a.jpeg\",\"goodsName\":\"牛仔短裤辣妹高腰裤短款弹力紧身a字型抽绳绑带纯欲风学生潮流夏\",\"goodsPrice\":null,\"goodsSpec\":\"深灰色 黑灰色,S\",\"id\":15745472193,\"orderAmount\":null,\"orderItemId\":3490,\"orderSn\":\"230405-342695669310441\",\"params\":{},\"quantity\":1,\"refundAmount\":32,\"refundQty\":1}',NULL,1,'nested exception is org.apache.ibatis.reflection.ReflectionException: There is no getter for property named \'spec_number\' in \'class com.qihang.erp.api.domain.PddOrderRefund\'','2024-01-14 12:00:40',18382),(29,'拼多多订单退款',1,'com.qihang.erp.api.controller.PddOrderRefundController.add()','POST',1,'admin',NULL,'/pdd/pddRefund','127.0.0.1','内网IP','{\"afterSalesType\":2,\"discountAmount\":null,\"goodsImage\":\"https://img.pddpic.com/mms-material-img/2022-07-23/b68b46a8-b269-4328-8909-7facf0a6354a.jpeg\",\"goodsName\":\"牛仔短裤辣妹高腰裤短款弹力紧身a字型抽绳绑带纯欲风学生潮流夏\",\"goodsPrice\":null,\"goodsSpec\":\"深灰色 黑灰色,S\",\"id\":15745472193,\"orderAmount\":null,\"orderItemId\":3490,\"orderSn\":\"230405-342695669310441\",\"params\":{},\"quantity\":1,\"refundAmount\":32,\"refundQty\":1}',NULL,1,'nested exception is org.apache.ibatis.reflection.ReflectionException: There is no getter for property named \'spec_number\' in \'class com.qihang.erp.api.domain.PddOrderRefund\'','2024-01-14 12:02:11',12582),(30,'拼多多订单退款',1,'com.qihang.erp.api.controller.PddOrderRefundController.add()','POST',1,'admin',NULL,'/pdd/pddRefund','127.0.0.1','内网IP','{\"afterSalesType\":2,\"discountAmount\":null,\"goodsImage\":\"https://img.pddpic.com/mms-material-img/2022-07-23/b68b46a8-b269-4328-8909-7facf0a6354a.jpeg\",\"goodsName\":\"牛仔短裤辣妹高腰裤短款弹力紧身a字型抽绳绑带纯欲风学生潮流夏\",\"goodsPrice\":null,\"goodsSpec\":\"深灰色 黑灰色,S\",\"id\":15745472193,\"orderAmount\":null,\"orderItemId\":3490,\"orderSn\":\"230405-342695669310441\",\"params\":{},\"quantity\":1,\"refundAmount\":32,\"refundQty\":1}',NULL,1,'nested exception is org.apache.ibatis.reflection.ReflectionException: There is no getter for property named \'spec_number\' in \'class com.qihang.erp.api.domain.PddOrderRefund\'','2024-01-14 12:05:49',4496),(31,'拼多多订单退款',1,'com.qihang.erp.api.controller.PddOrderRefundController.add()','POST',1,'admin',NULL,'/pdd/pddRefund','127.0.0.1','内网IP','{\"afterSalesType\":2,\"discountAmount\":null,\"goodsImage\":\"https://img.pddpic.com/mms-material-img/2022-07-23/b68b46a8-b269-4328-8909-7facf0a6354a.jpeg\",\"goodsName\":\"牛仔短裤辣妹高腰裤短款弹力紧身a字型抽绳绑带纯欲风学生潮流夏\",\"goodsPrice\":null,\"goodsSpec\":\"深灰色 黑灰色,S\",\"id\":15745472193,\"orderAmount\":null,\"orderItemId\":3490,\"orderSn\":\"230405-342695669310441\",\"params\":{},\"quantity\":1,\"refundAmount\":32,\"refundQty\":1}',NULL,1,'\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'after_sale_reason\' doesn\'t have a default value\r\n### The error may exist in file [D:\\projects\\qihang.ecom.erp\\ecerp-api\\target\\classes\\mapper\\pdd\\PddOrderRefundMapper.xml]\r\n### The error may involve com.qihang.erp.api.mapper.PddOrderRefundMapper.insertPddOrderRefund-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into s_pdd_order_refund          ( id,             order_sn,             shopId,             after_sales_type,             after_sales_status,                          confirm_time,             created_time,             discount_amount,             order_amount,             refund_amount,             goods_image,             goods_id,             sku_id,             goods_name,             goods_number,             spec_number,             goods_spec,             quantity,             goods_price,                                                    audit_status )           values ( ?,             ?,             ?,             ?,             ?,                          ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,                                                    ? )\r\n### Cause: java.sql.SQLException: Field \'after_sale_reason\' doesn\'t have a default value\n; Field \'after_sale_reason\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'after_sale_reason\' doesn\'t have a default value','2024-01-14 12:08:09',7758),(32,'拼多多订单退款',1,'com.qihang.erp.api.controller.PddOrderRefundController.add()','POST',1,'admin',NULL,'/pdd/pddRefund','127.0.0.1','内网IP','{\"afterSalesType\":2,\"discountAmount\":null,\"goodsImage\":\"https://img.pddpic.com/mms-material-img/2022-07-23/b68b46a8-b269-4328-8909-7facf0a6354a.jpeg\",\"goodsName\":\"牛仔短裤辣妹高腰裤短款弹力紧身a字型抽绳绑带纯欲风学生潮流夏\",\"goodsPrice\":null,\"goodsSpec\":\"深灰色 黑灰色,S\",\"id\":15745472193,\"orderAmount\":null,\"orderItemId\":3490,\"orderSn\":\"230405-342695669310441\",\"params\":{},\"quantity\":1,\"refundAmount\":32,\"refundQty\":1}',NULL,1,'\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'15745472193\' for key \'s_pdd_order_refund.PRIMARY\'\r\n### The error may exist in file [D:\\projects\\qihang.ecom.erp\\ecerp-api\\target\\classes\\mapper\\pdd\\PddOrderRefundMapper.xml]\r\n### The error may involve com.qihang.erp.api.mapper.PddOrderRefundMapper.insertPddOrderRefund-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into s_pdd_order_refund          ( id,             order_sn,             shopId,             after_sales_type,             after_sales_status,                          confirm_time,             created_time,             discount_amount,             order_amount,             refund_amount,             goods_image,             goods_id,             sku_id,             goods_name,             goods_number,             spec_number,             goods_spec,             quantity,             goods_price,                                                    audit_status )           values ( ?,             ?,             ?,             ?,             ?,                          ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,                                                    ? )\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'15745472193\' for key \'s_pdd_order_refund.PRIMARY\'\n; Duplicate entry \'15745472193\' for key \'s_pdd_order_refund.PRIMARY\'; nested exception is java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'15745472193\' for key \'s_pdd_order_refund.PRIMARY\'','2024-01-14 12:09:02',4150),(33,'拼多多订单退款',1,'com.qihang.erp.api.controller.PddOrderRefundController.add()','POST',1,'admin',NULL,'/pdd/pddRefund','127.0.0.1','内网IP','{\"afterSalesType\":2,\"discountAmount\":null,\"goodsImage\":\"https://img.pddpic.com/mms-material-img/2022-07-23/b68b46a8-b269-4328-8909-7facf0a6354a.jpeg\",\"goodsName\":\"牛仔短裤辣妹高腰裤短款弹力紧身a字型抽绳绑带纯欲风学生潮流夏\",\"goodsPrice\":null,\"goodsSpec\":\"深灰色 黑灰色,S\",\"id\":1,\"orderAmount\":null,\"orderItemId\":3490,\"orderSn\":\"230405-342695669310441\",\"params\":{},\"quantity\":1,\"refundAmount\":32,\"refundQty\":1}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-01-14 12:09:37',18522),(34,'抖店订单退款',1,'com.qihang.erp.api.controller.DouOrderRefundController.add()','POST',1,'admin',NULL,'/dou/douRefund','127.0.0.1','内网IP','{\"aftersaleId\":7149891465417507000,\"aftersaleType\":1,\"comboAmount\":29.9,\"comboNum\":1,\"goodsSpec\":\"\\t浅蓝色;L\",\"orderAmount\":null,\"orderId\":\"5030436502888242865\",\"params\":{},\"productName\":\"\\t【夏款清仓】牛仔短裤女夏高腰宽松毛边牛仔裤甜欲风辣妹阔腿新款\",\"productPic\":\"http://img.huayiyungou.com/niuzaiduanku/HN8026.jpg\",\"subOrderId\":\"\\t5030436502888242865\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-01-14 13:43:00',16479),(35,'菜单管理',2,'com.zhijian.web.controller.system.SysMenuController.edit()','PUT',1,'admin',NULL,'/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"shop/goods\",\"createTime\":\"2023-12-29 17:02:42\",\"icon\":\"color\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2016,\"menuName\":\"店铺商品管理\",\"menuType\":\"C\",\"orderNum\":9,\"params\":{},\"parentId\":2014,\"path\":\"shop/goods\",\"perms\":\"shop:goods\",\"query\":\"\",\"status\":\"1\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-01-14 14:04:20',15),(36,'菜单管理',2,'com.zhijian.web.controller.system.SysMenuController.edit()','PUT',1,'admin',NULL,'/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"\",\"createTime\":\"2023-12-31 12:14:33\",\"icon\":\"stock\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2026,\"menuName\":\"库存管理\",\"menuType\":\"M\",\"orderNum\":5,\"params\":{},\"parentId\":0,\"path\":\"wms\",\"perms\":\"\",\"query\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-01-14 15:07:56',7),(37,'菜单管理',2,'com.zhijian.web.controller.system.SysMenuController.edit()','PUT',1,'admin',NULL,'/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"\",\"createTime\":\"2023-12-31 12:14:33\",\"icon\":\"stock1\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2026,\"menuName\":\"库存管理\",\"menuType\":\"M\",\"orderNum\":5,\"params\":{},\"parentId\":0,\"path\":\"wms\",\"perms\":\"\",\"query\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-01-14 15:10:51',9),(38,'菜单管理',2,'com.zhijian.web.controller.system.SysMenuController.edit()','PUT',1,'admin',NULL,'/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"wms/stockInEntry\",\"createTime\":\"2023-12-31 12:27:37\",\"icon\":\"stockin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2027,\"menuName\":\"入库管理\",\"menuType\":\"C\",\"orderNum\":0,\"params\":{},\"parentId\":2026,\"path\":\"stock_in_entry/list\",\"perms\":\"wms:stock_in_entry:list\",\"query\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-01-14 15:12:48',9),(39,'商品分类',1,'com.qihang.erp.api.controller.ErpGoodsCategoryController.add()','POST',1,'admin',NULL,'/goods/category','127.0.0.1','内网IP','{\"createTime\":\"2024-01-14 19:33:40\",\"id\":34,\"name\":\"男装\",\"number\":\"NANZ\",\"params\":{},\"parentId\":0}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-01-14 19:33:40',94),(40,'商品分类',1,'com.qihang.erp.api.controller.ErpGoodsCategoryController.add()','POST',1,'admin',NULL,'/goods/category','127.0.0.1','内网IP','{\"createTime\":\"2024-01-14 19:33:56\",\"id\":35,\"name\":\"牛仔裤\",\"number\":\"NZK\",\"params\":{},\"parentId\":34}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-01-14 19:33:56',7),(41,'商品分类',2,'com.qihang.erp.api.controller.ErpGoodsCategoryController.edit()','PUT',1,'admin',NULL,'/goods/category','127.0.0.1','内网IP','{\"createTime\":\"2024-01-14 19:33:57\",\"id\":35,\"isDelete\":0,\"name\":\"牛仔裤2\",\"number\":\"NZK\",\"params\":{},\"parentId\":34,\"path\":\"\",\"sort\":0,\"updateTime\":\"2024-01-14 19:34:07\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-01-14 19:34:07',9),(42,'商品分类',3,'com.qihang.erp.api.controller.ErpGoodsCategoryController.remove()','DELETE',1,'admin',NULL,'/goods/category/35','127.0.0.1','内网IP','{}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-01-14 19:34:12',9),(43,'商品分类',3,'com.qihang.erp.api.controller.ErpGoodsCategoryController.remove()','DELETE',1,'admin',NULL,'/goods/category/34','127.0.0.1','内网IP','{}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-01-14 19:34:17',9),(44,'菜单管理',1,'com.zhijian.web.controller.system.SysMenuController.add()','POST',1,'admin',NULL,'/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"goods/create\",\"createBy\":\"admin\",\"icon\":\"component\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"添加商品\",\"menuType\":\"C\",\"orderNum\":2,\"params\":{},\"parentId\":2006,\"path\":\"create\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-01-14 19:42:11',17),(45,'商品管理',1,'com.qihang.erp.api.controller.GoodsController.add()','POST',1,'admin',NULL,'/goods/goods','127.0.0.1','内网IP','{\"categoryId\":2,\"colorValues\":[413,412],\"image\":\"http://\",\"name\":\"asaa\",\"number\":\"dsfds\",\"params\":{},\"purPrice\":122.9,\"sizeValues\":[408,407,406,405],\"specList\":[{\"colorId\":413,\"colorValue\":\"浅蓝色加绒\",\"purPrice\":null,\"sizeId\":408,\"sizeValue\":\"32\",\"styleValue\":\"\"},{\"colorId\":413,\"colorValue\":\"浅蓝色加绒\",\"purPrice\":null,\"sizeId\":407,\"sizeValue\":\"31\",\"styleValue\":\"\"},{\"colorId\":413,\"colorValue\":\"浅蓝色加绒\",\"purPrice\":null,\"sizeId\":406,\"sizeValue\":\"30\",\"styleValue\":\"\"},{\"colorId\":413,\"colorValue\":\"浅蓝色加绒\",\"purPrice\":null,\"sizeId\":405,\"sizeValue\":\"29\",\"styleValue\":\"\"},{\"colorId\":412,\"colorValue\":\"复古蓝加绒\",\"purPrice\":null,\"sizeId\":408,\"sizeValue\":\"32\",\"styleValue\":\"\"},{\"colorId\":412,\"colorValue\":\"复古蓝加绒\",\"purPrice\":null,\"sizeId\":407,\"sizeValue\":\"31\",\"styleValue\":\"\"},{\"colorId\":412,\"colorValue\":\"复古蓝加绒\",\"purPrice\":null,\"sizeId\":406,\"sizeValue\":\"30\",\"styleValue\":\"\"},{\"colorId\":412,\"colorValue\":\"复古蓝加绒\",\"purPrice\":null,\"sizeId\":405,\"sizeValue\":\"29\",\"styleValue\":\"\"}],\"supplierId\":33}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-01-14 21:23:20',28844),(46,'商品管理',1,'com.qihang.erp.api.controller.GoodsController.add()','POST',1,'admin',NULL,'/goods/goods','127.0.0.1','内网IP','{\"categoryId\":2,\"colorValues\":[413,412],\"image\":\"aa\",\"name\":\"aa\",\"number\":\"aa\",\"params\":{},\"purPrice\":233,\"sizeValues\":[408,407,406],\"specList\":[{\"colorId\":413,\"colorValue\":\"浅蓝色加绒\",\"purPrice\":null,\"sizeId\":408,\"sizeValue\":\"32\",\"specNum\":\"1223\",\"styleValue\":\"\"},{\"colorId\":413,\"colorValue\":\"浅蓝色加绒\",\"purPrice\":null,\"sizeId\":407,\"sizeValue\":\"31\",\"specNum\":\"232\",\"styleValue\":\"\"},{\"colorId\":413,\"colorValue\":\"浅蓝色加绒\",\"purPrice\":null,\"sizeId\":406,\"sizeValue\":\"30\",\"specNum\":\"232\",\"styleValue\":\"\"},{\"colorId\":412,\"colorValue\":\"复古蓝加绒\",\"purPrice\":null,\"sizeId\":408,\"sizeValue\":\"32\",\"specNum\":\"232\",\"styleValue\":\"\"},{\"colorId\":412,\"colorValue\":\"复古蓝加绒\",\"purPrice\":null,\"sizeId\":407,\"sizeValue\":\"31\",\"specNum\":\"34\",\"styleValue\":\"\"},{\"colorId\":412,\"colorValue\":\"复古蓝加绒\",\"purPrice\":null,\"sizeId\":406,\"sizeValue\":\"30\",\"specNum\":\"34\",\"styleValue\":\"\"}],\"supplierId\":33}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-01-14 21:28:22',5230),(47,'商品管理',1,'com.qihang.erp.api.controller.GoodsController.add()','POST',1,'admin',NULL,'/goods/goods','127.0.0.1','内网IP','{\"categoryId\":2,\"colorValues\":[413,412],\"image\":\"ASDF\",\"name\":\"ASFD\",\"number\":\"AF02551\",\"params\":{},\"purPrice\":12,\"sizeValues\":[408,406],\"specList\":[{\"colorId\":413,\"colorValue\":\"浅蓝色加绒\",\"purPrice\":null,\"sizeId\":408,\"sizeValue\":\"32\",\"specNum\":\"AF0255115032\",\"styleValue\":\"\"},{\"colorId\":413,\"colorValue\":\"浅蓝色加绒\",\"purPrice\":null,\"sizeId\":406,\"sizeValue\":\"30\",\"specNum\":\"AF0255115030\",\"styleValue\":\"\"},{\"colorId\":412,\"colorValue\":\"复古蓝加绒\",\"purPrice\":null,\"sizeId\":408,\"sizeValue\":\"32\",\"specNum\":\"AF0255114032\",\"styleValue\":\"\"},{\"colorId\":412,\"colorValue\":\"复古蓝加绒\",\"purPrice\":null,\"sizeId\":406,\"sizeValue\":\"30\",\"specNum\":\"AF0255114030\",\"styleValue\":\"\"}],\"supplierId\":33}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-01-14 21:32:30',19313),(48,'商品管理',1,'com.qihang.erp.api.controller.GoodsController.add()','POST',1,'admin',NULL,'/goods/goods','127.0.0.1','内网IP','{\"categoryId\":2,\"colorValues\":[413,412],\"createBy\":\"admin\",\"createTime\":\"2024-01-14 21:52:29\",\"id\":71,\"image\":\"aaa\",\"name\":\"aaa\",\"number\":\"aaaaa\",\"params\":{},\"purPrice\":12,\"sizeValues\":[406,405],\"specList\":[{\"colorId\":413,\"colorValue\":\"浅蓝色加绒\",\"sizeId\":406,\"sizeValue\":\"30\",\"specNum\":\"aaaaa15030\",\"styleValue\":\"\"},{\"colorId\":413,\"colorValue\":\"浅蓝色加绒\",\"sizeId\":405,\"sizeValue\":\"29\",\"specNum\":\"aaaaa15029\",\"styleValue\":\"\"},{\"colorId\":412,\"colorValue\":\"复古蓝加绒\",\"sizeId\":406,\"sizeValue\":\"30\",\"specNum\":\"aaaaa14030\",\"styleValue\":\"\"},{\"colorId\":412,\"colorValue\":\"复古蓝加绒\",\"sizeId\":405,\"sizeValue\":\"29\",\"specNum\":\"aaaaa14029\",\"styleValue\":\"\"}],\"supplierId\":33}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-01-14 21:52:45',22292),(49,'代码生成',6,'com.zhijian.generator.controller.GenController.importTableSave()','POST',1,'admin',NULL,'/tool/gen/importTable','127.0.0.1','内网IP','{\"tables\":\"sys_oss\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-01-15 15:25:41',370),(50,'代码生成',8,'com.zhijian.generator.controller.GenController.batchGenCode()','GET',1,'admin',NULL,'/tool/gen/batchGenCode','127.0.0.1','内网IP','{\"tables\":\"sys_oss\"}',NULL,0,NULL,'2024-01-15 15:25:45',417),(51,'商品管理',1,'com.qihang.erp.api.controller.GoodsController.add()','POST',1,'admin',NULL,'/goods/goods','127.0.0.1','内网IP','{\"categoryId\":2,\"colorImages\":{\"412\":\"http://localhost:8080/preview/images/49\",\"413\":\"http://localhost:8080/preview/images/48\"},\"colorNames\":{\"412\":\"复古蓝加绒\",\"413\":\"浅蓝色加绒\"},\"colorValues\":[413,412],\"createBy\":\"admin\",\"image\":\"http://localhost:8080/preview/images/47\",\"name\":\"测试测试\",\"number\":\"A0012D\",\"params\":{},\"purPrice\":12,\"sizeValues\":[408,407],\"specList\":[{\"colorId\":413,\"colorValue\":\"浅蓝色加绒\",\"sizeId\":408,\"sizeValue\":\"32\",\"specNum\":\"A0012D15032\",\"styleValue\":\"\"},{\"colorId\":413,\"colorValue\":\"浅蓝色加绒\",\"sizeId\":407,\"sizeValue\":\"31\",\"specNum\":\"A0012D15031\",\"styleValue\":\"\"},{\"colorId\":412,\"colorValue\":\"复古蓝加绒\",\"sizeId\":408,\"sizeValue\":\"32\",\"specNum\":\"A0012D14032\",\"styleValue\":\"\"},{\"colorId\":412,\"colorValue\":\"复古蓝加绒\",\"sizeId\":407,\"sizeValue\":\"31\",\"specNum\":\"A0012D14031\",\"styleValue\":\"\"}],\"supplierId\":33}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-01-16 10:29:29',127497),(52,'商品管理',1,'com.qihang.erp.api.controller.GoodsController.add()','POST',1,'admin',NULL,'/goods/goods','127.0.0.1','内网IP','{\"categoryId\":2,\"colorImages\":{\"412\":\"http://localhost:8080/preview/images/49\",\"413\":\"http://localhost:8080/preview/images/48\"},\"colorValues\":[413,412],\"createBy\":\"admin\",\"createTime\":\"2024-01-16 10:34:33\",\"id\":74,\"image\":\"http://localhost:8080/preview/images/47\",\"name\":\"测试测试\",\"number\":\"A0012D\",\"params\":{},\"purPrice\":12,\"sizeValues\":[408,407],\"specList\":[{\"colorId\":413,\"colorValue\":\"浅蓝色加绒\",\"sizeId\":408,\"sizeValue\":\"32\",\"specNum\":\"A0012D15032\",\"styleValue\":\"\"},{\"colorId\":413,\"colorValue\":\"浅蓝色加绒\",\"sizeId\":407,\"sizeValue\":\"31\",\"specNum\":\"A0012D15031\",\"styleValue\":\"\"},{\"colorId\":412,\"colorValue\":\"复古蓝加绒\",\"sizeId\":408,\"sizeValue\":\"32\",\"specNum\":\"A0012D14032\",\"styleValue\":\"\"},{\"colorId\":412,\"colorValue\":\"复古蓝加绒\",\"sizeId\":407,\"sizeValue\":\"31\",\"specNum\":\"A0012D14031\",\"styleValue\":\"\"}],\"supplierId\":33}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-01-16 10:34:33',262),(53,'菜单管理',2,'com.zhijian.web.controller.system.SysMenuController.edit()','PUT',1,'admin',NULL,'/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"\",\"createTime\":\"2023-12-27 15:00:27\",\"icon\":\"tool\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":3,\"menuName\":\"系统工具\",\"menuType\":\"M\",\"orderNum\":101,\"params\":{},\"parentId\":0,\"path\":\"tool\",\"perms\":\"\",\"query\":\"\",\"status\":\"1\",\"updateBy\":\"admin\",\"visible\":\"1\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-01-16 10:44:35',314),(54,'菜单管理',2,'com.zhijian.web.controller.system.SysMenuController.edit()','PUT',1,'admin',NULL,'/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"\",\"createTime\":\"2023-12-27 15:00:27\",\"icon\":\"tool\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":3,\"menuName\":\"系统工具\",\"menuType\":\"M\",\"orderNum\":101,\"params\":{},\"parentId\":0,\"path\":\"tool\",\"perms\":\"\",\"query\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"1\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-01-16 10:45:25',26),(55,'淘宝订单',2,'com.qihang.erp.api.controller.TaoOrderController.confirmOrder()','POST',1,'admin',NULL,'/tao/order/confirmOrder','127.0.0.1','内网IP','{\"address\":\"吉林吉林省松原市扶余市 三井子镇 里\",\"auditStatus\":0,\"auditTime\":\"2022-07-31\",\"buyerName\":\"\",\"city\":\"\",\"closeReason\":\"\",\"createTime\":\"2022-07-31 18:13:59\",\"discountAmount\":0,\"discountRemark\":\"\",\"id\":\"1631273557325601885\",\"isMerge\":0,\"logisticsCode\":\"432700565699461\",\"logisticsCompany\":\"韵达速递\",\"orderCreateTime\":\"2022-07-31\",\"orderModifyTime\":\"2022-07-31\",\"orderSource\":0,\"params\":{},\"payAmount\":28.9,\"payTime\":\"2022-07-31\",\"phone\":\"18704389133\",\"province\":\"吉林\",\"receiver\":\"王淑芳\",\"sellerMemo\":\"\",\"sendStatus\":0,\"sendTime\":\"2022-07-31\",\"shipType\":0,\"shippingFee\":0,\"shopId\":6,\"status\":3,\"statusStr\":\"等待买家确认收货\",\"taoOrderItemList\":[],\"totalAmount\":28.9,\"updateBy\":\"admin\",\"updateTime\":\"2022-07-31 19:55:48\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-01-16 13:44:26',127),(56,'仓库订单发货',1,'com.qihang.erp.api.controller.WmsOrderShippingController.stockingAdd()','POST',1,'admin',NULL,'/wms/shipping/stockingAdd','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"createTime\":\"2024-01-16 14:10:02.57\",\"ids\":[11],\"stockOutNum\":\"202401161410022\"}','{\"msg\":\"商品库存不足！\",\"code\":503}',0,NULL,'2024-01-16 14:10:05',39),(57,'代码生成',6,'com.zhijian.generator.controller.GenController.importTableSave()','POST',1,'admin',NULL,'/tool/gen/importTable','127.0.0.1','内网IP','{\"tables\":\"erp_goods_spec\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-01-16 14:12:38',220),(58,'代码生成',2,'com.zhijian.generator.controller.GenController.editSave()','PUT',1,'admin',NULL,'/tool/gen','127.0.0.1','内网IP','{\"businessName\":\"goodsSpec\",\"className\":\"ErpGoodsSpec\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"主键id\",\"columnId\":1205,\"columnName\":\"id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2024-01-16 14:12:38\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":54,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"GoodsId\",\"columnComment\":\"商品id\",\"columnId\":1206,\"columnName\":\"goods_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2024-01-16 14:12:38\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"goodsId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":54,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"SpecName\",\"columnComment\":\"规格名\",\"columnId\":1207,\"columnName\":\"spec_name\",\"columnType\":\"varchar(50)\",\"createBy\":\"admin\",\"createTime\":\"2024-01-16 14:12:38\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"specName\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":54,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"SpecNum\",\"columnComment\":\"规格编码\",\"columnId\":1208,\"columnName\":\"spec_num\",\"columnType\":\"varchar(25)\",\"createBy\":\"admin\",\"createTime\":\"2024-01-16 14:12:38\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"specNum\",\"javaType\":\"St','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-01-16 14:12:56',122),(59,'代码生成',8,'com.zhijian.generator.controller.GenController.batchGenCode()','GET',1,'admin',NULL,'/tool/gen/batchGenCode','127.0.0.1','内网IP','{\"tables\":\"erp_goods_spec\"}',NULL,0,NULL,'2024-01-16 14:13:01',653),(60,'菜单管理',1,'com.zhijian.web.controller.system.SysMenuController.add()','POST',1,'admin',NULL,'/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"goods/spec\",\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"商品规格查询\",\"menuType\":\"C\",\"orderNum\":3,\"params\":{},\"parentId\":2006,\"path\":\"spec_list\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-01-16 14:17:39',29),(61,'菜单管理',2,'com.zhijian.web.controller.system.SysMenuController.edit()','PUT',1,'admin',NULL,'/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"goods/spec\",\"createTime\":\"2024-01-16 14:17:39\",\"icon\":\"theme\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2067,\"menuName\":\"商品规格查询\",\"menuType\":\"C\",\"orderNum\":3,\"params\":{},\"parentId\":2006,\"path\":\"spec_list\",\"perms\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-01-16 14:18:10',13),(62,'采购订单',1,'com.qihang.erp.api.controller.ScmPurchaseOrderController.add()','POST',1,'admin',NULL,'/purchase/purchaseOrder','127.0.0.1','内网IP','{\"contactId\":33,\"createBy\":\"admin\",\"goodsList\":[{\"amount\":190,\"colorImage\":\"https://cbu01.alicdn.com/img/ibank/O1CN01AfNgvA2FOyAvwXZxv_!!2208857268871-0-cib.jpg\",\"colorValue\":\"黑色\",\"goodsId\":9,\"id\":32,\"name\":\"HN8026牛仔短裤\",\"number\":\"HN8026\",\"purPrice\":19,\"qty\":10,\"sizeValue\":\"2XL\",\"specNum\":\"2720210080260105\",\"styleValue\":\"\"}],\"orderAmount\":190,\"orderDate\":\"2024-01-16 00:00:00\",\"params\":{}}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-01-16 14:44:08',86),(63,'采购订单',2,'com.qihang.erp.api.controller.ScmPurchaseOrderController.edit()','PUT',1,'admin',NULL,'/purchase/purchaseOrder','127.0.0.1','内网IP','{\"auditUser\":\"启航\",\"id\":466,\"optionType\":\"audit\",\"updateBy\":\"admin\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-01-16 14:44:21',14),(64,'采购订单',2,'com.qihang.erp.api.controller.ScmPurchaseOrderController.edit()','PUT',1,'admin',NULL,'/purchase/purchaseOrder','127.0.0.1','内网IP','{\"auditUser\":\"启航\",\"confirmUser\":\"启航\",\"id\":466,\"optionType\":\"confirm\",\"totalAmount\":190,\"updateBy\":\"admin\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-01-16 14:44:30',48),(65,'采购订单',2,'com.qihang.erp.api.controller.ScmPurchaseOrderController.edit()','PUT',1,'admin',NULL,'/purchase/purchaseOrder','127.0.0.1','内网IP','{\"auditUser\":\"启航\",\"id\":466,\"optionType\":\"SupplierShip\",\"shipCompany\":\"菜鸟速递\",\"shipCost\":0,\"shipNo\":\"CN223533300022\",\"supplierDeliveryTime\":\"2024-01-16 00:00:00\",\"updateBy\":\"admin\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-01-16 14:49:49',24),(66,'采购订单物流',2,'com.qihang.erp.api.controller.ScmPurchaseOrderShipController.confirmReceipt()','PUT',1,'admin',NULL,'/purchase/PurchaseOrderShip','127.0.0.1','内网IP','{\"backCount\":0,\"createBy\":\"admin\",\"createTime\":\"2024-01-16 14:49:49\",\"freight\":0,\"id\":466,\"orderDate\":\"2024-01-16\",\"orderGoodsUnit\":1,\"orderNo\":\"PUR20240116144408\",\"orderSpecUnit\":1,\"orderSpecUnitTotal\":10,\"params\":{},\"receiptTime\":\"2024-01-16 00:00:00\",\"shipCompany\":\"菜鸟速递\",\"shipNo\":\"CN223533300022\",\"shipTime\":\"2024-01-16\",\"status\":0,\"stockInCount\":0,\"updateBy\":\"admin\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-01-16 14:50:46',16),(67,'采购订单物流',2,'com.qihang.erp.api.controller.ScmPurchaseOrderShipController.createStockInEntry()','POST',1,'admin',NULL,'/purchase/PurchaseOrderShip/createStockInEntry','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"createTime\":\"2024-01-16 14:44:09\",\"goodsList\":[{\"colorImage\":\"https://cbu01.alicdn.com/img/ibank/O1CN01AfNgvA2FOyAvwXZxv_!!2208857268871-0-cib.jpg\",\"colorValue\":\"黑色\",\"goodsId\":9,\"goodsName\":\"HN8026牛仔短裤\",\"goodsNum\":\"HN8026\",\"id\":1962,\"inQty\":10,\"orderId\":466,\"params\":{},\"quantity\":10,\"remark\":\"\",\"sizeValue\":\"2XL\",\"specId\":32,\"specNum\":\"2720210080260105\",\"styleValue\":\"\"}],\"id\":466,\"params\":{},\"updateBy\":\"admin\",\"updateTime\":\"2024-01-16 14:50:46\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-01-16 14:50:57',39),(68,'入库单',2,'com.qihang.erp.api.controller.WmsStockInEntryController.stockIn()','POST',1,'admin',NULL,'/wms/WmsStockInEntry/stockIn','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"createTime\":\"2024-01-16 14:50:58\",\"id\":8,\"no\":\"20240116145057\",\"params\":{},\"sourceGoodsUnit\":1,\"sourceId\":466,\"sourceNo\":\"PUR20240116144408\",\"sourceSpecUnit\":1,\"sourceSpecUnitTotal\":10,\"sourceType\":1,\"status\":0,\"stockInOperator\":\"启航\",\"stockInOperatorId\":1,\"stockInTime\":\"2024-01-16 00:00:00\",\"updateBy\":\"admin\",\"wmsStockInEntryItemList\":[{\"colorImage\":\"https://cbu01.alicdn.com/img/ibank/O1CN01AfNgvA2FOyAvwXZxv_!!2208857268871-0-cib.jpg\",\"colorValue\":\"黑色\",\"createBy\":\"admin\",\"createTime\":\"2024-01-16 14:50:58\",\"entryId\":8,\"goodsId\":9,\"goodsName\":\"HN8026牛仔短裤\",\"goodsNum\":\"HN8026\",\"id\":4,\"inQuantity\":0,\"locationId\":20,\"locationNum\":\"A01-1-16\",\"originalQuantity\":10,\"params\":{},\"quantity\":10,\"remark\":\"\",\"sizeValue\":\"2XL\",\"sourceId\":466,\"sourceItemId\":1962,\"sourceType\":1,\"specId\":32,\"specNum\":\"2720210080260105\",\"status\":0,\"styleValue\":\"\",\"totalQuantity\":10}]}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-01-16 14:51:50',42),(69,'仓库订单发货',1,'com.qihang.erp.api.controller.WmsOrderShippingController.stockingAdd()','POST',1,'admin',NULL,'/wms/shipping/stockingAdd','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"createTime\":\"2024-01-16 14:52:27.889\",\"ids\":[11],\"stockOutNum\":\"202401161452276\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-01-16 14:52:29',30),(70,'出库单',1,'com.qihang.erp.api.controller.WmsStockOutEntryController.stockOut()','POST',1,'admin',NULL,'/wms/stockOutEntry/stockOut','127.0.0.1','内网IP','{\"entryId\":2,\"entryItemId\":8,\"inventoryDetailId\":7,\"operatorId\":1,\"operatorName\":\"admin\",\"outQty\":1,\"specId\":32}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-01-16 14:52:43',45),(71,'出库单',1,'com.qihang.erp.api.controller.WmsStockOutEntryController.stockOut()','POST',1,'admin',NULL,'/wms/stockOutEntry/stockOut','127.0.0.1','内网IP','{\"entryId\":2,\"entryItemId\":8,\"inventoryDetailId\":7,\"operatorId\":1,\"operatorName\":\"admin\",\"outQty\":1,\"specId\":32}','{\"msg\":\"状态错误！\",\"code\":502}',0,NULL,'2024-01-16 14:53:11',8),(72,'淘宝订单',2,'com.qihang.erp.api.controller.TaoOrderController.confirmOrder()','POST',1,'admin',NULL,'/tao/order/confirmOrder','127.0.0.1','内网IP','{\"address\":\"上海上海 上海市 徐汇区 天平路街道 建国西路382号三楼4室 \",\"auditStatus\":0,\"auditTime\":\"2022-08-13\",\"buyerName\":\"\",\"city\":\"\",\"closeReason\":\"\",\"createTime\":\"2022-08-13 19:09:13\",\"discountAmount\":0,\"discountRemark\":\"\",\"id\":\"1642473483353670599\",\"isMerge\":0,\"logisticsCode\":\"432723807526979\",\"logisticsCompany\":\"韵达速递\",\"orderCreateTime\":\"2022-08-13\",\"orderModifyTime\":\"2022-08-13\",\"orderSource\":0,\"params\":{},\"payAmount\":29.92,\"payTime\":\"2022-08-13\",\"phone\":\"17321293202\",\"province\":\"上海\",\"receiver\":\"戴志兰\",\"sellerMemo\":\"\",\"sendStatus\":0,\"sendTime\":\"2022-08-13\",\"shipType\":0,\"shippingFee\":0,\"shopId\":6,\"status\":3,\"statusStr\":\"等待买家确认收货\",\"taoOrderItemList\":[],\"totalAmount\":29.92,\"updateBy\":\"admin\",\"updateTime\":\"2022-08-13 21:23:33\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-01-16 15:04:52',73),(73,'仓库订单发货',1,'com.qihang.erp.api.controller.WmsOrderShippingController.stockingAdd()','POST',1,'admin',NULL,'/wms/shipping/stockingAdd','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"createTime\":\"2024-01-16 15:04:59.9\",\"ids\":[12],\"stockOutNum\":\"202401161504597\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-01-16 15:05:01',14),(74,'出库单',1,'com.qihang.erp.api.controller.WmsStockOutEntryController.stockOut()','POST',1,'admin',NULL,'/wms/stockOutEntry/stockOut','127.0.0.1','内网IP','{\"entryId\":3,\"entryItemId\":9,\"inventoryDetailId\":7,\"operatorId\":1,\"operatorName\":\"admin\",\"outQty\":1,\"specId\":32}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-01-16 15:06:05',43952),(75,'菜单管理',2,'com.zhijian.web.controller.system.SysMenuController.edit()','PUT',1,'admin',NULL,'/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"bill/orderShipCost\",\"createTime\":\"2024-01-12 18:35:31\",\"icon\":\"guide\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2063,\"menuName\":\"发货物流账单\",\"menuType\":\"C\",\"orderNum\":3,\"params\":{},\"parentId\":2018,\"path\":\"orderShipCost\",\"perms\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-01-16 15:28:42',33),(76,'菜单管理',2,'com.zhijian.web.controller.system.SysMenuController.edit()','PUT',1,'admin',NULL,'/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createTime\":\"2024-01-12 18:35:55\",\"icon\":\"example\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2064,\"menuName\":\"店铺账单管理\",\"menuType\":\"M\",\"orderNum\":4,\"params\":{},\"parentId\":2018,\"path\":\"s\",\"perms\":\"\",\"status\":\"1\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-01-16 15:28:47',12),(77,'菜单管理',2,'com.zhijian.web.controller.system.SysMenuController.edit()','PUT',1,'admin',NULL,'/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createTime\":\"2024-01-12 18:35:02\",\"icon\":\"theme\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2062,\"menuName\":\"代发账单管理\",\"menuType\":\"C\",\"orderNum\":2,\"params\":{},\"parentId\":2018,\"path\":\"d\",\"perms\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-01-16 15:29:08',13),(78,'店铺订单',2,'com.qihang.erp.api.controller.ErpOrderController.ship()','POST',1,'admin',NULL,'/api/order/ship','127.0.0.1','内网IP','{\"address\":\"上海上海 上海市 徐汇区 天平路街道 建国西路382号三楼4室 \",\"amount\":29.92,\"city\":\"\",\"confirmTime\":\"2024-01-16\",\"country\":\"中国\",\"createBy\":\"admin\",\"createTime\":\"2024-01-16 15:04:52\",\"discountAmount\":0,\"erpOrderItemList\":[{\"createBy\":\"admin\",\"createTime\":\"2024-01-16 15:04:52\",\"goodsId\":9,\"goodsImg\":\"https://cbu01.alicdn.com/img/ibank/O1CN01AfNgvA2FOyAvwXZxv_!!2208857268871-0-cib.jpg\",\"goodsNum\":\"272021008026\",\"goodsPrice\":29.92,\"goodsSpec\":\"黑色,2XL\",\"goodsTitle\":\"8026牛仔短裤\",\"id\":13,\"isGift\":0,\"itemAmount\":29.92,\"orderId\":16,\"orderItemNum\":\"1642473483353670599\",\"params\":{},\"quantity\":1,\"refundCount\":0,\"refundStatus\":1,\"specId\":32,\"specNum\":\"2720210080260105\",\"supplierId\":26}],\"goodsAmount\":29.92,\"height\":19.0,\"id\":16,\"length\":20.0,\"orderNum\":\"1642473483353670599\",\"orderStatus\":2,\"params\":{},\"payTime\":\"2022-08-13\",\"postage\":0,\"province\":\"上海\",\"receiverName\":\"戴志兰\",\"receiverPhone\":\"17321293202\",\"refundStatus\":1,\"shipType\":0,\"shippingCompany\":\"菜鸟速递\",\"shippingCost\":3,\"shippingMan\":\"启航\",\"shippingNumber\":\"CN2210003552\",\"shopId\":6,\"shopType\":4,\"town\":\"\",\"updateBy\":\"admin\",\"updateTime\":\"2024-01-16 15:05:56\",\"weight\":409.0,\"width\":56.0}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-01-16 15:42:53',17950),(79,'代码生成',6,'com.zhijian.generator.controller.GenController.importTableSave()','POST',1,'admin',NULL,'/tool/gen/importTable','127.0.0.1','内网IP','{\"tables\":\"s_shop_setting\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-01-18 17:42:22',344),(80,'代码生成',2,'com.zhijian.generator.controller.GenController.editSave()','PUT',1,'admin',NULL,'/tool/gen','127.0.0.1','内网IP','{\"businessName\":\"shopSetting\",\"className\":\"ShopSetting\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"主键\",\"columnId\":1226,\"columnName\":\"id\",\"columnType\":\"int\",\"createBy\":\"admin\",\"createTime\":\"2024-01-18 17:42:22\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isPk\":\"1\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":55,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Name\",\"columnComment\":\"配置名\",\"columnId\":1227,\"columnName\":\"name\",\"columnType\":\"varchar(50)\",\"createBy\":\"admin\",\"createTime\":\"2024-01-18 17:42:22\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"name\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":55,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"AppKey\",\"columnComment\":\"appKey\",\"columnId\":1228,\"columnName\":\"app_key\",\"columnType\":\"varchar(50)\",\"createBy\":\"admin\",\"createTime\":\"2024-01-18 17:42:22\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"appKey\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":55,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"AppSecret\",\"columnComment\":\"appSecret\",\"columnId\":1229,\"columnName\":\"app_secret\",\"columnType\":\"varchar(50)\",\"createBy\":\"admin\",\"createTime\":\"2024-01-18 17:42:22\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"appSecre','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-01-18 17:43:02',109),(81,'代码生成',8,'com.zhijian.generator.controller.GenController.batchGenCode()','GET',1,'admin',NULL,'/tool/gen/batchGenCode','127.0.0.1','内网IP','{\"tables\":\"s_shop_setting\"}',NULL,0,NULL,'2024-01-18 17:43:15',534),(82,'店铺',2,'com.qihang.erp.api.controller.ShopController.edit()','PUT',1,'admin',NULL,'/shop/shop','127.0.0.1','内网IP','{\"appSercet\":\"\",\"appkey\":\"\",\"company\":\"华衣云商\",\"ename\":\"douyin\",\"id\":22,\"isDelete\":0,\"isShow\":1,\"modifyOn\":1653672695,\"name\":\"梦小妮牛仔裤\",\"nickName\":\"抖音-梦小妮\",\"orderNum\":87,\"params\":{},\"sellerUserId\":0,\"sellerUserIdStr\":\"0\",\"sessionKey\":\"\",\"type\":6,\"url\":\"http://openapi.jinritemai.com\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-01-18 19:46:21',21),(83,'店铺',2,'com.qihang.erp.api.controller.ShopController.edit()','PUT',1,'admin',NULL,'/shop/shop','127.0.0.1','内网IP','{\"apiRequestUrl\":\"http://gw.api.taobao.com/router/rest\",\"appSercet\":\"7b0769269b0c0ca88949791c14eb3a5c\",\"appkey\":\"31014100\",\"company\":\"煜梦服饰\",\"ename\":\"taobao\",\"id\":6,\"isDelete\":0,\"isShow\":1,\"modifyOn\":0,\"name\":\"梦小妮牛仔裤\",\"nickName\":\"淘宝-梦小妮\",\"orderNum\":98,\"params\":{},\"remark\":\"\",\"sellerUserId\":2200787809358,\"sellerUserIdStr\":\"0\",\"sessionKey\":\"610140071d1070a37cecea89f1c1f3d6e5d19bf4b58dd942200787809358\",\"type\":4,\"url\":\"\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-01-18 19:56:00',28),(84,'店铺',2,'com.qihang.erp.api.controller.ShopController.edit()','PUT',1,'admin',NULL,'/shop/shop','127.0.0.1','内网IP','{\"apiRequestUrl\":\"http://gw.api.taobao.com/router/rest\",\"appSercet\":\"7b0769269b0c0ca88949791c14eb3a5c\",\"appkey\":\"31014100\",\"company\":\"煜梦服饰\",\"ename\":\"taobao\",\"id\":6,\"isDelete\":0,\"isShow\":1,\"modifyOn\":0,\"name\":\"梦小妮牛仔裤\",\"nickName\":\"淘宝-梦小妮\",\"orderNum\":98,\"params\":{},\"remark\":\"\",\"sellerUserId\":2200787809358,\"sellerUserIdStr\":\"0\",\"sessionKey\":\"610140071d1070a37cecea89f1c1f3d6e5d19bf4b58dd942200787809358\",\"type\":4,\"url\":\"\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-01-18 19:57:45',27),(85,'菜单管理',2,'com.zhijian.web.controller.system.SysMenuController.edit()','PUT',1,'admin',NULL,'/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"\",\"createTime\":\"2023-12-29 17:07:23\",\"icon\":\"money\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2018,\"menuName\":\"财务管理\",\"menuType\":\"M\",\"orderNum\":6,\"params\":{},\"parentId\":0,\"path\":\"fms\",\"perms\":\"\",\"query\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-01-28 11:21:32',18),(86,'菜单管理',2,'com.zhijian.web.controller.system.SysMenuController.edit()','PUT',1,'admin',NULL,'/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"scm/purchase/cost\",\"createTime\":\"2023-12-29 17:09:32\",\"icon\":\"shopping\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2019,\"menuName\":\"采购账单管理\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2018,\"path\":\"purchase\",\"perms\":\"\",\"query\":\"\",\"status\":\"1\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-01-28 11:22:15',10),(87,'菜单管理',1,'com.zhijian.web.controller.system.SysMenuController.add()','POST',1,'admin',NULL,'/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createBy\":\"admin\",\"icon\":\"example\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"应收管理\",\"menuType\":\"M\",\"orderNum\":1,\"params\":{},\"parentId\":2018,\"path\":\"receivable\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-01-28 11:23:36',10),(88,'菜单管理',1,'com.zhijian.web.controller.system.SysMenuController.add()','POST',1,'admin',NULL,'/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createBy\":\"admin\",\"icon\":\"checkbox\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"商品销售收入\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2068,\"path\":\"order\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-01-28 11:24:35',9),(89,'菜单管理',2,'com.zhijian.web.controller.system.SysMenuController.edit()','PUT',1,'admin',NULL,'/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createTime\":\"2024-01-28 11:24:35\",\"icon\":\"checkbox\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2069,\"menuName\":\"订单应收\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2068,\"path\":\"order\",\"perms\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-01-28 11:25:16',10),(90,'菜单管理',1,'com.zhijian.web.controller.system.SysMenuController.add()','POST',1,'admin',NULL,'/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createBy\":\"admin\",\"icon\":\"bug\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"退款款项\",\"menuType\":\"M\",\"orderNum\":2,\"params\":{},\"parentId\":2068,\"path\":\"refund\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-01-28 11:26:55',7),(91,'菜单管理',2,'com.zhijian.web.controller.system.SysMenuController.edit()','PUT',1,'admin',NULL,'/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createTime\":\"2024-01-28 11:24:35\",\"icon\":\"checkbox\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2069,\"menuName\":\"订单收入\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2068,\"path\":\"order\",\"perms\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-01-28 11:27:25',11),(92,'菜单管理',1,'com.zhijian.web.controller.system.SysMenuController.add()','POST',1,'admin',NULL,'/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createBy\":\"admin\",\"icon\":\"cascader\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"平台服务费\",\"menuType\":\"M\",\"orderNum\":3,\"params\":{},\"parentId\":2068,\"path\":\"service_fee\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-01-28 11:28:03',8),(93,'菜单管理',1,'com.zhijian.web.controller.system.SysMenuController.add()','POST',1,'admin',NULL,'/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createBy\":\"admin\",\"icon\":\"clipboard\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"应付管理\",\"menuType\":\"M\",\"orderNum\":2,\"params\":{},\"parentId\":2018,\"path\":\"payable\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-01-28 11:29:21',7),(94,'菜单管理',2,'com.zhijian.web.controller.system.SysMenuController.edit()','PUT',1,'admin',NULL,'/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createTime\":\"2024-01-12 18:35:02\",\"icon\":\"theme\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2062,\"menuName\":\"代发账单\",\"menuType\":\"C\",\"orderNum\":2,\"params\":{},\"parentId\":2072,\"path\":\"d\",\"perms\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-01-28 11:29:56',9),(95,'菜单管理',1,'com.zhijian.web.controller.system.SysMenuController.add()','POST',1,'admin',NULL,'/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createBy\":\"admin\",\"icon\":\"component\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"采购应付\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2072,\"path\":\"purchase\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-01-28 11:30:49',23),(96,'菜单管理',2,'com.zhijian.web.controller.system.SysMenuController.edit()','PUT',1,'admin',NULL,'/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"bill/orderShipCost\",\"createTime\":\"2024-01-12 18:35:31\",\"icon\":\"guide\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2063,\"menuName\":\"物流费用\",\"menuType\":\"C\",\"orderNum\":3,\"params\":{},\"parentId\":2072,\"path\":\"orderShipCost\",\"perms\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-01-28 11:31:38',9),(97,'菜单管理',1,'com.zhijian.web.controller.system.SysMenuController.add()','POST',1,'admin',NULL,'/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createBy\":\"admin\",\"icon\":\"cascader\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"采购退货\",\"menuType\":\"C\",\"orderNum\":2,\"params\":{},\"parentId\":2072,\"path\":\"return\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-01-28 11:32:21',9),(98,'菜单管理',2,'com.zhijian.web.controller.system.SysMenuController.edit()','PUT',1,'admin',NULL,'/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createTime\":\"2024-01-12 18:35:02\",\"icon\":\"theme\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2062,\"menuName\":\"代发账单\",\"menuType\":\"C\",\"orderNum\":3,\"params\":{},\"parentId\":2072,\"path\":\"daifa\",\"perms\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-01-28 11:32:39',8),(99,'菜单管理',2,'com.zhijian.web.controller.system.SysMenuController.edit()','PUT',1,'admin',NULL,'/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"bill/orderShipCost\",\"createTime\":\"2024-01-12 18:35:31\",\"icon\":\"guide\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2063,\"menuName\":\"物流费用\",\"menuType\":\"C\",\"orderNum\":3,\"params\":{},\"parentId\":2072,\"path\":\"shipCost\",\"perms\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-01-28 11:32:53',8),(100,'菜单管理',1,'com.zhijian.web.controller.system.SysMenuController.add()','POST',1,'admin',NULL,'/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createBy\":\"admin\",\"icon\":\"cascader\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"营销费用\",\"menuType\":\"C\",\"orderNum\":5,\"params\":{},\"parentId\":2072,\"path\":\"market_fee\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-01-28 11:33:37',10),(101,'菜单管理',1,'com.zhijian.web.controller.system.SysMenuController.add()','POST',1,'admin',NULL,'/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createBy\":\"admin\",\"icon\":\"clipboard\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"其他费用\",\"menuType\":\"C\",\"orderNum\":6,\"params\":{},\"parentId\":2072,\"path\":\"other_fee\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-01-28 11:34:01',6),(102,'菜单管理',1,'com.zhijian.web.controller.system.SysMenuController.add()','POST',1,'admin',NULL,'/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createBy\":\"admin\",\"icon\":\"druid\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"存货报表\",\"menuType\":\"C\",\"orderNum\":3,\"params\":{},\"parentId\":2018,\"path\":\"inventory_report\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-01-28 11:36:05',9),(103,'采购订单',1,'com.qihang.erp.api.controller.ScmPurchaseOrderController.add()','POST',1,'admin',NULL,'/purchase/purchaseOrder','127.0.0.1','内网IP','{\"contactId\":33,\"createBy\":\"admin\",\"goodsList\":[{\"amount\":42,\"colorImage\":\"https://cbu01.alicdn.com/img/ibank/O1CN01yp4pfJ2FOyGRQhOVF_!!2208857268871-0-cib.jpg\",\"colorValue\":\"浅蓝色\",\"goodsId\":29,\"id\":438,\"name\":\"HNP182弹力紧身贴标牛仔短裤女ins\",\"number\":\"HNP182\",\"purPrice\":21,\"qty\":2,\"sizeValue\":\"XL\",\"specNum\":\"HNP1825004\",\"styleValue\":\"\"}],\"orderAmount\":42,\"orderDate\":\"2024-01-28 00:00:00\",\"params\":{}}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-01-28 11:36:56',30),(104,'采购订单',2,'com.qihang.erp.api.controller.ScmPurchaseOrderController.edit()','PUT',1,'admin',NULL,'/purchase/purchaseOrder','127.0.0.1','内网IP','{\"auditUser\":\"启航\",\"id\":467,\"optionType\":\"audit\",\"updateBy\":\"admin\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-01-28 11:37:11',11),(105,'采购订单',2,'com.qihang.erp.api.controller.ScmPurchaseOrderController.edit()','PUT',1,'admin',NULL,'/purchase/purchaseOrder','127.0.0.1','内网IP','{\"auditUser\":\"启航\",\"confirmUser\":\"启航\",\"id\":467,\"optionType\":\"confirm\",\"totalAmount\":42,\"updateBy\":\"admin\"}',NULL,1,'\r\n### Error updating database.  Cause: java.sql.SQLSyntaxErrorException: Table \'qihang-erp.scm_purchase_order_cost\' doesn\'t exist\r\n### The error may exist in file [D:\\projects\\qihang.ecom.erp\\ecerp-api\\target\\classes\\mapper\\api\\ScmPurchaseOrderCostMapper.xml]\r\n### The error may involve com.qihang.erp.api.mapper.ScmPurchaseOrderCostMapper.insertScmPurchaseOrderCost-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into scm_purchase_order_cost          ( id,             order_amount,             order_date,             order_no,             order_spec_unit,             order_goods_unit,             order_spec_unit_total,             actual_amount,             freight,             confirm_user,             confirm_time,             create_by,             pay_amount,                          pay_count,                          status )           values ( ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,                          ?,                          ? )\r\n### Cause: java.sql.SQLSyntaxErrorException: Table \'qihang-erp.scm_purchase_order_cost\' doesn\'t exist\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: Table \'qihang-erp.scm_purchase_order_cost\' doesn\'t exist','2024-01-28 11:37:18',14),(106,'采购订单',2,'com.qihang.erp.api.controller.ScmPurchaseOrderController.edit()','PUT',1,'admin',NULL,'/purchase/purchaseOrder','127.0.0.1','内网IP','{\"auditUser\":\"启航\",\"confirmUser\":\"启航\",\"id\":467,\"optionType\":\"confirm\",\"totalAmount\":42,\"updateBy\":\"admin\"}',NULL,1,'\r\n### Error updating database.  Cause: java.sql.SQLSyntaxErrorException: Table \'qihang-erp.scm_purchase_order_cost\' doesn\'t exist\r\n### The error may exist in file [D:\\projects\\qihang.ecom.erp\\ecerp-api\\target\\classes\\mapper\\api\\ScmPurchaseOrderCostMapper.xml]\r\n### The error may involve com.qihang.erp.api.mapper.ScmPurchaseOrderCostMapper.insertScmPurchaseOrderCost-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into scm_purchase_order_cost          ( id,             order_amount,             order_date,             order_no,             order_spec_unit,             order_goods_unit,             order_spec_unit_total,             actual_amount,             freight,             confirm_user,             confirm_time,             create_by,             pay_amount,                          pay_count,                          status )           values ( ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,                          ?,                          ? )\r\n### Cause: java.sql.SQLSyntaxErrorException: Table \'qihang-erp.scm_purchase_order_cost\' doesn\'t exist\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: Table \'qihang-erp.scm_purchase_order_cost\' doesn\'t exist','2024-01-28 11:39:26',6),(107,'采购订单',2,'com.qihang.erp.api.controller.ScmPurchaseOrderController.edit()','PUT',1,'admin',NULL,'/purchase/purchaseOrder','127.0.0.1','内网IP','{\"auditUser\":\"启航\",\"confirmUser\":\"启航\",\"id\":467,\"optionType\":\"confirm\",\"totalAmount\":42,\"updateBy\":\"admin\"}',NULL,1,'\r\n### Error updating database.  Cause: java.sql.SQLSyntaxErrorException: Table \'qihang-erp.scm_purchase_order_cost\' doesn\'t exist\r\n### The error may exist in file [D:\\projects\\qihang.ecom.erp\\ecerp-api\\target\\classes\\mapper\\api\\ScmPurchaseOrderCostMapper.xml]\r\n### The error may involve com.qihang.erp.api.mapper.ScmPurchaseOrderCostMapper.insertScmPurchaseOrderCost-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into scm_purchase_order_cost          ( id,             order_amount,             order_date,             order_no,             order_spec_unit,             order_goods_unit,             order_spec_unit_total,             actual_amount,             freight,             confirm_user,             confirm_time,             create_by,             pay_amount,                          pay_count,                          status )           values ( ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,                          ?,                          ? )\r\n### Cause: java.sql.SQLSyntaxErrorException: Table \'qihang-erp.scm_purchase_order_cost\' doesn\'t exist\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: Table \'qihang-erp.scm_purchase_order_cost\' doesn\'t exist','2024-01-28 11:39:48',7),(108,'采购订单',2,'com.qihang.erp.api.controller.ScmPurchaseOrderController.edit()','PUT',1,'admin',NULL,'/purchase/purchaseOrder','127.0.0.1','内网IP','{\"auditUser\":\"启航\",\"confirmUser\":\"启航\",\"id\":467,\"optionType\":\"confirm\",\"totalAmount\":42,\"updateBy\":\"admin\"}',NULL,1,'\r\n### Error updating database.  Cause: java.sql.SQLSyntaxErrorException: Table \'qihang-erp.scm_purchase_order_cost\' doesn\'t exist\r\n### The error may exist in file [D:\\projects\\qihang.ecom.erp\\ecerp-api\\target\\classes\\mapper\\api\\ScmPurchaseOrderCostMapper.xml]\r\n### The error may involve com.qihang.erp.api.mapper.ScmPurchaseOrderCostMapper.insertScmPurchaseOrderCost-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into scm_purchase_order_cost          ( id,             order_amount,             order_date,             order_no,             order_spec_unit,             order_goods_unit,             order_spec_unit_total,             actual_amount,             freight,             confirm_user,             confirm_time,             create_by,             pay_amount,                          pay_count,                          status )           values ( ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,                          ?,                          ? )\r\n### Cause: java.sql.SQLSyntaxErrorException: Table \'qihang-erp.scm_purchase_order_cost\' doesn\'t exist\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: Table \'qihang-erp.scm_purchase_order_cost\' doesn\'t exist','2024-01-28 11:41:41',61065),(109,'采购订单',2,'com.qihang.erp.api.controller.ScmPurchaseOrderController.edit()','PUT',1,'admin',NULL,'/purchase/purchaseOrder','127.0.0.1','内网IP','{\"auditUser\":\"启航\",\"confirmUser\":\"启航\",\"id\":467,\"optionType\":\"confirm\",\"totalAmount\":42,\"updateBy\":\"admin\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-01-28 11:42:19',7648),(110,'采购订单',2,'com.qihang.erp.api.controller.ScmPurchaseOrderController.edit()','PUT',1,'admin',NULL,'/purchase/purchaseOrder','127.0.0.1','内网IP','{\"auditUser\":\"启航\",\"confirmUser\":\"启航\",\"id\":467,\"optionType\":\"SupplierShip\",\"shipCompany\":\"德邦快递\",\"shipCost\":0,\"shipNo\":\"DFB455552202632\",\"supplierDeliveryTime\":\"2024-01-28 00:00:00\",\"totalAmount\":42,\"updateBy\":\"admin\"}',NULL,1,'\r\n### Error updating database.  Cause: java.sql.SQLSyntaxErrorException: Table \'qihang-erp.scm_purchase_order_cost\' doesn\'t exist\r\n### The error may exist in file [D:\\projects\\qihang.ecom.erp\\ecerp-api\\target\\classes\\mapper\\api\\ScmPurchaseOrderCostMapper.xml]\r\n### The error may involve com.qihang.erp.api.mapper.ScmPurchaseOrderCostMapper.updateScmPurchaseOrderCost-Inline\r\n### The error occurred while setting parameters\r\n### SQL: update scm_purchase_order_cost          SET freight = ?          where id = ?\r\n### Cause: java.sql.SQLSyntaxErrorException: Table \'qihang-erp.scm_purchase_order_cost\' doesn\'t exist\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: Table \'qihang-erp.scm_purchase_order_cost\' doesn\'t exist','2024-01-28 11:43:43',39170),(111,'采购订单',2,'com.qihang.erp.api.controller.ScmPurchaseOrderController.edit()','PUT',1,'admin',NULL,'/purchase/purchaseOrder','127.0.0.1','内网IP','{\"auditUser\":\"启航\",\"confirmUser\":\"启航\",\"id\":467,\"optionType\":\"SupplierShip\",\"shipCompany\":\"德邦快递\",\"shipCost\":0,\"shipNo\":\"DFB455552202632\",\"supplierDeliveryTime\":\"2024-01-28 00:00:00\",\"totalAmount\":42,\"updateBy\":\"admin\"}',NULL,1,'\r\n### Error updating database.  Cause: java.sql.SQLSyntaxErrorException: Table \'qihang-erp.scm_purchase_order_cost\' doesn\'t exist\r\n### The error may exist in file [D:\\projects\\qihang.ecom.erp\\ecerp-api\\target\\classes\\mapper\\api\\ScmPurchaseOrderCostMapper.xml]\r\n### The error may involve com.qihang.erp.api.mapper.ScmPurchaseOrderCostMapper.updateScmPurchaseOrderCost-Inline\r\n### The error occurred while setting parameters\r\n### SQL: update scm_purchase_order_cost          SET freight = ?          where id = ?\r\n### Cause: java.sql.SQLSyntaxErrorException: Table \'qihang-erp.scm_purchase_order_cost\' doesn\'t exist\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: Table \'qihang-erp.scm_purchase_order_cost\' doesn\'t exist','2024-01-28 11:43:54',15),(112,'代码生成',6,'com.zhijian.generator.controller.GenController.importTableSave()','POST',1,'admin',NULL,'/tool/gen/importTable','127.0.0.1','内网IP','{\"tables\":\"fms_payable_purchase\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-01-28 11:50:56',66),(113,'代码生成',2,'com.zhijian.generator.controller.GenController.editSave()','PUT',1,'admin',NULL,'/tool/gen','127.0.0.1','内网IP','{\"businessName\":\"payablePurchase\",\"className\":\"FmsPayablePurchase\",\"columns\":[{\"capJavaField\":\"Id\",\"columnId\":1239,\"columnName\":\"id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2024-01-28 11:50:56\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isPk\":\"1\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":56,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"SupplierId\",\"columnComment\":\"供应商id\",\"columnId\":1240,\"columnName\":\"supplier_id\",\"columnType\":\"int\",\"createBy\":\"admin\",\"createTime\":\"2024-01-28 11:50:56\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"supplierId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":56,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"SupplierName\",\"columnComment\":\"供应商名称\",\"columnId\":1241,\"columnName\":\"supplier_name\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2024-01-28 11:50:56\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"supplierName\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":56,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Amount\",\"columnComment\":\"应付金额\",\"columnId\":1242,\"columnName\":\"amount\",\"columnType\":\"decimal(10,2)\",\"createBy\":\"admin\",\"createTime\":\"2024-01-28 11:50:56\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaFiel','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-01-28 11:51:30',34),(114,'代码生成',8,'com.zhijian.generator.controller.GenController.batchGenCode()','GET',1,'admin',NULL,'/tool/gen/batchGenCode','127.0.0.1','内网IP','{\"tables\":\"fms_payable_purchase\"}',NULL,0,NULL,'2024-01-28 11:51:53',337),(115,'菜单管理',2,'com.zhijian.web.controller.system.SysMenuController.edit()','PUT',1,'admin',NULL,'/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"fms/payable/purchase\",\"createTime\":\"2024-01-28 11:30:49\",\"icon\":\"component\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2073,\"menuName\":\"采购应付\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2072,\"path\":\"purchase\",\"perms\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-01-28 11:55:53',15),(116,'采购订单',2,'com.qihang.erp.api.controller.ScmPurchaseOrderController.edit()','PUT',1,'admin',NULL,'/purchase/purchaseOrder','127.0.0.1','内网IP','{\"auditUser\":\"启航\",\"id\":467,\"optionType\":\"SupplierShip\",\"shipCompany\":\"菜鸟速递\",\"shipCost\":10,\"shipNo\":\"CN345565767\",\"supplierDeliveryTime\":\"2024-01-28 00:00:00\",\"updateBy\":\"admin\"}',NULL,1,'\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'id\' doesn\'t have a default value\r\n### The error may exist in file [D:\\projects\\qihang.ecom.erp\\ecerp-api\\target\\classes\\mapper\\fms\\FmsPayablePurchaseMapper.xml]\r\n### The error may involve com.qihang.erp.api.mapper.FmsPayablePurchaseMapper.insertFmsPayablePurchase-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into fms_payable_purchase          ( supplier_id,             supplier_name,             amount,             date,                          purchase_order_no,             purchase_desc,                          status,             create_time,             create_by )           values ( ?,             ?,             ?,             ?,                          ?,             ?,                          ?,             ?,             ? )\r\n### Cause: java.sql.SQLException: Field \'id\' doesn\'t have a default value\n; Field \'id\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'id\' doesn\'t have a default value','2024-01-28 12:07:03',19882),(117,'采购订单',2,'com.qihang.erp.api.controller.ScmPurchaseOrderController.edit()','PUT',1,'admin',NULL,'/purchase/purchaseOrder','127.0.0.1','内网IP','{\"auditUser\":\"启航\",\"id\":467,\"optionType\":\"SupplierShip\",\"shipCompany\":\"菜鸟速递\",\"shipCost\":10,\"shipNo\":\"CN345565767\",\"supplierDeliveryTime\":\"2024-01-28 00:00:00\",\"updateBy\":\"admin\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-01-28 12:07:31',26),(118,'定时任务',2,'com.zhijian.quartz.controller.SysJobController.edit()','PUT',1,'admin',NULL,'/monitor/job','127.0.0.1','内网IP','{\"concurrent\":\"1\",\"createBy\":\"admin\",\"createTime\":\"2023-08-07 19:31:38\",\"cronExpression\":\"0/10 * * * * ?\",\"invokeTarget\":\"ryTask.ryNoParams\",\"jobGroup\":\"DEFAULT\",\"jobId\":1,\"jobName\":\"系统默认（无参）\",\"misfirePolicy\":\"1\",\"nextValidTime\":\"2024-01-28 13:30:00\",\"params\":{},\"remark\":\"\",\"status\":\"0\",\"updateBy\":\"admin\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-01-28 13:29:54',14),(119,'定时任务',2,'com.zhijian.quartz.controller.SysJobController.changeStatus()','PUT',1,'admin',NULL,'/monitor/job/changeStatus','127.0.0.1','内网IP','{\"jobId\":1,\"misfirePolicy\":\"0\",\"params\":{},\"status\":\"1\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-01-28 13:30:18',7),(120,'定时任务',1,'com.zhijian.quartz.controller.SysJobController.add()','POST',1,'admin',NULL,'/monitor/job','127.0.0.1','内网IP','{\"concurrent\":\"1\",\"cronExpression\":\"0/30 * * * * ?\",\"invokeTarget\":\"inventoryReportTask\",\"jobGroup\":\"SYSTEM\",\"jobName\":\"库存存货日报生成\",\"misfirePolicy\":\"1\",\"nextValidTime\":\"2024-01-28 13:33:00\",\"params\":{},\"status\":\"0\"}',NULL,1,'No bean named \'inventoryReportTask\' available','2024-01-28 13:32:30',0),(121,'定时任务',1,'com.zhijian.quartz.controller.SysJobController.add()','POST',1,'admin',NULL,'/monitor/job','127.0.0.1','内网IP','{\"concurrent\":\"1\",\"cronExpression\":\"0/30 * * * * ?\",\"invokeTarget\":\"inventoryReportTask\",\"jobGroup\":\"SYSTEM\",\"jobName\":\"库存存货日报生成\",\"misfirePolicy\":\"1\",\"nextValidTime\":\"2024-01-28 13:34:30\",\"params\":{},\"status\":\"0\"}',NULL,1,'No bean named \'inventoryReportTask\' available','2024-01-28 13:34:11',0),(122,'定时任务',1,'com.zhijian.quartz.controller.SysJobController.add()','POST',1,'admin',NULL,'/monitor/job','127.0.0.1','内网IP','{\"concurrent\":\"1\",\"cronExpression\":\"0/30 * * * * ?\",\"invokeTarget\":\"inventoryReportTask\",\"jobGroup\":\"SYSTEM\",\"jobName\":\"库存存货日报生成\",\"misfirePolicy\":\"1\",\"nextValidTime\":\"2024-01-28 13:36:00\",\"params\":{},\"status\":\"0\"}',NULL,1,'No bean named \'inventoryReportTask\' available','2024-01-28 13:35:34',1),(123,'定时任务',1,'com.zhijian.quartz.controller.SysJobController.add()','POST',1,'admin',NULL,'/monitor/job','127.0.0.1','内网IP','{\"concurrent\":\"1\",\"cronExpression\":\"0/30 * * * * ?\",\"invokeTarget\":\"inventoryReportTask\",\"jobGroup\":\"SYSTEM\",\"jobName\":\"库存存货日报生成\",\"misfirePolicy\":\"1\",\"nextValidTime\":\"2024-01-28 13:36:00\",\"params\":{},\"status\":\"0\"}',NULL,1,'No bean named \'inventoryReportTask\' available','2024-01-28 13:35:44',1),(124,'定时任务',1,'com.zhijian.quartz.controller.SysJobController.add()','POST',1,'admin',NULL,'/monitor/job','127.0.0.1','内网IP','{\"concurrent\":\"1\",\"cronExpression\":\"0/30 * * * * ?\",\"invokeTarget\":\"inventoryReportTask.run()\",\"jobGroup\":\"SYSTEM\",\"jobName\":\"库存存货日报生成\",\"misfirePolicy\":\"1\",\"nextValidTime\":\"2024-01-28 13:40:30\",\"params\":{},\"status\":\"0\"}',NULL,1,'No bean named \'inventoryReportTask\' available','2024-01-28 13:40:24',1),(125,'定时任务',1,'com.zhijian.quartz.controller.SysJobController.add()','POST',1,'admin',NULL,'/monitor/job','127.0.0.1','内网IP','{\"concurrent\":\"1\",\"cronExpression\":\"0/30 * * * * ?\",\"invokeTarget\":\"inventoryReportTask.run()\",\"jobGroup\":\"SYSTEM\",\"jobName\":\"库存存货日报生成\",\"misfirePolicy\":\"1\",\"nextValidTime\":\"2024-01-28 13:42:00\",\"params\":{},\"status\":\"0\"}','{\"msg\":\"新增任务\'库存存货日报生成\'失败，目标字符串不在白名单内\",\"code\":500}',0,NULL,'2024-01-28 13:41:58',7),(126,'定时任务',1,'com.zhijian.quartz.controller.SysJobController.add()','POST',1,'admin',NULL,'/monitor/job','127.0.0.1','内网IP','{\"concurrent\":\"1\",\"createBy\":\"admin\",\"cronExpression\":\"0/30 * * * * ?\",\"invokeTarget\":\"inventoryReportTask.run()\",\"jobGroup\":\"SYSTEM\",\"jobId\":100,\"jobName\":\"库存存货日报生成\",\"misfirePolicy\":\"1\",\"nextValidTime\":\"2024-01-28 13:45:00\",\"params\":{},\"status\":\"1\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-01-28 13:44:43',114),(127,'定时任务',2,'com.zhijian.quartz.controller.SysJobController.changeStatus()','PUT',1,'admin',NULL,'/monitor/job/changeStatus','127.0.0.1','内网IP','{\"jobId\":100,\"misfirePolicy\":\"0\",\"params\":{},\"status\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-01-28 13:44:54',13),(128,'定时任务',2,'com.zhijian.quartz.controller.SysJobController.changeStatus()','PUT',1,'admin',NULL,'/monitor/job/changeStatus','127.0.0.1','内网IP','{\"jobId\":100,\"misfirePolicy\":\"0\",\"params\":{},\"status\":\"1\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-01-28 13:47:14',28),(129,'代码生成',3,'com.zhijian.generator.controller.GenController.remove()','DELETE',1,'admin',NULL,'/tool/gen/52,53,54,55,56','127.0.0.1','内网IP','{}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-01-28 14:33:26',10),(130,'代码生成',6,'com.zhijian.generator.controller.GenController.importTableSave()','POST',1,'admin',NULL,'/tool/gen/importTable','127.0.0.1','内网IP','{\"tables\":\"fms_inventory_report,fms_inventory_report_detail,fms_receivable_order\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-01-28 14:33:45',96),(131,'代码生成',2,'com.zhijian.generator.controller.GenController.editSave()','PUT',1,'admin',NULL,'/tool/gen','127.0.0.1','内网IP','{\"businessName\":\"receivableOrder\",\"className\":\"FmsReceivableOrder\",\"columns\":[{\"capJavaField\":\"Id\",\"columnId\":1275,\"columnName\":\"id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2024-01-28 14:33:45\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":59,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Date\",\"columnComment\":\"日期\",\"columnId\":1276,\"columnName\":\"date\",\"columnType\":\"date\",\"createBy\":\"admin\",\"createTime\":\"2024-01-28 14:33:45\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"datetime\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"date\",\"javaType\":\"Date\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":59,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"OrderNum\",\"columnComment\":\"订单号\",\"columnId\":1277,\"columnName\":\"order_num\",\"columnType\":\"varchar(50)\",\"createBy\":\"admin\",\"createTime\":\"2024-01-28 14:33:45\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"orderNum\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":true,\"tableId\":59,\"updateBy\":\"\",\"usableColumn\":true},{\"capJavaField\":\"OrderId\",\"columnComment\":\"订单id\",\"columnId\":1278,\"columnName\":\"order_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2024-01-28 14:33:45\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"orderId\",\"javaType\":\"Long\",\"list\":true','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-01-28 14:34:14',47),(132,'代码生成',2,'com.zhijian.generator.controller.GenController.editSave()','PUT',1,'admin',NULL,'/tool/gen','127.0.0.1','内网IP','{\"businessName\":\"reportDetail\",\"className\":\"FmsInventoryReportDetail\",\"columns\":[{\"capJavaField\":\"Id\",\"columnId\":1263,\"columnName\":\"id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2024-01-28 14:33:45\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isPk\":\"1\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":58,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"ReportId\",\"columnComment\":\"Report外键ID\",\"columnId\":1264,\"columnName\":\"report_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2024-01-28 14:33:45\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"reportId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":58,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Date\",\"columnComment\":\"日期\",\"columnId\":1265,\"columnName\":\"date\",\"columnType\":\"date\",\"createBy\":\"admin\",\"createTime\":\"2024-01-28 14:33:45\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"datetime\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"date\",\"javaType\":\"Date\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":58,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"GoodsId\",\"columnComment\":\"商品id\",\"columnId\":1266,\"columnName\":\"goods_id\",\"columnType\":\"int\",\"createBy\":\"admin\",\"createTime\":\"2024-01-28 14:33:45\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"goodsId\",\"javaType\":\"Long\",\"list\":t','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-01-28 14:34:44',26),(133,'代码生成',2,'com.zhijian.generator.controller.GenController.editSave()','PUT',1,'admin',NULL,'/tool/gen','127.0.0.1','内网IP','{\"businessName\":\"inventoryReport\",\"className\":\"FmsInventoryReport\",\"columns\":[{\"capJavaField\":\"Id\",\"columnId\":1253,\"columnName\":\"id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2024-01-28 14:33:45\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isPk\":\"1\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":57,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Date\",\"columnComment\":\"日期\",\"columnId\":1254,\"columnName\":\"date\",\"columnType\":\"date\",\"createBy\":\"admin\",\"createTime\":\"2024-01-28 14:33:45\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"datetime\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"date\",\"javaType\":\"Date\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":57,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Total\",\"columnComment\":\"库存总数量\",\"columnId\":1255,\"columnName\":\"total\",\"columnType\":\"int\",\"createBy\":\"admin\",\"createTime\":\"2024-01-28 14:33:45\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"total\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":57,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"GoodsCount\",\"columnComment\":\"商品总数\",\"columnId\":1256,\"columnName\":\"goods_count\",\"columnType\":\"int\",\"createBy\":\"admin\",\"createTime\":\"2024-01-28 14:33:45\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"goodsCount\",\"javaType\":\"Long\",\"list\":true,\"params\"','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-01-28 14:35:19',17),(134,'代码生成',8,'com.zhijian.generator.controller.GenController.batchGenCode()','GET',1,'admin',NULL,'/tool/gen/batchGenCode','127.0.0.1','内网IP','{\"tables\":\"fms_inventory_report,fms_receivable_order\"}',NULL,0,NULL,'2024-01-28 14:35:30',314),(135,'菜单管理',2,'com.zhijian.web.controller.system.SysMenuController.edit()','PUT',1,'admin',NULL,'/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"fms/receivable/order\",\"createTime\":\"2024-01-28 11:24:35\",\"icon\":\"checkbox\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2069,\"menuName\":\"订单收入\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2068,\"path\":\"order\",\"perms\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-01-28 14:48:11',18),(136,'菜单管理',2,'com.zhijian.web.controller.system.SysMenuController.edit()','PUT',1,'admin',NULL,'/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"fms/inventoryReport\",\"createTime\":\"2024-01-28 11:36:05\",\"icon\":\"druid\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2077,\"menuName\":\"存货报表\",\"menuType\":\"C\",\"orderNum\":3,\"params\":{},\"parentId\":2018,\"path\":\"inventory_report\",\"perms\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-01-28 14:49:01',11),(137,'代码生成',6,'com.zhijian.generator.controller.GenController.importTableSave()','POST',1,'admin',NULL,'/tool/gen/importTable','127.0.0.1','内网IP','{\"tables\":\"fms_payable_ship_fee\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-01-28 15:11:12',66),(138,'代码生成',2,'com.zhijian.generator.controller.GenController.editSave()','PUT',1,'admin',NULL,'/tool/gen','127.0.0.1','内网IP','{\"businessName\":\"shipFee\",\"className\":\"FmsPayableShipFee\",\"columns\":[{\"capJavaField\":\"Id\",\"columnId\":1295,\"columnName\":\"id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2024-01-28 15:11:12\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":60,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"LogisticsCompany\",\"columnComment\":\"物流公司\",\"columnId\":1296,\"columnName\":\"logistics_company\",\"columnType\":\"varchar(50)\",\"createBy\":\"admin\",\"createTime\":\"2024-01-28 15:11:12\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"logisticsCompany\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":60,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"LogisticsCompanyId\",\"columnComment\":\"物流公司id\",\"columnId\":1297,\"columnName\":\"logistics_company_id\",\"columnType\":\"varchar(10)\",\"createBy\":\"admin\",\"createTime\":\"2024-01-28 15:11:12\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"logisticsCompanyId\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":60,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"LogisticsNum\",\"columnComment\":\"物流单号\",\"columnId\":1298,\"columnName\":\"logistics_num\",\"columnType\":\"varchar(50)\",\"createBy\":\"admin\",\"createTime\":\"2024-01-28 15:11:12\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-01-28 15:11:39',45),(139,'代码生成',8,'com.zhijian.generator.controller.GenController.batchGenCode()','GET',1,'admin',NULL,'/tool/gen/batchGenCode','127.0.0.1','内网IP','{\"tables\":\"fms_payable_ship_fee\"}',NULL,0,NULL,'2024-01-28 15:11:48',204),(140,'菜单管理',2,'com.zhijian.web.controller.system.SysMenuController.edit()','PUT',1,'admin',NULL,'/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"fms/payable/shipFee\",\"createTime\":\"2024-01-12 18:35:31\",\"icon\":\"guide\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2063,\"menuName\":\"物流费用\",\"menuType\":\"C\",\"orderNum\":3,\"params\":{},\"parentId\":2072,\"path\":\"shipFee\",\"perms\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-01-28 15:16:13',20),(141,'菜单管理',2,'com.zhijian.web.controller.system.SysMenuController.edit()','PUT',1,'admin',NULL,'/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createTime\":\"2024-01-28 11:28:03\",\"icon\":\"cascader\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2071,\"menuName\":\"平台服务费\",\"menuType\":\"M\",\"orderNum\":3,\"params\":{},\"parentId\":2068,\"path\":\"service_fee\",\"perms\":\"\",\"status\":\"1\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-01-28 19:35:31',28),(142,'菜单管理',2,'com.zhijian.web.controller.system.SysMenuController.edit()','PUT',1,'admin',NULL,'/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createTime\":\"2024-01-28 11:34:01\",\"icon\":\"clipboard\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2076,\"menuName\":\"其他费用\",\"menuType\":\"C\",\"orderNum\":6,\"params\":{},\"parentId\":2072,\"path\":\"other_fee\",\"perms\":\"\",\"status\":\"1\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-01-28 19:49:00',11),(143,'淘宝订单',2,'com.qihang.erp.api.controller.TaoOrderController.confirmOrder()','POST',1,'admin',NULL,'/tao/order/confirmOrder','127.0.0.1','内网IP','{\"address\":\"上海上海 上海市 徐汇区 华泾镇 华发路368弄 馨宁公寓馨宁公寓368弄23号楼1501\",\"auditStatus\":0,\"auditTime\":\"2022-08-05\",\"buyerName\":\"\",\"city\":\"\",\"closeReason\":\"\",\"createTime\":\"2022-08-05 18:48:51\",\"discountAmount\":0,\"discountRemark\":\"\",\"id\":\"1635222253871665598\",\"isMerge\":0,\"logisticsCode\":\"432709738409767\",\"logisticsCompany\":\"韵达速递\",\"orderCreateTime\":\"2022-08-05\",\"orderModifyTime\":\"2022-08-05\",\"orderSource\":0,\"params\":{},\"payAmount\":29.92,\"payTime\":\"2022-08-05\",\"phone\":\"15635244122\",\"province\":\"上海\",\"receiver\":\"小红\",\"sellerMemo\":\"\",\"sendStatus\":0,\"sendTime\":\"2022-08-05\",\"shipType\":1,\"shippingFee\":0,\"shopId\":6,\"status\":3,\"statusStr\":\"等待买家确认收货\",\"taoOrderItemList\":[],\"totalAmount\":29.92,\"updateBy\":\"admin\",\"updateTime\":\"2022-08-05 19:49:12\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-01-28 19:55:37',69),(144,'供应商代发货',2,'com.qihang.erp.api.controller.ScmSupplierAgentShippingController.edit()','PUT',1,'admin',NULL,'/scm/agentShipping','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"createTime\":\"2024-01-28 19:55:37\",\"erpOrderId\":17,\"erpOrderItemId\":14,\"goodsId\":9,\"goodsImg\":\"https://cbu01.alicdn.com/img/ibank/O1CN01PHFmsX2FOyB14fPie_!!2208857268871-0-cib.jpg\",\"goodsNum\":\"272021008026\",\"goodsPrice\":16,\"goodsSpec\":\"浅蓝色,L\",\"goodsTitle\":\"8026牛仔短裤\",\"id\":1,\"itemAmount\":29.92,\"orderDate\":\"2022-08-05\",\"orderNum\":\"1635222253871665598\",\"params\":{},\"quantity\":1,\"shipCompany\":\"菜鸟速递\",\"shipCost\":3,\"shipNo\":\"CN4550110\",\"shipTime\":\"2024-01-28\",\"shopId\":6,\"shopType\":4,\"specId\":40,\"specNum\":\"2720210080260303\",\"status\":0,\"supplierId\":26,\"updateTime\":\"2024-01-28 20:40:06\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-01-28 20:40:06',326903),(145,'代码生成',6,'com.zhijian.generator.controller.GenController.importTableSave()','POST',1,'admin',NULL,'/tool/gen/importTable','127.0.0.1','内网IP','{\"tables\":\"fms_payable_agent_ship\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-01-28 20:48:33',156),(146,'代码生成',2,'com.zhijian.generator.controller.GenController.editSave()','PUT',1,'admin',NULL,'/tool/gen','127.0.0.1','内网IP','{\"businessName\":\"agentShip\",\"className\":\"FmsPayableAgentShip\",\"columns\":[{\"capJavaField\":\"Id\",\"columnId\":1318,\"columnName\":\"id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2024-01-28 20:48:33\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":61,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"OrderNum\",\"columnComment\":\"订单号\",\"columnId\":1319,\"columnName\":\"order_num\",\"columnType\":\"varchar(50)\",\"createBy\":\"admin\",\"createTime\":\"2024-01-28 20:48:33\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"orderNum\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":true,\"tableId\":61,\"updateBy\":\"\",\"usableColumn\":true},{\"capJavaField\":\"ShopId\",\"columnComment\":\"店铺id\",\"columnId\":1320,\"columnName\":\"shop_id\",\"columnType\":\"int\",\"createBy\":\"admin\",\"createTime\":\"2024-01-28 20:48:33\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"shopId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":61,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"SupplierId\",\"columnComment\":\"供应商id\",\"columnId\":1321,\"columnName\":\"supplier_id\",\"columnType\":\"int\",\"createBy\":\"admin\",\"createTime\":\"2024-01-28 20:48:33\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"supplierId\",\"javaType\":\"Long\",\"lis','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-01-28 20:48:59',43),(147,'代码生成',8,'com.zhijian.generator.controller.GenController.batchGenCode()','GET',1,'admin',NULL,'/tool/gen/batchGenCode','127.0.0.1','内网IP','{\"tables\":\"fms_payable_agent_ship\"}',NULL,0,NULL,'2024-01-28 20:49:04',287),(148,'菜单管理',2,'com.zhijian.web.controller.system.SysMenuController.edit()','PUT',1,'admin',NULL,'/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"fms/payable/agentShip\",\"createTime\":\"2024-01-12 18:35:02\",\"icon\":\"theme\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2062,\"menuName\":\"代发账单\",\"menuType\":\"C\",\"orderNum\":3,\"params\":{},\"parentId\":2072,\"path\":\"agentShip\",\"perms\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-01-28 20:57:14',23),(149,'供应商代发货',2,'com.qihang.erp.api.controller.ScmSupplierAgentShippingController.edit()','PUT',1,'admin',NULL,'/scm/agentShipping','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"createTime\":\"2024-01-28 19:55:37\",\"erpOrderId\":17,\"erpOrderItemId\":14,\"goodsId\":9,\"goodsImg\":\"https://cbu01.alicdn.com/img/ibank/O1CN01PHFmsX2FOyB14fPie_!!2208857268871-0-cib.jpg\",\"goodsNum\":\"272021008026\",\"goodsPrice\":16,\"goodsSpec\":\"浅蓝色,L\",\"goodsTitle\":\"8026牛仔短裤\",\"id\":1,\"itemAmount\":29.92,\"orderDate\":\"2022-08-05\",\"orderNum\":\"1635222253871665598\",\"params\":{},\"quantity\":1,\"shipCompany\":\"菜鸟速递\",\"shipCost\":2.0,\"shipNo\":\"CN52500021\",\"shipTime\":\"2024-01-28\",\"shopId\":6,\"shopType\":4,\"specId\":40,\"specNum\":\"2720210080260303\",\"status\":0,\"supplierId\":26,\"updateBy\":\"admin\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-01-28 21:06:20',504629),(150,'供应商代发货',2,'com.qihang.erp.api.controller.ScmSupplierAgentShippingController.edit()','PUT',1,'admin',NULL,'/scm/agentShipping','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"createTime\":\"2024-01-28 19:55:37\",\"erpOrderId\":17,\"erpOrderItemId\":14,\"goodsId\":9,\"goodsImg\":\"https://cbu01.alicdn.com/img/ibank/O1CN01PHFmsX2FOyB14fPie_!!2208857268871-0-cib.jpg\",\"goodsNum\":\"272021008026\",\"goodsPrice\":16,\"goodsSpec\":\"浅蓝色,L\",\"goodsTitle\":\"8026牛仔短裤\",\"id\":1,\"itemAmount\":29.92,\"orderDate\":\"2022-08-05\",\"orderNum\":\"1635222253871665598\",\"params\":{},\"quantity\":1,\"shipCompany\":\"菜鸟速递\",\"shipCost\":2.0,\"shipNo\":\"CN52500021\",\"shipTime\":\"2024-01-28\",\"shopId\":6,\"shopType\":4,\"specId\":40,\"specNum\":\"2720210080260303\",\"status\":0,\"supplierId\":26,\"updateBy\":\"admin\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-01-28 21:06:44',8276),(151,'店铺',2,'com.qihang.erp.api.controller.ShopController.edit()','PUT',1,'admin',NULL,'/shop/shop','127.0.0.1','内网IP','{\"apiRequestUrl\":\"2\",\"appSercet\":\"36a12497-fb9d-4b54-8cd1-fd1617346687\",\"appkey\":\"7249607407477720636\",\"company\":\"华衣云商\",\"ename\":\"douyin\",\"id\":22,\"isDelete\":0,\"isShow\":1,\"modifyOn\":1653672695,\"name\":\"梦小妮牛仔裤\",\"nickName\":\"抖音-梦小妮\",\"orderNum\":87,\"params\":{},\"sellerUserId\":0,\"sellerUserIdStr\":\"0\",\"sessionKey\":\"\",\"type\":6,\"url\":\"http://openapi.jinritemai.com\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-02-17 10:47:35',17),(152,'店铺',2,'com.qihang.erp.api.controller.ShopController.edit()','PUT',1,'admin',NULL,'/shop/shop','127.0.0.1','内网IP','{\"apiRequestUrl\":\"2\",\"appSercet\":\"36a12497-fb9d-4b54-8cd1-fd1617346687\",\"appkey\":\"7249607407477720636\",\"company\":\"华衣云商\",\"ename\":\"douyin\",\"id\":22,\"isDelete\":0,\"isShow\":1,\"modifyOn\":1653672695,\"name\":\"梦小妮牛仔裤\",\"nickName\":\"抖音-梦小妮\",\"orderNum\":87,\"params\":{},\"sellerUserId\":4463798,\"sellerUserIdStr\":\"0\",\"sessionKey\":\"\",\"type\":6,\"url\":\"http://openapi.jinritemai.com\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-02-17 11:54:47',16),(153,'菜单管理',2,'com.zhijian.web.controller.system.SysMenuController.edit()','PUT',1,'admin',NULL,'/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"\",\"createTime\":\"2023-12-27 15:00:27\",\"icon\":\"server\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":4,\"menuName\":\"采购管理\",\"menuType\":\"M\",\"orderNum\":1,\"params\":{},\"parentId\":0,\"path\":\"scm\",\"perms\":\"\",\"query\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-03-24 19:30:46',14),(154,'菜单管理',2,'com.zhijian.web.controller.system.SysMenuController.edit()','PUT',1,'admin',NULL,'/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"\",\"createTime\":\"2023-12-29 16:53:03\",\"icon\":\"shopping\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2014,\"menuName\":\"订单管理\",\"menuType\":\"M\",\"orderNum\":2,\"params\":{},\"parentId\":0,\"path\":\"sale\",\"perms\":\"\",\"query\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-03-24 19:31:53',10),(155,'菜单管理',2,'com.zhijian.web.controller.system.SysMenuController.edit()','PUT',1,'admin',NULL,'/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"sale/order/index\",\"createTime\":\"2023-12-31 20:05:05\",\"icon\":\"list\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2033,\"menuName\":\"订单查询\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2014,\"path\":\"order/list\",\"perms\":\"\",\"query\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-03-24 19:32:00',5),(156,'菜单管理',2,'com.zhijian.web.controller.system.SysMenuController.edit()','PUT',1,'admin',NULL,'/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"sale/order/create\",\"createTime\":\"2023-12-31 20:01:22\",\"icon\":\"documentation\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2030,\"menuName\":\"手动创建订单\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2014,\"path\":\"order/create\",\"perms\":\"\",\"query\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"1\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-03-24 19:32:32',9),(157,'菜单管理',2,'com.zhijian.web.controller.system.SysMenuController.edit()','PUT',1,'admin',NULL,'/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"\",\"createTime\":\"2024-01-01 14:14:42\",\"icon\":\"excel\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2036,\"menuName\":\"网店订单导入\",\"menuType\":\"C\",\"orderNum\":2,\"params\":{},\"parentId\":2014,\"path\":\"shop_order\",\"perms\":\"\",\"query\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-03-24 19:33:50',7),(158,'菜单管理',2,'com.zhijian.web.controller.system.SysMenuController.edit()','PUT',1,'admin',NULL,'/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"shop/order/import\",\"createTime\":\"2024-01-01 14:14:42\",\"icon\":\"excel\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2036,\"menuName\":\"网店订单导入\",\"menuType\":\"C\",\"orderNum\":2,\"params\":{},\"parentId\":2014,\"path\":\"shopOrder/import\",\"perms\":\"\",\"query\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-03-24 19:36:40',7),(159,'菜单管理',2,'com.zhijian.web.controller.system.SysMenuController.edit()','PUT',1,'admin',NULL,'/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"shop/order/import\",\"createTime\":\"2024-01-01 14:14:42\",\"icon\":\"excel\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2036,\"menuName\":\"网店订单导入\",\"menuType\":\"C\",\"orderNum\":2,\"params\":{},\"parentId\":2014,\"path\":\"shopOrder/import\",\"perms\":\"\",\"query\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-03-24 19:36:40',7),(160,'菜单管理',2,'com.zhijian.web.controller.system.SysMenuController.edit()','PUT',1,'admin',NULL,'/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"shop/order/index\",\"createTime\":\"2024-01-01 14:14:42\",\"icon\":\"excel\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2036,\"menuName\":\"网店订单导入\",\"menuType\":\"C\",\"orderNum\":2,\"params\":{},\"parentId\":2014,\"path\":\"shopOrder/import\",\"perms\":\"\",\"query\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-03-24 19:39:56',7),(161,'菜单管理',2,'com.zhijian.web.controller.system.SysMenuController.edit()','PUT',1,'admin',NULL,'/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"sale/returned\",\"createTime\":\"2024-01-03 14:24:36\",\"icon\":\"size\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2054,\"menuName\":\"售后管理\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2053,\"path\":\"returned\",\"perms\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-03-24 20:27:33',7),(162,'菜单管理',2,'com.zhijian.web.controller.system.SysMenuController.edit()','PUT',1,'admin',NULL,'/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"\",\"createTime\":\"2023-12-31 17:29:03\",\"icon\":\"clipboard\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2029,\"menuName\":\"店铺售后管理\",\"menuType\":\"M\",\"orderNum\":2,\"params\":{},\"parentId\":2053,\"path\":\"refund\",\"perms\":\"\",\"query\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-03-24 20:27:41',7),(163,'菜单管理',2,'com.zhijian.web.controller.system.SysMenuController.edit()','PUT',1,'admin',NULL,'/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"sale/returned\",\"createTime\":\"2024-01-03 14:24:36\",\"icon\":\"size\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2054,\"menuName\":\"售后管理\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2053,\"path\":\"refund_list\",\"perms\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-03-24 20:28:24',7),(164,'菜单管理',2,'com.zhijian.web.controller.system.SysMenuController.edit()','PUT',1,'admin',NULL,'/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"shop/refund/index\",\"createTime\":\"2023-12-31 17:29:03\",\"icon\":\"clipboard\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2029,\"menuName\":\"店铺售后导入\",\"menuType\":\"C\",\"orderNum\":2,\"params\":{},\"parentId\":2053,\"path\":\"shop_refund\",\"perms\":\"\",\"query\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-03-24 20:29:07',7),(165,'菜单管理',2,'com.zhijian.web.controller.system.SysMenuController.edit()','PUT',1,'admin',NULL,'/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"scm/agentShipping\",\"createTime\":\"2024-01-06 23:57:14\",\"icon\":\"clipboard\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2057,\"menuName\":\"供应商代发管理\",\"menuType\":\"C\",\"orderNum\":99,\"params\":{},\"parentId\":2034,\"path\":\"supplier/agentShipping\",\"perms\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-03-24 20:30:29',11),(166,'菜单管理',2,'com.zhijian.web.controller.system.SysMenuController.edit()','PUT',1,'admin',NULL,'/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"shop/order/index\",\"createTime\":\"2024-01-01 14:14:42\",\"icon\":\"excel\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2036,\"menuName\":\"网店订单导入\",\"menuType\":\"C\",\"orderNum\":2,\"params\":{},\"parentId\":2014,\"path\":\"shop_order\",\"perms\":\"\",\"query\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-03-24 20:35:32',6),(167,'菜单管理',2,'com.zhijian.web.controller.system.SysMenuController.edit()','PUT',1,'admin',NULL,'/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"fms/payable/purchase\",\"createTime\":\"2024-01-28 11:30:49\",\"icon\":\"component\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2073,\"menuName\":\"采购应付\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":4,\"path\":\"purchase\",\"perms\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-03-24 21:07:23',5),(168,'菜单管理',2,'com.zhijian.web.controller.system.SysMenuController.edit()','PUT',1,'admin',NULL,'/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"fms/payable/agentShip\",\"createTime\":\"2024-01-12 18:35:02\",\"icon\":\"theme\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2062,\"menuName\":\"代发账单\",\"menuType\":\"C\",\"orderNum\":3,\"params\":{},\"parentId\":4,\"path\":\"agentShip\",\"perms\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-03-24 21:07:38',10),(169,'菜单管理',2,'com.zhijian.web.controller.system.SysMenuController.edit()','PUT',1,'admin',NULL,'/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"fms/payable/shipFee\",\"createTime\":\"2024-01-12 18:35:31\",\"icon\":\"guide\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2063,\"menuName\":\"物流费用\",\"menuType\":\"C\",\"orderNum\":3,\"params\":{},\"parentId\":2034,\"path\":\"shipFee\",\"perms\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-03-24 21:07:53',7),(170,'菜单管理',2,'com.zhijian.web.controller.system.SysMenuController.edit()','PUT',1,'admin',NULL,'/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"\",\"createTime\":\"2023-12-29 17:07:23\",\"icon\":\"money\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2018,\"menuName\":\"财务管理\",\"menuType\":\"M\",\"orderNum\":6,\"params\":{},\"parentId\":0,\"path\":\"fms\",\"perms\":\"\",\"query\":\"\",\"status\":\"1\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-03-24 21:08:38',8),(171,'菜单管理',2,'com.zhijian.web.controller.system.SysMenuController.edit()','PUT',1,'admin',NULL,'/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"\",\"createTime\":\"2023-12-27 15:00:27\",\"icon\":\"tool\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":3,\"menuName\":\"系统工具\",\"menuType\":\"M\",\"orderNum\":101,\"params\":{},\"parentId\":0,\"path\":\"tool\",\"perms\":\"\",\"query\":\"\",\"status\":\"1\",\"updateBy\":\"admin\",\"visible\":\"1\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-03-24 21:08:58',8),(172,'菜单管理',2,'com.zhijian.web.controller.system.SysMenuController.edit()','PUT',1,'admin',NULL,'/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"\",\"createTime\":\"2023-12-27 15:00:27\",\"icon\":\"tool\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":3,\"menuName\":\"系统工具\",\"menuType\":\"M\",\"orderNum\":101,\"params\":{},\"parentId\":0,\"path\":\"tool\",\"perms\":\"\",\"query\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"1\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-03-24 21:09:13',8),(173,'菜单管理',2,'com.zhijian.web.controller.system.SysMenuController.edit()','PUT',1,'admin',NULL,'/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"\",\"createTime\":\"2023-12-27 15:00:27\",\"icon\":\"monitor\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2,\"menuName\":\"系统监控\",\"menuType\":\"M\",\"orderNum\":100,\"params\":{},\"parentId\":0,\"path\":\"monitor\",\"perms\":\"\",\"query\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"1\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-03-24 21:09:18',8);
/*!40000 ALTER TABLE `sys_oper_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_role`
--

DROP TABLE IF EXISTS `sys_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_role` (
  `role_id` bigint NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色名称',
  `role_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色权限字符串',
  `role_sort` int NOT NULL COMMENT '显示顺序',
  `data_scope` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '1' COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
  `menu_check_strictly` tinyint(1) DEFAULT '1' COMMENT '菜单树选择项是否关联显示',
  `dept_check_strictly` tinyint(1) DEFAULT '1' COMMENT '部门树选择项是否关联显示',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='角色信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_role`
--

LOCK TABLES `sys_role` WRITE;
/*!40000 ALTER TABLE `sys_role` DISABLE KEYS */;
INSERT INTO `sys_role` VALUES (1,'超级管理员','admin',1,'1',1,1,'0','0','admin','2023-08-07 19:31:37','',NULL,'超级管理员'),(2,'普通角色','common',2,'2',1,1,'0','0','admin','2023-08-07 19:31:37','admin','2024-04-10 11:38:52','普通角色');
/*!40000 ALTER TABLE `sys_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_role_menu`
--

DROP TABLE IF EXISTS `sys_role_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_role_menu` (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `menu_id` bigint NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`,`menu_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='角色和菜单关联表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_role_menu`
--

LOCK TABLES `sys_role_menu` WRITE;
/*!40000 ALTER TABLE `sys_role_menu` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_role_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_user`
--

DROP TABLE IF EXISTS `sys_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_user` (
  `user_id` bigint NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `dept_id` bigint DEFAULT NULL COMMENT '部门ID',
  `user_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户账号',
  `nick_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户昵称',
  `user_type` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '00' COMMENT '用户类型（00系统用户）',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '用户邮箱',
  `phonenumber` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '手机号码',
  `sex` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '用户性别（0男 1女 2未知）',
  `avatar` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '头像地址',
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '密码',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '帐号状态（0正常 1停用）',
  `expiration_date` date DEFAULT NULL COMMENT '到期日期',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `login_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '最后登录IP',
  `login_date` datetime DEFAULT NULL COMMENT '最后登录时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  `wx_open_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '登陆微信openid',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=134 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='用户信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user`
--

LOCK TABLES `sys_user` WRITE;
/*!40000 ALTER TABLE `sys_user` DISABLE KEYS */;
INSERT INTO `sys_user` VALUES (1,103,'admin','启航','00','ry@163.com','15888888888','1','','$2a$10$MkBdzADGzLxAqopkmh3vDu0oA5bxgHWcg173AVni9Rr9MFQtnjplK','0','2025-04-01','0','127.0.0.1','2025-05-17 15:40:52','admin','2023-08-07 19:31:37','','2025-05-17 15:40:52','管理员',NULL),(100,NULL,'qihang','BUZD','00','2855@qq.com','15658900660','2','','$2a$10$OW1WgE6qn46P35UpwyFSGupKCP6Jl9wScJkWMvbZ5MKQ6NsxsSrC2','0','2025-10-31','0','127.0.0.1','2025-05-17 15:21:34','admin','2024-04-21 10:36:49','admin','2025-05-17 15:21:34',NULL,NULL),(101,NULL,'15818590119','试用会员0119','00','','','0','','$2a$10$yMgN6PZKiuafBVHaEHhk3OoSQ5o98xVG8RHEs2sg5.Yv/TEQuR/86','0','2025-05-17','0','113.118.102.209','2025-04-17 21:13:06','主动注册','2025-04-17 13:13:04','','2025-04-17 13:13:05',NULL,NULL),(102,NULL,'15286902105','试用会员2105','00','','','0','','$2a$10$nbDujbCk2SrdamYRHr217ORRipaa5p5lVMVFctBU6fPt/rd3k.5E.','0','2025-05-17','0','114.86.55.0','2025-04-17 21:16:37','主动注册','2025-04-17 13:16:36','','2025-04-17 13:16:37',NULL,NULL),(103,NULL,'13335117173','试用会员7173','00','','','0','','$2a$10$oPYmtdGZ1rYNUCFpKaaIYOr1Z7mAtVAXmWrqyEj2qhAA.nqD2xjeC','0','2025-05-17','0','119.185.23.133','2025-04-17 23:29:48','主动注册','2025-04-17 13:43:51','','2025-04-17 15:29:48',NULL,NULL),(104,NULL,'18300003743','试用会员3743','00','','','0','','$2a$10$yFjV6iFRMAwc2CzV5C9uoOnK2QDCe5wWxtoajlps5ojbLcPpEYpOa','0','2025-05-17','0','113.89.149.8','2025-05-07 11:18:08','主动注册','2025-04-17 14:14:38','','2025-05-07 03:18:08',NULL,NULL),(105,NULL,'15305871631','试用会员1631','00','','','0','','$2a$10$gYDhJNlPlEVORzmOW2lLwOM/TmtowLR6DCZGFe9r2ckHfPT9wFi0y','0','2025-05-17','0','220.190.47.229','2025-04-25 06:38:00','主动注册','2025-04-17 14:28:08','','2025-04-24 22:37:59',NULL,NULL),(106,NULL,'18937638598','试用会员8598','00','','','0','','$2a$10$xBP3XJMZ1fCraIls7kTJg.O7i2JxVKNFacgviEjPwm.eT1jPYG632','0','2025-05-18','0','219.157.244.44','2025-04-18 09:02:07','主动注册','2025-04-18 01:02:06','','2025-04-18 01:02:06',NULL,NULL),(107,NULL,'15819801110','试用会员1110','00','','','0','','$2a$10$u.nYY54x/mZ1majhnM8D6.fXgK7u1tE70zWk830GFhiXv7.NUcl5e','0','2025-05-18','0','113.84.160.75','2025-04-18 09:16:45','主动注册','2025-04-18 01:16:44','','2025-04-18 01:16:45',NULL,NULL),(108,NULL,'15727783004','试用会员3004','00','','','0','','$2a$10$Y1q6g1dxUhb0lI/roPPaXu7cRFkecErzoFgGMpotYvc4y0pJ7jU2G','0','2025-05-18','0','182.98.51.20','2025-04-18 14:24:36','主动注册','2025-04-18 02:16:46','','2025-04-18 06:24:36',NULL,NULL),(109,NULL,'13519172625','试用会员2625','00','','','0','','$2a$10$uka7jZ2HxFjnSn/tp1wSd.j3q2Y/zHSou985Iy0zzOUQkYNNTSbqS','0','2025-05-18','0','1.83.163.132','2025-04-18 16:40:34','主动注册','2025-04-18 06:03:57','','2025-04-18 08:40:34',NULL,NULL),(110,NULL,'18620057602','试用会员7602','00','','','0','','$2a$10$/Vc3F5C3xIv6sRX21lu5U.HZX7HrHKdBx2kJiJc/OUkYc.7AK8qUi','0','2025-05-19','0','14.19.153.73','2025-04-19 11:24:01','主动注册','2025-04-19 03:23:59','','2025-04-19 03:24:00',NULL,NULL),(111,NULL,'13168958901','试用会员8901','00','','','0','','$2a$10$w18kdW8Uv/IuWqD0Z.EEh.nuuXcaQNy2VC4Z3A1f9j59YGapYX01G','0','2025-05-21','0','113.77.105.207','2025-04-21 18:24:41','主动注册','2025-04-21 10:24:40','','2025-04-21 10:24:40',NULL,NULL),(112,NULL,'15080888666','试用会员8666','00','','','0','','$2a$10$1pLlarRrg5/dr2NZb09VJ.wyHzyOzEE5a3rhJZ2/.vW81JreEAYvG','0','2025-05-22','0','120.36.152.6','2025-04-22 11:28:41','主动注册','2025-04-22 03:28:01','','2025-04-22 03:28:40',NULL,NULL),(113,NULL,'17662054245','试用会员4245','00','','','0','','$2a$10$rYkYUeExAwYFpUZ9C6LxleWZgB9Tlaaoqb7jAvtUpD5fkoEbLK7l.','0','2025-05-22','0','120.224.34.115','2025-04-22 15:15:05','主动注册','2025-04-22 07:15:04','','2025-04-22 07:15:04',NULL,NULL),(114,NULL,'18869942679','试用会员2679','00','','','0','','$2a$10$T0ea40Kqb49ykzLk8CbT1uyRXGyDHWaKV...NM/GOg63U9AoV7hqy','0','2025-05-23','0','183.147.111.124','2025-04-23 12:45:43','主动注册','2025-04-23 04:45:42','','2025-04-23 04:45:43',NULL,NULL),(115,NULL,'13523523345','试用会员3345','00','','','0','','$2a$10$HW6N6nJ1g6DiyNxu2oWJXO8HZketH/DjhPfD26RTG2vHDd1Hkypz2','0','2025-05-23','0','223.104.41.14','2025-04-23 16:27:04','主动注册','2025-04-23 08:26:58','','2025-04-23 08:27:04',NULL,NULL),(116,NULL,'18768983782','试用会员3782','00','','','0','','$2a$10$RgsPnMPj1HvYbqEPHtOxBuIg2GZj/ENE8V5cDkG3TAYA50/w7G9OO','0','2025-05-24','0','113.116.16.8','2025-04-24 15:14:36','主动注册','2025-04-24 07:14:34','','2025-04-24 07:14:35',NULL,NULL),(117,NULL,'qi','微信公众号扫码登录用户','00','','','0','','$2a$10$rYujjrj.ZHCXDANtdYnHXeE2fNus9n49OGjFo4cvEZTvXQ7BcNC4O','0','2025-05-28','0','121.34.200.232','2025-04-28 09:02:46','微信公众号扫码登录','2025-04-28 00:59:06','','2025-04-28 01:02:46',NULL,NULL),(118,NULL,'user20250428011043174','微信公众号扫码登录用户','00','','','0','','$2a$10$WOvLWru9OXee8LdvPYhNoul9/.xXwqkapF.UQlnhshEbtAm1F2tJ.','0','2025-05-28','0','',NULL,'微信公众号扫码登录','2025-04-28 01:10:43','',NULL,NULL,NULL),(119,NULL,'16630602542','试用会员2542','00','','','0','','$2a$10$Ibd7eyEprMRf7GqMVFmAf.gp0iFVP2/L3c9zMA5DHdLDJBCfiwWoa','0','2025-05-28','0','27.222.208.225','2025-04-29 01:09:43','主动注册','2025-04-28 17:09:41','','2025-04-28 17:09:42',NULL,NULL),(120,NULL,'18213075634','试用会员5634','00','','','0','','$2a$10$lf1s961Wb7hx1qDRvJd6i./gm294edUQngZJBjPjiH0ZEbQ/5LCki','0','2025-05-29','0','183.225.26.25','2025-04-29 11:59:49','主动注册','2025-04-29 03:59:48','','2025-04-29 03:59:49',NULL,NULL),(121,NULL,'18219352013','试用会员2013','00','','','0','','$2a$10$W6v1m7jtV5q9TF/EBD/tDeQ6VBleR45YxaYkmT/koq8.rcm/Bboaa','0','2025-05-29','0','119.123.55.188','2025-04-29 16:36:10','主动注册','2025-04-29 08:36:09','','2025-04-29 08:36:10',NULL,NULL),(122,NULL,'15994800846','试用会员0846','00','','','0','','$2a$10$RTlD9ZHK4r29veljrFhC9OCtSi9Na6PwlsxZqQSp1t3s5SS0Sq51C','0','2025-05-30','0','119.123.0.29','2025-04-30 13:38:20','主动注册','2025-04-30 03:11:37','','2025-04-30 05:38:19',NULL,NULL),(123,NULL,'18194334633','试用会员4633','00','','','0','','$2a$10$X9GMUKNfyBsZJoat43k3IeDo9P029.fvwdB4pwLedmnEVhktdEhRW','0','2025-06-05','0','124.90.166.57','2025-05-05 19:04:57','主动注册','2025-05-05 11:03:11','','2025-05-05 11:04:57',NULL,NULL),(124,NULL,'user20250505110433029','微信公众号扫码登录用户','00','','','0','','$2a$10$WARV7E3H.boQpss7GCdldOdcoFtLo0HSD/zX2CTw5Yiw.NUfgoYH6','0','2025-06-05','0','',NULL,'微信公众号扫码登录','2025-05-05 11:04:33','',NULL,NULL,NULL),(125,NULL,'15099999999','试用会员9999','00','','','0','','$2a$10$FHiGSHGIUI8rjc21ge9FPeVzxH0JY7bBJWI.VGf7ZygNmF8DAxh2O','0','2025-06-06','0','183.226.184.23','2025-05-06 10:39:40','主动注册','2025-05-06 02:39:38','','2025-05-06 02:39:39',NULL,NULL),(126,NULL,'18025168556','试用会员8556','00','','','0','','$2a$10$Z0Ghvqpqm0D1Nua/wmMeVuAzEPRyd9UxA2/THZFzmYBpVAsjjQbJO','0','2025-06-06','0','116.18.90.243','2025-05-06 11:20:54','主动注册','2025-05-06 03:20:53','','2025-05-06 03:20:54',NULL,NULL),(127,NULL,'15251918207','试用会员8207','00','','','0','','$2a$10$KpbrpVFy6T.knJRJ31vfx.BkexJsPmyqqP9/Af12XZhQZodFnThoi','0','2025-06-06','0','111.121.44.63','2025-05-06 12:42:42','主动注册','2025-05-06 04:42:41','','2025-05-06 04:42:42',NULL,NULL),(128,NULL,'18681457229','试用会员7229','00','','','0','','$2a$10$BhQ9qaYrLEiinWQ6BsxNlOdR4L5k/v9yQLvUJGX8IDVU5GQjPLxyS','0','2025-06-06','0','116.25.95.207','2025-05-06 18:30:20','主动注册','2025-05-06 10:30:19','','2025-05-06 10:30:20',NULL,NULL),(129,NULL,'18217781090','试用会员1090','00','','','0','','$2a$10$bUv8JWymv9vaQNDZzBWKDuGRjKlrFgtQ5/2HDGesLOXcg9MagspYO','0','2025-06-06','0','185.97.114.120','2025-05-06 20:27:11','主动注册','2025-05-06 12:27:09','','2025-05-06 12:27:10',NULL,NULL),(130,NULL,'13718612885','试用会员2885','00','','','0','','$2a$10$scDWHmG1ks05tYY/ExqOsu1/2W8ny7AjuOzutjWWXpEn0sfWIU.s2','0','2025-06-06','0','111.202.148.159','2025-05-06 22:17:21','主动注册','2025-05-06 14:17:20','','2025-05-06 14:17:21',NULL,NULL),(131,NULL,'18666140014','试用会员0014','00','','','0','','$2a$10$BrJd/yt0W30plZMwUuuw7e3.lKnS1nmdmqT5TaO6hoyYmDPmtSdaa','0','2025-06-07','0','125.89.64.58','2025-05-07 10:11:47','主动注册','2025-05-07 02:11:46','','2025-05-07 02:11:47',NULL,NULL),(132,NULL,'15999999999','试用会员9999','00','','','0','','$2a$10$XeB73vRwlS4yzPhDXc6z.eKIqQCQ8gf5ktsn3vg6Pr1o0PEfhayzG','0','2025-06-07','0','183.226.184.23','2025-05-07 12:13:55','主动注册','2025-05-07 04:13:54','','2025-05-07 04:13:55',NULL,NULL),(133,NULL,'13276775800','试用会员5800','00','','','0','','$2a$10$hUj4XZFksRU7aVzBqLsZhOtHgnqsIerrTiuP3eIScQvE2lq5EcyFi','0','2025-06-07','0','111.1.209.210','2025-05-07 16:19:43','主动注册','2025-05-07 08:19:42','','2025-05-07 08:19:42',NULL,NULL);
/*!40000 ALTER TABLE `sys_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_user_role`
--

DROP TABLE IF EXISTS `sys_user_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_user_role` (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `role_id` bigint NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`,`role_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='用户和角色关联表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user_role`
--

LOCK TABLES `sys_user_role` WRITE;
/*!40000 ALTER TABLE `sys_user_role` DISABLE KEYS */;
INSERT INTO `sys_user_role` VALUES (1,1),(2,1);
/*!40000 ALTER TABLE `sys_user_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wms_goods_bad_stock`
--

DROP TABLE IF EXISTS `wms_goods_bad_stock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wms_goods_bad_stock` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `goodsId` int NOT NULL COMMENT '商品id',
  `specId` int NOT NULL COMMENT '商品规格id',
  `specNumber` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '规格编码（唯一）',
  `sourceId` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '来源ID（type==1时 order_send_return主键id）',
  `type` int NOT NULL COMMENT '类型（1退货报损3待退还供应商）',
  `locationId` int NOT NULL DEFAULT '0' COMMENT '仓位',
  `quantity` int NOT NULL DEFAULT '0' COMMENT '数量',
  `lossAmount` double NOT NULL DEFAULT '0' COMMENT '损失金额（最大成本）',
  `isDelete` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常  1删除',
  `result` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '处理结果',
  `resultTime` datetime DEFAULT NULL COMMENT '处理时间',
  `reason` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '理由',
  `status` tinyint NOT NULL DEFAULT '0' COMMENT '是否处理0未处理1已处理',
  `createTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `modifyTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `tenant_id` bigint NOT NULL COMMENT '租户id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='不良品库存';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wms_goods_bad_stock`
--

LOCK TABLES `wms_goods_bad_stock` WRITE;
/*!40000 ALTER TABLE `wms_goods_bad_stock` DISABLE KEYS */;
INSERT INTO `wms_goods_bad_stock` VALUES (1,13,88,'28202206810101','20',1,0,1,29,0,'计入损失','2022-10-03 17:39:32','货物损坏，供应商拒收，消费者退款成功',1,'2022-10-03 09:39:32','2022-10-03 09:39:32',0),(2,33,497,'HN08017503','76',1,0,1,28,0,'计入损失','2022-10-16 18:00:00','货物损坏，供应商拒收，消费者退款成功',1,'2022-10-16 10:00:00','2022-10-16 10:00:00',0),(3,33,502,'HN08012903','249',1,0,1,28,0,'计入损失','2022-11-07 09:42:33','货物损坏，供应商拒收，消费者退款成功',1,'2022-11-07 01:42:33','2022-11-07 01:42:33',0),(4,15,119,'28202106610102','174',1,0,1,29,0,'计入损失','2022-11-07 09:43:20','货物损坏，供应商拒收，消费者退款成功',1,'2022-11-07 01:43:20','2022-11-07 01:43:20',0),(5,37,558,'HN1062904','327',1,0,1,31,0,'计入损失','2022-12-08 10:08:14','货物损坏，供应商拒收，消费者退款成功',1,'2022-12-08 02:08:14','2022-12-08 02:08:14',0);
/*!40000 ALTER TABLE `wms_goods_bad_stock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wms_goods_bad_stock_log`
--

DROP TABLE IF EXISTS `wms_goods_bad_stock_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wms_goods_bad_stock_log` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `stockId` bigint NOT NULL COMMENT '商品id',
  `specId` int NOT NULL COMMENT '商品规格id',
  `locationId` int NOT NULL COMMENT '所在仓位',
  `type` int NOT NULL COMMENT '类型1入库2出库',
  `quantity` bigint NOT NULL DEFAULT '0' COMMENT '数量',
  `remark` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  `createTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `tenant_id` bigint NOT NULL COMMENT '租户id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='不良品库存日志';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wms_goods_bad_stock_log`
--

LOCK TABLES `wms_goods_bad_stock_log` WRITE;
/*!40000 ALTER TABLE `wms_goods_bad_stock_log` DISABLE KEYS */;
INSERT INTO `wms_goods_bad_stock_log` VALUES (1,1,88,0,1,1,'退货不良品入库SKU :28202206810101退货单号:BAD221003173932494','2022-10-03 09:39:32',0),(2,2,497,0,1,1,'退货不良品入库SKU :HN08017503退货单号:BAD221016180000005','2022-10-16 10:00:00',0),(3,3,502,0,1,1,'退货不良品入库SKU :HN08012903退货单号:BAD221107094233114','2022-11-07 01:42:33',0),(4,4,119,0,1,1,'退货不良品入库SKU :28202106610102退货单号:BAD221107094320707','2022-11-07 01:43:20',0),(5,5,558,0,1,1,'退货不良品入库SKU :HN1062904退货单号:BAD221208100814778','2022-12-08 02:08:14',0);
/*!40000 ALTER TABLE `wms_goods_bad_stock_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wms_stock_in`
--

DROP TABLE IF EXISTS `wms_stock_in`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wms_stock_in` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `stock_in_num` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '入库单据编号',
  `stock_in_type` int NOT NULL COMMENT '来源类型（1采购订单2退货订单）',
  `source_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '来源单号',
  `source_id` bigint DEFAULT NULL COMMENT '来源单id',
  `source_goods_unit` int DEFAULT NULL COMMENT '采购订单商品数',
  `source_spec_unit_total` int DEFAULT NULL COMMENT '采购订单总件数',
  `source_spec_unit` int DEFAULT NULL COMMENT '采购订单商品规格数',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  `stock_in_operator_id` bigint DEFAULT NULL COMMENT '操作入库人id',
  `stock_in_operator` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '操作入库人',
  `stock_in_time` datetime DEFAULT NULL COMMENT '入库时间',
  `status` int NOT NULL DEFAULT '0' COMMENT '状态（0待入库1部分入库2全部入库）',
  `create_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='入库单';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wms_stock_in`
--

LOCK TABLES `wms_stock_in` WRITE;
/*!40000 ALTER TABLE `wms_stock_in` DISABLE KEYS */;
INSERT INTO `wms_stock_in` VALUES (1,'1739679264127199',1,'aaaa',NULL,1,14,1,NULL,1,'aaa','2025-02-16 12:15:15',2,'admin','2025-02-16 12:14:37','admin','2025-02-16 12:15:15'),(2,'1739891507973458',1,'a',NULL,1,1,1,NULL,1,'a','2025-02-18 23:12:09',2,'admin','2025-02-18 23:11:58','admin','2025-02-18 23:12:09');
/*!40000 ALTER TABLE `wms_stock_in` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wms_stock_in_item`
--

DROP TABLE IF EXISTS `wms_stock_in_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wms_stock_in_item` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `stock_in_id` bigint NOT NULL COMMENT '入库单id',
  `stock_in_type` int DEFAULT NULL COMMENT '来源类型（1采购订单2退货订单）',
  `source_no` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '来源单号',
  `source_id` bigint DEFAULT NULL COMMENT '来源单id',
  `source_item_id` bigint NOT NULL COMMENT '来源单itemId',
  `goods_id` bigint NOT NULL COMMENT '商品id',
  `goods_num` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '商品编码',
  `goods_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '商品名称',
  `goods_image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '商品图片',
  `sku_id` bigint NOT NULL COMMENT '商品规格id',
  `sku_code` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '商品规格编码',
  `sku_name` varchar(55) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '颜色',
  `quantity` int NOT NULL COMMENT '原始数量',
  `pur_price` decimal(10,2) NOT NULL COMMENT '入库价格',
  `in_quantity` int NOT NULL DEFAULT '0' COMMENT '入库数量',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '备注',
  `status` int DEFAULT '0' COMMENT '状态（0待入库2已入库）',
  `create_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `warehouse_id` bigint DEFAULT NULL COMMENT '仓库id',
  `position_id` bigint DEFAULT NULL COMMENT '仓位id',
  `position_num` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '仓位编码',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `specIndex` (`sku_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='入库单明细';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wms_stock_in_item`
--

LOCK TABLES `wms_stock_in_item` WRITE;
/*!40000 ALTER TABLE `wms_stock_in_item` DISABLE KEYS */;
INSERT INTO `wms_stock_in_item` VALUES (1,1,1,'aaaa',0,0,76,'DY3640','小众碎花连衣裙女夏高级感初恋裙子显瘦浪漫茶歇裙温柔风甜美气质','http://223.83.100.30:9001/omsimage/images/2024/09/07/b28f4e15-8997-418c-bd32-b4beb4966f6b.jpg',2,'DY36404302','黄色 M',14,5.00,14,'',2,'admin','2025-02-16 12:14:38','admin','2025-02-16 12:15:15',1,6,'A01-1-02'),(2,2,1,'a',0,0,76,'DY3640','小众碎花连衣裙女夏高级感初恋裙子显瘦浪漫茶歇裙温柔风甜美气质','http://223.83.100.30:9001/omsimage/images/2024/09/07/b28f4e15-8997-418c-bd32-b4beb4966f6b.jpg',3,'DY36404303','黄色 L',1,79.22,1,'',2,'admin','2025-02-18 23:11:58','admin','2025-02-18 23:12:09',1,6,'A01-1-02');
/*!40000 ALTER TABLE `wms_stock_in_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wms_stock_out`
--

DROP TABLE IF EXISTS `wms_stock_out`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wms_stock_out` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `out_num` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '出库单编号',
  `source_num` varchar(35) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '来源单据号',
  `source_id` bigint DEFAULT NULL COMMENT '来源单据Id',
  `type` int NOT NULL DEFAULT '1' COMMENT '出库类型1订单发货出库2采购退货出库3盘点出库4报损出库',
  `shop_id` bigint NOT NULL COMMENT '店铺id',
  `shop_group_id` bigint DEFAULT NULL COMMENT '店铺分组id',
  `goods_unit` int NOT NULL COMMENT '商品数',
  `spec_unit` int NOT NULL COMMENT '商品规格数',
  `spec_unit_total` int NOT NULL COMMENT '总件数',
  `out_total` int DEFAULT NULL COMMENT '已出库数量',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  `status` int NOT NULL COMMENT '状态：0待出库1部分出库2全部出库',
  `print_status` int NOT NULL COMMENT '打印状态：是否打印1已打印0未打印',
  `print_time` datetime DEFAULT NULL COMMENT '打印时间',
  `out_time` datetime DEFAULT NULL COMMENT '出库时间',
  `complete_time` datetime DEFAULT NULL COMMENT '完成出库时间',
  `operator_id` bigint DEFAULT '0' COMMENT '出库操作人userid',
  `operator_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '出库操作人',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建日期',
  `create_by` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '创建人',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `update_by` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='出库单';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wms_stock_out`
--

LOCK TABLES `wms_stock_out` WRITE;
/*!40000 ALTER TABLE `wms_stock_out` DISABLE KEYS */;
/*!40000 ALTER TABLE `wms_stock_out` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wms_stock_out_item`
--

DROP TABLE IF EXISTS `wms_stock_out_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wms_stock_out_item` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `type` int NOT NULL COMMENT '出库类型1订单拣货出库2采购退货出库3盘点出库4报损出库',
  `entry_id` bigint NOT NULL COMMENT '出库单id（外键）',
  `source_order_id` bigint DEFAULT NULL COMMENT '来源订单id',
  `source_order_item_id` bigint DEFAULT NULL COMMENT '来源订单itemId出库对应的itemId，如：order_item表id、invoice_info表id',
  `source_order_num` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '来源订单号',
  `original_quantity` bigint NOT NULL COMMENT '总数量',
  `out_quantity` bigint NOT NULL DEFAULT '0' COMMENT '已出库数量',
  `complete_time` datetime DEFAULT NULL COMMENT '完成出库时间',
  `picked_time` datetime DEFAULT NULL COMMENT '完成拣货时间',
  `status` int NOT NULL DEFAULT '0' COMMENT '状态：0待出库1部分出库2全部出库',
  `batch_id` bigint DEFAULT NULL COMMENT '库存批次id',
  `warehouse_id` bigint NOT NULL COMMENT '仓库id',
  `position_id` bigint NOT NULL COMMENT '仓位id',
  `position_num` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '仓位',
  `goods_id` bigint NOT NULL COMMENT '商品id',
  `goods_num` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '商品编码',
  `goods_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '商品名称',
  `goods_image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '商品图片',
  `sku_id` bigint NOT NULL COMMENT '商品规格id',
  `sku_code` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '商品规格编码',
  `sku_name` varchar(55) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '颜色',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '创建人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `update_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '更新人',
  `pur_price` decimal(10,2) NOT NULL COMMENT '入库价格',
  `shop_id` bigint NOT NULL COMMENT '店铺id',
  `shop_group_id` bigint DEFAULT NULL COMMENT '店铺分组id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='出库单明细';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wms_stock_out_item`
--

LOCK TABLES `wms_stock_out_item` WRITE;
/*!40000 ALTER TABLE `wms_stock_out_item` DISABLE KEYS */;
/*!40000 ALTER TABLE `wms_stock_out_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wms_stock_out_item_position`
--

DROP TABLE IF EXISTS `wms_stock_out_item_position`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wms_stock_out_item_position` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `entry_id` bigint NOT NULL COMMENT '出库单ID',
  `entry_item_id` bigint NOT NULL DEFAULT '0' COMMENT '出库单ItemID',
  `goods_inventory_id` bigint NOT NULL DEFAULT '0' COMMENT '库存ID',
  `goods_inventory_detail_id` bigint NOT NULL DEFAULT '0' COMMENT '库存详情ID',
  `quantity` bigint NOT NULL DEFAULT '0' COMMENT '出库数量',
  `location_id` int DEFAULT NULL COMMENT '出库仓位ID',
  `operator_id` int DEFAULT '0' COMMENT '出库操作人userid',
  `operator_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '出库操作人',
  `out_time` datetime DEFAULT NULL COMMENT '出库时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `goods_stock_info_item_id_index` (`goods_inventory_detail_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='出库仓位详情';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wms_stock_out_item_position`
--

LOCK TABLES `wms_stock_out_item_position` WRITE;
/*!40000 ALTER TABLE `wms_stock_out_item_position` DISABLE KEYS */;
/*!40000 ALTER TABLE `wms_stock_out_item_position` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wms_warehouse`
--

DROP TABLE IF EXISTS `wms_warehouse`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wms_warehouse` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `number` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '仓库编号',
  `name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '仓库名称',
  `province` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '省',
  `city` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '市',
  `district` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '区',
  `street` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '街道',
  `address` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '地址',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  `status` int NOT NULL DEFAULT '0' COMMENT '状态0禁用  1正常',
  `create_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='仓库表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wms_warehouse`
--

LOCK TABLES `wms_warehouse` WRITE;
/*!40000 ALTER TABLE `wms_warehouse` DISABLE KEYS */;
INSERT INTO `wms_warehouse` VALUES (1,'SHENZHEN','深圳仓库','广东省','深圳市','宝安区','福永街道',NULL,'自营仓库',1,'admin','2022-03-07 20:06:10','qihang','2025-05-06 12:16:21');
/*!40000 ALTER TABLE `wms_warehouse` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wms_warehouse_position`
--

DROP TABLE IF EXISTS `wms_warehouse_position`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wms_warehouse_position` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `warehouse_id` bigint NOT NULL COMMENT '仓库id',
  `number` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '仓库/货架编号',
  `name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '仓位/货架名称',
  `parent_id` int NOT NULL COMMENT '上级id',
  `depth` int DEFAULT '1' COMMENT '层级深度1级2级3级',
  `parent_id1` int NOT NULL COMMENT '一级类目id',
  `parent_id2` int NOT NULL COMMENT '二级类目id',
  `address` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '地址',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  `is_delete` int NOT NULL DEFAULT '0' COMMENT '0正常  1删除',
  `create_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='仓库仓位表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wms_warehouse_position`
--

LOCK TABLES `wms_warehouse_position` WRITE;
/*!40000 ALTER TABLE `wms_warehouse_position` DISABLE KEYS */;
INSERT INTO `wms_warehouse_position` VALUES (1,1,'001','深圳虚拟仓库',0,1,0,0,NULL,NULL,0,'admin','2022-03-07 20:06:10',NULL,'2022-03-07 20:06:10'),(2,1,'A','A区',1,2,1,0,NULL,NULL,0,'admin','2022-03-07 20:06:24',NULL,'2022-03-07 20:06:24'),(3,1,'B','B区',1,2,1,0,NULL,NULL,0,'admin','2022-03-07 20:06:38',NULL,'2022-03-07 20:06:38'),(4,1,'C','C区',1,2,1,0,NULL,NULL,0,'admin','2022-03-07 20:06:47',NULL,'2022-03-07 20:06:47'),(5,1,'A01-1-01','A01-1-01',2,3,1,2,NULL,NULL,0,'admin','2022-03-07 20:12:39',NULL,'2022-03-07 20:12:39'),(6,1,'A01-1-02','A01-1-02',2,3,1,2,NULL,NULL,0,'admin','2022-03-07 20:12:39',NULL,'2022-03-07 20:12:39'),(7,1,'A01-1-03','A01-1-03',2,3,1,2,NULL,NULL,0,'admin','2022-03-07 20:12:39',NULL,'2022-03-07 20:12:39'),(8,1,'A01-1-04','A01-1-04',2,3,1,2,NULL,NULL,0,'admin','2022-03-07 20:12:39',NULL,'2022-03-07 20:12:39'),(9,1,'A01-1-05','A01-1-05',2,3,1,2,NULL,NULL,0,'admin','2022-03-07 20:12:39',NULL,'2022-03-07 20:12:39'),(10,1,'A01-1-06','A01-1-06',2,3,1,2,NULL,NULL,0,'admin','2022-03-07 20:12:39',NULL,'2022-03-07 20:12:39'),(11,1,'A01-1-07','A01-1-07',2,3,1,2,NULL,NULL,0,'admin','2022-03-07 20:12:39',NULL,'2022-03-07 20:12:39'),(12,1,'A01-1-08','A01-1-08',2,3,1,2,NULL,NULL,0,'admin','2022-03-07 20:12:39',NULL,'2022-03-07 20:12:39'),(13,1,'A01-1-09','A01-1-09',2,3,1,2,NULL,NULL,0,'admin','2022-03-07 20:12:39',NULL,'2022-03-07 20:12:39'),(14,1,'A01-1-10','A01-1-10',2,3,1,2,NULL,NULL,0,'admin','2022-03-07 20:12:39',NULL,'2022-03-07 20:12:39'),(15,1,'A01-1-11','A01-1-11',2,3,1,2,NULL,NULL,0,'admin','2022-03-07 20:12:39',NULL,'2022-03-07 20:12:39'),(16,1,'A01-1-12','A01-1-12',2,3,1,2,NULL,NULL,0,'admin','2022-03-07 20:12:39',NULL,'2022-03-07 20:12:39'),(17,1,'A01-1-13','A01-1-13',2,3,1,2,NULL,NULL,0,'admin','2022-03-07 20:12:39',NULL,'2022-03-07 20:12:39'),(18,1,'A01-1-14','A01-1-14',2,3,1,2,NULL,NULL,0,'admin','2022-03-07 20:12:39',NULL,'2022-03-07 20:12:39'),(19,1,'A01-1-15','A01-1-15',2,3,1,2,NULL,NULL,0,'admin','2022-03-07 20:12:39',NULL,'2022-03-07 20:12:39'),(20,1,'A01-1-16','A01-1-16',2,3,1,2,NULL,NULL,0,'admin','2022-03-07 20:12:39',NULL,'2022-03-07 20:12:39');
/*!40000 ALTER TABLE `wms_warehouse_position` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-05-17 16:25:53
