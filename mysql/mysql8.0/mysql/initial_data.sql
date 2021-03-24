/*
 Navicat Premium Data Transfer

 Source Server         : 192.168.5.119
 Source Server Type    : MySQL
 Source Server Version : 50726
 Source Host           : 192.168.5.119:3306
 Source Schema         : loamen_demo

 Target Server Type    : MySQL
 Target Server Version : 50726
 File Encoding         : 65001

 Date: 13/07/2020 15:34:49
*/
USE loamen_demo;
SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;
CREATE TABLE `demo`  (
  `id` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `create_time` datetime(0) NOT NULL COMMENT '创建时间',
  `update_time` datetime(0) NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 ROW_FORMAT = Dynamic;
SET FOREIGN_KEY_CHECKS = 1;