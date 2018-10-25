# ************************************************************
# Sequel Pro SQL dump
# Version 4541
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: 127.0.0.1 (MySQL 5.7.22)
# Database: craftycoffee
# Generation Time: 2018-10-25 20:55:12 +0000
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
  `uri` text,
  `size` bigint(20) unsigned DEFAULT NULL,
  `timestamp` datetime DEFAULT NULL,
  `recordId` int(11) DEFAULT NULL,
  `inProgress` tinyint(1) DEFAULT '0',
  `completed` tinyint(1) DEFAULT '0',
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
  `filename` varchar(255) NOT NULL,
  `kind` varchar(50) NOT NULL DEFAULT 'unknown',
  `width` int(11) unsigned DEFAULT NULL,
  `height` int(11) unsigned DEFAULT NULL,
  `size` bigint(20) unsigned DEFAULT NULL,
  `focalPoint` varchar(13) DEFAULT NULL,
  `dateModified` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `assets_filename_folderId_unq_idx` (`filename`,`folderId`),
  KEY `assets_folderId_idx` (`folderId`),
  KEY `assets_volumeId_idx` (`volumeId`),
  CONSTRAINT `assets_folderId_fk` FOREIGN KEY (`folderId`) REFERENCES `volumefolders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `assets_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `assets_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `assets` WRITE;
/*!40000 ALTER TABLE `assets` DISABLE KEYS */;

INSERT INTO `assets` (`id`, `volumeId`, `folderId`, `filename`, `kind`, `width`, `height`, `size`, `focalPoint`, `dateModified`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(6,1,1,'espresso-shot.jpg','image',1200,689,44556,NULL,'2017-12-29 22:42:22','2017-12-29 22:42:22','2018-02-13 17:47:01','49bed849-c8e6-4f90-82ac-62f00943d899'),
	(11,1,1,'iced-coffee.jpg','image',1200,971,71819,NULL,'2018-01-02 17:41:40','2018-01-02 17:41:40','2018-02-13 17:47:01','e701589c-0b96-48d5-af56-5f050d8a5348');

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
  `fileExists` tinyint(1) NOT NULL DEFAULT '0',
  `inProgress` tinyint(1) NOT NULL DEFAULT '0',
  `dateIndexed` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `assettransformindex_volumeId_assetId_location_idx` (`volumeId`,`assetId`,`location`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `assettransformindex` WRITE;
/*!40000 ALTER TABLE `assettransformindex` DISABLE KEYS */;

INSERT INTO `assettransformindex` (`id`, `assetId`, `filename`, `format`, `location`, `volumeId`, `fileExists`, `inProgress`, `dateIndexed`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,6,'espresso-shot.jpg',NULL,'_drinksHomepageThumb',1,1,0,'2018-01-02 17:39:14','2018-01-02 17:39:14','2018-01-02 17:39:14','95332ffe-28e5-4f2b-9fcc-6e51167229ea'),
	(2,11,'iced-coffee.jpg',NULL,'_drinksHomepageThumb',1,1,0,'2018-01-02 17:42:10','2018-01-02 17:42:10','2018-01-02 17:42:10','477bdf95-af26-41cd-92e8-09b752833592');

/*!40000 ALTER TABLE `assettransformindex` ENABLE KEYS */;
UNLOCK TABLES;


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
	(1,'840x200 Thumb','drinksHomepageThumb','crop','center-center',840,200,NULL,NULL,'none','2017-12-29 22:39:10','2017-12-29 22:39:10','2017-12-29 22:39:10','ca00c6ab-4c31-4a41-b7c7-5dc4da53877a');

/*!40000 ALTER TABLE `assettransforms` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table categories
# ------------------------------------------------------------

DROP TABLE IF EXISTS `categories`;

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `categories_groupId_idx` (`groupId`),
  CONSTRAINT `categories_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `categorygroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `categories_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;

