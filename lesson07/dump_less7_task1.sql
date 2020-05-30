-- MySQL dump 10.13  Distrib 8.0.20, for Linux (x86_64)
--
-- Host: localhost    Database: task1
-- ------------------------------------------------------
-- Server version	8.0.20

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `client_id` bigint unsigned NOT NULL,
  `product_id` bigint unsigned NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `client_id` (`client_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `users` (`id`),
  CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,52,6,'2016-11-19 19:24:14'),(2,41,20,'2015-10-14 23:06:11'),(3,26,47,'2020-03-14 20:06:02'),(4,47,69,'2018-01-10 06:48:17'),(5,57,96,'2017-10-07 23:15:37'),(6,70,39,'2016-09-14 01:21:18'),(7,29,52,'2016-05-24 00:57:36'),(8,59,59,'2019-10-13 18:51:13'),(9,50,72,'2020-04-30 16:26:33'),(10,59,74,'2017-10-17 02:21:47'),(11,72,86,'2016-09-11 18:22:12'),(12,79,90,'2020-02-20 07:43:24'),(13,73,58,'2016-06-20 15:10:58'),(14,18,74,'2018-01-31 07:35:09'),(15,63,31,'2019-01-18 15:13:44'),(16,56,84,'2019-11-29 11:03:20'),(17,85,22,'2017-01-19 05:13:04'),(18,64,22,'2018-10-17 21:25:33'),(19,83,1,'2020-05-20 08:57:05'),(20,97,87,'2015-03-15 03:11:36'),(21,51,21,'2018-07-11 19:12:46'),(22,52,13,'2015-11-26 18:34:15'),(23,25,36,'2016-02-11 02:59:15'),(24,53,14,'2017-09-08 19:44:32'),(25,57,35,'2018-06-02 18:15:40'),(26,74,27,'2015-09-30 04:04:19'),(27,73,94,'2016-01-01 05:48:58'),(28,94,40,'2015-10-22 13:51:35'),(29,39,73,'2015-07-19 14:07:25'),(30,75,12,'2015-03-03 04:52:56'),(31,96,78,'2017-10-01 06:24:13'),(32,51,80,'2019-05-31 10:36:41'),(33,9,49,'2017-03-14 10:07:18'),(34,71,61,'2017-02-21 04:30:04'),(35,54,94,'2015-09-17 14:51:49'),(36,87,80,'2017-09-14 00:00:27'),(37,61,97,'2017-04-22 15:05:56'),(38,60,43,'2015-08-20 20:13:37'),(39,64,43,'2019-12-12 17:01:11'),(40,60,35,'2015-08-02 20:49:07'),(41,31,26,'2018-11-16 15:31:39'),(42,41,74,'2020-03-26 12:56:19'),(43,69,85,'2017-10-27 05:40:34'),(44,34,55,'2018-01-03 00:42:12'),(45,3,10,'2016-01-30 01:18:34'),(46,49,100,'2018-07-24 22:56:29'),(47,79,21,'2018-04-19 12:39:14'),(48,90,12,'2016-07-06 14:20:58'),(49,32,98,'2018-10-14 13:13:39'),(50,26,64,'2017-12-11 05:38:53'),(51,5,77,'2019-07-09 19:57:19'),(52,85,60,'2016-07-18 13:56:27'),(53,18,45,'2019-09-19 19:04:20'),(54,39,21,'2016-08-02 01:34:56'),(55,70,55,'2017-09-14 01:22:43'),(56,84,70,'2020-03-29 14:07:09'),(57,58,88,'2015-06-20 10:57:11'),(58,32,53,'2018-07-19 15:53:07'),(59,24,81,'2016-02-07 17:30:39'),(60,93,77,'2016-12-19 03:20:23'),(61,95,80,'2017-08-16 15:36:15'),(62,83,38,'2019-06-14 13:06:33'),(63,17,47,'2016-10-13 20:53:03'),(64,5,94,'2015-03-06 13:42:14'),(65,60,12,'2020-01-31 15:45:15'),(66,10,35,'2018-11-21 14:01:30'),(67,31,24,'2017-10-08 06:58:36'),(68,25,33,'2020-03-26 07:04:09'),(69,47,2,'2017-05-03 12:13:33'),(70,2,74,'2016-04-10 12:25:36'),(71,30,64,'2018-03-18 05:39:57'),(72,15,90,'2016-05-05 01:23:09'),(73,90,68,'2015-03-21 06:01:38'),(74,18,90,'2016-02-23 06:36:00'),(75,100,84,'2015-12-15 03:01:07'),(76,95,77,'2017-03-19 13:38:20'),(77,100,73,'2020-04-06 22:15:16'),(78,52,83,'2018-02-06 19:48:20'),(79,81,92,'2018-07-27 15:17:16'),(80,13,91,'2016-12-24 15:51:34'),(81,76,84,'2019-08-11 03:26:30'),(82,53,23,'2018-01-29 16:08:48'),(83,84,46,'2017-08-12 04:24:18'),(84,64,91,'2017-09-12 22:30:44'),(85,56,91,'2017-08-24 19:16:33'),(86,59,90,'2017-08-20 21:37:01'),(87,69,83,'2017-12-04 06:48:09'),(88,1,13,'2017-11-14 01:02:14'),(89,5,49,'2018-04-13 18:45:31'),(90,49,34,'2019-05-21 20:19:35'),(91,7,36,'2018-08-20 00:07:18'),(92,80,3,'2016-03-15 18:19:13'),(93,32,91,'2018-01-11 20:54:43'),(94,35,66,'2019-03-07 02:23:26'),(95,83,13,'2017-12-21 15:49:05'),(96,26,2,'2020-05-21 07:24:02'),(97,8,47,'2018-07-21 04:28:26'),(98,88,54,'2015-03-13 02:40:34'),(99,23,72,'2015-05-01 14:41:23'),(100,26,27,'2020-01-20 21:10:01');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `make` varchar(128) COLLATE utf8_bin NOT NULL,
  `model` varchar(128) COLLATE utf8_bin NOT NULL,
  `vendor_code` varchar(128) COLLATE utf8_bin NOT NULL,
  `description` text COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'Integer','nisi','665950028','sed, facilisis vitae, orci. Phasellus dapibus quam quis diam.'),(2,'sem','Cras','919270124','eu, accumsan sed, facilisis vitae,'),(3,'Suspendisse','est,','810623405','non, dapibus rutrum, justo. Praesent luctus.'),(4,'Nunc','orci','257432211','nec, eleifend non, dapibus rutrum, justo. Praesent luctus. Curabitur egestas'),(5,'enim.','tempus','263176257','Cum sociis natoque penatibus et magnis'),(6,'elementum','accumsan','472521798','Nullam ut nisi a odio semper cursus. Integer'),(7,'nec','pede,','640506416','ipsum nunc id enim. Curabitur'),(8,'malesuada.','lorem','081641482','tempus, lorem fringilla ornare placerat, orci lacus'),(9,'euismod','pede','283606291','aliquam eu, accumsan sed, facilisis vitae, orci.'),(10,'sollicitudin','Morbi','513623298','velit. Aliquam nisl. Nulla eu neque pellentesque massa'),(11,'scelerisque','id','566126959','Proin dolor. Nulla semper tellus id'),(12,'magnis','In','349224923','in magna. Phasellus dolor elit, pellentesque a,'),(13,'Donec','et,','866076656','dignissim. Maecenas ornare egestas ligula. Nullam feugiat placerat'),(14,'odio,','aliquet','704493873','fermentum convallis ligula. Donec luctus aliquet odio. Etiam ligula'),(15,'Nulla','lorem','424484640','ligula tortor, dictum eu, placerat eget, venenatis a,'),(16,'Aenean','felis','467822920','est, congue a, aliquet vel, vulputate eu, odio. Phasellus at'),(17,'Morbi','urna.','263809113','in sodales elit erat vitae risus. Duis a'),(18,'risus.','ut','910005230','turpis nec mauris blandit mattis. Cras'),(19,'dignissim','blandit','572819381','Donec fringilla. Donec feugiat metus sit amet ante.'),(20,'In','amet','465684496','tempor diam dictum sapien. Aenean massa. Integer vitae'),(21,'et','sapien,','373654524','gravida. Praesent eu nulla at sem molestie sodales.'),(22,'sapien,','libero.','407860857','vel arcu. Curabitur ut odio vel'),(23,'Duis','auctor','455857680','adipiscing, enim mi tempor lorem,'),(24,'Nullam','Ut','703020743','interdum. Sed auctor odio a'),(25,'Nunc','In','000793588','sem. Nulla interdum. Curabitur dictum. Phasellus in'),(26,'ridiculus','Quisque','720446533','metus sit amet ante. Vivamus non lorem vitae'),(27,'ornare','eleifend.','082962887','mi tempor lorem, eget mollis lectus'),(28,'Duis','ornare,','113724280','sed consequat auctor, nunc nulla vulputate dui,'),(29,'dictum','sit','681260394','molestie pharetra nibh. Aliquam ornare,'),(30,'turpis.','non','425039104','non, dapibus rutrum, justo. Praesent luctus. Curabitur egestas nunc sed'),(31,'dis','risus','807225917','at, velit. Pellentesque ultricies dignissim lacus.'),(32,'sed','est.','496397258','euismod in, dolor. Fusce feugiat.'),(33,'Aliquam','mauris','835901539','Integer tincidunt aliquam arcu. Aliquam ultrices'),(34,'eget','lectus','713734747','Nunc ullamcorper, velit in aliquet lobortis, nisi nibh'),(35,'a','Phasellus','679317966','penatibus et magnis dis parturient montes,'),(36,'a','Etiam','162221568','neque sed sem egestas blandit. Nam'),(37,'Aliquam','vel','197482540','ac risus. Morbi metus. Vivamus euismod urna. Nullam lobortis quam'),(38,'Fusce','eu','283781227','Phasellus dapibus quam quis diam.'),(39,'ipsum','dui','595553157','malesuada malesuada. Integer id magna et ipsum cursus vestibulum.'),(40,'lorem,','quis','941483315','lacus pede sagittis augue, eu'),(41,'porttitor','consectetuer','424075778','cursus luctus, ipsum leo elementum sem,'),(42,'id','id','014565857','Nulla dignissim. Maecenas ornare egestas'),(43,'dui.','euismod','659922017','feugiat metus sit amet ante. Vivamus non lorem vitae odio'),(44,'lectus.','tortor,','856727201','Integer eu lacus. Quisque imperdiet, erat nonummy ultricies ornare, elit'),(45,'eleifend.','tempus','214247686','fringilla ornare placerat, orci lacus vestibulum lorem, sit amet'),(46,'arcu.','porttitor','012936829','euismod urna. Nullam lobortis quam a felis ullamcorper'),(47,'metus.','Aenean','268846151','sed, sapien. Nunc pulvinar arcu et pede.'),(48,'lobortis','egestas.','398112599','magna nec quam. Curabitur vel lectus. Cum sociis natoque'),(49,'consectetuer','scelerisque','849414362','rutrum urna, nec luctus felis purus ac tellus. Suspendisse'),(50,'volutpat','ante','352175277','suscipit, est ac facilisis facilisis, magna tellus'),(51,'eleifend','Cras','289891616','dictum eu, eleifend nec, malesuada ut, sem. Nulla'),(52,'nec','Quisque','247563240','eget nisi dictum augue malesuada malesuada. Integer'),(53,'iaculis','nibh','114074362','nonummy ac, feugiat non, lobortis quis, pede.'),(54,'sed,','non','909372195','commodo hendrerit. Donec porttitor tellus non magna. Nam'),(55,'ante','purus.','177296043','vitae, orci. Phasellus dapibus quam quis diam. Pellentesque habitant morbi'),(56,'sapien,','ipsum.','378603708','convallis in, cursus et, eros.'),(57,'sed','elementum','562665117','amet, consectetuer adipiscing elit. Aliquam auctor, velit eget laoreet posuere,'),(58,'tristique','enim.','384143947','vitae sodales nisi magna sed'),(59,'felis.','nostra,','239627292','aliquam eu, accumsan sed, facilisis vitae, orci. Phasellus dapibus'),(60,'nunc,','non,','505609990','bibendum sed, est. Nunc laoreet lectus quis massa.'),(61,'nostra,','Mauris','431864610','rutrum urna, nec luctus felis purus ac tellus. Suspendisse'),(62,'Pellentesque','malesuada','672896438','magna. Sed eu eros. Nam consequat dolor'),(63,'ullamcorper.','neque','011415726','et malesuada fames ac turpis egestas.'),(64,'sollicitudin','ridiculus','924321151','malesuada fames ac turpis egestas. Aliquam'),(65,'condimentum.','tortor.','866112030','lacus. Nulla tincidunt, neque vitae'),(66,'a','lectus','211581954','sem, vitae aliquam eros turpis non enim. Mauris'),(67,'sed','at,','698653797','consequat enim diam vel arcu.'),(68,'velit','leo.','077051589','convallis ligula. Donec luctus aliquet odio. Etiam ligula tortor,'),(69,'ipsum','Nunc','358947125','vitae, sodales at, velit. Pellentesque ultricies dignissim lacus.'),(70,'Pellentesque','quis','509505640','orci luctus et ultrices posuere cubilia Curae; Donec tincidunt. Donec'),(71,'consequat','montes,','921823019','semper, dui lectus rutrum urna,'),(72,'commodo','dolor,','928070259','nunc, ullamcorper eu, euismod ac, fermentum vel, mauris. Integer sem'),(73,'leo.','elit,','942915166','pretium aliquet, metus urna convallis erat, eget tincidunt'),(74,'vulputate,','Donec','792913188','neque et nunc. Quisque ornare tortor at risus. Nunc ac'),(75,'Morbi','felis','166752691','mauris erat eget ipsum. Suspendisse'),(76,'eget,','cursus','762110351','dolor quam, elementum at, egestas a, scelerisque'),(77,'congue','ipsum','866387525','id, ante. Nunc mauris sapien,'),(78,'auctor','ante','335353462','velit eu sem. Pellentesque ut'),(79,'ligula.','id','174142166','est, vitae sodales nisi magna sed dui. Fusce aliquam, enim'),(80,'ultricies','Curabitur','261624993','quis arcu vel quam dignissim pharetra. Nam ac nulla.'),(81,'consectetuer','fermentum','329108088','vehicula. Pellentesque tincidunt tempus risus. Donec egestas. Duis ac arcu.'),(82,'Nullam','a','985400712','dictum magna. Ut tincidunt orci quis lectus.'),(83,'sed','consectetuer,','700938319','egestas blandit. Nam nulla magna, malesuada vel,'),(84,'Vivamus','nunc','029347010','Nunc ut erat. Sed nunc est, mollis'),(85,'Aenean','lorem','097071112','Class aptent taciti sociosqu ad'),(86,'morbi','malesuada','657759882','nisi sem semper erat, in consectetuer ipsum nunc id enim.'),(87,'lacus.','dolor.','526430210','vitae odio sagittis semper. Nam tempor diam dictum'),(88,'ipsum','enim','460935372','sem molestie sodales. Mauris blandit enim consequat purus. Maecenas libero'),(89,'magnis','feugiat.','742323850','Aliquam fringilla cursus purus. Nullam scelerisque neque sed sem egestas'),(90,'ipsum','pharetra','589382985','Aliquam auctor, velit eget laoreet'),(91,'orci.','Aenean','028274793','at, iaculis quis, pede. Praesent eu dui.'),(92,'eu,','libero','246946693','dignissim magna a tortor. Nunc commodo auctor velit. Aliquam nisl.'),(93,'eu,','euismod','451731814','nisi a odio semper cursus. Integer mollis. Integer'),(94,'neque.','nec','425082534','dolor, nonummy ac, feugiat non,'),(95,'augue','nec','675872014','cursus, diam at pretium aliquet, metus urna convallis'),(96,'est,','felis,','873553929','auctor, nunc nulla vulputate dui,'),(97,'ligula','sodales.','779005388','iaculis odio. Nam interdum enim non nisi. Aenean eget metus.'),(98,'adipiscing','nec','112832548','diam eu dolor egestas rhoncus. Proin nisl'),(99,'orci,','lacus.','403626518','vehicula. Pellentesque tincidunt tempus risus.'),(100,'morbi','et','260012505','vestibulum lorem, sit amet ultricies sem');
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `fname` varchar(128) COLLATE utf8_bin NOT NULL,
  `lname` varchar(128) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Deanna','Todd'),(2,'Fritz','Trevino'),(3,'Cameron','Norton'),(4,'Teegan','Burke'),(5,'Illiana','Burke'),(6,'Celeste','Patterson'),(7,'Yoko','Beard'),(8,'Addison','Workman'),(9,'Garrison','Blevins'),(10,'Evelyn','Newton'),(11,'Rana','Mullins'),(12,'Shelley','Lamb'),(13,'Lev','Barlow'),(14,'Garrison','Delacruz'),(15,'Liberty','Atkinson'),(16,'Imelda','Ashley'),(17,'Dennis','Cross'),(18,'Briar','Salazar'),(19,'Valentine','Rice'),(20,'Karly','Lawrence'),(21,'Judah','Callahan'),(22,'Gail','Pena'),(23,'Lewis','Bell'),(24,'Nolan','Decker'),(25,'Clark','Richard'),(26,'Nell','Navarro'),(27,'Charity','Snyder'),(28,'Gage','Murray'),(29,'Thor','Flynn'),(30,'Felix','Dawson'),(31,'Astra','Stevenson'),(32,'Sandra','Glenn'),(33,'Unity','Rollins'),(34,'Allen','Lopez'),(35,'Amal','Osborne'),(36,'Melvin','Rojas'),(37,'Caldwell','Gates'),(38,'Yvonne','Tran'),(39,'Iona','Rodriquez'),(40,'Bradley','Warren'),(41,'Russell','Pope'),(42,'Howard','Webster'),(43,'Priscilla','Lester'),(44,'Xanthus','Horton'),(45,'Bevis','Glass'),(46,'Akeem','Anderson'),(47,'Abdul','Cole'),(48,'Ray','Valenzuela'),(49,'Bertha','Neal'),(50,'Aladdin','Campbell'),(51,'Thane','Raymond'),(52,'Paula','Newman'),(53,'Leandra','Scott'),(54,'Dana','Dean'),(55,'Aidan','Keller'),(56,'Kim','Brooks'),(57,'Hop','Wooten'),(58,'Madeson','Chambers'),(59,'Jackson','Barron'),(60,'Lucy','Faulkner'),(61,'Allen','Mcmillan'),(62,'Michael','Guerra'),(63,'Cyrus','Shepherd'),(64,'Darryl','Riggs'),(65,'Kennan','Huffman'),(66,'Fleur','Trujillo'),(67,'Yvonne','Johnson'),(68,'Lance','Witt'),(69,'Vivien','Ruiz'),(70,'Charlotte','Griffith'),(71,'Quinlan','Cook'),(72,'Penelope','Cantrell'),(73,'Ciaran','Stewart'),(74,'Calvin','Mcmahon'),(75,'Neve','Hansen'),(76,'Astra','Levy'),(77,'Samantha','Tate'),(78,'Lacy','Maynard'),(79,'Kathleen','Emerson'),(80,'Taylor','Chase'),(81,'Xenos','Osborne'),(82,'Ethan','Lewis'),(83,'Adam','Mejia'),(84,'Kai','Mcknight'),(85,'Scott','Shelton'),(86,'Lamar','Farley'),(87,'Tamekah','Albert'),(88,'Jennifer','Brooks'),(89,'Daphne','Baxter'),(90,'Christopher','Powers'),(91,'Kirby','Peters'),(92,'Caleb','Dalton'),(93,'Keely','Vega'),(94,'Tatiana','Scott'),(95,'Zenaida','Saunders'),(96,'Mason','Whitney'),(97,'Briar','Calderon'),(98,'Francis','Taylor'),(99,'Anthony','Owens'),(100,'Velma','Santana');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-05-30  0:30:54
