/*
 Navicat Premium Data Transfer

 Source Server         : student
 Source Server Type    : MySQL
 Source Server Version : 80023
 Source Host           : localhost:3305
 Source Schema         : ssm_crud

 Target Server Type    : MySQL
 Target Server Version : 80023
 File Encoding         : 65001

 Date: 05/07/2023 18:59:08
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for tbl_dept
-- ----------------------------
DROP TABLE IF EXISTS `tbl_dept`;
CREATE TABLE `tbl_dept`  (
  `dept_id` int NOT NULL AUTO_INCREMENT,
  `dept_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `dept_num` int NOT NULL,
  `dept_manager` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`dept_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tbl_dept
-- ----------------------------
INSERT INTO `tbl_dept` VALUES (2, '后端部门', 2, '范炼宋');
INSERT INTO `tbl_dept` VALUES (3, '前端部门', 3, '刘国庆');
INSERT INTO `tbl_dept` VALUES (9, '前端部门', 88, '陈伟超');

-- ----------------------------
-- Table structure for tbl_emp
-- ----------------------------
DROP TABLE IF EXISTS `tbl_emp`;
CREATE TABLE `tbl_emp`  (
  `emp_id` int NOT NULL AUTO_INCREMENT,
  `emp_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `gender` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `d_id` int NOT NULL,
  PRIMARY KEY (`emp_id`) USING BTREE,
  INDEX `d_id`(`d_id`) USING BTREE,
  INDEX `emp_id`(`emp_id`) USING BTREE,
  INDEX `emp_id_2`(`emp_id`) USING BTREE,
  INDEX `emp_id_3`(`emp_id`) USING BTREE,
  CONSTRAINT `d_id` FOREIGN KEY (`d_id`) REFERENCES `tbl_dept` (`dept_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 8143 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tbl_emp
-- ----------------------------
INSERT INTO `tbl_emp` VALUES (4740, '林佩超', 'M', '4740@163.com', 2);
INSERT INTO `tbl_emp` VALUES (8139, '范炼宋', 'M', '8139@163.com', 2);
INSERT INTO `tbl_emp` VALUES (8141, '陈伟超', 'M', '5047@qq.com', 2);

-- ----------------------------
-- Table structure for tbl_salary
-- ----------------------------
DROP TABLE IF EXISTS `tbl_salary`;
CREATE TABLE `tbl_salary`  (
  `emp_id` int NOT NULL,
  `emp_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `dept_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `base_salary` int NOT NULL DEFAULT 0,
  `bonus` int NOT NULL DEFAULT 0,
  `insurance` float NOT NULL DEFAULT 0,
  `before_salary` float(10, 2) NOT NULL DEFAULT 0.00,
  `after_salary` float(10, 2) NOT NULL DEFAULT 0.00,
  PRIMARY KEY (`emp_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tbl_salary
-- ----------------------------
INSERT INTO `tbl_salary` VALUES (3130, '刘国庆', '前端部门', 20000, 2000, 200, 21800.00, 19850.00);
INSERT INTO `tbl_salary` VALUES (4740, '林佩超', '后端部门', 25000, 10, 200, 24810.00, 22258.00);
INSERT INTO `tbl_salary` VALUES (5047, '陈伟超', '测试部门', 20000, 10, 200, 19810.00, 18258.00);
INSERT INTO `tbl_salary` VALUES (5425, '范炼宋', '后端部门', 8000, 100, 200, 7900.00, 7813.00);

SET FOREIGN_KEY_CHECKS = 1;