INSERT INTO `categories` (`id`, `groupId`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(26,1,'2018-01-02 22:01:22','2018-02-13 17:47:01','d22b9cbe-9669-4b13-9c26-d2f7ef821383'),
	(27,1,'2018-01-02 22:03:40','2018-02-13 17:47:01','6ff0a35c-5e3e-4ec5-a7de-c06d8260c65f');

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
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `categorygroups_name_unq_idx` (`name`),
  UNIQUE KEY `categorygroups_handle_unq_idx` (`handle`),
  KEY `categorygroups_structureId_idx` (`structureId`),
  KEY `categorygroups_fieldLayoutId_idx` (`fieldLayoutId`),
  CONSTRAINT `categorygroups_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `categorygroups_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `structures` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `categorygroups` WRITE;
/*!40000 ALTER TABLE `categorygroups` DISABLE KEYS */;

INSERT INTO `categorygroups` (`id`, `structureId`, `fieldLayoutId`, `name`, `handle`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,2,12,'Drink Styles','drinkStyles','2018-01-02 21:58:37','2018-01-02 22:00:39','85aaa45b-96ee-4eeb-9170-a842e0ce42c7');

/*!40000 ALTER TABLE `categorygroups` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table categorygroups_sites
# ------------------------------------------------------------

DROP TABLE IF EXISTS `categorygroups_sites`;

CREATE TABLE `categorygroups_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '1',
  `uriFormat` text,
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
	(1,1,1,1,'styles/{slug}','styles/_category','2018-01-02 21:58:37','2018-01-02 22:00:39','b2f41a56-4f50-4596-ab13-6df4d0ba983d'),
	(2,1,2,1,'styles/{slug}','styles/_category','2018-02-09 15:28:52','2018-02-09 15:28:52','32705595-25e6-4294-b5a4-3778659fc651'),
	(3,1,3,1,'styles/{slug}','styles/_category','2018-02-13 17:47:00','2018-02-13 17:47:00','101e890f-8ca8-48ab-b7fd-7ac8c6942848');

/*!40000 ALTER TABLE `categorygroups_sites` ENABLE KEYS */;
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
  `field_drinkIntro` text,
  `field_pageCopy` text,
  `field_newsExcerpt` text,
  `field_newsBody` text,
  `field_subtitle` text,
  `field_pageIntro` text,
  `field_dateAddedToMenu` datetime DEFAULT NULL,
  `field_recipeSnapshot` text,
  `field_styleDescription` text,
  `field_siteDescription` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `content_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `content_siteId_idx` (`siteId`),
  KEY `content_title_idx` (`title`),
  CONSTRAINT `content_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `content_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `content` WRITE;
/*!40000 ALTER TABLE `content` DISABLE KEYS */;

INSERT INTO `content` (`id`, `elementId`, `siteId`, `title`, `dateCreated`, `dateUpdated`, `uid`, `field_drinkIntro`, `field_pageCopy`, `field_newsExcerpt`, `field_newsBody`, `field_subtitle`, `field_pageIntro`, `field_dateAddedToMenu`, `field_recipeSnapshot`, `field_styleDescription`, `field_siteDescription`)
VALUES
	(1,1,1,NULL,'2017-12-29 17:38:45','2018-02-07 19:36:12','5f5f320d-7981-4777-ac83-4d4ba93ec6fe',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(2,2,1,'Perfect Espresso','2017-12-29 22:10:38','2018-02-15 17:14:00','883601a5-78e4-4136-b997-e91178d99d80','This is an introduction to the Espresso drink.','<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?</p><p>At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga. Et harum quidem rerum facilis est et expedita distinctio. Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quo minus id quod maxime placeat facere possimus, omnis voluptas assumenda est, omnis dolor repellendus. Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet ut et voluptates repudiandae sint et molestiae non recusandae. Itaque earum rerum hic tenetur a sapiente delectus, ut aut reiciendis voluptatibus maiores alias consequatur aut perferendis doloribus asperiores repellat.</p>',NULL,NULL,NULL,NULL,'2017-10-01 07:00:00',NULL,NULL,NULL),
	(3,3,1,'Crafty Coffee is Open for Business','2017-12-29 22:14:23','2018-01-02 19:50:52','9358b3e0-6d68-4c25-bc80-860ab689e1f9',NULL,NULL,'If you\'re craving the best coffee in town, we\'ve got it.','<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam volup<a href=\"https://mijingo.com\">tatem quia voluptas sit aspernatur aut odit aut fugit, se</a>d quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?</p><blockquote><p>This is a fancy blockquote</p></blockquote><p>At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga. Et harum quidem rerum facilis est et expedita distinctio. Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quo minus id quod maxime placeat facere possimus, omnis voluptas assumenda est, omnis dolor repellendus. Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet ut et voluptates repudiandae sint et molestiae non recusandae. Itaque earum rerum hic tenetur a sapiente delectus, ut aut reiciendis voluptatibus maiores alias consequatur aut perferendis doloribus asperiores repellat.</p>',NULL,NULL,NULL,NULL,NULL,NULL),
	(5,5,1,'Homepage','2017-12-29 22:21:08','2018-02-09 15:45:35','582202d4-5e69-4689-bf5d-907a61f154ef',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(6,6,1,'Espresso-Shot','2017-12-29 22:42:22','2018-02-13 17:47:01','fd49c3ea-3ca7-44f9-b6a7-41a66e27b0ee',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(7,7,1,'About Crafty Coffee','2017-12-29 22:52:18','2017-12-29 23:06:04','911263b4-e84a-478f-ad95-fef639de0e72',NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?</p><p>At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga. Et harum quidem rerum facilis est et expedita distinctio. Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quo minus id quod maxime placeat facere possimus, omnis voluptas assumenda est, omnis dolor repellendus. Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet ut et voluptates repudiandae sint et molestiae non recusandae. Itaque earum rerum hic tenetur a sapiente delectus, ut aut reiciendis voluptatibus maiores alias consequatur aut perferendis doloribus asperiores repellat.</p>',NULL,NULL,'How it happened.','Everything you ever needed to know.',NULL,NULL,NULL,NULL),
	(8,8,1,'Locations','2017-12-29 22:52:28','2018-01-02 20:31:11','b7188c90-1a8b-46a2-89d7-ed240bb058ed',NULL,'<p>page copy</p>',NULL,NULL,'Where We Are','This is the intro.',NULL,NULL,NULL,NULL),
	(9,9,1,'Austin, TX','2017-12-29 22:53:01','2018-01-02 20:31:45','e480b7b9-ddd1-4e80-af56-3f52da0b482d',NULL,'<p>page copy</p>',NULL,NULL,'Home of the tacos.','Page intro',NULL,NULL,NULL,NULL),
	(10,10,1,'Founders','2017-12-29 22:58:50','2017-12-29 23:05:42','b93b1c72-8dbe-40f8-b14d-ab7477b193bf',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(11,11,1,'Iced-Coffee','2018-01-02 17:41:40','2018-02-13 17:47:01','92d04a44-c833-4b68-992f-165ecb679dd4',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(12,12,1,'Japanese Iced Coffee','2018-01-02 17:42:03','2018-02-15 17:19:26','906774e3-e811-42a0-8dec-e224a4fa6c3d','The best coffee of your life.','<p>crafty coffee</p>',NULL,NULL,NULL,NULL,'2017-06-01 07:00:00',NULL,NULL,NULL),
	(13,13,1,'Perfect Espresso','2018-01-02 21:14:07','2018-01-02 22:04:04','6826ab2b-005e-4d52-b35f-dae5b9f29aa6',NULL,NULL,NULL,NULL,NULL,'This is the page intro!',NULL,'[{\"col1\":\"This is the first thing\"},{\"col1\":\"This is the second thing\"},{\"col1\":\"This is the third thing\"}]',NULL,NULL),
	(14,26,1,'Espresso','2018-01-02 22:01:22','2018-02-13 17:47:01','a86d8ba4-20db-439c-b486-2cd36f4927aa',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'This is the style description',NULL),
	(15,27,1,'Iced Coffee','2018-01-02 22:03:40','2018-02-13 17:47:01','573da819-1805-4234-949b-59f349d78960',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'The best way to drink coffee in the summer.',NULL),
	(16,28,1,'Chapel Hill, NC','2018-01-29 20:12:51','2018-01-29 20:12:51','4034dac9-4637-4e1d-b6c5-464a2324575c',NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>',NULL,NULL,'Our newest location.','Home of the best basketball team on the planet.',NULL,NULL,NULL,NULL),
	(17,29,1,'Hamburg, Germany','2018-01-30 21:02:59','2018-01-30 21:02:59','8d67255e-7461-4b2f-80eb-4e07f1cb0678',NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>',NULL,NULL,'','',NULL,NULL,NULL,NULL),
	(18,30,1,NULL,'2018-01-30 22:07:08','2018-02-13 17:47:01','9176121d-4b45-4729-b317-c34af6ee5e7a',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'A website about coffee, how to make, how to drink, and where you can buy it.'),
	(19,11,2,'Iced-Coffee','2018-02-09 15:28:52','2018-02-13 17:47:01','743b1c8e-0100-440e-8563-eb00b9a10263',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(20,6,2,'Espresso-Shot','2018-02-09 15:28:52','2018-02-13 17:47:01','78b5a956-bb17-4e66-8b99-998d2c56e873',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(21,26,2,'Espresso','2018-02-09 15:28:52','2018-02-13 17:47:01','b720d3d9-cf4d-4abc-8e6c-ace75f0e6280',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'This is the style description',NULL),
	(22,27,2,'Iced Coffee','2018-02-09 15:28:52','2018-02-13 17:47:01','ababaa09-7430-4193-a010-5495b94a9979',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'The best way to drink coffee in the summer.',NULL),
	(23,30,2,NULL,'2018-02-09 15:28:52','2018-02-13 17:47:01','93fe4cf9-5812-48b2-93e0-eb0b12dc6bc5',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'A website about coffee, how to make, how to drink, and where you can buy it.'),
	(24,5,2,'Homepage','2018-02-09 15:29:44','2018-02-09 15:45:35','05b10769-d3be-4fda-8859-15eba3f6d6f0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(25,12,2,'Japanischer Eiskaffee','2018-02-09 15:32:05','2018-02-15 17:19:26','2f839d6f-2c38-4f1f-8719-6a29d4a058f6','Der beste Eiskaffe im Leben. DE','<p>Hier wird was geschrieben.</p>',NULL,NULL,NULL,NULL,'2017-06-01 07:00:00',NULL,NULL,NULL),
	(26,2,2,'Perfect Espresso','2018-02-09 15:32:06','2018-02-15 17:14:00','32558900-3bcb-4dbe-bdc0-2b365c52a78a','This is an introduction to the Espresso drink.','<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?</p><p>At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga. Et harum quidem rerum facilis est et expedita distinctio. Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quo minus id quod maxime placeat facere possimus, omnis voluptas assumenda est, omnis dolor repellendus. Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet ut et voluptates repudiandae sint et molestiae non recusandae. Itaque earum rerum hic tenetur a sapiente delectus, ut aut reiciendis voluptatibus maiores alias consequatur aut perferendis doloribus asperiores repellat.</p>',NULL,NULL,NULL,NULL,'2017-10-01 07:00:00',NULL,NULL,NULL),
	(27,11,3,'Iced-Coffee','2018-02-13 17:47:01','2018-02-13 17:47:01','c20a6d99-5411-4702-9c05-97767285f410',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(28,6,3,'Espresso-Shot','2018-02-13 17:47:01','2018-02-13 17:47:01','71b86e65-423c-4506-954b-3face99ecad3',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(29,26,3,'Espresso','2018-02-13 17:47:01','2018-02-13 17:47:01','2784e800-a936-4533-a816-09e4546b5dd7',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'This is the style description',NULL),
	(30,27,3,'Iced Coffee','2018-02-13 17:47:01','2018-02-13 17:47:01','eebfaa1f-1702-4314-ad90-5120bb1de876',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'The best way to drink coffee in the summer.',NULL),
	(31,30,3,NULL,'2018-02-13 17:47:01','2018-02-13 17:47:01','fc2fc032-5f27-44dc-80bf-929d75052c11',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(32,12,3,'Japanese Iced Coffee','2018-02-15 17:14:00','2018-02-15 17:19:26','53b17bd8-f14a-46e3-9f3b-c3297ccd7d0b','The best coffee of your life. Roasterei','<p>Hier wird was geschrieben.</p>',NULL,NULL,NULL,NULL,'2017-06-01 07:00:00',NULL,NULL,NULL),
	(33,2,3,'Perfect Espresso','2018-02-15 17:14:00','2018-02-15 17:14:00','24145ab9-936a-4c86-b4c8-09403e15453b','This is an introduction to the Espresso drink.','<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?</p><p>At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga. Et harum quidem rerum facilis est et expedita distinctio. Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quo minus id quod maxime placeat facere possimus, omnis voluptas assumenda est, omnis dolor repellendus. Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet ut et voluptates repudiandae sint et molestiae non recusandae. Itaque earum rerum hic tenetur a sapiente delectus, ut aut reiciendis voluptatibus maiores alias consequatur aut perferendis doloribus asperiores repellat.</p>',NULL,NULL,NULL,NULL,'2017-10-01 07:00:00',NULL,NULL,NULL);

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
  `traces` text,
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
	(3,'ElementQuery::getIterator()','/Users/ryan/training/craft-3-webinar/craftycoffee/templates/index.twig:18','2018-02-07 19:37:43','/Users/ryan/training/craft-3-webinar/craftycoffee/templates/index.twig',18,'Looping through element queries directly has been deprecated. Use the all() function to fetch the query results before looping over them.','[{\"objectClass\":\"craft\\\\services\\\\Deprecator\",\"file\":\"/Users/ryan/training/craft-3-webinar/craftycoffee/vendor/craftcms/cms/src/elements/db/ElementQuery.php\",\"line\":402,\"class\":\"craft\\\\services\\\\Deprecator\",\"method\":\"log\",\"args\":\"\\\"ElementQuery::getIterator()\\\", \\\"Looping through element queries directly has been deprecated. Us...\\\"\"},{\"objectClass\":\"craft\\\\elements\\\\db\\\\EntryQuery\",\"file\":\"/Users/ryan/training/craft-3-webinar/craftycoffee/storage/runtime/compiled_templates/7e/7ed7b2542a555658f0142c0c7a28c85a977c4a99ccbede0fb04f2384a9ea9af9.php\",\"line\":49,\"class\":\"craft\\\\elements\\\\db\\\\ElementQuery\",\"method\":\"getIterator\",\"args\":null},{\"objectClass\":\"__TwigTemplate_373dc1271d25f315f4289fbdf75e89a510778b938e39621ba7f756e96d3fde93\",\"file\":\"/Users/ryan/training/craft-3-webinar/craftycoffee/vendor/twig/twig/lib/Twig/Template.php\",\"line\":188,\"class\":\"__TwigTemplate_373dc1271d25f315f4289fbdf75e89a510778b938e39621ba7f756e96d3fde93\",\"method\":\"block_main\",\"args\":\"[\\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, \\\"SORT_DESC\\\" => 3, \\\"POS_HEAD\\\" => 1, ...], [\\\"main\\\" => [__TwigTemplate_373dc1271d25f315f4289fbdf75e89a510778b938e39621ba7f756e96d3fde93, \\\"block_main\\\"]]\"},{\"objectClass\":\"__TwigTemplate_593b7a45b45b7e2f867b40e563d0eae6b075b205c6a26d81be764be110eeb251\",\"file\":\"/Users/ryan/training/craft-3-webinar/craftycoffee/storage/runtime/compiled_templates/8e/8e70952d8ed08f16dca24875c26ea6f6a9c00e292f35879dc0f329947df65fb0.php\",\"line\":166,\"class\":\"Twig_Template\",\"method\":\"displayBlock\",\"args\":\"\\\"main\\\", [\\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, \\\"SORT_DESC\\\" => 3, \\\"POS_HEAD\\\" => 1, ...], [\\\"main\\\" => [__TwigTemplate_373dc1271d25f315f4289fbdf75e89a510778b938e39621ba7f756e96d3fde93, \\\"block_main\\\"]]\"},{\"objectClass\":\"__TwigTemplate_593b7a45b45b7e2f867b40e563d0eae6b075b205c6a26d81be764be110eeb251\",\"file\":\"/Users/ryan/training/craft-3-webinar/craftycoffee/vendor/twig/twig/lib/Twig/Template.php\",\"line\":389,\"class\":\"__TwigTemplate_593b7a45b45b7e2f867b40e563d0eae6b075b205c6a26d81be764be110eeb251\",\"method\":\"doDisplay\",\"args\":\"[\\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, \\\"SORT_DESC\\\" => 3, \\\"POS_HEAD\\\" => 1, ...], [\\\"main\\\" => [__TwigTemplate_373dc1271d25f315f4289fbdf75e89a510778b938e39621ba7f756e96d3fde93, \\\"block_main\\\"]]\"},{\"objectClass\":\"__TwigTemplate_593b7a45b45b7e2f867b40e563d0eae6b075b205c6a26d81be764be110eeb251\",\"file\":\"/Users/ryan/training/craft-3-webinar/craftycoffee/vendor/craftcms/cms/src/web/twig/Template.php\",\"line\":51,\"class\":\"Twig_Template\",\"method\":\"displayWithErrorHandling\",\"args\":\"[\\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, \\\"SORT_DESC\\\" => 3, \\\"POS_HEAD\\\" => 1, ...], [\\\"main\\\" => [__TwigTemplate_373dc1271d25f315f4289fbdf75e89a510778b938e39621ba7f756e96d3fde93, \\\"block_main\\\"]]\"},{\"objectClass\":\"__TwigTemplate_593b7a45b45b7e2f867b40e563d0eae6b075b205c6a26d81be764be110eeb251\",\"file\":\"/Users/ryan/training/craft-3-webinar/craftycoffee/vendor/twig/twig/lib/Twig/Template.php\",\"line\":366,\"class\":\"craft\\\\web\\\\twig\\\\Template\",\"method\":\"displayWithErrorHandling\",\"args\":\"[\\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, \\\"SORT_DESC\\\" => 3, \\\"POS_HEAD\\\" => 1, ...], [\\\"main\\\" => [__TwigTemplate_373dc1271d25f315f4289fbdf75e89a510778b938e39621ba7f756e96d3fde93, \\\"block_main\\\"]]\"},{\"objectClass\":\"__TwigTemplate_593b7a45b45b7e2f867b40e563d0eae6b075b205c6a26d81be764be110eeb251\",\"file\":\"/Users/ryan/training/craft-3-webinar/craftycoffee/vendor/craftcms/cms/src/web/twig/Template.php\",\"line\":32,\"class\":\"Twig_Template\",\"method\":\"display\",\"args\":\"[\\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, \\\"SORT_DESC\\\" => 3, \\\"POS_HEAD\\\" => 1, ...], [\\\"main\\\" => [__TwigTemplate_373dc1271d25f315f4289fbdf75e89a510778b938e39621ba7f756e96d3fde93, \\\"block_main\\\"]]\"},{\"objectClass\":\"__TwigTemplate_593b7a45b45b7e2f867b40e563d0eae6b075b205c6a26d81be764be110eeb251\",\"file\":\"/Users/ryan/training/craft-3-webinar/craftycoffee/storage/runtime/compiled_templates/7e/7ed7b2542a555658f0142c0c7a28c85a977c4a99ccbede0fb04f2384a9ea9af9.php\",\"line\":24,\"class\":\"craft\\\\web\\\\twig\\\\Template\",\"method\":\"display\",\"args\":\"[\\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, \\\"SORT_DESC\\\" => 3, \\\"POS_HEAD\\\" => 1, ...], [\\\"main\\\" => [__TwigTemplate_373dc1271d25f315f4289fbdf75e89a510778b938e39621ba7f756e96d3fde93, \\\"block_main\\\"]]\"},{\"objectClass\":\"__TwigTemplate_373dc1271d25f315f4289fbdf75e89a510778b938e39621ba7f756e96d3fde93\",\"file\":\"/Users/ryan/training/craft-3-webinar/craftycoffee/vendor/twig/twig/lib/Twig/Template.php\",\"line\":389,\"class\":\"__TwigTemplate_373dc1271d25f315f4289fbdf75e89a510778b938e39621ba7f756e96d3fde93\",\"method\":\"doDisplay\",\"args\":\"[\\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, \\\"SORT_DESC\\\" => 3, \\\"POS_HEAD\\\" => 1, ...], [\\\"main\\\" => [__TwigTemplate_373dc1271d25f315f4289fbdf75e89a510778b938e39621ba7f756e96d3fde93, \\\"block_main\\\"]]\"},{\"objectClass\":\"__TwigTemplate_373dc1271d25f315f4289fbdf75e89a510778b938e39621ba7f756e96d3fde93\",\"file\":\"/Users/ryan/training/craft-3-webinar/craftycoffee/vendor/craftcms/cms/src/web/twig/Template.php\",\"line\":51,\"class\":\"Twig_Template\",\"method\":\"displayWithErrorHandling\",\"args\":\"[\\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, \\\"SORT_DESC\\\" => 3, \\\"POS_HEAD\\\" => 1, ...], [\\\"main\\\" => [__TwigTemplate_373dc1271d25f315f4289fbdf75e89a510778b938e39621ba7f756e96d3fde93, \\\"block_main\\\"]]\"},{\"objectClass\":\"__TwigTemplate_373dc1271d25f315f4289fbdf75e89a510778b938e39621ba7f756e96d3fde93\",\"file\":\"/Users/ryan/training/craft-3-webinar/craftycoffee/vendor/twig/twig/lib/Twig/Template.php\",\"line\":366,\"class\":\"craft\\\\web\\\\twig\\\\Template\",\"method\":\"displayWithErrorHandling\",\"args\":\"[\\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, \\\"SORT_DESC\\\" => 3, \\\"POS_HEAD\\\" => 1, ...], [\\\"main\\\" => [__TwigTemplate_373dc1271d25f315f4289fbdf75e89a510778b938e39621ba7f756e96d3fde93, \\\"block_main\\\"]]\"},{\"objectClass\":\"__TwigTemplate_373dc1271d25f315f4289fbdf75e89a510778b938e39621ba7f756e96d3fde93\",\"file\":\"/Users/ryan/training/craft-3-webinar/craftycoffee/vendor/craftcms/cms/src/web/twig/Template.php\",\"line\":32,\"class\":\"Twig_Template\",\"method\":\"display\",\"args\":\"[], []\"},{\"objectClass\":\"__TwigTemplate_373dc1271d25f315f4289fbdf75e89a510778b938e39621ba7f756e96d3fde93\",\"file\":\"/Users/ryan/training/craft-3-webinar/craftycoffee/vendor/twig/twig/lib/Twig/Template.php\",\"line\":374,\"class\":\"craft\\\\web\\\\twig\\\\Template\",\"method\":\"display\",\"args\":\"[]\"},{\"objectClass\":\"__TwigTemplate_373dc1271d25f315f4289fbdf75e89a510778b938e39621ba7f756e96d3fde93\",\"file\":\"/Users/ryan/training/craft-3-webinar/craftycoffee/vendor/twig/twig/lib/Twig/Environment.php\",\"line\":289,\"class\":\"Twig_Template\",\"method\":\"render\",\"args\":\"[]\"},{\"objectClass\":\"craft\\\\web\\\\twig\\\\Environment\",\"file\":\"/Users/ryan/training/craft-3-webinar/craftycoffee/vendor/craftcms/cms/src/web/View.php\",\"line\":308,\"class\":\"Twig_Environment\",\"method\":\"render\",\"args\":\"\\\"\\\", []\"},{\"objectClass\":\"craft\\\\web\\\\View\",\"file\":\"/Users/ryan/training/craft-3-webinar/craftycoffee/vendor/craftcms/cms/src/web/View.php\",\"line\":356,\"class\":\"craft\\\\web\\\\View\",\"method\":\"renderTemplate\",\"args\":\"\\\"\\\", []\"},{\"objectClass\":\"craft\\\\web\\\\View\",\"file\":\"/Users/ryan/training/craft-3-webinar/craftycoffee/vendor/craftcms/cms/src/web/Controller.php\",\"line\":121,\"class\":\"craft\\\\web\\\\View\",\"method\":\"renderPageTemplate\",\"args\":\"\\\"\\\", []\"},{\"objectClass\":\"craft\\\\controllers\\\\TemplatesController\",\"file\":\"/Users/ryan/training/craft-3-webinar/craftycoffee/vendor/craftcms/cms/src/controllers/TemplatesController.php\",\"line\":79,\"class\":\"craft\\\\web\\\\Controller\",\"method\":\"renderTemplate\",\"args\":\"\\\"\\\", []\"},{\"objectClass\":\"craft\\\\controllers\\\\TemplatesController\",\"file\":null,\"line\":null,\"class\":\"craft\\\\controllers\\\\TemplatesController\",\"method\":\"actionRender\",\"args\":\"\\\"\\\", []\"},{\"objectClass\":null,\"file\":\"/Users/ryan/training/craft-3-webinar/craftycoffee/vendor/yiisoft/yii2/base/InlineAction.php\",\"line\":57,\"class\":null,\"method\":\"call_user_func_array\",\"args\":\"[craft\\\\controllers\\\\TemplatesController, \\\"actionRender\\\"], [\\\"\\\", []]\"},{\"objectClass\":\"yii\\\\base\\\\InlineAction\",\"file\":\"/Users/ryan/training/craft-3-webinar/craftycoffee/vendor/yiisoft/yii2/base/Controller.php\",\"line\":157,\"class\":\"yii\\\\base\\\\InlineAction\",\"method\":\"runWithParams\",\"args\":\"[\\\"template\\\" => \\\"\\\"]\"},{\"objectClass\":\"craft\\\\controllers\\\\TemplatesController\",\"file\":\"/Users/ryan/training/craft-3-webinar/craftycoffee/vendor/craftcms/cms/src/web/Controller.php\",\"line\":80,\"class\":\"yii\\\\base\\\\Controller\",\"method\":\"runAction\",\"args\":\"\\\"render\\\", [\\\"template\\\" => \\\"\\\"]\"},{\"objectClass\":\"craft\\\\controllers\\\\TemplatesController\",\"file\":\"/Users/ryan/training/craft-3-webinar/craftycoffee/vendor/yiisoft/yii2/base/Module.php\",\"line\":528,\"class\":\"craft\\\\web\\\\Controller\",\"method\":\"runAction\",\"args\":\"\\\"render\\\", [\\\"template\\\" => \\\"\\\"]\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/ryan/training/craft-3-webinar/craftycoffee/vendor/craftcms/cms/src/web/Application.php\",\"line\":253,\"class\":\"yii\\\\base\\\\Module\",\"method\":\"runAction\",\"args\":\"\\\"templates/render\\\", [\\\"template\\\" => \\\"\\\"]\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/ryan/training/craft-3-webinar/craftycoffee/vendor/yiisoft/yii2/web/Application.php\",\"line\":103,\"class\":\"craft\\\\web\\\\Application\",\"method\":\"runAction\",\"args\":\"\\\"templates/render\\\", [\\\"template\\\" => \\\"\\\"]\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/ryan/training/craft-3-webinar/craftycoffee/vendor/craftcms/cms/src/web/Application.php\",\"line\":218,\"class\":\"yii\\\\web\\\\Application\",\"method\":\"handleRequest\",\"args\":\"craft\\\\web\\\\Request\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/ryan/training/craft-3-webinar/craftycoffee/vendor/yiisoft/yii2/base/Application.php\",\"line\":386,\"class\":\"craft\\\\web\\\\Application\",\"method\":\"handleRequest\",\"args\":\"craft\\\\web\\\\Request\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/ryan/training/craft-3-webinar/craftycoffee/web/index.php\",\"line\":21,\"class\":\"yii\\\\base\\\\Application\",\"method\":\"run\",\"args\":null},{\"objectClass\":null,\"file\":\"/Users/ryan/.composer/vendor/laravel/valet/server.php\",\"line\":133,\"class\":null,\"method\":\"require\",\"args\":\"\\\"/Users/ryan/training/craft-3-webinar/craftycoffee/web/index.php\\\"\"}]','2018-02-07 19:37:43','2018-02-07 19:37:43','c4cfdcd8-7990-44d1-89b3-4253361843f0'),
	(4,'craft.locale()','/Users/ryan/training/up-and-running-with-craft/craftycoffee/templates/de/index.twig:9','2018-02-13 14:56:48','/Users/ryan/training/up-and-running-with-craft/craftycoffee/templates/de/index.twig',9,'craft.locale() has been deprecated. Use craft.app.language instead.','[{\"objectClass\":\"craft\\\\services\\\\Deprecator\",\"file\":\"/Users/ryan/training/up-and-running-with-craft/craftycoffee/vendor/craftcms/cms/src/web/twig/variables/CraftVariable.php\",\"line\":223,\"class\":\"craft\\\\services\\\\Deprecator\",\"method\":\"log\",\"args\":\"\\\"craft.locale()\\\", \\\"craft.locale() has been deprecated. Use craft.app.language inste...\\\"\"},{\"objectClass\":\"craft\\\\web\\\\twig\\\\variables\\\\CraftVariable\",\"file\":\"/Users/ryan/training/up-and-running-with-craft/craftycoffee/vendor/twig/twig/lib/Twig/Extension/Core.php\",\"line\":1595,\"class\":\"craft\\\\web\\\\twig\\\\variables\\\\CraftVariable\",\"method\":\"locale\",\"args\":null},{\"objectClass\":null,\"file\":\"/Users/ryan/training/up-and-running-with-craft/craftycoffee/vendor/craftcms/cms/src/helpers/Template.php\",\"line\":76,\"class\":null,\"method\":\"twig_get_attribute\",\"args\":\"craft\\\\web\\\\twig\\\\Environment, Twig_Source, craft\\\\web\\\\twig\\\\variables\\\\CraftVariable, \\\"locale\\\", ...\"},{\"objectClass\":null,\"file\":\"/Users/ryan/training/up-and-running-with-craft/craftycoffee/storage/runtime/compiled_templates/fd/fdb8efdbc7cd77d617db651663c2d6fb33e13ff76a39c95ed6248a5ed0ec4618.php\",\"line\":38,\"class\":\"craft\\\\helpers\\\\Template\",\"method\":\"attribute\",\"args\":\"craft\\\\web\\\\twig\\\\Environment, Twig_Source, craft\\\\web\\\\twig\\\\variables\\\\CraftVariable, \\\"locale\\\", ...\"},{\"objectClass\":\"__TwigTemplate_4d87f261c25b1622abaeef0f7d628cb0ce20fb9d2cb0dc05ff98d07e90e9bfb3\",\"file\":\"/Users/ryan/training/up-and-running-with-craft/craftycoffee/vendor/twig/twig/lib/Twig/Template.php\",\"line\":188,\"class\":\"__TwigTemplate_4d87f261c25b1622abaeef0f7d628cb0ce20fb9d2cb0dc05ff98d07e90e9bfb3\",\"method\":\"block_main\",\"args\":\"[\\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, \\\"SORT_DESC\\\" => 3, ...], [\\\"main\\\" => [__TwigTemplate_4d87f261c25b1622abaeef0f7d628cb0ce20fb9d2cb0dc05ff98d07e90e9bfb3, \\\"block_main\\\"]]\"},{\"objectClass\":\"__TwigTemplate_71ec18486d560b05f202fcfb99ba6711af7577c2449a0a11154bab5e112da34a\",\"file\":\"/Users/ryan/training/up-and-running-with-craft/craftycoffee/storage/runtime/compiled_templates/87/87727690e7b5ae1c09cd39ebc60bbe42538d1469db7535d49d2b028f07682466.php\",\"line\":166,\"class\":\"Twig_Template\",\"method\":\"displayBlock\",\"args\":\"\\\"main\\\", [\\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, \\\"SORT_DESC\\\" => 3, ...], [\\\"main\\\" => [__TwigTemplate_4d87f261c25b1622abaeef0f7d628cb0ce20fb9d2cb0dc05ff98d07e90e9bfb3, \\\"block_main\\\"]]\"},{\"objectClass\":\"__TwigTemplate_71ec18486d560b05f202fcfb99ba6711af7577c2449a0a11154bab5e112da34a\",\"file\":\"/Users/ryan/training/up-and-running-with-craft/craftycoffee/vendor/twig/twig/lib/Twig/Template.php\",\"line\":389,\"class\":\"__TwigTemplate_71ec18486d560b05f202fcfb99ba6711af7577c2449a0a11154bab5e112da34a\",\"method\":\"doDisplay\",\"args\":\"[\\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, \\\"SORT_DESC\\\" => 3, ...], [\\\"main\\\" => [__TwigTemplate_4d87f261c25b1622abaeef0f7d628cb0ce20fb9d2cb0dc05ff98d07e90e9bfb3, \\\"block_main\\\"]]\"},{\"objectClass\":\"__TwigTemplate_71ec18486d560b05f202fcfb99ba6711af7577c2449a0a11154bab5e112da34a\",\"file\":\"/Users/ryan/training/up-and-running-with-craft/craftycoffee/vendor/craftcms/cms/src/web/twig/Template.php\",\"line\":51,\"class\":\"Twig_Template\",\"method\":\"displayWithErrorHandling\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], [\\\"main\\\" => [__TwigTemplate_4d87f261c25b1622abaeef0f7d628cb0ce20fb9d2cb0dc05ff98d07e90e9bfb3, \\\"block_main\\\"]]\"},{\"objectClass\":\"__TwigTemplate_71ec18486d560b05f202fcfb99ba6711af7577c2449a0a11154bab5e112da34a\",\"file\":\"/Users/ryan/training/up-and-running-with-craft/craftycoffee/vendor/twig/twig/lib/Twig/Template.php\",\"line\":366,\"class\":\"craft\\\\web\\\\twig\\\\Template\",\"method\":\"displayWithErrorHandling\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], [\\\"main\\\" => [__TwigTemplate_4d87f261c25b1622abaeef0f7d628cb0ce20fb9d2cb0dc05ff98d07e90e9bfb3, \\\"block_main\\\"]]\"},{\"objectClass\":\"__TwigTemplate_71ec18486d560b05f202fcfb99ba6711af7577c2449a0a11154bab5e112da34a\",\"file\":\"/Users/ryan/training/up-and-running-with-craft/craftycoffee/vendor/craftcms/cms/src/web/twig/Template.php\",\"line\":32,\"class\":\"Twig_Template\",\"method\":\"display\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], [\\\"main\\\" => [__TwigTemplate_4d87f261c25b1622abaeef0f7d628cb0ce20fb9d2cb0dc05ff98d07e90e9bfb3, \\\"block_main\\\"]]\"},{\"objectClass\":\"__TwigTemplate_71ec18486d560b05f202fcfb99ba6711af7577c2449a0a11154bab5e112da34a\",\"file\":\"/Users/ryan/training/up-and-running-with-craft/craftycoffee/storage/runtime/compiled_templates/fd/fdb8efdbc7cd77d617db651663c2d6fb33e13ff76a39c95ed6248a5ed0ec4618.php\",\"line\":24,\"class\":\"craft\\\\web\\\\twig\\\\Template\",\"method\":\"display\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], [\\\"main\\\" => [__TwigTemplate_4d87f261c25b1622abaeef0f7d628cb0ce20fb9d2cb0dc05ff98d07e90e9bfb3, \\\"block_main\\\"]]\"},{\"objectClass\":\"__TwigTemplate_4d87f261c25b1622abaeef0f7d628cb0ce20fb9d2cb0dc05ff98d07e90e9bfb3\",\"file\":\"/Users/ryan/training/up-and-running-with-craft/craftycoffee/vendor/twig/twig/lib/Twig/Template.php\",\"line\":389,\"class\":\"__TwigTemplate_4d87f261c25b1622abaeef0f7d628cb0ce20fb9d2cb0dc05ff98d07e90e9bfb3\",\"method\":\"doDisplay\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], [\\\"main\\\" => [__TwigTemplate_4d87f261c25b1622abaeef0f7d628cb0ce20fb9d2cb0dc05ff98d07e90e9bfb3, \\\"block_main\\\"]]\"},{\"objectClass\":\"__TwigTemplate_4d87f261c25b1622abaeef0f7d628cb0ce20fb9d2cb0dc05ff98d07e90e9bfb3\",\"file\":\"/Users/ryan/training/up-and-running-with-craft/craftycoffee/vendor/craftcms/cms/src/web/twig/Template.php\",\"line\":51,\"class\":\"Twig_Template\",\"method\":\"displayWithErrorHandling\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], [\\\"main\\\" => [__TwigTemplate_4d87f261c25b1622abaeef0f7d628cb0ce20fb9d2cb0dc05ff98d07e90e9bfb3, \\\"block_main\\\"]]\"},{\"objectClass\":\"__TwigTemplate_4d87f261c25b1622abaeef0f7d628cb0ce20fb9d2cb0dc05ff98d07e90e9bfb3\",\"file\":\"/Users/ryan/training/up-and-running-with-craft/craftycoffee/vendor/twig/twig/lib/Twig/Template.php\",\"line\":366,\"class\":\"craft\\\\web\\\\twig\\\\Template\",\"method\":\"displayWithErrorHandling\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], [\\\"main\\\" => [__TwigTemplate_4d87f261c25b1622abaeef0f7d628cb0ce20fb9d2cb0dc05ff98d07e90e9bfb3, \\\"block_main\\\"]]\"},{\"objectClass\":\"__TwigTemplate_4d87f261c25b1622abaeef0f7d628cb0ce20fb9d2cb0dc05ff98d07e90e9bfb3\",\"file\":\"/Users/ryan/training/up-and-running-with-craft/craftycoffee/vendor/craftcms/cms/src/web/twig/Template.php\",\"line\":32,\"class\":\"Twig_Template\",\"method\":\"display\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]], []\"},{\"objectClass\":\"__TwigTemplate_4d87f261c25b1622abaeef0f7d628cb0ce20fb9d2cb0dc05ff98d07e90e9bfb3\",\"file\":\"/Users/ryan/training/up-and-running-with-craft/craftycoffee/vendor/twig/twig/lib/Twig/Template.php\",\"line\":374,\"class\":\"craft\\\\web\\\\twig\\\\Template\",\"method\":\"display\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"__TwigTemplate_4d87f261c25b1622abaeef0f7d628cb0ce20fb9d2cb0dc05ff98d07e90e9bfb3\",\"file\":\"/Users/ryan/training/up-and-running-with-craft/craftycoffee/vendor/twig/twig/lib/Twig/Environment.php\",\"line\":289,\"class\":\"Twig_Template\",\"method\":\"render\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\twig\\\\Environment\",\"file\":\"/Users/ryan/training/up-and-running-with-craft/craftycoffee/vendor/craftcms/cms/src/web/View.php\",\"line\":308,\"class\":\"Twig_Environment\",\"method\":\"render\",\"args\":\"\\\"de/index.twig\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\View\",\"file\":\"/Users/ryan/training/up-and-running-with-craft/craftycoffee/vendor/craftcms/cms/src/web/View.php\",\"line\":356,\"class\":\"craft\\\\web\\\\View\",\"method\":\"renderTemplate\",\"args\":\"\\\"de/index.twig\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\View\",\"file\":\"/Users/ryan/training/up-and-running-with-craft/craftycoffee/vendor/craftcms/cms/src/web/Controller.php\",\"line\":121,\"class\":\"craft\\\\web\\\\View\",\"method\":\"renderPageTemplate\",\"args\":\"\\\"de/index.twig\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\controllers\\\\TemplatesController\",\"file\":\"/Users/ryan/training/up-and-running-with-craft/craftycoffee/vendor/craftcms/cms/src/controllers/TemplatesController.php\",\"line\":79,\"class\":\"craft\\\\web\\\\Controller\",\"method\":\"renderTemplate\",\"args\":\"\\\"de/index.twig\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\controllers\\\\TemplatesController\",\"file\":null,\"line\":null,\"class\":\"craft\\\\controllers\\\\TemplatesController\",\"method\":\"actionRender\",\"args\":\"\\\"de/index.twig\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":null,\"file\":\"/Users/ryan/training/up-and-running-with-craft/craftycoffee/vendor/yiisoft/yii2/base/InlineAction.php\",\"line\":57,\"class\":null,\"method\":\"call_user_func_array\",\"args\":\"[craft\\\\controllers\\\\TemplatesController, \\\"actionRender\\\"], [\\\"de/index.twig\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"yii\\\\base\\\\InlineAction\",\"file\":\"/Users/ryan/training/up-and-running-with-craft/craftycoffee/vendor/yiisoft/yii2/base/Controller.php\",\"line\":157,\"class\":\"yii\\\\base\\\\InlineAction\",\"method\":\"runWithParams\",\"args\":\"[\\\"template\\\" => \\\"de/index.twig\\\", \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\controllers\\\\TemplatesController\",\"file\":\"/Users/ryan/training/up-and-running-with-craft/craftycoffee/vendor/craftcms/cms/src/web/Controller.php\",\"line\":80,\"class\":\"yii\\\\base\\\\Controller\",\"method\":\"runAction\",\"args\":\"\\\"render\\\", [\\\"template\\\" => \\\"de/index.twig\\\", \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\controllers\\\\TemplatesController\",\"file\":\"/Users/ryan/training/up-and-running-with-craft/craftycoffee/vendor/yiisoft/yii2/base/Module.php\",\"line\":528,\"class\":\"craft\\\\web\\\\Controller\",\"method\":\"runAction\",\"args\":\"\\\"render\\\", [\\\"template\\\" => \\\"de/index.twig\\\", \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/ryan/training/up-and-running-with-craft/craftycoffee/vendor/craftcms/cms/src/web/Application.php\",\"line\":253,\"class\":\"yii\\\\base\\\\Module\",\"method\":\"runAction\",\"args\":\"\\\"templates/render\\\", [\\\"template\\\" => \\\"de/index.twig\\\", \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/ryan/training/up-and-running-with-craft/craftycoffee/vendor/yiisoft/yii2/web/Application.php\",\"line\":103,\"class\":\"craft\\\\web\\\\Application\",\"method\":\"runAction\",\"args\":\"\\\"templates/render\\\", [\\\"template\\\" => \\\"de/index.twig\\\", \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/ryan/training/up-and-running-with-craft/craftycoffee/vendor/craftcms/cms/src/web/Application.php\",\"line\":218,\"class\":\"yii\\\\web\\\\Application\",\"method\":\"handleRequest\",\"args\":\"craft\\\\web\\\\Request\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/ryan/training/up-and-running-with-craft/craftycoffee/vendor/yiisoft/yii2/base/Application.php\",\"line\":386,\"class\":\"craft\\\\web\\\\Application\",\"method\":\"handleRequest\",\"args\":\"craft\\\\web\\\\Request\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/ryan/training/up-and-running-with-craft/craftycoffee/web-de/index.php\",\"line\":21,\"class\":\"yii\\\\base\\\\Application\",\"method\":\"run\",\"args\":null},{\"objectClass\":null,\"file\":\"/Users/ryan/.composer/vendor/laravel/valet/server.php\",\"line\":133,\"class\":null,\"method\":\"require\",\"args\":\"\\\"/Users/ryan/training/up-and-running-with-craft/craftycoffee/web-...\\\"\"}]','2018-02-13 14:56:48','2018-02-13 14:56:48','195037a7-baf1-4b18-b411-69f2b06d1ed4'),
	(5,'ElementQuery::getIterator()','/Users/ryan/training/craft-3-webinar/craftycoffee/templates/styles/_category.twig:24','2018-03-21 17:37:36','/Users/ryan/training/craft-3-webinar/craftycoffee/templates/styles/_category.twig',24,'Looping through element queries directly has been deprecated. Use the all() function to fetch the query results before looping over them.','[{\"objectClass\":\"craft\\\\services\\\\Deprecator\",\"file\":\"/Users/ryan/training/craft-3-webinar/craftycoffee/vendor/craftcms/cms/src/elements/db/ElementQuery.php\",\"line\":393,\"class\":\"craft\\\\services\\\\Deprecator\",\"method\":\"log\",\"args\":\"\\\"ElementQuery::getIterator()\\\", \\\"Looping through element queries directly has been deprecated. Us...\\\"\"},{\"objectClass\":\"craft\\\\elements\\\\db\\\\EntryQuery\",\"file\":\"/Users/ryan/training/craft-3-webinar/craftycoffee/storage/runtime/compiled_templates/03/0341c4daa6f770c0469ddcde44781b89e725829d2d519e66047722add6f9337b.php\",\"line\":61,\"class\":\"craft\\\\elements\\\\db\\\\ElementQuery\",\"method\":\"getIterator\",\"args\":null},{\"objectClass\":\"__TwigTemplate_d6aa8426544cc3246772b87f89ec612487c64b39e54aa542eea2b1b616601842\",\"file\":\"/Users/ryan/training/craft-3-webinar/craftycoffee/vendor/twig/twig/lib/Twig/Template.php\",\"line\":188,\"class\":\"__TwigTemplate_d6aa8426544cc3246772b87f89ec612487c64b39e54aa542eea2b1b616601842\",\"method\":\"block_main\",\"args\":\"[\\\"category\\\" => craft\\\\elements\\\\Category, \\\"variables\\\" => [\\\"category\\\" => craft\\\\elements\\\\Category], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], [\\\"main\\\" => [__TwigTemplate_d6aa8426544cc3246772b87f89ec612487c64b39e54aa542eea2b1b616601842, \\\"block_main\\\"]]\"},{\"objectClass\":\"__TwigTemplate_593b7a45b45b7e2f867b40e563d0eae6b075b205c6a26d81be764be110eeb251\",\"file\":\"/Users/ryan/training/craft-3-webinar/craftycoffee/storage/runtime/compiled_templates/8e/8e70952d8ed08f16dca24875c26ea6f6a9c00e292f35879dc0f329947df65fb0.php\",\"line\":166,\"class\":\"Twig_Template\",\"method\":\"displayBlock\",\"args\":\"\\\"main\\\", [\\\"category\\\" => craft\\\\elements\\\\Category, \\\"variables\\\" => [\\\"category\\\" => craft\\\\elements\\\\Category], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], [\\\"main\\\" => [__TwigTemplate_d6aa8426544cc3246772b87f89ec612487c64b39e54aa542eea2b1b616601842, \\\"block_main\\\"]]\"},{\"objectClass\":\"__TwigTemplate_593b7a45b45b7e2f867b40e563d0eae6b075b205c6a26d81be764be110eeb251\",\"file\":\"/Users/ryan/training/craft-3-webinar/craftycoffee/vendor/twig/twig/lib/Twig/Template.php\",\"line\":389,\"class\":\"__TwigTemplate_593b7a45b45b7e2f867b40e563d0eae6b075b205c6a26d81be764be110eeb251\",\"method\":\"doDisplay\",\"args\":\"[\\\"category\\\" => craft\\\\elements\\\\Category, \\\"variables\\\" => [\\\"category\\\" => craft\\\\elements\\\\Category], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], [\\\"main\\\" => [__TwigTemplate_d6aa8426544cc3246772b87f89ec612487c64b39e54aa542eea2b1b616601842, \\\"block_main\\\"]]\"},{\"objectClass\":\"__TwigTemplate_593b7a45b45b7e2f867b40e563d0eae6b075b205c6a26d81be764be110eeb251\",\"file\":\"/Users/ryan/training/craft-3-webinar/craftycoffee/vendor/craftcms/cms/src/web/twig/Template.php\",\"line\":51,\"class\":\"Twig_Template\",\"method\":\"displayWithErrorHandling\",\"args\":\"[\\\"category\\\" => craft\\\\elements\\\\Category, \\\"variables\\\" => [\\\"category\\\" => craft\\\\elements\\\\Category], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], [\\\"main\\\" => [__TwigTemplate_d6aa8426544cc3246772b87f89ec612487c64b39e54aa542eea2b1b616601842, \\\"block_main\\\"]]\"},{\"objectClass\":\"__TwigTemplate_593b7a45b45b7e2f867b40e563d0eae6b075b205c6a26d81be764be110eeb251\",\"file\":\"/Users/ryan/training/craft-3-webinar/craftycoffee/vendor/twig/twig/lib/Twig/Template.php\",\"line\":366,\"class\":\"craft\\\\web\\\\twig\\\\Template\",\"method\":\"displayWithErrorHandling\",\"args\":\"[\\\"category\\\" => craft\\\\elements\\\\Category, \\\"variables\\\" => [\\\"category\\\" => craft\\\\elements\\\\Category], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], [\\\"main\\\" => [__TwigTemplate_d6aa8426544cc3246772b87f89ec612487c64b39e54aa542eea2b1b616601842, \\\"block_main\\\"]]\"},{\"objectClass\":\"__TwigTemplate_593b7a45b45b7e2f867b40e563d0eae6b075b205c6a26d81be764be110eeb251\",\"file\":\"/Users/ryan/training/craft-3-webinar/craftycoffee/vendor/craftcms/cms/src/web/twig/Template.php\",\"line\":32,\"class\":\"Twig_Template\",\"method\":\"display\",\"args\":\"[\\\"category\\\" => craft\\\\elements\\\\Category, \\\"variables\\\" => [\\\"category\\\" => craft\\\\elements\\\\Category], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], [\\\"main\\\" => [__TwigTemplate_d6aa8426544cc3246772b87f89ec612487c64b39e54aa542eea2b1b616601842, \\\"block_main\\\"]]\"},{\"objectClass\":\"__TwigTemplate_593b7a45b45b7e2f867b40e563d0eae6b075b205c6a26d81be764be110eeb251\",\"file\":\"/Users/ryan/training/craft-3-webinar/craftycoffee/storage/runtime/compiled_templates/03/0341c4daa6f770c0469ddcde44781b89e725829d2d519e66047722add6f9337b.php\",\"line\":24,\"class\":\"craft\\\\web\\\\twig\\\\Template\",\"method\":\"display\",\"args\":\"[\\\"category\\\" => craft\\\\elements\\\\Category, \\\"variables\\\" => [\\\"category\\\" => craft\\\\elements\\\\Category], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], [\\\"main\\\" => [__TwigTemplate_d6aa8426544cc3246772b87f89ec612487c64b39e54aa542eea2b1b616601842, \\\"block_main\\\"]]\"},{\"objectClass\":\"__TwigTemplate_d6aa8426544cc3246772b87f89ec612487c64b39e54aa542eea2b1b616601842\",\"file\":\"/Users/ryan/training/craft-3-webinar/craftycoffee/vendor/twig/twig/lib/Twig/Template.php\",\"line\":389,\"class\":\"__TwigTemplate_d6aa8426544cc3246772b87f89ec612487c64b39e54aa542eea2b1b616601842\",\"method\":\"doDisplay\",\"args\":\"[\\\"category\\\" => craft\\\\elements\\\\Category, \\\"variables\\\" => [\\\"category\\\" => craft\\\\elements\\\\Category], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], [\\\"main\\\" => [__TwigTemplate_d6aa8426544cc3246772b87f89ec612487c64b39e54aa542eea2b1b616601842, \\\"block_main\\\"]]\"},{\"objectClass\":\"__TwigTemplate_d6aa8426544cc3246772b87f89ec612487c64b39e54aa542eea2b1b616601842\",\"file\":\"/Users/ryan/training/craft-3-webinar/craftycoffee/vendor/craftcms/cms/src/web/twig/Template.php\",\"line\":51,\"class\":\"Twig_Template\",\"method\":\"displayWithErrorHandling\",\"args\":\"[\\\"category\\\" => craft\\\\elements\\\\Category, \\\"variables\\\" => [\\\"category\\\" => craft\\\\elements\\\\Category], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], [\\\"main\\\" => [__TwigTemplate_d6aa8426544cc3246772b87f89ec612487c64b39e54aa542eea2b1b616601842, \\\"block_main\\\"]]\"},{\"objectClass\":\"__TwigTemplate_d6aa8426544cc3246772b87f89ec612487c64b39e54aa542eea2b1b616601842\",\"file\":\"/Users/ryan/training/craft-3-webinar/craftycoffee/vendor/twig/twig/lib/Twig/Template.php\",\"line\":366,\"class\":\"craft\\\\web\\\\twig\\\\Template\",\"method\":\"displayWithErrorHandling\",\"args\":\"[\\\"category\\\" => craft\\\\elements\\\\Category, \\\"variables\\\" => [\\\"category\\\" => craft\\\\elements\\\\Category], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], [\\\"main\\\" => [__TwigTemplate_d6aa8426544cc3246772b87f89ec612487c64b39e54aa542eea2b1b616601842, \\\"block_main\\\"]]\"},{\"objectClass\":\"__TwigTemplate_d6aa8426544cc3246772b87f89ec612487c64b39e54aa542eea2b1b616601842\",\"file\":\"/Users/ryan/training/craft-3-webinar/craftycoffee/vendor/craftcms/cms/src/web/twig/Template.php\",\"line\":32,\"class\":\"Twig_Template\",\"method\":\"display\",\"args\":\"[\\\"category\\\" => craft\\\\elements\\\\Category, \\\"variables\\\" => [\\\"category\\\" => craft\\\\elements\\\\Category]], []\"},{\"objectClass\":\"__TwigTemplate_d6aa8426544cc3246772b87f89ec612487c64b39e54aa542eea2b1b616601842\",\"file\":\"/Users/ryan/training/craft-3-webinar/craftycoffee/vendor/twig/twig/lib/Twig/Template.php\",\"line\":374,\"class\":\"craft\\\\web\\\\twig\\\\Template\",\"method\":\"display\",\"args\":\"[\\\"category\\\" => craft\\\\elements\\\\Category, \\\"variables\\\" => [\\\"category\\\" => craft\\\\elements\\\\Category]]\"},{\"objectClass\":\"__TwigTemplate_d6aa8426544cc3246772b87f89ec612487c64b39e54aa542eea2b1b616601842\",\"file\":\"/Users/ryan/training/craft-3-webinar/craftycoffee/vendor/twig/twig/lib/Twig/Environment.php\",\"line\":289,\"class\":\"Twig_Template\",\"method\":\"render\",\"args\":\"[\\\"category\\\" => craft\\\\elements\\\\Category, \\\"variables\\\" => [\\\"category\\\" => craft\\\\elements\\\\Category]]\"},{\"objectClass\":\"craft\\\\web\\\\twig\\\\Environment\",\"file\":\"/Users/ryan/training/craft-3-webinar/craftycoffee/vendor/craftcms/cms/src/web/View.php\",\"line\":308,\"class\":\"Twig_Environment\",\"method\":\"render\",\"args\":\"\\\"styles/_category\\\", [\\\"category\\\" => craft\\\\elements\\\\Category, \\\"variables\\\" => [\\\"category\\\" => craft\\\\elements\\\\Category]]\"},{\"objectClass\":\"craft\\\\web\\\\View\",\"file\":\"/Users/ryan/training/craft-3-webinar/craftycoffee/vendor/craftcms/cms/src/web/View.php\",\"line\":356,\"class\":\"craft\\\\web\\\\View\",\"method\":\"renderTemplate\",\"args\":\"\\\"styles/_category\\\", [\\\"category\\\" => craft\\\\elements\\\\Category, \\\"variables\\\" => [\\\"category\\\" => craft\\\\elements\\\\Category]]\"},{\"objectClass\":\"craft\\\\web\\\\View\",\"file\":\"/Users/ryan/training/craft-3-webinar/craftycoffee/vendor/craftcms/cms/src/web/Controller.php\",\"line\":120,\"class\":\"craft\\\\web\\\\View\",\"method\":\"renderPageTemplate\",\"args\":\"\\\"styles/_category\\\", [\\\"category\\\" => craft\\\\elements\\\\Category, \\\"variables\\\" => [\\\"category\\\" => craft\\\\elements\\\\Category]]\"},{\"objectClass\":\"craft\\\\controllers\\\\TemplatesController\",\"file\":\"/Users/ryan/training/craft-3-webinar/craftycoffee/vendor/craftcms/cms/src/controllers/TemplatesController.php\",\"line\":79,\"class\":\"craft\\\\web\\\\Controller\",\"method\":\"renderTemplate\",\"args\":\"\\\"styles/_category\\\", [\\\"category\\\" => craft\\\\elements\\\\Category, \\\"variables\\\" => [\\\"category\\\" => craft\\\\elements\\\\Category]]\"},{\"objectClass\":\"craft\\\\controllers\\\\TemplatesController\",\"file\":null,\"line\":null,\"class\":\"craft\\\\controllers\\\\TemplatesController\",\"method\":\"actionRender\",\"args\":\"\\\"styles/_category\\\", [\\\"category\\\" => craft\\\\elements\\\\Category, \\\"variables\\\" => [\\\"category\\\" => craft\\\\elements\\\\Category]]\"},{\"objectClass\":null,\"file\":\"/Users/ryan/training/craft-3-webinar/craftycoffee/vendor/yiisoft/yii2/base/InlineAction.php\",\"line\":57,\"class\":null,\"method\":\"call_user_func_array\",\"args\":\"[craft\\\\controllers\\\\TemplatesController, \\\"actionRender\\\"], [\\\"styles/_category\\\", [\\\"category\\\" => craft\\\\elements\\\\Category]]\"},{\"objectClass\":\"yii\\\\base\\\\InlineAction\",\"file\":\"/Users/ryan/training/craft-3-webinar/craftycoffee/vendor/yiisoft/yii2/base/Controller.php\",\"line\":157,\"class\":\"yii\\\\base\\\\InlineAction\",\"method\":\"runWithParams\",\"args\":\"[\\\"template\\\" => \\\"styles/_category\\\", \\\"variables\\\" => [\\\"category\\\" => craft\\\\elements\\\\Category]]\"},{\"objectClass\":\"craft\\\\controllers\\\\TemplatesController\",\"file\":\"/Users/ryan/training/craft-3-webinar/craftycoffee/vendor/craftcms/cms/src/web/Controller.php\",\"line\":80,\"class\":\"yii\\\\base\\\\Controller\",\"method\":\"runAction\",\"args\":\"\\\"render\\\", [\\\"template\\\" => \\\"styles/_category\\\", \\\"variables\\\" => [\\\"category\\\" => craft\\\\elements\\\\Category]]\"},{\"objectClass\":\"craft\\\\controllers\\\\TemplatesController\",\"file\":\"/Users/ryan/training/craft-3-webinar/craftycoffee/vendor/yiisoft/yii2/base/Module.php\",\"line\":528,\"class\":\"craft\\\\web\\\\Controller\",\"method\":\"runAction\",\"args\":\"\\\"render\\\", [\\\"template\\\" => \\\"styles/_category\\\", \\\"variables\\\" => [\\\"category\\\" => craft\\\\elements\\\\Category]]\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/ryan/training/craft-3-webinar/craftycoffee/vendor/craftcms/cms/src/web/Application.php\",\"line\":240,\"class\":\"yii\\\\base\\\\Module\",\"method\":\"runAction\",\"args\":\"\\\"templates/render\\\", [\\\"template\\\" => \\\"styles/_category\\\", \\\"variables\\\" => [\\\"category\\\" => craft\\\\elements\\\\Category]]\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/ryan/training/craft-3-webinar/craftycoffee/vendor/yiisoft/yii2/web/Application.php\",\"line\":103,\"class\":\"craft\\\\web\\\\Application\",\"method\":\"runAction\",\"args\":\"\\\"templates/render\\\", [\\\"template\\\" => \\\"styles/_category\\\", \\\"variables\\\" => [\\\"category\\\" => craft\\\\elements\\\\Category]]\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/ryan/training/craft-3-webinar/craftycoffee/vendor/craftcms/cms/src/web/Application.php\",\"line\":216,\"class\":\"yii\\\\web\\\\Application\",\"method\":\"handleRequest\",\"args\":\"craft\\\\web\\\\Request\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/ryan/training/craft-3-webinar/craftycoffee/vendor/yiisoft/yii2/base/Application.php\",\"line\":386,\"class\":\"craft\\\\web\\\\Application\",\"method\":\"handleRequest\",\"args\":\"craft\\\\web\\\\Request\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/ryan/training/craft-3-webinar/craftycoffee/web/index.php\",\"line\":21,\"class\":\"yii\\\\base\\\\Application\",\"method\":\"run\",\"args\":null},{\"objectClass\":null,\"file\":\"/Users/ryan/.composer/vendor/laravel/valet/server.php\",\"line\":133,\"class\":null,\"method\":\"require\",\"args\":\"\\\"/Users/ryan/training/craft-3-webinar/craftycoffee/web/index.php\\\"\"}]','2018-03-21 17:37:36','2018-03-21 17:37:36','b03f101c-8c8f-42bb-aa15-937cd93404a6');

/*!40000 ALTER TABLE `deprecationerrors` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table elementindexsettings
# ------------------------------------------------------------

DROP TABLE IF EXISTS `elementindexsettings`;

CREATE TABLE `elementindexsettings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `settings` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `elementindexsettings_type_unq_idx` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table elements
# ------------------------------------------------------------

DROP TABLE IF EXISTS `elements`;

CREATE TABLE `elements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `type` varchar(255) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `archived` tinyint(1) NOT NULL DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `elements_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `elements_type_idx` (`type`),
  KEY `elements_enabled_idx` (`enabled`),
  KEY `elements_archived_dateCreated_idx` (`archived`,`dateCreated`),
  CONSTRAINT `elements_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `elements` WRITE;
/*!40000 ALTER TABLE `elements` DISABLE KEYS */;

INSERT INTO `elements` (`id`, `fieldLayoutId`, `type`, `enabled`, `archived`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,NULL,'craft\\elements\\User',1,0,'2017-12-29 17:38:45','2018-02-07 19:36:12','0110b59d-0f3f-4466-85d9-395201672fb0'),
	(2,1,'craft\\elements\\Entry',1,0,'2017-12-29 22:10:38','2018-02-15 17:14:00','efcbc73b-3f21-453a-9bee-a580320aa479'),
	(3,2,'craft\\elements\\Entry',1,0,'2017-12-29 22:14:23','2018-01-02 19:50:52','93fc050e-6888-4fd6-9869-9aeca733d19c'),
	(5,3,'craft\\elements\\Entry',1,0,'2017-12-29 22:21:08','2018-02-09 15:45:35','3a60a4c5-8616-41e3-b653-4dde8d14a99e'),
	(6,4,'craft\\elements\\Asset',1,0,'2017-12-29 22:42:22','2018-02-13 17:47:01','18a17132-67fc-4144-b8c0-fcfa56edf9b0'),
	(7,5,'craft\\elements\\Entry',1,0,'2017-12-29 22:52:18','2017-12-29 23:06:04','a704dc04-dd15-46ba-93c7-a95f388e36f7'),
	(8,5,'craft\\elements\\Entry',1,0,'2017-12-29 22:52:28','2018-01-02 20:31:11','bc599f99-5fb7-4da6-b1ba-1b76842fff8d'),
	(9,5,'craft\\elements\\Entry',1,0,'2017-12-29 22:53:01','2018-01-02 20:31:45','126b5d23-581a-446b-8b47-6ff30e2ee791'),
	(10,5,'craft\\elements\\Entry',1,0,'2017-12-29 22:58:50','2017-12-29 23:05:42','c302cf22-a2b8-46ac-9ea5-6d29c1d836b9'),
	(11,4,'craft\\elements\\Asset',1,0,'2018-01-02 17:41:40','2018-02-13 17:47:01','a5e7b03f-aa1d-4734-81a8-ea8c84710452'),
	(12,1,'craft\\elements\\Entry',1,0,'2018-01-02 17:42:03','2018-02-15 17:19:26','69dd5a31-bceb-44a7-9031-5a172d90cce9'),
	(13,6,'craft\\elements\\Entry',1,0,'2018-01-02 21:14:07','2018-01-02 22:04:04','dbd2a339-55b0-4976-82b6-f35e9a959497'),
	(14,9,'craft\\elements\\MatrixBlock',1,0,'2018-01-02 21:14:07','2018-01-02 22:04:04','98fa392a-f3f9-426f-ba6b-358f92965c93'),
	(15,7,'craft\\elements\\MatrixBlock',1,0,'2018-01-02 21:14:07','2018-01-02 22:04:04','3fc9b5ae-b077-425c-b451-645d17134475'),
	(16,9,'craft\\elements\\MatrixBlock',1,0,'2018-01-02 21:14:07','2018-01-02 22:04:04','4af83073-cc9c-4cec-b829-973ff622f6e9'),
	(17,8,'craft\\elements\\MatrixBlock',1,0,'2018-01-02 21:14:07','2018-01-02 22:04:04','beac55c6-4a6e-4c40-885a-4943be2e8919'),
	(18,7,'craft\\elements\\MatrixBlock',1,0,'2018-01-02 21:14:07','2018-01-02 22:04:04','ad5bd676-08a9-4462-b53c-2f7d93883f4d'),
	(19,11,'craft\\elements\\MatrixBlock',1,0,'2018-01-02 21:14:07','2018-01-02 22:04:04','0b6c2628-ec48-4890-8991-1dd68954d4c0'),
	(20,8,'craft\\elements\\MatrixBlock',1,0,'2018-01-02 21:14:07','2018-01-02 22:04:04','1a1e3ebc-06ad-4c6e-a5c0-01bb88f9a9c2'),
	(21,10,'craft\\elements\\MatrixBlock',1,0,'2018-01-02 21:14:07','2018-01-02 22:04:04','9d019405-5582-41a9-9b9b-6e1a03430e5c'),
	(22,9,'craft\\elements\\MatrixBlock',1,0,'2018-01-02 21:14:07','2018-01-02 22:04:04','3e16082c-cb97-4233-9911-3745093f7a14'),
	(23,10,'craft\\elements\\MatrixBlock',1,0,'2018-01-02 21:14:07','2018-01-02 22:04:04','2705a724-3935-4727-ab48-7939f1758efb'),
	(24,9,'craft\\elements\\MatrixBlock',1,0,'2018-01-02 21:14:07','2018-01-02 22:04:04','4458b6dc-ccf2-476b-ace3-ae79f68ec03d'),
	(25,10,'craft\\elements\\MatrixBlock',1,0,'2018-01-02 21:14:07','2018-01-02 22:04:04','0ae7705d-8d4f-4caa-b0e9-b42c83cd5825'),
	(26,12,'craft\\elements\\Category',1,0,'2018-01-02 22:01:22','2018-02-13 17:47:01','577d52dd-d511-4abd-a47f-111bb747f9d3'),
	(27,12,'craft\\elements\\Category',1,0,'2018-01-02 22:03:40','2018-02-13 17:47:01','c74bb61c-6559-473d-8bcf-5f56aa1bd910'),
	(28,5,'craft\\elements\\Entry',1,0,'2018-01-29 20:12:51','2018-01-29 20:12:51','2a824747-9eed-48f0-b63e-dfac0b93e7b7'),
	(29,5,'craft\\elements\\Entry',1,0,'2018-01-30 21:02:58','2018-01-30 21:02:58','4362e7dc-2806-42a0-a030-c89def4b38d1'),
	(30,13,'craft\\elements\\GlobalSet',1,0,'2018-01-30 22:07:08','2018-02-13 17:47:01','03c29a5e-2128-4497-9c21-4e240d7a148a');

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
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
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
	(1,1,1,NULL,NULL,1,'2017-12-29 17:38:45','2018-02-07 19:36:12','da56dabf-1ae0-4cd2-af4c-729c921c69c5'),
	(2,2,1,'perfect-espresso','drinks/perfect-espresso',1,'2017-12-29 22:10:38','2018-02-15 17:14:00','9ba469c7-ea66-401a-bac8-6d8cca277483'),
	(3,3,1,'crafty-coffee-is-open-for-business','news/crafty-coffee-is-open-for-business',1,'2017-12-29 22:14:23','2018-01-02 19:50:52','816f9eee-db69-430b-8ff2-ae46aaea5a0e'),
	(5,5,1,'homepage','',1,'2017-12-29 22:21:08','2018-02-09 15:45:35','80613393-8805-4fb0-8ff9-f570ece7606b'),
	(6,6,1,NULL,NULL,1,'2017-12-29 22:42:22','2018-02-13 17:47:01','6999ba84-71ed-4d35-8813-7c3f2467afc4'),
	(7,7,1,'about','about',1,'2017-12-29 22:52:18','2017-12-29 23:06:04','80352a04-5058-408e-84de-96b4cb077987'),
	(8,8,1,'locations','about/locations',1,'2017-12-29 22:52:28','2018-01-02 20:31:11','8ac553c8-d4dc-4c27-ad2e-205829e3b435'),
	(9,9,1,'austin-tx','about/locations/austin-tx',1,'2017-12-29 22:53:01','2018-01-02 20:31:45','21bcec6e-2d91-4f08-9b75-fcc030026bfe'),
	(10,10,1,'founders','about/founders',1,'2017-12-29 22:58:50','2018-01-29 20:12:13','50e39878-6751-467c-834b-e57744c04602'),
	(11,11,1,NULL,NULL,1,'2018-01-02 17:41:40','2018-02-13 17:47:01','ee790f7f-15a4-4e46-92cd-f75c0de5c982'),
	(12,12,1,'japanese-iced-coffee','drinks/japanese-iced-coffee',1,'2018-01-02 17:42:03','2018-02-15 17:19:26','b0295c6e-93ca-4ee8-8f26-e9e6624f80d0'),
	(13,13,1,'perfect-espresso','recipes/perfect-espresso',1,'2018-01-02 21:14:07','2018-01-02 22:04:04','08906c53-c167-4667-96c9-8ad38a5e7277'),
	(14,14,1,NULL,NULL,1,'2018-01-02 21:14:07','2018-01-02 22:04:04','69e743e7-29f2-4d9f-9d74-92d3fc26c08c'),
	(15,15,1,NULL,NULL,1,'2018-01-02 21:14:07','2018-01-02 22:04:04','958031cc-e215-4046-8ea8-a25908198bcd'),
	(16,16,1,NULL,NULL,1,'2018-01-02 21:14:07','2018-01-02 22:04:04','50e2fa1d-d643-403f-a6ff-71945e661680'),
	(17,17,1,NULL,NULL,1,'2018-01-02 21:14:07','2018-01-02 22:04:04','b91dd5b4-d687-413d-a52b-ea042ced2084'),
	(18,18,1,NULL,NULL,1,'2018-01-02 21:14:07','2018-01-02 22:04:04','47a78a16-2a8c-4142-9081-2dd56d16400d'),
	(19,19,1,NULL,NULL,1,'2018-01-02 21:14:07','2018-01-02 22:04:04','532ae670-db9c-4cbe-bcd9-566d93622016'),
	(20,20,1,NULL,NULL,1,'2018-01-02 21:14:07','2018-01-02 22:04:04','11ba46ed-c022-4696-be3e-94827fafff13'),
	(21,21,1,NULL,NULL,1,'2018-01-02 21:14:07','2018-01-02 22:04:04','6be4ad88-6863-4efa-b0e7-e54f0b25b307'),
	(22,22,1,NULL,NULL,1,'2018-01-02 21:14:07','2018-01-02 22:04:04','b6e9121f-f40e-4950-abb1-bb801ee4af0e'),
	(23,23,1,NULL,NULL,1,'2018-01-02 21:14:07','2018-01-02 22:04:04','1fc90966-7c09-433f-86f7-835a45984f0e'),
	(24,24,1,NULL,NULL,1,'2018-01-02 21:14:07','2018-01-02 22:04:04','e81bca07-ea0a-4c00-a646-a38118315f6c'),
	(25,25,1,NULL,NULL,1,'2018-01-02 21:14:07','2018-01-02 22:04:04','6db2e162-4916-4137-9662-6f6bf48cbc61'),
	(26,26,1,'espresso','styles/espresso',1,'2018-01-02 22:01:22','2018-02-13 17:47:01','9143880d-7aa6-4e00-953d-c168b9a14f2c'),
	(27,27,1,'iced-coffee','styles/iced-coffee',1,'2018-01-02 22:03:40','2018-02-13 17:47:01','090c6613-751f-449d-a97c-80294679b957'),
	(28,28,1,'chapel-hill-nc','about/locations/chapel-hill-nc',1,'2018-01-29 20:12:51','2018-01-29 20:12:51','8a5be86e-68bd-4ac7-a369-21501aaa37c2'),
	(29,29,1,'hamburg-germany','about/locations/hamburg-germany',1,'2018-01-30 21:02:59','2018-01-30 21:02:59','9ee457e6-a8a7-4201-9e5a-622be9817a04'),
	(30,30,1,NULL,NULL,1,'2018-01-30 22:07:08','2018-02-13 17:47:01','90b44515-cb71-4bf5-9d62-85bcf56d1432'),
	(31,11,2,NULL,NULL,1,'2018-02-09 15:28:52','2018-02-13 17:47:01','4319698c-3303-43a7-93a8-4c63b136343c'),
	(32,6,2,NULL,NULL,1,'2018-02-09 15:28:52','2018-02-13 17:47:01','cb855c7b-1d98-46d7-be47-35658da52466'),
	(33,26,2,'espresso','styles/espresso',1,'2018-02-09 15:28:52','2018-02-13 17:47:01','7e7457ba-8d2a-4a69-b869-aaf762b3f93e'),
	(34,27,2,'iced-coffee','styles/iced-coffee',1,'2018-02-09 15:28:52','2018-02-13 17:47:01','a5991989-d4e8-4932-adec-44995e55531a'),
	(35,30,2,NULL,NULL,1,'2018-02-09 15:28:52','2018-02-13 17:47:01','6238f910-94e1-4ef3-b456-fa8088351886'),
	(36,5,2,'homepage','__home__',1,'2018-02-09 15:29:44','2018-02-09 15:45:35','617da2bc-e9c8-43ef-b79a-bd187cdcfe36'),
	(37,12,2,'japanischer-eiskaffee','getraenke/japanischer-eiskaffee',1,'2018-02-09 15:32:05','2018-02-15 17:19:26','87ef4b77-26e9-4a8c-b714-b7782a34504f'),
	(38,2,2,'perfect-espresso','getraenke/perfect-espresso',1,'2018-02-09 15:32:06','2018-02-15 17:14:00','15465b1b-ab89-46a9-9a54-820a68b641d4'),
	(39,11,3,NULL,NULL,1,'2018-02-13 17:47:01','2018-02-13 17:47:01','bb2fb685-3c5a-4c01-b50c-340bd85c35c6'),
	(40,6,3,NULL,NULL,1,'2018-02-13 17:47:01','2018-02-13 17:47:01','fa0c552b-b305-475a-ab66-13cfc99cbcc2'),
	(41,26,3,'espresso','styles/espresso',1,'2018-02-13 17:47:01','2018-02-13 17:47:01','d9979e9a-879b-4c61-878d-412bf4ddc3ea'),
	(42,27,3,'iced-coffee','styles/iced-coffee',1,'2018-02-13 17:47:01','2018-02-13 17:47:01','db4ca758-70f7-4958-8a18-5d1d0fbdbf3a'),
	(43,30,3,NULL,NULL,1,'2018-02-13 17:47:01','2018-02-13 17:47:01','6dbf7e64-d31c-4ce9-a489-9dbccf678733'),
	(44,12,3,'japanese-iced-coffee','drinks/japanese-iced-coffee',1,'2018-02-15 17:14:00','2018-02-15 17:19:26','c6b0bea9-c90f-4723-b7d8-97a070de0c61'),
	(45,2,3,'perfect-espresso','drinks/perfect-espresso',1,'2018-02-15 17:14:00','2018-02-15 17:14:00','043c09f9-1960-4e60-8a7a-57486ddb1583');

/*!40000 ALTER TABLE `elements_sites` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table entries
# ------------------------------------------------------------

DROP TABLE IF EXISTS `entries`;

CREATE TABLE `entries` (
  `id` int(11) NOT NULL,
  `sectionId` int(11) NOT NULL,
  `typeId` int(11) NOT NULL,
  `authorId` int(11) DEFAULT NULL,
  `postDate` datetime DEFAULT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `entries_postDate_idx` (`postDate`),
  KEY `entries_expiryDate_idx` (`expiryDate`),
  KEY `entries_authorId_idx` (`authorId`),
  KEY `entries_sectionId_idx` (`sectionId`),
  KEY `entries_typeId_idx` (`typeId`),
  CONSTRAINT `entries_authorId_fk` FOREIGN KEY (`authorId`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entries_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entries_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entries_typeId_fk` FOREIGN KEY (`typeId`) REFERENCES `entrytypes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `entries` WRITE;
/*!40000 ALTER TABLE `entries` DISABLE KEYS */;

INSERT INTO `entries` (`id`, `sectionId`, `typeId`, `authorId`, `postDate`, `expiryDate`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(2,1,1,1,'2017-12-29 22:10:00',NULL,'2017-12-29 22:10:38','2018-02-15 17:14:00','9e55907c-c5f1-4921-91da-17aa1f5ca015'),
	(3,2,2,1,'2017-12-29 22:14:00',NULL,'2017-12-29 22:14:23','2018-01-02 19:50:52','58263198-300b-4fa2-b38b-fcfb8a32102a'),
	(5,3,3,NULL,'2017-12-29 22:21:08',NULL,'2017-12-29 22:21:08','2018-02-09 15:45:35','e3b1ea28-0b77-42b7-80de-d7739b63ea50'),
	(7,4,4,1,'2017-12-29 22:52:00',NULL,'2017-12-29 22:52:18','2017-12-29 23:06:04','3b6fb6bb-d7cb-4eeb-9605-e5135d5561da'),
	(8,4,4,1,'2017-12-29 22:52:00',NULL,'2017-12-29 22:52:28','2018-01-02 20:31:11','bc37fd25-c51d-40b1-9267-fae4dcdbe0db'),
	(9,4,4,1,'2017-12-29 22:53:00',NULL,'2017-12-29 22:53:01','2018-01-02 20:31:45','cc35cd33-59be-4e6f-888d-954a2d0aefad'),
	(10,4,4,1,'2017-12-29 22:58:50',NULL,'2017-12-29 22:58:50','2017-12-29 23:05:42','210f7319-3836-44fa-be35-6a9b67931fc9'),
	(12,1,1,1,'2018-01-02 17:42:00',NULL,'2018-01-02 17:42:03','2018-02-15 17:19:26','3ad8fb3e-3c28-427b-9d76-67f9b1ecad05'),
	(13,5,5,1,'2018-01-02 21:14:00',NULL,'2018-01-02 21:14:07','2018-01-02 22:04:04','d62496f2-fe7c-4bab-8c32-229c0ae416ec'),
	(28,4,4,1,'2018-01-29 20:12:51',NULL,'2018-01-29 20:12:51','2018-01-29 20:12:51','fe2fb77d-6e30-485a-afcb-f29bdc2d6ebc'),
	(29,4,4,1,'2018-01-30 21:02:58',NULL,'2018-01-30 21:02:59','2018-01-30 21:02:59','f90453ca-5a64-473d-91f2-95c1131b4f1b');

/*!40000 ALTER TABLE `entries` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table entrydrafts
# ------------------------------------------------------------

DROP TABLE IF EXISTS `entrydrafts`;

CREATE TABLE `entrydrafts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `entryId` int(11) NOT NULL,
  `sectionId` int(11) NOT NULL,
  `creatorId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `notes` text,
  `data` mediumtext NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `entrydrafts_sectionId_idx` (`sectionId`),
  KEY `entrydrafts_entryId_siteId_idx` (`entryId`,`siteId`),
  KEY `entrydrafts_siteId_idx` (`siteId`),
  KEY `entrydrafts_creatorId_idx` (`creatorId`),
  CONSTRAINT `entrydrafts_creatorId_fk` FOREIGN KEY (`creatorId`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entrydrafts_entryId_fk` FOREIGN KEY (`entryId`) REFERENCES `entries` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entrydrafts_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entrydrafts_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table entrytypes
# ------------------------------------------------------------

DROP TABLE IF EXISTS `entrytypes`;

CREATE TABLE `entrytypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sectionId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `hasTitleField` tinyint(1) NOT NULL DEFAULT '1',
  `titleLabel` varchar(255) DEFAULT 'Title',
  `titleFormat` varchar(255) DEFAULT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `entrytypes_name_sectionId_unq_idx` (`name`,`sectionId`),
  UNIQUE KEY `entrytypes_handle_sectionId_unq_idx` (`handle`,`sectionId`),
  KEY `entrytypes_sectionId_idx` (`sectionId`),
  KEY `entrytypes_fieldLayoutId_idx` (`fieldLayoutId`),
  CONSTRAINT `entrytypes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `entrytypes_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `entrytypes` WRITE;
/*!40000 ALTER TABLE `entrytypes` DISABLE KEYS */;

INSERT INTO `entrytypes` (`id`, `sectionId`, `fieldLayoutId`, `name`, `handle`, `hasTitleField`, `titleLabel`, `titleFormat`, `sortOrder`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,1,1,'Drinks','drinks',1,'Drink Name',NULL,1,'2017-12-29 21:48:32','2018-01-02 22:32:52','eabce138-b2f3-449e-af77-aba1bf89a051'),
	(2,2,2,'News','news',1,'Headline',NULL,1,'2017-12-29 21:58:58','2017-12-29 22:16:56','f9557e52-0255-4777-96a7-14a37a410399'),
	(3,3,3,'Homepage','homepage',0,NULL,'{section.name|raw}',1,'2017-12-29 22:21:08','2018-02-09 15:45:34','f650a556-a6ad-4367-a5c0-251030e0aa78'),
	(4,4,5,'About','about',1,'Page Title',NULL,1,'2017-12-29 22:51:48','2017-12-29 23:05:42','9d2b0781-25c2-4db1-b6bf-0de153e2c02d'),
	(5,5,6,'Recipes','recipes',1,'Title',NULL,1,'2018-01-02 20:57:56','2018-01-02 22:02:49','09ac828e-bcdd-4210-9bec-e8e3d37297e0');

/*!40000 ALTER TABLE `entrytypes` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table entryversions
# ------------------------------------------------------------

DROP TABLE IF EXISTS `entryversions`;

CREATE TABLE `entryversions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `entryId` int(11) NOT NULL,
  `sectionId` int(11) NOT NULL,
  `creatorId` int(11) DEFAULT NULL,
  `siteId` int(11) NOT NULL,
  `num` smallint(6) unsigned NOT NULL,
  `notes` text,
  `data` mediumtext NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `entryversions_sectionId_idx` (`sectionId`),
  KEY `entryversions_entryId_siteId_idx` (`entryId`,`siteId`),
  KEY `entryversions_siteId_idx` (`siteId`),
  KEY `entryversions_creatorId_idx` (`creatorId`),
  CONSTRAINT `entryversions_creatorId_fk` FOREIGN KEY (`creatorId`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `entryversions_entryId_fk` FOREIGN KEY (`entryId`) REFERENCES `entries` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entryversions_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entryversions_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `entryversions` WRITE;
/*!40000 ALTER TABLE `entryversions` DISABLE KEYS */;

INSERT INTO `entryversions` (`id`, `entryId`, `sectionId`, `creatorId`, `siteId`, `num`, `notes`, `data`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,2,1,1,1,1,'','{\"typeId\":\"1\",\"authorId\":\"1\",\"title\":\"Perfect Espresso\",\"slug\":\"perfect-espresso\",\"postDate\":1514585438,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"1\":\"This is an introduction to the Espresso drink.\",\"2\":\"<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?</p><p>At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga. Et harum quidem rerum facilis est et expedita distinctio. Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quo minus id quod maxime placeat facere possimus, omnis voluptas assumenda est, omnis dolor repellendus. Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet ut et voluptates repudiandae sint et molestiae non recusandae. Itaque earum rerum hic tenetur a sapiente delectus, ut aut reiciendis voluptatibus maiores alias consequatur aut perferendis doloribus asperiores repellat.</p>\"}}','2017-12-29 22:10:38','2017-12-29 22:10:38','fb71ac98-b6fd-4e6e-8eff-457816c3eaf7'),
	(2,3,2,1,1,1,'','{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"Crafty Coffee is Open for Business\",\"slug\":\"crafty-coffee-is-open-for-business\",\"postDate\":1514585663,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"4\":\"<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?</p><p>At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga. Et harum quidem rerum facilis est et expedita distinctio. Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quo minus id quod maxime placeat facere possimus, omnis voluptas assumenda est, omnis dolor repellendus. Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet ut et voluptates repudiandae sint et molestiae non recusandae. Itaque earum rerum hic tenetur a sapiente delectus, ut aut reiciendis voluptatibus maiores alias consequatur aut perferendis doloribus asperiores repellat.</p>\",\"3\":\"If you\'re craving the best coffee in town, we\'ve got it.\"}}','2017-12-29 22:14:23','2017-12-29 22:14:23','14d37c87-4692-4972-80a8-0ccc211d1102'),
	(4,2,1,1,1,2,'','{\"typeId\":\"1\",\"authorId\":\"1\",\"title\":\"Perfect Espresso\",\"slug\":\"perfect-espresso\",\"postDate\":1514585400,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"5\":[\"6\"],\"1\":\"This is an introduction to the Espresso drink.\",\"2\":\"<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?</p><p>At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga. Et harum quidem rerum facilis est et expedita distinctio. Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quo minus id quod maxime placeat facere possimus, omnis voluptas assumenda est, omnis dolor repellendus. Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet ut et voluptates repudiandae sint et molestiae non recusandae. Itaque earum rerum hic tenetur a sapiente delectus, ut aut reiciendis voluptatibus maiores alias consequatur aut perferendis doloribus asperiores repellat.</p>\"}}','2017-12-29 22:42:41','2017-12-29 22:42:41','4fdafd32-2cbb-41b0-8564-d0ea2d7c3333'),
	(5,7,4,1,1,1,'','{\"typeId\":\"4\",\"authorId\":\"1\",\"title\":\"About Crafty Coffee\",\"slug\":\"about-crafty-coffee\",\"postDate\":1514587938,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":[]}','2017-12-29 22:52:18','2017-12-29 22:52:18','cf4b720e-82e7-42ff-8f40-7b65ffeb1aea'),
	(6,8,4,1,1,1,'','{\"typeId\":\"4\",\"authorId\":\"1\",\"title\":\"Locations\",\"slug\":\"locations\",\"postDate\":1514587948,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":[]}','2017-12-29 22:52:28','2017-12-29 22:52:28','de8d27e8-6446-496e-8d24-3b48d1238787'),
	(7,9,4,1,1,1,'','{\"typeId\":\"4\",\"authorId\":\"1\",\"title\":\"Austin, TX\",\"slug\":\"austin-tx\",\"postDate\":1514587981,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"8\",\"fields\":[]}','2017-12-29 22:53:01','2017-12-29 22:53:01','05d4897c-72c2-4ff1-b1ee-eb2394b17c14'),
	(8,7,4,1,1,2,'','{\"typeId\":\"4\",\"authorId\":\"1\",\"title\":\"About Crafty Coffee\",\"slug\":\"about\",\"postDate\":1514587920,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":[]}','2017-12-29 22:54:34','2017-12-29 22:54:34','a2722993-be37-45a7-992a-5ec294888470'),
	(9,10,4,1,1,1,'','{\"typeId\":\"4\",\"authorId\":\"1\",\"title\":\"Founders\",\"slug\":\"founders\",\"postDate\":1514588330,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":[]}','2017-12-29 22:58:50','2017-12-29 22:58:50','5617e3e8-5b33-467b-8e66-467b7c3e2e81'),
	(10,7,4,1,1,3,'','{\"typeId\":\"4\",\"authorId\":\"1\",\"title\":\"About Crafty Coffee\",\"slug\":\"about\",\"postDate\":1514587920,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"2\":\"<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?</p><p>At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga. Et harum quidem rerum facilis est et expedita distinctio. Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quo minus id quod maxime placeat facere possimus, omnis voluptas assumenda est, omnis dolor repellendus. Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet ut et voluptates repudiandae sint et molestiae non recusandae. Itaque earum rerum hic tenetur a sapiente delectus, ut aut reiciendis voluptatibus maiores alias consequatur aut perferendis doloribus asperiores repellat.</p>\",\"7\":\"Everything you ever needed to know.\",\"6\":\"How it happened.\"}}','2017-12-29 23:06:04','2017-12-29 23:06:04','4f8e45e0-b06d-4994-8c66-dc1aadeed81f'),
	(11,12,1,1,1,1,'','{\"typeId\":\"1\",\"authorId\":\"1\",\"title\":\"Japanese Iced Coffee\",\"slug\":\"japanese-iced-coffee\",\"postDate\":1514914923,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"5\":[\"11\"],\"1\":\"The best iced coffee ever.\",\"2\":\"<p>This is the page copy.</p>\"}}','2018-01-02 17:42:03','2018-01-02 17:42:03','ccc460ee-fea4-45dd-b7b9-f2a76949a454'),
	(12,3,2,1,1,2,'','{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"Crafty Coffee is Open for Business\",\"slug\":\"crafty-coffee-is-open-for-business\",\"postDate\":1514585640,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"4\":\"<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam volup<a href=\\\"https://mijingo.com\\\">tatem quia voluptas sit aspernatur aut odit aut fugit, se</a>d quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?</p><p>At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga. Et harum quidem rerum facilis est et expedita distinctio. Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quo minus id quod maxime placeat facere possimus, omnis voluptas assumenda est, omnis dolor repellendus. Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet ut et voluptates repudiandae sint et molestiae non recusandae. Itaque earum rerum hic tenetur a sapiente delectus, ut aut reiciendis voluptatibus maiores alias consequatur aut perferendis doloribus asperiores repellat.</p>\",\"3\":\"If you\'re craving the best coffee in town, we\'ve got it.\"}}','2018-01-02 19:49:34','2018-01-02 19:49:34','91096902-6a0d-407d-a3d4-8e085596b706'),
	(13,3,2,1,1,3,'','{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"Crafty Coffee is Open for Business\",\"slug\":\"crafty-coffee-is-open-for-business\",\"postDate\":1514585640,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"4\":\"<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam volup<a href=\\\"https://mijingo.com\\\">tatem quia voluptas sit aspernatur aut odit aut fugit, se</a>d quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?</p><blockquote><p>This is a fancy blockquote</p></blockquote><p>At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga. Et harum quidem rerum facilis est et expedita distinctio. Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quo minus id quod maxime placeat facere possimus, omnis voluptas assumenda est, omnis dolor repellendus. Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet ut et voluptates repudiandae sint et molestiae non recusandae. Itaque earum rerum hic tenetur a sapiente delectus, ut aut reiciendis voluptatibus maiores alias consequatur aut perferendis doloribus asperiores repellat.</p>\",\"3\":\"If you\'re craving the best coffee in town, we\'ve got it.\"}}','2018-01-02 19:50:52','2018-01-02 19:50:52','779fe825-6dce-4fee-a1a9-82c4bcc54cdb'),
	(14,2,1,1,1,3,'','{\"typeId\":\"1\",\"authorId\":\"1\",\"title\":\"Perfect Espresso\",\"slug\":\"perfect-espresso\",\"postDate\":1514585400,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"8\":\"2017-10-01 07:00:00\",\"5\":[\"6\"],\"1\":\"This is an introduction to the Espresso drink.\",\"2\":\"<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?</p><p>At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga. Et harum quidem rerum facilis est et expedita distinctio. Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quo minus id quod maxime placeat facere possimus, omnis voluptas assumenda est, omnis dolor repellendus. Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet ut et voluptates repudiandae sint et molestiae non recusandae. Itaque earum rerum hic tenetur a sapiente delectus, ut aut reiciendis voluptatibus maiores alias consequatur aut perferendis doloribus asperiores repellat.</p>\"}}','2018-01-02 20:06:17','2018-01-02 20:06:17','946c4bda-d157-43e9-8e31-0eec9b790014'),
	(15,12,1,1,1,2,'','{\"typeId\":\"1\",\"authorId\":\"1\",\"title\":\"Japanese Iced Coffee\",\"slug\":\"japanese-iced-coffee\",\"postDate\":1514914920,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"8\":\"2017-06-01 07:00:00\",\"5\":[\"11\"],\"1\":\"The best iced coffee ever.\",\"2\":\"<p>This is the page copy.</p>\"}}','2018-01-02 20:06:27','2018-01-02 20:06:27','effd2545-de75-431d-8352-77eadc3c69d6'),
	(16,8,4,1,1,2,'','{\"typeId\":\"4\",\"authorId\":\"1\",\"title\":\"Locations\",\"slug\":\"locations\",\"postDate\":1514587920,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"7\",\"fields\":{\"2\":\"<p>page copy</p>\",\"7\":\"This is the intro.\",\"6\":\"Where We Are\"}}','2018-01-02 20:31:11','2018-01-02 20:31:11','07598bdb-0840-440b-a6b5-4146bcfe9b49'),
	(17,9,4,1,1,2,'','{\"typeId\":\"4\",\"authorId\":\"1\",\"title\":\"Austin, TX\",\"slug\":\"austin-tx\",\"postDate\":1514587980,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"8\",\"fields\":{\"2\":\"<p>page copy</p>\",\"7\":\"Page intro\",\"6\":\"Home of the tacos.\"}}','2018-01-02 20:31:45','2018-01-02 20:31:45','5495951e-671f-4635-b664-f57ebf7c440b'),
	(18,13,5,1,1,1,'','{\"typeId\":\"5\",\"authorId\":\"1\",\"title\":\"Perfect Espresso\",\"slug\":\"perfect-espresso\",\"postDate\":1514927647,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"9\":{\"14\":{\"type\":\"recipeCopy\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"bodyContent\":\"<p>This is the body copy of the recipe.</p>\"}},\"15\":{\"type\":\"recipeImage\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"image\":[\"6\"],\"imageCaption\":\"Espresso is the best.\"}},\"16\":{\"type\":\"recipeCopy\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"bodyContent\":\"<p>I can have more copy right here.</p>\"}},\"17\":{\"type\":\"recipeTip\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"tipContent\":\"This is another tip.\"}},\"18\":{\"type\":\"recipeImage\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"image\":[\"11\"],\"imageCaption\":\"This is the caption\"}},\"19\":{\"type\":\"recipeIngredients\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"ingredients\":[{\"col1\":\"1 cup\",\"col2\":\"water\"},{\"col1\":\"18 grams\",\"col2\":\"Espresso beans\"},{\"col1\":\"1\",\"col2\":\"quality coffee grinder\"}]}},\"20\":{\"type\":\"recipeTip\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"tipContent\":\"Please only use a quality burr grinder for making espresso!\"}},\"21\":{\"type\":\"recipeSteps\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"stepsTitle\":\"Preparation\",\"stepsContent\":[{\"col1\":\"Turn on your espresso machine.\"},{\"col1\":\"Buy good beans\"},{\"col1\":\"Alert friends and family that you need to focus.\"}]}},\"22\":{\"type\":\"recipeCopy\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"bodyContent\":\"<p>This is more copy.</p><p> </p><p> </p>\"}},\"23\":{\"type\":\"recipeSteps\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"stepsTitle\":\"Grinding the Beans\",\"stepsContent\":[{\"col1\":\"Step one\"},{\"col1\":\"step two\"},{\"col1\":\"step there\"}]}},\"24\":{\"type\":\"recipeCopy\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"bodyContent\":\"<p>even more copy -- long winded!</p>\"}},\"25\":{\"type\":\"recipeSteps\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"stepsTitle\":\"Extracting the Espresso Shot\",\"stepsContent\":[{\"col1\":\"Step one\"},{\"col1\":\"Step two\"},{\"col1\":\"step three\"}]}}},\"17\":[{\"col1\":\"This is the first thing\"},{\"col1\":\"This is the second thing\"},{\"col1\":\"This is the third thing\"}]}}','2018-01-02 21:14:07','2018-01-02 21:14:07','b8de391d-f85e-4c86-b496-45bee0aa0351'),
	(19,13,5,1,1,2,'','{\"typeId\":\"5\",\"authorId\":\"1\",\"title\":\"Perfect Espresso\",\"slug\":\"perfect-espresso\",\"postDate\":1514927640,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"5\":[\"6\"],\"7\":\"This is the page intro!\",\"9\":{\"14\":{\"type\":\"recipeCopy\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"bodyContent\":\"<p>This is the body copy of the recipe.</p>\"}},\"15\":{\"type\":\"recipeImage\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"image\":[\"6\"],\"imageCaption\":\"Espresso is the best.\"}},\"16\":{\"type\":\"recipeCopy\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"bodyContent\":\"<p>I can have more copy right here.</p>\"}},\"17\":{\"type\":\"recipeTip\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"tipContent\":\"This is another tip.\"}},\"18\":{\"type\":\"recipeImage\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"image\":[\"11\"],\"imageCaption\":\"This is the caption\"}},\"19\":{\"type\":\"recipeIngredients\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"ingredients\":[{\"col1\":\"1 cup\",\"col2\":\"water\"},{\"col1\":\"18 grams\",\"col2\":\"Espresso beans\"},{\"col1\":\"1\",\"col2\":\"quality coffee grinder\"}]}},\"20\":{\"type\":\"recipeTip\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"tipContent\":\"Please only use a quality burr grinder for making espresso!\"}},\"21\":{\"type\":\"recipeSteps\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"stepsTitle\":\"Preparation\",\"stepsContent\":[{\"col1\":\"Turn on your espresso machine.\"},{\"col1\":\"Buy good beans\"},{\"col1\":\"Alert friends and family that you need to focus.\"}]}},\"22\":{\"type\":\"recipeCopy\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"bodyContent\":\"<p>This is more copy.</p><p> </p><p> </p>\"}},\"23\":{\"type\":\"recipeSteps\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"stepsTitle\":\"Grinding the Beans\",\"stepsContent\":[{\"col1\":\"Step one\"},{\"col1\":\"step two\"},{\"col1\":\"step there\"}]}},\"24\":{\"type\":\"recipeCopy\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"bodyContent\":\"<p>even more copy -- long winded!</p>\"}},\"25\":{\"type\":\"recipeSteps\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"stepsTitle\":\"Extracting the Espresso Shot\",\"stepsContent\":[{\"col1\":\"Step one\"},{\"col1\":\"Step two\"},{\"col1\":\"step three\"}]}}},\"17\":[{\"col1\":\"This is the first thing\"},{\"col1\":\"This is the second thing\"},{\"col1\":\"This is the third thing\"}]}}','2018-01-02 21:22:03','2018-01-02 21:22:03','99d57a6d-1f20-462a-8a8b-dc908d1043f9'),
	(20,13,5,1,1,3,'','{\"typeId\":\"5\",\"authorId\":\"1\",\"title\":\"Perfect Espresso\",\"slug\":\"perfect-espresso\",\"postDate\":1514927640,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"5\":[\"6\"],\"7\":\"This is the page intro!\",\"9\":{\"14\":{\"type\":\"recipeCopy\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"bodyContent\":\"<p>This is the body copy of the recipe.</p>\"}},\"17\":{\"type\":\"recipeTip\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"tipContent\":\"This is another tip.\"}},\"16\":{\"type\":\"recipeCopy\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"bodyContent\":\"<p>I can have more copy right here.</p>\"}},\"15\":{\"type\":\"recipeImage\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"image\":[\"6\"],\"imageCaption\":\"Espresso is the best.\"}},\"19\":{\"type\":\"recipeIngredients\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"ingredients\":[{\"col1\":\"1 cup\",\"col2\":\"water\"},{\"col1\":\"18 grams\",\"col2\":\"Espresso beans\"},{\"col1\":\"1\",\"col2\":\"quality coffee grinder\"}]}},\"18\":{\"type\":\"recipeImage\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"image\":[\"11\"],\"imageCaption\":\"This is the caption\"}},\"20\":{\"type\":\"recipeTip\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"tipContent\":\"Please only use a quality burr grinder for making espresso!\"}},\"21\":{\"type\":\"recipeSteps\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"stepsTitle\":\"Preparation\",\"stepsContent\":[{\"col1\":\"Turn on your espresso machine.\"},{\"col1\":\"Buy good beans\"},{\"col1\":\"Alert friends and family that you need to focus.\"}]}},\"22\":{\"type\":\"recipeCopy\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"bodyContent\":\"<p>This is more copy.</p><p> </p><p> </p>\"}},\"23\":{\"type\":\"recipeSteps\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"stepsTitle\":\"Grinding the Beans\",\"stepsContent\":[{\"col1\":\"Step one\"},{\"col1\":\"step two\"},{\"col1\":\"step there\"}]}},\"24\":{\"type\":\"recipeCopy\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"bodyContent\":\"<p>even more copy -- long winded!</p>\"}},\"25\":{\"type\":\"recipeSteps\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"stepsTitle\":\"Extracting the Espresso Shot\",\"stepsContent\":[{\"col1\":\"Step one\"},{\"col1\":\"Step two\"},{\"col1\":\"step three\"}]}}},\"17\":[{\"col1\":\"This is the first thing\"},{\"col1\":\"This is the second thing\"},{\"col1\":\"This is the third thing\"}]}}','2018-01-02 21:46:52','2018-01-02 21:46:52','e0392e74-5a42-4bdd-b5f0-1981470ad5de'),
	(21,13,5,1,1,4,'','{\"typeId\":\"5\",\"authorId\":\"1\",\"title\":\"Perfect Espresso\",\"slug\":\"perfect-espresso\",\"postDate\":1514927640,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"5\":[\"6\"],\"7\":\"This is the page intro!\",\"9\":{\"14\":{\"type\":\"recipeCopy\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"bodyContent\":\"<p>This is the body copy of the recipe.</p>\"}},\"17\":{\"type\":\"recipeTip\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"tipContent\":\"This is another tip.\"}},\"16\":{\"type\":\"recipeCopy\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"bodyContent\":\"<p>I can have more copy right here.</p>\"}},\"15\":{\"type\":\"recipeImage\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"image\":[\"6\"],\"imageCaption\":\"Espresso is the best.\"}},\"19\":{\"type\":\"recipeIngredients\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"ingredients\":[{\"col1\":\"1 cup\",\"col2\":\"water\"},{\"col1\":\"18 grams\",\"col2\":\"Espresso beans\"},{\"col1\":\"1\",\"col2\":\"quality coffee grinder\"}]}},\"18\":{\"type\":\"recipeImage\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"image\":[\"11\"],\"imageCaption\":\"This is the caption\"}},\"20\":{\"type\":\"recipeTip\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"tipContent\":\"Please only use a quality burr grinder for making espresso!\"}},\"21\":{\"type\":\"recipeSteps\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"stepsTitle\":\"Preparation\",\"stepsContent\":[{\"col1\":\"Turn on your espresso machine.\"},{\"col1\":\"Buy good beans\"},{\"col1\":\"Alert friends and family that you need to focus.\"}]}},\"22\":{\"type\":\"recipeCopy\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"bodyContent\":\"<p>This is more copy.</p><p> </p><p> </p>\"}},\"23\":{\"type\":\"recipeSteps\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"stepsTitle\":\"Grinding the Beans\",\"stepsContent\":[{\"col1\":\"Step one\"},{\"col1\":\"step two\"},{\"col1\":\"step there\"}]}},\"24\":{\"type\":\"recipeCopy\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"bodyContent\":\"<p>even more copy -- long winded!</p>\"}},\"25\":{\"type\":\"recipeSteps\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"stepsTitle\":\"Extracting the Espresso Shot\",\"stepsContent\":[{\"col1\":\"Step one\"},{\"col1\":\"Step two\"},{\"col1\":\"step three\"}]}}},\"17\":[{\"col1\":\"This is the first thing\"},{\"col1\":\"This is the second thing\"},{\"col1\":\"This is the third thing\"}],\"19\":[\"27\"]}}','2018-01-02 22:03:49','2018-01-02 22:03:49','f2349c41-e0c7-4921-b3cb-252308ad452e'),
	(22,13,5,1,1,5,'','{\"typeId\":\"5\",\"authorId\":\"1\",\"title\":\"Perfect Espresso\",\"slug\":\"perfect-espresso\",\"postDate\":1514927640,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"5\":[\"6\"],\"7\":\"This is the page intro!\",\"9\":{\"14\":{\"type\":\"recipeCopy\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"bodyContent\":\"<p>This is the body copy of the recipe.</p>\"}},\"17\":{\"type\":\"recipeTip\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"tipContent\":\"This is another tip.\"}},\"16\":{\"type\":\"recipeCopy\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"bodyContent\":\"<p>I can have more copy right here.</p>\"}},\"15\":{\"type\":\"recipeImage\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"image\":[\"6\"],\"imageCaption\":\"Espresso is the best.\"}},\"19\":{\"type\":\"recipeIngredients\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"ingredients\":[{\"col1\":\"1 cup\",\"col2\":\"water\"},{\"col1\":\"18 grams\",\"col2\":\"Espresso beans\"},{\"col1\":\"1\",\"col2\":\"quality coffee grinder\"}]}},\"18\":{\"type\":\"recipeImage\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"image\":[\"11\"],\"imageCaption\":\"This is the caption\"}},\"20\":{\"type\":\"recipeTip\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"tipContent\":\"Please only use a quality burr grinder for making espresso!\"}},\"21\":{\"type\":\"recipeSteps\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"stepsTitle\":\"Preparation\",\"stepsContent\":[{\"col1\":\"Turn on your espresso machine.\"},{\"col1\":\"Buy good beans\"},{\"col1\":\"Alert friends and family that you need to focus.\"}]}},\"22\":{\"type\":\"recipeCopy\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"bodyContent\":\"<p>This is more copy.</p><p> </p><p> </p>\"}},\"23\":{\"type\":\"recipeSteps\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"stepsTitle\":\"Grinding the Beans\",\"stepsContent\":[{\"col1\":\"Step one\"},{\"col1\":\"step two\"},{\"col1\":\"step there\"}]}},\"24\":{\"type\":\"recipeCopy\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"bodyContent\":\"<p>even more copy -- long winded!</p>\"}},\"25\":{\"type\":\"recipeSteps\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"stepsTitle\":\"Extracting the Espresso Shot\",\"stepsContent\":[{\"col1\":\"Step one\"},{\"col1\":\"Step two\"},{\"col1\":\"step three\"}]}}},\"17\":[{\"col1\":\"This is the first thing\"},{\"col1\":\"This is the second thing\"},{\"col1\":\"This is the third thing\"}],\"19\":[\"26\"]}}','2018-01-02 22:04:04','2018-01-02 22:04:04','04aef398-8cd6-49ba-b3f2-f90141dfc3f3'),
	(23,2,1,1,1,4,'','{\"typeId\":\"1\",\"authorId\":\"1\",\"title\":\"Perfect Espresso\",\"slug\":\"perfect-espresso\",\"postDate\":1514585400,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"8\":\"2017-10-01 07:00:00\",\"5\":[\"6\"],\"1\":\"This is an introduction to the Espresso drink.\",\"2\":\"<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?</p><p>At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga. Et harum quidem rerum facilis est et expedita distinctio. Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quo minus id quod maxime placeat facere possimus, omnis voluptas assumenda est, omnis dolor repellendus. Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet ut et voluptates repudiandae sint et molestiae non recusandae. Itaque earum rerum hic tenetur a sapiente delectus, ut aut reiciendis voluptatibus maiores alias consequatur aut perferendis doloribus asperiores repellat.</p>\",\"19\":[\"26\"]}}','2018-01-02 22:14:31','2018-01-02 22:14:31','b8c832e1-187b-43aa-a857-5100710b610b'),
	(24,2,1,1,1,5,'','{\"typeId\":\"1\",\"authorId\":\"1\",\"title\":\"Perfect Espresso\",\"slug\":\"perfect-espresso\",\"postDate\":1514585400,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"8\":\"2017-10-01 07:00:00\",\"5\":[\"6\"],\"1\":\"This is an introduction to the Espresso drink.\",\"2\":\"<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?</p><p>At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga. Et harum quidem rerum facilis est et expedita distinctio. Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quo minus id quod maxime placeat facere possimus, omnis voluptas assumenda est, omnis dolor repellendus. Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet ut et voluptates repudiandae sint et molestiae non recusandae. Itaque earum rerum hic tenetur a sapiente delectus, ut aut reiciendis voluptatibus maiores alias consequatur aut perferendis doloribus asperiores repellat.</p>\",\"20\":[\"13\"],\"19\":[\"26\"]}}','2018-01-02 22:33:12','2018-01-02 22:33:12','2d5ad3ea-6380-4ebb-b600-6a4ba501feb9'),
	(25,28,4,1,1,1,'','{\"typeId\":\"4\",\"authorId\":\"1\",\"title\":\"Chapel Hill, NC\",\"slug\":\"chapel-hill-nc\",\"postDate\":1517256771,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"8\",\"fields\":{\"2\":\"<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>\",\"7\":\"Home of the best basketball team on the planet.\",\"6\":\"Our newest location.\"}}','2018-01-29 20:12:51','2018-01-29 20:12:51','ba74bdf6-ca4a-450b-bdb8-1cbf28bf939f'),
	(26,29,4,1,1,1,'','{\"typeId\":\"4\",\"authorId\":\"1\",\"title\":\"Hamburg, Germany\",\"slug\":\"hamburg-germany\",\"postDate\":1517346178,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"8\",\"fields\":{\"2\":\"<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>\",\"7\":\"\",\"6\":\"\"}}','2018-01-30 21:02:59','2018-01-30 21:02:59','e9893a03-a56a-4c06-bde4-bb9cbb9fc31e'),
	(27,12,1,1,2,1,'Revision from Feb 9, 2018, 7:32:05 AM','{\"typeId\":\"1\",\"authorId\":\"1\",\"title\":\"Japanese Iced Coffee\",\"slug\":\"japanese-iced-coffee\",\"postDate\":1514914920,\"expiryDate\":null,\"enabled\":\"1\",\"newParentId\":null,\"fields\":{\"8\":\"2017-06-01 07:00:00\",\"5\":[\"11\"],\"1\":\"The best iced coffee ever.\",\"2\":\"<p>This is the page copy.</p>\",\"20\":[],\"19\":[]}}','2018-02-09 15:36:22','2018-02-09 15:36:22','cb87b640-beff-4589-92da-b2ea8b566e82'),
	(28,12,1,1,2,2,'','{\"typeId\":\"1\",\"authorId\":\"1\",\"title\":\"Japanischer Eiskaffee\",\"slug\":\"japanischer-eiskaffee\",\"postDate\":1514914920,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"8\":\"2017-06-01 07:00:00\",\"5\":[\"11\"],\"1\":\"Der beste Eiskaffe im Leben.\",\"2\":\"<p>Hier wird was geschrieben.</p>\",\"20\":[],\"19\":[\"27\"]}}','2018-02-09 15:36:22','2018-02-09 15:36:22','548af891-66cc-452a-8f26-55ac8f09e294'),
	(29,12,1,1,2,3,'','{\"typeId\":\"1\",\"authorId\":\"1\",\"title\":\"Japanischer Eiskaffee\",\"slug\":\"japanischer-eiskaffee\",\"postDate\":1514914920,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"8\":\"2017-06-01 07:00:00\",\"5\":[\"11\"],\"1\":\"Der beste Eiskaffe im Leben.\",\"2\":\"<p>Hier wird was geschrieben.</p>\",\"20\":[],\"19\":[\"27\"]}}','2018-02-15 17:08:42','2018-02-15 17:08:42','835b4346-945e-4947-9710-fe09ec1c072e'),
	(30,12,1,1,1,3,'','{\"typeId\":\"1\",\"authorId\":\"1\",\"title\":\"Japanese Iced Coffee\",\"slug\":\"japanese-iced-coffee\",\"postDate\":1514914920,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"8\":\"2017-06-01 07:00:00\",\"5\":[\"11\"],\"1\":\"The best coffee of your life.\",\"2\":\"<p>Hier wird was geschrieben.</p>\",\"20\":[],\"19\":[\"27\"]}}','2018-02-15 17:09:00','2018-02-15 17:09:00','c00922a1-4688-4220-a59f-a43d04349600'),
	(31,12,1,1,3,1,'Revision from Feb 15, 2018, 9:14:00 AM','{\"typeId\":\"1\",\"authorId\":\"1\",\"title\":\"Japanese Iced Coffee\",\"slug\":\"japanese-iced-coffee\",\"postDate\":1514914920,\"expiryDate\":null,\"enabled\":\"1\",\"newParentId\":null,\"fields\":{\"8\":\"2017-06-01 07:00:00\",\"5\":[\"11\"],\"1\":\"The best coffee of your life.\",\"2\":\"<p>Hier wird was geschrieben.</p>\",\"20\":[],\"19\":[\"27\"]}}','2018-02-15 17:14:15','2018-02-15 17:14:15','3406aaa9-c169-46e6-b80d-eb312be06f9b'),
	(32,12,1,1,3,2,'','{\"typeId\":\"1\",\"authorId\":\"1\",\"title\":\"Japanese Iced Coffee\",\"slug\":\"japanese-iced-coffee\",\"postDate\":1514914920,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"8\":\"2017-06-01 07:00:00\",\"5\":[\"11\"],\"1\":\"The best coffee of your life. Roasterei\",\"2\":\"<p>Hier wird was geschrieben.</p>\",\"20\":[],\"19\":[\"27\"]}}','2018-02-15 17:14:15','2018-02-15 17:14:15','be9967be-e17f-41af-9454-8af4906166b8'),
	(33,12,1,1,1,4,'','{\"typeId\":\"1\",\"authorId\":\"1\",\"title\":\"Japanese Iced Coffee\",\"slug\":\"japanese-iced-coffee\",\"postDate\":1514914920,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"8\":\"2017-06-01 07:00:00\",\"5\":[\"11\"],\"1\":\"The best coffee of your life.\",\"2\":\"<p>Hier wird was geschrieben.</p>\",\"20\":[],\"19\":[\"27\"]}}','2018-02-15 17:16:00','2018-02-15 17:16:00','54537e5e-99ac-4380-b96b-7ce6791c23eb'),
	(34,12,1,1,1,5,'','{\"typeId\":\"1\",\"authorId\":\"1\",\"title\":\"Japanese Iced Coffee\",\"slug\":\"japanese-iced-coffee\",\"postDate\":1514914920,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"8\":\"2017-06-01 07:00:00\",\"5\":[\"11\"],\"1\":\"The best coffee of your life.\",\"2\":\"<p>crafty coffee</p>\",\"20\":[],\"19\":[\"27\"]}}','2018-02-15 17:16:19','2018-02-15 17:16:19','9a2cc586-8451-4f4a-806b-e3e85fb7c5de'),
	(35,12,1,1,2,4,'','{\"typeId\":\"1\",\"authorId\":\"1\",\"title\":\"Japanischer Eiskaffee\",\"slug\":\"japanischer-eiskaffee\",\"postDate\":1514914920,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"8\":\"2017-06-01 07:00:00\",\"5\":[\"11\"],\"1\":\"Der beste Eiskaffe im Leben. DE\",\"2\":\"<p>Hier wird was geschrieben.</p>\",\"20\":[],\"19\":[\"27\"]}}','2018-02-15 17:19:26','2018-02-15 17:19:26','5327e974-c2e2-4678-9ac7-b31aa2c8e425');

/*!40000 ALTER TABLE `entryversions` ENABLE KEYS */;
UNLOCK TABLES;


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
	(1,'Common','2017-12-29 17:38:45','2017-12-29 17:38:45','0737b893-d941-47d2-93b0-33208f4486e0'),
	(2,'Drinks','2017-12-29 21:52:04','2017-12-29 21:52:04','319cb121-191a-4bdb-ad8f-c782feaef564'),
	(3,'General','2017-12-29 21:52:10','2017-12-29 21:52:10','fa050bd7-0ea9-49bf-b3d8-cb45bee0c25e'),
	(4,'News','2017-12-29 21:59:18','2017-12-29 21:59:18','b4532ef1-5542-49bb-8d2a-984a68900f6d'),
	(5,'About','2017-12-29 23:04:23','2017-12-29 23:04:23','eade4d0e-154d-4fa6-9ec4-6b117060ced3'),
	(6,'Recipes','2018-01-02 20:58:18','2018-01-02 20:58:18','420b4f9d-733a-47e6-9031-bbdfb7754c81'),
	(7,'Globals','2018-01-30 22:07:28','2018-01-30 22:07:28','af356800-143a-4d5b-a0e7-811a7f167bd0');

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
  `required` tinyint(1) NOT NULL DEFAULT '0',
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
	(5,2,3,3,0,1,'2017-12-29 22:16:56','2017-12-29 22:16:56','db04ac37-e7ce-4534-8878-0c20c1488915'),
	(6,2,3,4,1,2,'2017-12-29 22:16:56','2017-12-29 22:16:56','d7b2557a-88db-4292-95b3-56c5a69b471c'),
	(10,5,5,6,0,1,'2017-12-29 23:05:42','2017-12-29 23:05:42','59e3e969-c2a7-486f-9263-c4f76d9e15e9'),
	(11,5,5,7,0,2,'2017-12-29 23:05:42','2017-12-29 23:05:42','43c60bcd-e0af-4036-aff6-5800697db52b'),
	(12,5,5,2,1,3,'2017-12-29 23:05:42','2017-12-29 23:05:42','ebdaeb39-df2a-42ca-a744-924637e74501'),
	(17,7,7,10,0,1,'2018-01-02 21:06:45','2018-01-02 21:06:45','3a2692f3-6cdc-4599-bdad-d4ebbdbe10b2'),
	(18,7,7,11,0,2,'2018-01-02 21:06:45','2018-01-02 21:06:45','ae91ca90-4d1d-4102-97b4-6abc19402755'),
	(19,8,8,12,0,1,'2018-01-02 21:06:45','2018-01-02 21:06:45','817d611d-3e69-45f0-9d07-d62e69b90d08'),
	(20,9,9,13,0,1,'2018-01-02 21:06:45','2018-01-02 21:06:45','86d96611-9cd0-4e51-9d8a-9d4455459aed'),
	(21,10,10,14,0,1,'2018-01-02 21:06:46','2018-01-02 21:06:46','c7340406-6d59-40e5-b106-dc74189bc11a'),
	(22,10,10,15,0,2,'2018-01-02 21:06:46','2018-01-02 21:06:46','2d5c376d-70f1-4f5d-b96d-5b5a284985eb'),
	(23,11,11,16,0,1,'2018-01-02 21:06:46','2018-01-02 21:06:46','88d01f53-2748-4964-becd-5df5128c063a'),
	(30,12,14,18,0,1,'2018-01-02 22:00:39','2018-01-02 22:00:39','564cf684-e06c-41e4-8b29-018ac082092c'),
	(31,6,15,19,0,1,'2018-01-02 22:02:49','2018-01-02 22:02:49','21ec89bb-4256-40be-8937-b5e724164202'),
	(32,6,15,5,0,2,'2018-01-02 22:02:49','2018-01-02 22:02:49','8b5faf6a-dd88-4614-b72f-d8456778468c'),
	(33,6,15,7,0,3,'2018-01-02 22:02:49','2018-01-02 22:02:49','f8650ffd-3ab8-4e31-8d55-e2ddf470d6b4'),
	(34,6,15,17,0,4,'2018-01-02 22:02:49','2018-01-02 22:02:49','b833cc22-d48e-42af-bf34-e18e6e70f75e'),
	(35,6,15,9,0,5,'2018-01-02 22:02:49','2018-01-02 22:02:49','713d2760-dd14-4d6c-b0c6-6cc67298f27d'),
	(41,1,17,19,0,1,'2018-01-02 22:32:52','2018-01-02 22:32:52','0c5ebd77-6351-4284-be9a-eab393a6d752'),
	(42,1,17,5,1,2,'2018-01-02 22:32:52','2018-01-02 22:32:52','50507f70-113b-45d6-993a-33e69a366978'),
	(43,1,17,1,0,3,'2018-01-02 22:32:52','2018-01-02 22:32:52','7b1a1937-247b-42ae-bc37-782532419868'),
	(44,1,17,2,0,4,'2018-01-02 22:32:52','2018-01-02 22:32:52','ec99b1cf-f59c-4e1a-b6b9-89320dd92337'),
	(45,1,17,8,0,5,'2018-01-02 22:32:52','2018-01-02 22:32:52','6853394c-76b9-487a-9620-69ee9e5c87c7'),
	(46,1,17,20,0,6,'2018-01-02 22:32:52','2018-01-02 22:32:52','38a509eb-9e6d-4007-a382-5dac6e650d2d'),
	(47,13,18,21,0,1,'2018-01-30 22:07:53','2018-01-30 22:07:53','055aa667-4f52-4ac0-9200-0f04f2dd20d1');

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
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fieldlayouts_type_idx` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `fieldlayouts` WRITE;
/*!40000 ALTER TABLE `fieldlayouts` DISABLE KEYS */;

INSERT INTO `fieldlayouts` (`id`, `type`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,'craft\\elements\\Entry','2017-12-29 21:48:32','2018-01-02 22:32:52','fe985c93-1e23-4e08-8476-507ba28f3879'),
	(2,'craft\\elements\\Entry','2017-12-29 21:58:58','2017-12-29 22:16:56','45132e0d-7e4f-4bd3-a58b-c86eb601df0f'),
	(3,'craft\\elements\\Entry','2017-12-29 22:21:08','2018-02-09 15:45:34','665d5e9b-a16f-4879-a9ad-b2d5e30680e6'),
	(4,'craft\\elements\\Asset','2017-12-29 22:35:58','2017-12-29 22:35:58','5c838cdd-ecf6-4cef-a03f-9ecd218cf2ce'),
	(5,'craft\\elements\\Entry','2017-12-29 22:51:48','2017-12-29 23:05:42','c729ca99-8385-485f-97cd-1f0e8eceba05'),
	(6,'craft\\elements\\Entry','2018-01-02 20:57:56','2018-01-02 22:02:49','8e557e67-31fa-4dec-8b22-65f2cbb1dbd1'),
	(7,'craft\\elements\\MatrixBlock','2018-01-02 21:06:45','2018-01-02 21:06:45','daa840bd-2482-4a0b-8b71-36f7f69b7d93'),
	(8,'craft\\elements\\MatrixBlock','2018-01-02 21:06:45','2018-01-02 21:06:45','85a51e00-7707-4c6c-96f7-71d6bf109671'),
	(9,'craft\\elements\\MatrixBlock','2018-01-02 21:06:45','2018-01-02 21:06:45','7f6efc69-0838-4782-ae02-6422e8a1acba'),
	(10,'craft\\elements\\MatrixBlock','2018-01-02 21:06:46','2018-01-02 21:06:46','593e5bd9-ed02-4ba9-9d5f-a573688cf0d4'),
	(11,'craft\\elements\\MatrixBlock','2018-01-02 21:06:46','2018-01-02 21:06:46','60d7483f-a396-4a91-8638-7b37438e9c9d'),
	(12,'craft\\elements\\Category','2018-01-02 21:58:37','2018-01-02 22:00:39','9eecf3b9-25bb-4b1d-b2c1-ab2fc5d30c68'),
	(13,'craft\\elements\\GlobalSet','2018-01-30 22:07:08','2018-01-30 22:07:53','7b72554c-0a1e-4ffc-ae56-561ef97bf4b5');

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
	(3,2,'News',1,'2017-12-29 22:16:56','2017-12-29 22:16:56','14909e9e-b6c7-479d-9021-efaccbcd0e4b'),
	(5,5,'About',1,'2017-12-29 23:05:42','2017-12-29 23:05:42','cb3b1e82-05ef-4073-afad-e5f52f237f13'),
	(7,7,'Content',1,'2018-01-02 21:06:45','2018-01-02 21:06:45','f60152d6-ccf7-49b3-97eb-f5c7258d5d84'),
	(8,8,'Content',1,'2018-01-02 21:06:45','2018-01-02 21:06:45','d3afc40e-f9d5-4d62-8178-dbaf1cdfc6ab'),
	(9,9,'Content',1,'2018-01-02 21:06:45','2018-01-02 21:06:45','8ec4c0eb-804e-4e68-ab90-03fc44122601'),
	(10,10,'Content',1,'2018-01-02 21:06:46','2018-01-02 21:06:46','d6458afe-d4da-4508-aba4-0314b8ee75c8'),
	(11,11,'Content',1,'2018-01-02 21:06:46','2018-01-02 21:06:46','c0b59269-f6aa-4582-a9dd-50471d86664b'),
	(14,12,'Style',1,'2018-01-02 22:00:39','2018-01-02 22:00:39','22beab86-8e5d-469d-bff6-7a00f4634aea'),
	(15,6,'Recipes',1,'2018-01-02 22:02:49','2018-01-02 22:02:49','2a167438-eac7-4024-8162-fae78cc4eca5'),
	(17,1,'Drinks',1,'2018-01-02 22:32:52','2018-01-02 22:32:52','5f9cb08e-d070-4c69-aa8b-6a9e7fb9745a'),
	(18,13,'Globals',1,'2018-01-30 22:07:53','2018-01-30 22:07:53','d6f9b8e1-5fb7-4829-87e9-2dc08ba4a69c');

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
  `instructions` text,
  `translationMethod` varchar(255) NOT NULL DEFAULT 'none',
  `translationKeyFormat` text,
  `type` varchar(255) NOT NULL,
  `settings` text,
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

INSERT INTO `fields` (`id`, `groupId`, `name`, `handle`, `context`, `instructions`, `translationMethod`, `translationKeyFormat`, `type`, `settings`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,2,'Drink Intro','drinkIntro','global','A short introduction (one sentence) that describes the drink. Be creative!','site',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2017-12-29 21:55:30','2018-02-15 17:08:09','a43fc23c-14c9-448a-a481-162395d6ec13'),
	(2,3,'Page Copy','pageCopy','global','','none',NULL,'craft\\ckeditor\\Field','{\"purifierConfig\":\"\",\"purifyHtml\":\"1\",\"columnType\":\"text\"}','2017-12-29 21:56:31','2018-02-15 17:19:58','dee49864-8a19-4e79-9507-86ac050d5612'),
	(3,4,'News Excerpt','newsExcerpt','global','','none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2017-12-29 22:00:17','2017-12-29 22:00:17','db4d75df-18a3-4c76-a0e9-3463d56bf387'),
	(4,4,'News Body','newsBody','global','','none',NULL,'craft\\ckeditor\\Field','{\"purifierConfig\":\"\",\"purifyHtml\":\"1\",\"columnType\":\"text\"}','2017-12-29 22:00:46','2017-12-29 22:00:46','df7fcf64-6a2f-4d76-89ed-3f80ba537163'),
	(5,2,'Drink Image','drinkImage','global','','site',NULL,'craft\\fields\\Assets','{\"useSingleFolder\":\"\",\"defaultUploadLocationSource\":\"folder:1\",\"defaultUploadLocationSubpath\":\"\",\"singleUploadLocationSource\":\"folder:1\",\"singleUploadLocationSubpath\":\"\",\"restrictFiles\":\"1\",\"allowedKinds\":[\"image\"],\"sources\":[\"folder:1\"],\"source\":null,\"targetSiteId\":null,\"viewMode\":\"list\",\"limit\":\"1\",\"selectionLabel\":\"Choose a drink image\",\"localizeRelations\":false}','2017-12-29 22:41:09','2017-12-29 22:41:09','905d8c76-90aa-492b-b4a6-9232dd3c4be5'),
	(6,5,'Subtitle','subtitle','global','','none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2017-12-29 23:04:33','2017-12-29 23:04:33','2e589bf8-04f7-411f-a8f2-dbad1a553dbb'),
	(7,5,'Page Intro','pageIntro','global','','none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2017-12-29 23:04:48','2017-12-29 23:04:48','694b6c0f-ce93-43f1-801b-90ac16df28ed'),
	(8,2,'Date Added to Menu','dateAddedToMenu','global','','none',NULL,'craft\\fields\\Date','{\"showDate\":true,\"showTime\":false,\"minuteIncrement\":\"30\"}','2018-01-02 20:05:52','2018-01-02 20:05:52','e5966e9c-2221-419b-8dd9-d2ba975da3fa'),
	(9,6,'Recipe Contents','recipeContents','global','','site',NULL,'craft\\fields\\Matrix','{\"maxBlocks\":\"\",\"localizeBlocks\":false,\"contentTable\":\"{{%matrixcontent_recipecontents}}\"}','2018-01-02 21:06:45','2018-01-02 21:06:45','87803860-4cf0-408c-9e84-397c424eaf05'),
	(10,NULL,'Image','image','matrixBlockType:1','','site',NULL,'craft\\fields\\Assets','{\"useSingleFolder\":\"\",\"defaultUploadLocationSource\":\"folder:1\",\"defaultUploadLocationSubpath\":\"\",\"singleUploadLocationSource\":\"folder:1\",\"singleUploadLocationSubpath\":\"\",\"restrictFiles\":\"\",\"allowedKinds\":null,\"sources\":\"*\",\"source\":null,\"targetSiteId\":null,\"viewMode\":\"list\",\"limit\":\"1\",\"selectionLabel\":\"Add an image for this block.\",\"localizeRelations\":false}','2018-01-02 21:06:45','2018-01-02 21:06:45','2bc6476e-98e2-457b-9f97-78dab74ba4a4'),
	(11,NULL,'Image Caption','imageCaption','matrixBlockType:1','','none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2018-01-02 21:06:45','2018-01-02 21:06:45','fd7bed69-83a0-4517-8e71-e02b471135a0'),
	(12,NULL,'Tip Content','tipContent','matrixBlockType:2','','none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"multiline\":\"1\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2018-01-02 21:06:45','2018-01-02 21:06:45','8318e449-2fa0-44b1-ade3-552386075971'),
	(13,NULL,'Body Content','bodyContent','matrixBlockType:3','','none',NULL,'craft\\ckeditor\\Field','{\"purifierConfig\":\"\",\"purifyHtml\":\"1\",\"columnType\":\"text\"}','2018-01-02 21:06:45','2018-01-02 21:06:45','c4f0305b-df23-4920-b0c8-2105ec5bbda1'),
	(14,NULL,'Steps Title','stepsTitle','matrixBlockType:4','','none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2018-01-02 21:06:46','2018-01-02 21:06:46','0a8401f5-2147-49ed-ab88-0e38ee22e0fa'),
	(15,NULL,'Steps Content','stepsContent','matrixBlockType:4','','none',NULL,'craft\\fields\\Table','{\"columns\":{\"col1\":{\"heading\":\"Steps Instructions\",\"handle\":\"stepsInstructions\",\"width\":\"\",\"type\":\"singleline\"}},\"defaults\":[],\"columnType\":\"text\"}','2018-01-02 21:06:46','2018-01-02 21:06:46','1391b485-a67c-45e5-acdf-0fbbb99263e8'),
	(16,NULL,'Ingredients','ingredients','matrixBlockType:5','','none',NULL,'craft\\fields\\Table','{\"columns\":{\"col1\":{\"heading\":\"Amount\",\"handle\":\"amount\",\"width\":\"\",\"type\":\"singleline\"},\"col2\":{\"heading\":\"Ingredient\",\"handle\":\"ingredient\",\"width\":\"\",\"type\":\"singleline\"}},\"defaults\":[],\"columnType\":\"text\"}','2018-01-02 21:06:46','2018-01-02 21:06:46','3221ed5d-6cf7-443f-8ab3-2af981b308fe'),
	(17,6,'Recipe Snapshot','recipeSnapshot','global','','none',NULL,'craft\\fields\\Table','{\"columns\":{\"col1\":{\"heading\":\"Snapshot Text\",\"handle\":\"snapshotText\",\"width\":\"\",\"type\":\"singleline\"}},\"defaults\":[],\"columnType\":\"text\"}','2018-01-02 21:07:55','2018-01-02 21:07:55','912353f4-c088-499e-864a-3da0fc19fd82'),
	(18,6,'Style Description','styleDescription','global','','none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2018-01-02 21:59:28','2018-01-02 21:59:28','401c5576-4f56-412f-a576-f41f9ee31cf6'),
	(19,1,'Style','style','global','','site',NULL,'craft\\fields\\Categories','{\"branchLimit\":\"1\",\"sources\":\"*\",\"source\":\"group:1\",\"targetSiteId\":null,\"viewMode\":null,\"limit\":null,\"selectionLabel\":\"Add a style\",\"localizeRelations\":false}','2018-01-02 22:02:33','2018-01-02 22:02:33','236920c7-7ad4-49fb-908e-d7a3fe63db8d'),
	(20,2,'Related Recipe','relatedRecipe','global','','site',NULL,'craft\\fields\\Entries','{\"sources\":[\"section:5\"],\"source\":null,\"targetSiteId\":null,\"viewMode\":null,\"limit\":\"1\",\"selectionLabel\":\"Add a recipe\",\"localizeRelations\":false}','2018-01-02 22:32:23','2018-01-02 22:32:23','e720b498-35c0-4ca2-92a8-4fc947f3823b'),
	(21,7,'Site Description','siteDescription','global','','none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2018-01-30 22:07:36','2018-01-30 22:07:36','7527ed8a-4267-48e2-b707-45a6b98ca157');

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
  UNIQUE KEY `globalsets_name_unq_idx` (`name`),
  UNIQUE KEY `globalsets_handle_unq_idx` (`handle`),
  KEY `globalsets_fieldLayoutId_idx` (`fieldLayoutId`),
  CONSTRAINT `globalsets_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `globalsets_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `globalsets` WRITE;
/*!40000 ALTER TABLE `globalsets` DISABLE KEYS */;

INSERT INTO `globalsets` (`id`, `name`, `handle`, `fieldLayoutId`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(30,'Site Information','siteInformation',13,'2018-01-30 22:07:08','2018-01-30 22:07:53','d28d21f9-9016-4f24-a371-c2084fbd3578');

/*!40000 ALTER TABLE `globalsets` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table info
# ------------------------------------------------------------

DROP TABLE IF EXISTS `info`;

CREATE TABLE `info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `version` varchar(50) NOT NULL,
  `schemaVersion` varchar(15) NOT NULL,
  `edition` tinyint(3) unsigned NOT NULL,
  `timezone` varchar(30) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `on` tinyint(1) NOT NULL DEFAULT '0',
  `maintenance` tinyint(1) NOT NULL DEFAULT '0',
  `fieldVersion` char(12) NOT NULL DEFAULT '000000000000',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `info` WRITE;
/*!40000 ALTER TABLE `info` DISABLE KEYS */;

INSERT INTO `info` (`id`, `version`, `schemaVersion`, `edition`, `timezone`, `name`, `on`, `maintenance`, `fieldVersion`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,'3.0.28','3.0.93',1,'America/Los_Angeles','Crafty Coffee',1,0,'RBxkRaHVVErr','2017-12-29 17:38:45','2018-10-25 20:54:32','1e6ba66a-5cd6-4b9d-8e94-0868c15cee7a');

/*!40000 ALTER TABLE `info` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table matrixblocks
# ------------------------------------------------------------

DROP TABLE IF EXISTS `matrixblocks`;

CREATE TABLE `matrixblocks` (
  `id` int(11) NOT NULL,
  `ownerId` int(11) NOT NULL,
  `ownerSiteId` int(11) DEFAULT NULL,
  `fieldId` int(11) NOT NULL,
  `typeId` int(11) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `matrixblocks_ownerId_idx` (`ownerId`),
  KEY `matrixblocks_fieldId_idx` (`fieldId`),
  KEY `matrixblocks_typeId_idx` (`typeId`),
  KEY `matrixblocks_sortOrder_idx` (`sortOrder`),
  KEY `matrixblocks_ownerSiteId_idx` (`ownerSiteId`),
  CONSTRAINT `matrixblocks_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixblocks_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixblocks_ownerId_fk` FOREIGN KEY (`ownerId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixblocks_ownerSiteId_fk` FOREIGN KEY (`ownerSiteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `matrixblocks_typeId_fk` FOREIGN KEY (`typeId`) REFERENCES `matrixblocktypes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `matrixblocks` WRITE;
/*!40000 ALTER TABLE `matrixblocks` DISABLE KEYS */;

INSERT INTO `matrixblocks` (`id`, `ownerId`, `ownerSiteId`, `fieldId`, `typeId`, `sortOrder`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(14,13,NULL,9,3,1,'2018-01-02 21:14:07','2018-01-02 22:04:04','b8a2217f-f85a-4078-861e-e7bffad51853'),
	(15,13,NULL,9,1,4,'2018-01-02 21:14:07','2018-01-02 22:04:04','afc2f60f-63ac-4a56-9711-e5a3343c7af0'),
	(16,13,NULL,9,3,3,'2018-01-02 21:14:07','2018-01-02 22:04:04','9282934a-aa5a-4777-9fd8-c786a71e9d76'),
	(17,13,NULL,9,2,2,'2018-01-02 21:14:07','2018-01-02 22:04:04','e217003d-8204-42e5-b7a4-f6df3169a3a2'),
	(18,13,NULL,9,1,6,'2018-01-02 21:14:07','2018-01-02 22:04:04','dbcb0f0b-d0ad-46f9-a050-810ccee95a2d'),
	(19,13,NULL,9,5,5,'2018-01-02 21:14:07','2018-01-02 22:04:04','401d8044-bee2-4323-b324-576363aeebdb'),
	(20,13,NULL,9,2,7,'2018-01-02 21:14:07','2018-01-02 22:04:04','0273b397-2c4c-4c82-8658-7fad3f14cb04'),
	(21,13,NULL,9,4,8,'2018-01-02 21:14:07','2018-01-02 22:04:04','e23452f2-982a-4bb3-beb0-7a5d39d55501'),
	(22,13,NULL,9,3,9,'2018-01-02 21:14:07','2018-01-02 22:04:04','fd9dc668-f7a2-4962-b043-0dbd16b98687'),
	(23,13,NULL,9,4,10,'2018-01-02 21:14:07','2018-01-02 22:04:04','58f03118-e6e1-4be0-b543-60f86a620fe0'),
	(24,13,NULL,9,3,11,'2018-01-02 21:14:07','2018-01-02 22:04:04','3d4f4d1e-f266-4d01-b917-9d4b68e69e09'),
	(25,13,NULL,9,4,12,'2018-01-02 21:14:07','2018-01-02 22:04:04','adfc8aa6-6f7e-433b-9f4d-b49bdd0eb9fb');

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
	(1,9,7,'Recipe Image','recipeImage',1,'2018-01-02 21:06:45','2018-01-02 21:06:45','e894aa86-69d7-4ca9-8979-f6eb043e2683'),
	(2,9,8,'Recipe Tip','recipeTip',2,'2018-01-02 21:06:45','2018-01-02 21:06:45','4cb71c6c-f4ca-4251-8235-03bd7fb5fc11'),
	(3,9,9,'Recipe Copy','recipeCopy',3,'2018-01-02 21:06:45','2018-01-02 21:06:45','3af181f7-70c2-473a-8753-d016f18682f7'),
	(4,9,10,'Recipe Steps','recipeSteps',4,'2018-01-02 21:06:45','2018-01-02 21:06:46','d864ce6c-12fc-4165-9e2b-ea7549d8b3ae'),
	(5,9,11,'Recipe Ingredients','recipeIngredients',5,'2018-01-02 21:06:46','2018-01-02 21:06:46','e72ef425-e208-47b2-85f5-ab661d76e102');

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
  `field_recipeImage_imageCaption` text,
  `field_recipeTip_tipContent` text,
  `field_recipeCopy_bodyContent` text,
  `field_recipeSteps_stepsTitle` text,
  `field_recipeSteps_stepsContent` text,
  `field_recipeIngredients_ingredients` text,
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
	(1,14,1,'2018-01-02 21:14:07','2018-01-02 22:04:04','16149e3a-a7ab-4261-afc4-3bde62b938a4',NULL,NULL,'<p>This is the body copy of the recipe.</p>',NULL,NULL,NULL),
	(2,15,1,'2018-01-02 21:14:07','2018-01-02 22:04:04','dc2366d6-6c17-4fdc-b359-e7284e566df9','Espresso is the best.',NULL,NULL,NULL,NULL,NULL),
	(3,16,1,'2018-01-02 21:14:07','2018-01-02 22:04:04','2fa2f54f-818c-46c0-b961-3a4cd3956fd7',NULL,NULL,'<p>I can have more copy right here.</p>',NULL,NULL,NULL),
	(4,17,1,'2018-01-02 21:14:07','2018-01-02 22:04:04','ad5fc9f8-e9f1-4885-82c7-1e228900b0e7',NULL,'This is another tip.',NULL,NULL,NULL,NULL),
	(5,18,1,'2018-01-02 21:14:07','2018-01-02 22:04:04','4b4c7e75-62c4-43f7-a5e5-00e4b0335fed','This is the caption',NULL,NULL,NULL,NULL,NULL),
	(6,19,1,'2018-01-02 21:14:07','2018-01-02 22:04:04','5b54e8c9-9b7b-4191-9b2a-ca914deb9327',NULL,NULL,NULL,NULL,NULL,'[{\"col1\":\"1 cup\",\"col2\":\"water\"},{\"col1\":\"18 grams\",\"col2\":\"Espresso beans\"},{\"col1\":\"1\",\"col2\":\"quality coffee grinder\"}]'),
	(7,20,1,'2018-01-02 21:14:07','2018-01-02 22:04:04','3c01daa8-5e7a-458e-bcdf-a99716550a91',NULL,'Please only use a quality burr grinder for making espresso!',NULL,NULL,NULL,NULL),
	(8,21,1,'2018-01-02 21:14:07','2018-01-02 22:04:04','9903daba-119b-49e6-affa-e9f097eabde9',NULL,NULL,NULL,'Preparation','[{\"col1\":\"Turn on your espresso machine.\"},{\"col1\":\"Buy good beans\"},{\"col1\":\"Alert friends and family that you need to focus.\"}]',NULL),
	(9,22,1,'2018-01-02 21:14:07','2018-01-02 22:04:04','7fee19d4-2ddc-4c0b-9ce9-b4786a91345a',NULL,NULL,'<p>This is more copy.</p><p> </p><p> </p>',NULL,NULL,NULL),
	(10,23,1,'2018-01-02 21:14:07','2018-01-02 22:04:04','fdc21ad6-2058-4c28-a6de-3777ee796f06',NULL,NULL,NULL,'Grinding the Beans','[{\"col1\":\"Step one\"},{\"col1\":\"step two\"},{\"col1\":\"step there\"}]',NULL),
	(11,24,1,'2018-01-02 21:14:07','2018-01-02 22:04:04','85667857-2095-4100-a653-c288c91693fc',NULL,NULL,'<p>even more copy -- long winded!</p>',NULL,NULL,NULL),
	(12,25,1,'2018-01-02 21:14:07','2018-01-02 22:04:04','12ef0244-fc64-4f5e-9ff8-7975b4133e3a',NULL,NULL,NULL,'Extracting the Espresso Shot','[{\"col1\":\"Step one\"},{\"col1\":\"Step two\"},{\"col1\":\"step three\"}]',NULL);

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
	(1,NULL,'app','Install','2017-12-29 17:38:45','2017-12-29 17:38:45','2017-12-29 17:38:45','51146dcb-54d3-4b27-80ed-a3a8bbd1caa0'),
	(2,NULL,'app','m150403_183908_migrations_table_changes','2017-12-29 17:38:45','2017-12-29 17:38:45','2017-12-29 17:38:45','ab08abbc-9396-4a0e-97c0-6854b05e59ab'),
	(3,NULL,'app','m150403_184247_plugins_table_changes','2017-12-29 17:38:45','2017-12-29 17:38:45','2017-12-29 17:38:45','27fae677-09b4-4eda-a86f-91fe02d1514c'),
	(4,NULL,'app','m150403_184533_field_version','2017-12-29 17:38:45','2017-12-29 17:38:45','2017-12-29 17:38:45','318cac8d-cb87-4376-b1bf-d6ebb9ccfac4'),
	(5,NULL,'app','m150403_184729_type_columns','2017-12-29 17:38:45','2017-12-29 17:38:45','2017-12-29 17:38:45','e99c5ec7-2ae1-4188-b912-ea51d840bbce'),
	(6,NULL,'app','m150403_185142_volumes','2017-12-29 17:38:45','2017-12-29 17:38:45','2017-12-29 17:38:45','14be0df8-9830-423e-bfb8-00128e26be8b'),
	(7,NULL,'app','m150428_231346_userpreferences','2017-12-29 17:38:45','2017-12-29 17:38:45','2017-12-29 17:38:45','aac8847c-6963-4456-813c-ca453d279ec8'),
	(8,NULL,'app','m150519_150900_fieldversion_conversion','2017-12-29 17:38:45','2017-12-29 17:38:45','2017-12-29 17:38:45','5d1f1687-8d2e-4113-818e-f46ce637a437'),
	(9,NULL,'app','m150617_213829_update_email_settings','2017-12-29 17:38:45','2017-12-29 17:38:45','2017-12-29 17:38:45','da06eb88-cfcc-4a2c-8820-2c7a44224bb8'),
	(10,NULL,'app','m150721_124739_templatecachequeries','2017-12-29 17:38:45','2017-12-29 17:38:45','2017-12-29 17:38:45','f46e61bc-81df-474b-8060-215a4dc8c974'),
	(11,NULL,'app','m150724_140822_adjust_quality_settings','2017-12-29 17:38:45','2017-12-29 17:38:45','2017-12-29 17:38:45','1073d66a-8163-4dda-9260-061755d407be'),
	(12,NULL,'app','m150815_133521_last_login_attempt_ip','2017-12-29 17:38:45','2017-12-29 17:38:45','2017-12-29 17:38:45','6f052a99-04e0-485b-b5cb-fca55b45468f'),
	(13,NULL,'app','m151002_095935_volume_cache_settings','2017-12-29 17:38:45','2017-12-29 17:38:45','2017-12-29 17:38:45','9a8d437e-b13b-462e-a4dc-e50cab2ee197'),
	(14,NULL,'app','m151005_142750_volume_s3_storage_settings','2017-12-29 17:38:45','2017-12-29 17:38:45','2017-12-29 17:38:45','73619d99-fb6b-4d93-bcdd-32d95d18efd3'),
	(15,NULL,'app','m151016_133600_delete_asset_thumbnails','2017-12-29 17:38:45','2017-12-29 17:38:45','2017-12-29 17:38:45','8f10f2fe-45fc-4fe4-bd0a-45d3c5a8b725'),
	(16,NULL,'app','m151209_000000_move_logo','2017-12-29 17:38:45','2017-12-29 17:38:45','2017-12-29 17:38:45','039f74b9-32bf-4135-b08a-63181d6f1771'),
	(17,NULL,'app','m151211_000000_rename_fileId_to_assetId','2017-12-29 17:38:45','2017-12-29 17:38:45','2017-12-29 17:38:45','0ba5e781-a4a7-42d2-9023-4826d9bdd5a6'),
	(18,NULL,'app','m151215_000000_rename_asset_permissions','2017-12-29 17:38:45','2017-12-29 17:38:45','2017-12-29 17:38:45','882c3a9d-3f54-498a-b281-581e55c0fc8e'),
	(19,NULL,'app','m160707_000001_rename_richtext_assetsource_setting','2017-12-29 17:38:45','2017-12-29 17:38:45','2017-12-29 17:38:45','fe7a7cd9-d3d0-4ce0-b46c-12768393d4e5'),
	(20,NULL,'app','m160708_185142_volume_hasUrls_setting','2017-12-29 17:38:45','2017-12-29 17:38:45','2017-12-29 17:38:45','20640db0-cc84-4377-9125-d3a4574c2bdc'),
	(21,NULL,'app','m160714_000000_increase_max_asset_filesize','2017-12-29 17:38:45','2017-12-29 17:38:45','2017-12-29 17:38:45','d499100e-424b-453a-ad22-87d3aa987ee8'),
	(22,NULL,'app','m160727_194637_column_cleanup','2017-12-29 17:38:45','2017-12-29 17:38:45','2017-12-29 17:38:45','05c83595-df41-4e1c-844d-43ef8d5f5869'),
	(23,NULL,'app','m160804_110002_userphotos_to_assets','2017-12-29 17:38:45','2017-12-29 17:38:45','2017-12-29 17:38:45','cc029d20-9eed-43c7-aba2-668c53fd02aa'),
	(24,NULL,'app','m160807_144858_sites','2017-12-29 17:38:45','2017-12-29 17:38:45','2017-12-29 17:38:45','5154c282-85bf-43dd-9f56-d2e50b4414d9'),
	(25,NULL,'app','m160829_000000_pending_user_content_cleanup','2017-12-29 17:38:45','2017-12-29 17:38:45','2017-12-29 17:38:45','a93544e1-7b49-4ea7-bb8d-7cb2babd28e8'),
	(26,NULL,'app','m160830_000000_asset_index_uri_increase','2017-12-29 17:38:45','2017-12-29 17:38:45','2017-12-29 17:38:45','9d718533-e4c4-497b-b254-539fc36576de'),
	(27,NULL,'app','m160912_230520_require_entry_type_id','2017-12-29 17:38:45','2017-12-29 17:38:45','2017-12-29 17:38:45','08043c96-4e2e-43f1-a966-f24c55420c89'),
	(28,NULL,'app','m160913_134730_require_matrix_block_type_id','2017-12-29 17:38:45','2017-12-29 17:38:45','2017-12-29 17:38:45','9a272986-2c40-4484-b570-eb9598464ea7'),
	(29,NULL,'app','m160920_174553_matrixblocks_owner_site_id_nullable','2017-12-29 17:38:45','2017-12-29 17:38:45','2017-12-29 17:38:45','e23a1547-5a35-4224-9f36-090d7985bbfc'),
	(30,NULL,'app','m160920_231045_usergroup_handle_title_unique','2017-12-29 17:38:45','2017-12-29 17:38:45','2017-12-29 17:38:45','2ab6febb-c73f-497d-8b0a-8006ad45181d'),
	(31,NULL,'app','m160925_113941_route_uri_parts','2017-12-29 17:38:45','2017-12-29 17:38:45','2017-12-29 17:38:45','77c0c17d-1d26-4d78-ab45-c125a4abb04e'),
	(32,NULL,'app','m161006_205918_schemaVersion_not_null','2017-12-29 17:38:45','2017-12-29 17:38:45','2017-12-29 17:38:45','f1e85004-2e24-4a6f-83f5-16e95d854e19'),
	(33,NULL,'app','m161007_130653_update_email_settings','2017-12-29 17:38:45','2017-12-29 17:38:45','2017-12-29 17:38:45','ca6046d2-4e11-4334-8852-e6a0d96a5e7f'),
	(34,NULL,'app','m161013_175052_newParentId','2017-12-29 17:38:45','2017-12-29 17:38:45','2017-12-29 17:38:45','9ec670c5-32a8-4290-ac54-f0c4919501a5'),
	(35,NULL,'app','m161021_102916_fix_recent_entries_widgets','2017-12-29 17:38:45','2017-12-29 17:38:45','2017-12-29 17:38:45','f064c8c4-5d1d-4f4d-bda8-7b0354809bf3'),
	(36,NULL,'app','m161021_182140_rename_get_help_widget','2017-12-29 17:38:45','2017-12-29 17:38:45','2017-12-29 17:38:45','bdeb6494-5499-45bb-a2b1-d56e4dde820f'),
	(37,NULL,'app','m161025_000000_fix_char_columns','2017-12-29 17:38:45','2017-12-29 17:38:45','2017-12-29 17:38:45','2f964354-776a-4ecb-9a10-2a7701943df3'),
	(38,NULL,'app','m161029_124145_email_message_languages','2017-12-29 17:38:45','2017-12-29 17:38:45','2017-12-29 17:38:45','6b8514d1-cf00-4a5d-9a1c-c3ebd20378df'),
	(39,NULL,'app','m161108_000000_new_version_format','2017-12-29 17:38:45','2017-12-29 17:38:45','2017-12-29 17:38:45','cfe89546-0f35-4abc-9eda-bd361538fc3d'),
	(40,NULL,'app','m161109_000000_index_shuffle','2017-12-29 17:38:45','2017-12-29 17:38:45','2017-12-29 17:38:45','fea8ad5b-7eb9-43bf-8a4b-443a3e6da107'),
	(41,NULL,'app','m161122_185500_no_craft_app','2017-12-29 17:38:45','2017-12-29 17:38:45','2017-12-29 17:38:45','8c97c05a-4693-4edc-be34-80f4fd72a5ff'),
	(42,NULL,'app','m161125_150752_clear_urlmanager_cache','2017-12-29 17:38:45','2017-12-29 17:38:45','2017-12-29 17:38:45','636fa9f4-2e58-4198-a0fa-c980c4bac10f'),
	(43,NULL,'app','m161220_000000_volumes_hasurl_notnull','2017-12-29 17:38:45','2017-12-29 17:38:45','2017-12-29 17:38:45','ba0a45b2-47df-4202-a676-b9306d295c25'),
	(44,NULL,'app','m170114_161144_udates_permission','2017-12-29 17:38:45','2017-12-29 17:38:45','2017-12-29 17:38:45','eb662dd9-8e16-4ade-b25d-bf46f9520081'),
	(45,NULL,'app','m170120_000000_schema_cleanup','2017-12-29 17:38:45','2017-12-29 17:38:45','2017-12-29 17:38:45','8c6f8411-68c4-48e6-b063-40dc5f2ebff6'),
	(46,NULL,'app','m170126_000000_assets_focal_point','2017-12-29 17:38:45','2017-12-29 17:38:45','2017-12-29 17:38:45','f18514da-b42e-4bc1-8769-30890e0c2556'),
	(47,NULL,'app','m170206_142126_system_name','2017-12-29 17:38:45','2017-12-29 17:38:45','2017-12-29 17:38:45','8b92ae4f-9f9d-4fc9-8759-5ab7a351af2d'),
	(48,NULL,'app','m170217_044740_category_branch_limits','2017-12-29 17:38:45','2017-12-29 17:38:45','2017-12-29 17:38:45','926cc435-dff6-4d74-ae77-36dfff128c88'),
	(49,NULL,'app','m170217_120224_asset_indexing_columns','2017-12-29 17:38:45','2017-12-29 17:38:45','2017-12-29 17:38:45','9c89072f-d41b-43b2-b190-1b388575e9be'),
	(50,NULL,'app','m170223_224012_plain_text_settings','2017-12-29 17:38:45','2017-12-29 17:38:45','2017-12-29 17:38:45','ee786375-d61d-4d74-a642-d36b62cd3c41'),
	(51,NULL,'app','m170227_120814_focal_point_percentage','2017-12-29 17:38:45','2017-12-29 17:38:45','2017-12-29 17:38:45','0ee15457-477d-46ea-838e-6617785ccca0'),
	(52,NULL,'app','m170228_171113_system_messages','2017-12-29 17:38:45','2017-12-29 17:38:45','2017-12-29 17:38:45','33adce1b-e60c-4931-a6d8-6b804232340d'),
	(53,NULL,'app','m170303_140500_asset_field_source_settings','2017-12-29 17:38:45','2017-12-29 17:38:45','2017-12-29 17:38:45','20811dc4-0212-4114-aaca-b6f717de3917'),
	(54,NULL,'app','m170306_150500_asset_temporary_uploads','2017-12-29 17:38:45','2017-12-29 17:38:45','2017-12-29 17:38:45','34929fca-4e7f-47a0-9f1c-2c715f975a23'),
	(55,NULL,'app','m170414_162429_rich_text_config_setting','2017-12-29 17:38:45','2017-12-29 17:38:45','2017-12-29 17:38:45','9b9e5b3f-fcd8-4220-9a2c-65d959affeae'),
	(56,NULL,'app','m170523_190652_element_field_layout_ids','2017-12-29 17:38:45','2017-12-29 17:38:45','2017-12-29 17:38:45','2f5b1d51-97d5-4868-834e-a8a8dc4c9a10'),
	(57,NULL,'app','m170612_000000_route_index_shuffle','2017-12-29 17:38:45','2017-12-29 17:38:45','2017-12-29 17:38:45','2a127401-784d-49c8-9b42-34a7ad06dcb7'),
	(58,NULL,'app','m170621_195237_format_plugin_handles','2017-12-29 17:38:45','2017-12-29 17:38:45','2017-12-29 17:38:45','170492a2-9440-405d-8101-bcbb90411b58'),
	(59,NULL,'app','m170630_161028_deprecation_changes','2017-12-29 17:38:45','2017-12-29 17:38:45','2017-12-29 17:38:45','aba72da4-f765-4157-a4cb-c74b487e6a3a'),
	(60,NULL,'app','m170703_181539_plugins_table_tweaks','2017-12-29 17:38:45','2017-12-29 17:38:45','2017-12-29 17:38:45','4bbdd306-ded9-4b5e-bce6-c040a7ffeddc'),
	(61,NULL,'app','m170704_134916_sites_tables','2017-12-29 17:38:45','2017-12-29 17:38:45','2017-12-29 17:38:45','7581560a-b29a-4bc1-822b-eb2ec1bae0b1'),
	(62,NULL,'app','m170706_183216_rename_sequences','2017-12-29 17:38:45','2017-12-29 17:38:45','2017-12-29 17:38:45','a1deae78-e9d6-4158-9252-bdbf09063458'),
	(63,NULL,'app','m170707_094758_delete_compiled_traits','2017-12-29 17:38:45','2017-12-29 17:38:45','2017-12-29 17:38:45','ef9d774a-e9a5-4d31-bfe2-eefd71f906a6'),
	(64,NULL,'app','m170731_190138_drop_asset_packagist','2017-12-29 17:38:45','2017-12-29 17:38:45','2017-12-29 17:38:45','b7abecbf-9484-4224-a261-a6ad1415b5d0'),
	(65,NULL,'app','m170810_201318_create_queue_table','2017-12-29 17:38:45','2017-12-29 17:38:45','2017-12-29 17:38:45','89069f6a-2f44-4ed0-b6d7-bd28c94429b4'),
	(66,NULL,'app','m170816_133741_delete_compiled_behaviors','2017-12-29 17:38:45','2017-12-29 17:38:45','2017-12-29 17:38:45','c8b47031-68f9-4cb8-8e0e-73b3f301bf24'),
	(67,NULL,'app','m170821_180624_deprecation_line_nullable','2017-12-29 17:38:45','2017-12-29 17:38:45','2017-12-29 17:38:45','8e5166ac-5c99-490a-a586-f07312c358f1'),
	(68,NULL,'app','m170903_192801_longblob_for_queue_jobs','2017-12-29 17:38:45','2017-12-29 17:38:45','2017-12-29 17:38:45','217ae4a2-bca2-4cd6-809e-c8e3263913d0'),
	(69,NULL,'app','m170914_204621_asset_cache_shuffle','2017-12-29 17:38:45','2017-12-29 17:38:45','2017-12-29 17:38:45','92876e76-9930-4d6a-ab96-e498475727ab'),
	(70,NULL,'app','m171011_214115_site_groups','2017-12-29 17:38:45','2017-12-29 17:38:45','2017-12-29 17:38:45','db717cce-3bc3-4943-b341-048ff7bb2a4d'),
	(71,NULL,'app','m171012_151440_primary_site','2017-12-29 17:38:45','2017-12-29 17:38:45','2017-12-29 17:38:45','c8f69f5f-aa38-4c2a-a6b6-847c1637bcbe'),
	(72,NULL,'app','m171013_142500_transform_interlace','2017-12-29 17:38:45','2017-12-29 17:38:45','2017-12-29 17:38:45','18679a64-9b05-442b-90ea-290ea7e675f3'),
	(73,NULL,'app','m171016_092553_drop_position_select','2017-12-29 17:38:45','2017-12-29 17:38:45','2017-12-29 17:38:45','e3be398b-34be-43be-b984-09581834a965'),
	(74,NULL,'app','m171016_221244_less_strict_translation_method','2017-12-29 17:38:45','2017-12-29 17:38:45','2017-12-29 17:38:45','ff43680d-801e-48ca-aa25-d9b9803f1c7e'),
	(75,NULL,'app','m171107_000000_assign_group_permissions','2017-12-29 17:38:45','2017-12-29 17:38:45','2017-12-29 17:38:45','f9423028-0f09-4b19-be1c-8f9f8accd86a'),
	(76,NULL,'app','m171117_000001_templatecache_index_tune','2017-12-29 17:38:45','2017-12-29 17:38:45','2017-12-29 17:38:45','68175d54-9cae-4eec-959e-70c078911d61'),
	(77,NULL,'app','m171126_105927_disabled_plugins','2017-12-29 17:38:45','2017-12-29 17:38:45','2017-12-29 17:38:45','d23b2971-0f7d-407c-843a-71ad98e0d699'),
	(78,NULL,'app','m171130_214407_craftidtokens_table','2017-12-29 17:38:45','2017-12-29 17:38:45','2017-12-29 17:38:45','8e0dde98-5353-4793-acd6-3db3ed5f22b7'),
	(79,NULL,'app','m171202_004225_update_email_settings','2017-12-29 17:38:45','2017-12-29 17:38:45','2017-12-29 17:38:45','8a9456e0-fb19-4845-b975-21c74cda4e62'),
	(80,NULL,'app','m171204_000001_templatecache_index_tune_deux','2017-12-29 17:38:45','2017-12-29 17:38:45','2017-12-29 17:38:45','f375b4f3-2c0f-4691-9991-da5d0f7ff36a'),
	(81,NULL,'app','m171205_130908_remove_craftidtokens_refreshtoken_column','2017-12-29 17:38:45','2017-12-29 17:38:45','2017-12-29 17:38:45','927d1c10-8e5c-40cb-aa0a-41f523d8a598'),
	(82,NULL,'app','m171210_142046_fix_db_routes','2017-12-29 17:38:45','2017-12-29 17:38:45','2017-12-29 17:38:45','e48e3ad1-e46f-4631-8c69-d922f430eeb6'),
	(83,NULL,'app','m171218_143135_longtext_query_column','2017-12-29 17:38:45','2017-12-29 17:38:45','2017-12-29 17:38:45','2a1bd256-6988-4387-bfa4-e776f428df98'),
	(84,NULL,'app','m171231_055546_environment_variables_to_aliases','2018-01-30 21:58:09','2018-01-30 21:58:09','2018-01-30 21:58:09','57e4233b-9022-4324-9d4d-d74db400f64f'),
	(85,NULL,'app','m180113_153740_drop_users_archived_column','2018-01-30 21:58:09','2018-01-30 21:58:09','2018-01-30 21:58:09','c2ab03f2-b187-4e88-9527-e25aa7fd110d'),
	(86,NULL,'app','m180122_213433_propagate_entries_setting','2018-01-30 21:58:09','2018-01-30 21:58:09','2018-01-30 21:58:09','3b4dc09e-dbc0-4436-930b-172fa6629242'),
	(87,NULL,'app','m180124_230459_fix_propagate_entries_values','2018-01-30 21:58:09','2018-01-30 21:58:09','2018-01-30 21:58:09','80a793c9-c1c6-490b-b2b0-f0b8ac05fb5c'),
	(88,NULL,'app','m180128_235202_set_tag_slugs','2018-01-30 21:58:09','2018-01-30 21:58:09','2018-01-30 21:58:09','54dd9428-5675-41ac-a577-d56ef38cee97'),
	(89,NULL,'app','m180202_185551_fix_focal_points','2018-02-19 15:15:07','2018-02-19 15:15:07','2018-02-19 15:15:07','73fa8123-bd1c-4143-ad51-e6e4a3ffe338'),
	(90,NULL,'app','m180217_172123_tiny_ints','2018-10-25 20:54:06','2018-10-25 20:54:06','2018-10-25 20:54:06','6881b225-6cd9-4335-a093-8ab93a99610c'),
	(91,NULL,'app','m180321_233505_small_ints','2018-10-25 20:54:07','2018-10-25 20:54:07','2018-10-25 20:54:07','c00eb819-038b-4905-99bc-fdedc82834fa'),
	(92,NULL,'app','m180328_115523_new_license_key_statuses','2018-10-25 20:54:07','2018-10-25 20:54:07','2018-10-25 20:54:07','1e7f818b-377a-4b25-8b35-58884079cc67'),
	(93,NULL,'app','m180404_182320_edition_changes','2018-10-25 20:54:07','2018-10-25 20:54:07','2018-10-25 20:54:07','4dab6b8f-ff2d-4bcc-b661-646ac4f3bdf9'),
	(94,NULL,'app','m180411_102218_fix_db_routes','2018-10-25 20:54:07','2018-10-25 20:54:07','2018-10-25 20:54:07','6edae2b8-92d9-4a40-a5d8-773afc0d04d6'),
	(95,NULL,'app','m180416_205628_resourcepaths_table','2018-10-25 20:54:07','2018-10-25 20:54:07','2018-10-25 20:54:07','5db04e93-f14e-4afb-b02d-58fecc26a4d3'),
	(96,NULL,'app','m180418_205713_widget_cleanup','2018-10-25 20:54:07','2018-10-25 20:54:07','2018-10-25 20:54:07','b95324c7-3af4-4a82-992d-84538faa0f9d'),
	(97,NULL,'app','m180824_193422_case_sensitivity_fixes','2018-10-25 20:54:07','2018-10-25 20:54:07','2018-10-25 20:54:07','2f2a8f7e-91b4-4c3d-8037-4ce9e867786c'),
	(98,NULL,'app','m180901_151639_fix_matrixcontent_tables','2018-10-25 20:54:07','2018-10-25 20:54:07','2018-10-25 20:54:07','db37fc06-33bf-44e5-951e-969bab5c6d10');

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
  `licenseKey` char(24) DEFAULT NULL,
  `licenseKeyStatus` enum('valid','invalid','mismatched','astray','unknown') NOT NULL DEFAULT 'unknown',
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  `settings` text,
  `installDate` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `plugins_handle_unq_idx` (`handle`),
  KEY `plugins_enabled_idx` (`enabled`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `plugins` WRITE;
/*!40000 ALTER TABLE `plugins` DISABLE KEYS */;

INSERT INTO `plugins` (`id`, `handle`, `version`, `schemaVersion`, `licenseKey`, `licenseKeyStatus`, `enabled`, `settings`, `installDate`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(2,'ckeditor','1.0.0-beta.2','1.0.0',NULL,'unknown',1,NULL,'2017-12-29 19:31:43','2017-12-29 19:31:43','2018-10-25 20:54:33','091e0916-a695-4e93-a269-4e7ce7231caa'),
	(5,'contact-form','2.2.2','1.0.0',NULL,'unknown',1,NULL,'2017-12-29 19:34:53','2017-12-29 19:34:53','2018-10-25 20:54:33','03947a4e-cb2d-447e-959e-0de7e3b9fcc4'),
	(6,'element-api','2.5.4','1.0.0',NULL,'unknown',1,NULL,'2018-02-21 22:13:24','2018-02-21 22:13:24','2018-10-25 20:54:33','55769fbf-5c8f-4258-bc9a-be7fcfd0325e');

/*!40000 ALTER TABLE `plugins` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table queue
# ------------------------------------------------------------

DROP TABLE IF EXISTS `queue`;

CREATE TABLE `queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `job` longblob NOT NULL,
  `description` text,
  `timePushed` int(11) NOT NULL,
  `ttr` int(11) NOT NULL,
  `delay` int(11) NOT NULL DEFAULT '0',
  `priority` int(11) unsigned NOT NULL DEFAULT '1024',
  `dateReserved` datetime DEFAULT NULL,
  `timeUpdated` int(11) DEFAULT NULL,
  `progress` smallint(6) NOT NULL DEFAULT '0',
  `attempt` int(11) DEFAULT NULL,
  `fail` tinyint(1) DEFAULT '0',
  `dateFailed` datetime DEFAULT NULL,
  `error` text,
  PRIMARY KEY (`id`),
  KEY `queue_fail_timeUpdated_timePushed_idx` (`fail`,`timeUpdated`,`timePushed`),
  KEY `queue_fail_timeUpdated_delay_idx` (`fail`,`timeUpdated`,`delay`)
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
	(26,19,13,NULL,26,1,'2018-01-02 22:04:04','2018-01-02 22:04:04','4a3f79d6-1753-4fc6-a31f-f1079d07a38a'),
	(27,5,13,NULL,6,1,'2018-01-02 22:04:04','2018-01-02 22:04:04','04fda104-fc63-441a-9d51-e5dac472324d'),
	(28,10,15,NULL,6,1,'2018-01-02 22:04:04','2018-01-02 22:04:04','fd2ae4d3-30cd-4a81-817b-8bb242ce749e'),
	(29,10,18,NULL,11,1,'2018-01-02 22:04:04','2018-01-02 22:04:04','f62fab31-3166-4eae-b7df-f142dcc72216'),
	(77,19,2,NULL,26,1,'2018-02-15 17:14:00','2018-02-15 17:14:00','dd4a8b6f-ed47-4642-ac63-04fd1da0a050'),
	(78,5,2,NULL,6,1,'2018-02-15 17:14:00','2018-02-15 17:14:00','f3121421-99d5-4e97-b67c-1131846e0cfb'),
	(101,19,12,NULL,27,1,'2018-02-15 17:19:26','2018-02-15 17:19:26','42e4ec27-793e-4272-9878-05be014f8da7'),
	(102,5,12,NULL,11,1,'2018-02-15 17:19:26','2018-02-15 17:19:26','106d2143-6ec9-4445-b47f-addad2c80b5c');

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
	('102a4259','@lib/fileupload'),
	('209ca04e','@lib/fabric'),
	('35da7470','@lib/garnishjs'),
	('500eb99','@app/web/assets/utilities/dist'),
	('54d99ed4','@app/web/assets/updater/dist'),
	('56d02aa9','@lib/xregexp'),
	('5cbc6e23','@lib/selectize'),
	('66763f6','@lib/d3'),
	('677ba908','@app/web/assets/cp/dist'),
	('84687f20','@bower/jquery/dist'),
	('89c027b5','@lib/jquery.payment'),
	('8c243a7','@lib/picturefill'),
	('95e7885d','@lib/velocity'),
	('abf8d4d5','@lib/element-resize-detector'),
	('bb8b2835','@app/web/assets/updates/dist'),
	('db4e13f8','@lib/jquery-ui'),
	('f667f65','@lib/jquery-touch-events');

/*!40000 ALTER TABLE `resourcepaths` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table routes
# ------------------------------------------------------------

DROP TABLE IF EXISTS `routes`;

CREATE TABLE `routes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `siteId` int(11) DEFAULT NULL,
  `uriParts` varchar(255) NOT NULL,
  `uriPattern` varchar(255) NOT NULL,
  `template` varchar(500) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `routes_uriPattern_idx` (`uriPattern`),
  KEY `routes_siteId_idx` (`siteId`),
  CONSTRAINT `routes_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



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
	(1,'username',0,1,' admin '),
	(1,'firstname',0,1,' ryan '),
	(1,'lastname',0,1,' irelan '),
	(1,'fullname',0,1,' ryan irelan '),
	(1,'email',0,1,' ryan mijingo com '),
	(1,'slug',0,1,''),
	(2,'field',1,1,' this is an introduction to the espresso drink '),
	(2,'field',2,1,' lorem ipsum dolor sit amet consectetur adipisicing elit sed do eiusmod tempor incididunt ut labore et dolore magna aliqua ut enim ad minim veniam quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur excepteur sint occaecat cupidatat non proident sunt in culpa qui officia deserunt mollit anim id est laborum sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium totam rem aperiam eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt neque porro quisquam est qui dolorem ipsum quia dolor sit amet consectetur adipisci velit sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem ut enim ad minima veniam quis nostrum exercitationem ullam corporis suscipit laboriosam nisi ut aliquid ex ea commodi consequatur quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur vel illum qui dolorem eum fugiat quo voluptas nulla pariatur at vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident similique sunt in culpa qui officia deserunt mollitia animi id est laborum et dolorum fuga et harum quidem rerum facilis est et expedita distinctio nam libero tempore cum soluta nobis est eligendi optio cumque nihil impedit quo minus id quod maxime placeat facere possimus omnis voluptas assumenda est omnis dolor repellendus temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet ut et voluptates repudiandae sint et molestiae non recusandae itaque earum rerum hic tenetur a sapiente delectus ut aut reiciendis voluptatibus maiores alias consequatur aut perferendis doloribus asperiores repellat '),
	(2,'slug',0,1,' perfect espresso '),
	(2,'title',0,1,' perfect espresso '),
	(3,'field',3,1,' if you re craving the best coffee in town we ve got it '),
	(3,'field',4,1,' lorem ipsum dolor sit amet consectetur adipisicing elit sed do eiusmod tempor incididunt ut labore et dolore magna aliqua ut enim ad minim veniam quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur excepteur sint occaecat cupidatat non proident sunt in culpa qui officia deserunt mollit anim id est laborum sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium totam rem aperiam eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt neque porro quisquam est qui dolorem ipsum quia dolor sit amet consectetur adipisci velit sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem ut enim ad minima veniam quis nostrum exercitationem ullam corporis suscipit laboriosam nisi ut aliquid ex ea commodi consequatur quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur vel illum qui dolorem eum fugiat quo voluptas nulla pariatur this is a fancy blockquoteat vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident similique sunt in culpa qui officia deserunt mollitia animi id est laborum et dolorum fuga et harum quidem rerum facilis est et expedita distinctio nam libero tempore cum soluta nobis est eligendi optio cumque nihil impedit quo minus id quod maxime placeat facere possimus omnis voluptas assumenda est omnis dolor repellendus temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet ut et voluptates repudiandae sint et molestiae non recusandae itaque earum rerum hic tenetur a sapiente delectus ut aut reiciendis voluptatibus maiores alias consequatur aut perferendis doloribus asperiores repellat '),
	(3,'slug',0,1,' crafty coffee is open for business '),
	(3,'title',0,1,' crafty coffee is open for business '),
	(6,'filename',0,1,' espresso shot jpg '),
	(2,'field',5,1,' espresso shot '),
	(5,'title',0,1,' homepage '),
	(5,'slug',0,1,' homepage '),
	(6,'extension',0,1,' jpg '),
	(6,'kind',0,1,' image '),
	(6,'slug',0,1,''),
	(6,'title',0,1,' espresso shot '),
	(7,'slug',0,1,' about '),
	(7,'title',0,1,' about crafty coffee '),
	(8,'slug',0,1,' locations '),
	(8,'title',0,1,' locations '),
	(9,'slug',0,1,' austin tx '),
	(9,'title',0,1,' austin tx '),
	(10,'slug',0,1,' founders '),
	(10,'title',0,1,' founders '),
	(7,'field',6,1,' how it happened '),
	(7,'field',7,1,' everything you ever needed to know '),
	(7,'field',2,1,' lorem ipsum dolor sit amet consectetur adipisicing elit sed do eiusmod tempor incididunt ut labore et dolore magna aliqua ut enim ad minim veniam quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur excepteur sint occaecat cupidatat non proident sunt in culpa qui officia deserunt mollit anim id est laborum sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium totam rem aperiam eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt neque porro quisquam est qui dolorem ipsum quia dolor sit amet consectetur adipisci velit sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem ut enim ad minima veniam quis nostrum exercitationem ullam corporis suscipit laboriosam nisi ut aliquid ex ea commodi consequatur quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur vel illum qui dolorem eum fugiat quo voluptas nulla pariatur at vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident similique sunt in culpa qui officia deserunt mollitia animi id est laborum et dolorum fuga et harum quidem rerum facilis est et expedita distinctio nam libero tempore cum soluta nobis est eligendi optio cumque nihil impedit quo minus id quod maxime placeat facere possimus omnis voluptas assumenda est omnis dolor repellendus temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet ut et voluptates repudiandae sint et molestiae non recusandae itaque earum rerum hic tenetur a sapiente delectus ut aut reiciendis voluptatibus maiores alias consequatur aut perferendis doloribus asperiores repellat '),
	(8,'field',6,1,' where we are '),
	(8,'field',7,1,' this is the intro '),
	(8,'field',2,1,' page copy '),
	(9,'field',6,1,' home of the tacos '),
	(9,'field',7,1,' page intro '),
	(9,'field',2,1,' page copy '),
	(10,'field',6,1,''),
	(10,'field',7,1,''),
	(10,'field',2,1,''),
	(11,'filename',0,1,' iced coffee jpg '),
	(11,'extension',0,1,' jpg '),
	(11,'kind',0,1,' image '),
	(11,'slug',0,1,''),
	(11,'title',0,1,' iced coffee '),
	(12,'field',5,1,' iced coffee '),
	(12,'field',1,1,' the best coffee of your life '),
	(12,'field',2,1,' crafty coffee '),
	(12,'slug',0,1,' japanese iced coffee '),
	(12,'title',0,1,' japanese iced coffee '),
	(12,'field',8,1,''),
	(2,'field',8,1,''),
	(13,'field',17,1,' this is the first thing this is the first thing this is the second thing this is the second thing this is the third thing this is the third thing '),
	(13,'field',9,1,' this is the body copy of the recipe this is another tip i can have more copy right here espresso shot espresso is the best 1 cup water 1 cup water 18 grams espresso beans 18 grams espresso beans 1 quality coffee grinder 1 quality coffee grinder iced coffee this is the caption please only use a quality burr grinder for making espresso turn on your espresso machine turn on your espresso machine buy good beans buy good beans alert friends and family that you need to focus alert friends and family that you need to focus preparation this is more copy step one step one step two step two step there step there grinding the beans even more copy long winded step one step one step two step two step three step three extracting the espresso shot '),
	(14,'field',13,1,' this is the body copy of the recipe '),
	(14,'slug',0,1,''),
	(15,'field',10,1,' espresso shot '),
	(15,'field',11,1,' espresso is the best '),
	(15,'slug',0,1,''),
	(16,'field',13,1,' i can have more copy right here '),
	(16,'slug',0,1,''),
	(17,'field',12,1,' this is another tip '),
	(17,'slug',0,1,''),
	(18,'field',10,1,' iced coffee '),
	(18,'field',11,1,' this is the caption '),
	(18,'slug',0,1,''),
	(19,'field',16,1,' 1 cup water 1 cup water 18 grams espresso beans 18 grams espresso beans 1 quality coffee grinder 1 quality coffee grinder '),
	(19,'slug',0,1,''),
	(20,'field',12,1,' please only use a quality burr grinder for making espresso '),
	(20,'slug',0,1,''),
	(21,'field',14,1,' preparation '),
	(21,'field',15,1,' turn on your espresso machine turn on your espresso machine buy good beans buy good beans alert friends and family that you need to focus alert friends and family that you need to focus '),
	(21,'slug',0,1,''),
	(22,'field',13,1,' this is more copy '),
	(22,'slug',0,1,''),
	(23,'field',14,1,' grinding the beans '),
	(23,'field',15,1,' step one step one step two step two step there step there '),
	(23,'slug',0,1,''),
	(24,'field',13,1,' even more copy long winded '),
	(24,'slug',0,1,''),
	(25,'field',14,1,' extracting the espresso shot '),
	(25,'field',15,1,' step one step one step two step two step three step three '),
	(25,'slug',0,1,''),
	(13,'slug',0,1,' perfect espresso '),
	(13,'title',0,1,' perfect espresso '),
	(13,'field',5,1,' espresso shot '),
	(13,'field',7,1,' this is the page intro '),
	(26,'field',18,1,' this is the style description '),
	(26,'slug',0,1,' espresso '),
	(26,'title',0,1,' espresso '),
	(13,'field',19,1,' espresso '),
	(12,'field',19,1,' iced coffee '),
	(2,'field',19,1,' espresso '),
	(27,'field',18,1,' the best way to drink coffee in the summer '),
	(27,'slug',0,1,' iced coffee '),
	(27,'title',0,1,' iced coffee '),
	(12,'field',20,1,''),
	(2,'field',20,1,''),
	(28,'field',6,1,' our newest location '),
	(28,'field',7,1,' home of the best basketball team on the planet '),
	(28,'field',2,1,' lorem ipsum dolor sit amet consectetur adipisicing elit sed do eiusmod tempor incididunt ut labore et dolore magna aliqua ut enim ad minim veniam quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur excepteur sint occaecat cupidatat non proident sunt in culpa qui officia deserunt mollit anim id est laborum '),
	(28,'slug',0,1,' chapel hill nc '),
	(28,'title',0,1,' chapel hill nc '),
	(29,'field',6,1,''),
	(29,'field',7,1,''),
	(29,'field',2,1,' lorem ipsum dolor sit amet consectetur adipisicing elit sed do eiusmod tempor incididunt ut labore et dolore magna aliqua ut enim ad minim veniam quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur excepteur sint occaecat cupidatat non proident sunt in culpa qui officia deserunt mollit anim id est laborum '),
	(29,'slug',0,1,' hamburg germany '),
	(29,'title',0,1,' hamburg germany '),
	(30,'slug',0,1,''),
	(30,'field',21,1,' a website about coffee how to make how to drink and where you can buy it '),
	(11,'filename',0,2,' iced coffee jpg '),
	(11,'extension',0,2,' jpg '),
	(11,'kind',0,2,' image '),
	(11,'slug',0,2,''),
	(11,'title',0,2,' iced coffee '),
	(6,'filename',0,2,' espresso shot jpg '),
	(6,'extension',0,2,' jpg '),
	(6,'kind',0,2,' image '),
	(6,'slug',0,2,''),
	(6,'title',0,2,' espresso shot '),
	(26,'field',18,2,' this is the style description '),
	(26,'slug',0,2,' espresso '),
	(26,'title',0,2,' espresso '),
	(27,'field',18,2,' the best way to drink coffee in the summer '),
	(27,'slug',0,2,' iced coffee '),
	(27,'title',0,2,' iced coffee '),
	(30,'slug',0,2,''),
	(5,'slug',0,2,' homepage '),
	(5,'title',0,2,' homepage '),
	(12,'field',19,2,' iced coffee '),
	(12,'field',5,2,' iced coffee '),
	(12,'field',1,2,' der beste eiskaffe im leben de '),
	(12,'field',2,2,' hier wird was geschrieben '),
	(12,'field',8,2,''),
	(12,'field',20,2,''),
	(12,'slug',0,2,' japanischer eiskaffee '),
	(12,'title',0,2,' japanischer eiskaffee '),
	(2,'field',19,2,' espresso '),
	(2,'field',5,2,' espresso shot '),
	(2,'field',1,2,' this is an introduction to the espresso drink '),
	(2,'field',2,2,' lorem ipsum dolor sit amet consectetur adipisicing elit sed do eiusmod tempor incididunt ut labore et dolore magna aliqua ut enim ad minim veniam quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur excepteur sint occaecat cupidatat non proident sunt in culpa qui officia deserunt mollit anim id est laborum sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium totam rem aperiam eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt neque porro quisquam est qui dolorem ipsum quia dolor sit amet consectetur adipisci velit sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem ut enim ad minima veniam quis nostrum exercitationem ullam corporis suscipit laboriosam nisi ut aliquid ex ea commodi consequatur quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur vel illum qui dolorem eum fugiat quo voluptas nulla pariatur at vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident similique sunt in culpa qui officia deserunt mollitia animi id est laborum et dolorum fuga et harum quidem rerum facilis est et expedita distinctio nam libero tempore cum soluta nobis est eligendi optio cumque nihil impedit quo minus id quod maxime placeat facere possimus omnis voluptas assumenda est omnis dolor repellendus temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet ut et voluptates repudiandae sint et molestiae non recusandae itaque earum rerum hic tenetur a sapiente delectus ut aut reiciendis voluptatibus maiores alias consequatur aut perferendis doloribus asperiores repellat '),
	(2,'field',8,2,''),
	(2,'field',20,2,''),
	(2,'slug',0,2,' perfect espresso '),
	(2,'title',0,2,' perfect espresso '),
	(11,'filename',0,3,' iced coffee jpg '),
	(11,'extension',0,3,' jpg '),
	(11,'kind',0,3,' image '),
	(11,'slug',0,3,''),
	(11,'title',0,3,' iced coffee '),
	(6,'filename',0,3,' espresso shot jpg '),
	(6,'extension',0,3,' jpg '),
	(6,'kind',0,3,' image '),
	(6,'slug',0,3,''),
	(6,'title',0,3,' espresso shot '),
	(26,'field',18,3,' this is the style description '),
	(26,'slug',0,3,' espresso '),
	(26,'title',0,3,' espresso '),
	(27,'field',18,3,' the best way to drink coffee in the summer '),
	(27,'slug',0,3,' iced coffee '),
	(27,'title',0,3,' iced coffee '),
	(30,'slug',0,3,''),
	(30,'field',21,2,' a website about coffee how to make how to drink and where you can buy it '),
	(12,'field',19,3,' iced coffee '),
	(12,'field',5,3,' iced coffee '),
	(12,'field',1,3,' the best coffee of your life roasterei '),
	(12,'field',2,3,' hier wird was geschrieben '),
	(12,'field',8,3,''),
	(12,'field',20,3,''),
	(12,'slug',0,3,' japanese iced coffee '),
	(12,'title',0,3,' japanese iced coffee '),
	(2,'field',19,3,' espresso '),
	(2,'field',5,3,' espresso shot '),
	(2,'field',1,3,' this is an introduction to the espresso drink '),
	(2,'field',2,3,' lorem ipsum dolor sit amet consectetur adipisicing elit sed do eiusmod tempor incididunt ut labore et dolore magna aliqua ut enim ad minim veniam quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur excepteur sint occaecat cupidatat non proident sunt in culpa qui officia deserunt mollit anim id est laborum sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium totam rem aperiam eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt neque porro quisquam est qui dolorem ipsum quia dolor sit amet consectetur adipisci velit sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem ut enim ad minima veniam quis nostrum exercitationem ullam corporis suscipit laboriosam nisi ut aliquid ex ea commodi consequatur quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur vel illum qui dolorem eum fugiat quo voluptas nulla pariatur at vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident similique sunt in culpa qui officia deserunt mollitia animi id est laborum et dolorum fuga et harum quidem rerum facilis est et expedita distinctio nam libero tempore cum soluta nobis est eligendi optio cumque nihil impedit quo minus id quod maxime placeat facere possimus omnis voluptas assumenda est omnis dolor repellendus temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet ut et voluptates repudiandae sint et molestiae non recusandae itaque earum rerum hic tenetur a sapiente delectus ut aut reiciendis voluptatibus maiores alias consequatur aut perferendis doloribus asperiores repellat '),
	(2,'field',8,3,''),
	(2,'field',20,3,''),
	(2,'slug',0,3,' perfect espresso '),
	(2,'title',0,3,' perfect espresso ');

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
  `enableVersioning` tinyint(1) NOT NULL DEFAULT '0',
  `propagateEntries` tinyint(1) NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `sections_handle_unq_idx` (`handle`),
  UNIQUE KEY `sections_name_unq_idx` (`name`),
  KEY `sections_structureId_idx` (`structureId`),
  CONSTRAINT `sections_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `structures` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `sections` WRITE;
/*!40000 ALTER TABLE `sections` DISABLE KEYS */;

INSERT INTO `sections` (`id`, `structureId`, `name`, `handle`, `type`, `enableVersioning`, `propagateEntries`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,NULL,'Drinks','drinks','channel',1,1,'2017-12-29 21:48:32','2018-02-15 17:14:00','5fc2aad1-c7b2-4080-a631-c1bbcd9f800e'),
	(2,NULL,'News','news','channel',1,1,'2017-12-29 21:58:58','2017-12-29 21:58:58','a6335f97-2080-43cd-9f53-abe403373996'),
	(3,NULL,'Homepage','homepage','single',0,1,'2017-12-29 22:21:08','2018-02-09 15:45:34','016e92ff-2c08-4a5a-9591-70576d16100f'),
	(4,1,'About','about','structure',1,1,'2017-12-29 22:51:48','2017-12-29 22:58:20','fec4e53c-d4fa-458f-a325-9c4edaa7b557'),
	(5,NULL,'Recipes','recipes','channel',1,1,'2018-01-02 20:57:56','2018-01-02 20:57:56','b0b0f3e8-df8e-481f-a2f9-2c4e23d48904');

/*!40000 ALTER TABLE `sections` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sections_sites
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sections_sites`;

CREATE TABLE `sections_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sectionId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `enabledByDefault` tinyint(1) NOT NULL DEFAULT '1',
  `hasUrls` tinyint(1) NOT NULL DEFAULT '1',
  `uriFormat` text,
  `template` varchar(500) DEFAULT NULL,
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

INSERT INTO `sections_sites` (`id`, `sectionId`, `siteId`, `enabledByDefault`, `hasUrls`, `uriFormat`, `template`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,1,1,1,1,'drinks/{slug}','drinks/_entry','2017-12-29 21:48:32','2018-02-15 17:14:00','5abc0892-57b9-4459-9459-f337bacabe5a'),
	(2,2,1,1,1,'news/{slug}','news/_entry','2017-12-29 21:58:58','2017-12-29 21:58:58','588e4354-121e-4352-9707-f96947d3f8be'),
	(3,3,1,1,1,'/','index.twig','2017-12-29 22:21:08','2018-02-09 15:45:34','4497b998-abb6-4fc2-95bf-415f83dcbc71'),
	(4,4,1,1,1,'{parent.uri}/{slug}','about/_entry','2017-12-29 22:51:48','2017-12-29 22:58:20','3afc7b8c-8345-4fe3-9127-4a1043f31863'),
	(5,5,1,1,1,'recipes/{slug}','recipes/_entry','2018-01-02 20:57:56','2018-01-02 20:57:56','cadfd977-316b-4c55-b611-3ba5dc899e61'),
	(6,3,2,1,1,'__home__','de/index.twig','2018-02-09 15:29:44','2018-02-09 15:45:34','4515c8d5-87ee-4e33-840d-1cb79567afb3'),
	(7,1,2,1,1,'getraenke/{slug}','drinks/_entry','2018-02-09 15:32:05','2018-02-15 17:14:00','96f95bf2-69b8-43d1-b9d3-c7e945fb627a'),
	(8,1,3,1,1,'drinks/{slug}','drinks/_entry','2018-02-15 17:14:00','2018-02-15 17:14:00','8f6c2a07-c02b-4ca3-856f-5c1340add1fe');

/*!40000 ALTER TABLE `sections_sites` ENABLE KEYS */;
UNLOCK TABLES;


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

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;

INSERT INTO `sessions` (`id`, `userId`, `token`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(12,1,'25OOfujfkslFMf5vSb9SkKmiaImx8OzWXcRzHXMg5uJDQ7T5G6i7xsHrD_P7ns_E3IMzEOHGoE-6S1fOFp_mHBZnXOZHeMAgvedO','2018-10-25 20:53:23','2018-10-25 20:54:33','5f60c3cd-978a-460b-ad41-8a5e98a3d750');

/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;


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
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `sitegroups_name_unq_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `sitegroups` WRITE;
/*!40000 ALTER TABLE `sitegroups` DISABLE KEYS */;

INSERT INTO `sitegroups` (`id`, `name`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,'Crafty Coffee','2017-12-29 17:38:45','2017-12-29 17:38:45','110e06e2-c32d-421f-8cf5-cd7b2e25de1c'),
	(2,'English','2018-02-09 15:15:54','2018-02-09 15:15:54','9c2158cd-e7b9-42da-b2dc-57bbfeee3c07'),
	(3,'German','2018-02-09 15:28:58','2018-02-09 15:28:58','c2683e88-e6c3-4580-a96c-332a8a3f827d');

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
  `hasUrls` tinyint(1) NOT NULL DEFAULT '0',
  `baseUrl` varchar(255) DEFAULT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `sites_handle_unq_idx` (`handle`),
  KEY `sites_sortOrder_idx` (`sortOrder`),
  KEY `sites_groupId_fk` (`groupId`),
  CONSTRAINT `sites_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `sitegroups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `sites` WRITE;
/*!40000 ALTER TABLE `sites` DISABLE KEYS */;

INSERT INTO `sites` (`id`, `groupId`, `primary`, `name`, `handle`, `language`, `hasUrls`, `baseUrl`, `sortOrder`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,2,1,'Crafty Coffee','default','en-US',1,'https://craftycoffee.dev/',1,'2017-12-29 17:38:45','2018-02-09 15:29:12','d5f09a60-cd1b-4e3c-811b-43fa6d152dc7'),
	(2,3,0,'Krafty Kaffee','kraftyKaffee','de',1,'https://de.craftycoffee.dev/',2,'2018-02-09 15:28:52','2018-02-09 15:29:07','ab30b810-b780-42f5-8619-f00e67c4c762'),
	(3,1,0,'Crafty Roasterei','craftyRoasterei','en-US',1,'https://craftyroasterei.dev',3,'2018-02-13 17:47:00','2018-02-13 17:47:00','0cb94306-5f6d-4c44-a78e-65ce0703913c');

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
	(1,1,NULL,1,1,14,0,'2017-12-29 22:52:18','2018-01-30 21:02:59','643c05a3-40a2-429b-a7f9-8561c8bd81c6'),
	(2,1,7,1,2,13,1,'2017-12-29 22:52:18','2018-01-30 21:02:59','ac30a615-bc7d-4384-ac29-2bb133254d3d'),
	(3,1,8,1,3,10,2,'2017-12-29 22:52:28','2018-01-30 21:02:59','63912094-8998-4d34-a261-8c2dd515f4b6'),
	(4,1,9,1,4,5,3,'2017-12-29 22:53:01','2017-12-29 22:53:01','1584460a-e570-41cc-b299-687fed8d6827'),
	(5,1,10,1,11,12,2,'2017-12-29 22:58:50','2018-01-30 21:02:59','4633567a-48d1-4e98-a3f1-b736dfc69dfc'),
	(6,2,NULL,6,1,6,0,'2018-01-02 22:01:22','2018-01-02 22:03:40','71cff3e2-0967-4a28-9783-e2cefa1a15f5'),
	(7,2,26,6,2,3,1,'2018-01-02 22:01:22','2018-01-02 22:01:22','1763409a-169f-44c2-adf5-4a6348c8bd01'),
	(8,2,27,6,4,5,1,'2018-01-02 22:03:40','2018-01-02 22:03:40','768ce108-e96e-49cd-bafd-38f6164eb18f'),
	(9,1,28,1,6,7,3,'2018-01-29 20:12:51','2018-01-29 20:12:51','702bf13e-1be3-48cc-9887-f61f9cce728f'),
	(10,1,29,1,8,9,3,'2018-01-30 21:02:59','2018-01-30 21:02:59','4b85486d-e6b6-438c-bd06-bc7dd10912e9');

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
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `structures` WRITE;
/*!40000 ALTER TABLE `structures` DISABLE KEYS */;

INSERT INTO `structures` (`id`, `maxLevels`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,NULL,'2017-12-29 22:51:48','2017-12-29 22:58:20','513be269-c0ba-4bd5-af8f-75378f9b644b'),
	(2,2,'2018-01-02 21:58:37','2018-01-02 22:00:39','fa651328-1651-4c7a-8d60-c5a9a47b80ba');

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



# Dump of table systemsettings
# ------------------------------------------------------------

DROP TABLE IF EXISTS `systemsettings`;

CREATE TABLE `systemsettings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category` varchar(15) NOT NULL,
  `settings` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `systemsettings_category_unq_idx` (`category`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `systemsettings` WRITE;
/*!40000 ALTER TABLE `systemsettings` DISABLE KEYS */;

INSERT INTO `systemsettings` (`id`, `category`, `settings`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,'email','{\"fromEmail\":\"ryan@mijingo.com\",\"fromName\":\"Crafty Coffee\",\"transportType\":\"craft\\\\mail\\\\transportadapters\\\\Sendmail\"}','2017-12-29 17:38:45','2017-12-29 17:38:45','b96ada1f-3b4d-4a0b-8f6a-eba1c0f82ca0');

/*!40000 ALTER TABLE `systemsettings` ENABLE KEYS */;
UNLOCK TABLES;


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
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `taggroups_name_unq_idx` (`name`),
  UNIQUE KEY `taggroups_handle_unq_idx` (`handle`),
  KEY `taggroups_fieldLayoutId_fk` (`fieldLayoutId`),
  CONSTRAINT `taggroups_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table tags
# ------------------------------------------------------------

DROP TABLE IF EXISTS `tags`;

CREATE TABLE `tags` (
  `id` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
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
  `route` text,
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
  `preferences` text,
  PRIMARY KEY (`userId`),
  CONSTRAINT `userpreferences_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `userpreferences` WRITE;
/*!40000 ALTER TABLE `userpreferences` DISABLE KEYS */;

INSERT INTO `userpreferences` (`userId`, `preferences`)
VALUES
	(1,'{\"language\":\"en-US\",\"weekStartDay\":\"0\",\"enableDebugToolbarForSite\":true,\"enableDebugToolbarForCp\":true}');

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
  `admin` tinyint(1) NOT NULL DEFAULT '0',
  `locked` tinyint(1) NOT NULL DEFAULT '0',
  `suspended` tinyint(1) NOT NULL DEFAULT '0',
  `pending` tinyint(1) NOT NULL DEFAULT '0',
  `lastLoginDate` datetime DEFAULT NULL,
  `lastLoginAttemptIp` varchar(45) DEFAULT NULL,
  `invalidLoginWindowStart` datetime DEFAULT NULL,
  `invalidLoginCount` tinyint(3) unsigned DEFAULT NULL,
  `lastInvalidLoginDate` datetime DEFAULT NULL,
  `lockoutDate` datetime DEFAULT NULL,
  `hasDashboard` tinyint(1) NOT NULL DEFAULT '0',
  `verificationCode` varchar(255) DEFAULT NULL,
  `verificationCodeIssuedDate` datetime DEFAULT NULL,
  `unverifiedEmail` varchar(255) DEFAULT NULL,
  `passwordResetRequired` tinyint(1) NOT NULL DEFAULT '0',
  `lastPasswordChangeDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `users_uid_idx` (`uid`),
  KEY `users_verificationCode_idx` (`verificationCode`),
  KEY `users_photoId_fk` (`photoId`),
  KEY `users_email_idx` (`email`),
  KEY `users_username_idx` (`username`),
  CONSTRAINT `users_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `users_photoId_fk` FOREIGN KEY (`photoId`) REFERENCES `assets` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;

INSERT INTO `users` (`id`, `username`, `photoId`, `firstName`, `lastName`, `email`, `password`, `admin`, `locked`, `suspended`, `pending`, `lastLoginDate`, `lastLoginAttemptIp`, `invalidLoginWindowStart`, `invalidLoginCount`, `lastInvalidLoginDate`, `lockoutDate`, `hasDashboard`, `verificationCode`, `verificationCodeIssuedDate`, `unverifiedEmail`, `passwordResetRequired`, `lastPasswordChangeDate`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,'admin',NULL,'Ryan','Irelan','ryan@mijingo.com','$2y$13$gy5DsNUxu1TAkh51xZprue1SBj2XCp/uCsKOpQ3i1P57mYY1hT6oO',1,0,0,0,'2018-10-25 20:53:23','127.0.0.1',NULL,NULL,'2018-10-25 20:53:17',NULL,1,NULL,NULL,NULL,0,'2017-12-29 17:38:45','2017-12-29 17:38:45','2018-10-25 20:53:23','107ecda7-e80b-444a-bd2f-0f97fbe3a6a1');

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
	(1,NULL,1,'Drinks','','2017-12-29 22:35:58','2017-12-29 22:35:58','a84c7c74-9613-46ea-b7d6-2baebe8729ce'),
	(2,NULL,NULL,'Temporary source',NULL,'2017-12-29 22:39:35','2017-12-29 22:39:35','1cb254b2-d6e0-497e-bfd9-26db63c73e67'),
	(3,2,NULL,'user_1','user_1/','2017-12-29 22:39:35','2017-12-29 22:39:35','b904674e-d18d-4996-9396-0b16c6cc6501');

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
  `hasUrls` tinyint(1) NOT NULL DEFAULT '1',
  `url` varchar(255) DEFAULT NULL,
  `settings` text,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `volumes_name_unq_idx` (`name`),
  UNIQUE KEY `volumes_handle_unq_idx` (`handle`),
  KEY `volumes_fieldLayoutId_idx` (`fieldLayoutId`),
  CONSTRAINT `volumes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `volumes` WRITE;
/*!40000 ALTER TABLE `volumes` DISABLE KEYS */;

INSERT INTO `volumes` (`id`, `fieldLayoutId`, `name`, `handle`, `type`, `hasUrls`, `url`, `settings`, `sortOrder`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,4,'Drinks','drinks','craft\\volumes\\Local',1,'//craftycoffee.dev/images/drinks','{\"path\":\"/Users/ryan/training/up-and-running-with-craft/craftycoffee/web/images/drinks\"}',1,'2017-12-29 22:35:58','2017-12-29 22:35:58','6cd5f724-b88e-4084-8f92-e00cc7dea583');

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
  `colspan` tinyint(1) NOT NULL DEFAULT '0',
  `settings` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `widgets_userId_idx` (`userId`),
  CONSTRAINT `widgets_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `widgets` WRITE;
/*!40000 ALTER TABLE `widgets` DISABLE KEYS */;

INSERT INTO `widgets` (`id`, `userId`, `type`, `sortOrder`, `colspan`, `settings`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,1,'craft\\widgets\\RecentEntries',2,3,'{\"section\":\"*\",\"siteId\":\"1\",\"limit\":10}','2017-12-29 17:38:47','2017-12-29 19:09:30','c3098352-9a61-4e31-9965-0dbbb8a526e2'),
	(2,1,'craft\\widgets\\CraftSupport',3,1,'[]','2017-12-29 17:38:47','2017-12-29 19:09:30','504f69cd-96d1-4806-adb8-be8d652bb476'),
	(3,1,'craft\\widgets\\Updates',1,0,'[]','2017-12-29 17:38:47','2017-12-29 19:09:30','17cfb35c-0387-441c-862b-33ab99e178d7'),
	(6,1,'craft\\widgets\\Feed',6,0,'{\"url\":\"https://api.ryanirelan.com/feed.rss\",\"title\":\"Ryan Irelan\",\"limit\":\"5\"}','2017-12-29 19:10:33','2017-12-29 19:10:33','bf7fb896-8d1e-4246-9566-99abb5744b95');

/*!40000 ALTER TABLE `widgets` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
