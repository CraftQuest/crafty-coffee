# ************************************************************
# Sequel Pro SQL dump
# Version 4541
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: 127.0.0.1 (MySQL 5.5.5-10.3.10-MariaDB)
# Database: craftycoffee2020-manual
# Generation Time: 2020-02-29 21:31:32 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table assetindexdata
# ------------------------------------------------------------

DROP TABLE IF EXISTS `assetindexdata`;

CREATE TABLE `assetindexdata` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sessionId` varchar(36) NOT NULL DEFAULT '',
  `volumeId` int(11) NOT NULL,
  `uri` text DEFAULT NULL,
  `size` bigint(20) unsigned DEFAULT NULL,
  `timestamp` datetime DEFAULT NULL,
  `recordId` int(11) DEFAULT NULL,
  `inProgress` tinyint(1) DEFAULT 0,
  `completed` tinyint(1) DEFAULT 0,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `assetindexdata_sessionId_volumeId_idx` (`sessionId`,`volumeId`),
  KEY `assetindexdata_volumeId_idx` (`volumeId`),
  CONSTRAINT `assetindexdata_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table assets
# ------------------------------------------------------------

DROP TABLE IF EXISTS `assets`;

CREATE TABLE `assets` (
  `id` int(11) NOT NULL,
  `volumeId` int(11) DEFAULT NULL,
  `folderId` int(11) NOT NULL,
  `uploaderId` int(11) DEFAULT NULL,
  `filename` varchar(255) NOT NULL,
  `kind` varchar(50) NOT NULL DEFAULT 'unknown',
  `width` int(11) unsigned DEFAULT NULL,
  `height` int(11) unsigned DEFAULT NULL,
  `size` bigint(20) unsigned DEFAULT NULL,
  `focalPoint` varchar(13) DEFAULT NULL,
  `deletedWithVolume` tinyint(1) DEFAULT NULL,
  `keptFile` tinyint(1) DEFAULT NULL,
  `dateModified` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `assets_filename_folderId_idx` (`filename`,`folderId`),
  KEY `assets_folderId_idx` (`folderId`),
  KEY `assets_volumeId_idx` (`volumeId`),
  KEY `assets_uploaderId_fk` (`uploaderId`),
  CONSTRAINT `assets_folderId_fk` FOREIGN KEY (`folderId`) REFERENCES `volumefolders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `assets_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `assets_uploaderId_fk` FOREIGN KEY (`uploaderId`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `assets_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `assets` WRITE;
/*!40000 ALTER TABLE `assets` DISABLE KEYS */;

INSERT INTO `assets` (`id`, `volumeId`, `folderId`, `uploaderId`, `filename`, `kind`, `width`, `height`, `size`, `focalPoint`, `deletedWithVolume`, `keptFile`, `dateModified`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(15,1,1,1,'espresso-shot.jpg','image',1200,689,41638,NULL,NULL,NULL,'2020-02-09 17:51:08','2020-02-09 17:51:08','2020-02-09 17:51:08','5f9ea8c4-7abd-4513-b6a3-1a369e86b10b'),
	(17,1,1,1,'iced-coffee.jpg','image',1200,971,73675,NULL,NULL,NULL,'2020-02-09 19:10:14','2020-02-09 19:10:14','2020-02-09 19:10:14','1356f098-3e22-484a-aa81-23af38669d01');

/*!40000 ALTER TABLE `assets` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table assettransformindex
# ------------------------------------------------------------

DROP TABLE IF EXISTS `assettransformindex`;

CREATE TABLE `assettransformindex` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `assetId` int(11) NOT NULL,
  `filename` varchar(255) DEFAULT NULL,
  `format` varchar(255) DEFAULT NULL,
  `location` varchar(255) NOT NULL,
  `volumeId` int(11) DEFAULT NULL,
  `fileExists` tinyint(1) NOT NULL DEFAULT 0,
  `inProgress` tinyint(1) NOT NULL DEFAULT 0,
  `dateIndexed` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `assettransformindex_volumeId_assetId_location_idx` (`volumeId`,`assetId`,`location`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table assettransforms
# ------------------------------------------------------------

DROP TABLE IF EXISTS `assettransforms`;

CREATE TABLE `assettransforms` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `mode` enum('stretch','fit','crop') NOT NULL DEFAULT 'crop',
  `position` enum('top-left','top-center','top-right','center-left','center-center','center-right','bottom-left','bottom-center','bottom-right') NOT NULL DEFAULT 'center-center',
  `width` int(11) unsigned DEFAULT NULL,
  `height` int(11) unsigned DEFAULT NULL,
  `format` varchar(255) DEFAULT NULL,
  `quality` int(11) DEFAULT NULL,
  `interlace` enum('none','line','plane','partition') NOT NULL DEFAULT 'none',
  `dimensionChangeTime` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `assettransforms_name_unq_idx` (`name`),
  UNIQUE KEY `assettransforms_handle_unq_idx` (`handle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `assettransforms` WRITE;
/*!40000 ALTER TABLE `assettransforms` DISABLE KEYS */;

INSERT INTO `assettransforms` (`id`, `name`, `handle`, `mode`, `position`, `width`, `height`, `format`, `quality`, `interlace`, `dimensionChangeTime`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,'840x200 Thumb','EightFortyTwoHundredThumb','crop','center-center',840,200,NULL,NULL,'none','2020-02-09 19:09:44','2020-02-09 19:09:44','2020-02-09 19:09:44','e3377f7e-711b-46db-8988-88dd06c0b202');

/*!40000 ALTER TABLE `assettransforms` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table categories
# ------------------------------------------------------------

DROP TABLE IF EXISTS `categories`;

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `parentId` int(11) DEFAULT NULL,
  `deletedWithGroup` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `categories_groupId_idx` (`groupId`),
  KEY `categories_parentId_fk` (`parentId`),
  CONSTRAINT `categories_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `categorygroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `categories_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `categories_parentId_fk` FOREIGN KEY (`parentId`) REFERENCES `categories` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;

INSERT INTO `categories` (`id`, `groupId`, `parentId`, `deletedWithGroup`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(451,1,NULL,NULL,'2020-02-15 22:47:46','2020-02-15 22:47:46','45251066-661d-448b-8938-99f51b1fa4b9'),
	(467,1,NULL,NULL,'2020-02-15 23:57:34','2020-02-15 23:57:34','d0d9b5e3-df74-4126-b082-748b3b17300f');

/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table categorygroups
# ------------------------------------------------------------

DROP TABLE IF EXISTS `categorygroups`;

CREATE TABLE `categorygroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `categorygroups_name_idx` (`name`),
  KEY `categorygroups_handle_idx` (`handle`),
  KEY `categorygroups_structureId_idx` (`structureId`),
  KEY `categorygroups_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `categorygroups_dateDeleted_idx` (`dateDeleted`),
  CONSTRAINT `categorygroups_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `categorygroups_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `structures` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `categorygroups` WRITE;
/*!40000 ALTER TABLE `categorygroups` DISABLE KEYS */;

INSERT INTO `categorygroups` (`id`, `structureId`, `fieldLayoutId`, `name`, `handle`, `dateCreated`, `dateUpdated`, `dateDeleted`, `uid`)
VALUES
	(1,2,11,'Drink Styles','drinkStyles','2020-02-15 22:45:15','2020-02-15 22:47:01',NULL,'e8331de6-f36c-47ca-88ea-58d08765edc9');

/*!40000 ALTER TABLE `categorygroups` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table categorygroups_sites
# ------------------------------------------------------------

DROP TABLE IF EXISTS `categorygroups_sites`;

CREATE TABLE `categorygroups_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT 1,
  `uriFormat` text DEFAULT NULL,
  `template` varchar(500) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `categorygroups_sites_groupId_siteId_unq_idx` (`groupId`,`siteId`),
  KEY `categorygroups_sites_siteId_idx` (`siteId`),
  CONSTRAINT `categorygroups_sites_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `categorygroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `categorygroups_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `categorygroups_sites` WRITE;
/*!40000 ALTER TABLE `categorygroups_sites` DISABLE KEYS */;

INSERT INTO `categorygroups_sites` (`id`, `groupId`, `siteId`, `hasUrls`, `uriFormat`, `template`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,1,1,1,'styles/{slug}','styles/_entry','2020-02-15 22:45:15','2020-02-15 22:45:15','2b6116b4-5b54-4082-889d-2f8bef1fafc4');

/*!40000 ALTER TABLE `categorygroups_sites` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table changedattributes
# ------------------------------------------------------------

DROP TABLE IF EXISTS `changedattributes`;

CREATE TABLE `changedattributes` (
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `attribute` varchar(255) NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `propagated` tinyint(1) NOT NULL,
  `userId` int(11) DEFAULT NULL,
  PRIMARY KEY (`elementId`,`siteId`,`attribute`),
  KEY `changedattributes_elementId_siteId_dateUpdated_idx` (`elementId`,`siteId`,`dateUpdated`),
  KEY `changedattributes_siteId_fk` (`siteId`),
  KEY `changedattributes_userId_fk` (`userId`),
  CONSTRAINT `changedattributes_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `changedattributes_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `changedattributes_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `changedattributes` WRITE;
/*!40000 ALTER TABLE `changedattributes` DISABLE KEYS */;

INSERT INTO `changedattributes` (`elementId`, `siteId`, `attribute`, `dateUpdated`, `propagated`, `userId`)
VALUES
	(5,1,'title','2020-02-09 21:26:21',0,1),
	(11,1,'fieldLayoutId','2020-02-09 17:32:34',0,1),
	(11,1,'title','2020-02-09 20:46:41',0,1),
	(19,1,'title','2020-02-15 23:27:27',0,1),
	(22,1,'fieldLayoutId','2020-02-09 20:13:39',0,1),
	(22,1,'uri','2020-02-09 19:30:06',0,1),
	(25,1,'fieldLayoutId','2020-02-09 20:13:39',0,1),
	(25,1,'uri','2020-02-09 19:27:42',0,1),
	(28,1,'fieldLayoutId','2020-02-09 20:13:39',0,1),
	(28,1,'uri','2020-02-09 19:30:06',0,1),
	(31,1,'fieldLayoutId','2020-02-09 20:13:39',0,1),
	(31,1,'uri','2020-02-09 19:27:42',0,1);

/*!40000 ALTER TABLE `changedattributes` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table changedfields
# ------------------------------------------------------------

DROP TABLE IF EXISTS `changedfields`;

CREATE TABLE `changedfields` (
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `propagated` tinyint(1) NOT NULL,
  `userId` int(11) DEFAULT NULL,
  PRIMARY KEY (`elementId`,`siteId`,`fieldId`),
  KEY `changedfields_elementId_siteId_dateUpdated_idx` (`elementId`,`siteId`,`dateUpdated`),
  KEY `changedfields_siteId_fk` (`siteId`),
  KEY `changedfields_fieldId_fk` (`fieldId`),
  KEY `changedfields_userId_fk` (`userId`),
  CONSTRAINT `changedfields_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `changedfields_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `changedfields_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `changedfields_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `changedfields` WRITE;
/*!40000 ALTER TABLE `changedfields` DISABLE KEYS */;

INSERT INTO `changedfields` (`elementId`, `siteId`, `fieldId`, `dateUpdated`, `propagated`, `userId`)
VALUES
	(5,1,1,'2020-02-09 21:26:21',0,1),
	(5,1,5,'2020-02-09 19:06:20',0,1),
	(5,1,17,'2020-02-15 22:51:27',0,1),
	(5,1,18,'2020-02-16 00:02:47',0,1),
	(11,1,6,'2020-02-09 20:47:42',0,1),
	(19,1,17,'2020-02-15 23:27:27',0,1),
	(19,1,18,'2020-02-16 00:02:37',0,1),
	(22,1,2,'2020-02-09 20:14:18',0,1),
	(22,1,6,'2020-02-09 20:14:18',0,1),
	(22,1,7,'2020-02-09 20:14:18',0,1),
	(25,1,2,'2020-02-15 20:21:36',0,1),
	(25,1,6,'2020-02-15 20:21:36',0,1),
	(25,1,7,'2020-02-15 20:21:36',0,1),
	(28,1,2,'2020-02-15 20:57:07',0,1),
	(28,1,6,'2020-02-15 20:57:07',0,1),
	(28,1,7,'2020-02-15 20:57:07',0,1),
	(31,1,2,'2020-02-09 20:13:39',0,1),
	(31,1,6,'2020-02-09 20:13:39',0,1),
	(31,1,7,'2020-02-09 20:13:39',0,1),
	(381,1,17,'2020-02-15 22:50:45',0,1);

/*!40000 ALTER TABLE `changedfields` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table content
# ------------------------------------------------------------

DROP TABLE IF EXISTS `content`;

CREATE TABLE `content` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `field_introduction` text DEFAULT NULL,
  `field_pageCopy` text DEFAULT NULL,
  `field_excerpt` text DEFAULT NULL,
  `field_newsBody` text DEFAULT NULL,
  `field_subtitle` text DEFAULT NULL,
  `field_pageIntro` text DEFAULT NULL,
  `field_styleDescription` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `content_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `content_siteId_idx` (`siteId`),
  KEY `content_title_idx` (`title`),
  CONSTRAINT `content_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `content_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `content` WRITE;
/*!40000 ALTER TABLE `content` DISABLE KEYS */;

INSERT INTO `content` (`id`, `elementId`, `siteId`, `title`, `dateCreated`, `dateUpdated`, `uid`, `field_introduction`, `field_pageCopy`, `field_excerpt`, `field_newsBody`, `field_subtitle`, `field_pageIntro`, `field_styleDescription`)
VALUES
	(1,1,1,NULL,'2020-02-01 17:54:17','2020-02-09 21:37:28','d6c130fd-1f4e-437e-8a36-ed61e79a2ead',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(2,2,1,NULL,'2020-02-01 20:56:39','2020-02-01 20:56:39','62921278-9d87-4024-8c48-076a05f09a30',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(3,3,1,NULL,'2020-02-01 21:07:32','2020-02-01 21:07:32','613b5a02-8eb2-42d6-b91c-7a9aa6a2fee8',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(5,5,1,'Perfect Espresso','2020-02-01 21:10:00','2020-02-16 00:02:47','823668a1-7fa8-4514-b035-480da79e68aa','The best shot you\'ve ever had.','<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p>',NULL,NULL,NULL,NULL,NULL),
	(6,6,1,'Espresso','2020-02-01 21:10:00','2020-02-01 21:10:00','8faebb8e-b494-4c24-9a81-1c6d03393729','News article lede or summary.','<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p>',NULL,NULL,NULL,NULL,NULL),
	(7,7,1,NULL,'2020-02-01 21:10:40','2020-02-01 21:10:40','7d7f22cf-aeb8-4c46-81e1-833c282c2a33',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(9,9,1,'New coffee coming soon','2020-02-01 21:11:44','2020-02-01 21:11:44','2ffb73de-9bf8-4e23-812c-e1138913fcb7',NULL,NULL,'Check out the new coffee style coming to Crafty Coffee!','<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p>',NULL,NULL,NULL),
	(10,10,1,'New coffee coming soon','2020-02-01 21:11:44','2020-02-01 21:11:44','9da91ed7-8905-4d99-b716-c20a932a71ef',NULL,NULL,'Check out the new coffee style coming to Crafty Coffee!','<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p>',NULL,NULL,NULL),
	(11,11,1,'Crafty Coffee','2020-02-09 17:31:35','2020-02-09 20:47:42','a4179973-70fe-4377-8a39-d442efa3c30b',NULL,NULL,NULL,NULL,'If we wrote it down, you can make it at homezzzzz',NULL,NULL),
	(12,12,1,'Homepage','2020-02-09 17:31:35','2020-02-09 17:31:35','5676135a-55c1-43d7-a3c2-98cbfe845eb0',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(13,13,1,'Homepage','2020-02-09 17:31:36','2020-02-09 17:31:36','50755f78-98ef-4c21-969f-195286c7d6bd',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(14,14,1,'Homepage','2020-02-09 17:32:33','2020-02-09 17:32:33','d6f83426-6e2e-4e64-b222-17003c5267d4',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(15,15,1,'Espresso shot','2020-02-09 17:51:07','2020-02-09 17:51:07','13b1cd84-df6f-42c8-b806-aef57ca3496e',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(16,16,1,'Espresso','2020-02-09 19:06:20','2020-02-09 19:06:20','3c0212e8-68d9-44a8-ab28-91a066fea5ea','News article lede or summary.','<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p>',NULL,NULL,NULL,NULL,NULL),
	(17,17,1,'Iced coffee','2020-02-09 19:10:14','2020-02-09 19:10:14','f47ee976-b42c-4dd5-a04c-3dfb3df77976',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(19,19,1,'Iced Americano','2020-02-09 19:11:42','2020-02-16 00:02:37','275be93a-4526-4063-97da-298678bd8490','Intro','page copy',NULL,NULL,NULL,NULL,NULL),
	(20,20,1,'Iced Coffee','2020-02-09 19:11:43','2020-02-09 19:11:43','a79285c0-d3db-400c-be17-55380dd97334','Intro','page copy',NULL,NULL,NULL,NULL,NULL),
	(22,22,1,'About','2020-02-09 19:19:47','2020-02-09 20:14:18','a45c3eec-2c87-4957-8496-f4fbfedcadcd',NULL,'This is the page copy.<br />',NULL,NULL,'This is a subtitle','This is a page intro',NULL),
	(23,23,1,'About','2020-02-09 19:19:47','2020-02-09 19:19:47','ebd3df83-d017-45c7-bef6-ef32d0fc6437',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(25,25,1,'Locations','2020-02-09 19:20:02','2020-02-15 20:21:35','f738c716-2e1d-4d2d-8f47-3707aba22762',NULL,'<p>page copy</p>',NULL,NULL,'Where we are in the world.','We have office across the world. Visit us anywhere!',NULL),
	(26,26,1,'Locations','2020-02-09 19:20:02','2020-02-09 19:20:02','ad9d846b-34a3-4edc-92b5-0568e1f09270',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(28,28,1,'Austin, TX','2020-02-09 19:20:16','2020-02-15 20:57:06','cc85c7dd-2974-4f74-a742-8cc350b280c0',NULL,'page copy',NULL,NULL,'Live music capitol of the world','page intro',NULL),
	(29,29,1,'Austin, TX','2020-02-09 19:20:17','2020-02-09 19:20:17','a44be6b3-c4ed-40bb-9db1-fc5735cb22d6',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(31,31,1,'Mission Statement','2020-02-09 19:20:37','2020-02-09 20:13:39','7259c54b-98f1-46a3-8a40-78f227758506',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(32,32,1,'Mission Statement','2020-02-09 19:20:37','2020-02-09 19:20:37','57462b70-8532-4037-8e3d-b95f367578e6',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(33,33,1,'About','2020-02-09 20:14:18','2020-02-09 20:14:18','9c3fa64d-2d64-4dfb-ba9b-d51f7ddfa30c',NULL,'This is the page copy.<br />',NULL,NULL,'This is a subtitle','This is a page intro',NULL),
	(34,34,1,'Homepage','2020-02-09 20:46:21','2020-02-09 20:46:21','cc2a838e-ba10-42c6-9b4c-b84b43be0dc5',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(35,35,1,'Crafty Coffee','2020-02-09 20:46:41','2020-02-09 20:46:41','168d44cb-ca82-40f1-9d31-c620b610795c',NULL,NULL,NULL,NULL,'If we wrote it down, you can make it at home.',NULL,NULL),
	(36,36,1,'Crafty Coffee','2020-02-09 20:47:42','2020-02-09 20:47:42','551ef648-c34c-4096-bf69-9b137b176d43',NULL,NULL,NULL,NULL,'If we wrote it down, you can make it at homezzzzz',NULL,NULL),
	(37,37,1,'Perfect Espresso','2020-02-09 21:26:21','2020-02-09 21:26:21','5e89d4b5-185d-4020-a8ad-86b2a37854a6','The best shot you\'ve ever had.','<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p>',NULL,NULL,NULL,NULL,NULL),
	(39,39,1,'Acquired by Starbucks','2020-02-09 21:54:28','2020-02-09 21:54:28','341bb63c-128c-44c7-b6e7-2b9c4ea989cd',NULL,NULL,'This is amazing!','<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p>',NULL,NULL,NULL),
	(40,40,1,'Acquired by Starbucks','2020-02-09 21:54:29','2020-02-09 21:54:29','eef18d06-cca6-4a88-aaf1-5abe15b5f5e9',NULL,NULL,'This is amazing!','<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p>',NULL,NULL,NULL),
	(41,41,1,'Locations','2020-02-15 20:21:35','2020-02-15 20:21:35','8efc9228-46c3-4177-ae0b-397d708e621c',NULL,'<p>page copy</p>',NULL,NULL,'Where we are in the world.','We have office across the world. Visit us anywhere!',NULL),
	(42,42,1,'Austin, TX','2020-02-15 20:57:06','2020-02-15 20:57:06','962502c6-f147-4ff3-83ba-588cefbdfde2',NULL,'page copy',NULL,NULL,'Live music capitol of the world','page intro',NULL),
	(44,381,1,'Perfect Espresso','2020-02-15 21:15:15','2020-02-15 22:50:45','77184153-3da6-4071-ba50-721b24b45696',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(45,392,1,'Perfect Espresso','2020-02-15 21:15:15','2020-02-15 21:15:15','99c1848b-b1cb-4592-8d97-f00e8ca36ddd',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(47,438,1,'Perfect Espresso','2020-02-15 22:15:01','2020-02-15 22:15:01','872f3f37-d761-4aee-ab7f-03d02a1e1e91',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(48,451,1,'Espresso','2020-02-15 22:47:46','2020-02-15 22:47:46','87e5200f-c39a-4194-b34b-74f352dde07a',NULL,NULL,NULL,NULL,NULL,NULL,'All drinks made with the delicious espresso roasted bean and pressure brewed technique.'),
	(49,452,1,'Perfect Espresso','2020-02-15 22:50:45','2020-02-15 22:50:45','776ac2cb-9f68-475a-a17d-e0eed377a25d',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(50,465,1,'Perfect Espresso','2020-02-15 22:51:26','2020-02-15 22:51:26','d2cdfdf2-6722-46ea-8552-5abd05f2a42d','The best shot you\'ve ever had.','<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p>',NULL,NULL,NULL,NULL,NULL),
	(51,466,1,'Iced Americano','2020-02-15 23:27:27','2020-02-15 23:27:27','85cbe9dc-b7af-48e1-a6bc-06b02fd40f34','Intro','page copy',NULL,NULL,NULL,NULL,NULL),
	(52,467,1,'Iced Drinks','2020-02-15 23:57:34','2020-02-15 23:57:34','49f7e68c-51e5-4f75-aade-e4dfa5630297',NULL,NULL,NULL,NULL,NULL,NULL,'Iced drinks for hot days.'),
	(53,468,1,'Iced Americano','2020-02-16 00:02:30','2020-02-16 00:02:30','ec92fd12-315b-4d31-8804-96c006d287e9',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(54,470,1,'Iced Americano','2020-02-16 00:02:30','2020-02-16 00:02:30','86ad1177-86e5-4b15-a8eb-f3c938a6a368',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(55,471,1,'Iced Americano','2020-02-16 00:02:37','2020-02-16 00:02:37','6da84faa-fc19-4381-a8a5-006e58833fcb','Intro','page copy',NULL,NULL,NULL,NULL,NULL),
	(56,472,1,'Perfect Espresso','2020-02-16 00:02:47','2020-02-16 00:02:47','2e61058e-d17e-4f20-9466-f150cb67f66d','The best shot you\'ve ever had.','<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p>',NULL,NULL,NULL,NULL,NULL);

/*!40000 ALTER TABLE `content` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table craftidtokens
# ------------------------------------------------------------

DROP TABLE IF EXISTS `craftidtokens`;

CREATE TABLE `craftidtokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `accessToken` text NOT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craftidtokens_userId_fk` (`userId`),
  CONSTRAINT `craftidtokens_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table deprecationerrors
# ------------------------------------------------------------

DROP TABLE IF EXISTS `deprecationerrors`;

CREATE TABLE `deprecationerrors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key` varchar(255) NOT NULL,
  `fingerprint` varchar(255) NOT NULL,
  `lastOccurrence` datetime NOT NULL,
  `file` varchar(255) NOT NULL,
  `line` smallint(6) unsigned DEFAULT NULL,
  `message` varchar(255) DEFAULT NULL,
  `traces` text DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `deprecationerrors_key_fingerprint_unq_idx` (`key`,`fingerprint`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `deprecationerrors` WRITE;
/*!40000 ALTER TABLE `deprecationerrors` DISABLE KEYS */;

INSERT INTO `deprecationerrors` (`id`, `key`, `fingerprint`, `lastOccurrence`, `file`, `line`, `message`, `traces`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(22,'ElementQuery::getIterator()','/Users/ryan/training/craftycoffee-2020/templates/recipes/_entry.twig:29','2020-02-16 00:04:37','/Users/ryan/training/craftycoffee-2020/templates/recipes/_entry.twig',29,'Looping through element queries directly has been deprecated. Use the all() function to fetch the query results before looping over them.','[{\"objectClass\":\"craft\\\\services\\\\Deprecator\",\"file\":\"/Users/ryan/training/craftycoffee-2020/vendor/craftcms/cms/src/elements/db/ElementQuery.php\",\"line\":569,\"class\":\"craft\\\\services\\\\Deprecator\",\"method\":\"log\",\"args\":\"\\\"ElementQuery::getIterator()\\\", \\\"Looping through element queries directly has been deprecated. Us...\\\"\"},{\"objectClass\":\"craft\\\\elements\\\\db\\\\MatrixBlockQuery\",\"file\":\"/Users/ryan/training/craftycoffee-2020/storage/runtime/compiled_templates/cb/cb703c7c666095adab918f5f6a595de3a5a6763f5c218b04f4a70e7b700ba500.php\",\"line\":92,\"class\":\"craft\\\\elements\\\\db\\\\ElementQuery\",\"method\":\"getIterator\",\"args\":null},{\"objectClass\":\"__TwigTemplate_d04786f697e772d9e4c120c280aad35955c540de36a7666b3b6ebf61e49eabc3\",\"file\":\"/Users/ryan/training/craftycoffee-2020/vendor/twig/twig/src/Template.php\",\"line\":184,\"class\":\"__TwigTemplate_d04786f697e772d9e4c120c280aad35955c540de36a7666b3b6ebf61e49eabc3\",\"method\":\"block_main\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"devMode\\\" => false, ...], [\\\"main\\\" => [__TwigTemplate_d04786f697e772d9e4c120c280aad35955c540de36a7666b3b6ebf61e49eabc3, \\\"block_main\\\"]]\"},{\"objectClass\":\"__TwigTemplate_94c9ec52232620433566b442f3d7e23610178fc9699bb5aeb9b344553385f693\",\"file\":\"/Users/ryan/training/craftycoffee-2020/storage/runtime/compiled_templates/3b/3b46f1a282a10d9e280fcac045b145be4fc4e8f721c3dee22d51bf7faf500b98.php\",\"line\":83,\"class\":\"Twig\\\\Template\",\"method\":\"displayBlock\",\"args\":\"\\\"main\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"devMode\\\" => false, ...], [\\\"main\\\" => [__TwigTemplate_d04786f697e772d9e4c120c280aad35955c540de36a7666b3b6ebf61e49eabc3, \\\"block_main\\\"]]\"},{\"objectClass\":\"__TwigTemplate_94c9ec52232620433566b442f3d7e23610178fc9699bb5aeb9b344553385f693\",\"file\":\"/Users/ryan/training/craftycoffee-2020/vendor/twig/twig/src/Template.php\",\"line\":407,\"class\":\"__TwigTemplate_94c9ec52232620433566b442f3d7e23610178fc9699bb5aeb9b344553385f693\",\"method\":\"doDisplay\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"devMode\\\" => false, ...], [\\\"main\\\" => [__TwigTemplate_d04786f697e772d9e4c120c280aad35955c540de36a7666b3b6ebf61e49eabc3, \\\"block_main\\\"]]\"},{\"objectClass\":\"__TwigTemplate_94c9ec52232620433566b442f3d7e23610178fc9699bb5aeb9b344553385f693\",\"file\":\"/Users/ryan/training/craftycoffee-2020/vendor/twig/twig/src/Template.php\",\"line\":380,\"class\":\"Twig\\\\Template\",\"method\":\"displayWithErrorHandling\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"devMode\\\" => false, ...], [\\\"main\\\" => [__TwigTemplate_d04786f697e772d9e4c120c280aad35955c540de36a7666b3b6ebf61e49eabc3, \\\"block_main\\\"]]\"},{\"objectClass\":\"__TwigTemplate_94c9ec52232620433566b442f3d7e23610178fc9699bb5aeb9b344553385f693\",\"file\":\"/Users/ryan/training/craftycoffee-2020/storage/runtime/compiled_templates/cb/cb703c7c666095adab918f5f6a595de3a5a6763f5c218b04f4a70e7b700ba500.php\",\"line\":45,\"class\":\"Twig\\\\Template\",\"method\":\"display\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"devMode\\\" => false, ...], [\\\"main\\\" => [__TwigTemplate_d04786f697e772d9e4c120c280aad35955c540de36a7666b3b6ebf61e49eabc3, \\\"block_main\\\"]]\"},{\"objectClass\":\"__TwigTemplate_d04786f697e772d9e4c120c280aad35955c540de36a7666b3b6ebf61e49eabc3\",\"file\":\"/Users/ryan/training/craftycoffee-2020/vendor/twig/twig/src/Template.php\",\"line\":407,\"class\":\"__TwigTemplate_d04786f697e772d9e4c120c280aad35955c540de36a7666b3b6ebf61e49eabc3\",\"method\":\"doDisplay\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"devMode\\\" => false, ...], [\\\"main\\\" => [__TwigTemplate_d04786f697e772d9e4c120c280aad35955c540de36a7666b3b6ebf61e49eabc3, \\\"block_main\\\"]]\"},{\"objectClass\":\"__TwigTemplate_d04786f697e772d9e4c120c280aad35955c540de36a7666b3b6ebf61e49eabc3\",\"file\":\"/Users/ryan/training/craftycoffee-2020/vendor/twig/twig/src/Template.php\",\"line\":380,\"class\":\"Twig\\\\Template\",\"method\":\"displayWithErrorHandling\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"devMode\\\" => false, ...], [\\\"main\\\" => [__TwigTemplate_d04786f697e772d9e4c120c280aad35955c540de36a7666b3b6ebf61e49eabc3, \\\"block_main\\\"]]\"},{\"objectClass\":\"__TwigTemplate_d04786f697e772d9e4c120c280aad35955c540de36a7666b3b6ebf61e49eabc3\",\"file\":\"/Users/ryan/training/craftycoffee-2020/vendor/twig/twig/src/Template.php\",\"line\":392,\"class\":\"Twig\\\\Template\",\"method\":\"display\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"__TwigTemplate_d04786f697e772d9e4c120c280aad35955c540de36a7666b3b6ebf61e49eabc3\",\"file\":\"/Users/ryan/training/craftycoffee-2020/vendor/twig/twig/src/TemplateWrapper.php\",\"line\":45,\"class\":\"Twig\\\\Template\",\"method\":\"render\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]], []\"},{\"objectClass\":\"Twig\\\\TemplateWrapper\",\"file\":\"/Users/ryan/training/craftycoffee-2020/vendor/twig/twig/src/Environment.php\",\"line\":318,\"class\":\"Twig\\\\TemplateWrapper\",\"method\":\"render\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\twig\\\\Environment\",\"file\":\"/Users/ryan/training/craftycoffee-2020/vendor/craftcms/cms/src/web/View.php\",\"line\":390,\"class\":\"Twig\\\\Environment\",\"method\":\"render\",\"args\":\"\\\"recipes/_entry\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\View\",\"file\":\"/Users/ryan/training/craftycoffee-2020/vendor/craftcms/cms/src/web/View.php\",\"line\":451,\"class\":\"craft\\\\web\\\\View\",\"method\":\"renderTemplate\",\"args\":\"\\\"recipes/_entry\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\View\",\"file\":\"/Users/ryan/training/craftycoffee-2020/vendor/craftcms/cms/src/web/Controller.php\",\"line\":235,\"class\":\"craft\\\\web\\\\View\",\"method\":\"renderPageTemplate\",\"args\":\"\\\"recipes/_entry\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]], \\\"site\\\"\"},{\"objectClass\":\"craft\\\\controllers\\\\TemplatesController\",\"file\":\"/Users/ryan/training/craftycoffee-2020/vendor/craftcms/cms/src/controllers/TemplatesController.php\",\"line\":98,\"class\":\"craft\\\\web\\\\Controller\",\"method\":\"renderTemplate\",\"args\":\"\\\"recipes/_entry\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\controllers\\\\TemplatesController\",\"file\":null,\"line\":null,\"class\":\"craft\\\\controllers\\\\TemplatesController\",\"method\":\"actionRender\",\"args\":\"\\\"recipes/_entry\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":null,\"file\":\"/Users/ryan/training/craftycoffee-2020/vendor/yiisoft/yii2/base/InlineAction.php\",\"line\":57,\"class\":null,\"method\":\"call_user_func_array\",\"args\":\"[craft\\\\controllers\\\\TemplatesController, \\\"actionRender\\\"], [\\\"recipes/_entry\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"yii\\\\base\\\\InlineAction\",\"file\":\"/Users/ryan/training/craftycoffee-2020/vendor/yiisoft/yii2/base/Controller.php\",\"line\":157,\"class\":\"yii\\\\base\\\\InlineAction\",\"method\":\"runWithParams\",\"args\":\"[\\\"template\\\" => \\\"recipes/_entry\\\", \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\controllers\\\\TemplatesController\",\"file\":\"/Users/ryan/training/craftycoffee-2020/vendor/craftcms/cms/src/web/Controller.php\",\"line\":178,\"class\":\"yii\\\\base\\\\Controller\",\"method\":\"runAction\",\"args\":\"\\\"render\\\", [\\\"template\\\" => \\\"recipes/_entry\\\", \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\controllers\\\\TemplatesController\",\"file\":\"/Users/ryan/training/craftycoffee-2020/vendor/yiisoft/yii2/base/Module.php\",\"line\":528,\"class\":\"craft\\\\web\\\\Controller\",\"method\":\"runAction\",\"args\":\"\\\"render\\\", [\\\"template\\\" => \\\"recipes/_entry\\\", \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/ryan/training/craftycoffee-2020/vendor/craftcms/cms/src/web/Application.php\",\"line\":290,\"class\":\"yii\\\\base\\\\Module\",\"method\":\"runAction\",\"args\":\"\\\"templates/render\\\", [\\\"template\\\" => \\\"recipes/_entry\\\", \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/ryan/training/craftycoffee-2020/vendor/yiisoft/yii2/web/Application.php\",\"line\":103,\"class\":\"craft\\\\web\\\\Application\",\"method\":\"runAction\",\"args\":\"\\\"templates/render\\\", [\\\"template\\\" => \\\"recipes/_entry\\\", \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/ryan/training/craftycoffee-2020/vendor/craftcms/cms/src/web/Application.php\",\"line\":275,\"class\":\"yii\\\\web\\\\Application\",\"method\":\"handleRequest\",\"args\":\"craft\\\\web\\\\Request\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/ryan/training/craftycoffee-2020/vendor/yiisoft/yii2/base/Application.php\",\"line\":386,\"class\":\"craft\\\\web\\\\Application\",\"method\":\"handleRequest\",\"args\":\"craft\\\\web\\\\Request\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/ryan/training/craftycoffee-2020/web/index.php\",\"line\":21,\"class\":\"yii\\\\base\\\\Application\",\"method\":\"run\",\"args\":null},{\"objectClass\":null,\"file\":\"/Users/ryan/.composer/vendor/laravel/valet/server.php\",\"line\":147,\"class\":null,\"method\":\"require\",\"args\":\"\\\"/Users/ryan/training/craftycoffee-2020/web/index.php\\\"\"}]','2020-02-16 00:04:37','2020-02-16 00:04:37','77e7b18a-6182-46f2-be06-25c5222a4fa1');

/*!40000 ALTER TABLE `deprecationerrors` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table drafts
# ------------------------------------------------------------

DROP TABLE IF EXISTS `drafts`;

CREATE TABLE `drafts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sourceId` int(11) DEFAULT NULL,
  `creatorId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `notes` text DEFAULT NULL,
  `trackChanges` tinyint(1) NOT NULL DEFAULT 0,
  `dateLastMerged` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `drafts_creatorId_fk` (`creatorId`),
  KEY `drafts_sourceId_fk` (`sourceId`),
  CONSTRAINT `drafts_creatorId_fk` FOREIGN KEY (`creatorId`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `drafts_sourceId_fk` FOREIGN KEY (`sourceId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `drafts` WRITE;
/*!40000 ALTER TABLE `drafts` DISABLE KEYS */;

INSERT INTO `drafts` (`id`, `sourceId`, `creatorId`, `name`, `notes`, `trackChanges`, `dateLastMerged`)
VALUES
	(1,NULL,1,'First draft',NULL,0,NULL),
	(2,NULL,1,'First draft',NULL,0,NULL),
	(4,NULL,1,'First draft',NULL,0,NULL);

/*!40000 ALTER TABLE `drafts` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table elementindexsettings
# ------------------------------------------------------------

DROP TABLE IF EXISTS `elementindexsettings`;

CREATE TABLE `elementindexsettings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `settings` text DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `elementindexsettings_type_unq_idx` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `elementindexsettings` WRITE;
/*!40000 ALTER TABLE `elementindexsettings` DISABLE KEYS */;

INSERT INTO `elementindexsettings` (`id`, `type`, `settings`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,'craft\\elements\\Entry','{\"sources\":{\"section:13a49d3a-74d9-445a-9814-75a615b1b2b2\":{\"tableAttributes\":{\"1\":\"postDate\",\"2\":\"expiryDate\",\"3\":\"author\",\"4\":\"link\",\"5\":\"field:5\"}}}}','2020-02-09 19:06:34','2020-02-09 19:06:34','3f63b80e-584f-4d5a-a2f2-aaafb490bce7'),
	(2,'craft\\elements\\Category','{\"sources\":{\"group:e8331de6-f36c-47ca-88ea-58d08765edc9\":{\"tableAttributes\":{\"1\":\"field:16\",\"2\":\"uri\",\"3\":\"link\"}}}}','2020-02-15 22:48:09','2020-02-15 22:48:09','697e9de7-578b-43ec-bf70-8ac05eb62706');

/*!40000 ALTER TABLE `elementindexsettings` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table elements
# ------------------------------------------------------------

DROP TABLE IF EXISTS `elements`;

CREATE TABLE `elements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `draftId` int(11) DEFAULT NULL,
  `revisionId` int(11) DEFAULT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `type` varchar(255) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT 1,
  `archived` tinyint(1) NOT NULL DEFAULT 0,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `elements_dateDeleted_idx` (`dateDeleted`),
  KEY `elements_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `elements_type_idx` (`type`),
  KEY `elements_enabled_idx` (`enabled`),
  KEY `elements_archived_dateCreated_idx` (`archived`,`dateCreated`),
  KEY `elements_draftId_fk` (`draftId`),
  KEY `elements_revisionId_fk` (`revisionId`),
  KEY `elements_archived_dateDeleted_draftId_revisionId_idx` (`archived`,`dateDeleted`,`draftId`,`revisionId`),
  CONSTRAINT `elements_draftId_fk` FOREIGN KEY (`draftId`) REFERENCES `drafts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `elements_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `elements_revisionId_fk` FOREIGN KEY (`revisionId`) REFERENCES `revisions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `elements` WRITE;
/*!40000 ALTER TABLE `elements` DISABLE KEYS */;

INSERT INTO `elements` (`id`, `draftId`, `revisionId`, `fieldLayoutId`, `type`, `enabled`, `archived`, `dateCreated`, `dateUpdated`, `dateDeleted`, `uid`)
VALUES
	(1,NULL,NULL,NULL,'craft\\elements\\User',1,0,'2020-02-01 17:54:17','2020-02-09 21:37:28',NULL,'10158f50-1099-4e93-a1d0-ca7127fdbe07'),
	(2,1,NULL,NULL,'craft\\elements\\Entry',1,0,'2020-02-01 20:56:39','2020-02-01 20:56:39',NULL,'5e72d09d-4fea-4162-8ddb-4c80c7ac8a35'),
	(3,2,NULL,NULL,'craft\\elements\\Entry',1,0,'2020-02-01 21:07:32','2020-02-01 21:07:32',NULL,'1aedeb93-941c-45b2-bd79-d28a3a25b7d8'),
	(5,NULL,NULL,1,'craft\\elements\\Entry',1,0,'2020-02-01 21:10:00','2020-02-16 00:02:47',NULL,'ed65ff60-897b-4d78-84c6-6374a59c5ea1'),
	(6,NULL,1,1,'craft\\elements\\Entry',1,0,'2020-02-01 21:10:00','2020-02-01 21:10:00',NULL,'dec8dcd8-4c62-406a-b821-32e50c9b68a0'),
	(7,4,NULL,NULL,'craft\\elements\\Entry',1,0,'2020-02-01 21:10:40','2020-02-01 21:10:40',NULL,'aa6bc6ba-3584-400e-bf88-3ed9dbe04382'),
	(9,NULL,NULL,2,'craft\\elements\\Entry',1,0,'2020-02-01 21:11:43','2020-02-01 21:11:43',NULL,'eb9e2dd9-7959-4bcb-8805-4ae5e385d46c'),
	(10,NULL,2,2,'craft\\elements\\Entry',1,0,'2020-02-01 21:11:43','2020-02-01 21:11:43',NULL,'770477f6-f3c6-484e-ab30-cd879903a042'),
	(11,NULL,NULL,3,'craft\\elements\\Entry',1,0,'2020-02-09 17:31:35','2020-02-09 20:47:42',NULL,'48e39b44-b1d7-43d9-b3e0-ff022f7ea495'),
	(12,NULL,3,NULL,'craft\\elements\\Entry',1,0,'2020-02-09 17:31:35','2020-02-09 17:31:35',NULL,'cde6ecb7-59ff-4d9a-a565-fa19700f0952'),
	(13,NULL,4,NULL,'craft\\elements\\Entry',1,0,'2020-02-09 17:31:36','2020-02-09 17:31:36',NULL,'2c988899-9a0d-4c6f-ab91-b3bb348aa32b'),
	(14,NULL,5,3,'craft\\elements\\Entry',1,0,'2020-02-09 17:32:33','2020-02-09 17:32:33',NULL,'8c651e49-6ffd-4e78-b4d9-0051f04d2deb'),
	(15,NULL,NULL,NULL,'craft\\elements\\Asset',1,0,'2020-02-09 17:51:07','2020-02-09 17:51:07',NULL,'d02a86c1-d171-4d1a-a0a7-2323ea824b38'),
	(16,NULL,6,1,'craft\\elements\\Entry',1,0,'2020-02-09 19:06:20','2020-02-09 19:06:20',NULL,'0f9ce036-0f99-420c-b22b-336656c99677'),
	(17,NULL,NULL,NULL,'craft\\elements\\Asset',1,0,'2020-02-09 19:10:14','2020-02-09 19:10:14',NULL,'676c06c1-0b26-420b-b5f0-f85eabebe655'),
	(19,NULL,NULL,1,'craft\\elements\\Entry',1,0,'2020-02-09 19:11:42','2020-02-16 00:02:37',NULL,'80750380-70a2-4183-97f4-6535ce78897d'),
	(20,NULL,7,1,'craft\\elements\\Entry',1,0,'2020-02-09 19:11:42','2020-02-09 19:11:42',NULL,'442b34ad-e6b0-4e82-9426-26abb5079173'),
	(22,NULL,NULL,4,'craft\\elements\\Entry',1,0,'2020-02-09 19:19:47','2020-02-09 20:14:18',NULL,'1e9d242b-120b-4357-881d-8593443292f7'),
	(23,NULL,8,NULL,'craft\\elements\\Entry',1,0,'2020-02-09 19:19:47','2020-02-09 19:19:47',NULL,'2c4cb5d7-a2e0-42b0-a2ef-e5843646e474'),
	(25,NULL,NULL,4,'craft\\elements\\Entry',1,0,'2020-02-09 19:20:02','2020-02-15 20:21:35',NULL,'9aab46b0-c94f-4793-a0d5-b14bb27844b8'),
	(26,NULL,9,NULL,'craft\\elements\\Entry',1,0,'2020-02-09 19:20:02','2020-02-09 19:20:02',NULL,'954a7630-4604-4c22-880d-5c499ee9f01e'),
	(28,NULL,NULL,4,'craft\\elements\\Entry',1,0,'2020-02-09 19:20:16','2020-02-15 20:57:06',NULL,'e97a07ec-f4e4-4482-a686-52ee62d5bc06'),
	(29,NULL,10,NULL,'craft\\elements\\Entry',1,0,'2020-02-09 19:20:16','2020-02-09 19:20:16',NULL,'1f59fc7c-eafe-4ba5-a62c-d559f9e52f14'),
	(31,NULL,NULL,4,'craft\\elements\\Entry',1,0,'2020-02-09 19:20:37','2020-02-09 19:20:37',NULL,'14258394-bd07-4baa-855a-78a845a1719e'),
	(32,NULL,11,NULL,'craft\\elements\\Entry',1,0,'2020-02-09 19:20:37','2020-02-09 19:20:37',NULL,'ebf934e2-6ff7-4772-93ce-8034088e901d'),
	(33,NULL,12,4,'craft\\elements\\Entry',1,0,'2020-02-09 20:14:18','2020-02-09 20:14:18',NULL,'4b44fd73-9533-4ea4-a753-810a718a4f6a'),
	(34,NULL,13,3,'craft\\elements\\Entry',1,0,'2020-02-09 20:46:21','2020-02-09 20:46:21',NULL,'97aa714e-ec47-4034-bb36-41df90db3bfe'),
	(35,NULL,14,3,'craft\\elements\\Entry',1,0,'2020-02-09 20:46:41','2020-02-09 20:46:41',NULL,'8874febc-31e3-4bcc-b688-d0161feb142d'),
	(36,NULL,15,3,'craft\\elements\\Entry',1,0,'2020-02-09 20:47:42','2020-02-09 20:47:42',NULL,'947bc313-6676-4598-a207-ca127d21f00b'),
	(37,NULL,16,1,'craft\\elements\\Entry',1,0,'2020-02-09 21:26:21','2020-02-09 21:26:21',NULL,'c4d64ff3-948c-4fd8-85b5-2b9d82ad0449'),
	(39,NULL,NULL,2,'craft\\elements\\Entry',1,0,'2020-02-09 21:54:28','2020-02-09 21:54:28',NULL,'86059c1d-6a6a-46e0-a620-6979dc60a078'),
	(40,NULL,17,2,'craft\\elements\\Entry',1,0,'2020-02-09 21:54:28','2020-02-09 21:54:28',NULL,'a2a43b0c-55b0-4d1f-a003-18e9de5f90b4'),
	(41,NULL,18,4,'craft\\elements\\Entry',1,0,'2020-02-15 20:21:35','2020-02-15 20:21:35',NULL,'7aeb7959-12d3-4c96-b932-bea4a4f6f295'),
	(42,NULL,19,4,'craft\\elements\\Entry',1,0,'2020-02-15 20:57:06','2020-02-15 20:57:06',NULL,'3338784f-ea68-466a-98b2-d3de7cd9ac55'),
	(44,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:11:44','2020-02-15 21:11:44','2020-02-15 21:11:52','8d50ff17-329a-425c-9207-702870d86899'),
	(45,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:11:52','2020-02-15 21:11:52','2020-02-15 21:11:54','688070cb-1abe-4082-9163-619c966d85e0'),
	(46,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:11:54','2020-02-15 21:11:54','2020-02-15 21:11:57','1d746d92-f0f9-4ba6-986a-c5c7c9cfdf47'),
	(47,NULL,NULL,5,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:11:54','2020-02-15 21:11:54','2020-02-15 21:11:57','4b393029-12f5-465c-858a-7586ce5623f7'),
	(48,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:11:57','2020-02-15 21:11:57','2020-02-15 21:12:05','45308e6b-fbc9-4392-b52c-e1bee62698cc'),
	(49,NULL,NULL,5,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:11:57','2020-02-15 21:11:57','2020-02-15 21:12:05','c002812a-37d8-4d1a-ae8f-707de83b7aa8'),
	(50,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:12:05','2020-02-15 21:12:05','2020-02-15 21:12:07','b7b78ae3-9ce2-490d-8c7e-2defb01b1e18'),
	(51,NULL,NULL,5,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:12:05','2020-02-15 21:12:05','2020-02-15 21:12:07','a1721332-d08d-45dd-a884-9dabf96f98f0'),
	(52,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:12:07','2020-02-15 21:12:07','2020-02-15 21:12:21','03103a18-d91f-4eed-9880-aaaafbe9d793'),
	(53,NULL,NULL,5,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:12:07','2020-02-15 21:12:07','2020-02-15 21:12:21','09ad122f-7c9a-46d2-9e17-8d0daa5c9bdf'),
	(54,NULL,NULL,6,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:12:07','2020-02-15 21:12:07','2020-02-15 21:12:21','bc627c0e-2757-4f34-a0ad-9582ca206a28'),
	(55,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:12:21','2020-02-15 21:12:21','2020-02-15 21:12:28','2f89377f-c10b-42f8-ab75-8cd0c17e68d1'),
	(56,NULL,NULL,5,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:12:21','2020-02-15 21:12:21','2020-02-15 21:12:28','e41a9673-1433-413c-a241-52fe418e3ced'),
	(57,NULL,NULL,6,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:12:21','2020-02-15 21:12:21','2020-02-15 21:12:28','e215b7bf-2de7-46fd-91b9-143902bb6899'),
	(58,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:12:27','2020-02-15 21:12:27','2020-02-15 21:12:29','69869496-8d88-457a-8683-effc1c968fb9'),
	(59,NULL,NULL,5,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:12:27','2020-02-15 21:12:27','2020-02-15 21:12:29','a7722737-28f4-4597-88b3-bac28112d1ba'),
	(60,NULL,NULL,6,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:12:27','2020-02-15 21:12:27','2020-02-15 21:12:29','d694642a-dfb5-49b5-8880-f1515659ae38'),
	(61,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:12:29','2020-02-15 21:12:29','2020-02-15 21:12:46','b2bc3024-ee1a-4a6c-9930-0d4294c0713e'),
	(62,NULL,NULL,5,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:12:29','2020-02-15 21:12:29','2020-02-15 21:12:46','91af89f9-38ef-4f2f-b67e-6871aa01b688'),
	(63,NULL,NULL,6,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:12:29','2020-02-15 21:12:29','2020-02-15 21:12:46','dcbb7ddf-1d35-4409-9b98-bbd7a77d1883'),
	(64,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:12:29','2020-02-15 21:12:29','2020-02-15 21:12:46','3487a9d4-c5b9-4a67-94ef-5ca5d99d52bc'),
	(65,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:12:46','2020-02-15 21:12:46','2020-02-15 21:12:48','a78efeac-c669-4525-802d-67a7dc3cdd67'),
	(66,NULL,NULL,5,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:12:46','2020-02-15 21:12:46','2020-02-15 21:12:48','17c6e927-b661-4d43-998c-1e9b783fbdc2'),
	(67,NULL,NULL,6,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:12:46','2020-02-15 21:12:46','2020-02-15 21:12:48','95cd6d85-f080-4e69-84da-fbb5cf3007ed'),
	(68,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:12:46','2020-02-15 21:12:46','2020-02-15 21:12:48','af57692b-ab80-4c4a-a17d-1628cd4fd04f'),
	(69,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:12:48','2020-02-15 21:12:48','2020-02-15 21:12:50','96fb7384-3eab-4a88-9d99-cf31da74c531'),
	(70,NULL,NULL,5,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:12:48','2020-02-15 21:12:48','2020-02-15 21:12:50','38e4095f-93ea-44e3-be4f-65348d5ed168'),
	(71,NULL,NULL,6,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:12:48','2020-02-15 21:12:48','2020-02-15 21:12:50','6f3df853-1ac9-40b1-8286-b7c28984e76c'),
	(72,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:12:48','2020-02-15 21:12:48','2020-02-15 21:12:50','b6ff04a8-99dc-4bfc-a93e-c49e0c71bc69'),
	(73,NULL,NULL,9,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:12:48','2020-02-15 21:12:48','2020-02-15 21:12:50','ab955ee3-3b98-4ab1-8dd0-f173540630d3'),
	(74,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:12:50','2020-02-15 21:12:50','2020-02-15 21:12:54','c2a4d372-b96d-4a56-90fb-15f971369b3f'),
	(75,NULL,NULL,5,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:12:50','2020-02-15 21:12:50','2020-02-15 21:12:54','f411730a-6f01-4e42-bf19-7759b8199bd1'),
	(76,NULL,NULL,6,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:12:50','2020-02-15 21:12:50','2020-02-15 21:12:54','3f8575ad-1d46-475d-bbdc-825bc5ab132b'),
	(77,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:12:50','2020-02-15 21:12:50','2020-02-15 21:12:54','224c8841-a726-4aa4-b554-3629d38ee4e9'),
	(78,NULL,NULL,9,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:12:50','2020-02-15 21:12:50','2020-02-15 21:12:54','9b5dd8f7-aa8c-4001-9ff7-4aae0416a943'),
	(79,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:12:54','2020-02-15 21:12:54','2020-02-15 21:12:56','d888dcaa-84df-4d3d-b999-51321eda8e97'),
	(80,NULL,NULL,5,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:12:54','2020-02-15 21:12:54','2020-02-15 21:12:56','b47c0a4a-cdac-4ed1-b98b-1c7e5ab48ea4'),
	(81,NULL,NULL,6,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:12:54','2020-02-15 21:12:54','2020-02-15 21:12:56','deaa2cae-e728-4698-9d1c-1887bc3c6ded'),
	(82,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:12:54','2020-02-15 21:12:54','2020-02-15 21:12:56','d1abb354-0436-41bd-92a4-60dd67a0ebfb'),
	(83,NULL,NULL,9,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:12:54','2020-02-15 21:12:54','2020-02-15 21:12:56','efcaaf09-70cf-49d0-9807-831a9d8c11bb'),
	(84,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:12:56','2020-02-15 21:12:56','2020-02-15 21:12:57','a013cfeb-5eb2-4bf4-8239-b9277af85282'),
	(85,NULL,NULL,5,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:12:56','2020-02-15 21:12:56','2020-02-15 21:12:57','6e335964-6e21-4026-a646-feead1c5804e'),
	(86,NULL,NULL,6,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:12:56','2020-02-15 21:12:56','2020-02-15 21:12:57','86fda8b7-e7a6-48d6-9de4-9f559d267b0d'),
	(87,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:12:56','2020-02-15 21:12:56','2020-02-15 21:12:57','e54ac30f-f31b-41cc-a454-8b558b1bc6dd'),
	(88,NULL,NULL,9,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:12:56','2020-02-15 21:12:56','2020-02-15 21:12:57','8d95dce1-2943-4b6f-a7f4-07157b4643c9'),
	(89,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:12:57','2020-02-15 21:12:57','2020-02-15 21:12:58','c7b8181e-e945-467c-b060-ef63032e3600'),
	(90,NULL,NULL,5,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:12:57','2020-02-15 21:12:57','2020-02-15 21:12:58','0558834b-549e-4bf4-bb0a-1c68b0c60d58'),
	(91,NULL,NULL,6,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:12:57','2020-02-15 21:12:57','2020-02-15 21:12:58','d1ce7392-825b-43f1-a4b1-fac376207bf0'),
	(92,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:12:57','2020-02-15 21:12:57','2020-02-15 21:12:58','88e31854-10e7-4ad0-b206-6d5590fa8990'),
	(93,NULL,NULL,9,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:12:57','2020-02-15 21:12:57','2020-02-15 21:12:58','2c638f52-8dff-4f50-a817-65307a151978'),
	(94,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:12:58','2020-02-15 21:12:58','2020-02-15 21:13:00','f25362b6-6951-4c1d-a0a6-9124b835c663'),
	(95,NULL,NULL,5,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:12:58','2020-02-15 21:12:58','2020-02-15 21:13:00','350c64b9-4c9e-440a-9e8e-b4480d4f489e'),
	(96,NULL,NULL,6,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:12:58','2020-02-15 21:12:58','2020-02-15 21:13:00','ba561e5b-4635-4472-a1ba-404a8a584d27'),
	(97,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:12:58','2020-02-15 21:12:58','2020-02-15 21:13:00','9782dd12-a0f0-4e24-921a-be954abc6959'),
	(98,NULL,NULL,9,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:12:58','2020-02-15 21:12:58','2020-02-15 21:13:00','7d2e9748-f55e-42e4-92bd-e5d88d99bf39'),
	(99,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:00','2020-02-15 21:13:00','2020-02-15 21:13:02','fa0e76da-dd55-41ab-bc58-34032ac6cc26'),
	(100,NULL,NULL,5,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:00','2020-02-15 21:13:00','2020-02-15 21:13:02','e7880b14-d24a-43ab-b1df-fe2a0f2c054b'),
	(101,NULL,NULL,6,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:00','2020-02-15 21:13:00','2020-02-15 21:13:02','e831e86e-7f9a-451f-b023-469aae36e90b'),
	(102,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:00','2020-02-15 21:13:00','2020-02-15 21:13:02','5d8b82bf-374e-40a7-a679-e14770ffcc06'),
	(103,NULL,NULL,9,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:00','2020-02-15 21:13:00','2020-02-15 21:13:02','0b12b25e-61ab-42ed-b428-dbcb1c51fc38'),
	(104,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:02','2020-02-15 21:13:02','2020-02-15 21:13:06','a2cd8155-1263-4b90-a82c-423d8a268667'),
	(105,NULL,NULL,5,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:02','2020-02-15 21:13:02','2020-02-15 21:13:06','f883a15d-4e66-47aa-8b63-efec5e3e8885'),
	(106,NULL,NULL,6,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:02','2020-02-15 21:13:02','2020-02-15 21:13:06','902f2116-7d87-4cbf-b181-4491193656b0'),
	(107,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:02','2020-02-15 21:13:02','2020-02-15 21:13:06','c4ead8a8-4da6-4824-8952-9f581e251cc0'),
	(108,NULL,NULL,9,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:02','2020-02-15 21:13:02','2020-02-15 21:13:06','d282e671-986b-4422-9a7e-2e4e9b85a13f'),
	(109,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:06','2020-02-15 21:13:06','2020-02-15 21:13:07','7339b41c-8246-4c4d-a203-51b3737237d4'),
	(110,NULL,NULL,5,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:06','2020-02-15 21:13:06','2020-02-15 21:13:07','8e69d2e6-f360-465f-8268-4ff488792167'),
	(111,NULL,NULL,6,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:06','2020-02-15 21:13:06','2020-02-15 21:13:07','00b98c4b-40a3-4823-b857-d98238972581'),
	(112,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:06','2020-02-15 21:13:06','2020-02-15 21:13:07','ff38e019-4c06-4632-9cdd-f55e43ee7e73'),
	(113,NULL,NULL,9,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:06','2020-02-15 21:13:06','2020-02-15 21:13:07','7768cb94-440a-4b37-9b16-603c2e9700ec'),
	(114,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:07','2020-02-15 21:13:07','2020-02-15 21:13:12','85317271-cef7-4232-b1ed-d735bacf1064'),
	(115,NULL,NULL,5,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:07','2020-02-15 21:13:07','2020-02-15 21:13:12','d2027126-0395-4adc-bb58-285abce72d8a'),
	(116,NULL,NULL,6,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:07','2020-02-15 21:13:07','2020-02-15 21:13:12','64c9b84b-72d3-46c1-9347-97fd8f439b8c'),
	(117,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:07','2020-02-15 21:13:07','2020-02-15 21:13:12','a8fa83d8-9df3-4639-beae-e926f15be5b2'),
	(118,NULL,NULL,9,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:07','2020-02-15 21:13:07','2020-02-15 21:13:12','127050d9-c851-4c40-8ef4-7ea6ebc39ba9'),
	(119,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:12','2020-02-15 21:13:12','2020-02-15 21:13:14','24cc8f35-5ab6-42ef-8443-0467ead3a0ad'),
	(120,NULL,NULL,5,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:12','2020-02-15 21:13:12','2020-02-15 21:13:14','a8914734-17c6-4fe7-83a9-14d4556e31c9'),
	(121,NULL,NULL,6,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:12','2020-02-15 21:13:12','2020-02-15 21:13:14','89e6b4a4-3a10-4ae5-a224-14063a6bbc16'),
	(122,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:12','2020-02-15 21:13:12','2020-02-15 21:13:14','7af40406-f216-4290-96de-dc8852c8afd9'),
	(123,NULL,NULL,9,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:12','2020-02-15 21:13:12','2020-02-15 21:13:14','f0cdd91a-3fcd-4ec1-b358-b8d391c6e328'),
	(124,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:14','2020-02-15 21:13:14','2020-02-15 21:13:14','f8aaf683-7f4c-44d9-bd3f-73140ca6c7d1'),
	(125,NULL,NULL,5,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:14','2020-02-15 21:13:14','2020-02-15 21:13:14','64d8fc80-93e3-495c-a31b-cd9f71bbf174'),
	(126,NULL,NULL,6,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:14','2020-02-15 21:13:14','2020-02-15 21:13:14','266f7a59-1070-40d8-8afe-98f61774d37e'),
	(127,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:14','2020-02-15 21:13:14','2020-02-15 21:13:14','b1f06efa-a55b-42af-96bc-a0f78560fa83'),
	(128,NULL,NULL,9,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:14','2020-02-15 21:13:14','2020-02-15 21:13:14','c45b1fc7-1d0d-4a3f-9af4-2ab30983b387'),
	(129,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:14','2020-02-15 21:13:14','2020-02-15 21:13:19','10556fae-ec0f-4189-97c3-bd8681dd080e'),
	(130,NULL,NULL,5,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:14','2020-02-15 21:13:14','2020-02-15 21:13:19','23ade4c0-5c72-4de0-b20d-ad803b41235b'),
	(131,NULL,NULL,6,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:14','2020-02-15 21:13:14','2020-02-15 21:13:19','093c8138-4947-42ef-a60b-78f41e542b03'),
	(132,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:14','2020-02-15 21:13:14','2020-02-15 21:13:19','ff685a25-9dab-4508-818e-cfaaf9d75c02'),
	(133,NULL,NULL,9,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:14','2020-02-15 21:13:14','2020-02-15 21:13:19','4257f1ed-db61-4345-89ff-5f24d4e4c0b0'),
	(134,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:19','2020-02-15 21:13:19','2020-02-15 21:13:22','7dcd5e3c-6a95-4f0a-be43-cd421d3a9481'),
	(135,NULL,NULL,5,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:19','2020-02-15 21:13:19','2020-02-15 21:13:22','70f92b51-592d-465b-aa5d-0b63381ec548'),
	(136,NULL,NULL,6,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:19','2020-02-15 21:13:19','2020-02-15 21:13:22','10f86619-9195-44c5-8d82-045ad6ca9fcb'),
	(137,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:19','2020-02-15 21:13:19','2020-02-15 21:13:22','057ade59-f562-46cd-aa8d-fe76be5ba7f4'),
	(138,NULL,NULL,9,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:19','2020-02-15 21:13:19','2020-02-15 21:13:22','6c717651-fa94-4e74-bb5c-9c4338ce8f97'),
	(139,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:22','2020-02-15 21:13:22','2020-02-15 21:13:25','81344770-4601-47df-afcb-244995afd9b8'),
	(140,NULL,NULL,5,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:22','2020-02-15 21:13:22','2020-02-15 21:13:25','a3b85db2-5d15-441c-8206-3ac349806f1c'),
	(141,NULL,NULL,6,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:22','2020-02-15 21:13:22','2020-02-15 21:13:25','c203bbea-2c9c-4897-9c42-5e00d00c4a5f'),
	(142,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:22','2020-02-15 21:13:22','2020-02-15 21:13:25','8d7c7a56-33a5-4e89-a616-72a75df3f947'),
	(143,NULL,NULL,9,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:22','2020-02-15 21:13:22','2020-02-15 21:13:25','e182f6fe-5909-4ed4-bc63-531c0edeb527'),
	(144,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:22','2020-02-15 21:13:22','2020-02-15 21:13:25','d0566ab0-280f-4851-811d-c4dd9f14e362'),
	(145,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:25','2020-02-15 21:13:25','2020-02-15 21:13:29','32ee05f2-b2a2-440f-984d-ce9bb5f29983'),
	(146,NULL,NULL,5,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:25','2020-02-15 21:13:25','2020-02-15 21:13:29','985d6f7c-b826-49a1-8f29-da5e3a0f3929'),
	(147,NULL,NULL,6,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:25','2020-02-15 21:13:25','2020-02-15 21:13:29','046c1340-f67b-459b-8bfd-cec8b5748681'),
	(148,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:25','2020-02-15 21:13:25','2020-02-15 21:13:29','7a4492b6-9031-45fc-8a5d-fa5361f09dfd'),
	(149,NULL,NULL,9,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:25','2020-02-15 21:13:25','2020-02-15 21:13:29','393f6d22-617d-4540-a65a-3fc0d1528ed3'),
	(150,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:25','2020-02-15 21:13:25','2020-02-15 21:13:29','16852780-3e8c-4efd-ade9-d21009e5e859'),
	(151,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:29','2020-02-15 21:13:29','2020-02-15 21:13:35','c36b9cdb-a95b-4c41-84ac-4857330f9c02'),
	(152,NULL,NULL,5,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:29','2020-02-15 21:13:29','2020-02-15 21:13:35','5d32f157-9baf-418b-8121-8e3d7f130374'),
	(153,NULL,NULL,6,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:29','2020-02-15 21:13:29','2020-02-15 21:13:35','371b96ef-9780-420b-bf4b-0a4deac2b9f8'),
	(154,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:29','2020-02-15 21:13:29','2020-02-15 21:13:35','86bb2b0e-3b5c-49f7-95f4-c5e8f55e0140'),
	(155,NULL,NULL,9,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:29','2020-02-15 21:13:29','2020-02-15 21:13:35','b5dbf475-b5d8-4c18-8ecf-b4439763613e'),
	(156,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:29','2020-02-15 21:13:29','2020-02-15 21:13:35','eb5f5a78-6063-411e-bcc8-ed810fad3548'),
	(157,NULL,NULL,8,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:29','2020-02-15 21:13:29','2020-02-15 21:13:35','c14e8470-77e3-4400-b8c5-9b91c9cdc1fe'),
	(158,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:35','2020-02-15 21:13:35','2020-02-15 21:13:37','826076d3-229b-4e87-8b24-bd5a459b5f48'),
	(159,NULL,NULL,5,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:35','2020-02-15 21:13:35','2020-02-15 21:13:37','6042cd2d-9c13-4eba-9a22-efa03b767d0a'),
	(160,NULL,NULL,6,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:35','2020-02-15 21:13:35','2020-02-15 21:13:37','4ffbee0e-686b-41bf-ae7f-9a9cc11ec3d0'),
	(161,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:35','2020-02-15 21:13:35','2020-02-15 21:13:37','97ab8898-e75b-456e-8a11-9b9b8b8a1879'),
	(162,NULL,NULL,9,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:35','2020-02-15 21:13:35','2020-02-15 21:13:37','8b67d091-5237-4e51-a198-a8354bf081ff'),
	(163,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:35','2020-02-15 21:13:35','2020-02-15 21:13:37','453e8323-c284-4a77-85e1-f8b5dc76fdb5'),
	(164,NULL,NULL,8,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:35','2020-02-15 21:13:35','2020-02-15 21:13:37','9fe38df5-12a8-47bf-b4d1-06bd197b04d3'),
	(165,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:37','2020-02-15 21:13:37','2020-02-15 21:13:38','7e03addc-245d-42ad-90a2-c8943089fab0'),
	(166,NULL,NULL,5,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:37','2020-02-15 21:13:37','2020-02-15 21:13:38','857ed00c-3aa4-4d66-a3f8-b15d94bcde9e'),
	(167,NULL,NULL,6,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:37','2020-02-15 21:13:37','2020-02-15 21:13:38','dc41f286-4cef-490b-ba5b-5dd4a46970d6'),
	(168,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:37','2020-02-15 21:13:37','2020-02-15 21:13:38','5f5a3f9c-2be1-413d-ac27-111f997be1e1'),
	(169,NULL,NULL,9,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:37','2020-02-15 21:13:37','2020-02-15 21:13:38','9348c07e-39f7-4640-9994-69972e0467e3'),
	(170,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:37','2020-02-15 21:13:37','2020-02-15 21:13:38','ee67288e-9fa7-441e-a32e-f0e261d0ed91'),
	(171,NULL,NULL,8,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:37','2020-02-15 21:13:37','2020-02-15 21:13:38','0d72b035-c8fa-4759-8d7e-f4abf7de529b'),
	(172,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:38','2020-02-15 21:13:38','2020-02-15 21:13:41','17341317-dcd0-41d3-87dc-7a7155bf1804'),
	(173,NULL,NULL,5,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:38','2020-02-15 21:13:38','2020-02-15 21:13:41','e75267bc-3877-4a57-8f49-2fad184f9683'),
	(174,NULL,NULL,6,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:38','2020-02-15 21:13:38','2020-02-15 21:13:41','e31be445-e711-49fc-8b06-477ab99e1205'),
	(175,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:38','2020-02-15 21:13:38','2020-02-15 21:13:41','70134f64-7138-49a0-869c-4620a945d275'),
	(176,NULL,NULL,9,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:38','2020-02-15 21:13:38','2020-02-15 21:13:41','261eacb7-c60d-424c-a6cc-2b7a27d968a7'),
	(177,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:38','2020-02-15 21:13:38','2020-02-15 21:13:41','14fcb79a-5e61-4e05-b41b-1741a4335695'),
	(178,NULL,NULL,8,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:38','2020-02-15 21:13:38','2020-02-15 21:13:41','a9c0fe7b-afed-4d8d-a124-b7558a256531'),
	(179,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:41','2020-02-15 21:13:41','2020-02-15 21:13:42','ca0028d1-aa97-4ee9-977f-f37a91f36a94'),
	(180,NULL,NULL,5,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:41','2020-02-15 21:13:41','2020-02-15 21:13:42','e30e8e22-33b5-406f-aa6b-d2be6ae18c3a'),
	(181,NULL,NULL,6,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:41','2020-02-15 21:13:41','2020-02-15 21:13:42','0bc0a2cc-a10e-42cb-b0fa-89c084795da7'),
	(182,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:41','2020-02-15 21:13:41','2020-02-15 21:13:42','1fc5a826-6d6c-4946-aba9-1befb64bf1e5'),
	(183,NULL,NULL,9,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:41','2020-02-15 21:13:41','2020-02-15 21:13:42','3488a1e7-b9fe-4277-844c-df2b527a321d'),
	(184,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:41','2020-02-15 21:13:41','2020-02-15 21:13:42','d4fd421e-fd84-4c7b-a532-07e83e159835'),
	(185,NULL,NULL,8,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:41','2020-02-15 21:13:41','2020-02-15 21:13:42','11615a95-a951-44bb-8bd3-54c8b8e55c5d'),
	(186,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:42','2020-02-15 21:13:42','2020-02-15 21:13:47','d36626d0-7596-428a-92a6-b0b258284b8c'),
	(187,NULL,NULL,5,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:42','2020-02-15 21:13:42','2020-02-15 21:13:47','63324e30-fd37-4350-9d2f-8cd5fb328d08'),
	(188,NULL,NULL,6,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:42','2020-02-15 21:13:42','2020-02-15 21:13:47','6ac7a0f7-2aff-40a6-90a8-ae788f6b096c'),
	(189,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:42','2020-02-15 21:13:42','2020-02-15 21:13:47','99bf9658-9193-4005-af30-654cc004b53e'),
	(190,NULL,NULL,9,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:42','2020-02-15 21:13:42','2020-02-15 21:13:47','170d4a9a-8006-4c2d-b313-41ccd047057b'),
	(191,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:42','2020-02-15 21:13:42','2020-02-15 21:13:47','753f286d-f958-45f1-998b-79142d341f94'),
	(192,NULL,NULL,8,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:42','2020-02-15 21:13:42','2020-02-15 21:13:47','783c953d-76b5-4d71-9042-c6ae95ec7902'),
	(193,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:46','2020-02-15 21:13:46','2020-02-15 21:13:49','884898ce-4063-4d59-9e4f-df12a63c2f49'),
	(194,NULL,NULL,5,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:46','2020-02-15 21:13:46','2020-02-15 21:13:49','5b22e20c-1f54-42d2-ba18-b6a6e591bcdb'),
	(195,NULL,NULL,6,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:47','2020-02-15 21:13:47','2020-02-15 21:13:49','5d339da1-5f80-4a10-b48c-82cd4ebd3864'),
	(196,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:47','2020-02-15 21:13:47','2020-02-15 21:13:49','769ba99e-3fc1-4225-8669-89fcf3a300e7'),
	(197,NULL,NULL,9,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:47','2020-02-15 21:13:47','2020-02-15 21:13:49','2d5afb6d-c095-45f1-a35a-02c8ba527e32'),
	(198,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:47','2020-02-15 21:13:47','2020-02-15 21:13:49','4eaa4cfd-aa73-404c-a370-d51a3e86e970'),
	(199,NULL,NULL,8,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:47','2020-02-15 21:13:47','2020-02-15 21:13:49','7af9c121-caf2-4b4e-a70e-e870e02e3e41'),
	(200,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:49','2020-02-15 21:13:49','2020-02-15 21:13:52','578e6aca-cc62-4f1e-8819-aec261fe576c'),
	(201,NULL,NULL,5,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:49','2020-02-15 21:13:49','2020-02-15 21:13:52','0cada77f-01a8-45e9-a720-aad4f4b96843'),
	(202,NULL,NULL,6,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:49','2020-02-15 21:13:49','2020-02-15 21:13:52','d184db5c-dc9a-47cc-85c6-7f9d63f40fef'),
	(203,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:49','2020-02-15 21:13:49','2020-02-15 21:13:52','e2418a8f-51cb-43b0-ad41-13ebd7f0f50c'),
	(204,NULL,NULL,9,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:49','2020-02-15 21:13:49','2020-02-15 21:13:52','6d2d6f4d-39ca-403a-8dff-07de30ef91a3'),
	(205,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:49','2020-02-15 21:13:49','2020-02-15 21:13:52','3de39448-3302-4455-8a82-ccc8e7d109d1'),
	(206,NULL,NULL,8,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:49','2020-02-15 21:13:49','2020-02-15 21:13:52','9f609884-5e47-4a7f-aca0-17d2bf3f8548'),
	(207,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:51','2020-02-15 21:13:51','2020-02-15 21:13:55','3fcd314e-367e-4237-a1d6-a35b7edfd8a7'),
	(208,NULL,NULL,5,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:51','2020-02-15 21:13:51','2020-02-15 21:13:55','65523251-670f-48bd-add4-a979c07c9fc5'),
	(209,NULL,NULL,6,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:52','2020-02-15 21:13:52','2020-02-15 21:13:55','5d91f21e-8ec1-4c97-a933-2618c6d7ea00'),
	(210,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:52','2020-02-15 21:13:52','2020-02-15 21:13:55','3411a6a3-2210-436f-b1bb-d4395e26afc9'),
	(211,NULL,NULL,9,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:52','2020-02-15 21:13:52','2020-02-15 21:13:55','a76e7862-f65b-45fc-9346-3436fc0bd0e5'),
	(212,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:52','2020-02-15 21:13:52','2020-02-15 21:13:55','a3342d5d-3e22-4a42-a9d0-1afc59d4c71b'),
	(213,NULL,NULL,8,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:52','2020-02-15 21:13:52','2020-02-15 21:13:55','44c1077b-079c-4987-9f2f-4d49d4bf2742'),
	(214,NULL,NULL,5,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:52','2020-02-15 21:13:52','2020-02-15 21:13:55','ec359662-424c-42ef-a71a-3411e5919250'),
	(215,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:55','2020-02-15 21:13:55','2020-02-15 21:13:59','38ecd473-6897-47de-abce-b4a11b4e19e2'),
	(216,NULL,NULL,5,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:55','2020-02-15 21:13:55','2020-02-15 21:13:59','81417f0d-5430-4061-b591-09bd611c4518'),
	(217,NULL,NULL,6,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:55','2020-02-15 21:13:55','2020-02-15 21:13:59','d6bcb1d0-0f00-449e-98ac-8d15426a680d'),
	(218,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:55','2020-02-15 21:13:55','2020-02-15 21:13:59','ef8ffe26-71b0-4aa5-a434-f591662054cb'),
	(219,NULL,NULL,9,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:55','2020-02-15 21:13:55','2020-02-15 21:13:59','e7951e95-d8b0-406b-95ff-719cd7a7fd52'),
	(220,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:55','2020-02-15 21:13:55','2020-02-15 21:13:59','b3140877-afd3-4eb2-9437-fd6608f07429'),
	(221,NULL,NULL,8,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:55','2020-02-15 21:13:55','2020-02-15 21:13:59','ef834041-0b85-4b2a-b59b-d019ba3cf645'),
	(222,NULL,NULL,5,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:55','2020-02-15 21:13:55','2020-02-15 21:13:59','abd11479-1de4-4b94-bbd2-a07f4e790503'),
	(223,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:59','2020-02-15 21:13:59','2020-02-15 21:14:00','46ed41f0-f806-4a55-868b-8d5034bfe002'),
	(224,NULL,NULL,5,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:59','2020-02-15 21:13:59','2020-02-15 21:14:00','f8f55777-c8c5-4838-ab3d-011e1d062dad'),
	(225,NULL,NULL,6,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:59','2020-02-15 21:13:59','2020-02-15 21:14:00','bdbe7407-632e-44fd-a342-f17014536a5c'),
	(226,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:59','2020-02-15 21:13:59','2020-02-15 21:14:00','1f01314a-b917-4cac-8f8a-934c536589ec'),
	(227,NULL,NULL,9,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:59','2020-02-15 21:13:59','2020-02-15 21:14:00','e6277a54-ceda-4182-9f42-e471e520a2db'),
	(228,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:59','2020-02-15 21:13:59','2020-02-15 21:14:00','1e69a350-030e-423a-822d-b63cc841c1bc'),
	(229,NULL,NULL,8,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:59','2020-02-15 21:13:59','2020-02-15 21:14:00','fda052fe-964b-4021-9141-cc46d85bd1c7'),
	(230,NULL,NULL,5,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:13:59','2020-02-15 21:13:59','2020-02-15 21:14:00','d012c60b-3d50-4554-b255-a521f976ab9f'),
	(231,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:00','2020-02-15 21:14:00','2020-02-15 21:14:02','2ae5a4a0-85de-4b0a-bd83-93d3bb0f1629'),
	(232,NULL,NULL,5,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:00','2020-02-15 21:14:00','2020-02-15 21:14:02','f27aaa76-2945-4c9b-ad27-5d9d862cb540'),
	(233,NULL,NULL,6,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:00','2020-02-15 21:14:00','2020-02-15 21:14:02','ce0dbac1-6e7e-452a-94c6-6d38b224b4da'),
	(234,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:00','2020-02-15 21:14:00','2020-02-15 21:14:02','7776d1cd-b906-4f6e-8d99-08384a6c5c1c'),
	(235,NULL,NULL,9,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:00','2020-02-15 21:14:00','2020-02-15 21:14:02','cef595bb-ef8d-486b-aac0-bf1a0fa0436e'),
	(236,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:00','2020-02-15 21:14:00','2020-02-15 21:14:02','4454bbdb-2122-4bef-8af2-426caf1f0fa5'),
	(237,NULL,NULL,8,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:00','2020-02-15 21:14:00','2020-02-15 21:14:02','587e8129-63b3-4e13-a293-346044e0d098'),
	(238,NULL,NULL,5,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:00','2020-02-15 21:14:00','2020-02-15 21:14:02','1fa10991-2bb5-4351-8ac3-e63cfdacbd33'),
	(239,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:02','2020-02-15 21:14:02','2020-02-15 21:14:11','6c6d34f5-13be-4106-9cd6-bad15ade2ded'),
	(240,NULL,NULL,5,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:02','2020-02-15 21:14:02','2020-02-15 21:14:11','d4183d96-0c53-4a07-9b50-31d8e39d4883'),
	(241,NULL,NULL,6,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:02','2020-02-15 21:14:02','2020-02-15 21:14:11','091189d3-f867-4c6f-b585-a271660a62cf'),
	(242,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:02','2020-02-15 21:14:02','2020-02-15 21:14:11','cd1fed28-d69b-4f7e-999e-69742087e1e8'),
	(243,NULL,NULL,9,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:02','2020-02-15 21:14:02','2020-02-15 21:14:11','81795af7-8fac-400e-9c20-7a2f38d2f5d4'),
	(244,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:02','2020-02-15 21:14:02','2020-02-15 21:14:11','3bd4097f-cb3a-4702-8380-d0a127e13f52'),
	(245,NULL,NULL,8,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:02','2020-02-15 21:14:02','2020-02-15 21:14:11','a5f1efe4-5904-4c1f-8f78-fc33da66c890'),
	(246,NULL,NULL,5,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:02','2020-02-15 21:14:02','2020-02-15 21:14:11','09248686-947d-4a7f-9cee-e8a0c37bb54d'),
	(247,NULL,NULL,8,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:02','2020-02-15 21:14:02','2020-02-15 21:14:11','c15a9ac9-77d7-44df-985d-7917cbff694b'),
	(248,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:10','2020-02-15 21:14:10','2020-02-15 21:14:12','c9582154-361c-4271-a64f-457474b146f3'),
	(249,NULL,NULL,5,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:11','2020-02-15 21:14:11','2020-02-15 21:14:12','3e41c353-d7b6-4601-8f55-1468e511cee2'),
	(250,NULL,NULL,6,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:11','2020-02-15 21:14:11','2020-02-15 21:14:12','f84e305b-0daf-443e-b701-b2855ae09765'),
	(251,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:11','2020-02-15 21:14:11','2020-02-15 21:14:12','11bc565f-ab57-4d3d-870c-dab5614dc444'),
	(252,NULL,NULL,9,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:11','2020-02-15 21:14:11','2020-02-15 21:14:12','834caad2-d424-4d70-ad94-ab2e356a5759'),
	(253,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:11','2020-02-15 21:14:11','2020-02-15 21:14:12','f89b758c-ce1f-44d7-8a47-b795b27f32a6'),
	(254,NULL,NULL,8,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:11','2020-02-15 21:14:11','2020-02-15 21:14:12','07b1e59c-8175-4999-ab00-39cdce4e03ad'),
	(255,NULL,NULL,5,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:11','2020-02-15 21:14:11','2020-02-15 21:14:12','32430dc7-525c-460e-a8e8-c6eafac33cda'),
	(256,NULL,NULL,8,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:11','2020-02-15 21:14:11','2020-02-15 21:14:12','aa6c4400-4c5a-435d-98db-5bca799eb0d6'),
	(257,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:12','2020-02-15 21:14:12','2020-02-15 21:14:13','10ad7755-62bb-4b1d-ab47-bc3523682dc2'),
	(258,NULL,NULL,5,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:12','2020-02-15 21:14:12','2020-02-15 21:14:13','253c60eb-aec6-4dbf-a1b8-882c69ba6113'),
	(259,NULL,NULL,6,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:12','2020-02-15 21:14:12','2020-02-15 21:14:13','3b8bdc90-7621-46b8-b47e-b8a28831c660'),
	(260,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:12','2020-02-15 21:14:12','2020-02-15 21:14:13','9ba75d9e-3841-4b2b-adcb-b12cf4adb3f4'),
	(261,NULL,NULL,9,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:12','2020-02-15 21:14:12','2020-02-15 21:14:13','a85bbd84-1263-4fc7-9504-60a4dfcc9569'),
	(262,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:12','2020-02-15 21:14:12','2020-02-15 21:14:13','7fb944d4-165e-4d14-b56e-7b5f518ff5d3'),
	(263,NULL,NULL,8,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:12','2020-02-15 21:14:12','2020-02-15 21:14:13','ddb3f403-281e-4737-8ab8-951ec11513cc'),
	(264,NULL,NULL,5,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:12','2020-02-15 21:14:12','2020-02-15 21:14:13','d6bfddb4-c738-40bf-966c-b04f8dd5c07c'),
	(265,NULL,NULL,8,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:12','2020-02-15 21:14:12','2020-02-15 21:14:13','c53113b4-2937-4444-92a7-bec8815cda7d'),
	(266,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:12','2020-02-15 21:14:12','2020-02-15 21:14:18','df74fc7b-ee62-4250-a04c-e737bb67d4ad'),
	(267,NULL,NULL,5,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:12','2020-02-15 21:14:12','2020-02-15 21:14:18','e7541813-8d21-455a-a002-2a9115898adf'),
	(268,NULL,NULL,6,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:12','2020-02-15 21:14:12','2020-02-15 21:14:18','d261afdc-bae5-4c2e-b72b-029705b3f7a5'),
	(269,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:12','2020-02-15 21:14:12','2020-02-15 21:14:18','def33e95-ff31-4d71-a43c-3cac58d0fa3d'),
	(270,NULL,NULL,9,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:13','2020-02-15 21:14:13','2020-02-15 21:14:18','185b28aa-a643-4fd7-9809-5299d304a141'),
	(271,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:13','2020-02-15 21:14:13','2020-02-15 21:14:18','c0f51a22-c190-4331-a179-539f9f3e8e5f'),
	(272,NULL,NULL,8,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:13','2020-02-15 21:14:13','2020-02-15 21:14:18','1e614209-89d4-4ab8-a48e-2e3a195fb215'),
	(273,NULL,NULL,5,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:13','2020-02-15 21:14:13','2020-02-15 21:14:18','9c5cc648-1818-462d-8ded-d8e814ec0243'),
	(274,NULL,NULL,8,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:13','2020-02-15 21:14:13','2020-02-15 21:14:18','8ea809d1-8fca-4009-92d5-d737fc17f07c'),
	(275,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:18','2020-02-15 21:14:18','2020-02-15 21:14:19','d817a11f-3476-4e0c-b408-169e784e894c'),
	(276,NULL,NULL,5,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:18','2020-02-15 21:14:18','2020-02-15 21:14:19','b0c1069b-2254-40e2-aee4-46358382b30b'),
	(277,NULL,NULL,6,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:18','2020-02-15 21:14:18','2020-02-15 21:14:19','b8b3311e-d123-4007-a5c1-ac4206c45dff'),
	(278,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:18','2020-02-15 21:14:18','2020-02-15 21:14:19','96134960-761f-4b89-9d8a-ad2e53cd9f00'),
	(279,NULL,NULL,9,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:18','2020-02-15 21:14:18','2020-02-15 21:14:19','81165726-ac64-4392-aacd-25ce00a6984c'),
	(280,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:18','2020-02-15 21:14:18','2020-02-15 21:14:19','ae063ca4-01f8-4f59-ab83-7cbc5b6fea6d'),
	(281,NULL,NULL,8,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:18','2020-02-15 21:14:18','2020-02-15 21:14:19','5ae25338-d0de-4700-b172-bc342dbb0851'),
	(282,NULL,NULL,5,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:18','2020-02-15 21:14:18','2020-02-15 21:14:19','85c9e322-2a14-4ea0-8281-87378a9d139d'),
	(283,NULL,NULL,8,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:18','2020-02-15 21:14:18','2020-02-15 21:14:19','bfd6465d-9325-4a73-9a39-f3ed3b1d75ec'),
	(284,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:19','2020-02-15 21:14:19','2020-02-15 21:14:23','4acd4445-7a78-44fe-b63d-590970bada54'),
	(285,NULL,NULL,5,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:19','2020-02-15 21:14:19','2020-02-15 21:14:23','e4b4facd-5118-4a1b-a8ab-100ad8ddc7e9'),
	(286,NULL,NULL,6,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:19','2020-02-15 21:14:19','2020-02-15 21:14:23','f34aa5c3-145b-43c7-a9c6-2331f8644634'),
	(287,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:19','2020-02-15 21:14:19','2020-02-15 21:14:23','5972c9f5-1935-4051-9f5a-13596854ceb2'),
	(288,NULL,NULL,9,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:19','2020-02-15 21:14:19','2020-02-15 21:14:23','1bc4990a-e2b4-4c50-b8c8-4beea6e46281'),
	(289,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:19','2020-02-15 21:14:19','2020-02-15 21:14:23','de49111d-ae3d-4e44-9843-3f3db553b628'),
	(290,NULL,NULL,8,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:19','2020-02-15 21:14:19','2020-02-15 21:14:23','f0cf290f-a790-4e81-843c-c5824f89ed7f'),
	(291,NULL,NULL,5,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:19','2020-02-15 21:14:19','2020-02-15 21:14:23','eeca4ff0-7992-42c5-8bf3-7502bba3261f'),
	(292,NULL,NULL,8,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:19','2020-02-15 21:14:19','2020-02-15 21:14:23','2f87a2b8-a481-4a1e-8cd0-f94de93d990a'),
	(293,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:22','2020-02-15 21:14:22','2020-02-15 21:14:28','c4eab7ab-3b70-4dec-bdc1-03939840572c'),
	(294,NULL,NULL,5,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:22','2020-02-15 21:14:22','2020-02-15 21:14:28','c0e4bb2f-4688-41d5-b12a-7ca02d6b376a'),
	(295,NULL,NULL,6,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:22','2020-02-15 21:14:22','2020-02-15 21:14:28','05ba0e11-5add-4905-832d-a9a986ea6dd0'),
	(296,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:22','2020-02-15 21:14:22','2020-02-15 21:14:28','feb2f6ba-568b-4412-8344-bf4460a2e7e7'),
	(297,NULL,NULL,9,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:22','2020-02-15 21:14:22','2020-02-15 21:14:28','e9c31583-6b9e-4458-9c99-f5814196f6cf'),
	(298,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:22','2020-02-15 21:14:22','2020-02-15 21:14:28','2aedb5cb-c700-4858-b0ed-3882473efb57'),
	(299,NULL,NULL,8,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:22','2020-02-15 21:14:22','2020-02-15 21:14:28','df302fc9-926a-4b11-a0b6-83659f3d27af'),
	(300,NULL,NULL,5,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:22','2020-02-15 21:14:22','2020-02-15 21:14:28','ebad9627-54e4-49cf-b38a-4fecf04ff81a'),
	(301,NULL,NULL,8,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:23','2020-02-15 21:14:23','2020-02-15 21:14:28','9cb93d7a-bb8f-4bdf-9fff-91a34304fdf3'),
	(302,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:28','2020-02-15 21:14:28','2020-02-15 21:14:35','49cc0c32-a02f-49a4-859d-190074d1554b'),
	(303,NULL,NULL,5,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:28','2020-02-15 21:14:28','2020-02-15 21:14:35','9d57dc6c-a614-4552-b687-5de9e5ebe5cf'),
	(304,NULL,NULL,6,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:28','2020-02-15 21:14:28','2020-02-15 21:14:35','17a76d1e-72a1-4c31-8b80-8c10e86fa905'),
	(305,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:28','2020-02-15 21:14:28','2020-02-15 21:14:35','29138c3a-80f6-4199-bb6a-eecef1ca4a83'),
	(306,NULL,NULL,9,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:28','2020-02-15 21:14:28','2020-02-15 21:14:35','3dfa123b-2c5c-4183-bb93-9177082ec3fa'),
	(307,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:28','2020-02-15 21:14:28','2020-02-15 21:14:35','93e9e3a2-0ca2-4350-bc76-914c49e4592f'),
	(308,NULL,NULL,8,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:28','2020-02-15 21:14:28','2020-02-15 21:14:35','aecbc6fb-d59f-455f-9e23-cecd1e30001d'),
	(309,NULL,NULL,8,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:28','2020-02-15 21:14:28','2020-02-15 21:14:35','438534b0-d081-40e1-b88f-69faae451ae9'),
	(310,NULL,NULL,5,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:28','2020-02-15 21:14:28','2020-02-15 21:14:35','e7f34d60-8020-4eca-9ab2-e02ca0c086c8'),
	(311,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:35','2020-02-15 21:14:35','2020-02-15 21:14:42','bffe29bf-1360-4eb6-8cc4-96bf011519bc'),
	(312,NULL,NULL,5,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:35','2020-02-15 21:14:35','2020-02-15 21:14:42','5bc93ea5-c69d-4ca6-a091-8477e2ec4ff1'),
	(313,NULL,NULL,6,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:35','2020-02-15 21:14:35','2020-02-15 21:14:42','98c1e594-7bbe-4b1a-9777-95b8a5a4c8a3'),
	(314,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:35','2020-02-15 21:14:35','2020-02-15 21:14:42','c85b3ccf-0b63-4e63-86f8-78a1bdedf266'),
	(315,NULL,NULL,9,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:35','2020-02-15 21:14:35','2020-02-15 21:14:42','8745767a-972b-4774-8dfe-122a152d1f6d'),
	(316,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:35','2020-02-15 21:14:35','2020-02-15 21:14:42','a4a12916-1114-4bee-962e-0777fc17cb80'),
	(317,NULL,NULL,8,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:35','2020-02-15 21:14:35','2020-02-15 21:14:42','2ab4f0b6-7da6-41c3-a0dd-17a2271fdb04'),
	(318,NULL,NULL,6,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:35','2020-02-15 21:14:35','2020-02-15 21:14:42','63ba0f05-3959-4d97-bda6-e023a088fdb1'),
	(319,NULL,NULL,8,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:35','2020-02-15 21:14:35','2020-02-15 21:14:42','d2e99d8e-3a5a-4e9b-91a0-9ad62346cab9'),
	(320,NULL,NULL,5,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:35','2020-02-15 21:14:35','2020-02-15 21:14:42','df7f5fa0-e197-47df-81d2-b18ccdcf70e5'),
	(321,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:42','2020-02-15 21:14:42','2020-02-15 21:14:46','c1201a91-658d-4866-bc7f-ee47f0ac8b05'),
	(322,NULL,NULL,5,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:42','2020-02-15 21:14:42','2020-02-15 21:14:46','eb8cac2f-5b0f-4a9b-901d-26dd47e40232'),
	(323,NULL,NULL,6,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:42','2020-02-15 21:14:42','2020-02-15 21:14:46','4ab37384-da16-4f6d-b5b2-ffed23eb41f9'),
	(324,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:42','2020-02-15 21:14:42','2020-02-15 21:14:46','a9180ab6-6ac9-493f-ab90-e00671783dce'),
	(325,NULL,NULL,9,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:42','2020-02-15 21:14:42','2020-02-15 21:14:46','592516f2-eb1f-46ab-a474-e3d06ee0f33e'),
	(326,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:42','2020-02-15 21:14:42','2020-02-15 21:14:46','0196ac76-d2c1-4052-9c5a-1234d462bd43'),
	(327,NULL,NULL,8,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:42','2020-02-15 21:14:42','2020-02-15 21:14:46','c2b9bfa5-9cdd-41ed-adb6-a0f5e509cbe9'),
	(328,NULL,NULL,6,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:42','2020-02-15 21:14:42','2020-02-15 21:14:46','64baed71-ec81-4155-a6ef-3a78c9d64437'),
	(329,NULL,NULL,8,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:42','2020-02-15 21:14:42','2020-02-15 21:14:46','61486321-b543-488e-ad24-62c1efadf81b'),
	(330,NULL,NULL,5,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:42','2020-02-15 21:14:42','2020-02-15 21:14:46','f8f3d17a-e4be-49d6-8d3d-3317aeb0fc4d'),
	(331,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:46','2020-02-15 21:14:46','2020-02-15 21:14:49','aa95bc62-e517-4471-9ec4-52ebab03404b'),
	(332,NULL,NULL,5,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:46','2020-02-15 21:14:46','2020-02-15 21:14:49','6bb14d26-3371-4e6a-809e-6198e2ac64f4'),
	(333,NULL,NULL,6,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:46','2020-02-15 21:14:46','2020-02-15 21:14:49','7128332e-1380-4ff9-ad41-41f52c4758e3'),
	(334,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:46','2020-02-15 21:14:46','2020-02-15 21:14:49','41769296-30f3-44cf-8894-2665cd438291'),
	(335,NULL,NULL,9,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:46','2020-02-15 21:14:46','2020-02-15 21:14:49','a7012a4b-942c-45a7-8cee-a0dfb1c23d34'),
	(336,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:46','2020-02-15 21:14:46','2020-02-15 21:14:49','864bf961-1ab0-465a-8c05-cb5c1eea5625'),
	(337,NULL,NULL,8,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:46','2020-02-15 21:14:46','2020-02-15 21:14:49','d6ae04b1-7577-4a9b-aa6b-a7f07434ff94'),
	(338,NULL,NULL,6,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:46','2020-02-15 21:14:46','2020-02-15 21:14:49','42fdde39-5bcf-4923-a5d7-6c57e274d4f0'),
	(339,NULL,NULL,8,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:46','2020-02-15 21:14:46','2020-02-15 21:14:49','7613a34a-b71a-475b-86e9-792332993e2d'),
	(340,NULL,NULL,5,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:46','2020-02-15 21:14:46','2020-02-15 21:14:49','21881bbe-83bb-4773-b5c5-d182e1a995a9'),
	(341,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:49','2020-02-15 21:14:49','2020-02-15 21:14:51','556b4c43-8a53-4877-bfcd-c0bbc331209d'),
	(342,NULL,NULL,5,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:49','2020-02-15 21:14:49','2020-02-15 21:14:51','b2bd1a58-ca45-4c1e-ae94-0f4c893828f7'),
	(343,NULL,NULL,6,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:49','2020-02-15 21:14:49','2020-02-15 21:14:51','69a7628b-4d9a-4365-9120-f7899d47d644'),
	(344,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:49','2020-02-15 21:14:49','2020-02-15 21:14:51','c61f050a-1002-4162-b00e-be180b2ef6d5'),
	(345,NULL,NULL,9,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:49','2020-02-15 21:14:49','2020-02-15 21:14:51','f9034e90-0fd2-46bf-af58-996ad62f9652'),
	(346,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:49','2020-02-15 21:14:49','2020-02-15 21:14:51','b91cef20-5dca-4383-9aa2-f120b8a9c11a'),
	(347,NULL,NULL,8,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:49','2020-02-15 21:14:49','2020-02-15 21:14:51','93d211a5-aa23-485e-9279-a86a7ae51188'),
	(348,NULL,NULL,6,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:49','2020-02-15 21:14:49','2020-02-15 21:14:51','235f5dee-ef55-4a5b-98fd-9a42d4ad682e'),
	(349,NULL,NULL,8,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:49','2020-02-15 21:14:49','2020-02-15 21:14:51','fad4903f-6aa4-4a27-9d14-7d6b69a0d6f7'),
	(350,NULL,NULL,5,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:49','2020-02-15 21:14:49','2020-02-15 21:14:51','5ab39c93-c2bd-441c-87ef-d889db03f831'),
	(351,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:51','2020-02-15 21:14:51','2020-02-15 21:14:51','d1c7f20c-33c3-4257-add9-1f8bafdd4b7e'),
	(352,NULL,NULL,5,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:51','2020-02-15 21:14:51','2020-02-15 21:14:51','522427f5-7297-4ea3-bf14-4b5229d45c54'),
	(353,NULL,NULL,6,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:51','2020-02-15 21:14:51','2020-02-15 21:14:51','228d4921-4848-43a8-b004-dc5cfb0cd76d'),
	(354,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:51','2020-02-15 21:14:51','2020-02-15 21:14:51','93d9dae5-44a9-4d5f-8297-ab643eb07ff7'),
	(355,NULL,NULL,9,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:51','2020-02-15 21:14:51','2020-02-15 21:14:51','5e80e330-b58e-4dea-a67e-6fd7358ae193'),
	(356,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:51','2020-02-15 21:14:51','2020-02-15 21:14:51','7dc407c3-0167-4c07-992e-bc2dafa156e3'),
	(357,NULL,NULL,8,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:51','2020-02-15 21:14:51','2020-02-15 21:14:51','d8d4c8e8-856c-4db9-81fd-036d5d4fc37b'),
	(358,NULL,NULL,6,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:51','2020-02-15 21:14:51','2020-02-15 21:14:51','382c7e9c-997c-4c54-a039-3121a5312114'),
	(359,NULL,NULL,8,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:51','2020-02-15 21:14:51','2020-02-15 21:14:51','7d381d20-800b-4a88-a22a-4cd8759815e0'),
	(360,NULL,NULL,5,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:51','2020-02-15 21:14:51','2020-02-15 21:14:51','30cf0be9-047b-4e31-8bd4-957f4ae7bcd0'),
	(361,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:51','2020-02-15 21:14:51','2020-02-15 21:14:54','95365321-0f35-43cc-a1e3-c708a1d92584'),
	(362,NULL,NULL,5,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:51','2020-02-15 21:14:51','2020-02-15 21:14:54','fdc5b813-59ab-47df-aa76-1acf3c7a9e9f'),
	(363,NULL,NULL,6,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:51','2020-02-15 21:14:51','2020-02-15 21:14:54','0d1682ae-c84b-4e67-86a0-12eb87fdf18f'),
	(364,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:51','2020-02-15 21:14:51','2020-02-15 21:14:54','95a85db8-973f-460a-b077-e2af739eb557'),
	(365,NULL,NULL,9,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:51','2020-02-15 21:14:51','2020-02-15 21:14:54','b6b8141f-00a7-402b-a58e-82e0ea06e5e7'),
	(366,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:51','2020-02-15 21:14:51','2020-02-15 21:14:54','9114bb1a-a0e2-491c-b6e3-c3d7cb0b7c47'),
	(367,NULL,NULL,8,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:51','2020-02-15 21:14:51','2020-02-15 21:14:54','af3a4fdf-d7bb-4765-a968-f75acaef0183'),
	(368,NULL,NULL,6,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:51','2020-02-15 21:14:51','2020-02-15 21:14:54','a6a9ff26-719d-42c8-85d8-4879aa6da160'),
	(369,NULL,NULL,8,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:51','2020-02-15 21:14:51','2020-02-15 21:14:54','01f9ab0f-49db-4f9f-800c-7be45dc94526'),
	(370,NULL,NULL,5,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:14:51','2020-02-15 21:14:51','2020-02-15 21:14:54','2d0cd737-6b95-4ddd-97be-c60f4f0253bc'),
	(381,NULL,NULL,10,'craft\\elements\\Entry',1,0,'2020-02-15 21:15:15','2020-02-15 22:50:45',NULL,'1d742b72-d384-497a-91e4-fbb1e5a34f91'),
	(382,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:15:15','2020-02-15 21:14:54','2020-02-15 22:15:01','8faa8186-582f-4b68-979b-5bc3b59ee1d2'),
	(383,NULL,NULL,5,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:15:15','2020-02-15 21:14:54','2020-02-15 22:15:01','3e0dafe3-efbe-4e98-95ed-5fdd5c6a0fa8'),
	(384,NULL,NULL,6,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:15:15','2020-02-15 21:14:54','2020-02-15 22:15:01','9638e214-b800-4aaa-a08c-4e9257ad7d2f'),
	(385,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:15:15','2020-02-15 21:14:54','2020-02-15 22:15:01','6a4fc4be-7d2f-48ac-8819-d444e4acfd8d'),
	(386,NULL,NULL,9,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:15:15','2020-02-15 21:14:54','2020-02-15 22:15:01','dc72ba8e-04f1-42ae-8e84-ab87d18fdb33'),
	(387,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:15:15','2020-02-15 21:14:54','2020-02-15 22:15:01','38a019aa-18fb-47f8-91e9-cf99607a2335'),
	(388,NULL,NULL,8,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:15:15','2020-02-15 21:14:54','2020-02-15 22:15:01','adbefa68-82c5-4b15-8e05-d140a64668e7'),
	(389,NULL,NULL,8,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:15:15','2020-02-15 21:14:54','2020-02-15 22:15:01','33a97715-ce7e-47f7-ae4f-91fd0f758e6d'),
	(390,NULL,NULL,6,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:15:15','2020-02-15 21:14:54','2020-02-15 22:15:01','6f7812e8-1ea0-46a1-b6ac-ce7cce17f5c2'),
	(391,NULL,NULL,5,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:15:15','2020-02-15 21:14:54','2020-02-15 22:15:01','883882c6-5586-48ce-9ce3-4c073d41a7af'),
	(392,NULL,20,10,'craft\\elements\\Entry',1,0,'2020-02-15 21:15:15','2020-02-15 21:15:15',NULL,'37f1f704-59ac-4df2-aee9-51d045d48750'),
	(393,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:15:16','2020-02-15 21:14:54',NULL,'9b072875-932c-4450-8445-69ec721e544a'),
	(394,NULL,NULL,5,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:15:16','2020-02-15 21:14:54',NULL,'8fa7aedd-b8c4-47ef-ada3-bb0e722fa7eb'),
	(395,NULL,NULL,6,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:15:16','2020-02-15 21:14:54',NULL,'634f8889-6a15-41f4-8a5c-293afca804ef'),
	(396,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:15:16','2020-02-15 21:14:54',NULL,'6e0594ca-69d4-4d3f-ba91-81180da17630'),
	(397,NULL,NULL,9,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:15:16','2020-02-15 21:14:54',NULL,'72f595f0-2378-4317-b45b-ca7dc3d43551'),
	(398,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:15:16','2020-02-15 21:14:54',NULL,'433e21b9-2b4c-4d5f-874c-18b605b43cd4'),
	(399,NULL,NULL,8,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:15:16','2020-02-15 21:14:54',NULL,'9219dd4b-47d6-43f6-bd45-9e52ca83f06c'),
	(400,NULL,NULL,8,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:15:16','2020-02-15 21:14:54',NULL,'5e1dfa65-7fda-453b-8eca-b9cffbb291ed'),
	(401,NULL,NULL,6,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:15:16','2020-02-15 21:14:54',NULL,'31f1b961-e782-4c83-86ea-2c4a37f22937'),
	(402,NULL,NULL,5,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 21:15:16','2020-02-15 21:14:54',NULL,'3a390434-cc6a-4ca1-b351-308bdda0d6cf'),
	(414,NULL,NULL,8,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 22:13:52','2020-02-15 22:13:52','2020-02-15 22:14:00','b18d07f1-0739-49af-b30c-97533559eb44'),
	(415,NULL,NULL,8,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 22:14:00','2020-02-15 22:14:00','2020-02-15 22:14:00','b8b91b81-5c24-4458-b590-08ff78c670d7'),
	(416,NULL,NULL,8,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 22:14:00','2020-02-15 22:14:00','2020-02-15 22:14:10','edf0fd0c-e704-406e-ae85-4e9e1c0c3278'),
	(417,NULL,NULL,8,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 22:14:10','2020-02-15 22:14:10','2020-02-15 22:14:14','82b28352-8aef-4023-bc54-d93603373777'),
	(418,NULL,NULL,8,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 22:14:14','2020-02-15 22:14:14','2020-02-15 22:14:21','8c948845-74a1-4c4f-84c7-5e9777230b5f'),
	(419,NULL,NULL,8,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 22:14:21','2020-02-15 22:14:21','2020-02-15 22:14:29','11dabffa-38cb-4717-aea3-e5087b61a268'),
	(420,NULL,NULL,5,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 22:14:29','2020-02-15 22:14:29','2020-02-15 22:14:32','e6820c24-0a3f-4110-831b-1548de56e0e1'),
	(421,NULL,NULL,8,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 22:14:29','2020-02-15 22:14:29','2020-02-15 22:14:32','a6664c1c-b352-4034-bb9e-3174f7261ba4'),
	(422,NULL,NULL,5,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 22:14:32','2020-02-15 22:14:32','2020-02-15 22:14:37','1a121d40-1395-4cc6-b018-fb6176ea408e'),
	(423,NULL,NULL,8,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 22:14:32','2020-02-15 22:14:32','2020-02-15 22:14:37','041480ed-cca2-436b-b32b-4ed35556c883'),
	(426,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 22:15:01','2020-02-15 21:14:54',NULL,'44f07457-0593-41a3-a149-c651b67a167f'),
	(427,NULL,NULL,5,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 22:15:01','2020-02-15 21:14:54',NULL,'a5b2da84-20c5-4fd3-825f-3999596b46fe'),
	(428,NULL,NULL,6,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 22:15:01','2020-02-15 21:14:54',NULL,'d9509356-4694-49ee-940e-fa93bacf93f1'),
	(429,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 22:15:01','2020-02-15 21:14:54',NULL,'720f9b94-2465-438e-b934-8ab176785a05'),
	(430,NULL,NULL,9,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 22:15:01','2020-02-15 21:14:54',NULL,'7c5649f7-2efc-4a03-a551-4390a41f180e'),
	(431,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 22:15:01','2020-02-15 21:14:54',NULL,'238d9a6d-4112-4872-8ae3-8c46cd231e0e'),
	(432,NULL,NULL,5,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 22:15:01','2020-02-15 22:14:37',NULL,'543c781b-d678-4a2b-bf79-ab67aaf608cd'),
	(433,NULL,NULL,6,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 22:15:01','2020-02-15 21:14:54',NULL,'1a49da33-2985-46b6-aab3-bb89c976ff10'),
	(434,NULL,NULL,5,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 22:15:01','2020-02-15 21:14:54',NULL,'67af84ff-589f-438f-8c2a-13636cc9189a'),
	(435,NULL,NULL,8,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 22:15:01','2020-02-15 22:14:37',NULL,'d24f84ae-d02a-4982-aaf7-bf796107c461'),
	(436,NULL,NULL,8,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 22:15:01','2020-02-15 21:14:54',NULL,'b04ab410-c2d2-4d63-a117-9833d13b1152'),
	(437,NULL,NULL,8,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 22:15:01','2020-02-15 21:14:54',NULL,'d4f8845e-5ce5-4aae-9c99-405b3a32fbb6'),
	(438,NULL,21,10,'craft\\elements\\Entry',1,0,'2020-02-15 22:15:01','2020-02-15 22:15:01',NULL,'b4b86b51-3dcf-4bc3-a0df-1b410064cee1'),
	(439,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 22:15:02','2020-02-15 21:14:54',NULL,'fcbe87bc-2ac0-49cf-b5ac-2f059fde04ff'),
	(440,NULL,NULL,5,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 22:15:02','2020-02-15 21:14:54',NULL,'b6d7e272-0a28-4ed6-810e-df877bdb8270'),
	(441,NULL,NULL,6,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 22:15:02','2020-02-15 21:14:54',NULL,'dd776ae0-4a84-43e8-8358-fd27455419d3'),
	(442,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 22:15:02','2020-02-15 21:14:54',NULL,'7dbcfe70-92fd-4e04-8006-7abd6c819776'),
	(443,NULL,NULL,9,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 22:15:02','2020-02-15 21:14:54',NULL,'c28d3a53-dd32-4cc2-957c-5a31a15a651f'),
	(444,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 22:15:02','2020-02-15 21:14:54',NULL,'496641ad-4c02-47e6-b747-946247fadcec'),
	(445,NULL,NULL,5,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 22:15:02','2020-02-15 22:14:37',NULL,'e91e3ca7-bb1b-4131-8d92-7a8bf1a959f2'),
	(446,NULL,NULL,6,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 22:15:02','2020-02-15 21:14:54',NULL,'421a6725-0be0-4148-8f2b-e3d73a9cb53c'),
	(447,NULL,NULL,5,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 22:15:02','2020-02-15 21:14:54',NULL,'8533fd40-1dd3-45ac-9924-da72daf75257'),
	(448,NULL,NULL,8,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 22:15:02','2020-02-15 22:14:37',NULL,'3fde001a-9da8-4319-944e-acc73a96cb65'),
	(449,NULL,NULL,8,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 22:15:02','2020-02-15 21:14:54',NULL,'328020dc-2a7f-423c-bffe-722d08425b2c'),
	(450,NULL,NULL,8,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 22:15:02','2020-02-15 21:14:54',NULL,'a0913e30-4514-480c-bc0d-c0a68bf75c9c'),
	(451,NULL,NULL,11,'craft\\elements\\Category',1,0,'2020-02-15 22:47:46','2020-02-15 22:47:46',NULL,'0b61cbb6-381f-4abb-a65c-e51c4fb27dbf'),
	(452,NULL,22,10,'craft\\elements\\Entry',1,0,'2020-02-15 22:50:45','2020-02-15 22:50:45',NULL,'5f4f7135-2aee-40eb-96bd-1ed1bd43f0bb'),
	(453,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 22:50:45','2020-02-15 21:14:54',NULL,'5841c61a-bce8-48be-bc44-c0b6f87086dc'),
	(454,NULL,NULL,5,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 22:50:45','2020-02-15 21:14:54',NULL,'0838e702-a07c-4b10-93ee-093e75adcd08'),
	(455,NULL,NULL,6,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 22:50:45','2020-02-15 21:14:54',NULL,'0c7861c6-f1ce-4c19-bf51-b44e106c2b74'),
	(456,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 22:50:45','2020-02-15 21:14:54',NULL,'b32d1270-2e16-4395-8bb6-045442e0a695'),
	(457,NULL,NULL,9,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 22:50:45','2020-02-15 21:14:54',NULL,'0b6c841f-0796-4cbd-a491-03354e141f72'),
	(458,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 22:50:45','2020-02-15 21:14:54',NULL,'3449c1f9-97ea-4f3e-b47d-62458acc5cbd'),
	(459,NULL,NULL,5,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 22:50:45','2020-02-15 22:14:37',NULL,'38619219-eb7a-4b78-b96e-0573b9f22590'),
	(460,NULL,NULL,6,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 22:50:45','2020-02-15 21:14:54',NULL,'2a163a40-3dc1-4ede-8801-59a1d21783bc'),
	(461,NULL,NULL,5,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 22:50:45','2020-02-15 21:14:54',NULL,'966d9a19-0d7f-4a66-888a-3a8b437073e8'),
	(462,NULL,NULL,8,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 22:50:45','2020-02-15 22:14:37',NULL,'2d575e02-7470-4f80-b8e9-4592767c0bf3'),
	(463,NULL,NULL,8,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 22:50:45','2020-02-15 21:14:54',NULL,'2e8d0f18-ad89-45f1-9686-2ecc14ad0a0a'),
	(464,NULL,NULL,8,'craft\\elements\\MatrixBlock',1,0,'2020-02-15 22:50:45','2020-02-15 21:14:54',NULL,'3e54ca61-3c1f-4083-b095-17d85f9184ae'),
	(465,NULL,23,1,'craft\\elements\\Entry',1,0,'2020-02-15 22:51:26','2020-02-15 22:51:26',NULL,'8901150f-c2c8-40b3-bb35-7fbc396227b2'),
	(466,NULL,24,1,'craft\\elements\\Entry',1,0,'2020-02-15 23:27:27','2020-02-15 23:27:27',NULL,'1528f8ea-8c6e-4d67-8f36-7fb54857a8d5'),
	(467,NULL,NULL,11,'craft\\elements\\Category',1,0,'2020-02-15 23:57:34','2020-02-15 23:57:34',NULL,'4aa8a99b-bc3d-414c-a4a4-83d91f815165'),
	(468,NULL,NULL,10,'craft\\elements\\Entry',1,0,'2020-02-16 00:02:30','2020-02-16 00:02:30',NULL,'baa7e8af-278f-44ca-b010-0f409df87c5f'),
	(469,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-16 00:02:30','2020-02-16 00:02:30',NULL,'a85e97cf-467c-4d88-84bb-01cba8628dee'),
	(470,NULL,25,10,'craft\\elements\\Entry',1,0,'2020-02-16 00:02:30','2020-02-16 00:02:30',NULL,'a4925eb9-21db-405f-a132-eadd03b07d94'),
	(471,NULL,26,1,'craft\\elements\\Entry',1,0,'2020-02-16 00:02:37','2020-02-16 00:02:37',NULL,'52108856-7784-4084-97c8-47eb444e734c'),
	(472,NULL,27,1,'craft\\elements\\Entry',1,0,'2020-02-16 00:02:47','2020-02-16 00:02:47',NULL,'c1eb18a7-60d1-4a23-8246-27a045918854');

/*!40000 ALTER TABLE `elements` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table elements_sites
# ------------------------------------------------------------

DROP TABLE IF EXISTS `elements_sites`;

CREATE TABLE `elements_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `uri` varchar(255) DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT 1,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `elements_sites_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `elements_sites_siteId_idx` (`siteId`),
  KEY `elements_sites_slug_siteId_idx` (`slug`,`siteId`),
  KEY `elements_sites_enabled_idx` (`enabled`),
  KEY `elements_sites_uri_siteId_idx` (`uri`,`siteId`),
  CONSTRAINT `elements_sites_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `elements_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `elements_sites` WRITE;
/*!40000 ALTER TABLE `elements_sites` DISABLE KEYS */;

INSERT INTO `elements_sites` (`id`, `elementId`, `siteId`, `slug`, `uri`, `enabled`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,1,1,NULL,NULL,1,'2020-02-01 17:54:17','2020-02-01 17:54:17','534177b4-a4c6-4c58-a346-77c0b11aefd2'),
	(2,2,1,'__temp_PQxJ6npOhuiCXEXUN5pJayPnZCt43UyWBVIk','drinks/__temp_PQxJ6npOhuiCXEXUN5pJayPnZCt43UyWBVIk',1,'2020-02-01 20:56:39','2020-02-01 20:56:39','6ac0a202-8c66-4df0-99e3-14c2859e6d3f'),
	(3,3,1,'__temp_8jN9YKNpCt5fbOBzEt3M9AVM9xL1bYS8EXAO','drinks/__temp_8jN9YKNpCt5fbOBzEt3M9AVM9xL1bYS8EXAO',1,'2020-02-01 21:07:32','2020-02-01 21:07:32','975395c6-0dbb-4051-a29f-6c3e2cc53000'),
	(5,5,1,'espresso','drinks/espresso',1,'2020-02-01 21:10:00','2020-02-01 21:10:00','6e1436bd-5e6d-4e51-ad8e-761945b24dec'),
	(6,6,1,'espresso','drinks/espresso',1,'2020-02-01 21:10:00','2020-02-01 21:10:00','c274bec2-aed2-46ef-b76a-0b9292e6cbdf'),
	(7,7,1,'__temp_2pAURDwlvBA7cdVIXxQnuHvzIHAwJEeqmakA','news/__temp_2pAURDwlvBA7cdVIXxQnuHvzIHAwJEeqmakA',1,'2020-02-01 21:10:40','2020-02-01 21:10:40','69fe833b-20ca-4764-bf07-ce37393da72a'),
	(9,9,1,'new-coffee-coming-soon','news/new-coffee-coming-soon',1,'2020-02-01 21:11:43','2020-02-01 21:11:43','deb83761-a5d7-4711-8037-57c9a2de5a43'),
	(10,10,1,'new-coffee-coming-soon','news/new-coffee-coming-soon',1,'2020-02-01 21:11:44','2020-02-01 21:11:44','6101648c-2fb0-4a2b-9dce-2725525bed2f'),
	(11,11,1,'homepage','__home__',1,'2020-02-09 17:31:35','2020-02-09 17:31:35','e8156a67-f02a-45bb-8cdb-dcab6374cb52'),
	(12,12,1,'homepage','__home__',1,'2020-02-09 17:31:35','2020-02-09 17:31:35','bf7a632e-6d98-4b4f-afb8-e2887a7a4982'),
	(13,13,1,'homepage','__home__',1,'2020-02-09 17:31:36','2020-02-09 17:31:36','7cd6e935-5212-4657-8330-f68150a60da6'),
	(14,14,1,'homepage','__home__',1,'2020-02-09 17:32:33','2020-02-09 17:32:33','8f725684-1482-4988-89da-9f92f0ba8eec'),
	(15,15,1,NULL,NULL,1,'2020-02-09 17:51:07','2020-02-09 17:51:07','4620076a-9960-4837-8253-611a9d287ee6'),
	(16,16,1,'espresso','drinks/espresso',1,'2020-02-09 19:06:20','2020-02-09 19:06:20','34c401ac-e466-43c1-9698-2fee732280cf'),
	(17,17,1,NULL,NULL,1,'2020-02-09 19:10:14','2020-02-09 19:10:14','df046efd-279a-4ae0-98ea-0568cccb67fe'),
	(19,19,1,'iced-coffee','drinks/iced-coffee',1,'2020-02-09 19:11:42','2020-02-09 19:11:42','d5cb259c-b83b-40ba-95ba-cecd7aa27536'),
	(20,20,1,'iced-coffee','drinks/iced-coffee',1,'2020-02-09 19:11:43','2020-02-09 19:11:43','b097acaa-87db-48fb-8ee4-5ff94d0c91a5'),
	(22,22,1,'about','about',1,'2020-02-09 19:19:47','2020-02-09 19:30:06','a9a8752f-b4be-4cd3-a03b-99195d775d6e'),
	(23,23,1,'about','about/about',1,'2020-02-09 19:19:47','2020-02-09 19:19:47','14bc49bc-d9e1-40cf-a078-0edee9cb7a33'),
	(25,25,1,'locations','about/locations',1,'2020-02-09 19:20:02','2020-02-09 20:14:19','49c58c5f-e89e-44ce-8808-3452ee07a3bf'),
	(26,26,1,'locations','about/locations',1,'2020-02-09 19:20:02','2020-02-09 19:20:02','59271d81-bf7b-4636-8218-5a74d1496411'),
	(28,28,1,'austin-tx','about/locations/austin-tx',1,'2020-02-09 19:20:16','2020-02-15 20:21:36','7d01e2c4-a133-4cdd-80dd-a734c2694a00'),
	(29,29,1,'austin-tx','about/austin-tx',1,'2020-02-09 19:20:17','2020-02-09 19:20:17','b11022f8-8398-4425-b803-2af296a6a453'),
	(31,31,1,'mission-statement','about/mission-statement',1,'2020-02-09 19:20:37','2020-02-09 20:14:19','5ea8d500-1031-4faf-b862-608be1bbc88a'),
	(32,32,1,'mission-statement','about/mission-statement',1,'2020-02-09 19:20:37','2020-02-09 19:20:37','2d997f9f-3a46-459d-ba26-486770492c1e'),
	(33,33,1,'about','about',1,'2020-02-09 20:14:18','2020-02-09 20:14:18','b4818c7d-14a2-4487-9f70-53bad236c49c'),
	(34,34,1,'homepage','__home__',1,'2020-02-09 20:46:21','2020-02-09 20:46:21','26ce69f2-98b7-45cc-8362-c601c4eef3d6'),
	(35,35,1,'homepage','__home__',1,'2020-02-09 20:46:41','2020-02-09 20:46:41','09839a03-37f7-483c-9560-00ea6e822386'),
	(36,36,1,'homepage','__home__',1,'2020-02-09 20:47:42','2020-02-09 20:47:42','b427bcab-d93a-4909-a20c-c165ab5828bd'),
	(37,37,1,'espresso','drinks/espresso',1,'2020-02-09 21:26:21','2020-02-09 21:26:21','035976db-977e-431b-a54d-ba4b8dda2439'),
	(39,39,1,'acquired-by-starbucks','news/acquired-by-starbucks',1,'2020-02-09 21:54:28','2020-02-09 21:54:28','d0e4aa39-21c9-416f-9ff6-3a5615492045'),
	(40,40,1,'acquired-by-starbucks','news/acquired-by-starbucks',1,'2020-02-09 21:54:29','2020-02-09 21:54:29','a4935db0-e880-4e09-9ae5-bad508775521'),
	(41,41,1,'locations','about/locations',1,'2020-02-15 20:21:35','2020-02-15 20:21:35','b9ccf63b-873c-4dcf-9c31-a49afc67d94e'),
	(42,42,1,'austin-tx','about/locations/austin-tx',1,'2020-02-15 20:57:06','2020-02-15 20:57:06','36c323ad-bbfd-4fdc-b54c-d051aba6b057'),
	(44,44,1,NULL,NULL,1,'2020-02-15 21:11:45','2020-02-15 21:11:45','3c27993d-b654-46ee-ab15-5b7cad2f4ff4'),
	(45,45,1,NULL,NULL,1,'2020-02-15 21:11:52','2020-02-15 21:11:52','6c4f76e0-5e35-4d56-b6ec-46ca01defa21'),
	(46,46,1,NULL,NULL,1,'2020-02-15 21:11:54','2020-02-15 21:11:54','5540e7a5-8e0b-41ba-aed8-b31a55201e6d'),
	(47,47,1,NULL,NULL,1,'2020-02-15 21:11:54','2020-02-15 21:11:54','8a74c933-0bfb-48af-a2e8-72f550e08ee5'),
	(48,48,1,NULL,NULL,1,'2020-02-15 21:11:57','2020-02-15 21:11:57','d4606a7b-8742-4058-965e-d1861e7f582f'),
	(49,49,1,NULL,NULL,1,'2020-02-15 21:11:57','2020-02-15 21:11:57','b0100498-a25f-48ba-abd4-81546a7d22e1'),
	(50,50,1,NULL,NULL,1,'2020-02-15 21:12:05','2020-02-15 21:12:05','85cb0dde-a824-4663-b453-d423b9db2d2f'),
	(51,51,1,NULL,NULL,1,'2020-02-15 21:12:05','2020-02-15 21:12:05','f77baca6-8823-456b-8194-a58ef3af326b'),
	(52,52,1,NULL,NULL,1,'2020-02-15 21:12:07','2020-02-15 21:12:07','f745cc51-7ba8-4cf0-90dc-19e7dba5d5c5'),
	(53,53,1,NULL,NULL,1,'2020-02-15 21:12:07','2020-02-15 21:12:07','e0dacfc8-0993-4ca5-bb87-cb34f5dd218c'),
	(54,54,1,NULL,NULL,1,'2020-02-15 21:12:07','2020-02-15 21:12:07','eb086b89-9973-4872-b5dd-759bb4bd17ba'),
	(55,55,1,NULL,NULL,1,'2020-02-15 21:12:21','2020-02-15 21:12:21','4c2415d9-7658-4bf6-b05f-31d41bc3cfef'),
	(56,56,1,NULL,NULL,1,'2020-02-15 21:12:21','2020-02-15 21:12:21','deac5270-6d11-4a70-9534-cb3ac60253ee'),
	(57,57,1,NULL,NULL,1,'2020-02-15 21:12:21','2020-02-15 21:12:21','5402e161-9f8b-458c-bc07-8edfc6ae0483'),
	(58,58,1,NULL,NULL,1,'2020-02-15 21:12:27','2020-02-15 21:12:27','c1227b62-6496-401a-a8d5-8ab66a4ee12a'),
	(59,59,1,NULL,NULL,1,'2020-02-15 21:12:27','2020-02-15 21:12:27','22b18629-07a0-4f05-b481-2e39c962d672'),
	(60,60,1,NULL,NULL,1,'2020-02-15 21:12:27','2020-02-15 21:12:27','f4dc962b-cfd4-45c6-abba-b36bbe59508a'),
	(61,61,1,NULL,NULL,1,'2020-02-15 21:12:29','2020-02-15 21:12:29','c4d2c1f0-be26-46dd-9f39-cc67376c8728'),
	(62,62,1,NULL,NULL,1,'2020-02-15 21:12:29','2020-02-15 21:12:29','8d6d3b99-c003-4933-8ef5-8ed71cc2b909'),
	(63,63,1,NULL,NULL,1,'2020-02-15 21:12:29','2020-02-15 21:12:29','20bcc33c-a7c4-49b5-9ea7-dec679b89b52'),
	(64,64,1,NULL,NULL,1,'2020-02-15 21:12:29','2020-02-15 21:12:29','cc2fc2e8-17c0-4b63-b7dc-95f6c3c11848'),
	(65,65,1,NULL,NULL,1,'2020-02-15 21:12:46','2020-02-15 21:12:46','f30d7673-b219-4501-81a1-428db18a3dfc'),
	(66,66,1,NULL,NULL,1,'2020-02-15 21:12:46','2020-02-15 21:12:46','d391e991-a96c-41ce-bb2e-7b2b262b651f'),
	(67,67,1,NULL,NULL,1,'2020-02-15 21:12:46','2020-02-15 21:12:46','1dd01a8b-e4db-4d07-812c-3c73141a2c77'),
	(68,68,1,NULL,NULL,1,'2020-02-15 21:12:46','2020-02-15 21:12:46','6929f70c-d14f-4e54-9a42-299df8d08f63'),
	(69,69,1,NULL,NULL,1,'2020-02-15 21:12:48','2020-02-15 21:12:48','8e72ce20-d7ee-4c7b-942f-331789155bc5'),
	(70,70,1,NULL,NULL,1,'2020-02-15 21:12:48','2020-02-15 21:12:48','2dedb4ae-17f4-4020-b1fa-0814be1b1f7a'),
	(71,71,1,NULL,NULL,1,'2020-02-15 21:12:48','2020-02-15 21:12:48','91cd741e-e1f5-4132-9b36-ee0e1a01866d'),
	(72,72,1,NULL,NULL,1,'2020-02-15 21:12:48','2020-02-15 21:12:48','efd1906f-e4a2-4992-8d69-ae3886c21742'),
	(73,73,1,NULL,NULL,1,'2020-02-15 21:12:48','2020-02-15 21:12:48','5eae7d56-6663-4020-90eb-7474df2d9e21'),
	(74,74,1,NULL,NULL,1,'2020-02-15 21:12:50','2020-02-15 21:12:50','179a5780-d21e-4483-8b3a-cad8add26072'),
	(75,75,1,NULL,NULL,1,'2020-02-15 21:12:50','2020-02-15 21:12:50','09653ace-50ab-4808-9f66-0b966b661d88'),
	(76,76,1,NULL,NULL,1,'2020-02-15 21:12:50','2020-02-15 21:12:50','9be9ad01-a98f-4d09-8ada-c90020dbd15f'),
	(77,77,1,NULL,NULL,1,'2020-02-15 21:12:50','2020-02-15 21:12:50','ab84e919-12ae-4df6-a4fe-94ae50755019'),
	(78,78,1,NULL,NULL,1,'2020-02-15 21:12:50','2020-02-15 21:12:50','08b06bb6-eebd-44b7-8dad-3ef6b46518a4'),
	(79,79,1,NULL,NULL,1,'2020-02-15 21:12:54','2020-02-15 21:12:54','bbc713e3-e20c-4c41-ac7c-3dfff66556e4'),
	(80,80,1,NULL,NULL,1,'2020-02-15 21:12:54','2020-02-15 21:12:54','e8d17a00-878b-4223-aade-ff9a0af4701a'),
	(81,81,1,NULL,NULL,1,'2020-02-15 21:12:54','2020-02-15 21:12:54','a28ebe38-f815-46bb-846e-8453e2006ddf'),
	(82,82,1,NULL,NULL,1,'2020-02-15 21:12:54','2020-02-15 21:12:54','098323f0-5bea-442d-ab33-2626431bfa89'),
	(83,83,1,NULL,NULL,1,'2020-02-15 21:12:54','2020-02-15 21:12:54','09000cd8-368b-437f-8439-2dee81cf8802'),
	(84,84,1,NULL,NULL,1,'2020-02-15 21:12:56','2020-02-15 21:12:56','223d1208-7d77-40c1-9535-cf07e46eec47'),
	(85,85,1,NULL,NULL,1,'2020-02-15 21:12:56','2020-02-15 21:12:56','f5299fd2-2a7b-4a2e-9dca-f049848a9db9'),
	(86,86,1,NULL,NULL,1,'2020-02-15 21:12:56','2020-02-15 21:12:56','d8ddfb6a-b379-4aa4-b5dd-a50bdbce56a2'),
	(87,87,1,NULL,NULL,1,'2020-02-15 21:12:56','2020-02-15 21:12:56','0d4829c5-f2c2-4e08-b65c-98246324645f'),
	(88,88,1,NULL,NULL,1,'2020-02-15 21:12:56','2020-02-15 21:12:56','a2368c15-f4d2-49dc-9138-65e0d0407c8c'),
	(89,89,1,NULL,NULL,1,'2020-02-15 21:12:57','2020-02-15 21:12:57','6ca68492-9018-412a-975f-0be9ea276d72'),
	(90,90,1,NULL,NULL,1,'2020-02-15 21:12:57','2020-02-15 21:12:57','8a39c12f-a1ae-4930-8902-518f9a2cb11d'),
	(91,91,1,NULL,NULL,1,'2020-02-15 21:12:57','2020-02-15 21:12:57','019f92d1-4dee-4d10-aef2-3018e4c8b992'),
	(92,92,1,NULL,NULL,1,'2020-02-15 21:12:57','2020-02-15 21:12:57','2bd6c804-41b4-48b8-a71d-b6f184925c5c'),
	(93,93,1,NULL,NULL,1,'2020-02-15 21:12:57','2020-02-15 21:12:57','caa01773-6c68-4129-be1b-d8bdc91489f4'),
	(94,94,1,NULL,NULL,1,'2020-02-15 21:12:58','2020-02-15 21:12:58','2a28012d-c40b-4b3b-826a-253a21472b21'),
	(95,95,1,NULL,NULL,1,'2020-02-15 21:12:58','2020-02-15 21:12:58','a7a9ed87-2496-4e2c-9f2b-ae4de1843425'),
	(96,96,1,NULL,NULL,1,'2020-02-15 21:12:58','2020-02-15 21:12:58','ca662d18-b531-471f-8856-343813ce76ff'),
	(97,97,1,NULL,NULL,1,'2020-02-15 21:12:58','2020-02-15 21:12:58','efd84941-b42d-4360-8e75-447f07bb8856'),
	(98,98,1,NULL,NULL,1,'2020-02-15 21:12:58','2020-02-15 21:12:58','1cf42228-0ff9-4c07-a492-f7842f20c946'),
	(99,99,1,NULL,NULL,1,'2020-02-15 21:13:00','2020-02-15 21:13:00','5addcb6c-e1b9-49b6-b3e2-d7632b941470'),
	(100,100,1,NULL,NULL,1,'2020-02-15 21:13:00','2020-02-15 21:13:00','b2ca27c5-b94b-4e77-8880-fa8189912143'),
	(101,101,1,NULL,NULL,1,'2020-02-15 21:13:00','2020-02-15 21:13:00','c4b9979b-e753-4a8c-9024-97b6cfb222dc'),
	(102,102,1,NULL,NULL,1,'2020-02-15 21:13:00','2020-02-15 21:13:00','a4c76c6f-a052-47b4-aaaf-b195739cd49c'),
	(103,103,1,NULL,NULL,1,'2020-02-15 21:13:00','2020-02-15 21:13:00','1c51a37d-0dce-4c74-a417-b10af85ccdc4'),
	(104,104,1,NULL,NULL,1,'2020-02-15 21:13:02','2020-02-15 21:13:02','4ff477ca-850b-4cb1-aaf5-eb4779d2e590'),
	(105,105,1,NULL,NULL,1,'2020-02-15 21:13:02','2020-02-15 21:13:02','5db81450-f1b8-497b-8b76-c3ac0cc727dc'),
	(106,106,1,NULL,NULL,1,'2020-02-15 21:13:02','2020-02-15 21:13:02','2529ec21-4552-4434-b446-364120e5a636'),
	(107,107,1,NULL,NULL,1,'2020-02-15 21:13:02','2020-02-15 21:13:02','636f532e-00d5-474f-b980-aef318af86bf'),
	(108,108,1,NULL,NULL,1,'2020-02-15 21:13:02','2020-02-15 21:13:02','384133e5-b78a-4b16-8e7f-52a6b0e1f79b'),
	(109,109,1,NULL,NULL,1,'2020-02-15 21:13:06','2020-02-15 21:13:06','2144e56d-ff8f-4f1e-b08f-a439c8279f7b'),
	(110,110,1,NULL,NULL,1,'2020-02-15 21:13:06','2020-02-15 21:13:06','db52378a-c61a-42b4-89c2-7f14f64c647f'),
	(111,111,1,NULL,NULL,1,'2020-02-15 21:13:06','2020-02-15 21:13:06','d4aab3ed-71c9-456b-a937-c538038805db'),
	(112,112,1,NULL,NULL,1,'2020-02-15 21:13:06','2020-02-15 21:13:06','ff37d5cf-79ae-42e4-8b66-7739d26a3342'),
	(113,113,1,NULL,NULL,1,'2020-02-15 21:13:06','2020-02-15 21:13:06','efc03600-6839-4265-b128-232acae22528'),
	(114,114,1,NULL,NULL,1,'2020-02-15 21:13:07','2020-02-15 21:13:07','ec878f6b-1724-4d0f-b62a-0677d440b022'),
	(115,115,1,NULL,NULL,1,'2020-02-15 21:13:07','2020-02-15 21:13:07','50388e42-e5ed-4522-8b56-ed1790d43aae'),
	(116,116,1,NULL,NULL,1,'2020-02-15 21:13:07','2020-02-15 21:13:07','44176d26-6f1c-482d-9cae-7e00d4173030'),
	(117,117,1,NULL,NULL,1,'2020-02-15 21:13:07','2020-02-15 21:13:07','f128164e-92bc-4fe5-ad3d-6e00bb654eb4'),
	(118,118,1,NULL,NULL,1,'2020-02-15 21:13:07','2020-02-15 21:13:07','0471cbfd-7740-4529-8c4f-3fd3e393d474'),
	(119,119,1,NULL,NULL,1,'2020-02-15 21:13:12','2020-02-15 21:13:12','ecafb249-76e2-4c98-8ed0-5bcec77eac56'),
	(120,120,1,NULL,NULL,1,'2020-02-15 21:13:12','2020-02-15 21:13:12','4aa40482-a147-4927-be75-4a29189c7143'),
	(121,121,1,NULL,NULL,1,'2020-02-15 21:13:12','2020-02-15 21:13:12','c4ca880a-2605-4390-92d4-67f12fb2d292'),
	(122,122,1,NULL,NULL,1,'2020-02-15 21:13:12','2020-02-15 21:13:12','41dc38c1-28db-48d8-9204-dc3d13aa2ad3'),
	(123,123,1,NULL,NULL,1,'2020-02-15 21:13:12','2020-02-15 21:13:12','55f0d1ce-f08e-4270-a4c0-9a9bdf692ffd'),
	(124,124,1,NULL,NULL,1,'2020-02-15 21:13:14','2020-02-15 21:13:14','aee22f97-2067-4765-bab4-ec4dec4bd2a8'),
	(125,125,1,NULL,NULL,1,'2020-02-15 21:13:14','2020-02-15 21:13:14','30fed8df-3dad-4092-a9be-6cb3033b605f'),
	(126,126,1,NULL,NULL,1,'2020-02-15 21:13:14','2020-02-15 21:13:14','64529480-3682-4528-8d91-b09806ab5b53'),
	(127,127,1,NULL,NULL,1,'2020-02-15 21:13:14','2020-02-15 21:13:14','20e1999b-f2a2-4e69-a81c-9b2afc1b64b9'),
	(128,128,1,NULL,NULL,1,'2020-02-15 21:13:14','2020-02-15 21:13:14','de025be3-3945-43d6-a11f-95b23b535002'),
	(129,129,1,NULL,NULL,1,'2020-02-15 21:13:14','2020-02-15 21:13:14','48364a56-ed58-4925-ad2a-8c8aec831e55'),
	(130,130,1,NULL,NULL,1,'2020-02-15 21:13:14','2020-02-15 21:13:14','5e7cac93-db6b-4bc6-9cbd-8ca95c06d2d1'),
	(131,131,1,NULL,NULL,1,'2020-02-15 21:13:14','2020-02-15 21:13:14','a9c1bb82-ff4d-4fe0-bd3e-9d38fc5cdcc8'),
	(132,132,1,NULL,NULL,1,'2020-02-15 21:13:14','2020-02-15 21:13:14','d8736a53-4008-4f55-affc-676e40799fa5'),
	(133,133,1,NULL,NULL,1,'2020-02-15 21:13:14','2020-02-15 21:13:14','5b64aff7-2545-402f-820c-7b7391315b31'),
	(134,134,1,NULL,NULL,1,'2020-02-15 21:13:19','2020-02-15 21:13:19','646f6bbc-2158-44a5-8544-967bfca991f3'),
	(135,135,1,NULL,NULL,1,'2020-02-15 21:13:19','2020-02-15 21:13:19','8c1a20ad-c5bd-45e1-ba93-7c19ef8b385a'),
	(136,136,1,NULL,NULL,1,'2020-02-15 21:13:19','2020-02-15 21:13:19','55091d77-fced-4e1b-baa6-58f91b2d7f3d'),
	(137,137,1,NULL,NULL,1,'2020-02-15 21:13:19','2020-02-15 21:13:19','5d286193-49a5-4306-a6cd-d229b7a601d9'),
	(138,138,1,NULL,NULL,1,'2020-02-15 21:13:19','2020-02-15 21:13:19','770c9205-70bc-49ca-8218-d471bda41a14'),
	(139,139,1,NULL,NULL,1,'2020-02-15 21:13:22','2020-02-15 21:13:22','770c43e6-1bde-4606-aa53-7196234c9f5d'),
	(140,140,1,NULL,NULL,1,'2020-02-15 21:13:22','2020-02-15 21:13:22','6d902fd1-0438-4617-81d7-a8d1015baaf5'),
	(141,141,1,NULL,NULL,1,'2020-02-15 21:13:22','2020-02-15 21:13:22','9b02b572-81f1-4461-8fd8-e168c0513de9'),
	(142,142,1,NULL,NULL,1,'2020-02-15 21:13:22','2020-02-15 21:13:22','980a9a59-91c0-4a86-8067-fdf487e12ebb'),
	(143,143,1,NULL,NULL,1,'2020-02-15 21:13:22','2020-02-15 21:13:22','ce1ddc2e-58f3-47b5-9eb4-5911706d521f'),
	(144,144,1,NULL,NULL,1,'2020-02-15 21:13:22','2020-02-15 21:13:22','e983df3d-8cbf-4379-b7af-6867de57ac6a'),
	(145,145,1,NULL,NULL,1,'2020-02-15 21:13:25','2020-02-15 21:13:25','cbe291c1-245b-4d2f-ad04-2a323e3eb10f'),
	(146,146,1,NULL,NULL,1,'2020-02-15 21:13:25','2020-02-15 21:13:25','4196ff77-676d-4454-a3fd-023b2f0655cb'),
	(147,147,1,NULL,NULL,1,'2020-02-15 21:13:25','2020-02-15 21:13:25','8673392b-8df2-4b77-95a3-e7e8bbaffd93'),
	(148,148,1,NULL,NULL,1,'2020-02-15 21:13:25','2020-02-15 21:13:25','5a49ff5e-f89c-427c-9e4e-c4eb85b40b7c'),
	(149,149,1,NULL,NULL,1,'2020-02-15 21:13:25','2020-02-15 21:13:25','8a32121a-5233-49b1-a6d6-0a2b5c04c0f0'),
	(150,150,1,NULL,NULL,1,'2020-02-15 21:13:25','2020-02-15 21:13:25','0f56a5fb-94cc-44f1-9c1d-4e15f9d8fa28'),
	(151,151,1,NULL,NULL,1,'2020-02-15 21:13:29','2020-02-15 21:13:29','6d3394ad-1757-47cc-8a38-52f6ce69ff6f'),
	(152,152,1,NULL,NULL,1,'2020-02-15 21:13:29','2020-02-15 21:13:29','cdb124b6-1654-4892-b057-ff1bcf50ac16'),
	(153,153,1,NULL,NULL,1,'2020-02-15 21:13:29','2020-02-15 21:13:29','01a4bb5f-2ded-44b7-816b-30e5af5fd798'),
	(154,154,1,NULL,NULL,1,'2020-02-15 21:13:29','2020-02-15 21:13:29','9422c6a0-9a8f-49fb-9427-c5f8b03b2660'),
	(155,155,1,NULL,NULL,1,'2020-02-15 21:13:29','2020-02-15 21:13:29','e22b5a84-39f0-4044-8740-8d435d0446c6'),
	(156,156,1,NULL,NULL,1,'2020-02-15 21:13:29','2020-02-15 21:13:29','c58a0644-c975-4250-af2c-ce0acca48d4f'),
	(157,157,1,NULL,NULL,1,'2020-02-15 21:13:29','2020-02-15 21:13:29','203d25d7-9cc1-481b-a9d9-517755403c6c'),
	(158,158,1,NULL,NULL,1,'2020-02-15 21:13:35','2020-02-15 21:13:35','79e8c927-82a8-46d5-800d-3becb91519b3'),
	(159,159,1,NULL,NULL,1,'2020-02-15 21:13:35','2020-02-15 21:13:35','601c4ddf-2cf0-4503-aa1f-97530aa54dab'),
	(160,160,1,NULL,NULL,1,'2020-02-15 21:13:35','2020-02-15 21:13:35','ea037111-90d2-49a6-b5a0-24758f59e554'),
	(161,161,1,NULL,NULL,1,'2020-02-15 21:13:35','2020-02-15 21:13:35','fac97345-715b-4e33-8d53-1e423f85cd5e'),
	(162,162,1,NULL,NULL,1,'2020-02-15 21:13:35','2020-02-15 21:13:35','6cb6d0db-d41d-4d2a-8ee1-321533235d48'),
	(163,163,1,NULL,NULL,1,'2020-02-15 21:13:35','2020-02-15 21:13:35','9326b6e3-6417-48e8-994e-9a9261cdcf99'),
	(164,164,1,NULL,NULL,1,'2020-02-15 21:13:35','2020-02-15 21:13:35','6da4c605-ff23-4ed5-82bd-560c86e0cac3'),
	(165,165,1,NULL,NULL,1,'2020-02-15 21:13:37','2020-02-15 21:13:37','c76a54a1-7402-425f-80a2-ff36550f1afa'),
	(166,166,1,NULL,NULL,1,'2020-02-15 21:13:37','2020-02-15 21:13:37','d15fe25e-3e23-4c89-9ec4-297b3976aa75'),
	(167,167,1,NULL,NULL,1,'2020-02-15 21:13:37','2020-02-15 21:13:37','1c651ae8-cf70-499d-8cd2-8ed1e185317f'),
	(168,168,1,NULL,NULL,1,'2020-02-15 21:13:37','2020-02-15 21:13:37','7c042480-bc39-4af0-89cb-20fe8e2dde92'),
	(169,169,1,NULL,NULL,1,'2020-02-15 21:13:37','2020-02-15 21:13:37','092fbd66-1e34-4c9d-b897-965d5489b9d8'),
	(170,170,1,NULL,NULL,1,'2020-02-15 21:13:37','2020-02-15 21:13:37','d40e46dc-8c61-4c63-92fb-b79ceb8af88c'),
	(171,171,1,NULL,NULL,1,'2020-02-15 21:13:37','2020-02-15 21:13:37','7bca4b56-1ff2-4625-987a-52ff3fae113c'),
	(172,172,1,NULL,NULL,1,'2020-02-15 21:13:38','2020-02-15 21:13:38','cdde309f-9bc4-4aa2-b89e-7fc4518ca042'),
	(173,173,1,NULL,NULL,1,'2020-02-15 21:13:38','2020-02-15 21:13:38','dbe64fde-499b-4bc4-9dd6-7bb5af20b28f'),
	(174,174,1,NULL,NULL,1,'2020-02-15 21:13:38','2020-02-15 21:13:38','53d38330-9f5b-4387-ba50-1f6c397510e6'),
	(175,175,1,NULL,NULL,1,'2020-02-15 21:13:38','2020-02-15 21:13:38','61510b05-9b9b-4fb5-8fa4-8bbc274577ce'),
	(176,176,1,NULL,NULL,1,'2020-02-15 21:13:38','2020-02-15 21:13:38','f6c93c77-894f-4303-b395-9e3aafd7a05b'),
	(177,177,1,NULL,NULL,1,'2020-02-15 21:13:38','2020-02-15 21:13:38','8b068147-6862-4d1a-b735-2393fb7a3b9f'),
	(178,178,1,NULL,NULL,1,'2020-02-15 21:13:38','2020-02-15 21:13:38','578e007c-11b3-4a0a-9764-a5377effaf0b'),
	(179,179,1,NULL,NULL,1,'2020-02-15 21:13:41','2020-02-15 21:13:41','34a1badb-49bd-436c-b905-4cc25a5bdfb7'),
	(180,180,1,NULL,NULL,1,'2020-02-15 21:13:41','2020-02-15 21:13:41','82be864f-f22f-4996-adab-f50701a52c89'),
	(181,181,1,NULL,NULL,1,'2020-02-15 21:13:41','2020-02-15 21:13:41','d2d856a4-b4da-401e-ae38-a0dea03b0ef8'),
	(182,182,1,NULL,NULL,1,'2020-02-15 21:13:41','2020-02-15 21:13:41','93b3748b-25ca-4081-89ee-3255d9729207'),
	(183,183,1,NULL,NULL,1,'2020-02-15 21:13:41','2020-02-15 21:13:41','2d2e58c6-ee3e-48b7-b5ee-426bff2eebb2'),
	(184,184,1,NULL,NULL,1,'2020-02-15 21:13:41','2020-02-15 21:13:41','b357ba90-404a-4f73-90b0-d3690aed1149'),
	(185,185,1,NULL,NULL,1,'2020-02-15 21:13:41','2020-02-15 21:13:41','e7c78e54-2726-4160-93f6-8f187419a9c8'),
	(186,186,1,NULL,NULL,1,'2020-02-15 21:13:42','2020-02-15 21:13:42','9f46f613-cc8c-4ba1-917f-e6d7d4ca49fa'),
	(187,187,1,NULL,NULL,1,'2020-02-15 21:13:42','2020-02-15 21:13:42','05f7620b-d1df-49f0-884b-2db8925f5a41'),
	(188,188,1,NULL,NULL,1,'2020-02-15 21:13:42','2020-02-15 21:13:42','ad1d3601-5d1a-44af-94dd-a82dfd3a551f'),
	(189,189,1,NULL,NULL,1,'2020-02-15 21:13:42','2020-02-15 21:13:42','ae655489-4256-49d5-a7ff-f65eb9e98f4f'),
	(190,190,1,NULL,NULL,1,'2020-02-15 21:13:42','2020-02-15 21:13:42','e80d47e0-82b5-49f9-ac5a-3a972b177ea8'),
	(191,191,1,NULL,NULL,1,'2020-02-15 21:13:42','2020-02-15 21:13:42','0a9222bc-c085-43e9-82e9-d7fe1b1a733d'),
	(192,192,1,NULL,NULL,1,'2020-02-15 21:13:42','2020-02-15 21:13:42','86358409-429f-4337-9f5f-721f8c92daac'),
	(193,193,1,NULL,NULL,1,'2020-02-15 21:13:46','2020-02-15 21:13:46','938534c4-b767-4d1f-afe0-abe892dbd840'),
	(194,194,1,NULL,NULL,1,'2020-02-15 21:13:46','2020-02-15 21:13:46','aedfde14-4e32-4d96-b413-9026d8e1cc26'),
	(195,195,1,NULL,NULL,1,'2020-02-15 21:13:47','2020-02-15 21:13:47','d7fdd986-9c12-449a-aee8-0221b9578323'),
	(196,196,1,NULL,NULL,1,'2020-02-15 21:13:47','2020-02-15 21:13:47','97a46702-b8c1-43b4-905d-f0f3a27b51db'),
	(197,197,1,NULL,NULL,1,'2020-02-15 21:13:47','2020-02-15 21:13:47','2f83c574-2658-4964-a6ed-026847ca1c05'),
	(198,198,1,NULL,NULL,1,'2020-02-15 21:13:47','2020-02-15 21:13:47','067ad7db-47ae-45dc-88d6-2f1d8cfe51e4'),
	(199,199,1,NULL,NULL,1,'2020-02-15 21:13:47','2020-02-15 21:13:47','d6b32e88-6741-474e-bc5a-caaeecc211b4'),
	(200,200,1,NULL,NULL,1,'2020-02-15 21:13:49','2020-02-15 21:13:49','72cd390d-8885-4f0f-a264-250408e843e4'),
	(201,201,1,NULL,NULL,1,'2020-02-15 21:13:49','2020-02-15 21:13:49','1c0700ed-e117-495d-bdcc-ddf233047b46'),
	(202,202,1,NULL,NULL,1,'2020-02-15 21:13:49','2020-02-15 21:13:49','486a4375-7eac-4d54-b274-b60e962553f8'),
	(203,203,1,NULL,NULL,1,'2020-02-15 21:13:49','2020-02-15 21:13:49','e0871879-d4d5-43f5-b2e1-b729882e4cf6'),
	(204,204,1,NULL,NULL,1,'2020-02-15 21:13:49','2020-02-15 21:13:49','ed854788-c101-4a54-8523-a2b34fa819a3'),
	(205,205,1,NULL,NULL,1,'2020-02-15 21:13:49','2020-02-15 21:13:49','660f73b1-39bd-4cdb-9cde-36e687c3139f'),
	(206,206,1,NULL,NULL,1,'2020-02-15 21:13:49','2020-02-15 21:13:49','b6fc28c9-4f4f-47c0-bf2a-01c406012ae0'),
	(207,207,1,NULL,NULL,1,'2020-02-15 21:13:51','2020-02-15 21:13:51','c647a7ab-3d15-4666-a57b-4a8a5ce03e70'),
	(208,208,1,NULL,NULL,1,'2020-02-15 21:13:51','2020-02-15 21:13:51','1dd760e1-715b-43c8-9de3-89a5661ef2e1'),
	(209,209,1,NULL,NULL,1,'2020-02-15 21:13:52','2020-02-15 21:13:52','38980a73-3b3d-48a5-b1c8-65d4dd13d2aa'),
	(210,210,1,NULL,NULL,1,'2020-02-15 21:13:52','2020-02-15 21:13:52','78c9d484-c5da-4d9d-aa1a-a38b3b3c8713'),
	(211,211,1,NULL,NULL,1,'2020-02-15 21:13:52','2020-02-15 21:13:52','4ff63e67-6f75-4edf-95f1-787447b89e4a'),
	(212,212,1,NULL,NULL,1,'2020-02-15 21:13:52','2020-02-15 21:13:52','4fd1f3eb-6fd2-4904-8534-d869a26ea168'),
	(213,213,1,NULL,NULL,1,'2020-02-15 21:13:52','2020-02-15 21:13:52','c0b4fada-44c6-4715-80c5-ad4af293e862'),
	(214,214,1,NULL,NULL,1,'2020-02-15 21:13:52','2020-02-15 21:13:52','42ed0a60-6659-49e4-bd4c-eb6e5b7e1ab7'),
	(215,215,1,NULL,NULL,1,'2020-02-15 21:13:55','2020-02-15 21:13:55','104d507e-98bc-45ab-9816-6c5b4efbb49d'),
	(216,216,1,NULL,NULL,1,'2020-02-15 21:13:55','2020-02-15 21:13:55','b6180b94-b716-4130-a10a-29dddc2392a9'),
	(217,217,1,NULL,NULL,1,'2020-02-15 21:13:55','2020-02-15 21:13:55','22f861a9-57c1-47f7-b4b2-1f794fe4d312'),
	(218,218,1,NULL,NULL,1,'2020-02-15 21:13:55','2020-02-15 21:13:55','286b9053-2658-4b3b-b5fe-a343d270b51e'),
	(219,219,1,NULL,NULL,1,'2020-02-15 21:13:55','2020-02-15 21:13:55','a894d44c-7232-43e9-b5cf-ea45372e25cf'),
	(220,220,1,NULL,NULL,1,'2020-02-15 21:13:55','2020-02-15 21:13:55','49efca61-ff0c-49b8-9bde-969e70797279'),
	(221,221,1,NULL,NULL,1,'2020-02-15 21:13:55','2020-02-15 21:13:55','a4703014-3824-4085-a9bb-48f06c290033'),
	(222,222,1,NULL,NULL,1,'2020-02-15 21:13:55','2020-02-15 21:13:55','e0c0b1a6-b005-41b7-ab11-c398d252d254'),
	(223,223,1,NULL,NULL,1,'2020-02-15 21:13:59','2020-02-15 21:13:59','43926dcd-8556-4d5b-a18a-21c89c006531'),
	(224,224,1,NULL,NULL,1,'2020-02-15 21:13:59','2020-02-15 21:13:59','842d53e1-8423-4547-8985-67601a6aa1a1'),
	(225,225,1,NULL,NULL,1,'2020-02-15 21:13:59','2020-02-15 21:13:59','70307ee6-1d7f-449d-aa4c-8a21f578f5fe'),
	(226,226,1,NULL,NULL,1,'2020-02-15 21:13:59','2020-02-15 21:13:59','f57402cf-0695-45c7-82c3-5f22148045c7'),
	(227,227,1,NULL,NULL,1,'2020-02-15 21:13:59','2020-02-15 21:13:59','4a539b11-2cb9-49c4-887f-ea33357e023b'),
	(228,228,1,NULL,NULL,1,'2020-02-15 21:13:59','2020-02-15 21:13:59','6f95632b-4d8e-4d4b-a8f1-c854e816a919'),
	(229,229,1,NULL,NULL,1,'2020-02-15 21:13:59','2020-02-15 21:13:59','131a7c42-a934-4897-acc0-be4f81cd89ed'),
	(230,230,1,NULL,NULL,1,'2020-02-15 21:13:59','2020-02-15 21:13:59','5970d29d-e510-4f82-b05e-b820f9f63b14'),
	(231,231,1,NULL,NULL,1,'2020-02-15 21:14:00','2020-02-15 21:14:00','aabeee12-db5c-454c-bc91-70e009f51fef'),
	(232,232,1,NULL,NULL,1,'2020-02-15 21:14:00','2020-02-15 21:14:00','14dd5e74-8096-4b14-b19e-80dfe44d0d1b'),
	(233,233,1,NULL,NULL,1,'2020-02-15 21:14:00','2020-02-15 21:14:00','32165582-749a-457a-8c9a-9b5eeb98cf6d'),
	(234,234,1,NULL,NULL,1,'2020-02-15 21:14:00','2020-02-15 21:14:00','74860710-6bfd-416c-9178-d16b74ae8ef5'),
	(235,235,1,NULL,NULL,1,'2020-02-15 21:14:00','2020-02-15 21:14:00','30a0f7c5-24ee-4042-b663-eef54fa6485e'),
	(236,236,1,NULL,NULL,1,'2020-02-15 21:14:00','2020-02-15 21:14:00','5402b68c-44f2-43af-bfda-b726a177d6d3'),
	(237,237,1,NULL,NULL,1,'2020-02-15 21:14:00','2020-02-15 21:14:00','850f16f7-5a09-4f17-a50d-7bb14850745a'),
	(238,238,1,NULL,NULL,1,'2020-02-15 21:14:00','2020-02-15 21:14:00','c22331db-02ca-4b42-a265-b3a3abad6f45'),
	(239,239,1,NULL,NULL,1,'2020-02-15 21:14:02','2020-02-15 21:14:02','d2c21b44-1598-4a4c-88a8-49c259f2a04a'),
	(240,240,1,NULL,NULL,1,'2020-02-15 21:14:02','2020-02-15 21:14:02','4274df4f-eabc-4ad8-89ed-6d1e8fb676e3'),
	(241,241,1,NULL,NULL,1,'2020-02-15 21:14:02','2020-02-15 21:14:02','8a29b6de-d92e-4586-abf7-e6e95cf98e7f'),
	(242,242,1,NULL,NULL,1,'2020-02-15 21:14:02','2020-02-15 21:14:02','d0899e3a-0a00-41d6-b861-0b46b910d810'),
	(243,243,1,NULL,NULL,1,'2020-02-15 21:14:02','2020-02-15 21:14:02','8e47a6de-7a4b-4011-9f58-546fa4c87053'),
	(244,244,1,NULL,NULL,1,'2020-02-15 21:14:02','2020-02-15 21:14:02','d61943c9-4bc5-44ae-bc68-c097cdb45e91'),
	(245,245,1,NULL,NULL,1,'2020-02-15 21:14:02','2020-02-15 21:14:02','78b545d2-a5eb-4afc-b710-ceb3b920df5e'),
	(246,246,1,NULL,NULL,1,'2020-02-15 21:14:02','2020-02-15 21:14:02','9c1964f0-e84a-4f82-9e20-a8a10f5f1a04'),
	(247,247,1,NULL,NULL,1,'2020-02-15 21:14:02','2020-02-15 21:14:02','cbada872-a948-49c2-9055-50aa6e95da57'),
	(248,248,1,NULL,NULL,1,'2020-02-15 21:14:10','2020-02-15 21:14:10','eb5b80ae-3c72-4072-aae1-5c84e5f3a388'),
	(249,249,1,NULL,NULL,1,'2020-02-15 21:14:11','2020-02-15 21:14:11','371a7193-9b03-4db8-a0e0-e3baf7e2a5a8'),
	(250,250,1,NULL,NULL,1,'2020-02-15 21:14:11','2020-02-15 21:14:11','15c243f4-1d72-4c87-8f10-9691a2c57f8c'),
	(251,251,1,NULL,NULL,1,'2020-02-15 21:14:11','2020-02-15 21:14:11','1b61597d-7b48-412c-8e47-28a45f2e0924'),
	(252,252,1,NULL,NULL,1,'2020-02-15 21:14:11','2020-02-15 21:14:11','a1085762-97c0-407c-b126-aac19804b11c'),
	(253,253,1,NULL,NULL,1,'2020-02-15 21:14:11','2020-02-15 21:14:11','f6020dff-70a5-4761-a962-e10448cb02b8'),
	(254,254,1,NULL,NULL,1,'2020-02-15 21:14:11','2020-02-15 21:14:11','e71f7c00-9eb3-4d45-9857-c4e312eca5db'),
	(255,255,1,NULL,NULL,1,'2020-02-15 21:14:11','2020-02-15 21:14:11','21e93d4a-3341-46f0-b82f-396dc3017bc8'),
	(256,256,1,NULL,NULL,1,'2020-02-15 21:14:11','2020-02-15 21:14:11','06895f95-3bd8-4356-af62-f3cf32df6dda'),
	(257,257,1,NULL,NULL,1,'2020-02-15 21:14:12','2020-02-15 21:14:12','67dbf8e4-2ce0-4d05-8f0d-179733704510'),
	(258,258,1,NULL,NULL,1,'2020-02-15 21:14:12','2020-02-15 21:14:12','426f86a8-8b5c-4066-94c9-d9e65f10c364'),
	(259,259,1,NULL,NULL,1,'2020-02-15 21:14:12','2020-02-15 21:14:12','28f121c2-5c7b-4090-8b26-c6f8a0c84a05'),
	(260,260,1,NULL,NULL,1,'2020-02-15 21:14:12','2020-02-15 21:14:12','4dc11baa-e61b-4a53-8e43-ed91f74e17d8'),
	(261,261,1,NULL,NULL,1,'2020-02-15 21:14:12','2020-02-15 21:14:12','0fd2437e-fe5a-4a56-bb43-aac8cc6e3fde'),
	(262,262,1,NULL,NULL,1,'2020-02-15 21:14:12','2020-02-15 21:14:12','6c56a4e2-14e4-4514-b2d9-b6a291890819'),
	(263,263,1,NULL,NULL,1,'2020-02-15 21:14:12','2020-02-15 21:14:12','37054e2b-d889-4b59-8ade-23a3879a5545'),
	(264,264,1,NULL,NULL,1,'2020-02-15 21:14:12','2020-02-15 21:14:12','46c7df23-1269-4210-8156-5ba67e6d3f62'),
	(265,265,1,NULL,NULL,1,'2020-02-15 21:14:12','2020-02-15 21:14:12','81d792b4-0f5d-48db-b351-d79a7cdad7ff'),
	(266,266,1,NULL,NULL,1,'2020-02-15 21:14:12','2020-02-15 21:14:12','07cc503e-56a6-413e-94e2-3de5ab8674ec'),
	(267,267,1,NULL,NULL,1,'2020-02-15 21:14:12','2020-02-15 21:14:12','5f8c332b-0bfe-48fe-b14e-03423be8f9f4'),
	(268,268,1,NULL,NULL,1,'2020-02-15 21:14:12','2020-02-15 21:14:12','794936e2-3b7d-4eba-a446-1d5be305739e'),
	(269,269,1,NULL,NULL,1,'2020-02-15 21:14:12','2020-02-15 21:14:12','2f965b83-9820-4b93-aa35-69253973b912'),
	(270,270,1,NULL,NULL,1,'2020-02-15 21:14:13','2020-02-15 21:14:13','738eff19-4f97-465e-b172-e8d569c35bc7'),
	(271,271,1,NULL,NULL,1,'2020-02-15 21:14:13','2020-02-15 21:14:13','7f492a16-157b-4cac-a66d-fcc25ea31571'),
	(272,272,1,NULL,NULL,1,'2020-02-15 21:14:13','2020-02-15 21:14:13','693c93c3-809c-4eae-8927-df3ee778f601'),
	(273,273,1,NULL,NULL,1,'2020-02-15 21:14:13','2020-02-15 21:14:13','9fba9644-1f79-41af-88d6-281e3b27812e'),
	(274,274,1,NULL,NULL,1,'2020-02-15 21:14:13','2020-02-15 21:14:13','64e613c0-6b66-4ef9-902b-473ec33d179c'),
	(275,275,1,NULL,NULL,1,'2020-02-15 21:14:18','2020-02-15 21:14:18','cce1865f-531a-4a7c-8116-2a90c3faf06a'),
	(276,276,1,NULL,NULL,1,'2020-02-15 21:14:18','2020-02-15 21:14:18','0f67a0db-ba8d-4baf-a5fa-da8eaefcd62c'),
	(277,277,1,NULL,NULL,1,'2020-02-15 21:14:18','2020-02-15 21:14:18','e110e597-317d-4fdf-8e7d-a806c0cc8d7a'),
	(278,278,1,NULL,NULL,1,'2020-02-15 21:14:18','2020-02-15 21:14:18','dfe6ee49-8b38-44b6-944c-379ff6ce2876'),
	(279,279,1,NULL,NULL,1,'2020-02-15 21:14:18','2020-02-15 21:14:18','e675d501-565e-46bc-b110-cd43c0abacc2'),
	(280,280,1,NULL,NULL,1,'2020-02-15 21:14:18','2020-02-15 21:14:18','10edbe5b-d4ce-472f-9d05-7778a40760f1'),
	(281,281,1,NULL,NULL,1,'2020-02-15 21:14:18','2020-02-15 21:14:18','9c69d4dc-a225-4d85-8111-5ba5fadfaff7'),
	(282,282,1,NULL,NULL,1,'2020-02-15 21:14:18','2020-02-15 21:14:18','b2df8233-fabd-46af-b3ae-4d2382900721'),
	(283,283,1,NULL,NULL,1,'2020-02-15 21:14:18','2020-02-15 21:14:18','ffff4e3f-c953-4d45-9c32-bd81fd1fb834'),
	(284,284,1,NULL,NULL,1,'2020-02-15 21:14:19','2020-02-15 21:14:19','93fdde25-029d-4c6a-ab1a-7a5f57f1ec82'),
	(285,285,1,NULL,NULL,1,'2020-02-15 21:14:19','2020-02-15 21:14:19','8bb7e536-a595-4161-a9a3-aab6c4ccc101'),
	(286,286,1,NULL,NULL,1,'2020-02-15 21:14:19','2020-02-15 21:14:19','d47166e2-56d3-4176-a58a-cd6e6518f4a9'),
	(287,287,1,NULL,NULL,1,'2020-02-15 21:14:19','2020-02-15 21:14:19','a47c6e80-decf-4853-b5bb-c3f57adf45a0'),
	(288,288,1,NULL,NULL,1,'2020-02-15 21:14:19','2020-02-15 21:14:19','88f6e8bb-7bb8-4e79-b70a-a7849517e4f3'),
	(289,289,1,NULL,NULL,1,'2020-02-15 21:14:19','2020-02-15 21:14:19','8ceee9e5-01e4-4e70-ade8-8747cce08db9'),
	(290,290,1,NULL,NULL,1,'2020-02-15 21:14:19','2020-02-15 21:14:19','694972cf-2f92-4756-9bfc-e282513d4ded'),
	(291,291,1,NULL,NULL,1,'2020-02-15 21:14:19','2020-02-15 21:14:19','aedc2baa-ece3-4a9a-918d-1c43a42df79d'),
	(292,292,1,NULL,NULL,1,'2020-02-15 21:14:19','2020-02-15 21:14:19','ab6897dc-ea32-4df2-93b6-5ef00ba3680d'),
	(293,293,1,NULL,NULL,1,'2020-02-15 21:14:22','2020-02-15 21:14:22','247f9bf5-c1e8-4eee-85a3-ee37a7bb60e1'),
	(294,294,1,NULL,NULL,1,'2020-02-15 21:14:22','2020-02-15 21:14:22','3ecefed0-ada4-4cf3-95ec-39bc2031c5ec'),
	(295,295,1,NULL,NULL,1,'2020-02-15 21:14:22','2020-02-15 21:14:22','6df254a1-4ceb-4f01-84f7-6cb996a79c06'),
	(296,296,1,NULL,NULL,1,'2020-02-15 21:14:22','2020-02-15 21:14:22','ecaf9316-941f-4282-a0f1-38bae6cd1f7a'),
	(297,297,1,NULL,NULL,1,'2020-02-15 21:14:22','2020-02-15 21:14:22','2765c234-e2c2-4ac5-b7b1-0281002bde02'),
	(298,298,1,NULL,NULL,1,'2020-02-15 21:14:22','2020-02-15 21:14:22','0267bba2-7dd8-42d7-a735-6dd22baeb660'),
	(299,299,1,NULL,NULL,1,'2020-02-15 21:14:22','2020-02-15 21:14:22','b253d407-c55a-4e1c-ba35-891d04982710'),
	(300,300,1,NULL,NULL,1,'2020-02-15 21:14:22','2020-02-15 21:14:22','e9a27159-fcce-483d-bef5-8ca372a3eb2b'),
	(301,301,1,NULL,NULL,1,'2020-02-15 21:14:23','2020-02-15 21:14:23','4b0d7e05-d2f1-41f5-8e81-4b127bff8dcc'),
	(302,302,1,NULL,NULL,1,'2020-02-15 21:14:28','2020-02-15 21:14:28','e2815c12-0c6a-406e-a13a-76c23c73be39'),
	(303,303,1,NULL,NULL,1,'2020-02-15 21:14:28','2020-02-15 21:14:28','ee8f03ba-523b-4524-83b6-47d3579bf395'),
	(304,304,1,NULL,NULL,1,'2020-02-15 21:14:28','2020-02-15 21:14:28','8a6a3858-631e-4f32-b617-70c02eecc0f9'),
	(305,305,1,NULL,NULL,1,'2020-02-15 21:14:28','2020-02-15 21:14:28','7ff70114-6aa0-4533-beb9-caed60cb4508'),
	(306,306,1,NULL,NULL,1,'2020-02-15 21:14:28','2020-02-15 21:14:28','2b0074d8-373f-48ed-af16-6446d16a3157'),
	(307,307,1,NULL,NULL,1,'2020-02-15 21:14:28','2020-02-15 21:14:28','35c38fc8-c835-47f0-9c73-7dc362fc3b32'),
	(308,308,1,NULL,NULL,1,'2020-02-15 21:14:28','2020-02-15 21:14:28','2a8f4725-6b7c-4dc3-8bac-5be4b669b61b'),
	(309,309,1,NULL,NULL,1,'2020-02-15 21:14:28','2020-02-15 21:14:28','4049da09-862f-45c1-8c9b-8e0ab10bf045'),
	(310,310,1,NULL,NULL,1,'2020-02-15 21:14:28','2020-02-15 21:14:28','cbe7dc00-b0e1-4091-ba28-6203ec58b113'),
	(311,311,1,NULL,NULL,1,'2020-02-15 21:14:35','2020-02-15 21:14:35','1515c725-a278-4d85-a6ab-20dbb42758cf'),
	(312,312,1,NULL,NULL,1,'2020-02-15 21:14:35','2020-02-15 21:14:35','6b724275-606d-4ba5-aedf-396c5b0ecd02'),
	(313,313,1,NULL,NULL,1,'2020-02-15 21:14:35','2020-02-15 21:14:35','119f5a5a-4f42-40b0-a2ab-c696c7e8df24'),
	(314,314,1,NULL,NULL,1,'2020-02-15 21:14:35','2020-02-15 21:14:35','a0e25df0-96cf-4953-ac03-aa2ab97556b4'),
	(315,315,1,NULL,NULL,1,'2020-02-15 21:14:35','2020-02-15 21:14:35','49aed590-9e82-4006-9a2e-ba81120622e6'),
	(316,316,1,NULL,NULL,1,'2020-02-15 21:14:35','2020-02-15 21:14:35','8bfa0fcd-6bb3-4004-a81e-72b83213aff2'),
	(317,317,1,NULL,NULL,1,'2020-02-15 21:14:35','2020-02-15 21:14:35','7f816eae-e9c9-450f-9feb-b64893b64769'),
	(318,318,1,NULL,NULL,1,'2020-02-15 21:14:35','2020-02-15 21:14:35','1cc85082-44a1-4ae5-8b89-9ccf84dbbd81'),
	(319,319,1,NULL,NULL,1,'2020-02-15 21:14:35','2020-02-15 21:14:35','39492108-193e-439c-82f1-99bb3bbcf3b3'),
	(320,320,1,NULL,NULL,1,'2020-02-15 21:14:35','2020-02-15 21:14:35','770dc8e0-cfb1-4827-b52e-4d1d30cc8f50'),
	(321,321,1,NULL,NULL,1,'2020-02-15 21:14:42','2020-02-15 21:14:42','05403f03-583b-4a3c-8e66-0d8f8f3b6360'),
	(322,322,1,NULL,NULL,1,'2020-02-15 21:14:42','2020-02-15 21:14:42','cb055520-1497-4c61-892b-cd5ce687078a'),
	(323,323,1,NULL,NULL,1,'2020-02-15 21:14:42','2020-02-15 21:14:42','4f0d62d6-a1d3-41fc-9ff1-a8e8b56c9d64'),
	(324,324,1,NULL,NULL,1,'2020-02-15 21:14:42','2020-02-15 21:14:42','64748ffb-ffa8-4e28-8f4f-501b964b109f'),
	(325,325,1,NULL,NULL,1,'2020-02-15 21:14:42','2020-02-15 21:14:42','6818cb1e-f688-450d-8dc5-7be3e902594c'),
	(326,326,1,NULL,NULL,1,'2020-02-15 21:14:42','2020-02-15 21:14:42','e0ffa9b5-e601-4562-9e63-9286a32c9c19'),
	(327,327,1,NULL,NULL,1,'2020-02-15 21:14:42','2020-02-15 21:14:42','64427de0-13fd-4326-b3d3-445f18ef5926'),
	(328,328,1,NULL,NULL,1,'2020-02-15 21:14:42','2020-02-15 21:14:42','4fd5f090-d613-42f7-be30-231fa83da494'),
	(329,329,1,NULL,NULL,1,'2020-02-15 21:14:42','2020-02-15 21:14:42','0cbfe235-6879-40c0-a7b0-d93c0cb18b7c'),
	(330,330,1,NULL,NULL,1,'2020-02-15 21:14:42','2020-02-15 21:14:42','db8ddee5-0d7c-44d3-8045-9e116c00113a'),
	(331,331,1,NULL,NULL,1,'2020-02-15 21:14:46','2020-02-15 21:14:46','9577fdf5-a1f5-473f-97ee-6df666115ca1'),
	(332,332,1,NULL,NULL,1,'2020-02-15 21:14:46','2020-02-15 21:14:46','3150e9da-995e-41bd-8a2f-5c504315ba12'),
	(333,333,1,NULL,NULL,1,'2020-02-15 21:14:46','2020-02-15 21:14:46','c6b354f4-88dc-4e84-88f4-87118925dc3d'),
	(334,334,1,NULL,NULL,1,'2020-02-15 21:14:46','2020-02-15 21:14:46','b73fc809-e9aa-4553-9868-5e81652b8d69'),
	(335,335,1,NULL,NULL,1,'2020-02-15 21:14:46','2020-02-15 21:14:46','a972069b-deea-4980-a649-4d2fe37655f9'),
	(336,336,1,NULL,NULL,1,'2020-02-15 21:14:46','2020-02-15 21:14:46','4a84c7a9-36a9-46f3-a7cb-ccc415669f39'),
	(337,337,1,NULL,NULL,1,'2020-02-15 21:14:46','2020-02-15 21:14:46','108b31e1-166b-4968-99d1-c4f7368bdd10'),
	(338,338,1,NULL,NULL,1,'2020-02-15 21:14:46','2020-02-15 21:14:46','b396417e-5f4e-48f9-bdcc-37868cb6def3'),
	(339,339,1,NULL,NULL,1,'2020-02-15 21:14:46','2020-02-15 21:14:46','54a6cec3-9b09-4208-86c2-383147ef54ea'),
	(340,340,1,NULL,NULL,1,'2020-02-15 21:14:46','2020-02-15 21:14:46','15d5c5f7-d8c4-4194-aea8-e5316e71004f'),
	(341,341,1,NULL,NULL,1,'2020-02-15 21:14:49','2020-02-15 21:14:49','7de8bee8-30e8-4452-be10-1f37887f1ef2'),
	(342,342,1,NULL,NULL,1,'2020-02-15 21:14:49','2020-02-15 21:14:49','712159d6-532e-4b56-916a-ee63a40043ae'),
	(343,343,1,NULL,NULL,1,'2020-02-15 21:14:49','2020-02-15 21:14:49','e3f1b2bd-f6b9-406f-805e-fd2d3e534ae8'),
	(344,344,1,NULL,NULL,1,'2020-02-15 21:14:49','2020-02-15 21:14:49','41db7871-d0ab-4c18-8f1d-d535d73f661b'),
	(345,345,1,NULL,NULL,1,'2020-02-15 21:14:49','2020-02-15 21:14:49','7435b0bd-d732-499f-98f1-7886d382963e'),
	(346,346,1,NULL,NULL,1,'2020-02-15 21:14:49','2020-02-15 21:14:49','5ee713b0-697e-4a4e-b302-21fdd2012d5a'),
	(347,347,1,NULL,NULL,1,'2020-02-15 21:14:49','2020-02-15 21:14:49','8d0c7ec6-1ba8-4c0e-b379-9b1ff4a42e3f'),
	(348,348,1,NULL,NULL,1,'2020-02-15 21:14:49','2020-02-15 21:14:49','94539270-7046-4ad0-aa05-e980afe4388d'),
	(349,349,1,NULL,NULL,1,'2020-02-15 21:14:49','2020-02-15 21:14:49','ce23985c-a3c0-4051-b261-24e8cf13861c'),
	(350,350,1,NULL,NULL,1,'2020-02-15 21:14:49','2020-02-15 21:14:49','01cc75ef-2671-4f92-89e3-5b367539c30e'),
	(351,351,1,NULL,NULL,1,'2020-02-15 21:14:51','2020-02-15 21:14:51','c57222c8-b253-46bf-ac05-ce4be3c5d804'),
	(352,352,1,NULL,NULL,1,'2020-02-15 21:14:51','2020-02-15 21:14:51','3d6d2f2f-1fc8-4be8-b636-23d967a2d31e'),
	(353,353,1,NULL,NULL,1,'2020-02-15 21:14:51','2020-02-15 21:14:51','98d6686e-7f26-4f21-b16e-45d3e844c8cc'),
	(354,354,1,NULL,NULL,1,'2020-02-15 21:14:51','2020-02-15 21:14:51','9716f38d-2f4b-44ba-b867-335a585c2d2c'),
	(355,355,1,NULL,NULL,1,'2020-02-15 21:14:51','2020-02-15 21:14:51','45d76961-86ae-4925-a2fb-27ca8f2bcb8d'),
	(356,356,1,NULL,NULL,1,'2020-02-15 21:14:51','2020-02-15 21:14:51','a8e53f01-2830-4c67-a80a-8991babcb971'),
	(357,357,1,NULL,NULL,1,'2020-02-15 21:14:51','2020-02-15 21:14:51','d809d0a2-c635-400f-90e8-72d84885ea47'),
	(358,358,1,NULL,NULL,1,'2020-02-15 21:14:51','2020-02-15 21:14:51','c1a20c2f-d9a4-4848-85d4-df4f88901f5b'),
	(359,359,1,NULL,NULL,1,'2020-02-15 21:14:51','2020-02-15 21:14:51','5abb7505-a71b-44aa-a7e9-c7b781ae2a5a'),
	(360,360,1,NULL,NULL,1,'2020-02-15 21:14:51','2020-02-15 21:14:51','8c28a107-e680-4d72-9ef2-47caea03d435'),
	(361,361,1,NULL,NULL,1,'2020-02-15 21:14:51','2020-02-15 21:14:51','78200e24-c803-4c7e-8199-df34da890f29'),
	(362,362,1,NULL,NULL,1,'2020-02-15 21:14:51','2020-02-15 21:14:51','a4fc52e9-80c4-4899-a243-9b468274370e'),
	(363,363,1,NULL,NULL,1,'2020-02-15 21:14:51','2020-02-15 21:14:51','fb70b13e-4fbc-48c1-af30-4cd8c8c00b65'),
	(364,364,1,NULL,NULL,1,'2020-02-15 21:14:51','2020-02-15 21:14:51','1c8847a6-5746-46e1-afc5-5dc08768c15c'),
	(365,365,1,NULL,NULL,1,'2020-02-15 21:14:51','2020-02-15 21:14:51','31a59aa0-0dd5-406d-a0d4-b57697f27eb2'),
	(366,366,1,NULL,NULL,1,'2020-02-15 21:14:51','2020-02-15 21:14:51','e36dceb7-72b2-4dff-8611-2d4d5076f0cd'),
	(367,367,1,NULL,NULL,1,'2020-02-15 21:14:51','2020-02-15 21:14:51','39993397-f4a6-499d-bc20-269af8aa8e88'),
	(368,368,1,NULL,NULL,1,'2020-02-15 21:14:51','2020-02-15 21:14:51','4299cd5f-46db-472c-b3f4-a83b322c291f'),
	(369,369,1,NULL,NULL,1,'2020-02-15 21:14:51','2020-02-15 21:14:51','dbedba1b-a7b2-4db9-b118-4a3e73affd24'),
	(370,370,1,NULL,NULL,1,'2020-02-15 21:14:51','2020-02-15 21:14:51','2a95e157-ad56-4533-bbfe-b96fb21fb293'),
	(381,381,1,'perfect-espresso','recipes/perfect-espresso',1,'2020-02-15 21:15:15','2020-02-15 21:15:15','e3e7fff1-92b4-42df-b459-3ff39814473a'),
	(382,382,1,NULL,NULL,1,'2020-02-15 21:15:15','2020-02-15 21:15:15','fcff1fa3-ec00-41b8-85d4-633180f5517f'),
	(383,383,1,NULL,NULL,1,'2020-02-15 21:15:15','2020-02-15 21:15:15','6af4f4f8-9fae-4600-9f36-679e6af767bb'),
	(384,384,1,NULL,NULL,1,'2020-02-15 21:15:15','2020-02-15 21:15:15','f540c577-b2f8-4621-bf13-85124cd2287a'),
	(385,385,1,NULL,NULL,1,'2020-02-15 21:15:15','2020-02-15 21:15:15','dce669dc-0102-4b01-8e6b-7577114928dc'),
	(386,386,1,NULL,NULL,1,'2020-02-15 21:15:15','2020-02-15 21:15:15','f4101cf9-6f13-468b-94f4-4293f0b862f3'),
	(387,387,1,NULL,NULL,1,'2020-02-15 21:15:15','2020-02-15 21:15:15','450aa9e7-4b51-4a09-9f92-53db27595fe1'),
	(388,388,1,NULL,NULL,1,'2020-02-15 21:15:15','2020-02-15 21:15:15','a8c611bf-3bb4-4abf-8f2f-d2c87fc4d57d'),
	(389,389,1,NULL,NULL,1,'2020-02-15 21:15:15','2020-02-15 21:15:15','e525d5e9-e424-4a32-b0e1-d4972c3465f9'),
	(390,390,1,NULL,NULL,1,'2020-02-15 21:15:15','2020-02-15 21:15:15','a6ec9145-fbae-4f5a-a703-95006d26dad9'),
	(391,391,1,NULL,NULL,1,'2020-02-15 21:15:15','2020-02-15 21:15:15','ab935fa9-0cb1-4334-90b9-affce6ad4a82'),
	(392,392,1,'perfect-espresso','recipes/perfect-espresso',1,'2020-02-15 21:15:15','2020-02-15 21:15:15','6bfaa996-06c6-427c-998b-1648a15ce6b0'),
	(393,393,1,NULL,NULL,1,'2020-02-15 21:15:16','2020-02-15 21:15:16','c30b642c-3a03-4e28-ac6f-5435d58a152c'),
	(394,394,1,NULL,NULL,1,'2020-02-15 21:15:16','2020-02-15 21:15:16','8982e17c-9dab-4860-8691-3c0ea0ac34ba'),
	(395,395,1,NULL,NULL,1,'2020-02-15 21:15:16','2020-02-15 21:15:16','c8063844-1db8-4ab2-99d9-bbbfad0a2612'),
	(396,396,1,NULL,NULL,1,'2020-02-15 21:15:16','2020-02-15 21:15:16','775d2465-dc71-403b-b872-6f7402aabd8b'),
	(397,397,1,NULL,NULL,1,'2020-02-15 21:15:16','2020-02-15 21:15:16','b6e02712-64c4-4b62-96d3-54a7d5be984c'),
	(398,398,1,NULL,NULL,1,'2020-02-15 21:15:16','2020-02-15 21:15:16','1db639e8-a345-4990-8e68-08946f76ea00'),
	(399,399,1,NULL,NULL,1,'2020-02-15 21:15:16','2020-02-15 21:15:16','c6a6fd60-3b61-42ce-af67-972662867fe0'),
	(400,400,1,NULL,NULL,1,'2020-02-15 21:15:16','2020-02-15 21:15:16','dac4a89b-88d6-431e-9ef5-d3a05b53d0f2'),
	(401,401,1,NULL,NULL,1,'2020-02-15 21:15:16','2020-02-15 21:15:16','68ff7ea1-d583-4915-a991-c1d853bb2545'),
	(402,402,1,NULL,NULL,1,'2020-02-15 21:15:16','2020-02-15 21:15:16','8975ba14-217e-4a66-b149-116366b97a00'),
	(414,414,1,NULL,NULL,1,'2020-02-15 22:13:52','2020-02-15 22:13:52','c1bab5aa-99dc-4116-b657-201e13e55f0d'),
	(415,415,1,NULL,NULL,1,'2020-02-15 22:14:00','2020-02-15 22:14:00','e4249407-691a-462d-ae92-ad419965d0ee'),
	(416,416,1,NULL,NULL,1,'2020-02-15 22:14:00','2020-02-15 22:14:00','77328536-4db8-412d-bcd9-fbc29a6618cc'),
	(417,417,1,NULL,NULL,1,'2020-02-15 22:14:10','2020-02-15 22:14:10','f38371eb-f2ad-4ec9-9ba3-f91128cf4346'),
	(418,418,1,NULL,NULL,1,'2020-02-15 22:14:14','2020-02-15 22:14:14','4e923d94-e1d5-4f35-906b-c7dc3ade46aa'),
	(419,419,1,NULL,NULL,1,'2020-02-15 22:14:21','2020-02-15 22:14:21','1254516d-6727-44d6-aa1e-a48be0fb3f05'),
	(420,420,1,NULL,NULL,1,'2020-02-15 22:14:29','2020-02-15 22:14:29','0ed0ed73-a603-4400-969d-cfc00117f1d6'),
	(421,421,1,NULL,NULL,1,'2020-02-15 22:14:29','2020-02-15 22:14:29','d49fe58b-7494-481d-b964-e72e5291b774'),
	(422,422,1,NULL,NULL,1,'2020-02-15 22:14:32','2020-02-15 22:14:32','72990d42-34da-4459-b25e-4cb2b606e767'),
	(423,423,1,NULL,NULL,1,'2020-02-15 22:14:32','2020-02-15 22:14:32','7aafb098-73bc-4e55-82e6-cf62d09ba113'),
	(426,426,1,NULL,NULL,1,'2020-02-15 22:15:01','2020-02-15 22:15:01','282dbd25-2eb7-4f32-b46d-3fb56636141c'),
	(427,427,1,NULL,NULL,1,'2020-02-15 22:15:01','2020-02-15 22:15:01','3f4d967c-41f5-4b6a-b551-76513207c53a'),
	(428,428,1,NULL,NULL,1,'2020-02-15 22:15:01','2020-02-15 22:15:01','16ff7192-38ae-497d-815d-18c8c09a0404'),
	(429,429,1,NULL,NULL,1,'2020-02-15 22:15:01','2020-02-15 22:15:01','99e9072c-2526-44af-94da-b437a004ff4f'),
	(430,430,1,NULL,NULL,1,'2020-02-15 22:15:01','2020-02-15 22:15:01','0c80bb24-c22c-42c9-b693-61482548290c'),
	(431,431,1,NULL,NULL,1,'2020-02-15 22:15:01','2020-02-15 22:15:01','66d48777-7546-4973-8c31-d5eec28acf08'),
	(432,432,1,NULL,NULL,1,'2020-02-15 22:15:01','2020-02-15 22:15:01','ad5c7323-0863-4caa-9325-b97fcec292dc'),
	(433,433,1,NULL,NULL,1,'2020-02-15 22:15:01','2020-02-15 22:15:01','211ff141-7050-4e20-8536-591cb4b63a36'),
	(434,434,1,NULL,NULL,1,'2020-02-15 22:15:01','2020-02-15 22:15:01','fbc8c136-d0ba-4eac-8a1d-c5f00094bd59'),
	(435,435,1,NULL,NULL,1,'2020-02-15 22:15:01','2020-02-15 22:15:01','f043edb8-74a2-403e-8679-e3142f8868b8'),
	(436,436,1,NULL,NULL,1,'2020-02-15 22:15:01','2020-02-15 22:15:01','61e9dff8-16a0-46f5-af26-6be77e004692'),
	(437,437,1,NULL,NULL,1,'2020-02-15 22:15:01','2020-02-15 22:15:01','a9561c91-5a24-4a87-804a-c9f70fe6cc2b'),
	(438,438,1,'perfect-espresso','recipes/perfect-espresso',1,'2020-02-15 22:15:01','2020-02-15 22:15:01','38fbb7c0-b97a-43b5-8cad-a7916587f955'),
	(439,439,1,NULL,NULL,1,'2020-02-15 22:15:02','2020-02-15 22:15:02','d11f5fc8-d936-4494-a4b9-de04f9ce47dd'),
	(440,440,1,NULL,NULL,1,'2020-02-15 22:15:02','2020-02-15 22:15:02','20721b0b-9a2e-4750-8e1a-6d9647386940'),
	(441,441,1,NULL,NULL,1,'2020-02-15 22:15:02','2020-02-15 22:15:02','5201f7c4-217f-492a-9e8a-d2a905dc2f30'),
	(442,442,1,NULL,NULL,1,'2020-02-15 22:15:02','2020-02-15 22:15:02','b5ed174f-dfa8-4563-85fe-3c880cd1df82'),
	(443,443,1,NULL,NULL,1,'2020-02-15 22:15:02','2020-02-15 22:15:02','948ba92a-69eb-4e18-be7c-2ffb61673c84'),
	(444,444,1,NULL,NULL,1,'2020-02-15 22:15:02','2020-02-15 22:15:02','09d84123-38be-4635-be9e-e3b3ee31ef6f'),
	(445,445,1,NULL,NULL,1,'2020-02-15 22:15:02','2020-02-15 22:15:02','649b841a-6099-4f99-a1e9-cecbd4694357'),
	(446,446,1,NULL,NULL,1,'2020-02-15 22:15:02','2020-02-15 22:15:02','748dad59-8284-41c2-a1c9-f0312c164549'),
	(447,447,1,NULL,NULL,1,'2020-02-15 22:15:02','2020-02-15 22:15:02','63b032fd-8827-474e-8700-29d9fe79f861'),
	(448,448,1,NULL,NULL,1,'2020-02-15 22:15:02','2020-02-15 22:15:02','7a0cd63a-7ef5-4f19-bc3f-f730333a9e46'),
	(449,449,1,NULL,NULL,1,'2020-02-15 22:15:02','2020-02-15 22:15:02','5f70d779-05f2-4434-bec9-a17feca72380'),
	(450,450,1,NULL,NULL,1,'2020-02-15 22:15:02','2020-02-15 22:15:02','060f2998-7c6b-4713-9ae1-35b7132eab5d'),
	(451,451,1,'espresso','styles/espresso',1,'2020-02-15 22:47:46','2020-02-15 22:47:47','7122e0ef-34b9-4869-967e-841f3768607a'),
	(452,452,1,'perfect-espresso','recipes/perfect-espresso',1,'2020-02-15 22:50:45','2020-02-15 22:50:45','94fab29a-289b-4a1d-b600-9f954e819d60'),
	(453,453,1,NULL,NULL,1,'2020-02-15 22:50:45','2020-02-15 22:50:45','7d894659-d038-49a3-b718-517451bd8d77'),
	(454,454,1,NULL,NULL,1,'2020-02-15 22:50:45','2020-02-15 22:50:45','b5dd7994-4c61-49e4-9d3d-c5083f7d1bfe'),
	(455,455,1,NULL,NULL,1,'2020-02-15 22:50:45','2020-02-15 22:50:45','da813eb1-bdba-47ea-a6fd-50c904b2802b'),
	(456,456,1,NULL,NULL,1,'2020-02-15 22:50:45','2020-02-15 22:50:45','0a06d104-33fe-45ec-96f5-99e3986494e4'),
	(457,457,1,NULL,NULL,1,'2020-02-15 22:50:45','2020-02-15 22:50:45','0b8a14c6-10f5-4cf8-9470-98ca639ed1c9'),
	(458,458,1,NULL,NULL,1,'2020-02-15 22:50:45','2020-02-15 22:50:45','e1551fd7-2076-4ce5-8142-86c1343b0405'),
	(459,459,1,NULL,NULL,1,'2020-02-15 22:50:45','2020-02-15 22:50:45','0240602f-b17a-410c-b0a5-0fbf86de0ef9'),
	(460,460,1,NULL,NULL,1,'2020-02-15 22:50:45','2020-02-15 22:50:45','21180c03-4296-49fe-b927-ee4796b4067e'),
	(461,461,1,NULL,NULL,1,'2020-02-15 22:50:45','2020-02-15 22:50:45','4077c293-d5af-4ae1-97fd-6b607adca4e0'),
	(462,462,1,NULL,NULL,1,'2020-02-15 22:50:45','2020-02-15 22:50:45','574b8f51-5b9e-4b38-a3b8-7313385e2753'),
	(463,463,1,NULL,NULL,1,'2020-02-15 22:50:45','2020-02-15 22:50:45','137edefb-543f-45e2-bd3c-0a08b069d836'),
	(464,464,1,NULL,NULL,1,'2020-02-15 22:50:45','2020-02-15 22:50:45','6e7bc8df-b30b-4b31-a684-f89e672ac876'),
	(465,465,1,'espresso','drinks/espresso',1,'2020-02-15 22:51:26','2020-02-15 22:51:26','83aeaaa8-4a9c-44fe-aa56-c210c058522a'),
	(466,466,1,'iced-coffee','drinks/iced-coffee',1,'2020-02-15 23:27:27','2020-02-15 23:27:27','89d2c9ad-ef51-4903-b99d-aef92da617f9'),
	(467,467,1,'iced-drinks','styles/iced-drinks',1,'2020-02-15 23:57:34','2020-02-15 23:57:35','c241978a-16e9-465e-9384-f346ca94c0c1'),
	(468,468,1,'iced-americano','recipes/iced-americano',1,'2020-02-16 00:02:30','2020-02-16 00:02:30','faae962f-381e-4360-bd1e-7903c1eee986'),
	(469,469,1,NULL,NULL,1,'2020-02-16 00:02:30','2020-02-16 00:02:30','107d58bc-1d5e-4c1a-9323-db5bff7b1b5c'),
	(470,470,1,'iced-americano','recipes/iced-americano',1,'2020-02-16 00:02:30','2020-02-16 00:02:30','f31ace77-9887-429a-a71b-c81513e351f0'),
	(471,471,1,'iced-coffee','drinks/iced-coffee',1,'2020-02-16 00:02:37','2020-02-16 00:02:37','350e3a56-e313-4dbd-9d08-d379102a59d1'),
	(472,472,1,'espresso','drinks/espresso',1,'2020-02-16 00:02:47','2020-02-16 00:02:47','43adac85-1704-42a3-9075-0c4e1aa2f06f');

/*!40000 ALTER TABLE `elements_sites` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table entries
# ------------------------------------------------------------

DROP TABLE IF EXISTS `entries`;

CREATE TABLE `entries` (
  `id` int(11) NOT NULL,
  `sectionId` int(11) NOT NULL,
  `parentId` int(11) DEFAULT NULL,
  `typeId` int(11) NOT NULL,
  `authorId` int(11) DEFAULT NULL,
  `postDate` datetime DEFAULT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `deletedWithEntryType` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `entries_postDate_idx` (`postDate`),
  KEY `entries_expiryDate_idx` (`expiryDate`),
  KEY `entries_authorId_idx` (`authorId`),
  KEY `entries_sectionId_idx` (`sectionId`),
  KEY `entries_typeId_idx` (`typeId`),
  KEY `entries_parentId_fk` (`parentId`),
  CONSTRAINT `entries_authorId_fk` FOREIGN KEY (`authorId`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entries_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entries_parentId_fk` FOREIGN KEY (`parentId`) REFERENCES `entries` (`id`) ON DELETE SET NULL,
  CONSTRAINT `entries_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entries_typeId_fk` FOREIGN KEY (`typeId`) REFERENCES `entrytypes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `entries` WRITE;
/*!40000 ALTER TABLE `entries` DISABLE KEYS */;

INSERT INTO `entries` (`id`, `sectionId`, `parentId`, `typeId`, `authorId`, `postDate`, `expiryDate`, `deletedWithEntryType`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(2,1,NULL,1,1,'2020-02-01 20:56:00',NULL,NULL,'2020-02-01 20:56:39','2020-02-01 20:56:39','2c5feb37-6bdb-4063-b669-da26a221647b'),
	(3,1,NULL,1,1,'2020-02-01 21:07:00',NULL,NULL,'2020-02-01 21:07:32','2020-02-01 21:07:32','8fb12faf-2f40-42bb-9297-39e3a7bd18f3'),
	(5,1,NULL,1,1,'2020-02-01 21:09:00',NULL,NULL,'2020-02-01 21:10:00','2020-02-01 21:10:00','1156b822-84b6-4fc5-9873-5cc29f6aea85'),
	(6,1,NULL,1,1,'2020-02-01 21:09:00',NULL,NULL,'2020-02-01 21:10:00','2020-02-01 21:10:00','941117ef-6e14-4c79-8f33-55e52d87125e'),
	(7,2,NULL,2,1,'2020-02-01 21:10:00',NULL,NULL,'2020-02-01 21:10:40','2020-02-01 21:10:40','ea8a0871-480d-4414-9225-289226deb835'),
	(9,2,NULL,2,1,'2020-02-01 21:11:00',NULL,NULL,'2020-02-01 21:11:44','2020-02-01 21:11:44','a18fb954-bd61-4fa5-8e08-205c74a33255'),
	(10,2,NULL,2,1,'2020-02-01 21:11:00',NULL,NULL,'2020-02-01 21:11:44','2020-02-01 21:11:44','af789c5d-810d-4feb-8a16-458b17cf327a'),
	(11,3,NULL,3,NULL,'2020-02-09 17:31:00',NULL,NULL,'2020-02-09 17:31:35','2020-02-09 17:31:35','d3583165-7aed-4378-8fcf-178e84876b19'),
	(12,3,NULL,3,NULL,'2020-02-09 17:31:00',NULL,NULL,'2020-02-09 17:31:35','2020-02-09 17:31:35','3deb3386-7fb1-4e91-a203-4947b8b00d2f'),
	(13,3,NULL,3,NULL,'2020-02-09 17:31:00',NULL,NULL,'2020-02-09 17:31:36','2020-02-09 17:31:36','c3be1740-98be-4140-a81a-812423f21671'),
	(14,3,NULL,3,NULL,'2020-02-09 17:31:00',NULL,NULL,'2020-02-09 17:32:33','2020-02-09 17:32:33','afc16e52-059f-40f6-80b8-160f0144ae97'),
	(16,1,NULL,1,1,'2020-02-01 21:09:00',NULL,NULL,'2020-02-09 19:06:20','2020-02-09 19:06:20','01c9d756-4c6b-4982-b318-4228031d301e'),
	(19,1,NULL,1,1,'2020-02-09 19:11:00',NULL,NULL,'2020-02-09 19:11:42','2020-02-09 19:11:42','63e87991-dc87-4704-9a66-53b8f6648f45'),
	(20,1,NULL,1,1,'2020-02-09 19:11:00',NULL,NULL,'2020-02-09 19:11:43','2020-02-09 19:11:43','b18db4e2-5db8-417b-b50e-81bb76cd1e8c'),
	(22,4,NULL,4,1,'2020-02-09 19:19:00',NULL,NULL,'2020-02-09 19:19:47','2020-02-09 19:19:47','319f3434-a20c-4be1-989b-69dab999f177'),
	(23,4,NULL,4,1,'2020-02-09 19:19:00',NULL,NULL,'2020-02-09 19:19:47','2020-02-09 19:19:47','a782fc2b-a9fc-4cb9-a68e-4ccba720f357'),
	(25,4,NULL,4,1,'2020-02-09 19:19:00',NULL,NULL,'2020-02-09 19:20:02','2020-02-09 19:20:02','b1399647-6831-4eee-bbf2-1606c1c34cbf'),
	(26,4,NULL,4,1,'2020-02-09 19:19:00',NULL,NULL,'2020-02-09 19:20:02','2020-02-09 19:20:02','45497ea8-7001-4826-961d-ffde2e00037f'),
	(28,4,NULL,4,1,'2020-02-09 19:20:00',NULL,NULL,'2020-02-09 19:20:16','2020-02-09 19:20:16','78e2672d-6304-4608-a933-777967f11ea3'),
	(29,4,NULL,4,1,'2020-02-09 19:20:00',NULL,NULL,'2020-02-09 19:20:17','2020-02-09 19:20:17','6afe317d-e363-4e6d-8c25-d84a843cf82d'),
	(31,4,NULL,4,1,'2020-02-09 19:20:00',NULL,NULL,'2020-02-09 19:20:37','2020-02-09 19:20:37','7b755525-1fd2-41de-963c-5d4bd26a0690'),
	(32,4,NULL,4,1,'2020-02-09 19:20:00',NULL,NULL,'2020-02-09 19:20:37','2020-02-09 19:20:37','7ee0eec1-b29f-4556-a67b-fca52908fc30'),
	(33,4,NULL,4,1,'2020-02-09 19:19:00',NULL,NULL,'2020-02-09 20:14:18','2020-02-09 20:14:18','d7d372c3-3e59-4f3b-84e1-020f0c8a01d0'),
	(34,3,NULL,3,NULL,'2020-02-09 17:31:00',NULL,NULL,'2020-02-09 20:46:21','2020-02-09 20:46:21','b26abe83-2dab-400f-b5bb-622d3957d052'),
	(35,3,NULL,3,NULL,'2020-02-09 17:31:00',NULL,NULL,'2020-02-09 20:46:41','2020-02-09 20:46:41','a7bea90e-86ef-441f-9f49-49ff3bcc5cc8'),
	(36,3,NULL,3,NULL,'2020-02-09 17:31:00',NULL,NULL,'2020-02-09 20:47:42','2020-02-09 20:47:42','b61a3b4a-0d5f-42aa-9a18-93046ac05b4f'),
	(37,1,NULL,1,1,'2020-02-01 21:09:00',NULL,NULL,'2020-02-09 21:26:21','2020-02-09 21:26:21','0fb48c46-3a54-438c-bf8f-2164fc56d132'),
	(39,2,NULL,2,1,'2020-02-09 21:54:00',NULL,NULL,'2020-02-09 21:54:28','2020-02-09 21:54:28','ab0cbe6a-8e27-49e5-a800-3154c2fdf91c'),
	(40,2,NULL,2,1,'2020-02-09 21:54:00',NULL,NULL,'2020-02-09 21:54:29','2020-02-09 21:54:29','ef48ad70-0c14-4ffb-aca0-cfc8adfa43f2'),
	(41,4,NULL,4,1,'2020-02-09 19:19:00',NULL,NULL,'2020-02-15 20:21:35','2020-02-15 20:21:35','4397a917-7c26-46af-8013-be83dd085763'),
	(42,4,NULL,4,1,'2020-02-09 19:20:00',NULL,NULL,'2020-02-15 20:57:06','2020-02-15 20:57:06','d4164a63-84bd-47d7-b0fc-e213faf5f3c5'),
	(381,5,NULL,5,1,'2020-02-15 21:11:00',NULL,NULL,'2020-02-15 21:15:15','2020-02-15 21:15:15','5ca2b477-bfc5-40f7-a1ba-f31256ab385d'),
	(392,5,NULL,5,1,'2020-02-15 21:11:00',NULL,NULL,'2020-02-15 21:15:15','2020-02-15 21:15:15','1266c367-2bc5-42a6-aafb-02dd671b0abd'),
	(438,5,NULL,5,1,'2020-02-15 21:11:00',NULL,NULL,'2020-02-15 22:15:01','2020-02-15 22:15:01','11c93939-f274-40c9-ba79-c96b9ce0e22c'),
	(452,5,NULL,5,1,'2020-02-15 21:11:00',NULL,NULL,'2020-02-15 22:50:45','2020-02-15 22:50:45','73164ace-e806-4914-963e-dde224bd45ba'),
	(465,1,NULL,1,1,'2020-02-01 21:09:00',NULL,NULL,'2020-02-15 22:51:26','2020-02-15 22:51:26','ab3f551a-6600-4c3e-885d-33b7d3918d21'),
	(466,1,NULL,1,1,'2020-02-09 19:11:00',NULL,NULL,'2020-02-15 23:27:27','2020-02-15 23:27:27','679293b1-28e5-496e-8c95-cbcfef0b94e4'),
	(468,5,NULL,5,1,'2020-02-16 00:02:00',NULL,NULL,'2020-02-16 00:02:30','2020-02-16 00:02:30','f54ba86d-9359-47a5-8853-aa39b01d4b5d'),
	(470,5,NULL,5,1,'2020-02-16 00:02:00',NULL,NULL,'2020-02-16 00:02:30','2020-02-16 00:02:30','eaa4a4f7-c597-4925-9709-798619e54edb'),
	(471,1,NULL,1,1,'2020-02-09 19:11:00',NULL,NULL,'2020-02-16 00:02:37','2020-02-16 00:02:37','6a9b5a97-4780-493e-a1e1-b51cf7043c66'),
	(472,1,NULL,1,1,'2020-02-01 21:09:00',NULL,NULL,'2020-02-16 00:02:47','2020-02-16 00:02:47','3fde0108-4f41-4c04-9397-686b35ca2058');

/*!40000 ALTER TABLE `entries` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table entrytypes
# ------------------------------------------------------------

DROP TABLE IF EXISTS `entrytypes`;

CREATE TABLE `entrytypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sectionId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `hasTitleField` tinyint(1) NOT NULL DEFAULT 1,
  `titleLabel` varchar(255) DEFAULT 'Title',
  `titleFormat` varchar(255) DEFAULT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `entrytypes_name_sectionId_idx` (`name`,`sectionId`),
  KEY `entrytypes_handle_sectionId_idx` (`handle`,`sectionId`),
  KEY `entrytypes_sectionId_idx` (`sectionId`),
  KEY `entrytypes_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `entrytypes_dateDeleted_idx` (`dateDeleted`),
  CONSTRAINT `entrytypes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `entrytypes_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `entrytypes` WRITE;
/*!40000 ALTER TABLE `entrytypes` DISABLE KEYS */;

INSERT INTO `entrytypes` (`id`, `sectionId`, `fieldLayoutId`, `name`, `handle`, `hasTitleField`, `titleLabel`, `titleFormat`, `sortOrder`, `dateCreated`, `dateUpdated`, `dateDeleted`, `uid`)
VALUES
	(1,1,1,'Drinks','drinks',1,'Drink Name','',1,'2020-02-01 20:51:13','2020-02-01 21:09:23',NULL,'06203c16-55ba-4810-8681-c9389a09d511'),
	(2,2,2,'News','news',1,'Headline','',1,'2020-02-01 21:02:31','2020-02-01 21:11:12',NULL,'f6651859-32f7-4145-8c38-20b0580af233'),
	(3,3,3,'Homepage','homepage',1,'Homepage Title','{section.name|raw}',1,'2020-02-09 17:31:35','2020-02-09 20:46:21',NULL,'d70d6cbe-3a4a-4e56-9b2e-805217072249'),
	(4,4,4,'About Crafty Coffee','aboutCraftyCoffee',1,'Page Title','',1,'2020-02-09 19:19:21','2020-02-09 20:13:39',NULL,'1dfcc1f2-1d87-4993-9e6f-67bcc0ad89ad'),
	(5,5,10,'Recipes','recipes',1,'Recipe Name','',1,'2020-02-15 21:06:05','2020-02-15 21:11:19',NULL,'1f0fb227-518c-43e2-a942-e265b4418f0a');

/*!40000 ALTER TABLE `entrytypes` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table feedme_feeds
# ------------------------------------------------------------

DROP TABLE IF EXISTS `feedme_feeds`;

CREATE TABLE `feedme_feeds` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `feedUrl` text NOT NULL,
  `feedType` varchar(255) DEFAULT NULL,
  `primaryElement` varchar(255) DEFAULT NULL,
  `elementType` varchar(255) NOT NULL,
  `elementGroup` text DEFAULT NULL,
  `siteId` varchar(255) DEFAULT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `duplicateHandle` text DEFAULT NULL,
  `paginationNode` text DEFAULT NULL,
  `fieldMapping` text DEFAULT NULL,
  `fieldUnique` text DEFAULT NULL,
  `passkey` varchar(255) NOT NULL,
  `backup` tinyint(1) NOT NULL DEFAULT 0,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table fieldgroups
# ------------------------------------------------------------

DROP TABLE IF EXISTS `fieldgroups`;

CREATE TABLE `fieldgroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `fieldgroups_name_unq_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `fieldgroups` WRITE;
/*!40000 ALTER TABLE `fieldgroups` DISABLE KEYS */;

INSERT INTO `fieldgroups` (`id`, `name`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,'Common','2020-02-01 17:54:17','2020-02-01 17:54:17','3b6974a4-9d51-4345-a941-778edfff572f'),
	(2,'Drinks','2020-02-01 20:54:33','2020-02-01 20:54:33','ee4b868b-862a-4514-89bf-c1627b334767'),
	(3,'News','2020-02-01 21:02:39','2020-02-01 21:02:39','5d80f4a5-fb02-449a-8ba7-ebddb8f75a13'),
	(5,'About','2020-02-09 20:11:47','2020-02-09 20:11:47','9c35720b-c811-4a45-b7b5-b2bc21e04771'),
	(6,'Recipes','2020-02-15 21:06:25','2020-02-15 21:06:25','f1955e73-011b-4287-8fd2-2e9156f746c3'),
	(7,'Styles','2020-02-15 22:45:53','2020-02-15 22:45:53','db2778d4-77e2-4d2c-bbc5-06e8b1f63667');

/*!40000 ALTER TABLE `fieldgroups` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table fieldlayoutfields
# ------------------------------------------------------------

DROP TABLE IF EXISTS `fieldlayoutfields`;

CREATE TABLE `fieldlayoutfields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `layoutId` int(11) NOT NULL,
  `tabId` int(11) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `required` tinyint(1) NOT NULL DEFAULT 0,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `fieldlayoutfields_layoutId_fieldId_unq_idx` (`layoutId`,`fieldId`),
  KEY `fieldlayoutfields_sortOrder_idx` (`sortOrder`),
  KEY `fieldlayoutfields_tabId_idx` (`tabId`),
  KEY `fieldlayoutfields_fieldId_idx` (`fieldId`),
  CONSTRAINT `fieldlayoutfields_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fieldlayoutfields_layoutId_fk` FOREIGN KEY (`layoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fieldlayoutfields_tabId_fk` FOREIGN KEY (`tabId`) REFERENCES `fieldlayouttabs` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `fieldlayoutfields` WRITE;
/*!40000 ALTER TABLE `fieldlayoutfields` DISABLE KEYS */;

INSERT INTO `fieldlayoutfields` (`id`, `layoutId`, `tabId`, `fieldId`, `required`, `sortOrder`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(3,2,2,3,0,1,'2020-02-01 21:11:12','2020-02-01 21:11:12','571e6a70-2ebe-4877-ad0f-c7145acb3d88'),
	(4,2,2,4,0,2,'2020-02-01 21:11:12','2020-02-01 21:11:12','5b56990b-45d3-4e1c-bd86-fd354d4f6b55'),
	(11,4,5,7,0,2,'2020-02-09 20:13:39','2020-02-09 20:13:39','b9bddd71-a87a-463a-aa97-81eaa7ad6334'),
	(12,4,5,2,1,3,'2020-02-09 20:13:39','2020-02-09 20:13:39','274d6bb6-b006-4af9-ba40-888d37fa9496'),
	(13,4,5,6,0,1,'2020-02-09 20:13:39','2020-02-09 20:13:39','3cb2aef0-f1eb-47f7-87bc-02d5556fa086'),
	(14,3,6,6,0,1,'2020-02-09 20:46:21','2020-02-09 20:46:21','1b38829b-5f33-4856-8c5f-4384292570e5'),
	(15,5,7,9,0,2,'2020-02-15 21:11:00','2020-02-15 21:11:00','cbe9c7ec-0a7a-4a4a-ba90-3387a85e419c'),
	(16,5,7,10,0,1,'2020-02-15 21:11:00','2020-02-15 21:11:00','2cb76774-c36a-47a1-b3b0-29c05c419d65'),
	(17,6,8,11,0,1,'2020-02-15 21:11:01','2020-02-15 21:11:01','dc7c8225-f3da-4ce4-8016-26292e4faa98'),
	(18,7,9,12,0,1,'2020-02-15 21:11:01','2020-02-15 21:11:01','f683c886-b704-4885-ac07-5bb69a9bbc3f'),
	(19,8,10,13,0,1,'2020-02-15 21:11:01','2020-02-15 21:11:01','fd216c2f-308b-44aa-a9c3-dfdbe431f9f2'),
	(20,8,10,14,0,2,'2020-02-15 21:11:01','2020-02-15 21:11:01','1c9d871c-c5b7-4de8-acb0-eb890700ad81'),
	(21,9,11,15,0,1,'2020-02-15 21:11:01','2020-02-15 21:11:01','e35397af-16bf-4675-b6cc-965a3046f3c1'),
	(23,11,13,16,0,1,'2020-02-15 22:47:01','2020-02-15 22:47:01','bdeea368-3be2-430d-b80c-5527a1fb9278'),
	(24,10,14,17,0,1,'2020-02-15 22:50:27','2020-02-15 22:50:27','f87f14e8-696f-42fa-af39-79890dca9144'),
	(25,10,14,8,0,2,'2020-02-15 22:50:27','2020-02-15 22:50:27','75886175-532d-4505-ad5e-da34e9ffd2fb'),
	(30,1,16,1,0,2,'2020-02-16 00:01:58','2020-02-16 00:01:58','e9d8fc35-c1f8-4af0-a8a9-2bbbd3815ae9'),
	(31,1,16,5,0,4,'2020-02-16 00:01:58','2020-02-16 00:01:58','c64b6bb5-41c0-42b5-943e-41c1244ce04c'),
	(32,1,16,18,0,5,'2020-02-16 00:01:58','2020-02-16 00:01:58','66742ce9-bf3c-4a8f-b369-3fc07e038be1'),
	(33,1,16,17,0,1,'2020-02-16 00:01:58','2020-02-16 00:01:58','c8b65d16-0359-4592-92ad-097ad1625c43'),
	(34,1,16,2,0,3,'2020-02-16 00:01:58','2020-02-16 00:01:58','eed2f7ed-e50a-47bb-a87a-355831afdcd3');

/*!40000 ALTER TABLE `fieldlayoutfields` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table fieldlayouts
# ------------------------------------------------------------

DROP TABLE IF EXISTS `fieldlayouts`;

CREATE TABLE `fieldlayouts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fieldlayouts_dateDeleted_idx` (`dateDeleted`),
  KEY `fieldlayouts_type_idx` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `fieldlayouts` WRITE;
/*!40000 ALTER TABLE `fieldlayouts` DISABLE KEYS */;

INSERT INTO `fieldlayouts` (`id`, `type`, `dateCreated`, `dateUpdated`, `dateDeleted`, `uid`)
VALUES
	(1,'craft\\elements\\Entry','2020-02-01 21:09:23','2020-02-01 21:09:23',NULL,'3dc744db-5229-4d1e-a804-d45dd0e54ac2'),
	(2,'craft\\elements\\Entry','2020-02-01 21:11:12','2020-02-01 21:11:12',NULL,'54fc7844-58dc-4302-b462-8c78f299b5aa'),
	(3,'craft\\elements\\Entry','2020-02-09 17:32:33','2020-02-09 17:32:33',NULL,'13e21443-f0f4-47e1-8740-561f0db55bbf'),
	(4,'craft\\elements\\Entry','2020-02-09 20:13:39','2020-02-09 20:13:39',NULL,'1ab7b24d-0a91-4780-8ceb-75f755842588'),
	(5,'craft\\elements\\MatrixBlock','2020-02-15 21:11:00','2020-02-15 21:11:00',NULL,'fe12124a-6141-4fcf-8175-58ad302d26ad'),
	(6,'craft\\elements\\MatrixBlock','2020-02-15 21:11:01','2020-02-15 21:11:01',NULL,'448d9a7a-b76e-42f0-8399-4465b97953db'),
	(7,'craft\\elements\\MatrixBlock','2020-02-15 21:11:01','2020-02-15 21:11:01',NULL,'e31ae32c-7554-4e56-99a7-05db4b7d4e28'),
	(8,'craft\\elements\\MatrixBlock','2020-02-15 21:11:01','2020-02-15 21:11:01',NULL,'fa174242-6bd2-46a6-8608-35da9799cc6f'),
	(9,'craft\\elements\\MatrixBlock','2020-02-15 21:11:01','2020-02-15 21:11:01',NULL,'863d3279-5a88-4549-9141-55fe48eaf17b'),
	(10,'craft\\elements\\Entry','2020-02-15 21:11:19','2020-02-15 21:11:19',NULL,'25f35663-03e9-4789-9528-ae9907d6dc3e'),
	(11,'craft\\elements\\Category','2020-02-15 22:47:01','2020-02-15 22:47:01',NULL,'4690bc11-42da-4835-a37e-2102396f331b');

/*!40000 ALTER TABLE `fieldlayouts` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table fieldlayouttabs
# ------------------------------------------------------------

DROP TABLE IF EXISTS `fieldlayouttabs`;

CREATE TABLE `fieldlayouttabs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `layoutId` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fieldlayouttabs_sortOrder_idx` (`sortOrder`),
  KEY `fieldlayouttabs_layoutId_idx` (`layoutId`),
  CONSTRAINT `fieldlayouttabs_layoutId_fk` FOREIGN KEY (`layoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `fieldlayouttabs` WRITE;
/*!40000 ALTER TABLE `fieldlayouttabs` DISABLE KEYS */;

INSERT INTO `fieldlayouttabs` (`id`, `layoutId`, `name`, `sortOrder`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(2,2,'News',1,'2020-02-01 21:11:12','2020-02-01 21:11:12','4ba4fa05-8194-420c-946d-a58d13d8f80b'),
	(5,4,'About',1,'2020-02-09 20:13:39','2020-02-09 20:13:39','4b800267-cc7a-48b9-a8e1-fe034498f2fa'),
	(6,3,'Common',1,'2020-02-09 20:46:21','2020-02-09 20:46:21','4dc21d88-81cd-44dd-bc9a-8efdb5645e51'),
	(7,5,'Content',1,'2020-02-15 21:11:00','2020-02-15 21:11:00','dff27399-5c79-4a55-87c4-73b4e1647745'),
	(8,6,'Content',1,'2020-02-15 21:11:01','2020-02-15 21:11:01','c3329c73-8803-4890-99c7-5ee9090b8bef'),
	(9,7,'Content',1,'2020-02-15 21:11:01','2020-02-15 21:11:01','1bacd4c0-9b70-4bfe-924f-7ffdbe4deaa0'),
	(10,8,'Content',1,'2020-02-15 21:11:01','2020-02-15 21:11:01','77533a1a-ce80-448c-8eeb-5900c4912eca'),
	(11,9,'Content',1,'2020-02-15 21:11:01','2020-02-15 21:11:01','8775a533-5f9d-44ab-aaf9-207ae234a4af'),
	(13,11,'Styles',1,'2020-02-15 22:47:01','2020-02-15 22:47:01','9d29c80c-bb83-41c2-90f7-2449bad9810c'),
	(14,10,'Recipes',1,'2020-02-15 22:50:27','2020-02-15 22:50:27','3e54b600-9837-4ff6-a752-aa6ae9e6094b'),
	(16,1,'Drink Details',1,'2020-02-16 00:01:58','2020-02-16 00:01:58','33e85a3a-dce7-497a-b7de-de20a50e47f4');

/*!40000 ALTER TABLE `fieldlayouttabs` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table fields
# ------------------------------------------------------------

DROP TABLE IF EXISTS `fields`;

CREATE TABLE `fields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(64) NOT NULL,
  `context` varchar(255) NOT NULL DEFAULT 'global',
  `instructions` text DEFAULT NULL,
  `searchable` tinyint(1) NOT NULL DEFAULT 1,
  `translationMethod` varchar(255) NOT NULL DEFAULT 'none',
  `translationKeyFormat` text DEFAULT NULL,
  `type` varchar(255) NOT NULL,
  `settings` text DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `fields_handle_context_unq_idx` (`handle`,`context`),
  KEY `fields_groupId_idx` (`groupId`),
  KEY `fields_context_idx` (`context`),
  CONSTRAINT `fields_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `fieldgroups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `fields` WRITE;
/*!40000 ALTER TABLE `fields` DISABLE KEYS */;

INSERT INTO `fields` (`id`, `groupId`, `name`, `handle`, `context`, `instructions`, `searchable`, `translationMethod`, `translationKeyFormat`, `type`, `settings`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,2,'Introduction','introduction','global','Short sentence at top of drink page. ',1,'none',NULL,'craft\\fields\\PlainText','{\"byteLimit\":null,\"charLimit\":null,\"code\":\"\",\"columnType\":null,\"initialRows\":\"4\",\"multiline\":\"\",\"placeholder\":\"\"}','2020-02-01 20:58:38','2020-02-01 20:58:38','074c8fde-16e3-4d13-b76d-6aa448a652df'),
	(2,2,'Page Copy','pageCopy','global','',1,'none',NULL,'craft\\redactor\\Field','{\"availableTransforms\":\"*\",\"availableVolumes\":\"*\",\"cleanupHtml\":true,\"columnType\":\"text\",\"purifierConfig\":\"\",\"purifyHtml\":\"1\",\"redactorConfig\":\"Standard.json\",\"removeEmptyTags\":\"1\",\"removeInlineStyles\":\"1\",\"removeNbsp\":\"1\"}','2020-02-01 21:00:29','2020-02-01 21:00:29','c2802d29-16d2-4e5f-8401-92321167c0e5'),
	(3,1,'Excerpt','excerpt','global','',1,'none',NULL,'craft\\fields\\PlainText','{\"byteLimit\":null,\"charLimit\":null,\"code\":\"\",\"columnType\":null,\"initialRows\":\"4\",\"multiline\":\"\",\"placeholder\":\"\"}','2020-02-01 21:03:51','2020-02-01 21:04:07','7df7941d-1e86-4a49-ab03-7ab8719f88b9'),
	(4,3,'News Body','newsBody','global','',1,'none',NULL,'craft\\redactor\\Field','{\"availableTransforms\":\"*\",\"availableVolumes\":\"*\",\"cleanupHtml\":true,\"columnType\":\"text\",\"purifierConfig\":\"\",\"purifyHtml\":\"1\",\"redactorConfig\":\"\",\"removeEmptyTags\":\"1\",\"removeInlineStyles\":\"1\",\"removeNbsp\":\"1\"}','2020-02-01 21:04:45','2020-02-01 21:04:45','e59589de-cf68-450b-9d7c-a57576c03f36'),
	(5,2,'Drink Image','drinkImage','global','',1,'site',NULL,'craft\\fields\\Assets','{\"allowedKinds\":[\"image\"],\"defaultUploadLocationSource\":\"volume:679feb39-d56f-43cf-9b9a-5c4009fa2324\",\"defaultUploadLocationSubpath\":\"\",\"limit\":\"1\",\"localizeRelations\":false,\"restrictFiles\":\"1\",\"selectionLabel\":\"Add a drink image\",\"showUnpermittedFiles\":false,\"showUnpermittedVolumes\":false,\"singleUploadLocationSource\":\"volume:679feb39-d56f-43cf-9b9a-5c4009fa2324\",\"singleUploadLocationSubpath\":\"\",\"source\":null,\"sources\":[\"volume:679feb39-d56f-43cf-9b9a-5c4009fa2324\"],\"targetSiteId\":null,\"useSingleFolder\":false,\"validateRelatedElements\":\"\",\"viewMode\":\"large\"}','2020-02-09 19:05:54','2020-02-09 19:05:54','479c8046-8ddf-451a-9c73-c31398b7da01'),
	(6,5,'Subtitle','subtitle','global','',1,'none',NULL,'craft\\fields\\PlainText','{\"byteLimit\":null,\"charLimit\":null,\"code\":\"\",\"columnType\":null,\"initialRows\":\"4\",\"multiline\":\"\",\"placeholder\":\"\"}','2020-02-09 20:12:35','2020-02-09 20:12:35','dad89190-0d91-462f-88dd-4d1ac49c4f66'),
	(7,5,'Page Intro','pageIntro','global','',1,'none',NULL,'craft\\fields\\PlainText','{\"byteLimit\":null,\"charLimit\":null,\"code\":\"\",\"columnType\":null,\"initialRows\":\"4\",\"multiline\":\"\",\"placeholder\":\"\"}','2020-02-09 20:12:46','2020-02-09 20:12:46','54bb063c-5936-4bf3-bc9a-85c89a1219e6'),
	(8,6,'Recipe Contents','recipeContents','global','',1,'site',NULL,'craft\\fields\\Matrix','{\"contentTable\":\"{{%matrixcontent_recipecontents}}\",\"maxBlocks\":\"\",\"minBlocks\":\"\",\"propagationMethod\":\"all\"}','2020-02-15 21:11:00','2020-02-15 21:11:00','c335386c-416d-422b-ab7d-a6390613287a'),
	(9,NULL,'Image Caption','imageCaption','matrixBlockType:f78bfaa9-e525-4b4a-9897-ce5058310dcc','',1,'none',NULL,'craft\\fields\\PlainText','{\"byteLimit\":null,\"charLimit\":null,\"code\":\"\",\"columnType\":null,\"initialRows\":\"4\",\"multiline\":\"\",\"placeholder\":\"\"}','2020-02-15 21:11:00','2020-02-15 21:11:00','1a5780ca-d8db-4b31-8c76-c8d74fa795f2'),
	(10,NULL,'Image','image','matrixBlockType:f78bfaa9-e525-4b4a-9897-ce5058310dcc','',1,'site',NULL,'craft\\fields\\Assets','{\"allowedKinds\":null,\"defaultUploadLocationSource\":\"volume:679feb39-d56f-43cf-9b9a-5c4009fa2324\",\"defaultUploadLocationSubpath\":\"\",\"limit\":\"1\",\"localizeRelations\":false,\"restrictFiles\":\"\",\"selectionLabel\":\"\",\"showUnpermittedFiles\":false,\"showUnpermittedVolumes\":false,\"singleUploadLocationSource\":\"volume:679feb39-d56f-43cf-9b9a-5c4009fa2324\",\"singleUploadLocationSubpath\":\"\",\"source\":null,\"sources\":\"*\",\"targetSiteId\":null,\"useSingleFolder\":false,\"validateRelatedElements\":\"\",\"viewMode\":\"list\"}','2020-02-15 21:11:00','2020-02-15 21:11:00','4bb837ed-696a-465c-ae5e-a52ed850b2e3'),
	(11,NULL,'Tip Content','tipContent','matrixBlockType:2fe8849d-a3b2-4e86-abfd-a4124ea0076c','',1,'none',NULL,'craft\\fields\\PlainText','{\"byteLimit\":null,\"charLimit\":null,\"code\":\"\",\"columnType\":null,\"initialRows\":\"4\",\"multiline\":\"\",\"placeholder\":\"\"}','2020-02-15 21:11:01','2020-02-15 21:11:01','8c86b286-218c-4a63-ba91-14d33ceb7cda'),
	(12,NULL,'Body Content','bodyContent','matrixBlockType:51e3646e-111c-4651-ae09-9fd365b33a91','',1,'none',NULL,'craft\\redactor\\Field','{\"availableTransforms\":\"*\",\"availableVolumes\":\"*\",\"cleanupHtml\":true,\"columnType\":\"text\",\"purifierConfig\":\"\",\"purifyHtml\":\"1\",\"redactorConfig\":\"\",\"removeEmptyTags\":\"1\",\"removeInlineStyles\":\"1\",\"removeNbsp\":\"1\"}','2020-02-15 21:11:01','2020-02-15 21:11:01','fe75e466-7678-407d-ad47-a73ce2ca3bbb'),
	(13,NULL,'Steps Title','stepsTitle','matrixBlockType:0e0962e4-e4b0-4083-b63b-9906481a6e0b','',1,'none',NULL,'craft\\fields\\PlainText','{\"byteLimit\":null,\"charLimit\":null,\"code\":\"\",\"columnType\":null,\"initialRows\":\"4\",\"multiline\":\"\",\"placeholder\":\"\"}','2020-02-15 21:11:01','2020-02-15 21:11:01','b03a2cff-e3e4-4c3a-b6a6-c3e8c781c2ee'),
	(14,NULL,'Steps Content','stepsContent','matrixBlockType:0e0962e4-e4b0-4083-b63b-9906481a6e0b','',1,'none',NULL,'craft\\fields\\Table','{\"addRowLabel\":\"Add a row\",\"columnType\":\"text\",\"columns\":{\"col1\":{\"heading\":\"Step Instructions\",\"handle\":\"stepInstructions\",\"width\":\"\",\"type\":\"multiline\"}},\"maxRows\":\"\",\"minRows\":\"\"}','2020-02-15 21:11:01','2020-02-15 21:11:01','e2a289f9-4e7a-4b22-b722-afe735c924c2'),
	(15,NULL,'Ingredients','ingredients','matrixBlockType:17260a44-4415-4ac9-a021-0fb47c72adc6','',1,'none',NULL,'craft\\fields\\Table','{\"addRowLabel\":\"Add a row\",\"columnType\":\"text\",\"columns\":{\"col1\":{\"heading\":\"Amount\",\"handle\":\"amount\",\"width\":\"\",\"type\":\"singleline\"},\"col2\":{\"heading\":\"Ingredient\",\"handle\":\"ingredient\",\"width\":\"\",\"type\":\"singleline\"}},\"maxRows\":\"\",\"minRows\":\"\"}','2020-02-15 21:11:01','2020-02-15 21:11:01','ae1f295a-8164-4b75-b727-e7c2d20e5d02'),
	(16,7,'Style Description','styleDescription','global','',1,'none',NULL,'craft\\fields\\PlainText','{\"byteLimit\":null,\"charLimit\":null,\"code\":\"\",\"columnType\":null,\"initialRows\":\"4\",\"multiline\":\"1\",\"placeholder\":\"\"}','2020-02-15 22:46:37','2020-02-15 22:46:37','ef440483-c84f-4039-bdfd-3249561fe9fb'),
	(17,7,'Drink Style','drinkStyle','global','',1,'site',NULL,'craft\\fields\\Categories','{\"allowLimit\":false,\"allowMultipleSources\":false,\"branchLimit\":\"1\",\"limit\":null,\"localizeRelations\":false,\"selectionLabel\":\"Add a drink style\",\"source\":\"group:e8331de6-f36c-47ca-88ea-58d08765edc9\",\"sources\":\"*\",\"targetSiteId\":null,\"validateRelatedElements\":\"\",\"viewMode\":null}','2020-02-15 22:50:09','2020-02-15 22:50:09','a6e1ddbb-d173-474a-9b71-eeb5805708dd'),
	(18,2,'Drink Recipe','drinkRecipe','global','',1,'site',NULL,'craft\\fields\\Entries','{\"limit\":\"1\",\"localizeRelations\":false,\"selectionLabel\":\"Add a drink recipe\",\"source\":null,\"sources\":[\"section:c828d52a-d271-4b70-89a7-f6865c41ae33\"],\"targetSiteId\":null,\"validateRelatedElements\":\"\",\"viewMode\":null}','2020-02-16 00:01:39','2020-02-16 00:01:39','4d09f665-5d14-4ba3-b0d7-b901a4eae2f0');

/*!40000 ALTER TABLE `fields` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table globalsets
# ------------------------------------------------------------

DROP TABLE IF EXISTS `globalsets`;

CREATE TABLE `globalsets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `globalsets_name_idx` (`name`),
  KEY `globalsets_handle_idx` (`handle`),
  KEY `globalsets_fieldLayoutId_idx` (`fieldLayoutId`),
  CONSTRAINT `globalsets_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `globalsets_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table gqlschemas
# ------------------------------------------------------------

DROP TABLE IF EXISTS `gqlschemas`;

CREATE TABLE `gqlschemas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `scope` text DEFAULT NULL,
  `isPublic` tinyint(1) NOT NULL DEFAULT 0,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `gqlschemas` WRITE;
/*!40000 ALTER TABLE `gqlschemas` DISABLE KEYS */;

INSERT INTO `gqlschemas` (`id`, `name`, `scope`, `isPublic`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,'Public Schema','[]',1,'2020-02-01 18:03:17','2020-02-01 18:03:17','b7e76599-2010-4217-a546-937b5d3fa0e7');

/*!40000 ALTER TABLE `gqlschemas` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table gqltokens
# ------------------------------------------------------------

DROP TABLE IF EXISTS `gqltokens`;

CREATE TABLE `gqltokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `accessToken` varchar(255) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT 1,
  `expiryDate` datetime DEFAULT NULL,
  `lastUsed` datetime DEFAULT NULL,
  `schemaId` int(11) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `gqltokens_accessToken_unq_idx` (`accessToken`),
  UNIQUE KEY `gqltokens_name_unq_idx` (`name`),
  KEY `gqltokens_schemaId_fk` (`schemaId`),
  CONSTRAINT `gqltokens_schemaId_fk` FOREIGN KEY (`schemaId`) REFERENCES `gqlschemas` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `gqltokens` WRITE;
/*!40000 ALTER TABLE `gqltokens` DISABLE KEYS */;

INSERT INTO `gqltokens` (`id`, `name`, `accessToken`, `enabled`, `expiryDate`, `lastUsed`, `schemaId`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,'Public Token','__PUBLIC__',1,NULL,NULL,1,'2020-02-01 18:03:17','2020-02-01 18:03:17','229491ed-d64f-491a-870d-253866879301');

/*!40000 ALTER TABLE `gqltokens` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table info
# ------------------------------------------------------------

DROP TABLE IF EXISTS `info`;

CREATE TABLE `info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `version` varchar(50) NOT NULL,
  `schemaVersion` varchar(15) NOT NULL,
  `maintenance` tinyint(1) NOT NULL DEFAULT 0,
  `configMap` mediumtext DEFAULT NULL,
  `fieldVersion` char(12) NOT NULL DEFAULT '000000000000',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `info` WRITE;
/*!40000 ALTER TABLE `info` DISABLE KEYS */;

INSERT INTO `info` (`id`, `version`, `schemaVersion`, `maintenance`, `configMap`, `fieldVersion`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,'3.4.8','3.4.9',0,'[]','POUfbUDan6wE','2020-02-01 17:54:17','2020-02-23 23:54:59','e407b421-8286-44ca-955c-036b2fa4e75f');

/*!40000 ALTER TABLE `info` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table matrixblocks
# ------------------------------------------------------------

DROP TABLE IF EXISTS `matrixblocks`;

CREATE TABLE `matrixblocks` (
  `id` int(11) NOT NULL,
  `ownerId` int(11) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `typeId` int(11) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `deletedWithOwner` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `matrixblocks_ownerId_idx` (`ownerId`),
  KEY `matrixblocks_fieldId_idx` (`fieldId`),
  KEY `matrixblocks_typeId_idx` (`typeId`),
  KEY `matrixblocks_sortOrder_idx` (`sortOrder`),
  CONSTRAINT `matrixblocks_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixblocks_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixblocks_ownerId_fk` FOREIGN KEY (`ownerId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixblocks_typeId_fk` FOREIGN KEY (`typeId`) REFERENCES `matrixblocktypes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `matrixblocks` WRITE;
/*!40000 ALTER TABLE `matrixblocks` DISABLE KEYS */;

INSERT INTO `matrixblocks` (`id`, `ownerId`, `fieldId`, `typeId`, `sortOrder`, `deletedWithOwner`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(382,381,8,3,1,0,'2020-02-15 21:15:15','2020-02-15 21:15:15','1ba481d9-8647-45b4-90d0-a5981baafe34'),
	(383,381,8,1,2,0,'2020-02-15 21:15:15','2020-02-15 21:15:15','32bff2f2-6bbf-48cc-bfc8-04108bd20386'),
	(384,381,8,2,3,0,'2020-02-15 21:15:15','2020-02-15 21:15:15','ff59a6fe-1802-4c31-bb94-47f2fafd86f5'),
	(385,381,8,3,4,0,'2020-02-15 21:15:15','2020-02-15 21:15:15','4f757e99-6b74-4a7e-85ee-86696be35f08'),
	(386,381,8,5,5,0,'2020-02-15 21:15:15','2020-02-15 21:15:15','7752173c-749e-4b63-bf47-9242a3605739'),
	(387,381,8,3,6,0,'2020-02-15 21:15:15','2020-02-15 21:15:15','331d69b7-4864-4691-8659-af10995a9810'),
	(388,381,8,4,7,0,'2020-02-15 21:15:15','2020-02-15 21:15:15','ee9b8e35-d0cf-4627-9ed8-7fd70b36b352'),
	(389,381,8,4,8,0,'2020-02-15 21:15:15','2020-02-15 21:15:15','17a8fbe0-894b-4d36-9a3d-bd4d14c8494c'),
	(390,381,8,2,9,0,'2020-02-15 21:15:15','2020-02-15 21:15:15','0dd83367-2685-48f2-989d-4ba8ddb47a0c'),
	(391,381,8,1,10,0,'2020-02-15 21:15:15','2020-02-15 21:15:15','62cac4c6-1639-4260-8b5a-b9ee53cdba0c'),
	(393,392,8,3,1,NULL,'2020-02-15 21:15:16','2020-02-15 21:15:16','72af5e19-58e3-4f0c-98c7-d4d67fd2005e'),
	(394,392,8,1,2,NULL,'2020-02-15 21:15:16','2020-02-15 21:15:16','06bfd2dc-1e11-429f-9bf0-5c0d17c62311'),
	(395,392,8,2,3,NULL,'2020-02-15 21:15:16','2020-02-15 21:15:16','c21633ae-3680-464b-8b40-aabe96620d91'),
	(396,392,8,3,4,NULL,'2020-02-15 21:15:16','2020-02-15 21:15:16','ae195e91-b4f6-4455-801b-aa4d6a2eddcb'),
	(397,392,8,5,5,NULL,'2020-02-15 21:15:16','2020-02-15 21:15:16','48f8ab79-f78d-40bd-982b-fb2caf00ddb6'),
	(398,392,8,3,6,NULL,'2020-02-15 21:15:16','2020-02-15 21:15:16','c3b497f3-8ef6-4068-9119-212e9af43978'),
	(399,392,8,4,7,NULL,'2020-02-15 21:15:16','2020-02-15 21:15:16','b33f56f7-a29d-4894-87c9-12462292920d'),
	(400,392,8,4,8,NULL,'2020-02-15 21:15:16','2020-02-15 21:15:16','5ba49324-18c8-4ea9-a8e0-4a8a0a1dede8'),
	(401,392,8,2,9,NULL,'2020-02-15 21:15:16','2020-02-15 21:15:16','b3a8bbc2-4067-4c57-94c9-756a285ecf2f'),
	(402,392,8,1,10,NULL,'2020-02-15 21:15:16','2020-02-15 21:15:16','c9edbea5-f80c-4059-b78f-e962e9d0a71f'),
	(426,381,8,3,1,NULL,'2020-02-15 22:15:01','2020-02-15 22:15:01','9a0ad4de-7609-435f-8b44-fa9730677eb8'),
	(427,381,8,1,2,NULL,'2020-02-15 22:15:01','2020-02-15 22:15:01','468335bb-c127-4996-a88d-6a1815948582'),
	(428,381,8,2,3,NULL,'2020-02-15 22:15:01','2020-02-15 22:15:01','be668058-3192-4d45-a1a7-11a48730f83f'),
	(429,381,8,3,4,NULL,'2020-02-15 22:15:01','2020-02-15 22:15:01','ef792a40-8cd6-4e85-9d3c-5a4c9cec3da1'),
	(430,381,8,5,5,NULL,'2020-02-15 22:15:01','2020-02-15 22:15:01','e95997b1-f037-45c5-9cc2-1060f59810bd'),
	(431,381,8,3,6,NULL,'2020-02-15 22:15:01','2020-02-15 22:15:01','fff6462c-cede-40fe-869c-2314f46dfb91'),
	(432,381,8,1,7,NULL,'2020-02-15 22:15:01','2020-02-15 22:15:01','d963acc4-7203-4ca0-9390-dcb38acf17fc'),
	(433,381,8,2,8,NULL,'2020-02-15 22:15:01','2020-02-15 22:15:01','cd821d7a-39d3-49d7-830d-ead67dcc77c9'),
	(434,381,8,1,9,NULL,'2020-02-15 22:15:01','2020-02-15 22:15:01','3e92c0cc-eabe-4059-a359-16738bdbe8c9'),
	(435,381,8,4,10,NULL,'2020-02-15 22:15:01','2020-02-15 22:15:01','36d60bd6-fcef-4fde-ae69-b2f68409c4f8'),
	(436,381,8,4,11,NULL,'2020-02-15 22:15:01','2020-02-15 22:15:01','d50f7289-b338-4847-a463-ba1bcb10da63'),
	(437,381,8,4,12,NULL,'2020-02-15 22:15:01','2020-02-15 22:15:01','10b6176a-c320-4290-8bbd-3dc6954de375'),
	(439,438,8,3,1,NULL,'2020-02-15 22:15:02','2020-02-15 22:15:02','3f12a13f-c9da-4657-b9c6-3cdd2cfdb75a'),
	(440,438,8,1,2,NULL,'2020-02-15 22:15:02','2020-02-15 22:15:02','213ad428-28cb-45e3-8bf7-05b8296a1ce4'),
	(441,438,8,2,3,NULL,'2020-02-15 22:15:02','2020-02-15 22:15:02','a06f81ef-b5da-43fa-870a-f7519bb14ff6'),
	(442,438,8,3,4,NULL,'2020-02-15 22:15:02','2020-02-15 22:15:02','543f1276-c475-41ef-9c2a-33053001c166'),
	(443,438,8,5,5,NULL,'2020-02-15 22:15:02','2020-02-15 22:15:02','2b064699-2213-4a35-8815-6e67bf4f00b2'),
	(444,438,8,3,6,NULL,'2020-02-15 22:15:02','2020-02-15 22:15:02','44ba6567-c61b-4dc1-9864-30538131fc27'),
	(445,438,8,1,7,NULL,'2020-02-15 22:15:02','2020-02-15 22:15:02','21b82adb-0c29-4ec0-9191-745b734f6c95'),
	(446,438,8,2,8,NULL,'2020-02-15 22:15:02','2020-02-15 22:15:02','f3d414b8-b8f4-412e-9ef7-e6e89c3647a2'),
	(447,438,8,1,9,NULL,'2020-02-15 22:15:02','2020-02-15 22:15:02','70d97804-549d-4533-b048-2efadb10e9dd'),
	(448,438,8,4,10,NULL,'2020-02-15 22:15:02','2020-02-15 22:15:02','7057c1e7-e6ab-4173-b40f-59e96031af8d'),
	(449,438,8,4,11,NULL,'2020-02-15 22:15:02','2020-02-15 22:15:02','353fd558-92c4-4539-9a07-6473a48258f6'),
	(450,438,8,4,12,NULL,'2020-02-15 22:15:02','2020-02-15 22:15:02','03986387-0fa6-4f7b-94c0-25fd503358fa'),
	(453,452,8,3,1,NULL,'2020-02-15 22:50:45','2020-02-15 22:50:45','b834b718-2aff-4349-9d54-40982ea9c59c'),
	(454,452,8,1,2,NULL,'2020-02-15 22:50:45','2020-02-15 22:50:45','f72c75e0-510b-4537-9874-b536a647a420'),
	(455,452,8,2,3,NULL,'2020-02-15 22:50:45','2020-02-15 22:50:45','1c18899f-cada-42c6-b77b-7cd046b86f84'),
	(456,452,8,3,4,NULL,'2020-02-15 22:50:45','2020-02-15 22:50:45','70c9d668-e2eb-4c99-8232-725589472688'),
	(457,452,8,5,5,NULL,'2020-02-15 22:50:45','2020-02-15 22:50:45','90388809-5582-4cb2-be07-d5e07e91e608'),
	(458,452,8,3,6,NULL,'2020-02-15 22:50:45','2020-02-15 22:50:45','d576d802-d0ea-49e2-831d-8c5973d40fc5'),
	(459,452,8,1,7,NULL,'2020-02-15 22:50:45','2020-02-15 22:50:45','867c6042-c6dd-46dc-b35f-12d7ae1a2fdd'),
	(460,452,8,2,8,NULL,'2020-02-15 22:50:45','2020-02-15 22:50:45','ef0da03b-a4cd-4ccf-8034-b58dee899251'),
	(461,452,8,1,9,NULL,'2020-02-15 22:50:45','2020-02-15 22:50:45','7b471d8b-b179-46c2-81e0-256fed09f550'),
	(462,452,8,4,10,NULL,'2020-02-15 22:50:45','2020-02-15 22:50:45','b0b66b3f-4200-4610-a85d-5b2a822d8155'),
	(463,452,8,4,11,NULL,'2020-02-15 22:50:45','2020-02-15 22:50:45','242c3020-4eb9-4f72-b2ac-17af03734d9f'),
	(464,452,8,4,12,NULL,'2020-02-15 22:50:45','2020-02-15 22:50:45','9e1893a5-898a-4970-9574-45c5e9c47e6d'),
	(469,468,8,3,1,NULL,'2020-02-16 00:02:30','2020-02-16 00:02:30','64fe069c-bcdd-454f-8d8e-b6cdab020889');

/*!40000 ALTER TABLE `matrixblocks` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table matrixblocktypes
# ------------------------------------------------------------

DROP TABLE IF EXISTS `matrixblocktypes`;

CREATE TABLE `matrixblocktypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `matrixblocktypes_name_fieldId_unq_idx` (`name`,`fieldId`),
  UNIQUE KEY `matrixblocktypes_handle_fieldId_unq_idx` (`handle`,`fieldId`),
  KEY `matrixblocktypes_fieldId_idx` (`fieldId`),
  KEY `matrixblocktypes_fieldLayoutId_idx` (`fieldLayoutId`),
  CONSTRAINT `matrixblocktypes_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixblocktypes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `matrixblocktypes` WRITE;
/*!40000 ALTER TABLE `matrixblocktypes` DISABLE KEYS */;

INSERT INTO `matrixblocktypes` (`id`, `fieldId`, `fieldLayoutId`, `name`, `handle`, `sortOrder`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,8,5,'Recipe Image','recipeImage',1,'2020-02-15 21:11:00','2020-02-15 21:11:00','f78bfaa9-e525-4b4a-9897-ce5058310dcc'),
	(2,8,6,'Recipe Tip','recipeTip',2,'2020-02-15 21:11:01','2020-02-15 21:11:01','2fe8849d-a3b2-4e86-abfd-a4124ea0076c'),
	(3,8,7,'Recipe Copy','recipeCopy',3,'2020-02-15 21:11:01','2020-02-15 21:11:01','51e3646e-111c-4651-ae09-9fd365b33a91'),
	(4,8,8,'Recipe Steps','recipeSteps',4,'2020-02-15 21:11:01','2020-02-15 21:11:01','0e0962e4-e4b0-4083-b63b-9906481a6e0b'),
	(5,8,9,'Recipe Ingredients','recipeIngredients',5,'2020-02-15 21:11:01','2020-02-15 21:11:01','17260a44-4415-4ac9-a021-0fb47c72adc6');

/*!40000 ALTER TABLE `matrixblocktypes` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table matrixcontent_recipecontents
# ------------------------------------------------------------

DROP TABLE IF EXISTS `matrixcontent_recipecontents`;

CREATE TABLE `matrixcontent_recipecontents` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `field_recipeImage_imageCaption` text DEFAULT NULL,
  `field_recipeTip_tipContent` text DEFAULT NULL,
  `field_recipeCopy_bodyContent` text DEFAULT NULL,
  `field_recipeSteps_stepsTitle` text DEFAULT NULL,
  `field_recipeSteps_stepsContent` text DEFAULT NULL,
  `field_recipeIngredients_ingredients` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `matrixcontent_recipecontents_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `matrixcontent_recipecontents_siteId_fk` (`siteId`),
  CONSTRAINT `matrixcontent_recipecontents_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixcontent_recipecontents_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `matrixcontent_recipecontents` WRITE;
/*!40000 ALTER TABLE `matrixcontent_recipecontents` DISABLE KEYS */;

INSERT INTO `matrixcontent_recipecontents` (`id`, `elementId`, `siteId`, `dateCreated`, `dateUpdated`, `uid`, `field_recipeImage_imageCaption`, `field_recipeTip_tipContent`, `field_recipeCopy_bodyContent`, `field_recipeSteps_stepsTitle`, `field_recipeSteps_stepsContent`, `field_recipeIngredients_ingredients`)
VALUES
	(1,44,1,'2020-02-15 21:11:45','2020-02-15 21:11:45','ec6a2a95-2492-4f28-ad02-5afed0432495',NULL,NULL,NULL,NULL,NULL,NULL),
	(2,45,1,'2020-02-15 21:11:52','2020-02-15 21:11:52','f9ace12b-08a8-409c-b7dc-7a3160d16e97',NULL,NULL,'<p>This is the initial page copy.</p>',NULL,NULL,NULL),
	(3,46,1,'2020-02-15 21:11:54','2020-02-15 21:11:54','81616a2f-7890-4f56-9382-4e439010a76e',NULL,NULL,'<p>This is the initial page copy.</p>',NULL,NULL,NULL),
	(4,47,1,'2020-02-15 21:11:54','2020-02-15 21:11:54','5c9a817d-2cf6-42e6-87d4-5f1badf079dc',NULL,NULL,NULL,NULL,NULL,NULL),
	(5,48,1,'2020-02-15 21:11:57','2020-02-15 21:11:57','a5807f7b-8e87-4e8d-9a29-dce0e59a1458',NULL,NULL,'<p>This is the initial page copy.</p>',NULL,NULL,NULL),
	(6,49,1,'2020-02-15 21:11:57','2020-02-15 21:11:57','91b17869-ffe4-4ee8-8113-a379ed4b8489',NULL,NULL,NULL,NULL,NULL,NULL),
	(7,50,1,'2020-02-15 21:12:05','2020-02-15 21:12:05','daf4726d-6266-4ecd-9907-1e3762757e6e',NULL,NULL,'<p>This is the initial page copy.</p>',NULL,NULL,NULL),
	(8,51,1,'2020-02-15 21:12:05','2020-02-15 21:12:05','7faaa9b3-18f6-4a5d-9ed1-63b8d44b61a6','The perfect espresso. Time to drink!',NULL,NULL,NULL,NULL,NULL),
	(9,52,1,'2020-02-15 21:12:07','2020-02-15 21:12:07','343dac79-cd88-483e-9237-bd83398ed14a',NULL,NULL,'<p>This is the initial page copy.</p>',NULL,NULL,NULL),
	(10,53,1,'2020-02-15 21:12:07','2020-02-15 21:12:07','27a3938d-59e2-4988-9b42-f0004e6d889d','The perfect espresso. Time to drink!',NULL,NULL,NULL,NULL,NULL),
	(11,54,1,'2020-02-15 21:12:07','2020-02-15 21:12:07','0609716e-054a-4677-9727-ac620fe5ce41',NULL,NULL,NULL,NULL,NULL,NULL),
	(12,55,1,'2020-02-15 21:12:21','2020-02-15 21:12:21','d61ff107-b56e-47c3-bb19-ef3975fbfe11',NULL,NULL,'<p>This is the initial page copy.</p>',NULL,NULL,NULL),
	(13,56,1,'2020-02-15 21:12:21','2020-02-15 21:12:21','ca57d1ea-5ba7-41af-8571-d4204a7e479e','The perfect espresso. Time to drink!',NULL,NULL,NULL,NULL,NULL),
	(14,57,1,'2020-02-15 21:12:21','2020-02-15 21:12:21','f13edbc5-11de-4250-b8b8-461fd4bab3bb',NULL,'Be careful with the water temperature! It\'s important that the water is',NULL,NULL,NULL,NULL),
	(15,58,1,'2020-02-15 21:12:27','2020-02-15 21:12:27','c5dd6c5e-b153-4bcc-8dc0-0c9cc6203a9a',NULL,NULL,'<p>This is the initial page copy.</p>',NULL,NULL,NULL),
	(16,59,1,'2020-02-15 21:12:27','2020-02-15 21:12:27','dce45e9e-3c2d-45f4-bdda-cadea6a124f6','The perfect espresso. Time to drink!',NULL,NULL,NULL,NULL,NULL),
	(17,60,1,'2020-02-15 21:12:27','2020-02-15 21:12:27','d3f86edb-ed0a-49b2-b6bc-2c3029734b34',NULL,'Be careful with the water temperature! It\'s important that the water is hot enough but not to hot.',NULL,NULL,NULL,NULL),
	(18,61,1,'2020-02-15 21:12:29','2020-02-15 21:12:29','99db4ea8-2c5a-47a4-b9b8-308c946501eb',NULL,NULL,'<p>This is the initial page copy.</p>',NULL,NULL,NULL),
	(19,62,1,'2020-02-15 21:12:29','2020-02-15 21:12:29','a3df90cb-c87c-49cf-8c0d-e4b47deadb10','The perfect espresso. Time to drink!',NULL,NULL,NULL,NULL,NULL),
	(20,63,1,'2020-02-15 21:12:29','2020-02-15 21:12:29','43ad14e9-f5a6-47a5-a435-54515f902529',NULL,'Be careful with the water temperature! It\'s important that the water is hot enough but not to hot.',NULL,NULL,NULL,NULL),
	(21,64,1,'2020-02-15 21:12:29','2020-02-15 21:12:29','27e96fb8-486b-4541-b5f3-0e8327d33165',NULL,NULL,NULL,NULL,NULL,NULL),
	(22,65,1,'2020-02-15 21:12:46','2020-02-15 21:12:46','7a6db716-d5df-4e73-8b47-e7bd26c3499f',NULL,NULL,'<p>This is the initial page copy.</p>',NULL,NULL,NULL),
	(23,66,1,'2020-02-15 21:12:46','2020-02-15 21:12:46','458eaed0-e89f-4d87-ac43-4f60d53b8d9d','The perfect espresso. Time to drink!',NULL,NULL,NULL,NULL,NULL),
	(24,67,1,'2020-02-15 21:12:46','2020-02-15 21:12:46','b98f334f-4099-4684-be8f-423bc59fd321',NULL,'Be careful with the water temperature! It\'s important that the water is hot enough but not to hot.',NULL,NULL,NULL,NULL),
	(25,68,1,'2020-02-15 21:12:46','2020-02-15 21:12:46','61ec26c0-5412-40f3-93e3-c46fa56b2be5',NULL,NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p>',NULL,NULL,NULL),
	(26,69,1,'2020-02-15 21:12:48','2020-02-15 21:12:48','2f5b6865-4118-4153-97d3-f0fb8ac5b525',NULL,NULL,'<p>This is the initial page copy.</p>',NULL,NULL,NULL),
	(27,70,1,'2020-02-15 21:12:48','2020-02-15 21:12:48','8a57b62b-f5ec-47fd-aac9-6c1874066dbe','The perfect espresso. Time to drink!',NULL,NULL,NULL,NULL,NULL),
	(28,71,1,'2020-02-15 21:12:48','2020-02-15 21:12:48','e23df088-7084-4ca7-bc70-6e0eb3e8742e',NULL,'Be careful with the water temperature! It\'s important that the water is hot enough but not to hot.',NULL,NULL,NULL,NULL),
	(29,72,1,'2020-02-15 21:12:48','2020-02-15 21:12:48','6359add9-414a-4580-8456-a63ebde76087',NULL,NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p>',NULL,NULL,NULL),
	(30,73,1,'2020-02-15 21:12:48','2020-02-15 21:12:48','a6380f0a-13bb-4dd0-bebb-4c830f5356d7',NULL,NULL,NULL,NULL,NULL,NULL),
	(31,74,1,'2020-02-15 21:12:50','2020-02-15 21:12:50','df7a3dee-a0b0-46cc-a148-e3676823cbb3',NULL,NULL,'<p>This is the initial page copy.</p>',NULL,NULL,NULL),
	(32,75,1,'2020-02-15 21:12:50','2020-02-15 21:12:50','456abcb4-e6c9-45b8-baf4-49dc404a5f74','The perfect espresso. Time to drink!',NULL,NULL,NULL,NULL,NULL),
	(33,76,1,'2020-02-15 21:12:50','2020-02-15 21:12:50','0268c054-9522-405e-9f35-bb9b77aad5f4',NULL,'Be careful with the water temperature! It\'s important that the water is hot enough but not to hot.',NULL,NULL,NULL,NULL),
	(34,77,1,'2020-02-15 21:12:50','2020-02-15 21:12:50','ec147ebd-33b9-40f5-a546-7cefd54ce51a',NULL,NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p>',NULL,NULL,NULL),
	(35,78,1,'2020-02-15 21:12:50','2020-02-15 21:12:50','32a21b08-7038-4600-8f34-5914bae9cfd2',NULL,NULL,NULL,NULL,NULL,'[{\"col1\":\"\",\"col2\":\"\"}]'),
	(36,79,1,'2020-02-15 21:12:54','2020-02-15 21:12:54','650b9621-81dc-4b89-ad0e-418bfa0cdd2b',NULL,NULL,'<p>This is the initial page copy.</p>',NULL,NULL,NULL),
	(37,80,1,'2020-02-15 21:12:54','2020-02-15 21:12:54','8b35f1c8-6e74-4384-971c-6e3a6db0b47b','The perfect espresso. Time to drink!',NULL,NULL,NULL,NULL,NULL),
	(38,81,1,'2020-02-15 21:12:54','2020-02-15 21:12:54','5dcdcbd5-212d-45d5-8047-f6b2c8029763',NULL,'Be careful with the water temperature! It\'s important that the water is hot enough but not to hot.',NULL,NULL,NULL,NULL),
	(39,82,1,'2020-02-15 21:12:54','2020-02-15 21:12:54','7cf83eb0-97f3-43e8-acee-f14ac731edcd',NULL,NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p>',NULL,NULL,NULL),
	(40,83,1,'2020-02-15 21:12:54','2020-02-15 21:12:54','b10fe554-2002-43d4-83d7-0499cd4666a4',NULL,NULL,NULL,NULL,NULL,'[{\"col1\":\"1\",\"col2\":\"\"}]'),
	(41,84,1,'2020-02-15 21:12:56','2020-02-15 21:12:56','24db0024-b2ab-478f-8f9d-232c113ceda1',NULL,NULL,'<p>This is the initial page copy.</p>',NULL,NULL,NULL),
	(42,85,1,'2020-02-15 21:12:56','2020-02-15 21:12:56','72b34a63-4639-4ebd-817c-de345fdd03be','The perfect espresso. Time to drink!',NULL,NULL,NULL,NULL,NULL),
	(43,86,1,'2020-02-15 21:12:56','2020-02-15 21:12:56','58c55f7c-bc8e-4bae-b496-197b49c14af6',NULL,'Be careful with the water temperature! It\'s important that the water is hot enough but not to hot.',NULL,NULL,NULL,NULL),
	(44,87,1,'2020-02-15 21:12:56','2020-02-15 21:12:56','e824770f-d8f4-4e83-a930-a450757443c6',NULL,NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p>',NULL,NULL,NULL),
	(45,88,1,'2020-02-15 21:12:56','2020-02-15 21:12:56','29aa864d-6b50-428f-9348-f37604de4f59',NULL,NULL,NULL,NULL,NULL,'[{\"col1\":\"\",\"col2\":\"\"}]'),
	(46,89,1,'2020-02-15 21:12:57','2020-02-15 21:12:57','db7f9cfe-894e-4428-aeda-f24be3986926',NULL,NULL,'<p>This is the initial page copy.</p>',NULL,NULL,NULL),
	(47,90,1,'2020-02-15 21:12:57','2020-02-15 21:12:57','90d03653-3afd-419f-a4c0-160906fa2136','The perfect espresso. Time to drink!',NULL,NULL,NULL,NULL,NULL),
	(48,91,1,'2020-02-15 21:12:57','2020-02-15 21:12:57','3e911b08-5d2a-49e6-a199-3092673a0c4c',NULL,'Be careful with the water temperature! It\'s important that the water is hot enough but not to hot.',NULL,NULL,NULL,NULL),
	(49,92,1,'2020-02-15 21:12:57','2020-02-15 21:12:57','9a97dd51-dcb2-42cc-b261-a69145953c1b',NULL,NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p>',NULL,NULL,NULL),
	(50,93,1,'2020-02-15 21:12:57','2020-02-15 21:12:57','26ac6b73-b96c-4e5e-b399-f8c66b9c13fb',NULL,NULL,NULL,NULL,NULL,'[{\"col1\":\"1\",\"col2\":\"\"}]'),
	(51,94,1,'2020-02-15 21:12:58','2020-02-15 21:12:58','4498602b-866b-4903-8f8e-62cbf1bee1b3',NULL,NULL,'<p>This is the initial page copy.</p>',NULL,NULL,NULL),
	(52,95,1,'2020-02-15 21:12:58','2020-02-15 21:12:58','7f949e60-3c40-4f02-9462-a7d5543d8da1','The perfect espresso. Time to drink!',NULL,NULL,NULL,NULL,NULL),
	(53,96,1,'2020-02-15 21:12:58','2020-02-15 21:12:58','8a16902f-4844-46ce-ae5d-cd5134fa1145',NULL,'Be careful with the water temperature! It\'s important that the water is hot enough but not to hot.',NULL,NULL,NULL,NULL),
	(54,97,1,'2020-02-15 21:12:58','2020-02-15 21:12:58','6bdfa783-edf0-4914-9443-ce56ce0639dc',NULL,NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p>',NULL,NULL,NULL),
	(55,98,1,'2020-02-15 21:12:58','2020-02-15 21:12:58','32bd8230-d180-488a-8199-ee0181d854f7',NULL,NULL,NULL,NULL,NULL,'[{\"col1\":\"2\",\"col2\":\"\"}]'),
	(56,99,1,'2020-02-15 21:13:00','2020-02-15 21:13:00','2668f101-701f-46fc-8ff2-b2dbaaef8940',NULL,NULL,'<p>This is the initial page copy.</p>',NULL,NULL,NULL),
	(57,100,1,'2020-02-15 21:13:00','2020-02-15 21:13:00','e4fd7c17-185c-40b6-a0e0-356e8c738514','The perfect espresso. Time to drink!',NULL,NULL,NULL,NULL,NULL),
	(58,101,1,'2020-02-15 21:13:00','2020-02-15 21:13:00','57bdd571-1d39-439f-b8ff-a2e3c35c631f',NULL,'Be careful with the water temperature! It\'s important that the water is hot enough but not to hot.',NULL,NULL,NULL,NULL),
	(59,102,1,'2020-02-15 21:13:00','2020-02-15 21:13:00','0c84588b-f7c2-4755-a830-8d8d56d4e7f2',NULL,NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p>',NULL,NULL,NULL),
	(60,103,1,'2020-02-15 21:13:00','2020-02-15 21:13:00','968cee59-95ae-499e-a016-aa70d8958847',NULL,NULL,NULL,NULL,NULL,'[{\"col1\":\"22\",\"col2\":\"\"}]'),
	(61,104,1,'2020-02-15 21:13:02','2020-02-15 21:13:02','87da2365-f8c9-4d93-88ff-b0af4f1b57e2',NULL,NULL,'<p>This is the initial page copy.</p>',NULL,NULL,NULL),
	(62,105,1,'2020-02-15 21:13:02','2020-02-15 21:13:02','4f3cd929-4156-4199-ad15-22875a2ff2e7','The perfect espresso. Time to drink!',NULL,NULL,NULL,NULL,NULL),
	(63,106,1,'2020-02-15 21:13:02','2020-02-15 21:13:02','12a16c57-44f7-4a0e-a8fb-ccdac2282951',NULL,'Be careful with the water temperature! It\'s important that the water is hot enough but not to hot.',NULL,NULL,NULL,NULL),
	(64,107,1,'2020-02-15 21:13:02','2020-02-15 21:13:02','6d07ab3c-3ceb-44c5-8f83-e6ee14bec93e',NULL,NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p>',NULL,NULL,NULL),
	(65,108,1,'2020-02-15 21:13:02','2020-02-15 21:13:02','bd5aa34a-415c-425d-a82b-a0222ebef6a4',NULL,NULL,NULL,NULL,NULL,'[{\"col1\":\"22 grams\",\"col2\":\"\"}]'),
	(66,109,1,'2020-02-15 21:13:06','2020-02-15 21:13:06','df51dd76-771f-4437-9388-0ac19e638e43',NULL,NULL,'<p>This is the initial page copy.</p>',NULL,NULL,NULL),
	(67,110,1,'2020-02-15 21:13:06','2020-02-15 21:13:06','12ad2431-22ac-4e98-af5e-9e9987d4ffda','The perfect espresso. Time to drink!',NULL,NULL,NULL,NULL,NULL),
	(68,111,1,'2020-02-15 21:13:06','2020-02-15 21:13:06','2aabf6d4-7817-4ee7-b29b-2da46dfac5aa',NULL,'Be careful with the water temperature! It\'s important that the water is hot enough but not to hot.',NULL,NULL,NULL,NULL),
	(69,112,1,'2020-02-15 21:13:06','2020-02-15 21:13:06','12ab0f01-e364-4fc9-9b11-95b6c1e5ac91',NULL,NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p>',NULL,NULL,NULL),
	(70,113,1,'2020-02-15 21:13:06','2020-02-15 21:13:06','ba9eebc6-994f-4241-876b-9f292659dff6',NULL,NULL,NULL,NULL,NULL,'[{\"col1\":\"22 grams\",\"col2\":\"Ground coffee\"}]'),
	(71,114,1,'2020-02-15 21:13:07','2020-02-15 21:13:07','fb926628-d04a-41d0-9144-d2e40902578d',NULL,NULL,'<p>This is the initial page copy.</p>',NULL,NULL,NULL),
	(72,115,1,'2020-02-15 21:13:07','2020-02-15 21:13:07','5708b125-7de7-43a5-a995-6a0ad98f5845','The perfect espresso. Time to drink!',NULL,NULL,NULL,NULL,NULL),
	(73,116,1,'2020-02-15 21:13:07','2020-02-15 21:13:07','f5ee11bf-ec59-4c9d-98b2-c0a3924af8dc',NULL,'Be careful with the water temperature! It\'s important that the water is hot enough but not to hot.',NULL,NULL,NULL,NULL),
	(74,117,1,'2020-02-15 21:13:07','2020-02-15 21:13:07','4681b738-425d-45b0-b733-28e445022382',NULL,NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p>',NULL,NULL,NULL),
	(75,118,1,'2020-02-15 21:13:07','2020-02-15 21:13:07','46e19610-d583-498d-a181-8c883f21d715',NULL,NULL,NULL,NULL,NULL,'[{\"col1\":\"22 grams\",\"col2\":\"Ground coffee\"},{\"col1\":\"\",\"col2\":\"\"}]'),
	(76,119,1,'2020-02-15 21:13:12','2020-02-15 21:13:12','f5890f6b-1e76-4dc3-8801-56a8ab7fe5f7',NULL,NULL,'<p>This is the initial page copy.</p>',NULL,NULL,NULL),
	(77,120,1,'2020-02-15 21:13:12','2020-02-15 21:13:12','0f5a4d5a-edac-4faf-b919-19a51ae6481a','The perfect espresso. Time to drink!',NULL,NULL,NULL,NULL,NULL),
	(78,121,1,'2020-02-15 21:13:12','2020-02-15 21:13:12','96141148-cfc8-49f3-87fb-d28256a03d9c',NULL,'Be careful with the water temperature! It\'s important that the water is hot enough but not to hot.',NULL,NULL,NULL,NULL),
	(79,122,1,'2020-02-15 21:13:12','2020-02-15 21:13:12','d0232789-1f50-490e-9f2b-a6f59ed9aaa6',NULL,NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p>',NULL,NULL,NULL),
	(80,123,1,'2020-02-15 21:13:12','2020-02-15 21:13:12','ead6a662-968b-4a6a-967d-359302a86666',NULL,NULL,NULL,NULL,NULL,'[{\"col1\":\"22 grams\",\"col2\":\"Ground coffee\"},{\"col1\":\"4 oz\",\"col2\":\"\"}]'),
	(81,124,1,'2020-02-15 21:13:14','2020-02-15 21:13:14','ca092516-1c51-4b22-a700-319353806720',NULL,NULL,'<p>This is the initial page copy.</p>',NULL,NULL,NULL),
	(82,125,1,'2020-02-15 21:13:14','2020-02-15 21:13:14','a2ac7dd4-eb8e-45ed-8c7f-79df3a90d342','The perfect espresso. Time to drink!',NULL,NULL,NULL,NULL,NULL),
	(83,126,1,'2020-02-15 21:13:14','2020-02-15 21:13:14','63dad7cf-d951-4b1c-b362-22ae9c0b5e9e',NULL,'Be careful with the water temperature! It\'s important that the water is hot enough but not to hot.',NULL,NULL,NULL,NULL),
	(84,127,1,'2020-02-15 21:13:14','2020-02-15 21:13:14','1802f7d4-39a2-4f89-8b51-25f17cddc719',NULL,NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p>',NULL,NULL,NULL),
	(85,128,1,'2020-02-15 21:13:14','2020-02-15 21:13:14','cebe1d59-2a6e-4f29-9acf-5246c6e44de7',NULL,NULL,NULL,NULL,NULL,'[{\"col1\":\"22 grams\",\"col2\":\"Ground coffee\"},{\"col1\":\"4 oz\",\"col2\":\"Hot water\"}]'),
	(86,129,1,'2020-02-15 21:13:14','2020-02-15 21:13:14','63218e11-b9ba-4174-95c9-bb87e7a8cda2',NULL,NULL,'<p>This is the initial page copy.</p>',NULL,NULL,NULL),
	(87,130,1,'2020-02-15 21:13:14','2020-02-15 21:13:14','3afe1aa4-908e-4800-b305-ccf5e8a2d010','The perfect espresso. Time to drink!',NULL,NULL,NULL,NULL,NULL),
	(88,131,1,'2020-02-15 21:13:14','2020-02-15 21:13:14','567b5467-fe84-4911-a09c-6ab2391d0dd7',NULL,'Be careful with the water temperature! It\'s important that the water is hot enough but not to hot.',NULL,NULL,NULL,NULL),
	(89,132,1,'2020-02-15 21:13:14','2020-02-15 21:13:14','400d88b3-2677-4c8e-a7b0-508834674307',NULL,NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p>',NULL,NULL,NULL),
	(90,133,1,'2020-02-15 21:13:14','2020-02-15 21:13:14','184dfb9f-2e6e-46f9-ab96-205565ee8fb7',NULL,NULL,NULL,NULL,NULL,'[{\"col1\":\"22 grams\",\"col2\":\"Ground coffee\"},{\"col1\":\"4 oz\",\"col2\":\"Hot water\"},{\"col1\":\"\",\"col2\":\"\"}]'),
	(91,134,1,'2020-02-15 21:13:19','2020-02-15 21:13:19','b2af669c-f32f-4603-885e-4d38bbe8a792',NULL,NULL,'<p>This is the initial page copy.</p>',NULL,NULL,NULL),
	(92,135,1,'2020-02-15 21:13:19','2020-02-15 21:13:19','7a06e498-337a-49ac-a373-6768d378bf1f','The perfect espresso. Time to drink!',NULL,NULL,NULL,NULL,NULL),
	(93,136,1,'2020-02-15 21:13:19','2020-02-15 21:13:19','00b18885-95c9-47c5-94b9-f53177d89bf9',NULL,'Be careful with the water temperature! It\'s important that the water is hot enough but not to hot.',NULL,NULL,NULL,NULL),
	(94,137,1,'2020-02-15 21:13:19','2020-02-15 21:13:19','e771ebdd-dd09-4631-ad94-d0dbaa4cff99',NULL,NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p>',NULL,NULL,NULL),
	(95,138,1,'2020-02-15 21:13:19','2020-02-15 21:13:19','5d6083c1-eb55-4d07-8461-6e6bc1f36c7e',NULL,NULL,NULL,NULL,NULL,'[{\"col1\":\"22 grams\",\"col2\":\"Ground coffee\"},{\"col1\":\"4 oz\",\"col2\":\"Hot water\"},{\"col1\":\"1\",\"col2\":\"Espresso Machine\"}]'),
	(96,139,1,'2020-02-15 21:13:22','2020-02-15 21:13:22','05bf4c02-765e-49c3-8386-407aa63598f7',NULL,NULL,'<p>This is the initial page copy.</p>',NULL,NULL,NULL),
	(97,140,1,'2020-02-15 21:13:22','2020-02-15 21:13:22','a0b60289-d092-461a-a0b5-3fe4a8954222','The perfect espresso. Time to drink!',NULL,NULL,NULL,NULL,NULL),
	(98,141,1,'2020-02-15 21:13:22','2020-02-15 21:13:22','916972cd-aa57-454a-91dc-861eebd58344',NULL,'Be careful with the water temperature! It\'s important that the water is hot enough but not to hot.',NULL,NULL,NULL,NULL),
	(99,142,1,'2020-02-15 21:13:22','2020-02-15 21:13:22','34fd6694-0d6a-4858-8bf6-afab7fac3562',NULL,NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p>',NULL,NULL,NULL),
	(100,143,1,'2020-02-15 21:13:22','2020-02-15 21:13:22','31749ea8-9ab8-4da2-aae6-e154d22ce88c',NULL,NULL,NULL,NULL,NULL,'[{\"col1\":\"22 grams\",\"col2\":\"Ground coffee\"},{\"col1\":\"4 oz\",\"col2\":\"Hot water\"},{\"col1\":\"1\",\"col2\":\"Espresso Machine\"}]'),
	(101,144,1,'2020-02-15 21:13:22','2020-02-15 21:13:22','9c730697-7790-483d-a9dc-909be421dd4a',NULL,NULL,NULL,NULL,NULL,NULL),
	(102,145,1,'2020-02-15 21:13:25','2020-02-15 21:13:25','0707f9cb-8354-4c53-9787-12fda73c0c06',NULL,NULL,'<p>This is the initial page copy.</p>',NULL,NULL,NULL),
	(103,146,1,'2020-02-15 21:13:25','2020-02-15 21:13:25','e4edfafa-38cd-49e4-8442-2b99f4cf28cd','The perfect espresso. Time to drink!',NULL,NULL,NULL,NULL,NULL),
	(104,147,1,'2020-02-15 21:13:25','2020-02-15 21:13:25','29d70786-51bd-4973-9b1e-7c016913be85',NULL,'Be careful with the water temperature! It\'s important that the water is hot enough but not to hot.',NULL,NULL,NULL,NULL),
	(105,148,1,'2020-02-15 21:13:25','2020-02-15 21:13:25','8ed3ff0f-9bb2-4cb1-8fdc-2dc690fa6f11',NULL,NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p>',NULL,NULL,NULL),
	(106,149,1,'2020-02-15 21:13:25','2020-02-15 21:13:25','bac735ec-ec3f-4b88-a1d5-a2fcfa1d7c28',NULL,NULL,NULL,NULL,NULL,'[{\"col1\":\"22 grams\",\"col2\":\"Ground coffee\"},{\"col1\":\"4 oz\",\"col2\":\"Hot water\"},{\"col1\":\"1\",\"col2\":\"Espresso Machine\"}]'),
	(107,150,1,'2020-02-15 21:13:25','2020-02-15 21:13:25','a6dbcb81-5c15-48ff-aa29-5ca6b3aad878',NULL,NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p>',NULL,NULL,NULL),
	(108,151,1,'2020-02-15 21:13:29','2020-02-15 21:13:29','6a735368-aafe-4daf-9aa2-1bcacdb7e1de',NULL,NULL,'<p>This is the initial page copy.</p>',NULL,NULL,NULL),
	(109,152,1,'2020-02-15 21:13:29','2020-02-15 21:13:29','19c037ce-a18d-4bf2-8074-7bb2c899b072','The perfect espresso. Time to drink!',NULL,NULL,NULL,NULL,NULL),
	(110,153,1,'2020-02-15 21:13:29','2020-02-15 21:13:29','074be33a-3b7b-4171-9541-b6e9214d1d13',NULL,'Be careful with the water temperature! It\'s important that the water is hot enough but not to hot.',NULL,NULL,NULL,NULL),
	(111,154,1,'2020-02-15 21:13:29','2020-02-15 21:13:29','175e1920-188f-46aa-9247-f02c50b6dbaf',NULL,NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p>',NULL,NULL,NULL),
	(112,155,1,'2020-02-15 21:13:29','2020-02-15 21:13:29','8002afa3-8f03-40a4-8312-acda3fa03c98',NULL,NULL,NULL,NULL,NULL,'[{\"col1\":\"22 grams\",\"col2\":\"Ground coffee\"},{\"col1\":\"4 oz\",\"col2\":\"Hot water\"},{\"col1\":\"1\",\"col2\":\"Espresso Machine\"}]'),
	(113,156,1,'2020-02-15 21:13:29','2020-02-15 21:13:29','3c425dac-b1c7-4106-bd17-af8280c9f128',NULL,NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p>',NULL,NULL,NULL),
	(114,157,1,'2020-02-15 21:13:29','2020-02-15 21:13:29','61c45f5b-d165-4b7e-9291-192238643ae9',NULL,NULL,NULL,NULL,NULL,NULL),
	(115,158,1,'2020-02-15 21:13:35','2020-02-15 21:13:35','2fbb59e4-e553-45fb-8cdc-8a25bddf0ed2',NULL,NULL,'<p>This is the initial page copy.</p>',NULL,NULL,NULL),
	(116,159,1,'2020-02-15 21:13:35','2020-02-15 21:13:35','c3dd83f2-67d1-4124-b97c-6d8a8038e93e','The perfect espresso. Time to drink!',NULL,NULL,NULL,NULL,NULL),
	(117,160,1,'2020-02-15 21:13:35','2020-02-15 21:13:35','7e06bf25-f26c-4015-8f11-0633badca617',NULL,'Be careful with the water temperature! It\'s important that the water is hot enough but not to hot.',NULL,NULL,NULL,NULL),
	(118,161,1,'2020-02-15 21:13:35','2020-02-15 21:13:35','385e4644-fa32-4449-916a-7029abb2675c',NULL,NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p>',NULL,NULL,NULL),
	(119,162,1,'2020-02-15 21:13:35','2020-02-15 21:13:35','0083c666-3179-4513-b9ff-75f9147af07a',NULL,NULL,NULL,NULL,NULL,'[{\"col1\":\"22 grams\",\"col2\":\"Ground coffee\"},{\"col1\":\"4 oz\",\"col2\":\"Hot water\"},{\"col1\":\"1\",\"col2\":\"Espresso Machine\"}]'),
	(120,163,1,'2020-02-15 21:13:35','2020-02-15 21:13:35','f6a87656-dd2b-462d-8290-8eba9080fc6b',NULL,NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p>',NULL,NULL,NULL),
	(121,164,1,'2020-02-15 21:13:35','2020-02-15 21:13:35','b84a34c4-6fd7-41e8-9ccb-458a3a9ef969',NULL,NULL,NULL,'Preparing Your',NULL,NULL),
	(122,165,1,'2020-02-15 21:13:37','2020-02-15 21:13:37','4c55a390-98ef-4d7e-871e-c22ffb55a75c',NULL,NULL,'<p>This is the initial page copy.</p>',NULL,NULL,NULL),
	(123,166,1,'2020-02-15 21:13:37','2020-02-15 21:13:37','ce5b377e-1e17-4d32-8127-1b1efa748177','The perfect espresso. Time to drink!',NULL,NULL,NULL,NULL,NULL),
	(124,167,1,'2020-02-15 21:13:37','2020-02-15 21:13:37','afd79817-a4f9-4792-865b-29d767afa564',NULL,'Be careful with the water temperature! It\'s important that the water is hot enough but not to hot.',NULL,NULL,NULL,NULL),
	(125,168,1,'2020-02-15 21:13:37','2020-02-15 21:13:37','73044889-3f7a-4cb0-a5a4-44832709d06c',NULL,NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p>',NULL,NULL,NULL),
	(126,169,1,'2020-02-15 21:13:37','2020-02-15 21:13:37','9dd6501c-ab80-4250-b283-f38bd4c97b79',NULL,NULL,NULL,NULL,NULL,'[{\"col1\":\"22 grams\",\"col2\":\"Ground coffee\"},{\"col1\":\"4 oz\",\"col2\":\"Hot water\"},{\"col1\":\"1\",\"col2\":\"Espresso Machine\"}]'),
	(127,170,1,'2020-02-15 21:13:37','2020-02-15 21:13:37','7f1c9ec6-90f8-42e6-a443-9f773a8fc4cd',NULL,NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p>',NULL,NULL,NULL),
	(128,171,1,'2020-02-15 21:13:37','2020-02-15 21:13:37','afb5799c-637e-48d6-9808-4bb84d83887a',NULL,NULL,NULL,'Preparing Your Workspace',NULL,NULL),
	(129,172,1,'2020-02-15 21:13:38','2020-02-15 21:13:38','03c7a848-1d99-4b96-9871-52b0a8516157',NULL,NULL,'<p>This is the initial page copy.</p>',NULL,NULL,NULL),
	(130,173,1,'2020-02-15 21:13:38','2020-02-15 21:13:38','823e2a45-d484-44ed-bb35-7b5615eefdb6','The perfect espresso. Time to drink!',NULL,NULL,NULL,NULL,NULL),
	(131,174,1,'2020-02-15 21:13:38','2020-02-15 21:13:38','ca44e049-e4cc-4ca0-87fb-6fdf5cc2c1a1',NULL,'Be careful with the water temperature! It\'s important that the water is hot enough but not to hot.',NULL,NULL,NULL,NULL),
	(132,175,1,'2020-02-15 21:13:38','2020-02-15 21:13:38','f9594feb-b605-4182-8440-fcedebbe2fea',NULL,NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p>',NULL,NULL,NULL),
	(133,176,1,'2020-02-15 21:13:38','2020-02-15 21:13:38','8f04893c-339e-474a-8188-885d4f5875f2',NULL,NULL,NULL,NULL,NULL,'[{\"col1\":\"22 grams\",\"col2\":\"Ground coffee\"},{\"col1\":\"4 oz\",\"col2\":\"Hot water\"},{\"col1\":\"1\",\"col2\":\"Espresso Machine\"}]'),
	(134,177,1,'2020-02-15 21:13:38','2020-02-15 21:13:38','06a66a73-1667-441b-b27e-0ee0dd7d5d37',NULL,NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p>',NULL,NULL,NULL),
	(135,178,1,'2020-02-15 21:13:38','2020-02-15 21:13:38','7169033b-c054-4994-9286-47ebd7011c6f',NULL,NULL,NULL,'Preparing Your Workspace','[{\"col1\":\"\"}]',NULL),
	(136,179,1,'2020-02-15 21:13:41','2020-02-15 21:13:41','7a364e92-20f7-4bb6-b645-a92a3c7b693e',NULL,NULL,'<p>This is the initial page copy.</p>',NULL,NULL,NULL),
	(137,180,1,'2020-02-15 21:13:41','2020-02-15 21:13:41','2032d323-7b82-4345-85b5-2ed932bc078a','The perfect espresso. Time to drink!',NULL,NULL,NULL,NULL,NULL),
	(138,181,1,'2020-02-15 21:13:41','2020-02-15 21:13:41','7dda6c0b-5c0c-4e78-b3bc-c701ea903477',NULL,'Be careful with the water temperature! It\'s important that the water is hot enough but not to hot.',NULL,NULL,NULL,NULL),
	(139,182,1,'2020-02-15 21:13:41','2020-02-15 21:13:41','1fb76576-c939-45cd-becf-3cdd0aa74b11',NULL,NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p>',NULL,NULL,NULL),
	(140,183,1,'2020-02-15 21:13:41','2020-02-15 21:13:41','4b0e903b-6662-42c8-85f4-d2b870c15e0f',NULL,NULL,NULL,NULL,NULL,'[{\"col1\":\"22 grams\",\"col2\":\"Ground coffee\"},{\"col1\":\"4 oz\",\"col2\":\"Hot water\"},{\"col1\":\"1\",\"col2\":\"Espresso Machine\"}]'),
	(141,184,1,'2020-02-15 21:13:41','2020-02-15 21:13:41','e8898e13-e971-4ff4-9e5f-b20c2cdc146f',NULL,NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p>',NULL,NULL,NULL),
	(142,185,1,'2020-02-15 21:13:41','2020-02-15 21:13:41','35146d94-e34b-4606-9660-e80bf3ade11f',NULL,NULL,NULL,'Preparing Your Workspace','[{\"col1\":\"Clean up the area.\"}]',NULL),
	(143,186,1,'2020-02-15 21:13:42','2020-02-15 21:13:42','d180bc80-7cb9-4080-bd44-055a2cb1b79d',NULL,NULL,'<p>This is the initial page copy.</p>',NULL,NULL,NULL),
	(144,187,1,'2020-02-15 21:13:42','2020-02-15 21:13:42','7b45da27-3546-48cb-b88a-b3ac46f352d9','The perfect espresso. Time to drink!',NULL,NULL,NULL,NULL,NULL),
	(145,188,1,'2020-02-15 21:13:42','2020-02-15 21:13:42','77e5a338-43d4-4d83-b414-90917e780c1d',NULL,'Be careful with the water temperature! It\'s important that the water is hot enough but not to hot.',NULL,NULL,NULL,NULL),
	(146,189,1,'2020-02-15 21:13:42','2020-02-15 21:13:42','8b0a7bac-cac0-40dc-9bce-c44b685bb72a',NULL,NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p>',NULL,NULL,NULL),
	(147,190,1,'2020-02-15 21:13:42','2020-02-15 21:13:42','611d3325-8693-4130-a094-595f2e913bcf',NULL,NULL,NULL,NULL,NULL,'[{\"col1\":\"22 grams\",\"col2\":\"Ground coffee\"},{\"col1\":\"4 oz\",\"col2\":\"Hot water\"},{\"col1\":\"1\",\"col2\":\"Espresso Machine\"}]'),
	(148,191,1,'2020-02-15 21:13:42','2020-02-15 21:13:42','cc410356-6008-4207-81ab-08408e740232',NULL,NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p>',NULL,NULL,NULL),
	(149,192,1,'2020-02-15 21:13:42','2020-02-15 21:13:42','cce342cf-fe21-46d5-845d-ffdca7296cc4',NULL,NULL,NULL,'Preparing Your Workspace','[{\"col1\":\"Clean up the area.\"},{\"col1\":\"\"}]',NULL),
	(150,193,1,'2020-02-15 21:13:46','2020-02-15 21:13:46','97d60bfb-fa97-4aa9-bd13-ef20552ee353',NULL,NULL,'<p>This is the initial page copy.</p>',NULL,NULL,NULL),
	(151,194,1,'2020-02-15 21:13:47','2020-02-15 21:13:47','457e4544-3d17-4312-b70d-9c56e2d3f3ca','The perfect espresso. Time to drink!',NULL,NULL,NULL,NULL,NULL),
	(152,195,1,'2020-02-15 21:13:47','2020-02-15 21:13:47','091697cc-bcd3-4031-b6e5-034b7eabf12d',NULL,'Be careful with the water temperature! It\'s important that the water is hot enough but not to hot.',NULL,NULL,NULL,NULL),
	(153,196,1,'2020-02-15 21:13:47','2020-02-15 21:13:47','fe47d636-a8ec-4d93-b853-6120529ef386',NULL,NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p>',NULL,NULL,NULL),
	(154,197,1,'2020-02-15 21:13:47','2020-02-15 21:13:47','c9a2f0c6-0d93-4703-9d10-07d4f1af5893',NULL,NULL,NULL,NULL,NULL,'[{\"col1\":\"22 grams\",\"col2\":\"Ground coffee\"},{\"col1\":\"4 oz\",\"col2\":\"Hot water\"},{\"col1\":\"1\",\"col2\":\"Espresso Machine\"}]'),
	(155,198,1,'2020-02-15 21:13:47','2020-02-15 21:13:47','6582d7c6-f5e7-41a9-a6b6-fcdd55584994',NULL,NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p>',NULL,NULL,NULL),
	(156,199,1,'2020-02-15 21:13:47','2020-02-15 21:13:47','dd604862-723e-4199-b060-d97e963905fb',NULL,NULL,NULL,'Preparing Your Workspace','[{\"col1\":\"Clean up the area.\"},{\"col1\":\"Turn on \"}]',NULL),
	(157,200,1,'2020-02-15 21:13:49','2020-02-15 21:13:49','584b2a2a-91c4-474b-b90f-69ebabb48818',NULL,NULL,'<p>This is the initial page copy.</p>',NULL,NULL,NULL),
	(158,201,1,'2020-02-15 21:13:49','2020-02-15 21:13:49','218e5441-1231-42c9-b136-1d190aa01217','The perfect espresso. Time to drink!',NULL,NULL,NULL,NULL,NULL),
	(159,202,1,'2020-02-15 21:13:49','2020-02-15 21:13:49','f6b0174f-9c42-4b18-af08-35d0ead28b63',NULL,'Be careful with the water temperature! It\'s important that the water is hot enough but not to hot.',NULL,NULL,NULL,NULL),
	(160,203,1,'2020-02-15 21:13:49','2020-02-15 21:13:49','b482b62f-2f44-4a77-8cc0-06ae556539f6',NULL,NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p>',NULL,NULL,NULL),
	(161,204,1,'2020-02-15 21:13:49','2020-02-15 21:13:49','b9fe142d-2af0-4f6a-b7c2-28179581f512',NULL,NULL,NULL,NULL,NULL,'[{\"col1\":\"22 grams\",\"col2\":\"Ground coffee\"},{\"col1\":\"4 oz\",\"col2\":\"Hot water\"},{\"col1\":\"1\",\"col2\":\"Espresso Machine\"}]'),
	(162,205,1,'2020-02-15 21:13:49','2020-02-15 21:13:49','d5df483f-69cc-4473-8221-d87c8c3c409f',NULL,NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p>',NULL,NULL,NULL),
	(163,206,1,'2020-02-15 21:13:49','2020-02-15 21:13:49','84ba53ed-a0f6-46cc-9b90-4ca3eef51748',NULL,NULL,NULL,'Preparing Your Workspace','[{\"col1\":\"Clean up the area.\"},{\"col1\":\"Turn on espresso machine.\"}]',NULL),
	(164,207,1,'2020-02-15 21:13:51','2020-02-15 21:13:51','11ab07f6-4c7b-4038-991d-e517925e78d1',NULL,NULL,'<p>This is the initial page copy.</p>',NULL,NULL,NULL),
	(165,208,1,'2020-02-15 21:13:51','2020-02-15 21:13:51','d654317a-98c8-4f00-b0ed-3618f90d793d','The perfect espresso. Time to drink!',NULL,NULL,NULL,NULL,NULL),
	(166,209,1,'2020-02-15 21:13:52','2020-02-15 21:13:52','ee5c2b48-da5f-4fab-a042-baba079ceede',NULL,'Be careful with the water temperature! It\'s important that the water is hot enough but not to hot.',NULL,NULL,NULL,NULL),
	(167,210,1,'2020-02-15 21:13:52','2020-02-15 21:13:52','86e252d3-67ac-40fb-863e-7784de3ee5c2',NULL,NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p>',NULL,NULL,NULL),
	(168,211,1,'2020-02-15 21:13:52','2020-02-15 21:13:52','9db34c33-72c7-4d2d-8b83-924743a3d856',NULL,NULL,NULL,NULL,NULL,'[{\"col1\":\"22 grams\",\"col2\":\"Ground coffee\"},{\"col1\":\"4 oz\",\"col2\":\"Hot water\"},{\"col1\":\"1\",\"col2\":\"Espresso Machine\"}]'),
	(169,212,1,'2020-02-15 21:13:52','2020-02-15 21:13:52','972f6169-257a-4bea-956c-8d9fca3df859',NULL,NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p>',NULL,NULL,NULL),
	(170,213,1,'2020-02-15 21:13:52','2020-02-15 21:13:52','db29150a-98f1-4756-a71a-199b68f57c1c',NULL,NULL,NULL,'Preparing Your Workspace','[{\"col1\":\"Clean up the area.\"},{\"col1\":\"Turn on espresso machine.\"}]',NULL),
	(171,214,1,'2020-02-15 21:13:52','2020-02-15 21:13:52','e4d545d1-0b3e-4606-8f60-66b1d573ac1c',NULL,NULL,NULL,NULL,NULL,NULL),
	(172,215,1,'2020-02-15 21:13:55','2020-02-15 21:13:55','92f94967-079e-49c5-aa2a-7cff4231d3ae',NULL,NULL,'<p>This is the initial page copy.</p>',NULL,NULL,NULL),
	(173,216,1,'2020-02-15 21:13:55','2020-02-15 21:13:55','2a76400e-9e01-48ad-9be0-4bb33737a956','The perfect espresso. Time to drink!',NULL,NULL,NULL,NULL,NULL),
	(174,217,1,'2020-02-15 21:13:55','2020-02-15 21:13:55','594feda2-6a1e-4134-a8e8-83c0872dc9c7',NULL,'Be careful with the water temperature! It\'s important that the water is hot enough but not to hot.',NULL,NULL,NULL,NULL),
	(175,218,1,'2020-02-15 21:13:55','2020-02-15 21:13:55','a7010220-af34-48b2-85a7-81bdfa7b4f12',NULL,NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p>',NULL,NULL,NULL),
	(176,219,1,'2020-02-15 21:13:55','2020-02-15 21:13:55','2dde651a-3d50-412c-8fe2-f573f0e063d0',NULL,NULL,NULL,NULL,NULL,'[{\"col1\":\"22 grams\",\"col2\":\"Ground coffee\"},{\"col1\":\"4 oz\",\"col2\":\"Hot water\"},{\"col1\":\"1\",\"col2\":\"Espresso Machine\"}]'),
	(177,220,1,'2020-02-15 21:13:55','2020-02-15 21:13:55','16f076e0-63bc-435c-9d05-3c0f439f76b5',NULL,NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p>',NULL,NULL,NULL),
	(178,221,1,'2020-02-15 21:13:55','2020-02-15 21:13:55','65876468-4872-48e1-8da8-8b622dff5853',NULL,NULL,NULL,'Preparing Your Workspace','[{\"col1\":\"Clean up the area.\"},{\"col1\":\"Turn on espresso machine.\"}]',NULL),
	(179,222,1,'2020-02-15 21:13:55','2020-02-15 21:13:55','294a5715-d5d9-4761-bca8-acd2e46567b6',NULL,NULL,NULL,NULL,NULL,NULL),
	(180,223,1,'2020-02-15 21:13:59','2020-02-15 21:13:59','a685ce35-34f7-498a-82cd-46b415838a9c',NULL,NULL,'<p>This is the initial page copy.</p>',NULL,NULL,NULL),
	(181,224,1,'2020-02-15 21:13:59','2020-02-15 21:13:59','939e4987-e189-4ab4-98b3-a1eda4d968f9','The perfect espresso. Time to drink!',NULL,NULL,NULL,NULL,NULL),
	(182,225,1,'2020-02-15 21:13:59','2020-02-15 21:13:59','d41c174a-eb34-4799-9b3a-4808eec374e3',NULL,'Be careful with the water temperature! It\'s important that the water is hot enough but not to hot.',NULL,NULL,NULL,NULL),
	(183,226,1,'2020-02-15 21:13:59','2020-02-15 21:13:59','6e1c7f89-c903-483a-b6e0-77e5224852c8',NULL,NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p>',NULL,NULL,NULL),
	(184,227,1,'2020-02-15 21:13:59','2020-02-15 21:13:59','77e5c6fd-fa05-4f12-900c-4ab9cca12190',NULL,NULL,NULL,NULL,NULL,'[{\"col1\":\"22 grams\",\"col2\":\"Ground coffee\"},{\"col1\":\"4 oz\",\"col2\":\"Hot water\"},{\"col1\":\"1\",\"col2\":\"Espresso Machine\"}]'),
	(185,228,1,'2020-02-15 21:13:59','2020-02-15 21:13:59','940b704b-f0f1-4979-b60a-26303b734de9',NULL,NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p>',NULL,NULL,NULL),
	(186,229,1,'2020-02-15 21:13:59','2020-02-15 21:13:59','de3f7009-9d31-497a-8c1a-65bcdf4f58f8',NULL,NULL,NULL,'Preparing Your Workspace','[{\"col1\":\"Clean up the area.\"},{\"col1\":\"Turn on espresso machine.\"}]',NULL),
	(187,230,1,'2020-02-15 21:13:59','2020-02-15 21:13:59','a41565ad-2576-4fd8-82c3-6d4a228532cf','Another',NULL,NULL,NULL,NULL,NULL),
	(188,231,1,'2020-02-15 21:14:00','2020-02-15 21:14:00','f3fb0716-4807-4616-93c0-1394df399337',NULL,NULL,'<p>This is the initial page copy.</p>',NULL,NULL,NULL),
	(189,232,1,'2020-02-15 21:14:00','2020-02-15 21:14:00','cc12bd7b-2947-400d-8822-8a7ef83a8cbb','The perfect espresso. Time to drink!',NULL,NULL,NULL,NULL,NULL),
	(190,233,1,'2020-02-15 21:14:00','2020-02-15 21:14:00','fb1d1be0-8a9a-495f-ab98-9efe933639d4',NULL,'Be careful with the water temperature! It\'s important that the water is hot enough but not to hot.',NULL,NULL,NULL,NULL),
	(191,234,1,'2020-02-15 21:14:00','2020-02-15 21:14:00','852bac05-09ae-42a9-8f8c-6965473b89f4',NULL,NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p>',NULL,NULL,NULL),
	(192,235,1,'2020-02-15 21:14:00','2020-02-15 21:14:00','92bf0dea-74e3-4ce4-82a4-0a1fcfea5d37',NULL,NULL,NULL,NULL,NULL,'[{\"col1\":\"22 grams\",\"col2\":\"Ground coffee\"},{\"col1\":\"4 oz\",\"col2\":\"Hot water\"},{\"col1\":\"1\",\"col2\":\"Espresso Machine\"}]'),
	(193,236,1,'2020-02-15 21:14:00','2020-02-15 21:14:00','4731798c-9471-413b-ba57-6f58f836fb4c',NULL,NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p>',NULL,NULL,NULL),
	(194,237,1,'2020-02-15 21:14:00','2020-02-15 21:14:00','f29af7be-3a40-4abf-932e-efaf6501f011',NULL,NULL,NULL,'Preparing Your Workspace','[{\"col1\":\"Clean up the area.\"},{\"col1\":\"Turn on espresso machine.\"}]',NULL),
	(195,238,1,'2020-02-15 21:14:00','2020-02-15 21:14:00','ca9f81f5-ec1f-4ac7-bad5-3515ae597463','Another of the same.',NULL,NULL,NULL,NULL,NULL),
	(196,239,1,'2020-02-15 21:14:02','2020-02-15 21:14:02','0fcbdc5f-dd4b-4d6c-91c9-dbf992f19219',NULL,NULL,'<p>This is the initial page copy.</p>',NULL,NULL,NULL),
	(197,240,1,'2020-02-15 21:14:02','2020-02-15 21:14:02','5091a765-62d8-4c31-914b-dd31dfea9b6c','The perfect espresso. Time to drink!',NULL,NULL,NULL,NULL,NULL),
	(198,241,1,'2020-02-15 21:14:02','2020-02-15 21:14:02','c217b509-f3ec-4236-b225-3cb43d85719a',NULL,'Be careful with the water temperature! It\'s important that the water is hot enough but not to hot.',NULL,NULL,NULL,NULL),
	(199,242,1,'2020-02-15 21:14:02','2020-02-15 21:14:02','f6c2b3e6-0022-4caa-bd8b-d886b9ad2f6a',NULL,NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p>',NULL,NULL,NULL),
	(200,243,1,'2020-02-15 21:14:02','2020-02-15 21:14:02','9c8cbe3d-8b37-4ac9-94fe-ec5a1c3d003b',NULL,NULL,NULL,NULL,NULL,'[{\"col1\":\"22 grams\",\"col2\":\"Ground coffee\"},{\"col1\":\"4 oz\",\"col2\":\"Hot water\"},{\"col1\":\"1\",\"col2\":\"Espresso Machine\"}]'),
	(201,244,1,'2020-02-15 21:14:02','2020-02-15 21:14:02','9b592d71-ae16-4759-b1b7-1bdcb4882f91',NULL,NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p>',NULL,NULL,NULL),
	(202,245,1,'2020-02-15 21:14:02','2020-02-15 21:14:02','2f615f1c-1125-422d-b56f-edea21794fc8',NULL,NULL,NULL,'Preparing Your Workspace','[{\"col1\":\"Clean up the area.\"},{\"col1\":\"Turn on espresso machine.\"}]',NULL),
	(203,246,1,'2020-02-15 21:14:02','2020-02-15 21:14:02','6a354c3d-4a40-40c6-a962-9d23c4b04f5a','Another of the same.',NULL,NULL,NULL,NULL,NULL),
	(204,247,1,'2020-02-15 21:14:02','2020-02-15 21:14:02','caa5881d-0666-456f-84f9-51d63bd9f290',NULL,NULL,NULL,NULL,NULL,NULL),
	(205,248,1,'2020-02-15 21:14:10','2020-02-15 21:14:10','ca85cf74-e4da-48d8-9760-746c0c3724d8',NULL,NULL,'<p>This is the initial page copy.</p>',NULL,NULL,NULL),
	(206,249,1,'2020-02-15 21:14:11','2020-02-15 21:14:11','2df60fee-0960-42d8-8693-22e653259582','The perfect espresso. Time to drink!',NULL,NULL,NULL,NULL,NULL),
	(207,250,1,'2020-02-15 21:14:11','2020-02-15 21:14:11','3a31b831-6727-4590-8838-57f6cb0fc0d5',NULL,'Be careful with the water temperature! It\'s important that the water is hot enough but not to hot.',NULL,NULL,NULL,NULL),
	(208,251,1,'2020-02-15 21:14:11','2020-02-15 21:14:11','26bf007e-3c19-4de4-81a9-95f5d2433087',NULL,NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p>',NULL,NULL,NULL),
	(209,252,1,'2020-02-15 21:14:11','2020-02-15 21:14:11','e61f753c-7162-423d-a80e-a4d7d66fffc6',NULL,NULL,NULL,NULL,NULL,'[{\"col1\":\"22 grams\",\"col2\":\"Ground coffee\"},{\"col1\":\"4 oz\",\"col2\":\"Hot water\"},{\"col1\":\"1\",\"col2\":\"Espresso Machine\"}]'),
	(210,253,1,'2020-02-15 21:14:11','2020-02-15 21:14:11','e96fe1d5-c211-431f-8c64-c8276b29abe7',NULL,NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p>',NULL,NULL,NULL),
	(211,254,1,'2020-02-15 21:14:11','2020-02-15 21:14:11','1506c51c-7468-4fa7-a251-e8cfd48480fd',NULL,NULL,NULL,'Preparing Your Workspace','[{\"col1\":\"Clean up the area.\"},{\"col1\":\"Turn on espresso machine.\"}]',NULL),
	(212,255,1,'2020-02-15 21:14:11','2020-02-15 21:14:11','30e83412-0c3c-4ae2-a6e4-935f864efeb3','Another of the same.',NULL,NULL,NULL,NULL,NULL),
	(213,256,1,'2020-02-15 21:14:11','2020-02-15 21:14:11','dfba2683-a1ae-45a2-b8d8-0b15634d88f0',NULL,NULL,NULL,'Grinding the Cofee',NULL,NULL),
	(214,257,1,'2020-02-15 21:14:12','2020-02-15 21:14:12','d1e164a9-bb38-4f83-89fe-5a7691e95101',NULL,NULL,'<p>This is the initial page copy.</p>',NULL,NULL,NULL),
	(215,258,1,'2020-02-15 21:14:12','2020-02-15 21:14:12','69abccf8-d406-48f2-bbf1-2e77c97bf6b5','The perfect espresso. Time to drink!',NULL,NULL,NULL,NULL,NULL),
	(216,259,1,'2020-02-15 21:14:12','2020-02-15 21:14:12','fef92378-56c8-4672-a37a-a16c86fcbd7d',NULL,'Be careful with the water temperature! It\'s important that the water is hot enough but not to hot.',NULL,NULL,NULL,NULL),
	(217,260,1,'2020-02-15 21:14:12','2020-02-15 21:14:12','a8cc4a6e-3848-4905-80ef-79a4a7252d04',NULL,NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p>',NULL,NULL,NULL),
	(218,261,1,'2020-02-15 21:14:12','2020-02-15 21:14:12','d9df174e-843b-41c0-ac88-a8d0920aaf67',NULL,NULL,NULL,NULL,NULL,'[{\"col1\":\"22 grams\",\"col2\":\"Ground coffee\"},{\"col1\":\"4 oz\",\"col2\":\"Hot water\"},{\"col1\":\"1\",\"col2\":\"Espresso Machine\"}]'),
	(219,262,1,'2020-02-15 21:14:12','2020-02-15 21:14:12','32b63483-3193-441b-be57-350c8b8bbff7',NULL,NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p>',NULL,NULL,NULL),
	(220,263,1,'2020-02-15 21:14:12','2020-02-15 21:14:12','2489bb78-3719-4004-8bdc-205727850fab',NULL,NULL,NULL,'Preparing Your Workspace','[{\"col1\":\"Clean up the area.\"},{\"col1\":\"Turn on espresso machine.\"}]',NULL),
	(221,264,1,'2020-02-15 21:14:12','2020-02-15 21:14:12','6faf7933-8297-4e6f-a498-91f15988b95a','Another of the same.',NULL,NULL,NULL,NULL,NULL),
	(222,265,1,'2020-02-15 21:14:12','2020-02-15 21:14:12','a981d68e-6f0a-4cf8-8c3b-307fedd8da0f',NULL,NULL,NULL,'Grinding the Coffee',NULL,NULL),
	(223,266,1,'2020-02-15 21:14:12','2020-02-15 21:14:12','bc7108ce-1283-46af-8f5c-23835703cc6b',NULL,NULL,'<p>This is the initial page copy.</p>',NULL,NULL,NULL),
	(224,267,1,'2020-02-15 21:14:12','2020-02-15 21:14:12','dace1ab8-14f1-4c84-ae24-e2cb55ec4ee5','The perfect espresso. Time to drink!',NULL,NULL,NULL,NULL,NULL),
	(225,268,1,'2020-02-15 21:14:12','2020-02-15 21:14:12','d0a55b95-1c70-4d1e-aca8-5dcdead0bc4d',NULL,'Be careful with the water temperature! It\'s important that the water is hot enough but not to hot.',NULL,NULL,NULL,NULL),
	(226,269,1,'2020-02-15 21:14:13','2020-02-15 21:14:13','1be2fe2e-e7fe-4b40-b473-edd847c1b762',NULL,NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p>',NULL,NULL,NULL),
	(227,270,1,'2020-02-15 21:14:13','2020-02-15 21:14:13','a92b6a15-a3fd-4b9b-958a-4894e7f3703a',NULL,NULL,NULL,NULL,NULL,'[{\"col1\":\"22 grams\",\"col2\":\"Ground coffee\"},{\"col1\":\"4 oz\",\"col2\":\"Hot water\"},{\"col1\":\"1\",\"col2\":\"Espresso Machine\"}]'),
	(228,271,1,'2020-02-15 21:14:13','2020-02-15 21:14:13','da114260-8664-4e4f-854c-028144567b2b',NULL,NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p>',NULL,NULL,NULL),
	(229,272,1,'2020-02-15 21:14:13','2020-02-15 21:14:13','d9c80411-3480-4392-8264-9a865f4fb081',NULL,NULL,NULL,'Preparing Your Workspace','[{\"col1\":\"Clean up the area.\"},{\"col1\":\"Turn on espresso machine.\"}]',NULL),
	(230,273,1,'2020-02-15 21:14:13','2020-02-15 21:14:13','9a057812-d77a-4cb5-ac11-2e5a232f9171','Another of the same.',NULL,NULL,NULL,NULL,NULL),
	(231,274,1,'2020-02-15 21:14:13','2020-02-15 21:14:13','64044349-f563-4ca9-b4cf-c9a57acb8c45',NULL,NULL,NULL,'Grinding the Coffee','[{\"col1\":\"\"}]',NULL),
	(232,275,1,'2020-02-15 21:14:18','2020-02-15 21:14:18','445792a2-2fc5-4d04-83e0-3275d62db48c',NULL,NULL,'<p>This is the initial page copy.</p>',NULL,NULL,NULL),
	(233,276,1,'2020-02-15 21:14:18','2020-02-15 21:14:18','d19c2cb5-d0ef-40b4-8404-8b14859ee507','The perfect espresso. Time to drink!',NULL,NULL,NULL,NULL,NULL),
	(234,277,1,'2020-02-15 21:14:18','2020-02-15 21:14:18','17e76c13-09f8-444a-9e9a-dc0c0d9c0711',NULL,'Be careful with the water temperature! It\'s important that the water is hot enough but not to hot.',NULL,NULL,NULL,NULL),
	(235,278,1,'2020-02-15 21:14:18','2020-02-15 21:14:18','fd293256-b531-4794-9363-ede870b5c133',NULL,NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p>',NULL,NULL,NULL),
	(236,279,1,'2020-02-15 21:14:18','2020-02-15 21:14:18','e97eca87-e2db-46a6-afd0-ef9177ded595',NULL,NULL,NULL,NULL,NULL,'[{\"col1\":\"22 grams\",\"col2\":\"Ground coffee\"},{\"col1\":\"4 oz\",\"col2\":\"Hot water\"},{\"col1\":\"1\",\"col2\":\"Espresso Machine\"}]'),
	(237,280,1,'2020-02-15 21:14:18','2020-02-15 21:14:18','673fb35c-cd3e-4e39-86ea-0ed3d1682e55',NULL,NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p>',NULL,NULL,NULL),
	(238,281,1,'2020-02-15 21:14:18','2020-02-15 21:14:18','16bd72ff-ee11-4ccf-b92e-ffe1ff80b0e0',NULL,NULL,NULL,'Preparing Your Workspace','[{\"col1\":\"Clean up the area.\"},{\"col1\":\"Turn on espresso machine.\"}]',NULL),
	(239,282,1,'2020-02-15 21:14:18','2020-02-15 21:14:18','5cb464b5-2558-4fda-a83b-dc9bad76fa7d','Another of the same.',NULL,NULL,NULL,NULL,NULL),
	(240,283,1,'2020-02-15 21:14:18','2020-02-15 21:14:18','d7ce8cff-0365-4dd1-951c-a04c49fc0a27',NULL,NULL,NULL,'Grinding the Coffee','[{\"col1\":\"Instruction 1\"}]',NULL),
	(241,284,1,'2020-02-15 21:14:19','2020-02-15 21:14:19','8d099c5c-a317-4d09-9a8f-273eb5ae6e3a',NULL,NULL,'<p>This is the initial page copy.</p>',NULL,NULL,NULL),
	(242,285,1,'2020-02-15 21:14:19','2020-02-15 21:14:19','ed5f4999-1ce2-43f7-b113-ad0c3ad9ed55','The perfect espresso. Time to drink!',NULL,NULL,NULL,NULL,NULL),
	(243,286,1,'2020-02-15 21:14:19','2020-02-15 21:14:19','2190d980-98eb-4c2c-92ad-415c7152046e',NULL,'Be careful with the water temperature! It\'s important that the water is hot enough but not to hot.',NULL,NULL,NULL,NULL),
	(244,287,1,'2020-02-15 21:14:19','2020-02-15 21:14:19','0e2a1446-3a3c-4f16-9408-2a855e4b18a7',NULL,NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p>',NULL,NULL,NULL),
	(245,288,1,'2020-02-15 21:14:19','2020-02-15 21:14:19','83447686-9445-41f8-bcd6-bb3d27fcd4d3',NULL,NULL,NULL,NULL,NULL,'[{\"col1\":\"22 grams\",\"col2\":\"Ground coffee\"},{\"col1\":\"4 oz\",\"col2\":\"Hot water\"},{\"col1\":\"1\",\"col2\":\"Espresso Machine\"}]'),
	(246,289,1,'2020-02-15 21:14:19','2020-02-15 21:14:19','54ef65cf-aeaf-4daf-af79-8ec9cf6e38ff',NULL,NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p>',NULL,NULL,NULL),
	(247,290,1,'2020-02-15 21:14:19','2020-02-15 21:14:19','5d86066b-be86-4e72-a07e-7b6ac0a16baf',NULL,NULL,NULL,'Preparing Your Workspace','[{\"col1\":\"Clean up the area.\"},{\"col1\":\"Turn on espresso machine.\"}]',NULL),
	(248,291,1,'2020-02-15 21:14:19','2020-02-15 21:14:19','8d19720e-0110-4e97-a583-55aaa33a553d','Another of the same.',NULL,NULL,NULL,NULL,NULL),
	(249,292,1,'2020-02-15 21:14:19','2020-02-15 21:14:19','bc2c9ad7-a392-4ea1-9d78-59e1e749b126',NULL,NULL,NULL,'Grinding the Coffee','[{\"col1\":\"Instruction 1\"},{\"col1\":\"\"}]',NULL),
	(250,293,1,'2020-02-15 21:14:22','2020-02-15 21:14:22','9637b13f-5aa7-4147-a2fe-7da10280b77c',NULL,NULL,'<p>This is the initial page copy.</p>',NULL,NULL,NULL),
	(251,294,1,'2020-02-15 21:14:22','2020-02-15 21:14:22','0742f242-3534-4763-a540-26614bae0db8','The perfect espresso. Time to drink!',NULL,NULL,NULL,NULL,NULL),
	(252,295,1,'2020-02-15 21:14:22','2020-02-15 21:14:22','600faa05-2dea-42bb-92ef-63d247b2e31a',NULL,'Be careful with the water temperature! It\'s important that the water is hot enough but not to hot.',NULL,NULL,NULL,NULL),
	(253,296,1,'2020-02-15 21:14:22','2020-02-15 21:14:22','b7eaaed2-b6d2-4c1e-bd63-0aabc393de29',NULL,NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p>',NULL,NULL,NULL),
	(254,297,1,'2020-02-15 21:14:22','2020-02-15 21:14:22','1b7d3bde-237a-4b9b-922d-666ebe87078c',NULL,NULL,NULL,NULL,NULL,'[{\"col1\":\"22 grams\",\"col2\":\"Ground coffee\"},{\"col1\":\"4 oz\",\"col2\":\"Hot water\"},{\"col1\":\"1\",\"col2\":\"Espresso Machine\"}]'),
	(255,298,1,'2020-02-15 21:14:22','2020-02-15 21:14:22','de110d8f-4842-4921-a145-92a8237f659d',NULL,NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p>',NULL,NULL,NULL),
	(256,299,1,'2020-02-15 21:14:22','2020-02-15 21:14:22','e39add36-6827-4855-af52-ad84c5320eb8',NULL,NULL,NULL,'Preparing Your Workspace','[{\"col1\":\"Clean up the area.\"},{\"col1\":\"Turn on espresso machine.\"}]',NULL),
	(257,300,1,'2020-02-15 21:14:22','2020-02-15 21:14:22','cf9b490f-4a2e-496c-b362-66b1fc0bc5e8','Another of the same.',NULL,NULL,NULL,NULL,NULL),
	(258,301,1,'2020-02-15 21:14:23','2020-02-15 21:14:23','2003b491-a375-406b-a39b-aa1423ff7a3a',NULL,NULL,NULL,'Grinding the Coffee','[{\"col1\":\"Instruction 1\"},{\"col1\":\"Instruction 2\"}]',NULL),
	(259,302,1,'2020-02-15 21:14:28','2020-02-15 21:14:28','700c40e2-fc6f-4c64-93bb-c696a36c0164',NULL,NULL,'<p>This is the initial page copy.</p>',NULL,NULL,NULL),
	(260,303,1,'2020-02-15 21:14:28','2020-02-15 21:14:28','21d424c2-69a4-444a-91c9-b5af7449e279','The perfect espresso. Time to drink!',NULL,NULL,NULL,NULL,NULL),
	(261,304,1,'2020-02-15 21:14:28','2020-02-15 21:14:28','23556f9d-b16d-46e3-90f1-3fe607d30528',NULL,'Be careful with the water temperature! It\'s important that the water is hot enough but not to hot.',NULL,NULL,NULL,NULL),
	(262,305,1,'2020-02-15 21:14:28','2020-02-15 21:14:28','397a5baa-d582-4ffd-a828-6ba052100320',NULL,NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p>',NULL,NULL,NULL),
	(263,306,1,'2020-02-15 21:14:28','2020-02-15 21:14:28','62a84faf-def1-408a-9bed-5394a4b3eb3a',NULL,NULL,NULL,NULL,NULL,'[{\"col1\":\"22 grams\",\"col2\":\"Ground coffee\"},{\"col1\":\"4 oz\",\"col2\":\"Hot water\"},{\"col1\":\"1\",\"col2\":\"Espresso Machine\"}]'),
	(264,307,1,'2020-02-15 21:14:28','2020-02-15 21:14:28','a737f321-ee80-4ced-aad9-817d1a52e85a',NULL,NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p>',NULL,NULL,NULL),
	(265,308,1,'2020-02-15 21:14:28','2020-02-15 21:14:28','9e760e20-2a03-4289-8c4b-9752529b26fc',NULL,NULL,NULL,'Preparing Your Workspace','[{\"col1\":\"Clean up the area.\"},{\"col1\":\"Turn on espresso machine.\"}]',NULL),
	(266,309,1,'2020-02-15 21:14:28','2020-02-15 21:14:28','6df211fe-24d4-48d3-87f5-b3fd279f847b',NULL,NULL,NULL,'Grinding the Coffee','[{\"col1\":\"Instruction 1\"},{\"col1\":\"Instruction 2\"}]',NULL),
	(267,310,1,'2020-02-15 21:14:28','2020-02-15 21:14:28','b8ad9cf2-121c-45fc-a5c6-1ceee4b5ce64','Another of the same.',NULL,NULL,NULL,NULL,NULL),
	(268,311,1,'2020-02-15 21:14:35','2020-02-15 21:14:35','ac61459c-c6ca-46be-8ef6-447b8ceb1f62',NULL,NULL,'<p>This is the initial page copy.</p>',NULL,NULL,NULL),
	(269,312,1,'2020-02-15 21:14:35','2020-02-15 21:14:35','237eb2df-b4aa-450f-b7ac-3904ba381c48','The perfect espresso. Time to drink!',NULL,NULL,NULL,NULL,NULL),
	(270,313,1,'2020-02-15 21:14:35','2020-02-15 21:14:35','c9a5741c-0387-4adf-919f-982637f66a75',NULL,'Be careful with the water temperature! It\'s important that the water is hot enough but not to hot.',NULL,NULL,NULL,NULL),
	(271,314,1,'2020-02-15 21:14:35','2020-02-15 21:14:35','956224e8-b4ab-4033-b794-4dfdfee07bc3',NULL,NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p>',NULL,NULL,NULL),
	(272,315,1,'2020-02-15 21:14:35','2020-02-15 21:14:35','bcd0bafb-6674-48c4-a483-c7e263c64ea9',NULL,NULL,NULL,NULL,NULL,'[{\"col1\":\"22 grams\",\"col2\":\"Ground coffee\"},{\"col1\":\"4 oz\",\"col2\":\"Hot water\"},{\"col1\":\"1\",\"col2\":\"Espresso Machine\"}]'),
	(273,316,1,'2020-02-15 21:14:35','2020-02-15 21:14:35','d8b5840a-3086-4cf0-926e-6d0c5b677d74',NULL,NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p>',NULL,NULL,NULL),
	(274,317,1,'2020-02-15 21:14:35','2020-02-15 21:14:35','23b074f6-5587-4986-9759-92762443a02f',NULL,NULL,NULL,'Preparing Your Workspace','[{\"col1\":\"Clean up the area.\"},{\"col1\":\"Turn on espresso machine.\"}]',NULL),
	(275,318,1,'2020-02-15 21:14:35','2020-02-15 21:14:35','8b8c85b3-013b-4f17-9a23-21cf1dc3bb89',NULL,NULL,NULL,NULL,NULL,NULL),
	(276,319,1,'2020-02-15 21:14:35','2020-02-15 21:14:35','e596fa88-f08e-476c-969e-8ea9109a773f',NULL,NULL,NULL,'Grinding the Coffee','[{\"col1\":\"Instruction 1\"},{\"col1\":\"Instruction 2\"}]',NULL),
	(277,320,1,'2020-02-15 21:14:35','2020-02-15 21:14:35','a8d65ee2-615a-48f6-9d06-87d10277caf4','Another of the same.',NULL,NULL,NULL,NULL,NULL),
	(278,321,1,'2020-02-15 21:14:42','2020-02-15 21:14:42','87adfcdd-193b-4e76-9202-99185deb6ed7',NULL,NULL,'<p>This is the initial page copy.</p>',NULL,NULL,NULL),
	(279,322,1,'2020-02-15 21:14:42','2020-02-15 21:14:42','d153ccbd-4348-4038-b4ed-5a092b7c424f','The perfect espresso. Time to drink!',NULL,NULL,NULL,NULL,NULL),
	(280,323,1,'2020-02-15 21:14:42','2020-02-15 21:14:42','e13b512f-0a6f-4cd3-b9ce-38c831fac8b1',NULL,'Be careful with the water temperature! It\'s important that the water is hot enough but not to hot.',NULL,NULL,NULL,NULL),
	(281,324,1,'2020-02-15 21:14:42','2020-02-15 21:14:42','efaa16ea-8e21-4eca-a16c-03356f9f81c4',NULL,NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p>',NULL,NULL,NULL),
	(282,325,1,'2020-02-15 21:14:42','2020-02-15 21:14:42','5ed1ee2e-d026-4439-b15e-51afc534c499',NULL,NULL,NULL,NULL,NULL,'[{\"col1\":\"22 grams\",\"col2\":\"Ground coffee\"},{\"col1\":\"4 oz\",\"col2\":\"Hot water\"},{\"col1\":\"1\",\"col2\":\"Espresso Machine\"}]'),
	(283,326,1,'2020-02-15 21:14:42','2020-02-15 21:14:42','fcb37884-3f1a-4aa0-a9c2-462f80f9fe95',NULL,NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p>',NULL,NULL,NULL),
	(284,327,1,'2020-02-15 21:14:42','2020-02-15 21:14:42','0f151c17-5d17-4cb7-b02d-35d6812ebf57',NULL,NULL,NULL,'Preparing Your Workspace','[{\"col1\":\"Clean up the area.\"},{\"col1\":\"Turn on espresso machine.\"}]',NULL),
	(285,328,1,'2020-02-15 21:14:42','2020-02-15 21:14:42','e25dd368-bc5e-4ec7-afbd-f50802271b3b',NULL,'Get the best espresso machine you can afford',NULL,NULL,NULL,NULL),
	(286,329,1,'2020-02-15 21:14:42','2020-02-15 21:14:42','33e5f74b-fcb1-426b-acc7-e3c1417d3925',NULL,NULL,NULL,'Grinding the Coffee','[{\"col1\":\"Instruction 1\"},{\"col1\":\"Instruction 2\"}]',NULL),
	(287,330,1,'2020-02-15 21:14:42','2020-02-15 21:14:42','33f18828-53dc-40c6-88a8-6b58fd3cd747','Another of the same.',NULL,NULL,NULL,NULL,NULL),
	(288,331,1,'2020-02-15 21:14:46','2020-02-15 21:14:46','5f5c6259-ead2-4b56-8e69-98af8e23c016',NULL,NULL,'<p>This is the initial page copy.</p>',NULL,NULL,NULL),
	(289,332,1,'2020-02-15 21:14:46','2020-02-15 21:14:46','45ea5c43-8288-4ed3-88cd-d9f11e5a4c95','The perfect espresso. Time to drink!',NULL,NULL,NULL,NULL,NULL),
	(290,333,1,'2020-02-15 21:14:46','2020-02-15 21:14:46','6fba4450-2a12-4175-9442-825d7bbe904f',NULL,'Be careful with the water temperature! It\'s important that the water is hot enough but not to hot.',NULL,NULL,NULL,NULL),
	(291,334,1,'2020-02-15 21:14:46','2020-02-15 21:14:46','e5519412-4391-4265-b362-53f18f9ba8ab',NULL,NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p>',NULL,NULL,NULL),
	(292,335,1,'2020-02-15 21:14:46','2020-02-15 21:14:46','16a6126b-e782-4c5f-97eb-6f8ae4664775',NULL,NULL,NULL,NULL,NULL,'[{\"col1\":\"22 grams\",\"col2\":\"Ground coffee\"},{\"col1\":\"4 oz\",\"col2\":\"Hot water\"},{\"col1\":\"1\",\"col2\":\"Espresso Machine\"}]'),
	(293,336,1,'2020-02-15 21:14:46','2020-02-15 21:14:46','61e6ec7f-6704-417d-b084-f119b08f63f7',NULL,NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p>',NULL,NULL,NULL),
	(294,337,1,'2020-02-15 21:14:46','2020-02-15 21:14:46','5d0a16d4-59c9-4c89-8841-82381ea9d206',NULL,NULL,NULL,'Preparing Your Workspace','[{\"col1\":\"Clean up the area.\"},{\"col1\":\"Turn on espresso machine.\"}]',NULL),
	(295,338,1,'2020-02-15 21:14:46','2020-02-15 21:14:46','dfdf684e-36d8-49fc-a2af-24257b1d5d56',NULL,'Get the best espresso machine you can afford; it',NULL,NULL,NULL,NULL),
	(296,339,1,'2020-02-15 21:14:46','2020-02-15 21:14:46','e6f7ee23-dffb-4b88-b92d-1bd42d02e0d8',NULL,NULL,NULL,'Grinding the Coffee','[{\"col1\":\"Instruction 1\"},{\"col1\":\"Instruction 2\"}]',NULL),
	(297,340,1,'2020-02-15 21:14:46','2020-02-15 21:14:46','17ca98c5-064a-49df-8005-1a2dfa39100e','Another of the same.',NULL,NULL,NULL,NULL,NULL),
	(298,341,1,'2020-02-15 21:14:49','2020-02-15 21:14:49','16289a41-26a2-4cf4-89af-7d65ff3654ae',NULL,NULL,'<p>This is the initial page copy.</p>',NULL,NULL,NULL),
	(299,342,1,'2020-02-15 21:14:49','2020-02-15 21:14:49','5eeb6c0c-350d-41b2-b52a-25c3212bf8e4','The perfect espresso. Time to drink!',NULL,NULL,NULL,NULL,NULL),
	(300,343,1,'2020-02-15 21:14:49','2020-02-15 21:14:49','d7f38918-dfd9-4fe7-9a96-3bb2d79e84f2',NULL,'Be careful with the water temperature! It\'s important that the water is hot enough but not to hot.',NULL,NULL,NULL,NULL),
	(301,344,1,'2020-02-15 21:14:49','2020-02-15 21:14:49','cbc9e89e-8d8f-41ca-bf4c-f829e6cdcc1f',NULL,NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p>',NULL,NULL,NULL),
	(302,345,1,'2020-02-15 21:14:49','2020-02-15 21:14:49','cd2bf94c-6bd1-4372-99bf-7500e28f5aa3',NULL,NULL,NULL,NULL,NULL,'[{\"col1\":\"22 grams\",\"col2\":\"Ground coffee\"},{\"col1\":\"4 oz\",\"col2\":\"Hot water\"},{\"col1\":\"1\",\"col2\":\"Espresso Machine\"}]'),
	(303,346,1,'2020-02-15 21:14:49','2020-02-15 21:14:49','73c2c0a6-cb30-479a-acc3-643b06e4e57b',NULL,NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p>',NULL,NULL,NULL),
	(304,347,1,'2020-02-15 21:14:49','2020-02-15 21:14:49','e3590466-58d7-4f66-a76e-1bcee070bae2',NULL,NULL,NULL,'Preparing Your Workspace','[{\"col1\":\"Clean up the area.\"},{\"col1\":\"Turn on espresso machine.\"}]',NULL),
	(305,348,1,'2020-02-15 21:14:49','2020-02-15 21:14:49','6983fdc2-6fd2-4b0e-bbc8-b881e126d9af',NULL,'Get the best espresso machine you can afford; it makes a differene!',NULL,NULL,NULL,NULL),
	(306,349,1,'2020-02-15 21:14:49','2020-02-15 21:14:49','21028008-a1a5-4082-a623-b13f50223298',NULL,NULL,NULL,'Grinding the Coffee','[{\"col1\":\"Instruction 1\"},{\"col1\":\"Instruction 2\"}]',NULL),
	(307,350,1,'2020-02-15 21:14:49','2020-02-15 21:14:49','c3060d7d-d3ff-4da0-8b84-600a1bc67f18','Another of the same.',NULL,NULL,NULL,NULL,NULL),
	(308,351,1,'2020-02-15 21:14:51','2020-02-15 21:14:51','276458de-94b6-469f-ab7f-b5d2d76c13e8',NULL,NULL,'<p>This is the initial page copy.</p>',NULL,NULL,NULL),
	(309,352,1,'2020-02-15 21:14:51','2020-02-15 21:14:51','1d851469-e836-4409-b64d-d8af86a740ce','The perfect espresso. Time to drink!',NULL,NULL,NULL,NULL,NULL),
	(310,353,1,'2020-02-15 21:14:51','2020-02-15 21:14:51','26718662-719e-4450-a454-3b18b25b9a31',NULL,'Be careful with the water temperature! It\'s important that the water is hot enough but not to hot.',NULL,NULL,NULL,NULL),
	(311,354,1,'2020-02-15 21:14:51','2020-02-15 21:14:51','465e0147-f75f-44fb-b444-282be2883505',NULL,NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p>',NULL,NULL,NULL),
	(312,355,1,'2020-02-15 21:14:51','2020-02-15 21:14:51','e7b8bfdd-4f18-44b4-9321-03eafd250d07',NULL,NULL,NULL,NULL,NULL,'[{\"col1\":\"22 grams\",\"col2\":\"Ground coffee\"},{\"col1\":\"4 oz\",\"col2\":\"Hot water\"},{\"col1\":\"1\",\"col2\":\"Espresso Machine\"}]'),
	(313,356,1,'2020-02-15 21:14:51','2020-02-15 21:14:51','2151e8d8-79cb-42d4-a2e1-c89d900864be',NULL,NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p>',NULL,NULL,NULL),
	(314,357,1,'2020-02-15 21:14:51','2020-02-15 21:14:51','9dbfad89-e61d-4142-9ea7-6bd591d0a3c5',NULL,NULL,NULL,'Preparing Your Workspace','[{\"col1\":\"Clean up the area.\"},{\"col1\":\"Turn on espresso machine.\"}]',NULL),
	(315,358,1,'2020-02-15 21:14:51','2020-02-15 21:14:51','309a2f08-029c-4676-a2c7-994ad4ba324f',NULL,'Get the best espresso machine you can afford; it makes a difference',NULL,NULL,NULL,NULL),
	(316,359,1,'2020-02-15 21:14:51','2020-02-15 21:14:51','c4389220-3cfc-4247-adf7-efe96d521dca',NULL,NULL,NULL,'Grinding the Coffee','[{\"col1\":\"Instruction 1\"},{\"col1\":\"Instruction 2\"}]',NULL),
	(317,360,1,'2020-02-15 21:14:51','2020-02-15 21:14:51','726f19bb-74a3-4414-8085-0a727de48b05','Another of the same.',NULL,NULL,NULL,NULL,NULL),
	(318,361,1,'2020-02-15 21:14:51','2020-02-15 21:14:51','2da03538-ae48-439b-8ac3-e5a11ba491da',NULL,NULL,'<p>This is the initial page copy.</p>',NULL,NULL,NULL),
	(319,362,1,'2020-02-15 21:14:51','2020-02-15 21:14:51','12cd06bc-457d-4ad4-a726-9efc526faf14','The perfect espresso. Time to drink!',NULL,NULL,NULL,NULL,NULL),
	(320,363,1,'2020-02-15 21:14:51','2020-02-15 21:14:51','02fd47ef-c089-4f6d-b107-ba63f76aa24b',NULL,'Be careful with the water temperature! It\'s important that the water is hot enough but not to hot.',NULL,NULL,NULL,NULL),
	(321,364,1,'2020-02-15 21:14:51','2020-02-15 21:14:51','492664fc-5456-4827-9975-995d837d21ca',NULL,NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p>',NULL,NULL,NULL),
	(322,365,1,'2020-02-15 21:14:51','2020-02-15 21:14:51','80db6a39-4af0-4779-9ad6-8d66f8d1dd8a',NULL,NULL,NULL,NULL,NULL,'[{\"col1\":\"22 grams\",\"col2\":\"Ground coffee\"},{\"col1\":\"4 oz\",\"col2\":\"Hot water\"},{\"col1\":\"1\",\"col2\":\"Espresso Machine\"}]'),
	(323,366,1,'2020-02-15 21:14:51','2020-02-15 21:14:51','59efbf1a-eeb0-489e-b139-4c8982c58df9',NULL,NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p>',NULL,NULL,NULL),
	(324,367,1,'2020-02-15 21:14:51','2020-02-15 21:14:51','b5d4547f-cd19-4cc4-bef5-f62ba6a2b0cd',NULL,NULL,NULL,'Preparing Your Workspace','[{\"col1\":\"Clean up the area.\"},{\"col1\":\"Turn on espresso machine.\"}]',NULL),
	(325,368,1,'2020-02-15 21:14:51','2020-02-15 21:14:51','1a4f9e3f-3290-46ba-9567-18bb0e49eb3d',NULL,'Get the best espresso machine you can afford; it makes a difference!',NULL,NULL,NULL,NULL),
	(326,369,1,'2020-02-15 21:14:51','2020-02-15 21:14:51','a4bb0d78-c032-470d-942b-0979f59dcee1',NULL,NULL,NULL,'Grinding the Coffee','[{\"col1\":\"Instruction 1\"},{\"col1\":\"Instruction 2\"}]',NULL),
	(327,370,1,'2020-02-15 21:14:51','2020-02-15 21:14:51','41a74fb5-14e6-4466-ba26-ca83a0b7ab2a','Another of the same.',NULL,NULL,NULL,NULL,NULL),
	(338,382,1,'2020-02-15 21:15:15','2020-02-15 21:15:15','56a5984d-9ec3-48e6-8c54-ca636112d88b',NULL,NULL,'<p>This is the initial page copy.</p>',NULL,NULL,NULL),
	(339,383,1,'2020-02-15 21:15:15','2020-02-15 21:15:15','bd5e621d-26da-4f2b-95de-27f576d97fba','The perfect espresso. Time to drink!',NULL,NULL,NULL,NULL,NULL),
	(340,384,1,'2020-02-15 21:15:15','2020-02-15 21:15:15','5eeb7cf4-55cf-4caf-90ab-b1f2b85fb366',NULL,'Be careful with the water temperature! It\'s important that the water is hot enough but not to hot.',NULL,NULL,NULL,NULL),
	(341,385,1,'2020-02-15 21:15:15','2020-02-15 21:15:15','61e4ecbc-25d7-4a4f-8626-d55a55b912f2',NULL,NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p>',NULL,NULL,NULL),
	(342,386,1,'2020-02-15 21:15:15','2020-02-15 21:15:15','bc9bf211-2027-4809-934c-7696c641ca62',NULL,NULL,NULL,NULL,NULL,'[{\"col1\":\"22 grams\",\"col2\":\"Ground coffee\"},{\"col1\":\"4 oz\",\"col2\":\"Hot water\"},{\"col1\":\"1\",\"col2\":\"Espresso Machine\"}]'),
	(343,387,1,'2020-02-15 21:15:15','2020-02-15 21:15:15','54321315-6348-4ddc-b438-99f54321e961',NULL,NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p>',NULL,NULL,NULL),
	(344,388,1,'2020-02-15 21:15:15','2020-02-15 21:15:15','264d0d7d-e1f7-4f68-b2ac-246ee6b2965b',NULL,NULL,NULL,'Preparing Your Workspace','[{\"col1\":\"Clean up the area.\"},{\"col1\":\"Turn on espresso machine.\"}]',NULL),
	(345,389,1,'2020-02-15 21:15:15','2020-02-15 21:15:15','5e140717-4f0a-4be0-aed2-abf6c6bb2d3e',NULL,NULL,NULL,'Grinding the Coffee','[{\"col1\":\"Instruction 1\"},{\"col1\":\"Instruction 2\"}]',NULL),
	(346,390,1,'2020-02-15 21:15:15','2020-02-15 21:15:15','08e9aeb6-d2a4-4b93-9813-b61faf9a0040',NULL,'Get the best espresso machine you can afford; it makes a difference!',NULL,NULL,NULL,NULL),
	(347,391,1,'2020-02-15 21:15:15','2020-02-15 21:15:15','5c886cff-c63a-47b3-a397-d33804b393bd','Another of the same.',NULL,NULL,NULL,NULL,NULL),
	(348,393,1,'2020-02-15 21:15:16','2020-02-15 21:15:16','f26a3063-93d9-41e7-8362-14bf10df39dc',NULL,NULL,'<p>This is the initial page copy.</p>',NULL,NULL,NULL),
	(349,394,1,'2020-02-15 21:15:16','2020-02-15 21:15:16','be976944-9d19-4218-9db2-f0fc805a7b8a','The perfect espresso. Time to drink!',NULL,NULL,NULL,NULL,NULL),
	(350,395,1,'2020-02-15 21:15:16','2020-02-15 21:15:16','7f52676f-0fd7-43d1-b4d1-91f384aaef87',NULL,'Be careful with the water temperature! It\'s important that the water is hot enough but not to hot.',NULL,NULL,NULL,NULL),
	(351,396,1,'2020-02-15 21:15:16','2020-02-15 21:15:16','93496daf-0e88-4e1d-b7d9-0ffb7e3b88fb',NULL,NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p>',NULL,NULL,NULL),
	(352,397,1,'2020-02-15 21:15:16','2020-02-15 21:15:16','71126da2-a973-439f-b0db-21998f110fed',NULL,NULL,NULL,NULL,NULL,'[{\"col1\":\"22 grams\",\"col2\":\"Ground coffee\"},{\"col1\":\"4 oz\",\"col2\":\"Hot water\"},{\"col1\":\"1\",\"col2\":\"Espresso Machine\"}]'),
	(353,398,1,'2020-02-15 21:15:16','2020-02-15 21:15:16','fb091789-dd5c-4f7d-a6e6-c8bdbde52758',NULL,NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p>',NULL,NULL,NULL),
	(354,399,1,'2020-02-15 21:15:16','2020-02-15 21:15:16','2bdb2df6-b250-42f9-82d9-7c0927eceef3',NULL,NULL,NULL,'Preparing Your Workspace','[{\"col1\":\"Clean up the area.\"},{\"col1\":\"Turn on espresso machine.\"}]',NULL),
	(355,400,1,'2020-02-15 21:15:16','2020-02-15 21:15:16','b8a69f14-2607-4774-8344-b12f8c387030',NULL,NULL,NULL,'Grinding the Coffee','[{\"col1\":\"Instruction 1\"},{\"col1\":\"Instruction 2\"}]',NULL),
	(356,401,1,'2020-02-15 21:15:16','2020-02-15 21:15:16','b5b0d4c2-db6b-4cff-b20f-f686943b1baf',NULL,'Get the best espresso machine you can afford; it makes a difference!',NULL,NULL,NULL,NULL),
	(357,402,1,'2020-02-15 21:15:16','2020-02-15 21:15:16','e7aca7d1-079f-4f14-8606-cafd5c9f9cab','Another of the same.',NULL,NULL,NULL,NULL,NULL),
	(368,414,1,'2020-02-15 22:13:52','2020-02-15 22:13:52','a1e745a6-e803-4848-903d-360e8ddafcbb',NULL,NULL,NULL,NULL,NULL,NULL),
	(369,415,1,'2020-02-15 22:14:00','2020-02-15 22:14:00','cf3bc488-8bde-4749-a5fa-de8c7a071ad8',NULL,NULL,NULL,'Buying Good Coffee Beans',NULL,NULL),
	(370,416,1,'2020-02-15 22:14:00','2020-02-15 22:14:00','26c1004e-86ad-4f3e-bfe7-850dfab7defc',NULL,NULL,NULL,'Buying Good Coffee Beans','[{\"col1\":\"\"}]',NULL),
	(371,417,1,'2020-02-15 22:14:10','2020-02-15 22:14:10','be6d5509-0b37-4562-b668-99a2b3fe871a',NULL,NULL,NULL,'Buying Good Coffee Beans','[{\"col1\":\"Go to the whole foods market. \"}]',NULL),
	(372,418,1,'2020-02-15 22:14:14','2020-02-15 22:14:14','cda4f17a-a0ad-4608-9bce-ffaa8655331c',NULL,NULL,NULL,'Buying Good Coffee Beans','[{\"col1\":\"Go to the whole foods market. \"}]',NULL),
	(373,419,1,'2020-02-15 22:14:21','2020-02-15 22:14:21','359b67d3-30a5-45ec-adb0-0ccb4bf665fd',NULL,NULL,NULL,'Buying Good Coffee Beans','[{\"col1\":\"Go to the whole foods market. \"}]',NULL),
	(374,420,1,'2020-02-15 22:14:29','2020-02-15 22:14:29','e68a6ca9-6f1e-450c-8630-a1681433f8e0',NULL,NULL,NULL,NULL,NULL,NULL),
	(375,421,1,'2020-02-15 22:14:29','2020-02-15 22:14:29','eda28a39-4c05-4a8e-99db-38b94f543a27',NULL,NULL,NULL,'Buying Good Coffee Beans','[{\"col1\":\"Go to the whole foods market. \"}]',NULL),
	(376,422,1,'2020-02-15 22:14:32','2020-02-15 22:14:32','34c6999f-1444-4d7b-9917-3f1ec0e8f92d',NULL,NULL,NULL,NULL,NULL,NULL),
	(377,423,1,'2020-02-15 22:14:32','2020-02-15 22:14:32','2bdc0482-e81a-4ffd-a6dd-f15ef1ad8728',NULL,NULL,NULL,'Buying Good Coffee Beans','[{\"col1\":\"Go to the whole foods market. \"}]',NULL),
	(380,426,1,'2020-02-15 22:15:01','2020-02-15 22:15:01','58ee364c-e238-443b-b6ea-5f0a4f775403',NULL,NULL,'<p>This is the initial page copy.</p>',NULL,NULL,NULL),
	(381,427,1,'2020-02-15 22:15:01','2020-02-15 22:15:01','b8f0f89d-e141-4e25-9ee4-c3dfab791024','The perfect espresso. Time to drink!',NULL,NULL,NULL,NULL,NULL),
	(382,428,1,'2020-02-15 22:15:01','2020-02-15 22:15:01','0a8b4dd3-9172-49d3-b887-2f0a7aef89eb',NULL,'Be careful with the water temperature! It\'s important that the water is hot enough but not to hot.',NULL,NULL,NULL,NULL),
	(383,429,1,'2020-02-15 22:15:01','2020-02-15 22:15:01','af86f989-1d02-4559-ac0a-f77c21d3cc08',NULL,NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p>',NULL,NULL,NULL),
	(384,430,1,'2020-02-15 22:15:01','2020-02-15 22:15:01','e89a748e-4cec-4240-8dec-2e7644ae90cf',NULL,NULL,NULL,NULL,NULL,'[{\"col1\":\"22 grams\",\"col2\":\"Ground coffee\"},{\"col1\":\"4 oz\",\"col2\":\"Hot water\"},{\"col1\":\"1\",\"col2\":\"Espresso Machine\"}]'),
	(385,431,1,'2020-02-15 22:15:01','2020-02-15 22:15:01','f1bf7c4f-2fd1-44e3-9867-06d293ad6afd',NULL,NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p>',NULL,NULL,NULL),
	(386,432,1,'2020-02-15 22:15:01','2020-02-15 22:15:01','b27cd5c1-3e6f-49f9-82f6-318a03e6724e',NULL,NULL,NULL,NULL,NULL,NULL),
	(387,433,1,'2020-02-15 22:15:01','2020-02-15 22:15:01','d6e0f994-1354-40a4-ba2f-daa024a1866b',NULL,'Get the best espresso machine you can afford; it makes a difference!',NULL,NULL,NULL,NULL),
	(388,434,1,'2020-02-15 22:15:01','2020-02-15 22:15:01','4e6ed0d8-3a30-4938-8b91-dd55e079f7d3','Another of the same.',NULL,NULL,NULL,NULL,NULL),
	(389,435,1,'2020-02-15 22:15:01','2020-02-15 22:15:01','369f84a0-5d54-4be4-ad13-d8af64cbc074',NULL,NULL,NULL,'Buying Good Coffee Beans','[{\"col1\":\"Go to the whole foods market. \"}]',NULL),
	(390,436,1,'2020-02-15 22:15:01','2020-02-15 22:15:01','b6ef3c86-65a4-4ea0-858c-aa461879c79e',NULL,NULL,NULL,'Preparing Your Workspace','[{\"col1\":\"Clean up the area.\"},{\"col1\":\"Turn on espresso machine.\"}]',NULL),
	(391,437,1,'2020-02-15 22:15:01','2020-02-15 22:15:01','418fb37f-9681-471d-8963-7b597621c9a7',NULL,NULL,NULL,'Grinding the Coffee','[{\"col1\":\"Instruction 1\"},{\"col1\":\"Instruction 2\"}]',NULL),
	(392,439,1,'2020-02-15 22:15:02','2020-02-15 22:15:02','68e4efb3-f4b5-4025-b788-c0909f3ca822',NULL,NULL,'<p>This is the initial page copy.</p>',NULL,NULL,NULL),
	(393,440,1,'2020-02-15 22:15:02','2020-02-15 22:15:02','f66a02c7-6f3a-4afb-bf39-40d203d3c4d0','The perfect espresso. Time to drink!',NULL,NULL,NULL,NULL,NULL),
	(394,441,1,'2020-02-15 22:15:02','2020-02-15 22:15:02','8a018e01-6328-4db4-aa0e-557594854ca5',NULL,'Be careful with the water temperature! It\'s important that the water is hot enough but not to hot.',NULL,NULL,NULL,NULL),
	(395,442,1,'2020-02-15 22:15:02','2020-02-15 22:15:02','a225001d-90b7-4eff-ac2c-69fc830ca4d0',NULL,NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p>',NULL,NULL,NULL),
	(396,443,1,'2020-02-15 22:15:02','2020-02-15 22:15:02','eb80a003-0746-48dc-a2d0-9aeda07e066b',NULL,NULL,NULL,NULL,NULL,'[{\"col1\":\"22 grams\",\"col2\":\"Ground coffee\"},{\"col1\":\"4 oz\",\"col2\":\"Hot water\"},{\"col1\":\"1\",\"col2\":\"Espresso Machine\"}]'),
	(397,444,1,'2020-02-15 22:15:02','2020-02-15 22:15:02','131eb1f4-210e-4c10-aaa6-54881b319404',NULL,NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p>',NULL,NULL,NULL),
	(398,445,1,'2020-02-15 22:15:02','2020-02-15 22:15:02','6b8af794-91b2-40eb-92ec-22cbd750d5d0',NULL,NULL,NULL,NULL,NULL,NULL),
	(399,446,1,'2020-02-15 22:15:02','2020-02-15 22:15:02','f984c690-5ce4-48ce-84c0-6ffef53debd3',NULL,'Get the best espresso machine you can afford; it makes a difference!',NULL,NULL,NULL,NULL),
	(400,447,1,'2020-02-15 22:15:02','2020-02-15 22:15:02','593d7904-90e8-4365-9e6d-4039bd791ef9','Another of the same.',NULL,NULL,NULL,NULL,NULL),
	(401,448,1,'2020-02-15 22:15:02','2020-02-15 22:15:02','27e28796-8fd6-4829-9548-79cd75acf7d6',NULL,NULL,NULL,'Buying Good Coffee Beans','[{\"col1\":\"Go to the whole foods market. \"}]',NULL),
	(402,449,1,'2020-02-15 22:15:02','2020-02-15 22:15:02','a1010b60-58f7-40e3-b042-1210338fae52',NULL,NULL,NULL,'Preparing Your Workspace','[{\"col1\":\"Clean up the area.\"},{\"col1\":\"Turn on espresso machine.\"}]',NULL),
	(403,450,1,'2020-02-15 22:15:02','2020-02-15 22:15:02','aea330aa-40ad-481a-98be-b6481385fb83',NULL,NULL,NULL,'Grinding the Coffee','[{\"col1\":\"Instruction 1\"},{\"col1\":\"Instruction 2\"}]',NULL),
	(404,453,1,'2020-02-15 22:50:45','2020-02-15 22:50:45','19300c53-3a14-42ce-9126-6d6d6f7ce82c',NULL,NULL,'<p>This is the initial page copy.</p>',NULL,NULL,NULL),
	(405,454,1,'2020-02-15 22:50:45','2020-02-15 22:50:45','d9a35386-357f-48b6-939d-923dad88176b','The perfect espresso. Time to drink!',NULL,NULL,NULL,NULL,NULL),
	(406,455,1,'2020-02-15 22:50:45','2020-02-15 22:50:45','65910e5b-b60c-4c59-b325-f390ec27ad9f',NULL,'Be careful with the water temperature! It\'s important that the water is hot enough but not to hot.',NULL,NULL,NULL,NULL),
	(407,456,1,'2020-02-15 22:50:45','2020-02-15 22:50:45','4c15ec61-2092-4a2b-943c-82034533cb87',NULL,NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p>',NULL,NULL,NULL),
	(408,457,1,'2020-02-15 22:50:45','2020-02-15 22:50:45','5892d4fb-80a4-46b1-83ab-509569a72cfd',NULL,NULL,NULL,NULL,NULL,'[{\"col1\":\"22 grams\",\"col2\":\"Ground coffee\"},{\"col1\":\"4 oz\",\"col2\":\"Hot water\"},{\"col1\":\"1\",\"col2\":\"Espresso Machine\"}]'),
	(409,458,1,'2020-02-15 22:50:45','2020-02-15 22:50:45','3e93d039-9a1c-438b-9731-ac40e2b8ff15',NULL,NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit? Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aspernatur deleniti dignissimos est explicabo, iure laborum minima natus nihil qui repudiandae, velit voluptatum! Animi id illo illum in maiores velit?</p>',NULL,NULL,NULL),
	(410,459,1,'2020-02-15 22:50:45','2020-02-15 22:50:45','20df462e-dd09-4569-9113-08f6626b51bb',NULL,NULL,NULL,NULL,NULL,NULL),
	(411,460,1,'2020-02-15 22:50:45','2020-02-15 22:50:45','2ba67045-ff95-49f3-954b-99416647d568',NULL,'Get the best espresso machine you can afford; it makes a difference!',NULL,NULL,NULL,NULL),
	(412,461,1,'2020-02-15 22:50:45','2020-02-15 22:50:45','e85b6e3b-a9fc-4fe7-a494-326c382c0245','Another of the same.',NULL,NULL,NULL,NULL,NULL),
	(413,462,1,'2020-02-15 22:50:45','2020-02-15 22:50:45','95676112-ebe2-4cf5-adf5-9b724f66048a',NULL,NULL,NULL,'Buying Good Coffee Beans','[{\"col1\":\"Go to the whole foods market. \"}]',NULL),
	(414,463,1,'2020-02-15 22:50:45','2020-02-15 22:50:45','f1319c61-223d-4bae-bec7-af669d0f55cf',NULL,NULL,NULL,'Preparing Your Workspace','[{\"col1\":\"Clean up the area.\"},{\"col1\":\"Turn on espresso machine.\"}]',NULL),
	(415,464,1,'2020-02-15 22:50:45','2020-02-15 22:50:45','9b96b8d2-38b1-45b1-b4e1-9a15c59b6755',NULL,NULL,NULL,'Grinding the Coffee','[{\"col1\":\"Instruction 1\"},{\"col1\":\"Instruction 2\"}]',NULL),
	(416,469,1,'2020-02-16 00:02:30','2020-02-16 00:02:30','73b7233b-c3ce-4365-8d21-d1dcdc331004',NULL,NULL,'<p>placeholder copy here</p>',NULL,NULL,NULL);

/*!40000 ALTER TABLE `matrixcontent_recipecontents` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table migrations
# ------------------------------------------------------------

DROP TABLE IF EXISTS `migrations`;

CREATE TABLE `migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pluginId` int(11) DEFAULT NULL,
  `type` enum('app','plugin','content') NOT NULL DEFAULT 'app',
  `name` varchar(255) NOT NULL,
  `applyTime` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `migrations_pluginId_idx` (`pluginId`),
  KEY `migrations_type_pluginId_idx` (`type`,`pluginId`),
  CONSTRAINT `migrations_pluginId_fk` FOREIGN KEY (`pluginId`) REFERENCES `plugins` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;

INSERT INTO `migrations` (`id`, `pluginId`, `type`, `name`, `applyTime`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,NULL,'app','Install','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','eafc608a-9653-4353-aa9b-ab366f6f7410'),
	(2,NULL,'app','m150403_183908_migrations_table_changes','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','8fee6f4d-c0c2-46ee-bf2a-98a2df0c2284'),
	(3,NULL,'app','m150403_184247_plugins_table_changes','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','20bb0cb7-297b-4401-a5c2-09a835c42a7d'),
	(4,NULL,'app','m150403_184533_field_version','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','1db03246-f369-4d01-b7df-bd9d65836d1f'),
	(5,NULL,'app','m150403_184729_type_columns','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','5defe34e-da74-4b7e-b18d-cf3d000ebd16'),
	(6,NULL,'app','m150403_185142_volumes','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','1baeb90d-2394-46d2-b47d-2ed4e3778cd2'),
	(7,NULL,'app','m150428_231346_userpreferences','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','bd904f84-3e86-4a82-9100-e698209a5de8'),
	(8,NULL,'app','m150519_150900_fieldversion_conversion','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','1bc0aa33-65c9-4014-9acb-91f70a199ef1'),
	(9,NULL,'app','m150617_213829_update_email_settings','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','99bad61f-8afb-463e-b2c8-ba99ed1c5b91'),
	(10,NULL,'app','m150721_124739_templatecachequeries','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','1bea6ac3-3c47-4f81-b07c-90ab91479c6a'),
	(11,NULL,'app','m150724_140822_adjust_quality_settings','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','be24d28a-de79-43ca-bae3-1db824d92f7e'),
	(12,NULL,'app','m150815_133521_last_login_attempt_ip','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','58e242d7-6397-486b-90df-bbeb7923af5e'),
	(13,NULL,'app','m151002_095935_volume_cache_settings','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','21043a0b-58ad-46f3-8ed6-a04567ab5137'),
	(14,NULL,'app','m151005_142750_volume_s3_storage_settings','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','847423d8-2cce-46d4-ac9d-79a45b82baff'),
	(15,NULL,'app','m151016_133600_delete_asset_thumbnails','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','d17102aa-022d-4b60-a4a0-7ac4461c5e02'),
	(16,NULL,'app','m151209_000000_move_logo','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','a751dc99-e4d7-466b-a502-b8daef198bee'),
	(17,NULL,'app','m151211_000000_rename_fileId_to_assetId','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','75c02f33-7873-48a1-837b-fc7bea77eb50'),
	(18,NULL,'app','m151215_000000_rename_asset_permissions','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','018964a9-dd24-4b07-8349-8137460d2e61'),
	(19,NULL,'app','m160707_000001_rename_richtext_assetsource_setting','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','0b017dc9-dd0f-413c-ac9c-88ad80c28228'),
	(20,NULL,'app','m160708_185142_volume_hasUrls_setting','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','d56afd10-8019-4795-9492-18ed5edf194d'),
	(21,NULL,'app','m160714_000000_increase_max_asset_filesize','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','db926ff9-37a4-4a82-b8a8-7093465b5d81'),
	(22,NULL,'app','m160727_194637_column_cleanup','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','77fa7781-8df4-4a06-91a5-79e39565358b'),
	(23,NULL,'app','m160804_110002_userphotos_to_assets','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','f444a663-5277-4a66-a93a-6d5f63ae0ddd'),
	(24,NULL,'app','m160807_144858_sites','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','34f05702-5431-4680-a5d3-bb5acafc9551'),
	(25,NULL,'app','m160829_000000_pending_user_content_cleanup','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','36db34ed-4ed2-4653-b9d1-2f8200acc602'),
	(26,NULL,'app','m160830_000000_asset_index_uri_increase','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','6384fbfd-4202-4275-b987-f2fa38f5ca37'),
	(27,NULL,'app','m160912_230520_require_entry_type_id','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','ea5d44a4-e679-4b44-a90a-347a04bf56f5'),
	(28,NULL,'app','m160913_134730_require_matrix_block_type_id','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','08579dce-d416-4f33-9a83-dc5cd5418ee7'),
	(29,NULL,'app','m160920_174553_matrixblocks_owner_site_id_nullable','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','888a6711-e781-4e56-9c4e-e018e1be1bb2'),
	(30,NULL,'app','m160920_231045_usergroup_handle_title_unique','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','7d66d1f8-e375-4ed3-b867-1fa6664b7ab7'),
	(31,NULL,'app','m160925_113941_route_uri_parts','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','d6e87541-74ce-4ca1-a266-826fad5d00b0'),
	(32,NULL,'app','m161006_205918_schemaVersion_not_null','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','e19fba1d-78a6-4a51-9152-207249b0a5b2'),
	(33,NULL,'app','m161007_130653_update_email_settings','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','f70df3f1-0887-40ae-aac1-b76adc754e45'),
	(34,NULL,'app','m161013_175052_newParentId','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','381659a8-90da-48ca-85e9-eda79f5c82a1'),
	(35,NULL,'app','m161021_102916_fix_recent_entries_widgets','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','a9c966fa-e077-48b8-a088-d09d6042f75f'),
	(36,NULL,'app','m161021_182140_rename_get_help_widget','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','55147ac7-3265-4959-9093-79adc39ffd2d'),
	(37,NULL,'app','m161025_000000_fix_char_columns','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','82f2c762-0172-490e-ab09-5676ce005810'),
	(38,NULL,'app','m161029_124145_email_message_languages','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','473c5ad7-0a0b-47a7-acfa-b902bf9cd279'),
	(39,NULL,'app','m161108_000000_new_version_format','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','4acfe70e-5501-47fb-8e6f-8bc1837c7ad5'),
	(40,NULL,'app','m161109_000000_index_shuffle','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','92267987-cfa3-4a05-88f0-bf575bfa78dd'),
	(41,NULL,'app','m161122_185500_no_craft_app','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','4f505e7a-c7d2-473e-a65d-af6516a15896'),
	(42,NULL,'app','m161125_150752_clear_urlmanager_cache','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','afb48aab-eca0-4317-8e67-15254550210f'),
	(43,NULL,'app','m161220_000000_volumes_hasurl_notnull','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','cb3622a8-7c79-4c61-867e-bc4dac641091'),
	(44,NULL,'app','m170114_161144_udates_permission','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','c8c41bc7-128d-4036-b4f6-cd3add801d35'),
	(45,NULL,'app','m170120_000000_schema_cleanup','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','fd4eda95-4fe3-43e0-a719-63e46683b2ca'),
	(46,NULL,'app','m170126_000000_assets_focal_point','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','03f3ce4d-ad5c-43dc-8591-048c9d1c5b08'),
	(47,NULL,'app','m170206_142126_system_name','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','7d1c8948-b58b-405e-a616-828c2940a34a'),
	(48,NULL,'app','m170217_044740_category_branch_limits','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','f7e4a265-671e-4c1e-a125-0739a45bde71'),
	(49,NULL,'app','m170217_120224_asset_indexing_columns','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','25c751db-f2da-408d-9609-420115520206'),
	(50,NULL,'app','m170223_224012_plain_text_settings','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','a7b211e0-151c-42c5-8c44-66f46142a2a4'),
	(51,NULL,'app','m170227_120814_focal_point_percentage','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','6b4f5415-0c00-4a76-8d91-fa92ea7a5881'),
	(52,NULL,'app','m170228_171113_system_messages','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','0f7d03a1-2f7a-49e5-808f-58a5e764bfb6'),
	(53,NULL,'app','m170303_140500_asset_field_source_settings','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','ec1e50b8-2a92-41c3-afc8-bd401b25b6a7'),
	(54,NULL,'app','m170306_150500_asset_temporary_uploads','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','8ebc37e7-aa03-4853-b40b-e143da9f1621'),
	(55,NULL,'app','m170523_190652_element_field_layout_ids','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','733e7388-3cdc-4f3a-817d-5413caed7321'),
	(56,NULL,'app','m170612_000000_route_index_shuffle','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','8d77e60b-4a64-4afb-994e-600d44386fce'),
	(57,NULL,'app','m170621_195237_format_plugin_handles','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','38740de4-58a1-443e-bdbe-3cfd5bff1028'),
	(58,NULL,'app','m170630_161027_deprecation_line_nullable','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','c55bde27-b9de-4c17-bd0e-8caf6369f364'),
	(59,NULL,'app','m170630_161028_deprecation_changes','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','93e28970-b98d-4673-9b45-cd46cecfd9d0'),
	(60,NULL,'app','m170703_181539_plugins_table_tweaks','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','bb1cac7c-19dc-4198-8d8f-a49a16986edd'),
	(61,NULL,'app','m170704_134916_sites_tables','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','b83cc3c8-f728-4f75-9a3e-5d312ea4df82'),
	(62,NULL,'app','m170706_183216_rename_sequences','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','fd406dea-cac4-41e0-a826-0e6c8a757348'),
	(63,NULL,'app','m170707_094758_delete_compiled_traits','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','5621d947-25ee-4020-b904-f68591b1c0b9'),
	(64,NULL,'app','m170731_190138_drop_asset_packagist','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','cdc8f7cc-3f2a-4dab-b7cc-6f779a541403'),
	(65,NULL,'app','m170810_201318_create_queue_table','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','0cf383e1-b936-46fd-a101-cb6bdae7c1b1'),
	(66,NULL,'app','m170903_192801_longblob_for_queue_jobs','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','e07ea0f3-7004-4973-84c9-70954a8b1c94'),
	(67,NULL,'app','m170914_204621_asset_cache_shuffle','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','65f37d37-6716-43cb-8ea0-a165264dacc6'),
	(68,NULL,'app','m171011_214115_site_groups','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','026c2eee-532b-4d7c-9356-185031df9923'),
	(69,NULL,'app','m171012_151440_primary_site','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','d4682641-818a-46c2-a0a2-1421ce4ce2ec'),
	(70,NULL,'app','m171013_142500_transform_interlace','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','5fab9740-dbda-42bc-80a1-20a056ea8e8a'),
	(71,NULL,'app','m171016_092553_drop_position_select','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','f0018127-f381-415c-8a0f-5f37a1a11203'),
	(72,NULL,'app','m171016_221244_less_strict_translation_method','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','bdaf6d86-ef59-46a8-88d4-4634e7c7d044'),
	(73,NULL,'app','m171107_000000_assign_group_permissions','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','58c21691-4964-4833-8a71-0257df4f9d54'),
	(74,NULL,'app','m171117_000001_templatecache_index_tune','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','95800748-baed-40ae-8bee-348185f7a9ad'),
	(75,NULL,'app','m171126_105927_disabled_plugins','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','33f464c2-f909-484f-8e91-c6b52abe791e'),
	(76,NULL,'app','m171130_214407_craftidtokens_table','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','74e848eb-8b4a-44af-8a39-26aed742f243'),
	(77,NULL,'app','m171202_004225_update_email_settings','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','985e4ec1-20e3-4390-91de-97508a1dea23'),
	(78,NULL,'app','m171204_000001_templatecache_index_tune_deux','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','26a6654b-a4a8-47d8-a399-09786d107868'),
	(79,NULL,'app','m171205_130908_remove_craftidtokens_refreshtoken_column','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','9891e13b-986a-418d-ac38-7e716d7a836d'),
	(80,NULL,'app','m171218_143135_longtext_query_column','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','f48c7a31-991c-4c7f-98d5-81395f8ed7e8'),
	(81,NULL,'app','m171231_055546_environment_variables_to_aliases','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','17546f63-eebb-490f-89ff-286bb18b8ac4'),
	(82,NULL,'app','m180113_153740_drop_users_archived_column','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','a23c5efb-e193-4c0e-9062-ec190a9000d2'),
	(83,NULL,'app','m180122_213433_propagate_entries_setting','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','ea2e8d2e-4e12-4353-8be7-7dbc94960caf'),
	(84,NULL,'app','m180124_230459_fix_propagate_entries_values','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','6924ca45-6fef-40af-a7c5-0b21d80b34d2'),
	(85,NULL,'app','m180128_235202_set_tag_slugs','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','e0db711f-fbab-4c4c-9630-faa254084c35'),
	(86,NULL,'app','m180202_185551_fix_focal_points','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','56cdfc71-a3a3-4d7d-82ec-f4974520b7b4'),
	(87,NULL,'app','m180217_172123_tiny_ints','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','276b5deb-e1df-45e3-b912-b3881d189371'),
	(88,NULL,'app','m180321_233505_small_ints','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','9be41c39-4378-43e5-b313-914e9c19f953'),
	(89,NULL,'app','m180328_115523_new_license_key_statuses','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','f4a65d4c-100d-43be-a81a-c330dba89d8c'),
	(90,NULL,'app','m180404_182320_edition_changes','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','d5d6acfe-8f13-4729-85f7-e484ce3786e5'),
	(91,NULL,'app','m180411_102218_fix_db_routes','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','21497049-77c2-47e0-abda-b4ad1b654b80'),
	(92,NULL,'app','m180416_205628_resourcepaths_table','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','1353e043-e3f9-480f-aae1-635a1247bc70'),
	(93,NULL,'app','m180418_205713_widget_cleanup','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','3f39f5a6-7291-4f01-a640-ee7773a64300'),
	(94,NULL,'app','m180425_203349_searchable_fields','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','6e5a3d56-00b2-4b25-9ff4-e103344832a8'),
	(95,NULL,'app','m180516_153000_uids_in_field_settings','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','1494ccb0-469f-4afc-aaf2-6c42c5e4284b'),
	(96,NULL,'app','m180517_173000_user_photo_volume_to_uid','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','8bc45767-5554-4623-9844-1346e66b8122'),
	(97,NULL,'app','m180518_173000_permissions_to_uid','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','5958b143-b412-4622-bdd6-a9509965b8cc'),
	(98,NULL,'app','m180520_173000_matrix_context_to_uids','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','a3e97166-b8dd-49ef-9ab5-94496d3be7c2'),
	(99,NULL,'app','m180521_172900_project_config_table','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','f0d24ec2-a00f-4d7e-a58c-a15812c07b53'),
	(100,NULL,'app','m180521_173000_initial_yml_and_snapshot','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','9ada395d-b1e5-4587-ae92-321bea8ab6a1'),
	(101,NULL,'app','m180731_162030_soft_delete_sites','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','accada56-95eb-4e1e-8418-98255369d1c2'),
	(102,NULL,'app','m180810_214427_soft_delete_field_layouts','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','80494c4c-7199-4c11-a2ed-573f43c83bf3'),
	(103,NULL,'app','m180810_214439_soft_delete_elements','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','b83a7e2a-bd5b-4784-89fe-bc0811ffe1fd'),
	(104,NULL,'app','m180824_193422_case_sensitivity_fixes','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','e8caea42-a9c9-403f-830d-39a54ecc9969'),
	(105,NULL,'app','m180901_151639_fix_matrixcontent_tables','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','13f1ed9d-5226-4930-94cc-36db7ae960c0'),
	(106,NULL,'app','m180904_112109_permission_changes','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','9f4f2d27-830f-4f20-a869-fc8992ec5025'),
	(107,NULL,'app','m180910_142030_soft_delete_sitegroups','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','e42ab249-6a59-4df0-99f9-13e05de75ff8'),
	(108,NULL,'app','m181011_160000_soft_delete_asset_support','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','f9397fda-9cab-4cb6-8fd7-c93c7942807f'),
	(109,NULL,'app','m181016_183648_set_default_user_settings','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','7b349573-2e31-497d-a149-70c0701cd1fa'),
	(110,NULL,'app','m181017_225222_system_config_settings','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','af459a8e-867d-4eca-b038-5ff96b12f51a'),
	(111,NULL,'app','m181018_222343_drop_userpermissions_from_config','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','790dd40a-d9a3-480e-ab10-43520f345fe0'),
	(112,NULL,'app','m181029_130000_add_transforms_routes_to_config','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','ae11ec33-f7f7-4c20-bfcb-34df3a1d099e'),
	(113,NULL,'app','m181112_203955_sequences_table','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','081d726c-1216-4fc3-9829-89de5820d18d'),
	(114,NULL,'app','m181121_001712_cleanup_field_configs','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','a0b0023c-a074-4480-a653-b18ac2cb99ed'),
	(115,NULL,'app','m181128_193942_fix_project_config','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','8b2112b1-f291-40ed-97f1-8ec258c8ebe3'),
	(116,NULL,'app','m181130_143040_fix_schema_version','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','2404bb2e-51d5-4cbc-bacc-1c3d8db3e2ea'),
	(117,NULL,'app','m181211_143040_fix_entry_type_uids','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','fd5d6781-7e27-4aad-bf71-9620594e8264'),
	(118,NULL,'app','m181213_102500_config_map_aliases','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','113c56d2-6ce4-4c2c-b756-c7e06756d0d2'),
	(119,NULL,'app','m181217_153000_fix_structure_uids','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','75140aa2-d5af-4db6-ad2c-897874ed9d8f'),
	(120,NULL,'app','m190104_152725_store_licensed_plugin_editions','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','b016486c-fc42-424e-a4eb-5e05976fc6bb'),
	(121,NULL,'app','m190108_110000_cleanup_project_config','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','a84bf068-49cd-48ab-9d20-bf47e77aa9b9'),
	(122,NULL,'app','m190108_113000_asset_field_setting_change','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','09c0cd93-f0f3-497c-a655-6ab626efa03c'),
	(123,NULL,'app','m190109_172845_fix_colspan','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','ddb41638-35ec-4168-833d-abb000d92874'),
	(124,NULL,'app','m190110_150000_prune_nonexisting_sites','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','54cf5649-9f78-4583-bd3d-7ffe2d4298f4'),
	(125,NULL,'app','m190110_214819_soft_delete_volumes','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','35df3098-f096-493e-93c2-2164dc246bc3'),
	(126,NULL,'app','m190112_124737_fix_user_settings','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','09e3d7a3-1182-488e-bd13-ebd1cffa998e'),
	(127,NULL,'app','m190112_131225_fix_field_layouts','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','9204b4a5-140f-4d8b-9cc2-9ae3ff7f7440'),
	(128,NULL,'app','m190112_201010_more_soft_deletes','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','1971cdbf-bcef-43f7-ba88-f5617da486b8'),
	(129,NULL,'app','m190114_143000_more_asset_field_setting_changes','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','4a83bedd-bf7c-4c00-8469-0041a5d24b3b'),
	(130,NULL,'app','m190121_120000_rich_text_config_setting','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','c4a8f8c0-fae7-4ad1-b8f1-0a2ea57bdf9f'),
	(131,NULL,'app','m190125_191628_fix_email_transport_password','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','aa49b249-7d06-4cdd-a7a0-9d7a9dc7e7de'),
	(132,NULL,'app','m190128_181422_cleanup_volume_folders','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','eb3131cd-dea1-4c3e-a6d6-047c35a5aa49'),
	(133,NULL,'app','m190205_140000_fix_asset_soft_delete_index','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','19065078-b7d2-4702-bf26-f15a57492636'),
	(134,NULL,'app','m190208_140000_reset_project_config_mapping','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','5b6c8487-d226-433e-b98d-96f8f81b2e56'),
	(135,NULL,'app','m190218_143000_element_index_settings_uid','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','6e21ff74-5f0d-4050-b80a-f20392115a5c'),
	(136,NULL,'app','m190312_152740_element_revisions','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','2b7abee2-6ca0-45cd-ad36-dd75ad74d0b1'),
	(137,NULL,'app','m190327_235137_propagation_method','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','4cc96b9d-88c6-4035-bfa1-3b2c0b9a3133'),
	(138,NULL,'app','m190401_223843_drop_old_indexes','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','03cb294e-75bc-422f-8d89-a13377a64762'),
	(139,NULL,'app','m190416_014525_drop_unique_global_indexes','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','e361a6a5-14f1-43c2-b355-f5a5d4848add'),
	(140,NULL,'app','m190417_085010_add_image_editor_permissions','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','16f371d1-5c50-423a-b761-f36ecb4c8ac9'),
	(141,NULL,'app','m190502_122019_store_default_user_group_uid','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','bc2dcd1e-a03b-4a53-8903-ba49fa6266e6'),
	(142,NULL,'app','m190504_150349_preview_targets','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','2266900b-7cd3-43e1-80a0-2e04d5f230ca'),
	(143,NULL,'app','m190516_184711_job_progress_label','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','487e6d06-8905-4c16-a58c-743da3732b93'),
	(144,NULL,'app','m190523_190303_optional_revision_creators','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','7fd69925-8d3b-44b4-af29-1a17160c6270'),
	(145,NULL,'app','m190529_204501_fix_duplicate_uids','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','ef7b19cd-8f04-4d8d-aa3d-c38486516de3'),
	(146,NULL,'app','m190605_223807_unsaved_drafts','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','98df026b-f5ce-4af2-81fa-7e67f5fbf3ac'),
	(147,NULL,'app','m190607_230042_entry_revision_error_tables','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','df2b0645-156c-47b3-8b36-3f40cc88fe19'),
	(148,NULL,'app','m190608_033429_drop_elements_uid_idx','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','75a3adea-d8f8-4e49-a07b-1b8491dacf4b'),
	(149,NULL,'app','m190617_164400_add_gqlschemas_table','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','3cf42afa-b842-4e51-bcdd-7442a380a6fc'),
	(150,NULL,'app','m190624_234204_matrix_propagation_method','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','c708c183-b656-4969-b6f4-b127f7be9856'),
	(151,NULL,'app','m190711_153020_drop_snapshots','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','9f0a9d76-8dc2-4cce-b93e-6122d6c10a94'),
	(152,NULL,'app','m190712_195914_no_draft_revisions','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','c2a84c9b-07e9-4e60-95fb-ebbba2493fd0'),
	(153,NULL,'app','m190723_140314_fix_preview_targets_column','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','44ae4e42-56e4-4d3c-b6b1-e91d780065b0'),
	(154,NULL,'app','m190820_003519_flush_compiled_templates','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','164633a4-f12c-449b-822c-b63cc501c2d8'),
	(155,NULL,'app','m190823_020339_optional_draft_creators','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','dd0e95a6-c977-4a1f-be1c-1b608c1ab34f'),
	(156,NULL,'app','m190913_152146_update_preview_targets','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','bb7f007c-fe6e-4bd7-adb4-d1cf1bc10869'),
	(157,NULL,'app','m191107_122000_add_gql_project_config_support','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','ff1446e0-892f-4c8e-ae07-9523fceb0240'),
	(158,NULL,'app','m191204_085100_pack_savable_component_settings','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','e169a121-9f5f-49dd-9940-6cad8cffbb4b'),
	(159,NULL,'app','m191206_001148_change_tracking','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','2247177a-8863-41e6-a52a-b3ae544e5b6d'),
	(160,NULL,'app','m191216_191635_asset_upload_tracking','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','ff2c8009-f78c-4057-8ee3-3a432ecef6df'),
	(161,NULL,'app','m191222_002848_peer_asset_permissions','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','714fc2e3-a224-480e-8400-a1d89f1c129e'),
	(162,NULL,'app','m200127_172522_queue_channels','2020-02-01 17:54:18','2020-02-01 17:54:18','2020-02-01 17:54:18','2e473542-afe3-487e-a903-22e5e0e2bc19'),
	(163,1,'plugin','Install','2020-02-01 18:34:44','2020-02-01 18:34:44','2020-02-01 18:34:44','e91294d8-4f98-4903-bb64-89719d5b288c'),
	(164,1,'plugin','m180314_002755_field_type','2020-02-01 18:34:44','2020-02-01 18:34:44','2020-02-01 18:34:44','057e63b9-9706-4d94-98f6-ee37122dbdba'),
	(165,1,'plugin','m180314_002756_base_install','2020-02-01 18:34:44','2020-02-01 18:34:44','2020-02-01 18:34:44','b340f6ee-d615-4e15-8991-931e94a87a5f'),
	(166,1,'plugin','m180502_202319_remove_field_metabundles','2020-02-01 18:34:44','2020-02-01 18:34:44','2020-02-01 18:34:44','d92e5655-7be6-4e82-9f98-a5cde8a361fc'),
	(167,1,'plugin','m180711_024947_commerce_products','2020-02-01 18:34:44','2020-02-01 18:34:44','2020-02-01 18:34:44','6ce8af26-84f6-4a14-90ea-9d76c6a2d1b6'),
	(168,1,'plugin','m190401_220828_longer_handles','2020-02-01 18:34:44','2020-02-01 18:34:44','2020-02-01 18:34:44','ab51b66a-1421-4e3e-b09b-cc32c1170ed7'),
	(169,1,'plugin','m190518_030221_calendar_events','2020-02-01 18:34:44','2020-02-01 18:34:44','2020-02-01 18:34:44','db722c0f-f150-41a0-89a5-6a255f7d57e5'),
	(170,2,'plugin','Install','2020-02-01 18:37:09','2020-02-01 18:37:09','2020-02-01 18:37:09','3d04f799-2d0e-4a2b-bebc-a3c39c7086f6'),
	(171,2,'plugin','m180305_000000_migrate_feeds','2020-02-01 18:37:09','2020-02-01 18:37:09','2020-02-01 18:37:09','98026932-106e-457f-b15a-13cee04bda4e'),
	(172,2,'plugin','m181113_000000_add_paginationNode','2020-02-01 18:37:09','2020-02-01 18:37:09','2020-02-01 18:37:09','9fb88994-2dde-4c99-8d89-c2d647621385'),
	(173,2,'plugin','m190201_000000_update_asset_feeds','2020-02-01 18:37:09','2020-02-01 18:37:09','2020-02-01 18:37:09','85f99e2d-e546-44d1-b47a-93c0005c1f9d'),
	(174,2,'plugin','m190320_000000_renameLocale','2020-02-01 18:37:09','2020-02-01 18:37:09','2020-02-01 18:37:09','eae727ed-9f2f-429b-b307-3839bf9ba879'),
	(175,2,'plugin','m190406_000000_sortOrder','2020-02-01 18:37:09','2020-02-01 18:37:09','2020-02-01 18:37:09','674487a5-b75a-4f65-adbc-57a8ee066905'),
	(176,3,'plugin','m180430_204710_remove_old_plugins','2020-02-01 20:59:55','2020-02-01 20:59:55','2020-02-01 20:59:55','e5f74dbc-85d7-4e5c-8d47-f9881850234c'),
	(177,3,'plugin','Install','2020-02-01 20:59:55','2020-02-01 20:59:55','2020-02-01 20:59:55','38244af7-590f-4347-ae49-065f4570e010'),
	(178,3,'plugin','m190225_003922_split_cleanup_html_settings','2020-02-01 20:59:55','2020-02-01 20:59:55','2020-02-01 20:59:55','63c3316d-da72-4266-ab32-439a17c6d4a3'),
	(179,NULL,'app','m200211_175048_truncate_element_query_cache','2020-02-23 23:43:57','2020-02-23 23:43:57','2020-02-23 23:43:57','4b394ce3-2054-4aad-8739-87233180dc09'),
	(180,NULL,'app','m200213_172522_new_elements_index','2020-02-23 23:43:57','2020-02-23 23:43:57','2020-02-23 23:43:57','f3ac25d4-6abd-4864-ba77-04aff509f0ba');

/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table plugins
# ------------------------------------------------------------

DROP TABLE IF EXISTS `plugins`;

CREATE TABLE `plugins` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `handle` varchar(255) NOT NULL,
  `version` varchar(255) NOT NULL,
  `schemaVersion` varchar(255) NOT NULL,
  `licenseKeyStatus` enum('valid','invalid','mismatched','astray','unknown') NOT NULL DEFAULT 'unknown',
  `licensedEdition` varchar(255) DEFAULT NULL,
  `installDate` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `plugins_handle_unq_idx` (`handle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `plugins` WRITE;
/*!40000 ALTER TABLE `plugins` DISABLE KEYS */;

INSERT INTO `plugins` (`id`, `handle`, `version`, `schemaVersion`, `licenseKeyStatus`, `licensedEdition`, `installDate`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,'seomatic','3.2.41','3.0.8','invalid',NULL,'2020-02-01 18:34:44','2020-02-01 18:34:44','2020-02-23 23:55:14','53dc127b-0245-4e27-bd67-6c101efdc68b'),
	(2,'feed-me','4.2.0.1','2.1.2','unknown',NULL,'2020-02-01 18:37:09','2020-02-01 18:37:09','2020-02-23 23:55:14','f502c60e-d82b-4984-b62a-7f28239e3d7d'),
	(3,'redactor','2.5.0','2.3.0','unknown',NULL,'2020-02-01 20:59:55','2020-02-01 20:59:55','2020-02-23 23:55:14','7822b0e0-cb15-452e-acbe-6883a56005e6'),
	(4,'command-palette','3.1.4','3.0.0','unknown',NULL,'2020-02-23 23:54:59','2020-02-23 23:54:59','2020-02-23 23:55:14','e93da1cd-725e-4ab4-b56c-a5d0c40e180e');

/*!40000 ALTER TABLE `plugins` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table projectconfig
# ------------------------------------------------------------

DROP TABLE IF EXISTS `projectconfig`;

CREATE TABLE `projectconfig` (
  `path` varchar(255) NOT NULL,
  `value` text NOT NULL,
  PRIMARY KEY (`path`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `projectconfig` WRITE;
/*!40000 ALTER TABLE `projectconfig` DISABLE KEYS */;

INSERT INTO `projectconfig` (`path`, `value`)
VALUES
	('categoryGroups.e8331de6-f36c-47ca-88ea-58d08765edc9.fieldLayouts.4690bc11-42da-4835-a37e-2102396f331b.tabs.0.fields.ef440483-c84f-4039-bdfd-3249561fe9fb.required','false'),
	('categoryGroups.e8331de6-f36c-47ca-88ea-58d08765edc9.fieldLayouts.4690bc11-42da-4835-a37e-2102396f331b.tabs.0.fields.ef440483-c84f-4039-bdfd-3249561fe9fb.sortOrder','1'),
	('categoryGroups.e8331de6-f36c-47ca-88ea-58d08765edc9.fieldLayouts.4690bc11-42da-4835-a37e-2102396f331b.tabs.0.name','\"Styles\"'),
	('categoryGroups.e8331de6-f36c-47ca-88ea-58d08765edc9.fieldLayouts.4690bc11-42da-4835-a37e-2102396f331b.tabs.0.sortOrder','1'),
	('categoryGroups.e8331de6-f36c-47ca-88ea-58d08765edc9.handle','\"drinkStyles\"'),
	('categoryGroups.e8331de6-f36c-47ca-88ea-58d08765edc9.name','\"Drink Styles\"'),
	('categoryGroups.e8331de6-f36c-47ca-88ea-58d08765edc9.siteSettings.b34dff01-1c91-4de4-ab83-84610f1405d7.hasUrls','true'),
	('categoryGroups.e8331de6-f36c-47ca-88ea-58d08765edc9.siteSettings.b34dff01-1c91-4de4-ab83-84610f1405d7.template','\"styles/_entry\"'),
	('categoryGroups.e8331de6-f36c-47ca-88ea-58d08765edc9.siteSettings.b34dff01-1c91-4de4-ab83-84610f1405d7.uriFormat','\"styles/{slug}\"'),
	('categoryGroups.e8331de6-f36c-47ca-88ea-58d08765edc9.structure.maxLevels','5'),
	('categoryGroups.e8331de6-f36c-47ca-88ea-58d08765edc9.structure.uid','\"7af3f7b7-0804-4bf7-9c3e-824031b4214b\"'),
	('dateModified','1582502099'),
	('email.fromEmail','\"ryan@mijingo.com\"'),
	('email.fromName','\"Crafty Coffee\"'),
	('email.transportType','\"craft\\\\mail\\\\transportadapters\\\\Sendmail\"'),
	('fieldGroups.3b6974a4-9d51-4345-a941-778edfff572f.name','\"Common\"'),
	('fieldGroups.5d80f4a5-fb02-449a-8ba7-ebddb8f75a13.name','\"News\"'),
	('fieldGroups.9c35720b-c811-4a45-b7b5-b2bc21e04771.name','\"About\"'),
	('fieldGroups.db2778d4-77e2-4d2c-bbc5-06e8b1f63667.name','\"Styles\"'),
	('fieldGroups.ee4b868b-862a-4514-89bf-c1627b334767.name','\"Drinks\"'),
	('fieldGroups.f1955e73-011b-4287-8fd2-2e9156f746c3.name','\"Recipes\"'),
	('fields.074c8fde-16e3-4d13-b76d-6aa448a652df.contentColumnType','\"text\"'),
	('fields.074c8fde-16e3-4d13-b76d-6aa448a652df.fieldGroup','\"ee4b868b-862a-4514-89bf-c1627b334767\"'),
	('fields.074c8fde-16e3-4d13-b76d-6aa448a652df.handle','\"introduction\"'),
	('fields.074c8fde-16e3-4d13-b76d-6aa448a652df.instructions','\"Short sentence at top of drink page. \"'),
	('fields.074c8fde-16e3-4d13-b76d-6aa448a652df.name','\"Introduction\"'),
	('fields.074c8fde-16e3-4d13-b76d-6aa448a652df.searchable','true'),
	('fields.074c8fde-16e3-4d13-b76d-6aa448a652df.settings.byteLimit','null'),
	('fields.074c8fde-16e3-4d13-b76d-6aa448a652df.settings.charLimit','null'),
	('fields.074c8fde-16e3-4d13-b76d-6aa448a652df.settings.code','\"\"'),
	('fields.074c8fde-16e3-4d13-b76d-6aa448a652df.settings.columnType','null'),
	('fields.074c8fde-16e3-4d13-b76d-6aa448a652df.settings.initialRows','\"4\"'),
	('fields.074c8fde-16e3-4d13-b76d-6aa448a652df.settings.multiline','\"\"'),
	('fields.074c8fde-16e3-4d13-b76d-6aa448a652df.settings.placeholder','\"\"'),
	('fields.074c8fde-16e3-4d13-b76d-6aa448a652df.translationKeyFormat','null'),
	('fields.074c8fde-16e3-4d13-b76d-6aa448a652df.translationMethod','\"none\"'),
	('fields.074c8fde-16e3-4d13-b76d-6aa448a652df.type','\"craft\\\\fields\\\\PlainText\"'),
	('fields.479c8046-8ddf-451a-9c73-c31398b7da01.contentColumnType','\"string\"'),
	('fields.479c8046-8ddf-451a-9c73-c31398b7da01.fieldGroup','\"ee4b868b-862a-4514-89bf-c1627b334767\"'),
	('fields.479c8046-8ddf-451a-9c73-c31398b7da01.handle','\"drinkImage\"'),
	('fields.479c8046-8ddf-451a-9c73-c31398b7da01.instructions','\"\"'),
	('fields.479c8046-8ddf-451a-9c73-c31398b7da01.name','\"Drink Image\"'),
	('fields.479c8046-8ddf-451a-9c73-c31398b7da01.searchable','true'),
	('fields.479c8046-8ddf-451a-9c73-c31398b7da01.settings.allowedKinds.0','\"image\"'),
	('fields.479c8046-8ddf-451a-9c73-c31398b7da01.settings.defaultUploadLocationSource','\"volume:679feb39-d56f-43cf-9b9a-5c4009fa2324\"'),
	('fields.479c8046-8ddf-451a-9c73-c31398b7da01.settings.defaultUploadLocationSubpath','\"\"'),
	('fields.479c8046-8ddf-451a-9c73-c31398b7da01.settings.limit','\"1\"'),
	('fields.479c8046-8ddf-451a-9c73-c31398b7da01.settings.localizeRelations','false'),
	('fields.479c8046-8ddf-451a-9c73-c31398b7da01.settings.restrictFiles','\"1\"'),
	('fields.479c8046-8ddf-451a-9c73-c31398b7da01.settings.selectionLabel','\"Add a drink image\"'),
	('fields.479c8046-8ddf-451a-9c73-c31398b7da01.settings.showUnpermittedFiles','false'),
	('fields.479c8046-8ddf-451a-9c73-c31398b7da01.settings.showUnpermittedVolumes','false'),
	('fields.479c8046-8ddf-451a-9c73-c31398b7da01.settings.singleUploadLocationSource','\"volume:679feb39-d56f-43cf-9b9a-5c4009fa2324\"'),
	('fields.479c8046-8ddf-451a-9c73-c31398b7da01.settings.singleUploadLocationSubpath','\"\"'),
	('fields.479c8046-8ddf-451a-9c73-c31398b7da01.settings.source','null'),
	('fields.479c8046-8ddf-451a-9c73-c31398b7da01.settings.sources.0','\"volume:679feb39-d56f-43cf-9b9a-5c4009fa2324\"'),
	('fields.479c8046-8ddf-451a-9c73-c31398b7da01.settings.targetSiteId','null'),
	('fields.479c8046-8ddf-451a-9c73-c31398b7da01.settings.useSingleFolder','false'),
	('fields.479c8046-8ddf-451a-9c73-c31398b7da01.settings.validateRelatedElements','\"\"'),
	('fields.479c8046-8ddf-451a-9c73-c31398b7da01.settings.viewMode','\"large\"'),
	('fields.479c8046-8ddf-451a-9c73-c31398b7da01.translationKeyFormat','null'),
	('fields.479c8046-8ddf-451a-9c73-c31398b7da01.translationMethod','\"site\"'),
	('fields.479c8046-8ddf-451a-9c73-c31398b7da01.type','\"craft\\\\fields\\\\Assets\"'),
	('fields.4d09f665-5d14-4ba3-b0d7-b901a4eae2f0.contentColumnType','\"string\"'),
	('fields.4d09f665-5d14-4ba3-b0d7-b901a4eae2f0.fieldGroup','\"ee4b868b-862a-4514-89bf-c1627b334767\"'),
	('fields.4d09f665-5d14-4ba3-b0d7-b901a4eae2f0.handle','\"drinkRecipe\"'),
	('fields.4d09f665-5d14-4ba3-b0d7-b901a4eae2f0.instructions','\"\"'),
	('fields.4d09f665-5d14-4ba3-b0d7-b901a4eae2f0.name','\"Drink Recipe\"'),
	('fields.4d09f665-5d14-4ba3-b0d7-b901a4eae2f0.searchable','true'),
	('fields.4d09f665-5d14-4ba3-b0d7-b901a4eae2f0.settings.limit','\"1\"'),
	('fields.4d09f665-5d14-4ba3-b0d7-b901a4eae2f0.settings.localizeRelations','false'),
	('fields.4d09f665-5d14-4ba3-b0d7-b901a4eae2f0.settings.selectionLabel','\"Add a drink recipe\"'),
	('fields.4d09f665-5d14-4ba3-b0d7-b901a4eae2f0.settings.source','null'),
	('fields.4d09f665-5d14-4ba3-b0d7-b901a4eae2f0.settings.sources.0','\"section:c828d52a-d271-4b70-89a7-f6865c41ae33\"'),
	('fields.4d09f665-5d14-4ba3-b0d7-b901a4eae2f0.settings.targetSiteId','null'),
	('fields.4d09f665-5d14-4ba3-b0d7-b901a4eae2f0.settings.validateRelatedElements','\"\"'),
	('fields.4d09f665-5d14-4ba3-b0d7-b901a4eae2f0.settings.viewMode','null'),
	('fields.4d09f665-5d14-4ba3-b0d7-b901a4eae2f0.translationKeyFormat','null'),
	('fields.4d09f665-5d14-4ba3-b0d7-b901a4eae2f0.translationMethod','\"site\"'),
	('fields.4d09f665-5d14-4ba3-b0d7-b901a4eae2f0.type','\"craft\\\\fields\\\\Entries\"'),
	('fields.54bb063c-5936-4bf3-bc9a-85c89a1219e6.contentColumnType','\"text\"'),
	('fields.54bb063c-5936-4bf3-bc9a-85c89a1219e6.fieldGroup','\"9c35720b-c811-4a45-b7b5-b2bc21e04771\"'),
	('fields.54bb063c-5936-4bf3-bc9a-85c89a1219e6.handle','\"pageIntro\"'),
	('fields.54bb063c-5936-4bf3-bc9a-85c89a1219e6.instructions','\"\"'),
	('fields.54bb063c-5936-4bf3-bc9a-85c89a1219e6.name','\"Page Intro\"'),
	('fields.54bb063c-5936-4bf3-bc9a-85c89a1219e6.searchable','true'),
	('fields.54bb063c-5936-4bf3-bc9a-85c89a1219e6.settings.byteLimit','null'),
	('fields.54bb063c-5936-4bf3-bc9a-85c89a1219e6.settings.charLimit','null'),
	('fields.54bb063c-5936-4bf3-bc9a-85c89a1219e6.settings.code','\"\"'),
	('fields.54bb063c-5936-4bf3-bc9a-85c89a1219e6.settings.columnType','null'),
	('fields.54bb063c-5936-4bf3-bc9a-85c89a1219e6.settings.initialRows','\"4\"'),
	('fields.54bb063c-5936-4bf3-bc9a-85c89a1219e6.settings.multiline','\"\"'),
	('fields.54bb063c-5936-4bf3-bc9a-85c89a1219e6.settings.placeholder','\"\"'),
	('fields.54bb063c-5936-4bf3-bc9a-85c89a1219e6.translationKeyFormat','null'),
	('fields.54bb063c-5936-4bf3-bc9a-85c89a1219e6.translationMethod','\"none\"'),
	('fields.54bb063c-5936-4bf3-bc9a-85c89a1219e6.type','\"craft\\\\fields\\\\PlainText\"'),
	('fields.7df7941d-1e86-4a49-ab03-7ab8719f88b9.contentColumnType','\"text\"'),
	('fields.7df7941d-1e86-4a49-ab03-7ab8719f88b9.fieldGroup','\"3b6974a4-9d51-4345-a941-778edfff572f\"'),
	('fields.7df7941d-1e86-4a49-ab03-7ab8719f88b9.handle','\"excerpt\"'),
	('fields.7df7941d-1e86-4a49-ab03-7ab8719f88b9.instructions','\"\"'),
	('fields.7df7941d-1e86-4a49-ab03-7ab8719f88b9.name','\"Excerpt\"'),
	('fields.7df7941d-1e86-4a49-ab03-7ab8719f88b9.searchable','true'),
	('fields.7df7941d-1e86-4a49-ab03-7ab8719f88b9.settings.byteLimit','null'),
	('fields.7df7941d-1e86-4a49-ab03-7ab8719f88b9.settings.charLimit','null'),
	('fields.7df7941d-1e86-4a49-ab03-7ab8719f88b9.settings.code','\"\"'),
	('fields.7df7941d-1e86-4a49-ab03-7ab8719f88b9.settings.columnType','null'),
	('fields.7df7941d-1e86-4a49-ab03-7ab8719f88b9.settings.initialRows','\"4\"'),
	('fields.7df7941d-1e86-4a49-ab03-7ab8719f88b9.settings.multiline','\"\"'),
	('fields.7df7941d-1e86-4a49-ab03-7ab8719f88b9.settings.placeholder','\"\"'),
	('fields.7df7941d-1e86-4a49-ab03-7ab8719f88b9.translationKeyFormat','null'),
	('fields.7df7941d-1e86-4a49-ab03-7ab8719f88b9.translationMethod','\"none\"'),
	('fields.7df7941d-1e86-4a49-ab03-7ab8719f88b9.type','\"craft\\\\fields\\\\PlainText\"'),
	('fields.a6e1ddbb-d173-474a-9b71-eeb5805708dd.contentColumnType','\"string\"'),
	('fields.a6e1ddbb-d173-474a-9b71-eeb5805708dd.fieldGroup','\"db2778d4-77e2-4d2c-bbc5-06e8b1f63667\"'),
	('fields.a6e1ddbb-d173-474a-9b71-eeb5805708dd.handle','\"drinkStyle\"'),
	('fields.a6e1ddbb-d173-474a-9b71-eeb5805708dd.instructions','\"\"'),
	('fields.a6e1ddbb-d173-474a-9b71-eeb5805708dd.name','\"Drink Style\"'),
	('fields.a6e1ddbb-d173-474a-9b71-eeb5805708dd.searchable','true'),
	('fields.a6e1ddbb-d173-474a-9b71-eeb5805708dd.settings.allowLimit','false'),
	('fields.a6e1ddbb-d173-474a-9b71-eeb5805708dd.settings.allowMultipleSources','false'),
	('fields.a6e1ddbb-d173-474a-9b71-eeb5805708dd.settings.branchLimit','\"1\"'),
	('fields.a6e1ddbb-d173-474a-9b71-eeb5805708dd.settings.limit','null'),
	('fields.a6e1ddbb-d173-474a-9b71-eeb5805708dd.settings.localizeRelations','false'),
	('fields.a6e1ddbb-d173-474a-9b71-eeb5805708dd.settings.selectionLabel','\"Add a drink style\"'),
	('fields.a6e1ddbb-d173-474a-9b71-eeb5805708dd.settings.source','\"group:e8331de6-f36c-47ca-88ea-58d08765edc9\"'),
	('fields.a6e1ddbb-d173-474a-9b71-eeb5805708dd.settings.sources','\"*\"'),
	('fields.a6e1ddbb-d173-474a-9b71-eeb5805708dd.settings.targetSiteId','null'),
	('fields.a6e1ddbb-d173-474a-9b71-eeb5805708dd.settings.validateRelatedElements','\"\"'),
	('fields.a6e1ddbb-d173-474a-9b71-eeb5805708dd.settings.viewMode','null'),
	('fields.a6e1ddbb-d173-474a-9b71-eeb5805708dd.translationKeyFormat','null'),
	('fields.a6e1ddbb-d173-474a-9b71-eeb5805708dd.translationMethod','\"site\"'),
	('fields.a6e1ddbb-d173-474a-9b71-eeb5805708dd.type','\"craft\\\\fields\\\\Categories\"'),
	('fields.c2802d29-16d2-4e5f-8401-92321167c0e5.contentColumnType','\"text\"'),
	('fields.c2802d29-16d2-4e5f-8401-92321167c0e5.fieldGroup','\"ee4b868b-862a-4514-89bf-c1627b334767\"'),
	('fields.c2802d29-16d2-4e5f-8401-92321167c0e5.handle','\"pageCopy\"'),
	('fields.c2802d29-16d2-4e5f-8401-92321167c0e5.instructions','\"\"'),
	('fields.c2802d29-16d2-4e5f-8401-92321167c0e5.name','\"Page Copy\"'),
	('fields.c2802d29-16d2-4e5f-8401-92321167c0e5.searchable','true'),
	('fields.c2802d29-16d2-4e5f-8401-92321167c0e5.settings.availableTransforms','\"*\"'),
	('fields.c2802d29-16d2-4e5f-8401-92321167c0e5.settings.availableVolumes','\"*\"'),
	('fields.c2802d29-16d2-4e5f-8401-92321167c0e5.settings.cleanupHtml','true'),
	('fields.c2802d29-16d2-4e5f-8401-92321167c0e5.settings.columnType','\"text\"'),
	('fields.c2802d29-16d2-4e5f-8401-92321167c0e5.settings.purifierConfig','\"\"'),
	('fields.c2802d29-16d2-4e5f-8401-92321167c0e5.settings.purifyHtml','\"1\"'),
	('fields.c2802d29-16d2-4e5f-8401-92321167c0e5.settings.redactorConfig','\"Standard.json\"'),
	('fields.c2802d29-16d2-4e5f-8401-92321167c0e5.settings.removeEmptyTags','\"1\"'),
	('fields.c2802d29-16d2-4e5f-8401-92321167c0e5.settings.removeInlineStyles','\"1\"'),
	('fields.c2802d29-16d2-4e5f-8401-92321167c0e5.settings.removeNbsp','\"1\"'),
	('fields.c2802d29-16d2-4e5f-8401-92321167c0e5.translationKeyFormat','null'),
	('fields.c2802d29-16d2-4e5f-8401-92321167c0e5.translationMethod','\"none\"'),
	('fields.c2802d29-16d2-4e5f-8401-92321167c0e5.type','\"craft\\\\redactor\\\\Field\"'),
	('fields.c335386c-416d-422b-ab7d-a6390613287a.contentColumnType','\"string\"'),
	('fields.c335386c-416d-422b-ab7d-a6390613287a.fieldGroup','\"f1955e73-011b-4287-8fd2-2e9156f746c3\"'),
	('fields.c335386c-416d-422b-ab7d-a6390613287a.handle','\"recipeContents\"'),
	('fields.c335386c-416d-422b-ab7d-a6390613287a.instructions','\"\"'),
	('fields.c335386c-416d-422b-ab7d-a6390613287a.name','\"Recipe Contents\"'),
	('fields.c335386c-416d-422b-ab7d-a6390613287a.searchable','true'),
	('fields.c335386c-416d-422b-ab7d-a6390613287a.settings.contentTable','\"{{%matrixcontent_recipecontents}}\"'),
	('fields.c335386c-416d-422b-ab7d-a6390613287a.settings.maxBlocks','\"\"'),
	('fields.c335386c-416d-422b-ab7d-a6390613287a.settings.minBlocks','\"\"'),
	('fields.c335386c-416d-422b-ab7d-a6390613287a.settings.propagationMethod','\"all\"'),
	('fields.c335386c-416d-422b-ab7d-a6390613287a.translationKeyFormat','null'),
	('fields.c335386c-416d-422b-ab7d-a6390613287a.translationMethod','\"site\"'),
	('fields.c335386c-416d-422b-ab7d-a6390613287a.type','\"craft\\\\fields\\\\Matrix\"'),
	('fields.dad89190-0d91-462f-88dd-4d1ac49c4f66.contentColumnType','\"text\"'),
	('fields.dad89190-0d91-462f-88dd-4d1ac49c4f66.fieldGroup','\"9c35720b-c811-4a45-b7b5-b2bc21e04771\"'),
	('fields.dad89190-0d91-462f-88dd-4d1ac49c4f66.handle','\"subtitle\"'),
	('fields.dad89190-0d91-462f-88dd-4d1ac49c4f66.instructions','\"\"'),
	('fields.dad89190-0d91-462f-88dd-4d1ac49c4f66.name','\"Subtitle\"'),
	('fields.dad89190-0d91-462f-88dd-4d1ac49c4f66.searchable','true'),
	('fields.dad89190-0d91-462f-88dd-4d1ac49c4f66.settings.byteLimit','null'),
	('fields.dad89190-0d91-462f-88dd-4d1ac49c4f66.settings.charLimit','null'),
	('fields.dad89190-0d91-462f-88dd-4d1ac49c4f66.settings.code','\"\"'),
	('fields.dad89190-0d91-462f-88dd-4d1ac49c4f66.settings.columnType','null'),
	('fields.dad89190-0d91-462f-88dd-4d1ac49c4f66.settings.initialRows','\"4\"'),
	('fields.dad89190-0d91-462f-88dd-4d1ac49c4f66.settings.multiline','\"\"'),
	('fields.dad89190-0d91-462f-88dd-4d1ac49c4f66.settings.placeholder','\"\"'),
	('fields.dad89190-0d91-462f-88dd-4d1ac49c4f66.translationKeyFormat','null'),
	('fields.dad89190-0d91-462f-88dd-4d1ac49c4f66.translationMethod','\"none\"'),
	('fields.dad89190-0d91-462f-88dd-4d1ac49c4f66.type','\"craft\\\\fields\\\\PlainText\"'),
	('fields.e59589de-cf68-450b-9d7c-a57576c03f36.contentColumnType','\"text\"'),
	('fields.e59589de-cf68-450b-9d7c-a57576c03f36.fieldGroup','\"5d80f4a5-fb02-449a-8ba7-ebddb8f75a13\"'),
	('fields.e59589de-cf68-450b-9d7c-a57576c03f36.handle','\"newsBody\"'),
	('fields.e59589de-cf68-450b-9d7c-a57576c03f36.instructions','\"\"'),
	('fields.e59589de-cf68-450b-9d7c-a57576c03f36.name','\"News Body\"'),
	('fields.e59589de-cf68-450b-9d7c-a57576c03f36.searchable','true'),
	('fields.e59589de-cf68-450b-9d7c-a57576c03f36.settings.availableTransforms','\"*\"'),
	('fields.e59589de-cf68-450b-9d7c-a57576c03f36.settings.availableVolumes','\"*\"'),
	('fields.e59589de-cf68-450b-9d7c-a57576c03f36.settings.cleanupHtml','true'),
	('fields.e59589de-cf68-450b-9d7c-a57576c03f36.settings.columnType','\"text\"'),
	('fields.e59589de-cf68-450b-9d7c-a57576c03f36.settings.purifierConfig','\"\"'),
	('fields.e59589de-cf68-450b-9d7c-a57576c03f36.settings.purifyHtml','\"1\"'),
	('fields.e59589de-cf68-450b-9d7c-a57576c03f36.settings.redactorConfig','\"\"'),
	('fields.e59589de-cf68-450b-9d7c-a57576c03f36.settings.removeEmptyTags','\"1\"'),
	('fields.e59589de-cf68-450b-9d7c-a57576c03f36.settings.removeInlineStyles','\"1\"'),
	('fields.e59589de-cf68-450b-9d7c-a57576c03f36.settings.removeNbsp','\"1\"'),
	('fields.e59589de-cf68-450b-9d7c-a57576c03f36.translationKeyFormat','null'),
	('fields.e59589de-cf68-450b-9d7c-a57576c03f36.translationMethod','\"none\"'),
	('fields.e59589de-cf68-450b-9d7c-a57576c03f36.type','\"craft\\\\redactor\\\\Field\"'),
	('fields.ef440483-c84f-4039-bdfd-3249561fe9fb.contentColumnType','\"text\"'),
	('fields.ef440483-c84f-4039-bdfd-3249561fe9fb.fieldGroup','\"db2778d4-77e2-4d2c-bbc5-06e8b1f63667\"'),
	('fields.ef440483-c84f-4039-bdfd-3249561fe9fb.handle','\"styleDescription\"'),
	('fields.ef440483-c84f-4039-bdfd-3249561fe9fb.instructions','\"\"'),
	('fields.ef440483-c84f-4039-bdfd-3249561fe9fb.name','\"Style Description\"'),
	('fields.ef440483-c84f-4039-bdfd-3249561fe9fb.searchable','true'),
	('fields.ef440483-c84f-4039-bdfd-3249561fe9fb.settings.byteLimit','null'),
	('fields.ef440483-c84f-4039-bdfd-3249561fe9fb.settings.charLimit','null'),
	('fields.ef440483-c84f-4039-bdfd-3249561fe9fb.settings.code','\"\"'),
	('fields.ef440483-c84f-4039-bdfd-3249561fe9fb.settings.columnType','null'),
	('fields.ef440483-c84f-4039-bdfd-3249561fe9fb.settings.initialRows','\"4\"'),
	('fields.ef440483-c84f-4039-bdfd-3249561fe9fb.settings.multiline','\"1\"'),
	('fields.ef440483-c84f-4039-bdfd-3249561fe9fb.settings.placeholder','\"\"'),
	('fields.ef440483-c84f-4039-bdfd-3249561fe9fb.translationKeyFormat','null'),
	('fields.ef440483-c84f-4039-bdfd-3249561fe9fb.translationMethod','\"none\"'),
	('fields.ef440483-c84f-4039-bdfd-3249561fe9fb.type','\"craft\\\\fields\\\\PlainText\"'),
	('graphql.schemas.b7e76599-2010-4217-a546-937b5d3fa0e7.isPublic','true'),
	('graphql.schemas.b7e76599-2010-4217-a546-937b5d3fa0e7.name','\"Public Schema\"'),
	('imageTransforms.e3377f7e-711b-46db-8988-88dd06c0b202.format','null'),
	('imageTransforms.e3377f7e-711b-46db-8988-88dd06c0b202.handle','\"EightFortyTwoHundredThumb\"'),
	('imageTransforms.e3377f7e-711b-46db-8988-88dd06c0b202.height','200'),
	('imageTransforms.e3377f7e-711b-46db-8988-88dd06c0b202.interlace','\"none\"'),
	('imageTransforms.e3377f7e-711b-46db-8988-88dd06c0b202.mode','\"crop\"'),
	('imageTransforms.e3377f7e-711b-46db-8988-88dd06c0b202.name','\"840x200 Thumb\"'),
	('imageTransforms.e3377f7e-711b-46db-8988-88dd06c0b202.position','\"center-center\"'),
	('imageTransforms.e3377f7e-711b-46db-8988-88dd06c0b202.quality','null'),
	('imageTransforms.e3377f7e-711b-46db-8988-88dd06c0b202.width','840'),
	('matrixBlockTypes.0e0962e4-e4b0-4083-b63b-9906481a6e0b.field','\"c335386c-416d-422b-ab7d-a6390613287a\"'),
	('matrixBlockTypes.0e0962e4-e4b0-4083-b63b-9906481a6e0b.fieldLayouts.fa174242-6bd2-46a6-8608-35da9799cc6f.tabs.0.fields.b03a2cff-e3e4-4c3a-b6a6-c3e8c781c2ee.required','false'),
	('matrixBlockTypes.0e0962e4-e4b0-4083-b63b-9906481a6e0b.fieldLayouts.fa174242-6bd2-46a6-8608-35da9799cc6f.tabs.0.fields.b03a2cff-e3e4-4c3a-b6a6-c3e8c781c2ee.sortOrder','1'),
	('matrixBlockTypes.0e0962e4-e4b0-4083-b63b-9906481a6e0b.fieldLayouts.fa174242-6bd2-46a6-8608-35da9799cc6f.tabs.0.fields.e2a289f9-4e7a-4b22-b722-afe735c924c2.required','false'),
	('matrixBlockTypes.0e0962e4-e4b0-4083-b63b-9906481a6e0b.fieldLayouts.fa174242-6bd2-46a6-8608-35da9799cc6f.tabs.0.fields.e2a289f9-4e7a-4b22-b722-afe735c924c2.sortOrder','2'),
	('matrixBlockTypes.0e0962e4-e4b0-4083-b63b-9906481a6e0b.fieldLayouts.fa174242-6bd2-46a6-8608-35da9799cc6f.tabs.0.name','\"Content\"'),
	('matrixBlockTypes.0e0962e4-e4b0-4083-b63b-9906481a6e0b.fieldLayouts.fa174242-6bd2-46a6-8608-35da9799cc6f.tabs.0.sortOrder','1'),
	('matrixBlockTypes.0e0962e4-e4b0-4083-b63b-9906481a6e0b.fields.b03a2cff-e3e4-4c3a-b6a6-c3e8c781c2ee.contentColumnType','\"text\"'),
	('matrixBlockTypes.0e0962e4-e4b0-4083-b63b-9906481a6e0b.fields.b03a2cff-e3e4-4c3a-b6a6-c3e8c781c2ee.fieldGroup','null'),
	('matrixBlockTypes.0e0962e4-e4b0-4083-b63b-9906481a6e0b.fields.b03a2cff-e3e4-4c3a-b6a6-c3e8c781c2ee.handle','\"stepsTitle\"'),
	('matrixBlockTypes.0e0962e4-e4b0-4083-b63b-9906481a6e0b.fields.b03a2cff-e3e4-4c3a-b6a6-c3e8c781c2ee.instructions','\"\"'),
	('matrixBlockTypes.0e0962e4-e4b0-4083-b63b-9906481a6e0b.fields.b03a2cff-e3e4-4c3a-b6a6-c3e8c781c2ee.name','\"Steps Title\"'),
	('matrixBlockTypes.0e0962e4-e4b0-4083-b63b-9906481a6e0b.fields.b03a2cff-e3e4-4c3a-b6a6-c3e8c781c2ee.searchable','true'),
	('matrixBlockTypes.0e0962e4-e4b0-4083-b63b-9906481a6e0b.fields.b03a2cff-e3e4-4c3a-b6a6-c3e8c781c2ee.settings.byteLimit','null'),
	('matrixBlockTypes.0e0962e4-e4b0-4083-b63b-9906481a6e0b.fields.b03a2cff-e3e4-4c3a-b6a6-c3e8c781c2ee.settings.charLimit','null'),
	('matrixBlockTypes.0e0962e4-e4b0-4083-b63b-9906481a6e0b.fields.b03a2cff-e3e4-4c3a-b6a6-c3e8c781c2ee.settings.code','\"\"'),
	('matrixBlockTypes.0e0962e4-e4b0-4083-b63b-9906481a6e0b.fields.b03a2cff-e3e4-4c3a-b6a6-c3e8c781c2ee.settings.columnType','null'),
	('matrixBlockTypes.0e0962e4-e4b0-4083-b63b-9906481a6e0b.fields.b03a2cff-e3e4-4c3a-b6a6-c3e8c781c2ee.settings.initialRows','\"4\"'),
	('matrixBlockTypes.0e0962e4-e4b0-4083-b63b-9906481a6e0b.fields.b03a2cff-e3e4-4c3a-b6a6-c3e8c781c2ee.settings.multiline','\"\"'),
	('matrixBlockTypes.0e0962e4-e4b0-4083-b63b-9906481a6e0b.fields.b03a2cff-e3e4-4c3a-b6a6-c3e8c781c2ee.settings.placeholder','\"\"'),
	('matrixBlockTypes.0e0962e4-e4b0-4083-b63b-9906481a6e0b.fields.b03a2cff-e3e4-4c3a-b6a6-c3e8c781c2ee.translationKeyFormat','null'),
	('matrixBlockTypes.0e0962e4-e4b0-4083-b63b-9906481a6e0b.fields.b03a2cff-e3e4-4c3a-b6a6-c3e8c781c2ee.translationMethod','\"none\"'),
	('matrixBlockTypes.0e0962e4-e4b0-4083-b63b-9906481a6e0b.fields.b03a2cff-e3e4-4c3a-b6a6-c3e8c781c2ee.type','\"craft\\\\fields\\\\PlainText\"'),
	('matrixBlockTypes.0e0962e4-e4b0-4083-b63b-9906481a6e0b.fields.e2a289f9-4e7a-4b22-b722-afe735c924c2.contentColumnType','\"text\"'),
	('matrixBlockTypes.0e0962e4-e4b0-4083-b63b-9906481a6e0b.fields.e2a289f9-4e7a-4b22-b722-afe735c924c2.fieldGroup','null'),
	('matrixBlockTypes.0e0962e4-e4b0-4083-b63b-9906481a6e0b.fields.e2a289f9-4e7a-4b22-b722-afe735c924c2.handle','\"stepsContent\"'),
	('matrixBlockTypes.0e0962e4-e4b0-4083-b63b-9906481a6e0b.fields.e2a289f9-4e7a-4b22-b722-afe735c924c2.instructions','\"\"'),
	('matrixBlockTypes.0e0962e4-e4b0-4083-b63b-9906481a6e0b.fields.e2a289f9-4e7a-4b22-b722-afe735c924c2.name','\"Steps Content\"'),
	('matrixBlockTypes.0e0962e4-e4b0-4083-b63b-9906481a6e0b.fields.e2a289f9-4e7a-4b22-b722-afe735c924c2.searchable','true'),
	('matrixBlockTypes.0e0962e4-e4b0-4083-b63b-9906481a6e0b.fields.e2a289f9-4e7a-4b22-b722-afe735c924c2.settings.addRowLabel','\"Add a row\"'),
	('matrixBlockTypes.0e0962e4-e4b0-4083-b63b-9906481a6e0b.fields.e2a289f9-4e7a-4b22-b722-afe735c924c2.settings.columns.__assoc__.0.0','\"col1\"'),
	('matrixBlockTypes.0e0962e4-e4b0-4083-b63b-9906481a6e0b.fields.e2a289f9-4e7a-4b22-b722-afe735c924c2.settings.columns.__assoc__.0.1.__assoc__.0.0','\"heading\"'),
	('matrixBlockTypes.0e0962e4-e4b0-4083-b63b-9906481a6e0b.fields.e2a289f9-4e7a-4b22-b722-afe735c924c2.settings.columns.__assoc__.0.1.__assoc__.0.1','\"Step Instructions\"'),
	('matrixBlockTypes.0e0962e4-e4b0-4083-b63b-9906481a6e0b.fields.e2a289f9-4e7a-4b22-b722-afe735c924c2.settings.columns.__assoc__.0.1.__assoc__.1.0','\"handle\"'),
	('matrixBlockTypes.0e0962e4-e4b0-4083-b63b-9906481a6e0b.fields.e2a289f9-4e7a-4b22-b722-afe735c924c2.settings.columns.__assoc__.0.1.__assoc__.1.1','\"stepInstructions\"'),
	('matrixBlockTypes.0e0962e4-e4b0-4083-b63b-9906481a6e0b.fields.e2a289f9-4e7a-4b22-b722-afe735c924c2.settings.columns.__assoc__.0.1.__assoc__.2.0','\"width\"'),
	('matrixBlockTypes.0e0962e4-e4b0-4083-b63b-9906481a6e0b.fields.e2a289f9-4e7a-4b22-b722-afe735c924c2.settings.columns.__assoc__.0.1.__assoc__.2.1','\"\"'),
	('matrixBlockTypes.0e0962e4-e4b0-4083-b63b-9906481a6e0b.fields.e2a289f9-4e7a-4b22-b722-afe735c924c2.settings.columns.__assoc__.0.1.__assoc__.3.0','\"type\"'),
	('matrixBlockTypes.0e0962e4-e4b0-4083-b63b-9906481a6e0b.fields.e2a289f9-4e7a-4b22-b722-afe735c924c2.settings.columns.__assoc__.0.1.__assoc__.3.1','\"multiline\"'),
	('matrixBlockTypes.0e0962e4-e4b0-4083-b63b-9906481a6e0b.fields.e2a289f9-4e7a-4b22-b722-afe735c924c2.settings.columnType','\"text\"'),
	('matrixBlockTypes.0e0962e4-e4b0-4083-b63b-9906481a6e0b.fields.e2a289f9-4e7a-4b22-b722-afe735c924c2.settings.maxRows','\"\"'),
	('matrixBlockTypes.0e0962e4-e4b0-4083-b63b-9906481a6e0b.fields.e2a289f9-4e7a-4b22-b722-afe735c924c2.settings.minRows','\"\"'),
	('matrixBlockTypes.0e0962e4-e4b0-4083-b63b-9906481a6e0b.fields.e2a289f9-4e7a-4b22-b722-afe735c924c2.translationKeyFormat','null'),
	('matrixBlockTypes.0e0962e4-e4b0-4083-b63b-9906481a6e0b.fields.e2a289f9-4e7a-4b22-b722-afe735c924c2.translationMethod','\"none\"'),
	('matrixBlockTypes.0e0962e4-e4b0-4083-b63b-9906481a6e0b.fields.e2a289f9-4e7a-4b22-b722-afe735c924c2.type','\"craft\\\\fields\\\\Table\"'),
	('matrixBlockTypes.0e0962e4-e4b0-4083-b63b-9906481a6e0b.handle','\"recipeSteps\"'),
	('matrixBlockTypes.0e0962e4-e4b0-4083-b63b-9906481a6e0b.name','\"Recipe Steps\"'),
	('matrixBlockTypes.0e0962e4-e4b0-4083-b63b-9906481a6e0b.sortOrder','4'),
	('matrixBlockTypes.17260a44-4415-4ac9-a021-0fb47c72adc6.field','\"c335386c-416d-422b-ab7d-a6390613287a\"'),
	('matrixBlockTypes.17260a44-4415-4ac9-a021-0fb47c72adc6.fieldLayouts.863d3279-5a88-4549-9141-55fe48eaf17b.tabs.0.fields.ae1f295a-8164-4b75-b727-e7c2d20e5d02.required','false'),
	('matrixBlockTypes.17260a44-4415-4ac9-a021-0fb47c72adc6.fieldLayouts.863d3279-5a88-4549-9141-55fe48eaf17b.tabs.0.fields.ae1f295a-8164-4b75-b727-e7c2d20e5d02.sortOrder','1'),
	('matrixBlockTypes.17260a44-4415-4ac9-a021-0fb47c72adc6.fieldLayouts.863d3279-5a88-4549-9141-55fe48eaf17b.tabs.0.name','\"Content\"'),
	('matrixBlockTypes.17260a44-4415-4ac9-a021-0fb47c72adc6.fieldLayouts.863d3279-5a88-4549-9141-55fe48eaf17b.tabs.0.sortOrder','1'),
	('matrixBlockTypes.17260a44-4415-4ac9-a021-0fb47c72adc6.fields.ae1f295a-8164-4b75-b727-e7c2d20e5d02.contentColumnType','\"text\"'),
	('matrixBlockTypes.17260a44-4415-4ac9-a021-0fb47c72adc6.fields.ae1f295a-8164-4b75-b727-e7c2d20e5d02.fieldGroup','null'),
	('matrixBlockTypes.17260a44-4415-4ac9-a021-0fb47c72adc6.fields.ae1f295a-8164-4b75-b727-e7c2d20e5d02.handle','\"ingredients\"'),
	('matrixBlockTypes.17260a44-4415-4ac9-a021-0fb47c72adc6.fields.ae1f295a-8164-4b75-b727-e7c2d20e5d02.instructions','\"\"'),
	('matrixBlockTypes.17260a44-4415-4ac9-a021-0fb47c72adc6.fields.ae1f295a-8164-4b75-b727-e7c2d20e5d02.name','\"Ingredients\"'),
	('matrixBlockTypes.17260a44-4415-4ac9-a021-0fb47c72adc6.fields.ae1f295a-8164-4b75-b727-e7c2d20e5d02.searchable','true'),
	('matrixBlockTypes.17260a44-4415-4ac9-a021-0fb47c72adc6.fields.ae1f295a-8164-4b75-b727-e7c2d20e5d02.settings.addRowLabel','\"Add a row\"'),
	('matrixBlockTypes.17260a44-4415-4ac9-a021-0fb47c72adc6.fields.ae1f295a-8164-4b75-b727-e7c2d20e5d02.settings.columns.__assoc__.0.0','\"col1\"'),
	('matrixBlockTypes.17260a44-4415-4ac9-a021-0fb47c72adc6.fields.ae1f295a-8164-4b75-b727-e7c2d20e5d02.settings.columns.__assoc__.0.1.__assoc__.0.0','\"heading\"'),
	('matrixBlockTypes.17260a44-4415-4ac9-a021-0fb47c72adc6.fields.ae1f295a-8164-4b75-b727-e7c2d20e5d02.settings.columns.__assoc__.0.1.__assoc__.0.1','\"Amount\"'),
	('matrixBlockTypes.17260a44-4415-4ac9-a021-0fb47c72adc6.fields.ae1f295a-8164-4b75-b727-e7c2d20e5d02.settings.columns.__assoc__.0.1.__assoc__.1.0','\"handle\"'),
	('matrixBlockTypes.17260a44-4415-4ac9-a021-0fb47c72adc6.fields.ae1f295a-8164-4b75-b727-e7c2d20e5d02.settings.columns.__assoc__.0.1.__assoc__.1.1','\"amount\"'),
	('matrixBlockTypes.17260a44-4415-4ac9-a021-0fb47c72adc6.fields.ae1f295a-8164-4b75-b727-e7c2d20e5d02.settings.columns.__assoc__.0.1.__assoc__.2.0','\"width\"'),
	('matrixBlockTypes.17260a44-4415-4ac9-a021-0fb47c72adc6.fields.ae1f295a-8164-4b75-b727-e7c2d20e5d02.settings.columns.__assoc__.0.1.__assoc__.2.1','\"\"'),
	('matrixBlockTypes.17260a44-4415-4ac9-a021-0fb47c72adc6.fields.ae1f295a-8164-4b75-b727-e7c2d20e5d02.settings.columns.__assoc__.0.1.__assoc__.3.0','\"type\"'),
	('matrixBlockTypes.17260a44-4415-4ac9-a021-0fb47c72adc6.fields.ae1f295a-8164-4b75-b727-e7c2d20e5d02.settings.columns.__assoc__.0.1.__assoc__.3.1','\"singleline\"'),
	('matrixBlockTypes.17260a44-4415-4ac9-a021-0fb47c72adc6.fields.ae1f295a-8164-4b75-b727-e7c2d20e5d02.settings.columns.__assoc__.1.0','\"col2\"'),
	('matrixBlockTypes.17260a44-4415-4ac9-a021-0fb47c72adc6.fields.ae1f295a-8164-4b75-b727-e7c2d20e5d02.settings.columns.__assoc__.1.1.__assoc__.0.0','\"heading\"'),
	('matrixBlockTypes.17260a44-4415-4ac9-a021-0fb47c72adc6.fields.ae1f295a-8164-4b75-b727-e7c2d20e5d02.settings.columns.__assoc__.1.1.__assoc__.0.1','\"Ingredient\"'),
	('matrixBlockTypes.17260a44-4415-4ac9-a021-0fb47c72adc6.fields.ae1f295a-8164-4b75-b727-e7c2d20e5d02.settings.columns.__assoc__.1.1.__assoc__.1.0','\"handle\"'),
	('matrixBlockTypes.17260a44-4415-4ac9-a021-0fb47c72adc6.fields.ae1f295a-8164-4b75-b727-e7c2d20e5d02.settings.columns.__assoc__.1.1.__assoc__.1.1','\"ingredient\"'),
	('matrixBlockTypes.17260a44-4415-4ac9-a021-0fb47c72adc6.fields.ae1f295a-8164-4b75-b727-e7c2d20e5d02.settings.columns.__assoc__.1.1.__assoc__.2.0','\"width\"'),
	('matrixBlockTypes.17260a44-4415-4ac9-a021-0fb47c72adc6.fields.ae1f295a-8164-4b75-b727-e7c2d20e5d02.settings.columns.__assoc__.1.1.__assoc__.2.1','\"\"'),
	('matrixBlockTypes.17260a44-4415-4ac9-a021-0fb47c72adc6.fields.ae1f295a-8164-4b75-b727-e7c2d20e5d02.settings.columns.__assoc__.1.1.__assoc__.3.0','\"type\"'),
	('matrixBlockTypes.17260a44-4415-4ac9-a021-0fb47c72adc6.fields.ae1f295a-8164-4b75-b727-e7c2d20e5d02.settings.columns.__assoc__.1.1.__assoc__.3.1','\"singleline\"'),
	('matrixBlockTypes.17260a44-4415-4ac9-a021-0fb47c72adc6.fields.ae1f295a-8164-4b75-b727-e7c2d20e5d02.settings.columnType','\"text\"'),
	('matrixBlockTypes.17260a44-4415-4ac9-a021-0fb47c72adc6.fields.ae1f295a-8164-4b75-b727-e7c2d20e5d02.settings.maxRows','\"\"'),
	('matrixBlockTypes.17260a44-4415-4ac9-a021-0fb47c72adc6.fields.ae1f295a-8164-4b75-b727-e7c2d20e5d02.settings.minRows','\"\"'),
	('matrixBlockTypes.17260a44-4415-4ac9-a021-0fb47c72adc6.fields.ae1f295a-8164-4b75-b727-e7c2d20e5d02.translationKeyFormat','null'),
	('matrixBlockTypes.17260a44-4415-4ac9-a021-0fb47c72adc6.fields.ae1f295a-8164-4b75-b727-e7c2d20e5d02.translationMethod','\"none\"'),
	('matrixBlockTypes.17260a44-4415-4ac9-a021-0fb47c72adc6.fields.ae1f295a-8164-4b75-b727-e7c2d20e5d02.type','\"craft\\\\fields\\\\Table\"'),
	('matrixBlockTypes.17260a44-4415-4ac9-a021-0fb47c72adc6.handle','\"recipeIngredients\"'),
	('matrixBlockTypes.17260a44-4415-4ac9-a021-0fb47c72adc6.name','\"Recipe Ingredients\"'),
	('matrixBlockTypes.17260a44-4415-4ac9-a021-0fb47c72adc6.sortOrder','5'),
	('matrixBlockTypes.2fe8849d-a3b2-4e86-abfd-a4124ea0076c.field','\"c335386c-416d-422b-ab7d-a6390613287a\"'),
	('matrixBlockTypes.2fe8849d-a3b2-4e86-abfd-a4124ea0076c.fieldLayouts.448d9a7a-b76e-42f0-8399-4465b97953db.tabs.0.fields.8c86b286-218c-4a63-ba91-14d33ceb7cda.required','false'),
	('matrixBlockTypes.2fe8849d-a3b2-4e86-abfd-a4124ea0076c.fieldLayouts.448d9a7a-b76e-42f0-8399-4465b97953db.tabs.0.fields.8c86b286-218c-4a63-ba91-14d33ceb7cda.sortOrder','1'),
	('matrixBlockTypes.2fe8849d-a3b2-4e86-abfd-a4124ea0076c.fieldLayouts.448d9a7a-b76e-42f0-8399-4465b97953db.tabs.0.name','\"Content\"'),
	('matrixBlockTypes.2fe8849d-a3b2-4e86-abfd-a4124ea0076c.fieldLayouts.448d9a7a-b76e-42f0-8399-4465b97953db.tabs.0.sortOrder','1'),
	('matrixBlockTypes.2fe8849d-a3b2-4e86-abfd-a4124ea0076c.fields.8c86b286-218c-4a63-ba91-14d33ceb7cda.contentColumnType','\"text\"'),
	('matrixBlockTypes.2fe8849d-a3b2-4e86-abfd-a4124ea0076c.fields.8c86b286-218c-4a63-ba91-14d33ceb7cda.fieldGroup','null'),
	('matrixBlockTypes.2fe8849d-a3b2-4e86-abfd-a4124ea0076c.fields.8c86b286-218c-4a63-ba91-14d33ceb7cda.handle','\"tipContent\"'),
	('matrixBlockTypes.2fe8849d-a3b2-4e86-abfd-a4124ea0076c.fields.8c86b286-218c-4a63-ba91-14d33ceb7cda.instructions','\"\"'),
	('matrixBlockTypes.2fe8849d-a3b2-4e86-abfd-a4124ea0076c.fields.8c86b286-218c-4a63-ba91-14d33ceb7cda.name','\"Tip Content\"'),
	('matrixBlockTypes.2fe8849d-a3b2-4e86-abfd-a4124ea0076c.fields.8c86b286-218c-4a63-ba91-14d33ceb7cda.searchable','true'),
	('matrixBlockTypes.2fe8849d-a3b2-4e86-abfd-a4124ea0076c.fields.8c86b286-218c-4a63-ba91-14d33ceb7cda.settings.byteLimit','null'),
	('matrixBlockTypes.2fe8849d-a3b2-4e86-abfd-a4124ea0076c.fields.8c86b286-218c-4a63-ba91-14d33ceb7cda.settings.charLimit','null'),
	('matrixBlockTypes.2fe8849d-a3b2-4e86-abfd-a4124ea0076c.fields.8c86b286-218c-4a63-ba91-14d33ceb7cda.settings.code','\"\"'),
	('matrixBlockTypes.2fe8849d-a3b2-4e86-abfd-a4124ea0076c.fields.8c86b286-218c-4a63-ba91-14d33ceb7cda.settings.columnType','null'),
	('matrixBlockTypes.2fe8849d-a3b2-4e86-abfd-a4124ea0076c.fields.8c86b286-218c-4a63-ba91-14d33ceb7cda.settings.initialRows','\"4\"'),
	('matrixBlockTypes.2fe8849d-a3b2-4e86-abfd-a4124ea0076c.fields.8c86b286-218c-4a63-ba91-14d33ceb7cda.settings.multiline','\"\"'),
	('matrixBlockTypes.2fe8849d-a3b2-4e86-abfd-a4124ea0076c.fields.8c86b286-218c-4a63-ba91-14d33ceb7cda.settings.placeholder','\"\"'),
	('matrixBlockTypes.2fe8849d-a3b2-4e86-abfd-a4124ea0076c.fields.8c86b286-218c-4a63-ba91-14d33ceb7cda.translationKeyFormat','null'),
	('matrixBlockTypes.2fe8849d-a3b2-4e86-abfd-a4124ea0076c.fields.8c86b286-218c-4a63-ba91-14d33ceb7cda.translationMethod','\"none\"'),
	('matrixBlockTypes.2fe8849d-a3b2-4e86-abfd-a4124ea0076c.fields.8c86b286-218c-4a63-ba91-14d33ceb7cda.type','\"craft\\\\fields\\\\PlainText\"'),
	('matrixBlockTypes.2fe8849d-a3b2-4e86-abfd-a4124ea0076c.handle','\"recipeTip\"'),
	('matrixBlockTypes.2fe8849d-a3b2-4e86-abfd-a4124ea0076c.name','\"Recipe Tip\"'),
	('matrixBlockTypes.2fe8849d-a3b2-4e86-abfd-a4124ea0076c.sortOrder','2'),
	('matrixBlockTypes.51e3646e-111c-4651-ae09-9fd365b33a91.field','\"c335386c-416d-422b-ab7d-a6390613287a\"'),
	('matrixBlockTypes.51e3646e-111c-4651-ae09-9fd365b33a91.fieldLayouts.e31ae32c-7554-4e56-99a7-05db4b7d4e28.tabs.0.fields.fe75e466-7678-407d-ad47-a73ce2ca3bbb.required','false'),
	('matrixBlockTypes.51e3646e-111c-4651-ae09-9fd365b33a91.fieldLayouts.e31ae32c-7554-4e56-99a7-05db4b7d4e28.tabs.0.fields.fe75e466-7678-407d-ad47-a73ce2ca3bbb.sortOrder','1'),
	('matrixBlockTypes.51e3646e-111c-4651-ae09-9fd365b33a91.fieldLayouts.e31ae32c-7554-4e56-99a7-05db4b7d4e28.tabs.0.name','\"Content\"'),
	('matrixBlockTypes.51e3646e-111c-4651-ae09-9fd365b33a91.fieldLayouts.e31ae32c-7554-4e56-99a7-05db4b7d4e28.tabs.0.sortOrder','1'),
	('matrixBlockTypes.51e3646e-111c-4651-ae09-9fd365b33a91.fields.fe75e466-7678-407d-ad47-a73ce2ca3bbb.contentColumnType','\"text\"'),
	('matrixBlockTypes.51e3646e-111c-4651-ae09-9fd365b33a91.fields.fe75e466-7678-407d-ad47-a73ce2ca3bbb.fieldGroup','null'),
	('matrixBlockTypes.51e3646e-111c-4651-ae09-9fd365b33a91.fields.fe75e466-7678-407d-ad47-a73ce2ca3bbb.handle','\"bodyContent\"'),
	('matrixBlockTypes.51e3646e-111c-4651-ae09-9fd365b33a91.fields.fe75e466-7678-407d-ad47-a73ce2ca3bbb.instructions','\"\"'),
	('matrixBlockTypes.51e3646e-111c-4651-ae09-9fd365b33a91.fields.fe75e466-7678-407d-ad47-a73ce2ca3bbb.name','\"Body Content\"'),
	('matrixBlockTypes.51e3646e-111c-4651-ae09-9fd365b33a91.fields.fe75e466-7678-407d-ad47-a73ce2ca3bbb.searchable','true'),
	('matrixBlockTypes.51e3646e-111c-4651-ae09-9fd365b33a91.fields.fe75e466-7678-407d-ad47-a73ce2ca3bbb.settings.availableTransforms','\"*\"'),
	('matrixBlockTypes.51e3646e-111c-4651-ae09-9fd365b33a91.fields.fe75e466-7678-407d-ad47-a73ce2ca3bbb.settings.availableVolumes','\"*\"'),
	('matrixBlockTypes.51e3646e-111c-4651-ae09-9fd365b33a91.fields.fe75e466-7678-407d-ad47-a73ce2ca3bbb.settings.cleanupHtml','true'),
	('matrixBlockTypes.51e3646e-111c-4651-ae09-9fd365b33a91.fields.fe75e466-7678-407d-ad47-a73ce2ca3bbb.settings.columnType','\"text\"'),
	('matrixBlockTypes.51e3646e-111c-4651-ae09-9fd365b33a91.fields.fe75e466-7678-407d-ad47-a73ce2ca3bbb.settings.purifierConfig','\"\"'),
	('matrixBlockTypes.51e3646e-111c-4651-ae09-9fd365b33a91.fields.fe75e466-7678-407d-ad47-a73ce2ca3bbb.settings.purifyHtml','\"1\"'),
	('matrixBlockTypes.51e3646e-111c-4651-ae09-9fd365b33a91.fields.fe75e466-7678-407d-ad47-a73ce2ca3bbb.settings.redactorConfig','\"\"'),
	('matrixBlockTypes.51e3646e-111c-4651-ae09-9fd365b33a91.fields.fe75e466-7678-407d-ad47-a73ce2ca3bbb.settings.removeEmptyTags','\"1\"'),
	('matrixBlockTypes.51e3646e-111c-4651-ae09-9fd365b33a91.fields.fe75e466-7678-407d-ad47-a73ce2ca3bbb.settings.removeInlineStyles','\"1\"'),
	('matrixBlockTypes.51e3646e-111c-4651-ae09-9fd365b33a91.fields.fe75e466-7678-407d-ad47-a73ce2ca3bbb.settings.removeNbsp','\"1\"'),
	('matrixBlockTypes.51e3646e-111c-4651-ae09-9fd365b33a91.fields.fe75e466-7678-407d-ad47-a73ce2ca3bbb.translationKeyFormat','null'),
	('matrixBlockTypes.51e3646e-111c-4651-ae09-9fd365b33a91.fields.fe75e466-7678-407d-ad47-a73ce2ca3bbb.translationMethod','\"none\"'),
	('matrixBlockTypes.51e3646e-111c-4651-ae09-9fd365b33a91.fields.fe75e466-7678-407d-ad47-a73ce2ca3bbb.type','\"craft\\\\redactor\\\\Field\"'),
	('matrixBlockTypes.51e3646e-111c-4651-ae09-9fd365b33a91.handle','\"recipeCopy\"'),
	('matrixBlockTypes.51e3646e-111c-4651-ae09-9fd365b33a91.name','\"Recipe Copy\"'),
	('matrixBlockTypes.51e3646e-111c-4651-ae09-9fd365b33a91.sortOrder','3'),
	('matrixBlockTypes.f78bfaa9-e525-4b4a-9897-ce5058310dcc.field','\"c335386c-416d-422b-ab7d-a6390613287a\"'),
	('matrixBlockTypes.f78bfaa9-e525-4b4a-9897-ce5058310dcc.fieldLayouts.fe12124a-6141-4fcf-8175-58ad302d26ad.tabs.0.fields.1a5780ca-d8db-4b31-8c76-c8d74fa795f2.required','false'),
	('matrixBlockTypes.f78bfaa9-e525-4b4a-9897-ce5058310dcc.fieldLayouts.fe12124a-6141-4fcf-8175-58ad302d26ad.tabs.0.fields.1a5780ca-d8db-4b31-8c76-c8d74fa795f2.sortOrder','2'),
	('matrixBlockTypes.f78bfaa9-e525-4b4a-9897-ce5058310dcc.fieldLayouts.fe12124a-6141-4fcf-8175-58ad302d26ad.tabs.0.fields.4bb837ed-696a-465c-ae5e-a52ed850b2e3.required','false'),
	('matrixBlockTypes.f78bfaa9-e525-4b4a-9897-ce5058310dcc.fieldLayouts.fe12124a-6141-4fcf-8175-58ad302d26ad.tabs.0.fields.4bb837ed-696a-465c-ae5e-a52ed850b2e3.sortOrder','1'),
	('matrixBlockTypes.f78bfaa9-e525-4b4a-9897-ce5058310dcc.fieldLayouts.fe12124a-6141-4fcf-8175-58ad302d26ad.tabs.0.name','\"Content\"'),
	('matrixBlockTypes.f78bfaa9-e525-4b4a-9897-ce5058310dcc.fieldLayouts.fe12124a-6141-4fcf-8175-58ad302d26ad.tabs.0.sortOrder','1'),
	('matrixBlockTypes.f78bfaa9-e525-4b4a-9897-ce5058310dcc.fields.1a5780ca-d8db-4b31-8c76-c8d74fa795f2.contentColumnType','\"text\"'),
	('matrixBlockTypes.f78bfaa9-e525-4b4a-9897-ce5058310dcc.fields.1a5780ca-d8db-4b31-8c76-c8d74fa795f2.fieldGroup','null'),
	('matrixBlockTypes.f78bfaa9-e525-4b4a-9897-ce5058310dcc.fields.1a5780ca-d8db-4b31-8c76-c8d74fa795f2.handle','\"imageCaption\"'),
	('matrixBlockTypes.f78bfaa9-e525-4b4a-9897-ce5058310dcc.fields.1a5780ca-d8db-4b31-8c76-c8d74fa795f2.instructions','\"\"'),
	('matrixBlockTypes.f78bfaa9-e525-4b4a-9897-ce5058310dcc.fields.1a5780ca-d8db-4b31-8c76-c8d74fa795f2.name','\"Image Caption\"'),
	('matrixBlockTypes.f78bfaa9-e525-4b4a-9897-ce5058310dcc.fields.1a5780ca-d8db-4b31-8c76-c8d74fa795f2.searchable','true'),
	('matrixBlockTypes.f78bfaa9-e525-4b4a-9897-ce5058310dcc.fields.1a5780ca-d8db-4b31-8c76-c8d74fa795f2.settings.byteLimit','null'),
	('matrixBlockTypes.f78bfaa9-e525-4b4a-9897-ce5058310dcc.fields.1a5780ca-d8db-4b31-8c76-c8d74fa795f2.settings.charLimit','null'),
	('matrixBlockTypes.f78bfaa9-e525-4b4a-9897-ce5058310dcc.fields.1a5780ca-d8db-4b31-8c76-c8d74fa795f2.settings.code','\"\"'),
	('matrixBlockTypes.f78bfaa9-e525-4b4a-9897-ce5058310dcc.fields.1a5780ca-d8db-4b31-8c76-c8d74fa795f2.settings.columnType','null'),
	('matrixBlockTypes.f78bfaa9-e525-4b4a-9897-ce5058310dcc.fields.1a5780ca-d8db-4b31-8c76-c8d74fa795f2.settings.initialRows','\"4\"'),
	('matrixBlockTypes.f78bfaa9-e525-4b4a-9897-ce5058310dcc.fields.1a5780ca-d8db-4b31-8c76-c8d74fa795f2.settings.multiline','\"\"'),
	('matrixBlockTypes.f78bfaa9-e525-4b4a-9897-ce5058310dcc.fields.1a5780ca-d8db-4b31-8c76-c8d74fa795f2.settings.placeholder','\"\"'),
	('matrixBlockTypes.f78bfaa9-e525-4b4a-9897-ce5058310dcc.fields.1a5780ca-d8db-4b31-8c76-c8d74fa795f2.translationKeyFormat','null'),
	('matrixBlockTypes.f78bfaa9-e525-4b4a-9897-ce5058310dcc.fields.1a5780ca-d8db-4b31-8c76-c8d74fa795f2.translationMethod','\"none\"'),
	('matrixBlockTypes.f78bfaa9-e525-4b4a-9897-ce5058310dcc.fields.1a5780ca-d8db-4b31-8c76-c8d74fa795f2.type','\"craft\\\\fields\\\\PlainText\"'),
	('matrixBlockTypes.f78bfaa9-e525-4b4a-9897-ce5058310dcc.fields.4bb837ed-696a-465c-ae5e-a52ed850b2e3.contentColumnType','\"string\"'),
	('matrixBlockTypes.f78bfaa9-e525-4b4a-9897-ce5058310dcc.fields.4bb837ed-696a-465c-ae5e-a52ed850b2e3.fieldGroup','null'),
	('matrixBlockTypes.f78bfaa9-e525-4b4a-9897-ce5058310dcc.fields.4bb837ed-696a-465c-ae5e-a52ed850b2e3.handle','\"image\"'),
	('matrixBlockTypes.f78bfaa9-e525-4b4a-9897-ce5058310dcc.fields.4bb837ed-696a-465c-ae5e-a52ed850b2e3.instructions','\"\"'),
	('matrixBlockTypes.f78bfaa9-e525-4b4a-9897-ce5058310dcc.fields.4bb837ed-696a-465c-ae5e-a52ed850b2e3.name','\"Image\"'),
	('matrixBlockTypes.f78bfaa9-e525-4b4a-9897-ce5058310dcc.fields.4bb837ed-696a-465c-ae5e-a52ed850b2e3.searchable','true'),
	('matrixBlockTypes.f78bfaa9-e525-4b4a-9897-ce5058310dcc.fields.4bb837ed-696a-465c-ae5e-a52ed850b2e3.settings.allowedKinds','null'),
	('matrixBlockTypes.f78bfaa9-e525-4b4a-9897-ce5058310dcc.fields.4bb837ed-696a-465c-ae5e-a52ed850b2e3.settings.defaultUploadLocationSource','\"volume:679feb39-d56f-43cf-9b9a-5c4009fa2324\"'),
	('matrixBlockTypes.f78bfaa9-e525-4b4a-9897-ce5058310dcc.fields.4bb837ed-696a-465c-ae5e-a52ed850b2e3.settings.defaultUploadLocationSubpath','\"\"'),
	('matrixBlockTypes.f78bfaa9-e525-4b4a-9897-ce5058310dcc.fields.4bb837ed-696a-465c-ae5e-a52ed850b2e3.settings.limit','\"1\"'),
	('matrixBlockTypes.f78bfaa9-e525-4b4a-9897-ce5058310dcc.fields.4bb837ed-696a-465c-ae5e-a52ed850b2e3.settings.localizeRelations','false'),
	('matrixBlockTypes.f78bfaa9-e525-4b4a-9897-ce5058310dcc.fields.4bb837ed-696a-465c-ae5e-a52ed850b2e3.settings.restrictFiles','\"\"'),
	('matrixBlockTypes.f78bfaa9-e525-4b4a-9897-ce5058310dcc.fields.4bb837ed-696a-465c-ae5e-a52ed850b2e3.settings.selectionLabel','\"\"'),
	('matrixBlockTypes.f78bfaa9-e525-4b4a-9897-ce5058310dcc.fields.4bb837ed-696a-465c-ae5e-a52ed850b2e3.settings.showUnpermittedFiles','false'),
	('matrixBlockTypes.f78bfaa9-e525-4b4a-9897-ce5058310dcc.fields.4bb837ed-696a-465c-ae5e-a52ed850b2e3.settings.showUnpermittedVolumes','false'),
	('matrixBlockTypes.f78bfaa9-e525-4b4a-9897-ce5058310dcc.fields.4bb837ed-696a-465c-ae5e-a52ed850b2e3.settings.singleUploadLocationSource','\"volume:679feb39-d56f-43cf-9b9a-5c4009fa2324\"'),
	('matrixBlockTypes.f78bfaa9-e525-4b4a-9897-ce5058310dcc.fields.4bb837ed-696a-465c-ae5e-a52ed850b2e3.settings.singleUploadLocationSubpath','\"\"'),
	('matrixBlockTypes.f78bfaa9-e525-4b4a-9897-ce5058310dcc.fields.4bb837ed-696a-465c-ae5e-a52ed850b2e3.settings.source','null'),
	('matrixBlockTypes.f78bfaa9-e525-4b4a-9897-ce5058310dcc.fields.4bb837ed-696a-465c-ae5e-a52ed850b2e3.settings.sources','\"*\"'),
	('matrixBlockTypes.f78bfaa9-e525-4b4a-9897-ce5058310dcc.fields.4bb837ed-696a-465c-ae5e-a52ed850b2e3.settings.targetSiteId','null'),
	('matrixBlockTypes.f78bfaa9-e525-4b4a-9897-ce5058310dcc.fields.4bb837ed-696a-465c-ae5e-a52ed850b2e3.settings.useSingleFolder','false'),
	('matrixBlockTypes.f78bfaa9-e525-4b4a-9897-ce5058310dcc.fields.4bb837ed-696a-465c-ae5e-a52ed850b2e3.settings.validateRelatedElements','\"\"'),
	('matrixBlockTypes.f78bfaa9-e525-4b4a-9897-ce5058310dcc.fields.4bb837ed-696a-465c-ae5e-a52ed850b2e3.settings.viewMode','\"list\"'),
	('matrixBlockTypes.f78bfaa9-e525-4b4a-9897-ce5058310dcc.fields.4bb837ed-696a-465c-ae5e-a52ed850b2e3.translationKeyFormat','null'),
	('matrixBlockTypes.f78bfaa9-e525-4b4a-9897-ce5058310dcc.fields.4bb837ed-696a-465c-ae5e-a52ed850b2e3.translationMethod','\"site\"'),
	('matrixBlockTypes.f78bfaa9-e525-4b4a-9897-ce5058310dcc.fields.4bb837ed-696a-465c-ae5e-a52ed850b2e3.type','\"craft\\\\fields\\\\Assets\"'),
	('matrixBlockTypes.f78bfaa9-e525-4b4a-9897-ce5058310dcc.handle','\"recipeImage\"'),
	('matrixBlockTypes.f78bfaa9-e525-4b4a-9897-ce5058310dcc.name','\"Recipe Image\"'),
	('matrixBlockTypes.f78bfaa9-e525-4b4a-9897-ce5058310dcc.sortOrder','1'),
	('plugins.command-palette.edition','\"standard\"'),
	('plugins.command-palette.enabled','true'),
	('plugins.command-palette.schemaVersion','\"3.0.0\"'),
	('plugins.feed-me.edition','\"standard\"'),
	('plugins.feed-me.enabled','true'),
	('plugins.feed-me.schemaVersion','\"2.1.2\"'),
	('plugins.redactor.edition','\"standard\"'),
	('plugins.redactor.enabled','true'),
	('plugins.redactor.schemaVersion','\"2.3.0\"'),
	('plugins.seomatic.edition','\"standard\"'),
	('plugins.seomatic.enabled','true'),
	('plugins.seomatic.schemaVersion','\"3.0.8\"'),
	('sections.13a49d3a-74d9-445a-9814-75a615b1b2b2.enableVersioning','true'),
	('sections.13a49d3a-74d9-445a-9814-75a615b1b2b2.entryTypes.06203c16-55ba-4810-8681-c9389a09d511.fieldLayouts.3dc744db-5229-4d1e-a804-d45dd0e54ac2.tabs.0.fields.074c8fde-16e3-4d13-b76d-6aa448a652df.required','false'),
	('sections.13a49d3a-74d9-445a-9814-75a615b1b2b2.entryTypes.06203c16-55ba-4810-8681-c9389a09d511.fieldLayouts.3dc744db-5229-4d1e-a804-d45dd0e54ac2.tabs.0.fields.074c8fde-16e3-4d13-b76d-6aa448a652df.sortOrder','2'),
	('sections.13a49d3a-74d9-445a-9814-75a615b1b2b2.entryTypes.06203c16-55ba-4810-8681-c9389a09d511.fieldLayouts.3dc744db-5229-4d1e-a804-d45dd0e54ac2.tabs.0.fields.479c8046-8ddf-451a-9c73-c31398b7da01.required','false'),
	('sections.13a49d3a-74d9-445a-9814-75a615b1b2b2.entryTypes.06203c16-55ba-4810-8681-c9389a09d511.fieldLayouts.3dc744db-5229-4d1e-a804-d45dd0e54ac2.tabs.0.fields.479c8046-8ddf-451a-9c73-c31398b7da01.sortOrder','4'),
	('sections.13a49d3a-74d9-445a-9814-75a615b1b2b2.entryTypes.06203c16-55ba-4810-8681-c9389a09d511.fieldLayouts.3dc744db-5229-4d1e-a804-d45dd0e54ac2.tabs.0.fields.4d09f665-5d14-4ba3-b0d7-b901a4eae2f0.required','false'),
	('sections.13a49d3a-74d9-445a-9814-75a615b1b2b2.entryTypes.06203c16-55ba-4810-8681-c9389a09d511.fieldLayouts.3dc744db-5229-4d1e-a804-d45dd0e54ac2.tabs.0.fields.4d09f665-5d14-4ba3-b0d7-b901a4eae2f0.sortOrder','5'),
	('sections.13a49d3a-74d9-445a-9814-75a615b1b2b2.entryTypes.06203c16-55ba-4810-8681-c9389a09d511.fieldLayouts.3dc744db-5229-4d1e-a804-d45dd0e54ac2.tabs.0.fields.a6e1ddbb-d173-474a-9b71-eeb5805708dd.required','false'),
	('sections.13a49d3a-74d9-445a-9814-75a615b1b2b2.entryTypes.06203c16-55ba-4810-8681-c9389a09d511.fieldLayouts.3dc744db-5229-4d1e-a804-d45dd0e54ac2.tabs.0.fields.a6e1ddbb-d173-474a-9b71-eeb5805708dd.sortOrder','1'),
	('sections.13a49d3a-74d9-445a-9814-75a615b1b2b2.entryTypes.06203c16-55ba-4810-8681-c9389a09d511.fieldLayouts.3dc744db-5229-4d1e-a804-d45dd0e54ac2.tabs.0.fields.c2802d29-16d2-4e5f-8401-92321167c0e5.required','false'),
	('sections.13a49d3a-74d9-445a-9814-75a615b1b2b2.entryTypes.06203c16-55ba-4810-8681-c9389a09d511.fieldLayouts.3dc744db-5229-4d1e-a804-d45dd0e54ac2.tabs.0.fields.c2802d29-16d2-4e5f-8401-92321167c0e5.sortOrder','3'),
	('sections.13a49d3a-74d9-445a-9814-75a615b1b2b2.entryTypes.06203c16-55ba-4810-8681-c9389a09d511.fieldLayouts.3dc744db-5229-4d1e-a804-d45dd0e54ac2.tabs.0.name','\"Drink Details\"'),
	('sections.13a49d3a-74d9-445a-9814-75a615b1b2b2.entryTypes.06203c16-55ba-4810-8681-c9389a09d511.fieldLayouts.3dc744db-5229-4d1e-a804-d45dd0e54ac2.tabs.0.sortOrder','1'),
	('sections.13a49d3a-74d9-445a-9814-75a615b1b2b2.entryTypes.06203c16-55ba-4810-8681-c9389a09d511.handle','\"drinks\"'),
	('sections.13a49d3a-74d9-445a-9814-75a615b1b2b2.entryTypes.06203c16-55ba-4810-8681-c9389a09d511.hasTitleField','true'),
	('sections.13a49d3a-74d9-445a-9814-75a615b1b2b2.entryTypes.06203c16-55ba-4810-8681-c9389a09d511.name','\"Drinks\"'),
	('sections.13a49d3a-74d9-445a-9814-75a615b1b2b2.entryTypes.06203c16-55ba-4810-8681-c9389a09d511.sortOrder','1'),
	('sections.13a49d3a-74d9-445a-9814-75a615b1b2b2.entryTypes.06203c16-55ba-4810-8681-c9389a09d511.titleFormat','\"\"'),
	('sections.13a49d3a-74d9-445a-9814-75a615b1b2b2.entryTypes.06203c16-55ba-4810-8681-c9389a09d511.titleLabel','\"Drink Name\"'),
	('sections.13a49d3a-74d9-445a-9814-75a615b1b2b2.handle','\"drinks\"'),
	('sections.13a49d3a-74d9-445a-9814-75a615b1b2b2.name','\"Drinks\"'),
	('sections.13a49d3a-74d9-445a-9814-75a615b1b2b2.previewTargets.0.label','\"Primary entry page\"'),
	('sections.13a49d3a-74d9-445a-9814-75a615b1b2b2.previewTargets.0.refresh','\"1\"'),
	('sections.13a49d3a-74d9-445a-9814-75a615b1b2b2.previewTargets.0.urlFormat','\"{url}\"'),
	('sections.13a49d3a-74d9-445a-9814-75a615b1b2b2.propagationMethod','\"all\"'),
	('sections.13a49d3a-74d9-445a-9814-75a615b1b2b2.siteSettings.b34dff01-1c91-4de4-ab83-84610f1405d7.enabledByDefault','true'),
	('sections.13a49d3a-74d9-445a-9814-75a615b1b2b2.siteSettings.b34dff01-1c91-4de4-ab83-84610f1405d7.hasUrls','true'),
	('sections.13a49d3a-74d9-445a-9814-75a615b1b2b2.siteSettings.b34dff01-1c91-4de4-ab83-84610f1405d7.template','\"drinks/_entry\"'),
	('sections.13a49d3a-74d9-445a-9814-75a615b1b2b2.siteSettings.b34dff01-1c91-4de4-ab83-84610f1405d7.uriFormat','\"drinks/{slug}\"'),
	('sections.13a49d3a-74d9-445a-9814-75a615b1b2b2.type','\"channel\"'),
	('sections.354b2ad6-6ee8-4ad8-a988-713dc66ba2aa.enableVersioning','true'),
	('sections.354b2ad6-6ee8-4ad8-a988-713dc66ba2aa.entryTypes.d70d6cbe-3a4a-4e56-9b2e-805217072249.fieldLayouts.13e21443-f0f4-47e1-8740-561f0db55bbf.tabs.0.fields.dad89190-0d91-462f-88dd-4d1ac49c4f66.required','false'),
	('sections.354b2ad6-6ee8-4ad8-a988-713dc66ba2aa.entryTypes.d70d6cbe-3a4a-4e56-9b2e-805217072249.fieldLayouts.13e21443-f0f4-47e1-8740-561f0db55bbf.tabs.0.fields.dad89190-0d91-462f-88dd-4d1ac49c4f66.sortOrder','1'),
	('sections.354b2ad6-6ee8-4ad8-a988-713dc66ba2aa.entryTypes.d70d6cbe-3a4a-4e56-9b2e-805217072249.fieldLayouts.13e21443-f0f4-47e1-8740-561f0db55bbf.tabs.0.name','\"Common\"'),
	('sections.354b2ad6-6ee8-4ad8-a988-713dc66ba2aa.entryTypes.d70d6cbe-3a4a-4e56-9b2e-805217072249.fieldLayouts.13e21443-f0f4-47e1-8740-561f0db55bbf.tabs.0.sortOrder','1'),
	('sections.354b2ad6-6ee8-4ad8-a988-713dc66ba2aa.entryTypes.d70d6cbe-3a4a-4e56-9b2e-805217072249.handle','\"homepage\"'),
	('sections.354b2ad6-6ee8-4ad8-a988-713dc66ba2aa.entryTypes.d70d6cbe-3a4a-4e56-9b2e-805217072249.hasTitleField','true'),
	('sections.354b2ad6-6ee8-4ad8-a988-713dc66ba2aa.entryTypes.d70d6cbe-3a4a-4e56-9b2e-805217072249.name','\"Homepage\"'),
	('sections.354b2ad6-6ee8-4ad8-a988-713dc66ba2aa.entryTypes.d70d6cbe-3a4a-4e56-9b2e-805217072249.sortOrder','1'),
	('sections.354b2ad6-6ee8-4ad8-a988-713dc66ba2aa.entryTypes.d70d6cbe-3a4a-4e56-9b2e-805217072249.titleFormat','\"{section.name|raw}\"'),
	('sections.354b2ad6-6ee8-4ad8-a988-713dc66ba2aa.entryTypes.d70d6cbe-3a4a-4e56-9b2e-805217072249.titleLabel','\"Homepage Title\"'),
	('sections.354b2ad6-6ee8-4ad8-a988-713dc66ba2aa.handle','\"homepage\"'),
	('sections.354b2ad6-6ee8-4ad8-a988-713dc66ba2aa.name','\"Homepage\"'),
	('sections.354b2ad6-6ee8-4ad8-a988-713dc66ba2aa.previewTargets.0.label','\"Primary entry page\"'),
	('sections.354b2ad6-6ee8-4ad8-a988-713dc66ba2aa.previewTargets.0.refresh','\"1\"'),
	('sections.354b2ad6-6ee8-4ad8-a988-713dc66ba2aa.previewTargets.0.urlFormat','\"{url}\"'),
	('sections.354b2ad6-6ee8-4ad8-a988-713dc66ba2aa.propagationMethod','\"all\"'),
	('sections.354b2ad6-6ee8-4ad8-a988-713dc66ba2aa.siteSettings.b34dff01-1c91-4de4-ab83-84610f1405d7.enabledByDefault','true'),
	('sections.354b2ad6-6ee8-4ad8-a988-713dc66ba2aa.siteSettings.b34dff01-1c91-4de4-ab83-84610f1405d7.hasUrls','true'),
	('sections.354b2ad6-6ee8-4ad8-a988-713dc66ba2aa.siteSettings.b34dff01-1c91-4de4-ab83-84610f1405d7.template','\"index\"'),
	('sections.354b2ad6-6ee8-4ad8-a988-713dc66ba2aa.siteSettings.b34dff01-1c91-4de4-ab83-84610f1405d7.uriFormat','\"__home__\"'),
	('sections.354b2ad6-6ee8-4ad8-a988-713dc66ba2aa.type','\"single\"'),
	('sections.c828d52a-d271-4b70-89a7-f6865c41ae33.enableVersioning','true'),
	('sections.c828d52a-d271-4b70-89a7-f6865c41ae33.entryTypes.1f0fb227-518c-43e2-a942-e265b4418f0a.fieldLayouts.25f35663-03e9-4789-9528-ae9907d6dc3e.tabs.0.fields.a6e1ddbb-d173-474a-9b71-eeb5805708dd.required','false'),
	('sections.c828d52a-d271-4b70-89a7-f6865c41ae33.entryTypes.1f0fb227-518c-43e2-a942-e265b4418f0a.fieldLayouts.25f35663-03e9-4789-9528-ae9907d6dc3e.tabs.0.fields.a6e1ddbb-d173-474a-9b71-eeb5805708dd.sortOrder','1'),
	('sections.c828d52a-d271-4b70-89a7-f6865c41ae33.entryTypes.1f0fb227-518c-43e2-a942-e265b4418f0a.fieldLayouts.25f35663-03e9-4789-9528-ae9907d6dc3e.tabs.0.fields.c335386c-416d-422b-ab7d-a6390613287a.required','false'),
	('sections.c828d52a-d271-4b70-89a7-f6865c41ae33.entryTypes.1f0fb227-518c-43e2-a942-e265b4418f0a.fieldLayouts.25f35663-03e9-4789-9528-ae9907d6dc3e.tabs.0.fields.c335386c-416d-422b-ab7d-a6390613287a.sortOrder','2'),
	('sections.c828d52a-d271-4b70-89a7-f6865c41ae33.entryTypes.1f0fb227-518c-43e2-a942-e265b4418f0a.fieldLayouts.25f35663-03e9-4789-9528-ae9907d6dc3e.tabs.0.name','\"Recipes\"'),
	('sections.c828d52a-d271-4b70-89a7-f6865c41ae33.entryTypes.1f0fb227-518c-43e2-a942-e265b4418f0a.fieldLayouts.25f35663-03e9-4789-9528-ae9907d6dc3e.tabs.0.sortOrder','1'),
	('sections.c828d52a-d271-4b70-89a7-f6865c41ae33.entryTypes.1f0fb227-518c-43e2-a942-e265b4418f0a.handle','\"recipes\"'),
	('sections.c828d52a-d271-4b70-89a7-f6865c41ae33.entryTypes.1f0fb227-518c-43e2-a942-e265b4418f0a.hasTitleField','true'),
	('sections.c828d52a-d271-4b70-89a7-f6865c41ae33.entryTypes.1f0fb227-518c-43e2-a942-e265b4418f0a.name','\"Recipes\"'),
	('sections.c828d52a-d271-4b70-89a7-f6865c41ae33.entryTypes.1f0fb227-518c-43e2-a942-e265b4418f0a.sortOrder','1'),
	('sections.c828d52a-d271-4b70-89a7-f6865c41ae33.entryTypes.1f0fb227-518c-43e2-a942-e265b4418f0a.titleFormat','\"\"'),
	('sections.c828d52a-d271-4b70-89a7-f6865c41ae33.entryTypes.1f0fb227-518c-43e2-a942-e265b4418f0a.titleLabel','\"Recipe Name\"'),
	('sections.c828d52a-d271-4b70-89a7-f6865c41ae33.handle','\"recipes\"'),
	('sections.c828d52a-d271-4b70-89a7-f6865c41ae33.name','\"Recipes\"'),
	('sections.c828d52a-d271-4b70-89a7-f6865c41ae33.previewTargets.0.label','\"Primary entry page\"'),
	('sections.c828d52a-d271-4b70-89a7-f6865c41ae33.previewTargets.0.refresh','\"1\"'),
	('sections.c828d52a-d271-4b70-89a7-f6865c41ae33.previewTargets.0.urlFormat','\"{url}\"'),
	('sections.c828d52a-d271-4b70-89a7-f6865c41ae33.propagationMethod','\"all\"'),
	('sections.c828d52a-d271-4b70-89a7-f6865c41ae33.siteSettings.b34dff01-1c91-4de4-ab83-84610f1405d7.enabledByDefault','true'),
	('sections.c828d52a-d271-4b70-89a7-f6865c41ae33.siteSettings.b34dff01-1c91-4de4-ab83-84610f1405d7.hasUrls','true'),
	('sections.c828d52a-d271-4b70-89a7-f6865c41ae33.siteSettings.b34dff01-1c91-4de4-ab83-84610f1405d7.template','\"recipes/_entry\"'),
	('sections.c828d52a-d271-4b70-89a7-f6865c41ae33.siteSettings.b34dff01-1c91-4de4-ab83-84610f1405d7.uriFormat','\"recipes/{slug}\"'),
	('sections.c828d52a-d271-4b70-89a7-f6865c41ae33.type','\"channel\"'),
	('sections.da63c6af-f55a-4348-95a8-fd5d294a0125.enableVersioning','true'),
	('sections.da63c6af-f55a-4348-95a8-fd5d294a0125.entryTypes.1dfcc1f2-1d87-4993-9e6f-67bcc0ad89ad.fieldLayouts.1ab7b24d-0a91-4780-8ceb-75f755842588.tabs.0.fields.54bb063c-5936-4bf3-bc9a-85c89a1219e6.required','false'),
	('sections.da63c6af-f55a-4348-95a8-fd5d294a0125.entryTypes.1dfcc1f2-1d87-4993-9e6f-67bcc0ad89ad.fieldLayouts.1ab7b24d-0a91-4780-8ceb-75f755842588.tabs.0.fields.54bb063c-5936-4bf3-bc9a-85c89a1219e6.sortOrder','2'),
	('sections.da63c6af-f55a-4348-95a8-fd5d294a0125.entryTypes.1dfcc1f2-1d87-4993-9e6f-67bcc0ad89ad.fieldLayouts.1ab7b24d-0a91-4780-8ceb-75f755842588.tabs.0.fields.c2802d29-16d2-4e5f-8401-92321167c0e5.required','true'),
	('sections.da63c6af-f55a-4348-95a8-fd5d294a0125.entryTypes.1dfcc1f2-1d87-4993-9e6f-67bcc0ad89ad.fieldLayouts.1ab7b24d-0a91-4780-8ceb-75f755842588.tabs.0.fields.c2802d29-16d2-4e5f-8401-92321167c0e5.sortOrder','3'),
	('sections.da63c6af-f55a-4348-95a8-fd5d294a0125.entryTypes.1dfcc1f2-1d87-4993-9e6f-67bcc0ad89ad.fieldLayouts.1ab7b24d-0a91-4780-8ceb-75f755842588.tabs.0.fields.dad89190-0d91-462f-88dd-4d1ac49c4f66.required','false'),
	('sections.da63c6af-f55a-4348-95a8-fd5d294a0125.entryTypes.1dfcc1f2-1d87-4993-9e6f-67bcc0ad89ad.fieldLayouts.1ab7b24d-0a91-4780-8ceb-75f755842588.tabs.0.fields.dad89190-0d91-462f-88dd-4d1ac49c4f66.sortOrder','1'),
	('sections.da63c6af-f55a-4348-95a8-fd5d294a0125.entryTypes.1dfcc1f2-1d87-4993-9e6f-67bcc0ad89ad.fieldLayouts.1ab7b24d-0a91-4780-8ceb-75f755842588.tabs.0.name','\"About\"'),
	('sections.da63c6af-f55a-4348-95a8-fd5d294a0125.entryTypes.1dfcc1f2-1d87-4993-9e6f-67bcc0ad89ad.fieldLayouts.1ab7b24d-0a91-4780-8ceb-75f755842588.tabs.0.sortOrder','1'),
	('sections.da63c6af-f55a-4348-95a8-fd5d294a0125.entryTypes.1dfcc1f2-1d87-4993-9e6f-67bcc0ad89ad.handle','\"aboutCraftyCoffee\"'),
	('sections.da63c6af-f55a-4348-95a8-fd5d294a0125.entryTypes.1dfcc1f2-1d87-4993-9e6f-67bcc0ad89ad.hasTitleField','true'),
	('sections.da63c6af-f55a-4348-95a8-fd5d294a0125.entryTypes.1dfcc1f2-1d87-4993-9e6f-67bcc0ad89ad.name','\"About Crafty Coffee\"'),
	('sections.da63c6af-f55a-4348-95a8-fd5d294a0125.entryTypes.1dfcc1f2-1d87-4993-9e6f-67bcc0ad89ad.sortOrder','1'),
	('sections.da63c6af-f55a-4348-95a8-fd5d294a0125.entryTypes.1dfcc1f2-1d87-4993-9e6f-67bcc0ad89ad.titleFormat','\"\"'),
	('sections.da63c6af-f55a-4348-95a8-fd5d294a0125.entryTypes.1dfcc1f2-1d87-4993-9e6f-67bcc0ad89ad.titleLabel','\"Page Title\"'),
	('sections.da63c6af-f55a-4348-95a8-fd5d294a0125.handle','\"aboutCraftyCoffee\"'),
	('sections.da63c6af-f55a-4348-95a8-fd5d294a0125.name','\"About Crafty Coffee\"'),
	('sections.da63c6af-f55a-4348-95a8-fd5d294a0125.previewTargets.0.label','\"Primary entry page\"'),
	('sections.da63c6af-f55a-4348-95a8-fd5d294a0125.previewTargets.0.refresh','\"1\"'),
	('sections.da63c6af-f55a-4348-95a8-fd5d294a0125.previewTargets.0.urlFormat','\"{url}\"'),
	('sections.da63c6af-f55a-4348-95a8-fd5d294a0125.propagationMethod','\"all\"'),
	('sections.da63c6af-f55a-4348-95a8-fd5d294a0125.siteSettings.b34dff01-1c91-4de4-ab83-84610f1405d7.enabledByDefault','true'),
	('sections.da63c6af-f55a-4348-95a8-fd5d294a0125.siteSettings.b34dff01-1c91-4de4-ab83-84610f1405d7.hasUrls','true'),
	('sections.da63c6af-f55a-4348-95a8-fd5d294a0125.siteSettings.b34dff01-1c91-4de4-ab83-84610f1405d7.template','\"about/_entry\"'),
	('sections.da63c6af-f55a-4348-95a8-fd5d294a0125.siteSettings.b34dff01-1c91-4de4-ab83-84610f1405d7.uriFormat','\"{parent.uri}/{slug}\"'),
	('sections.da63c6af-f55a-4348-95a8-fd5d294a0125.structure.maxLevels','null'),
	('sections.da63c6af-f55a-4348-95a8-fd5d294a0125.structure.uid','\"e5368fac-d7e4-4660-a5f6-2f726467f4d5\"'),
	('sections.da63c6af-f55a-4348-95a8-fd5d294a0125.type','\"structure\"'),
	('sections.e6acd7d8-4560-486d-a427-0d4692807508.enableVersioning','true'),
	('sections.e6acd7d8-4560-486d-a427-0d4692807508.entryTypes.f6651859-32f7-4145-8c38-20b0580af233.fieldLayouts.54fc7844-58dc-4302-b462-8c78f299b5aa.tabs.0.fields.7df7941d-1e86-4a49-ab03-7ab8719f88b9.required','false'),
	('sections.e6acd7d8-4560-486d-a427-0d4692807508.entryTypes.f6651859-32f7-4145-8c38-20b0580af233.fieldLayouts.54fc7844-58dc-4302-b462-8c78f299b5aa.tabs.0.fields.7df7941d-1e86-4a49-ab03-7ab8719f88b9.sortOrder','1'),
	('sections.e6acd7d8-4560-486d-a427-0d4692807508.entryTypes.f6651859-32f7-4145-8c38-20b0580af233.fieldLayouts.54fc7844-58dc-4302-b462-8c78f299b5aa.tabs.0.fields.e59589de-cf68-450b-9d7c-a57576c03f36.required','false'),
	('sections.e6acd7d8-4560-486d-a427-0d4692807508.entryTypes.f6651859-32f7-4145-8c38-20b0580af233.fieldLayouts.54fc7844-58dc-4302-b462-8c78f299b5aa.tabs.0.fields.e59589de-cf68-450b-9d7c-a57576c03f36.sortOrder','2'),
	('sections.e6acd7d8-4560-486d-a427-0d4692807508.entryTypes.f6651859-32f7-4145-8c38-20b0580af233.fieldLayouts.54fc7844-58dc-4302-b462-8c78f299b5aa.tabs.0.name','\"News\"'),
	('sections.e6acd7d8-4560-486d-a427-0d4692807508.entryTypes.f6651859-32f7-4145-8c38-20b0580af233.fieldLayouts.54fc7844-58dc-4302-b462-8c78f299b5aa.tabs.0.sortOrder','1'),
	('sections.e6acd7d8-4560-486d-a427-0d4692807508.entryTypes.f6651859-32f7-4145-8c38-20b0580af233.handle','\"news\"'),
	('sections.e6acd7d8-4560-486d-a427-0d4692807508.entryTypes.f6651859-32f7-4145-8c38-20b0580af233.hasTitleField','true'),
	('sections.e6acd7d8-4560-486d-a427-0d4692807508.entryTypes.f6651859-32f7-4145-8c38-20b0580af233.name','\"News\"'),
	('sections.e6acd7d8-4560-486d-a427-0d4692807508.entryTypes.f6651859-32f7-4145-8c38-20b0580af233.sortOrder','1'),
	('sections.e6acd7d8-4560-486d-a427-0d4692807508.entryTypes.f6651859-32f7-4145-8c38-20b0580af233.titleFormat','\"\"'),
	('sections.e6acd7d8-4560-486d-a427-0d4692807508.entryTypes.f6651859-32f7-4145-8c38-20b0580af233.titleLabel','\"Headline\"'),
	('sections.e6acd7d8-4560-486d-a427-0d4692807508.handle','\"news\"'),
	('sections.e6acd7d8-4560-486d-a427-0d4692807508.name','\"News\"'),
	('sections.e6acd7d8-4560-486d-a427-0d4692807508.previewTargets.0.label','\"Primary entry page\"'),
	('sections.e6acd7d8-4560-486d-a427-0d4692807508.previewTargets.0.refresh','\"1\"'),
	('sections.e6acd7d8-4560-486d-a427-0d4692807508.previewTargets.0.urlFormat','\"{url}\"'),
	('sections.e6acd7d8-4560-486d-a427-0d4692807508.propagationMethod','\"all\"'),
	('sections.e6acd7d8-4560-486d-a427-0d4692807508.siteSettings.b34dff01-1c91-4de4-ab83-84610f1405d7.enabledByDefault','true'),
	('sections.e6acd7d8-4560-486d-a427-0d4692807508.siteSettings.b34dff01-1c91-4de4-ab83-84610f1405d7.hasUrls','true'),
	('sections.e6acd7d8-4560-486d-a427-0d4692807508.siteSettings.b34dff01-1c91-4de4-ab83-84610f1405d7.template','\"news/_entry\"'),
	('sections.e6acd7d8-4560-486d-a427-0d4692807508.siteSettings.b34dff01-1c91-4de4-ab83-84610f1405d7.uriFormat','\"news/{slug}\"'),
	('sections.e6acd7d8-4560-486d-a427-0d4692807508.type','\"channel\"'),
	('siteGroups.7675e13b-31b4-40d1-8025-a37fd35fb97f.name','\"Crafty Coffee\"'),
	('sites.b34dff01-1c91-4de4-ab83-84610f1405d7.baseUrl','\"$DEFAULT_SITE_URL\"'),
	('sites.b34dff01-1c91-4de4-ab83-84610f1405d7.handle','\"default\"'),
	('sites.b34dff01-1c91-4de4-ab83-84610f1405d7.hasUrls','true'),
	('sites.b34dff01-1c91-4de4-ab83-84610f1405d7.language','\"en-US\"'),
	('sites.b34dff01-1c91-4de4-ab83-84610f1405d7.name','\"Crafty Coffee\"'),
	('sites.b34dff01-1c91-4de4-ab83-84610f1405d7.primary','true'),
	('sites.b34dff01-1c91-4de4-ab83-84610f1405d7.siteGroup','\"7675e13b-31b4-40d1-8025-a37fd35fb97f\"'),
	('sites.b34dff01-1c91-4de4-ab83-84610f1405d7.sortOrder','1'),
	('system.edition','\"pro\"'),
	('system.live','true'),
	('system.name','\"Crafty Coffee\"'),
	('system.schemaVersion','\"3.4.9\"'),
	('system.timeZone','\"America/Chicago\"'),
	('users.allowPublicRegistration','false'),
	('users.defaultGroup','null'),
	('users.photoSubpath','\"\"'),
	('users.photoVolumeUid','null'),
	('users.requireEmailVerification','true'),
	('volumes.679feb39-d56f-43cf-9b9a-5c4009fa2324.handle','\"drinks\"'),
	('volumes.679feb39-d56f-43cf-9b9a-5c4009fa2324.hasUrls','true'),
	('volumes.679feb39-d56f-43cf-9b9a-5c4009fa2324.name','\"Drinks\"'),
	('volumes.679feb39-d56f-43cf-9b9a-5c4009fa2324.settings.path','\"@webroot/images/uploads/drinks\"'),
	('volumes.679feb39-d56f-43cf-9b9a-5c4009fa2324.sortOrder','1'),
	('volumes.679feb39-d56f-43cf-9b9a-5c4009fa2324.type','\"craft\\\\volumes\\\\Local\"'),
	('volumes.679feb39-d56f-43cf-9b9a-5c4009fa2324.url','\"@web/images/uploads/drinks\"');

/*!40000 ALTER TABLE `projectconfig` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table queue
# ------------------------------------------------------------

DROP TABLE IF EXISTS `queue`;

CREATE TABLE `queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `channel` varchar(255) NOT NULL DEFAULT 'queue',
  `job` longblob NOT NULL,
  `description` text DEFAULT NULL,
  `timePushed` int(11) NOT NULL,
  `ttr` int(11) NOT NULL,
  `delay` int(11) NOT NULL DEFAULT 0,
  `priority` int(11) unsigned NOT NULL DEFAULT 1024,
  `dateReserved` datetime DEFAULT NULL,
  `timeUpdated` int(11) DEFAULT NULL,
  `progress` smallint(6) NOT NULL DEFAULT 0,
  `progressLabel` varchar(255) DEFAULT NULL,
  `attempt` int(11) DEFAULT NULL,
  `fail` tinyint(1) DEFAULT 0,
  `dateFailed` datetime DEFAULT NULL,
  `error` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `queue_channel_fail_timeUpdated_timePushed_idx` (`channel`,`fail`,`timeUpdated`,`timePushed`),
  KEY `queue_channel_fail_timeUpdated_delay_idx` (`channel`,`fail`,`timeUpdated`,`delay`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table relations
# ------------------------------------------------------------

DROP TABLE IF EXISTS `relations`;

CREATE TABLE `relations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldId` int(11) NOT NULL,
  `sourceId` int(11) NOT NULL,
  `sourceSiteId` int(11) DEFAULT NULL,
  `targetId` int(11) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `relations_fieldId_sourceId_sourceSiteId_targetId_unq_idx` (`fieldId`,`sourceId`,`sourceSiteId`,`targetId`),
  KEY `relations_sourceId_idx` (`sourceId`),
  KEY `relations_targetId_idx` (`targetId`),
  KEY `relations_sourceSiteId_idx` (`sourceSiteId`),
  CONSTRAINT `relations_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `relations_sourceId_fk` FOREIGN KEY (`sourceId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `relations_sourceSiteId_fk` FOREIGN KEY (`sourceSiteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `relations_targetId_fk` FOREIGN KEY (`targetId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `relations` WRITE;
/*!40000 ALTER TABLE `relations` DISABLE KEYS */;

INSERT INTO `relations` (`id`, `fieldId`, `sourceId`, `sourceSiteId`, `targetId`, `sortOrder`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,5,5,NULL,15,1,'2020-02-09 19:06:20','2020-02-09 19:06:20','e2bdfa0e-c957-4a3a-b85e-d64c7b356a87'),
	(2,5,16,NULL,15,1,'2020-02-09 19:06:20','2020-02-09 19:06:20','5493e543-f609-45d9-b675-759a4ccb514b'),
	(4,5,19,NULL,17,1,'2020-02-09 19:11:42','2020-02-09 19:11:42','9b06484a-6018-4790-8ec6-6718a9b05234'),
	(5,5,20,NULL,17,1,'2020-02-09 19:11:43','2020-02-09 19:11:43','b4c548c2-0d3e-4c3b-9d9f-13b038b69b5a'),
	(6,5,37,NULL,15,1,'2020-02-09 21:26:21','2020-02-09 21:26:21','6f5b149e-a17e-4d15-a32b-0e26f78a0afa'),
	(7,10,49,NULL,15,1,'2020-02-15 21:11:57','2020-02-15 21:11:57','79c5ef61-595e-461d-b762-0a3719593479'),
	(8,10,51,NULL,15,1,'2020-02-15 21:12:05','2020-02-15 21:12:05','7925ba2c-f84b-4200-9501-021b0fbb7cb2'),
	(9,10,53,NULL,15,1,'2020-02-15 21:12:07','2020-02-15 21:12:07','c2d03ba0-f70e-46c2-9925-27e8a1bad5b0'),
	(10,10,56,NULL,15,1,'2020-02-15 21:12:21','2020-02-15 21:12:21','9495c318-60f1-43a2-a345-31692d7dec29'),
	(11,10,59,NULL,15,1,'2020-02-15 21:12:27','2020-02-15 21:12:27','5b0c5539-eb03-4027-81e7-8950204be35e'),
	(12,10,62,NULL,15,1,'2020-02-15 21:12:29','2020-02-15 21:12:29','0509d83b-7420-4c08-9298-888c6cfb0c60'),
	(13,10,66,NULL,15,1,'2020-02-15 21:12:46','2020-02-15 21:12:46','c73715d7-bed5-4725-9cb4-f9d5615dad21'),
	(14,10,70,NULL,15,1,'2020-02-15 21:12:48','2020-02-15 21:12:48','4c222748-2fc6-4376-b185-a2c2c781dc2c'),
	(15,10,75,NULL,15,1,'2020-02-15 21:12:50','2020-02-15 21:12:50','6c4c5569-cb9a-4582-add3-b0c4e49691d8'),
	(16,10,80,NULL,15,1,'2020-02-15 21:12:54','2020-02-15 21:12:54','16eb66a5-2964-41f3-a17b-b9c5f0c1c634'),
	(17,10,85,NULL,15,1,'2020-02-15 21:12:56','2020-02-15 21:12:56','0265749a-83ac-48e0-8131-8b10bfc49e31'),
	(18,10,90,NULL,15,1,'2020-02-15 21:12:57','2020-02-15 21:12:57','8c3c4019-5fed-42df-ba75-0145f0fe06ad'),
	(19,10,95,NULL,15,1,'2020-02-15 21:12:58','2020-02-15 21:12:58','88dc65c6-ac7e-41fe-aeaf-600997f025f6'),
	(20,10,100,NULL,15,1,'2020-02-15 21:13:00','2020-02-15 21:13:00','738a4fc9-d141-452b-9f95-481bb06733b0'),
	(21,10,105,NULL,15,1,'2020-02-15 21:13:02','2020-02-15 21:13:02','0c187160-bec3-4727-8d96-358c1591bb96'),
	(22,10,110,NULL,15,1,'2020-02-15 21:13:06','2020-02-15 21:13:06','f8ef500d-9919-4c24-8e8e-da7ceae5a794'),
	(23,10,115,NULL,15,1,'2020-02-15 21:13:07','2020-02-15 21:13:07','7bc47187-ad48-4af2-923a-7f4908c3309f'),
	(24,10,120,NULL,15,1,'2020-02-15 21:13:12','2020-02-15 21:13:12','11df0f90-2bb6-4893-a38d-889d5326b63e'),
	(25,10,125,NULL,15,1,'2020-02-15 21:13:14','2020-02-15 21:13:14','20dcb842-53ea-4560-9f69-6ebc0d07a0f5'),
	(26,10,130,NULL,15,1,'2020-02-15 21:13:14','2020-02-15 21:13:14','e9226249-587d-41c8-86cc-5db71f5ab409'),
	(27,10,135,NULL,15,1,'2020-02-15 21:13:19','2020-02-15 21:13:19','532c1c5c-ede2-4d57-9b24-2869ba6a687c'),
	(28,10,140,NULL,15,1,'2020-02-15 21:13:22','2020-02-15 21:13:22','566ea16b-bee7-4ca1-999a-f908574af3b4'),
	(29,10,146,NULL,15,1,'2020-02-15 21:13:25','2020-02-15 21:13:25','2ec3a139-9826-4584-afef-0847a7179e1d'),
	(30,10,152,NULL,15,1,'2020-02-15 21:13:29','2020-02-15 21:13:29','ca20607f-906e-4809-b44e-d9b4bbed32c8'),
	(31,10,159,NULL,15,1,'2020-02-15 21:13:35','2020-02-15 21:13:35','e84a2c2a-8e75-4b1c-94b8-69f1c46dca2b'),
	(32,10,166,NULL,15,1,'2020-02-15 21:13:37','2020-02-15 21:13:37','8517a5ce-1e85-41a8-b66c-1df4c91cb0ca'),
	(33,10,173,NULL,15,1,'2020-02-15 21:13:38','2020-02-15 21:13:38','0660f295-e29b-4520-b8c6-eaa8ba5a3fdf'),
	(34,10,180,NULL,15,1,'2020-02-15 21:13:41','2020-02-15 21:13:41','0e7af6eb-ca46-417b-89aa-dee37706f19d'),
	(35,10,187,NULL,15,1,'2020-02-15 21:13:42','2020-02-15 21:13:42','8c34b9a4-abe6-4d55-9ee7-e185bec03c83'),
	(36,10,194,NULL,15,1,'2020-02-15 21:13:47','2020-02-15 21:13:47','31ba5613-3b47-4241-bc8b-23b79a56c4cd'),
	(37,10,201,NULL,15,1,'2020-02-15 21:13:49','2020-02-15 21:13:49','407fedf2-71c0-4194-92dc-800e43363891'),
	(38,10,208,NULL,15,1,'2020-02-15 21:13:51','2020-02-15 21:13:51','8d227874-ef7c-4c1e-a1f2-ec899bb28b66'),
	(39,10,216,NULL,15,1,'2020-02-15 21:13:55','2020-02-15 21:13:55','ea832e64-182e-4f09-959c-e993ffcd0bdf'),
	(40,10,222,NULL,15,1,'2020-02-15 21:13:55','2020-02-15 21:13:55','6e6031c8-2102-43ba-8448-27e8e8e9ab89'),
	(41,10,224,NULL,15,1,'2020-02-15 21:13:59','2020-02-15 21:13:59','ade9f9de-0859-4631-b607-69ca2e1e2922'),
	(42,10,230,NULL,15,1,'2020-02-15 21:13:59','2020-02-15 21:13:59','0390629c-249f-448a-a3a6-2d94d3e599d5'),
	(43,10,232,NULL,15,1,'2020-02-15 21:14:00','2020-02-15 21:14:00','98771767-ca8e-4899-a8db-e40c96e30cc1'),
	(44,10,238,NULL,15,1,'2020-02-15 21:14:00','2020-02-15 21:14:00','306a018f-b38c-4991-bf67-2cd75e14addf'),
	(45,10,240,NULL,15,1,'2020-02-15 21:14:02','2020-02-15 21:14:02','97839787-4ff8-4532-9573-ca559a5ad2ae'),
	(46,10,246,NULL,15,1,'2020-02-15 21:14:02','2020-02-15 21:14:02','8da6d6e2-f41c-473b-a982-246d4376ec3c'),
	(47,10,249,NULL,15,1,'2020-02-15 21:14:11','2020-02-15 21:14:11','23855898-a2ef-40d3-88f3-a78a0552dabc'),
	(48,10,255,NULL,15,1,'2020-02-15 21:14:11','2020-02-15 21:14:11','2a37d977-c6ac-4278-9596-6bdd4d22242d'),
	(49,10,258,NULL,15,1,'2020-02-15 21:14:12','2020-02-15 21:14:12','600de615-6ca2-4cba-9ff4-20da512b2546'),
	(50,10,264,NULL,15,1,'2020-02-15 21:14:12','2020-02-15 21:14:12','380daec5-f8b1-4dd3-a368-67014f275323'),
	(51,10,267,NULL,15,1,'2020-02-15 21:14:12','2020-02-15 21:14:12','890c0fa3-5f88-42ea-a579-611dcb200615'),
	(52,10,273,NULL,15,1,'2020-02-15 21:14:13','2020-02-15 21:14:13','2ce7d644-fa1f-4717-96c5-aed39c1317a0'),
	(53,10,276,NULL,15,1,'2020-02-15 21:14:18','2020-02-15 21:14:18','40cb92fd-08f8-4aec-9227-02fc3ab69319'),
	(54,10,282,NULL,15,1,'2020-02-15 21:14:18','2020-02-15 21:14:18','133b41de-c1f6-4417-a4cf-b00029297636'),
	(55,10,285,NULL,15,1,'2020-02-15 21:14:19','2020-02-15 21:14:19','819ff303-caae-44fa-8901-e514b95432e3'),
	(56,10,291,NULL,15,1,'2020-02-15 21:14:19','2020-02-15 21:14:19','a8693386-adf7-4496-867e-262f3bec2ff5'),
	(57,10,294,NULL,15,1,'2020-02-15 21:14:22','2020-02-15 21:14:22','3eb70e78-c70b-4192-bb28-d51cb2260600'),
	(58,10,300,NULL,15,1,'2020-02-15 21:14:22','2020-02-15 21:14:22','f0f7011c-cc0f-4e45-8f10-85e0f6074d89'),
	(59,10,303,NULL,15,1,'2020-02-15 21:14:28','2020-02-15 21:14:28','47b8ddb1-accd-4463-ac83-62f2fc03504e'),
	(60,10,310,NULL,15,1,'2020-02-15 21:14:28','2020-02-15 21:14:28','04dbc2af-aa7f-4c68-8206-4c85318589e4'),
	(61,10,312,NULL,15,1,'2020-02-15 21:14:35','2020-02-15 21:14:35','1a68ea43-f71e-4bdd-818e-fd339ce63d5f'),
	(62,10,320,NULL,15,1,'2020-02-15 21:14:35','2020-02-15 21:14:35','ae99e302-769e-440f-ab54-2c451e497714'),
	(63,10,322,NULL,15,1,'2020-02-15 21:14:42','2020-02-15 21:14:42','df249f5d-d733-4952-83cc-e25dc5417190'),
	(64,10,330,NULL,15,1,'2020-02-15 21:14:42','2020-02-15 21:14:42','8a72cf1b-b5b2-41dd-a771-dc9c4d4f3dbb'),
	(65,10,332,NULL,15,1,'2020-02-15 21:14:46','2020-02-15 21:14:46','96701286-8c45-442a-85b8-ff0d52f26c08'),
	(66,10,340,NULL,15,1,'2020-02-15 21:14:46','2020-02-15 21:14:46','90f51386-62c6-4438-bfe7-4424cb0392e1'),
	(67,10,342,NULL,15,1,'2020-02-15 21:14:49','2020-02-15 21:14:49','fae6b0a0-c16c-4fad-9507-495a4b9db002'),
	(68,10,350,NULL,15,1,'2020-02-15 21:14:49','2020-02-15 21:14:49','6cd5f7a2-68b7-4177-85ce-30635fc552de'),
	(69,10,352,NULL,15,1,'2020-02-15 21:14:51','2020-02-15 21:14:51','99c76df2-e060-4238-970c-cf95dbf556ec'),
	(70,10,360,NULL,15,1,'2020-02-15 21:14:51','2020-02-15 21:14:51','d016de4e-5c9f-4192-a949-bba8d2285f2f'),
	(71,10,362,NULL,15,1,'2020-02-15 21:14:51','2020-02-15 21:14:51','45046869-2205-477b-ab14-76ea9f0cf126'),
	(72,10,370,NULL,15,1,'2020-02-15 21:14:51','2020-02-15 21:14:51','ef2f8686-aed2-4e46-86a9-3f72c6e3fe38'),
	(75,10,383,NULL,15,1,'2020-02-15 21:15:15','2020-02-15 21:15:15','376711fa-f8d0-444b-8261-a4df56b9d4fd'),
	(76,10,391,NULL,15,1,'2020-02-15 21:15:15','2020-02-15 21:15:15','a48d3293-e964-4d62-a994-bb852e899e84'),
	(77,10,394,NULL,15,1,'2020-02-15 21:15:16','2020-02-15 21:15:16','90572da8-9b22-4233-9ad6-5330c3ede98e'),
	(78,10,402,NULL,15,1,'2020-02-15 21:15:16','2020-02-15 21:15:16','87ab9db8-b09c-4fbb-a2f0-0dba82f2aa12'),
	(81,10,422,NULL,17,1,'2020-02-15 22:14:32','2020-02-15 22:14:32','21c25730-35fd-40cb-8aeb-6783ec2f2c0a'),
	(83,10,427,NULL,15,1,'2020-02-15 22:15:01','2020-02-15 22:15:01','13dfc262-773c-4980-9924-f5e83d0d8976'),
	(84,10,432,NULL,17,1,'2020-02-15 22:15:01','2020-02-15 22:15:01','9566192e-f909-4066-a2ff-24bfb56097b0'),
	(85,10,434,NULL,15,1,'2020-02-15 22:15:01','2020-02-15 22:15:01','a7e8668d-4c86-4dd6-a6e8-a189a6a8e508'),
	(86,10,440,NULL,15,1,'2020-02-15 22:15:02','2020-02-15 22:15:02','4eb4c023-3bce-4816-b6f7-def883ebfd79'),
	(87,10,445,NULL,17,1,'2020-02-15 22:15:02','2020-02-15 22:15:02','f8a01966-d971-466d-bbf8-507dcaba9cc7'),
	(88,10,447,NULL,15,1,'2020-02-15 22:15:02','2020-02-15 22:15:02','26df23d9-b7ee-4e92-86e0-6fc97372c0cc'),
	(89,17,381,NULL,451,1,'2020-02-15 22:50:45','2020-02-15 22:50:45','881540c1-4ff2-4cb4-8b3c-95ef6c3c32f3'),
	(90,17,452,NULL,451,1,'2020-02-15 22:50:45','2020-02-15 22:50:45','fc539be5-1b88-4dc1-9f89-c870df32f401'),
	(91,10,454,NULL,15,1,'2020-02-15 22:50:45','2020-02-15 22:50:45','66fb114b-c82a-4946-b0d8-eeeed3b5aebd'),
	(92,10,459,NULL,17,1,'2020-02-15 22:50:45','2020-02-15 22:50:45','edb4c314-2abb-4eb4-9854-dac773165cdc'),
	(93,10,461,NULL,15,1,'2020-02-15 22:50:45','2020-02-15 22:50:45','856bb76a-f6d5-4ff0-9455-13035fb943ba'),
	(94,17,5,NULL,451,1,'2020-02-15 22:51:26','2020-02-15 22:51:26','ce539b9b-e567-4c20-b9f4-23c803231c5f'),
	(95,17,465,NULL,451,1,'2020-02-15 22:51:26','2020-02-15 22:51:26','45d7cde9-681f-44e8-ab7b-74fdea2c338b'),
	(96,5,465,NULL,15,1,'2020-02-15 22:51:26','2020-02-15 22:51:26','4159eb28-ede0-4f12-aa99-689f5b7245d5'),
	(97,17,19,NULL,451,1,'2020-02-15 23:27:27','2020-02-15 23:27:27','34e8ea50-1ebc-400f-9d93-0628b5724295'),
	(98,17,466,NULL,451,1,'2020-02-15 23:27:27','2020-02-15 23:27:27','c7c8f261-8b11-4c83-9280-a6669aa79b00'),
	(99,5,466,NULL,17,1,'2020-02-15 23:27:27','2020-02-15 23:27:27','5f2c9c8c-90d9-4a11-8bc4-72613e6985c5'),
	(100,17,468,NULL,467,1,'2020-02-16 00:02:30','2020-02-16 00:02:30','39e672cd-40d8-4001-aac6-d476ebc1a502'),
	(101,17,470,NULL,467,1,'2020-02-16 00:02:30','2020-02-16 00:02:30','038c9c11-aaf3-4e3a-a79a-56132b9a5604'),
	(102,18,19,NULL,468,1,'2020-02-16 00:02:37','2020-02-16 00:02:37','8a407119-a749-4112-b5a6-33514d4ed67a'),
	(103,17,471,NULL,451,1,'2020-02-16 00:02:37','2020-02-16 00:02:37','04a9d115-7723-4f20-98f2-0b9923300690'),
	(104,5,471,NULL,17,1,'2020-02-16 00:02:37','2020-02-16 00:02:37','56a6938f-eb1e-487c-9774-c3ac16eca20e'),
	(105,18,471,NULL,468,1,'2020-02-16 00:02:37','2020-02-16 00:02:37','c9bdebe5-74d1-4390-a941-48dec270e447'),
	(106,18,5,NULL,381,1,'2020-02-16 00:02:47','2020-02-16 00:02:47','eec934e9-fba0-4e4e-ba6e-455594f08639'),
	(107,17,472,NULL,451,1,'2020-02-16 00:02:47','2020-02-16 00:02:47','df4f6bf4-e569-4fd7-98bc-713be2e44e4f'),
	(108,5,472,NULL,15,1,'2020-02-16 00:02:47','2020-02-16 00:02:47','e277da56-bf2e-4783-97a5-cebbceaf3b99'),
	(109,18,472,NULL,381,1,'2020-02-16 00:02:47','2020-02-16 00:02:47','bc2f6931-e20f-46d3-81c3-15629ac6137e');

/*!40000 ALTER TABLE `relations` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table resourcepaths
# ------------------------------------------------------------

DROP TABLE IF EXISTS `resourcepaths`;

CREATE TABLE `resourcepaths` (
  `hash` varchar(255) NOT NULL,
  `path` varchar(255) NOT NULL,
  PRIMARY KEY (`hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `resourcepaths` WRITE;
/*!40000 ALTER TABLE `resourcepaths` DISABLE KEYS */;

INSERT INTO `resourcepaths` (`hash`, `path`)
VALUES
	('14974bc','@app/web/assets/userpermissions/dist'),
	('14f58c76','@lib/jquery.payment'),
	('168732ca','@app/web/assets/tablesettings/dist'),
	('195dd4e3','@bower/jquery/dist'),
	('1bed500b','@app/web/assets/cp/dist'),
	('1c4f813e','@craft/web/assets/craftsupport/dist'),
	('1c8416be','@craft/web/assets/editentry/dist'),
	('1fad5c95','@app/web/assets/utilities/dist'),
	('1fb7a7de','@lib/element-resize-detector'),
	('21a8fb56','@lib/velocity'),
	('235abc7a','@craft/web/assets/feed/dist'),
	('23e837d2','@craft/web/assets/matrixsettings/dist'),
	('2607c3e','@craft/redactor/assets/field/dist'),
	('2725d7cd','@craft/web/assets/edituser/dist'),
	('2c8a50e9','@yii/debug/assets'),
	('2d0d8d61','@craft/feedme/web/assets/feedme/dist'),
	('30270c2b','@bower/jquery/dist'),
	('350701d5','@app/web/assets/matrixsettings/dist'),
	('36cd7f16','@lib/element-resize-detector'),
	('3a13a42','@craft/web/assets/deprecationerrors/dist'),
	('3c22d4be','@craft/web/assets/dashboard/dist'),
	('3d8f54be','@lib/jquery.payment'),
	('3efe4785','@craft/web/assets/plugins/dist'),
	('4561f275','@craft/web/assets/feed/dist'),
	('456e11ce','@craft/web/assets/edittransform/dist'),
	('45865eee','@nystudio107/seomatic/assetbundles/seomatic/dist'),
	('45c7788b','@craft/web/assets/assetindexes/dist'),
	('46130785','@app/web/assets/findreplace/dist'),
	('467bb83b','@lib/jquery-ui'),
	('48233f89','@app/web/assets/installer/dist'),
	('483d83cf','@lib/vue'),
	('4a8517f6','@app/web/assets/generalsettings/dist'),
	('4c3fd450','@app/web/assets/graphiql/dist'),
	('4cacf872','@lib/axios'),
	('4cd55ba','@app/web/assets/feed/dist'),
	('4e7429d8','@app/web/assets/updater/dist'),
	('50b3d726','@app/web/assets/craftsupport/dist'),
	('5413d747','@app/web/assets/systemmessages/dist'),
	('59bce19f','@vendor/yiisoft/yii2/assets'),
	('5a199ab1','@craft/web/assets/dashboard/dist'),
	('5e1c5598','@craft/web/assets/editsection/dist'),
	('5e217be7','@app/web/assets/updateswidget/dist'),
	('5f38be8','@craft/web/assets/updates/dist'),
	('6023f47','@craft/web/assets/newusers/dist'),
	('60397148','@craft/web/assets/newusers/dist'),
	('609b3989','@app/web/assets/recententries/dist'),
	('61475b07','@lib/vue'),
	('63c8c5e7','@craft/web/assets/updates/dist'),
	('65d620ba','@lib/axios'),
	('66ee532f','@app/web/assets/pluginstore/dist'),
	('6f0160f3','@lib/jquery-ui'),
	('727278fc','@craft/web/assets/login/dist'),
	('7802a5b5','@amimpact/commandpalette/assetbundles/palette/dist'),
	('79e80b7a','@app/web/assets/login/dist'),
	('7a74cf31','@craft/web/assets/craftsupport/dist'),
	('7dd61e04','@app/web/assets/cp/dist'),
	('7f3ae1be','@vendor/craftcms/redactor/lib/redactor'),
	('8193df6b','@app/web/assets/dbbackup/dist'),
	('8195077b','@lib/garnishjs'),
	('85593559','@craft/web/assets/recententries/dist'),
	('8d1fe99a','@lib/fileupload'),
	('8d2239e','@lib/velocity'),
	('90d5de2f','@lib/prismjs'),
	('9149461e','@app/web/assets/newusers/dist'),
	('9253d4a6','@lib/jquery-touch-events'),
	('94d3d345','@lib/fabric'),
	('957e7015','@craft/web/assets/tablesettings/dist'),
	('958f0c1a','@craft/web/assets/matrix/dist'),
	('95f7e864','@lib/picturefill'),
	('9a2b5354','@app/web/assets/plugins/dist'),
	('9b52c835','@lib/d3'),
	('9d54d863','@craft/web/assets/utilities/dist'),
	('9e7d9248','@app/web/assets/editentry/dist'),
	('9f3b0e29','@craft/web/assets/userpermissions/dist'),
	('a1269f39','@app/web/assets/updates/dist'),
	('a19daea6','@craft/web/assets/cp/dist'),
	('a4653152','@lib/fileupload'),
	('a8e69edb','@craft/web/assets/pluginstore/dist'),
	('a8efdfb3','@lib/garnishjs'),
	('b0703a54','@app/web/assets/queuemanager/dist'),
	('b22810fd','@lib/d3'),
	('b4423ab5','@craft/web/assets/admintable/dist'),
	('b9bc7e06','@app/web/assets/fields/dist'),
	('bb290c6e','@lib/jquery-touch-events'),
	('bc8d30ac','@lib/picturefill'),
	('bd6cc260','@craft/web/assets/fields/dist'),
	('bda90b8d','@lib/fabric'),
	('bedb5048','@app/web/assets/dashboard/dist'),
	('bf47424d','@app/web/assets/deprecationerrors/dist'),
	('c189c5e0','@lib/selectize'),
	('c2ea5cce','@vendor/craftcms/redactor/lib/redactor-plugins/fullscreen'),
	('c7a6e0a9','@craft/web/assets/cp/dist'),
	('cadabb7f','@craft/web/assets/installer/dist'),
	('cbe5816a','@lib/xregexp'),
	('ceddd0d4','@craft/web/assets/pluginstore/dist'),
	('d655e09b','@app/web/assets/edituser/dist'),
	('ddd83938','@craft/web/assets/updateswidget/dist'),
	('e01e9418','@app/web/assets/admintable/dist'),
	('e29f59a2','@lib/xregexp'),
	('e3627b56','@craft/web/assets/recententries/dist'),
	('e8f31d28','@lib/selectize'),
	('eaa13d09','@craft/web/assets/updater/dist'),
	('ed4bb1f6','@app/web/assets/clearcaches/dist'),
	('f41ad91f','@lib/timepicker'),
	('f5bfa628','@vendor/craftcms/redactor/lib/redactor-plugins/video'),
	('f62fd663','@app/web/assets/editsection/dist'),
	('fb6f966c','@craft/web/assets/utilities/dist');

/*!40000 ALTER TABLE `resourcepaths` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table revisions
# ------------------------------------------------------------

DROP TABLE IF EXISTS `revisions`;

CREATE TABLE `revisions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sourceId` int(11) NOT NULL,
  `creatorId` int(11) DEFAULT NULL,
  `num` int(11) NOT NULL,
  `notes` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `revisions_sourceId_num_unq_idx` (`sourceId`,`num`),
  KEY `revisions_creatorId_fk` (`creatorId`),
  CONSTRAINT `revisions_creatorId_fk` FOREIGN KEY (`creatorId`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `revisions_sourceId_fk` FOREIGN KEY (`sourceId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `revisions` WRITE;
/*!40000 ALTER TABLE `revisions` DISABLE KEYS */;

INSERT INTO `revisions` (`id`, `sourceId`, `creatorId`, `num`, `notes`)
VALUES
	(1,5,1,1,NULL),
	(2,9,1,1,NULL),
	(3,11,1,1,NULL),
	(4,11,1,2,NULL),
	(5,11,1,3,NULL),
	(6,5,1,2,NULL),
	(7,19,1,1,NULL),
	(8,22,1,1,NULL),
	(9,25,1,1,NULL),
	(10,28,1,1,NULL),
	(11,31,1,1,NULL),
	(12,22,1,2,NULL),
	(13,11,1,4,NULL),
	(14,11,1,5,NULL),
	(15,11,1,6,NULL),
	(16,5,1,3,NULL),
	(17,39,1,1,NULL),
	(18,25,1,2,NULL),
	(19,28,1,2,NULL),
	(20,381,1,1,NULL),
	(21,381,1,2,'Applied “Draft 1”'),
	(22,381,1,3,NULL),
	(23,5,1,4,NULL),
	(24,19,1,2,NULL),
	(25,468,1,1,NULL),
	(26,19,1,3,NULL),
	(27,5,1,5,NULL);

/*!40000 ALTER TABLE `revisions` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table searchindex
# ------------------------------------------------------------

DROP TABLE IF EXISTS `searchindex`;

CREATE TABLE `searchindex` (
  `elementId` int(11) NOT NULL,
  `attribute` varchar(25) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `keywords` text NOT NULL,
  PRIMARY KEY (`elementId`,`attribute`,`fieldId`,`siteId`),
  FULLTEXT KEY `searchindex_keywords_idx` (`keywords`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

LOCK TABLES `searchindex` WRITE;
/*!40000 ALTER TABLE `searchindex` DISABLE KEYS */;

INSERT INTO `searchindex` (`elementId`, `attribute`, `fieldId`, `siteId`, `keywords`)
VALUES
	(1,'fullname',0,1,' ryan irelan '),
	(1,'lastname',0,1,' irelan '),
	(1,'username',0,1,' admin '),
	(1,'firstname',0,1,' ryan '),
	(5,'slug',0,1,' espresso '),
	(5,'title',0,1,' perfect espresso '),
	(5,'field',2,1,' lorem ipsum dolor sit amet consectetur adipisicing elit animi aspernatur deleniti dignissimos est explicabo iure laborum minima natus nihil qui repudiandae velit voluptatum animi id illo illum in maiores velit lorem ipsum dolor sit amet consectetur adipisicing elit animi aspernatur deleniti dignissimos est explicabo iure laborum minima natus nihil qui repudiandae velit voluptatum animi id illo illum in maiores velit lorem ipsum dolor sit amet consectetur adipisicing elit animi aspernatur deleniti dignissimos est explicabo iure laborum minima natus nihil qui repudiandae velit voluptatum animi id illo illum in maiores velit lorem ipsum dolor sit amet consectetur adipisicing elit animi aspernatur deleniti dignissimos est explicabo iure laborum minima natus nihil qui repudiandae velit voluptatum animi id illo illum in maiores velit lorem ipsum dolor sit amet consectetur adipisicing elit animi aspernatur deleniti dignissimos est explicabo iure laborum minima natus nihil qui repudiandae velit voluptatum animi id illo illum in maiores velit lorem ipsum dolor sit amet consectetur adipisicing elit animi aspernatur deleniti dignissimos est explicabo iure laborum minima natus nihil qui repudiandae velit voluptatum animi id illo illum in maiores velit '),
	(9,'slug',0,1,' new coffee coming soon '),
	(9,'title',0,1,' new coffee coming soon '),
	(9,'field',3,1,' check out the new coffee style coming to crafty coffee '),
	(9,'field',4,1,' lorem ipsum dolor sit amet consectetur adipisicing elit animi aspernatur deleniti dignissimos est explicabo iure laborum minima natus nihil qui repudiandae velit voluptatum animi id illo illum in maiores velit lorem ipsum dolor sit amet consectetur adipisicing elit animi aspernatur deleniti dignissimos est explicabo iure laborum minima natus nihil qui repudiandae velit voluptatum animi id illo illum in maiores velit lorem ipsum dolor sit amet consectetur adipisicing elit animi aspernatur deleniti dignissimos est explicabo iure laborum minima natus nihil qui repudiandae velit voluptatum animi id illo illum in maiores velit lorem ipsum dolor sit amet consectetur adipisicing elit animi aspernatur deleniti dignissimos est explicabo iure laborum minima natus nihil qui repudiandae velit voluptatum animi id illo illum in maiores velit lorem ipsum dolor sit amet consectetur adipisicing elit animi aspernatur deleniti dignissimos est explicabo iure laborum minima natus nihil qui repudiandae velit voluptatum animi id illo illum in maiores velit lorem ipsum dolor sit amet consectetur adipisicing elit animi aspernatur deleniti dignissimos est explicabo iure laborum minima natus nihil qui repudiandae velit voluptatum animi id illo illum in maiores velit '),
	(11,'title',0,1,' crafty coffee '),
	(11,'slug',0,1,' homepage '),
	(15,'filename',0,1,' espresso shot jpg '),
	(15,'extension',0,1,' jpg '),
	(15,'kind',0,1,' image '),
	(15,'slug',0,1,''),
	(15,'title',0,1,' espresso shot '),
	(5,'field',5,1,' espresso shot '),
	(17,'filename',0,1,' iced coffee jpg '),
	(17,'extension',0,1,' jpg '),
	(17,'kind',0,1,' image '),
	(17,'slug',0,1,''),
	(17,'title',0,1,' iced coffee '),
	(19,'field',1,1,' intro '),
	(19,'field',2,1,' page copy '),
	(19,'field',5,1,' iced coffee '),
	(22,'title',0,1,' about '),
	(22,'slug',0,1,' about '),
	(25,'title',0,1,' locations '),
	(25,'slug',0,1,' locations '),
	(28,'title',0,1,' austin tx '),
	(28,'slug',0,1,' austin tx '),
	(31,'slug',0,1,' mission statement '),
	(31,'title',0,1,' mission statement '),
	(22,'field',6,1,' this is a subtitle '),
	(22,'field',7,1,' this is a page intro '),
	(22,'field',2,1,' this is the page copy '),
	(11,'field',6,1,' if we wrote it down you can make it at homezzzzz '),
	(5,'field',1,1,' the best shot youve ever had '),
	(1,'email',0,1,' ryan mijingo com '),
	(1,'slug',0,1,''),
	(39,'slug',0,1,' acquired by starbucks '),
	(39,'title',0,1,' acquired by starbucks '),
	(39,'field',3,1,' this is amazing '),
	(39,'field',4,1,' lorem ipsum dolor sit amet consectetur adipisicing elit animi aspernatur deleniti dignissimos est explicabo iure laborum minima natus nihil qui repudiandae velit voluptatum animi id illo illum in maiores velit lorem ipsum dolor sit amet consectetur adipisicing elit animi aspernatur deleniti dignissimos est explicabo iure laborum minima natus nihil qui repudiandae velit voluptatum animi id illo illum in maiores velit lorem ipsum dolor sit amet consectetur adipisicing elit animi aspernatur deleniti dignissimos est explicabo iure laborum minima natus nihil qui repudiandae velit voluptatum animi id illo illum in maiores velit lorem ipsum dolor sit amet consectetur adipisicing elit animi aspernatur deleniti dignissimos est explicabo iure laborum minima natus nihil qui repudiandae velit voluptatum animi id illo illum in maiores velit lorem ipsum dolor sit amet consectetur adipisicing elit animi aspernatur deleniti dignissimos est explicabo iure laborum minima natus nihil qui repudiandae velit voluptatum animi id illo illum in maiores velit lorem ipsum dolor sit amet consectetur adipisicing elit animi aspernatur deleniti dignissimos est explicabo iure laborum minima natus nihil qui repudiandae velit voluptatum animi id illo illum in maiores velit '),
	(25,'field',6,1,' where we are in the world '),
	(25,'field',7,1,' we have office across the world visit us anywhere '),
	(25,'field',2,1,' page copy '),
	(28,'field',6,1,' live music capitol of the world '),
	(28,'field',7,1,' page intro '),
	(28,'field',2,1,' page copy '),
	(381,'title',0,1,' perfect espresso '),
	(381,'slug',0,1,' perfect espresso '),
	(381,'field',8,1,' this is the initial page copy espresso shot the perfect espresso time to drink be careful with the water temperature its important that the water is hot enough but not to hot lorem ipsum dolor sit amet consectetur adipisicing elit animi aspernatur deleniti dignissimos est explicabo iure laborum minima natus nihil qui repudiandae velit voluptatum animi id illo illum in maiores velit lorem ipsum dolor sit amet consectetur adipisicing elit animi aspernatur deleniti dignissimos est explicabo iure laborum minima natus nihil qui repudiandae velit voluptatum animi id illo illum in maiores velit lorem ipsum dolor sit amet consectetur adipisicing elit animi aspernatur deleniti dignissimos est explicabo iure laborum minima natus nihil qui repudiandae velit voluptatum animi id illo illum in maiores velit lorem ipsum dolor sit amet consectetur adipisicing elit animi aspernatur deleniti dignissimos est explicabo iure laborum minima natus nihil qui repudiandae velit voluptatum animi id illo illum in maiores velit lorem ipsum dolor sit amet consectetur adipisicing elit animi aspernatur deleniti dignissimos est explicabo iure laborum minima natus nihil qui repudiandae velit voluptatum animi id illo illum in maiores velit 22 grams ground coffee 22 grams ground coffee 4 oz hot water 4 oz hot water 1 espresso machine 1 espresso machine lorem ipsum dolor sit amet consectetur adipisicing elit animi aspernatur deleniti dignissimos est explicabo iure laborum minima natus nihil qui repudiandae velit voluptatum animi id illo illum in maiores velit lorem ipsum dolor sit amet consectetur adipisicing elit animi aspernatur deleniti dignissimos est explicabo iure laborum minima natus nihil qui repudiandae velit voluptatum animi id illo illum in maiores velit lorem ipsum dolor sit amet consectetur adipisicing elit animi aspernatur deleniti dignissimos est explicabo iure laborum minima natus nihil qui repudiandae velit voluptatum animi id illo illum in maiores velit lorem ipsum dolor sit amet consectetur adipisicing elit animi aspernatur deleniti dignissimos est explicabo iure laborum minima natus nihil qui repudiandae velit voluptatum animi id illo illum in maiores velit lorem ipsum dolor sit amet consectetur adipisicing elit animi aspernatur deleniti dignissimos est explicabo iure laborum minima natus nihil qui repudiandae velit voluptatum animi id illo illum in maiores velit iced coffee get the best espresso machine you can afford it makes a difference espresso shot another of the same go to the whole foods market go to the whole foods market buying good coffee beans clean up the area clean up the area turn on espresso machine turn on espresso machine preparing your workspace instruction 1 instruction 1 instruction 2 instruction 2 grinding the coffee '),
	(382,'slug',0,1,''),
	(382,'field',12,1,' this is the initial page copy '),
	(383,'slug',0,1,''),
	(383,'field',10,1,' espresso shot '),
	(383,'field',9,1,' the perfect espresso time to drink '),
	(384,'slug',0,1,''),
	(384,'field',11,1,' be careful with the water temperature its important that the water is hot enough but not to hot '),
	(385,'slug',0,1,''),
	(385,'field',12,1,' lorem ipsum dolor sit amet consectetur adipisicing elit animi aspernatur deleniti dignissimos est explicabo iure laborum minima natus nihil qui repudiandae velit voluptatum animi id illo illum in maiores velit lorem ipsum dolor sit amet consectetur adipisicing elit animi aspernatur deleniti dignissimos est explicabo iure laborum minima natus nihil qui repudiandae velit voluptatum animi id illo illum in maiores velit lorem ipsum dolor sit amet consectetur adipisicing elit animi aspernatur deleniti dignissimos est explicabo iure laborum minima natus nihil qui repudiandae velit voluptatum animi id illo illum in maiores velit lorem ipsum dolor sit amet consectetur adipisicing elit animi aspernatur deleniti dignissimos est explicabo iure laborum minima natus nihil qui repudiandae velit voluptatum animi id illo illum in maiores velit lorem ipsum dolor sit amet consectetur adipisicing elit animi aspernatur deleniti dignissimos est explicabo iure laborum minima natus nihil qui repudiandae velit voluptatum animi id illo illum in maiores velit '),
	(386,'slug',0,1,''),
	(386,'field',15,1,' 22 grams ground coffee 22 grams ground coffee 4 oz hot water 4 oz hot water 1 espresso machine 1 espresso machine '),
	(387,'slug',0,1,''),
	(387,'field',12,1,' lorem ipsum dolor sit amet consectetur adipisicing elit animi aspernatur deleniti dignissimos est explicabo iure laborum minima natus nihil qui repudiandae velit voluptatum animi id illo illum in maiores velit lorem ipsum dolor sit amet consectetur adipisicing elit animi aspernatur deleniti dignissimos est explicabo iure laborum minima natus nihil qui repudiandae velit voluptatum animi id illo illum in maiores velit lorem ipsum dolor sit amet consectetur adipisicing elit animi aspernatur deleniti dignissimos est explicabo iure laborum minima natus nihil qui repudiandae velit voluptatum animi id illo illum in maiores velit lorem ipsum dolor sit amet consectetur adipisicing elit animi aspernatur deleniti dignissimos est explicabo iure laborum minima natus nihil qui repudiandae velit voluptatum animi id illo illum in maiores velit lorem ipsum dolor sit amet consectetur adipisicing elit animi aspernatur deleniti dignissimos est explicabo iure laborum minima natus nihil qui repudiandae velit voluptatum animi id illo illum in maiores velit '),
	(388,'slug',0,1,''),
	(388,'field',13,1,' preparing your workspace '),
	(388,'field',14,1,' clean up the area clean up the area turn on espresso machine turn on espresso machine '),
	(389,'slug',0,1,''),
	(389,'field',13,1,' grinding the coffee '),
	(389,'field',14,1,' instruction 1 instruction 1 instruction 2 instruction 2 '),
	(390,'slug',0,1,''),
	(390,'field',11,1,' get the best espresso machine you can afford it makes a difference '),
	(391,'slug',0,1,''),
	(391,'field',10,1,' espresso shot '),
	(391,'field',9,1,' another of the same '),
	(426,'slug',0,1,''),
	(426,'field',12,1,' this is the initial page copy '),
	(427,'slug',0,1,''),
	(427,'field',10,1,' espresso shot '),
	(427,'field',9,1,' the perfect espresso time to drink '),
	(428,'slug',0,1,''),
	(428,'field',11,1,' be careful with the water temperature its important that the water is hot enough but not to hot '),
	(429,'slug',0,1,''),
	(429,'field',12,1,' lorem ipsum dolor sit amet consectetur adipisicing elit animi aspernatur deleniti dignissimos est explicabo iure laborum minima natus nihil qui repudiandae velit voluptatum animi id illo illum in maiores velit lorem ipsum dolor sit amet consectetur adipisicing elit animi aspernatur deleniti dignissimos est explicabo iure laborum minima natus nihil qui repudiandae velit voluptatum animi id illo illum in maiores velit lorem ipsum dolor sit amet consectetur adipisicing elit animi aspernatur deleniti dignissimos est explicabo iure laborum minima natus nihil qui repudiandae velit voluptatum animi id illo illum in maiores velit lorem ipsum dolor sit amet consectetur adipisicing elit animi aspernatur deleniti dignissimos est explicabo iure laborum minima natus nihil qui repudiandae velit voluptatum animi id illo illum in maiores velit lorem ipsum dolor sit amet consectetur adipisicing elit animi aspernatur deleniti dignissimos est explicabo iure laborum minima natus nihil qui repudiandae velit voluptatum animi id illo illum in maiores velit '),
	(430,'slug',0,1,''),
	(430,'field',15,1,' 22 grams ground coffee 22 grams ground coffee 4 oz hot water 4 oz hot water 1 espresso machine 1 espresso machine '),
	(431,'slug',0,1,''),
	(431,'field',12,1,' lorem ipsum dolor sit amet consectetur adipisicing elit animi aspernatur deleniti dignissimos est explicabo iure laborum minima natus nihil qui repudiandae velit voluptatum animi id illo illum in maiores velit lorem ipsum dolor sit amet consectetur adipisicing elit animi aspernatur deleniti dignissimos est explicabo iure laborum minima natus nihil qui repudiandae velit voluptatum animi id illo illum in maiores velit lorem ipsum dolor sit amet consectetur adipisicing elit animi aspernatur deleniti dignissimos est explicabo iure laborum minima natus nihil qui repudiandae velit voluptatum animi id illo illum in maiores velit lorem ipsum dolor sit amet consectetur adipisicing elit animi aspernatur deleniti dignissimos est explicabo iure laborum minima natus nihil qui repudiandae velit voluptatum animi id illo illum in maiores velit lorem ipsum dolor sit amet consectetur adipisicing elit animi aspernatur deleniti dignissimos est explicabo iure laborum minima natus nihil qui repudiandae velit voluptatum animi id illo illum in maiores velit '),
	(432,'slug',0,1,''),
	(432,'field',10,1,' iced coffee '),
	(432,'field',9,1,''),
	(433,'slug',0,1,''),
	(433,'field',11,1,' get the best espresso machine you can afford it makes a difference '),
	(434,'slug',0,1,''),
	(434,'field',10,1,' espresso shot '),
	(434,'field',9,1,' another of the same '),
	(435,'slug',0,1,''),
	(435,'field',13,1,' buying good coffee beans '),
	(435,'field',14,1,' go to the whole foods market go to the whole foods market '),
	(436,'slug',0,1,''),
	(436,'field',13,1,' preparing your workspace '),
	(436,'field',14,1,' clean up the area clean up the area turn on espresso machine turn on espresso machine '),
	(437,'slug',0,1,''),
	(437,'field',13,1,' grinding the coffee '),
	(437,'field',14,1,' instruction 1 instruction 1 instruction 2 instruction 2 '),
	(451,'slug',0,1,' espresso '),
	(451,'title',0,1,' espresso '),
	(451,'field',16,1,' all drinks made with the delicious espresso roasted bean and pressure brewed technique '),
	(381,'field',17,1,' espresso '),
	(5,'field',17,1,' espresso '),
	(19,'slug',0,1,' iced coffee '),
	(19,'field',17,1,' espresso '),
	(467,'slug',0,1,' iced drinks '),
	(467,'title',0,1,' iced drinks '),
	(467,'field',16,1,' iced drinks for hot days '),
	(469,'slug',0,1,''),
	(469,'field',12,1,' placeholder copy here '),
	(468,'slug',0,1,' iced americano '),
	(468,'title',0,1,' iced americano '),
	(468,'field',17,1,' iced drinks '),
	(468,'field',8,1,' placeholder copy here '),
	(19,'title',0,1,' iced americano '),
	(19,'field',18,1,' iced americano '),
	(5,'field',18,1,' perfect espresso ');

/*!40000 ALTER TABLE `searchindex` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sections
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sections`;

CREATE TABLE `sections` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `type` enum('single','channel','structure') NOT NULL DEFAULT 'channel',
  `enableVersioning` tinyint(1) NOT NULL DEFAULT 0,
  `propagationMethod` varchar(255) NOT NULL DEFAULT 'all',
  `previewTargets` text DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `sections_handle_idx` (`handle`),
  KEY `sections_name_idx` (`name`),
  KEY `sections_structureId_idx` (`structureId`),
  KEY `sections_dateDeleted_idx` (`dateDeleted`),
  CONSTRAINT `sections_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `structures` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `sections` WRITE;
/*!40000 ALTER TABLE `sections` DISABLE KEYS */;

INSERT INTO `sections` (`id`, `structureId`, `name`, `handle`, `type`, `enableVersioning`, `propagationMethod`, `previewTargets`, `dateCreated`, `dateUpdated`, `dateDeleted`, `uid`)
VALUES
	(1,NULL,'Drinks','drinks','channel',1,'all','[{\"label\":\"Primary entry page\",\"refresh\":\"1\",\"urlFormat\":\"{url}\"}]','2020-02-01 20:51:13','2020-02-01 20:51:13',NULL,'13a49d3a-74d9-445a-9814-75a615b1b2b2'),
	(2,NULL,'News','news','channel',1,'all','[{\"label\":\"Primary entry page\",\"refresh\":\"1\",\"urlFormat\":\"{url}\"}]','2020-02-01 21:02:30','2020-02-01 21:02:30',NULL,'e6acd7d8-4560-486d-a427-0d4692807508'),
	(3,NULL,'Homepage','homepage','single',1,'all','[{\"label\":\"Primary entry page\",\"refresh\":\"1\",\"urlFormat\":\"{url}\"}]','2020-02-09 17:31:34','2020-02-09 17:31:34',NULL,'354b2ad6-6ee8-4ad8-a988-713dc66ba2aa'),
	(4,1,'About Crafty Coffee','aboutCraftyCoffee','structure',1,'all','[{\"label\":\"Primary entry page\",\"refresh\":\"1\",\"urlFormat\":\"{url}\"}]','2020-02-09 19:19:20','2020-02-09 19:19:20',NULL,'da63c6af-f55a-4348-95a8-fd5d294a0125'),
	(5,NULL,'Recipes','recipes','channel',1,'all','[{\"label\":\"Primary entry page\",\"refresh\":\"1\",\"urlFormat\":\"{url}\"}]','2020-02-15 21:06:04','2020-02-15 21:06:04',NULL,'c828d52a-d271-4b70-89a7-f6865c41ae33');

/*!40000 ALTER TABLE `sections` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sections_sites
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sections_sites`;

CREATE TABLE `sections_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sectionId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT 1,
  `uriFormat` text DEFAULT NULL,
  `template` varchar(500) DEFAULT NULL,
  `enabledByDefault` tinyint(1) NOT NULL DEFAULT 1,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `sections_sites_sectionId_siteId_unq_idx` (`sectionId`,`siteId`),
  KEY `sections_sites_siteId_idx` (`siteId`),
  CONSTRAINT `sections_sites_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sections_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `sections_sites` WRITE;
/*!40000 ALTER TABLE `sections_sites` DISABLE KEYS */;

INSERT INTO `sections_sites` (`id`, `sectionId`, `siteId`, `hasUrls`, `uriFormat`, `template`, `enabledByDefault`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,1,1,1,'drinks/{slug}','drinks/_entry',1,'2020-02-01 20:51:13','2020-02-01 20:51:13','efd9e578-5fb8-4b1c-8b3d-ba07d214b1f5'),
	(2,2,1,1,'news/{slug}','news/_entry',1,'2020-02-01 21:02:30','2020-02-01 21:02:30','0c27cadc-0582-4766-ba1e-6e97a35ea9bb'),
	(3,3,1,1,'__home__','index',1,'2020-02-09 17:31:34','2020-02-09 17:31:34','5ce9c16e-b484-4b11-8f69-1af9057aa268'),
	(4,4,1,1,'{parent.uri}/{slug}','about/_entry',1,'2020-02-09 19:19:20','2020-02-09 19:30:05','cba9a953-6534-4143-8422-8fd4b6fabd7b'),
	(5,5,1,1,'recipes/{slug}','recipes/_entry',1,'2020-02-15 21:06:04','2020-02-15 21:06:04','5a593b86-5cf6-4257-832d-cab098cac3e8');

/*!40000 ALTER TABLE `sections_sites` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table seomatic_metabundles
# ------------------------------------------------------------

DROP TABLE IF EXISTS `seomatic_metabundles`;

CREATE TABLE `seomatic_metabundles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `bundleVersion` varchar(255) NOT NULL DEFAULT '',
  `sourceBundleType` varchar(255) NOT NULL DEFAULT '',
  `sourceId` int(11) DEFAULT NULL,
  `sourceName` varchar(255) NOT NULL DEFAULT '',
  `sourceHandle` varchar(255) NOT NULL DEFAULT '',
  `sourceType` varchar(64) NOT NULL DEFAULT '',
  `sourceTemplate` varchar(500) DEFAULT '',
  `sourceSiteId` int(11) DEFAULT NULL,
  `sourceAltSiteSettings` text DEFAULT NULL,
  `sourceDateUpdated` datetime NOT NULL,
  `metaGlobalVars` text DEFAULT NULL,
  `metaSiteVars` text DEFAULT NULL,
  `metaSitemapVars` text DEFAULT NULL,
  `metaContainers` text DEFAULT NULL,
  `redirectsContainer` text DEFAULT NULL,
  `frontendTemplatesContainer` text DEFAULT NULL,
  `metaBundleSettings` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `seomatic_metabundles_sourceBundleType_idx` (`sourceBundleType`),
  KEY `seomatic_metabundles_sourceId_idx` (`sourceId`),
  KEY `seomatic_metabundles_sourceSiteId_idx` (`sourceSiteId`),
  KEY `seomatic_metabundles_sourceHandle_idx` (`sourceHandle`),
  CONSTRAINT `seomatic_metabundles_sourceSiteId_fk` FOREIGN KEY (`sourceSiteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `seomatic_metabundles` WRITE;
/*!40000 ALTER TABLE `seomatic_metabundles` DISABLE KEYS */;

INSERT INTO `seomatic_metabundles` (`id`, `dateCreated`, `dateUpdated`, `uid`, `bundleVersion`, `sourceBundleType`, `sourceId`, `sourceName`, `sourceHandle`, `sourceType`, `sourceTemplate`, `sourceSiteId`, `sourceAltSiteSettings`, `sourceDateUpdated`, `metaGlobalVars`, `metaSiteVars`, `metaSitemapVars`, `metaContainers`, `redirectsContainer`, `frontendTemplatesContainer`, `metaBundleSettings`)
VALUES
	(1,'2020-02-01 18:34:44','2020-02-01 18:34:44','ebdee5bc-ad78-44ad-8466-3dd2850633a9','1.0.46','__GLOBAL_BUNDLE__',1,'__GLOBAL_BUNDLE__','__GLOBAL_BUNDLE__','__GLOBAL_BUNDLE__','',1,'[]','2020-02-01 18:34:44','{\"language\":null,\"mainEntityOfPage\":\"WebSite\",\"seoTitle\":\"\",\"siteNamePosition\":\"before\",\"seoDescription\":\"\",\"seoKeywords\":\"\",\"seoImage\":\"\",\"seoImageWidth\":\"\",\"seoImageHeight\":\"\",\"seoImageDescription\":\"\",\"canonicalUrl\":\"{seomatic.helper.safeCanonicalUrl()}\",\"robots\":\"all\",\"ogType\":\"website\",\"ogTitle\":\"{seomatic.meta.seoTitle}\",\"ogSiteNamePosition\":\"none\",\"ogDescription\":\"{seomatic.meta.seoDescription}\",\"ogImage\":\"{seomatic.meta.seoImage}\",\"ogImageWidth\":\"{seomatic.meta.seoImageWidth}\",\"ogImageHeight\":\"{seomatic.meta.seoImageHeight}\",\"ogImageDescription\":\"{seomatic.meta.seoImageDescription}\",\"twitterCard\":\"summary\",\"twitterCreator\":\"{seomatic.site.twitterHandle}\",\"twitterTitle\":\"{seomatic.meta.seoTitle}\",\"twitterSiteNamePosition\":\"none\",\"twitterDescription\":\"{seomatic.meta.seoDescription}\",\"twitterImage\":\"{seomatic.meta.seoImage}\",\"twitterImageWidth\":\"{seomatic.meta.seoImageWidth}\",\"twitterImageHeight\":\"{seomatic.meta.seoImageHeight}\",\"twitterImageDescription\":\"{seomatic.meta.seoImageDescription}\"}','{\"siteName\":\"Crafty Coffee\",\"identity\":{\"siteType\":\"Organization\",\"siteSubType\":\"LocalBusiness\",\"siteSpecificType\":\"\",\"computedType\":\"Organization\",\"genericName\":\"\",\"genericAlternateName\":\"\",\"genericDescription\":\"\",\"genericUrl\":\"\",\"genericImage\":\"\",\"genericImageWidth\":\"\",\"genericImageHeight\":\"\",\"genericImageIds\":[],\"genericTelephone\":\"\",\"genericEmail\":\"\",\"genericStreetAddress\":\"\",\"genericAddressLocality\":\"\",\"genericAddressRegion\":\"\",\"genericPostalCode\":\"\",\"genericAddressCountry\":\"\",\"genericGeoLatitude\":\"\",\"genericGeoLongitude\":\"\",\"personGender\":\"\",\"personBirthPlace\":\"\",\"organizationDuns\":\"\",\"organizationFounder\":\"\",\"organizationFoundingDate\":\"\",\"organizationFoundingLocation\":\"\",\"organizationContactPoints\":[],\"corporationTickerSymbol\":\"\",\"localBusinessPriceRange\":\"\",\"localBusinessOpeningHours\":[],\"restaurantServesCuisine\":\"\",\"restaurantMenuUrl\":\"\",\"restaurantReservationsUrl\":\"\"},\"creator\":{\"siteType\":\"Organization\",\"siteSubType\":\"LocalBusiness\",\"siteSpecificType\":\"\",\"computedType\":\"Organization\",\"genericName\":\"\",\"genericAlternateName\":\"\",\"genericDescription\":\"\",\"genericUrl\":\"\",\"genericImage\":\"\",\"genericImageWidth\":\"\",\"genericImageHeight\":\"\",\"genericImageIds\":[],\"genericTelephone\":\"\",\"genericEmail\":\"\",\"genericStreetAddress\":\"\",\"genericAddressLocality\":\"\",\"genericAddressRegion\":\"\",\"genericPostalCode\":\"\",\"genericAddressCountry\":\"\",\"genericGeoLatitude\":\"\",\"genericGeoLongitude\":\"\",\"personGender\":\"\",\"personBirthPlace\":\"\",\"organizationDuns\":\"\",\"organizationFounder\":\"\",\"organizationFoundingDate\":\"\",\"organizationFoundingLocation\":\"\",\"organizationContactPoints\":[],\"corporationTickerSymbol\":\"\",\"localBusinessPriceRange\":\"\",\"localBusinessOpeningHours\":[],\"restaurantServesCuisine\":\"\",\"restaurantMenuUrl\":\"\",\"restaurantReservationsUrl\":\"\"},\"twitterHandle\":\"\",\"facebookProfileId\":\"\",\"facebookAppId\":\"\",\"googleSiteVerification\":\"\",\"bingSiteVerification\":\"\",\"pinterestSiteVerification\":\"\",\"sameAsLinks\":{\"twitter\":{\"siteName\":\"Twitter\",\"handle\":\"twitter\",\"url\":\"\"},\"facebook\":{\"siteName\":\"Facebook\",\"handle\":\"facebook\",\"url\":\"\"},\"wikipedia\":{\"siteName\":\"Wikipedia\",\"handle\":\"wikipedia\",\"url\":\"\"},\"linkedin\":{\"siteName\":\"LinkedIn\",\"handle\":\"linkedin\",\"url\":\"\"},\"googleplus\":{\"siteName\":\"Google+\",\"handle\":\"googleplus\",\"url\":\"\"},\"youtube\":{\"siteName\":\"YouTube\",\"handle\":\"youtube\",\"url\":\"\"},\"instagram\":{\"siteName\":\"Instagram\",\"handle\":\"instagram\",\"url\":\"\"},\"pinterest\":{\"siteName\":\"Pinterest\",\"handle\":\"pinterest\",\"url\":\"\"},\"github\":{\"siteName\":\"GitHub\",\"handle\":\"github\",\"url\":\"\"},\"vimeo\":{\"siteName\":\"Vimeo\",\"handle\":\"vimeo\",\"url\":\"\"}},\"siteLinksSearchTarget\":\"\",\"siteLinksQueryInput\":\"\",\"additionalSitemapUrls\":[],\"additionalSitemapUrlsDateUpdated\":null,\"additionalSitemaps\":[]}','{\"sitemapUrls\":true,\"sitemapAssets\":true,\"sitemapFiles\":true,\"sitemapAltLinks\":true,\"sitemapChangeFreq\":\"weekly\",\"sitemapPriority\":0.5,\"sitemapLimit\":null,\"structureDepth\":null,\"sitemapImageFieldMap\":[{\"property\":\"title\",\"field\":\"title\"},{\"property\":\"caption\",\"field\":\"\"},{\"property\":\"geo_location\",\"field\":\"\"},{\"property\":\"license\",\"field\":\"\"}],\"sitemapVideoFieldMap\":[{\"property\":\"title\",\"field\":\"title\"},{\"property\":\"description\",\"field\":\"\"},{\"property\":\"thumbnailLoc\",\"field\":\"\"},{\"property\":\"duration\",\"field\":\"\"},{\"property\":\"category\",\"field\":\"\"}]}','{\"MetaTagContainergeneral\":{\"data\":{\"generator\":{\"charset\":\"\",\"content\":\"SEOmatic\",\"httpEquiv\":\"\",\"name\":\"generator\",\"property\":null,\"include\":true,\"key\":\"generator\",\"environment\":null,\"dependencies\":{\"config\":[\"generatorEnabled\"]}},\"keywords\":{\"charset\":\"\",\"content\":\"{seomatic.meta.seoKeywords}\",\"httpEquiv\":\"\",\"name\":\"keywords\",\"property\":null,\"include\":true,\"key\":\"keywords\",\"environment\":null,\"dependencies\":null},\"description\":{\"charset\":\"\",\"content\":\"{seomatic.meta.seoDescription}\",\"httpEquiv\":\"\",\"name\":\"description\",\"property\":null,\"include\":true,\"key\":\"description\",\"environment\":null,\"dependencies\":null},\"referrer\":{\"charset\":\"\",\"content\":\"no-referrer-when-downgrade\",\"httpEquiv\":\"\",\"name\":\"referrer\",\"property\":null,\"include\":true,\"key\":\"referrer\",\"environment\":null,\"dependencies\":null},\"robots\":{\"charset\":\"\",\"content\":\"none\",\"httpEquiv\":\"\",\"name\":\"robots\",\"property\":null,\"include\":true,\"key\":\"robots\",\"environment\":{\"live\":{\"content\":\"{seomatic.meta.robots}\"},\"staging\":{\"content\":\"none\"},\"local\":{\"content\":\"none\"}},\"dependencies\":null}},\"name\":\"General\",\"description\":\"General Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContaineropengraph\":{\"data\":{\"fb:profile_id\":{\"charset\":\"\",\"content\":\"{seomatic.site.facebookProfileId}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"fb:profile_id\",\"include\":true,\"key\":\"fb:profile_id\",\"environment\":null,\"dependencies\":null},\"fb:app_id\":{\"charset\":\"\",\"content\":\"{seomatic.site.facebookAppId}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"fb:app_id\",\"include\":true,\"key\":\"fb:app_id\",\"environment\":null,\"dependencies\":null},\"og:locale\":{\"charset\":\"\",\"content\":\"{{ craft.app.language |replace({\\\"-\\\": \\\"_\\\"}) }}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:locale\",\"include\":true,\"key\":\"og:locale\",\"environment\":null,\"dependencies\":null},\"og:locale:alternate\":{\"charset\":\"\",\"content\":\"\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:locale:alternate\",\"include\":true,\"key\":\"og:locale:alternate\",\"environment\":null,\"dependencies\":null},\"og:site_name\":{\"charset\":\"\",\"content\":\"{seomatic.site.siteName}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:site_name\",\"include\":true,\"key\":\"og:site_name\",\"environment\":null,\"dependencies\":null},\"og:type\":{\"charset\":\"\",\"content\":\"{seomatic.meta.ogType}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:type\",\"include\":true,\"key\":\"og:type\",\"environment\":null,\"dependencies\":null},\"og:url\":{\"charset\":\"\",\"content\":\"{seomatic.meta.canonicalUrl}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:url\",\"include\":true,\"key\":\"og:url\",\"environment\":null,\"dependencies\":null},\"og:title\":{\"siteName\":\"{seomatic.site.siteName}\",\"siteNamePosition\":\"{seomatic.meta.ogSiteNamePosition}\",\"separatorChar\":\"{seomatic.config.separatorChar}\",\"charset\":\"\",\"content\":\"{seomatic.meta.ogTitle}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:title\",\"include\":true,\"key\":\"og:title\",\"environment\":null,\"dependencies\":null},\"og:description\":{\"charset\":\"\",\"content\":\"{seomatic.meta.ogDescription}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:description\",\"include\":true,\"key\":\"og:description\",\"environment\":null,\"dependencies\":null},\"og:image\":{\"charset\":\"\",\"content\":\"{seomatic.meta.ogImage}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:image\",\"include\":true,\"key\":\"og:image\",\"environment\":null,\"dependencies\":null},\"og:image:width\":{\"charset\":\"\",\"content\":\"{seomatic.meta.ogImageWidth}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:image:width\",\"include\":true,\"key\":\"og:image:width\",\"environment\":null,\"dependencies\":{\"tag\":[\"og:image\"]}},\"og:image:height\":{\"charset\":\"\",\"content\":\"{seomatic.meta.ogImageHeight}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:image:height\",\"include\":true,\"key\":\"og:image:height\",\"environment\":null,\"dependencies\":{\"tag\":[\"og:image\"]}},\"og:image:alt\":{\"charset\":\"\",\"content\":\"{seomatic.meta.ogImageDescription}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:image:alt\",\"include\":true,\"key\":\"og:image:alt\",\"environment\":null,\"dependencies\":{\"tag\":[\"og:image\"]}},\"og:see_also\":{\"charset\":\"\",\"content\":\"\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:see_also\",\"include\":true,\"key\":\"og:see_also\",\"environment\":null,\"dependencies\":null}},\"name\":\"Facebook\",\"description\":\"Facebook OpenGraph Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"opengraph\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContainertwitter\":{\"data\":{\"twitter:card\":{\"charset\":\"\",\"content\":\"{seomatic.meta.twitterCard}\",\"httpEquiv\":\"\",\"name\":\"twitter:card\",\"property\":null,\"include\":true,\"key\":\"twitter:card\",\"environment\":null,\"dependencies\":null},\"twitter:site\":{\"charset\":\"\",\"content\":\"@{seomatic.site.twitterHandle}\",\"httpEquiv\":\"\",\"name\":\"twitter:site\",\"property\":null,\"include\":true,\"key\":\"twitter:site\",\"environment\":null,\"dependencies\":{\"site\":[\"twitterHandle\"]}},\"twitter:creator\":{\"charset\":\"\",\"content\":\"@{seomatic.meta.twitterCreator}\",\"httpEquiv\":\"\",\"name\":\"twitter:creator\",\"property\":null,\"include\":true,\"key\":\"twitter:creator\",\"environment\":null,\"dependencies\":{\"meta\":[\"twitterCreator\"]}},\"twitter:title\":{\"siteName\":\"{seomatic.site.siteName}\",\"siteNamePosition\":\"{seomatic.meta.twitterSiteNamePosition}\",\"separatorChar\":\"{seomatic.config.separatorChar}\",\"charset\":\"\",\"content\":\"{seomatic.meta.twitterTitle}\",\"httpEquiv\":\"\",\"name\":\"twitter:title\",\"property\":null,\"include\":true,\"key\":\"twitter:title\",\"environment\":null,\"dependencies\":null},\"twitter:description\":{\"charset\":\"\",\"content\":\"{seomatic.meta.twitterDescription}\",\"httpEquiv\":\"\",\"name\":\"twitter:description\",\"property\":null,\"include\":true,\"key\":\"twitter:description\",\"environment\":null,\"dependencies\":null},\"twitter:image\":{\"charset\":\"\",\"content\":\"{seomatic.meta.twitterImage}\",\"httpEquiv\":\"\",\"name\":\"twitter:image\",\"property\":null,\"include\":true,\"key\":\"twitter:image\",\"environment\":null,\"dependencies\":null},\"twitter:image:width\":{\"charset\":\"\",\"content\":\"{seomatic.meta.twitterImageWidth}\",\"httpEquiv\":\"\",\"name\":\"twitter:image:width\",\"property\":null,\"include\":true,\"key\":\"twitter:image:width\",\"environment\":null,\"dependencies\":{\"tag\":[\"twitter:image\"]}},\"twitter:image:height\":{\"charset\":\"\",\"content\":\"{seomatic.meta.twitterImageHeight}\",\"httpEquiv\":\"\",\"name\":\"twitter:image:height\",\"property\":null,\"include\":true,\"key\":\"twitter:image:height\",\"environment\":null,\"dependencies\":{\"tag\":[\"twitter:image\"]}},\"twitter:image:alt\":{\"charset\":\"\",\"content\":\"{seomatic.meta.twitterImageDescription}\",\"httpEquiv\":\"\",\"name\":\"twitter:image:alt\",\"property\":null,\"include\":true,\"key\":\"twitter:image:alt\",\"environment\":null,\"dependencies\":{\"tag\":[\"twitter:image\"]}}},\"name\":\"Twitter\",\"description\":\"Twitter Card Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"twitter\",\"include\":true,\"dependencies\":{\"site\":[\"twitterHandle\"]},\"clearCache\":false},\"MetaTagContainermiscellaneous\":{\"data\":{\"google-site-verification\":{\"charset\":\"\",\"content\":\"{seomatic.site.googleSiteVerification}\",\"httpEquiv\":\"\",\"name\":\"google-site-verification\",\"property\":null,\"include\":true,\"key\":\"google-site-verification\",\"environment\":null,\"dependencies\":{\"site\":[\"googleSiteVerification\"]}},\"bing-site-verification\":{\"charset\":\"\",\"content\":\"{seomatic.site.bingSiteVerification}\",\"httpEquiv\":\"\",\"name\":\"msvalidate.01\",\"property\":null,\"include\":true,\"key\":\"bing-site-verification\",\"environment\":null,\"dependencies\":{\"site\":[\"bingSiteVerification\"]}},\"pinterest-site-verification\":{\"charset\":\"\",\"content\":\"{seomatic.site.pinterestSiteVerification}\",\"httpEquiv\":\"\",\"name\":\"p:domain_verify\",\"property\":null,\"include\":true,\"key\":\"pinterest-site-verification\",\"environment\":null,\"dependencies\":{\"site\":[\"pinterestSiteVerification\"]}}},\"name\":\"Miscellaneous\",\"description\":\"Miscellaneous Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"miscellaneous\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaLinkContainergeneral\":{\"data\":{\"canonical\":{\"crossorigin\":\"\",\"href\":\"{seomatic.meta.canonicalUrl}\",\"hreflang\":\"\",\"media\":\"\",\"rel\":\"canonical\",\"sizes\":\"\",\"type\":\"\",\"include\":true,\"key\":\"canonical\",\"environment\":null,\"dependencies\":null},\"home\":{\"crossorigin\":\"\",\"href\":\"{{ siteUrl }}\",\"hreflang\":\"\",\"media\":\"\",\"rel\":\"home\",\"sizes\":\"\",\"type\":\"\",\"include\":true,\"key\":\"home\",\"environment\":null,\"dependencies\":null},\"author\":{\"crossorigin\":\"\",\"href\":\"{{ seomatic.helper.siteUrl(\\\"/humans.txt\\\") }}\",\"hreflang\":\"\",\"media\":\"\",\"rel\":\"author\",\"sizes\":\"\",\"type\":\"text/plain\",\"include\":true,\"key\":\"author\",\"environment\":null,\"dependencies\":{\"frontend_template\":[\"humans\"]}},\"publisher\":{\"crossorigin\":\"\",\"href\":\"{seomatic.site.googlePublisherLink}\",\"hreflang\":\"\",\"media\":\"\",\"rel\":\"publisher\",\"sizes\":\"\",\"type\":\"\",\"include\":true,\"key\":\"publisher\",\"environment\":null,\"dependencies\":{\"site\":[\"googlePublisherLink\"]}}},\"name\":\"General\",\"description\":\"Link Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaLinkContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaScriptContainergeneral\":{\"data\":{\"googleAnalytics\":{\"name\":\"Google Analytics\",\"description\":\"Google Analytics gives you the digital analytics tools you need to analyze data from all touchpoints in one place, for a deeper understanding of the customer experience. You can then share the insights that matter with your whole organization. [Learn More](https://www.google.com/analytics/analytics/)\",\"templatePath\":\"_frontend/scripts/googleAnalytics.twig\",\"templateString\":\"{% if trackingId.value is defined and trackingId.value %}\\n(function(i,s,o,g,r,a,m){i[\'GoogleAnalyticsObject\']=r;i[r]=i[r]||function(){\\n(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),\\nm=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)\\n})(window,document,\'script\',\'{{ analyticsUrl.value }}\',\'ga\');\\nga(\'create\', \'{{ trackingId.value |raw }}\', \'auto\'{% if linker.value %}, {allowLinker: true}{% endif %});\\n{% if ipAnonymization.value %}\\nga(\'set\', \'anonymizeIp\', true);\\n{% endif %}\\n{% if displayFeatures.value %}\\nga(\'require\', \'displayfeatures\');\\n{% endif %}\\n{% if ecommerce.value %}\\nga(\'require\', \'ecommerce\');\\n{% endif %}\\n{% if enhancedEcommerce.value %}\\nga(\'require\', \'ec\');\\n{% endif %}\\n{% if enhancedLinkAttribution.value %}\\nga(\'require\', \'linkid\');\\n{% endif %}\\n{% if enhancedLinkAttribution.value %}\\nga(\'require\', \'linker\');\\n{% endif %}\\n{% set pageView = (sendPageView.value and not craft.app.request.isLivePreview) %}\\n{% if pageView %}\\nga(\'send\', \'pageview\');\\n{% endif %}\\n{% endif %}\\n\",\"position\":1,\"bodyTemplatePath\":null,\"bodyTemplateString\":null,\"bodyPosition\":2,\"vars\":{\"trackingId\":{\"title\":\"Google Analytics Tracking ID\",\"instructions\":\"Only enter the ID, e.g.: `UA-XXXXXX-XX`, not the entire script code. [Learn More](https://support.google.com/analytics/answer/1032385?hl=e)\",\"type\":\"string\",\"value\":\"\"},\"sendPageView\":{\"title\":\"Automatically send Google Analytics PageView\",\"instructions\":\"Controls whether the Google Analytics script automatically sends a PageView to Google Analytics when your pages are loaded.\",\"type\":\"bool\",\"value\":true},\"ipAnonymization\":{\"title\":\"Google Analytics IP Anonymization\",\"instructions\":\"When a customer of Analytics requests IP address anonymization, Analytics anonymizes the address as soon as technically feasible at the earliest possible stage of the collection network.\",\"type\":\"bool\",\"value\":false},\"displayFeatures\":{\"title\":\"Display Features\",\"instructions\":\"The display features plugin for analytics.js can be used to enable Advertising Features in Google Analytics, such as Remarketing, Demographics and Interest Reporting, and more. [Learn More](https://developers.google.com/analytics/devguides/collection/analyticsjs/display-features)\",\"type\":\"bool\",\"value\":false},\"ecommerce\":{\"title\":\"Ecommerce\",\"instructions\":\"Ecommerce tracking allows you to measure the number of transactions and revenue that your website generates. [Learn More](https://developers.google.com/analytics/devguides/collection/analyticsjs/ecommerce)\",\"type\":\"bool\",\"value\":false},\"enhancedEcommerce\":{\"title\":\"Enhanced Ecommerce\",\"instructions\":\"The enhanced ecommerce plug-in for analytics.js enables the measurement of user interactions with products on ecommerce websites across the user\'s shopping experience, including: product impressions, product clicks, viewing product details, adding a product to a shopping cart, initiating the checkout process, transactions, and refunds. [Learn More](https://developers.google.com/analytics/devguides/collection/analyticsjs/enhanced-ecommerce)\",\"type\":\"bool\",\"value\":false},\"enhancedLinkAttribution\":{\"title\":\"Enhanced Link Attribution\",\"instructions\":\"Enhanced Link Attribution improves the accuracy of your In-Page Analytics report by automatically differentiating between multiple links to the same URL on a single page by using link element IDs. [Learn More](https://developers.google.com/analytics/devguides/collection/analyticsjs/enhanced-link-attribution)\",\"type\":\"bool\",\"value\":false},\"linker\":{\"title\":\"Linker\",\"instructions\":\"The linker plugin simplifies the process of implementing cross-domain tracking as described in the Cross-domain Tracking guide for analytics.js. [Learn More](https://developers.google.com/analytics/devguides/collection/analyticsjs/linker)\",\"type\":\"bool\",\"value\":false},\"analyticsUrl\":{\"title\":\"Google Analytics Script URL\",\"instructions\":\"The URL to the Google Analytics tracking script. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://www.google-analytics.com/analytics.js\"}},\"dataLayer\":[],\"include\":false,\"key\":\"googleAnalytics\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null},\"gtag\":{\"name\":\"Google gtag.js\",\"description\":\"The global site tag (gtag.js) is a JavaScript tagging framework and API that allows you to send event data to AdWords, DoubleClick, and Google Analytics. Instead of having to manage multiple tags for different products, you can use gtag.js and more easily benefit from the latest tracking features and integrations as they become available. [Learn More](https://developers.google.com/gtagjs/)\",\"templatePath\":\"_frontend/scripts/gtagHead.twig\",\"templateString\":\"{% set gtagProperty = googleAnalyticsId.value ?? googleAdWordsId.value ?? dcFloodlightId.value ?? null %}\\n{% if gtagProperty %}\\nwindow.dataLayer = window.dataLayer || [{% if dataLayer is defined and dataLayer %}{{ dataLayer |json_encode() |raw }}{% endif %}];\\nfunction gtag(){dataLayer.push(arguments)};\\ngtag(\'js\', new Date());\\n{% set pageView = (sendPageView.value and not craft.app.request.isLivePreview) %}\\n{% if googleAnalyticsId.value %}\\n{%- set gtagConfig = \\\"{\\\"\\n    ~ \\\"\'send_page_view\': #{pageView ? \'true\' : \'false\'},\\\"\\n    ~ \\\"\'anonymize_ip\': #{ipAnonymization.value ? \'true\' : \'false\'},\\\"\\n    ~ \\\"\'link_attribution\': #{enhancedLinkAttribution.value ? \'true\' : \'false\'},\\\"\\n    ~ \\\"\'allow_display_features\': #{displayFeatures.value ? \'true\' : \'false\'}\\\"\\n    ~ \\\"}\\\"\\n-%}\\ngtag(\'config\', \'{{ googleAnalyticsId.value }}\', {{ gtagConfig }});\\n{% endif %}\\n{% if googleAdWordsId.value %}\\n{%- set gtagConfig = \\\"{\\\"\\n    ~ \\\"\'send_page_view\': #{pageView ? \'true\' : \'false\'}\\\"\\n    ~ \\\"}\\\"\\n-%}\\ngtag(\'config\', \'{{ googleAdWordsId.value }}\', {{ gtagConfig }});\\n{% endif %}\\n{% if dcFloodlightId.value %}\\n{%- set gtagConfig = \\\"{\\\"\\n    ~ \\\"\'send_page_view\': #{pageView ? \'true\' : \'false\'}\\\"\\n    ~ \\\"}\\\"\\n-%}\\ngtag(\'config\', \'{{ dcFloodlightId.value }}\', {{ gtagConfig }});\\n{% endif %}\\n{% endif %}\\n\",\"position\":1,\"bodyTemplatePath\":\"_frontend/scripts/gtagBody.twig\",\"bodyTemplateString\":\"{% set gtagProperty = googleAnalyticsId.value ?? googleAdWordsId.value ?? dcFloodlightId.value ?? null %}\\n{% if gtagProperty %}\\n<script async src=\\\"{{ gtagScriptUrl.value }}?id={{ gtagProperty }}\\\"></script>\\n{% endif %}\\n\",\"bodyPosition\":2,\"vars\":{\"googleAnalyticsId\":{\"title\":\"Google Analytics Tracking ID\",\"instructions\":\"Only enter the ID, e.g.: `UA-XXXXXX-XX`, not the entire script code. [Learn More](https://support.google.com/analytics/answer/1032385?hl=e)\",\"type\":\"string\",\"value\":\"\"},\"googleAdWordsId\":{\"title\":\"AdWords Conversion ID\",\"instructions\":\"Only enter the ID, e.g.: `AW-XXXXXXXX`, not the entire script code. [Learn More](https://developers.google.com/adwords-remarketing-tag/)\",\"type\":\"string\",\"value\":\"\"},\"dcFloodlightId\":{\"title\":\"DoubleClick Floodlight ID\",\"instructions\":\"Only enter the ID, e.g.: `DC-XXXXXXXX`, not the entire script code. [Learn More](https://support.google.com/dcm/partner/answer/7568534)\",\"type\":\"string\",\"value\":\"\"},\"sendPageView\":{\"title\":\"Automatically send PageView\",\"instructions\":\"Controls whether the `gtag.js` script automatically sends a PageView to Google Analytics, AdWords, and DoubleClick Floodlight when your pages are loaded.\",\"type\":\"bool\",\"value\":true},\"ipAnonymization\":{\"title\":\"Google Analytics IP Anonymization\",\"instructions\":\"In some cases, you might need to anonymize the IP addresses of hits sent to Google Analytics. [Learn More](https://developers.google.com/analytics/devguides/collection/gtagjs/ip-anonymization)\",\"type\":\"bool\",\"value\":false},\"displayFeatures\":{\"title\":\"Google Analytics Display Features\",\"instructions\":\"The display features plugin for gtag.js can be used to enable Advertising Features in Google Analytics, such as Remarketing, Demographics and Interest Reporting, and more. [Learn More](https://developers.google.com/analytics/devguides/collection/gtagjs/display-features)\",\"type\":\"bool\",\"value\":false},\"enhancedLinkAttribution\":{\"title\":\"Google Analytics Enhanced Link Attribution\",\"instructions\":\"Enhanced link attribution improves click track reporting by automatically differentiating between multiple link clicks that have the same URL on a given page. [Learn More](https://developers.google.com/analytics/devguides/collection/gtagjs/enhanced-link-attribution)\",\"type\":\"bool\",\"value\":false},\"gtagScriptUrl\":{\"title\":\"Google gtag.js Script URL\",\"instructions\":\"The URL to the Google gtag.js tracking script. Normally this should not be changed, unless you locally cache it. The JavaScript `dataLayer` will automatically be set to the `dataLayer` Twig template variable.\",\"type\":\"string\",\"value\":\"https://www.googletagmanager.com/gtag/js\"}},\"dataLayer\":[],\"include\":false,\"key\":\"gtag\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null},\"googleTagManager\":{\"name\":\"Google Tag Manager\",\"description\":\"Google Tag Manager is a tag management system that allows you to quickly and easily update tags and code snippets on your website. Once the Tag Manager snippet has been added to your website or mobile app, you can configure tags via a web-based user interface without having to alter and deploy additional code. [Learn More](https://support.google.com/tagmanager/answer/6102821?hl=en)\",\"templatePath\":\"_frontend/scripts/googleTagManagerHead.twig\",\"templateString\":\"{% if googleTagManagerId.value is defined and googleTagManagerId.value and not craft.app.request.isLivePreview %}\\n{{ dataLayerVariableName.value }} = [{% if dataLayer is defined and dataLayer %}{{ dataLayer |json_encode() |raw }}{% endif %}];\\n(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({\'gtm.start\':\\nnew Date().getTime(),event:\'gtm.js\'});var f=d.getElementsByTagName(s)[0],\\nj=d.createElement(s),dl=l!=\'dataLayer\'?\'&l=\'+l:\'\';j.async=true;j.src=\\n\'{{ googleTagManagerUrl.value }}?id=\'+i+dl;f.parentNode.insertBefore(j,f);\\n})(window,document,\'script\',\'{{ dataLayerVariableName.value }}\',\'{{ googleTagManagerId.value }}\');\\n{% endif %}\\n\",\"position\":1,\"bodyTemplatePath\":\"_frontend/scripts/googleTagManagerBody.twig\",\"bodyTemplateString\":\"{% if googleTagManagerId.value is defined and googleTagManagerId.value and not craft.app.request.isLivePreview %}\\n<noscript><iframe src=\\\"{{ googleTagManagerNoScriptUrl.value }}?id={{ googleTagManagerId.value }}\\\"\\nheight=\\\"0\\\" width=\\\"0\\\" style=\\\"display:none;visibility:hidden\\\"></iframe></noscript>\\n{% endif %}\\n\",\"bodyPosition\":2,\"vars\":{\"googleTagManagerId\":{\"title\":\"Google Tag Manager ID\",\"instructions\":\"Only enter the ID, e.g.: `GTM-XXXXXX`, not the entire script code. [Learn More](https://developers.google.com/tag-manager/quickstart)\",\"type\":\"string\",\"value\":\"\"},\"dataLayerVariableName\":{\"title\":\"DataLayer Variable Name\",\"instructions\":\"The name to use for the JavaScript DataLayer variable. The value of this variable will be set to the `dataLayer` Twig template variable.\",\"type\":\"string\",\"value\":\"dataLayer\"},\"googleTagManagerUrl\":{\"title\":\"Google Tag Manager Script URL\",\"instructions\":\"The URL to the Google Tag Manager script. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://www.googletagmanager.com/gtm.js\"},\"googleTagManagerNoScriptUrl\":{\"title\":\"Google Tag Manager Script &lt;noscript&gt; URL\",\"instructions\":\"The URL to the Google Tag Manager `&lt;noscript&gt;`. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://www.googletagmanager.com/ns.html\"}},\"dataLayer\":[],\"include\":false,\"key\":\"googleTagManager\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null},\"facebookPixel\":{\"name\":\"Facebook Pixel\",\"description\":\"The Facebook pixel is an analytics tool that helps you measure the effectiveness of your advertising. You can use the Facebook pixel to understand the actions people are taking on your website and reach audiences you care about. [Learn More](https://www.facebook.com/business/help/651294705016616)\",\"templatePath\":\"_frontend/scripts/facebookPixelHead.twig\",\"templateString\":\"{% if facebookPixelId.value is defined and facebookPixelId.value %}\\n!function(f,b,e,v,n,t,s){if(f.fbq)return;n=f.fbq=function(){n.callMethod?\\nn.callMethod.apply(n,arguments):n.queue.push(arguments)};if(!f._fbq)f._fbq=n;\\nn.push=n;n.loaded=!0;n.version=\'2.0\';n.queue=[];t=b.createElement(e);t.async=!0;\\nt.src=v;s=b.getElementsByTagName(e)[0];s.parentNode.insertBefore(t,s)}(window,\\ndocument,\'script\',\'{{ facebookPixelUrl.value }}\');\\nfbq(\'init\', \'{{ facebookPixelId.value }}\');\\n{% set pageView = (sendPageView.value and not craft.app.request.isLivePreview) %}\\n{% if pageView %}\\nfbq(\'track\', \'PageView\');\\n{% endif %}\\n{% endif %}\\n\",\"position\":1,\"bodyTemplatePath\":\"_frontend/scripts/facebookPixelBody.twig\",\"bodyTemplateString\":\"{% if facebookPixelId.value is defined and facebookPixelId.value %}\\n<noscript><img height=\\\"1\\\" width=\\\"1\\\" style=\\\"display:none\\\"\\nsrc=\\\"{{ facebookPixelNoScriptUrl.value }}?id={{ facebookPixelId.value }}&ev=PageView&noscript=1\\\" /></noscript>\\n{% endif %}\\n\",\"bodyPosition\":2,\"vars\":{\"facebookPixelId\":{\"title\":\"Facebook Pixel ID\",\"instructions\":\"Only enter the ID, e.g.: `XXXXXXXXXX`, not the entire script code. [Learn More](https://developers.facebook.com/docs/facebook-pixel/api-reference)\",\"type\":\"string\",\"value\":\"\"},\"sendPageView\":{\"title\":\"Automatically send Facebook Pixel PageView\",\"instructions\":\"Controls whether the Facebook Pixel script automatically sends a PageView to Facebook Analytics when your pages are loaded.\",\"type\":\"bool\",\"value\":true},\"facebookPixelUrl\":{\"title\":\"Facebook Pixel Script URL\",\"instructions\":\"The URL to the Facebook Pixel script. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://connect.facebook.net/en_US/fbevents.js\"},\"facebookPixelNoScriptUrl\":{\"title\":\"Facebook Pixel Script &lt;noscript&gt; URL\",\"instructions\":\"The URL to the Facebook Pixel `&lt;noscript&gt;`. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://www.facebook.com/tr\"}},\"dataLayer\":[],\"include\":false,\"key\":\"facebookPixel\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null},\"linkedInInsight\":{\"name\":\"LinkedIn Insight\",\"description\":\"The LinkedIn Insight Tag is a lightweight JavaScript tag that powers conversion tracking, retargeting, and web analytics for LinkedIn ad campaigns.\",\"templatePath\":\"_frontend/scripts/linkedInInsightHead.twig\",\"templateString\":\"{% if dataPartnerId.value is defined and dataPartnerId.value %}\\n_linkedin_data_partner_id = \\\"{{ dataPartnerId.value }}\\\";\\n{% endif %}\\n\",\"position\":1,\"bodyTemplatePath\":\"_frontend/scripts/linkedInInsightBody.twig\",\"bodyTemplateString\":\"{% if dataPartnerId.value is defined and dataPartnerId.value %}\\n<script type=\\\"text/javascript\\\">\\n(function(){var s = document.getElementsByTagName(\\\"script\\\")[0];\\n    var b = document.createElement(\\\"script\\\");\\n    b.type = \\\"text/javascript\\\";b.async = true;\\n    b.src = \\\"{{ linkedInInsightUrl.value }}\\\";\\n    s.parentNode.insertBefore(b, s);})();\\n</script>\\n<noscript>\\n<img height=\\\"1\\\" width=\\\"1\\\" style=\\\"display:none;\\\" alt=\\\"\\\" src=\\\"{{ linkedInInsightNoScriptUrl.value }}?pid={{ dataPartnerId.value }}&fmt=gif\\\" />\\n</noscript>\\n{% endif %}\\n\",\"bodyPosition\":3,\"vars\":{\"dataPartnerId\":{\"title\":\"LinkedIn Data Partner ID\",\"instructions\":\"Only enter the ID, e.g.: `XXXXXXXXXX`, not the entire script code. [Learn More](https://www.linkedin.com/help/lms/answer/65513/adding-the-linkedin-insight-tag-to-your-website?lang=en)\",\"type\":\"string\",\"value\":\"\"},\"linkedInInsightUrl\":{\"title\":\"LinkedIn Insight Script URL\",\"instructions\":\"The URL to the LinkedIn Insight script. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://snap.licdn.com/li.lms-analytics/insight.min.js\"},\"linkedInInsightNoScriptUrl\":{\"title\":\"LinkedIn Insight &lt;noscript&gt; URL\",\"instructions\":\"The URL to the LinkedIn Insight `&lt;noscript&gt;`. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://dc.ads.linkedin.com/collect/\"}},\"dataLayer\":[],\"include\":false,\"key\":\"linkedInInsight\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null},\"hubSpot\":{\"name\":\"HubSpot\",\"description\":\"If you\'re not hosting your entire website on HubSpot, or have pages on your website that are not hosted on HubSpot, you\'ll need to install the HubSpot tracking code on your non-HubSpot pages in order to capture those analytics.\",\"templatePath\":null,\"templateString\":null,\"position\":1,\"bodyTemplatePath\":\"_frontend/scripts/hubSpotBody.twig\",\"bodyTemplateString\":\"{% if hubSpotId.value is defined and hubSpotId.value %}\\n<script type=\\\"text/javascript\\\" id=\\\"hs-script-loader\\\" async defer src=\\\"{{ hubSpotUrl.value }}{{ hubSpotId.value }}.js\\\"></script>\\n{% endif %}\\n\",\"bodyPosition\":3,\"vars\":{\"hubSpotId\":{\"title\":\"HubSpot ID\",\"instructions\":\"Only enter the ID, e.g.: `XXXXXXXXXX`, not the entire script code. [Learn More](https://knowledge.hubspot.com/articles/kcs_article/reports/install-the-hubspot-tracking-code)\",\"type\":\"string\",\"value\":\"\"},\"hubSpotUrl\":{\"title\":\"HubSpot Script URL\",\"instructions\":\"The URL to the HubSpot script. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"//js.hs-scripts.com/\"}},\"dataLayer\":[],\"include\":false,\"key\":\"hubSpot\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null}},\"position\":1,\"name\":\"General\",\"description\":\"Script Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaScriptContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaJsonLdContainergeneral\":{\"data\":{\"mainEntityOfPage\":{\"issn\":null,\"about\":null,\"accessMode\":null,\"accessModeSufficient\":null,\"accessibilityAPI\":null,\"accessibilityControl\":null,\"accessibilityFeature\":null,\"accessibilityHazard\":null,\"accessibilitySummary\":null,\"accountablePerson\":null,\"aggregateRating\":null,\"alternativeHeadline\":null,\"associatedMedia\":null,\"audience\":null,\"audio\":null,\"author\":{\"id\":\"{seomatic.site.identity.genericUrl}#identity\"},\"award\":null,\"character\":null,\"citation\":null,\"comment\":null,\"commentCount\":null,\"contentLocation\":null,\"contentRating\":null,\"contentReferenceTime\":null,\"contributor\":null,\"copyrightHolder\":{\"id\":\"{seomatic.site.identity.genericUrl}#identity\"},\"copyrightYear\":null,\"correction\":null,\"creator\":{\"id\":\"{seomatic.site.creator.genericUrl}#creator\"},\"dateCreated\":null,\"dateModified\":null,\"datePublished\":null,\"discussionUrl\":null,\"editor\":null,\"educationalAlignment\":null,\"educationalUse\":null,\"encoding\":null,\"encodingFormat\":null,\"exampleOfWork\":null,\"expires\":null,\"funder\":null,\"genre\":null,\"hasPart\":null,\"headline\":null,\"inLanguage\":\"{seomatic.meta.language}\",\"interactionStatistic\":null,\"interactivityType\":null,\"isAccessibleForFree\":null,\"isBasedOn\":null,\"isFamilyFriendly\":null,\"isPartOf\":null,\"keywords\":null,\"learningResourceType\":null,\"license\":null,\"locationCreated\":null,\"mainEntity\":null,\"material\":null,\"materialExtent\":null,\"mentions\":null,\"offers\":null,\"position\":null,\"producer\":null,\"provider\":null,\"publication\":null,\"publisher\":null,\"publisherImprint\":null,\"publishingPrinciples\":null,\"recordedAt\":null,\"releasedEvent\":null,\"review\":null,\"schemaVersion\":null,\"sdDatePublished\":null,\"sdLicense\":null,\"sdPublisher\":null,\"sourceOrganization\":null,\"spatial\":null,\"spatialCoverage\":null,\"sponsor\":null,\"temporal\":null,\"temporalCoverage\":null,\"text\":null,\"thumbnailUrl\":null,\"timeRequired\":null,\"translationOfWork\":null,\"translator\":null,\"typicalAgeRange\":null,\"version\":null,\"video\":null,\"workExample\":null,\"workTranslation\":null,\"additionalType\":null,\"alternateName\":null,\"description\":\"{seomatic.meta.seoDescription}\",\"disambiguatingDescription\":null,\"identifier\":null,\"image\":{\"type\":\"ImageObject\",\"url\":\"{seomatic.meta.seoImage}\"},\"mainEntityOfPage\":\"{seomatic.meta.canonicalUrl}\",\"name\":\"{seomatic.meta.seoTitle}\",\"potentialAction\":{\"type\":\"SearchAction\",\"target\":\"{seomatic.site.siteLinksSearchTarget}\",\"query-input\":\"{seomatic.helper.siteLinksQueryInput()}\"},\"sameAs\":null,\"subjectOf\":null,\"url\":\"{seomatic.meta.canonicalUrl}\",\"context\":\"http://schema.org\",\"type\":\"{seomatic.meta.mainEntityOfPage}\",\"id\":null,\"graph\":null,\"include\":true,\"key\":\"mainEntityOfPage\",\"environment\":null,\"dependencies\":null},\"identity\":{\"actionableFeedbackPolicy\":null,\"address\":{\"type\":\"PostalAddress\",\"streetAddress\":\"{seomatic.site.identity.genericStreetAddress}\",\"addressLocality\":\"{seomatic.site.identity.genericAddressLocality}\",\"addressRegion\":\"{seomatic.site.identity.genericAddressRegion}\",\"postalCode\":\"{seomatic.site.identity.genericPostalCode}\",\"addressCountry\":\"{seomatic.site.identity.genericAddressCountry}\"},\"aggregateRating\":null,\"alumni\":null,\"areaServed\":null,\"award\":null,\"brand\":null,\"contactPoint\":null,\"correctionsPolicy\":null,\"department\":null,\"dissolutionDate\":null,\"diversityPolicy\":null,\"diversityStaffingReport\":null,\"duns\":\"{seomatic.site.identity.organizationDuns}\",\"email\":\"{seomatic.site.identity.genericEmail}\",\"employee\":null,\"ethicsPolicy\":null,\"event\":null,\"faxNumber\":null,\"founder\":\"{seomatic.site.identity.organizationFounder}\",\"foundingDate\":\"{seomatic.site.identity.organizationFoundingDate}\",\"foundingLocation\":\"{seomatic.site.identity.organizationFoundingLocation}\",\"funder\":null,\"globalLocationNumber\":null,\"hasOfferCatalog\":null,\"hasPOS\":null,\"isicV4\":null,\"knowsAbout\":null,\"knowsLanguage\":null,\"legalName\":null,\"leiCode\":null,\"location\":null,\"logo\":{\"type\":\"ImageObject\",\"url\":\"{seomatic.helper.socialTransform(seomatic.site.identity.genericImageIds[0], \\\"schema-logo\\\")}\",\"width\":\"{seomatic.helper.socialTransformWidth(seomatic.site.identity.genericImageIds[0], \\\"schema-logo\\\")}\",\"height\":\"{seomatic.helper.socialTransformHeight(seomatic.site.identity.genericImageIds[0], \\\"schema-logo\\\")}\"},\"makesOffer\":null,\"member\":null,\"memberOf\":null,\"naics\":null,\"numberOfEmployees\":null,\"ownershipFundingInfo\":null,\"owns\":null,\"parentOrganization\":null,\"publishingPrinciples\":null,\"review\":null,\"seeks\":null,\"slogan\":null,\"sponsor\":null,\"subOrganization\":null,\"taxID\":null,\"telephone\":\"{seomatic.site.identity.genericTelephone}\",\"unnamedSourcesPolicy\":null,\"vatID\":null,\"additionalType\":null,\"alternateName\":\"{seomatic.site.identity.genericAlternateName}\",\"description\":\"{seomatic.site.identity.genericDescription}\",\"disambiguatingDescription\":null,\"identifier\":null,\"image\":{\"type\":\"ImageObject\",\"url\":\"{seomatic.site.identity.genericImage}\",\"width\":\"{seomatic.site.identity.genericImageWidth}\",\"height\":\"{seomatic.site.identity.genericImageHeight}\"},\"mainEntityOfPage\":null,\"name\":\"{seomatic.site.identity.genericName}\",\"potentialAction\":null,\"sameAs\":null,\"subjectOf\":null,\"url\":\"{seomatic.site.identity.genericUrl}\",\"context\":\"http://schema.org\",\"type\":\"{seomatic.site.identity.computedType}\",\"id\":\"{seomatic.site.identity.genericUrl}#identity\",\"graph\":null,\"include\":true,\"key\":\"identity\",\"environment\":null,\"dependencies\":null},\"creator\":{\"actionableFeedbackPolicy\":null,\"address\":{\"type\":\"PostalAddress\",\"streetAddress\":\"{seomatic.site.creator.genericStreetAddress}\",\"addressLocality\":\"{seomatic.site.creator.genericAddressLocality}\",\"addressRegion\":\"{seomatic.site.creator.genericAddressRegion}\",\"postalCode\":\"{seomatic.site.creator.genericPostalCode}\",\"addressCountry\":\"{seomatic.site.creator.genericAddressCountry}\"},\"aggregateRating\":null,\"alumni\":null,\"areaServed\":null,\"award\":null,\"brand\":null,\"contactPoint\":null,\"correctionsPolicy\":null,\"department\":null,\"dissolutionDate\":null,\"diversityPolicy\":null,\"diversityStaffingReport\":null,\"duns\":\"{seomatic.site.creator.organizationDuns}\",\"email\":\"{seomatic.site.creator.genericEmail}\",\"employee\":null,\"ethicsPolicy\":null,\"event\":null,\"faxNumber\":null,\"founder\":\"{seomatic.site.creator.organizationFounder}\",\"foundingDate\":\"{seomatic.site.creator.organizationFoundingDate}\",\"foundingLocation\":\"{seomatic.site.creator.organizationFoundingLocation}\",\"funder\":null,\"globalLocationNumber\":null,\"hasOfferCatalog\":null,\"hasPOS\":null,\"isicV4\":null,\"knowsAbout\":null,\"knowsLanguage\":null,\"legalName\":null,\"leiCode\":null,\"location\":null,\"logo\":{\"type\":\"ImageObject\",\"url\":\"{seomatic.helper.socialTransform(seomatic.site.creator.genericImageIds[0], \\\"schema-logo\\\")}\",\"width\":\"{seomatic.helper.socialTransformWidth(seomatic.site.creator.genericImageIds[0], \\\"schema-logo\\\")}\",\"height\":\"{seomatic.helper.socialTransformHeight(seomatic.site.creator.genericImageIds[0], \\\"schema-logo\\\")}\"},\"makesOffer\":null,\"member\":null,\"memberOf\":null,\"naics\":null,\"numberOfEmployees\":null,\"ownershipFundingInfo\":null,\"owns\":null,\"parentOrganization\":null,\"publishingPrinciples\":null,\"review\":null,\"seeks\":null,\"slogan\":null,\"sponsor\":null,\"subOrganization\":null,\"taxID\":null,\"telephone\":\"{seomatic.site.creator.genericTelephone}\",\"unnamedSourcesPolicy\":null,\"vatID\":null,\"additionalType\":null,\"alternateName\":\"{seomatic.site.creator.genericAlternateName}\",\"description\":\"{seomatic.site.creator.genericDescription}\",\"disambiguatingDescription\":null,\"identifier\":null,\"image\":{\"type\":\"ImageObject\",\"url\":\"{seomatic.site.creator.genericImage}\",\"width\":\"{seomatic.site.creator.genericImageWidth}\",\"height\":\"{seomatic.site.creator.genericImageHeight}\"},\"mainEntityOfPage\":null,\"name\":\"{seomatic.site.creator.genericName}\",\"potentialAction\":null,\"sameAs\":null,\"subjectOf\":null,\"url\":\"{seomatic.site.creator.genericUrl}\",\"context\":\"http://schema.org\",\"type\":\"{seomatic.site.creator.computedType}\",\"id\":\"{seomatic.site.creator.genericUrl}#creator\",\"graph\":null,\"include\":true,\"key\":\"creator\",\"environment\":null,\"dependencies\":null}},\"name\":\"General\",\"description\":\"JsonLd Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaJsonLdContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTitleContainergeneral\":{\"data\":{\"title\":{\"title\":\"{seomatic.meta.seoTitle}\",\"siteName\":\"{seomatic.site.siteName}\",\"siteNamePosition\":\"{seomatic.meta.siteNamePosition}\",\"separatorChar\":\"{seomatic.config.separatorChar}\",\"include\":true,\"key\":\"title\",\"environment\":null,\"dependencies\":null}},\"name\":\"General\",\"description\":\"Meta Title Tag\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTitleContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false}}','[]','{\"data\":{\"humans\":{\"templateVersion\":\"1.0.0\",\"templateString\":\"/* TEAM */\\n\\nCreator: {{ seomatic.site.creator.genericName ?? \\\"n/a\\\" }}\\nURL: {{ seomatic.site.creator.genericUrl ?? \\\"n/a\\\" }}\\nDescription: {{ seomatic.site.creator.genericDescription ?? \\\"n/a\\\" }}\\n\\n/* THANKS */\\n\\nCraft CMS - https://craftcms.com\\nPixel & Tonic - https://pixelandtonic.com\\n\\n/* SITE */\\n\\nStandards: HTML5, CSS3\\nComponents: Craft CMS 3, Yii2, PHP, JavaScript, SEOmatic\\n\",\"siteId\":null,\"include\":true,\"handle\":\"humans\",\"path\":\"humans.txt\",\"template\":\"_frontend/pages/humans.twig\",\"controller\":\"frontend-template\",\"action\":\"humans\"},\"robots\":{\"templateVersion\":\"1.0.0\",\"templateString\":\"# robots.txt for {{ siteUrl }}\\n\\nSitemap: {{ seomatic.helper.sitemapIndexForSiteId() }}\\n{% switch seomatic.config.environment %}\\n\\n{% case \\\"live\\\" %}\\n\\n# live - don\'t allow web crawlers to index cpresources/ or vendor/\\n\\nUser-agent: *\\nDisallow: /cpresources/\\nDisallow: /vendor/\\nDisallow: /.env\\nDisallow: /cache/\\n\\n{% case \\\"staging\\\" %}\\n\\n# staging - disallow all\\n\\nUser-agent: *\\nDisallow: /\\n\\n{% case \\\"local\\\" %}\\n\\n# local - disallow all\\n\\nUser-agent: *\\nDisallow: /\\n\\n{% default %}\\n\\n# default - don\'t allow web crawlers to index cpresources/ or vendor/\\n\\nUser-agent: *\\nDisallow: /cpresources/\\nDisallow: /vendor/\\nDisallow: /.env\\nDisallow: /cache/\\n\\n{% endswitch %}\\n\",\"siteId\":null,\"include\":true,\"handle\":\"robots\",\"path\":\"robots.txt\",\"template\":\"_frontend/pages/robots.twig\",\"controller\":\"frontend-template\",\"action\":\"robots\"},\"ads\":{\"templateVersion\":\"1.0.0\",\"templateString\":\"# ads.txt file for {{ siteUrl }}\\n# More info: https://support.google.com/admanager/answer/7441288?hl=en\\n{{ siteUrl }},123,DIRECT\\n\",\"siteId\":null,\"include\":true,\"handle\":\"ads\",\"path\":\"ads.txt\",\"template\":\"_frontend/pages/ads.twig\",\"controller\":\"frontend-template\",\"action\":\"ads\"}},\"name\":\"Frontend Templates\",\"description\":\"Templates that are rendered on the frontend\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\FrontendTemplateContainer\",\"handle\":\"SeomaticEditableTemplate\",\"include\":true,\"dependencies\":null,\"clearCache\":false}','{\"siteType\":\"CreativeWork\",\"siteSubType\":\"WebSite\",\"siteSpecificType\":\"\",\"seoTitleSource\":\"fromCustom\",\"seoTitleField\":\"\",\"siteNamePositionSource\":\"fromCustom\",\"seoDescriptionSource\":\"fromCustom\",\"seoDescriptionField\":\"\",\"seoKeywordsSource\":\"fromCustom\",\"seoKeywordsField\":\"\",\"seoImageIds\":[],\"seoImageSource\":\"fromAsset\",\"seoImageField\":\"\",\"seoImageTransform\":true,\"seoImageTransformMode\":\"crop\",\"seoImageDescriptionSource\":\"fromCustom\",\"seoImageDescriptionField\":\"\",\"twitterCreatorSource\":\"sameAsSite\",\"twitterCreatorField\":\"\",\"twitterTitleSource\":\"sameAsSeo\",\"twitterTitleField\":\"\",\"twitterSiteNamePositionSource\":\"fromCustom\",\"twitterDescriptionSource\":\"sameAsSeo\",\"twitterDescriptionField\":\"\",\"twitterImageIds\":[],\"twitterImageSource\":\"sameAsSeo\",\"twitterImageField\":\"\",\"twitterImageTransform\":true,\"twitterImageTransformMode\":\"crop\",\"twitterImageDescriptionSource\":\"sameAsSeo\",\"twitterImageDescriptionField\":\"\",\"ogTitleSource\":\"sameAsSeo\",\"ogTitleField\":\"\",\"ogSiteNamePositionSource\":\"fromCustom\",\"ogDescriptionSource\":\"sameAsSeo\",\"ogDescriptionField\":\"\",\"ogImageIds\":[],\"ogImageSource\":\"sameAsSeo\",\"ogImageField\":\"\",\"ogImageTransform\":true,\"ogImageTransformMode\":\"crop\",\"ogImageDescriptionSource\":\"sameAsSeo\",\"ogImageDescriptionField\":\"\"}'),
	(2,'2020-02-01 20:51:13','2020-02-16 00:02:47','aaaa2e42-bc49-497d-b5bf-94ab46377733','1.0.28','section',1,'Drinks','drinks','channel','drinks/_entry',1,'{\"1\":{\"id\":\"1\",\"sectionId\":\"1\",\"siteId\":\"1\",\"enabledByDefault\":\"1\",\"hasUrls\":\"1\",\"uriFormat\":\"drinks/{slug}\",\"template\":\"drinks/_entry\",\"language\":\"en-us\"}}','2020-02-16 00:02:47','{\"language\":null,\"mainEntityOfPage\":\"WebPage\",\"seoTitle\":\"{entry.title}\",\"siteNamePosition\":\"\",\"seoDescription\":\"\",\"seoKeywords\":\"\",\"seoImage\":\"\",\"seoImageWidth\":\"\",\"seoImageHeight\":\"\",\"seoImageDescription\":\"\",\"canonicalUrl\":\"{entry.url}\",\"robots\":\"\",\"ogType\":\"website\",\"ogTitle\":\"{seomatic.meta.seoTitle}\",\"ogSiteNamePosition\":\"\",\"ogDescription\":\"{seomatic.meta.seoDescription}\",\"ogImage\":\"{seomatic.meta.seoImage}\",\"ogImageWidth\":\"{seomatic.meta.seoImageWidth}\",\"ogImageHeight\":\"{seomatic.meta.seoImageHeight}\",\"ogImageDescription\":\"{seomatic.meta.seoImageDescription}\",\"twitterCard\":\"summary_large_image\",\"twitterCreator\":\"{seomatic.site.twitterHandle}\",\"twitterTitle\":\"{seomatic.meta.seoTitle}\",\"twitterSiteNamePosition\":\"\",\"twitterDescription\":\"{seomatic.meta.seoDescription}\",\"twitterImage\":\"{seomatic.meta.seoImage}\",\"twitterImageWidth\":\"{seomatic.meta.seoImageWidth}\",\"twitterImageHeight\":\"{seomatic.meta.seoImageHeight}\",\"twitterImageDescription\":\"{seomatic.meta.seoImageDescription}\"}','{\"siteName\":\"Crafty Coffee\",\"identity\":null,\"creator\":null,\"twitterHandle\":\"\",\"facebookProfileId\":\"\",\"facebookAppId\":\"\",\"googleSiteVerification\":\"\",\"bingSiteVerification\":\"\",\"pinterestSiteVerification\":\"\",\"sameAsLinks\":[],\"siteLinksSearchTarget\":\"\",\"siteLinksQueryInput\":\"\",\"additionalSitemapUrls\":[],\"additionalSitemapUrlsDateUpdated\":null,\"additionalSitemaps\":[]}','{\"sitemapUrls\":true,\"sitemapAssets\":true,\"sitemapFiles\":true,\"sitemapAltLinks\":true,\"sitemapChangeFreq\":\"weekly\",\"sitemapPriority\":0.5,\"sitemapLimit\":null,\"structureDepth\":null,\"sitemapImageFieldMap\":[{\"property\":\"title\",\"field\":\"title\"},{\"property\":\"caption\",\"field\":\"\"},{\"property\":\"geo_location\",\"field\":\"\"},{\"property\":\"license\",\"field\":\"\"}],\"sitemapVideoFieldMap\":[{\"property\":\"title\",\"field\":\"title\"},{\"property\":\"description\",\"field\":\"\"},{\"property\":\"thumbnailLoc\",\"field\":\"\"},{\"property\":\"duration\",\"field\":\"\"},{\"property\":\"category\",\"field\":\"\"}]}','{\"MetaTagContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"General Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContaineropengraph\":{\"data\":[],\"name\":\"Facebook\",\"description\":\"Facebook OpenGraph Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"opengraph\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContainertwitter\":{\"data\":[],\"name\":\"Twitter\",\"description\":\"Twitter Card Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"twitter\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContainermiscellaneous\":{\"data\":[],\"name\":\"Miscellaneous\",\"description\":\"Miscellaneous Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"miscellaneous\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaLinkContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"Link Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaLinkContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaScriptContainergeneral\":{\"data\":[],\"position\":1,\"name\":\"General\",\"description\":\"Script Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaScriptContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaJsonLdContainergeneral\":{\"data\":{\"mainEntityOfPage\":{\"breadcrumb\":null,\"lastReviewed\":null,\"mainContentOfPage\":null,\"primaryImageOfPage\":null,\"relatedLink\":null,\"reviewedBy\":null,\"significantLink\":null,\"speakable\":null,\"specialty\":null,\"about\":null,\"accessMode\":null,\"accessModeSufficient\":null,\"accessibilityAPI\":null,\"accessibilityControl\":null,\"accessibilityFeature\":null,\"accessibilityHazard\":null,\"accessibilitySummary\":null,\"accountablePerson\":null,\"aggregateRating\":null,\"alternativeHeadline\":null,\"associatedMedia\":null,\"audience\":null,\"audio\":null,\"author\":{\"id\":\"{seomatic.site.identity.genericUrl}#identity\"},\"award\":null,\"character\":null,\"citation\":null,\"comment\":null,\"commentCount\":null,\"contentLocation\":null,\"contentRating\":null,\"contentReferenceTime\":null,\"contributor\":null,\"copyrightHolder\":{\"id\":\"{seomatic.site.identity.genericUrl}#identity\"},\"copyrightYear\":\"{entry.postDate | date(\\\"Y\\\")}\",\"correction\":null,\"creator\":{\"id\":\"{seomatic.site.identity.genericUrl}#creator\"},\"dateCreated\":false,\"dateModified\":\"{entry.dateUpdated |atom}\",\"datePublished\":\"{entry.postDate |atom}\",\"discussionUrl\":null,\"editor\":null,\"educationalAlignment\":null,\"educationalUse\":null,\"encoding\":null,\"encodingFormat\":null,\"exampleOfWork\":null,\"expires\":null,\"funder\":null,\"genre\":null,\"hasPart\":null,\"headline\":\"{seomatic.meta.seoTitle}\",\"inLanguage\":\"{seomatic.meta.language}\",\"interactionStatistic\":null,\"interactivityType\":null,\"isAccessibleForFree\":null,\"isBasedOn\":null,\"isFamilyFriendly\":null,\"isPartOf\":null,\"keywords\":null,\"learningResourceType\":null,\"license\":null,\"locationCreated\":null,\"mainEntity\":null,\"material\":null,\"materialExtent\":null,\"mentions\":null,\"offers\":null,\"position\":null,\"producer\":null,\"provider\":null,\"publication\":null,\"publisher\":{\"id\":\"{seomatic.site.identity.genericUrl}#creator\"},\"publisherImprint\":null,\"publishingPrinciples\":null,\"recordedAt\":null,\"releasedEvent\":null,\"review\":null,\"schemaVersion\":null,\"sdDatePublished\":null,\"sdLicense\":null,\"sdPublisher\":null,\"sourceOrganization\":null,\"spatial\":null,\"spatialCoverage\":null,\"sponsor\":null,\"temporal\":null,\"temporalCoverage\":null,\"text\":null,\"thumbnailUrl\":null,\"timeRequired\":null,\"translationOfWork\":null,\"translator\":null,\"typicalAgeRange\":null,\"version\":null,\"video\":null,\"workExample\":null,\"workTranslation\":null,\"additionalType\":null,\"alternateName\":null,\"description\":\"{seomatic.meta.seoDescription}\",\"disambiguatingDescription\":null,\"identifier\":null,\"image\":{\"type\":\"ImageObject\",\"url\":\"{seomatic.meta.seoImage}\"},\"mainEntityOfPage\":\"{seomatic.meta.canonicalUrl}\",\"name\":\"{seomatic.meta.seoTitle}\",\"potentialAction\":{\"type\":\"SearchAction\",\"target\":\"{seomatic.site.siteLinksSearchTarget}\",\"query-input\":\"{seomatic.helper.siteLinksQueryInput()}\"},\"sameAs\":null,\"subjectOf\":null,\"url\":\"{seomatic.meta.canonicalUrl}\",\"context\":\"http://schema.org\",\"type\":\"{seomatic.meta.mainEntityOfPage}\",\"id\":null,\"graph\":null,\"include\":true,\"key\":\"mainEntityOfPage\",\"environment\":null,\"dependencies\":null}},\"name\":\"General\",\"description\":\"JsonLd Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaJsonLdContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTitleContainergeneral\":{\"data\":{\"title\":{\"title\":\"{seomatic.meta.seoTitle}\",\"siteName\":\"{seomatic.site.siteName}\",\"siteNamePosition\":\"{seomatic.meta.siteNamePosition}\",\"separatorChar\":\"{seomatic.config.separatorChar}\",\"include\":true,\"key\":\"title\",\"environment\":null,\"dependencies\":null}},\"name\":\"General\",\"description\":\"Meta Title Tag\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTitleContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false}}','[]','{\"data\":[],\"name\":null,\"description\":null,\"class\":\"nystudio107\\\\seomatic\\\\models\\\\FrontendTemplateContainer\",\"handle\":null,\"include\":true,\"dependencies\":null,\"clearCache\":false}','{\"siteType\":\"CreativeWork\",\"siteSubType\":\"WebPage\",\"siteSpecificType\":\"\",\"seoTitleSource\":\"fromField\",\"seoTitleField\":\"title\",\"siteNamePositionSource\":\"sameAsGlobal\",\"seoDescriptionSource\":\"fromCustom\",\"seoDescriptionField\":\"\",\"seoKeywordsSource\":\"fromCustom\",\"seoKeywordsField\":\"\",\"seoImageIds\":[],\"seoImageSource\":\"fromAsset\",\"seoImageField\":\"\",\"seoImageTransform\":true,\"seoImageTransformMode\":\"crop\",\"seoImageDescriptionSource\":\"fromCustom\",\"seoImageDescriptionField\":\"\",\"twitterCreatorSource\":\"sameAsSite\",\"twitterCreatorField\":\"\",\"twitterTitleSource\":\"sameAsSeo\",\"twitterTitleField\":\"\",\"twitterSiteNamePositionSource\":\"sameAsGlobal\",\"twitterDescriptionSource\":\"sameAsSeo\",\"twitterDescriptionField\":\"\",\"twitterImageIds\":[],\"twitterImageSource\":\"sameAsSeo\",\"twitterImageField\":\"\",\"twitterImageTransform\":true,\"twitterImageTransformMode\":\"crop\",\"twitterImageDescriptionSource\":\"sameAsSeo\",\"twitterImageDescriptionField\":\"\",\"ogTitleSource\":\"sameAsSeo\",\"ogTitleField\":\"\",\"ogSiteNamePositionSource\":\"sameAsGlobal\",\"ogDescriptionSource\":\"sameAsSeo\",\"ogDescriptionField\":\"\",\"ogImageIds\":[],\"ogImageSource\":\"sameAsSeo\",\"ogImageField\":\"\",\"ogImageTransform\":true,\"ogImageTransformMode\":\"crop\",\"ogImageDescriptionSource\":\"sameAsSeo\",\"ogImageDescriptionField\":\"\"}'),
	(3,'2020-02-01 21:02:31','2020-02-09 21:54:28','932af653-ebdd-46e3-ba5a-adc97225556a','1.0.28','section',2,'News','news','channel','news/_entry',1,'{\"1\":{\"id\":\"2\",\"sectionId\":\"2\",\"siteId\":\"1\",\"enabledByDefault\":\"1\",\"hasUrls\":\"1\",\"uriFormat\":\"news/{slug}\",\"template\":\"news/_entry\",\"language\":\"en-us\"}}','2020-02-09 21:54:28','{\"language\":null,\"mainEntityOfPage\":\"WebPage\",\"seoTitle\":\"{entry.title}\",\"siteNamePosition\":\"\",\"seoDescription\":\"\",\"seoKeywords\":\"\",\"seoImage\":\"\",\"seoImageWidth\":\"\",\"seoImageHeight\":\"\",\"seoImageDescription\":\"\",\"canonicalUrl\":\"{entry.url}\",\"robots\":\"\",\"ogType\":\"website\",\"ogTitle\":\"{seomatic.meta.seoTitle}\",\"ogSiteNamePosition\":\"\",\"ogDescription\":\"{seomatic.meta.seoDescription}\",\"ogImage\":\"{seomatic.meta.seoImage}\",\"ogImageWidth\":\"{seomatic.meta.seoImageWidth}\",\"ogImageHeight\":\"{seomatic.meta.seoImageHeight}\",\"ogImageDescription\":\"{seomatic.meta.seoImageDescription}\",\"twitterCard\":\"summary_large_image\",\"twitterCreator\":\"{seomatic.site.twitterHandle}\",\"twitterTitle\":\"{seomatic.meta.seoTitle}\",\"twitterSiteNamePosition\":\"\",\"twitterDescription\":\"{seomatic.meta.seoDescription}\",\"twitterImage\":\"{seomatic.meta.seoImage}\",\"twitterImageWidth\":\"{seomatic.meta.seoImageWidth}\",\"twitterImageHeight\":\"{seomatic.meta.seoImageHeight}\",\"twitterImageDescription\":\"{seomatic.meta.seoImageDescription}\"}','{\"siteName\":\"Crafty Coffee\",\"identity\":null,\"creator\":null,\"twitterHandle\":\"\",\"facebookProfileId\":\"\",\"facebookAppId\":\"\",\"googleSiteVerification\":\"\",\"bingSiteVerification\":\"\",\"pinterestSiteVerification\":\"\",\"sameAsLinks\":[],\"siteLinksSearchTarget\":\"\",\"siteLinksQueryInput\":\"\",\"additionalSitemapUrls\":[],\"additionalSitemapUrlsDateUpdated\":null,\"additionalSitemaps\":[]}','{\"sitemapUrls\":true,\"sitemapAssets\":true,\"sitemapFiles\":true,\"sitemapAltLinks\":true,\"sitemapChangeFreq\":\"weekly\",\"sitemapPriority\":0.5,\"sitemapLimit\":null,\"structureDepth\":null,\"sitemapImageFieldMap\":[{\"property\":\"title\",\"field\":\"title\"},{\"property\":\"caption\",\"field\":\"\"},{\"property\":\"geo_location\",\"field\":\"\"},{\"property\":\"license\",\"field\":\"\"}],\"sitemapVideoFieldMap\":[{\"property\":\"title\",\"field\":\"title\"},{\"property\":\"description\",\"field\":\"\"},{\"property\":\"thumbnailLoc\",\"field\":\"\"},{\"property\":\"duration\",\"field\":\"\"},{\"property\":\"category\",\"field\":\"\"}]}','{\"MetaTagContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"General Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContaineropengraph\":{\"data\":[],\"name\":\"Facebook\",\"description\":\"Facebook OpenGraph Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"opengraph\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContainertwitter\":{\"data\":[],\"name\":\"Twitter\",\"description\":\"Twitter Card Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"twitter\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContainermiscellaneous\":{\"data\":[],\"name\":\"Miscellaneous\",\"description\":\"Miscellaneous Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"miscellaneous\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaLinkContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"Link Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaLinkContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaScriptContainergeneral\":{\"data\":[],\"position\":1,\"name\":\"General\",\"description\":\"Script Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaScriptContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaJsonLdContainergeneral\":{\"data\":{\"mainEntityOfPage\":{\"breadcrumb\":null,\"lastReviewed\":null,\"mainContentOfPage\":null,\"primaryImageOfPage\":null,\"relatedLink\":null,\"reviewedBy\":null,\"significantLink\":null,\"speakable\":null,\"specialty\":null,\"about\":null,\"accessMode\":null,\"accessModeSufficient\":null,\"accessibilityAPI\":null,\"accessibilityControl\":null,\"accessibilityFeature\":null,\"accessibilityHazard\":null,\"accessibilitySummary\":null,\"accountablePerson\":null,\"aggregateRating\":null,\"alternativeHeadline\":null,\"associatedMedia\":null,\"audience\":null,\"audio\":null,\"author\":{\"id\":\"{seomatic.site.identity.genericUrl}#identity\"},\"award\":null,\"character\":null,\"citation\":null,\"comment\":null,\"commentCount\":null,\"contentLocation\":null,\"contentRating\":null,\"contentReferenceTime\":null,\"contributor\":null,\"copyrightHolder\":{\"id\":\"{seomatic.site.identity.genericUrl}#identity\"},\"copyrightYear\":\"{entry.postDate | date(\\\"Y\\\")}\",\"correction\":null,\"creator\":{\"id\":\"{seomatic.site.identity.genericUrl}#creator\"},\"dateCreated\":false,\"dateModified\":\"{entry.dateUpdated |atom}\",\"datePublished\":\"{entry.postDate |atom}\",\"discussionUrl\":null,\"editor\":null,\"educationalAlignment\":null,\"educationalUse\":null,\"encoding\":null,\"encodingFormat\":null,\"exampleOfWork\":null,\"expires\":null,\"funder\":null,\"genre\":null,\"hasPart\":null,\"headline\":\"{seomatic.meta.seoTitle}\",\"inLanguage\":\"{seomatic.meta.language}\",\"interactionStatistic\":null,\"interactivityType\":null,\"isAccessibleForFree\":null,\"isBasedOn\":null,\"isFamilyFriendly\":null,\"isPartOf\":null,\"keywords\":null,\"learningResourceType\":null,\"license\":null,\"locationCreated\":null,\"mainEntity\":null,\"material\":null,\"materialExtent\":null,\"mentions\":null,\"offers\":null,\"position\":null,\"producer\":null,\"provider\":null,\"publication\":null,\"publisher\":{\"id\":\"{seomatic.site.identity.genericUrl}#creator\"},\"publisherImprint\":null,\"publishingPrinciples\":null,\"recordedAt\":null,\"releasedEvent\":null,\"review\":null,\"schemaVersion\":null,\"sdDatePublished\":null,\"sdLicense\":null,\"sdPublisher\":null,\"sourceOrganization\":null,\"spatial\":null,\"spatialCoverage\":null,\"sponsor\":null,\"temporal\":null,\"temporalCoverage\":null,\"text\":null,\"thumbnailUrl\":null,\"timeRequired\":null,\"translationOfWork\":null,\"translator\":null,\"typicalAgeRange\":null,\"version\":null,\"video\":null,\"workExample\":null,\"workTranslation\":null,\"additionalType\":null,\"alternateName\":null,\"description\":\"{seomatic.meta.seoDescription}\",\"disambiguatingDescription\":null,\"identifier\":null,\"image\":{\"type\":\"ImageObject\",\"url\":\"{seomatic.meta.seoImage}\"},\"mainEntityOfPage\":\"{seomatic.meta.canonicalUrl}\",\"name\":\"{seomatic.meta.seoTitle}\",\"potentialAction\":{\"type\":\"SearchAction\",\"target\":\"{seomatic.site.siteLinksSearchTarget}\",\"query-input\":\"{seomatic.helper.siteLinksQueryInput()}\"},\"sameAs\":null,\"subjectOf\":null,\"url\":\"{seomatic.meta.canonicalUrl}\",\"context\":\"http://schema.org\",\"type\":\"{seomatic.meta.mainEntityOfPage}\",\"id\":null,\"graph\":null,\"include\":true,\"key\":\"mainEntityOfPage\",\"environment\":null,\"dependencies\":null}},\"name\":\"General\",\"description\":\"JsonLd Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaJsonLdContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTitleContainergeneral\":{\"data\":{\"title\":{\"title\":\"{seomatic.meta.seoTitle}\",\"siteName\":\"{seomatic.site.siteName}\",\"siteNamePosition\":\"{seomatic.meta.siteNamePosition}\",\"separatorChar\":\"{seomatic.config.separatorChar}\",\"include\":true,\"key\":\"title\",\"environment\":null,\"dependencies\":null}},\"name\":\"General\",\"description\":\"Meta Title Tag\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTitleContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false}}','[]','{\"data\":[],\"name\":null,\"description\":null,\"class\":\"nystudio107\\\\seomatic\\\\models\\\\FrontendTemplateContainer\",\"handle\":null,\"include\":true,\"dependencies\":null,\"clearCache\":false}','{\"siteType\":\"CreativeWork\",\"siteSubType\":\"WebPage\",\"siteSpecificType\":\"\",\"seoTitleSource\":\"fromField\",\"seoTitleField\":\"title\",\"siteNamePositionSource\":\"sameAsGlobal\",\"seoDescriptionSource\":\"fromCustom\",\"seoDescriptionField\":\"\",\"seoKeywordsSource\":\"fromCustom\",\"seoKeywordsField\":\"\",\"seoImageIds\":[],\"seoImageSource\":\"fromAsset\",\"seoImageField\":\"\",\"seoImageTransform\":true,\"seoImageTransformMode\":\"crop\",\"seoImageDescriptionSource\":\"fromCustom\",\"seoImageDescriptionField\":\"\",\"twitterCreatorSource\":\"sameAsSite\",\"twitterCreatorField\":\"\",\"twitterTitleSource\":\"sameAsSeo\",\"twitterTitleField\":\"\",\"twitterSiteNamePositionSource\":\"sameAsGlobal\",\"twitterDescriptionSource\":\"sameAsSeo\",\"twitterDescriptionField\":\"\",\"twitterImageIds\":[],\"twitterImageSource\":\"sameAsSeo\",\"twitterImageField\":\"\",\"twitterImageTransform\":true,\"twitterImageTransformMode\":\"crop\",\"twitterImageDescriptionSource\":\"sameAsSeo\",\"twitterImageDescriptionField\":\"\",\"ogTitleSource\":\"sameAsSeo\",\"ogTitleField\":\"\",\"ogSiteNamePositionSource\":\"sameAsGlobal\",\"ogDescriptionSource\":\"sameAsSeo\",\"ogDescriptionField\":\"\",\"ogImageIds\":[],\"ogImageSource\":\"sameAsSeo\",\"ogImageField\":\"\",\"ogImageTransform\":true,\"ogImageTransformMode\":\"crop\",\"ogImageDescriptionSource\":\"sameAsSeo\",\"ogImageDescriptionField\":\"\"}'),
	(4,'2020-02-09 17:31:34','2020-02-09 20:47:42','6f192c2d-b2c7-4632-a9bc-93f56c97c428','1.0.28','section',3,'Homepage','homepage','single','index',1,'{\"1\":{\"id\":\"3\",\"sectionId\":\"3\",\"siteId\":\"1\",\"enabledByDefault\":\"1\",\"hasUrls\":\"1\",\"uriFormat\":\"__home__\",\"template\":\"index\",\"language\":\"en-us\"}}','2020-02-09 20:47:42','{\"language\":null,\"mainEntityOfPage\":\"WebPage\",\"seoTitle\":\"{entry.title}\",\"siteNamePosition\":\"\",\"seoDescription\":\"\",\"seoKeywords\":\"\",\"seoImage\":\"\",\"seoImageWidth\":\"\",\"seoImageHeight\":\"\",\"seoImageDescription\":\"\",\"canonicalUrl\":\"{entry.url}\",\"robots\":\"\",\"ogType\":\"website\",\"ogTitle\":\"{seomatic.meta.seoTitle}\",\"ogSiteNamePosition\":\"\",\"ogDescription\":\"{seomatic.meta.seoDescription}\",\"ogImage\":\"{seomatic.meta.seoImage}\",\"ogImageWidth\":\"{seomatic.meta.seoImageWidth}\",\"ogImageHeight\":\"{seomatic.meta.seoImageHeight}\",\"ogImageDescription\":\"{seomatic.meta.seoImageDescription}\",\"twitterCard\":\"summary_large_image\",\"twitterCreator\":\"{seomatic.site.twitterHandle}\",\"twitterTitle\":\"{seomatic.meta.seoTitle}\",\"twitterSiteNamePosition\":\"\",\"twitterDescription\":\"{seomatic.meta.seoDescription}\",\"twitterImage\":\"{seomatic.meta.seoImage}\",\"twitterImageWidth\":\"{seomatic.meta.seoImageWidth}\",\"twitterImageHeight\":\"{seomatic.meta.seoImageHeight}\",\"twitterImageDescription\":\"{seomatic.meta.seoImageDescription}\"}','{\"siteName\":\"Crafty Coffee\",\"identity\":null,\"creator\":null,\"twitterHandle\":\"\",\"facebookProfileId\":\"\",\"facebookAppId\":\"\",\"googleSiteVerification\":\"\",\"bingSiteVerification\":\"\",\"pinterestSiteVerification\":\"\",\"sameAsLinks\":[],\"siteLinksSearchTarget\":\"\",\"siteLinksQueryInput\":\"\",\"additionalSitemapUrls\":[],\"additionalSitemapUrlsDateUpdated\":null,\"additionalSitemaps\":[]}','{\"sitemapUrls\":true,\"sitemapAssets\":true,\"sitemapFiles\":true,\"sitemapAltLinks\":true,\"sitemapChangeFreq\":\"weekly\",\"sitemapPriority\":0.5,\"sitemapLimit\":null,\"structureDepth\":null,\"sitemapImageFieldMap\":[{\"property\":\"title\",\"field\":\"title\"},{\"property\":\"caption\",\"field\":\"\"},{\"property\":\"geo_location\",\"field\":\"\"},{\"property\":\"license\",\"field\":\"\"}],\"sitemapVideoFieldMap\":[{\"property\":\"title\",\"field\":\"title\"},{\"property\":\"description\",\"field\":\"\"},{\"property\":\"thumbnailLoc\",\"field\":\"\"},{\"property\":\"duration\",\"field\":\"\"},{\"property\":\"category\",\"field\":\"\"}]}','{\"MetaTagContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"General Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContaineropengraph\":{\"data\":[],\"name\":\"Facebook\",\"description\":\"Facebook OpenGraph Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"opengraph\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContainertwitter\":{\"data\":[],\"name\":\"Twitter\",\"description\":\"Twitter Card Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"twitter\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContainermiscellaneous\":{\"data\":[],\"name\":\"Miscellaneous\",\"description\":\"Miscellaneous Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"miscellaneous\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaLinkContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"Link Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaLinkContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaScriptContainergeneral\":{\"data\":[],\"position\":1,\"name\":\"General\",\"description\":\"Script Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaScriptContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaJsonLdContainergeneral\":{\"data\":{\"mainEntityOfPage\":{\"breadcrumb\":null,\"lastReviewed\":null,\"mainContentOfPage\":null,\"primaryImageOfPage\":null,\"relatedLink\":null,\"reviewedBy\":null,\"significantLink\":null,\"speakable\":null,\"specialty\":null,\"about\":null,\"accessMode\":null,\"accessModeSufficient\":null,\"accessibilityAPI\":null,\"accessibilityControl\":null,\"accessibilityFeature\":null,\"accessibilityHazard\":null,\"accessibilitySummary\":null,\"accountablePerson\":null,\"aggregateRating\":null,\"alternativeHeadline\":null,\"associatedMedia\":null,\"audience\":null,\"audio\":null,\"author\":{\"id\":\"{seomatic.site.identity.genericUrl}#identity\"},\"award\":null,\"character\":null,\"citation\":null,\"comment\":null,\"commentCount\":null,\"contentLocation\":null,\"contentRating\":null,\"contentReferenceTime\":null,\"contributor\":null,\"copyrightHolder\":{\"id\":\"{seomatic.site.identity.genericUrl}#identity\"},\"copyrightYear\":\"{entry.postDate | date(\\\"Y\\\")}\",\"correction\":null,\"creator\":{\"id\":\"{seomatic.site.identity.genericUrl}#creator\"},\"dateCreated\":false,\"dateModified\":\"{entry.dateUpdated |atom}\",\"datePublished\":\"{entry.postDate |atom}\",\"discussionUrl\":null,\"editor\":null,\"educationalAlignment\":null,\"educationalUse\":null,\"encoding\":null,\"encodingFormat\":null,\"exampleOfWork\":null,\"expires\":null,\"funder\":null,\"genre\":null,\"hasPart\":null,\"headline\":\"{seomatic.meta.seoTitle}\",\"inLanguage\":\"{seomatic.meta.language}\",\"interactionStatistic\":null,\"interactivityType\":null,\"isAccessibleForFree\":null,\"isBasedOn\":null,\"isFamilyFriendly\":null,\"isPartOf\":null,\"keywords\":null,\"learningResourceType\":null,\"license\":null,\"locationCreated\":null,\"mainEntity\":null,\"material\":null,\"materialExtent\":null,\"mentions\":null,\"offers\":null,\"position\":null,\"producer\":null,\"provider\":null,\"publication\":null,\"publisher\":{\"id\":\"{seomatic.site.identity.genericUrl}#creator\"},\"publisherImprint\":null,\"publishingPrinciples\":null,\"recordedAt\":null,\"releasedEvent\":null,\"review\":null,\"schemaVersion\":null,\"sdDatePublished\":null,\"sdLicense\":null,\"sdPublisher\":null,\"sourceOrganization\":null,\"spatial\":null,\"spatialCoverage\":null,\"sponsor\":null,\"temporal\":null,\"temporalCoverage\":null,\"text\":null,\"thumbnailUrl\":null,\"timeRequired\":null,\"translationOfWork\":null,\"translator\":null,\"typicalAgeRange\":null,\"version\":null,\"video\":null,\"workExample\":null,\"workTranslation\":null,\"additionalType\":null,\"alternateName\":null,\"description\":\"{seomatic.meta.seoDescription}\",\"disambiguatingDescription\":null,\"identifier\":null,\"image\":{\"type\":\"ImageObject\",\"url\":\"{seomatic.meta.seoImage}\"},\"mainEntityOfPage\":\"{seomatic.meta.canonicalUrl}\",\"name\":\"{seomatic.meta.seoTitle}\",\"potentialAction\":{\"type\":\"SearchAction\",\"target\":\"{seomatic.site.siteLinksSearchTarget}\",\"query-input\":\"{seomatic.helper.siteLinksQueryInput()}\"},\"sameAs\":null,\"subjectOf\":null,\"url\":\"{seomatic.meta.canonicalUrl}\",\"context\":\"http://schema.org\",\"type\":\"{seomatic.meta.mainEntityOfPage}\",\"id\":null,\"graph\":null,\"include\":true,\"key\":\"mainEntityOfPage\",\"environment\":null,\"dependencies\":null}},\"name\":\"General\",\"description\":\"JsonLd Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaJsonLdContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTitleContainergeneral\":{\"data\":{\"title\":{\"title\":\"{seomatic.meta.seoTitle}\",\"siteName\":\"{seomatic.site.siteName}\",\"siteNamePosition\":\"{seomatic.meta.siteNamePosition}\",\"separatorChar\":\"{seomatic.config.separatorChar}\",\"include\":true,\"key\":\"title\",\"environment\":null,\"dependencies\":null}},\"name\":\"General\",\"description\":\"Meta Title Tag\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTitleContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false}}','[]','{\"data\":[],\"name\":null,\"description\":null,\"class\":\"nystudio107\\\\seomatic\\\\models\\\\FrontendTemplateContainer\",\"handle\":null,\"include\":true,\"dependencies\":null,\"clearCache\":false}','{\"siteType\":\"CreativeWork\",\"siteSubType\":\"WebPage\",\"siteSpecificType\":\"\",\"seoTitleSource\":\"fromField\",\"seoTitleField\":\"title\",\"siteNamePositionSource\":\"sameAsGlobal\",\"seoDescriptionSource\":\"fromCustom\",\"seoDescriptionField\":\"\",\"seoKeywordsSource\":\"fromCustom\",\"seoKeywordsField\":\"\",\"seoImageIds\":[],\"seoImageSource\":\"fromAsset\",\"seoImageField\":\"\",\"seoImageTransform\":true,\"seoImageTransformMode\":\"crop\",\"seoImageDescriptionSource\":\"fromCustom\",\"seoImageDescriptionField\":\"\",\"twitterCreatorSource\":\"sameAsSite\",\"twitterCreatorField\":\"\",\"twitterTitleSource\":\"sameAsSeo\",\"twitterTitleField\":\"\",\"twitterSiteNamePositionSource\":\"sameAsGlobal\",\"twitterDescriptionSource\":\"sameAsSeo\",\"twitterDescriptionField\":\"\",\"twitterImageIds\":[],\"twitterImageSource\":\"sameAsSeo\",\"twitterImageField\":\"\",\"twitterImageTransform\":true,\"twitterImageTransformMode\":\"crop\",\"twitterImageDescriptionSource\":\"sameAsSeo\",\"twitterImageDescriptionField\":\"\",\"ogTitleSource\":\"sameAsSeo\",\"ogTitleField\":\"\",\"ogSiteNamePositionSource\":\"sameAsGlobal\",\"ogDescriptionSource\":\"sameAsSeo\",\"ogDescriptionField\":\"\",\"ogImageIds\":[],\"ogImageSource\":\"sameAsSeo\",\"ogImageField\":\"\",\"ogImageTransform\":true,\"ogImageTransformMode\":\"crop\",\"ogImageDescriptionSource\":\"sameAsSeo\",\"ogImageDescriptionField\":\"\"}'),
	(5,'2020-02-09 19:19:20','2020-02-15 20:57:07','f0eb0ac5-f621-4e5f-9233-34cbcccc2a5f','1.0.28','section',4,'About Crafty Coffee','aboutCraftyCoffee','structure','about/_entry',1,'{\"1\":{\"id\":\"4\",\"sectionId\":\"4\",\"siteId\":\"1\",\"enabledByDefault\":\"1\",\"hasUrls\":\"1\",\"uriFormat\":\"about/{slug}\",\"template\":\"about/_entry\",\"language\":\"en-us\"}}','2020-02-15 20:57:06','{\"language\":null,\"mainEntityOfPage\":\"WebPage\",\"seoTitle\":\"{entry.title}\",\"siteNamePosition\":\"\",\"seoDescription\":\"\",\"seoKeywords\":\"\",\"seoImage\":\"\",\"seoImageWidth\":\"\",\"seoImageHeight\":\"\",\"seoImageDescription\":\"\",\"canonicalUrl\":\"{entry.url}\",\"robots\":\"\",\"ogType\":\"website\",\"ogTitle\":\"{seomatic.meta.seoTitle}\",\"ogSiteNamePosition\":\"\",\"ogDescription\":\"{seomatic.meta.seoDescription}\",\"ogImage\":\"{seomatic.meta.seoImage}\",\"ogImageWidth\":\"{seomatic.meta.seoImageWidth}\",\"ogImageHeight\":\"{seomatic.meta.seoImageHeight}\",\"ogImageDescription\":\"{seomatic.meta.seoImageDescription}\",\"twitterCard\":\"summary_large_image\",\"twitterCreator\":\"{seomatic.site.twitterHandle}\",\"twitterTitle\":\"{seomatic.meta.seoTitle}\",\"twitterSiteNamePosition\":\"\",\"twitterDescription\":\"{seomatic.meta.seoDescription}\",\"twitterImage\":\"{seomatic.meta.seoImage}\",\"twitterImageWidth\":\"{seomatic.meta.seoImageWidth}\",\"twitterImageHeight\":\"{seomatic.meta.seoImageHeight}\",\"twitterImageDescription\":\"{seomatic.meta.seoImageDescription}\"}','{\"siteName\":\"Crafty Coffee\",\"identity\":null,\"creator\":null,\"twitterHandle\":\"\",\"facebookProfileId\":\"\",\"facebookAppId\":\"\",\"googleSiteVerification\":\"\",\"bingSiteVerification\":\"\",\"pinterestSiteVerification\":\"\",\"sameAsLinks\":[],\"siteLinksSearchTarget\":\"\",\"siteLinksQueryInput\":\"\",\"additionalSitemapUrls\":[],\"additionalSitemapUrlsDateUpdated\":null,\"additionalSitemaps\":[]}','{\"sitemapUrls\":true,\"sitemapAssets\":true,\"sitemapFiles\":true,\"sitemapAltLinks\":true,\"sitemapChangeFreq\":\"weekly\",\"sitemapPriority\":0.5,\"sitemapLimit\":null,\"structureDepth\":null,\"sitemapImageFieldMap\":[{\"property\":\"title\",\"field\":\"title\"},{\"property\":\"caption\",\"field\":\"\"},{\"property\":\"geo_location\",\"field\":\"\"},{\"property\":\"license\",\"field\":\"\"}],\"sitemapVideoFieldMap\":[{\"property\":\"title\",\"field\":\"title\"},{\"property\":\"description\",\"field\":\"\"},{\"property\":\"thumbnailLoc\",\"field\":\"\"},{\"property\":\"duration\",\"field\":\"\"},{\"property\":\"category\",\"field\":\"\"}]}','{\"MetaTagContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"General Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContaineropengraph\":{\"data\":[],\"name\":\"Facebook\",\"description\":\"Facebook OpenGraph Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"opengraph\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContainertwitter\":{\"data\":[],\"name\":\"Twitter\",\"description\":\"Twitter Card Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"twitter\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContainermiscellaneous\":{\"data\":[],\"name\":\"Miscellaneous\",\"description\":\"Miscellaneous Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"miscellaneous\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaLinkContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"Link Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaLinkContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaScriptContainergeneral\":{\"data\":[],\"position\":1,\"name\":\"General\",\"description\":\"Script Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaScriptContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaJsonLdContainergeneral\":{\"data\":{\"mainEntityOfPage\":{\"breadcrumb\":null,\"lastReviewed\":null,\"mainContentOfPage\":null,\"primaryImageOfPage\":null,\"relatedLink\":null,\"reviewedBy\":null,\"significantLink\":null,\"speakable\":null,\"specialty\":null,\"about\":null,\"accessMode\":null,\"accessModeSufficient\":null,\"accessibilityAPI\":null,\"accessibilityControl\":null,\"accessibilityFeature\":null,\"accessibilityHazard\":null,\"accessibilitySummary\":null,\"accountablePerson\":null,\"aggregateRating\":null,\"alternativeHeadline\":null,\"associatedMedia\":null,\"audience\":null,\"audio\":null,\"author\":{\"id\":\"{seomatic.site.identity.genericUrl}#identity\"},\"award\":null,\"character\":null,\"citation\":null,\"comment\":null,\"commentCount\":null,\"contentLocation\":null,\"contentRating\":null,\"contentReferenceTime\":null,\"contributor\":null,\"copyrightHolder\":{\"id\":\"{seomatic.site.identity.genericUrl}#identity\"},\"copyrightYear\":\"{entry.postDate | date(\\\"Y\\\")}\",\"correction\":null,\"creator\":{\"id\":\"{seomatic.site.identity.genericUrl}#creator\"},\"dateCreated\":false,\"dateModified\":\"{entry.dateUpdated |atom}\",\"datePublished\":\"{entry.postDate |atom}\",\"discussionUrl\":null,\"editor\":null,\"educationalAlignment\":null,\"educationalUse\":null,\"encoding\":null,\"encodingFormat\":null,\"exampleOfWork\":null,\"expires\":null,\"funder\":null,\"genre\":null,\"hasPart\":null,\"headline\":\"{seomatic.meta.seoTitle}\",\"inLanguage\":\"{seomatic.meta.language}\",\"interactionStatistic\":null,\"interactivityType\":null,\"isAccessibleForFree\":null,\"isBasedOn\":null,\"isFamilyFriendly\":null,\"isPartOf\":null,\"keywords\":null,\"learningResourceType\":null,\"license\":null,\"locationCreated\":null,\"mainEntity\":null,\"material\":null,\"materialExtent\":null,\"mentions\":null,\"offers\":null,\"position\":null,\"producer\":null,\"provider\":null,\"publication\":null,\"publisher\":{\"id\":\"{seomatic.site.identity.genericUrl}#creator\"},\"publisherImprint\":null,\"publishingPrinciples\":null,\"recordedAt\":null,\"releasedEvent\":null,\"review\":null,\"schemaVersion\":null,\"sdDatePublished\":null,\"sdLicense\":null,\"sdPublisher\":null,\"sourceOrganization\":null,\"spatial\":null,\"spatialCoverage\":null,\"sponsor\":null,\"temporal\":null,\"temporalCoverage\":null,\"text\":null,\"thumbnailUrl\":null,\"timeRequired\":null,\"translationOfWork\":null,\"translator\":null,\"typicalAgeRange\":null,\"version\":null,\"video\":null,\"workExample\":null,\"workTranslation\":null,\"additionalType\":null,\"alternateName\":null,\"description\":\"{seomatic.meta.seoDescription}\",\"disambiguatingDescription\":null,\"identifier\":null,\"image\":{\"type\":\"ImageObject\",\"url\":\"{seomatic.meta.seoImage}\"},\"mainEntityOfPage\":\"{seomatic.meta.canonicalUrl}\",\"name\":\"{seomatic.meta.seoTitle}\",\"potentialAction\":{\"type\":\"SearchAction\",\"target\":\"{seomatic.site.siteLinksSearchTarget}\",\"query-input\":\"{seomatic.helper.siteLinksQueryInput()}\"},\"sameAs\":null,\"subjectOf\":null,\"url\":\"{seomatic.meta.canonicalUrl}\",\"context\":\"http://schema.org\",\"type\":\"{seomatic.meta.mainEntityOfPage}\",\"id\":null,\"graph\":null,\"include\":true,\"key\":\"mainEntityOfPage\",\"environment\":null,\"dependencies\":null}},\"name\":\"General\",\"description\":\"JsonLd Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaJsonLdContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTitleContainergeneral\":{\"data\":{\"title\":{\"title\":\"{seomatic.meta.seoTitle}\",\"siteName\":\"{seomatic.site.siteName}\",\"siteNamePosition\":\"{seomatic.meta.siteNamePosition}\",\"separatorChar\":\"{seomatic.config.separatorChar}\",\"include\":true,\"key\":\"title\",\"environment\":null,\"dependencies\":null}},\"name\":\"General\",\"description\":\"Meta Title Tag\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTitleContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false}}','[]','{\"data\":[],\"name\":null,\"description\":null,\"class\":\"nystudio107\\\\seomatic\\\\models\\\\FrontendTemplateContainer\",\"handle\":null,\"include\":true,\"dependencies\":null,\"clearCache\":false}','{\"siteType\":\"CreativeWork\",\"siteSubType\":\"WebPage\",\"siteSpecificType\":\"\",\"seoTitleSource\":\"fromField\",\"seoTitleField\":\"title\",\"siteNamePositionSource\":\"sameAsGlobal\",\"seoDescriptionSource\":\"fromCustom\",\"seoDescriptionField\":\"\",\"seoKeywordsSource\":\"fromCustom\",\"seoKeywordsField\":\"\",\"seoImageIds\":[],\"seoImageSource\":\"fromAsset\",\"seoImageField\":\"\",\"seoImageTransform\":true,\"seoImageTransformMode\":\"crop\",\"seoImageDescriptionSource\":\"fromCustom\",\"seoImageDescriptionField\":\"\",\"twitterCreatorSource\":\"sameAsSite\",\"twitterCreatorField\":\"\",\"twitterTitleSource\":\"sameAsSeo\",\"twitterTitleField\":\"\",\"twitterSiteNamePositionSource\":\"sameAsGlobal\",\"twitterDescriptionSource\":\"sameAsSeo\",\"twitterDescriptionField\":\"\",\"twitterImageIds\":[],\"twitterImageSource\":\"sameAsSeo\",\"twitterImageField\":\"\",\"twitterImageTransform\":true,\"twitterImageTransformMode\":\"crop\",\"twitterImageDescriptionSource\":\"sameAsSeo\",\"twitterImageDescriptionField\":\"\",\"ogTitleSource\":\"sameAsSeo\",\"ogTitleField\":\"\",\"ogSiteNamePositionSource\":\"sameAsGlobal\",\"ogDescriptionSource\":\"sameAsSeo\",\"ogDescriptionField\":\"\",\"ogImageIds\":[],\"ogImageSource\":\"sameAsSeo\",\"ogImageField\":\"\",\"ogImageTransform\":true,\"ogImageTransformMode\":\"crop\",\"ogImageDescriptionSource\":\"sameAsSeo\",\"ogImageDescriptionField\":\"\"}'),
	(6,'2020-02-15 21:06:04','2020-02-16 00:02:30','82f8ae00-3c8c-4c2b-82dc-af10bcb6f3a2','1.0.28','section',5,'Recipes','recipes','channel','recipes/_entry',1,'{\"1\":{\"id\":\"5\",\"sectionId\":\"5\",\"siteId\":\"1\",\"enabledByDefault\":\"1\",\"hasUrls\":\"1\",\"uriFormat\":\"recipes/{slug}\",\"template\":\"recipes/_entry\",\"language\":\"en-us\"}}','2020-02-16 00:02:30','{\"language\":null,\"mainEntityOfPage\":\"WebPage\",\"seoTitle\":\"{entry.title}\",\"siteNamePosition\":\"\",\"seoDescription\":\"\",\"seoKeywords\":\"\",\"seoImage\":\"\",\"seoImageWidth\":\"\",\"seoImageHeight\":\"\",\"seoImageDescription\":\"\",\"canonicalUrl\":\"{entry.url}\",\"robots\":\"\",\"ogType\":\"website\",\"ogTitle\":\"{seomatic.meta.seoTitle}\",\"ogSiteNamePosition\":\"\",\"ogDescription\":\"{seomatic.meta.seoDescription}\",\"ogImage\":\"{seomatic.meta.seoImage}\",\"ogImageWidth\":\"{seomatic.meta.seoImageWidth}\",\"ogImageHeight\":\"{seomatic.meta.seoImageHeight}\",\"ogImageDescription\":\"{seomatic.meta.seoImageDescription}\",\"twitterCard\":\"summary_large_image\",\"twitterCreator\":\"{seomatic.site.twitterHandle}\",\"twitterTitle\":\"{seomatic.meta.seoTitle}\",\"twitterSiteNamePosition\":\"\",\"twitterDescription\":\"{seomatic.meta.seoDescription}\",\"twitterImage\":\"{seomatic.meta.seoImage}\",\"twitterImageWidth\":\"{seomatic.meta.seoImageWidth}\",\"twitterImageHeight\":\"{seomatic.meta.seoImageHeight}\",\"twitterImageDescription\":\"{seomatic.meta.seoImageDescription}\"}','{\"siteName\":\"Crafty Coffee\",\"identity\":null,\"creator\":null,\"twitterHandle\":\"\",\"facebookProfileId\":\"\",\"facebookAppId\":\"\",\"googleSiteVerification\":\"\",\"bingSiteVerification\":\"\",\"pinterestSiteVerification\":\"\",\"sameAsLinks\":[],\"siteLinksSearchTarget\":\"\",\"siteLinksQueryInput\":\"\",\"additionalSitemapUrls\":[],\"additionalSitemapUrlsDateUpdated\":null,\"additionalSitemaps\":[]}','{\"sitemapUrls\":true,\"sitemapAssets\":true,\"sitemapFiles\":true,\"sitemapAltLinks\":true,\"sitemapChangeFreq\":\"weekly\",\"sitemapPriority\":0.5,\"sitemapLimit\":null,\"structureDepth\":null,\"sitemapImageFieldMap\":[{\"property\":\"title\",\"field\":\"title\"},{\"property\":\"caption\",\"field\":\"\"},{\"property\":\"geo_location\",\"field\":\"\"},{\"property\":\"license\",\"field\":\"\"}],\"sitemapVideoFieldMap\":[{\"property\":\"title\",\"field\":\"title\"},{\"property\":\"description\",\"field\":\"\"},{\"property\":\"thumbnailLoc\",\"field\":\"\"},{\"property\":\"duration\",\"field\":\"\"},{\"property\":\"category\",\"field\":\"\"}]}','{\"MetaTagContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"General Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContaineropengraph\":{\"data\":[],\"name\":\"Facebook\",\"description\":\"Facebook OpenGraph Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"opengraph\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContainertwitter\":{\"data\":[],\"name\":\"Twitter\",\"description\":\"Twitter Card Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"twitter\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContainermiscellaneous\":{\"data\":[],\"name\":\"Miscellaneous\",\"description\":\"Miscellaneous Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"miscellaneous\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaLinkContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"Link Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaLinkContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaScriptContainergeneral\":{\"data\":[],\"position\":1,\"name\":\"General\",\"description\":\"Script Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaScriptContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaJsonLdContainergeneral\":{\"data\":{\"mainEntityOfPage\":{\"breadcrumb\":null,\"lastReviewed\":null,\"mainContentOfPage\":null,\"primaryImageOfPage\":null,\"relatedLink\":null,\"reviewedBy\":null,\"significantLink\":null,\"speakable\":null,\"specialty\":null,\"about\":null,\"accessMode\":null,\"accessModeSufficient\":null,\"accessibilityAPI\":null,\"accessibilityControl\":null,\"accessibilityFeature\":null,\"accessibilityHazard\":null,\"accessibilitySummary\":null,\"accountablePerson\":null,\"aggregateRating\":null,\"alternativeHeadline\":null,\"associatedMedia\":null,\"audience\":null,\"audio\":null,\"author\":{\"id\":\"{seomatic.site.identity.genericUrl}#identity\"},\"award\":null,\"character\":null,\"citation\":null,\"comment\":null,\"commentCount\":null,\"contentLocation\":null,\"contentRating\":null,\"contentReferenceTime\":null,\"contributor\":null,\"copyrightHolder\":{\"id\":\"{seomatic.site.identity.genericUrl}#identity\"},\"copyrightYear\":\"{entry.postDate | date(\\\"Y\\\")}\",\"correction\":null,\"creator\":{\"id\":\"{seomatic.site.identity.genericUrl}#creator\"},\"dateCreated\":false,\"dateModified\":\"{entry.dateUpdated |atom}\",\"datePublished\":\"{entry.postDate |atom}\",\"discussionUrl\":null,\"editor\":null,\"educationalAlignment\":null,\"educationalUse\":null,\"encoding\":null,\"encodingFormat\":null,\"exampleOfWork\":null,\"expires\":null,\"funder\":null,\"genre\":null,\"hasPart\":null,\"headline\":\"{seomatic.meta.seoTitle}\",\"inLanguage\":\"{seomatic.meta.language}\",\"interactionStatistic\":null,\"interactivityType\":null,\"isAccessibleForFree\":null,\"isBasedOn\":null,\"isFamilyFriendly\":null,\"isPartOf\":null,\"keywords\":null,\"learningResourceType\":null,\"license\":null,\"locationCreated\":null,\"mainEntity\":null,\"material\":null,\"materialExtent\":null,\"mentions\":null,\"offers\":null,\"position\":null,\"producer\":null,\"provider\":null,\"publication\":null,\"publisher\":{\"id\":\"{seomatic.site.identity.genericUrl}#creator\"},\"publisherImprint\":null,\"publishingPrinciples\":null,\"recordedAt\":null,\"releasedEvent\":null,\"review\":null,\"schemaVersion\":null,\"sdDatePublished\":null,\"sdLicense\":null,\"sdPublisher\":null,\"sourceOrganization\":null,\"spatial\":null,\"spatialCoverage\":null,\"sponsor\":null,\"temporal\":null,\"temporalCoverage\":null,\"text\":null,\"thumbnailUrl\":null,\"timeRequired\":null,\"translationOfWork\":null,\"translator\":null,\"typicalAgeRange\":null,\"version\":null,\"video\":null,\"workExample\":null,\"workTranslation\":null,\"additionalType\":null,\"alternateName\":null,\"description\":\"{seomatic.meta.seoDescription}\",\"disambiguatingDescription\":null,\"identifier\":null,\"image\":{\"type\":\"ImageObject\",\"url\":\"{seomatic.meta.seoImage}\"},\"mainEntityOfPage\":\"{seomatic.meta.canonicalUrl}\",\"name\":\"{seomatic.meta.seoTitle}\",\"potentialAction\":{\"type\":\"SearchAction\",\"target\":\"{seomatic.site.siteLinksSearchTarget}\",\"query-input\":\"{seomatic.helper.siteLinksQueryInput()}\"},\"sameAs\":null,\"subjectOf\":null,\"url\":\"{seomatic.meta.canonicalUrl}\",\"context\":\"http://schema.org\",\"type\":\"{seomatic.meta.mainEntityOfPage}\",\"id\":null,\"graph\":null,\"include\":true,\"key\":\"mainEntityOfPage\",\"environment\":null,\"dependencies\":null}},\"name\":\"General\",\"description\":\"JsonLd Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaJsonLdContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTitleContainergeneral\":{\"data\":{\"title\":{\"title\":\"{seomatic.meta.seoTitle}\",\"siteName\":\"{seomatic.site.siteName}\",\"siteNamePosition\":\"{seomatic.meta.siteNamePosition}\",\"separatorChar\":\"{seomatic.config.separatorChar}\",\"include\":true,\"key\":\"title\",\"environment\":null,\"dependencies\":null}},\"name\":\"General\",\"description\":\"Meta Title Tag\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTitleContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false}}','[]','{\"data\":[],\"name\":null,\"description\":null,\"class\":\"nystudio107\\\\seomatic\\\\models\\\\FrontendTemplateContainer\",\"handle\":null,\"include\":true,\"dependencies\":null,\"clearCache\":false}','{\"siteType\":\"CreativeWork\",\"siteSubType\":\"WebPage\",\"siteSpecificType\":\"\",\"seoTitleSource\":\"fromField\",\"seoTitleField\":\"title\",\"siteNamePositionSource\":\"sameAsGlobal\",\"seoDescriptionSource\":\"fromCustom\",\"seoDescriptionField\":\"\",\"seoKeywordsSource\":\"fromCustom\",\"seoKeywordsField\":\"\",\"seoImageIds\":[],\"seoImageSource\":\"fromAsset\",\"seoImageField\":\"\",\"seoImageTransform\":true,\"seoImageTransformMode\":\"crop\",\"seoImageDescriptionSource\":\"fromCustom\",\"seoImageDescriptionField\":\"\",\"twitterCreatorSource\":\"sameAsSite\",\"twitterCreatorField\":\"\",\"twitterTitleSource\":\"sameAsSeo\",\"twitterTitleField\":\"\",\"twitterSiteNamePositionSource\":\"sameAsGlobal\",\"twitterDescriptionSource\":\"sameAsSeo\",\"twitterDescriptionField\":\"\",\"twitterImageIds\":[],\"twitterImageSource\":\"sameAsSeo\",\"twitterImageField\":\"\",\"twitterImageTransform\":true,\"twitterImageTransformMode\":\"crop\",\"twitterImageDescriptionSource\":\"sameAsSeo\",\"twitterImageDescriptionField\":\"\",\"ogTitleSource\":\"sameAsSeo\",\"ogTitleField\":\"\",\"ogSiteNamePositionSource\":\"sameAsGlobal\",\"ogDescriptionSource\":\"sameAsSeo\",\"ogDescriptionField\":\"\",\"ogImageIds\":[],\"ogImageSource\":\"sameAsSeo\",\"ogImageField\":\"\",\"ogImageTransform\":true,\"ogImageTransformMode\":\"crop\",\"ogImageDescriptionSource\":\"sameAsSeo\",\"ogImageDescriptionField\":\"\"}'),
	(7,'2020-02-15 22:45:15','2020-02-15 23:57:34','700281df-16d3-4974-8df6-44f0fd727020','1.0.25','categorygroup',1,'Drink Styles','drinkStyles','category','styles/_entry',1,'{\"1\":{\"id\":1,\"groupId\":1,\"siteId\":1,\"hasUrls\":1,\"uriFormat\":\"styles/{slug}\",\"template\":\"styles/_entry\",\"language\":\"en-us\"}}','2020-02-15 23:57:34','{\"language\":null,\"mainEntityOfPage\":\"WebPage\",\"seoTitle\":\"{category.title}\",\"siteNamePosition\":\"\",\"seoDescription\":\"\",\"seoKeywords\":\"\",\"seoImage\":\"\",\"seoImageWidth\":\"\",\"seoImageHeight\":\"\",\"seoImageDescription\":\"\",\"canonicalUrl\":\"{category.url}\",\"robots\":\"all\",\"ogType\":\"website\",\"ogTitle\":\"{seomatic.meta.seoTitle}\",\"ogSiteNamePosition\":\"\",\"ogDescription\":\"{seomatic.meta.seoDescription}\",\"ogImage\":\"{seomatic.meta.seoImage}\",\"ogImageWidth\":\"{seomatic.meta.seoImageWidth}\",\"ogImageHeight\":\"{seomatic.meta.seoImageHeight}\",\"ogImageDescription\":\"{seomatic.meta.seoImageDescription}\",\"twitterCard\":\"summary_large_image\",\"twitterCreator\":\"{seomatic.site.twitterHandle}\",\"twitterTitle\":\"{seomatic.meta.seoTitle}\",\"twitterSiteNamePosition\":\"\",\"twitterDescription\":\"{seomatic.meta.seoDescription}\",\"twitterImage\":\"{seomatic.meta.seoImage}\",\"twitterImageWidth\":\"{seomatic.meta.seoImageWidth}\",\"twitterImageHeight\":\"{seomatic.meta.seoImageHeight}\",\"twitterImageDescription\":\"{seomatic.meta.seoImageDescription}\"}','{\"siteName\":\"Crafty Coffee\",\"identity\":null,\"creator\":null,\"twitterHandle\":\"\",\"facebookProfileId\":\"\",\"facebookAppId\":\"\",\"googleSiteVerification\":\"\",\"bingSiteVerification\":\"\",\"pinterestSiteVerification\":\"\",\"sameAsLinks\":[],\"siteLinksSearchTarget\":\"\",\"siteLinksQueryInput\":\"\",\"additionalSitemapUrls\":[],\"additionalSitemapUrlsDateUpdated\":null,\"additionalSitemaps\":[]}','{\"sitemapUrls\":true,\"sitemapAssets\":true,\"sitemapFiles\":true,\"sitemapAltLinks\":true,\"sitemapChangeFreq\":\"weekly\",\"sitemapPriority\":0.5,\"sitemapLimit\":null,\"structureDepth\":null,\"sitemapImageFieldMap\":[{\"property\":\"title\",\"field\":\"title\"},{\"property\":\"caption\",\"field\":\"\"},{\"property\":\"geo_location\",\"field\":\"\"},{\"property\":\"license\",\"field\":\"\"}],\"sitemapVideoFieldMap\":[{\"property\":\"title\",\"field\":\"title\"},{\"property\":\"description\",\"field\":\"\"},{\"property\":\"thumbnailLoc\",\"field\":\"\"},{\"property\":\"duration\",\"field\":\"\"},{\"property\":\"category\",\"field\":\"\"}]}','{\"MetaTagContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"General Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContaineropengraph\":{\"data\":[],\"name\":\"Facebook\",\"description\":\"Facebook OpenGraph Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"opengraph\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContainertwitter\":{\"data\":[],\"name\":\"Twitter\",\"description\":\"Twitter Card Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"twitter\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContainermiscellaneous\":{\"data\":[],\"name\":\"Miscellaneous\",\"description\":\"Miscellaneous Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"miscellaneous\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaLinkContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"Link Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaLinkContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaScriptContainergeneral\":{\"data\":[],\"position\":1,\"name\":\"General\",\"description\":\"Script Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaScriptContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaJsonLdContainergeneral\":{\"data\":{\"mainEntityOfPage\":{\"breadcrumb\":null,\"lastReviewed\":null,\"mainContentOfPage\":null,\"primaryImageOfPage\":null,\"relatedLink\":null,\"reviewedBy\":null,\"significantLink\":null,\"speakable\":null,\"specialty\":null,\"about\":null,\"accessMode\":null,\"accessModeSufficient\":null,\"accessibilityAPI\":null,\"accessibilityControl\":null,\"accessibilityFeature\":null,\"accessibilityHazard\":null,\"accessibilitySummary\":null,\"accountablePerson\":null,\"aggregateRating\":null,\"alternativeHeadline\":null,\"associatedMedia\":null,\"audience\":null,\"audio\":null,\"author\":{\"id\":\"{seomatic.site.identity.genericUrl}#identity\"},\"award\":null,\"character\":null,\"citation\":null,\"comment\":null,\"commentCount\":null,\"contentLocation\":null,\"contentRating\":null,\"contentReferenceTime\":null,\"contributor\":null,\"copyrightHolder\":{\"id\":\"{seomatic.site.identity.genericUrl}#identity\"},\"copyrightYear\":\"{category.postDate |date(\\\"Y\\\")}\",\"correction\":null,\"creator\":{\"id\":\"{seomatic.site.identity.genericUrl}#creator\"},\"dateCreated\":false,\"dateModified\":\"{category.dateUpdated |atom}\",\"datePublished\":\"{category.postDate |atom}\",\"discussionUrl\":null,\"editor\":null,\"educationalAlignment\":null,\"educationalUse\":null,\"encoding\":null,\"encodingFormat\":null,\"exampleOfWork\":null,\"expires\":null,\"funder\":null,\"genre\":null,\"hasPart\":null,\"headline\":\"{seomatic.meta.seoTitle}\",\"inLanguage\":\"{seomatic.meta.language}\",\"interactionStatistic\":null,\"interactivityType\":null,\"isAccessibleForFree\":null,\"isBasedOn\":null,\"isFamilyFriendly\":null,\"isPartOf\":null,\"keywords\":null,\"learningResourceType\":null,\"license\":null,\"locationCreated\":null,\"mainEntity\":null,\"material\":null,\"materialExtent\":null,\"mentions\":null,\"offers\":null,\"position\":null,\"producer\":null,\"provider\":null,\"publication\":null,\"publisher\":{\"id\":\"{seomatic.site.identity.genericUrl}#creator\"},\"publisherImprint\":null,\"publishingPrinciples\":null,\"recordedAt\":null,\"releasedEvent\":null,\"review\":null,\"schemaVersion\":null,\"sdDatePublished\":null,\"sdLicense\":null,\"sdPublisher\":null,\"sourceOrganization\":null,\"spatial\":null,\"spatialCoverage\":null,\"sponsor\":null,\"temporal\":null,\"temporalCoverage\":null,\"text\":null,\"thumbnailUrl\":null,\"timeRequired\":null,\"translationOfWork\":null,\"translator\":null,\"typicalAgeRange\":null,\"version\":null,\"video\":null,\"workExample\":null,\"workTranslation\":null,\"additionalType\":null,\"alternateName\":null,\"description\":\"{seomatic.meta.seoDescription}\",\"disambiguatingDescription\":null,\"identifier\":null,\"image\":{\"type\":\"ImageObject\",\"url\":\"{seomatic.meta.seoImage}\"},\"mainEntityOfPage\":\"{seomatic.meta.canonicalUrl}\",\"name\":\"{seomatic.meta.seoTitle}\",\"potentialAction\":{\"type\":\"SearchAction\",\"target\":\"{seomatic.site.siteLinksSearchTarget}\",\"query-input\":\"{seomatic.helper.siteLinksQueryInput()}\"},\"sameAs\":null,\"subjectOf\":null,\"url\":\"{seomatic.meta.canonicalUrl}\",\"context\":\"http://schema.org\",\"type\":\"{seomatic.meta.mainEntityOfPage}\",\"id\":null,\"graph\":null,\"include\":true,\"key\":\"mainEntityOfPage\",\"environment\":null,\"dependencies\":null}},\"name\":\"General\",\"description\":\"JsonLd Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaJsonLdContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTitleContainergeneral\":{\"data\":{\"title\":{\"title\":\"{seomatic.meta.seoTitle}\",\"siteName\":\"{seomatic.site.siteName}\",\"siteNamePosition\":\"{seomatic.meta.siteNamePosition}\",\"separatorChar\":\"{seomatic.config.separatorChar}\",\"include\":true,\"key\":\"title\",\"environment\":null,\"dependencies\":null}},\"name\":\"General\",\"description\":\"Meta Title Tag\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTitleContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false}}','[]','{\"data\":[],\"name\":null,\"description\":null,\"class\":\"nystudio107\\\\seomatic\\\\models\\\\FrontendTemplateContainer\",\"handle\":null,\"include\":true,\"dependencies\":null,\"clearCache\":false}','{\"siteType\":\"CreativeWork\",\"siteSubType\":\"WebPage\",\"siteSpecificType\":\"\",\"seoTitleSource\":\"fromField\",\"seoTitleField\":\"title\",\"siteNamePositionSource\":\"sameAsGlobal\",\"seoDescriptionSource\":\"fromCustom\",\"seoDescriptionField\":\"\",\"seoKeywordsSource\":\"fromCustom\",\"seoKeywordsField\":\"\",\"seoImageIds\":[],\"seoImageSource\":\"fromAsset\",\"seoImageField\":\"\",\"seoImageTransform\":true,\"seoImageTransformMode\":\"crop\",\"seoImageDescriptionSource\":\"fromCustom\",\"seoImageDescriptionField\":\"\",\"twitterCreatorSource\":\"sameAsSite\",\"twitterCreatorField\":\"\",\"twitterTitleSource\":\"sameAsSeo\",\"twitterTitleField\":\"\",\"twitterSiteNamePositionSource\":\"sameAsGlobal\",\"twitterDescriptionSource\":\"sameAsSeo\",\"twitterDescriptionField\":\"\",\"twitterImageIds\":[],\"twitterImageSource\":\"sameAsSeo\",\"twitterImageField\":\"\",\"twitterImageTransform\":true,\"twitterImageTransformMode\":\"crop\",\"twitterImageDescriptionSource\":\"sameAsSeo\",\"twitterImageDescriptionField\":\"\",\"ogTitleSource\":\"sameAsSeo\",\"ogTitleField\":\"\",\"ogSiteNamePositionSource\":\"sameAsGlobal\",\"ogDescriptionSource\":\"sameAsSeo\",\"ogDescriptionField\":\"\",\"ogImageIds\":[],\"ogImageSource\":\"sameAsSeo\",\"ogImageField\":\"\",\"ogImageTransform\":true,\"ogImageTransformMode\":\"crop\",\"ogImageDescriptionSource\":\"sameAsSeo\",\"ogImageDescriptionField\":\"\"}');

/*!40000 ALTER TABLE `seomatic_metabundles` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sequences
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sequences`;

CREATE TABLE `sequences` (
  `name` varchar(255) NOT NULL,
  `next` int(11) unsigned NOT NULL DEFAULT 1,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table sessions
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sessions`;

CREATE TABLE `sessions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `token` char(100) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `sessions_uid_idx` (`uid`),
  KEY `sessions_token_idx` (`token`),
  KEY `sessions_dateUpdated_idx` (`dateUpdated`),
  KEY `sessions_userId_idx` (`userId`),
  CONSTRAINT `sessions_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table shunnedmessages
# ------------------------------------------------------------

DROP TABLE IF EXISTS `shunnedmessages`;

CREATE TABLE `shunnedmessages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `message` varchar(255) NOT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `shunnedmessages_userId_message_unq_idx` (`userId`,`message`),
  CONSTRAINT `shunnedmessages_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table sitegroups
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sitegroups`;

CREATE TABLE `sitegroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `sitegroups_name_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `sitegroups` WRITE;
/*!40000 ALTER TABLE `sitegroups` DISABLE KEYS */;

INSERT INTO `sitegroups` (`id`, `name`, `dateCreated`, `dateUpdated`, `dateDeleted`, `uid`)
VALUES
	(1,'Crafty Coffee','2020-02-01 17:54:17','2020-02-01 17:54:17',NULL,'7675e13b-31b4-40d1-8025-a37fd35fb97f');

/*!40000 ALTER TABLE `sitegroups` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sites
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sites`;

CREATE TABLE `sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `primary` tinyint(1) NOT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `language` varchar(12) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT 0,
  `baseUrl` varchar(255) DEFAULT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `sites_dateDeleted_idx` (`dateDeleted`),
  KEY `sites_handle_idx` (`handle`),
  KEY `sites_sortOrder_idx` (`sortOrder`),
  KEY `sites_groupId_fk` (`groupId`),
  CONSTRAINT `sites_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `sitegroups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `sites` WRITE;
/*!40000 ALTER TABLE `sites` DISABLE KEYS */;

INSERT INTO `sites` (`id`, `groupId`, `primary`, `name`, `handle`, `language`, `hasUrls`, `baseUrl`, `sortOrder`, `dateCreated`, `dateUpdated`, `dateDeleted`, `uid`)
VALUES
	(1,1,1,'Crafty Coffee','default','en-US',1,'$DEFAULT_SITE_URL',1,'2020-02-01 17:54:17','2020-02-01 17:54:17',NULL,'b34dff01-1c91-4de4-ab83-84610f1405d7');

/*!40000 ALTER TABLE `sites` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table structureelements
# ------------------------------------------------------------

DROP TABLE IF EXISTS `structureelements`;

CREATE TABLE `structureelements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) NOT NULL,
  `elementId` int(11) DEFAULT NULL,
  `root` int(11) unsigned DEFAULT NULL,
  `lft` int(11) unsigned NOT NULL,
  `rgt` int(11) unsigned NOT NULL,
  `level` smallint(6) unsigned NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `structureelements_structureId_elementId_unq_idx` (`structureId`,`elementId`),
  KEY `structureelements_root_idx` (`root`),
  KEY `structureelements_lft_idx` (`lft`),
  KEY `structureelements_rgt_idx` (`rgt`),
  KEY `structureelements_level_idx` (`level`),
  KEY `structureelements_elementId_idx` (`elementId`),
  CONSTRAINT `structureelements_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `structureelements_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `structures` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `structureelements` WRITE;
/*!40000 ALTER TABLE `structureelements` DISABLE KEYS */;

INSERT INTO `structureelements` (`id`, `structureId`, `elementId`, `root`, `lft`, `rgt`, `level`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,1,NULL,1,1,24,0,'2020-02-09 19:19:31','2020-02-15 20:57:06','25fb879a-096a-42b7-a005-87ddb764898c'),
	(3,1,22,1,2,19,1,'2020-02-09 19:19:47','2020-02-15 20:57:06','82eba3cd-6d3a-452d-809c-46f5a4770aef'),
	(4,1,23,1,20,21,1,'2020-02-09 19:19:47','2020-02-15 20:57:06','f52ceab6-26de-48d7-bc1c-f74cf7a93a46'),
	(6,1,25,1,3,10,2,'2020-02-09 19:20:02','2020-02-15 20:57:06','3a908d53-b980-4a7d-a830-e1fa536b2a28'),
	(7,1,26,1,11,12,2,'2020-02-09 19:20:02','2020-02-15 20:57:06','cc64ccdd-6465-4fa7-a45c-ecb542d7e846'),
	(9,1,28,1,4,5,3,'2020-02-09 19:20:16','2020-02-09 19:20:17','074715bd-0055-4c47-bbb3-a36aad662767'),
	(10,1,29,1,6,7,3,'2020-02-09 19:20:17','2020-02-09 19:20:17','5de1a752-ba3e-428e-a704-bcaeee1ff25d'),
	(12,1,31,1,13,14,2,'2020-02-09 19:20:37','2020-02-15 20:57:06','402635b1-1ce6-46a1-8c02-4c992ec50846'),
	(13,1,32,1,15,16,2,'2020-02-09 19:20:37','2020-02-15 20:57:06','19702c0d-d34d-41e8-a8b5-bc2c00332ab1'),
	(14,1,33,1,22,23,1,'2020-02-09 20:14:18','2020-02-15 20:57:06','492bdf33-9226-4f5a-9c3c-b94c2c90a70f'),
	(15,1,41,1,17,18,2,'2020-02-15 20:21:35','2020-02-15 20:57:06','cf08583b-1da2-4098-bac5-1fe9020d0bd6'),
	(16,1,42,1,8,9,3,'2020-02-15 20:57:06','2020-02-15 20:57:06','45dbb370-5e26-4b5b-8364-b411b6375492'),
	(17,2,NULL,17,1,6,0,'2020-02-15 22:47:46','2020-02-15 23:57:34','76391c2d-eff7-4f82-a978-9df7fe435b12'),
	(18,2,451,17,2,3,1,'2020-02-15 22:47:46','2020-02-15 22:47:46','43e9089b-4d0d-4c5c-bef7-d5c4d0c653a4'),
	(19,2,467,17,4,5,1,'2020-02-15 23:57:34','2020-02-15 23:57:34','d2194a32-f65e-4e59-915d-cd9171b78eb0');

/*!40000 ALTER TABLE `structureelements` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table structures
# ------------------------------------------------------------

DROP TABLE IF EXISTS `structures`;

CREATE TABLE `structures` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `maxLevels` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `structures_dateDeleted_idx` (`dateDeleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `structures` WRITE;
/*!40000 ALTER TABLE `structures` DISABLE KEYS */;

INSERT INTO `structures` (`id`, `maxLevels`, `dateCreated`, `dateUpdated`, `dateDeleted`, `uid`)
VALUES
	(1,NULL,'2020-02-09 19:19:20','2020-02-09 19:19:20',NULL,'e5368fac-d7e4-4660-a5f6-2f726467f4d5'),
	(2,5,'2020-02-15 22:45:15','2020-02-15 22:45:15',NULL,'7af3f7b7-0804-4bf7-9c3e-824031b4214b');

/*!40000 ALTER TABLE `structures` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table systemmessages
# ------------------------------------------------------------

DROP TABLE IF EXISTS `systemmessages`;

CREATE TABLE `systemmessages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `language` varchar(255) NOT NULL,
  `key` varchar(255) NOT NULL,
  `subject` text NOT NULL,
  `body` text NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `systemmessages_key_language_unq_idx` (`key`,`language`),
  KEY `systemmessages_language_idx` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table taggroups
# ------------------------------------------------------------

DROP TABLE IF EXISTS `taggroups`;

CREATE TABLE `taggroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `taggroups_name_idx` (`name`),
  KEY `taggroups_handle_idx` (`handle`),
  KEY `taggroups_dateDeleted_idx` (`dateDeleted`),
  KEY `taggroups_fieldLayoutId_fk` (`fieldLayoutId`),
  CONSTRAINT `taggroups_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table tags
# ------------------------------------------------------------

DROP TABLE IF EXISTS `tags`;

CREATE TABLE `tags` (
  `id` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `deletedWithGroup` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `tags_groupId_idx` (`groupId`),
  CONSTRAINT `tags_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `taggroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `tags_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table templatecacheelements
# ------------------------------------------------------------

DROP TABLE IF EXISTS `templatecacheelements`;

CREATE TABLE `templatecacheelements` (
  `cacheId` int(11) NOT NULL,
  `elementId` int(11) NOT NULL,
  KEY `templatecacheelements_cacheId_idx` (`cacheId`),
  KEY `templatecacheelements_elementId_idx` (`elementId`),
  CONSTRAINT `templatecacheelements_cacheId_fk` FOREIGN KEY (`cacheId`) REFERENCES `templatecaches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `templatecacheelements_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table templatecachequeries
# ------------------------------------------------------------

DROP TABLE IF EXISTS `templatecachequeries`;

CREATE TABLE `templatecachequeries` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cacheId` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `query` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `templatecachequeries_cacheId_idx` (`cacheId`),
  KEY `templatecachequeries_type_idx` (`type`),
  CONSTRAINT `templatecachequeries_cacheId_fk` FOREIGN KEY (`cacheId`) REFERENCES `templatecaches` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table templatecaches
# ------------------------------------------------------------

DROP TABLE IF EXISTS `templatecaches`;

CREATE TABLE `templatecaches` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `siteId` int(11) NOT NULL,
  `cacheKey` varchar(255) NOT NULL,
  `path` varchar(255) DEFAULT NULL,
  `expiryDate` datetime NOT NULL,
  `body` mediumtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `templatecaches_cacheKey_siteId_expiryDate_path_idx` (`cacheKey`,`siteId`,`expiryDate`,`path`),
  KEY `templatecaches_cacheKey_siteId_expiryDate_idx` (`cacheKey`,`siteId`,`expiryDate`),
  KEY `templatecaches_siteId_idx` (`siteId`),
  CONSTRAINT `templatecaches_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table tokens
# ------------------------------------------------------------

DROP TABLE IF EXISTS `tokens`;

CREATE TABLE `tokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `token` char(32) NOT NULL,
  `route` text DEFAULT NULL,
  `usageLimit` tinyint(3) unsigned DEFAULT NULL,
  `usageCount` tinyint(3) unsigned DEFAULT NULL,
  `expiryDate` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `tokens_token_unq_idx` (`token`),
  KEY `tokens_expiryDate_idx` (`expiryDate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `tokens` WRITE;
/*!40000 ALTER TABLE `tokens` DISABLE KEYS */;

INSERT INTO `tokens` (`id`, `token`, `route`, `usageLimit`, `usageCount`, `expiryDate`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,'uxT6HKI26ZVl8uiisOoBGWYuasXGL80g','[\"preview/preview\",{\"elementType\":\"craft\\\\elements\\\\Entry\",\"sourceId\":381,\"siteId\":1,\"draftId\":13,\"revisionId\":null}]',NULL,NULL,'2020-02-16 22:13:39','2020-02-15 22:13:39','2020-02-15 22:13:39','57e26c32-1a55-4247-a30a-a735f82cac7a');

/*!40000 ALTER TABLE `tokens` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table usergroups
# ------------------------------------------------------------

DROP TABLE IF EXISTS `usergroups`;

CREATE TABLE `usergroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `usergroups_handle_unq_idx` (`handle`),
  UNIQUE KEY `usergroups_name_unq_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table usergroups_users
# ------------------------------------------------------------

DROP TABLE IF EXISTS `usergroups_users`;

CREATE TABLE `usergroups_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `usergroups_users_groupId_userId_unq_idx` (`groupId`,`userId`),
  KEY `usergroups_users_userId_idx` (`userId`),
  CONSTRAINT `usergroups_users_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `usergroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `usergroups_users_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table userpermissions
# ------------------------------------------------------------

DROP TABLE IF EXISTS `userpermissions`;

CREATE TABLE `userpermissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `userpermissions_name_unq_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table userpermissions_usergroups
# ------------------------------------------------------------

DROP TABLE IF EXISTS `userpermissions_usergroups`;

CREATE TABLE `userpermissions_usergroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `permissionId` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `userpermissions_usergroups_permissionId_groupId_unq_idx` (`permissionId`,`groupId`),
  KEY `userpermissions_usergroups_groupId_idx` (`groupId`),
  CONSTRAINT `userpermissions_usergroups_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `usergroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `userpermissions_usergroups_permissionId_fk` FOREIGN KEY (`permissionId`) REFERENCES `userpermissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table userpermissions_users
# ------------------------------------------------------------

DROP TABLE IF EXISTS `userpermissions_users`;

CREATE TABLE `userpermissions_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `permissionId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `userpermissions_users_permissionId_userId_unq_idx` (`permissionId`,`userId`),
  KEY `userpermissions_users_userId_idx` (`userId`),
  CONSTRAINT `userpermissions_users_permissionId_fk` FOREIGN KEY (`permissionId`) REFERENCES `userpermissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `userpermissions_users_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table userpreferences
# ------------------------------------------------------------

DROP TABLE IF EXISTS `userpreferences`;

CREATE TABLE `userpreferences` (
  `userId` int(11) NOT NULL AUTO_INCREMENT,
  `preferences` text DEFAULT NULL,
  PRIMARY KEY (`userId`),
  CONSTRAINT `userpreferences_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `userpreferences` WRITE;
/*!40000 ALTER TABLE `userpreferences` DISABLE KEYS */;

INSERT INTO `userpreferences` (`userId`, `preferences`)
VALUES
	(1,'{\"language\":\"en-US\",\"weekStartDay\":\"1\",\"enableDebugToolbarForSite\":true,\"enableDebugToolbarForCp\":true,\"showExceptionView\":false,\"profileTemplates\":true}');

/*!40000 ALTER TABLE `userpreferences` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table users
# ------------------------------------------------------------

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `photoId` int(11) DEFAULT NULL,
  `firstName` varchar(100) DEFAULT NULL,
  `lastName` varchar(100) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `admin` tinyint(1) NOT NULL DEFAULT 0,
  `locked` tinyint(1) NOT NULL DEFAULT 0,
  `suspended` tinyint(1) NOT NULL DEFAULT 0,
  `pending` tinyint(1) NOT NULL DEFAULT 0,
  `lastLoginDate` datetime DEFAULT NULL,
  `lastLoginAttemptIp` varchar(45) DEFAULT NULL,
  `invalidLoginWindowStart` datetime DEFAULT NULL,
  `invalidLoginCount` tinyint(3) unsigned DEFAULT NULL,
  `lastInvalidLoginDate` datetime DEFAULT NULL,
  `lockoutDate` datetime DEFAULT NULL,
  `hasDashboard` tinyint(1) NOT NULL DEFAULT 0,
  `verificationCode` varchar(255) DEFAULT NULL,
  `verificationCodeIssuedDate` datetime DEFAULT NULL,
  `unverifiedEmail` varchar(255) DEFAULT NULL,
  `passwordResetRequired` tinyint(1) NOT NULL DEFAULT 0,
  `lastPasswordChangeDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `users_uid_idx` (`uid`),
  KEY `users_verificationCode_idx` (`verificationCode`),
  KEY `users_email_idx` (`email`),
  KEY `users_username_idx` (`username`),
  KEY `users_photoId_fk` (`photoId`),
  CONSTRAINT `users_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `users_photoId_fk` FOREIGN KEY (`photoId`) REFERENCES `assets` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;

INSERT INTO `users` (`id`, `username`, `photoId`, `firstName`, `lastName`, `email`, `password`, `admin`, `locked`, `suspended`, `pending`, `lastLoginDate`, `lastLoginAttemptIp`, `invalidLoginWindowStart`, `invalidLoginCount`, `lastInvalidLoginDate`, `lockoutDate`, `hasDashboard`, `verificationCode`, `verificationCodeIssuedDate`, `unverifiedEmail`, `passwordResetRequired`, `lastPasswordChangeDate`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,'admin',NULL,'Ryan','Irelan','ryan@mijingo.com','$2y$13$JSv8YOM8pD9Wv/aCpz/zfeIjcxa3bQlK.Exa2HN0ziV0N5bRVgRTe',1,0,0,0,'2020-02-23 23:43:00',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,0,'2020-02-01 17:54:17','2020-02-01 17:54:17','2020-02-23 23:43:00','a5e7a25b-fe1c-44f3-97e9-e4e299240e73');

/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table volumefolders
# ------------------------------------------------------------

DROP TABLE IF EXISTS `volumefolders`;

CREATE TABLE `volumefolders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parentId` int(11) DEFAULT NULL,
  `volumeId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `path` varchar(255) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `volumefolders_name_parentId_volumeId_unq_idx` (`name`,`parentId`,`volumeId`),
  KEY `volumefolders_parentId_idx` (`parentId`),
  KEY `volumefolders_volumeId_idx` (`volumeId`),
  CONSTRAINT `volumefolders_parentId_fk` FOREIGN KEY (`parentId`) REFERENCES `volumefolders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `volumefolders_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `volumefolders` WRITE;
/*!40000 ALTER TABLE `volumefolders` DISABLE KEYS */;

INSERT INTO `volumefolders` (`id`, `parentId`, `volumeId`, `name`, `path`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,NULL,1,'Drinks','','2020-02-09 17:49:39','2020-02-09 17:49:39','688531f8-a772-4471-ad28-b1c30ef95023'),
	(2,NULL,NULL,'Temporary source',NULL,'2020-02-09 17:50:43','2020-02-09 17:50:43','670ba7ee-901e-4fde-99a0-5cdcba4059d9'),
	(3,2,NULL,'user_1','user_1/','2020-02-09 17:50:43','2020-02-09 17:50:43','2a7c0775-18de-4c78-8386-a6f44f32d9d5');

/*!40000 ALTER TABLE `volumefolders` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table volumes
# ------------------------------------------------------------

DROP TABLE IF EXISTS `volumes`;

CREATE TABLE `volumes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT 1,
  `url` varchar(255) DEFAULT NULL,
  `settings` text DEFAULT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `volumes_name_idx` (`name`),
  KEY `volumes_handle_idx` (`handle`),
  KEY `volumes_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `volumes_dateDeleted_idx` (`dateDeleted`),
  CONSTRAINT `volumes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `volumes` WRITE;
/*!40000 ALTER TABLE `volumes` DISABLE KEYS */;

INSERT INTO `volumes` (`id`, `fieldLayoutId`, `name`, `handle`, `type`, `hasUrls`, `url`, `settings`, `sortOrder`, `dateCreated`, `dateUpdated`, `dateDeleted`, `uid`)
VALUES
	(1,NULL,'Drinks','drinks','craft\\volumes\\Local',1,'@web/images/uploads/drinks','{\"path\":\"@webroot/images/uploads/drinks\"}',1,'2020-02-09 17:49:39','2020-02-09 17:49:39',NULL,'679feb39-d56f-43cf-9b9a-5c4009fa2324');

/*!40000 ALTER TABLE `volumes` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table widgets
# ------------------------------------------------------------

DROP TABLE IF EXISTS `widgets`;

CREATE TABLE `widgets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `colspan` tinyint(3) DEFAULT NULL,
  `settings` text DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT 1,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `widgets_userId_idx` (`userId`),
  CONSTRAINT `widgets_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `widgets` WRITE;
/*!40000 ALTER TABLE `widgets` DISABLE KEYS */;

INSERT INTO `widgets` (`id`, `userId`, `type`, `sortOrder`, `colspan`, `settings`, `enabled`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(2,1,'craft\\widgets\\CraftSupport',2,2,'[]',1,'2020-02-01 17:54:19','2020-02-01 18:02:34','71e07798-c335-4f68-b199-168a2a0bb805'),
	(3,1,'craft\\widgets\\Updates',3,2,'[]',1,'2020-02-01 17:54:19','2020-02-01 18:02:42','92b94b6d-1844-46ed-9ec2-09b315908d74'),
	(4,1,'craft\\widgets\\Feed',4,2,'{\"url\":\"https://craftcms.com/news.rss\",\"title\":\"Craft News\",\"limit\":5}',1,'2020-02-01 17:54:19','2020-02-01 18:02:45','4f2564ec-7932-44d7-b560-c30c016452d7'),
	(5,1,'craft\\widgets\\NewUsers',5,3,'{\"userGroupId\":null,\"dateRange\":\"d7\"}',1,'2020-02-01 18:02:13','2020-02-01 18:02:41','fd80d4e4-91e2-43ea-8ade-a3eec48c5880'),
	(6,1,'craft\\widgets\\RecentEntries',6,4,'{\"section\":\"*\",\"siteId\":\"1\",\"limit\":\"10\"}',1,'2020-02-01 18:02:19','2020-02-01 18:02:43','12a70f04-10d3-44bd-95bc-5268a4bde642');

/*!40000 ALTER TABLE `widgets` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
