-- MySQL dump 10.13  Distrib 5.7.13, for osx10.11 (x86_64)
--
-- Host: localhost    Database: ADMISSION
-- ------------------------------------------------------
-- Server version	5.7.13

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `COURSE`
--

DROP TABLE IF EXISTS `COURSE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `COURSE` (
  `courseid` int(4) NOT NULL AUTO_INCREMENT,
  `coursename` varchar(20) COLLATE latin1_bin NOT NULL,
  PRIMARY KEY (`courseid`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1 COLLATE=latin1_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `COURSE`
--

LOCK TABLES `COURSE` WRITE;
/*!40000 ALTER TABLE `COURSE` DISABLE KEYS */;
INSERT INTO `COURSE` VALUES (1,'SQL and DBMS'),(2,'QA and Tests'),(3,'JAVA+'),(4,'JDBC-Hibernet'),(5,'Spring MVC'),(6,'C++ and Pointers'),(7,'NodeJS'),(8,'CordovaIonic'),(9,'Big Data');
/*!40000 ALTER TABLE `COURSE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `RESULT`
--

DROP TABLE IF EXISTS `RESULT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `RESULT` (
  `rid` int(4) unsigned NOT NULL AUTO_INCREMENT,
  `studentid` int(4) NOT NULL,
  `courseid` int(4) NOT NULL,
  `marks1` double DEFAULT NULL,
  `marks2` double DEFAULT NULL,
  PRIMARY KEY (`rid`),
  KEY `courseid` (`courseid`),
  KEY `studentid` (`studentid`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=latin1 COLLATE=latin1_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `RESULT`
--

LOCK TABLES `RESULT` WRITE;
/*!40000 ALTER TABLE `RESULT` DISABLE KEYS */;
INSERT INTO `RESULT` VALUES (1,12,1,98,54),(2,13,1,36,39),(3,14,1,89,83),(5,11,2,59,78),(6,12,2,71,76),(7,13,2,44,87),(8,14,2,67,77),(10,11,3,48,57),(11,12,3,69,69),(12,13,3,36,39),(13,14,3,89,83),(14,11,4,36,26),(15,12,4,77,66),(16,13,4,44,87),(25,12,4,11,12),(28,11,1,88,99),(32,14,4,88,99),(35,15,2,88,99),(36,16,2,88,77),(37,15,4,88,99),(38,17,2,76,59),(39,18,2,87,69);
/*!40000 ALTER TABLE `RESULT` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `STUDENT`
--

DROP TABLE IF EXISTS `STUDENT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `STUDENT` (
  `studentid` int(4) NOT NULL AUTO_INCREMENT,
  `firstname` varchar(20) COLLATE latin1_bin DEFAULT NULL,
  `lastname` varchar(20) COLLATE latin1_bin DEFAULT NULL,
  `gender` varchar(1) COLLATE latin1_bin DEFAULT NULL,
  `startdate` date DEFAULT NULL,
  PRIMARY KEY (`studentid`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=latin1 COLLATE=latin1_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `STUDENT`
--

LOCK TABLES `STUDENT` WRITE;
/*!40000 ALTER TABLE `STUDENT` DISABLE KEYS */;
INSERT INTO `STUDENT` VALUES (11,'John','Connor','M','2029-06-01'),(12,'Dale','Cooper','M','2018-04-16'),(13,'Helen','Ripley','F','2005-08-10'),(14,'Conan','Destroyer','M','1230-02-22'),(15,'Carter','Murke','M','2016-03-02'),(16,'James','Bond','M','2002-03-04'),(17,'Lara','Croft','F','2001-05-23'),(18,'John','Rambo','M','1998-10-22'),(19,'Jenifer','Lopez','F','2007-11-08'),(20,'Leonardo','DaVinci','M','2015-10-22'),(21,'Rene','Decart','M','2016-01-01'),(22,'Henry','Ford','M','2002-02-22'),(23,'Stephan','Bolzman','M','2015-02-22'),(24,'Jason','Burne','M','2010-02-26'),(25,'Hercule','Poirot','M','1998-05-23');
/*!40000 ALTER TABLE `STUDENT` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-09-27 12:24:55
