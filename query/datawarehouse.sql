/*
 Navicat Premium Data Transfer

 Source Server         : demo
 Source Server Type    : MySQL
 Source Server Version : 100427 (10.4.27-MariaDB)
 Source Host           : localhost:3306
 Source Schema         : datawarehouse

 Target Server Type    : MySQL
 Target Server Version : 100427 (10.4.27-MariaDB)
 File Encoding         : 65001

 Date: 15/12/2023 23:49:27
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for dimarea
-- ----------------------------
DROP TABLE IF EXISTS `dimarea`;
CREATE TABLE `dimarea`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `area` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_date` datetime NOT NULL,
  `update_date` datetime NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for dimdate
-- ----------------------------
DROP TABLE IF EXISTS `dimdate`;
CREATE TABLE `dimdate`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `full_date` date NULL DEFAULT NULL,
  `day` int NULL DEFAULT NULL,
  `month` int NULL DEFAULT NULL,
  `year` int NULL DEFAULT NULL,
  `quarter_of_year` int NULL DEFAULT NULL,
  `update_date` datetime NULL DEFAULT current_timestamp,
  `create_date` datetime NULL DEFAULT current_timestamp,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 28 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for dimprize
-- ----------------------------
DROP TABLE IF EXISTS `dimprize`;
CREATE TABLE `dimprize`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name_prize` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_date` datetime NOT NULL DEFAULT current_timestamp,
  `update_date` datetime NOT NULL DEFAULT current_timestamp,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 450 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for dimprovince
-- ----------------------------
DROP TABLE IF EXISTS `dimprovince`;
CREATE TABLE `dimprovince`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `province` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `update_date` datetime NULL DEFAULT current_timestamp,
  `create_date` datetime NULL DEFAULT current_timestamp,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 141 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for factlottery
-- ----------------------------
DROP TABLE IF EXISTS `factlottery`;
CREATE TABLE `factlottery`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `province_id` int NULL DEFAULT NULL,
  `date_lottery_id` int NULL DEFAULT NULL,
  `prize_id` int NOT NULL,
  `result` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `area_id` int NOT NULL,
  `create_date` datetime NULL DEFAULT current_timestamp,
  `update_date` datetime NULL DEFAULT current_timestamp,
  `expiration_date` datetime NULL DEFAULT (current_timestamp() + interval 30 year),
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK_DATE`(`date_lottery_id` ASC) USING BTREE,
  INDEX `FK_PROVINCE`(`province_id` ASC) USING BTREE,
  INDEX `FK_PRIZE`(`prize_id` ASC) USING BTREE,
  INDEX `FK_AREA`(`area_id` ASC) USING BTREE,
  CONSTRAINT `FK_AREA` FOREIGN KEY (`area_id`) REFERENCES `dimarea` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_DATE` FOREIGN KEY (`date_lottery_id`) REFERENCES `dimdate` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_PRIZE` FOREIGN KEY (`prize_id`) REFERENCES `dimprize` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_PROVINCE` FOREIGN KEY (`province_id`) REFERENCES `dimprovince` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 13072 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for lottery_aggregate
-- ----------------------------
DROP TABLE IF EXISTS `lottery_aggregate`;
CREATE TABLE `lottery_aggregate`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `province` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `area` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `name_prize` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `result` int NOT NULL,
  `date_lottery` date NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 128 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Procedure structure for aggregate
-- ----------------------------
DROP PROCEDURE IF EXISTS `aggregate`;
delimiter ;;
CREATE PROCEDURE `aggregate`()
BEGIN
		truncate datawarehouse.lottery_aggregate;
		insert into datawarehouse.lottery_aggregate (province, area, name_prize, result, date_lottery)
		select dimprovince.province, dimarea.area, dimprize.name_prize, factlottery.result, dimdate.full_date from factlottery join dimdate on factlottery.date_lottery_id = dimdate.id join dimprovince on factlottery.province_id = dimprovince.id join dimarea on factlottery.area_id = dimarea.id join dimprize on factlottery.prize_id = dimprize.id where 								factlottery.expiration_date > CURRENT_TIME();

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for load_to_data_mart
-- ----------------------------
DROP PROCEDURE IF EXISTS `load_to_data_mart`;
delimiter ;;
CREATE PROCEDURE `load_to_data_mart`()
BEGIN

		truncate datamart.data_mart;
		insert into datamart.data_mart (province, area, name_prize, result, date_lottery)
		select province, area, name_prize, result, date_lottery from datawarehouse.lottery_aggregate;
		
END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
