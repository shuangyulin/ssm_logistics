-- phpMyAdmin SQL Dump
-- version 3.0.1.1
-- http://www.phpmyadmin.net
--
-- 服务器版本: 5.1.29
-- PHP 版本: 5.2.6

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

-- --------------------------------------------------------

-- ----------------------------
-- Table structure for `admin`
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `username` varchar(20) NOT NULL DEFAULT '',
  `password` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_admin
-- ----------------------------
INSERT INTO `admin` VALUES ('a', 'a'); 

CREATE TABLE IF NOT EXISTS `t_userInfo` (
  `user_name` varchar(30)  NOT NULL COMMENT 'user_name',
  `password` varchar(30)  NOT NULL COMMENT '登录密码',
  `name` varchar(20)  NOT NULL COMMENT '姓名',
  `gender` varchar(4)  NOT NULL COMMENT '性别',
  `birthDate` varchar(20)  NULL COMMENT '出生日期',
  `userPhoto` varchar(60)  NOT NULL COMMENT '用户照片',
  `telephone` varchar(20)  NOT NULL COMMENT '联系电话',
  `email` varchar(50)  NOT NULL COMMENT '邮箱',
  `address` varchar(80)  NULL COMMENT '家庭地址',
  `regTime` varchar(20)  NULL COMMENT '注册时间',
  PRIMARY KEY (`user_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `t_workMan` (
  `workUserName` varchar(30)  NOT NULL COMMENT 'workUserName',
  `password` varchar(30)  NOT NULL COMMENT '登录密码',
  `name` varchar(20)  NOT NULL COMMENT '姓名',
  `gender` varchar(4)  NOT NULL COMMENT '性别',
  `birthDate` varchar(20)  NULL COMMENT '出生日期',
  `workManPhoto` varchar(60)  NOT NULL COMMENT '工作人员照片',
  `telephone` varchar(20)  NOT NULL COMMENT '联系电话',
  `address` varchar(80)  NULL COMMENT '家庭地址',
  `workManMemo` varchar(800)  NULL COMMENT '备注信息',
  PRIMARY KEY (`workUserName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `t_cangku` (
  `cangkuId` int(11) NOT NULL AUTO_INCREMENT COMMENT '仓库id',
  `diqu` varchar(20)  NOT NULL COMMENT '所在地区',
  `cangkuName` varchar(20)  NOT NULL COMMENT '仓库名称',
  `mianji` varchar(20)  NOT NULL COMMENT '仓库面积',
  `tdl` varchar(20)  NOT NULL COMMENT '仓库吞吐量',
  `lianxiren` varchar(20)  NOT NULL COMMENT '联系人',
  `telephone` varchar(20)  NOT NULL COMMENT '联系电话',
  `address` varchar(80)  NOT NULL COMMENT '仓库地址',
  `cangkuMemo` varchar(800)  NULL COMMENT '仓库备注',
  PRIMARY KEY (`cangkuId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_wuzi` (
  `wuliuNo` varchar(20)  NOT NULL COMMENT 'wuliuNo',
  `wuziClassObj` int(11) NOT NULL COMMENT '物资分类',
  `wuziName` varchar(20)  NOT NULL COMMENT '物资名称',
  `zhongliang` varchar(20)  NOT NULL COMMENT '物资重量',
  `wuziDesc` varchar(8000)  NOT NULL COMMENT '物资详情',
  `userObj` varchar(30)  NOT NULL COMMENT '寄件人',
  `sendTelephone` varchar(30)  NOT NULL COMMENT '寄件人电话',
  `sendAddress` varchar(80)  NOT NULL COMMENT '寄件人地址',
  `receiveUserObj` varchar(30)  NOT NULL COMMENT '收件人',
  `receiveTelephone` varchar(20)  NOT NULL COMMENT '收件人电话',
  `receiveAddress` varchar(80)  NOT NULL COMMENT '收件人地址',
  `yunfei` float NOT NULL COMMENT '运费',
  `wldt` varchar(800)  NOT NULL COMMENT '物流动态',
  `wuziMemo` varchar(800)  NULL COMMENT '备注信息',
  PRIMARY KEY (`wuliuNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `t_ruku` (
  `rukuId` int(11) NOT NULL AUTO_INCREMENT COMMENT '入库id',
  `wuziObj` varchar(20)  NOT NULL COMMENT '入库物资',
  `wuziClassObj` int(11) NOT NULL COMMENT '物资种类',
  `zhongliang` varchar(20)  NOT NULL COMMENT '重量',
  `cangkuObj` int(11) NOT NULL COMMENT '入库仓库',
  `rukuTime` varchar(20)  NULL COMMENT '入库时间',
  `okFlag` varchar(20)  NOT NULL COMMENT '是否完好',
  `workManObj` varchar(30)  NOT NULL COMMENT '工作人员',
  `rukuMemo` varchar(800)  NULL COMMENT '入库备注',
  PRIMARY KEY (`rukuId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_chuku` (
  `chukuId` int(11) NOT NULL AUTO_INCREMENT COMMENT '出库id',
  `wuziObj` varchar(20)  NOT NULL COMMENT '出库物资',
  `wuziClassObj` int(11) NOT NULL COMMENT '物资种类',
  `zhongliang` varchar(20)  NOT NULL COMMENT '重量',
  `cangkuObj` int(11) NOT NULL COMMENT '出库仓库',
  `chukuTime` varchar(20)  NULL COMMENT '出库时间',
  `okFlag` varchar(20)  NOT NULL COMMENT '是否完好',
  `workManObj` varchar(30)  NOT NULL COMMENT '工作人员',
  `chukuMemo` varchar(800)  NULL COMMENT '出库备注',
  PRIMARY KEY (`chukuId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_wuziClass` (
  `wuziClassId` int(11) NOT NULL AUTO_INCREMENT COMMENT '物资种类id',
  `wuziClassName` varchar(20)  NOT NULL COMMENT '物资种类名称',
  PRIMARY KEY (`wuziClassId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

ALTER TABLE t_wuzi ADD CONSTRAINT FOREIGN KEY (wuziClassObj) REFERENCES t_wuziClass(wuziClassId);
ALTER TABLE t_wuzi ADD CONSTRAINT FOREIGN KEY (userObj) REFERENCES t_userInfo(user_name);
ALTER TABLE t_wuzi ADD CONSTRAINT FOREIGN KEY (receiveUserObj) REFERENCES t_userInfo(user_name);
ALTER TABLE t_ruku ADD CONSTRAINT FOREIGN KEY (wuziObj) REFERENCES t_wuzi(wuliuNo);
ALTER TABLE t_ruku ADD CONSTRAINT FOREIGN KEY (wuziClassObj) REFERENCES t_wuziClass(wuziClassId);
ALTER TABLE t_ruku ADD CONSTRAINT FOREIGN KEY (cangkuObj) REFERENCES t_cangku(cangkuId);
ALTER TABLE t_ruku ADD CONSTRAINT FOREIGN KEY (workManObj) REFERENCES t_workMan(workUserName);
ALTER TABLE t_chuku ADD CONSTRAINT FOREIGN KEY (wuziObj) REFERENCES t_wuzi(wuliuNo);
ALTER TABLE t_chuku ADD CONSTRAINT FOREIGN KEY (wuziClassObj) REFERENCES t_wuziClass(wuziClassId);
ALTER TABLE t_chuku ADD CONSTRAINT FOREIGN KEY (cangkuObj) REFERENCES t_cangku(cangkuId);
ALTER TABLE t_chuku ADD CONSTRAINT FOREIGN KEY (workManObj) REFERENCES t_workMan(workUserName);


