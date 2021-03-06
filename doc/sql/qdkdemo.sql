/*
SQLyog Enterprise - MySQL GUI v7.14 
MySQL - 5.5.27 : Database - teacherdemo
*********************************************************************
*/


/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

CREATE DATABASE /*!32312 IF NOT EXISTS*/`teacherdemo` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `teacherdemo`;

/*Table structure for table `teacher` */

DROP TABLE IF EXISTS `teacherinfo`;

CREATE TABLE `teacherinfo` (
  `id` varchar(32) NOT NULL,
  `teacherAccount` varchar(50) DEFAULT NULL,
  `teacherName` varchar(255) DEFAULT NULL,
  `teacherSex` char(1) DEFAULT NULL,
  `teacherPhone` varchar(11) DEFAULT NULL,
  `teacherEmail` varchar(50) CHECK(teacherEmail LIKE '%@%'),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `teacherinfo` */

insert  into `teacherinfo`(`id`,`teacherAccount`,`teacherName`,`teacherSex`,`teacherPhone`,`teacherEmail`) values ('55409718de2fd6a2e391cc0f00000000','blog-01','This is the content of blog-01.x','55403fb7de2f15115a30f36700000000'),('55409d7ade2fd6a2e391cc1400000000','blog-02','blog-02blog-02blog-02blog-02blog-02blog-02blog-02','55403fb7de2f15115a30f36700000000'),('55409dc5de2fd6a2e391cc1500000000','blog-03','blog-03blog-03blog-03blog-03blog-03blog-03blog-03','55403fb7de2f15115a30f36700000000'),('55409dd3de2fd6a2e391cc1600000000','blog-04','blog-04blog-04blog-04blog-04blog-04','55403fb7de2f15115a30f36700000000'),('55409de5de2fd6a2e391cc1700000000','blog-05','blog-05blog-05blog-05blog-05blog-05','55403fb7de2f15115a30f36700000000'),('55409df4de2fd6a2e391cc1800000000','blog-06','blog-06blog-06blog-06blog-06blog-06','55403fb7de2f15115a30f36700000000'),('55409e00de2fd6a2e391cc1900000000','blog-07','blog-07blog-07blog-07blog-07blog-07','55403fb7de2f15115a30f36700000000'),('55409e09de2fd6a2e391cc1a00000000','blog-08','blog-08','55403fb7de2f15115a30f36700000000'),('55409e18de2fd6a2e391cc1b00000000','blog-09','blog-09blog-09blog-09blog-09blog-09','55403fb7de2f15115a30f36700000000'),('55409e23de2fd6a2e391cc1c00000000','blog-10','blog-10blog-10blog-10blog-10blog-10','55403fb7de2f15115a30f36700000000'),('55409e2fde2fd6a2e391cc1d00000000','blog-11','blog-11blog-11blog-11blog-11blog-11blog-11','55403fb7de2f15115a30f36700000000'),('55409e39de2fd6a2e391cc1e00000000','blog-12','blog-12blog-12blog-12blog-12blog-12blog-12','55403fb7de2f15115a30f36700000000'),('55409e45de2fd6a2e391cc1f00000000','blog-13','blog-13blog-13blog-13blog-13blog-13','55403fb7de2f15115a30f36700000000'),('55409e4ede2fd6a2e391cc2000000000','blog-14','blog-14blog-14blog-14blog-14blog-14','55403fb7de2f15115a30f36700000000'),('55409e58de2fd6a2e391cc2100000000','blog-15','blog-15blog-15blog-15blog-15blog-15blog-15','55403fb7de2f15115a30f36700000000');

/*Table structure for table `user` */

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `id` varchar(32) NOT NULL,
  `loginId` varchar(24) NOT NULL,
  `password` varchar(50) NOT NULL,
  `sex` char(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `user` */

insert  into `user`(`id`,`loginId`,`password`,`sex`) values ('55403fb7de2f15115a30f36700000000','Linxy','e10adc3949ba59abbe56e057f20f883e','1');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
