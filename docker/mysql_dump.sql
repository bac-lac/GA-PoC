-- MySQL dump 10.13  Distrib 8.0.41, for Linux (x86_64)
--
-- Host:     Database: GADATA
-- ------------------------------------------------------
-- Server version	8.0.41

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


USE GADATA;
--
-- Table structure for table `dpa_active_job`
--

DROP TABLE IF EXISTS `dpa_active_job`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_active_job` (
  `job_id` bigint NOT NULL,
  `proj_id` int NOT NULL,
  `proj_name` varchar(200) NOT NULL,
  `proj_folder` varchar(512) NOT NULL,
  `run_user` varchar(64) NOT NULL,
  `queue_priority` int NOT NULL,
  `run_priority` int NOT NULL,
  `run_mode` char(1) NOT NULL,
  `submit_time` datetime NOT NULL,
  `start_time` datetime NOT NULL,
  `job_log` varchar(256) NOT NULL,
  `system_name` varchar(20) DEFAULT NULL,
  `held` char(1) NOT NULL,
  `job_queue_id` int DEFAULT NULL,
  `job_queue_name` varchar(20) DEFAULT NULL,
  `job_name` varchar(200) DEFAULT NULL,
  `submit_src` char(1) NOT NULL DEFAULT '0',
  `submit_src_id` int NOT NULL DEFAULT '-1',
  `submit_src_name` varchar(64) DEFAULT NULL,
  `exception_count` int NOT NULL DEFAULT '0',
  `domain_id` int NOT NULL DEFAULT '1',
  `agent_id` int NOT NULL DEFAULT '0',
  `agent_group_id` int NOT NULL DEFAULT '0',
  `submit_src_alt_id` int NOT NULL DEFAULT '-1',
  `execution_id` bigint DEFAULT '0',
  PRIMARY KEY (`job_id`),
  KEY `idx_dpa_active_job` (`proj_id`),
  KEY `idx_dpa_active_job_queue` (`run_mode`,`job_queue_id`,`agent_id`,`agent_group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_active_job`
--

LOCK TABLES `dpa_active_job` WRITE;
/*!40000 ALTER TABLE `dpa_active_job` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_active_job` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_active_system`
--

DROP TABLE IF EXISTS `dpa_active_system`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_active_system` (
  `system_name` varchar(20) NOT NULL,
  `system_name_lc` varchar(20) NOT NULL,
  `system_address` varchar(45) DEFAULT NULL,
  `system_port` int DEFAULT NULL,
  `system_updated_on` datetime NOT NULL,
  `system_role` char(1) NOT NULL DEFAULT 'X',
  `job_ready_status` char(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`system_name_lc`),
  CONSTRAINT `dpa_active_system_chk_1` CHECK ((`system_name_lc` = lower(`system_name`)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_active_system`
--

LOCK TABLES `dpa_active_system` WRITE;
/*!40000 ALTER TABLE `dpa_active_system` DISABLE KEYS */;
INSERT INTO `dpa_active_system` VALUES ('Default','default',' ',0,'2025-03-27 18:18:02','X','1');
/*!40000 ALTER TABLE `dpa_active_system` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_addon`
--

DROP TABLE IF EXISTS `dpa_addon`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_addon` (
  `addon_id` int NOT NULL,
  `addon_name` varchar(128) NOT NULL,
  `addon_desc` varchar(512) DEFAULT NULL,
  `marketplace_addon` char(1) NOT NULL,
  `addon_data` mediumblob,
  `addon_version` varchar(11) NOT NULL,
  `enabled` char(1) NOT NULL,
  `created_by` varchar(64) NOT NULL,
  `created_on` datetime NOT NULL,
  `modified_by` varchar(64) NOT NULL,
  `modified_on` datetime NOT NULL,
  `addon_uuid` varchar(38) DEFAULT NULL,
  `addon_author_acct_id` varchar(36) DEFAULT NULL,
  `addon_type` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`addon_id`),
  UNIQUE KEY `addon_uuid` (`addon_uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_addon`
--

LOCK TABLES `dpa_addon` WRITE;
/*!40000 ALTER TABLE `dpa_addon` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_addon` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_addr_book`
--

DROP TABLE IF EXISTS `dpa_addr_book`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_addr_book` (
  `book_id` int NOT NULL,
  `book_name` varchar(64) NOT NULL,
  `book_name_lc` varchar(64) NOT NULL,
  `book_desc` varchar(512) DEFAULT NULL,
  `book_type` char(1) NOT NULL,
  `domain_id` int NOT NULL DEFAULT '1',
  `created_by` varchar(64) NOT NULL,
  `created_on` datetime NOT NULL,
  `modified_by` varchar(64) NOT NULL,
  `modified_on` datetime NOT NULL,
  PRIMARY KEY (`book_id`),
  UNIQUE KEY `book_name_lc` (`book_name_lc`,`book_type`),
  CONSTRAINT `dpa_addr_book_chk_1` CHECK ((`book_name_lc` = lower(`book_name`)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_addr_book`
--

LOCK TABLES `dpa_addr_book` WRITE;
/*!40000 ALTER TABLE `dpa_addr_book` DISABLE KEYS */;
INSERT INTO `dpa_addr_book` VALUES (101,'101','101','Personal Address Book','P',1,'system','2024-04-22 14:01:11','system','2024-04-22 14:01:11'),(102,'Default','default','This is the default shared address book shipped with GoAnywhere','S',1,'system','2024-04-22 14:01:11','system','2024-04-22 14:01:11');
/*!40000 ALTER TABLE `dpa_addr_book` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_addr_book_con_group`
--

DROP TABLE IF EXISTS `dpa_addr_book_con_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_addr_book_con_group` (
  `group_id` int NOT NULL,
  `book_id` int NOT NULL,
  `group_name` varchar(64) NOT NULL,
  `group_name_lc` varchar(64) NOT NULL,
  `group_desc` varchar(512) DEFAULT NULL,
  `created_by` varchar(64) NOT NULL,
  `created_by_type` char(1) NOT NULL,
  `created_on` datetime NOT NULL,
  `modified_by` varchar(64) NOT NULL,
  `modified_by_type` char(1) NOT NULL,
  `modified_on` datetime NOT NULL,
  PRIMARY KEY (`group_id`),
  UNIQUE KEY `book_id` (`book_id`,`group_name_lc`),
  KEY `idx_dpa_addr_book_con_group` (`book_id`),
  CONSTRAINT `dpa_addr_book_con_group_ibfk_1` FOREIGN KEY (`book_id`) REFERENCES `dpa_addr_book` (`book_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_addr_book_con_group`
--

LOCK TABLES `dpa_addr_book_con_group` WRITE;
/*!40000 ALTER TABLE `dpa_addr_book_con_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_addr_book_con_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_addr_book_con_group_map`
--

DROP TABLE IF EXISTS `dpa_addr_book_con_group_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_addr_book_con_group_map` (
  `contact_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`contact_id`,`group_id`),
  KEY `group_id` (`group_id`),
  CONSTRAINT `dpa_addr_book_con_group_map_ibfk_1` FOREIGN KEY (`contact_id`) REFERENCES `dpa_addr_book_contact` (`contact_id`),
  CONSTRAINT `dpa_addr_book_con_group_map_ibfk_2` FOREIGN KEY (`group_id`) REFERENCES `dpa_addr_book_con_group` (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_addr_book_con_group_map`
--

LOCK TABLES `dpa_addr_book_con_group_map` WRITE;
/*!40000 ALTER TABLE `dpa_addr_book_con_group_map` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_addr_book_con_group_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_addr_book_contact`
--

DROP TABLE IF EXISTS `dpa_addr_book_contact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_addr_book_contact` (
  `contact_id` int NOT NULL,
  `book_id` int NOT NULL,
  `contact_name` varchar(64) DEFAULT NULL,
  `contact_email` varchar(128) NOT NULL,
  `contact_email_lc` varchar(128) NOT NULL,
  `contact_sms_country_name` varchar(60) DEFAULT NULL,
  `contact_sms_phone` varchar(40) DEFAULT NULL,
  `contact_phone` varchar(40) DEFAULT NULL,
  `contact_desc` varchar(512) DEFAULT NULL,
  `contact_org` varchar(60) DEFAULT NULL,
  `created_by` varchar(64) NOT NULL,
  `created_by_type` char(1) NOT NULL,
  `created_on` datetime NOT NULL,
  `modified_by` varchar(64) NOT NULL,
  `modified_by_type` char(1) NOT NULL,
  `modified_on` datetime NOT NULL,
  PRIMARY KEY (`contact_id`),
  UNIQUE KEY `book_id` (`book_id`,`contact_email_lc`),
  KEY `idx_dpa_addr_book_con_email` (`contact_email_lc`),
  KEY `idx_dpa_contact_book` (`book_id`),
  CONSTRAINT `dpa_addr_book_contact_ibfk_1` FOREIGN KEY (`book_id`) REFERENCES `dpa_addr_book` (`book_id`) ON DELETE CASCADE,
  CONSTRAINT `dpa_addr_book_contact_chk_1` CHECK ((`contact_email_lc` = lower(`contact_email`)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_addr_book_contact`
--

LOCK TABLES `dpa_addr_book_contact` WRITE;
/*!40000 ALTER TABLE `dpa_addr_book_contact` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_addr_book_contact` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_addr_book_wu_map`
--

DROP TABLE IF EXISTS `dpa_addr_book_wu_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_addr_book_wu_map` (
  `book_id` int NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`book_id`,`user_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `dpa_addr_book_wu_map_ibfk_1` FOREIGN KEY (`book_id`) REFERENCES `dpa_addr_book` (`book_id`) ON DELETE CASCADE,
  CONSTRAINT `dpa_addr_book_wu_map_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `dpa_web_user` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_addr_book_wu_map`
--

LOCK TABLES `dpa_addr_book_wu_map` WRITE;
/*!40000 ALTER TABLE `dpa_addr_book_wu_map` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_addr_book_wu_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_addr_book_wugroup_map`
--

DROP TABLE IF EXISTS `dpa_addr_book_wugroup_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_addr_book_wugroup_map` (
  `book_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`book_id`,`group_id`),
  KEY `group_id` (`group_id`),
  CONSTRAINT `dpa_addr_book_wugroup_map_ibfk_1` FOREIGN KEY (`book_id`) REFERENCES `dpa_addr_book` (`book_id`) ON DELETE CASCADE,
  CONSTRAINT `dpa_addr_book_wugroup_map_ibfk_2` FOREIGN KEY (`group_id`) REFERENCES `dpa_web_group` (`group_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_addr_book_wugroup_map`
--

LOCK TABLES `dpa_addr_book_wugroup_map` WRITE;
/*!40000 ALTER TABLE `dpa_addr_book_wugroup_map` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_addr_book_wugroup_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_admin_api_key`
--

DROP TABLE IF EXISTS `dpa_admin_api_key`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_admin_api_key` (
  `api_key_id` int NOT NULL,
  `user_id` int NOT NULL,
  `api_key_name` varchar(64) NOT NULL,
  `api_key_name_lc` varchar(64) NOT NULL,
  `description` varchar(512) DEFAULT NULL,
  `api_key` varchar(128) NOT NULL,
  `api_key_created_on` datetime DEFAULT NULL,
  `expires_on` datetime DEFAULT NULL,
  `api_key_created_by` varchar(64) NOT NULL,
  PRIMARY KEY (`api_key_id`),
  UNIQUE KEY `api_key` (`api_key`),
  UNIQUE KEY `api_key_name_lc` (`api_key_name_lc`,`user_id`),
  KEY `idx_dpa_admin_api_key_usr` (`user_id`),
  CONSTRAINT `dpa_admin_api_key_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `dpa_user` (`user_id`) ON DELETE CASCADE,
  CONSTRAINT `dpa_admin_api_key_chk_1` CHECK ((`api_key_name_lc` = lower(`api_key_name`)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_admin_api_key`
--

LOCK TABLES `dpa_admin_api_key` WRITE;
/*!40000 ALTER TABLE `dpa_admin_api_key` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_admin_api_key` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_admin_log`
--

DROP TABLE IF EXISTS `dpa_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_admin_log` (
  `entry_id` int NOT NULL,
  `entry_type` int NOT NULL,
  `comp_type` int NOT NULL,
  `comp_id` int NOT NULL,
  `comp_name` varchar(200) NOT NULL,
  `admin_user_id` int NOT NULL,
  `admin_user_name` varchar(64) NOT NULL,
  `created_on` datetime NOT NULL,
  `comp_def` mediumblob,
  `domain_id` int NOT NULL DEFAULT '1',
  `override_message` varchar(512) DEFAULT NULL,
  `comp_uuid` varchar(36) DEFAULT NULL,
  `checksum` varchar(91) DEFAULT NULL,
  `tracking_id` varchar(36) DEFAULT NULL,
  `submitted_type` char(1) DEFAULT NULL,
  `local_ip` varchar(40) DEFAULT NULL,
  `local_port` int DEFAULT NULL,
  `remote_ip` varchar(40) DEFAULT NULL,
  `remote_port` int DEFAULT NULL,
  PRIMARY KEY (`entry_id`),
  KEY `idx_dpa_admin_log_cid` (`comp_id`),
  KEY `idx_dpa_admin_log_aid` (`admin_user_id`),
  KEY `idx_dpa_admin_log_cuuid` (`comp_uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_admin_log`
--

LOCK TABLES `dpa_admin_log` WRITE;
/*!40000 ALTER TABLE `dpa_admin_log` DISABLE KEYS */;
INSERT INTO `dpa_admin_log` VALUES (1009,4,56,0,' ',1001,'gaaabaclac','2025-03-21 16:57:00',NULL,-1,'User \'gaaabaclac\' logged in',NULL,'2:bFD8dIK6okh39rPTY4CAPaARMPCp0zXESfdrQENb6DcJThdJoKg8X985BZFt3a63hJ/oPGsZ3B/9fWuRedCr2g==','995fe351-1d08-4cbb-a214-b8a2e3052513','A','172.18.0.3',8000,'172.18.0.1',53670),(1010,5,56,0,' ',1001,'gaaabaclac','2025-03-21 17:12:17',NULL,-1,'User \'gaaabaclac\' logged out',NULL,'2:s7EK4fMraVZxrmcn+QRsR7Vm0jtt/BuYUb4Nv7O/9m9Xgmdl77n958FCUzqEl7JM1CMvqVgjIS+28PtEWaHqig==','995fe351-1d08-4cbb-a214-b8a2e3052513','A','172.18.0.3',8000,'172.18.0.1',53670),(1011,4,56,0,' ',1001,'gaaabaclac','2025-03-21 17:55:39',NULL,-1,'User \'gaaabaclac\' logged in',NULL,'2:Wy919ceQ6MtLEliVubZTpSbM5QE/svvINOiPxkLmHHxpCxDZFlK68+LuzWGUAVZg85++krAvP2uAlAYaq4fdsA==','aa989d61-7e7a-4521-8e78-25ff4ca114fa','A','172.18.0.3',8000,'172.18.0.1',32988);
/*!40000 ALTER TABLE `dpa_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_admin_log_detail`
--

DROP TABLE IF EXISTS `dpa_admin_log_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_admin_log_detail` (
  `entry_id` int NOT NULL,
  `detail_def` mediumblob,
  `checksum` varchar(91) DEFAULT NULL,
  KEY `idx_dpa_admin_log_detail_eid` (`entry_id`),
  CONSTRAINT `dpa_admin_log_detail_ibfk_1` FOREIGN KEY (`entry_id`) REFERENCES `dpa_admin_log` (`entry_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_admin_log_detail`
--

LOCK TABLES `dpa_admin_log_detail` WRITE;
/*!40000 ALTER TABLE `dpa_admin_log_detail` DISABLE KEYS */;
INSERT INTO `dpa_admin_log_detail` VALUES (1006,_binary '<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?><e><l>JDBC Driver</l><o>org.apache.derby.iapi.jdbc.AutoloadedDriver</o><t>change</t><n>org.mariadb.jdbc.Driver</n></e>','1:ltiLUqZClYQNGma3YCDG8wDcX/WKrKMbvdKbJKXk5t/e/lUKgK87tWuBF/9UBrM4tQqD4gSHYypOUiqDkeL65w=='),(1006,_binary '<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?><e><l>JDBC URL</l><o>jdbc:derby:/opt/Fortra/GoAnywhere/userdata/database/goanywhere</o><t>change</t><n>jdbc:mariadb://database-1.cxmsdcmrjeui.ca-central-1.rds.amazonaws.com:3306/GADATA?useCursorFetch=true&amp;defaultFetchSize=20&amp;characterEncoding=utf8</n></e>','1:BHxNcH459HPjwjtbwnykZmLGn7+LFVv4/UBJ7RH7glJ3VWfdnqZQ4oTilLLWh+SQHRBL0rj+Xxv+sNPCANmhPg=='),(1006,_binary '<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?><e><l>Password</l><r>Password Changed</r><t>change</t></e>','1:bx/YiF/2tEwFmrLMb8azF5/VuENzcRw43B3uRbevspd7+5BdifNlenEckBcPWwBdYTfgKJ7yK8d2nBdp+3G7Qg=='),(1006,_binary '<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?><e><l>User</l><o></o><t>change</t><n>GADATA</n></e>','1:K7tGtQxI0lUYF3XV1dHSjn52TJKLvpg29RKjnt4my9N5KO175xeeLAokZq1+USTl4duWWeS0duFseIZLy21W7Q=='),(1007,_binary '<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?><e><l>JDBC Driver</l><o>org.apache.derby.iapi.jdbc.AutoloadedDriver</o><t>change</t><n>org.mariadb.jdbc.Driver</n></e>','1:iKKCG/YYsSHG400g6zRSLqLuMhgwJYtUAPWtXP74MMNxgTgRn+h/szpOqAKfRL3IrdGZm1PeO2FHCyEXu8AYIw=='),(1007,_binary '<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?><e><l>JDBC URL</l><o>jdbc:derby:/opt/Fortra/GoAnywhere/userdata/database/goanywhere</o><t>change</t><n>jdbc:mariadb://database-1.cxmsdcmrjeui.ca-central-1.rds.amazonaws.com:3306/GADATA?useCursorFetch=true&amp;defaultFetchSize=20&amp;characterEncoding=utf8</n></e>','1:7/ZeppWmRXhxyFopUdB6eVqt9ohnASuUcxO/blhTInFQBX5qVOLxBsRls4nr7PrL50F+aDej37lPDIq2/dY5wQ=='),(1007,_binary '<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?><e><l>Password</l><r>Password Changed</r><t>change</t></e>','1:nwXsxHOwm8jguSg5jwXwQahq+vRDV5T74qPoLtG+1cl5wtVZjs69BSOMvA82HGqzEUDZNODbp1b1bT+ZGiJnWw=='),(1007,_binary '<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?><e><l>User</l><o></o><t>change</t><n>GADATA</n></e>','1:e4RsJVZIEId8VWy0xtflgx04dqscKzoIo1LBMY9ski5gBThBYyIMckEPaR7DhwukXo8PHDGyojjrKDKzEqkyZQ==');
/*!40000 ALTER TABLE `dpa_admin_log_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_agent`
--

DROP TABLE IF EXISTS `dpa_agent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_agent` (
  `agent_id` int NOT NULL,
  `agent_name` varchar(64) NOT NULL,
  `agent_name_lc` varchar(64) NOT NULL,
  `description` varchar(512) DEFAULT NULL,
  `enabled` char(1) NOT NULL,
  `registered` char(1) NOT NULL,
  `domain_id` int NOT NULL DEFAULT '1',
  `reg_code` varchar(128) DEFAULT NULL,
  `upgrade_code` char(1) NOT NULL DEFAULT 'N',
  `major_version` int NOT NULL DEFAULT '0',
  `minor_version` int NOT NULL DEFAULT '0',
  `patch_version` int NOT NULL DEFAULT '0',
  `created_by` varchar(64) NOT NULL,
  `created_on` datetime NOT NULL,
  `modified_by` varchar(64) NOT NULL,
  `modified_on` datetime NOT NULL,
  `approved_by` varchar(64) DEFAULT NULL,
  `approved_on` datetime DEFAULT NULL,
  `feature_set` char(1) NOT NULL DEFAULT 'S',
  `alert_offline_threshold` int NOT NULL DEFAULT '60',
  `auto_resume_transfers` char(1) NOT NULL DEFAULT '2',
  `auto_resume_retries` int NOT NULL DEFAULT '3',
  `auto_resume_interval` int NOT NULL DEFAULT '30',
  PRIMARY KEY (`agent_id`),
  UNIQUE KEY `agent_name_lc` (`agent_name_lc`,`domain_id`),
  CONSTRAINT `dpa_agent_chk_1` CHECK ((`agent_name_lc` = lower(`agent_name`)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_agent`
--

LOCK TABLES `dpa_agent` WRITE;
/*!40000 ALTER TABLE `dpa_agent` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_agent` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_agent_alert`
--

DROP TABLE IF EXISTS `dpa_agent_alert`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_agent_alert` (
  `event_id` bigint NOT NULL,
  `offline_threshold` int DEFAULT NULL,
  `alert_sent` char(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_agent_alert`
--

LOCK TABLES `dpa_agent_alert` WRITE;
/*!40000 ALTER TABLE `dpa_agent_alert` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_agent_alert` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_agent_auth`
--

DROP TABLE IF EXISTS `dpa_agent_auth`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_agent_auth` (
  `agent_id` int NOT NULL,
  `auth_fingerprint` char(191) DEFAULT NULL,
  PRIMARY KEY (`agent_id`),
  UNIQUE KEY `auth_fingerprint` (`auth_fingerprint`),
  CONSTRAINT `dpa_agent_auth_ibfk_1` FOREIGN KEY (`agent_id`) REFERENCES `dpa_agent` (`agent_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_agent_auth`
--

LOCK TABLES `dpa_agent_auth` WRITE;
/*!40000 ALTER TABLE `dpa_agent_auth` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_agent_auth` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_agent_group`
--

DROP TABLE IF EXISTS `dpa_agent_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_agent_group` (
  `group_id` int NOT NULL,
  `group_name` varchar(64) NOT NULL,
  `description` varchar(512) DEFAULT NULL,
  `enabled` char(1) NOT NULL DEFAULT '1',
  `domain_id` int NOT NULL DEFAULT '1',
  `created_by` varchar(64) NOT NULL,
  `created_on` datetime NOT NULL,
  `modified_by` varchar(64) NOT NULL,
  `modified_on` datetime NOT NULL,
  `group_name_lc` varchar(64) DEFAULT NULL,
  `alert_offline_threshold` int NOT NULL DEFAULT '60',
  PRIMARY KEY (`group_id`),
  UNIQUE KEY `group_name_lc` (`group_name_lc`,`domain_id`),
  CONSTRAINT `dpa_agent_group_chk_1` CHECK ((`group_name_lc` = lower(`group_name`)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_agent_group`
--

LOCK TABLES `dpa_agent_group` WRITE;
/*!40000 ALTER TABLE `dpa_agent_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_agent_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_agent_group_job`
--

DROP TABLE IF EXISTS `dpa_agent_group_job`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_agent_group_job` (
  `execution_id` bigint NOT NULL,
  `agent_group_id` int NOT NULL,
  `proj_name` varchar(200) NOT NULL,
  `proj_folder` varchar(512) NOT NULL,
  `run_user` varchar(64) NOT NULL,
  `queue_priority` int NOT NULL,
  `run_priority` int NOT NULL,
  `submit_time` datetime NOT NULL,
  `run_mode` char(1) NOT NULL DEFAULT 'U',
  `job_name` varchar(200) DEFAULT NULL,
  `submit_src` char(1) NOT NULL DEFAULT '0',
  `submit_src_id` int NOT NULL DEFAULT '-1',
  `submit_src_alt_id` int NOT NULL DEFAULT '-1',
  `submit_src_name` varchar(64) DEFAULT NULL,
  `domain_id` int NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_agent_group_job`
--

LOCK TABLES `dpa_agent_group_job` WRITE;
/*!40000 ALTER TABLE `dpa_agent_group_job` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_agent_group_job` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_agent_group_perm`
--

DROP TABLE IF EXISTS `dpa_agent_group_perm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_agent_group_perm` (
  `agent_id` int NOT NULL,
  `agent_type` char(1) NOT NULL,
  `group_id` int NOT NULL,
  `permissions` int NOT NULL,
  PRIMARY KEY (`agent_id`,`agent_type`,`group_id`),
  KEY `group_id` (`group_id`),
  CONSTRAINT `dpa_agent_group_perm_ibfk_1` FOREIGN KEY (`group_id`) REFERENCES `dpa_group` (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_agent_group_perm`
--

LOCK TABLES `dpa_agent_group_perm` WRITE;
/*!40000 ALTER TABLE `dpa_agent_group_perm` DISABLE KEYS */;
INSERT INTO `dpa_agent_group_perm` VALUES (101,'T',101,15);
/*!40000 ALTER TABLE `dpa_agent_group_perm` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_agent_log`
--

DROP TABLE IF EXISTS `dpa_agent_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_agent_log` (
  `event_id` bigint NOT NULL,
  `event_time` datetime NOT NULL,
  `event_type` int NOT NULL,
  `agent_id` int NOT NULL,
  `agent_name` varchar(64) NOT NULL,
  `domain_id` int NOT NULL,
  `system_name` varchar(20) DEFAULT NULL,
  `alert_sent` char(1) NOT NULL,
  PRIMARY KEY (`event_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_agent_log`
--

LOCK TABLES `dpa_agent_log` WRITE;
/*!40000 ALTER TABLE `dpa_agent_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_agent_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_agent_name_sequence`
--

DROP TABLE IF EXISTS `dpa_agent_name_sequence`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_agent_name_sequence` (
  `domain_id` int NOT NULL DEFAULT '1',
  `name_pattern` varchar(50) NOT NULL,
  `next_value` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`domain_id`,`name_pattern`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_agent_name_sequence`
--

LOCK TABLES `dpa_agent_name_sequence` WRITE;
/*!40000 ALTER TABLE `dpa_agent_name_sequence` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_agent_name_sequence` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_agent_notification`
--

DROP TABLE IF EXISTS `dpa_agent_notification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_agent_notification` (
  `notif_id` bigint NOT NULL,
  `agent_id` int NOT NULL,
  `created_on` datetime NOT NULL,
  `priority` int NOT NULL DEFAULT '5',
  `message` mediumblob,
  `send_when_disabled` char(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`notif_id`),
  KEY `agent_id` (`agent_id`),
  CONSTRAINT `dpa_agent_notification_ibfk_1` FOREIGN KEY (`agent_id`) REFERENCES `dpa_agent` (`agent_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_agent_notification`
--

LOCK TABLES `dpa_agent_notification` WRITE;
/*!40000 ALTER TABLE `dpa_agent_notification` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_agent_notification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_agent_reg_rule`
--

DROP TABLE IF EXISTS `dpa_agent_reg_rule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_agent_reg_rule` (
  `rule_id` int NOT NULL,
  `reg_code` varchar(128) NOT NULL,
  `template_id` int NOT NULL,
  `require_approval` char(1) NOT NULL DEFAULT '1',
  `name_pattern` varchar(50) DEFAULT NULL,
  `notify_managers` char(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`rule_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_agent_reg_rule`
--

LOCK TABLES `dpa_agent_reg_rule` WRITE;
/*!40000 ALTER TABLE `dpa_agent_reg_rule` DISABLE KEYS */;
INSERT INTO `dpa_agent_reg_rule` VALUES (1,' ',101,'1','agent_','1');
/*!40000 ALTER TABLE `dpa_agent_reg_rule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_agent_template`
--

DROP TABLE IF EXISTS `dpa_agent_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_agent_template` (
  `template_id` int NOT NULL,
  `template_name` varchar(64) NOT NULL,
  `description` varchar(512) NOT NULL,
  `domain_id` int NOT NULL DEFAULT '1',
  `created_by` varchar(64) NOT NULL,
  `created_on` datetime NOT NULL,
  `modified_by` varchar(64) NOT NULL,
  `modified_on` datetime NOT NULL,
  `feature_set` char(1) NOT NULL DEFAULT 'S',
  `alert_offline_threshold` int NOT NULL DEFAULT '60',
  `auto_resume_transfers` char(1) NOT NULL DEFAULT '2',
  `auto_resume_retries` int NOT NULL DEFAULT '3',
  `auto_resume_interval` int NOT NULL DEFAULT '30',
  PRIMARY KEY (`template_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_agent_template`
--

LOCK TABLES `dpa_agent_template` WRITE;
/*!40000 ALTER TABLE `dpa_agent_template` DISABLE KEYS */;
INSERT INTO `dpa_agent_template` VALUES (101,'Agent Template','This is the default template shipped with GoAnywhere',1,'system','2024-04-22 14:01:14','system','2024-04-22 14:01:14','S',60,'2',3,30);
/*!40000 ALTER TABLE `dpa_agent_template` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_agent_template_group`
--

DROP TABLE IF EXISTS `dpa_agent_template_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_agent_template_group` (
  `template_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`template_id`,`group_id`),
  KEY `group_id` (`group_id`),
  CONSTRAINT `dpa_agent_template_group_ibfk_1` FOREIGN KEY (`template_id`) REFERENCES `dpa_agent_template` (`template_id`),
  CONSTRAINT `dpa_agent_template_group_ibfk_2` FOREIGN KEY (`group_id`) REFERENCES `dpa_agent_group` (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_agent_template_group`
--

LOCK TABLES `dpa_agent_template_group` WRITE;
/*!40000 ALTER TABLE `dpa_agent_template_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_agent_template_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_agent_user_perm`
--

DROP TABLE IF EXISTS `dpa_agent_user_perm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_agent_user_perm` (
  `agent_id` int NOT NULL,
  `agent_type` char(1) NOT NULL,
  `user_id` int NOT NULL,
  `permissions` int NOT NULL,
  PRIMARY KEY (`agent_id`,`agent_type`,`user_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `dpa_agent_user_perm_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `dpa_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_agent_user_perm`
--

LOCK TABLES `dpa_agent_user_perm` WRITE;
/*!40000 ALTER TABLE `dpa_agent_user_perm` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_agent_user_perm` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_alert_notification`
--

DROP TABLE IF EXISTS `dpa_alert_notification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_alert_notification` (
  `comp_id` int NOT NULL,
  `comp_type` int NOT NULL,
  `alert_type` int NOT NULL,
  `notify_managers` char(1) NOT NULL DEFAULT '0',
  `notify_add_email` char(1) NOT NULL DEFAULT '0',
  `add_email` varchar(512) DEFAULT NULL,
  UNIQUE KEY `comp_id` (`comp_id`,`comp_type`,`alert_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_alert_notification`
--

LOCK TABLES `dpa_alert_notification` WRITE;
/*!40000 ALTER TABLE `dpa_alert_notification` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_alert_notification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_as2_audit_log`
--

DROP TABLE IF EXISTS `dpa_as2_audit_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_as2_audit_log` (
  `event_id` bigint NOT NULL,
  `start_time` datetime NOT NULL,
  `end_time` datetime DEFAULT NULL,
  `severity` char(1) NOT NULL,
  `local_ip` varchar(40) DEFAULT NULL,
  `local_port` int DEFAULT NULL,
  `remote_ip` varchar(40) DEFAULT NULL,
  `remote_port` int DEFAULT NULL,
  `session_id` varchar(40) DEFAULT NULL,
  `user_name` varchar(64) DEFAULT NULL,
  `command` int DEFAULT NULL,
  `event_type` int DEFAULT NULL,
  `time_taken` bigint DEFAULT NULL,
  `remarks` varchar(256) DEFAULT NULL,
  `message_id` varchar(255) DEFAULT NULL,
  `mic` varchar(88) DEFAULT NULL,
  `mic_algorithm` varchar(8) DEFAULT NULL,
  `signature_algorithm` varchar(7) DEFAULT NULL,
  `encryption_algorithm` varchar(10) DEFAULT NULL,
  `compressed` char(1) DEFAULT NULL,
  `mdn_type` char(1) DEFAULT NULL,
  `mdn_signed` char(1) DEFAULT NULL,
  `mdn_sent` char(1) DEFAULT NULL,
  `subject` varchar(256) DEFAULT NULL,
  `from_id` varchar(128) DEFAULT NULL,
  `to_id` varchar(128) DEFAULT NULL,
  `system_name` varchar(20) DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `indexed` char(1) NOT NULL DEFAULT '0',
  `domain_id` int NOT NULL DEFAULT '1',
  `checksum` varchar(91) DEFAULT NULL,
  PRIMARY KEY (`event_id`),
  KEY `idx_dpa_as2_audit_log` (`start_time` DESC),
  KEY `idx_dpa_as2_audit_log_usr` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_as2_audit_log`
--

LOCK TABLES `dpa_as2_audit_log` WRITE;
/*!40000 ALTER TABLE `dpa_as2_audit_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_as2_audit_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_as2_audit_log_file`
--

DROP TABLE IF EXISTS `dpa_as2_audit_log_file`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_as2_audit_log_file` (
  `event_id` bigint NOT NULL,
  `file_path` varchar(256) NOT NULL,
  `file_size` bigint NOT NULL,
  `virtual_path` varchar(256) DEFAULT NULL,
  `checksum` varchar(91) DEFAULT NULL,
  KEY `idx_dpa_as2_audit_log_file_event_id` (`event_id`),
  CONSTRAINT `dpa_as2_audit_log_file_ibfk_1` FOREIGN KEY (`event_id`) REFERENCES `dpa_as2_audit_log` (`event_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_as2_audit_log_file`
--

LOCK TABLES `dpa_as2_audit_log_file` WRITE;
/*!40000 ALTER TABLE `dpa_as2_audit_log_file` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_as2_audit_log_file` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_as2_audit_log_header`
--

DROP TABLE IF EXISTS `dpa_as2_audit_log_header`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_as2_audit_log_header` (
  `event_id` bigint NOT NULL,
  `header_name` varchar(128) NOT NULL,
  `header_value` varchar(256) DEFAULT NULL,
  `checksum` varchar(91) DEFAULT NULL,
  KEY `idx_dpa_as2_audit_log_header_event_id` (`event_id`),
  CONSTRAINT `dpa_as2_audit_log_header_ibfk_1` FOREIGN KEY (`event_id`) REFERENCES `dpa_as2_audit_log` (`event_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_as2_audit_log_header`
--

LOCK TABLES `dpa_as2_audit_log_header` WRITE;
/*!40000 ALTER TABLE `dpa_as2_audit_log_header` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_as2_audit_log_header` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_as2_audit_log_mdn`
--

DROP TABLE IF EXISTS `dpa_as2_audit_log_mdn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_as2_audit_log_mdn` (
  `event_id` bigint NOT NULL,
  `mdn_data` mediumblob,
  `checksum` varchar(91) DEFAULT NULL,
  KEY `idx_dpa_as2_audit_log_mdn_event_id` (`event_id`),
  CONSTRAINT `dpa_as2_audit_log_mdn_ibfk_1` FOREIGN KEY (`event_id`) REFERENCES `dpa_as2_audit_log` (`event_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_as2_audit_log_mdn`
--

LOCK TABLES `dpa_as2_audit_log_mdn` WRITE;
/*!40000 ALTER TABLE `dpa_as2_audit_log_mdn` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_as2_audit_log_mdn` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_as2_recipient`
--

DROP TABLE IF EXISTS `dpa_as2_recipient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_as2_recipient` (
  `as2_recipient_id` int NOT NULL,
  `as2_to_id` varchar(128) NOT NULL,
  `as2_to_id_lc` varchar(128) NOT NULL,
  `decryption_key_location` char(1) NOT NULL DEFAULT '0',
  `decryption_key_name` varchar(128) DEFAULT NULL,
  `decryption_key_password` varchar(152) DEFAULT NULL,
  `decryption_alias` varchar(128) DEFAULT NULL,
  `default_upload_dir` varchar(256) DEFAULT NULL,
  `when_file_exists` int NOT NULL DEFAULT '0',
  `keep_receipts` char(1) NOT NULL DEFAULT '1',
  `signature_key_location` char(1) NOT NULL DEFAULT '0',
  `signature_key_name` varchar(128) DEFAULT NULL,
  `signature_key_password` varchar(152) DEFAULT NULL,
  `signature_alias` varchar(128) DEFAULT NULL,
  `signature_alg_format` char(1) NOT NULL DEFAULT '0',
  `auto_async_mdn_approval` char(1) NOT NULL DEFAULT '0',
  `mdn_proxy_enabled` char(1) NOT NULL DEFAULT '0',
  `require_encryption` char(1) NOT NULL DEFAULT '0',
  `require_signature` char(1) NOT NULL DEFAULT '0',
  `require_authentication` char(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`as2_recipient_id`),
  UNIQUE KEY `as2_to_id_lc` (`as2_to_id_lc`),
  CONSTRAINT `dpa_as2_recipient_chk_1` CHECK ((`as2_to_id_lc` = lower(`as2_to_id`)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_as2_recipient`
--

LOCK TABLES `dpa_as2_recipient` WRITE;
/*!40000 ALTER TABLE `dpa_as2_recipient` DISABLE KEYS */;
INSERT INTO `dpa_as2_recipient` VALUES (100,' ',' ','1',NULL,' ',' ',' ',0,'1','1',NULL,' ',' ','0','0','0','0','0','1');
/*!40000 ALTER TABLE `dpa_as2_recipient` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_as4_audit_log`
--

DROP TABLE IF EXISTS `dpa_as4_audit_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_as4_audit_log` (
  `event_id` bigint NOT NULL,
  `start_time` datetime NOT NULL,
  `end_time` datetime DEFAULT NULL,
  `severity` char(1) NOT NULL,
  `local_ip` varchar(40) DEFAULT NULL,
  `local_port` int DEFAULT NULL,
  `remote_ip` varchar(40) DEFAULT NULL,
  `remote_port` int DEFAULT NULL,
  `session_id` varchar(40) DEFAULT NULL,
  `user_name` varchar(64) DEFAULT NULL,
  `command` int DEFAULT NULL,
  `event_type` int DEFAULT NULL,
  `time_taken` bigint DEFAULT NULL,
  `remarks` varchar(256) DEFAULT NULL,
  `message_id` varchar(255) DEFAULT NULL,
  `compressed` char(1) DEFAULT NULL,
  `signature_algorithm` varchar(32) DEFAULT NULL,
  `encryption_algorithm` varchar(32) DEFAULT NULL,
  `receipt_type` char(1) DEFAULT NULL,
  `receipt_signed` char(1) DEFAULT NULL,
  `receipt_sent` char(1) DEFAULT NULL,
  `from_id` varchar(128) DEFAULT NULL,
  `from_party_type` varchar(128) DEFAULT NULL,
  `from_role` varchar(128) DEFAULT NULL,
  `to_id` varchar(128) DEFAULT NULL,
  `to_party_type` varchar(128) DEFAULT NULL,
  `to_role` varchar(128) DEFAULT NULL,
  `system_name` varchar(20) DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `mpc` varchar(128) DEFAULT NULL,
  `indexed` char(1) NOT NULL DEFAULT '0',
  `domain_id` int NOT NULL DEFAULT '1',
  `checksum` varchar(91) DEFAULT NULL,
  `file_path` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`event_id`),
  KEY `idx_dpa_as4_audit_log` (`start_time` DESC),
  KEY `idx_dpa_as4_audit_log_usr` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_as4_audit_log`
--

LOCK TABLES `dpa_as4_audit_log` WRITE;
/*!40000 ALTER TABLE `dpa_as4_audit_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_as4_audit_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_as4_audit_log_file`
--

DROP TABLE IF EXISTS `dpa_as4_audit_log_file`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_as4_audit_log_file` (
  `event_id` bigint NOT NULL,
  `file_path` varchar(256) NOT NULL,
  `file_size` bigint NOT NULL,
  `virtual_path` varchar(256) DEFAULT NULL,
  `checksum` varchar(91) DEFAULT NULL,
  KEY `idx_dpa_as4_audit_log_file_evt` (`event_id`),
  CONSTRAINT `dpa_as4_audit_log_file_ibfk_1` FOREIGN KEY (`event_id`) REFERENCES `dpa_as4_audit_log` (`event_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_as4_audit_log_file`
--

LOCK TABLES `dpa_as4_audit_log_file` WRITE;
/*!40000 ALTER TABLE `dpa_as4_audit_log_file` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_as4_audit_log_file` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_as4_audit_log_message`
--

DROP TABLE IF EXISTS `dpa_as4_audit_log_message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_as4_audit_log_message` (
  `event_id` bigint NOT NULL,
  `message_data` mediumblob,
  `checksum` varchar(91) DEFAULT NULL,
  KEY `idx_dpa_as4_audit_log_msg_evt` (`event_id`),
  CONSTRAINT `dpa_as4_audit_log_message_ibfk_1` FOREIGN KEY (`event_id`) REFERENCES `dpa_as4_audit_log` (`event_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_as4_audit_log_message`
--

LOCK TABLES `dpa_as4_audit_log_message` WRITE;
/*!40000 ALTER TABLE `dpa_as4_audit_log_message` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_as4_audit_log_message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_as4_fingerprint`
--

DROP TABLE IF EXISTS `dpa_as4_fingerprint`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_as4_fingerprint` (
  `user_id` int NOT NULL,
  `as4_fingerprint` varchar(59) NOT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `as4_fingerprint` (`as4_fingerprint`),
  CONSTRAINT `dpa_as4_fingerprint_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `dpa_web_user` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_as4_fingerprint`
--

LOCK TABLES `dpa_as4_fingerprint` WRITE;
/*!40000 ALTER TABLE `dpa_as4_fingerprint` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_as4_fingerprint` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_as4_message_properties`
--

DROP TABLE IF EXISTS `dpa_as4_message_properties`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_as4_message_properties` (
  `entry_id` bigint NOT NULL,
  `property_name` varchar(128) NOT NULL,
  `property_value` varchar(128) NOT NULL,
  `property_type` varchar(128) DEFAULT NULL,
  KEY `entry_id` (`entry_id`),
  CONSTRAINT `dpa_as4_message_properties_ibfk_1` FOREIGN KEY (`entry_id`) REFERENCES `dpa_as4_mpc_entries` (`entry_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_as4_message_properties`
--

LOCK TABLES `dpa_as4_message_properties` WRITE;
/*!40000 ALTER TABLE `dpa_as4_message_properties` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_as4_message_properties` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_as4_mpc`
--

DROP TABLE IF EXISTS `dpa_as4_mpc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_as4_mpc` (
  `mpc_id` int NOT NULL,
  `mpc_name` varchar(128) NOT NULL,
  `mpc_name_lc` varchar(128) NOT NULL,
  `domain_id` int NOT NULL,
  `mpc_description` varchar(512) DEFAULT NULL,
  `mpc_type` char(1) NOT NULL,
  `subchannels` char(1) NOT NULL,
  `created_on` datetime NOT NULL,
  `created_by` varchar(64) NOT NULL,
  `modified_on` datetime NOT NULL,
  `modified_by` varchar(64) NOT NULL,
  PRIMARY KEY (`mpc_id`),
  UNIQUE KEY `mpc_name_lc` (`mpc_name_lc`,`domain_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_as4_mpc`
--

LOCK TABLES `dpa_as4_mpc` WRITE;
/*!40000 ALTER TABLE `dpa_as4_mpc` DISABLE KEYS */;
INSERT INTO `dpa_as4_mpc` VALUES (1,'Default','default',1,'The default MPC for the domain.','D','0','2024-04-22 14:01:15','system','2024-04-22 14:01:15','system');
/*!40000 ALTER TABLE `dpa_as4_mpc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_as4_mpc_attachments`
--

DROP TABLE IF EXISTS `dpa_as4_mpc_attachments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_as4_mpc_attachments` (
  `entry_id` bigint NOT NULL,
  `file_path` varchar(256) NOT NULL,
  KEY `entry_id` (`entry_id`),
  CONSTRAINT `dpa_as4_mpc_attachments_ibfk_1` FOREIGN KEY (`entry_id`) REFERENCES `dpa_as4_mpc_entries` (`entry_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_as4_mpc_attachments`
--

LOCK TABLES `dpa_as4_mpc_attachments` WRITE;
/*!40000 ALTER TABLE `dpa_as4_mpc_attachments` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_as4_mpc_attachments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_as4_mpc_entries`
--

DROP TABLE IF EXISTS `dpa_as4_mpc_entries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_as4_mpc_entries` (
  `entry_id` bigint NOT NULL,
  `mpc_id` int NOT NULL,
  `body_xml_file_path` varchar(256) DEFAULT NULL,
  `conversation_id` varchar(128) NOT NULL,
  `attachment_count` int NOT NULL,
  `entry_status` char(1) NOT NULL,
  `created_on` datetime NOT NULL,
  `consumed_on` datetime DEFAULT NULL,
  PRIMARY KEY (`entry_id`),
  KEY `idx_dpa_as4_mpc_entries` (`created_on`),
  KEY `idx_dpa_as4_mpc_entries_mpc` (`mpc_id`),
  CONSTRAINT `dpa_as4_mpc_entries_ibfk_1` FOREIGN KEY (`mpc_id`) REFERENCES `dpa_as4_mpc` (`mpc_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_as4_mpc_entries`
--

LOCK TABLES `dpa_as4_mpc_entries` WRITE;
/*!40000 ALTER TABLE `dpa_as4_mpc_entries` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_as4_mpc_entries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_as4_mpc_names`
--

DROP TABLE IF EXISTS `dpa_as4_mpc_names`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_as4_mpc_names` (
  `channel_id` int NOT NULL,
  `channel_name_lc` varchar(188) NOT NULL,
  `domain_id` int NOT NULL,
  `channel_type` char(1) NOT NULL,
  PRIMARY KEY (`channel_id`,`channel_type`),
  UNIQUE KEY `channel_name_lc` (`channel_name_lc`,`domain_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_as4_mpc_names`
--

LOCK TABLES `dpa_as4_mpc_names` WRITE;
/*!40000 ALTER TABLE `dpa_as4_mpc_names` DISABLE KEYS */;
INSERT INTO `dpa_as4_mpc_names` VALUES (1,'default',1,'M');
/*!40000 ALTER TABLE `dpa_as4_mpc_names` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_as4_partner_id`
--

DROP TABLE IF EXISTS `dpa_as4_partner_id`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_as4_partner_id` (
  `user_id` int NOT NULL,
  `partner_id` varchar(128) NOT NULL,
  `partner_id_lc` varchar(128) NOT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `partner_id_lc` (`partner_id_lc`),
  CONSTRAINT `dpa_as4_partner_id_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `dpa_web_user` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_as4_partner_id`
--

LOCK TABLES `dpa_as4_partner_id` WRITE;
/*!40000 ALTER TABLE `dpa_as4_partner_id` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_as4_partner_id` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_as4_subc`
--

DROP TABLE IF EXISTS `dpa_as4_subc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_as4_subc` (
  `subc_id` int NOT NULL,
  `subc_name` varchar(60) NOT NULL,
  `subc_name_lc` varchar(60) NOT NULL,
  `mpc_id` int NOT NULL,
  `user_id` int NOT NULL,
  `user_name` varchar(64) NOT NULL,
  PRIMARY KEY (`subc_id`),
  UNIQUE KEY `subc_name_lc` (`subc_name_lc`,`mpc_id`),
  KEY `user_id` (`user_id`),
  KEY `mpc_id` (`mpc_id`),
  CONSTRAINT `dpa_as4_subc_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `dpa_web_user` (`user_id`) ON DELETE CASCADE,
  CONSTRAINT `dpa_as4_subc_ibfk_2` FOREIGN KEY (`mpc_id`) REFERENCES `dpa_as4_mpc` (`mpc_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_as4_subc`
--

LOCK TABLES `dpa_as4_subc` WRITE;
/*!40000 ALTER TABLE `dpa_as4_subc` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_as4_subc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_as4_subc_entries`
--

DROP TABLE IF EXISTS `dpa_as4_subc_entries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_as4_subc_entries` (
  `entry_id` bigint NOT NULL,
  `subc_id` int NOT NULL,
  `entry_status` char(1) NOT NULL,
  `consumed_on` datetime DEFAULT NULL,
  KEY `entry_id` (`entry_id`),
  KEY `subc_id` (`subc_id`),
  CONSTRAINT `dpa_as4_subc_entries_ibfk_1` FOREIGN KEY (`entry_id`) REFERENCES `dpa_as4_mpc_entries` (`entry_id`),
  CONSTRAINT `dpa_as4_subc_entries_ibfk_2` FOREIGN KEY (`subc_id`) REFERENCES `dpa_as4_subc` (`subc_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_as4_subc_entries`
--

LOCK TABLES `dpa_as4_subc_entries` WRITE;
/*!40000 ALTER TABLE `dpa_as4_subc_entries` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_as4_subc_entries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_as4_usermsg`
--

DROP TABLE IF EXISTS `dpa_as4_usermsg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_as4_usermsg` (
  `message_id` varchar(255) NOT NULL,
  `domain_id` int DEFAULT NULL,
  `key_vault_name` varchar(50) DEFAULT NULL,
  `rec_key_name` varchar(128) DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `signature_fingerprint` varchar(59) DEFAULT NULL,
  `msg_type` char(1) NOT NULL,
  `entry_id` int DEFAULT NULL,
  `channel_type` char(1) DEFAULT NULL,
  `channel_id` int DEFAULT NULL,
  `user_msg` mediumblob NOT NULL,
  `time_sent` datetime NOT NULL,
  `finished_transmission` char(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`message_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_as4_usermsg`
--

LOCK TABLES `dpa_as4_usermsg` WRITE;
/*!40000 ALTER TABLE `dpa_as4_usermsg` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_as4_usermsg` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_as4_web_user_pull`
--

DROP TABLE IF EXISTS `dpa_as4_web_user_pull`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_as4_web_user_pull` (
  `pull_id` int NOT NULL,
  `user_id` int NOT NULL,
  `mpc_id` int NOT NULL,
  `subc_id` int DEFAULT NULL,
  `key_vault_name` varchar(50) DEFAULT NULL,
  `sign_message` char(1) DEFAULT NULL,
  `signature_algorithm` varchar(7) DEFAULT NULL,
  `signature_key_name` varchar(128) DEFAULT NULL,
  `signature_key_password` varchar(152) DEFAULT NULL,
  `encrypt_message` char(1) DEFAULT NULL,
  `encryption_algorithm` varchar(10) DEFAULT NULL,
  `encryption_key_name` varchar(128) DEFAULT NULL,
  `decryption_key_name` varchar(128) DEFAULT NULL,
  `decryption_key_password` varchar(152) DEFAULT NULL,
  `from_id` varchar(128) DEFAULT NULL,
  `from_party` varchar(128) DEFAULT NULL,
  `from_role` varchar(128) DEFAULT NULL,
  `to_party` varchar(128) DEFAULT NULL,
  `to_role` varchar(128) DEFAULT NULL,
  `agreement_ref` varchar(128) DEFAULT NULL,
  `agreement_type` varchar(128) DEFAULT NULL,
  `pmode` varchar(128) DEFAULT NULL,
  `message_service` varchar(128) DEFAULT NULL,
  `service_type` varchar(128) DEFAULT NULL,
  `message_action` varchar(128) DEFAULT NULL,
  `compress_message` char(1) DEFAULT NULL,
  `reception_awareness` char(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`pull_id`),
  UNIQUE KEY `user_id` (`user_id`,`mpc_id`),
  KEY `mpc_id` (`mpc_id`),
  KEY `subc_id` (`subc_id`),
  CONSTRAINT `dpa_as4_web_user_pull_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `dpa_web_user` (`user_id`),
  CONSTRAINT `dpa_as4_web_user_pull_ibfk_2` FOREIGN KEY (`mpc_id`) REFERENCES `dpa_as4_mpc` (`mpc_id`),
  CONSTRAINT `dpa_as4_web_user_pull_ibfk_3` FOREIGN KEY (`subc_id`) REFERENCES `dpa_as4_subc` (`subc_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_as4_web_user_pull`
--

LOCK TABLES `dpa_as4_web_user_pull` WRITE;
/*!40000 ALTER TABLE `dpa_as4_web_user_pull` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_as4_web_user_pull` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_as4_web_user_push`
--

DROP TABLE IF EXISTS `dpa_as4_web_user_push`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_as4_web_user_push` (
  `push_id` int NOT NULL,
  `user_id` int NOT NULL,
  `pmode_name` varchar(128) DEFAULT NULL,
  `pmode_name_lc` varchar(128) DEFAULT NULL,
  `pmode_order` int DEFAULT NULL,
  `key_vault_name` varchar(50) DEFAULT NULL,
  `decryption_key_name` varchar(128) DEFAULT NULL,
  `decryption_key_password` varchar(152) DEFAULT NULL,
  `sign_message` char(1) DEFAULT NULL,
  `signature_algorithm` varchar(7) DEFAULT NULL,
  `signature_key_name` varchar(128) DEFAULT NULL,
  `signature_key_password` varchar(152) DEFAULT NULL,
  `reply_mode` char(1) DEFAULT NULL,
  `receipt_url` varchar(256) DEFAULT NULL,
  `require_encryption` char(1) DEFAULT NULL,
  `require_signature` char(1) DEFAULT NULL,
  `from_party` varchar(128) DEFAULT NULL,
  `from_role` varchar(128) DEFAULT NULL,
  `to_id` varchar(128) DEFAULT NULL,
  `to_party` varchar(128) DEFAULT NULL,
  `to_role` varchar(128) DEFAULT NULL,
  `agreement_ref` varchar(128) DEFAULT NULL,
  `agreement_type` varchar(128) DEFAULT NULL,
  `conversation_id` varchar(128) DEFAULT NULL,
  `message_service` varchar(128) DEFAULT NULL,
  `service_type` varchar(128) DEFAULT NULL,
  `message_action` varchar(128) DEFAULT NULL,
  `upload_dir` varchar(256) DEFAULT NULL,
  `when_file_exists` char(1) DEFAULT NULL,
  `require_auth` char(1) DEFAULT NULL,
  PRIMARY KEY (`push_id`),
  UNIQUE KEY `pmode_name_lc` (`pmode_name_lc`,`user_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `dpa_as4_web_user_push_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `dpa_web_user` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_as4_web_user_push`
--

LOCK TABLES `dpa_as4_web_user_push` WRITE;
/*!40000 ALTER TABLE `dpa_as4_web_user_push` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_as4_web_user_push` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_audit_log_exemption`
--

DROP TABLE IF EXISTS `dpa_audit_log_exemption`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_audit_log_exemption` (
  `exempt_id` int NOT NULL,
  `exempt_name` varchar(128) NOT NULL,
  `exempt_name_lc` varchar(128) NOT NULL,
  `service_code` int NOT NULL,
  `event_type_id` int NOT NULL,
  `exempt_type` char(1) NOT NULL,
  `ip_addr` varchar(2000) DEFAULT NULL,
  `created_by` varchar(64) NOT NULL,
  `created_on` datetime NOT NULL,
  `modified_by` varchar(64) NOT NULL,
  `modified_on` datetime NOT NULL,
  PRIMARY KEY (`exempt_id`),
  UNIQUE KEY `exempt_name_lc` (`exempt_name_lc`),
  KEY `idx_dpa_audit_log_exemption_event_type` (`event_type_id`),
  CONSTRAINT `dpa_audit_log_exemption_chk_1` CHECK ((`exempt_name_lc` = lower(`exempt_name`)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_audit_log_exemption`
--

LOCK TABLES `dpa_audit_log_exemption` WRITE;
/*!40000 ALTER TABLE `dpa_audit_log_exemption` DISABLE KEYS */;
INSERT INTO `dpa_audit_log_exemption` VALUES (101,'Checksum Successful','checksum successful',0,172,'A','','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13');
/*!40000 ALTER TABLE `dpa_audit_log_exemption` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_big_sequence`
--

DROP TABLE IF EXISTS `dpa_big_sequence`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_big_sequence` (
  `sequence_name` varchar(50) NOT NULL,
  `next_value` bigint NOT NULL DEFAULT '1001',
  PRIMARY KEY (`sequence_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_big_sequence`
--

LOCK TABLES `dpa_big_sequence` WRITE;
/*!40000 ALTER TABLE `dpa_big_sequence` DISABLE KEYS */;
INSERT INTO `dpa_big_sequence` VALUES ('dpa_agent_log',1000),('dpa_agent_notification',1000),('dpa_job',1000000000000),('dpa_job_file_log',10000),('dpa_processed_edi_data',1000),('dpa_sla_event_log',1000),('execution_id',10000),('gofast_fileid',10000);
/*!40000 ALTER TABLE `dpa_big_sequence` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_category`
--

DROP TABLE IF EXISTS `dpa_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_category` (
  `cat_id` int NOT NULL,
  `cat_name` varchar(50) NOT NULL,
  `cat_name_lc` varchar(50) NOT NULL,
  `cat_desc` varchar(512) DEFAULT NULL,
  `parent_cat` int NOT NULL,
  `created_by` varchar(64) NOT NULL,
  `created_on` datetime NOT NULL,
  `modified_by` varchar(64) NOT NULL,
  `modified_on` datetime NOT NULL,
  `domain_id` int NOT NULL DEFAULT '1',
  `agent_id` int NOT NULL DEFAULT '0',
  `agent_group_id` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`cat_id`),
  UNIQUE KEY `cat_name_lc` (`cat_name_lc`,`parent_cat`),
  CONSTRAINT `dpa_category_chk_1` CHECK ((`cat_name_lc` = lower(`cat_name`)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_category`
--

LOCK TABLES `dpa_category` WRITE;
/*!40000 ALTER TABLE `dpa_category` DISABLE KEYS */;
INSERT INTO `dpa_category` VALUES (101,'/','/','Root folder for all projects',101,'system','2024-04-22 14:01:13','system','2024-04-22 14:01:13',1,0,0);
/*!40000 ALTER TABLE `dpa_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_category_var`
--

DROP TABLE IF EXISTS `dpa_category_var`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_category_var` (
  `cat_id` int NOT NULL,
  `var_name` varchar(50) NOT NULL,
  `var_desc` varchar(256) DEFAULT NULL,
  `var_value` varchar(2000) NOT NULL,
  UNIQUE KEY `cat_id` (`cat_id`,`var_name`),
  CONSTRAINT `dpa_category_var_ibfk_1` FOREIGN KEY (`cat_id`) REFERENCES `dpa_category` (`cat_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_category_var`
--

LOCK TABLES `dpa_category_var` WRITE;
/*!40000 ALTER TABLE `dpa_category_var` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_category_var` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_comp_contact`
--

DROP TABLE IF EXISTS `dpa_comp_contact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_comp_contact` (
  `contact_id` int NOT NULL,
  `comp_id` int NOT NULL,
  `comp_type` char(2) NOT NULL,
  `contact_name` varchar(128) DEFAULT NULL,
  `contact_phone` varchar(40) DEFAULT NULL,
  `contact_email` varchar(128) DEFAULT NULL,
  `primary_contact` char(1) DEFAULT NULL,
  `contact_type` char(1) NOT NULL,
  PRIMARY KEY (`contact_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_comp_contact`
--

LOCK TABLES `dpa_comp_contact` WRITE;
/*!40000 ALTER TABLE `dpa_comp_contact` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_comp_contact` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_comp_location`
--

DROP TABLE IF EXISTS `dpa_comp_location`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_comp_location` (
  `comp_id` int NOT NULL,
  `comp_type` char(2) NOT NULL,
  `address` varchar(256) DEFAULT NULL,
  `city` varchar(60) DEFAULT NULL,
  `state_code` varchar(60) DEFAULT NULL,
  `postal_code` varchar(20) DEFAULT NULL,
  `country` varchar(60) DEFAULT NULL,
  `location_type` char(1) NOT NULL,
  `latitude` varchar(20) DEFAULT NULL,
  `longitude` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`comp_id`,`comp_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_comp_location`
--

LOCK TABLES `dpa_comp_location` WRITE;
/*!40000 ALTER TABLE `dpa_comp_location` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_comp_location` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_content_scan_log`
--

DROP TABLE IF EXISTS `dpa_content_scan_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_content_scan_log` (
  `event_id` bigint NOT NULL,
  `file_id` smallint NOT NULL,
  `domain_id` int DEFAULT NULL,
  `start_time` datetime NOT NULL,
  `end_time` datetime DEFAULT NULL,
  `time_taken` bigint DEFAULT NULL,
  `status` char(1) NOT NULL,
  `command` int NOT NULL,
  `event_type` int NOT NULL,
  `service` smallint NOT NULL,
  `file_name` varchar(256) DEFAULT NULL,
  `file_path` varchar(256) DEFAULT NULL,
  `file_size` bigint DEFAULT NULL,
  `unreachable` char(1) DEFAULT NULL,
  `scanner_status_code` int DEFAULT NULL,
  `http_status_code` int DEFAULT NULL,
  `remarks` varchar(256) DEFAULT NULL,
  `scan_info` mediumblob,
  `indexed` char(1) NOT NULL DEFAULT '0',
  `checksum` varchar(91) DEFAULT NULL,
  PRIMARY KEY (`event_id`,`file_id`),
  KEY `idx_dpa_content_scan_log` (`start_time` DESC)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_content_scan_log`
--

LOCK TABLES `dpa_content_scan_log` WRITE;
/*!40000 ALTER TABLE `dpa_content_scan_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_content_scan_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_country`
--

DROP TABLE IF EXISTS `dpa_country`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_country` (
  `country_code` int NOT NULL,
  `country_name` varchar(60) NOT NULL,
  PRIMARY KEY (`country_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_country`
--

LOCK TABLES `dpa_country` WRITE;
/*!40000 ALTER TABLE `dpa_country` DISABLE KEYS */;
INSERT INTO `dpa_country` VALUES (1000,'United States'),(1001,'United Kingdom'),(1002,'Afghanistan'),(1003,'Akrotiri'),(1004,'Albania'),(1005,'Algeria'),(1006,'American Samoa'),(1007,'Andorra'),(1008,'Angola'),(1009,'Anguilla'),(1010,'Antigua and Barbuda'),(1011,'Argentina'),(1012,'Armenia'),(1013,'Aruba'),(1014,'Australia'),(1015,'Austria'),(1016,'Azerbaijan'),(1017,'Bahamas'),(1018,'Bahrain'),(1019,'Bangladesh'),(1020,'Barbados'),(1021,'Belarus'),(1022,'Belgium'),(1023,'Belize'),(1024,'Benin'),(1025,'Bermuda'),(1026,'Bhutan'),(1027,'Bolivia'),(1028,'Bosnia and Herzegovina'),(1029,'Botswana'),(1030,'Bouvet Island'),(1031,'Brazil'),(1032,'British Indian Ocean Territory'),(1033,'Brunei Darussalam'),(1034,'Bulgaria'),(1035,'Burkina Faso'),(1036,'Burundi'),(1037,'Cambodia'),(1038,'Cameroon'),(1039,'Canada'),(1040,'Cape Verde'),(1041,'Cayman Islands'),(1042,'Central African Republic'),(1043,'Chad'),(1044,'Chile'),(1045,'China'),(1046,'Christmas Island'),(1047,'Cocos (Keeling) Islands'),(1048,'Colombia'),(1049,'Comoros'),(1050,'Congo'),(1051,'Congo, Democratic Republic'),(1052,'Cook Islands'),(1053,'Costa Rica'),(1054,'Cote d\'Ivoire'),(1055,'Croatia'),(1056,'Cuba'),(1057,'Curacao'),(1058,'Cyprus'),(1059,'Czech Republic'),(1060,'Dehkelia'),(1061,'Denmark'),(1062,'Djibouti'),(1063,'Dominica'),(1064,'Dominican Republic'),(1065,'Ecuador'),(1066,'Egypt'),(1067,'El Salvador'),(1068,'Equatorial Guinea'),(1069,'Eritrea'),(1070,'Estonia'),(1071,'Ethiopia'),(1072,'Falkland Islands'),(1073,'Faroe Islands'),(1074,'Fiji Islands'),(1075,'Finland'),(1076,'France'),(1077,'French Polynesia'),(1078,'Gabon'),(1079,'Gambia'),(1080,'Georgia'),(1081,'Germany'),(1082,'Ghana'),(1083,'Gibraltar'),(1084,'Greece'),(1085,'Greenland'),(1086,'Grenada'),(1087,'Guadeloupe'),(1088,'Guam'),(1089,'Guatemala'),(1090,'Guernsey'),(1091,'Guinea'),(1092,'Guinea-Bissau'),(1093,'Guyana'),(1094,'Haiti'),(1095,'Honduras'),(1096,'Hong Kong'),(1097,'Hungary'),(1098,'Iceland'),(1099,'India'),(1100,'Indonesia'),(1101,'Iran'),(1102,'Iraq'),(1103,'Ireland'),(1104,'Israel'),(1105,'Italy'),(1106,'Jamaica'),(1107,'Japan'),(1108,'Jersey'),(1109,'Jordan'),(1110,'Kazakhstan'),(1111,'Kenya'),(1112,'Kiribati'),(1113,'Kosovo'),(1114,'Kuwait'),(1115,'Kyrgyzstan'),(1116,'Laos'),(1117,'Latvia'),(1118,'Lebanon'),(1119,'Lesotho'),(1120,'Liberia'),(1121,'Libya'),(1122,'Liechtenstein'),(1123,'Lithuania'),(1124,'Luxembourg'),(1125,'Macau'),(1126,'Macedonia'),(1127,'Madagascar'),(1128,'Malawi'),(1129,'Malaysia'),(1130,'Maldives'),(1131,'Mali'),(1132,'Malta'),(1133,'Marshall Islands'),(1134,'Martinique'),(1135,'Mauritania'),(1136,'Mauritius'),(1137,'Mayotte'),(1138,'Mexico'),(1139,'Micronesia'),(1140,'Moldova'),(1141,'Monaco'),(1142,'Mongolia'),(1143,'Montenegro'),(1144,'Montserrat'),(1145,'Morocco'),(1146,'Mozambique'),(1147,'Myanmar'),(1148,'Namibia'),(1149,'Nauru'),(1150,'Nepal'),(1151,'Netherlands'),(1152,'New Caledonia'),(1153,'New Zealand'),(1154,'Nicaragua'),(1155,'Niger'),(1156,'Nigeria'),(1157,'Norfolk Island'),(1158,'North Korea'),(1159,'Northern Mariana Island'),(1160,'Norway'),(1161,'Oman'),(1162,'Pakistan'),(1163,'Palau'),(1164,'Palestine'),(1165,'Panama'),(1166,'Papua New Guinea'),(1167,'Paraguay'),(1168,'Peru'),(1169,'Philippines'),(1170,'Poland'),(1171,'Portugal'),(1172,'Puerto Rico'),(1173,'Qatar'),(1174,'Reunion'),(1175,'Romania'),(1176,'Russian Federation'),(1177,'Rwanda'),(1178,'Saint Helena'),(1179,'Saint Kitts and Nevis'),(1180,'Saint Lucia'),(1181,'Saint Martin'),(1182,'Saint Pierre and Miquelon'),(1183,'Saint Vincent and the Grenadines'),(1184,'Samoa'),(1185,'San Marino'),(1186,'Sao Tome and Principe'),(1187,'Saudi Arabia'),(1188,'Senegal'),(1189,'Serbia'),(1190,'Seychelles'),(1191,'Sierra Leone'),(1192,'Singapore'),(1193,'Sint Maarten'),(1194,'Slovakia'),(1195,'Slovenia'),(1196,'Solomon Islands'),(1197,'Somalia'),(1198,'South Africa'),(1199,'South Korea'),(1200,'South Sudan'),(1201,'Spain'),(1202,'Sri Lanka'),(1203,'Sudan'),(1204,'Suriname'),(1205,'Svalbard'),(1206,'Swaziland'),(1207,'Sweden'),(1208,'Switzerland'),(1209,'Syria'),(1210,'Taiwan'),(1211,'Tajikistan'),(1212,'Tanzania'),(1213,'Thailand'),(1214,'Timor-Leste'),(1215,'Togo'),(1216,'Tokelau'),(1217,'Tonga'),(1218,'Trinidad and Tobago'),(1219,'Tunisia'),(1220,'Turkey'),(1221,'Turkmenistan'),(1222,'Turks and Caicos Islands'),(1223,'Tuvalu'),(1224,'Uganda'),(1225,'Ukraine'),(1226,'United Arab Emirates'),(1227,'Uruguay'),(1228,'Uzbekistan'),(1229,'Vanuatu'),(1230,'Vatican'),(1231,'Venezuela'),(1232,'Vietnam'),(1233,'Virgin Islands, British'),(1234,'Virgin Islands, U.S.'),(1235,'Wallis & Futuna Islands'),(1236,'Western Sahara'),(1237,'Yemen'),(1238,'Zambia'),(1239,'Zimbabwe'),(1240,'Other'),(1241,'East Timor'),(1242,'Pacific Islands Trust Tr');
/*!40000 ALTER TABLE `dpa_country` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_dashboard`
--

DROP TABLE IF EXISTS `dpa_dashboard`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_dashboard` (
  `dashboard_id` int NOT NULL,
  `dashboard_name` varchar(100) NOT NULL,
  `personal` char(1) NOT NULL,
  `shared` char(1) NOT NULL,
  `layout` int NOT NULL,
  `created_by` varchar(64) NOT NULL,
  `created_on` datetime NOT NULL,
  `modified_by` varchar(64) NOT NULL,
  `modified_on` datetime NOT NULL,
  PRIMARY KEY (`dashboard_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_dashboard`
--

LOCK TABLES `dpa_dashboard` WRITE;
/*!40000 ALTER TABLE `dpa_dashboard` DISABLE KEYS */;
INSERT INTO `dpa_dashboard` VALUES (1001,'My Dashboard','1','0',3,'gaaabaclac','2024-06-10 19:49:13','gaaabaclac','2024-06-10 19:49:13');
/*!40000 ALTER TABLE `dpa_dashboard` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_dashboard_column`
--

DROP TABLE IF EXISTS `dpa_dashboard_column`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_dashboard_column` (
  `dashboard_id` int NOT NULL,
  `column_num` int NOT NULL,
  `gadget_id` int NOT NULL,
  `gadget_index` int NOT NULL,
  KEY `idx_dpa_dashboard_column_did` (`dashboard_id`),
  KEY `idx_dpa_dashboard_column_gid` (`gadget_id`),
  CONSTRAINT `dpa_dashboard_column_ibfk_1` FOREIGN KEY (`gadget_id`) REFERENCES `dpa_gadget` (`gadget_id`) ON DELETE CASCADE,
  CONSTRAINT `dpa_dashboard_column_ibfk_2` FOREIGN KEY (`dashboard_id`) REFERENCES `dpa_dashboard` (`dashboard_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_dashboard_column`
--

LOCK TABLES `dpa_dashboard_column` WRITE;
/*!40000 ALTER TABLE `dpa_dashboard_column` DISABLE KEYS */;
INSERT INTO `dpa_dashboard_column` VALUES (1001,0,1001,0),(1001,0,1003,1),(1001,1,1002,0),(1001,1,1004,1),(1001,1,1005,2),(1001,1,1006,3);
/*!40000 ALTER TABLE `dpa_dashboard_column` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_dashboard_user`
--

DROP TABLE IF EXISTS `dpa_dashboard_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_dashboard_user` (
  `dashboard_id` int NOT NULL,
  `user_id` int NOT NULL,
  KEY `idx_dpa_dashboard_user_did` (`dashboard_id`),
  CONSTRAINT `dpa_dashboard_user_ibfk_1` FOREIGN KEY (`dashboard_id`) REFERENCES `dpa_dashboard` (`dashboard_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_dashboard_user`
--

LOCK TABLES `dpa_dashboard_user` WRITE;
/*!40000 ALTER TABLE `dpa_dashboard_user` DISABLE KEYS */;
INSERT INTO `dpa_dashboard_user` VALUES (1001,1001);
/*!40000 ALTER TABLE `dpa_dashboard_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_device_auth`
--

DROP TABLE IF EXISTS `dpa_device_auth`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_device_auth` (
  `device_id` varchar(36) NOT NULL,
  `redirect_uri` varchar(256) DEFAULT NULL,
  `code_challenge` varchar(64) DEFAULT NULL,
  `auth_code` varchar(256) DEFAULT NULL,
  `access_token` varchar(36) DEFAULT NULL,
  `access_token_created_on` datetime DEFAULT NULL,
  `refresh_token` varchar(36) DEFAULT NULL,
  `refresh_token_created_on` datetime DEFAULT NULL,
  `auth_status` char(1) DEFAULT NULL,
  PRIMARY KEY (`device_id`),
  CONSTRAINT `dpa_device_auth_ibfk_1` FOREIGN KEY (`device_id`) REFERENCES `dpa_gd_device` (`device_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_device_auth`
--

LOCK TABLES `dpa_device_auth` WRITE;
/*!40000 ALTER TABLE `dpa_device_auth` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_device_auth` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_domain`
--

DROP TABLE IF EXISTS `dpa_domain`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_domain` (
  `domain_id` int NOT NULL,
  `domain_name` varchar(50) NOT NULL,
  `domain_name_lc` varchar(50) NOT NULL,
  `domain_desc` varchar(512) DEFAULT NULL,
  `created_by` varchar(64) NOT NULL,
  `created_on` datetime NOT NULL,
  `modified_by` varchar(64) NOT NULL,
  `modified_on` datetime NOT NULL,
  `restrict_folders` char(1) NOT NULL,
  `root_cat` int NOT NULL,
  `enabled` char(1) NOT NULL DEFAULT '1',
  `allow_file_based_keys` char(1) NOT NULL DEFAULT '1',
  `default_kms_vault` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`domain_id`),
  UNIQUE KEY `domain_name_lc` (`domain_name_lc`),
  CONSTRAINT `dpa_domain_chk_1` CHECK ((`domain_name_lc` = lower(`domain_name`)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_domain`
--

LOCK TABLES `dpa_domain` WRITE;
/*!40000 ALTER TABLE `dpa_domain` DISABLE KEYS */;
INSERT INTO `dpa_domain` VALUES (1,'Default','default','This is the default domain shipped with GoAnywhere','system','2024-04-22 14:01:14','system','2024-04-22 14:01:14','0',101,'1','0','cd7f043e-2cf7-ed26-6af5-2e500c1a0e7f');
/*!40000 ALTER TABLE `dpa_domain` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_domain_folder`
--

DROP TABLE IF EXISTS `dpa_domain_folder`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_domain_folder` (
  `domain_id` int NOT NULL,
  `df_path` varchar(256) NOT NULL,
  KEY `idx_dpa_domain_folder_did` (`domain_id`),
  CONSTRAINT `dpa_domain_folder_ibfk_1` FOREIGN KEY (`domain_id`) REFERENCES `dpa_domain` (`domain_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_domain_folder`
--

LOCK TABLES `dpa_domain_folder` WRITE;
/*!40000 ALTER TABLE `dpa_domain_folder` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_domain_folder` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_domain_setting`
--

DROP TABLE IF EXISTS `dpa_domain_setting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_domain_setting` (
  `domain_id` int NOT NULL,
  `setting_name` varchar(100) NOT NULL,
  `setting_value` varchar(2000) NOT NULL,
  PRIMARY KEY (`domain_id`,`setting_name`),
  CONSTRAINT `dpa_domain_setting_ibfk_1` FOREIGN KEY (`domain_id`) REFERENCES `dpa_domain` (`domain_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_domain_setting`
--

LOCK TABLES `dpa_domain_setting` WRITE;
/*!40000 ALTER TABLE `dpa_domain_setting` DISABLE KEYS */;
INSERT INTO `dpa_domain_setting` VALUES (1,'access.allowExecuteNativeCommand','true'),(1,'data.projectsDirectory','userdata/projects'),(1,'data.workspaceDirectory','userdata/workspace'),(1,'ghttps.siteUrl','https://localhost'),(1,'services.expireWebDocsFiles','false'),(1,'services.expireWebDocsFilesAfterDays','90'),(1,'services.webDocsDir','userdata/webdocs');
/*!40000 ALTER TABLE `dpa_domain_setting` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_edi_control_number`
--

DROP TABLE IF EXISTS `dpa_edi_control_number`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_edi_control_number` (
  `process_id` bigint NOT NULL,
  `group_control_number` int NOT NULL,
  KEY `process_id` (`process_id`),
  CONSTRAINT `dpa_edi_control_number_ibfk_1` FOREIGN KEY (`process_id`) REFERENCES `dpa_processed_edi_data` (`process_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_edi_control_number`
--

LOCK TABLES `dpa_edi_control_number` WRITE;
/*!40000 ALTER TABLE `dpa_edi_control_number` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_edi_control_number` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_email_token`
--

DROP TABLE IF EXISTS `dpa_email_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_email_token` (
  `token` char(36) NOT NULL,
  `action_type` int NOT NULL,
  `created_on` datetime NOT NULL,
  PRIMARY KEY (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_email_token`
--

LOCK TABLES `dpa_email_token` WRITE;
/*!40000 ALTER TABLE `dpa_email_token` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_email_token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_encrypted_folder`
--

DROP TABLE IF EXISTS `dpa_encrypted_folder`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_encrypted_folder` (
  `folder_id` int NOT NULL,
  `folder_path` varchar(256) NOT NULL,
  `enc_key` varchar(256) NOT NULL,
  `uuid` varchar(36) NOT NULL,
  `created_by` varchar(64) NOT NULL,
  `created_on` datetime NOT NULL,
  PRIMARY KEY (`folder_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_encrypted_folder`
--

LOCK TABLES `dpa_encrypted_folder` WRITE;
/*!40000 ALTER TABLE `dpa_encrypted_folder` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_encrypted_folder` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_event_type`
--

DROP TABLE IF EXISTS `dpa_event_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_event_type` (
  `event_type_id` int NOT NULL,
  `event_type_name` varchar(50) NOT NULL,
  `event_type_desc` varchar(512) DEFAULT NULL,
  `triggers_allowed` char(1) DEFAULT NULL,
  PRIMARY KEY (`event_type_id`),
  UNIQUE KEY `event_type_name` (`event_type_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_event_type`
--

LOCK TABLES `dpa_event_type` WRITE;
/*!40000 ALTER TABLE `dpa_event_type` DISABLE KEYS */;
INSERT INTO `dpa_event_type` VALUES (101,'login_failed',' ','1'),(102,'login_successful',' ','1'),(103,'login_successful_partial',' ','0'),(111,'download_failed',' ','1'),(112,'download_successful',' ','1'),(121,'upload_failed',' ','1'),(122,'upload_successful',' ','1'),(123,'before_godrive_upload',' ','1'),(131,'create_folder_failed',' ','1'),(132,'create_folder_successful',' ','1'),(141,'delete_file_failed',' ','1'),(142,'delete_file_successful',' ','1'),(146,'delete_folder_failed',' ','1'),(147,'delete_folder_successful',' ','1'),(151,'rename_file_failed',' ','1'),(152,'rename_file_successful',' ','1'),(156,'rename_folder_failed',' ','1'),(157,'rename_folder_successful',' ','1'),(161,'as2_message_receive_successful',' ','1'),(162,'as2_message_receive_failed',' ','1'),(164,'before_as2_mdn_send',' ','1'),(166,'as2_mdn_receive_failed',' ','1'),(167,'as2_mdn_receive_successful',' ','1'),(171,'checksum_failed',' ','0'),(172,'checksum_successful',' ','0'),(393,'before_secure_mail_send',' ','1'),(800,'connect',' ','1'),(801,'connection_rejected',' ','1'),(810,'disconnect',' ','1'),(941,'invitation_failed',' ','1'),(942,'invitation_successful',' ','1'),(951,'registration_failed',' ','1'),(952,'registration_successful',' ','1'),(970,'account_disabled',' ','1'),(975,'ip_address_blocked',' ','1'),(981,'change_password_failed',' ','1'),(982,'change_password_successful',' ','1'),(1000,'upload_form_file_successful',' ','0'),(1001,'upload_form_file_failed',' ','0'),(1002,'delete_form_file_successful',' ','0'),(1003,'delete_form_file_failed',' ','0'),(1004,'submit_form_successful',' ','0'),(1005,'submit_form_failed',' ','0'),(1006,'create_form_successful',' ','0'),(1007,'create_form_failed',' ','0'),(1008,'download_form_file_successful',' ','0'),(1009,'download_form_file_failed',' ','0'),(1010,'delete_form_successful',' ','0'),(1011,'delete_form_failed',' ','0'),(1012,'as4_push_successful',' ','1'),(1013,'as4_push_failed',' ','1'),(1014,'as4_pull_successful',' ','1'),(1015,'as4_pull_failed',' ','1'),(1016,'as4_receipt_receive_successful',' ','1'),(1017,'as4_receipt_receive_failed',' ','1'),(1018,'as4_error_receive',' ','1'),(1019,'before_as4_pull_receive',' ','1'),(1020,'before_as4_receipt_send',' ','1'),(1021,'as4_receipt_received_warning',' ','1'),(1100,'pesit_send_successful',' ','1'),(1101,'pesit_send_failed',' ','1'),(1102,'pesit_receive_successful',' ','1'),(1103,'pesit_receive_failed',' ','1'),(1104,'pesit_receive_ack_successful',' ','1'),(1105,'pesit_receive_ack_failed',' ','1');
/*!40000 ALTER TABLE `dpa_event_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_ftp_type`
--

DROP TABLE IF EXISTS `dpa_ftp_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_ftp_type` (
  `file_ext` varchar(20) NOT NULL,
  `data_type` char(1) NOT NULL,
  PRIMARY KEY (`file_ext`),
  CONSTRAINT `dpa_ftp_type_chk_1` CHECK ((`data_type` in (_utf8mb4'A',_utf8mb4'E',_utf8mb4'I')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_ftp_type`
--

LOCK TABLES `dpa_ftp_type` WRITE;
/*!40000 ALTER TABLE `dpa_ftp_type` DISABLE KEYS */;
INSERT INTO `dpa_ftp_type` VALUES ('ASC','A'),('ASP','A'),('BAT','A'),('C','A'),('CGI','A'),('CONF','A'),('CPP','A'),('CSS','A'),('CSV','A'),('DHTML','A'),('DTD','A'),('H','A'),('HTM','A'),('HTML','A'),('INI','A'),('JAVA','A'),('JHTML','A'),('JS','A'),('JSP','A'),('LOG','A'),('MV','A'),('PHP','A'),('PHTML','A'),('PL','A'),('SH','A'),('SHTML','A'),('SQL','A'),('TXT','A'),('VBS','A'),('XML','A'),('XSD','A');
/*!40000 ALTER TABLE `dpa_ftp_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_gadget`
--

DROP TABLE IF EXISTS `dpa_gadget`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_gadget` (
  `gadget_id` int NOT NULL,
  `gadget_name` varchar(100) NOT NULL,
  `gadget_type` varchar(10) NOT NULL,
  `created_by` varchar(64) NOT NULL,
  `created_on` datetime NOT NULL,
  `modified_by` varchar(64) NOT NULL,
  `modified_on` datetime NOT NULL,
  PRIMARY KEY (`gadget_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_gadget`
--

LOCK TABLES `dpa_gadget` WRITE;
/*!40000 ALTER TABLE `dpa_gadget` DISABLE KEYS */;
INSERT INTO `dpa_gadget` VALUES (1001,' ','start','gaaabaclac','2024-06-10 19:49:13','gaaabaclac','2024-06-10 19:49:13'),(1002,' ','links','gaaabaclac','2024-06-10 19:49:13','gaaabaclac','2024-06-10 19:49:13'),(1003,' ','news','gaaabaclac','2024-06-10 19:49:13','gaaabaclac','2024-06-10 19:49:13'),(1004,' ','maservices','gaaabaclac','2024-06-10 19:49:13','gaaabaclac','2024-06-10 19:49:13'),(1005,' ','servstats','gaaabaclac','2024-06-10 19:49:13','gaaabaclac','2024-06-10 19:49:13'),(1006,' ','jobstats','gaaabaclac','2024-06-10 19:49:13','gaaabaclac','2024-06-10 19:49:13');
/*!40000 ALTER TABLE `dpa_gadget` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_gadget_setting`
--

DROP TABLE IF EXISTS `dpa_gadget_setting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_gadget_setting` (
  `gadget_id` int NOT NULL,
  `gadget_type` varchar(10) NOT NULL,
  `setting_name` varchar(50) NOT NULL,
  `setting_value` varchar(1000) NOT NULL,
  KEY `idx_dpa_gadget_setting_gid` (`gadget_id`),
  CONSTRAINT `dpa_gadget_setting_ibfk_1` FOREIGN KEY (`gadget_id`) REFERENCES `dpa_gadget` (`gadget_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_gadget_setting`
--

LOCK TABLES `dpa_gadget_setting` WRITE;
/*!40000 ALTER TABLE `dpa_gadget_setting` DISABLE KEYS */;
INSERT INTO `dpa_gadget_setting` VALUES (1002,'links','links','Resources,Projects,Scheduler,Triggers,Admin Users,Web Users,Audit Logs,Reports'),(1003,'news','pageSize','3'),(1004,'maservices','services','623'),(1005,'servstats','protocols','HT, FTP, FTS, SFT, AS2, AS4, GoFast, PST'),(1005,'servstats','range','today'),(1006,'jobstats','range','today');
/*!40000 ALTER TABLE `dpa_gadget_setting` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_gd_audit_log`
--

DROP TABLE IF EXISTS `dpa_gd_audit_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_gd_audit_log` (
  `entry_id` bigint NOT NULL,
  `entry_index` int NOT NULL,
  `start_time` datetime NOT NULL,
  `indexed_godrive` char(1) NOT NULL DEFAULT '0',
  `failed_godrive` char(1) NOT NULL DEFAULT '0',
  `indexed_global` char(1) NOT NULL DEFAULT '0',
  `failed_global` char(1) NOT NULL DEFAULT '0',
  `log_data` mediumblob,
  PRIMARY KEY (`entry_id`,`entry_index`),
  KEY `idx_dpa_gd_audit_log` (`start_time` DESC)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_gd_audit_log`
--

LOCK TABLES `dpa_gd_audit_log` WRITE;
/*!40000 ALTER TABLE `dpa_gd_audit_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_gd_audit_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_gd_comment`
--

DROP TABLE IF EXISTS `dpa_gd_comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_gd_comment` (
  `comment_id` int NOT NULL,
  `gdi_id` int NOT NULL,
  `comment_text` varchar(2000) NOT NULL,
  `parent_comment_id` int NOT NULL,
  `created_by` int NOT NULL,
  `created_on` datetime NOT NULL,
  `modified_by` int NOT NULL,
  `modified_on` datetime NOT NULL,
  PRIMARY KEY (`comment_id`),
  KEY `idx_dpa_gd_comment_gdi_id` (`gdi_id`),
  CONSTRAINT `dpa_gd_comment_ibfk_1` FOREIGN KEY (`gdi_id`) REFERENCES `dpa_gd_item` (`gdi_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_gd_comment`
--

LOCK TABLES `dpa_gd_comment` WRITE;
/*!40000 ALTER TABLE `dpa_gd_comment` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_gd_comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_gd_device`
--

DROP TABLE IF EXISTS `dpa_gd_device`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_gd_device` (
  `device_id` varchar(36) NOT NULL,
  `user_id` int DEFAULT NULL,
  `user_name` varchar(64) DEFAULT NULL,
  `os_name` varchar(100) NOT NULL,
  `client_type` char(1) NOT NULL,
  `status` char(1) NOT NULL,
  `client_system_name` varchar(100) NOT NULL,
  `folder` varchar(256) DEFAULT NULL,
  `deactivated_from` char(1) DEFAULT NULL,
  `deactivated_on` datetime DEFAULT NULL,
  `activated_on` datetime DEFAULT NULL,
  `verification_pin` varchar(10) DEFAULT NULL,
  `pin_emailed` char(1) DEFAULT NULL,
  `approved_on` datetime DEFAULT NULL,
  `approved_by` varchar(64) DEFAULT NULL,
  `lost_stolen` char(1) DEFAULT NULL,
  `lost_stolen_on` datetime DEFAULT NULL,
  `locale_lang_cde` varchar(10) NOT NULL,
  `modified_on` datetime NOT NULL,
  `created_on` datetime NOT NULL,
  `last_connected_on` datetime DEFAULT NULL,
  `dek` varchar(145) DEFAULT NULL,
  `domain_id` int DEFAULT '1',
  PRIMARY KEY (`device_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_gd_device`
--

LOCK TABLES `dpa_gd_device` WRITE;
/*!40000 ALTER TABLE `dpa_gd_device` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_gd_device` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_gd_item`
--

DROP TABLE IF EXISTS `dpa_gd_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_gd_item` (
  `gdi_id` int NOT NULL,
  `gdi_type` char(1) NOT NULL DEFAULT 'F',
  `gdi_name` varchar(128) DEFAULT NULL,
  `created_by` int NOT NULL,
  `created_on` datetime NOT NULL,
  `modified_by` int NOT NULL,
  `modified_on` datetime NOT NULL,
  `stubbed` char(1) NOT NULL DEFAULT '1',
  `shared` char(1) NOT NULL DEFAULT '0',
  `trashed` char(1) NOT NULL DEFAULT '0',
  `trashed_on` datetime DEFAULT NULL,
  `trashed_by` int DEFAULT NULL,
  `current_volume_id` int DEFAULT NULL,
  `current_relative_path` varchar(64) DEFAULT NULL,
  `current_file_size` bigint DEFAULT NULL,
  `current_rev_id` int DEFAULT NULL,
  `current_rev_num` int DEFAULT NULL,
  `locked` char(1) NOT NULL DEFAULT '0',
  `locked_by` int DEFAULT NULL,
  `locked_on` datetime DEFAULT NULL,
  `locked_read` char(1) NOT NULL DEFAULT '0',
  `has_comments` char(1) NOT NULL DEFAULT '0',
  `expires_on` datetime DEFAULT NULL,
  `linked` char(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`gdi_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_gd_item`
--

LOCK TABLES `dpa_gd_item` WRITE;
/*!40000 ALTER TABLE `dpa_gd_item` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_gd_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_gd_notification`
--

DROP TABLE IF EXISTS `dpa_gd_notification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_gd_notification` (
  `notification_id` int NOT NULL,
  `sender_id` int NOT NULL,
  `recipient_id` int NOT NULL,
  `gdi_id` int NOT NULL,
  `notification_type` char(1) NOT NULL,
  `notification_data` mediumblob,
  PRIMARY KEY (`notification_id`),
  KEY `idx_dpa_gd_notif_recipient_id` (`recipient_id`),
  KEY `idx_dpa_gd_notif_gdi_id` (`gdi_id`),
  CONSTRAINT `dpa_gd_notification_ibfk_1` FOREIGN KEY (`recipient_id`) REFERENCES `dpa_web_user` (`user_id`) ON DELETE CASCADE,
  CONSTRAINT `dpa_gd_notification_ibfk_2` FOREIGN KEY (`gdi_id`) REFERENCES `dpa_gd_item` (`gdi_id`) ON DELETE CASCADE,
  CONSTRAINT `dpa_gd_notification_chk_1` CHECK ((`notification_type` in (_utf8mb3'D',_utf8mb3'U',_utf8mb3'C',_utf8mb3'R')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_gd_notification`
--

LOCK TABLES `dpa_gd_notification` WRITE;
/*!40000 ALTER TABLE `dpa_gd_notification` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_gd_notification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_gd_revision`
--

DROP TABLE IF EXISTS `dpa_gd_revision`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_gd_revision` (
  `rev_id` int NOT NULL,
  `gdi_id` int NOT NULL,
  `rev_num` int NOT NULL,
  `created_by` int NOT NULL,
  `created_on` datetime NOT NULL,
  `volume_id` int NOT NULL,
  `relative_path` varchar(64) NOT NULL,
  `file_size` bigint NOT NULL,
  `purged` char(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`rev_id`),
  KEY `idx_dpa_gd_revision_gdi_id` (`gdi_id`),
  CONSTRAINT `dpa_gd_revision_ibfk_1` FOREIGN KEY (`gdi_id`) REFERENCES `dpa_gd_item` (`gdi_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_gd_revision`
--

LOCK TABLES `dpa_gd_revision` WRITE;
/*!40000 ALTER TABLE `dpa_gd_revision` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_gd_revision` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_gd_volume`
--

DROP TABLE IF EXISTS `dpa_gd_volume`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_gd_volume` (
  `volume_id` int NOT NULL,
  `volume_path` varchar(256) NOT NULL,
  `limit_space` char(1) NOT NULL DEFAULT '0',
  `allocated_space` int NOT NULL,
  `allocated_space_unit` char(1) NOT NULL,
  `created_by` varchar(64) NOT NULL,
  `created_on` datetime NOT NULL,
  `modified_by` varchar(64) NOT NULL,
  `modified_on` datetime NOT NULL,
  PRIMARY KEY (`volume_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_gd_volume`
--

LOCK TABLES `dpa_gd_volume` WRITE;
/*!40000 ALTER TABLE `dpa_gd_volume` DISABLE KEYS */;
INSERT INTO `dpa_gd_volume` VALUES (1000,'userdata/godrive','0',500,'G','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13');
/*!40000 ALTER TABLE `dpa_gd_volume` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_gdi_thumb`
--

DROP TABLE IF EXISTS `dpa_gdi_thumb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_gdi_thumb` (
  `gdi_id` int NOT NULL,
  `rev_num` int NOT NULL,
  `target_size` int NOT NULL,
  `volume_id` int DEFAULT NULL,
  `relative_path` varchar(64) DEFAULT NULL,
  `thumb_size` bigint NOT NULL,
  `thumb_valid` char(1) NOT NULL DEFAULT '0',
  `use_source` char(1) NOT NULL DEFAULT '0',
  KEY `idx_dpa_gdi_thumb_gdi_id` (`gdi_id`),
  CONSTRAINT `dpa_gdi_thumb_ibfk_1` FOREIGN KEY (`gdi_id`) REFERENCES `dpa_gd_item` (`gdi_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_gdi_thumb`
--

LOCK TABLES `dpa_gdi_thumb` WRITE;
/*!40000 ALTER TABLE `dpa_gdi_thumb` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_gdi_thumb` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_gdi_user`
--

DROP TABLE IF EXISTS `dpa_gdi_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_gdi_user` (
  `gdiu_id` int NOT NULL,
  `item_id` int NOT NULL,
  `user_id` int NOT NULL,
  `parent_item_id` int NOT NULL,
  `share_item_id` int NOT NULL,
  `role_id` int NOT NULL,
  `share_pending` char(1) NOT NULL DEFAULT '0',
  `shared_name` varchar(128) DEFAULT NULL,
  `shared_on` datetime DEFAULT NULL,
  `shared_by` int DEFAULT NULL,
  `dek` varchar(256) DEFAULT NULL,
  `dek_iv` varchar(256) DEFAULT NULL,
  `subscription` int NOT NULL DEFAULT '-1',
  PRIMARY KEY (`gdiu_id`),
  UNIQUE KEY `item_id` (`item_id`,`user_id`,`parent_item_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `dpa_gdi_user_ibfk_1` FOREIGN KEY (`item_id`) REFERENCES `dpa_gd_item` (`gdi_id`) ON DELETE CASCADE,
  CONSTRAINT `dpa_gdi_user_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `dpa_web_user` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_gdi_user`
--

LOCK TABLES `dpa_gdi_user` WRITE;
/*!40000 ALTER TABLE `dpa_gdi_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_gdi_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_gftp_audit_log`
--

DROP TABLE IF EXISTS `dpa_gftp_audit_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_gftp_audit_log` (
  `event_id` bigint NOT NULL,
  `start_time` datetime NOT NULL,
  `end_time` datetime DEFAULT NULL,
  `severity` char(1) NOT NULL,
  `local_ip` varchar(40) DEFAULT NULL,
  `local_port` int DEFAULT NULL,
  `remote_ip` varchar(40) DEFAULT NULL,
  `remote_port` int DEFAULT NULL,
  `session_id` varchar(40) DEFAULT NULL,
  `user_name` varchar(64) DEFAULT NULL,
  `command` int DEFAULT NULL,
  `event_type` int DEFAULT NULL,
  `time_taken` bigint DEFAULT NULL,
  `file_path` varchar(256) DEFAULT NULL,
  `file_size` bigint DEFAULT NULL,
  `remarks` varchar(256) DEFAULT NULL,
  `system_name` varchar(20) DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `virtual_path` varchar(256) DEFAULT NULL,
  `indexed` char(1) NOT NULL DEFAULT '0',
  `domain_id` int NOT NULL DEFAULT '1',
  `checksum` varchar(91) DEFAULT NULL,
  PRIMARY KEY (`event_id`),
  KEY `idx_dpa_gftp_audit_log` (`start_time` DESC),
  KEY `idx_dpa_gftp_audit_log_usr` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_gftp_audit_log`
--

LOCK TABLES `dpa_gftp_audit_log` WRITE;
/*!40000 ALTER TABLE `dpa_gftp_audit_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_gftp_audit_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_gftps_audit_log`
--

DROP TABLE IF EXISTS `dpa_gftps_audit_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_gftps_audit_log` (
  `event_id` bigint NOT NULL,
  `start_time` datetime NOT NULL,
  `end_time` datetime DEFAULT NULL,
  `severity` char(1) NOT NULL,
  `local_ip` varchar(40) DEFAULT NULL,
  `local_port` int DEFAULT NULL,
  `remote_ip` varchar(40) DEFAULT NULL,
  `remote_port` int DEFAULT NULL,
  `session_id` varchar(40) DEFAULT NULL,
  `user_name` varchar(64) DEFAULT NULL,
  `command` int DEFAULT NULL,
  `event_type` int DEFAULT NULL,
  `time_taken` bigint DEFAULT NULL,
  `file_path` varchar(256) DEFAULT NULL,
  `file_size` bigint DEFAULT NULL,
  `remarks` varchar(256) DEFAULT NULL,
  `system_name` varchar(20) DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `virtual_path` varchar(256) DEFAULT NULL,
  `indexed` char(1) NOT NULL DEFAULT '0',
  `domain_id` int NOT NULL DEFAULT '1',
  `checksum` varchar(91) DEFAULT NULL,
  PRIMARY KEY (`event_id`),
  KEY `idx_dpa_gftps_audit_log` (`start_time` DESC),
  KEY `idx_dpa_gftps_audit_log_usr` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_gftps_audit_log`
--

LOCK TABLES `dpa_gftps_audit_log` WRITE;
/*!40000 ALTER TABLE `dpa_gftps_audit_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_gftps_audit_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_ghttps_audit_log`
--

DROP TABLE IF EXISTS `dpa_ghttps_audit_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_ghttps_audit_log` (
  `event_id` bigint NOT NULL,
  `start_time` datetime NOT NULL,
  `end_time` datetime DEFAULT NULL,
  `severity` char(1) NOT NULL,
  `local_ip` varchar(40) DEFAULT NULL,
  `local_port` int DEFAULT NULL,
  `remote_ip` varchar(40) DEFAULT NULL,
  `remote_port` int DEFAULT NULL,
  `session_id` varchar(40) DEFAULT NULL,
  `user_name` varchar(64) DEFAULT NULL,
  `command` int DEFAULT NULL,
  `event_type` int DEFAULT NULL,
  `time_taken` bigint DEFAULT NULL,
  `file_path` varchar(256) DEFAULT NULL,
  `file_size` bigint DEFAULT NULL,
  `remarks` varchar(256) DEFAULT NULL,
  `package_id` varchar(36) DEFAULT NULL,
  `recipient_email` varchar(128) DEFAULT NULL,
  `system_name` varchar(20) DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `virtual_path` varchar(256) DEFAULT NULL,
  `indexed` char(1) NOT NULL DEFAULT '0',
  `domain_id` int NOT NULL DEFAULT '1',
  `payload_id` varchar(36) DEFAULT NULL,
  `sms_phone` varchar(40) DEFAULT NULL,
  `checksum` varchar(91) DEFAULT NULL,
  PRIMARY KEY (`event_id`),
  KEY `idx_dpa_ghttps_audit_log` (`start_time` DESC),
  KEY `idx_dpa_ghttps_audit_log_pkg` (`package_id`),
  KEY `idx_dpa_ghttps_audit_log_rcp` (`recipient_email`),
  KEY `idx_dpa_ghttps_audit_log_usr` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_ghttps_audit_log`
--

LOCK TABLES `dpa_ghttps_audit_log` WRITE;
/*!40000 ALTER TABLE `dpa_ghttps_audit_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_ghttps_audit_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_global_log`
--

DROP TABLE IF EXISTS `dpa_global_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_global_log` (
  `log_id` int NOT NULL,
  `log_version` int NOT NULL,
  `status` int NOT NULL,
  PRIMARY KEY (`log_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_global_log`
--

LOCK TABLES `dpa_global_log` WRITE;
/*!40000 ALTER TABLE `dpa_global_log` DISABLE KEYS */;
INSERT INTO `dpa_global_log` VALUES (1000,26,1);
/*!40000 ALTER TABLE `dpa_global_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_gofast_audit_log`
--

DROP TABLE IF EXISTS `dpa_gofast_audit_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_gofast_audit_log` (
  `event_id` bigint NOT NULL,
  `start_time` datetime NOT NULL,
  `end_time` datetime DEFAULT NULL,
  `severity` char(1) NOT NULL,
  `local_ip` varchar(40) DEFAULT NULL,
  `local_port` int DEFAULT NULL,
  `remote_ip` varchar(40) DEFAULT NULL,
  `remote_port` int DEFAULT NULL,
  `session_id` varchar(40) DEFAULT NULL,
  `user_name` varchar(64) DEFAULT NULL,
  `command` int DEFAULT NULL,
  `event_type` int DEFAULT NULL,
  `time_taken` bigint DEFAULT NULL,
  `file_path` varchar(256) DEFAULT NULL,
  `file_size` bigint DEFAULT NULL,
  `remarks` varchar(256) DEFAULT NULL,
  `system_name` varchar(20) DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `virtual_path` varchar(256) DEFAULT NULL,
  `indexed` char(1) NOT NULL DEFAULT '0',
  `domain_id` int NOT NULL DEFAULT '1',
  `checksum` varchar(91) DEFAULT NULL,
  PRIMARY KEY (`event_id`),
  KEY `idx_dpa_gofast_audit_log` (`start_time` DESC),
  KEY `idx_dpa_gofast_audit_log_usr` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_gofast_audit_log`
--

LOCK TABLES `dpa_gofast_audit_log` WRITE;
/*!40000 ALTER TABLE `dpa_gofast_audit_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_gofast_audit_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_group`
--

DROP TABLE IF EXISTS `dpa_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_group` (
  `group_id` int NOT NULL,
  `group_name` varchar(50) NOT NULL,
  `group_name_lc` varchar(50) NOT NULL,
  `group_desc` varchar(512) DEFAULT NULL,
  `sys_group` char(1) NOT NULL DEFAULT '0',
  `created_by` varchar(64) NOT NULL,
  `created_on` datetime NOT NULL,
  `modified_by` varchar(64) NOT NULL,
  `modified_on` datetime NOT NULL,
  `login_method_id` int NOT NULL DEFAULT '-1',
  `ldap_group_dn` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`group_id`),
  UNIQUE KEY `group_name_lc` (`group_name_lc`),
  CONSTRAINT `dpa_group_chk_1` CHECK ((`group_name_lc` = lower(`group_name`)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_group`
--

LOCK TABLES `dpa_group` WRITE;
/*!40000 ALTER TABLE `dpa_group` DISABLE KEYS */;
INSERT INTO `dpa_group` VALUES (101,'All Admin Users','all admin users','This group includes all admin users','1','system','2024-04-22 14:01:11','system','2024-04-22 14:01:11',-1,NULL);
/*!40000 ALTER TABLE `dpa_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_group_agent_map`
--

DROP TABLE IF EXISTS `dpa_group_agent_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_group_agent_map` (
  `agent_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`agent_id`,`group_id`),
  KEY `group_id` (`group_id`),
  CONSTRAINT `dpa_group_agent_map_ibfk_1` FOREIGN KEY (`agent_id`) REFERENCES `dpa_agent` (`agent_id`),
  CONSTRAINT `dpa_group_agent_map_ibfk_2` FOREIGN KEY (`group_id`) REFERENCES `dpa_agent_group` (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_group_agent_map`
--

LOCK TABLES `dpa_group_agent_map` WRITE;
/*!40000 ALTER TABLE `dpa_group_agent_map` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_group_agent_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_group_domain`
--

DROP TABLE IF EXISTS `dpa_group_domain`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_group_domain` (
  `domain_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`group_id`,`domain_id`),
  KEY `domain_id` (`domain_id`),
  CONSTRAINT `dpa_group_domain_ibfk_1` FOREIGN KEY (`domain_id`) REFERENCES `dpa_domain` (`domain_id`),
  CONSTRAINT `dpa_group_domain_ibfk_2` FOREIGN KEY (`group_id`) REFERENCES `dpa_group` (`group_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_group_domain`
--

LOCK TABLES `dpa_group_domain` WRITE;
/*!40000 ALTER TABLE `dpa_group_domain` DISABLE KEYS */;
INSERT INTO `dpa_group_domain` VALUES (1,101);
/*!40000 ALTER TABLE `dpa_group_domain` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_group_role`
--

DROP TABLE IF EXISTS `dpa_group_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_group_role` (
  `group_id` int NOT NULL,
  `role_id` int NOT NULL,
  PRIMARY KEY (`group_id`,`role_id`),
  KEY `role_id` (`role_id`),
  CONSTRAINT `dpa_group_role_ibfk_1` FOREIGN KEY (`group_id`) REFERENCES `dpa_group` (`group_id`) ON DELETE CASCADE,
  CONSTRAINT `dpa_group_role_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `dpa_role` (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_group_role`
--

LOCK TABLES `dpa_group_role` WRITE;
/*!40000 ALTER TABLE `dpa_group_role` DISABLE KEYS */;
INSERT INTO `dpa_group_role` VALUES (101,118);
/*!40000 ALTER TABLE `dpa_group_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_gsftp_audit_log`
--

DROP TABLE IF EXISTS `dpa_gsftp_audit_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_gsftp_audit_log` (
  `event_id` bigint NOT NULL,
  `start_time` datetime NOT NULL,
  `end_time` datetime DEFAULT NULL,
  `severity` char(1) NOT NULL,
  `local_ip` varchar(40) DEFAULT NULL,
  `local_port` int DEFAULT NULL,
  `remote_ip` varchar(40) DEFAULT NULL,
  `remote_port` int DEFAULT NULL,
  `session_id` varchar(40) DEFAULT NULL,
  `user_name` varchar(64) DEFAULT NULL,
  `command` int DEFAULT NULL,
  `event_type` int DEFAULT NULL,
  `time_taken` bigint DEFAULT NULL,
  `file_path` varchar(256) DEFAULT NULL,
  `file_size` bigint DEFAULT NULL,
  `remarks` varchar(256) DEFAULT NULL,
  `system_name` varchar(20) DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `virtual_path` varchar(256) DEFAULT NULL,
  `indexed` char(1) NOT NULL DEFAULT '0',
  `domain_id` int NOT NULL DEFAULT '1',
  `checksum` varchar(91) DEFAULT NULL,
  PRIMARY KEY (`event_id`),
  KEY `idx_dpa_gsftp_audit_log` (`start_time` DESC),
  KEY `idx_dpa_gsftp_audit_log_usr` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_gsftp_audit_log`
--

LOCK TABLES `dpa_gsftp_audit_log` WRITE;
/*!40000 ALTER TABLE `dpa_gsftp_audit_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_gsftp_audit_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_holiday`
--

DROP TABLE IF EXISTS `dpa_holiday`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_holiday` (
  `calendar_id` int NOT NULL,
  `holiday_name` varchar(50) DEFAULT NULL,
  `holiday_date` bigint NOT NULL,
  UNIQUE KEY `calendar_id` (`calendar_id`,`holiday_date`),
  CONSTRAINT `dpa_holiday_ibfk_1` FOREIGN KEY (`calendar_id`) REFERENCES `dpa_holiday_calendar` (`calendar_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_holiday`
--

LOCK TABLES `dpa_holiday` WRITE;
/*!40000 ALTER TABLE `dpa_holiday` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_holiday` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_holiday_calendar`
--

DROP TABLE IF EXISTS `dpa_holiday_calendar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_holiday_calendar` (
  `calendar_id` int NOT NULL,
  `calendar_name` varchar(50) NOT NULL,
  `calendar_name_lc` varchar(50) NOT NULL,
  `calendar_desc` varchar(255) DEFAULT NULL,
  `weekends` int NOT NULL DEFAULT '0',
  `created_by` varchar(64) NOT NULL,
  `created_on` datetime NOT NULL,
  `modified_by` varchar(64) NOT NULL,
  `modified_on` datetime NOT NULL,
  PRIMARY KEY (`calendar_id`),
  UNIQUE KEY `calendar_name_lc` (`calendar_name_lc`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_holiday_calendar`
--

LOCK TABLES `dpa_holiday_calendar` WRITE;
/*!40000 ALTER TABLE `dpa_holiday_calendar` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_holiday_calendar` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_ignored_package_file`
--

DROP TABLE IF EXISTS `dpa_ignored_package_file`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_ignored_package_file` (
  `file_hash` varchar(40) NOT NULL,
  `file_size` bigint NOT NULL,
  `file_name` varchar(128) NOT NULL,
  PRIMARY KEY (`file_hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_ignored_package_file`
--

LOCK TABLES `dpa_ignored_package_file` WRITE;
/*!40000 ALTER TABLE `dpa_ignored_package_file` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_ignored_package_file` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_ip_filter`
--

DROP TABLE IF EXISTS `dpa_ip_filter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_ip_filter` (
  `entry_id` int NOT NULL,
  `created_by` varchar(64) NOT NULL,
  `created_on` datetime NOT NULL,
  `modified_by` varchar(64) NOT NULL,
  `modified_on` datetime NOT NULL,
  `entry_label` varchar(50) DEFAULT NULL,
  `entry_def` varchar(128) DEFAULT NULL,
  `entry_type` char(1) NOT NULL DEFAULT 'G',
  PRIMARY KEY (`entry_id`),
  UNIQUE KEY `entry_def` (`entry_def`,`entry_type`),
  KEY `idx_dpa_ip_filter` (`entry_label`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_ip_filter`
--

LOCK TABLES `dpa_ip_filter` WRITE;
/*!40000 ALTER TABLE `dpa_ip_filter` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_ip_filter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_ip_filter_cidr`
--

DROP TABLE IF EXISTS `dpa_ip_filter_cidr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_ip_filter_cidr` (
  `entry_id` int NOT NULL,
  `cidr` varchar(64) DEFAULT NULL,
  KEY `entry_id` (`entry_id`),
  CONSTRAINT `dpa_ip_filter_cidr_ibfk_1` FOREIGN KEY (`entry_id`) REFERENCES `dpa_ip_filter` (`entry_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_ip_filter_cidr`
--

LOCK TABLES `dpa_ip_filter_cidr` WRITE;
/*!40000 ALTER TABLE `dpa_ip_filter_cidr` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_ip_filter_cidr` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_job`
--

DROP TABLE IF EXISTS `dpa_job`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_job` (
  `job_id` bigint NOT NULL,
  `proj_id` int NOT NULL,
  `proj_name` varchar(200) NOT NULL,
  `proj_folder` varchar(512) NOT NULL,
  `run_user` varchar(64) NOT NULL,
  `queue_priority` int NOT NULL,
  `run_priority` int NOT NULL,
  `submit_time` datetime NOT NULL,
  `start_time` datetime NOT NULL,
  `end_time` datetime DEFAULT NULL,
  `time_taken` bigint DEFAULT NULL,
  `job_log` varchar(256) NOT NULL,
  `status` char(1) NOT NULL DEFAULT 'A',
  `remarks` varchar(512) DEFAULT NULL,
  `system_name` varchar(20) DEFAULT NULL,
  `job_queue_name` varchar(20) DEFAULT NULL,
  `run_mode` char(1) NOT NULL DEFAULT 'U',
  `job_name` varchar(200) DEFAULT NULL,
  `submit_src` char(1) NOT NULL DEFAULT '0',
  `submit_src_id` int NOT NULL DEFAULT '-1',
  `submit_src_name` varchar(64) DEFAULT NULL,
  `resolved` char(1) NOT NULL DEFAULT 'N',
  `resolved_on` datetime DEFAULT NULL,
  `resolved_by` varchar(64) DEFAULT NULL,
  `job_notes` varchar(512) DEFAULT NULL,
  `indexed` char(1) NOT NULL DEFAULT '0',
  `exception_count` int NOT NULL DEFAULT '0',
  `domain_id` int NOT NULL DEFAULT '1',
  `agent_id` int NOT NULL DEFAULT '0',
  `agent_group_id` int NOT NULL DEFAULT '0',
  `submit_src_alt_id` int NOT NULL DEFAULT '-1',
  `execution_id` bigint DEFAULT '0',
  `agent_name` varchar(64) DEFAULT NULL,
  `agent_group_name` varchar(64) DEFAULT NULL,
  `checksum` varchar(91) DEFAULT NULL,
  PRIMARY KEY (`job_id`),
  KEY `dpa_idx_job_1` (`start_time` DESC,`status` DESC,`run_user` DESC),
  KEY `dpa_idx_job_2` (`start_time` DESC,`proj_id`,`status`,`run_user`),
  KEY `dpa_idx_job_3` (`start_time` DESC,`submit_src`,`submit_src_id`,`status`),
  CONSTRAINT `dpa_job_chk_1` CHECK ((`status` in (_utf8mb3'A',_utf8mb3'S',_utf8mb3'F',_utf8mb3'C')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_job`
--

LOCK TABLES `dpa_job` WRITE;
/*!40000 ALTER TABLE `dpa_job` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_job` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_job_file_log`
--

DROP TABLE IF EXISTS `dpa_job_file_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_job_file_log` (
  `event_id` bigint NOT NULL,
  `event_type` smallint NOT NULL,
  `transfer_direction` char(1) DEFAULT NULL,
  `start_time` datetime DEFAULT NULL,
  `time_taken` bigint DEFAULT NULL,
  `job_id` bigint NOT NULL,
  `task_name` smallint NOT NULL,
  `status` char(1) NOT NULL,
  `source_file_name` varchar(128) DEFAULT NULL,
  `source_file_path` varchar(256) DEFAULT NULL,
  `source_file_size` bigint DEFAULT NULL,
  `source_server_host` varchar(128) DEFAULT NULL,
  `source_server_user` varchar(128) DEFAULT NULL,
  `source_resource_name` varchar(50) DEFAULT NULL,
  `source_protocol` smallint DEFAULT NULL,
  `destination_file_name` varchar(128) DEFAULT NULL,
  `destination_file_path` varchar(256) DEFAULT NULL,
  `destination_file_size` bigint DEFAULT NULL,
  `destination_server_host` varchar(128) DEFAULT NULL,
  `destination_server_user` varchar(128) DEFAULT NULL,
  `destination_resource_name` varchar(50) DEFAULT NULL,
  `destination_protocol` smallint DEFAULT NULL,
  `admin_user` varchar(64) NOT NULL,
  `indexed` char(1) NOT NULL DEFAULT '0',
  `domain_id` int NOT NULL DEFAULT '1',
  `agent_id` int NOT NULL DEFAULT '0',
  `agent_name` varchar(64) DEFAULT NULL,
  `agent_group_id` int NOT NULL DEFAULT '0',
  `agent_group_name` varchar(64) DEFAULT NULL,
  `checksum` varchar(91) DEFAULT NULL,
  PRIMARY KEY (`event_id`),
  KEY `idx_dpa_job_file_log` (`start_time` DESC)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_job_file_log`
--

LOCK TABLES `dpa_job_file_log` WRITE;
/*!40000 ALTER TABLE `dpa_job_file_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_job_file_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_job_queue`
--

DROP TABLE IF EXISTS `dpa_job_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_job_queue` (
  `queue_id` int NOT NULL,
  `queue_name` varchar(20) NOT NULL,
  `queue_name_lc` varchar(20) NOT NULL,
  `description` varchar(512) DEFAULT NULL,
  `priority` int NOT NULL,
  `max_active_count` int NOT NULL,
  `default_queue` char(1) NOT NULL,
  `status` char(1) NOT NULL,
  `executing_system_name` varchar(20) DEFAULT NULL,
  `created_by` varchar(64) NOT NULL,
  `created_on` datetime NOT NULL,
  `modified_by` varchar(64) NOT NULL,
  `modified_on` datetime NOT NULL,
  PRIMARY KEY (`queue_id`),
  UNIQUE KEY `queue_name_lc` (`queue_name_lc`),
  CONSTRAINT `dpa_job_queue_chk_1` CHECK ((`queue_name_lc` = lower(`queue_name`)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_job_queue`
--

LOCK TABLES `dpa_job_queue` WRITE;
/*!40000 ALTER TABLE `dpa_job_queue` DISABLE KEYS */;
INSERT INTO `dpa_job_queue` VALUES (1,'Default','default','The default queue for processing batch jobs',5,0,'1','A',NULL,'system','2024-04-22 14:01:14','system','2024-04-22 14:01:14');
/*!40000 ALTER TABLE `dpa_job_queue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_kms_cert_key`
--

DROP TABLE IF EXISTS `dpa_kms_cert_key`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_kms_cert_key` (
  `key_id` varchar(36) NOT NULL,
  `vault_id` varchar(36) NOT NULL,
  `key_name` varchar(128) NOT NULL,
  `key_name_lc` varchar(128) NOT NULL,
  `key_type` char(1) NOT NULL,
  `description` varchar(512) DEFAULT NULL,
  `key_size` int NOT NULL,
  `algorithm` char(1) NOT NULL,
  `key_password` varchar(152) DEFAULT NULL,
  `subject` varchar(128) NOT NULL,
  `issuer` varchar(128) NOT NULL,
  `expires_on` datetime NOT NULL,
  `sha1_fingerprint` char(59) NOT NULL,
  `sha512_fingerprint` char(191) NOT NULL,
  `key_obj` mediumblob,
  `created_by` varchar(64) NOT NULL,
  `created_on` datetime NOT NULL,
  `modified_by` varchar(64) NOT NULL,
  `modified_on` datetime NOT NULL,
  PRIMARY KEY (`key_id`),
  UNIQUE KEY `vault_id` (`vault_id`,`key_name_lc`),
  CONSTRAINT `dpa_kms_cert_key_ibfk_1` FOREIGN KEY (`vault_id`) REFERENCES `dpa_kms_vault` (`vault_id`),
  CONSTRAINT `dpa_kms_cert_key_chk_1` CHECK ((`key_name_lc` = lower(`key_name`)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_kms_cert_key`
--

LOCK TABLES `dpa_kms_cert_key` WRITE;
/*!40000 ALTER TABLE `dpa_kms_cert_key` DISABLE KEYS */;
INSERT INTO `dpa_kms_cert_key` VALUES ('0791c045-ef35-4bb1-b533-ffc979447a13','7ad62dc6-56e4-57bb-218f-349ed1097ad9','aolrootca2','aolrootca2','1',NULL,4096,'R',NULL,'America Online Root Certification Authority 2','America Online Root Certification Authority 2','2037-09-29 14:08:00','85:B5:FF:67:9B:0C:79:96:1F:C8:6E:44:22:00:46:13:DB:17:92:84','D6:ED:3C:CA:E2:66:0F:AF:10:43:0D:77:9B:04:09:BF',_binary '*1:GpMbq6dLxdt1i8IEEcrht9SzWJV3EILLlsB8LIQi6m7o2Q0pBcHRDACYXFHJ0s2cDemyiHqYDMEsntsvDkzqJWOyRJkSSZjgVB9sypdxtPH26OTQSLyZqvJfrPXQjW0TMSmkqDPH1s+AWQAVzkYU5A5KxboJ6QT2z8S9WrF5NV00KDcAz6+TE/Y314wKEeuQJ36rUaeK4/fQVn8P9/lKlo3sXnnJmRNFCun66qjdoptTHmednbK6ATjS95A5nIpE8a+UwmvkWKODNno68WwG8xUOZmrmTISBezazUrBx4B/f6qnwJxBJy67j0mwUjLH8tEJYdl3DeQXlHdoFtn1lIQ99RkWdIJjHBz2IYSs9ZCoYGiTKzGM1i2JukvAj2qBr4srlSUVQsXBPOcdRhu7Ngas2aW4GKXsujPQ5MGROYbM1RLhVpSpD5u8dnxtsgaSu63jveVVBGIhhhAoC1hAKsh5uFIKOMjWouLp5Juf2iJb0gDHb3Hv3+wtb0UnXi02Fwg0esQWXBhtoo+fn3YKjjvqJVi9wHBEzRBjbt0/oKfaeo9XDWWweq+X1NltsbtDLU7wwpw4rAs4BcZeonz0bMHvardcEAZjEsyjiXaYHDyJDQ2SItBBKTLV7Fbc/LfFoD1r9uJ+88Mw2lSTZ+GOtX0lEF+99/xPR+K1PXo2mIpuFm457L+KBfeS5po/0Tg0+66PN8TwIWOD7ot5VwpC3+j9T98AIa+u4Ka1qls8G8P7ZOFNpOitTFAaXeOS/frUhoN0KPUul7psEDUxPxxttdJSCs/zoGBTLAhk0jEjTELr9V48htsl5TaizK5dI4b09N03/ifVCTBWwNIkut4zDxPUgLWn08YG7zp//tK7CvgGx8vAMogi+2pBZobPLO4pk1unQlRvW6fvWyJkTLiPETRpfuibt369GzoHYrBjMBoM8YfHUjCWo+2KqvUHapeTBMk3eAi6tX2wcLzaWP1m7T/eJZE3RxEiBuFcnwMzvQH1j1qmdj3K+m+p9hCpOT7fI6O04zGJ0SuaVkGAmPLdiLKlsftzFTc6k6cNz3/guMt7K5BHSh0N14NTrs7wErEOwQTfKpvD3UpYhYmKyDK9zrKWObIPK7PkfiQv1MzapJLBcpi1u7o/ANmwayjvKfg9GqkfE7HBbA3yc3AxKNtrxJw7tMbXOdafay/bY+FNpFTKxcYzxPy+WyxaqUP6ToE1R2c1RPHw1L/YXtCFc2RcqGFVYi6bR+th6gwYQLCXBzirTS+HXNdA8YZuWu/+GD29uWLnH3RqKyl96z2ig20ffhKtE4ZMcOxmaAwkufQAWrwOaI1Wy/JRjYAULuEHpbQrAxIYmKkTvWDoBisPcS/RlzzkT1kCrGSeGCXFVMGsPzaGt45zkrr+Vx9NLqbhmVzhUoAeVIQ6kAmfCXjeHMpOTgjBHFPgQNLCiw0UxhzV+Pkv1Z0hhRoyephU9ucgBQxdokJ6rP52/QkYbAHLFk/9e98mzmQJfs+CDU2RBW8Uw4ZxYqpSTF0JRF1IXLF61Jy5PF0XrQ1FtiOBTyzgrH2yxlQTJfWmm3G5gnbMy8jh3vSeMBlmPAVdGIklle9xsFFSTpHq5Qz7+3zn3S4l7jjhCmxyZD7VYDGWV5gaJ7vEVKzYZW1sdkc6Jyo384rlOJLjxYwYQaVdC6UAHAhC5kwj1J4o68uDFi46iU4y1VxexGGtA6o2MO2J/d/1Y85CC1u71FpovqyV5waDtNzYT1rIRl72ejczRiKF2Hh19XYQNWsizLeniPQIFXLMWNC4QMo2GnzitQ5Aa7O1Vf/hc56RL0S7fkSxP3rZp1i7HBWYKjl2gCaR3htltdc+bZkp6bfH46wjfCGdHA3qrwLtXyWKu9NHAqo3TB963k1Vx1+XEcnvCJbQGI8vUys4PvviFWD+/jayk5lt0PAsYtbx4CKfw6g==','system','2016-04-13 18:46:42','system','2024-04-22 14:01:19'),('0887c518-6de6-468f-a4e5-f2c8f4964264','7ad62dc6-56e4-57bb-218f-349ed1097ad9','geotrustglobalca','geotrustglobalca','1',NULL,2048,'R',NULL,'GeoTrust Global CA','GeoTrust Global CA','2022-05-21 04:00:00','DE:28:F4:A4:FF:E5:B9:2F:A3:C5:03:D1:A3:49:A7:F9:96:2A:82:12','F7:75:AB:29:FB:51:4E:B7:77:5E:FF:05:3C:99:8E:F5',_binary '*1:wca+Bd8m/en28MkrLh/vLU3Rnh0AvohzzkFUzZ/dbqnwysi9x6fEiai3R2C4MzZ4ejgBZueA7/IzI3V39nMe76cjF/e6C27lWbB3QYrUjSQWjfHHO9XLj90hZDmsUCFEPio1fNcjq2VhxPkEhK1zcxhJU7idE9HbTQaB3sK2eAdH8cxt2NV576Nmc+rWJLyDdTgRYlK7co1JG+RwoCfCJAOszqWHHQSDzqd3cbRFkE4kj47tVVfJEJ9Db57gmigoFqztYIWtXLtaz+jqb7T+UtnX4hw6D8n2biq6V/O0EG3RA8vOOx52z0ozbR0BxGLZXrs0cY2xIH5L2j4cnAOGq+IWQ5g8fvrlf0ZBY8C88HmCAR91p1um9mqKpZZGkF5qNMcHOLIPhuWf3GpnM0tNB2NZ2RC3aO6TaCMQN+1HSvB3zfqLz0m5n/JqSGtp7h1jnOOIKj5mkUHpjGynzkZKTnoiVS1JQv7qpaSHhuUGruYPj5fQjQV1K0n31QRE8Z4i7irulH/av8WthTmS6h7SIxkvCq6q99olvodVCjgC5SbXoTprRwXy3JrnPYCbqfbuDXo450aE6g+5gwYsaFy5Q683ee1pnzVBUScCqtg4YKszkA9NmLsJbFOIHszmTupcQ2ez7rU3d52hVth8WqBo3hdsNUA6s/06QaTmM0IX1Vwq1yxbpXC0YDHIQ9d4L73h07mY7FSxxLedILeuwo+tKt5Qa+l+mvVrbj6JYrB4W3pVJlA88CifLJ4EuSPEKM9rDUlVUK9/jLe1k1o7MuQqnyHKAljcgLFASO1OSxJdBcDISw20TJhO7OAwKaQ5k2MAnvX+Uts9So4pYt6ms+/SPbLGNWkcfO/YpZ+wr3Oo6SgAng35a0bsArK5DuXBtkqo8RKuj67TpFPxsMN28ijGriAtEnCvkLZsdA0QCdIR8o//DiRsQDjnsE6BnQ++6gK8jlg/WcOXLfLlYJSG4VOjVK2nLMcViYCEcPUcRPeEkIy/7vRnTUUEe1OVP0dsg/4PI+M/piIAMnN3NiZKHo3I+IX+hVRaqxe18IHacxBNYf9qXc1YgdySeQ6DxzHy3UcXrDVLd+OEHYlNHfsMuKM7sWOY6poNg2E1aynp6UedOtMcZefPWHFSk9Pn/e+yYiPS','system','2016-04-13 18:46:40','system','2024-04-22 14:01:19'),('0a7f02d6-52e7-429f-a854-3579847dba49','7ad62dc6-56e4-57bb-218f-349ed1097ad9','geotrustprimarycag2','geotrustprimarycag2','1',NULL,0,'E',NULL,'GeoTrust Primary Certification Authority - G2','GeoTrust Primary Certification Authority - G2','2038-01-18 23:59:59','8D:17:84:D5:37:F3:03:7D:EC:70:FE:57:8B:51:9A:99:E6:10:D7:B0','01:5E:D8:6B:BD:6F:3D:8E:A1:31:F8:12:E0:98:73:6A',_binary '*1:kVbYXKJdYBbvuK+619mvpDEv0wGluWckKW9+lubPqQD93vrimYmlE2m6ggtysBDGgw6Xnww5dAHXbyrXk+ubeq2tdVUnmYPs7iqdAof7U1O1GzMmmWL5gb4BNnd6b+jXMBzmnFwZxiEqXkW0AQxNY75WQbj2/+mOvFonaBxXO392pRatvI5ap9b3AnG6szCTAUNHVh3RD4p5foRu7Yggc28fPhA5/dzOiVeRdTuc0n+nm+nu+ZWEdgdxYtWHma3Z19+QgCqjyY97iqIr2CQLJsXzM2T1S+aARtP/oVu4e6QsdcBtfg3GG41IcAMmb2S7+NY6fe/sp+QYPvvNmqAUPOkNDtZzdWYwgsl4GXA9HZ0j7CgS82B5a6y61AAQdL5aksnkMIlwbnRxn1NG0a/se+IrfsT06DNHaBk3I1PNda7s6TCH7vgZbtCy2ru63swj8CxuqjT672R9ngATVpUDVcMZW0GAdASGTQmd4L7NLQYCwFYwBVPtY6KSiA57t25exv85XgeECp8FIGamfAdK9xePd0F+RCAOQRVk1RFU+M2xtJtfbonpWNw+mY2KGYOeiQ/N+t5/GGIinnNsB87VQmrN9ZMIsJ1Q00aAtJvtYDtqA75q3ymmE0/YwkshdF2NqHnfVjK+P5DJ6Dx5vebKiOB4VNCHmssdNxzg7uM35fCAmCEzeWrcTLqzHo5lx1PwP5nAb1+95qmNx0D3QT5cwIHsGuHIZ/e9Cbfaz56FhnDfdpqv53bUxvSWdcGkxhchOSPolql2GjHIxgN1Mdr5tZFD4livPMhd02pWx5AqB/KqmkrcexsSypxvNxy2KMw1dRejYT9CYIjgNv2bzoVpkClRWuSdlmTNaaySLuEgKMhgsmNOD7Cd1pLkwDXRXrxa5wsso/Y7cj2CVW5KIHLDVUT9WWao2ZdKV09fnUnpHLU=','system','2016-04-13 18:46:45','system','2024-04-22 14:01:19'),('0fe0b08b-8e63-4d5b-b25a-0b5a9e1aec46','7ad62dc6-56e4-57bb-218f-349ed1097ad9','digicertassuredidrootca','digicertassuredidrootca','1',NULL,2048,'R',NULL,'DigiCert Assured ID Root CA','DigiCert Assured ID Root CA','2031-11-10 00:00:00','05:63:B8:63:0D:62:D7:5A:BB:C8:AB:1E:4B:DF:B5:A8:99:B2:4D:43','87:CE:0B:7B:2A:0E:49:00:E1:58:71:9B:37:A8:93:72',_binary '*1:MooYW3MD984K00zCNSaC6/MJTqQ0Ia7KEN5Ge/Gkwec+Z+M5ECB2+oQIwXIR6+io9iYiQsyrL1vtwsmvCAkXz9vd8Jwpd2Wi8S1xHf+VkkfSVH0tHS95msRoMn4ILPbd+Y0UP3ktXZ3TCQSqPH3FLVhW2IboPPGhsvLPhK5GxBdARlFJrKn8AL9APFFbs2VUrqpPhUb3Mt1eBZxvg3YymBKimwNVuQShcsUvODnElEvSbG+zO857lo4LlqMBaSBuVr9/ci9HoxcPu2UbhZadsqgaHcSeqhPW2ATUamfkcHh/3rMVSSokcosbjPpIrFQcAD7Ei3Tm25yVu2vo+ank4JdPhYw9dRFtfDy2zRBHy8mwf+1Xed6PNN+njDmIWS0eEJq+yteTqX1mvaFa4hsIcEHnNC4A2iB7LKIZ67JOu3DIKevzVHVt7EfVDaQsam170lLwrjNJ7cMe4FLD+0+B5ygig03p3MG3tG97m3mYeJZcBVTd94UxRb/c8qRfUUDWWUCNAs7khdUVJwRK+Mp75TABJINYoDR5C4WGSUq9NY356RRmHLOXNtceMgnitJdwVihdiYoXn6rG9q4jbdQLp5yZyMPmr1KYGlkHT8H9FZiv4Yt+7H1InsyCKN+EHiP87Jcne53ngNrfp1T4UtTLNvqHXgoU+AOVx1h5fRPK1qrWtUjizO3jJJn+a4J0w6QRtSN1/tqgbTO9pHBklrEbwcj/HaCOXkR2/40jE4q2VtGagqqCKUbK9HR8uzwR7ghI9nvnAvVZDyu1N28PriTVLNpW1yPm8dtYzaFaeXIhOxT+RcIEGMI7z87PFAAUEMPW5SVmbPClibfsULt7iLAQfjAqjw3g21KTEkrZBqZOGkMU7qkphSfEpW50YT2B62arbWF/+fBVZDlKGHGeNurRcv0Q/y7/TwfX06OE7InBUCUv/Movovr4Q3cu6V+kDuHIZdaPVgEpK+bBc3REKWvlANdXfYC4oHkQnuLN7lWIfl3lNioQc1+xU4CK0IlC792nYe0255tTHBOqHo700iTmfqAfuecWo7fjHzV9QIguDl+x3ChNRVW7tj1Hwtqkk1gmUypd8kxAO90eCRmh/FHQkWrabAvMFpG/a85kTzF4z4+UfObL+roSKLKFYIm+SKsxgtPJN8nWQSSlqxFjmyx8G+jdrfNOwf9ekvEoN7KqClAGdADETXuHk9qKnkVIC5b6mxL3Gnqou3Y4gUfs1kGVXPdCTYn9vm/aVpp1TpKnDDswEJbMzEsFjgg5bcp84LrB','system','2016-04-13 18:46:23','system','2024-04-22 14:01:19'),('0ffd8df5-a3bb-4855-88d8-096389e3b42d','7ad62dc6-56e4-57bb-218f-349ed1097ad9','digicertglobalrootg2','digicertglobalrootg2','1',NULL,2048,'R',NULL,'DigiCert Global Root G2','DigiCert Global Root G2','2038-01-15 12:00:00','DF:3C:24:F9:BF:D6:66:76:1B:26:80:73:FE:06:D1:CC:8D:4F:82:A4','E4:A6:8A:C8:54:AC:52:42:46:0A:FD:72:48:1B:2A:44',_binary '*1:PsSgi2Qv0Eo5KWfmr9MGrwSoGTX+lF9Nx3W787rqcoBf9i51gxQ0DTJlEaE9LevhlSzPnve22yH2y08VZtch+L4v7EseGVPLtA7W+/Ae8C9qiGrZV9Glcm6KB9vFqE2O/bT1oQRs86z0sYjZg0MpSCpm8501Qfyaye/3l6le7ZttEDJwJzF2dNJFAopajavG/JVqMXBZpeympK335U0Pzo2KsaVnvqIbF/W/2nvZcQvW7dNfHescKtsDCFcWgCuTtTmKA0yjkREkvzP93aGBhSPGr5iciGmpGugVT8MqJf3LLPx0QNT3uPSaD5On25hc6gxHE/Bkulu5E4GeqtxQQ3Grbhjq1KQCgUW/Px1JuBVaEuDA1h0JfbUHNl/0DsT+Le51gzDKMxcce7OQpQXt0IfOyHLQtvhBknqAfKqAsgnCto8lfanIXwZMtRNyhVRYIPcvZx7kWYimj5U3Fi4y0AshImA3CIkYcl6oVXxzabF9o8S6XGGzLUIDJb+OsDOvUhwV0FF0WHCJV0Ts6dux55aOgErX/OJHGwbMZ2S2I68y6S79kT39+IjAgXMGBix/TPAQM+KAQc2+Kypex5J6mXkUEYTUs/FufEk+i1pZf22EAKP6ZeRs1hidwUzvUuu8G9XMRIRz7A9W/1jNCn8vHUJHBKfok+604jLc9O8Cg1atd9kHgPBe0GcrRQwxPjX0trF21dtKxT8xRPa/ZAsBlF25SE6p7xQ6eSP6rbUtZexRDYrQjet2ETRAoURvvBG4Zs2MdEhWaFuR/2hArXWrODYr0b3UuR0QOgO46ipQKhj3N6/RmD9CRrSmSvJFEQcXsV2aAyVxipGLrsoBNLcDrhQAe12pIq5vmDApR9oBYCxAPL488XPnfpL+MpsTb3z3YT4e+DA5fjPaPVPzR87sUNOW+LKZ+EBpFJ/pWY2h5XHjTdiURgb9TDjcNFoZvvxHKFRw8qmKNG5+PgRpo0l9Iu6+ZSxHzFKpDaBrYZgM4q7iXrkHqin2iZtEfiiI07eKgndLnDKuenvqpAyGgvpkPOLro1zpbfqGst+xC4h0hml6gBq/IBnzNIqTPh4KRuDA4yKgU15lCtm5GiHU4GQANp2HeV8G4PpLsb3EjpaXl7uP7zm3xZ1Sl/FNiMt5/sGoRCh91oNhrbgxscNG39BwQYjZqEoq9bVidhnNrLcgRXH+CfYCeQI4NvrvlXhNSsj2TBOdi/1fdp9gTxUb7mP3fQ==','system','2016-04-13 18:46:29','system','2024-04-22 14:01:19'),('10a31ec5-f667-4323-bc72-97bf7bd61b89','7ad62dc6-56e4-57bb-218f-349ed1097ad9','dtrustclass3ca2ev','dtrustclass3ca2ev','1',NULL,2048,'R',NULL,'D-TRUST Root Class 3 CA 2 EV 2009','D-TRUST Root Class 3 CA 2 EV 2009','2029-11-05 08:50:46','96:C9:1B:0B:95:B4:10:98:42:FA:D0:D8:22:79:FE:60:FA:B9:16:83','AA:C6:43:2C:5E:2D:CD:C4:34:C0:50:4F:11:02:4F:B6',_binary '*1:h07BX2ildM+u9C45975KSSsnLmsZDCfTej2gnB5qN2NL3KRp26Q9JNbcsQd61m2rjkTg6AvVlJVBTwO91h0MdXCZ4OQ95hZq4Gs+4BaRHCxqwZwQE1DKa2mezto8IV/Ll8L5TiKeMqBK4MxgvqPRtIm3vjNgVLPh0NULde5pD2gYx6VlRImsCMrG5QDY3pvZfU1KZcA1HBzTEkmvbi7rO+5zBSkSv5iBrDvpxbg3TUCeaSXR4cwyXIXLC1DnPwDT6fscBdPDGcLmFZeeyeiXhwFbV9EF6RkrsWnwYwZLKOyjg5NnfuIC5ZUD4T39BbKO6GWr6vf0M7boZKfC/M6MpAGdv69DNhEL45dP1HV6chw1oqwOadNGkqZgQ6yCDlh5z4ceuGy4SgYiFbIYEiaNejQetmrNoOisDcKq1rf11R4eGjPvhZ+3i6hMebPBZFD19FxFsQaYwwpB1383KvvlZQnxLS4RppYFZqeFtbaqrnNVZct8uDy3FzXefO0vBj5mHnyh96XNtvuth/5fepC5acRvBu8Bd5x6V++ilIfP117T8qKmLwECdUdqMLOkANC7H/KFuQSv6c7yUxv2qirFm1ThSg5+xQabsR0IQBm5+cup8I/6MOKnQ7w1ks7yl9DnSXkDJ1M/JWreMqM4kceNyLXjFlZHk0+81U5ANWbNuiYqiIISgzFWJcq29V5D+pDhWlh2tIzQIQxrLhC8iKnth8jS2QBnucSSArbGhvyalX6132Kk8vXesbeJTTKmGFFArf14G/DmbunsJtaI1dhPaXwYzZ6lsprY4LfeNqAESxZOovHBSdCKCwDX+nHB77bQoP3arWdfWqxi7QQstUi859bOO+MQ9suVmHr1N0aCpu8Ej4Fen3BD2PswfJXlVL8Gy5wvmhmDKe4uaguJl2tSZZRjfL7AFUrKfiTRygOxolvSJou98W60Gdc4QIXzuov01V3lEb2U1Nkhu8SpS4kFqJaIczyPdv2q+M0NVFbIYr8AKoMXIXSlYTHgr6rw28xgofDci32HWfpmB3f3agFqf0Qd1Tg6OQJ2R1rBSidmtvGUWBBe4z9SXODiTTIeG6eGAp5WWYBAARcUIKRMtkjZf7l/GZpkyf4Lz5U6XJiFU8SUGCXm+PzynroE7E6IPjUkVKDcQ+bF3oTWxPeWTFqDQC6caF5hP1JYDJOgLY+JR/u8KEi5ASp3kGCYslii5Lchmt617iCBKLM9YWTUXE0nfTOad4e+jQE6UVGUoWTme6OujyFbgq3PZf3ZF2FSoTlOvc+9HbPMOIOo901EsvHR+k7xvhF0vsD3D+6ZjLj9PQkQF7e5LoleU5BBhamsBU7GzvCIVlu4mslL600P2DTrkUOOXnFWfkuA8QokQOOexyi2zWPo9vbyVhN2GTaqThQgTInuhA61cx0CFiSYMmbgLHeztTEPU5KqT95Dyd8Kh2R9pmqeXCxFi3NUr8nN/mM6','system','2016-05-10 21:39:04','system','2024-04-22 14:01:19'),('133db14c-aac0-49d4-8eda-f3a0f6f0a838','7ad62dc6-56e4-57bb-218f-349ed1097ad9','godaddyclass2ca','godaddyclass2ca','1',NULL,2048,'R',NULL,'Go Daddy Class 2 Certification Authority','Go Daddy Class 2 Certification Authority','2034-06-29 17:06:20','27:96:BA:E6:3F:18:01:E2:77:26:1B:A0:D7:77:70:02:8F:20:EE:E4','91:DE:06:25:AB:DA:FD:32:17:0C:BB:25:17:2A:84:67',_binary '*1:t2kpm19J7aJ7QjCA+ZsF0WYuyua5eUqxEo/+nNd/+FXSbBKz5gEY6B3kSUhULLsUdYFzCsmIltAlkZh5klMd8qZIBJTwZqzURmd1v/8yXZkc+31WCTYQcxKo+0dnkCRlwy9PuF+wyKEsTb+T31qT/BnNCgn476Qfuz2modwWttD7a1vKhs4dE2zxSimfOJGmzpOX/3tZFZRVequNBvsMAMJ+ALPLqmAgNgPLTGnQZf8VMSD0oSaabYc+HR04cll4alalYAxmGJ86ho8EVC+7+s1eKVvCW574aPem1d2R0fsGNPKDxEL+awCARK3WwZXnAT+7GVptLiP6A/+5RqwN999AiGREbGiwr5VfJPv8pxHkdNy9glhXyd9Vzphq6AyYhfODPjWH2nNt5vXzmZIYuAd/WJKmgAjjit2jrda8VuK7re5+nAl+9MdBqTZBk5RojrTZy4mWX7NiVJn1NytGrKuvyW/H8pstX9bqGmA0ml7JsUGQ/bgZ51vpDQl0w91z2hpPkc7AaBfjdAxnyXiAtD59MdKcM49r4ev2sSiVCouyNwAWpoWLGH+vXmib03DeZch+Dcqjtv9CTL5+L67cl9B1dnjp1WRe85IeBiboODBR+HXRu5nx1xXPvt8F+67f/sDSRr06YpORlB2SGeYyL9NIq4+wfBhc9xZJ6gqyhBrFJoWKg6050iN9kRWbNoIRhSNxr8YKMbVqvvT+/Rrw/Sz7BT4hSXjTYpa3GJDUgWl1pnkfLS3p6FmtnTXQ4aKkGuDQLvcs61zhpbnAohrBN0kSpxUlgEWJvcZHPbG3DG1rR6zdvpdLVPexYX2HAfGE4nFjOqPRAFpKl/r2ntx9eRWbjyuuNvIgBkQooahmcZjAfINTKCwwEUl9lwla7UKFQrE67QzKyEopFDjO7rzjqkV7bHKNVe8xwNWvzyF2ijTyvOZvfdS+RzrE4QhzdhN9IumpV4C1QK4ej79SDGOFgBJZulEYSeAo3blqRazcjNsoEWhVwYz9Txjj1+1EMDNi5tSreIF66fuiiK/tV+Szzwef7L93EcrHAq13hLmGtOJqFM/iU2DTbMuzxo1F2TcANzpZI3J36rJwjtMCSS1I6MYTOLLgk42MEAkhiAukLsCXjv8Aw7WLkN1Y9iRWBRh64P/b8jy4/WUkwE1pZzfDv1+gu++Yg86tX55ugqYqInX7sB837YvPENCrbp6PULjJHTa6czmegvRgNxhRq/oxyhN9ALLpQzt4hUm9M/eQ+xc8vnYe7xPc++VbD+XVob43X/b24QLtqNPLFQATGQalP5PVsyG8ZJ/Ot5eRJkZ2n1nK/n9gxKXBHAWrij01kGRuE7kfvhawswWVqmQDx0xiD1LocIYzzEgAxWoFAEd82DI=','system','2016-04-13 18:46:47','system','2024-04-22 14:01:19'),('1ae87891-2a48-4cc9-ad0a-0027f4bec7b2','7ad62dc6-56e4-57bb-218f-349ed1097ad9','equifaxsecureca','equifaxsecureca','1',NULL,1024,'R',NULL,'Equifax Secure Certificate Authority','Equifax Secure Certificate Authority','2018-08-22 16:41:51','D2:32:09:AD:23:D3:14:23:21:74:E4:0D:7F:9D:62:13:97:86:63:3A','67:CB:9D:C0:13:24:8A:82:9B:B2:17:1E:D1:1B:EC:D4',_binary '*1:kZOhcirknP/u0hAC32kOQ8m8kBM+l7RQ/71fx+DnpVnMvw4TBWvz/xmiVxS7Qm+xdTCmDucsSM01Vtz8lpwe8O52rhBlXN4pIasbQG0ounbKn4zaAQSuVFptiYXb6VQZnwmfKUE2ph1j8eV8gVM4infQQnlDU++WjA8FbJo9gBtDwtMaoAUyDCWCOG1Iw2AqYEjyQJUFYy3gLdZLiBmP8VIBpoO0WWh2dSCiUywLFKqPXdaU8zME+ZT5TEZfZaXt2jl0uuXCo6JG390kCSwlcAYde4Ov7tRDebV1lD7RWG3RAUD0HcGXPRZpIShsPL6RjPNMEUamRV0UkqFKr/L3x/YPtYdCK3yXX33aACevepYfcxNS+MYnl9qnZRB+onMBk5chvqsrersVgUXWEngKz8TVxLlSzNZhZCT+qGPEI8tAIZ8EOZ56UGpiwKBOtNCcpM8jMObrBIlDuz2QkNF2n3PCOkZBJE23WV53XUAFIoVEGwVB9L8nvSpqhD2fmmidfOOX32s2K2bAiNS04JO6wS4f97npTuMLYEnPhjZ+qLuVrQqEJ1yCCZz6gAvC7CR5iWQisGBrY/1BCNQYQ3i88nZyRGrwHY43PQNcaf9vsB4RZc5k7BF530v7ZS6dTR1/7fcOD4+6y1M+Kxhyy97So83SyXvPXPm86gjhG2rW/Q5GE4R0mQAfCW6pZJS1K2SyfsrbHFHkmUWWcqNju8/ioDX2rkimw9sd/NHC5WnvQ/fekiWcWcWtxSKMpAuzde4f4vTBNa3irf4P4GE/SQioNu6Ff0RGpUHc9ALhI5HLpjf/bhiXeZUn6rM585gp0NmNAPEABJi1JBMGbYZRzzny2ujG/kdK5wB94Lwdry51CVLA1p6CVokPstbFV5xpT3wO2AE9As99yIksAqWf6FAnDEABtiZzPWbQmQcw7KfaZyRxVEmGBvGHOyGj23HN+phn6gSS5XCOTCwqlC0bKYt1irYdnmy8fje79KDjdEge6BCbKcIdy1N2gxhZ1nF4s5edKaBBX0r4CugDQooogMQvc4eueKXEJIv0358+i+fU8wBOsfUwymvs1hR7CdaHcDyc','system','2016-04-13 18:46:28','system','2024-04-22 14:01:19'),('1b2d6206-f153-43b0-a006-b8879359112a','7ad62dc6-56e4-57bb-218f-349ed1097ad9','certplusclass3pprimaryca','certplusclass3pprimaryca','1',NULL,2048,'R',NULL,'Class 3P Primary CA','Class 3P Primary CA','2019-07-06 23:59:59','21:6B:2A:29:E6:2A:00:CE:82:01:46:D8:24:41:41:B9:25:11:B2:79','E1:4B:52:73:D7:1B:DB:93:30:E5:BD:E4:09:6E:BE:FB',_binary '*1:OrFobi4Eaukz/9JmxYantCExOc8JGiBFisx36LGCT5SRj5s4vT5UhkNvGg/tyWZq/ScXRVv1rlddUoJHQczs0ACUXsrWeb+w2rsSSH/wAimyZ6aSgq/Ijl+vOLxTKEj5ftAS9n7D3shz1zZ8ViqXx734q2q9WrpUkKz5iKfLJM6lAOY61kJHDV+CHdij9Eytd0+lIHKQdVEIM1gr9iBdwh6dtm5/Y/LB1h84VaAtCTv3Q/XawSjWFDN162CgNRJQC1ZOi88OvqiQGuCElcxdsNTbeMRBbntdsFEFSTt2FoDIqWOmN24fbunSs5PBqNIDyw3NtcjFBhCjFMd4fg8XDmcrGkBGv5+dwwvK3xvtOJwjuZMC486+Hk0HNZq9CTIL5An1FYXhj7J3ddd3J1Jmt4L3JLH1A8WrxQs3SPfhhxsGmPzLiGGqoS9LcY2PI8JGqMgpCBzBhZ6DC1VbQlhvbIig61ZorhB1FdLcwRhC2YZ9W5V27rIOeJv9D/xGpPhE1aKPywOEHDiD2H9H1LxL140duO4CU3+Mj+NS2W++R3oxM7MNpxGQr0HFtvJznsbZItZ0PEAUXjOZH2mPpwQU6FtEDGIIimUxkukqahAa/QsXbKLrBQgLmn7jwgJCP6iH73UB9aAhuYirDa1oHdU70h11ujxBzbkT0eL+ua62Lq2Tp8h6/utWQtrWW1Fpvsc2ZSRegyt2rl2iQtnTwnSHXCjbqp0dT/otKVBARh1cQt0inV6MDfN1hBgy3nJf832uiah88zOZNKDWdAFDTg6lNDMT5pNJzQ4OY5cGUI4lRBU4h9K5l5XED0TUR1002MG/tXJJZrey6VuRs1sJi7f15eiW/TiHX4eM4e0/fkdm/nSpaFDQTblVqMitnjoVx6JW+vRHD/ezhPnTm74m6Tl2CCfaGRE6sIot6cH/mwvJ0fiBmKBJELJwaozNuRW51uCWeGw5fLVTmjNb/FmLJlh0wAUGtA8XfAPDvJEnCx2/nahofvJqqdAEkcRnSFhTVUuxDxEEPhP2+4O98zTTv/kcSH/66iO2wy5DTtLNapPset46aD0tpqtLCTWUu7t4MdSFYq4owA/Tq/Ib1w4mDo+0RplYlXYzFglu2U3GAH6b+V3Uq6s6u8VBNpqcbaVb00mcjevcTgHtyhlgfdtDwWXjXRtgp3MnzCjqWBpN7dozcVYoYKxQjWjBqQ1NyJVPwtxo4xYB3Ex7+LxQYinV0b+URw==','system','2016-04-13 18:46:36','system','2024-04-22 14:01:19'),('1d7755ac-f065-4064-89f1-852557dc0bf7','7ad62dc6-56e4-57bb-218f-349ed1097ad9','affirmtrustcommercialca','affirmtrustcommercialca','1',NULL,2048,'R',NULL,'AffirmTrust Commercial','AffirmTrust Commercial','2030-12-31 14:06:06','F9:B5:B6:32:45:5F:9C:BE:EC:57:5F:80:DC:E9:6E:2C:C7:B2:78:B7','82:92:BA:5B:EF:CD:8A:6F:A6:3D:55:F9:84:F6:D6:B7',_binary '*1:Imr3RjpIX6DnVQRJUehOAet64FLbKE4hgciQtUoe0dKxwzQVlsR4+G56afKNMwX7FiSSGlFyQb+8ZgMaECUCh518Fed+0wOWlO3UuLKf5RmWNOVP2o8Ap7LSvQBsvXcr/YedDvEq2cL24H4S/4dWXS3U/rhjUd+mXGlCKKJleySUpkQTDuNjcI9NE/mdKaTLvdRrrN6TpCeWc9ZEVZczOY7wO8b0wc5c8KouZ+Uasfd337qn0M/o76al0x9aeqxUXa9tydGKkdT7NdP/vbwDD8byA9RyWiQBILla8F/zXxXC4D/t7RfVwD6NDJ3JK6duKGAq9TNAuujfYjLyDRzL6vn2YbmycfQjlqKyHySHjGusN/tqH3/MgFSszJK8kKYiAPW1AjKO1Fqnd+zVBPvwguGc04PU0qj8KJe8RHmcc4aJOZyTwgfJU9w1jnbTL84kWUiffAxtzEtRMM1YoKPI0+41g/E+aaeEjzhCDqM1NylIRnljyL3AfkZG/3Zt7+V7VIRXIPCBgEMOnISp0UN+YVNnd/pyksQSlzjh1yAPC8lIzUD1LxVuajfgP7Dahhs+2/05d31APjcdGbKW43FQMO6o6Iib+SuAsaxnT1yNURK0YVpb+v85oNGPxiiVNBwmMevJ/vA50kHVLSc5jkpRqeebfdizhBXx8Eax67R4MczEOH7FE+U6E/kNZjzbk9zR5Svx4aM9tdczfCjVbiXFPLXQuEPMYqxW39cp40SkOPlqxolUBMIetPZ+4u4BvGQhrZQMJfz9bRoWwNQU8YZrcgYgMQRFe/mPlzT9CmTAupRgkLKa405mczvnbyJZoQGCU98yddsbhLVk4lXW3Gi82PG16bAqLlyem+Ci0Pq3Zy4uJGDRH9NzrOxdsBzQT4wFcqW3vg21D0vQvUgiwvUR5ndsJJMtYfJbvJuxEHvl5j690Vl5S/lCyV1F2l6mrDiQAf/SiB8B8zW3CroxCth5Hr7J+Bzj0YVhkc7mB5JJq4NKqzdHijFv0iDw65m6QMDggPcbPeRi0MJQqNG0rEX8ZVY8xKHn3+K2dNa5wXAZS9u0WSMbrjQzBGYK8VDgUQyhVZVW41cOtNtgNJNO8zah1WJiZ4aKM5CYgYUfpaefv36WS/RLsoDRURcqUsigr8xd','system','2016-04-13 18:46:38','system','2024-04-22 14:01:19'),('20f26295-6e64-43fe-9a93-0300abae5071','7ad62dc6-56e4-57bb-218f-349ed1097ad9','letsencryptisrgx1','letsencryptisrgx1','1',NULL,4096,'R',NULL,'ISRG Root X1','ISRG Root X1','2035-06-04 11:04:38','CA:BD:2A:79:A1:07:6A:31:F2:1D:25:36:35:CB:03:9D:43:29:A5:E8','0C:D2:F9:E0:DA:17:73:E9:ED:86:4D:A5:E3:70:E7:4E',_binary '*1:o65MpG6S0RFcZKZzW3wIAGVYpzBvJfStNziswI875xEagLLhRJv3tlM8Gd+XpFETODe2jmRDsTm6si/aAxwT9hFH0hnYpPuNfqhHEoC11bVxE2H1pTn3MxxzEJpZHGkjncujDac8KRU21Yxkta95Zu1F5h3KdhyWTNNyWmGlugW9tLkJE1wmMzwkvfRaejKWjmiNoIj4nb11lLjWWQ4MqN6VCVPr2sHx1Hp9RzcQZKhpfRQJ0vSqoP39PuhHhad4YP66L/6ewe6ZkYCELMuRk+ADqxfKBLQcPgrjearw85Da+98fQuoret0d3MivKKCa0MpsQ5mUPlGdP3+D5MMydFAV1MMZ6IxFVpXud/WX5B5uWHAbT+xYpGyvYlPvINFLkJKlZNatELVONGPWTri1LCBC/Mm+CDb3Yl9hncTNsz4x8e5aax4Z78dzXv80nOeNpBteuvU6bsqcMT4Cudnb0RpCcZxVJI7rfU5fxW5u7yIqdGqtGnRV0yIZDZSsCgTE5OOSe+n+SC1aO6KkukRnAILqQg8TRKXbuD/skgPD5YL+r35ty0+4t8SN0lt/VFr2IVXdhJ23lMh4fttKttW6zVZ+ZJYdPbpG9XAL2ARpvUcEN7sVUd08dK1WHQSEBWm+La/hawHBYL/a82bYeX2F8u1o+Kot2APbEMQYPHNQ/LBVkuU5R8JK71KQVmUXT69+ohFMU9H1CA1wFtKo41iNDFeE21V6l8VjzByejQrO5p2CxgpFb95cgCY+lnl3C2IvI3RPcr8upEBUq3cBXYSwG5DPXDmyOLMCm/M41Z7DhOY45lmwsWAGGgPJbHqiEvjVe1M6dO2eyfA86GY1vG5PjN7kOZp3p3qrHG3pw7+vm3at+FdsFGTxOVlXI3HNB0LVCK5zXtGjeSaXekxa/prpXDLhlYbSK8b9GuitDyLZxG19iEBAoLJGfwr+r7rvoJC7LPar2Lrn0x0hUNC96GO+ETr776oISTDYpzVEzldvrIr62gsnGRTSLrEOHJ6mNWo+geaj1Hw+tv6/pgX+1hfzktUaZ3fkYkxEfBKd6/FKIy9TOlzrqCHugKErQv4DpsYqYXy1pbTVUjFe7Fw2k8zJ+Ge/0gYIloTFW+9qCMdlVXO2CDYfZDt+T4z1zFkTZ1Ch9yl1fT0FTsEvOlVxoN3EKMOFIMzj8pCQpmLnh1ucJqPrfqKfOlbfP9aXgCC24CoAyb8PP3feszhKrSB/3QGMY7m50goKNHX4NyR/gmlpK/D2d4m9HU/3qf0rFTKu/9Z7Hp051l7Vg2FD/BZZaJjJytLLYq4NadB04UFSVsmlOuJmpv93SADeXN2Zk57+Ib9aJrOIffh9MwhUoJEpQF4MWmlRPs909XFT9Vh1Ii3l0NgC4UwivVNG9bztum48GiiEX7JsACbGCnJw/w1vAnkEjipSZxSEWMu//j9roFKB6S7CQ2q6dt4JnNmmUtHCd2GOemxFpl6GpEzAM0JfW1wlxbS0u5rAczceppbZxxDafs6SWtLrr+c0PqHPq8/JBOgFw/9Yho/BmK52mYV5KTBPuqjnZ6SyTHZoX+kdmfDoLeVkd20jYeRmL2NnsNL592gInbRmv0f3k2YkFAmMDv34LSRYBIzPD1rUAedZlG/z8uuZtAsTXmNhjcKSGagI+hE5bpFrguGbix5s62JdQiZLFpzh080Ht85CV8B7+NtbvB/inw4IPibLwGjSnmyoQBrblhNw2YPFAc2iYjz2GWQqrzUnXL2V7L+mgTbdG7SHT0jPMPEsKGMN8OXj9SL3G0o7HKcEDc+cSCN6kpc5N3NSvD8h2atjhR597eT+5XCmvBf3WJiZCfOcVXeRh7LkJxX9','system','2017-05-17 21:48:31','system','2024-04-22 14:01:19'),('234a71a5-7643-42a7-bb2a-dbd1e4cc1d9d','7ad62dc6-56e4-57bb-218f-349ed1097ad9','gtecybertrustglobalca','gtecybertrustglobalca','1',NULL,1024,'R',NULL,'GTE CyberTrust Global Root','GTE CyberTrust Global Root','2018-08-13 23:59:00','97:81:79:50:D8:1C:96:70:CC:34:D8:09:CF:79:44:31:36:7E:F4:74','CA:3D:D3:68:F1:03:5C:D0:32:FA:B8:2B:59:E8:5A:DB',_binary '*1:ZX/FT9D4jkfkPbmhFiz8QFxSzBeQ4kOiC6JrdpZRtg2Geb9RjKWhRH79IMpwRFZHSGDWgYdFGdSKKQXynIkHDl6O/PI7wZWxNvozlJbxT9CeBaFVVZKHkgYMr06OpPT+UGBB03VT/6LtkdGaxmJOVMKR70xYw73PiGPBFTqXYp2if81Vm0s7p+g1Yfyo4JGeZDJwhFu/dBa7xaEh03xBVjQ7XIio0JFg5fVowu6DTkxZcWl2yMmePPuvhClQjVut8RZ8C4mNn4hTad0vaWN7xgFoacetdcewOwhYzwmVANbwicHxnHF0Kkm12ZBCnZHh5UuXtW1p74u8r3nd1GLwgYl2d4zq1+adFPYRwjfgKUOh2y4ZwijBm3Y5xDo0e0RjQ6XDUkw57l6WIEHntG13oPjaP24aMR7biF6qRondck5xLASI0X1G6AoAkgCikZKx1OnfAECTHiEYTX7Fc9rM0xncD9Xw4qd7ejt/wtQ83Um0E+OsAcUP8HsKzEDm9Q8V1pNXKYN8WpTzSMbTvf7Pxc3AX4lCpmt1xaApHV6ZeTCnXnLFAY9AjvzUNpO2VOwTRKGYm3Rz4edZkPxNBueEnS1lE7oXtQ+JVcrWAZ8gG0WyI1N4DaMt2z1Hdbrx43y/RokFooAu9lrmSrWqTYmZQmV2uJfb61sEswTVoyNNFLTl98F1ZKOmytKjwpn8HnF0gFJ6JlDHjTCk9h/mpvAylZsKkhQtZEksv8J+NuGyKdX6kU6S2ncmm3HIc5iD0Tr0CpiPInR1ShYz/Nzsmo0Mfi3PaZ06ibecRb71qtJeGz4=','system','2016-04-13 18:46:38','system','2024-04-22 14:01:19'),('25d630fc-8f97-4f58-933a-c2e9705c6301','7ad62dc6-56e4-57bb-218f-349ed1097ad9','thawtepremiumserverca','thawtepremiumserverca','1',NULL,1024,'R',NULL,'Thawte Premium Server CA','Thawte Premium Server CA','2021-01-01 23:59:59','E0:AB:05:94:20:72:54:93:05:60:62:02:36:70:F7:CD:2E:FC:66:66','A6:6B:60:90:23:9B:3F:2D:BB:98:6F:D6:A7:19:0D:46',_binary '*1:sQlLCFLIXqSB3HWkLxZVMEdvZqsq3Fx7+2fdnGVluvpbrgspCHegToCzlvbsn3fxvLwH3EygMnuBY7lRRtnJEYG1rRpRS+58MxH9cBM51mLge1MEa8BXcEik828XRC6TsR5ogy8ACZmmQ60LKPbk48RS5KEJxjdhXEfaeLDSskFZRqaTnbUe/9lfKz1wgqUhbgJNEaWz/IHsn7pFTHNIFkgWtwgmuGFFVn4LT1Q283YZ50s7tzkvTaAEUdsrHxtvilUVxorXdgZVlL7M45rzN4S9I9CS1OChdF3LRZifbEcv+rUjYxjLqEXUEfLWunaB7Q4H+U0I8ZIkF1PowpNbLXhPAsU3CB0XPdOJ/Kg242+I6NIoknB8k1w0bOvlhmerEFV/MYJzBjJnK8hfgQwaDi5QLHL621xowWmTkymNkgrcH6Me3/5u1exp5TJTFqS2rPQ8ozXN0EufxdIHHsdSoFD7+YQJZIdTQZctQSjG3ikAFm+AZSgmYxk39MaXiTqISsSmDCMfYIWf7b3Frnd6vXRPGoTiM/PhJCSyXCf5ViPrKv8QzV7BAOe+FGEDa12Law20WxMEvkapxQUoaiLgkKHQxFsAkmfZlEi7kYYdgZlxXLvDzodLa0b4IxwHnkQbFSFJJ6x1tP5dp3H2nle9hXrNlkNJKsRSZDxit+to/9xyaKIIJRWNNIuL/oJ7nK1KexObLumyQNaBOU3EYGxGNJtHT2Q/8fcKXwsS6B+9C9qAfgQx56JzpBdd06W/HQVoUYQr3VDDuVkTNz2NXsjYlMS2D35mELkzvOZT/q8VDEX71Nymt6KSYS36Xt9vurCHqjnRNfqmM9D9RAFI+63zFwvR8l548TkOvsWv0XofWvTR1z7GKa7Yt67I6fguqNPPeArAQFIOZWOdoQQYahnjmbNfq73SGfP0xfMffcqeBWN2sYG1hidGgYqFGzx1y3ow4Ve90uTrUzgQ1kBIdmiTPrROQOihlpsbsYZxTT634gnxpZRU7Kl9vd/jRstocn6957cnhWCm0aVOfVWqmpUXh+vNKSr4Q7ogURfbsAGWDg2hiNnbF0o2gw7oM+Z46CceBNb4Il5AG3EvnTV5uBlTlg==','system','2016-04-13 18:46:24','system','2024-04-22 14:01:19'),('29572da6-bfc9-4115-8c1f-f036be2d03b8','7ad62dc6-56e4-57bb-218f-349ed1097ad9','camerfirmachambersca','camerfirmachambersca','1',NULL,4096,'R',NULL,'Chambers of Commerce Root - 2008','Chambers of Commerce Root - 2008','2038-07-31 12:29:50','78:6A:74:AC:76:AB:14:7F:9C:6A:30:50:BA:9E:A8:7E:FE:9A:CE:3C','5E:80:9E:84:5A:0E:65:0B:17:02:F3:55:18:2A:3E:D7',_binary '*1:9hznjII0ISZZZTo6CGvlcbnOCgx1sz9lNcshAYRcA0qI2U3IlxOQdb7B+/2lQfkqtzxJKS722r5mm6rnE32T5B80C/KMF+PLY/vigyEqLO4efF5Xt++Y9XkvozbeCf4k5mRlABS6uQ0C4iTUcFppJ7t/LOoOVNJ0wd9iEFcLpTXhQ0fmtamvLQ1XIWtWm9oVNOiRMPHBbQMG/u4nB0xQXWy3W27v+Fpp8tKt8QBUBLWU8q3ZBNih/kC3aSIIb/eiKbL4/duDOIEy0JoXLJBj4cf9QmxHOaMpdaDaoNy5IbF0xGD9d0dtyIZwgY/RwqOBxolAztYopls6zQfuhB+0pxKLdAE1b/xX/z7qG2DdTIee8Jfl6ZviFgufCzC0cnCpW4l/1fahpcJtUvs1suWrntpRo6AH+AWc4XMYtyr9+Kbb1FO5h3EOIsUmshmUfinnKkz1paUtrkAab0n9Xx4UVyfQXsWS0VEeO6G7+5dhMl2ieSS7YHgP9VGCHiOLXRIvF+XSW22m9FvNQIbd8TSJPpmAtqeQDx3WxWfPxB6hDEjOashqL3U+davgf4xGrUfLtpn2H6uDZmQgb2C6WqZHLUJtYTYL75x94jVwxrJO2FSTrUl+dElacIjOpOFOcShLooBaEYjSSId8bFeNoWz8/A2JgZbaj5718fvNhQiQ+TZ7M1lZVcwjWxR99HMPWRcDIXyFkrzy5X12eztm6O8UVLb2ysac1UDP/ybCsQJzAeLsGfJzzbxkujogm/Jl3qZhkRgdJKOQ55nC3z10Gj5D1S7emoTOy3RttiRf4h4iefD76Bj4Zimk1mpvhKy8QE9DVZ+HB2b+gI8ugys2vXV9+oQEMJF2zEhC0almFOX5p+w5+Nym8x40ICr/u0V76qYkybXrg1W+O6/N4ORWRLFJimVG1Nwxsj1Pvi24+oMgMyehbFrpYhAo1BzzSjnBlA7ULUtFGZLPUueTsxBQqObou+l/tNttO/4Cl+SYJceRijluQRaDtP2koqi+uRkoASoObgUfD1xw+LrPnK2Cc/w6tB6Fnjq5H/bEdNCMztsM0JDVXzU7Jp5gU09JpO2KCr9cwcehVwPHUJNLhB2CsIlQpQn/+lzunF/o6avMjR7oag0AUtOLyZrB5If7NO+0VWWgRuvTrcUALW5CIMeZ/lwS2vcXlf2WjqOpp0zGBGA9Fb/faRmw7laGsc7S2mB71tgZoOM1t5xZKkcekSDTVeB4gOuwCjVKoKNefgiC/C+e6LCMK/7Qcd5ztCUlbxApWMZh4qYWPwIj8I/K4MIlgMXm3oG0B3eoI/p9ySi8r810/lsDw0ho8WrCKMGU0wWvRptCItWGgYzV54EyjDCmn3BHACEZNsedYP3OpqUmECN1SIw5dkNnutx8Hw4WhVAYCS9BgfSnHyJcuaJN0qPk3tPeKincTCgWS3KfPj1EznnVlyEGLivRc+yZMFgL/tfZHI64jq3dt81VTGTDmA2osemsKCm9kQqjNjVlhgEeR74YUD8I4R0nddQyAQfj2ytbqTLYXcEbJ9NwIo6hBUSHJepTCbhsCPqaEcVrFO4+t4zDrMhJs5GIghio2J9IxshBMDeFpliHD2sYylagH86hQxd+HcwxN60jvxHgjauFM6alk38AuW8SQ53o9wUCDzni56bBli1sEmYZQJEHkQOQsLilhqW1rAoUbeE5PsS09db/54jQNjCt0znAICljZEvEi5m0XLo1KSukyGB1HSRCL6qCh5bOLfpyPQeKIIFSQQ0tlcEzW6zSFhwy2VEIDi0Lkf973mctOsDC0LJYP3EGFabCgHtwwRMXFOI7lCOyK5BHHEABBJTotgFeOgeUKbEZ9xugA1rc+3Lk0gKSiIGv9ApXLyrXiAvnQfNU3bQ/Rbjv5VU28GISyMQL2+9GTsCraK1dbyCdhryed3TPOulzBvgXc0630zU/ghxEirQHlbbDrRHssmIXsUYVK/GR0iWTeCcre+s9sBW1Tz8RBaVuLVN3mgMeUMjqAQZtBriw7siySp6DrpV1FmJwDX9WQ4Eau7OYW6tLgo+QC1efvhCSpT6rPKOG2MjHOdw7/mnk7o2inYehApgkH642aS+Ee5WxRyqoxDWqWKghQMeJIESuh89JpSziYKN9cjLL1ZQU1BvrnS4xpVHvEwQ5aRVNC3D0FIIlk69q9bFGpNEh0v/7g2W3Lgtv3tbvZvIgyAD5BgwJq3MhpcewQJfSqbjG5h+jswojIn9oNHdMaqjwroZU5ssqkxLgJ57KNxRimowEKYb2aWko6pjQ7k2Y5wRNxXmgdo/FSdTFuAkuMnlyDP5WEufKCiUI1nAYYg9Kaynv9q1hj9nY0DcBEv8T29whFkwgifhtr7NtucXwHT9vBm3vVWnxpjKrHyuwU7XSTSSftknR0hXg1ipoDeslgx9uNaqFjdaa8Zql5BzBa1jJoZRzcskKfJDieD6hvUzBUteFC56KOjMXSY6obQj9RPJ6CFVoFiBejn0A7g6ZE4KBHY35venZdw==','system','2016-04-13 18:46:47','system','2024-04-22 14:01:19'),('2eb61dd0-0c96-45ba-8f1a-8fd6a0c049c7','7ad62dc6-56e4-57bb-218f-349ed1097ad9','camerfirmachamberscommerceca','camerfirmachamberscommerceca','1',NULL,2048,'R',NULL,'Chambers of Commerce Root','Chambers of Commerce Root','2037-09-30 16:13:44','6E:3A:55:A4:19:0C:19:5C:93:84:3C:C0:DB:72:2E:31:30:61:F0:B1','B0:01:EE:14:D9:AF:29:18:94:76:8E:F1:69:33:2A:84',_binary '*1:AGte9DEG/iBB1Vpvm5x7pzH/8J24Bow1Vau3uBPgoyX1T8CQ/Df1YwyEz4rhgxy1rhO2eVrUTrlExqE6zzF5pW4+BK50uQX3QggLr1Tz9QcklsvlgxIQo0rw1nLlA7KFtukdyWNUHPVlQ2bp/MBV5FRXTMUHhd3YjJ0nRlF7NTxhjh204WS3kJyFJtofVFw1SKKY0vN0IIS3YA5w57VlP1u38ftCcNnA6w0kU0rx1JWHlIEXbRmLNe4JiBmjTyPXe3s5vHsC8bomaGVXC1Xu3gXeVYAw/YmukUWYjigxSup7PBlX3Ear43ZSRgRMedh1PJ/t5n7zxZQLO0zJe9ReUpDALJF4rppMw8cogxBEcdLVIkR00NTIBhsPMI+2OWTPG3KnTyqC/oT+uhtFgpxEoVScD51tVgu50K6sOf1qocaCjJydRvtmrkyDjEa2tQf396qLvhk9QQx+H8lFMga2U9HQEdcuOvwAYAqIZMHmyEBj7UTpAK6suJoPDiJvHIWVVK5QlcOyETTgbc8xe+r04ihBtcEL5/ATrY/j1LuWHxorOn3VBuGBs95S48jaPFsMfGAceFtx8sGr6jJ/At1md/uCfXLsjMQSvL3lb4qhaJWtwk6iG55y9uA38qfPYyPKZczPLVKWxEOaB7w6ZB46Syw2YJeGV5qqL28SJk0OoGBiN7/fEq1TsZCxV1vVPiVblON+hPsCYKhljKuhWxWOt3pPte9VSz7d+DhKEddFfqGFVq6geyLecEWQJN7nbwQwFPdB0nEPz8n5cPZfE/RaFBmAmDordMjUl7V45yOTUiaC4/E8SxtjRYGhuP+kzU+hICQwM6EQmt+uJPLke3nznN1omV7atFGP6q2dzn6YgZsTwHjAATT+/bMwwUa7JZI+h1u5xDBysuQqLq4IC/hldVNuToxi4nkgSLssDUDxYMz7oIoPZGwAEUn+wspwSp4MXy9HwEfqp16zQ89xjQuSWS0S4qAqVC4yLxPFCPpaWK/l2wYu7Cc+P1TFwz/S/LwksA92aKm5dxI2M6iCy2EbLIDkZu33mHaDEzyDsuMMADev9vP87iZkrk/RjFQRHah6e0hoUSqE9KB8T+m31Y5LrMH+a5l/jsgvvlExJF18pY7LSGk1gFsgdjPZz+jhhToBtV79FjRPqXhZvS8MNJH7q5nBPAov//eE/9qkZdMLk/0QiAQnHbGYb47XZgSsJz4xk3N+JoH0CAlatD5KMHAMmBsRDsG3O7IQKhKRuIFKMG+Ax0fe49jzxh3iqWFfunHtuH6No0qyEznsoA0Gzul3bAG92vutkvMZTOQPUk9cY24e9ejeUA4dbg4d0AzH0Q68KcXhC95vjtAip2zBL8vObxThBugzSXgx3LEdKUNEv538/e5BY4iZMQgQmMNihCYkpAAxEFPZvl0Svgw1qNyWXdkPCAYzDX/4gA/QvECOPA9Gjg/2V12Db2bEHKn/vYgTuzc4X19AU5bxrrHAmuUQnsroNRBoJZQay6XM4tw0QVNho1UVghYuPDrQdWsOv6A4bHdIvof2WM7QjsfKgY+9S4HsKjv2jNHwLGOiFaSdLkjhXFQNdKn9ZhipRLMOlHfThesQ+xpHS1AdS7Sh6G7bCi0rreYXZTTXFvkV3/o0O4c=','system','2016-04-13 18:46:34','system','2024-04-22 14:01:19'),('332032ca-49ce-4cd0-afed-3bd28e2a3f21','7ad62dc6-56e4-57bb-218f-349ed1097ad9','swisssignsilverg2ca','swisssignsilverg2ca','1',NULL,4096,'R',NULL,'SwissSign Silver CA - G2','SwissSign Silver CA - G2','2036-10-25 08:32:46','9B:AA:E5:9F:56:EE:21:CB:43:5A:BE:25:93:DF:A7:F0:40:D1:1D:CB','E0:06:A1:C9:7D:CF:C9:FC:0D:C0:56:75:96:D8:62:13',_binary '*1:DeUmquOx2qtezaUQ54YdUb/vDJhvljKh6i2gWj1KGdSyRYAm8ynHTGS2lRAtcxSf7rIGUfuO+PHdfQ1+6Kh2PI+UhyAARdk94WR/PHgmlcgRGo/t3wHE+Gtt59zapFLQVSak34VUghgL/N4bdUIfQWMgD3tLnXWH+0GaUHtB1UTJNgbzygoTxaj7tdALWLmS4B3Ic7+JUDQBIHlVA6sXAK69ubFoGspq7UsviCYajIWIwmsCuinhpR8ZppIkxhiscxlnD8cLloR5BQz0Z5fHkhYnpIINYssvO9a4/ZX3fs7npcHmswbGym8+D4sYS5neVJNd9XSb/ak/yQkYvTWiYSrjEkImGjAWiC7obLrQRZliPQMRj1xixNlBsiQWoVntb/ft0hunj5UV3qNoafr7RKvhdsPyZqDfPTOBTHhbsHnmUHGqG+FJhjV6JZmKo7avtjrVERcPbG5MzLIko2Au0jGQFCxuqyUZlUPN7pz01a5MKnGF9k4Lr2b6eBxpmJ7kTuDFcvbvpOXqtilnDL4rIyuhaQhThnyRkXaICyWyPsZSvOipG6ysJAhN6eIlDyzct9rEuylaeOyHRFjX2cOtmtiK0LbRpHW5rPkFfYV3MCDM0YhL0RgAHXW0mHzhreMCm29deanlY8Y4XXq7YdSYwYCM5SJZus/OR42PgUkG8fNm8ecMo8ed8E7WtejBbU/7S9g7bDjeO6pKti9kpyeas9cQosIOozjx54kZIH1dXm5k1tbv+gWi5kh/sZv4I1smv6nQphusW9unzqCQHVFOkngqw0CgI32Pkr426YbA5/XnfhZS4n3wvw2nVO+I53epYEgkJ9xGAbaUrXWyvLw5M6W98oA1ts/QKPd6hxUDYZO+LraOgCEhLjLjNAQSnd1pL9fs/hkFDxyOAdPvgToyJiFK0vXrqJAq0g+8N59lY0wPxFQJ4bFhGyuXY3x3zHOW4vOyxTonVkZvUHpXfZEzApOy9U1a5ZC4c8UuNJOAbo4TEI4J9LmOufDn1ax5aweQkLV0W+zZPArE0FU8yWpZljM926gVai1lPl5FbGFk4u/ZcKDU4ih59/sThc9/A/6h5hqBSD9AGgAxalKmgNTz1n2jWPK3sLiYMgKWbt5HC8AUYSaC1iN044U+Tg19ybB1im7CNY2wIyCGbrZPl6CX347+ADM44h9miS51/bx52EFYVKKMM104ZEUwKIbSU520+lRimDWuCrutq1sKS317GIiFPq+IiKdUeBr2juT+SIviFy66bPUn4V1mkGFaP+2DP8H2GWHJjYbRQTsB+GGKAWiPMwz5TYcpq5H4mwO9C0EWO4KSn9HA1Ge4ODKkfPdGVG0gtGL7avezkDFgdQGk6eEUD7TwbpfdB/p2lU48WyJrAS7ovDpBmmLWxuGwYW36l4vqNe5dmnLNz9DOTOLtUVSKPMqzQohI+80v2VNUG2+uMEDE4MooZZSGIYkdtvkXXYrufckZSYEs46GBT3MtbHiZHL5OFBJr5yQkf6zeNojjv08XbilpoQnMWzL304dMaRjQBXs5nsnH9+friPSiic+jOnjS0eLGNis3K0UVCxiaeAolgBbiJKwkAKXm2m7eiqzpHeiLqJKfC8xj//OeWoS9qkaKvg+IkxpqQ9JoMDc3guB2GkG8N6B9Rh6QzcWX8kCJLKl8MSXDFCbtbbKbsaqJpf7Plp3wyZEgNuIGXjb6DLswcz7nYp/Ukp1fZnsLePR6RPOpeJwkdtTqhe2ULOhz+B5H6tHa+CvCUO/BFOXAkvUYPnWMMoePkGHpdOrctaQwDcQCmKETFV70YhGfmd+6ouU1TXABj8w7bzoh+hHBGa0ATkt145mi7HHIDMHs9mvkVEBFS4xkfSYnP2lGHirhN0dQeRsafiGyPRuReOLtFHXC3cRo6uondr+KqIoCiM+dEvo/hbYpS7BvTKZn6RJiLN3b9BL3CMTc7h7rAw3k6wUqdrXNGhWo+cmmmGY2','system','2016-04-13 18:46:24','system','2024-04-22 14:01:19'),('33cbb50a-4ca7-499a-89b4-57ad1631da0c','7ad62dc6-56e4-57bb-218f-349ed1097ad9','globalsignca','globalsignca','1',NULL,2048,'R',NULL,'GlobalSign Root CA','GlobalSign Root CA','2028-01-28 12:00:00','B1:BC:96:8B:D4:F4:9D:62:2A:A8:9A:81:F2:15:01:52:A4:1D:82:9C','3E:45:52:15:09:51:92:E1:B7:5D:37:9F:B1:87:29:8A',_binary '*1:6+xWMFTTq1d6Gt/ow3MyvKYEEyafbAHJP/o27XHu9schWxbklYZtKVSU33A0O6NbTkm9s1RxSs9KmwpB8d7vXRxWdFI6DONMlgAdh+ec7+wyuiqOBZzKih96XxYcEY+X6l7zdnOkobDJxAl7QLjJ5Ntz6LekuS3DWYnIwTL00fpgzzZG5N/8HeLgLQ71Fz9Oc+by0DCQJ2kSoz4l1GLcZsK2FiqWszOMZb5bHhicw6wMr8+4Uu2LdEFH9yc5BoFm3pWJWmDtGkxr0boWslsZlcdMfaAoB1oEoXkqcviqX2+Qz9Oks/7rmmHqxWbVl2kESQbtz9Z7S8Szcm3ZDcJUMhcclppBcVFEhIKFBOfIKW4rs2Xp/9OFVRo9vlUmAE9claonTl8XZut4q0ix+W2V3VCMEwBWKod15D15v///HWz/Hkyi7qxfv6LFfkTJ6qbno3anR3a1UPSAtuwhWdA9rpAyUBc6iOxqyrdXgfOWkkP+O+8eQ6GWQR1zfHeJoWtf/8j0D+u+VJNf2X1QtJbQQxwUW+iUmHVKitVrG7FWCmBQa/uCrUOUByjqK/guv97+KWjRw3QFRe5j6JrP7pVynRajZ6iEe++Zm0azFVMxm6TWf0hQOP70vYz6SeMKX5wJo1Y5p2/jArqigrZaTm2JMrJR0KZgz4jL8zA3MP+RVmw05W/P++LCImGVQxygD1l4xe0shVFB96IhCemVWXuMmgyEplerEr6hXzlitBX6zmqSt7HGdVxPzqkBkW6PgxpJnAuspVP/qTMMXqsOgx+IinpjKwqNrpD1nNebkBbKU8tAGwemsU6bsmIQE4+KvfOXPazSowdHc9ce5zIwh8lVJDkPMDWbxQUfF8xX/juCkRd5KcYPW2RIHwLHl+eNmQBkXtEJDoq0+WhXhsEUjptygMaTidgMp6VvNY3PZVqGC8g/oAIdU1LqxIp1VpbzsUirHpX5aM+olk9dQfClZRp9/93Cpet/EHfZxkfkqMSsRym10NWazlv0v3MNaH2U3wRijxwdmB3LsAsInU4I/6dw9zkUkhZ+c1MAc0AwBsUGZGljhO//bJa+ImvrpN4MfguDMU5KFpYpFA6NqocyQCsscKzc0IPDTM/N6OGiobuQMT3lQfiJQ8ZksIr3i+zRBHBRrHTH/RD7g5/MdGRt3/XIDT5zJc4ly4Z8g6ciH+yfUT4=','system','2016-04-13 18:46:40','system','2024-04-22 14:01:19'),('3651ef36-5298-4bb0-beac-b92b85d1e6ee','7ad62dc6-56e4-57bb-218f-349ed1097ad9','deutschetelekomrootca2','deutschetelekomrootca2','1',NULL,2048,'R',NULL,'Deutsche Telekom Root CA 2','Deutsche Telekom Root CA 2','2019-07-09 23:59:00','85:A4:08:C0:9C:19:3E:5D:51:58:7D:CD:D6:13:30:FD:8C:DE:37:BF','74:01:4A:91:B1:08:C4:58:CE:47:CD:F0:DD:11:53:08',_binary '*1:UbozE+67E9IVbBuGG2eA8JodG5ffjPREfeT5Qxb8sx9rsqZlbbkBW6DsreqEtU3lIuO9Lu22Dn60L0F2l/a28T1CihmFWjNPtKwM5o+NM9/2FL+1Ale2MIvqEehDzjsKISIdHH7I1t3i1RvNC9lgnuow+h0tjf76jv2MgKQ+dEGTSQPYoTEVcsHX6xs4q0d2B++ONBqz8y9Mga3X5Weln0HDjVOwfblvMyHdxPpSJ+VR8cObhKPbIDQajZVIQG+gQon82hZLmI9NG6qSH+8FW3YnS/0oz1tfmmuB/n7tm40ip5aUNfwzL6E/dgA3gqQCo2Bpfe4u4CXwC4j5qPQxRT1hCg8AvLb06kj1+LuLB621w0hSW91zV4buv0g756dvzj8waXLhuwhO703hQZs1DkuBhKjGMh49hkego86FJhdgJpakYiPfpWbXe7ovm2zKFMzzImPKTMpXk9fWk9H56v8pTxVoRmM4LbTmREy0eGn/I4Gvt2N4JiB7h7/JAZUl/+iAHRUydFFufNzdQIA4TWhynU8tgslmTTEYna0M1ISzfbBc0lkx+I31DJZBjVioK7qS1tEsSl9G3Ml7ZRkPOTmmcPufLEKd+tRYH5uZDo/IFcrUJd3M/oMNm9Wih66EglT+zyvRO/1hTExjS9uixdjbOfi3isWVocKbH2HykZDZjb+l4BnpvixfrpfZhd2MOJ7SKoH3/60ZOF9qnV97nEjmpmXhV1Of0ZbI4OOds0kR4SE8hBMq7CIFKpCwqTJ13KP3TYiMhsxM1xkn9ot5FoTyQMpsxUDhDVvoYzaig4vaHWNOEUWPBhcAhz5vwgILTIaoPVvkUlufWXMEj7PUkkwEsWEwlTEwHIGq5ljMGe9HWZpyMf5xDhGbBHrHNUZ30V/uDxzWP27Sygd0fgcX9ECD21EYuMLJx+hmyPHo16cY5sm0PN50VUUxM6MUtYD+8q9DCh6FmK8nozCBLjHgtWmaOwzzuiK10OeKSfg9p6C7qONmYKRGHme7nGrJuXno9w1lpXi2pWw0c8ec49K4OAmv5nk0+aw4sjcHikUGUCEfCk3bGE+sP8QhcnZp+WYTZpisnNo0AEEE8hox7jMmgFLcQBi1MEms5ITHDLZW0HRHF56gJsiMldfvOQxn1WJMcIVHsktCYTsk14PR+0QblUFZuskmYAdb+oWmbAHd1CaDHw/eWVe10QToOliKEsYqoeXGDadrMBjkwAwX61NQ5yYuEAF66paAnDUuE5sCHuA=','system','2016-04-13 18:46:31','system','2024-04-22 14:01:19'),('3d59cb25-af9b-448c-8c3e-5faa99db3d05','7ad62dc6-56e4-57bb-218f-349ed1097ad9','quovadisrootca2g3','quovadisrootca2g3','1',NULL,4096,'R',NULL,'QuoVadis Root CA 2 G3','QuoVadis Root CA 2 G3','2042-01-12 18:59:32','09:3C:61:F3:8B:8B:DC:7D:55:DF:75:38:02:05:00:E1:25:F5:C8:36','AF:0C:86:6E:BF:40:2D:7F:0B:3E:12:50:BA:12:3D:06',_binary '*1:tiyh1HfMusf+WXzN2hIFnRh0M+S1hZ+ecTnqhU4i1tGFNcBmYyBnGUw+2w0fAzqFH+Fis6uH+J3u/iicj7McaERppcN7SwCs97x2may5a3xz7tQmmk8NKHGHL5fenK4hI0CGRmC6puxHBh1wIDsvr7Zd/qgUQZ0wCS2W37sz6cuwhA2rNGqSq8y25wZHbVVVZGsSxOT/UB698fAx9Wm8LMU8NCT0K/4uy6M7dyPf9KIC+BXVajSXjVbzuNKL/4+T+NH6Xitb7nWNXr7oGtlowYBW21oYP4/5YzJtJ4J+yr3LcxiFM9O11CCkMTZ4Uk04AYroDbb8Bvry5wgw9wAl4OQhT5k0GK30yRhLvHGMaLpakPdhYmNf8UZWQpJVza7smiToY4Pcc0kZ6fe1QqmhmLPaBtrJooEzvwcgsmEyzumRCnh1uMJT2/gLGKe83yjOsu0FPNfGFtOwye9diOVciLuV3rXQp7Kg50I9A/6q6Qokty2R0AyWvEXaT2ehVAT9MnU+lWAc5Pf1wbLx+Tw4ufb4U08ounhi42GkMViukkryC3CbXh7pTlH0d9B3lO1a1bxCOE0/PpqSli9QJ3ZIxeFWui/Pyz9J8Yfbv+Oj4qO01F2OITw9Q6ywTEsCmzC10tNtgkUhRqxn+++52jzFYbic/agpBzRuMSe4LTb0c5puNel76kSEv1vX07DBGPCMqy4Yz3sBTSm98+XRj01+aR2KJXdwmGaucfqmQkil/v7KN8w/OO4Tfno8DX+rFS303iyQBRutTcUgjQH+gSCqayqmzwuqJ/IFXqQnsFoUHp/E5mTkN7+/dTsremM0LdrovCuQ/tmbWxxjrZpbE7SPJjViGMxv1fbcrXCBQeiPUqisP9jR7Z2c3mJYucjCYOkNE8o1Ks01hs70Nufqnkd5a4e4ZRYdP+Hw34uFccHOO3iSUN0qaIB7T4GkOSviykOKFVnzqj/EREE8Y3ENrQC/EtfQ5t7xOmUX90EeVAMnjalqV0n4Fhfw/CBeIZHQ+TfEoip2ooi3Hq+ECHUllVkk0Z5SYRt52AnJktDsD1c28f5zoRSGHsxou9okAKH17uzbr4xsWg2+arhJTe8CRVPA1ycA9PstJTsiQh8jBaz47cgiySnkXEkQRoF/UG8G36GGmxNOmO6eTsOjwVR9/rtDv3APN/s7yauceuFxU34AhOGoooA4btyOtHo6EX1fu/dYyAyeH4abddUBHNOaLCsWu71d+H82IuMHxu/KmGJtuz622Jj/vpABbonzZLL/Po7MZ5SMr/TFEEF1UO5Plw5asAkOlGFd8QwOW1Ntq3rkHgOQyekrrvTz0aknCS9Kql5JHAECPdmnWnRC4WstgeaoqvA2dfiQklGY32CXAIJCT717kiSX1NNbcLCgMR3NzQLZ40Hi1TVbuqEq8hAYEX/u/YQnTozNC7fZTDv38F8sMbd21/Q35NhSyYzyLVbjbixgrcIfoymbdePhz5j5zf5x5AP30fpITxJekc7gMJkYFyjenZn+ZzTrwljCasy7cyQ1FXJut9oEaP/tE3B5l1ZToaLZi1lQk3wOl6vJdZe1AK20X2Om2+/cWZ7eoi9KC/mG+ly3jkqW4sJSDMUjmkY9mXgZ73KFKQw6KSvZeUv048WzrKTQesKwUVJQMPd+7ywCUCxGXx+YTDZl+yw+Hj+ZoKD8r2UOEbUbew0+N7bmt9C14I+K+iqkF0J1a6OfDIKenir9/5SD+OXMD6U78p3xDqeBAUoaxqADoYg4BEGPDwCFtb5sHaEB4ZKDSSf9JrfYsJBHyyivhm4kD7AnU+DiOTmJzwWJfC7nAnzfpKfS/yzaz+rO7RA+/gXMgXkYQ8v5','system','2016-04-13 18:46:46','system','2024-04-22 14:01:19'),('416cd87a-eba5-427c-a1a6-6c0f86b2c081','7ad62dc6-56e4-57bb-218f-349ed1097ad9','digicertassuredidg3','digicertassuredidg3','1',NULL,0,'E',NULL,'DigiCert Assured ID Root G3','DigiCert Assured ID Root G3','2038-01-15 12:00:00','F5:17:A2:4F:9A:48:C6:C9:F8:A2:00:26:9F:DC:0F:48:2C:AB:30:89','7C:7F:65:31:0C:81:DF:8D:BA:3E:99:E2:5C:AD:6E:FB',_binary '*1:40VBc1EZHfIX1SFPf6cTJwR1+XUOelH7mmSwJGkPdtqj4E5qu7aqqidqyAObWH+8VwGFOWToaeoxTMIL2d1aCppqeXWS10eggJ4L2v/rXvcXKVwJbQpCu1gaU/FqcKvTFFz1oPs2r+W1tE6795NjnHjiSvzZ+tb+zsdgsnaAWgiGeCcPnz+K8Z82ywPoN2ep/Ko+gqyBlNR+p+QVsKm7x40IcsNfEh58d3JzQyZuG/PnWM1qKI4G8ozMEfK+30uoMhMhnrToOW2pbbOQnhQWr/9+S4cN+7saerhNo0F2UpEWYOEXJrO0n6RlkVF00zacy1jqt3FHAgChlvsEWryTCrWjKGM36eQzEjQYNq1Q8igVgsONliOyEykeflv4WX/6KhBcCMtuwwvWbLmewjee+Z6Pchl0AvFuU6IG6H0geYJwdtHcjBGUoxGGpMEqzh8BwqwX11IRrzS0GhlCpoO5k+Waxs6RQJIkFq3lZ0XIgeyhcnDEYtbcjz3p3x56XzrL0duAHTtk5PsXLklnep+dNmsnKcWeXNWQdUvGlgIm0drAgNELSKSahH7p+0I1qNi1Uy/grYXfjGNk1z32e1amC2mqbnNBTERofhTH+RexX3/UltE/Jxhkd2R5PR51vTKMny4pShWDFNf7MgUGxYdK72m2atcb0QtNmOgk2XZ8fxzP04DoQJUBZmk0nH18S5yIoRLlgh6TewNB6CuOgdtQdrADJZGdSyZgGWg0kVsONHQK+s0ne231rGBR2XI5neKDXSKpedxpy8LMW7IVWgb5Vg==','system','2016-04-13 18:46:25','system','2024-04-22 14:01:19'),('41b33579-2c8d-42bb-b594-de09e4b442b0','7ad62dc6-56e4-57bb-218f-349ed1097ad9','verisignclass3g5ca','verisignclass3g5ca','1',NULL,2048,'R',NULL,'VeriSign Class 3 Public Primary Certification Authority - G5','VeriSign Class 3 Public Primary Certification Authority - G5','2036-07-16 23:59:59','4E:B6:D5:78:49:9B:1C:CF:5F:58:1E:AD:56:BE:3D:9B:67:44:A5:E5','CB:17:E4:31:67:3E:E2:09:FE:45:57:93:F3:0A:FA:1C',_binary '*1:O/bQmgtn/X0tWn+hpQoejmqQRBCCnC8J+hGtz1/lG0WxizK8Srq+hlBq1qk8ff2xpOZjsXdH6/u1P10RFu0fCq+ej35eEtMmjmxh0/RQG3SxwgdJ7Uj0+OiV/7XcUd9PyJ20eY7mA1HDPfxwiEapyUrr6Kp35iRHNmCjycrFMt+zHkr6b9Tf+bcWnAoWJd0Zb+WJnSlz39P5wOY5195lxxWl54/MJ0CzwY7g3VqQKROeSuZp8g5gSZ2j86XCkC0+zElBx1qkdhToWvjCLf2ApNdPkw4FtFbYQhlM5GlGaXDlsh6LircRNywLCM3FRjDxG5INeE9bOozcq5xpXkYtwkfhr21+zrBHgSl6+0cxvdRFdiCMijJAn5gTRLFuXObQmyqrfR3xmtwqNZv259sQod7Zl/qJ6NrAbfQhb4IdEPtkRCPuZc83ixYoFzJvT4/3X2KfwL4vBJaf/Gv8B4bBFVn87RqxyxFEw8IrVLZgJoGbj2QMzkz10P+5xrbC+0dd3U8tm20ibi3uLrVf+NjordmOGnkg10fnlKM80pbE1XI4V+OYiIbDpSjCbPwVDCpbnJJkIyUXiZSZe6/phVYq016L7sdioc4ohI5+3XURSEOX/et0ZhfgRm5y1rrCA8Yy1Q6V5uVNjyoGN9jB4YoTUJDJXP1iD478oVFdcGPEWnerT8DeblFivI7HRuekxduRdQnOOlGKPjfSSJzSuDmC2Ik/+u3x5q7HNkaoFYjsW6UlkzZcmwnoJiEkc+zelaPFasjZeuE25KvEx8gptKudevCGgDys46pMQcmElI+EGvrI4b8nbCNTba9n9hFlbWb9vNU/v12loKNztK+2xHNPTQVW5ybCdmsaqrO/yq5rXS7B7Cbb6QdyisHVYFNIu53J8dI69xeQy4yOLCenWjKnTYMLnoX5vFB0SNnnX0DIpbeZkiRyeosX283DYOpZxa/5zHNDJpRQpUmHAW15FVwkgRFVIPpzSvOip1kuIAf5LxcqPwPGSNNj5fUla3+Ap6aK6Wl07O3727xQ7t2x8d9dp2XudKv6aoE+baPAA/uexHE/Fhczp7lk7p2wel4MyFSbHq/4XCHXh8Wj2nNmSeCyQPZc/0CK2SqJvwfKrrLmKnrTNxiDBQN6ENTLRY7skqlgiD5YsETfZbL2JJWgSewr5TR3VX+yLcZ67M/+qRr4T1tr++NjHHWvGgOwUt56IURLkYIOL93VZz/5f2DYX0g0x4aG1kZfCv8NK7m3/A62aBRCHZj2mEA1uuRsSnnYZM+ElBtQJLZUUp5qE3WPfMpBxQAx/AMu8QOMNbH0Nnt+5EArdGG2+QlbYZ1dt6vCCte6N5Ba3WnG4aRXhygdXqcVxuBQVozUwhUVKAZkZOe8ziJjPt2J5Ir0eJusVVMhdjXYJizEnyv4fHz227a6aP9zU6pW6M5Hrn0Vc+j2SxbLdp+LWYi1c43z7YtqGujTn+0ksbGllyxAW5JuGcNkErdvKuyLhCpccRa+SaMWhGetC5AKbJzMGRRKZx/JPQcPb5fNIDi2TZZ1HZyC11FwakJVybhTQ/e7CHpKw/tI3g0UrPr54T5Cj0D1l5HPc2345mUebn9n4+MolubSNQY62p0UBW6twGSsLjzFcNq0eRB6x/zKp0XP0oC9Na/81a2GccNA','system','2016-04-13 18:46:35','system','2024-04-22 14:01:19'),('4210f587-6e02-44b3-831a-84f2472d220a','7ad62dc6-56e4-57bb-218f-349ed1097ad9','digicertglobalrootg3','digicertglobalrootg3','1',NULL,0,'E',NULL,'DigiCert Global Root G3','DigiCert Global Root G3','2038-01-15 12:00:00','7E:04:DE:89:6A:3E:66:6D:00:E6:87:D3:3F:FA:D9:3B:E8:3D:34:9E','F5:5D:A4:50:A5:FB:28:7E:1E:0F:0D:CC:96:57:56:CA',_binary '*1:8vmx0SBXf4vI4KSREbGlob35mjzLRug1vhiwb8Rhx4kWutAYyeYKt3wxBQwxkymxQr89IeLgL1jgOIJWHBxWmYjOJY7FermA0s/653ptckcy31lgdE2TrUke+nvHkUPABxZJ+QZ2MQpcadCcNErn+pZsnqwWAeiHXlA2MY0oTFvGUf9turjzpUfRTd6RfIXKQSab5wWyxwEjRnzsypX3uROhM9/MZzvu6LJDVzkbeV8fkbDVBtbXflRxXJm2x0SVi238Appv8FcJicgXQJ4BtwMZ9L3AeyafOVP06uk5b2lzmrbigEV2Y+057Y+SlctYst1OiV2lBrjPznAgjwNK1SDf8ifT1k1BzHcbKHWMdLEnz1lMdiFdFvjgN6E/3nyWfUzANhJiyQ52+fR5dcxceefMHLETVn0qGd/IvsaThHamshfAqq23nYhXcM8RRu7DOGuPMOwj7pOdW4C4gn4K1SM5akLnIF2IykbnOyT7uWrm27dL+qmQjo7u4A42q4AKTr/KbJ3ixKgWoaqXnA7sEaRq3H8c+DVvJcVzCpqFT6HJ9wH9sGmJtkaBZsuwlMebbNPhv3TmNwcst/9m5fQyPNLqe8CWXof0kFjvwT6oSv1ZIrcEtjzz/6Q9YpSCN3T8Rjf0BjMQuQ97Gcx+NM9KYTrfhlAGcyxaSx8pH6uIk2WfcKyA8MMufxqrd34v8I7JmWiA69kHKlcTQt2Oazrmr9svOV+I7d1INKz8XyrW6O/7qo1of/+hpEnLMNZZqUyHGmm4uvdiaK6K1j3PrekReQ==','system','2016-04-13 18:46:29','system','2024-04-22 14:01:19'),('4381dc9f-7205-4f09-9745-dc6516d520a8','7ad62dc6-56e4-57bb-218f-349ed1097ad9','geotrustprimaryca','geotrustprimaryca','1',NULL,2048,'R',NULL,'GeoTrust Primary Certification Authority','GeoTrust Primary Certification Authority','2036-07-16 23:59:59','32:3C:11:8E:1B:F7:B8:B6:52:54:E2:E2:10:0D:D6:02:90:37:F0:96','02:26:C3:01:5E:08:30:37:43:A9:D0:7D:CF:37:E6:BF',_binary '*1:IKtAUVN5nwAmgy51RMlixGFMlPXeCAO4Nxng2YhEjd9dlIihnJhXvJYqYo4WA8DREbKxecYBGdnbEXnaY/i2jnGLUzRSJje4xo6G5QbaCMLZt8jHtlCeeh3uCstb8Qx9VmNt1oDskFFx3GF5i2kWfucsi6YfgErsEorDH7blq5JNkd/dlYvy9luh38iREFgKcdpcHC3sueFMeamhYf4KH8bbZDqfZShjOOQN60pwBpLMYn/N2Atdh79++XC5h71MDa3OI3Oj35Au6WWWiy87G3K3znJh+Xu6qTnPmkU94RCu/+6l8RKWVqNPslyUrOJhX0vJHUKlp32MHU0y6MUjcAmdO1LHyEjYbCPod96iDNMDlpIIczMhn4cgvjD8y4kjy+ZIOxDBpea16z2tNYey1TnlQHYvZ+Wp3knxxeXGRsLtpkEJAD+QRQwM8rDiX9v7J24Rt2ouoWhGcNgzs0jJXt2L9118oaY3+JOCjoOuu2bSuRiIrCj/XUZXHEUNNJv2vV+CpmN7EWL3CiZENp8XQy3qJ3btHT4qUqJ1i7pSS6FI6VWu8Y5fHKe4Hc4ICsXOP9e+Ey7spBVeMx1QzVDD+Ge/EwSpUI2miD+0oI4Yq78eq1n0pmOvIwoni3wRVpoF7ccQafNPk04YY22NqTbruHYkwhadhO8/VSn9L2DLHkQBMhTQwkLe1HTkHD7Jqoj8DpCqxujfpecjwx2pUaZcHW4cZMBpEuKbn2sJRfps2gztIFE6C9ZJfv5AOyfpMhEtsJxIQlVOEdHqgxbZ5fM0ycE1IBcpkmHxMh3VMPk+fCgqiVrN5GH8IVpOOZ8/tg8AB3Hq0c5YEF71ZOOZOizRCpeehi0W6L523oLVMbO4xv5TWQNIZ8ubtDlvMd+6ZA3oSd20NAqJeKbGVxSOForxwEg33/Q2EJ+u+MeH5j/n/gn3RHvthrGRfjymtB1u6R5dqCZYpj4eU1dtkftotIYg5mR4uEUJasfhEA3yCN+CJY75N9cKEMWiUjMVfXILJjcwgNA9dq57TuX9EqXJ9jtTn+hai5cNMu8afftECVMKexcp6XEnd47HL6Wyn27HqJgHllZQ0ovOJfxNqTwPb7m5srsn5KMw7jO+NAGum0TvNKg1qE3Yl1yqakMg2W/4B1kSs8fIDV+UakFdfv3pleqbHcx13zZueX8POQub04Fs2ub630UOiMtwNF+yfaYjI3ph','system','2016-04-13 18:46:32','system','2024-04-22 14:01:19'),('4415c96e-8041-4835-b2ec-92522749e7ba','7ad62dc6-56e4-57bb-218f-349ed1097ad9','addtrustclass1ca','addtrustclass1ca','1',NULL,2048,'R',NULL,'AddTrust Class 1 CA Root','AddTrust Class 1 CA Root','2020-05-30 10:38:31','CC:AB:0E:A0:4C:23:01:D6:69:7B:DD:37:9F:CD:12:EB:24:E3:94:9D','1E:42:95:02:33:92:6B:B9:5F:C0:7F:DA:D6:B2:4B:FC',_binary '*1:K9JmAZDExApxj5E68a5h14zSSC6+Q22HKBTH2Bp0BczFfMKCsMH/17Qiol7Gfme+ihxEMSCxgOD7VO7CVfoCmWuddSmHckY54vn1jP6ag4EqYmvx+MpeKrUcqw3ofatwWxrGDeFqL+MKpEXpqgvSajqvShHtBxsO7/gtG1soU8ofUHl0QNZllNSqZfk9Cfst3gNA1SvxtFsOCquXL+NduuoeW8hxRQTnWBVzy4h/uopLDaIuyw7ib2aMPrR6Ocv8eZNKSdqbCOwOU5PelilDC1GyZfXwubZXlcEVIpCuXdUqDxbGWJ0EVqLoRE9QPfhCkioJCy6QutF6CojQQvEWiqr5sEfZsBOiZ0u3mrKLmsLoIKj9pQWxCjuE57Kn8qXu8fVN3HVZskRVXP1pahpFmps0hFHtMB+SqZZ6zPIalwVPZHJTkgCPa7r1XRBQ5BfBnubmd428nqp2gzqkx1630v3tcRuiAY/7BGgtBr4FevwLeUoqoBJMKJ0ox0iHU62eWASTntqfFGHS6Nz/0KFZwDQ4Idk2lpdFbnpc+VQUHNmPNhukbtevo+0PRJdcwvaiGJKoj3O9jZskbso6V3j644JfR2RE6h0bstiMj/H+VnXlLP4DLbj+4pcb8oLQxUrrQ3UZxIDRoZDw1n76qdFGKOjnfM04KlV125iCseAh6ajC0rcUP3cgcrK7Q9jWkexAVNr8OHHj6RtCV6Xjd6cIjR366C8GB4DwCJ+gnJH9vmkMfRpzBUmbcuybWoVlM03BzsYmSEPd8mnwvGzbQY07eL85r+HjkDkPnPtLzFHvUy2fIlWlUMfCV3w92eoVledxrJ1zWC33zePcuHTKv19a7aCgwQVPQHhn1jL0fkOgIqQxFdmb4f9FTMsV5GpMEHwXoEfX+Yl3UCUS6mOFlzN1BT6b/8cp16CQTvZbyLIt5c0i2xGOCpk5nsDY4ClTwPFnUli4R77q2KeLl/Un4PRdnMh9hC/cW5pxo8sbFtgXiOctInFMH67EScY/zCo7e2bje6HnEfpG1mnY2TKZZJ4TLzTnx9rY1AzUzS0O5Ggmm9Ffl8EZ9mm195Hjj0YAdm9Pcb+/QMNIA8J2Tc3PFHDAG8UjOqjE5sJGVP/LaSBJ4kmbvF/RpMK/T5/bk74ESPsQ/B+YCHopJz0gkoxCR3Jtj1yzqBH099od8JwVZrJ76kzhvZ7FFcUrMFJBeJJasECy+Rp494zEras2ehKbomzy6XZ5jxJw+Y1HdXaCcLEU7zjjKYj080hTfPyHocMV8QNgE8u7Ztv3EbQ3oYQ9wvSzsQcF3VDOTzcGZ/Lb8/XthwxQ4MTnb1vDsN9z2ADHHgXzuo0TzkMW5heT8mRuL+DvHb+zoG8XX/PgbQsfNJ7z4pYwRkq7+Lcqe8MM6OsiEe15','system','2016-04-13 18:46:28','system','2024-04-22 14:01:19'),('4bbc9247-6fc3-4efb-9d53-5a1fd61157ed','7ad62dc6-56e4-57bb-218f-349ed1097ad9','thawteprimaryrootcag2','thawteprimaryrootcag2','1',NULL,0,'E',NULL,'thawte Primary Root CA - G2','thawte Primary Root CA - G2','2038-01-18 23:59:59','AA:DB:BC:22:23:8F:C4:01:A1:27:BB:38:DD:F4:1D:DB:08:9E:F0:12','74:9D:EA:60:24:C4:FD:22:53:3E:CC:3A:72:D9:29:4F',_binary '*1:9ynwo+bmT4ITrRrQAEOUtqDw+xBCig4kouQ7SYnPHj1agiPkT+Xe0mR8F4zCJp+ZkLq9q6BZOXpViPVqF6l+FrfYvfLdGyT0gQoqvmh/eyPh3EhRk/ZawkgzdkgPMEOXHAv7R1Qsj8xwPmzOK5yWdMxovjYWxIt/11484PaINPuAjCCae4m5IiTbn/68Ktqwwt6LWpdQZUXcp9KFLsc+lw9qVwW4UGe8msUqblrML1QzbaJu8MYLJar5FU9Chls21qmmqe05rEyXLEZQkwiygVf28e1/+gs7O4KuteIvWQrqWaVI14QKVWWtU5EZX2Rzbb1TAA3bmFjws3R8CY6mVtF75dJfW2OYq0gb1GtGdc5R8aexlzdh5LQAEn0KJHArqC55RTUwWI9qN2bvgcFDwma7/z7L35n2jUF5SFzs/Fc58Ib/GzzxBIMB616fSrjrXYgTv7F/XSgPF6bm3pymeHGr5ED44AC7isIJ95UQMn939B5qoUnQJXKJVrlNJtoC4CqMSYwLRTSVEfD2cXsRFreAsOvAVNfoTfh18EjG+RarJgG1pJMZeoVceG/6zwHCiIObk3ZCbLtJZnr3Sr53CRNf8s28YJa4JoxG/9P4WaiwucPYXtpZ6oFSJnCqt4PySdf1tQIHK2fDtjWrYvysC3RtLGDDU3cEAJH6AIIMp9aV+f2pCUVKaPFHbhevvvSPUgRpU4sx1RUZW/qhCBAKFBgacGDnk0kylIeFbVs5ymRhsjNZtnfy0dAVpTXGYJVZ+qzsDCLfbOTndYDzlGDdD9pPhTEL0Y1WlsYmx7YYj74tAA6MTGEDKJDqFvDgT/XztGUhENSrALJokdGMI0Qt/eceKeIhmZrHUrGwTmFTr5I=','system','2016-04-13 18:46:31','system','2024-04-22 14:01:19'),('4bd293d9-d63a-47ea-9e49-26e9f9552f36','7ad62dc6-56e4-57bb-218f-349ed1097ad9','swisssignplatinumg2ca','swisssignplatinumg2ca','1',NULL,4096,'R',NULL,'SwissSign Platinum CA - G2','SwissSign Platinum CA - G2','2036-10-25 08:36:00','56:E0:FA:C0:3B:8F:18:23:55:18:E5:D3:11:CA:E8:C2:43:31:AB:66','C9:98:27:77:28:1E:3D:0E:15:3C:84:00:B8:85:03:E6',_binary '*1:AYwM/5kgF5l8pnGUiduZfPOWrkX5s9a3mYXPvtOVBiJAYX+NvHebG/fUbGczi7J65Y/d+Sfqp6FUbhPVKD//veGSB0LlFPworrmwlRdd2qg0Nw5opi10/W54mlmKIu6uK3rSW7ybzlTTpXF9WJQWPGHTOZhHoliJLBJ6zXP9HcuseRyzCuuCplGo0ZUTtpQ83T9cXupYywfB2zJTxg+Hn44hDXjNarKpAQ+ocH3vK89K6j7Ww6wppiNBPjTcx/9MQvgpqUcc16Yj/oRiPZcrNQAy4swbsk7x+C/kMqb0q39+uYI5P0dwn0XGtvAgDUmzAhhIfDX3NFJT5o5RzK8kt8Ima2p+BXodRwYuDMe+e7e/Jq/VI5E91D4nUbo3T9kp+HESAre/rfvn4lD9KuCI3zdvVGywyCogVg9RNuiSs48uQG+RupUIo5VOvrVV6WnN5sGJ6nAjw1YJz/CYoBoUI5nxgDbe1d6IYUdN90c+bMKRyEfVI9hETw6FUTmDiKwdU2O2Mvrb3y+9UmvlXncHdkRDZNtdZen6/z24jLyVuYzXllTUHjSS9jp4xkuvIyHuC4c2ZH3qeWLu7h/4bf4srrYvKmU/eKlV09jeZIKs2GizdejOfPpI6AAt9r7Unrj5a3TFOqqcSrUFSdomH9wBKLJQxgcs6mvSLidSfIShhdu1BuKdfTMeFNU0755GIZDwj8sCsqysvs4rIY4w1Nq5b9Mmd7rfjcb0BCz2Pdt+qVCtcJD2POQd59KoAglIRhO3EDRAxUnAWKU0DClwX0iV0Orjq1/Ml89azowFdg4qDOLqTkNrCKhS/zzs3ZHZZsfrq1DRUGKMhEpY1/msHDosfZZYqUCbgwSvgu5TPFcbr+nPGzIRTX7JkgtIuNRFEPUnXAjSAR70ILUC79vR3FBIv2umAQ88Gu4/aVwG+XpkEimxe+CSNDZ3WHixBRHGYxRBxzHVCBSowysaOn74tIoVYqUsxz2ChVeeQUl+fcRloc9OwMRbAaniksUmbyZirK8frKRzCivf+RAxK2bEgXKG8Gq1Fc6rvwq7p6TwbplQMy2gcZeDvpcA9hyO0L6IYHge0tLXRHYgy9xZu8oKcn0Xel/MPyxkqxv5n+L3rlo0nRjFLyIyj08OoG56pFuLjvBfmM/7CY74rFmPbbwr64XbmBct5Cv5y8DufZcpdivCNu3va/Gn6OmaMoZUl3PWeaJf3buB51YppyC/hX+KuWlOgSn5TQlWIIcUQsQkOK+hbyCrPRwl1RfkcHHwcs3XxJyUO4MgeKeVCs/0fOA0gy0hbZCZRBPBfWLIEgyIq9RNY2VVmrN55kuu7UuPC51D7blZbvoOg/5T0kKXtkA8nWRGxTXcFFSPquBUzhuy24bWUeDYs3FFAdtLwqCgno5EevljXHYcILafctL01JGUOQyE0C8cDZAvGtriDIeW8L7Nzm87Be1xieC8qmFv3PYTyhye6EQCYV2XtrvxANka16zecT9uoo4YFTDNy56f7mIIvX6PMSXQQL/U2FvhY8s6lzJY2y+iig6OIysxJZx5VmNZnQ73mMonVoP1F5v1zDipHfEgmkFO+9v/kKbczKxxysm9Fu28dssi9kfKOJXjBA4v92uJuOoDwXR4XRchiJtjEW/AAY8XIFapJ7kcfYSUbUu48bEDImY+o5fXCvMnvaCQlSdh4GBuxFoLm1p8GYRKvDjp+VtjDuZuz0GBNM5ezN9OvmnjVvEaAfO9bPLUvST0O52SWwQlMdQ3AwT8tWM3zLYqKkt+ziiJr3dfrSRKnn7TggslKynXUn+nFUqZ+N485km5JceJbcFPPe8xOg68IK67+qCknS7ZSPh7J3B41nzEHqNboxtVbvFzsu9iUq+GOGLJbVNbi87Jy+G1D7hP6rXXUIvvdcrZzZWdEI2QmBv1kMNgV2lCC+nSo8KXa1e2hGruaN94AEdTGOk/Te7Qg66EYmHfTy82f7bwXmw3xLiM','system','2016-04-13 18:46:24','system','2024-04-22 14:01:19'),('531600f7-ef9c-43fc-aad3-470a48e6edd5','7ad62dc6-56e4-57bb-218f-349ed1097ad9','buypassclass2ca','buypassclass2ca','1',NULL,4096,'R',NULL,'Buypass Class 2 Root CA','Buypass Class 2 Root CA','2040-10-26 08:38:03','49:0A:75:74:DE:87:0A:47:FE:58:EE:F6:C7:6B:EB:C6:0B:12:40:99','46:A7:D2:FE:45:FB:64:5A:A8:59:90:9B:78:44:9B:29',_binary '*1:QmSrIXEZwSnZK9kF+7k79xjrcwDgKk/4msbOx2Hv1QDTNa8f9gBNlAUb9QtsZpdYNIcrXBEcFzOvG5OIS8to7sQxJaTtkadYD/5sER3/PFsR+agZL/tl6IwnUHQwMO+CCNf9HdXsVgBWEIf/4iWR60KHNqH7TnzkBy21ADZYwnUt+/ZZZ5rspQGxuuXEMXsbUJVNfMgx2Jt7S5LUi+wWS3YqEFeGiFjaTGH6ki+qF1RcwRhX4WbpAutfDpeY+GwwMmsODpUBAoYYbfPLlbCZivlqkCAgKt79zAMgVkecSlmAm27BS5r8ob8UYABdojaWqUng4ts8y5cU6RZWBvU0m2aKWw/icoNkV3AGH0byV56Jft+txfkEyv8Rkrnibin3KEMZd9GTXsvqrIMoTBZ0AtGCWcG2yL1htfeGFc07CCsCOWKUHDlAL1s9He8M3NHlZIV+7SSh8q/4sG0OxX0Y51U4v9SphwbEv8wqeffKhmFop6gwstyrk5bRkdQsASvPnggNjGclVkorUFtsL7v9Y177TXhNtk/QbqY3665uAPqpAWHMP1muWd7lXEWz2CNWBRai+U2BcS3pxLGtcL7yhrjwDFXkA2QvCOgdIFhadQeKrwuXbmvsOPOEI6e++K4Gd5JealXrvO8chqdkjKePGX1eAPuk/FVjzVuTDTCG3J/RCJZ/TWUl1iBrf3Ib/zskMWhiPfACMiXs9YYQfkdoUlpOnrfmSzpNlpz7qRFyKPBPr4GASIdOfEdTE5h4rvOJz3P0nTvF70qzDkwrZV/t8Wa4es0O7XI+3O+XHuwAqLdnQXwr2P8xJ/rhGmzrCXW8zKmeqYygJOuFPmHxj6zSrPfiuIPt9l6AdiEpsyqsctdplngsT6pK8y9xORm1T3BYsH19BHhqP7aW2IgeMgTB6idA0ejOvvHWMPZC7Pej/MvZWwS3DAGhqZmJ5bvulueWVrzW0DNwI5G76CxnDIsGR8j4hRYpJJ+5wn3VIpU1BQZG2S/10V+O+vlp5DhTFBU7i90Fmi8Z49Y5unkPORigTOJeHgq0ErG/4ssWN6bWJM/irpubZcKlSvdACzqE4xW+PO2V4EBz89CCkj+L5baaBTVFs36289YCNaN1ZJnJCSCaFsViK9VPBwMaa9efkXtjiDDrcLEiXJJ9PAkvPlq4V3qCsfh4M7tpUPhw5n7rojmeWJr8S7LiZ310kCsBDOo2PcBNe/DZxG6x2b2+F1VnnR6wjTefzo/358bY6LEqum3COhd0DWNBk6X8k0+D+e49ayx+EodYXznbqBs9HRFlg0/ClrkPXThsmL5MJd/biS4aW3jp8vkpIWf5PRucPQuuEKsJ8VW9iaGLHaAjBheA2UxOMuYTsK39eDiTmZoxAiuvYl0m7nHDs/GvHRWayNs3xy1YwX/sRkOtqb0L0kigLuQ8jeacsQVU0wLbbaIGuraLuj7QA1s2gqulKMV6kmMSckw3fZa5bTKhlrPbZHQQ7oIQlUTV+hP5nXccUcVYHGQg6QhdSOuusZzzRNxnMXfvWGwjmxgZ2xasCKB0m5GiK2M+2M/j5A80/vp2nxr7K+I5NkAsmx5/waQtQGPQtlc8siYYxoZZVfgOeRNsx4aD2zsqlfLJfBJaL6sXqItzaKCHhQyi1FAxzrryLcPen3DzXv1D0Pmpg/P8NXzVKA3ZcfnF+E/4nMG3jceSFpdq4juvt1pHRlwQsMibqezBudauumsLSiHSHUxMdr7B1LM8/xXU5HgsocGmh2/0vMcAPHcUXNz5CZWen+EGamfeGSXhtzeNjgXmPHHMBAg0z2HEvWsp31DWaqMDyCgk7MI/9/I=','system','2016-04-13 18:46:32','system','2024-04-22 14:01:19'),('55bb16d3-2580-4348-855e-814a12550164','7ad62dc6-56e4-57bb-218f-349ed1097ad9','thawteprimaryrootcag3','thawteprimaryrootcag3','1',NULL,2048,'R',NULL,'thawte Primary Root CA - G3','thawte Primary Root CA - G3','2037-12-01 23:59:59','F1:8B:53:8D:1B:E9:03:B6:A6:F0:56:43:5B:17:15:89:CA:F3:6B:F2','FB:1B:5D:43:8A:94:CD:44:C6:76:F2:43:4B:47:E7:31',_binary '*1:cTfGFIyent+PIaX4iCsA+rW5w2NZ15BtW65dL08kCepWPrziZUQudUAjCEGT4ZkCaXCYw9Qq0YxgYNuOyY3aF9nuH95JTicJoIf+WTpsMVeWzXcxOTpZhUvmissFCHzrJZv3yrngEC+lbNLdBLGS6vH1+tUChIf9xg4XN2b08L1agH5tGqp4kA/NZeghqKm6KermQEpdF9T9kMNH3tj2IRsq9ui5pbploepP8jk5OeRQs5zudDD3qhK67JevM1f5TDUoYOLLt4XxjmI8A6ZP5qptJOiT34Pd4nPuDR0pjVVCRulaxkycb5ME6ZXpWRfJcZx1tqD12jzdFGDbhJy93ZEGtteZ7YUFvQZOQ51dGKHFQ2grjSCv6qogMrtuNV4uRoNDpyrk1IErtFqCqPGVSe/VvBiuu2UcQNp4IhMcofQVkcZvpwE+U/tT0ZR+J+Mjt/KALPsYVXjPzVmzU111HaHypQTrPUpeCVmsUxFcnZbALWqQUEfaeBZjyDc6aa/UJ8oMySB2nfrHGcp6BUHz7V8OHpgu3/UK6QW6Qsevz+UWV+snivdtsTwaAzQfWHhKx0uM5cttCAiKD2FdwRZBMjRDQg3LtsIKM8HrBImcjkjxf6GDuHzmj/g5HOz+trL3VpQyFlflMccaBBTCDAEnQKuuKBNEesEUR/5YffQGXEmYdF3n5tXagTWF3FGLtY3hUrtf2xI2mhx9y99HceTuURq+Vd+FP3eAfMMbtOd/m67dkliSgI+P/keIoM6kKMK4NObRHkQc/HruKZIl74tQ/S34QV3M9451U+MMdjU0If+AUJ5+Yb0KFxyIVD+kyRkxDGWBPKiqq4+zHqMwAOHFoOE9d7Unb69+DNLxNzaloXrlkUnS/rYhucdmXgX4FABKKo/W1SfzggmQSK6BC8Jw575YWlc8UufNoq2l5MlN8rKIGxjxww6N6YaXN6AYlchwJxpGIxdv6OlI1/CBIBhGV7J9pfNNOf/yd5adYm4WCR7Ud4fYP4P0xI9MC0Ff0SdThBVEWFm0OtwTq9Iew6jpAmnG0BPGCK7ZGAH8qkzexQ8vKaGwpm7giU3Z7B//0UTTRUiSgS24arLUGxf3RljKnDQkwpU07WlXEmO5BH1JgDzNvLTe3924asnqdINGxtUYuUSnVIlk463Fkzw27kbgh+Bh4foGauT0ATcrmEdLb/ag2WFG/U9JfiwoC/X5NFN8+x4xpnewqog7SrE+cN0sksobVrwo9NkfU1mN4eYbApmfAMr1w5B68bAHpQsYFoGcD+GwUrroa5SbxnfDq3Lz7+4Kv0aakt4WHhu29KPbtbNV+ytLlBy+WjzQcZj3P++5b9o6wbVKqJdnY7FBaOTFSHvGvd10/XMZUvNdojwPraFJ+70hXppBK7WVEilbSXj/2WxAGGsVmCrDAa3oeY6s0w==','system','2016-04-13 18:46:31','system','2024-04-22 14:01:19'),('5726f7c9-69ee-428c-91fb-f9663cbb7197','7ad62dc6-56e4-57bb-218f-349ed1097ad9','verisignclass1ca','verisignclass1ca','1',NULL,1024,'R',NULL,'Class 1 Public Primary Certification Authority','Class 1 Public Primary Certification Authority','2028-08-02 23:59:59','CE:6A:64:A3:09:E4:2F:BB:D9:85:1C:45:3E:64:09:EA:E8:7D:60:F1','86:AC:DE:2B:C5:6D:C3:D9:8C:28:88:D3:8D:16:13:1E',_binary '*1:uPPWRY3l7v7FRALyrpYIw9tOKC6bMcj3JsFsFmTew9SeLO8WMPkq21mZDTezBJhmcrXfELzL37OJc1rxlDtIf1410l7GrKGGkm5hnnDgoXcjbCanWg2R2IUz7PsJvNL3A2X4JvbRdaz0c4M4stJZEE2vKLsuPoYNMeC+UGxT0QzNB0iBvr8bw8IVkTwqGXui4ufML1/AcoTOOXQ2pHEjdtbrAvtrKFzqhzt4U1rAKAr1fkFXPzNlPoFuRVoCX7hpnfGoKK6MZ6EbPz26StJYyxwbSO2WCjQDMY2eCpN9miASEQlBHSq1k+l84uYJQ0hmJeg5JkdzwqYpcONjL9d9KAup5NZMxZVLcJPzCefeASm3JgxtOwS8zGepVYF7rVWSHxl04TBG2A04cRfL4JQ+XLAnnjxJfGW+6jaFqBe/O5iOc3B0vFFIzkZBMrsq9g33UUJEmMcceelNVun0lUUN5U2IkiXbBG3XjcV5tcA4xHmZ5lWy71bPiJUFSzHM11SFnxJj6MPf6/I/8vX+GEaDsON2hAAaXcumVn3ZcWjvGwwg3XR2JAZPsmH/2j0Rb2wS+u8wtDzR0+bInFHDribCXK+E/SPQeHmQNH3IbhtRFBUU/U3iWgMEwxBmwQDNmQVbyQMR5XQTL1j6EArkgaxLWiM0vyAn0srjlS7m52srVn0zrZYzkYmAj5g8fK0CoIM52vviUhM5xrMvgyTTgP1/gF/wd9n+EFM3aQ/683OoUfbGXyrAKyzxkQrT8GRzAwuc1EM9obV8hNEBdu5T+sQb9A==','system','2016-04-13 18:46:33','system','2024-04-22 14:01:19'),('575a0a76-ca56-4e9c-a685-6567a06eb077','7ad62dc6-56e4-57bb-218f-349ed1097ad9','entrustrootcag2','entrustrootcag2','1',NULL,2048,'R',NULL,'Entrust Root Certification Authority - G2','Entrust Root Certification Authority - G2','2030-12-07 17:55:54','8C:F4:27:FD:79:0C:3A:D1:66:06:8D:E8:1E:57:EF:BB:93:22:72:D4','4B:E2:C9:91:96:65:0C:F4:0E:5A:93:92:A0:0A:FE:B2',_binary '*1:hLPMtfhTxW8xXlU/NlT4ZvQ3Z/E1z/7/qjq957Jyc1qG3hqRRIQb5a2s9ECpjEz1obJC8DmnlJjLMMm4vpjcdC/EU6EyrH5qe8D1tS7pje5J65VE8TftuB6ff9n2MUQtAEoQhHfcdeI9nAUkUsVHoEFWnkstfNUjTqI7bF6racWDp0Z6QPUIb/bx7sBkUGOZA8AKO9f+5G3QU09hCc4GOveRoiYHFeUe50j4B9KUgy28sqpd/V+nyG4b/KSt9/FktchCjnDMXUZiWMnkDqr0W24chClNdHfsqiCejbfp67pcQjfr7ZdJyC1KzKOv0GLAZZMl0Ti9NMQsffpi4ccDTgFEUCe0+tL0jrgncUjCG1OqBEwlyCRGn+fSzrALyExk1Z/t/1HEDfLeh79az11OQinz77TAxSp+nfjYzH+hWl+nxgfxNUhTJbVu8PIbQB/B9Fh2YvT/8D3T4fBjvdCdCP96D8DIFedUHfbPNr+gPKZ5mX3Oom7d0FnJlxACiUqynGa1I/XB0k2YHT2vAZ+WnpKFlmj+TkKpmowTVfl2lFFHqrNpS9fNSIyZV8s5v2DHj6eft9tXDX6yC2uOYyCQCbJ0q8BmHkrOJmx2djlPVXUoJ6VyoLIykXN+TCXCpN0RbeNSMJKJ3Cf8bdOmxFUFdsE9U9Z018BtsqpVxlptaiKX98lJ00qmMiEtAjmy3UNOD7EIo/JsDKbaxlm6oBpxV8gFjmvV8j2DPkNpUMH67b3Kk/gVOPKLEjYbUrdxVK24rw73spdes82Iq4z7TsRLPUbZCDNSgBLDjLP0gHIC7jMHC3QUwGPaJAno2lg9xdtKeWcVSSc3d6TxH6F4+KmXdxxBTCrmmi92/i8mU1t9clqggF76SPqMqoQ76W0Sar6s6BV0BKh9yLi6es1+nD9BcQEV5HW3Ne7p60zv8Fnsfx+XEu0UMuoWAt5qipIdIXFV2MsoV2iaFrByF4H4d9AlBAgPEnsk5E5/s7iAm1bNJ9RCF6yEynAPIOV/Zkxwc9jj5YlABUGYY/XW7+J6GBCnEiSvE3u68mizfb1YtxpDAD8Or/td91oDOLK6++C1m/SKvRdZE9b1ZGdECobjq8eHlT1mFK+uNiTsIs+UlWqWD9U2rVyiwPtRXEGzhf2W0b9GlPzO5Qh7mfbgtllge+bPPqB62B6VQeevczQJ2CXqnx1k2PIQgkSleou770Ogn/D+zORWZ+KivkI+Gchab1GjJqvS3OQDKD+iIuqKH1XCF635kW/cUWcQc2bWiaVUhqJJlNtO7NOsNCeDODmOTRYJrbLUzC90oS752Pg7zhdMlPx/xDyZdVWO9+XX/DhOqJ+qwv9cThz1hTCeRzG6LbxjG0PtgpI/hw3bLMOwNIw+cAg/SUq+wupLqxo0Zynx7ruLQBdvcgVCNC0Cf3TQhIyqMR9m2tHTMy4oA8a/l14gxRrE5joveKC3XewWtsgeVb4R','system','2016-04-13 18:46:28','system','2024-04-22 14:01:19'),('579f7d0b-0b4a-4054-a72c-545763633202','7ad62dc6-56e4-57bb-218f-349ed1097ad9','actalisauthenticationrootca','actalisauthenticationrootca','1',NULL,4096,'R',NULL,'Actalis Authentication Root CA','Actalis Authentication Root CA','2030-09-22 11:22:02','F3:73:B3:87:06:5A:28:84:8A:F2:F3:4A:CE:19:2B:DD:C7:8E:9C:AC','69:C1:0D:4F:07:A3:1B:C3:FE:56:3D:04:BC:11:F6:A6',_binary '*1:lIKnQc5GLCZBkzgEt1HGxV02e417OQwsM4bMkYed+3pWHjbilwUMYkLvYFo0VoG268YhqZJmjd1JyTGTeFG4/OnKq7lGrcgEkJaw7PLaeRhLZ41Nl7PgFl9LO5qOxrmgbQXCF652Y+cxv2tClqjUj8x3Su1IHEt5DJ/IQajKK3p+Tz8RQlSBL+ujw9SJB/UPLCohZwehjNLJo8bMY9Zhzi2XqlPGR2wE58xAT5UIX9Yiu4NIU3DbWu+TMzbL7yBGabtMO87zogv4U3NDfOatWdg7/UGXWvDJqA5rqOVN78VwoGLBIl16Kxu1BdY5zzlRaszDp9uPctBTLUomP3wWxFqTA5xpbESj4bA+sL2iUJxhqOPZ10ORkdad3f8U6jN5MF9iWwHHby5N1nljBy4PziavE/MB94FRn/j9iCa8H1kv9Sfgtwq7u1beMop29bjd9ypxJmtiCFXDdc0M/Y5ERmMa8Aa8rIbEgSc6UIGIXvUZ6izbYMlDQUjtJH8ZGwmHmTSjlhr/yCVjbfPGRxbIIS5Yb0XXGO0vmsq8qo63h+rJlJzi37t7uz7ceFs0P9CgxRthZcEsZA/OtzEv+cYzcUYgbQfBk6sqSxiRjb2EdYHowkhVHqQc20ZhC8MrwlXNpAywW1H5dpndmyBcy4IOesNEr9aytst6Y2neq155wemqq9GsuWjClEXzwL91iACivAirWJl7Do9X8f3c/HQxwu6lu1WDFtbdcRJ+PlaSxiOpeRavcej4ya2xFW8w1VOwVq7fX790aCz8D+Vx5AQjyX+Yy8ItHqJze3xYisiIyll6+pGZBU/0xk6/NjZhWDAPeroQppoh5e8JqmJU5vhzDPOIbvTvbvwKXmY7BNxEMLQWYs/s2IssGTiefHMABu1qV3YnNNtNPs9EDbTnN7OXAa0sDbUyj1PbSue95mcGtHmlFrFyLWEfPf9MhGmZ1IQHBwK6rV2GUcDjjWTtCG4lacFTWi24IloDDKBjYBuv4ellqPZ0MwtyktsK9l29CACSYdqrtg/1UJtfDfIolt4qqYbN6oBSI+UcAL2B64Df21jHEvBTywjnfYYnhugx+uW1+ZjVG8pMUq2UkEbK6p3UVEir/tfieKEFc07JwPpL0cIAA0+/9u8xxFrIntYD+NZPjvEsMloDbDAsVypch8p4G1ZqTjNaLnOgihiOkisyaTs8hOpLsKTYSwXE2SJk0WmSeEpq8MhSNnXS1aPU0oRhizZR+pItikB6yhbCTw7CZ8zqF+VIagc+6rFjiEHzTlW2sidkHI0hZL3Sqfciu4kbqCBaw5/qGlR3lderrnpfgVUlblhr8iALegqWk5R1wOCrJpEFXfm9jP2ROlE48BTytfyCjuBnc6lNATun0L56bYBeYO+6pYioutSItcct4cnjuYZnK38mVK50IsYk8xxJDLIbOnTAKpx3wo6804ArpQiYA0bccpyER3cKurltAWb4I8UAnijWkQWSjkU0lE2/BxpdHgCGVCUiKjzDiB/aBx19achndP/bpdHcKeQ4H29RpH0KutgnPPh9IjfYd/hwzUdiwCuOcmwpwGvk9r4VYPn8d+4iQYIQE0Wz1H8jy8nvfMnKAw+2Kn7rOJ5+ZyxFj2TQUngLyyODFRU4Ur+QdM+hfraWc6fgWlC3uFC1Bnt9ESt0SowwIk0ColYI7MORRLqLrFxO/QBtWw/nhQQDU3VGG0uofSpCnXl7EOKKLZ3tI7w2NkOJtSGogu18YnvMfa3tMXOhm5CMZ1Tj4iAvLcAW4e+BPjRZ2KGngrUV10jeud18NmJeRPgG4Azr3d3NqU1B3admSMDy0XsNkiWQVKxo+XXNWh9Wus4TXyjMzFhKzmMx2Jw3qWx6eAYU8feAQ9du5Y3qKrezOaojH4xfyt57gB1hfQYLfvOiThgh4Z1gV17/Sgk1qPl3Vp7c8PayF0LEQYYPh3VVrfcILUNkPSU=','system','2016-04-13 18:46:34','system','2024-04-22 14:01:19'),('5a2c942d-f0fe-4993-a717-189622c49926','7ad62dc6-56e4-57bb-218f-349ed1097ad9','buypassclass3ca','buypassclass3ca','1',NULL,4096,'R',NULL,'Buypass Class 3 Root CA','Buypass Class 3 Root CA','2040-10-26 08:28:58','DA:FA:F7:FA:66:84:EC:06:8F:14:50:BD:C7:C2:81:A5:BC:A9:64:57','3D:3B:18:9E:2C:64:5A:E8:D5:88:CE:0E:F9:37:C2:EC',_binary '*1:QmSrIXEZwSnZK9kF+7k79xjrcwDgKk/4msbOx2Hv1QDTNa8f9gBNlAUb9QtsZpdYNIcrXBEcFzOvG5OIS8to7sQxJaTtkadYD/5sER3/PFsR+agZL/tl6IwnUHQwMO+C5n1MPoZskF5xkMo6AtVa4oXKeTVdDlxHIr9WWfIERGquXQISvwWsg7vlt6pqCTzLlFc8u+71HuAtkOVNHhJtYpdSeATJL/Wg/9/AnMCR6wz24/Pxer1B3vhqm7eFEIDBezEvbOUWRrBq1YBFgwa3iHujMoET/SR84q6q2mRBRsy2iEJxObLZ0aqOnlyyWCfqzTCrrpWtIiGA2Qx8yBj8mk/dblCW+f0VEOb5jG4jiwdHIrJgRsubK1ETEeQWSlnX+03djdQoCireTdBiubay/GV0caTv5yTrO+ovGKfcalZmtxgvuWRnG16UAXq/8sRnPZyPaoDuHVl9GsDWkvYM7GLXFxZpWlzPFe3ROUjm4ywVRi13LauS4n+P5eKRKi68hgI5unkw6zo5KChpgwJ/VT/ip+PLWm9GGbp4p7RI7RawUlSqW+KL7E4yjQOxjAO1J1sa5BKFbW9G7xW0mnCE8Yo3dP1H+8Q9APExU55vkGq+x3NaR47MZpBxcvLakKzI6dhfRF9r/G7diwy8BVp5x4aq0vYeo7M+2nRdP3/YvWfL+qbdu7Mxczi8OKybZdAYrEFFVyKcf1dZHKNu922bPPmVmq3NC5BanRH7WUR0PwAxbZmMfMEUINa5RZJJFQn/28Salg049CRbK7lIiLwH3ICxl8CT2NBb7DusZGAlWc8RJ+tPAmW++OX3NWCdpvSCtkrd79KgE0dinBsWy3aSTmKsFIotCG8PXGU6lqGWy16x79uhQZ0OStfJ+0l7I9ieCLerdHqCooc8FcwUyMGs7P1pllZLcKDH56JQZCtpXpOIQnGYlIP1eZC3L5bAleZyOPZIU+AO5DEOnvxwh9fgZQW0WLUeCx33Us4DpHDbiII3V/gIRYpsJ4hngGl42hr7HrQKtPol6cJGfVo7BWTxdMFfq/MzkWIPPIKnxoubAMrXttHy0cf8pD9MbRB24vHgKnVJanEZAu4JfgbEgUAyYWU5rLMVIawCq8aPrL9SzLZDAre+2PGSb6EGBQG/umK+WvjLrX74qmU7neblhO9XbvxL8eU5dHb08QAseIAtDG1LpZCx4/rOJyTo1tFjU7g7cHVQcNq6yjtZc8CZilZ+VEIm9sPvHbGdfIVnrr0klfaQ0ng4pE+MYvAdnXk4l6wVPGdOyNnW8hcUansI+ca4RfWC0Xnfi4XI5C7K+EFWLOtEpoB6pxCLnivlq8pqi1m4Opi7mJxX7HdtHza9Dt78S+qO8IOtt2Z/tTabUWPJe0kNHc88POuXq/OwOLoD7sNbZdeE4CLXCv61VgBmrVHJJ8ZqqS5Rov+18sz3YVw7Q6YpbcO67+MhXNAQUJKzqL5wNXVZOXORkSKeqpDi/TM1hJwPQNQLlvc48VwRIWjdtRcMLRoRq8CEPBITniiRjbk+NEywljq2K7FPSChiqeByaXJQuSPaavdnHNuQFZ26ED6ZtJ2aeAHmPsgbIEVjITxMjicQsOMwCdLcDhrpn6EchnvycPOnoxAGRXyOeh25JU5cqbTzQkxtRO41VDAdrmW6qxRTSAufIz2OMAOh4hJIf0u3wPM5Lslp+XEJhMSBsdy+ki0/GYqCLmmEWPGYEVuKC93Ni234LTtHO6z5/KvDlUphP80CU4R1xFN1a2PfwDj9B07BVBcIG02Cdonbv7NrZlKtbBtQemyllbg/HxfTO+Y8PrzOYe+O9A2IFzmyJNw=','system','2016-04-13 18:46:31','system','2024-04-22 14:01:19'),('5db0af21-b2e3-4f73-9084-3b3308160211','7ad62dc6-56e4-57bb-218f-349ed1097ad9','geotrustuniversalca','geotrustuniversalca','1',NULL,4096,'R',NULL,'GeoTrust Universal CA','GeoTrust Universal CA','2029-03-04 05:00:00','E6:21:F3:35:43:79:05:9A:4B:68:30:9D:8A:2F:74:22:15:87:EC:79','92:65:58:8B:A2:1A:31:72:73:68:5C:B4:A5:7A:07:48',_binary '*1:GoTL7DYUMXWFJ4BoKGu1tLQy8Od2rpv+v7jMh12JZdzRT79tOpDv7DzN4mf1upw9RnXetj6gam3CsidjGCIsuDSY/saQxkvtiNPPhvBAk8uzSZ6eJkig0Zuwt8Rn51Stcjw+8cCPgqB1qTp2Z2Cv/W/LCthabujUr0DekoWOTLGgTJttEu8OsZOK5vbc2FEgsPvhvCh2ion0/dm69qOz60C5n/MJS+i4RnB3xLzri4Pa5MXRrzvI02YwcrElL8f+pOdwX+G3N67yDjrfZI1rpY0wZtCptvb4Fn1PUzLeulq8ePUlzV/prUtlFfMmEc+AcCArC14djsjSOV0iAsPz2/Ml3sZdT0oxLUJGOxz5OqFQEwYXZIQvmJSksc18lEZCyXqXNlbRbHzCjUQH8Re8nIbtubXZM5P1cqEwVWdXPAAgdTGd8nG13hr0XXyqxFoX+VzEprLTxh7VKs5vVUmB0QWJIxBaM6ixE+wdGK8RnoCQy1YRIFvuGmhl3Z203Uw3O+v36fvAY1hsx95PPN+bEQUn1NoyA0pIA+y6gH25gn8f+APnCJqv99MBgZhQsmomw7pSnJ/2z6CKMr/etSgsuGaCR3ixNNjbJamQv4Xde40eLSrya/aG8rc9AAZ+KYnrZKDNfoQFYPR12llkMndfD6CJn02jsI2Rkwwcz6lL6RSX7hOliYVE4dNvr9xp+mStWU8U92VvPzQoTxn50LaEVXcoFbFPUPYd/LALXwhSCKjLoVZaTDVSHXYaTd/ludMEYdaW046xLaHBHbPJL1SKJi6dlTa9mdrm8LvkqyYCZe1RXE9FvqpfOWpbKN8buNpcF+GBtrvtSWD01LoVu32Sjbf6ReQP2MmH5Al1BcLqsO1wnnCRQcw3HxkxZaQQxRsnGFWfKc15xMK+6dSvQPO9cq+k5vPj0YCYIfk7ywMnlHLVW++aJsMOLRn2h5DM+7yFGInZZkHWhMxwmf1EdAa/Sx7eAnnklwEAxP265PotH1+hgzxeJqaPXt7Wf4R/stLiuccCI/gGnTBdf7n4glr+0vGz37glJHhCpgnQ+cGZkrf3UWoiWLFLgh8ds5IsZ2vDSMA+boFtHTWItX3LU+vxR57gBgtjPtmJGFx5UtqdxJFa2hTxjFxp+N10/qcSmm4tZl1RUs8jmHTqKPQRlC+fhuIs/Q/PY+rivVJkahdxPnbB1fWvKbdGC9dp3oTLYCCgP+D4CFHv/jnadlBuqAJxAj5wWWzpfaJdq33Rlahp22V/xy+YCAop61fqnX72B6kXKUaZPDyr6YaW7ioK/zVc+m0a78RduI19VzGI+4ZmIlMimT7dsbMioP7cZ6LI6BBIjHD1eFVexrMo4idv3ApQjvltG9dJRlTFPxpFc1cFaSBP6VjAyjLhfDUsW33zV7TGOP25zD/yDjH6CdumZdN47yYqC6pMT3K26xM75+IehIOwII35Tr68+P3GWknn6yZPDzxEN8x5tqG9fIH8Oe4pkJyZuJk7Y1j5imINoKm3BMJC1CUleuAOwSAU3koUNwGUv7vfCq04E1B6GoYqF74SbQM4KeqLDGw6YmNW63iuCtOJXRTIYmMPUi4dJdWMfXrgUXQ+RWbYeI9aqSLuffz4J2JJlb9CMdb0feAOelLEAPzlZX2z60QPvQGEHf49UCTzlUx7+maTmOhm8nMDRbN3dk6/JzEYfzKPXL7a0cFA2HMMY/TjIZna+XtjAp0nPSnVGo/u8VITbpG1awq3C0PIH6cK2ZB6C7/AT6GJylhFYAtBsY6CNeYZ+OPNX3cpXy/ZZioHLWBuAwRLdug3UM+XqeMMpwPjsWXfJKhCTncJ3IBCWD2RhfRX3BdJl7Kpb+XS','system','2016-04-13 18:46:30','system','2024-04-22 14:01:19'),('6332ee2d-1349-44bc-9b05-1c0c34769b79','7ad62dc6-56e4-57bb-218f-349ed1097ad9','quovadisrootca3','quovadisrootca3','1',NULL,4096,'R',NULL,'QuoVadis Root CA 3','QuoVadis Root CA 3','2031-11-24 19:06:44','1F:49:14:F7:D8:74:95:1D:DD:AE:02:C0:BE:FD:3A:2D:82:75:51:85','31:85:3C:62:94:97:63:B9:AA:FD:89:4E:AF:6F:E0:CF',_binary '*1:6WYo+Dk3BxXkHJ9HU8s7djSplBUo753Jw6PT8pqMPJDaQOzotbrbWEZmhwlOeco53bGc68OcNbT83EZhIFp4gSndCDoy0stSRIkS96Ws2redxJqWdcpy8pSweg4u7vhqi/Moad7pvtaBDyjoa2N3u/pAkp2pTy6Vd/gEiJVOwczT0qs58TRRo3kNjucWJ1jwVFnNjP16OYgr0Z/2Grd2t2mTLg5jaBRuFvTt2JV7qam71CAGOg6DlhhwPZ+WV+jMC9/Z8UqOwMzHDTI7Qy1i+eiGfgYXNg9YKL8muDdTEvlHt2Hws/rBR+468zNNKZldR/0HIhrRgW4XFtPVBn+i1/odZVCz+v3IZOLFRh0WvODEs8Kjj4odW1cGn+f9OKB2vpS8wQ27NiZb5CsX0pD1aIJG6N8HXTBgPfGEItnSh86HA3Tw9C94geeqcoOV5f4kCVLsy1F0UqT8XVRclSryVsDwlWORUKQXNyPPlY/XXD307Is+qzGHBRGxqaVuDt1MUFsc2UBSSa0Ca2CNkE+8YfxvAD0UyNTGlXq55/MNpgL7X4YtgGDy9dHSkhWJ0StM0BWQJz1l21Tl6vqNa86cwYWcJdmxg/7HIzUQuJL2ROfevhq7eIe+dnmwEqGBYxM25zwL450zTjKCWegcRg6iWoP8pD5bbraRc7nGzpRM1PR1TmSzizQC1uDA3qLb3w4oNndr9AG56R6pKSTDhryGWZlXePJ7L2IHB7GzsewxVF1Y2ydu86Nxss8WLobLYQdDA5EfF97MtLXphnD5PN8oRqpQ3QciRf+6grs7t1Lv2FIViLuAScC+EUjafUcKV478+O086cRT4O57AIdCsrCTJuCcocTczcW24F05VS4+1BTaHa67fMsi2Dq24eZcszre+QHZWV+rXrD6XkJZPyF6zOHDJzXBbgdzg8teD7xOkwG6+ghsaWOYzZWGgpFwZpZVYfH3lJefGPHbz7RhgP6woLVveLP4CcesS1PXCv7cHV/CgEjhafE3KJNLHRrtL0i78njzHz2Zi9MB41kJ6UUsl/Y3CkfhKunfnYq20CANDhOOUky3suTQf4ktZ97CQLc54V4Sf6W7QHbJA/X4zDwgJFRxfladNz8VQ7pFjbhusJlNv3ip7pQZRfj/jAXmQzzsjqGeLwT+rouYoAKCxtfldil4oEBe766j4lsKRYiFcrV+u9OpmAb3PYHgYF/W9pfPqoBjJMQXnO7LF50uq9Q9aOxY2ibgBmtvcY9WiCKzKBExDC9y9QabRF1hWw3/QE/Bq/cH1Tet/YV+a+2KLq5xz8zGZIRtpRagQQIHDPi0K8Q6NzKuQT1G1KWNFQ1Pjuo9ruSSzkHgzFXGIQss6uB7x6gW0E2c+8A3/tGmRn1GuRwTdmqc23tth/piR9WY6w6qQudOD/zuIuZgDCzGIMOs69+hxcmFjRU+iuRzC/Rq4sLhxukxz4mILY9dHSRBjq7ZRhCmaS+Np7aJZABCCLJSr/1SALZ9+toG0yZ5hNPNVhCw0+h/JC/TJerOLn0m6D6Q+hYQAulLyJUka5h9oXVMeFmYhvmF8jt50TS5BdubSx4DqRBjHcwzH4XWl31UUcESRlt/XFEJC/4Dq/FTvzT6seMB74OCqeMmDdbRHxyyBOISpmeswUSk7VhcvmzYBsQF3XeH0SXbKfG1WEhoh7wAWf26FWGoFQjF6UoZxFmo+VglRH599zteQnj9wTpYspSfK+MyIoB7r/cZd6DMeWEc/lfpcJCEgwyh8liBj+ChLyEksdZF3S0MmGjHtg8FTcw2OU+3x1aG2joj6YhmJNG4uXl1eQYl99EeWB0rp4cOjsEKP5eZElynhe6/acqpBMND+fPeyfPQRzVMbhwVkg5MqPgMnCYYkLpdhwH8+j/iERclqzVTFG0R08TcMAyt8ZQPxJpUA67iiMzXQYAls3vG/PMp4Q28p/fD5MDo8GVqJtzf1qjCpvnmLjELaJqYlkj1TtMckHQJXiqQLWaSHhybuNzmK4DLu8uvfuxaOsUxD43mTjjNtOWsI8JBB5Aup8dPBZT2HQQhg+tk/4SvT1rGaHFwUXkU3hcv9oY+yaoVzNbxEgwnfFF7SxumaW8He7osAhXQe4Nhj6bvNw/lauOfilfYpK4C0/AYkxO4nVIgnwEMbLCpJ6sU76tqKoldUfJOWA9TCDKvdnRh9evVzLc/Hr78ToOuLXzIQW2XK3S+QxgbHeu5h4Ev0TTZOogExOjDIEjIDhZ4JOiJiobz5nMNIv3x77dFWx8w5P8EmF6Fhp8=','system','2016-04-13 18:46:28','system','2024-04-22 14:01:19'),('648980f6-5dde-47c1-8fe6-5f0bcc4cdb47','7ad62dc6-56e4-57bb-218f-349ed1097ad9','addtrustqualifiedca','addtrustqualifiedca','1',NULL,2048,'R',NULL,'AddTrust Qualified CA Root','AddTrust Qualified CA Root','2020-05-30 10:44:50','4D:23:78:EC:91:95:39:B5:00:7F:75:8F:03:3B:21:1E:C5:4D:8B:CF','27:EC:39:47:CD:DA:5A:AF:E2:9A:01:65:21:A9:4C:BB',_binary '*1:GPUQ7AJ+uXa5LsruraXKROXp4k9ZgasT2pzeGoGXdQlcjJySv2ds+RvYXJ+GY4NyHey4rndjL0yiz3E+Ou29CyYAU4c7N3mx3KRFRXl5v9BljUspXHTckNdONoQfDCtU1GejqdjcV0DRLrCwH/REelZePWiozUpDs/w/77FWXAsPXXGw6XrKAJuwrj+LJZ/YRvo8JMGl066A5D0U3MbofRotKJD6UIsf91UpFtMGUmiE1wT3+YuBtCcAd2MpN3oB3g8x18hV+ONAkjkWy5bL6Qttoy6aYgWaPgc5X0cgPVqw70NmS0RqXz/XKRZR0epMO6DTtT/KFgCT5e9pN69+0Zm+8r53heEtNR8TCBk7J3xlA01A73zU66bpZUa+bNqdow5/mUAyPCoWNAzuqzYgxUmRV7sBxhk7lWgTy0XByJ1Mo/+ZxEvFvGj38yThtzbDPhn9mzWuWn9Tz+b3Ka9/5ZEjJK4FybKoeNxSX6StKfM5LWKnC63YJu72OXaLOB64sW5Ds3r8XZy0mxchkYmudfWla13eVF0iOVz5AbLwYGURLJ/b8fJvraVsRyvJVqiud8cIO2615Q2ITrYARJCKnIsXuURvywG6YS+aT3zJxrVpMYF46nZ0QYsqJVUU0ztbSQuxyBMHOMxt0KkIQ/p/NsAAOvw788JV392dwxfFNbjzUbboH57imnpqojU1CoGO5Lk356cD0IHAeyFLujJNjWPVRVvZ4uyFAV4gq+YGlsG1ENIVIxaqvKL75lZ3gSn90WDm18wYSDanZWJ+k78kWNYrAoJVRxge+NB4qP0lh1PKEi1A6Mi4aVzo/lvTNg+zXZHC+m8de+zjy98ZTvfdcYetuIjh46jNII7x3bI4uAGXneIJc44QryEksgOdX8owtCTeSN3mK7Tfh+UOiStIl1VcejrpF0JFgR1AyqrWrnTVpbPicDVksY/JqAqn1WFgLeBsQij+Ia6qdSj8c9E8GSRgpGpk4BLHBX2WteTfEQntNInaQGIDq9rKk++tphlw22Ote9N8ZTX97twy3jiObYAlFF8C+FiLXW9HfnxB8LvKGxdjd3NPLGexVAeH4YQgEXug1s3TnRzqe6Sn8HUI4/RGlXfpXWOxWJdNzdSFcZeTvjxQS/D6ZF7E4h8wpBm+4QOH7MIHQBhsLxAzONSfZCBiyaOY0pfgF+3PfGv2oq1ctPMevKjABa9sjWMspCap2wT481ncVvHDSJNcC7G7Mjcl7e3qlV747QyraD+iFPGJfDhGMua+RNDnbHlvQNQWAEISXpUl4WhQrJOhNzWLd5PTkncBLGfDrrXu1ccBOyD6wflKN7PuE15Ae0PO9wMBhPt4fdr+FetlrGmqDkVVAyVni4YirV/zvfSMbDEexLzzb7SF6Whw2QhgKOd5b2HTc0dZpXuP6kYDEFfGFFknDA==','system','2016-04-13 18:46:43','system','2024-04-22 14:01:19'),('64fbf8c9-0949-448e-9de2-a99539df9f01','7ad62dc6-56e4-57bb-218f-349ed1097ad9','comodoeccca','comodoeccca','1',NULL,0,'E',NULL,'COMODO ECC Certification Authority','COMODO ECC Certification Authority','2038-01-18 23:59:59','9F:74:4E:9F:2B:4D:BA:EC:0F:31:2C:50:B6:56:3B:8E:2D:93:C3:11','7C:62:FF:74:9D:31:53:5E:68:4A:D5:78:AA:1E:BF:23',_binary '*1:CPNKNOtc0z27htmiu7WooLjpzKFbv/DKA7KYiYtzThsXwmlNxU06os11ulZA1Kd9Ko0l4ITi5stccpohiyABoIBRteFB6je9ZfSvbwq5g/VUPDWHr7D+m2QypqUrwJcIN2UzM2OjExwUIgdDk36IMsb5ALwycpNQId7aAWNFsbJHcV5uHNA02Q05P/MJReXj2Ca54fkEuOZpxFwPH/wJtRlsPOviTjkMoKIlpp0+Wjyku1LJTRL5Qym4bqRVrxcffFzUPKlDn76Q4BrmVnmBdZQIOnV7J9Q1WpcFZ1sgURT4UdVOLxi9MgP7qibOgt/ZCb8iSi6GtzkunYFu/rAHwM6IVsRnb/bUsx1B/54hxU/RLxOEi+liTI6DrHWKGFEQuPaqoPqqajzsFLUHaEhjQnPzXyNKCnjgKe1xnhpq5GUujv058riRSuZIyx4T2OJx6TkgYga0Isv4rmSVzZcwslREJ/gGEKr19CDiawYiyRM+YIKNkbzJwctS+6GVkgfrJ3f1eme4f0ugjXRqkysfJ1SoaOcFCi3JkCZakFSpDSw5rur0bZb3ObwFMnPX+NFKX0Beopz37UVpkzSRZJr4YgEGoTa5PQyi+Pt0AwyFcdBquxrkXmBY6vkpyptP+PuAyGY1AjpC9yMKsRROBGoiy+LgetagMFExzxRCn9L6UV8BVIReUWxMBv9pR4Cw0619CxzSXKssWNvTs17fStbQ/pUgpnk1RRYUyPjz4AE4toQ9IPkvW/L8QcN5jDHSrpgPfnzYnIUkiw84veEpvY3kG21nZQc0vZCxOE6Z7wWUxlGSYh2wOSEsxyE7B50MjUrstNjSMwGfYe3T7L+PxY3fH/THmGJBirlBj5ss7YcpCco=','system','2016-04-13 18:46:49','system','2024-04-22 14:01:19'),('669e3482-7846-4d04-8894-939d68b295c1','7ad62dc6-56e4-57bb-218f-349ed1097ad9','affirmtrustpremiumca','affirmtrustpremiumca','1',NULL,4096,'R',NULL,'AffirmTrust Premium','AffirmTrust Premium','2040-12-31 14:10:36','D8:A6:33:2C:E0:03:6F:B1:85:F6:63:4F:7D:6A:06:65:26:32:28:27','C4:5D:0E:48:B6:AC:28:30:4E:0A:BC:F9:38:16:87:57',_binary '*1:KRk0QaE3WvVFs+A3WyEZjXLHTAC2XYiuRI5oi4gfz3AQFavcbFAXmyoL7oOm3b+L4HO3H/BpAf1ZN8EQnUOlIJ4w+2rxkOcNQyyZQE4jaOpJjsev05Rd+GfXmLO/qkqcPRIcE0vGkJpBArncmzklg+RErWU2Jvb2IhPiSVm4rH/uEe8nOoP9GlsJWhO7m72pItYMDSsXsjsWd4JBDXI1m3MBrW6KxQgLyvlw8F2KOld2uKnL5oLgRokvf6O3XL0GNFdkhD8sn9q+CdFJmw0tsInyGhB5yzwI0AvlyE4bQjYKnKtuYrD9+HiKJriAh+tlSks8vH//NlCqyNzYXfCkiI7sfXBFFm/qoI4MvJjjiLIrAIamPbUeYpXVxrEeVBHUHHCLTxM+RF1qJD5CGY80MmxgoSoJhvysBLhx+6kFhH7sOcPWvi1t1FEHruxcgIc/5PG8kND/6uXUva1ZAq5Oa/wV1m5QDBHC4Am3xu1TEcb+v832mp8sj8SATMhZbeHvhyIBhngGwRsLqEmetxz/LsWFniPztoYHPw+O+92xbhmq3qK6p28z8dEufHr1JroNiG3904pi63QZXMgLKAmq43AT3lfosq/rxEz8jzxRY/DFdg8O3TRQUMB+YAIb2hn9pNoFKQ6/f0vbenyWp3MimCI4ammZh29l/CoyT/zc/MaIRc/zNFfSBhQ4HbuxbzJebPRLXQUPuPMDo8Nc15cX5Gar+gAmu7huRHLr8TsgE/hx0rj7UTk6bhlr7gxMWYHMBl0pJP/6rCXLJZD8bhYTrkHvzV9fVPZ26ivjrkavK2ANBvmm4jyr1v4oIh3TPda5woiZJXp0LJ5QiLNi1CtktT9xP5kwt+enQPfLrZecQBwXswuIf9Hr84EX+Vw3Km3Egwqu6vWreWGzCCBvdJjMyZGioLTnUSN3uMJepi92VENKzU+kYcBZSV0w/boxfR8CD+I19SwrwDmO62lU2XKvnQBs+9TSCfio+q17LAvyAuJ4360J0gd+03JUNKz4GMuF4274qjT8Zw6qp/+x12Yt9jNvfC4e8s+vzVggSL0Rh5TwjU0O9hSXU5t7088owHCh9+x2reGlzVhn/LwGjepSLIdWU2VcW7GUMC7n7f9x0/++PLtIvvqwIkxJsiOBcu3epFPc2z7Mgf+hQzeN5PE6TAziy86D55iJzLqgrixCcc67QchCXXfyRgsas0bQ70gZfgy3WXSX7lgAfcqBJo211MvcWp9KhJJqfy+uFplDfYHpgR010S5uG9QzpxAdw9Dt+F3SoGHXt1f6x1jeuU163ZvIRfzOqHRYrE9hyowfxTieEnoM2Z9MPLdBsu4+jdyVcXykwgsV386Tdfbyl73pDsfu8kRs2oHTDVy7Pne1JRtQjSxxzr0+xI9c+YMbUjVuuBo0ZGfEv38zoKJvQSEglpJa1MfxdKAuINSbSzxLjlXdVtewTuMpzlvrrSUo/Db4P83jhLTXv80hzBzndVqCb9QtBUdOdV9nWCqbWr9Yoc5MZMLdg2txkPdZRKIYfPukfPuQcuLVsJFzXRz5PR0UuLbTtaxSu2i8k42kDN8KDGwbr22bdrPgRujd2u70ieEyYE5DZREcLkUhoZE6ef7bj/Nruyxtrrx+AxtJO+Q84ihdNQ2bWZPcGrqjRMEvsRHX5Ry5mDfe6pG3q0NFE68Yfkvbgaq9T43Yfjgx46re3auYVdA+QqnoiMW1UmuQwoy/P/wtEy3hJbunpHrwtR8ZJBCdn5CrPwmJbDipX35Wiu8oy62EMRJwIgkUJUsz2VWGRK/X6X/iEevpB7pTZAiOGQ==','system','2016-04-13 18:46:48','system','2024-04-22 14:01:19'),('672e226e-c98a-477c-a155-ffbe63853744','7ad62dc6-56e4-57bb-218f-349ed1097ad9','affirmtrustnetworkingca','affirmtrustnetworkingca','1',NULL,2048,'R',NULL,'AffirmTrust Networking','AffirmTrust Networking','2030-12-31 14:08:24','29:36:21:02:8B:20:ED:02:F5:66:C5:32:D1:D6:ED:90:9F:45:00:2F','42:65:CA:BE:01:9A:9A:4C:A9:8C:41:49:CD:C0:D5:7F',_binary '*1:W2DZvBu7etSV/TksgnDYqz4yhpQwit9Mi5mxk1VUXP7eWu255LnaImNSGumUqFHUKnoe7AY+5RyYwKbZJKWhhY59cGbktYDbwQ2G1iFmYgzgQ3EdCcqXCXJcElP7tgyqifzgRZ6qa10eLbpfJVSTGn+mFeGtql1vZ7QvpHYWbxfD7ZRfpdWh6SnyDR4WEIlCq6sym6acIZWHyWjd9Zo/s//IEPL7RB6D3X1s1t3SZfaVXvxBSygvZHM+xZi8qh7AqiuZb2OAh0JNcoHm1W4JDzZmyNxmdFxwlNMgdcAc+eehveylnvb+98VuzTKT5cQq32o27NaN40yddnX/TwkT4dSFhDILfrITEu+OdzDAlzejDbPXjUPOt5UtyEuJepdioGvONBnhTiE372ILJ29m4BjR5PoL7LAB52p44ju8xUmBBqjHMRh/PRprcQn+vFXssSdrDjz6FhtaXa+zCVi4n22ujIQdltckpYplnfBKjMayxD58mqSlgTkoZPhsqcjG2OU3UeRM11vORBI83DJXYFes7VtDGYQr2OZZ/tZIEt+8JMhyoF1FgNrHVrKhbsUwHy/ZyKiEqxZiA0nh/YO8BQuUOO2NA4fQcNXfoYcwVOeOgirSebhepQqCnPbZAz0w1tZBHP9p3UPSrrV+J57Z7N8gxXC/NMT1KuhAxHjoqVeeJGC4VeJ0rSBU0eRSOIncofsLOIlG4XRXvddvrhD+F0JVeY6Hx2FUSc4bEKllfnVtP9gObFO5EnUTL2cH528h1g3OXLNRXtUU/K/ROpm9h/Aq/3OmZAnULNxf+5k2ONwkyKEpwQtYIqHkj/cRipj85VOZ4rNKruBFxk/VLDj34KGcpuQhHzlCFfY2bR72NqvHaxBBQW3Cwbfug6m9hOVhopAHlepdDCBGYADOKf8b/Mm9kOep0QQkUpD0vr7p3ZdL/sT3rKKy93sEwWYpIXnikIRQY6b6+/RU1RwtGikgO9Koui4meq0U9fjPn+8lzaHNi2VsfxZXvzcelJeW7VpP5fLC4o1wCoRdKxyvWpn1Hl51XNxroP3NtBhDz65j743GiAnvg4TU7xZk8K7fXG37ClzjGzdFZVoSqTquEefuNUP8OVew5jlu8S9l2G1aPDkKi0uDz4nGqBH+XAUneUMt','system','2016-04-13 18:46:26','system','2024-04-22 14:01:19'),('6c0dc05d-afdc-4634-b7ff-cd31954bf78b','7ad62dc6-56e4-57bb-218f-349ed1097ad9','verisignclass3g3ca','verisignclass3g3ca','1',NULL,2048,'R',NULL,'VeriSign Class 3 Public Primary Certification Authority - G3','VeriSign Class 3 Public Primary Certification Authority - G3','2036-07-16 23:59:59','13:2D:0D:45:53:4B:69:97:CD:B2:D5:C3:39:E2:55:76:60:9B:5C:C6','CD:68:B6:A7:C7:C4:CE:75:E0:1D:4F:57:44:61:92:09',_binary '*1:XT77AhZqDvCgkTOZOp6w7tnnMI7JfPxJR+/RjeFoeCVCG9w0Kl0fEDq9jESYgngL8DBXczEAihvcKuEA/EYoFi1KK3Nctm/7iW120kq+dyUucxbEwOisEzdf7upZt7KINZwSOvSE54CGkUYvamIUphaJT/enWSHqyDFhynsh5RDoBMVJWn52Bf6vcpi/JBcYbHdlvS8etsTJAZsf7JD9g4ASTyCMIDu+AAlUp6xFZP39RmWsRIxwjfJX4bi/t4CiFGMrXD1w3fnoyMUuttBRppkkcHrO9pQEGr2FErZHlHBdmRRr7scbwZ/7ohrBxOzAlOnFuLOw8dgS3KaSr766FBWDV8bwdLWLlVbj8fb5Jqx2K+mrpCDZ+pKsK38OvfoYHWPZukSDe9D/Em6O/06P3JDOsWaeF6xoauLw+0HnPoHk4oKeyGdZdqJknLOLOQi6A9JLpnBPkzu13+KsL5vlx9U5LCkvl2Ax3hP2Q6FCAAbccknjx9gibcfUytuaQbrdlGMjMx14fV7ugUiF7Y1hR22qYTD2tGRcGyYHmkQOkBTguSarSVt8lls7Z2Cib+lG84L50GE+shGUJVysomyBOqyWYjAMUBaWbROeeL4b877MCm5OODMzdB49Vc0kqkJhLW8qT09yIkerzQKRO7h07GFn3zbBkXhXchLq/J+00fsVvfJfSFSEvZ8SeeN1chhGwlL1U6TEPtXELfHDguk57yG3mkP7eMz4EjY4VwqQfP4UuaGoLnV9GjYHl20c62y3GszshuqzxcFAi7YXed4qUz5+i6pyzFHnzxNzRhbhJ78ZEJshE8bazzjfjiZuUCeYwShH8bm3Iy4fGQh1o46kb0DyFrgH6mj8KeDE8KB6v+w1safk212wpxgRHViJCLoqRlQ6XnI3fiUjY8SDxnYkxhXVVmviJ5eT18Py+7ZaP0YuiVD7sXgImwc2jLekj3ovhRIHWESPIM+DcV0IXouxJjE4TjE8i3/0z16uGYxxUAJUU3Er3t1zZzcFARhtJIPouoqRFE4sr5z4k3xx4WxEYRp1ZPCZYQHU+fMwupny+JTAszk1CXCk2GGaD4YR3b1LMcWV8LBtdS2XL+r/NnZcjDw36v1KBH2E2vzMklJGkzQYCeWCyzWSn4PEHfqwR1BOSQrPDFyQywe2RFBUUDzYkHSQgmYhfamzCSHHFB3ab91+gEC855KV18mQn4vsY7J1wxH6vzrChiGmqi47s4eBJBcLF7LZiUa9X++btyGb+x8oVj87Tw1UEI7icJDpHGkpRRGs60SfD4HFB1QDD856n7vDiyp+HhZQQ0i/clordbmySjeZmzSdkCqemy5FXgSKUD/bA5sBnLwB5ZbIJH4Xtb1D4w/QJb0fMdoBXDQPPFxPBeE+ui56vudSx40AsOez','system','2016-04-13 18:46:36','system','2024-04-22 14:01:19'),('6d5dde1d-6749-4320-8e50-3f22ffb2b0be','7ad62dc6-56e4-57bb-218f-349ed1097ad9','secomscrootca1','secomscrootca1','1',NULL,2048,'R',NULL,'Security Communication RootCA1','Security Communication RootCA1','2023-09-30 04:20:49','36:B1:2B:49:F9:81:9E:D7:4C:9E:BC:38:0F:C6:56:8F:5D:AC:B2:F7','F1:BC:63:6A:54:E0:B5:27:F5:CD:E7:1A:E3:4D:6E:4A',_binary '*1:B45X+3iKzoF3pTzsnZvugnujZ7DV2bQa9T5GkaATrOxqlZq2IXjpzmT8tFKKdjZ7/3agcjVnXbudq/v/gsCXsA1ozYrytSzwu1AIwi2qewI/OR0/XjvWOVz79kxnilzOrHuYpwMpLSq6Mu9NSGLXqf5YdCqPSb6KSxexfXmPwBHDytMZklwAI71O2gxcDJskrN1XkfIA8bxwB7SdbJq+AUss6XRAAURjm4B7fuhX/vHADBoXav1JJTQadgEGw1tvPHdZvX2vxQKFkEkDyjIZlVYUOCZZp50Swjnzm4tpfiFd44jBJR9V5NxKHCg65Ydp2fDM5TMRsp86XERj2C7vPnTwo2e7zhWO3f3HlNAfRwkVJfz4HGwWT/vEax0KgNYyxHY+fvfb5vyASLvKG1oTY5dDNwPWP0appgwyaQlMHtFxXWv7WOAXb3T0ABOufbd3qkG7n72X2RJK3ogHY5Bnm38C/sD1FBl40HYzxSDtTUwTxpRY2NDGWNFj01LL6df1XYocGf0an+Mlut1F/gZV9aErH+75MzxnyvsPOo5dVBvNAMBE+Fyzrb1nQRWSYqAHTBIn9ZMmN0eGTQVDTJjfaKBBgyVIVKWM7kLKJBpHI/o8UvFyDaao4Z1kXy4nH3f57REFIURuJVx/IqdemPY7NHz4jYa1rkVEiPN0an82nS9Bp6kH1KdMZxTbi7icoQH8Jb0y7F/4/Vr+n+/QspkNZ5dPO/MrqD0hdYq61rZFGzMqsajulm0mGZyAYfog8Iq12Mn1H3pwZH1kpzFhquMcctyTyRTy1FOiqAGnEPwTcQRcCuDC+5wp/JI89igHroTtAM7VMCNgDrr1ygQxY7+HRujbh27M7oyADQBgNY1XEiiV+J6yXhTREsTXmbYv1Yg2DD8U/2m6jT85RS4GaZP91r095aeNnv4hfk65pXkgEdW+0dLR4tWiSi5/glaD6wXtAcUBmbuA+ipXBEo6tU48WNPmCVoS3RE3Pn3JlsGPVE9xP5qOhgePCm8J5BZ8DdUj8beHbZ5sGqg73CCYQpdqJGKskezsatdZuPxJkpktx5nWgh0rKBRXTg33JSWXsv2WkPV9F1hV2jFXl+vLWIRI3qtVuSWUVSxIP2KLwcla8loKoJuOpS4cSrcoIC7Q9iuJ','system','2016-04-13 18:46:38','system','2024-04-22 14:01:19'),('6ea32a91-df41-44d3-a55a-418b3a5e42e4','7ad62dc6-56e4-57bb-218f-349ed1097ad9','globalsignr2ca','globalsignr2ca','1',NULL,2048,'R',NULL,'GlobalSign','GlobalSign','2021-12-15 08:00:00','75:E0:AB:B6:13:85:12:27:1C:04:F8:5F:DD:DE:38:E4:B7:24:2E:FE','94:14:77:7E:3E:5E:FD:8F:30:BD:41:B0:CF:E7:D0:30',_binary '*1:6JSdWFGJvm52DWfu+Mc3fL0NsRliFTPeCOOhF5+/G2dWVPEHk9Ky1ICa9gbSKOOW3U8Tx3Gvb6tpK6KTRCj5f09+fMDa3SCO/upj+eNK2xviWuQt1zlZhLg7whdqs2DhrlvMhs2KfO0wdHfrIfJIzz756AmqpW17zmSV1FTQvp0hRlIZntRBtx1/pqa8MuxZQ2Z41RI2cVkddMMsgJXWv9HrBF0zrK5X9CA24oX0EjY8ALJho8FcGfbHjsEskfMSNaejuSAMrDdY1zE3djUQiqwYdo+Ul/8Iogpqn1bx1IuqoKES/+MdSom3pwifmPgql4sryVvk3rdWYzuJEOLy8X+Uv0sqk8VAStOky1f3l5jcT3l7SUMu1qypgxATmI/u3yieiRMNTfhRZxGTh8CbAIGJ6cVR4QNzwIF15JdFHFLzJedX7s4UWtnHbAxpZN64Zfufpu3eRsKO5FJbhuMAnQuHKJsE2FKXlhb2+4mDHcJwFR6RsbEqVwOtxsySuDmzIcnFcsRgPGobb+JAVtazTCLcKe5hoynY5qXucszxuKmV7bVbRSo00F5cYuWpoDYbsATOcSo8Lnx2TWyu10p/RPFUDTjAMxsZSFsEmwinMCNLVN4qgD8/su4vCQH7LQyrMG8P7ZnkHZNBu9jtiAeEyD7jRZhW1sDkiX4/E7yHMnsgEX8VXUfhtVQCyky2TGAhmtd9LgwDJz7WKIwu98uA9/0sXJjwM6ywzjW/COIbBVOOd782e38euxOPXabdlCqfbIczv62F3+QzYhISf6gMvhWTkvdom/akXr+a7XM7mJFgYXMKtxxxWKv/v/73LaSlE7gPRjIrA3wM3XfCE2vShCUnEeP4pcAgo6qCdHuk9kf3VJZVZ5WX6FEU22V7p/aG5y3rPjWBWDdV73a6v5BcjrEviNZ9SqvTskvwLmm/urb8CLfZjSq9C1400hQ/733WP/gDRho9AZ8qIHAbp14TPXGOlafR3VEu6Ach9zFKI5LRDnDx8mXqgDZTsRFxJV/tmxNYXLR/IT7fuveVtR25qb2lt41rO0+PleobIvQR437G7BE5F0dFjBCkG4GJX4k3tVr8V23Pi5ZdJvHwGOlaZVdZnAYIu7593K/AayJZHdu/CTpV/TI0kLZN94fyWjYOUMjZqsEGGfxZhHTSeUGvYGdLtE0a1hwzM2DNf+WI0zhV6ybLIsqOGbHeNrv9ARMugT7Rg3yqpyvf+0XLOl3qHq00wRdkPfpSw1U4CPdinibZKvhPTEF+V3JqKJAgnyIL','system','2016-04-13 18:46:39','system','2024-04-22 14:01:19'),('715160ab-9ece-42e9-b15c-4874147891b1','7ad62dc6-56e4-57bb-218f-349ed1097ad9','godaddyrootg2ca','godaddyrootg2ca','1',NULL,2048,'R',NULL,'Go Daddy Root Certificate Authority - G2','Go Daddy Root Certificate Authority - G2','2037-12-31 23:59:59','47:BE:AB:C9:22:EA:E8:0E:78:78:34:62:A7:9F:45:C2:54:FD:E6:8B','80:3A:BC:22:C1:E6:FB:8D:9B:3B:27:4A:32:1B:9A:01',_binary '*1:YVULRxy3BpsgszV7uCyQqwJkGnlrRI7tk5YpLbhQvzC0ICf4aLzN9rUI5x8c4dwf7Gqeg/q/GzihKU6oHe1YIWIL33pLKuW1nwyLar2sFvr1YSrS3G0ESmmGFCOIA8GuI7lJPzJw9uicEIBzAenROG1+6DQWngtXWAzLdhMnBdAroRgaRvQb87Z7PZH0UWs5JfyPL9tLsQQY0cj19Ci1FFfQKoDrWBxSUtAgMCJrt3/qdtmRPBtjlSqaBA1C+H2aWdcly9+CoAhWI8Ce3GoGvum+0m4T6fN/1e9x3hboIi9oq5GXv/A/L9B4nB9EtEKD8D98PU/3lCZ6331IOljA47hj2LIwmdSUzfq6lLa+dJgUrm4U4Uz3BbiUHBzGfiUnD9kU8V6D0dZTkXA5gi+oBdKH3FNMYPqDRkb+JzZzj20+GvpH8QHcDhE1Cdv56s4t85QsgJ1xwA0YyDxVf37gxKgT6e1oxd88piBIc745F+YzCju4uNl2eBpzlni0SiSjRtu8gD1U8MeaBjfKSyYMyJ/vbJeRrJJBr+X/anzj9BapDXpNVtirrcpBAGd5CUM1fdWin5b1byqvvM0KjwfTd8Qk8zR70NzSVtuF54RqFVTSRiBcV/xr91RRwTSZNlYVK1u8oYXjh6KMs4PMul/nQhuBK2FWLCJXuMUHQfrAz8ZKvKgffgl8uVwkighJH67rpFbdaL+4wXLTKg/WCvL/9XJJR9pThCAh8mKcwag8wQ19aj2uJJAoOSZy/9JApHafATERzOvb9MXPDeFrg8USsnp7kvFILtY81vjo0kjsHLynPq5JQnQT3Fin7U2XC1RrdDHb5zXDBThZTxdAdODMwQ2fShmCZHaUCiDb0Bt2duwI3a2jAe1HZIGg0Jyd2BPr8lcuOfFY2Pj749MdhRgvQh+ewje1Biy+EtPTfcyquEoAhzN7zL0AAiu9jYFLDCQ5RD+tHjRvFYSeGFT49KPa5RVdfYaUMfV4ebLrPPSXqi6tuwPL2/qmllnrXyiXGULONyDDJBjRA+NaQ9qYxLon8TDbko6IaUzUj9HCAseWYhrgAvb6D6NmasZ5Bm+VbUUT6Xs1q8xeASwsnUqWhCgVgO2gtcpJUn2G+zysks0VaPKSv6oYulV4wz0GaYLOZMH5hcyTxwa22+sttPDZIfK5KARA2xJ6KpTX7dXOpuKyDwdGPUwzzaoXdlf4GS2+hmB3zVIECcHwNLKgDo/bpYhpj/MQiT2UktN3m+rM6DBBDTVJVGM4jGuSHm3V886QOJzQCyU/xxjKkJH9Kkrn6rFMSQ==','system','2016-04-13 18:46:49','system','2024-04-22 14:01:19'),('73a760b9-6049-4c66-8d85-2db7432608a2','7ad62dc6-56e4-57bb-218f-349ed1097ad9','certumtrustednetworkca','certumtrustednetworkca','1',NULL,2048,'R',NULL,'Certum Trusted Network CA','Certum Trusted Network CA','2029-12-31 12:07:37','07:E0:32:E0:20:B7:2C:3F:19:2F:06:28:A2:59:3A:19:A7:0F:06:9E','D5:E9:81:40:C5:18:69:FC:46:2C:89:75:62:0F:AA:78',_binary '*1:tr/KtMG6s4HJ4CCDyPuAB5acCrpfMzJnDAOyDOnfHjWN/hX5l3N8pRGU5tAIQn83uu5na6jFKeeiggjbxmGvLqztudjnrxURJYY3fE5gco+B7sFAwQxUfDL/EOIyjGDqScrk/tTedBvSgmTS1776U2Ax6zc2Z9/PZcun0F1uNG+HB9wKIWA1ydORiM+NJoTSJdrjCmQz5fxR7exnWFyOpNB+gcvxqlcYNsMsXzip0DqkTkIXJS/2o7WOsQFmYVQtHYvm8ClcuP7NQ4WTYjPtMS+je+ah46V+SvXV1LF4l78uaOruLnTM6BVJTNwT7Gkrxfi89IaV/t2H8uGI5vdpl++wMtIb1ELazBhU9WLOntaW8L+6kd2PNGspwohuDZ7ndO0U947KOTWWDph9VKCTtlKAtlYA+1q61H3tmW3XAj7obKiRuJyE1h5U/p81SULFy/y+bXuhvMwV5CBcPezezF8bLRO4CxRzHhGmkvnNkqdO2AaP3fk+T7MCD6j8dZI/xzY5BmogKGW7yEfgUBP+tKR61dNE4v7x1KK7GIhuIAN9YQYdmswt2Goet3/uFO9bKPLWGvYUSR1KFx7hTTLAvZyap90qWZfD/4vWVvvPUzVqGCgmEPE0JeMIt/Z47zEzck1bdSoca0iUeRh6SWrt5fR57R9ERDVL1+Q720HUGJpCFzg0c4ce9fnYhKQsdsjrOwh61DdW/goBG4qP1n41sOILc2ulbWZqbDN3PUPHjtZD2NOHP35SOeayOeIIKirti6hiQTwQWhnEyvZr1oTgK1HAUGXwFCkDLpQ57AFhCkmtVtmoPPy5dusRnKXqYfMa3Vn6ifSiTvz/T5U/SRJfmFJpoIYen6eo05F6fpDNS+EnG2zpDOLzWWYiYyZ6e7gvZzOLsFCFPGK54aj9i0/3QEVJhzCFdm95y98hASYhqUnhF6xiV7rOKUzQsBGctARBEDxG1RYoNcgcqjPxwhMCUx+8JEcdFSmi+xy/8dp0AC6IKzSaPaTuSo7zR71Cg2Jaj1tsqJTtZsu6Wgub7Tkr07uQ7jkmhJqyXT03b716D9wnJySLKegW/lmsbCL3TfraBS8G8fQcBfsc2Iiajea2EpAad35iSOK82YEl8YWLEUfuTGuDCAGEUnsIQNCTlnMiijRqz42djMQeu5TdK7TQzMY79x9zGFL2u9onbQ6XBYcF8neYFBPYFFNxrwJ75bdiaxQaqFK8DJdY9XmGBBKyMpBwNkskoS0ggXmADr/5fT0sGLGVGzFcPu5cn6DEm8he','system','2016-04-13 18:46:37','system','2024-04-22 14:01:19'),('746df9d2-930a-47f8-b61b-82d06753b70c','7ad62dc6-56e4-57bb-218f-349ed1097ad9','xrampglobalca','xrampglobalca','1',NULL,2048,'R',NULL,'XRamp Global Certification Authority','XRamp Global Certification Authority','2035-01-01 05:37:19','B8:01:86:D1:EB:9C:86:A5:41:04:CF:30:54:F3:4C:52:B7:E5:58:C6','A1:0B:44:B3:CA:10:D8:00:6E:9D:0F:D8:0F:92:0A:D1',_binary '*1:gfy/VbxPm5Ct/btR26u4tmKQIAlG5LbegLOYBYQvQEWDjuEGERy5kbB3pxiF7RhWrXKLoN25m0DKXuvCkg7o0hKJv+AUlzTJmtfobb4ooKhehuEQkqv55SZaRDBXBrLS4cZ73aydK9iene8naV29gJnDSVGbi1SZoJUek/bDvQMZM1+fGbhVbKUG43ou2YzoQJz3J/a8nAKyLYfZ75nWKV9y/VEwP+WAt0ywoHWjEAPzKcAG+2bm2krh50q//SUq9srz2p5MaC/dFJv/2VUdT8nV8EtriWC0nOHNyb9BenWHJzFcHzfEqoaEtuq3yVjtAVmi4mXCMSZ2i/6nwtxY0HYliCntP3FxcH4dWw/klkxnVT4kUFYwJjZDvFUXu2xRMwhlZXIh0zDKwAYfybCIIs7CcbjOC0Rh3NKSSLjV6fHdtlnislYxHhEQa4H+TSXz0RiDPFxlfu5n3TMNh04SWtwh9K70RO3KK/vb4KGfwuxmy84AnQSFy9gOlU9Q0+hXbTzZ4YdG9Neq8bHQibOyArwCt1Jc4gUCD6segYm3DOwpX2+nBTtcpjOVMYyPTv0cWYSfNaZtMpk/EHCM7X2y149o+eo++fySvvd/IFk94AulBllLiClwjLBk6ktXyCaPLwpSQAVn8mIfSSJXYAEzlByVYIkvc44moXHZ1LibDe9XFbVZYuLHlZoX1R1eCsUHB1R8UunWWuimtCektwRKrInCu5Y2RNDXALAtUGRW1XNVctaXhiVANanFS2jbIg4cFcFHvTF4qrCtlySe2cMLufrWf8Q20E0YY11bBYHcDCgwkpg5fyfghOYRpF1AbqdUswk6KZHMJMJmJoVayA88QpXH9CwZ0inUNxdE9adi63HzIuXT5w/cvZIX91xc4HbRXnFCQPnOwR5zwgabEarFbIWx58wpl+3y7zq7tRBZjjrSnPqqmScg2pavANVLGSDCmVIgUbBCl2p4H1Omt6ASgI3zVK1N1AbkJn6LCYIGEix4+tf5YK+nP+cGtu9TzZXzVV2r5tf/SqUAccMCTNjRb1yZNV7kXS8lENCG0mIPfGJTpaIdvCpNFmQRXAT9TvBUDqcApLsGSvQyV54jz9O798+/mPkYhdtQFcRiOWdo75mG2WPAPY89Dn7D1raQy8K8EHgeXQYWFgEs7OiB4ZKyRPK59QT5HYhZGSNIrPtTkz/MuEDzxvINY7aqrY2X9XmesEpM90weF7DXOPZg2l6KJiOiemzAmH6dpV7xNts2Id0bdJfN1sQLClyZ6bOI3h3dABhrGaM5Q9K+GextwsPnCFheIpWxh6Kd/d7LZGb7XAWhx8FCmud5/VsKAjijNqYk3OD8KAkwwObqgtLHxwQz75Gpo/bmhFTPuhG5IwAv05sDPnrGVwepGdDvnbpaoSBHFIllhUy+efhB9hlFHm8W4AP1O6DamlLAbD5gkjQ3pDk=','system','2016-04-13 18:46:36','system','2024-04-22 14:01:19'),('7656bbad-042a-4c68-9fc6-25e1cf596474','7ad62dc6-56e4-57bb-218f-349ed1097ad9','quovadisrootca','quovadisrootca','1',NULL,2048,'R',NULL,'QuoVadis Root Certification Authority','QuoVadis Root Certification Authority','2021-03-17 18:33:33','DE:3F:40:BD:50:93:D3:9B:6C:60:F6:DA:BC:07:62:01:00:89:76:C9','27:DE:36:FE:72:B7:00:03:00:9D:F4:F0:1E:6C:04:24',_binary '*1:XEP9ZvU+CT4po7DCCiNI08qKnkLO6W7K9PwcRs2mmXkq1zuov/2zeyBL45G/3Sy3eYdRmEVZWgyLe6emqIR61Pc+18HG8zAc3gCAQH7XfGHdazpH4J4chNpY3P6ehqM7OHWa1VJigNASYlw2P6/imeTK9z32uG3rtwWQEiZpiVYHUIAZ7N6ChimdH1cFdJeY45Qr0Gc9mIdLJ6EqHe2Jh5fi2kyDDiEJBYAUhirws1cyJ41JMWZhBeWoS8zG1+kZxC1aliLHTyWQi15SRctfFJdnHAyMz/p+9dKqyxSIylKmj8pCoKQmIylTtJFsEF5ERJX1Vt6G7F4p6fjdpIkcufcc0mrAndgt2L8SVx7NnglFVHJAvbEQMbkqPoig1GkCaWlWu9qj2GJKaE4UzL0jg6JS/2zgAMNIB+f4KffV6LQf9fjyT6lUA3sXDU+Z6vw8rz5QuCsb20LQ1br5N4uO8msjK1o7ojkQB29Yce+L5nR3PtjeEoqTUaFldqUqFFBHXZVr+hp0aCttsRnWa8clk5YQ/15CW012fV7YskIxapxkNbYIDbiNdCamCq4n8PuXu+tueuk+KLQdtDdTmUcwz3qzuJC58mugwTaFdGD1/DoeF8U2FnayUThOqFIwis855C/fiMIpHftAyIlvt2E6XUCuwaD/43PGdZdL62sG99/Z6ySzNmL3d44fr7eckpfGjmLOLvWXn7t1gtpJBYvZxPVadqXqZtYIhh+ksD0UrD0XCRHgKHndwX0Ztfrp8Bbd7MoZJusa1uOprGVON/wsg4ttgxrkxIjqGNthCUh4Peqjfux+wYwaoVzolWiTid/p/A9m+8pv0e5fg+WA/SmovW77rqUBZjxRiR2jKE2NG3LcFxOxqiPLxBL4QkDN+mMzrA8FXdaKBACQyxXuV/3DxHAFbn6k35g8geqc3RO05CH1yEox4Xvfslos1tRqsMISGL2r6RGXaDEp5KBb0dhgbS8OO1SSqOHT1C0nW8Y8s+NhWnjNLemOT7M9uheU1f16+fZSckT/LSSKVpdPPb3JPX/C9SEnLPBjcC7z1QMmm7IsmhkYjc9ZJulX865FgM7pn61hGVQFkktG70jxaa1CGSGt/2iI/kHS4x0lPlt2NHnwtI/qE3zwGpg3Uy1i1187QyuCDQ4WdqC9LjPz+Yljn1U/pFpsZxEernSEpzA3MWgs73hulHhZRSpvDIOg0hvTbOv1RpuLwfqHfjorrqgT3TqVQU9YqVdG4dciMHZQgfjp+dmXVfCioyAScGHmjvApyxZ5BrJC/9Ck7cOSjlx9uG9ulpQyTpTMqgXe9EUweNm1bNNPW2xnesSlxTe23Uj8Yo9xInbaBk8yuT4Uwm0iu9Lkd2nMbbhtn8n5a220v66TTNbEh1HAvVYMflEWgSmH6elgXUmJU348p6lqw2EJk0ZOWxvrP7VSvNPdTPtVOtsQI3fT0cgpaA2mDgqPuvuy2TMgl5pCJdgG5rZSqneSAt8VcESIVh3HAEm0jjvWplMFt8oAxDdF9xheSsHRD9CqMjSsCQSGEMK1cFPgJN8SY3Ndcc0NNBF4rAyUYaosoxAid4jLbp2o19W98ifcqkcJr3LPmOgeuBeuyg9hTopyZpVgYTs60b8qIiO17ffzGuFpspFc1eqUPFa3E2F6gCAKkw3phOdcVQ95RecRExbyiyxps2o64kkI+Ho0yUqnOhyFQeO4xOdiWTvKkvmZKNC5XuW6vSM/l4myx5ODFyJw0FN83/6nuZGnyIXoNHb3ex9ozagD+yeSiYxMvApHTyA5YKwJRZTeHqFTQq9gkAHbDoJOXNnWdlxE1N+rh6+UBaxeMxsKo6u+zqSu90Jhu8hB2x3XZ9zRrdxvbPLtFIpnKXaVuNC8vtQpLEj9+1ZKt+gFhvXOqpabs4fbgD5iyN8+RXLJv9KETAXZmaziNGEhEQHPOYl15hE1tH5GzRxf85EaJUG7I/jOwj7EZ596fkN+zvp9zQ0eAGwcQ6I2etye1A==','system','2016-04-13 18:46:41','system','2024-04-22 14:01:19'),('78f3bfcf-60bf-4be0-b19b-2782234b6322','7ad62dc6-56e4-57bb-218f-349ed1097ad9','affirmtrustpremiumeccca','affirmtrustpremiumeccca','1',NULL,0,'E',NULL,'AffirmTrust Premium ECC','AffirmTrust Premium ECC','2040-12-31 14:20:24','B8:23:6B:00:2F:1D:16:86:53:01:55:6C:11:A4:37:CA:EB:FF:C3:BB','64:B0:09:55:CF:B1:D5:99:E2:BE:13:AB:A6:5D:EA:4D',_binary '*1:fJbJmwtZn807+1ejSSbQ3xm1Cfxa6/5D7OzYFHk23TgJg5AsibEnnwB0iHOHuZ4UjwGvWxgTP4NbhXofjOIO3iEq26kMREEgu8EnVtJ1+mUNzc2nll63xSd7ZyltHTVjtewSSbMx+FwLHxcRB2wJmRR+llbCtCRAHNYaagcYTE9lC7/MJDTj8bR4bqwFzpNao8PE8ZW8OYTFcBwBOfyxwpCw+vxPgymrdiJ20cBTGxvsnIVsfGKq6u5ZsZ7HiXgfp3AXmZOz1sLWU/y9MLe57/HUwtrfFAUdFQ0rDs15QsOK9XAMt+M0Xy5rZ6o9iX38cu3j3QBy0/4gmE8W0W380yDRgACGVvExNzIksfvPshEjsq1nxHro5/n5Cw1p1XCHwFrqgkZ9GkHUlrK7NzN1Btyeh5vTNXi5BaK+y1ZOi5wb8b9VesOJXtmOEbhbctWaX2/kkVIE4YE1yWs/KofwMcygbZlI1RDayvt0Gc06u5sv3gp+FV/hhjWEIjekvLH1rfczpS2O3lAKRnzB01fluKRDMP9+v0FFkeJwUM7g77BZnHXCxMy4MrILpSF01ShhRZMJktdVDvuJRg5hcgpRT1xvfMcpi9af2Hblr/2iicudyH0+l2pG3aK8RbmyVS2bX73lYbjJkczqabT38seAptVE5ogaMi4UOHvXK97xLfvtazGWq9dRokKT5W7thRHc','system','2016-04-13 18:46:42','system','2024-04-22 14:01:19'),('7a172474-31cd-4d68-af43-618ae0710b92','7ad62dc6-56e4-57bb-218f-349ed1097ad9','verisignclass1g2ca','verisignclass1g2ca','1',NULL,1024,'R',NULL,'Class 1 Public Primary Certification Authority - G2','Class 1 Public Primary Certification Authority - G2','2028-08-01 23:59:59','27:3E:E1:24:57:FD:C4:F9:0C:55:E8:2B:56:16:7F:62:F5:32:E5:47','DB:23:3D:F9:69:FA:4B:B9:95:80:44:73:5E:7D:41:83',_binary '*1:3BGYoPLus1a4Nf2RgNjV5vzudeqS/U8sRWEyuesb/3A2ZqPWZjTX11+pgIP34hb7E9HBm9WQfwwpchQ5Y+E7kktgmE6h9KM+s27pKnCbOytVSSCgy3Ii9DtQCREZn17FRqAKO/XgCKk89NmquvjV8LR5av1cu+WIAgKvMKEguG0GvOReeUoq6njgUwP3xUhEiPKLqGKbM+P+YEZ06CvbFq1kTFvQDWlZZOAJU/1UAoqykRzM2qRerVPQISz2NFF7TSTqrm/4EseVtn4jaRlU3HEqAh57WA169x322TRjkoMUWYktZLfCZTjDzHcjmhI/Q3TgYxM15HQfdMKmXYHmoyOYGUH/BKcXaem89kgVSQbYxH7Utqg/86MDZ0BfGZCbocYd0Jlwf1VtShMBOfSqo1A+7CDmHFbJyCanv6+WxS+gu0tF1Xkw+wm4WQMq/vanfIWSqG9z+qkd8JBRhudtHgsK0KpwZwdbFXMlFHPz036XuF6z+gnxqIsJpVdNRbv1PtEjHgt0/GRDP71WOto8u5saFwfnj0jOZaXoKGQl1eD8M3xZs0PFQiP+XwstmVfVtn1sWrJBL/WUKryTpEjxDs3Yb3H5z6yUQhKgA7bc5tpittVmp5L9jRp4ooPYCknmefQHwOyRmFZ9IjF7zVwmKPDR+15jF0l7SmpzMWKOnBDq+BLPJhLjakM9n7cnyERAG6124zSKqtwdETdJ3I/vnB3qCo+5L+S4hzzNYT1r7iQsk6jm1VC5aXRO0Tqc2dSwpelAUqnhzbnCEluyAhu0+QowLQOiKuuUG/4fpvCfyw2yAhT/Ild3BGff62X7s+/ixLAUDhONbvbrd3RVU3Z1UVKFci7JwqCQ/SfSuTvEiZf3EQwXur7Iz8PRLJY3LH8apeiWfWinTFeUZ9dXQX5lIFW2ra5DCMCxhnX5pmyHOqlvJX1Lmgxg/Ovt5BTRzXcfjN7zUS05ddJt9zP4Jjo3ve0IKyvMKO5nUFxb3ZJ6K6j/qg9NBYfbdp5L9AWO3AvIwubEvGl629/Gg4Cak1rnIQ==','system','2016-04-13 18:46:49','system','2024-04-22 14:01:19'),('7d058668-0ca7-4711-8212-6d219ffb4a6c','7ad62dc6-56e4-57bb-218f-349ed1097ad9','certplusclass2primaryca','certplusclass2primaryca','1',NULL,2048,'R',NULL,'Class 2 Primary CA','Class 2 Primary CA','2019-07-06 23:59:59','74:20:74:41:72:9C:DD:92:EC:79:31:D8:23:10:8D:C2:81:92:E2:BB','88:2C:8C:52:B8:A2:3C:F3:F7:BB:03:EA:AE:AC:42:0B',_binary '*1:HEQko+8ucyjheNriXSHVJ6HOOhQjnZ9VEFSK0j6r0GQ5Ivcuq3zAV0uz1s9am+CLeheKNlAEg7B8HJNYO2CqZrRYbv21+BEu3j9BS97fy035nSq1zhyHsEoxUx++kCfkChmaMVKKsghlfDwIUfV1pKJJiHtxs7al2g4CdbcK4dxkdJ2GA7+eM8hc9Usd8nWkezlN5V9ICdOclJjTLGYNJOiSruoP+gslbvuVgyGo2Vcng8jNP5hSvS++wkZB6at4MjZP4CnDRxl+dfPxFP4URz2JpdyxZQclAHGbf6skpl3gg1CKqRb2kuw/rr3V4zICv7KnvJPqmYk/E8kE/7SDtOI5FpBc5i9gP1r2HPomAxWC69WoUd1BfJ8/NwwHaZuPQcRWPxQftFHEvESSMTC3T6PdKEoobe04XKH7spjvND9OHk+W8ZUDZ/Mt/UeibyYHl1B5Wp+/10edRAsZf7JPz75pQSGSDFBDwIy2Q9oyAAnQny3BWuyDwaFLKvinMCaNxwn+N5Egz4RfmEv5RLI6qkOcbk09Q6ejo2S/4CIowkAbuPBOAYwpgKKvKkw4e3oktuL9uKES7FYr8WHTxSTyFNZBAMOs+7muP+tZq4SvY8XeVwfW6n25MZ6ENgvh/wlLzqIF1HFdS7EGIzJDn+GG7mh6FVkGFChx8/ESat/qVB3rVZkF6flAHXzTOUwqzxpjyk5fd3u5Jqqu1tTa4bbVt/J8R5pMnlA3766uWmnW0/Nk99oq4erI0xpU9hYKHTw7nhIIgl2BW7molBbc/1f19swogUs7szaX9AhjssaN+kXoKawl8vzLr2SX11+k+b2F8ouV2HUS5JVScUfogbqtHfCa/JpqfqaKENm2fJlkzZRs7v8K9zOFE8UZ20Vhf7q4j9o4qo+bMhY3PKS1OLYD6Vgnms2NLMpofM/oNl6apILhOVYYSAl5r4k8q3SML7H6H8n5mG8Lipa2WbVpjBqvjxmPJVaM2ItrHn029krf6Mt4/UwyMCHZU7onfipmv8n/bo8xNngnFBWx9SUwjpDA08Umrkwr0shw0fwb4des5MTfuGr8r8ns/InRFthMXqcQs8x88AjZzeN4Oumb7vPQ8xUir5srRww7060xVLYQEsTvGw7fOIwaNL+iCkf/M5koWsr+s12BDCjGQLodnoU2kn5JHxDTB2p2THyPoUDn/CWE3ob+UaHzlZtlDP/WcSxc68eXvOu44hNs0i1HHuF9BQ==','system','2016-04-13 18:46:39','system','2024-04-22 14:01:19'),('7d21c1bb-0e50-4986-818e-c7f764cdbce9','7ad62dc6-56e4-57bb-218f-349ed1097ad9','quovadisrootca1g3','quovadisrootca1g3','1',NULL,4096,'R',NULL,'QuoVadis Root CA 1 G3','QuoVadis Root CA 1 G3','2042-01-12 17:27:44','1B:8E:EA:57:96:29:1A:C9:39:EA:B8:0A:81:1A:73:73:C0:93:79:67','A4:BC:5B:3F:FE:37:9A:FA:64:F0:E2:FA:05:3D:0B:AB',_binary '*1:z4zsrxA44rp4q2r2Irrj9p4zw6nt8Q97J/utSHxK29G3HErJbZLuzjEWYevqCrZubMAyEiWng5I/oZpTkkcG0o6hNoD+IvRqEK9nU5Uvc+AcP+e/NgcVSkDUOFl/oqQj7TfJ+D0GHjP2RkV2pKUUHTsdhU6Qlj1fd5fvID/qC7bodFkwSCZn1AqC1XL9zfMUZEb76NFuyrZdsDToYeStlmcUzdSfUyioD0q708pLVbDl6/dPQDOuTQRrwmre6TF6t3EQ9wqzGuTsH9I8x4mUJSpeu7Ez4B3ozrUe6DyWkk4AwR8oikaqL/LtmcG7j2pUx653ZTSk0iGDfx1ivSQiVdnWgWql1Y8dIYSGzL4DJPBp4HmyZog/Rt+8U4HCB8VxSrzOiEcdnx7GNXxvdduTTeifx/IE2bFo26tTMjgZH6fcpSRTK0fedNR6BcOHFGDFlaqI+/CGcma2MufVmCQOecDzmRFQ7da7ryDKU8rkznoG16+DRX/+uC2VpLN54qKtMwSNbM7rKlAHxoylBIs5IqS29hgyZ76ZZe+bRKYhr0ZlTGg9HyfdCwBZkhl0291IMo6pZhfCclX6O+D8ihVsARC3hhSdmAFkqh5dK1bEvllRCb26vbYfxvS5CQZKVNfoKALw70Hg1YSinAvB5H4fzIV6ZYOhfbw1T1wPBF79uRfL7MYhQ3hHf/nVv+21jRYgwUjBMPhyBKb52UjD1tvObX8F4D2drlpOGzE5asy2cTQngMvXW0LoWKPD6wotLNbM73rghvh8QQBNO73BVV9iIPbNAJZpbIA5hAV8OmwTAFLIBEXiJ8AAWu7Oq7MVFKvW9h6XfgWF42tgfTQknATyNxi/3Sc+3SQUy5ZNMlKgAMMO93jj5UOu4SSUb8jjD8wKtmL3R23qNDDVTf2HJYcHJrA8ZJJk5IbaDt9+hOuKD9XtSiCghGPHKc8LKOEr8jPiiaUL6nVDTDVZWxxzJJhLAjxoz7Pn1a2yHcF3M0XQtip4M6LNOfuMztZCmehHhMfLCgSWmxQe9yOQZ2fkPISQDwxhVbhrTwufoATBLKdWws+Tu37d6fHjn6bF6g0RnVhdbb8gzmgwCXq4RrmAVt3fkKRR7rGnafxc8/D03TCjmgB4ewA/AW1rDV1CWFFBYSTVwo/pTYnNj9TIPmj9zjaJeTxtaMtZPO8luAcLTGT6c57JvunXJwATfk7qKt8O9p0WOKsuVYoxKv4g3zBzqfCxIgS6fGRZMeER9V3LXvFBjf3A/NQiLcAC5dx5DOJ6yZiIej1zHLuydIq9CMwgJUERKhxL4Y6csoawiZ5aNIWK7/g4HWKx/d6KbyCoN6vop2OWz64l5vILH8mtavr0TmNF1r7LS+G06KO59CboUhFT/qg2oyQB17nHB6Llh4T0rtV9MmoMF/NIHQIQ9xJzATBf4oLofIebmd7aBpOZglrpInRmg//8EubkKfvIWoBmf1Hf6z6tS/9c3QGQ4WMvbb1c+i/SSngVO5x7NRLCrSQcYOPMsP8kpuvpoq8+YxENSHjghnxaiRtmpeJp5Ev6z9kYqcFgYDN73n0BsVc7mXF0atKbLnOTpUsGr5u0DQFNE1DICiouKiZZNL086b3LYb+NLq1UDSdgfLDzArb0ZNW/JutQ574cYR/Uc1ryMBoT5JRl1qbok1asWATBds7EbrXoa7HF5xOwjO1d2OpeEasAXdBtJO8TjAikLT7kcPgOSYHiWBAo+O2G2N8b71Go/sJ7jHzmATZVRkf2cpA5OR2nA1LxXsplF2c6KEqlCTV+/UjZXHpvpm57R+Qg5a7LOf8iLCA9H4LMh0tc79MrdBkrEkffRSUYy6ndB6smIWLafOYM','system','2016-04-13 18:46:46','system','2024-04-22 14:01:19'),('7fe44a04-3d93-4797-82f4-aed80e4d35d4','7ad62dc6-56e4-57bb-218f-349ed1097ad9','secomscrootca2','secomscrootca2','1',NULL,2048,'R',NULL,'Security Communication RootCA2','Security Communication RootCA2','2029-05-29 05:00:39','5F:3B:8C:F2:F8:10:B3:7D:78:B4:CE:EC:19:19:C3:73:34:B9:C7:74','6C:39:7D:A4:0E:55:59:B2:3F:D6:41:B1:12:50:DE:43',_binary '*1:uKZk1dn9buHFOT/qNMEkjY+ytzWaz3xdR3/oK8ob7U2cvlGcO34kejZyZfrOc+PHJuqaSqWCYBihFNqlH3exVAgKhtcI8WiFEzDKcFDouZEaqLRHoiudo+38MpfT1Ro+mhaJpNPXDdyIiRfMx9N8+5oeohWJJkmsT9Mmj97iHXep2eRjHYbWCVF+ejC/Sz58N6/Zy3N0KPGrKIC+XI9z04Ux2jausI+B4aLFgefy1wkZ5D6BI7rFXxyLRcAiS6/BV0BLWnJZ5QcAdDdd23cW2SqtIlv6xfGyOdwHV92z6T9LjuINn3td0sQJkjiUuYhj7Xr98ePm/CwgrCoX+6Fk9oZkIHY54k3/hDXc81mT805Xz9sKmkkTBJ+BrqEXGTMaH9Ah90xpTHU4EuBCKHF1iJ36islm52ARqsU/87Kg13ynk70QSF+N0CSxblReDT42UQadcZjyT6EOpCK/8rVbJLLy2xErdlT1NuvkWaughievU3no0cZj8d0+MD064A4lqWd6hWTxeW6ESjgw51OT9eCG+vfCREUo9h2PGEgQxthats0o1FowlkrTuaM/dEdJ9k1DdqZYT/VOtpEBiwP6yTS+WPT84WZ/1QhMaMk3rNI/6B763KN92klFEINF6USXS3BtPszGogoUWptE1HqJfaSZ0/S7Gti4hj0hAlz7kfEz6jrtpDW69a1zRlg4omjsU35Qke8RgJqTswXcvSphC6sIjSiRFOEf8Ba3cKE5OqaI2cQBQacG7xwCQZTicubJE7WCb6rKq3zKm9MM3wdq+yyTBwvwbWGVwnacCnRqzvJAxmDaLAA/+YV+T8LTbJZfqjrF1B9/GifirK25l0g+osekiagAsCDp21074Pgs8m82M2v59JfM7KY4vo/EPOQ+VTi3njvK+CUmklEXDYvupZ55Dl6sgZ1O8/o6ePzf2pj4Eqf89jH4c9P5lZeGewveLVE2M3mgMhyyWBOma3OSIzz3G4wVqOJf5Zgxi4kGQw2hvHVUW+VYShZgqr47tejA7Lbl4hI9MtmKr63gHl671e1i282PafQL119X35Y4Z8X9YW8cN5eysjsyPqEH3mG8tfJC+UuhsVYGmLOsPxdQ6E05yaI1fyJu0RjfkaEh4Hvb8/jbtLrBGVWZXE+hZd0PEM5a2O0CE6Q0I9h0KwmDOaQFmawbAo661oAwSL8bPB8=','system','2016-04-13 18:46:37','system','2024-04-22 14:01:19'),('81848e8e-49f5-423f-bb55-631830eebf9f','7ad62dc6-56e4-57bb-218f-349ed1097ad9','verisignclass3g4ca','verisignclass3g4ca','1',NULL,0,'E',NULL,'VeriSign Class 3 Public Primary Certification Authority - G4','VeriSign Class 3 Public Primary Certification Authority - G4','2038-01-18 23:59:59','22:D5:D8:DF:8F:02:31:D1:8D:F7:9D:B7:CF:8A:2D:64:C9:3F:6C:3A','3A:52:E1:E7:FD:6F:3A:E3:6F:F3:6F:99:1B:F9:22:41',_binary '*1:qFmjwZXzy20dOU5lpECm/eBalDxZW0z3F6lmn0AUTAnflIC3IX7dxDnR5Tdhb/abrytqCnxTw01B2TF3Dtp62QmVzZpEiE7YBeWt6A4g1xfVylxjpxYpJlfOhV8ZPU8P/ggA3xIQ9k/6IhPqiarihlFglodFPHN4E9j6j2pNBqDzOcwU8jV3NnV7E4LWWi8WfMrVfVzPsLJ/rwyq50Yox1zDLwQXGkQQ0owsz2uzfGVRWuvNPEwVVXv9yphHznDzFM6UMvbFKzatenqwzajEAPDszM/aUeT+yVYxPxoAcuAh+Af9i7Rfa0/DDJRnRkx8pMDzBmbfRSrlZok+Wix0EtljMfZzsYyTjxbX8h3Y7gALeaHnzyzbtDpcvV6SXfCDTNfIUK43s9s1yjzntEsk2M5JnL7kilaJluxtT5LXMehGHDrA5k/HO6Lh/0Xxd+dhz18mRYGYWfLeTLH74+F0ZEbTlwyjUW1jQVBAA8Izhgnocpah4XN7gdygI85j73IlgOTFwmY32tVon6ntI7noKVfomWFuXdXrGY8a7qel2ZPYQt+WvuQDHpfv3doWzG2Y9Z4Olvuc1PMz8WS0lVgOOZIw+yOYnZrDEukb5Mca6yyy0RuQua78vhi8tlQ1IvkJZw0FLqnxtIrKA1VgNmJ9/EeF7wornBetVJa0fQb3ARUZZpUgcSspXIZvHJ8akXUH+zl06vAWBbdW2zGTYlJ37/UTVqqtQkitwYupC93xQqQkfWRnFzfr/2zULaLRpRLWHvJdqoCMRF9Z7HyCV92cOWOGM8618UXrOb82JgC7hBtNqqPp2rmvJdTKd8Zm8a+UpFlYpZIInuWdrnkM6qF4ZDGvU4BSRpxseWP+C15uhIfyWA8veWjUzxLlchTAqhNR4psnxO8E8K7F//lfIAKiDPQAj37V1D3AwErbWhVWmHSu3tXG98isyipMNpRW8hyX7jjgZkqey6NPabDBPcsll319FN6pRE10mYdwpfxi+86lfmZbNSmwkJL7xOjE0AdsQQjPKaqNOMmTwDMCDyqSgAxOBWpKIDiekyNJ5TYstbGTgjtzbP07PhwEY+YftXcNu3B4RNhm9IOoB3kt0Mtu7UhCG7WJOVkVa5a7x7KDBvFqM8Gy8ryW+TaNftPHHSeqI5IHqH9jHM2kjYohH5y7EIttW6klnk0X0KIXtuRW2PjATXGzeChccG2iAyQH1klS','system','2016-04-13 18:46:35','system','2024-04-22 14:01:19'),('845f9775-42ac-4f3d-8bb9-e87419cedf17','7ad62dc6-56e4-57bb-218f-349ed1097ad9','starfieldrootg2ca','starfieldrootg2ca','1',NULL,2048,'R',NULL,'Starfield Root Certificate Authority - G2','Starfield Root Certificate Authority - G2','2037-12-31 23:59:59','B5:1C:06:7C:EE:2B:0C:3D:F8:55:AB:2D:92:F4:FE:39:D4:E7:0F:0E','D6:39:81:C6:52:7E:96:69:FC:FC:CA:66:ED:05:F2:96',_binary '*1:rLdkSJrsRPPyYF423oxq5mo6FO2Q67DDmPNv2OCyGCXVez0ADJlpIfzzc0PVjV4LjUr8u+oFlrOkPjQVDoSBwxt6vS/ai0r6/DFxM3qJDn939DF9A/24rgO5MPU99kzgPspn0ThJS0BKUjJkV4g4+gp5qs1CLko7/4DS/tASfvjRcoL2TG1vIgYqdKWBHS8MxLReksTaAJitSL9N79HuCs7y3tw+ZC7fP4xEZ5DpranxHYLwrI6rW7wj22sQIhTJFDnZ4n3jDokDLWzNJPMqrwM9aJQVLRJu0FVbFDHkUUQTN/XYwd8Hr+PfK+7KmUdpkRdeZFbrqdy0UqqHL5o6XMGKHhbmZCz1XdJ+GRCI8gw932r6BCG21h56+ylCGWgCR6LDtdB7/sC/pJ9kHCJoIz6ZC1w5j5l4UNRryy9o0Xugp9bbCDnhH7rDOlWbgQoT8TDGEpzWgacXo3KhZoxFavRVCL6AF1ZvRGFAwM+RhBcI0r+CSC4ALep+2z6GemLhiwrcknjzx4WXXYemKFpxiaJK1n4+DdQhGfGLf0XDps8vTestWs9R3LnTwTnWGc/gybn0sbsbaP/iBZ4zIt/JCo43fg2OcMV28h8iTj7k7cz4C636TvfpatWqZO/wiS/JTBRdXUt4oVqvJcy2B17T6ifmCWZwysZ7Tyxy5tkTvwPR7Tjnh+P1aAwJt/Xdyhq1pApOg6lB+ehk7Y0R3Mkke3WxToMjgY8mYBFLfT/9kpinC6uV5A/qjhNszTm7g8iEm/1tYIZPiaJhef0yiYbkL51UUC3OXlt35QUcrlPIOLit9fQtmKc6VWvF5TRpLx1BGkW1XgXQj1tzr5vs2ZbzCpbruBy+UvEVq+OuYB2Ik0F3Qj1/fqvV3nOH/2eS5dJxjDMEfeoaF4ysvJb9NNWqBzzjS3oWM/tLwJvh/+dtUYISCWynfNQFxBJkEikBAmvJxCjG7gPnxL14se5mf/W8B4RSztpSrE7hjy8GnangeDD0U1v73pLPWVtOjVBvNdP3GKqzAAZZ1T8NVNhVwaX01o33SFoAijrfTrHGsVJ7knzooSymul5i8EyMvNSCt/dwNPuHqQprye0tj7YWZ6Ob06ZK48Xu+MiQSUHPnVLpHJAJdSXwGWfnow3Kz57Z11/VEDrEZm3iRt+QsAujzyEAFHXafrGhPsnyZLQWaNlBQdY+Iej8Hyf+8UyHvL1kj6zNsnJEubHwn9oib/6rulJgCUiKbqrZ2jBpGo6c/1FdG0Jlxn3cn06GFTsM2w/mqYZj9giS7KLfhz/ZCeRMAomGUpWSt9lbv7o8ZPDEwU+Lvj3k/ff+IBAGJi6ac3TjSygx','system','2016-04-13 18:46:40','system','2024-04-22 14:01:19'),('8527c070-71db-4f6c-8c48-28f4c85dc219','7ad62dc6-56e4-57bb-218f-349ed1097ad9','digicerttrustedrootg4','digicerttrustedrootg4','1',NULL,4096,'R',NULL,'DigiCert Trusted Root G4','DigiCert Trusted Root G4','2038-01-15 12:00:00','DD:FB:16:CD:49:31:C9:73:A2:03:7D:3F:C8:3A:4D:7D:77:5D:05:E4','78:F2:FC:AA:60:1F:2F:B4:EB:C9:37:BA:53:2E:75:49',_binary '*1:Uh9etkwlyD9oYIQkYoL4X0sc/beB/79CEGE7fq63qA4E5DtCucuYoObDHa7tu0yWgm389Mz4XltLXKtgRRlWr6NB0qj1t5eieOqIsUan+L16IklnT+Ope+gXe5ext63bnDu55TyO4iPIbK3VTp2UxCUhtxdGDjS42KzNmrBiKKzsG/23eH7p64MoLdvqBBWIpa/BEJ4/VfNd+TroOgY1uIzrJE8OqM2qhaIcKdpW1sFi4t3OuahndoLdG+1bj7k0aDatKta4edv4An0xm4pi7FQUDnHAkKlq/6p1NpEHjkZ7crepAJQgASdagyelvY0uEZBQl8oHMk+7wzHRgjV/UfBPyt8FiY6Vx7IK5AMOAw5TkccR9ypY4C5AhF0kItASDIe3RX5X2MSqi7ts2JxYtbdAw7Nz8B7brNCJJTsnRaokTHXVQbG46SQb/FjsBlLYXDMDCXbr/xSPsdemEWZORznr++w8uKm3ZmDPOhWC3whMYXCHbqvDi4nrnJlppAfEZN8iTOZZgVmBCsfqLlvTlRtw0lQ+en7Bl1fQpkqRo1nZtHBMcPgQ1/Jv77EMRfUCI01NRf2KjnH5zIvpTHfEUZwMwsQu1Eu4Wup8wpvib4kjD3gCFMyCBHNZdZD1oZmPCpP3fDEEyi38tBiPH2j8KpzUTmyFzKW/V59ANm+K0bRcrVYDJHI9PS6XeWxtRIuFKWWOt2Fn3vWsXI7D3dk+SN0jU8yo8ekr4itNNiwXR9MOpapVAAbjU6d/R/QhSbhmzaKRP3+hq8Fhoy4asw/GmXjQFLSAq7ALj6+z/dnDbb/PIQbv/WLvGJGHVZH+taDur6W75E29CMqj63Rb/z8Yh9CH+cmHSTbtwH/reUaYXv4o02BVygaYe4JkmrkAJmxZa/Mhpz2PeVvCjWGttLbFboLTexvgDH36w32dZ515YahzaGrICjsf2eAqSf3LuWxcK1XA0iDIGuTzlKCRtGDPrxkVyLxLtSn+IuCv15Zt4VtpQ2RnF3YM23tiVwQAPArWqFBwm4eBWP/57qVxOn2l+WymyhzAVk7MaABKzjh3OO/1ncmBQPyPX76+f5/QQKFmmYNNn1WZWWp378tBdmSFXLvUWXlKqMiPoMyPpKHNzuDb/zsASWW4GwDdm8oeLr/04RrWK3al8K2jvT00CBWLQ0Ws63ess8ttXtus8BOOtTKSpt8FxvTLzmTl/PYwdtMsiiggPyQOmMGlyE7dDgPmuPmW6IuUez0fj9DjKK5qzMdbvBC9nwBfWyJYHNhb4YtdylkPgJC+eK045hDgt5rqW2eTzfUzVr60w4TEOJSAQLS2mL1CdeDKK4/S7wAPbLWyovBddazSDpi5exjkqZDVp25vP6fLWnGhhvhTdmGSoEpYa2Bes4h7+hVt5bHdAYAjSpPl6YBtcTlfEIbWFyLmVvYjw1bXQqE4i7YHxxzTrRhcKVZcuenAyyfrrNDmXvXTV9SBWQZKzWRBkIR5tezyC5YhskDGY2fpXBRTAcVUt8HrrjM6vXd8almQplRH7h3xsO6tNslUCB2h3GAAmigsz4okb8RX1UiYsgGr9M1XooSRLwRFymV+yuUY/H1C3xQjQepp3u57iCedHGi6Sn7Gx0INagPVkcIUImvt5IqmB2fkwTudApBD6E/fD2EoEyoFJz0bdiDIIMzFllMz7D1TTQ9mR6ZToEs8l0l2J+I6o3xZgMJM5yY5PzBEuK9xXwudzhdcHAH6Tm2AzM0SmAe0C64xicIEFEDxEZptN90NAhRcJhtB5Y46A9YE6L1Cw0HMw6tgESXdh9meqRZUiifbqUjtcOillUv1JMmMq/59x0q7916xLmj2uG8/cJa7r5+xXKDJznoW2jNW8jKPo3H5IZFXiKydqIcEDYEB0zHrnco9x5JUD9FGuUQLG2K35oBI','system','2016-04-13 18:46:35','system','2024-04-22 14:01:19'),('85496d9a-d5f0-4e61-aaf9-d0bc9974e36d','7ad62dc6-56e4-57bb-218f-349ed1097ad9','baltimorecodesigningca','baltimorecodesigningca','1',NULL,2048,'R',NULL,'Baltimore CyberTrust Code Signing Root','Baltimore CyberTrust Code Signing Root','2025-05-17 23:59:00','30:46:D8:C8:88:FF:69:30:C3:4A:FC:CD:49:27:08:7C:60:56:7B:0D','90:F5:28:49:56:D1:5D:2C:B0:53:D4:4B:EF:6F:90:22',_binary '*1:maFb0qYzfKkUcx57jGHbNqtcBqwXAhVvfxvV1sLyC/AS6ADH6RXVvfyaxW3RtnQlq0P77ego4pukZVKF/8Qe5LrzzA7139hQJeWVSuaWi9jz1Ze+nY+IrRlgB21vEoj6NodSQDpxKjtYd2NgV4SLjtx0sTDklkph05qgmG5DL0dasCb57roh0j9hpc8zR6Ht2ExT7uuUMO+GdT4Lj9jvtrPWmpFDu/SsC839vojPBpE2ODYzIzfIWFz+hgF831D8lIOwgr/YfQbJzz7sdhEatXsp4f9L4MblqhFtuXqlvCRZPM0VdZnB/88n84AunBtVLk/hBqK5KgvFgEfu94k9TT91zAb1t8ZAEGPf938ODKHXlkMkFU+7J8aQcPFf1FCsTzzuW82433RObqNFe+JctVi/J8MuvowW2IPcO4jZ2R63c5I1tRVCJZtadtuHTF0pJp7WAb8qaxna/GY01L8OQ5/YiNwv4ItFhL8HcvZ37B+eGU97aO7381vMVjuL0BukW0e6fcMoa6i+C7dzLk1gKLh6IkiPj/USdiCe8mP46o0MFA6tRf6ekwXKyzs3+WDcZxZ3l92dfy6GeXInXOsprB/ctPr8kty+mLrDw2UcoDgyi34/jrhG5rp9lESN42TUuwSo6LUXfRQWiSGagZovsnZYuhRPfj5L8kY3YBHxNQrnZ1Xg6VW3nu4gULqOnljX4kIU/2A/EsKZchQfduVqbllXLO/v3WW+uUC8ozq5FWKg7geap5usP6iKB47ujWPCJyfGfSd2pcdweu6fh3SjUv/xZN6OniNtiLBuQkdZOKKw2tBwLqIvuJFM2GV4o2XA4FBEPFlV6MyAcPVzCTtfJtp6wAzoc7Uo6JO+u0HvETUdMzndFTWCU4qLP1XtrEq1IVtUGHVG4sxw+ac2OPQwVg8EQ8CFEyrM3VmnKO5e3//ZRFA2ayAcLjawon5nMl5p7vvIhbwTCo4/ha971/tqXssv6hQZF8mDykYuUoFXMKmz9emW7WRxdadML21h213in6kOz7igv6RaohEc3ga02UOzzaylEIztKqaTGtRlNFDcvsjyW58YNKgLYNpyLUqSuTu+u5pXwXG/7FfI8VE8Svi0gLmrBO+1BbCo9lgFcZVorgJ3M8x6AOoFCHwE4JqWUUhpOYVIRbfpF/hjTPNfpTUZNQDYKAMJ+2vMjm2rQTrPVN1ZRVvtSIZPM6FTK8KLmYoOwKfvByQk/qRWF2g5+Ic0yCHiSsvhOk9SqPfP3lw=','system','2016-04-13 18:46:33','system','2024-04-22 14:01:19'),('8ec67fb6-8001-4b9c-babb-e14b44c763c6','7ad62dc6-56e4-57bb-218f-349ed1097ad9','baltimorecybertrustca','baltimorecybertrustca','1',NULL,2048,'R',NULL,'Baltimore CyberTrust Root','Baltimore CyberTrust Root','2025-05-12 23:59:00','D4:DE:20:D0:5E:66:FC:53:FE:1A:50:88:2C:78:DB:28:52:CA:E4:74','AC:B6:94:A5:9C:17:E0:D7:91:52:9B:B1:97:06:A6:E4',_binary '*1:oY9FAFLejNnPqZEOH+MJpPJT6AlxL8CW77UQ1iHoSwz8FWoAj1J5BX0IaxdyeUYsdCKBFOmPmod61ycze5K79R6rftUBBsWdAMsEOyOZAhgy4XWpNOYfG2rjQgJU+cBkC/pXVAo8RjHq70uw0oUTDo7mO5RBB7PcJuv2xx7gR0HMOJDkP0t7bp5RLIrQxXDOUg3LPidChug2U9jf2+KFhK25LaJC7m81S1oFguaTtDQaHA/EIN0XB8BE9ChUKmk2RVSlYbeqq3qX6wdO8mce+pT3Ij4ZCGelxMXY21NVxu/VKYNfjyhFSWUYHP2c3WdaOSo+5JSAD3ABg/+hbg+5ngAiVBgVCBGTSWb5cm/1gGxYyb1OjU7hSw5UvvQAPCQIfR4K7UK0VPNlwzRtb2xjYkUGlQODmnlzEM5AvsveUwni01E2FB/BLTOCin8GNvYM4qsnUmj8q+O2qb1RxTUUkakxNLN+ZTVRNgF/Jp2FZpf3Z6J6Z3fHMLsDFRDdV/1UUxiejiIZMiLsb/Akoexg8ZBpkZ00imlCLTLB21oec+uT5Z2la55Aj+vWXYJ11Do+vXNMsS4akBl2G9qbCzChvBI4nola9HvBkbmP/vXbE7tXE3/K607TH9NupHygbGXQ9uFvpkMkdYW4HMtDT9nmLfP/1bW1HoYIzgfTqpDQBTJmoToWieyZLfKdSxmN3TWXeyN9VmzgkFWDcBwuWegCw+7Jo3XQKQQz8B1TKYKyu9ebaxP8Kk4OFN5/byKEqyGneRRmDOrzgNhd28FmVUjZ7TyvgIjHMo+g+E1eLBH5CarvvkBvXEKAl3ilTzl6uU4Y5UPoWIDj4GCLP2InD9CkYCMgTAy/4Burk6GmdH4OKWJtx79pjQYFS4rFAzbKgnAYJcNctfub2m9DkfXUOb4ujYc3jBCRWufcTRAlUW4zC7Bbbc1+b5xTdJh3arkVHrxm3OB/Beg+YN9kYon0YGtA8/6S4fWiXSBFSvP4kvUfgjicZU4xsYrPcad5G9NdFs+e9Rh7iyk5nd6XQ4uiHUx9y8gL91YUqzssaAL3OArZE6S1Urrn3dfQqgzBeuyPoLPYpVZCPm0wMamYmiF6XwNazNC//P7c72fba7wQhXqj1d1Amu6Xz7rhvZZj5Sir7Iu0Bk+m0t/KY5EvwTH6C8jKOaDsiocw4B8kgkL67qXgrNM=','system','2016-04-13 18:46:33','system','2024-04-22 14:01:19'),('9352c97e-6639-4b36-ac6e-c4310bac113f','7ad62dc6-56e4-57bb-218f-349ed1097ad9','utnuserfirstclientauthemailca','utnuserfirstclientauthemailca','1',NULL,2048,'R',NULL,'UTN-USERFirst-Client Authentication and Email','UTN-USERFirst-Client Authentication and Email','2019-07-09 17:36:58','B1:72:B1:A5:6D:95:F9:1F:E5:02:87:E1:4D:37:EA:6A:44:63:76:8A','D7:34:3D:EF:1D:27:09:28:E1:31:02:5B:13:2B:DD:F7',_binary '*1:r68Zh7N3Z84N5UF2RpZWpNZr+LHTUK9jzu6Zd7l/+hCBmkVBrhGHl5qztuW6AMv0Hns35t6a2+Xpy7ZVFT9ksMq30A0VvnleP6+gXMlxAP1jjG6W4+zFhHfeMl/w/hOkvxSQWwbihdWOc9pcv/FOvW5skFF1hOT7dgbe8Hr2NRYiT1tTNNC0uiDRQ9goHbbdndbZWXs+/8u2m748DESy6TPO1kEKIoBJdvK1oJ5LiiU864RBS6NQbPFcRH30adoGykTLGTiVZdczSO4OnV6Q03OT32V2rs+vXOo3nU617ER38DCovGDG91sFze5bhqE+NZHWTcmsuvZPlsDITAHaoOQd8E4sAHn8dotjQhOgl4rnaLN4ZrsPk2wm8NH7MGl+jcxTNbbhgniCfaIcdUONiv3wQtsR1CmGD4EK025UeDDAnvRJZZ7gVnDCMRndmR6bbpjB4l3UM3FYcrBKzMsbB4KubokEQi+wX8x3DoekJbmeCe5Mt/1UlzGK+eKgPAo9/GIe3AzP4s3KceI02TgEGRwvAqOKZ8IRwA+BQJeiTgLq50CNqhvK6IHZ+sAlG+d9JXCTeMdxuMQkrvxiJTMpDCGponNjiRqv6EvCRUrCxvCbDeMUEovIEy4edpCLRJA4kYWg6LXHBTvcbLx5/zR94LBgg8kZbXMbIq/lbfSM02tObM5zacJ38da9vUSm0By0l5gJAVaWwwUmsIa2bDRdzwxHYyNo+FlHX1uAJTA5I7TvWZQ83V9MfSp7550Ed51Ja/2Phl5Adxon0FBVhAQWsFwh+hKYazKteKBXiMr61UPRD52S/kEMVQ2wnJBAMHEzn77NVELkWdgdJ4i3HiPs4Ifv4V3DNowovzzNKGC23rlxnDl8mDxQwH7ACP/BNWB2iRB3LXbKFYEPPpmZG65EXPoSuyhz8qTK9QcvHRIUQx4yIxPKLe43SkaKzo/6YHjBkDw7X7zlc8jFLGcB42+tkruwF5+rZTmAEn2jiNlgYtvMMblue6Ld6TPRp9SF+0ZX6cCIM9r38Z/BPFS74knmifFKQiHkbOuJNqzJDN0MZMDUmnCLd170eNK9IaxHxlnoiSyCPygfb0qVoEanurZ9idaDw/Pt+TTQ4zfRuymIb5gG1kkeshE2r3fbgf2Y6TLgBg/EJGuebjvw/k5Pt06sW6lf13xBu7dTei0OvUl/kk/tCR5Xz/HdQNVwFQFa8FWjKJwdFFkPpF/cxzXNDigEbwGwq1JOOugq4hCOqBDUJJkyiFHft3uyxFlam5EBJunMN+bleZv9V+xXH8LBnssHM1mpNxhOHXd5vcj95771Rc4/l2SP2uoFFJO3m1BQXl8oiEwQrJvbqeKw7RUXDKIENelQupD1q6+27EVq9NZoCs7ORmr7EFegFo3bZlRG+sgiOmTeP431UhHhMvv1Hr/JYX5UORMLe9ZY4UtOuxxIO4w/GlnGzfw3gJIbY/fS7Bayuy4T1P0Rfm3dTGvnfQH3Y7zujwY/XlWAdgL/xkJdC1v41o2uiNANYezOL1JdRTmfuaFY9Ak70qc1/mIHu9W4EkUAgKOQV5iwdofT36LYXTdjQqnYl7GrdaFcjRhv2bvH','system','2016-04-13 18:46:25','system','2024-04-22 14:01:19'),('93c59893-779d-486e-b2f1-43fd40cc93d9','7ad62dc6-56e4-57bb-218f-349ed1097ad9','verisignclass3g2ca','verisignclass3g2ca','1',NULL,1024,'R',NULL,'Class 3 Public Primary Certification Authority - G2','Class 3 Public Primary Certification Authority - G2','2028-08-01 23:59:59','85:37:1C:A6:E5:50:14:3D:CE:28:03:47:1B:DE:3A:09:E8:F8:77:0F','A2:33:9B:4C:74:78:73:D4:6C:E7:C1:F3:8D:CB:5C:E9',_binary '*1:P5VUWH5QASYYNu3k0Qzcj18IHBBxBr7DAG8zSVYShthbjb7LZd78HcBNQOvCaNQSIMz5VopGHgf4tHqusrMsKFwNJIhvzlkEFKn6rEOzjIkINsmChj62kHOWcTyfMt0rMKRebpUQ+S3IAh/rA3brh3MDehpY+GKtgTmE9iGgEHWcUBP/MEmF88nM5SCUHg/H7SeZBaLo9PevyH2Zfk35y1MmmXas2PS0oPtO5YvmxhGKP0OgTpI2R+hsc8aczV+/6Fb7pUhlxDGSxORSNJ6pnTt0ywf9WBPRN6drq5DMVfF71cWe7BUFxz3pIIOvICZCK/r0n7IXKr4ervqVgTDbP0okctx41dNId9XVnhyBli/bFthbq9SJ28rKnXpKkk+fV09EA7R7JGFc0gK/eCkiETiepEK9cwURtPxtOOBzROhhsjuKXfSr+gDnTG3C6lSQi9YHeGMNgiHrAQ1xJqZOgVHkfrdGEE6RhzANKb3bK8dssAiyDoikg8iSaJdcrWmrB/x6WAowj9EcUyx8zT4QxDepeo8hHyh35ISwVraK2Kgx2S3IApxRkR5BUwW9q/Fi+4emzso3BSP97fx3a5iF0o/azs9BUWo6HhaSdulL7YABWVs4la7vON0WoMuCQ/eEKoUMdqDYKoPXmyvwIiy1LLksVytczwmxyH7ucAhoB7128tXzWVbukioELhf1KwvZAfLXxPjTRoxbaTl1Cf5Tll/ScWwtkWZmLP6GMdZ825yODHH1xuBXtzY3A0dikd13hDUCq60n865lDopEiZgTwYLGpYoQMQmZXVqtC3zeLCzA7AMCVC3dv075BCHc9aIVBDOggx72rxh25Llbn6DP+ngMP24rbzzSfS6l9X2a4rQpwXg/bJkPuyxuI6J/6VTAHLEyNuv7G0nS+bWjRvashUn2+NbUHGBKZkf+0A1Jte3QEi7fTkW9JY93+51qfeBmq6ZYOcxLPMbpPD7c8fOOU15kYZBxVsYatNnAw7M91NYoV8NXL3+55NWpbum3s1PheDNuv5skCKXDMBVQnFSdMA==','system','2016-04-13 18:46:37','system','2024-04-22 14:01:19'),('969be22a-e527-4bb9-9914-d78c69f5896e','7ad62dc6-56e4-57bb-218f-349ed1097ad9','identrustdstx3','identrustdstx3','1',NULL,2048,'R',NULL,'DST Root CA X3','DST Root CA X3','2021-09-30 14:01:15','DA:C9:02:4F:54:D8:F6:DF:94:93:5F:B1:73:26:38:CA:6A:D7:7C:13','41:03:52:DC:0F:F7:50:1B:16:F0:02:8E:BA:6F:45:C5',_binary '*1:fiPkEONul+9Lewyw5jiDzjrIkXzOpZvkK597r2x2qieApcvMsFc1kTFONCxxPBHNr9rigvDMU2KOLeaExqW0YQSe2kQ6ieGDAptkdJDyrlFPGDdwPb3i1jKJ5n/VGx14fQTTcSHDEEALvPKPCl4nq+y2UMO0ZPmNJDK5a5TVUVbrv2000jNL900XVwZqZlQQ7Sy0nwKJVpkAJ7GZhtAyEoHbNw5ChoNufxV3FC4LrhDBa70VxuFUYwotwS+OzxAyyGirgbVwhUOXsTdGishpUm1sTrDiG1vExBIciTneYqqQJdOThekHEhZkg644f/xTtruPFHkQLPCNzVQNydMnxXyFEySo4qYV9BEFHVKLdWPonuwNr/45Ip4Ay99Oz4LqyCfrEJb1krw/HE/KnREUb9jF3ETXdZwtuzIF4eSI/P/Y6sAtyhlMpzKDvIg4EGNqPrRs6XkdkQVd4FgP4fuUh2vpbL+yZQIHW6uMe73uBJiYn6sxYNpJ1smIi6h8dB6XOP1SSG/VU19Xe0rQu1Aum7gcGAXF1/0mdaaNTIsmsFi8phC8ZQp9B00lbVvH2TN0dskL/7ITWJ7ez5/VEXPCXQPYIOSGunDEbdhP0PJ2H9YJWlPJTXjF2uVz/vOgS/lQ5+bAeSDR6OkhlkD45XVp6M9QpjX1s91Docwl1p4/RRNUMtARIE6uVkfoLJqMnhEKMqqtCgPhvHMW/Ipq9lk3QUhT9CfSEbyLcDOqfoyNoRHrDvPq4unBxUVFi1SUk8mHTIL66Vd098DXP7OjLxt+WS4Dr/I7JngHk8KSU58eK/lq1nXKQQ5UwyYjx0SfVjhKR+9zcTxIWxRjeHq7HxlZCQZhr/4Nd4kQWzUZZLpOuX2ikqJR9BmB1NIc3efvBfu8CgrDGnrnR0I8K/d+0Dggt/k3I/jhVhiKgyaHqjrNHPRubAQfbKlkCNGtI3TPZlrDsKeXyPGSjCKOEWHVAWnhpp84VXKRX/nkytmlGrKHFbPOBAUntGXrAqoaZVtu9eyQP5Qumm3sY29znRVW9N9Mj7nCxfmsEdwpa9LXjHVUL0gIAjFb2hXnuE83p+4KoQ8hd8ALNZIfWB9Bu03wcaCHUEwiIEqHyuNl1Cx9BWJTmIw=','system','2016-05-10 21:39:08','system','2024-04-22 14:01:19'),('96b0f2f8-0127-482a-999b-c52b7158a382','7ad62dc6-56e4-57bb-218f-349ed1097ad9','digicertglobalrootca','digicertglobalrootca','1',NULL,2048,'R',NULL,'DigiCert Global Root CA','DigiCert Global Root CA','2031-11-10 00:00:00','A8:98:5D:3A:65:E5:E5:C4:B2:D7:D6:6D:40:C6:DD:2F:B1:9C:54:36','79:E4:A9:84:0D:7D:3A:96:D7:C0:4F:E2:43:4C:89:2E',_binary '*1:I/9H9cFv4s8/rbR5Qpylcbao/L7XsOzP6YRraB0tXuzM+3uPbjSX8DIz340CDqrWRvmv0IgungCiTh76aqvdDlcC6+Mk24luyxvOhzfQVd0Jzf6n1wSEjVcosB9CX/Up3M1S2rZB66dw/YBvmBHxPxVkjHlaj9Cq1BKXbXI/KCYyqM//R1x4L8XFEAVlSXHcBe4JItKJvPZxPE3T1d/4HTq7Ff5xkhI2SU2x4eRUxYfYi/aL+0zXc7pADnoQ/CwvJXMZgCCCfO1GiJN4x+ok7vU72aNDYzQ2ovBMEsToTSaA71fHCgcsGtoKrgL+fbA4NKpUpgrdSOV50tbu6QR1ad/0G9KRq0vp1YLfhRNg5ImzLpwFRdA9bSumj2v+IzAMr8aQTN95BQMJfidQ2eiLSwdYeEVv3DazqC2+W1DN8NKfUY6BjiAQfzCxygfyu5htSZifRDYumaPaCosC6HrTuUnQzF+BucYmJlM9KpJWWaQQJYOl8i1/riaSmYTIGBXOKxkuz6gSL+7e7T2Q4AWgjQUw4PgSmetqXdAKBtJe3Ddqy2xBHJiOmDK8Nkh2EUEn3CMLC4uBnWhzfz2PZl/ycxXCucceslYMahJEejZ53FRNwglGZYQkFENNgcY/u4/iy7VCcsU/wA7BPGYfurNDAlYGtXVZ2uK4Zvg90kVc4mbQTMMWkGiwJpyO0BK6lATAXpGYjhuEj2ClPeU82yFDpti4Yns/W6JAsorun4qPgsVsdi4AH50SL7phJYHjbdTItUlJFUtX7pihWySByjE8+McEE+1K3KcI35+zn311DaXuHy1wFhoI8+vGTM1G0hubVn6G3yOmTDuqr3jCCIV2paYet/wo7SHpavXxA8+g42Tgom1oAMCckFsnPiDSmWzsAOBrHjCgAPAzRcyy90vR7zXTWUMIvhIMz1K4VdGo+Q3Y4xitnYnNIAZYGwoTAYuljpiVG7AgNggPup2Ey5RftBT0rJ8I8j9lV554EFm48eadYZUeV26fQHsblDCxvSd9aCxg0lmyfzeWd9Htd9mGD5//jaJ6riY0v2k1oZs2Luzr4KKIy44vPDjjEiG6vnWk6bnS4lITKAVI2ExJbO+vcvqqsqfP47LsD9G8jtFwjTxJOBLn9v2+FQaBG9WlZrwiNsb/qgb8LsgkJ82ebykrAKxFYt18tx2if3JwMJaf65x3e9aSz054ufgOqqCzAue8t8OAhItJXWZpgYdKBt4l9hov0fjdnBaAxhGbQb0MLV3fmaWH9GzRgONmznVyO9iP','system','2016-04-13 18:46:39','system','2024-04-22 14:01:19'),('9760c31e-c670-401c-a8f3-adb345a32d96','7ad62dc6-56e4-57bb-218f-349ed1097ad9','digicertassuredidg2','digicertassuredidg2','1',NULL,2048,'R',NULL,'DigiCert Assured ID Root G2','DigiCert Assured ID Root G2','2038-01-15 12:00:00','A1:4B:48:D9:43:EE:0A:0E:40:90:4F:3C:E0:A4:C0:91:93:51:5D:3F','92:38:B9:F8:63:24:82:65:2C:57:33:E6:FE:81:8F:9D',_binary '*1:r/OfaFK+MBIovUQYkKSWEomJp5qn/+KgWgaUp55nJYex7DbG3xPqiKuOLFULBs2m6fot1XkG/2SBUPn/wCDdZFltheRcJGiSboiROjNn6GGYujo3XuzzCkzIDT835Mvy1nqQgSQDJ68maaZFza1FLE/OkaRDBk3ceIvcnjofsc72ClmAtEOnydF/lLYjwZVBKeOn3VupS8cUWPPlXAYgza5QdfLFArmM1C10TyXMTvNlc0JbCgTfa2txG+utb9w6TYKxz2rrcEgPRCbvdJ9CJr0qQbYC3wyD7aj9MoW/tb6obhaDkHYbGmj6G42FD2QRAToZC5pG57ZCliQycUcOohmRzJ3BB7l8sJOAdLRYw1jdWoOcvxxDcwaLKewGrYWUsPMt6y0V0mqtkV71NuxBtcxaRCDM8dEw7PdsMOPJt1AZfvhezMILr76BQ3gH0rrJKyaT9KGQhCCQ3TUxE4uH8iOz91F9JJs0mtJnGaM+pOo7Ukd5T3pDEZo3tPV+Z2CsyfXc4JwwgxFAqjM6vpuqkZcwEXfZxxGtAMkiCw0JCgYMViUWAO60oPG+2lO3kVf43gi2rCuMh/2wXWgLDvTu0KiyoFjiFLqsTdNAgug90JfRv3Mz4qfAvuvd3MkL/jNt1YO4QefbHBmw9u6hX/DM2WV9c51CrBCccJQ2FzL9MHz46yuL+tfBt77AkoKcLGJrCefoyg+RxVR2renvfSdg9Eu2isrBojgb37tittyg5vxSUM8krG8Yrw4SWTrkCl8sJT9cJdUgLRdYtzzZII7SnYWIVDTCHzRWrmUyClc1EpXGLi/79Z4t3CB6cGzeQjYvjBqilJyOWB+f8hPa8ZGG0Z3nmiEdecx23Ozm9BAmTKbFqWniFhk5oKZsUVf6nweycLF0Y8q4d4QgKC6iq+BSL18VYoUhAb2DLM5G7LJxPqulEBAxVplxStkE5vV4F/UUk/mMx3CqVBspEZHlRDzXjfd/hgk7yf1aIzD4Bb7aRKaEY0KLPDogxzSkfJZaED3cAr13HC3Etg6/gBwZv3Hba85xuFJrDgYhaPNsgHuZ6kHsGHrWQA3U9WZrC6O/Fe6ZkQVyrYm4shUy3em2HAFJih0XdZlLsqGjgGlnTVFdaCRmM8NC83xqE8UgVRQhaRMxxmGWnACXtZEG+mYXvzFs4+8cicrPMg/txNqjT7V9S6IqjMlzNGS6azygv/27rYq0jmZ/g1leBBO2P2rdb1o2eg==','system','2016-04-13 18:46:26','system','2024-04-22 14:01:19'),('9a7d7105-15f9-47ab-8505-0a6819ed5029','7ad62dc6-56e4-57bb-218f-349ed1097ad9','comodoaaaca','comodoaaaca','1',NULL,2048,'R',NULL,'AAA Certificate Services','AAA Certificate Services','2028-12-31 23:59:59','D1:EB:23:A4:6D:17:D6:8F:D9:25:64:C2:F1:F1:60:17:64:D8:E3:49','49:79:04:B0:EB:87:19:AC:47:B0:BC:11:51:9B:74:D0',_binary '*1:wWOeVtAdAduY+JlWoj495eMRg7eSyvkyQNFy3PchnrsqpbzUQ3v+bvzkErMdnrfD7iWZuvnBLWc8z95Z7ZuN57BhU8efHMSXINuWVhf7ox3bvy7hY41F6aTH7zzM55E06p22WCEwz1Goucj7Qm1wFgTb/hIG/7ELqO78uUQia2zHcm/2lY0seVAdqAe7Tf6/KybX1pj2vD8iF+b+BCp7wBBufJ+gqeAdYjVo1SgvUMoxc7TEMDu8eWqWOV4nQHkbT4o4afrRmy9CGqTCiKiwKFNvicnrlxrj0SC3Id8Ph1nsixLRBHxEx7HQzBPKSMpe26b4/IB4cuHjxLlHE/CvWBF60j3M9OyZ/oZ0hDet9hhL0oKsdAUl7ZjBHg5pFK81P9omvtZoJCWcklyebyqPfMG/we/LNJm2cK9zsdpCexnxE5UXgjP6o6sNDsOckTyMqgGf/VwV15CcnsmY+HBbJyVvc0p7RLdHtf4WUajRe+vIJM+lrSft/10RP23saltwBf471aINt5i5zVj2xpxKlN1kE/kKN89kFJGaWfvOAgmbb9UPBxheM2OPGwgvTO9iZtq5EQEhk5eKcZXQd2bLG2Hsqy4Y14ktDaCdRwkxgx1mrnF98rYRU2npK5n+VYwMtBuZ5sna4++czHQ5aQ3wXNAvNE1iKz+E+916fxzhXww/VkpSi5Mxdq7PKJ9TPxOUV26AtWALucKiiMozWR2cT8CXtkSDZEGZjCD7OxaGZGEDlD1pa3ohweBq5fBM94Vz63aI6ScXkHoxZ56zzhUdAZMncF+31ja+m4RSGHlT9FShnmdE3VPw3UdfPpEMDngsg5ue6STx3O3PufdniCIzlZUxHAR3wjZnEyghzyny5rcgENMg5lscub3Iby/eX0MR7HtL93KXrNtyWv9cm85zyEDjKddRB8Cy7url29hYDfCy+J2mq2cR0Rh6r4Wq3tidj3U103cMndvO8nFxiQQYfE9o3PYRMfX7pepUiGFsRaU1DIIsw+R0B5eN+E+MW4gg3oAJzrekKgyJldRrJgp8E1JURe+/YXGiHi21VsyWwwNl5MT+25U652HoBWCzlRynXMgzB+Rv17WmSlvIBM91qDW/x5a8yH7dkF4b2IIii+sbfcvXX5pighZFUcvTYpcfR+W/FNjAA+KPDYkoHQN2QT9FpwHdMO++UK6iDMpOeQSUC6p/nfq9GqrCcLePgzu9W9iiz7gDWasblXl7JBX/plNYCpvSjFg0UrgsS3TSKBpmJxhgJTphkkGhLM7EQBUFsailrg27zKYy0wHARowAUMOnIgfm+K1K1r1i/Yd4yT9iFjNqeGUMMdAdFP7aMofh8rN12myzsOHi/s8g2LxNPmMdlEwJCDOnOyW5oiFdWhubbWcFKzp0GA2FiLcZjUcaGpmfR3Y+KidZ88WHMEiwPKh/pmqkYiKkRIRkCrSpTyY=','system','2016-04-13 18:46:42','system','2024-04-22 14:01:19'),('9b21d2f3-ac55-49e6-bd21-bd8c6dd17866','7ad62dc6-56e4-57bb-218f-349ed1097ad9','starfieldclass2ca','starfieldclass2ca','1',NULL,2048,'R',NULL,'Starfield Class 2 Certification Authority','Starfield Class 2 Certification Authority','2034-06-29 17:39:16','AD:7E:1C:28:B0:64:EF:8F:60:03:40:20:14:C3:D0:E3:37:0E:B5:8A','32:4A:4B:BB:C8:63:69:9B:BE:74:9A:C6:DD:1D:46:24',_binary '*1:a4t8n/ApSEVCWN9kdNpA//JfCwj/b458vIww0VLvZyp2K4hmSqbO1E9QEUOkfB+HPNrdhMFDKx3lckcI9LTEcqE+wM4C1M6epReoewSIdYDR+A6uqcqyascIKA0gNVoCXkA9ZlknJdoRSN4IGFfqPI5FCGJSIYj83Md95fBb/s76RSrUnYDiE1jwrLXpkKdU7Lw2eTwfd5GWbRA449WiDwGr+myFsE2aRe7qCueBMdZAh332DCdzF01Wrcb8hI51wb2ApjexYdQXMy9CjJL969taJVDhWzI0BxpWzfVe7sdNAX6H3TLi8lNYbEHkgflwigmMdF/kC8PE4c6k7kbOHwhGw3Fexbe89nMvsy4jonGc0Zg9Ow8kpEvpUeDsa09YvbGsJbWALRbFhRQoT9aYaXi9LMGqbDw3CvtCDn/yBIwoHpACA5GTfB9atHVpEmWCGl4UxE6oTvFg4l6pxE6w1lFutH5axBoIsFCp8IohD17i2PQJDoEJZQWLuoTpt1o/2XvLzt4d8qQgmdVefvDrjqI9qxvoQyVC7xRBmuwN4OyiIfaX3jDMcYSOud80bG76wTq1I+Xc6a7A7fDJJnTIExumTehsNnfW9W7auyTohU++tgw6837w8xdKPoHumuwlTKFsk3C5vBY1X5BmKyXjZURVDHT9jAjL7ZwLln+GROBip1ttQ3u8IP947M0/umfvl5u7Jj6ZY3D+Wp56wE6L+z/OXvDkZXvOBsoVkf0G3BB2eWJIfhujpoDIeAeSfQBuzLVwa+QHp34yQCB0gZRfnGa4JRfDXScXZMPiJbNaewNlYNmFMcPVXiku2zhp4IarmdoCpdxupOLS6Z0cjl57uYSh4pI/rgqZiZuSHMhzumiiHP0XFONagfexLdNwvmk2KaIiWK2ACSSa+X92Exe1MAxg47pTM9YImjZ9jDQFkMT7wtpPj6fJqTvFSD9UFbsYQI5ODmMXvXfPLBzPubExkWdcCu6oyR7n05zye5oPf+GQHWpHKD6PBYakZ4vuWNnmbY88ZyetMkz+b1py25HvZ0W5TPSsX5Spn7yTFNg58a/k9F/FXSROYblY2lZXd4Qme+uzRawrEZIkcbBfELLtk9uIGO7NGSPF0udprVx0pboO34vV0OybsKBk4V2DucvpMdX514/PNycw9bf6xrIe1tzc4+qXGRvv5lOX5u8/oYdB3ZhmISoXxkAtM6MxdmmtZibIAwHo47FxqfMBmSWudzpakg+pIxREdRb9/QQIt9d1Ghkvi+r3jFjaHbI9ebihiZ1430yIdBV9g8F5x4YLgFe5ztUnEvCotMYY+7+3dX6/E41Fd+m62REvd3VMjxUaCCLQukRBGl12NL8WS4Y/XKNxV39xodq3oqSQ+PZhJNfRg9vJnGd61NjaSOTBVaDv','system','2016-04-13 18:46:33','system','2024-04-22 14:01:19'),('9dd85bda-6abb-4508-a5ca-c58fefe1646c','7ad62dc6-56e4-57bb-218f-349ed1097ad9','keynectisrootca','keynectisrootca','1',NULL,2048,'R',NULL,'KEYNECTIS ROOT CA','KEYNECTIS ROOT CA','2020-05-26 00:00:00','9C:61:5C:4D:4D:85:10:3A:53:26:C2:4D:BA:EA:E4:A2:D2:D5:CC:97','CC:4D:AE:FB:30:6B:D8:38:FE:50:EB:86:61:4B:D2:26',_binary '*1:VgM3T9SKKVAP/X9dnMawu3qivOUCuzY3DRAcZVPlmyWZZsmknnfQCURqG14FsyGV9AFbtGGCUPU30NE8ETJg60mCvCJ6JOh2tChl0kskFqqivjNgFbfNtxHox1JEvUnEslkYJ4Uxn6JUMi5VULGc5tIwkZOlmgTmwxl4fFcXj/fBSSz37P7x/XkmAM1cYeB87osxSt7BIQ1LkLVYGwFt/XYBHxl8+5DbCwCZJbaod5ooJjLhAYV0Kru8GGP/C7Sr14JCw4PTGil3LvX7MKu6HT6Od8fHtyQCoRKw2uM2wvEAeqtiD+kmu/Mpu7HA/4bxVmNZnfww0dhDA+E8symM3dabqGY6e7tn3SzgYGjMQim6HBXxwYqH+NUFxAuWsSJ/AC9POhuLxJIJPPlLypZaJkBEfa73QCm34rikj3MFktYgBo84SKVdJJ4xJqLoKsas8au/GyaogeLC5SAcLaBb3yZju/arKmZ4iiM+T8d4dQuWYIm2Ayhwo9aWsKU8NugIIViFWhj8OK5KO4pZzgfzzj5KIT9ycUa1mfUrR104bIQLWOlNFf/Bxf/n1sAOCFB8XSQVfuJGgGLfZRPHKo4WiuYCRYo0EFN91AFDqXT6Lf5WKKIYKmGnEVHQCyZswoA49NgBmQv6euQcBjEfNbO3iYAfVCtvHtR1fDzvZ/oNlFRd6D7s9GIn3pUIOgXtSbIZ6YdA9uauIyt4JFnJl3srLOj1yS8iTnVcHzuoQhjBtvPz2OIf8gZNofZ9WWKb9eUNZ2mCOgPtsnv6luAaGfq2bgGTacutwBdtCJhmFojqVuZ1CkIU2zzVbJq4+rRiSj8Ku9FyTExmu53Ttb17C3a7+/yhGrKXq7gjQ/N1GaS+DBG64uHu93E0v7opDR1QxJ1cQHpLQ4ZGFAfA315hZXRVyp0f3xugz51rDfarYxQRtVgohsSENF3AOMZNfKxlYFPGhrGbhOjBh68dO9HOTiSjgOvD1D2QhmAPlRGch52dZXs2KlaojvUXiYNyW23IALrwxCOm63kSfLEYJr+F75K9taMor1xRyH4Kk39Ds7de+diUiOU1rUFYFagm3aM+laTa4FkQ/akhS7np/ZcyFlcUjBKeIa7+gt7bprgCk6wbyeM8MC1KF+Pzsa0lRo0FG0S+6vjpX/0Df1XhkRWgxOmwNUel8rCzrODM3PrNbUOCX+WqH8/3Xq4MH4wb8IdsGoP55GkhXpHa6cxJlXaPVPdX7hVaoj4FcbOT3mbFSaXS1JEltir+7Ol1UdrvJu9hV3RWcQwki44Ud2BC11/nzb3UyFYudyiqA0c8LgZZhe4fk/TahjW6nOqayJ9YHrrguMEy','system','2016-04-13 18:46:43','system','2024-04-22 14:01:19'),('a166f743-337c-4a3b-b1f6-efb8a39af9f4','7ad62dc6-56e4-57bb-218f-349ed1097ad9','entrustevca','entrustevca','1',NULL,2048,'R',NULL,'Entrust Root Certification Authority','Entrust Root Certification Authority','2026-11-27 20:53:42','B3:1E:B1:B7:40:E3:6C:84:02:DA:DC:37:D4:4D:F5:D4:67:49:52:F9','D6:A5:C3:ED:5D:DD:3E:00:C1:3D:87:92:1F:1D:3F:E4',_binary '*1:Sffvph2UPoM3GJ/1EpM/PKmKTKDEVZUPvuwvQtU+bBCdqsGYw67mzSb7UXKo6tBhP70aK4lP4uVRzRuWHeosW3F2fepSmo+9S5gjS+vc0WuT7xX289ZHk2zMip8MFkQpBpkIKo9qdwfCsEHKBwWJZmjOjiynCerg58cqf+o814pDbt9GLP6TKfFAVDoLhu3dabnZqOWzU7eZWh+7x2qo6GkDHW1WscLu8cLNp3sJj9z9EYFT7zKs6yCt8bsWvZCa591HzlUTaPBZ9V8ELT3wWeUUYNyz6wg+7v9xHLeNpXJNt2c+NrRzkL4M2iromT0xZoSunyu3RdDGNKsW/jSqIjMu6m6v22ZPch2Bt6jjz/q2qJojT5rUFvryTKYqUqTcYZPj1rHs/xijdCvaQ0KRL1+7L1s39AkAzAsTF6b9SxeoNU2YlKLmSTGjVP5+pD6EmUaPDj8IsiZo75Zr0VYnNXHSO/hKvp/ga5iARNccbE6fTadJWv6cM5lhOFsEXVqYT5qTgaY5gDa3RT9Vb99D+XUIVmIELLadw4KH6+g4vyufNvXQxXK/9fr+AZm8zPWwN5tKglInSkYMHyck2c5w3ojE/iwzHWiVBE7xQMtEE1NTwfs1mPAl4RNoggDlfJnKsz6/j/DiuomA9B54FYrw4CeGijvG0LQBaTZhAWadgTJohF+HCnE19sh0iP3MOMR4borj2pCDIkVqToglDbhOh1J2CxJmP40qiiJVRZx5w92BbCSPugRdVWSaH0aykFVmocDp4WPo7/msV7B0bGBLigAAQrsfu4MXLSi0RVAKSMlIEISajMJFkBXG1ZQPhqfZTbTjyCeBPQjYCnh5W16igFZkB4nOpxe4rKAOLpiqx9OIu+N9dCt+Sa7kS5OHP0nS20s07i+C8DhVKwI40gWaXvfK2pEDf9UH9Jo2AAqNeVRvfJLDO+yLxZ5pI1zv2/sPNjsIV5AZO4d9MLN0+/50UeiZIn/3e1axpkJDeo5UyElw1uWb4AF3aU2LC8SkYR3Xhd0WMBjkxoGc836RqHW7rtvYsjPs5gRRvx8xI7IYKBDNheIJXUxfXUzQGaGjZl7WBnhcuUg8nf59ZatJV7/TmbO9IsSetjY5/vTePM/q+ksvyooDqalskBXsSDLYzB75P+kM7ojFxjS2fRJzXimwDVPFkdOhUY+VgEo0K2AZj3Gvora/nxshnMnkIJ5c95hITFoWduzv+O0Q18uS1aUpOU8ZukrwYE2aV2Lzyk0kbIoSwZee9/wuZ8Sm3Kwgpv8lrpEbMoT6V9v9We6n8jP26yuKOE2hix/mx/4+KhXpkqb9fa0JWxN55qqGZYx/ZlBou7nMbvRjWhvgWthWDj5uViLB8mUAlosanTdxCqSC8Zo18xA6Uts819dw+PY/9+w1bLZ0RpVF6fIzUA8qlHqaKRQ+RNctkEZyHg6Lfn+4821ScRT/OfoLcgYo9FgBudbTwPMETGZlEJ/hDt5AZQr5b8YR6+0rLT8ON6xG+gLs3TUCGf64sv6+GohEZD2OFlABhMRprKQqE/myDbVuU01A7fEi3o0P0O+PyKO/5bhZwDo=','system','2016-04-13 18:46:26','system','2024-04-22 14:01:19'),('a32f00d1-f311-4f8d-af48-e7e750e4ec9a','7ad62dc6-56e4-57bb-218f-349ed1097ad9','equifaxsecureebusinessca1','equifaxsecureebusinessca1','1',NULL,1024,'R',NULL,'Equifax Secure eBusiness CA-1','Equifax Secure eBusiness CA-1','2020-06-22 04:00:00','AE:E6:3D:70:E3:76:FB:C7:3A:EB:B0:A1:C1:D4:C4:7A:A7:40:B3:F4','14:C0:08:E5:A3:85:03:A3:BE:78:E9:67:4F:27:CA:EE',_binary '*1:BBK5hbi1/XcfjXHT5r/kjh4HSUeQfb9I87yL4gb8LiiiF+5lL4SH4Fg0FRBYzeRqo1ApdHJEcnv91wt8WS5E82YGxosBqECS9su5i/r0M5awWIf9p9Ky+5BAkuBeVQQ203bwQKx16K9awgT9/7mhp/AgjpC6Jo/sM11zsfRgFlUILbw5ewJrd0UI1H0JhdiPRlaVzOhJGxMgPqb+pmEfe2GcWuU1TlhLtex/jWDg1VppqV+Y9snpSlKFIEuqru2RHjFJLcjuSgIhn0G2TKS716qJNitojKKj7TWlYe6Gzw330HTDt88ftE6ttzCq2pDqF0+So6zkKz5XJL+FNSiX6gYBuTC9iLU33O0ALj+WbgqMeD6+N5jRwzLC6l7jyYqUq89HrHlMt5prd337Apm2lJ+c1rRSqUSJbrKN/RkrTJGRwhEFp822V+dE6zIptVc/+c9+1RDGQCxZqRgcVje/hlGHSGWEQKC5tInyj1ARdMAye2cZspiGvvNO56NbeqkMQcDgIaButR58oAxRCkGt+FQVEPafFMbJq4HDUUa4qK9imYhAA1A4YxAnQMiwERArvtFmAZYglpjuH//ZNzlbLtShocURiTD4R97Yl7yFn2160PIrwybxDDFtSpfkeTiWvNQgC1auoBpHoqDrvpxQTIh8KM2Wn4wt8es5hOlt5YKKLbKG+CpcmkXDNiGZeA2XWei2ao1KHBCSohMxXPRrvJukbczPnpC18EiJdXy5mwO7Pujai5eH4+gvwps6+kHWPyXUXBFT1wfVwV6NcECny+nRqtlMdTUS2yaauqon+5kAHxEOGY3il72mSpHhLU0FwtkOjpxMToy3mfA10/6CoikqsvMRA2sVWKXKvK2QfB4=','system','2016-04-13 18:46:25','system','2024-04-22 14:01:19'),('a925f32b-ac1a-45c0-827b-96939c4df69b','7ad62dc6-56e4-57bb-218f-349ed1097ad9','equifaxsecureglobalebusinessca1','equifaxsecureglobalebusinessca1','1',NULL,1024,'R',NULL,'Equifax Secure Global eBusiness CA-1','Equifax Secure Global eBusiness CA-1','2020-06-22 04:00:00','3A:74:CB:7A:47:DB:70:DE:89:1F:24:35:98:64:B8:2D:82:BD:1A:36','51:F0:2A:33:F1:F5:55:39:07:F2:16:7A:47:C7:5D:63',_binary '*1:1y5U2R2TSStcaTmWso90IW3OrTyJbWc2jnvwQ9fN+R6TesqN/MnyeF3FJyA6VxST/XY0twrZq+L6wX66pYvcerqIbtRfewS6MF9JLTe/daSN6p7zUEUYiLyV/3MROHDf0W58bA2MllvQeyeMXjtU4yOzHCieVjTn9aZdUQtEedJDuwQRLjnSNBRkBEupAvJ5oeyIxWPD662lLUeA6WOMSunUzdUPJxfErZ+wb1LoyXanWhnmn62jCM1MMV10NxHc7cpAq//7MOaARE9b1FQu5joktWmrhgpblR5xqDpwLTeFsi79IDxs3oIm9OsvTKX1hdgxEVOusX6XwxtKDpoV7l5jo8wIF2bTYnj3cDZkrWwnaLMSI7jwo4BSCH/0n6+Or1o2yj/0TkC0HzJQ61UucgttGhSYKLyvj1Cz0PJGPhsIZIRK4SWzmzsRu6j0XaeY6jmmO/riw+O+qd7fC/z0P1ZuwneXS0kOj0FC6bA38vFztbJwPc/I6trFKpgnlVYjThiT3LRZ+C9nKQxx1EUkBbH8rFoZI8RSkyQHA8IOJbd8GIPfZcoJcrJuzl5WcYGZgyxecUWtupGy3bMYeGe8KO9OnDRqL0WuzXEqWUTVBzoO6muO9Dag+r7x/jvVYi2jrzSNhKr2nJe0XbCVs1isTiPFEuttvtn5VYxG3MMculmBT/ktp2ki/UbojvnkHX0H1akdfEjk09Mynzoz4/Ofjm7qBjgtSO36XDe2z40mAVxjIbhlrD1OOCLXPK5hbFPwPbovI2PlXNI21QXjxs7R2seMpWFjoU19lG9YYznYIPwkm1lNe/NoyW/cScj8QFsYo+doV3K1srBFFwR9QJm1a6KElnzfM5qPHGqs7nsvZ575FLdnC29WHlTX9PvTAiiL','system','2016-04-13 18:46:30','system','2024-04-22 14:01:19'),('a955c437-cbad-4963-9dbe-24ff2b314e01','7ad62dc6-56e4-57bb-218f-349ed1097ad9','quovadisrootca3g3','quovadisrootca3g3','1',NULL,4096,'R',NULL,'QuoVadis Root CA 3 G3','QuoVadis Root CA 3 G3','2042-01-12 20:26:32','48:12:BD:92:3C:A8:C4:39:06:E7:30:6D:27:96:E6:A4:CF:22:2E:7D','DF:7D:B9:AD:54:6F:68:A1:DF:89:57:03:97:43:B0:D7',_binary '*1:14Eaci2CSLcFM9UCtewr51fGPu2UytPR2sjpm3QmuTXJpw5lIA0pH9ZmIEQEpbs8ffNOzvq2uxRYHLSlqQ4j5Jp0bBb1vUH5gyaz6saY3a768WIiZvNeu/15oXvCKov0fypujowxKshKteg6tFmKZh/c7p1ylyTCLf7QJdj8IIAMU7WynGGF9xzrlAhzLZ99+7WiA7FiFV3QZmFwDFWGWuNEUfrIQBRNSgZGTNEPFxhLNDuiBhPhj9YNbc+o4HCfrKRMr4DQQ/x5mO+DPisTapDK3Cdwyhsji2QRJhFPcgiEcvY+vjH5C4t+RSTbVLM+py8lrY4ReVolDoT0s50pdrIG+jq5IM8PfLzNJREttyY6dnvD+bj02fq0nkgk5hJqpwuHTEBtODGCcOALdSKRn/pKENwLTqlCwNHS2seU5CSnLYkGe3aZVVdxczezf1OO2aO5YR86laZONuDXhuuusyehg9Rmrc0/UiwaHBU9zVJ05Xu8CyFKGs1PwbDv4BIiizmQ9xzcxUF3oaqLfQx0GE50m1hw3TVmjad+UKDC8QiKPxAnJtlg2NtX+IW5HS2gLOFr8jmoU/cuqzy+tnluOkK/H6PNU/Uh5FpX/E49hxFSDCNQezPE+3rsNi0WiE6QyqukCg6eBaPBz2QCuLHDjMLFU7rkq0BjMlqrvd48yJXKWADVluf2lEIq0yKNLqvtmrqW0lGfWHnV3844GP+dbQ+ofwjLX81dCpK2rSRFo6zgj+WuDWORnUV8WVLPoqlKl9+Ai7E7VGEv4WsU6dEiSRjxaqlk2smYtY2H9Jh+npCLAykqQdeRg/FCZNoJWexHhPoWpp7tF9ZKWfSnqQQvKI0V/78U7ReHR/DKgZGdXOiFOnZBxgExe+DwVB5q54R/sWTyO4ULVcoGadJNW75fC3kLf8gY0vKwGf8iwCR0deF8UQDWhKXE5x88ae2DdY6/3U9W7xcRjRVjvUrC54oXjQf8aFed0BVCkmz4GnZ+NsJA+QIPMcecrBiVLPT4UUIU0bS5cLD4MFw4y24D0gN+hhp3E15YtA96QgTKNsecBKoI/5ZCBRixBLUsZ8OJqwt10/X0+7MEZYS/pvZ1cA/I1QRXKSFmfH3MQdLnL4ag9Z2QjVdyv9Y7HZwLQckZvva0H7B3qx/p7aOTs7M9i+wLKRXLw0pI4QtyKn2gMlkIrbQC6WfrGtRz/cWoIEfStPlAjNO3A16en53jVWe0URZ6yIpNLd+loNA+rOEkCd1CEikgWtrDoWkFVRYDRXyro2bM1icwXeE5KWtUVBZPqG2O3Hs10c7XxftZWowidWLMNj7eamzeMaZ0aTqzxcI4E7Qfnawx9IOhN0rx+RirfUND/V2+2Epm1mc1eP3AkylUHIDdfeuya8gZz03sZjiCSwFkbK0HWJDapuT7TIVsdwE8Z2bGNHsRaX0Kozvo3QEw2UgMFGoDbz8TMJKW1d6V6wLv0z80XrNdS/ma4/n5KQ+cX65TlrWR4pFzXzIlcjnwx/mmsNxBmYv0ulOoWyQM24A3uT1bL3hY593YaswPYsPD928Viy+13hmVySOUoempcXqPTw2OQmOtX4snQjFgC2sya8NViTRxttB/yhGX9YyN6O8XuFLzPlnCA9Qxk9P41TRsXGcxkLrBAdmAQExkWut9Y7a7GOCRo9IJM1j0P4lCvBUWb1tSun+iCxjLzeLHOnUfkyRFiq4hnd43yYAcr6UosRPv4RG5T2N8wIq7OW2g7GJOwNGXOTNau5TibaGHbnzJ/Q3NqCUIC5BoKfyTc6YfMlw3EfrQshaqukNYrA+YC+Me7WJa1itHPC/6yETD/jy7usjUUQFMR5/csifrmyRN','system','2016-04-13 18:46:44','system','2024-04-22 14:01:19'),('ab8167b8-0f53-4b77-ae3c-b5b5632af373','7ad62dc6-56e4-57bb-218f-349ed1097ad9','identrustcommercial','identrustcommercial','1',NULL,4096,'R',NULL,'IdenTrust Commercial Root CA 1','IdenTrust Commercial Root CA 1','2034-01-16 18:12:23','DF:71:7E:AA:4A:D9:4E:C9:55:84:99:60:2D:48:DE:5F:BC:F0:3A:25','B3:3E:77:73:75:EE:A0:D3:E3:7E:49:63:49:59:BB:C7',_binary '*1:SD/osex1KI+m8dca8pqt/JSaqQdyaDuV3r1iOPoc54tEyI5hBM4d1sxitMScVB43DeB2MP/+BOC/MHXevnaLucMH2PtRdhzvsZRNX84dEhcTdlNhclCVYYFrCgq+q1ioZaUFWPPqWnwlQeiifNOEJIHdlXQf/QDcd59RdBfScaFuPEI7pHF82G0oI9zS6C8D+w6/j1WKpvKMYjrmBYzmiaugnURZ238RQzqpa/+NL9PqfRVNov0ysHcy4tEx4MF4i/Zk06AJ09fKd8vf7wzyVA+eAblFRxqW3oBJB9qOwDaLXnLodHmeGw0Mi90loEUdeYquNSY1GamKw9AF1lJo+66Kta3XkLjfo8UZFpzrMQnxw6ZKokENJrvZqJebYZJ+XNRF9pqSoUtkB3+xiPV3vPWBVkhBaRyC824x8ZRiNPy8th4Htob/eMH5rQSpOvPksfVIDbUJMfP3Y0jJ3p2ZLEYCY22y1ZT6YxutIvxWtqxRPyldlS15pjn6bclDRTAZRxJNIXombjzh+cMJEsr4qRh94HUjOUHLMI84T5h+lV64rq6eULROmsdjRyMKGJy16yf3l09fTk5bt/rnbQOTbwyhh08jhXNxsBoW1RGm+o45kt7qP3yZFKxBWpySFVFESPVAw8wqQ/np1Edx3qEeSF0pP92AXh2kOm1Rn4lP/bdMOSKJZi6AeqLUCHtB4A+SKoZJXsqlA9fUMgEz3rVrHdZOIudej3JhgGn+9sQg0vSDM7EA3T2OoWEuloNy5x7dUxtMYtI9K38o3eJ7Q0tTtCsaOO2HAHi4x8cc+P9sztekvJRrNc+a7FV6ftCPn1QcJOTb0u18ETcSIkhRgrtMulaiyT++0EKivXtRuxgtx8MZP/u55M/QEseauS3HX7H6vSRXEbdYb3AirW4R/VBk5XucSTIAyej7thmGNe0xvdCBWWh/qymO/8/k4+Js1/8uohygRN5tCWtQRZ55It5xBrDI11OVNSvpKIlLk3BiUWa5tV11bip4BtYYXWmkTEtJXZnFP+UXIL6uzf/urMcw4SDZK/lNjX+HTNSVOZWxosFUhvfx1qp+G/Z9jgRS49LFIE/BS81qGuVodwaWk6gMPi5a3CZotzSzBaobjEI/j86vvEWTPCOoWAWbTTtKyPLohcPwF3PMQvlmtZ/4VAk45epZpamLUK/NXVbD0l1tRZoirKfD8cyw2Qob8jymg1pvGYlp+gJ6LltX+hpcSnCrVYk5kzOTjSzb1FOT+E/n31FWllv1rhqgKvOsGLYslJUDo9CDGGt1LCmOHi6MOAldVHohQIY6/GQagMNBL15kx1nk9B45L+bOaEwXmWxdf4esk6vbHXBAOTm1uyy1rIBI6gKtnVnF4NU6USGRoB2xDEK7gPEe2XQ3jycEGmUHyUiTKODvLOfMpqQ6NUwX6bifv8ErsW3T5bMWWlNMf0kYsD7lVRyNdAJKqKdqrbsjIQJK4J0lpmP/TbSRgt+ASjQQmn3Z7LyaRnkauyAbBhWbbLsjikP1GBqX7wpRygrmkpx/M3dxnEdP/0kQfJxzCNs8jyKyo0SSv8Di2M14TzjVBBOl53zpoKy5KCZ3xi+lbqfWcUBzejug+ZrXWAhQnCLOLea7P0XzgC5nK3QCsdK2pwdhKKFU/4sJsXYvmBuV8QGsd8MDbl+JkWUpx3tbs3vhPUhWEn3oEOAKe1m8tHOWln4wtFySOdrBc20CRBQOm6KxCsjnfeFzH1PehwJlj6ccgUE+MPR4Fqc19yGw2yo5Fei5635y1RcNQZCsscflXmo6ARORpY5VvQHrcNUQ0eu/Peszkz6giinAMOh5pNzeRJFAgizhxZrwLN87mzKiu4h5','system','2016-05-10 21:39:17','system','2024-04-22 14:01:19'),('acc0e409-2fa4-4cc2-923a-0882e3e93ff7','7ad62dc6-56e4-57bb-218f-349ed1097ad9','usertrusteccca','usertrusteccca','1',NULL,0,'E',NULL,'USERTrust ECC Certification Authority','USERTrust ECC Certification Authority','2038-01-18 23:59:59','D1:CB:CA:5D:B2:D5:2A:7F:69:3B:67:4D:E5:F0:5A:1D:0C:95:7D:F0','FA:68:BC:D9:B5:7F:AD:FD:C9:1D:06:83:28:CC:24:C1',_binary '*1:nizOL9pyhvzR5zgoV3lWLKWVUcz8JMoUQhhR9l+YElVpHH1MkPsOXeJvImv3t0pn4EmWFLKbPyd3mRrsOXdkaw3viPjtkq18p8CVT60JNsBp6RsjldN12XrrvIwzYrzGos/k3lymDnZbJWZWtg7Zk88ZPBQEAx3Uo+QrUlvknC7Nq6/jtRt0GBexRmxl0UECjEu3uzDn0IqnLaR12EUIjpwtvT7l7pN1aEzeQIvmt8gHz4M2CiRs+Ts93vpX9nl9tx1w0qhSfRrB6l2ndyXXdJefqLCDrmH1jm3BIg67oj0nqEzibk8zz/6xAe2vrRqDwERQMnzl96xt2bc2+1QDPEe6I6hEzWrlcuqKUsPzqdc/aTlC++qJRXDwRjDsftG7oGBzIzHvL8AzDnN05beey0cZpZGoyANid6wgqAnFItri+wM001ntoRYGyZ9fnmL5yCCh6eDIWdeKG40gs5mf3Ehrd5C5EHmS2+RHU5xMn6fDZ1fBuaH+E0nzhDhNcvieexgQjA6jXomOHnujCX77KW0zddmIEbUvstN8z7Vtg5125NXrRG5iym6BELdalzzE7iKJS1nC62otL/uCyUEPadOcczprQRgEcZY7T7Kx029fO7isqyxKPf/grfYaacVdIE0cPLQE6V9JH97H++/Vn/B7Y4NLPorDrJ/p85a+uKQKFgVrRkMvemjJ1Vw7hM/ZZFOMfjQ0J1abbrih5YlnfZoWM6rEoHogBfSEduJQlejlHTRGPiOqVryqRBSC2Of77FSj4EOL7A+3pC7fFyRwhK/myGx4js2E9GbnSc5JmGeuNj674HO2mWJSOlLffC64n+rL+PaTETp+I7ahsQIMbAS1/BWCi5RuS30YvIxrjBRm6TEn2N1yGShW8QyJN0Ib','system','2016-04-13 18:46:47','system','2024-04-22 14:01:19'),('add1e0fe-1060-4b89-b2ab-edb6b1ce0c7b','7ad62dc6-56e4-57bb-218f-349ed1097ad9','verisignuniversalrootca','verisignuniversalrootca','1',NULL,2048,'R',NULL,'VeriSign Universal Root Certification Authority','VeriSign Universal Root Certification Authority','2037-12-01 23:59:59','36:79:CA:35:66:87:72:30:4D:30:A5:FB:87:3B:0F:A7:7B:B7:0D:54','8E:AD:B5:01:AA:4D:81:E4:8C:1D:D1:E1:14:00:95:19',_binary '*1:wLWnG1pm8VANf3dxl9BgMmsi2bEoImaPDM2M8AVxo/xbnGo8l0Jkweg3d/ROGWwVRCSVp0mIq2LIPFbcYPvKT11oaO5xj45PonDMqYBIxGUezOjQkkEHbu7AeGTt/x1ftXMMarP9CasxSizGlNw+/nqIfhAw6wKBiRZv1rOkOP/xdWtCR2KyaKmCe9QFDzYI9ltPf0tosj4vLzHkNja7RV/ep+PAHY1lgXNn/RR8eLOMljB09XF6cbHDQkm8ZlE9CdYSlfg6XGp31TsoctNCdS/W1aROtIucogDYaVbqpblthNjUvR3pJrPXfFFs+dOBiUO1Y+u87PIlufzLRO8qu7qfhIhzSHf7Rq0JkxQCtX2webCRDyXMSPNqEqbIKAciWGzfIZjLMXFS+qUqWIifH8oIsSNm0jtn+qV/cgl5gUn+x0N2DQrDStiu/3NVdTV+p5VGbBPs1ol468vvclV+e0a6jk5zMp6sGFSgYGlgeZVvSj9xpIvU34qhObuwrPnIWzTxT45msZ+y5Rlj7sVhhZ7zlbHohqFCkuGBsaJQozszAoR5Hx8vXnRDIZ9EdkF8H8OBgrQ6Pkxzmejnzl0De3CsvTwmlHRobId6mfG2Vyf7BjbOcE4VTIcCg3s60f+m4DmZ80R8nsmd9g+QzZxlG694YNPudrtPjZKtBvseMOodFwZgm+t3k+gy1mTCnMGVkChUNi70A1kzjizn/kl/3Ou0xCRqEqQ1f7tgGh8enpf7U0IDmLwGdS73gZVB2omqvHhud6A0D8Cs3wraQ1mHjaJh/4k81acmz6q6OOy+DD91e1M+ybQSCmlGXa67/zaxhpFD35qDK7sYP1MKEA4O3iJla70rPr6gZjC4pHJadZuwUD9B6b+8boj9slS//280Mo7NkVT/wzp0Nnt3lYhcqVeokPITvXH0q7yPDegEe9kYmVn7XM2qnL8V+NhX/dJVcfG2AQVW1N0225DVcC3bn4dXaN+atlOruF7ydhhY6IOVx/0YHCVScNRKw+n9e/qVOqZFUY505pq1wKOuBjaIRc/MGj1BnSHmLmIBxuAzcd3HoHQvzNzZsYX6paerAZXUx59WHN7Isf2tobRMVoOCJ57iI5GADHduE7V09sMA8OuBs+SC0pf8r8k/0dcLnH8XMaJYWoYh7s4txFnlWOyNaT2SOCmoNgKO6sDA4PVHY20R2N9Bepn7t34aOAlo5yLkWHPG551zH8sC55BUjB7qFo7iHOZJwDKDwW5J7aLZwif+SDu8p1C1sWuqKtI+ubpp+Dm3M0HWAeXlLg4K+5OvqhJR1fs+fG+D18MMBllFvxc5+ItStWS9eD1tonQYhbEi5haB6u5HWsHlZnO6IDt+QVdTcjU3dWNVLqFEaY7k9BHS7P8qs0H2VBo8/aA/YH29ViaCbHtOuN4VJffSUdQ3PREbARJ8/8OnbsJM/gVKfJ5/ioQxilx8E8rVOU1oXvyq7EmHMxBlb/WrkBawOXFy7+vbyhFAIf4lQazMP8QhpmB1epbGjDW+D51yeqqC0C8GGeEq12dsCX3sHZM7Ej+9oNZtQsemOM5lfddHRgUgSzrKBscZ7lQHJ9EN89l9hMBn87Ng9mfWpfSo5IFMsm/5Rw==','system','2016-04-13 18:46:39','system','2024-04-22 14:01:19'),('af5bcc40-8620-44b8-95a5-5bb4e5a60ce2','7ad62dc6-56e4-57bb-218f-349ed1097ad9','entrustrootcaec1','entrustrootcaec1','1',NULL,0,'E',NULL,'Entrust Root Certification Authority - EC1','Entrust Root Certification Authority - EC1','2037-12-18 15:55:36','20:D8:06:40:DF:9B:25:F5:12:25:3A:11:EA:F7:59:8A:EB:14:B5:47','B6:7E:1D:F0:58:C5:49:6C:24:3B:3D:ED:98:18:ED:BC',_binary '*1:qT8pFifMSNPTJxjS4BR5b/WuwuRHcZCWssgAu1CSIZW45GgRiBl14+VVncCWBApVzhx0TEXldKeuekITaMHlKpWF7xQkD/sw3Tz31yLUoDhWyIM62HgOgy9BYMtFKZHpiC8hvhIHGkExhpgm4+Q0phKrbDHlJhtjrKs0/25dwqvVOHHBnLzMhKIyD55FF+zMs30b/JHMxasrdbBCEPwFdS+mDSd9gX9BFWAgpPbeFea0ItzPJxBx2akm4XiHRa2x94wGVSUXI9V1aZYrK9tK2MMyRL3Xfd1lzIgqP+RwCDCpcB+OckgjqqJXP13xcsD9lvta2h+97L/ePo3Fb6PqEAs/5ZCfMshIiwv29Hd9jR0u4MU0tg3Bs+N2Ivwss/av7p0cMMSenAOj7MYG2KvBAV41KYfez9DE1AF0PH7x3D4j5K9WZ9pBxuWewBZKusyFNdZ4PmdwMXw671xZ35s3JZi6qZLM82ZqPEibtKLPb9m6xR5ary6bZWwNzqZzubxfbMUkyvxoDHN82r3yeVMG0B+LyXLTFMXSe8pyAP5D36NfHHQ0LQ6dGpk1cY56FFbso1p67BkSuzWGy94q2JWbPRbyFY85/ZXNpdE3ZbAnBpRx/9kfejQK/zijORxx4JZbxCHGilIiLn0T5ewgiIJzPFtrSdJYloa0K0/8quYDA7u1b9PIV17XWvp6ffbab83snVISM/USXgy3QhvNTb8xUbgj17XrEO8y6evmvmfzufKXfEj7mZrrKdAK7KyLwYQszISsCKyZAteDehwxnHjOzo5dWwJ5AIWelJPbxljxf+LHlg8+BF73rMotC4aojGWyIn+aGQRTGcq7VuOZqvwSwb1JdIpmvz5hn3AhzW5jvZbrSDw2iIEdwaC9FD0LCT3CMcfuPvLnia1iKO1aTze5G4jVXuLkS1wTk4+G5glfB9eXtF7+y1/MbJKm63QzQTdcwMxDSgIuWmW5Rdgw/HwVEKyE/dwsveXiatx6OPLes/9nBx1pb+ZUBpaJ6Od+HK2k','system','2016-04-13 18:46:36','system','2024-04-22 14:01:19'),('b1eebf58-310e-495c-b4ed-0baca147f11a','7ad62dc6-56e4-57bb-218f-349ed1097ad9','ttelesecglobalrootclass2ca','ttelesecglobalrootclass2ca','1',NULL,2048,'R',NULL,'T-TeleSec GlobalRoot Class 2','T-TeleSec GlobalRoot Class 2','2033-10-01 23:59:59','59:0D:2D:7D:88:4F:40:2E:61:7E:A5:62:32:17:65:CF:17:D8:94:E9','2B:9B:9E:E4:7B:6C:1F:00:72:1A:CC:C1:77:79:DF:6A',_binary '*1:nTLotPrORleilaZkKLfQqRhp6Mwge9u2KompFPNjQRBpO99wng+tNmQEKAy5tcRavDW6VbMtP5/MW8MfVHxlW+aMjz6yKt67kyGi4XbbtnlK/9IRx0AgBl3U+Gj0B/sNuwyCce2pdqID2Vcp/rOtoP9+034kdzmZTGfohFZnIF0mcjUW95ulv+Gn2TxTnHWIWBOLNsd0y0HEP4Iv6OZrdxPGnW8X1YiXF49P4IkBQ6pJqeVHg12CJZmJl+1RBP1+CDYziqvwQE7J4e/vqiHkhq5Xf6AEWWZfYUy2H+2UM0vSnsWZ8XDO8vBr78z7L05JEoxA+kF/KmLPLH2YfHf5c+cqCFPrTDER68ZpYzrBEtPNZ87zeqUPRCloM03BVqWkVodDSIK+nmAZ5Xs5RHwgAPTKB35GqnDm4nY9KMEjUebq760LH74aFQx3k0QKHEbi52/LZYB9jE0FSadgqx/y9Hk2DMmbjgBnlv9Z9EKWoi0u1iw7nFu5PQ32xA1N2k4sWpOZvKYZ8mgBaeCgQF0H8gzzDI9LZKscX2NvQYHHe2R925l49HR69vAXZPNhGharUtXTXslEBzfR4vHVmmYnXa9m4yKaQGsIp8X2Sdxduq/helSvAkZggJWrjbpfEH0emuukCaXex/wc4bxTHs+LLO9Q1QJpXYC+Uu5Nnvg77XJ2mVNtyi1607NcvGoNLNv3ygh2SCF4apP5FpewB8RXxyQB86d7iifur347a6oOSQsDskDKpAxU4W1+ZIRpNn/i9FFqWNjC7vJXkM8lYhH5o2uD9u8aBTQWGnBNV0tOpMh2hWdtjTN7IVZQdoiFmZfeN/IW30j9gr6GSFM1JG/i65lGXMo11Hp+Ucb4JrfocTwDlzW7BF8TTGfjF84GUTn1TJFfmZk9NPBTM3clRceShMXZY9StOfetq2WJwqEcuu3BnwKI5gjZsLKp1lYydpKT/C4fBu3w4+xZGnlycLQyvCmT5NPm7PGEXHvRTNl9Gjx9mmrYOx/AM1/UP3JotO1FtMIKnVbVP6Sh35wng5ekxEnfCe9IHZTXKf974VrRpLSoCPAuWSWi7NLeBdTA7fJVOw3M67ieLmbOTHlgGeYpwtGHDgTSAk/18fpTj74551F8qQXq5mh5dWZP94ks0N4e7SnZLK39paRhETl8zLvYcSGJ2Wdb4qkOimDxse2lHH0QBjRqWNt223ZgnXrAqrJ39RszP5l+c7oQVkP94T4fZ+YgrljnOMp8faTRgbdMzzYQQ+188GgEkqf0hzS7lPKCkrH8XuCKf2TzjI/QlxUlPw==','system','2016-04-13 18:46:35','system','2024-04-22 14:01:19'),('b465eebc-45ae-496d-bc3c-c7c56a14d383','7ad62dc6-56e4-57bb-218f-349ed1097ad9','swisssigngoldg2ca','swisssigngoldg2ca','1',NULL,4096,'R',NULL,'SwissSign Gold CA - G2','SwissSign Gold CA - G2','2036-10-25 08:30:35','D8:C5:38:8A:B7:30:1B:1B:6E:D4:7A:E6:45:25:3A:6F:9F:1A:27:61','24:77:D9:A8:91:D1:3B:FA:88:2D:C2:FF:F8:CD:33:93',_binary '*1:XeBFWGf4/1fYOBGuOng9WemvnlqBceFvOf7/EWPqX2gPsozIjhVgOyjE0pxnJ0lQs0DpCRAoBREBI9NQN8w4VVGdDo/btGGbA4Y4gBOrzC2jO27H7wtBFEPmsOROk64Goy39whCjpIXon71o/o2xAr2Bmdzhj/Ze2ehb+5aNJtayPVDY+nqt51HXy3ZJ9ekFJDFovUAFLF/91UTwWfygHcocTpBcM8mFeVe5I4pZrSNrDnp3BmQCl08GDfDio5WayQ4U4uZoj5I5CrySEaLtSLWsrPAsOtAOl96WL0DDk09tzpr17uB48TRI0Pk3Ao5As2uIdLTVKH4sO7bMqS3d64fPkZiV03Z0EapBM2szUshy0RjiSQ0+IFWg9I3ECOwguRyFDnRvGReTX5zW/QNReKjQpTJv+qpU+Dml0HcE7/5WOHG2WJe4LbHjj1licFoaOLAdfnQSS1P1dO46wvgxtV4MihZeY42S9Rn+1Q7+BjT9q9bKrAT8ecRMThUviaiwQbjIA+90Dn91DGGZ81sVLgMD2Cc3YfZCxMPT26xrMfy0pwFzxyQhn1/6Yc2tAYcky5pfNpzWYeugogKriVC1DBXZ4MyUCiylvOnsFHVCZrY+LykdDp76B1solutT7C8Ma5TUv30ZKNk0rloMpL5g7w6rHfEKXs4jGzpmYtKfASwWCUy6GjEAz/QYYwQR3dSWC0jEMYHz3H6KxgVNTuk43aYeN0Z4otd8o41m7NHuJkysRjOpt4v723d50eeLaDPR3+/ckRqzSB+WEMRFtTu7UT7HsdwSNJ+iM2+chph3hf2LIlm7FYvgUnoJFQrE5O7c9XGYArwJq+aSGZrixA6KqNvX/+eKVbfU/cyvYwBr1w6X5he0SMh1Z0RZ4WHBgAOiyUxOiSQ2R0E21fLdabz/HlP/tox3Isgag5pfbzv1Ypc6LKARykE6OpoJLkJG4ewcNsgL5QGA7Syd+9vLYBatw78XImygQh4hxc3W2oMOuYO2HLTiitxl9asrHqDo3+x3bVJhSH2eFJqXowm6t6vvB6CRmkdZUYXFjlrzthM42WA/czMB+s+spF/5WVIF2eCDUumlmdwfBnZ1Exa/RfU7R938QuwG6BWyNzg8qqZ6hNAFFw1BbwlSf9zDzHVKn6KkLZivYT3+ep969h1kotXO2zkvWJ2O6AZo5Rx00MkVI42yHf58RQBhKKipPIiTFfjXicI6yDQfAXdrQCfY9/l1qkU9iWPjAVgdxS2CkCEBjnGlcks9E63vO1mZsH4FZhWlhhzJhUcYBdLJeGYXPQx72uI8UmkKxXsTv3gOlb2aYT497LUKh4sKk8V/6d9WM2RXGTcMNinclYHZYMoMteTeDbTDY9acfclDU6wL8QIpGC+Z0TDEFEW8eNf4CdViA/ptyxRbYaiBgJCG9sRHp1B7+UmXsFCUa3t5x8G6bjShQRe9fLDmPfn5hW847gKMa3lChFwCDT05H3H+guCE23RwX0ZwOKHSViLmRWNiHMVItYdTqbktJ1TgIBgxFJV2QhMCQmrC+QIpGRSFfB9YfhdBeGgWOczDa4b1iX/i2/CQGtT/ed1OwxK24tcL9RPb9gNqehaZSwCwutO2yOV9/8ag0hN7DjxQZLOSNijA9+6U6pVacdJxzu+NlOsDUy2WqG4/+PZDdgabjFCg75k+bcIAqXmNvW0SZPns1T577gyWwZHH8BFHOIYbbeM1li0KVTiN4SFx6fhTq4WdASxy1PBZT1p2Frn6tN0KUz9SajRt+292/vhkURyFKTbTwroUFcZGCUFGNLrsgJAe8ScI2KJhsE4nDdunMl4yW8EuqftcNKTilAm26y+kdHZqa82/yoOF0PcqzfmxhLwOE2qMOWuzFjBIeeIxfTcoNIaDgtWrGbuC/763ABPIZ1w3EN9b4BxPx050EdA+aonn3cuHJ1a+uybSvpIw8XmxabOk1vAXMjI=','system','2016-04-13 18:46:45','system','2024-04-22 14:01:19'),('b4d8483f-75aa-462f-a796-36035e4675d0','7ad62dc6-56e4-57bb-218f-349ed1097ad9','ttelesecglobalrootclass3ca','ttelesecglobalrootclass3ca','1',NULL,2048,'R',NULL,'T-TeleSec GlobalRoot Class 3','T-TeleSec GlobalRoot Class 3','2033-10-01 23:59:59','55:A6:72:3E:CB:F2:EC:CD:C3:23:74:70:19:9D:2A:BE:11:E3:81:D1','CA:FB:40:A8:4E:39:92:8A:1D:FE:8E:2F:C4:27:EA:EF',_binary '*1:nTLotPrORleilaZkKLfQqRhp6Mwge9u2KompFPNjQRBpO99wng+tNmQEKAy5tcRavDW6VbMtP5/MW8MfVHxlW+aMjz6yKt67kyGi4XbbtnlK/9IRx0AgBl3U+Gj0B/sNuwyCce2pdqID2Vcp/rOtoP9+034kdzmZTGfohFZnIF0mcjUW95ulv+Gn2TxTnHWIWBOLNsd0y0HEP4Iv6OZrdyAGaNBwZIO/FnzM6OQC1rfbg9lBaeSE07NKMkRuaDraXyB/6NhQaFvAeNT50xGyki1yx+szmAuF/0LhYhQdytslYecty4d9GrtRK/MDV6fhTpMa+YAZwDZZ1Xr02PSWVpwetbIT7Sum8FvrC2V5/wRBFhMTN64erm4VZyDByFlwv3t/uoe1Mf5wwE5GqgNMtz2D2uXxyHJGWXRjUadSPVLxfVicYGbNG3qo6AqHEhwMJfsBHr/rln3YPy/wBPO5zZU5QRane+025ER/HzeSCPo07ds86Z3LunWHJXXI1ybBjbpp0BmISi5hZU4l0IpKuqkENbfmocJQJ7ungbTvFPgVWniA1pKpYHR4KL4Fk60GQwpfsJXl4zcCwxNHDHMrgXBbnlZPliI7CSmqjcOHBYitIG1iVK8sg2R3uXRLP90MRkOdTu8sGsbkLGz7Yh2WiTUu3L+ZV5jd2ZmPFkxrYdphLxdjopdRpIshKRwI8lpgjO5SrfzO3Ry4wMpxu2DD5CVOcO2HNVhGiW4n0tsaM76lZYOBMy15x0akzZAFpomjnppVmSSrNqQw2w43yUd3OYPMo42ZIWAGqNSiBmIbNIN+3qF9/pElCmvJDE/ZqMheKcMMvc7u7W/ltjpzmRXsyVq265pneAmwJoHSEEtDDXghE3VHxg0wMwpsw4qG7oFlg1+w5LHeHimcjbS0CWBH5wSPHWlXOiKB5OAukwVySJZXqIk7HPMkk7gN7NkVw/9Xwymgo1gcYmQWt9Hm1r8sWKICsYeYLcNWTg04lAuiM+hfpAe6/YoKW8omtbhqD09OvHydK3UuVZgqhC9gJ13b86VtmDwjbtbfaeAsXkK8arA6NislwLAyBstriFObkqLYe5fBGNW7QwseNXcUXnT7GfQ2cY7tf81hw0XMAhcwwoQYo5oRem27LMo0wViknQwDX7s3akvwN83lhfjZDoALnGzqnnQO1X+ThASkbhCVpHaaEgQfxSGQSEkC6Qh9fEuPQBkFgV1H54FlY33HNzUqGucZJEIBK84hgvcTHmKNhiYCuO/qivJ1ATuAVRrryTWzP4OCWMjLRTORtB34DE4EZA==','system','2016-04-13 18:46:34','system','2024-04-22 14:01:19'),('b5de81b4-118a-4d35-9fdf-bf91db953907','7ad62dc6-56e4-57bb-218f-349ed1097ad9','verisignclass3ca','verisignclass3ca','1',NULL,1024,'R',NULL,'Class 3 Public Primary Certification Authority','Class 3 Public Primary Certification Authority','2028-08-02 23:59:59','A1:DB:63:93:91:6F:17:E4:18:55:09:40:04:15:C7:02:40:B0:AE:6B','EF:5A:F1:33:EF:F1:CD:BB:51:02:EE:12:14:4B:96:C4',_binary '*1:0+w581cAARiWYvPUTPY9zAc8GAZWFY1gRYJqi5xOUeWjhCfAEQiJOu7jna9+xUEks2ycp6eTpI1NGVxRgwAjPjHr8qZWTkUdDACi9rPuyqWxvJlCqq/3EmIKUXzKuCmqlEeJELwG+QsmsGZq/C/Fr3N0swXUT4yHn/pr01Cae1ibdGaJs9FGiV8DMevtTQBEGtvaWK2mALP+q4KpOCzydnMf0ndmYKqSQ1AsgfQUm4rXSOhx4XCpvDcqL6P1AKF6ww/qEc3KHGYbIwUcEKDp+SpGWhac6ugAfAPBQtNn7GelIguigTKEwuKDs7eEmq1SAGoDTplhwbYNwCsd4uK+5c89FEYbaEvTrY7DgdkIgWla+v6P6e2yvKUyexwBZbf1wdwx9UkpsDWZRyK3q5v8BT+o2FEi7zzP9t38/gnaO3iptsU2rOKG+EOl0917lT2BX4/aICikRsoArcvMj8Db2I1Xy0y1gk9fMECUdTQqAdcggGGThMUgfznyWl6EfF/D89SGbLa7Lx9prGrCbeuofJJqhJZxhK39wl2BPE9sKF77bg++GdXbndZKbBdR19XXaWselQkEFWeiUEV0oablCO112Rsma0rgvfMJF9iDtw+cm5YcgGiCzpNSk8+uSAkFZmqMLPMT8bhY0JvcTCHW4ZT4zVSaB8lQHpEudkgau1N1XJctc0k9koehdS2n3bg0K6xF4+pkkhMAE4Z9F0bHgXdgib+NiWpSaiDPMIbfZd+AdaGR47TY2gRCwInF/wGNWFZuW5ZxYbqMefOjil8K9Q==','system','2016-04-13 18:46:30','system','2024-04-22 14:01:19'),('bbf9bfac-9113-423c-9ed1-074ae75c67c9','7ad62dc6-56e4-57bb-218f-349ed1097ad9','entrust2048ca','entrust2048ca','1',NULL,2048,'R',NULL,'Entrust.net Certification Authority (2048)','Entrust.net Certification Authority (2048)','2029-07-24 14:15:12','50:30:06:09:1D:97:D4:F5:AE:39:F7:CB:E7:92:7D:7D:65:2D:34:31','EE:29:31:BC:32:7E:9A:E6:E8:B5:F7:51:B4:34:71:90',_binary '*1:Ehpm9otyveBiqhPRkVLnLDfTC4I+KsH5A9gTjVMlqig2ie5UjhbejWip6tLLojvGYgo03dmFdbTvmRDuIgIAURHMjC4f1+L/ZkC+Oliue8k1HRaETW1/33AV4iKdGkp+7/W2sdRalgFIlKOmJ5SYwBHxqtgD1LGWIc9L9uc5lCmWVWke/hpgzoM04birbDgMscnjQ4QxTW04B2MlGkmwoh8pOa+eqVjK3rTZ3Yqg8IABvsEC/3DT7zG/mexiGWzWWz3eZkw+T/k2T/EhN3wr2BaJWXXvRErpvZtctGa5xmcMXjoFKf8wXCq4ON4asQWIQPb2O6hbL1giADmbpAEEfO89EuJGvOSlN5NnKPXCqrIP8JD4R0X9bXjrnRAGK7WahUCWZQAVi7AD6ONJwMAgFYo2WKAiYfcUGPirjKO2mXFaqY5XntxBDJlneOdcubptJf0fesKQ+1Qh5ZU7TzRImynpae6npYgtcdFFq6e5NBL6xMo9u+16a1iQlxLB6iVkLj3NsrDHWRv8qQQkkkXLN0SagTS98nE7Q0hZJyB+BpgJq82t3xDiWHi8Q0ESmeLRo/YpY6XBrXdoPstYJG5LuZoBHnyAw1ppsvkNgwjRNwkNTU0a2Fgkdj2Dfg/gpGGrRa+u4ZufJDud8JnlsW96AqO7M92eiyX/6LxarrOEqKGVoasdaSD1lYVqY0GZbaM2bb+cxIQjHQfwW0xf2kWCuwZsiyaJIjurGfCMOHl5WsXvcpcIjgYfxewIOyzbz0ED7nDGvwgZH+UJLuoszA8O02l6BYudB9rjhh0trFdj7VVs/E5LGNCXwCgVVgm9InWbw5Lzu115vkxrAMENCDHKsF8emsMc/AHnVY30cpUYlKiwZWaztHcmRaizh7y6nmf/golGPHnJUUb9FNTEy1HGJyMxOcCzlRxF4Ci9By8WqHrBige/f+ErnUshNP6jp4H1y/fKMZNvhCbWG0ZBuxbGyC36XLgzIlJyIWuOHCDEAjYd9+yMEavSsQno2B1dgUdlVz6nND87i//hWoef2jLB4Z080AMs3mRaIHZSF/pj0vrXS3sWjPB0THaoO3CGv7Ry9ElTfBXzds0vR0tk/mMBmXYI3q1BrldmR23G+6k8SE5QSksWcMRdFTGj+vLt585d3KUNxz5SiOS4ebyOLeVgUJh44RDNHvLiw0HiOSahoxwQ6q8xTX/8uestXeBqK7J2mjpBIXFITcc5JX4aIX/EJ1GMA8Eah0KtidTcBzO3wdq/3kgkF8wEGsdBcBVseYZMHJ6Gj6n8HxU5cmGOv4RJE5onL9tutKHqUG9tuZT4l+VwmXqI8UJkr9DQoYe5M4gpaPo3+HAZe3y+Uw/YolHeLrZ5uYqjnW44fIj2y6XISmtwmCR2UUAoLqR5UvGtZ3ZO3IWW53wEbGgX2t1kBpLjHA==','system','2016-04-13 18:46:45','system','2024-04-22 14:01:19'),('bd606ccd-bc58-47c9-8121-65e7f10aba10','7ad62dc6-56e4-57bb-218f-349ed1097ad9','addtrustexternalca','addtrustexternalca','1',NULL,2048,'R',NULL,'AddTrust External CA Root','AddTrust External CA Root','2020-05-30 10:48:38','02:FA:F3:E2:91:43:54:68:60:78:57:69:4D:F5:E4:5B:68:85:18:68','1D:35:54:04:85:78:B0:3F:42:42:4D:BF:20:73:0A:3F',_binary '*1:xV8NmhYQP+sAiZS/3fU7fG29LSX9LMOsqv64loHgw0gGz1H0PaRTGDOcfr/0aCkzjFmdCEdsfWGBwqwFoh63hcMi5uqrRmThcRt5iF9i3HTx989PdyIuNkxcGQnF1M3sd1kx0O+TInZ6MWt/XjjAnLE4cb5I1rmwqGDHfNEzAvIQJ2JEN5twEfxnSnfBwmoWKhgOqq5v6s7q4GfDoFZYAPMRgEBP1siht8OU46ecSd0R0T+hRTki91allg5awFaqMf/I8RsQFSv8Q/kx8dGZM4lc3gUKJy08/iuVOLLPDDZyL1MugeBZGVHx/UgKo3Yip0s9NNQoIj50iqS/TalkqVu0xKP/3aIm3JZvHBOCPukcS82iSwFbF3OOtGHkvht8g7rEmjRduwnIFY0zozXQVAXvyPnOz25ZgLcn4MgV7mbm2lDHzU4ZoK8aWyYe+4LSHoz/4raZoxVhKb7W1RrynB26tZTGF5gzBL/DJBBSAG1or+CJwQO3s2mvANLk064MSOqqQwLoy9zGHhR5i7l/ANsdOV6q+2SbZi8P3ZmshormN8cLUdevOTRYeMsOv5OAvfr2/Hl3BxSpGsk2VSkI7oYvnCySyzv0iynfsPeezE27TtGW60h17AxO1O/eMKxFS2K1ymo9bix1bcdDvJTrR2Fgmi+PbTEQMB28fD8WMA8xstKy+nFFQdq5dtDd50uiLCIb2+fOrB1UPkVbTo8Ps4S8T4rVYxaSkrbWerJyv2fnuTwtvmnD4CH3WfoYxVjM3FqooVSKa+kDcxw39c4VT6w2y7UAcfgowmkb04b/YgERUysmr2JSMb8aiANjoshkik8uV20ZoY2pY3jzsohVQy+7zhh61AleQXF3HlcUyx1/ybaXAwZKEZ2alJe3lXvwAQ9/eI47HNe+inQHLt7fcpnKQbG31XrfkGEByZkHj5vlPMErmOORSQBdP/4gWGmJAgWPE/WQwZcgbw7zT1oQe/Ex/uwAEnic8oRwM88vtFh6ou7bLkkUgp9uMw/2BB6ymyKu66Luf1379DjVFGE598Y+9OzpKGDxDxv8bYRVwcR5kMQcTtHxE8SXENFQI6L1Mut+Nz/VngC2VaCs5Jv0nw3t5dyuG4Xz9m7Lwcw3rBUKCyweTLp55sXeg1/UuuwAZyklP/224SBdicupRIjxO67OuacXisYQiA8vYslenhnjCit2fmQNWwLAZb9UWy60+jItAeWIiz5oI5WLfdMT0SN1/SlhfloFLlyoSMsLMZt14Kx2lA+zWBVHCj9Y1g7xZBr/0kbED1+SgN7om2tUDRHFP6y/pxyMYQVPqi8zDH1deJ7DGaUYCOH5ZtI9j9NaZoxKKUnUzoju+7oCzgeffrBSCwPMGn8EijHt/8qr+PKGC/tXkNZI/nYIFZPp6TMTDhwgZrqq2EUwTBrip98XoTn+O2mNrgPHfQbXaiKz2as=','system','2016-04-13 18:46:43','system','2024-04-22 14:01:19'),('bf32a020-a6bc-4865-ab4b-d3fad6b48045','7ad62dc6-56e4-57bb-218f-349ed1097ad9','verisignclass1g3ca','verisignclass1g3ca','1',NULL,2048,'R',NULL,'VeriSign Class 1 Public Primary Certification Authority - G3','VeriSign Class 1 Public Primary Certification Authority - G3','2036-07-16 23:59:59','20:42:85:DC:F7:EB:76:41:95:57:8E:13:6B:D4:B7:D1:E9:8E:46:A5','B1:47:BC:18:57:D1:18:A0:78:2D:EC:71:E8:2A:95:73',_binary '*1:V3IfKUQ9ozJiD2EpP6nRwmy+zBO4iNQl0kc8lBRK9v0egtGVsUWrgfZxIPLlZ5S7b2u3uS2x3u4vg1haZi/35EKFiX3Nj2Y7Oc750UlBOBRhKBAK3BoXvNJdLAF5XNwJ0wZ3yuh6jmUec7MSIFdUPJuWiuyrP9BCM+ooZFL8aofg1DbH9lPX5Lz5nJLUbTzuk2val2e2tQTQf15G4+dq8ID3dVeRysOX8n8MEEJ2HDmQYVu6wcn0QC4igex+O2t67MFsLyOVigB7YjdmDHr4ip00I7DMuDK4Zkg0altlidRQjMKjSH1/WWkfypzOPm8YojtVQ/gxFp9tjSMao18GnZifJzq285Ag/fay92yitLmuG1qcTw2kJVK616PtRU/mqbriFPFQ6gl1UJjM14xrT7Zk+zrqeOlfkGaIQfPHeAXBZiYgiKEb5PSgkZ9YR2EUJYRrW3jieSbRtIxhxb5yaW5Nt8qHbalFTysf72a0UjJ0+xHf2B8iNp7PF7hDXS/WFYe2R06VSUX7nwnKZbb1p5n4mz0LHsJmwJlkkqLVtWxkDr8fmQbQW0Zo1iRLvmFmX2a59yN0aXT+3ndQ1llmz/cvnCNG5gJmexIEKNk2d/aJ/G3VWP/6WRgkde2VKX19eGLJ4n7gIeHs1v4aIBjIc/zdffD1RA6p75trzwSi2VXtIAOvW2OgXxADH4kvMsllCK9SWGmU7duIH2ZSeRTZVSM5ETF7RLkJmRW/nSVrvn6ROBqKtDZa7TXiGwoRbCCjM+m+GBKnkNg//Awv8EJJi7VL49bmwhUdFPwPFfsJ5MzmM2L7ks0oM4AYr7Of6dMq3ZIQQQOTweDmC+CAczF6Q39LWDAfSplPescN5owJAoisuKrzQn3Rga/nWXtzXxFnihzeMnnHOWXK+xwLdBn0hppytbJ+SkMzPn6iYf6mP5RhiSGxenS0oAyV6E9JFB9yOboVJyXOVYjRTK6znMySM3nti2MhFkIOGmFN/j00wFiTw0K4H0wQsK1J1L1jwxYWuyiqt2TEAfqy+ACIuPhEiTmF/vP3uDZjv4sgjFxSNFmYyF+RY/+f1JmXv668caxuYOsBGGQ31bJlb+MaT+RthW7BOT5NXcRJgbmFLKWSwWrlita1hkadfKg7wsyY2eFER7I8RhvyEshiFuhospW1RaDoHp9A0ECrOrJNJSv+9QqsvVtTJ9jO7GC+00EUO8hrd+RaA6EaLSjNYuYUTjtwAiq2CHAnnAU7NRt0ph+6qc+zGlTxmKHxtdS6DPJGoDRdIGqSMyDdANsRDNzYsZaCaAQDc1VdqsirUtEQMYbsHRGxIc5yQStC8iVej+9e1p5Ouxtl35ny1JMBip0GKBDWSNte4gosDbhoFuqR3Y3zGnZL3EsdSHgO/IUhm42G5NVL','system','2016-04-13 18:46:48','system','2024-04-22 14:01:19'),('c6899521-c911-41de-9fd2-5274635dcf5b','7ad62dc6-56e4-57bb-218f-349ed1097ad9','goanywhere-sample','goanywhere-sample','2',NULL,2048,'R','*1:CMsDAQObBxG7WIzD8t29nibat1iW/ZQEZTod9pYT9Hvz2Q5rHqoC0+iQo8FWITR4RYDHUR7epxUzA+Y13qZYiw==','www.sample.com','www.sample.com','2041-01-31 19:45:10','39:A8:C5:01:7F:FD:3A:ED:01:ED:EE:3C:AB:0A:6B:01:6C:C1:4E:4D','3D:FE:F2:6B:7F:BD:5A:DC:3C:77:B1:D8:AE:75:A5:20:00:14:00:4E:40:20:72:2F:61:74:64:12:CB:92:F1:49:30:24:8F:1D:C9:F5:3F:2A:DF:81:43:71:8F:31:E2:5E:13:3E:D0:4F:E7:4B:25:05:2B:36:AE:BF:86:F9:D6:FE',_binary '*1:/earqYuwzdUWYraxzDaAZ9c/GLFrREGdHBtPoOCvKkd3FGtD+NjjGnD3CixlJPNU6hWg/CRtwsJO5pGJ00W8aqfgFuTAAlh8Qqv/qePpWkNlfokcGs7d59/0KRuzVzyV8Z6n2myJy8kd6M0UBzXEzSYra1OoUXhwp5AG9qhCIx9oVxhBiM2NTqtFaUE5/BPub5NLkhpeq6XC58lX8Dhb2Gg5gcOleg4Lda05ZuatzbyiZLGwXDCfFvxXud4OkuPue3P1+8QG8cjd0JpvbZsqC3IhSc152BCmY7bFKxQMsr5g3Cg/IaQIUpNIaAK1d0kjSnJzLUz1Xqg4iR+YRhUUqVSOk6LmfxFs9hAjf6vy7Q8UBz3xUlILed5Fjvot+rqKw7g9Ox9m6wAITHFOgEQUMxHg4MW4OkGBEtyiywTEv3AyPf7CASYgtajwqkDBhJbZcBo+4BSixHL03XGCEGrRJP5EiTrxDTmu+xkismre/D9mabTI0ob5NklsvCfu2JkRZUZ0GRd6Bu6ILdYSo8IdavKITxDpb0+sKIi22BkvGhVuYaGPvN8ddhuuvLeuK8WNDUZUlpa3kFRa/UtHFZmRHb0sx84tO6LY2wCGlQLIS+/GuvXyYxZ6gYsWIDj8xDLXcB1Cfd3XIGvVOes4U3TRqIj5Iy6p25QDAKE7omJQSn51hPEVLqDjR+HHmbWQEge3mpXNJO5DIAIv5cLSeDThqHh4PAzCQT7pV18xeU2ko9QEYw8yon9VudPwzH5NMWPNsMgFVinWmYGZgcdjVCvvdpfHXV3pV8XuPAwGd7k43t/vRoBEASUXLWWQTDhJ5/vqQSRPjmLvVmVN4iVyhiHRqFuYtMqVLMKKy3D1serlfaW6xrSvl1HtWdrumOhAF9bVVHBn00cFy5m0NzCtXnrFMRzN/J5V0fwM4XvPDPhiomhXfSul4B7nEsjVbnmFBFYkdm0taplJieXz8cnJ3adWIX6zt2BP3ufQiFOOV7tnwB3sJh+ACISWugUmxedhFJPgD0JJW4VzueB02+aa8im350SBWgBCmiMzKg6BhmWxZUg0/t+ZhHJS6kfLNd30beTt53tZGEPVUYidlcHT1loayzL8sA6rFQl401pRBlUcA3jbntwDF3uOP4Bmui6LaeaSmHyKrcyGxd/wixNiCTuNRdEQsqWsRxXvp9TmeTk6BeIpQLic7XscGzXG5kbjgisG/9LQpWuo1qaw2E6KENA2zIPI+Z1wXhPJFJlYTMtZWgJeXyWSkC+mTK5ehYEmu2X2l94hyI+LhT+sBAjVH88RXhOrEB+w23xrh3/7BhSe3+8YUXsSG1U/+OpBaWRIhe9cOjudzOSICexl/rJ9d7FOISVhZ4KdiKMDLLJOK/iIoTmaWmeFDDSkTZUAkQZXI8PD6iDg2WMxdoOmY/zCJhx9gXgxv14NQawXKQoYoSn5EJEDdrjhLhC0VxHhEVfwVOfuI9+cqmc7Q9oiiD9crQrcIndQQLeRyGrRaDpIu5Q601LdBLUHGOR2egtpX9y6f397snGEGXo69ZEJfrqapF0HHJB+kkeXv562Tly+101lhSKqbzGM5jEgS1z2oiUDQm9hMBqXgI+Sd8E+DHNxuIedGdj+YkDvv8aBaW1U72qLrEftik7I8iKJinRpNnReaYH/bOd2pxTTZ2/m3RFQ9YJSOgcNDMuCF4rLmML0+/2KREv0zwtdp/FgIZOMma9fO65ZZn639LuTizywjK6k5AeDMcYdcqst82Czzv43172moZoSTqIiRXtvfJFkE5VbfzXrq7pxiC8GrhVfQl4Qoj8HHZqqoEiaGL6C8/Qu/0Xx+1AMmt7uP8cHB1urXbfUmXPCO4A6QeYmqzztz6JDmra5IscxQ5/kO1hoAcyQIgezmgTRaB+ZyT9n5YZ2I6KUAe2kR7GM3V+zV2tF5h0Uc/ATUMoB61Hs1acLXKYPBpSJChu9CY6CprN1xUMrXNSWLWBQpsAPv+YWVq6DYDySs/4D6m/K9h3GPVtAOPcNI9ZqtFRflIde12vN1ANLeE0JVG6HlSzo3w5ojswq2aE5HA+un2TJS6XGfx19I9yE8UPMQ0xq8eUk5aRvOBw8hP5SnqkadiW9l710boNCuUfHaXAcoTgtv+KMBuc/SJIOjTCcSN0RQTJ3Np59OMzWG9CmdI5mfJ48V0cGYa/+IN9nM9I/3WopeQW4pIQOvp5QpRNpUlzRZmg7FyXAleS7r8yY3mP9EmXFKzUHyaCp1G+QE6/STZRkiJNQ/AzfexbHihPUMEg32N5IDCD/QqD/x784H/NR524+uRQXYMdKja7juDmA7haolZYdofA7JM0YejYhorh/warnbRIKxqaVi1y02RFDJ7XtqCu233gNNLndkdNj8AquwSIXGvxP9RqzFez9+EkIdFyXas9qXOpvLn7m3mZmSN829v5lkqzchV3Yv6Ki/NWNReyeJn8ecWMM027E3eBo2YA0rnJykhAwIk73bxizvl481Y2vWrRQtTQq7MMkWem+QkyosY2uahGOqwXyeQNoM3t6Qy3bzE5MDgm80Umj0OZDOIiaudJ+/T9xdIFSiUKDVmzppHmAxGToyLtVBM8LcsCAytKs29H2P+Kjpm6WLmkakfxYOYSFQpNO93lndKF9V3B9+lc2wBkoxgXG4YvzTvXJctxbFNuYNKjk8eyTr6R+taoK7PCxKU8X738eyMiB/4MYvjZDM2eg0gnv9rkTJzPi5acdUqeGpuN2ffxfgfUs8kFavh3CidH8G8bjNIWRSge560p00k2cLVCP6Ij2WaDZ+epF6NYQb9AKhYMnFDL5th1xYniMfN4+1bMStbmTP9n5Qo5fBNIdQqbw+WGvxvnsuC1ghnm4dX2H2MbvlqwxSrFAmSWAQ72rMgQuDe2sVdotnhBOoevAVlSpWkc6oxYoR7rXQhHCa0jDR1iaB4HCsLEZ9JV8Z1VrhnUH7cWBvrymWP+CIniNZnQpJz6NcsN7+lvdwGL/WxSkGU12zV/iMuhl6VKArI4kC9J7d7MfMWIwZp8neSs/4D3trp4=','System','2024-06-10 19:45:11','System','2024-06-10 19:45:11'),('c6abdc19-ee4f-4421-953f-410c600b72a6','7ad62dc6-56e4-57bb-218f-349ed1097ad9','verisignclass2g3ca','verisignclass2g3ca','1',NULL,2048,'R',NULL,'VeriSign Class 2 Public Primary Certification Authority - G3','VeriSign Class 2 Public Primary Certification Authority - G3','2036-07-16 23:59:59','61:EF:43:D7:7F:CA:D4:61:51:BC:98:E0:C3:59:12:AF:9F:EB:63:11','F8:BE:C4:63:22:C9:A8:46:74:8B:B8:1D:1E:4A:2B:F6',_binary '*1:nv7meL5mFjCcHK4gUreuVoUfb7uwjD2OWttgtipzBDteJ/31r9rObPNcYIeUC12obXN8cv9oYgHbZse9jij5aoX1esUOC1XIJxVu4XkwQemq8ttoCgcYS4y8oFZkaxQ909ME/KK8qtxlmdDPeKQdav1HXqgLjfNFe5flQzwTfg6NP3ZNpCI9D8/hxi3Ide1dH8BiBa9vy29tAdaGDTL4PSnhPDbDG+DFMDyouUS+4Xb4FgI+mlHzfxMJqO2OdgMQ57Mjuf3TXsnwPJhryRgGFsdnH/tBO+wVhf42p4fhdJtWXQpH/j479R7f50b0yrJWbKMXssQ87l6IRD0lQE2QjEComylAXY3A+mJmrAU/LDCFVIeoUjw1Qtukc1pD8hIAyznX4U1UDe6uZdY6RY2xgEPxAbdjKOY0uSb2hKPKMpN9g3eoxKj3fxbsDMIWrp6N6jcV5285wiN7LRAFr8RVb7a+LO7u7+vAIXSQvAoVpUFjG3podiw65yPNVbcrUkr/yYFW6VF2GN3Ie8meXC+JuuZpBoeKute0mEIiXBTfLVr84R7yqK3O10JtMWDKJmTfQ37jTWTZHOyQsW+8UXYtx2PN3+2WC7E7gntwuAFyl7ooQPjG/dERPzFxUifsGn825R8r94B7EBEZXKXbX9OwqqmSv/KngI5IoUmeD4/Ml91bm5UW5rO5MIrbN5mh0X1851TPVVKdFSOjw0CV6cki2cmclfmy/2cmUgtUH17hPWg3Kywr2aDF/hoyWKv8oOYrP2PecU1CCEW4JfPAzGKY3OK7uvgzSYUv/MaITsqCHU1F+Yi/MoWoBgEaEhHHkOD7zH2/+d/1vnKJ+ivBb4FXALRwNsbgZBRsLufSwFzcJywMUYin3tn4as4QIFfV6sogVemc0WZiO9Axzsfkb/as3v89BjtyMDacu57jquhsmp7jeBzQhNne3s8n2MAcN1SiWTNiJzvU9Sv8yXZSxVzcA4yqQEaGZeXPRm5Z0sONv7dLHH2Xsyi0SY7PvFIlfimC8IJaZdAPXqfgeuoTVPF+mv2saJR5HL5Oz2cfqyA1OqV0d4jwYZ0dBxWF9vyYAKdHANgv6Z5fBjeB7TvZsjPIDVgnONUv3ZB1gNFyRiFyPZLyGoi2Cr9sG3y7ZC5DqNlPE2LSZuJ+buD0TP0TY9G6kR52UWPGFaGQCjeKgi/HnYuFH425frIwLFwdQmrG+tjXjFxBVxZ1TJVSIcTBkUj1TvTryHVrqMmd2WVIjbfETdLkolOppZEMlmzTT22uQuHNdvvZjY9n7/RGaUXG48dDCo/ZfWHCHs6ugyRsOVLrGUhlZ5P30oLOsuv/dhn8cf3LPKbpTYO1oYboxXEOKUdvnhQjQcSwscdMMUR2pDiv3a+bKt7SZa2fWBYRtZijrC3Y','system','2016-04-13 18:46:43','system','2024-04-22 14:01:19'),('c8877f9f-0acf-4c9c-8512-62f8dad3f2c5','7ad62dc6-56e4-57bb-218f-349ed1097ad9','identrustpublicca','identrustpublicca','1',NULL,4096,'R',NULL,'IdenTrust Public Sector Root CA 1','IdenTrust Public Sector Root CA 1','2034-01-16 17:53:32','BA:29:41:60:77:98:3F:F4:F3:EF:F2:31:05:3B:2E:EA:6D:4D:45:FD','37:06:A5:B0:FC:89:9D:BA:F4:6B:8C:1A:64:CD:D5:BA',_binary '*1:+mpF89PkduSo+sb7AcT6uvUQ4tY1d/zIakYdhZaikDABSeShO+ghrOebGE2n/8ujwAOnCUZdrmUeSsme12KLOOoQnTWPKWuxzg9hoBtD69BA+LD9WH3c+q5yLtsHwp0WZq4BeUDC+CeT72GPqrb0zRUimZg2k3pzgHVgjvvCLTvVDp7Kx3T6R2hdxJCiB2SnTzjmjhhRUqtoEmmcEWeAkwdT8RBxol4m/ovNg4KkPM4F/02Lqo0QGJ+s1sg/wpI31UwJz6wq0EriOAFuOE/HS/61JvCh7d7Rrt4oeBKLSndsqyS8vZDIlFKs49+HYNtE3UjZiRicsrngfz0cmK923kj27Ea7jIlkXC4ki37z7UX1IIMi6451KPpBN01/0md5Io8KaaLm1S4sxvkBw7P245D4FanyxwzFxOFMhvdL+0XZJWa9/dVue7sk6Up8Q+k6U+GRaf5jCrDo123HCyXK9I+L3OwuvR0QrPFDcJktydAJLEgXbgEKFhqyhiroyQf82rLSPrOYGyT4R5Gspj7fGwf/t4TIT2KmF+6syKES4xLlfGnE3JB8dRdLZULfqjFFPghkA1fSXQAuYqdJmW1VxtZ8u6pfOyv/K3IT+pbw5TrHTFFRBIi6AvirHLQZVZRMi31IpD8a/mZrAet7PrMFZn4AJdQMpXZK6ETfhwNpF5D/SYBEfsbgk+CU43DjSPPvIyd1gZ5+jgvdaij1S6W4awIcHf7j/aFnf7VZSChK0istFoq8Jz40kHSMQSZ9sn+y1rlmG2VSqUHdD18PZDej40YrqCVNs7EZ86QfY6zv+smEcNWRYp885F3uXB+bNz4g5VH665QBD9Vd7sp9S575MLYbuAZkKYhzPEUR3Wuu0R6E/OM/5Fk6xmiwrKezoQ1uDd0UPJelppAp/UvbN0xmizDBWu5ORq5Jxs7AldTTxxqgyzkIHE6JNYk7YznPKXsbQpqkUn0V4F/PzE+QvmHoAy5DYC8iHNuuVk8A3F9a4HExKr3tfm33V4QpeIYMz25qMyTbRelXRL4gb6AGENNCnb5FXnOqNjq2LBhejEKUFuMBa7Q2ejS3GwLfoXh5BmvcvNVpQ0jRnxWtldMf673BXioa/RpbPhh58m73lvzfk8/dS4fViXvk/MMiFcUJhtyk1U/Zh+gjKk/Xwg0k/FHO4PDoPCwSV/ZlsovyVF7mCLEzPufHI3xgdNuJuON7mr+NX7A5jyGTISdB6iFWSrti+OIyqcOSdnp3GiSFYXvhmBMBE1iyBmW2R9oLGoRLRdPFeQgssqJ8lAkrqTIj9zK1CGBtolcATeXuVZizh3vSfGJa0xKk2JeFvm+e7ommfpU+cotDFBKnoP8sp/Wwfeco7waXwqoxlc9TCWn51Kz7YjLh6xhTkHojxE5wiZdux0SZwlgMYRfRxdUC1Y6sMkb3sJm7lP4B5Cw7u8qgrBYJYKJ/mR04ivJ3uUm8hUj+KJcAa4JQ/oNQUIjDi2Zt55SiHj3FJ9eHlg1qmYM1vw84QM5XuXZnZ1Xzyl/NKC01Tb8y8UvYJCXn2rqIJDp2WqgYEAomGBzhjz8lVAgP8iK9hG6BenUfgSbRpg6PSijUP3fRKpG6OOiycZfbJiREqYNUzGBgFkEQcvRQfmiviNTPKXMXZnGqPb7b4drDkFn7d43iH3yYKtCNFfR2Xoejlj5u7VHPYnKpQtA2qJ9qt1GKOhphK23aNpYTZVIB1kjvKOxkMB1pwjmeDn/2gfpHs8bqk8kt08/1nvjrrWswT2TjBJYXN9nurxwY1kYJ+EZNO4Lr/37ZHdCMRL5Cz0e/AowhPPH3yHUHh/RcnJQqws+n43urQQsC6RtofaEmQKRPswR4','system','2016-05-10 21:39:13','system','2024-04-22 14:01:19'),('c8e2f520-e2b0-4b83-a47c-0db92ba2760a','7ad62dc6-56e4-57bb-218f-349ed1097ad9','dtrustclass3ca2','dtrustclass3ca2','1',NULL,2048,'R',NULL,'D-TRUST Root Class 3 CA 2 2009','D-TRUST Root Class 3 CA 2 2009','2029-11-05 08:35:58','58:E8:AB:B0:36:15:33:FB:80:F7:9B:1B:6D:29:D3:FF:8D:5F:00:F0','CD:E0:25:69:8D:47:AC:9C:89:35:90:F7:FD:51:3D:2F',_binary '*1:16jOpF1iKLKOJarBeCJIZzmVqXnjInULcVm/4VJ5/mG0tGmfCirLJzPc8P5MM6j6zBd+FRjTcHqnRsXanM9alOj0YrN1Qe26HoL0kSl1/C4DOElHaOL5oZjd0yjrIlTL5x98CZ0y+IrLQvBIDqmYzXLerBp7wZxuSusa/nN3b2LQN8RMZv0QV9ChzXRIz5Q5DY8Fphlx8HASS09xxmf1kSY3GHOJY2MlGA1zgJf3INfwF0DKTjeTEdF0BsYQFsPEN2De4G7t0xjkGEYGowJKEypRvbC5Wt28a/0GiqH1idJFfHclho5/UfyXVqgU7kmQgBrF/eY423Mb+cyuvCxrej3VyYmhLCtUV8NZ/psNIGglWTFMbd4phtKbSd/wjgFmTM9aU6wgwE/d2XvTw2GwE9p6XVGuppl0KqctAkvoxCzSBReWTiWfFF3Rqqmg0IyApMa/T2jhtfPlbeTBJT69mdy0Nco5RPwU9NDIyoo8Pm4VR8u7BbMW60XMKeJp2IZCf1Rpk8uwTdyTJ41tnGBzxryTxRDvvPOSqu86PBCaMAm3PeuEJlg25xEcfIO4m4MxfnBs2/QkZqYKsM7yWRS9dUmCZRnfvyTYIHwq5w586EWzJQOFB7DeM5Xu8rmL7HSI92X6HO4agnKcn8aLJmwuNZxADKaRH/sY1lY1+HpqH5jln9LnMvd5GVQiOq1NL7fFtg+i54GvhsW0pIRDe4v0dwSM95HX9Opg3RDSzoJhnWrPTF8H3Hey8iM/hmyaAkxjdr1Gam9wFQhssBecj8SeEVF+3IFwKTGH8ibNtWFiyyjLlWnA6VHLRsrgeuKlc877H2yos2mgUQD7FDf9DUSQK7vlesZMcr/6m7aMBhQkDLoZJxpADJMPT2sTAqk0wIQ3vLJtR4dPgI4LSA/Vq+cBtsyo2l+24KwPuVi1GF0oo0w82u9K5A8QCfF/Kz3VV7GLmwW+Pa6/IvlLQNUIkDCg9M40WTywuxn2r48KiL5e3o7OmBbpvpuXXQBrbu/v4mYuTKOROWN2Kg7SvIlSbxF6ehmz+/T4VRwKkkNljFY8ulkHUR34mAfA0Moje8QGFT1kHtoGWqSrj6AVR67alZMPfaupvNcTa16MO7iYzlc1WZwWubsL/Et0LSpUz5SPwAcPacyfLl0Ln2A9x1OKkIU344u8TV3jCVrH+3LlQWZ/UDHEbg+eBhJlS1RpyXOIsg6AzbMgI2VioBEdp7gYPomP+fw8ZKC1vm/Oo6HppfNeo6qUM3yzG8mMiwhelYGgAzMRnsRIKaJCdwL7NjVR3kYL8nMWuI58v1g2OqhvdqcVZ7zdwwqD6cB68MaQBX1+xwpbfhW461g6ie2usL+4Pjqby773fHWsdnfm1nm5K+NgljHjfDX/DpcFmEJvZL+fIvBZYz4y+Qmgrhopqbz11w0aRi/YtokFLMiQ0CQQpLFKPO4=','system','2016-05-10 21:38:59','system','2024-04-22 14:01:19'),('ca33e685-44ec-4268-bd17-33cfa2a971cc','7ad62dc6-56e4-57bb-218f-349ed1097ad9','comodorsaca','comodorsaca','1',NULL,4096,'R',NULL,'COMODO RSA Certification Authority','COMODO RSA Certification Authority','2038-01-18 23:59:59','AF:E5:D2:44:A8:D1:19:42:30:FF:47:9F:E2:F8:97:BB:CD:7A:8C:B4','1B:31:B0:71:40:36:CC:14:36:91:AD:C4:3E:FD:EC:18',_binary '*1:eLC0l2HRERTtsj5e9foTJqwfehWbfb2eI35e3OOmD/AVl0kVp5EUFZa7lypUO23E9JAOXfx49h8liT5bUF0ZDUae8lUxpugZ8XYHxHKB2Vmfmv34G8ggmwzwfEcSBClL5p7og68y6qlHF+cbEclVTW3/s7kDS4dFIVNhN+XgvALrpU19K7AZDImg21E24iIDosx9pCh8+gbp+vYgltHsODQfNa7FzbRMZkOC6vHZEfEJMbIvS5Q8DbgN5z2c/rdvbFALiT2PpTlqxFLiLfnA1obQCZMTNoCEuC4yMTnA43IcFSysmPf82Fm14ZXD8QGpx4c2aUouhy1IHRnrfHCj9yv/Wj38v+T2xtpTU7SZugmiKJaahStwu6ut4olcfPJm7hDI1HYwWw725IuUjrve6RjnpZ52QY0QNtkcOd+7BrysITHqYk11s6auCWwpUMwBopKHO7mgTA0OEwAKSEl5eoArLwrbe7Nu7/2GNiAaz5hoCLrhb2TsWFsODsyI2ULCKg4IDxfKO/npN5h1FP8lB8g3SkAbyoukOaLffwvdSVz6HiYgdMhNEqgUqg6wQ79jq2IQuoYcbykgJBV2GCaYa0QVmbzEUMYqVnfSjdTZ27PMxqPFos35LRJPZbKwriYgocLpL5UcKRTNKg1b0leaEkckNuogZ/3o+phOonSoZAaQVzhSoXEaVS+1buvJGa971VBbNytjuWPnUnYM5AnHAzlL+0r54EZ2OhURamwWYvKTo6hP3RktzXWGtZ7BanyO3w0DY1SD/dMSQkXbR2Of4tW825lkMLmqMjQRKKByfnRzX6nK+7eE0X6bbLIEVz04aEIfe/Xiwo8hrebjQRn1HCV92HjHHKALiPY7vekD60jOAfCxz1MbPmt4EMVrxBhHLd+0RjMImGiZS6S58gAmqyPgQwPd4agzv98UStTOnWjXFan/uON9Hh9BrD2uQhXQtF+oKolFLabkq5DpJD8zlXAAoaX52Hte29x8xxRQNe1fIgjPuN8X/IMRom9UaOhJtRTFsyNgjavK+tdRPOlx0k5N7Qm8EGH6truRQN4E0glD9Av2BwCGFD7F3xa02uC7sxkUTPdg9niOzDne4PKxqq6K2Nt95CrYItReCFbSWVMiPUX2fhq5/lMwlU8Q771e8/mLczYidua6iX6QvUSeQzMXxSm1vFtXKVb/yjeiNzpF3y6v9IzD5repekkd5iZ0BH9a/IPFUAxCehf9zHD8asEQYci/yuFj++DdrqjQtQbRxieKeHoU0iCQ5sQ//8ryqZp5jCtccscRBVMMpsbn7pKr4EdLghRm9ykznhnzRjUfjbIWFNn6O6w8qFx57uFElY0vDQAmgJ4XU2HpNdpTwfx8kFLN9Bd5aHH2ORy1C3VCe9AOdhMd16+pX8AKHWPubYMxS43Ene5z/gNiu/PP0TMp4avh1cJIiI/Edlpow86ncrB1KC/vpYejWjSmudfx6qGOMmy1r9v0m+F5MrqGZK+E4Z3iWk0Y4j4OVRBjzRONdC1d+UgDK+6Sut4kYYiG4/RmR7I4xGu2SzCsjJYK8xQAIpt399UCL3dKmYz/CXFAUqErYTdqO2119DtBd14aIlW0aghMICar7XHGG9W5UoNj7LeMsq1/TMgCjEN3pXQiRlXxR8Kefa3qrJS8jhbJUewWh5rfjFk1J9tsEuJN6fc2kZO6bjdzUUFtPbMapXriC+GQ43BqJcQOZxHp16he0wmkoo1nyuXzybpFnlA36NDjue7KxOHbIGuKrFTRLq+FDzuIliqC5C9KrgsIGNUx04xQBmJxeyWkv1SRh5hzTmur4I3UKwKUqR3dwtf04yJkcOPOoC5cBcwHcpoOWIdelo3WD36Edhl0+W+abcS6QmwbN+WhxA8uE6zxBLT5sy5Np31WQo4tdM8FR+b8dBzSuNvD/b6Ndc6LDnFKn5OhIymgIyNExitPZO/aCyMRKAMxOWlSfiXBWo+CZF7BIecPXlVrcAJdy5IDHUbdkRtMdQ==','system','2016-04-13 18:46:24','system','2024-04-22 14:01:19'),('cbddcefe-d727-42f1-8df5-ed777f8d1f5a','7ad62dc6-56e4-57bb-218f-349ed1097ad9','swisscomrootca2','swisscomrootca2','1',NULL,4096,'R',NULL,'Swisscom Root CA 2','Swisscom Root CA 2','2031-06-25 07:38:14','77:47:4F:C6:30:E4:0F:4C:47:64:3F:84:BA:B8:C6:95:4A:8A:41:EC','5B:04:69:EC:A5:83:94:63:18:A7:86:D0:E4:F2:6E:19',_binary '*1:ZHPGS08dbrwgw3O0Fa0dzc14FrCWhkQdB9W/0JRpjrQghcmQhsfy87FvwBFf4pBD/d60NIg3f3j1teaXKDuAbwbXiDg3kkASThBnnFt4qPTfD5sbZEdLrPCj+1LKdDzMIffR5xHDx8nq+4JcqX6+WxjUVBvLix8ELptaKo2/oMM/Rmoe27SLpZxHL4php8a4ZwaNQtpfgkTFTsQrXLIYi7nzofVBIMik0o97MF7O8aWdaNHS9vGlxNHdVeo37wokIPLxzU67EFzoY78VPyxz7qkNmTEAFDDzeAf0QsXt0Yy4eLGipEtTJbXxrxz/DbTASC6SeWr9459IlOZUwDFQGSnMYvzd1+eVIZeER0U0IfpjvOgUPr1XoTU2+SKnlh6FMEH+H/xmrIhcDxPkuerC3wQMuZ8/owKTWMiwZDKddrThvcYtXs5UfDS8N8rd3ygq7tLg9SYuuX+aXBHX/+QzWU+5vxyszbYiYW5IWv+q40W5dahfNDuHkiIu1SnrGDt7ulo1zopR9np939sOZAadd7m+xKxoV0lLXWghoy6GBn6dixjJp730PRURLehFLUIcGHnIUqh8BciY4YfqHdWc05ypQS41JSWwgEUUnHe/BxV+Wu7DRrzuaBDUYe1G0Ymp6F6nwyMt8lp0phd3xlodqPPsG5ifQAvx1Q0I3HjDD8V9IqB8DOozVIgEhnHwfbRz/rdFYPJQa/EoTAChxYxYRCO7ExAEl5nIZZVYBbJuAdsGSZR22KW0D1cmaHmTmrjaLy7Skpw5G4caFg67y10woh4R6en2WilGzHtsmUQNt5Bpvd+jF/COnGfnGkN2p7poyHXSNKOwy0Q+R0JOOTVVg0mhyyIM9m1zwuO/Q9+6yGwVs6HmjeYetrMYM/9vG513Yocxf1+YgPXn+kS5rcDkoeJV+cNnbBAgD8ooCF9W5rne/OvMNnyZ2uMNgbXaS1hn5rim531KeqAgd1DiPb7y6qFoXb//gK90sIn2il3xp00FcDhfj0mL/l/+XnZDQI0ect7pKC2ttv3VapkQ+ffNSWg42eCJYkNEIgKhSeKS5DQME4SLfXnrRcdtKzg3R3f7wPj6sO1nqhNWogn3A+k94q6n2CNxyyq1AFZZZLzKEqn5QcWtgNw5pe2SUE9bLkyA895Z1DUdQZaKwHPNDBkpMglrqpq9bOPTlE2H3d8gg0Cfu6TCr0OHXPmLtBR7Tdg96ERoYussIsKqiSRay3tEwNlaHP/2F46MXoZKSR3C4n1PDS3XYw2gWbRkptbXgbjgVO7Z103QQNQ6RqGcgZjlEwPMcKObp6tUwe6nEUVd/tE92CnwRDFScUS2zDt2e5pPPw0nyvnjhPu4wZPU6w8P2XbnmQ0njeJD/fmsv6mI5qD7N/keJDfhlJkhlCu4vlUch0atbi39afyRSox1xWLQ/aB5CbKw8ScH4tj2MtLVSMSQqn25IYbewNVsuZdZnwtNuM35i1civM3oHowqemqmgZbRH3yMXYualrdObnJaaAL1g1eOM5NaEcq9PKJYR4hrqI9KVT/6MgBFx9R/p9jI9U5ZCnk6FG6+0rymsfeSpeZbnpELS6WdLQqqb+H5G0O+58bd4c2mrCuP/vZ7RpgS2jYI9txFvZdorlvuKtvRMSnLT3F8bg9lQcxIrWIMGF00D2qBEs5xGLCwxMd4A+aB8PNYZBWgw5mNfSeEx6OiPnEcF35ScZ7RvcvVHz+OsvIlokzvYnDvnK7T+QIojZHew/EsneMM/4SFEOl6q/M/2l5aaa4etrjFabIQrADJnQLVbqIrC4xb2kpRul++Tj+Q4B10Rc8rpGpGui0WJI5jN0K8QWIMmykRGh2V2QKoUb8YXkRzPvpIYwpjLsdznJyZfVP4CiCPkMSe51vy7hTBxj8YHUFWmoT5x1qWOahWlnp4T6Lp0YI+vDgh0dDXJvhfrpWqCZ55VgGUbmXahfPG/90zZWlS1sqSohv7xHYuByHyLSgM4JvzdVP/l3NKrMhyFQ==','system','2016-04-13 18:46:29','system','2024-04-22 14:01:19'),('ce0c6e76-5251-4137-94df-dba7de34514d','7ad62dc6-56e4-57bb-218f-349ed1097ad9','globalsignr3ca','globalsignr3ca','1',NULL,2048,'R',NULL,'GlobalSign','GlobalSign','2029-03-18 10:00:00','D6:9B:56:11:48:F0:1C:77:C5:45:78:C1:09:26:DF:5B:85:69:76:AD','C5:DF:B8:49:CA:05:13:55:EE:2D:BA:1A:C3:3E:B0:28',_binary '*1:v2d162x6+Tf8an34yBHPQ/lMfX34+lBp4EAWS+0QD2bqv2oLLs3AGvcfAo0irCt0PhQ5PeV9vfEd9WnuH6RGIswL9HPuX/s56hhwrAejbzcWOdkfKIx+11so6lR4ZzFvWA105ZgzyVWgOePstVBlyikgGEIRYhHD3zR+7RKWzkfiBa7WabYBxKx8F3xPqFvoSuVWeIRE8vpg/yNVI5a9+tLeLhTuumuYdnqgpbJK8tnqy7qNXZW8chbn8Dfp5uo0CMBBoI852lPYt9GO3fzRS49ekfsN8Cs8URTTy422POCdygP/gwEM8cTcX9+y12w4OhQ/6A7SoPY26Rg0cKRaNdDRiXirULniYPiW67yL7mwVSxswe/DlL+CVA9Jkbxy7ePMBnLbs92U0jszvT6ZUjPcDQMEFwYxsaY/uTH7YeS5ZsRAtM02TpyM/RpZMPjoE3/TOLoYWslu6ZDQgLSfdxJUkCgIiLt/0gX2bQQ8BcrIUir32aLAwlXHYv3s8y/tgcid1dY4yaEwjTsj9QQ88u4Mv8gtzvbTnYatUXYs1VYdC/LF2/vXyjL9N5u2ovDN+DT3K8+OSKHO6Ro7+K2ussoSBkm6Hm5BCl4qBlW2S3N3af1Nk7am1lRp7Mtk7G6ybzPx7TyQFiI7JBc4jqmDhQ1wQvBjjF21SwJ5WjCA+eZKFVm4oyK33v60v8q4CykRT+1EwacG/GxGv1Cks33UT/Qf1tKelWEzPjV/2aDZP1cY0prQIYRxCx+qFNLsZHKIHXiqKUol1xIvCpc6Hhn5QZTriDWj+Lz1m1RMriwZPDUfMNLLGgXWLqh1SiN7a6T9OIFClTB1CibcaF+8lo9IXGD3geHTzRut+/F2K4nC9DRcu5jjPWWwMTQnWr8Q2dp5dl+xYulYWxQ68uqyzP4BB0iRBtPvkwNP2D7VPeBKqGkk5Hq5abA2EheJseJJJcNltb9Rl+baj3XitWJ6R6V8xGfmLfokn25MuNfJB3WX58mVXdVm6EBorOV0H6NgoeM1mSN5wgjH7y3Cn2ABpPN2ub6OdChjLSTyXkiELNSEWTuf3HAuEY58UvKje/WWBnwMCZslFbXFkLJVNwWy0LvHIUPRTu9HaYWGoFMIYFHwsgIbLN0evvZnGvGaHrz8YRivezPvyRvKegJgtq4a2qEK2cA==','system','2016-04-13 18:46:37','system','2024-04-22 14:01:19'),('ce1ec90e-0588-438e-9801-2505f6b68082','7ad62dc6-56e4-57bb-218f-349ed1097ad9','certumca','certumca','1',NULL,2048,'R',NULL,'Certum CA','Certum CA','2027-06-11 10:46:39','62:52:DC:40:F7:11:43:A2:2F:DE:9E:F7:34:8E:06:42:51:B1:81:18','2C:8F:9F:66:1D:18:90:B1:47:26:9D:8E:86:82:8C:A9',_binary '*1:IHh55B0cl6oRmSUTD2ebOEhxQIkfIBADOisYF5uSvETvvm5MgoYZzPATdtH0Z3JAqXZ44Iayx8TYvLj+vy/z5jO3KV7/ioxZFKDWsNtOBTnqkWcJS7GdODml0VjW8lLO/J8jMu5CgGoeADhjlTersyqvs0ereWb2xT6o3QhvZDVpclz3cZpFnYK9NC5yyPjh9z83v7CGQxjGBEAg7CZd3YSs7EGHlq90BTZ8CG4Bo59nh/cRDw5OHApKPjjz8qzRPKz7Vjxx85FggTFoZJzZdzxYLxyiY5aG479siesWvK+5DOwiTAAZHC074DwvPLyav3jDOCbnJXjDWNoTTpLXuM1llC8FnfN8IigHXkXIwsasfO+S/ilOIEE8aM26dhArewdRi0GJi14IpBuLO/h7Wz4RL7UIK5TGbzrQM8O6ia+paZR2qOx00uud4fvLgHJXpfE7CmLOxu3zbJgD8t442KsUTxM+HDI/jDURsaO4p0jdQP/ikmQGyFXnIXfb7/ZpRdUQD3PQZKd51awx5L8Zkn8gQ6INeLAlYZ3DzUEFC9nkivacgT4OhDLg7gxfg4SQtEjabXor/wotGChFZE6uIr1J8eQcjDMN6qcll4bZNwBwvw8bflpnOga0qwLRX5Cj2AFMaPDBMLWvnhKMTlEZMh+ZIFyI4KFPAzmXkV7vgXdLx6q8ON2gXr3Y9BYAoBw/CA6iykw6y+zU9z5absDFLGLbdtcGWKhEhfT2qJqJxB1SWLIx14IgPAMCvfLjvzjQJIS77tWyCd6HW0e+Bi94NmjRjO27j54PePGLibBUrFRHvfP/Zfgf/S1qAeD7EvXzj0yizPC6ywJW53KvDF7qrV2KzLlld+MwzU/ciAW15uyTXZF3q/hq6Vdl2u7gZ3d0CM21Gl20fALPEXttUXjpOJo+XSIK96cPkldhKQhAcxHytoo+Gaa24jAzlFSwBC1j4VvjHoGS7n1aGXXvu2A+OvaSC/WmokRSawCsRGpbkDt0gGiyEXYBVCCr+cUc3F9YnnHyLSNmOlvxSlxMnwu/HjIeUeSMztheRXWuw/QuYwk=','system','2016-04-13 18:46:27','system','2024-04-22 14:01:19'),('d0605d30-44a4-44ad-b97f-3d2bdccde58a','7ad62dc6-56e4-57bb-218f-349ed1097ad9','geotrustprimarycag3','geotrustprimarycag3','1',NULL,2048,'R',NULL,'GeoTrust Primary Certification Authority - G3','GeoTrust Primary Certification Authority - G3','2037-12-01 23:59:59','03:9E:ED:B8:0B:E7:A0:3C:69:53:89:3B:20:D2:D9:32:3A:4C:2A:FD','B5:E8:34:36:C9:10:44:58:48:70:6D:2E:83:D4:B8:05',_binary '*1:aHr9UO/pjHGAmeEjLvQiWFauv3zv0z9ZLJRI+0ro+1ZfdzQvNQ2v2PyQMdBOuIpL09CQs1b5m8q5oglS1NiAJOtNBS3MaFQIOgWuJ1yDuB48LRo7tAQD99tc1aveuBm0KaJVej+GPs8HWNgstRuzCiqdO/I2WHfr8Le9LgzH7226ApF5mziFJvBtdf5hVpx9h06BL1JhlqMoFtukKPESVt7dRakLK4/7X6dlwPKhexRRdfuYpiVq12XZCCvpRY0q71XrCAphdWfO4QxnTv6A+e3S1hfcyLicjY7pUMyXoLkgBA8GIT37ps9o48fO4bhMvzij+WHEfkYe920zT93CzX22uXW3JiWocxsl1SYnw4Y6cyI2p1/CvV/I0sKABYBlK61nhYsRXnuutPFm+3JjMC32VZkVsTXYOH+NNnJvfuR5vkpE5TrY10R0vcFDWHBWxeecP/MtL2Gvf2r3bnF9IVrPvYU552pOiggK4tc0ZAHkt9zL9Cs0tFrGU6HNvegzimfCE+AP4a3P3Npj2vWSbDO5qgQSCHJClzj3yyqryseWzbTXVrgUbXMvLLa4OAs4oPmby3ZUHctyd1v3bQeB2PJ+UU+OgwASWQYf2N/ZQIaPIyXG8NShYxlE/iSXlxADxxXOQibXBt/qoOIbVttQu0kmOlkML6G3vjQlAeHdXBtlGa17RiQUzQM8b/CwbR8o590sEUGWI4w5ppeEj/crQXFWy1CUdncnT6N4OkjjPA7tiiu3rSnYQpki70B7I2T0JPH5pjB50UqojKZ/BK+0mezH0KHgTWFhvOPL3H6o/mdphj4sU4yC7LC61BmRFpF1zPsARt7ZfmWrA5NmtB8ypaCpgQWBJwzopr0dveUbS2Tz3+/NAMELx2N+gseEpi3NVClNqckIuNypC0HJyzPxUtJHt6UhnkKEldGQVFnlJVqa/kt19q6RjNCaR52EBckjTLPmZKcAl9ALpBR91I8ulsYvXd7XRZa24CnFUceuRacf9cmdEPNdAM3RtOZ6K1pp76rhsE7jG8gZgmGcDxQKdSF7TKcXhaLGLvMj/AmPbIaGobnSxWpUdpzZGTHyf144WNHeSiJKo3Nt2HyCoEL22nf6DAw8QF79hp2JEcLt5VpkVW7L86IACPns8HLvEGRja/MT6luKRu/o03sqaKlfHW4oskEOz3V4z4EZGtJPhynH+l/giY2o3mKe4HncTLao0zRiVXSkef3FXSJZIyKQLGnm+mm2FFwDtrbnUNLSMRpwOK9JKZHorCaroHmeTQ01kre7EAhCBraR+Ozraxyjrhzrmz4kIcxnetLuYq4DwROI4ilaGV8iqC1tt4a269YyMbzCUNXUwgiRvUuXfsAGdy6Qt/BYkc8SSy4rP3HbIoQ=','system','2016-04-13 18:46:45','system','2024-04-22 14:01:19'),('d08ec08c-5f01-4de7-8882-26252f81c7b8','7ad62dc6-56e4-57bb-218f-349ed1097ad9','luxtrustglobalrootca','luxtrustglobalrootca','1',NULL,2048,'R',NULL,'LuxTrust Global Root','LuxTrust Global Root','2021-03-17 09:51:37','C9:3C:34:EA:90:D9:13:0C:0F:03:00:4B:98:BD:8B:35:70:91:56:11','42:A5:21:7A:4C:AF:C7:BF:FD:A7:F5:B2:10:4C:3E:BE',_binary '*1:MFk8jjbkwK5J5VDJNWj5t9RMainak8MPqSYOZj3s7PncKymn82aV/Yb7dxC22+iM7V3DvOwPGOi2Vd78ogbBA0ZY3qky9ZggSXk3G+nL13MQ0UC/bf8sH3CZ/OZcdnQ4rOhjQeOhpiuf1eCg3oQG8x2ZonwnIixQqM4ozldnXm4tst377JBkRHkIP6luTN/mHBiv9ZdvFNzImc7T1s4XcEkIyorUriXEjgjqs0HNl6N7zTjudF1j6jmq2hsNnR/OdixsOTdwRKEujdlUEraPYh2xJJN4vZqQzo4+AtfF8AAERaSUJ3TPAOPyPIyRb7egZcRIPj2Qk9lNUsM5czWFNgzdSv8DWyciUmT+3xjcn+//CITORVqKf4+gyvxjaw0YZT92k1JkSvh0/SK3+VxPHh+kkTGJcf5CLHEbLJT7vsbpzUMREGdvV2RXyFVmXHYHgkmXot8IN/eSn9GxBBC2bqF3+kEi/a7D8sHRleENp1BkkmGEMg9266hgTs1siLSo1iaicR4DgB81351Hl9CpOeByc8UGmwsczaIEOIA+bchoeeNo7snQCXVQ5logLPjYGhpWOeAt9qBA0dKryt6ko3ZIIpgIIb8QARqVLQVqzvGjHEWfdN9vCiKNpCNOFM+JcSNK4nZrI0hyv94HrDPNfgyi6wdzZyRDaGOyrZPgaDJBTERdIT6rNnu3IcPTOULMwlqIQTHqdYKbwv0INIYCa2ptzuviU/WjislEho9OoYJp6YGiPclzPmK9ClEXopy4WhtQZxJ+VcikTJQhgZCvzBhMfzZTSIT+SP37WYF6l5CfNzcIjRwLbYYLhDXycIXaYOM6lcnG0WlK0VY5HRTCB9LPqAXp7F6Dfs2KJdgeDHzGfAypy46rRuZn/EkXjV24en2fVFrwzSOPtNQ4je2H2AEWyJauhdk4ijoJugk0QsSrT+dNh9aqnDFvtkAv3R30G7T+rj0qFxcEhTjGQfKQjGDp84WD70u6/kfcIZGuKPtEbhtl8LgHpxD/aN5M2DLz/QlfbHwUxAE0j5y8MhRmpxEd++fFLRyP9ri0vlORbIDH+quCeTdpB0nwIHufuqLHH1/RocX16Kp8+HhnO9fkF226p7NwQw6Y7N8XBWnX6ju8GmHyunSoI1kfnQnEVb2PsamB2yFtAFiov19yD7HAJQ==','system','2016-04-13 18:46:44','system','2024-04-22 14:01:19'),('d177b548-49aa-4066-a15f-eded752fde4b','7ad62dc6-56e4-57bb-218f-349ed1097ad9','digicerthighassuranceevrootca','digicerthighassuranceevrootca','1',NULL,2048,'R',NULL,'DigiCert High Assurance EV Root CA','DigiCert High Assurance EV Root CA','2031-11-10 00:00:00','5F:B7:EE:06:33:E2:59:DB:AD:0C:4C:9A:E6:D3:8F:1A:61:C7:DC:25','D4:74:DE:57:5C:39:B2:D3:9C:85:83:C5:C0:65:49:8A',_binary '*1:XVoWBStqQYBk1E/if+Nqst8tPVS7LPqkUoOjjIIZKKn6MWwXFJoTVKfWUKoJBS0hb4Lr2cdMxAlBH44gNp8EWQFO/KOZepAlW48fDxAnA6vLGyGjDH2tw15hwSdalSbFljEuIRP9SZ021oEQMslhSzJmpmmk7VzssT2Nu+qk8w5q6n1GxzUjQNCn9n85Og1eKcPQw026J2Tw5S+tg7ZOjyI9uniF2BAp56M9o19j593hmsL1bSHRXByWCCIn2Wd+gsmVqSBjr69eO8mPZf5jBU98gikNViK/MIa3UnIl8SVo5H0hZb7H6kTKpg0LQWsk5L7ZshtJRQoeGmajuyHzn0wetHS1wl43GVqxDc3vf2zgs2UVpoqmukZvBv5U/zCrOSkEutnbfGVxRg8eLqLf0HOYwJVrn4DlsDPtDpNy7TyFnqc0n8n1O4w32JUmxU6eUx8n4oml+g45B0S+aDjI7A8j1G2pHrjXc9+fJ8H69aPogbxiFkKtxOPVrsAW6BB2WygVjZElTE8t/Z+Zd+oZfLg+Jnte/xPIr1bXcUDJFXOZfYgaJ0uqihzd+sIrcufWmggpxEFHbKt44m+Ruws4MoBANz5JpSmbCi3SnoxOrRekM2OIMEcjeIWNDPH6Hedl+ZevHDyryYL2bp9tHhH9iVzYqHVGWwETFxFLUV2RrBoLZI+359LYTa4czw+FYjskw6DCPHnHUN03ppt0FwKLPgynroW+jKwXJrKeD4bpMyxbPRVidRyrq/hlmMxB0lQpZh8M3GpxvbwqDUATqKAzhwioHkl7Vfgd/OgLCh0kr9d4vBsBN1zvq+ScsEFlB32f0GP6r3jWMGK5/m4ihqBv6EJkr201+PripEbF/CbxFwqHDYTneiiCpv9YYHyi87bVRlHHhSiMJBh4/DI5HjASlQ0S0xwqy0VNfbxOpx9+xiC4sQVLAvuY5xV19ywtDZpe54CGg6zrYvIOiFvTp6UxqI7LVUtUNrqluIuz3VgApuF/aTZPModEohFYZhL992lCwbB7Hm/7CRylEzf0G4cIjQuTWQk1bV+9BBoz7trTtZxvpAgWwxv2N4nvb0Z384U19+2AKfyA+wDenuI0fVbsqGvX/X+gpSZ7NJc7SKQHn4uaExtwZFoeMm2rz/MToLy3D/X1TnfGKPkFji3H/7/3MPUkS7mko/r20129/nROsLQOIgH8SUu4EIALgXhSymA2gakDaGAT3KD1Ikvene6A/lKagXtox3UcgLHH6nV8X4MlwRnHMz7fv8uf5SB39X3gNTeBCtntjge2s3toFEChTw==','system','2016-04-13 18:46:30','system','2024-04-22 14:01:19'),('d4875be4-7994-4493-a2ed-da2d1ff75e09','7ad62dc6-56e4-57bb-218f-349ed1097ad9','securetrustca','securetrustca','1',NULL,2048,'R',NULL,'SecureTrust CA','SecureTrust CA','2029-12-31 19:40:55','87:82:C6:C3:04:35:3B:CF:D2:96:92:D2:59:3E:7D:44:D9:34:FF:11','DC:32:C3:A7:6D:25:57:C7:68:09:9D:EA:2D:A9:A2:D1',_binary '*1:RWyRrg0CgcJYdM1ut6WumnKIHqqrdIojv+yfauB8QD8y63fyDp4kguwzT0q3VivXWZJ1YEJL5Z6tln41woB75SSYsMapDPtvyuO/cYtTNtoE+YZSEDHz3FWo9Ejb+mreAmgAVseqoFUrajKvednibhnC4wn6gmMrrsrGiegmlBPLXoF3tt3/rdqet+BqM2R1sr+focRtBj+bOgvEaXq94u9ZeCN+LHbhBskGOrNjBY69waiC6Y9nDD8c3dQBlnG2a+NRxeMuQGNBYUnJcdV6651c24+6e3PEFFOdji4ta467nTqnbBKOl8XJU62L0wjdD0s+GqhRaARJmTUtI9vLk9qrMZaLxoQIxQ3uTaD+stLG2fmTG39YQsu5B7HME21+LYhSE/Ro9UEe8SF0bJWoQbSnD//ZO6U4nhvJ5UoCrOrdJLctMhN8nAsLth1QeyUE48EMRA3A3kB75X78RcaRXCbB6efThkEuv5ZpOqWK+MI+I3k4SbSFuVdZP43wl+V4mIOjWRaHrtJvDjIErOLRLm9JlfOIF6mxfuaQ1NbdoLhZbfqVu0myeu8K8cosRh7ZYSuZbGoowpEmP8+c4goQsZPYH5w6GdjOMUnGnvLJb8nNSeqMxaFKbA2Zqi5EYNHC7fy5LHSM2j5FqWtBF4GgJMm2QrhlROZWVCjkONvdNSkivRCikImujgySdjG7ZYe0DcgVwb3F2X3UjdsAdjuwzIHWVodofAUaowcLPLQy2/tpk699udcvPapzKdzu0EwsGhJ3Wn0JaG9SaxD/rQ82oq4Q2S7TNY62EXj5Qt3ouGx5qU86kXbIyZgjg+gq2u/g5FwWUrbbMbnZ65INMHBiJuv3VWw46yGezymbF7WZ/Q5CKni7mL2NwqrbSVuqmpZTqHxjJz6uMBoaIzgnh2c+8TAW0nt3+dCzAJT7HXAhsPWuJt0BA5ji1RlW9hcfZFu0ZwKxIoFUuDXPqy8esiqUhhCpShE9/hLGeQmIwOG+dTXc0w+SOokgYm3mxo3Cza2ru4K020Ma2v8/Y0abgv/e6/eGrDo/TjRoHnPQd+6Ic9t/BBbRD072sS8vgDGY9UGjCJp+ex0HQ+vvSDXUneOfKVH0krgxzrfYAIhMKflI8FiEwoshVHW15EZkGjcSA6QLowzss8cdeK23DSjrOWlDTf4zG3Htj6A0kQsKrmRAch7pfbR7U5rpi3X13Skc1i7lUTCiBDP7e1MR91ioQkzH/blGSjUyCK54mGy7MQCiU6GGE2qTg2FiodTx0UT2G97m','system','2016-04-13 18:46:25','system','2024-04-22 14:01:19'),('d4b642f0-a8a4-44f0-b9f9-042c287272d7','7ad62dc6-56e4-57bb-218f-349ed1097ad9','soneraclass2ca','soneraclass2ca','1',NULL,2048,'R',NULL,'Sonera Class2 CA','Sonera Class2 CA','2021-04-06 07:29:40','37:F7:6D:E6:07:7C:90:C5:B1:3E:93:1A:B7:41:10:B4:F2:E4:9A:27','A3:EC:75:0F:2E:88:DF:FA:48:01:4E:0B:5C:48:6F:FB',_binary '*1:m1DNftA8KgNyVnla0Uj7LdY2XgLYIfTULhtv9EusHZ5U0yZ73czu4ZNVxtrjJzH3hAf7gzg1E16PWvvw9c4X5uluP3hZkoX162vul6KpfyeruSWsmrWyNpZWLzy/tOB4ZR9/qP8a57PN6dO1jrSYhg86X5SaZl9Fe7DO8CbnewX+z8z9B1uHUjKK5A394byi7VkMQ54u7Y3xCXOuzSayIf9W93AWeIzTgw661MrL6u2IRxaoR9K/Klx9xOm/vwduRoQa6totc+U0dxSZ0C9ypKVY11URFMOupYTX2g2tXvA2U4DtXYb80TqQgg+hhhuleCKu35ToHklJ2jZkFZBqkfY9uoX+uUv5qHv4Dk9qqxsyQ1PjSj8UYM1bF0inoeCt1lQL2b2KK7cXMV63+N4AaqRaWxjABUEoqeKZrK0mtelL9L4DwsW7mpP6EYucSG/KuEviQ/pnA0Ljvz3j50Pmt0HLLXIIaoeNSEkkRIPgKJLgi4WVpE2SmIGdFukijpmoqh/W53qKK+zs51u1jGUWKnWHJ70qVlJalkL5iqQSuyFDcRPCpkvqYYX/8DRTDyzrv1Be/fFVa8CY3dj72UMKsBpKgnkfUwvesB3DrgKgzqSFMe3Daq7HcAu/+gWgggSG/+aoXPmxukgUzM6LFhIch3fSsJT7urOMy7wTyhwRv9JEZhkk0BKVFem6Enqal5QWvqkHI0Be1VN9Mo379WfOrg9Uq9xiHzESaz1vT1DZE6zjESZmtMwVADP4O4iTHiS+fsQ7WoUUHfZUmgp1yEhgppxu7XVSlzkTneBtd9uooiKrbBQqx6QIO1znkJXMjIht50LCAcKKNW78dY6c2F3gnyMKrAWZZc7rq3kHQolKesB9lgR6H3+tGUC6Ns13qHpo1Qx90Fgeuj8dmMwxIlViohZ0FAAu3Ts3uMUsGMyrTcRspQYbYswwo5tQElD2MINQP5xzLUxNKqy5CQAh2F9SRo2EEGPHNJmkKOkq19QyMqCwbQV26l9hifJ15cDkbyX8NPocEZSOgIW2viap0l+ZY1u5D8m02zGg+L7nCoOQ0zLqAhBkUravwmxRi0XNQGab','system','2016-04-13 18:46:41','system','2024-04-22 14:01:19'),('da15fe25-6a3c-47fa-8e36-95118df6e1ab','7ad62dc6-56e4-57bb-218f-349ed1097ad9','utnuserfirstobjectca','utnuserfirstobjectca','1',NULL,2048,'R',NULL,'UTN-USERFirst-Object','UTN-USERFirst-Object','2019-07-09 18:40:36','E1:2D:FB:4B:41:D7:D9:C3:2B:30:51:4B:AC:1D:81:D8:38:5E:2D:46','A7:F2:E4:16:06:41:11:50:30:6B:9C:E3:B4:9C:B0:C9',_binary '*1:pVlU6afdpArjnUdgockk6GHaOGAUcJT/diL1yNqxYZUU8Eu3dd9hOGjHYr5Ha3xc0zza7Bp4Yr5yO0h03P/kxmahxPcZylOQBzsQqWCjeUMmOfymO3pLiYY76HqqsTlQVELUsj+kvYjN5TP20c0//Gou3oUolJynFN9+bTXvr7TDmgx9Rud3DqnuYlA48TZxhFb7VxJ+q3zeD6cxjeTxGY+jN5F7Ezayo+yYI2oN7GNUxxPZhw2BkAqLkv4H0bU1i/0evljSj06CVoi9B4GHyKfvSJiZISvd4hNRj3aCH8XHW5B/yS2GIU1diTu+2zBwot11nIozu5t8J1y+ZmBTG1v6pLKXPce4DKiYgiYRsSSo+utYtxZJzOJcmFe8Ogr71PKRQ5uI3illnbVlnXSrYqFauV0H7mN0i4PfsyIgsMFUx6y4XSStTyPPT51gkgQV2a64io97g+Vv39tg+9eGSdF5rEiWWLC62uehIl3nt57lfBCyam1fkV5A3LBAqR8EzQ1f2ozk93Wgy+WJGPvCWa7s3/nNTyVDyIHC1tp81msZ7O3WUGx9LYto2FIsiJnkEfMaaixaH6fUMbBjSPYqClrM9cMzJc2FtaOOpwh0avDFy8t5tNl+Fc/U2BHEZFonI2wOYDUK8ZAneycj4x1f8uuizY5yB4fFBHQWQq1JyKODO58pDpoapxyyJFFuRZrzj3rTvsQNCBTe2RrClGkE/5FBfHGmjJfMUCS3p7zvIvT2pZzHjGZ1tE8CrLnV7MpuYGrzNeCDqJwz5ol4PFVObHbK9VMvGc19j2EbwhG4fAdxew/mWcGprg3SYHkh/sdmMEE6ciYrJnYpmw8WPT6YhMOjsgntXtCL4Zu3mFZWQhNT1OR1dGjv80XBGElujkdDslwGj9WkXYiHVA34EabmvYvECmh58eIOPd7i/Dg1Ejh+bKFed1rb5s9plTIMXZCBdvk5tBlmsmZWJVyF6J24CsjIKfm7mbnI4MOyOQ/qf8qiIwZpkjbI/hR/CvTaXjsBLXlsDgCTFtbsrM2989bhd+cxlrNquZ9ElN1za3eu0OdeUZIRRb6RlMmA2eVNCr7XBB7XOmGZdKrUd6oTMj2GrKwetmzwbNamhk7Js/3j2cXnghDVEaqKFDLaxowENdUILyZQFPKKeM0u2kLgddEbytLYntkFDBMK2FXlnE3jxaPegvZ1zQUU8LnhTAdctG/h2S345WRdemJDc4trKsmG1nft1xNNN4OzyKFg4TrnYyroCuHL1LNpxoyQXgBUsKQwSqgb9bVSIsjZcU8bmfvj8Wk6TYpMTXdPs4u2J1cuRpN2TbxWuiMod2HM9ww3jyuo7yWeGClKwDOfQF9VH50rE5GpuxK1CgwNl0D4qlPUnvsz7MgRTDxrczmCr8vAf5/KoDDOWgKHalb9ft75uBbkZT+VuOAhg8OSscZe7S1zMlcynllZQX7t8wE0ZpSCreeD32O/s1Gjkn8qnyyjLxtR0QQ4XXVhlpYQ/9yRtsYOR/U=','system','2016-04-13 18:46:32','system','2024-04-22 14:01:19'),('da6798a7-3846-43ea-9a75-7a511c59e9f8','7ad62dc6-56e4-57bb-218f-349ed1097ad9','verisigntsaca','verisigntsaca','1',NULL,1024,'R',NULL,'Thawte Timestamping CA','Thawte Timestamping CA','2021-01-01 23:59:59','20:CE:B1:F0:F5:1C:0E:19:A9:F3:8D:B1:AA:8E:03:8C:AA:7A:C7:01','F2:89:95:6E:4D:05:F0:F1:A7:21:55:7D:46:11:BA:47',_binary '*1:PBN0XgPBeGLvKEnyBnqlaynmFjHHe310zQsx9/nVapseeVYNEOxBsD26djFVUTajZuqoCGAENrjKpETuE6jCcFMOZdgc3uh2bRJwaLxYl6E7G8n7X8kQs9cPACzULYxJbp7+eX3VXZWMIJYmzzhyoftZGCCENPbjVUgjWwzDYMLlKT4cPJGuNGBbDuv0z6UWx9jyTz6bQaPOtm96aGMj6DaHanS6tbBoLSgTAh10VyZonJsixE0j+1asqO5zek1SAI2Hh6FyRX+Y5+nzEMG1tlcVPJ90flqvb7a0GD7PKm2rJESPRSg6SaUq6T44PT+SpjVaj7GyOE6GBQS44hWXbiO5BufgdjtnJQDkGIRJ5szBEptZtQQ8nLu4gOW/kIwqKrMQUPvWO90ZkxBbV9McaxEXH23iO3ohEDywlPpQfYRW1xoMR97NPRAgXy80kpjW2MytP5pTUhi9lhauDSEHuws6XM0d2WFfpBkUGyD6PgAloS7NwMQaw7rG59NwzCmHGqXVKrBnyApG5r4c5KAeAQ7H2zIaS2sXsY1dRkqa8xuNoY+UuV7iR4Bl64l29bfUxN/uBdiIxeurJPpszDABWeAB3FhnyUNFJmXKaw2xYYhpcyG5kzFSopMjbsYb+DeI0//wA7noSAkilZWvPkyJqir3okq4KjAuvxozO38kFSUQAsnG0x5Tg7KTmKy1q99jBeV1o8zNWjtavYhDZk2ENlkBPlQ4eWmEQ8PleYAj9VWjSdKjaFmZatCCNwWGcvRHBnuY7P0dMYoOXzXZFkCmJa3KwvS26ewuGxGlfrQBT3tn90qaTHpa/2JCNf7unFRyzOiZ30VJYfcMixOp8Rc/iOthajSvUH2uQz84nWDysDxu3OoP2f/h0y2oIVSr9/cZAWIt3wyzX+FD6SKdTslZijF3ymp4+vUUxcqB8Re5S74=','system','2016-04-13 18:46:41','system','2024-04-22 14:01:19'),('dd513cfa-4d9f-4447-8f85-af24185ae249','7ad62dc6-56e4-57bb-218f-349ed1097ad9','verisignclass2g2ca','verisignclass2g2ca','1',NULL,1024,'R',NULL,'Class 2 Public Primary Certification Authority - G2','Class 2 Public Primary Certification Authority - G2','2028-08-01 23:59:59','B3:EA:C4:47:76:C9:C8:1C:EA:F2:9D:95:B6:CC:A0:08:1B:67:EC:9D','2D:BB:E5:25:D3:D1:65:82:3A:B7:0E:FA:E6:EB:E2:E1',_binary '*1:EaqzvUTzKibmUzLRO0HCwzGMucl1v3hp63EMkBLib2+1fnP6bFmCPKIV6s9hrQuxRaLtWIceypCJDV0U2w70PNgmUiBGMwXbk5/9z2MM0G9iwY9bP4qFgF9tCC1Oke6c8ZsCNmghOdQ3ldQXkmZ5VpWD3WwiBYQTMfMgrrm19/JqRjDVI8Ik48/60EeWL0bq2wDVmb1XQ4uw8rqArS76Q3B1ACfCRLl6Mho6L+ssNfT769psqhBupgYDsTrxAUXiib3uWATi/PwNklvsHWp7CwuzeLrwhZ5kjiT8eeo1hUXITmfc4yv0E7bJGmh3jdcpRPNlqirPOdxmwdmNYcJWKn2jecEfQU8LnKvtdUzJrxOqcgvgcya0SuROs7lqbYT6icEvLcIBNBfIZ5VQYWUpKumhe50lEiFJkw78/yMiMSTQ8faw16Alsme9QWkuhBLQX3pXcE04dQgWfuw1MPJikYbamxCfU0IwlNT+qguqR38EhPpiCgol1I+UPzeG9KHOviYWNxMf2K432oL5fGOOqcBD6HB9DaCOv9iUyrS4Bxpixgsi3v6EN7wsNog0MBEm4FQQ18gwX/i1Be9CPswjs1+ChcyFrKYiT33dYqYCQ97I1o16o6LlPT2CB8TLX5Dl+NJQkJ3MTS1YO7Liazm3rUV5w0TLJGKZYg6IfY3V5W/BRy9SDNhhWVpwG8CHImbmnuBtJVpM6xKu363PO+4AUs2+lnFJPnuM6iMQcmZjjxsoAxkuYi2PgoeRvkU6177eGUkXo8nij53PcjWY57j190sznPjqs0y2xBcrmFcDOkv9tbIaRIdITUMq2ny1lOoEJWMHUWtOcFYCeqvZ2UhHzJD5jTabr3O/t62UVAFiNJ2XJdcJJCNwBMhGr/u02jLm9klYcSZLWQbb+1LbnmVEPabU1tvqNdrD8zOvKlZdRN3SbSx80q2W8S44WsLVi2akawP0cBrRntZ2780ytMUuKzmvs8+g0tW39TU+4ceLlQLq0Myp42/DdR7HXpKYjmIVZo1bOSInt2C9gnYzwB3wMQ==','system','2016-04-13 18:46:44','system','2024-04-22 14:01:19'),('dd6b0050-2859-475e-a98d-108d202c11a8','7ad62dc6-56e4-57bb-218f-349ed1097ad9','usertrustrsaca','usertrustrsaca','1',NULL,4096,'R',NULL,'USERTrust RSA Certification Authority','USERTrust RSA Certification Authority','2038-01-18 23:59:59','2B:8F:1B:57:33:0D:BB:A2:D0:7A:6C:51:F7:0E:E9:0D:DA:B9:AD:8E','1B:FE:69:D1:91:B7:19:33:A3:72:A8:0F:E1:55:E5:B5',_binary '*1:w7DqpoOSM3uHdaQPSOD99/V/tpLs8NmcaZjupbM1elJbo5Ewydyfw/HvczXU8RrHN+Yn/YmxdmzLOM2BvhMH3iCw8AAzw6CMcgQqA5QrfxuXAaWo73Eso+8KXPHVs+BfF//vpusOTPBpcbDdVWu1+jss6bJHhvne3RdVnevyqxpOiObH14w8+c8VqvyhPUMxqZhkDplEv2SQ5IMKwzZ/Fo4sDalG9fORMNI7BdIC/a+BVFB9dShw1Od/auGeFhUjScYR9/od0t83DIGN8ac1hUioujLvuDqdZaiKLyRfnTe/LYQpIx4Xw0oKSAr4jbIpYxMr517RXYiKoTzR5vjAKOZm5gUIZYA1Mp3e8F+GR2awPI0fMij/4ai0afGfMBke6KeJQAjAp5wyZzIgoiTym4gQEccA0WYtHT3roqAcJtyk+VNpOV/pWfgfDd8geydlewN9z2yqTUOaflhpPHDw5i+6mmkMZZlEaEvizXbIYvrRcvEhiz42bUmd+HYSxMKpxTYDWIBy3lX6sEPUfBFhTmfjTqdxr5UOQMjUBFMmlEkd0ThLcsz+mef1rayf20L7bhIOlytxO68Ie5FLuAkOyvtVnitxGbG67wPM9DPyWqncmd5PB8T3WNZOHc6nCENhGwNvKAKgb+Y+Q2OPZFvPBYz4FGh9nD2i/UvHs4ZUgSdUeE2wWPteZSy7ZWe5XiwxvItbiNtq2tlmdKKgEP49ySQHO7/0A6AViw1R1Bt1pQm/fGK7DSyIKAZYvXExSmsMU53nf887rWcVu7nQpyH1gOhRwnAcTKH5obFo+Cu9+EQMxx9MtGzUbGQJy5KJRiS3d3oW1dRiYGpa3E4hI2MYjHjLGj1k/e8HVW9Hu/mqxN2I/MimNf0Qw+cxKLGQcZGKVA1qMIMl7jOM5enyUyJ3ulC1SStOTO0V3PqFg3oKDA460JxfeP5Ouwwq4jwex+sr9rkDe7r0fkQ30HterrO+bHPtL7R6I4iWVc/M6WkEKXhDJM+6/N4hI4WnTz6XjuMmllmFuhVK1sdh2alPqh8eXc3NO4w7mwEcm3TfdOoCWwzyMLfXFx2YfO2fl8UL+yQMFTxUI9nISID+P5HVRJOvn8dKPQxfL5sfi5N+bmKziuqj/COJjW4UCFKgGnHbd4Dv+X0joRbl0SYcNrrKYsTbT5ZmGca9HXtBkYmKb/AGOvaX5V4du9Z3/kT2+j0Spe/f4qWWRbJUtUtYlwgItKsYdl08oSd0dnMPs9qL9mwU9ETy36OEbh6xA1FYox0LjurPPxW2ln7sBVjVx9BObw6HvnCZa5PlSEqa/uwfYV4Cs9GQIX2DuetN9hyYlpbdyg9bHQddH+1NNtyt6igEzxrXFA722zxWoYbLM56eohApFu3HmimObGaZq3k0EqfafUyTdqTNRnatRanUAproElbo7MkTaQmIVK07NYL6M8GhIOEiGwiQ7IuxXrBc7qLYNcmVrwOoxjSf9iFNYF+5YLktG2VXX/06EWDrXkzNlc22oDTC80ZRHgX/1rFW6UhnG26xgHuU44Z7tqvxr55bdw1E6YK/Te3V8C4mx8tu8H2jV5OTlg36O4N0S5/kt49px0sx2JX4P70d9Cuk9zPNf+iV+MiESF/1lOq1t3VJRW6xCoFZmf5JwYkntk4bNwmqdO6Fv/S/7HnHLTEJ3oo6aUJ6u1lT2mfKC2XEOu1lTcd4Ktp+HUAbBuCoc6reCvI56yt2bvVUkfdYTvOVvqNbph0lg9C5/m3J1uN7/c53X8vI1WOk0EPn20LEgEitLoOICqWbChPS6o2h64DcSLkauzF8gIi6yNERy8IgdaVIU8B/zuUmEvpEp/nkdD+XuOr5cnSlu3VikP54Q1n68T1LtTm9P+vgl+n9a4kxR+3rwY29LwMlEx0ivS6x9BjwNekO7ad6gpeCJLlMB3qlAW7iSvlIAqMaFzeHKTTR2Zzkz5y1D3ZLM/i9Bvy0DSmthYzdXsOiWWpjNYKpvy4iOiAoBr8peq4Uj3FLgP590hmfWJAw7TE=','system','2016-04-13 18:46:48','system','2024-04-22 14:01:19'),('df33fe28-9d0b-4749-b78b-e5a400b5ba8c','7ad62dc6-56e4-57bb-218f-349ed1097ad9','utnuserfirsthardwareca','utnuserfirsthardwareca','1',NULL,2048,'R',NULL,'UTN-USERFirst-Hardware','UTN-USERFirst-Hardware','2019-07-09 18:19:22','04:83:ED:33:99:AC:36:08:05:87:22:ED:BC:5E:46:00:E3:BE:F9:D7','4C:56:41:E5:0D:BB:2B:E8:CA:A3:ED:18:08:AD:43:39',_binary '*1:R9zRkPWZENyp5gSj2+WQJBwnHx3sIOJnhCQjIL6ASklfzGUlYP1egatEdI6nvt7zjklJOEy/c8Z2lRsYhJLk395K3V0Xw+qjhU1XPWk0hDhmV6P1GgNPZeTA5Na7K0rG/wFe4pe9a+eIhd7y+glMKWCcygiQxnZWNNu3pGedHYbxdQtFwsPw0OCFyzAXhXZMKjdMAVxpkshSL93ofdeReUx+Qdas0aNVvjAN0KzCnwaT7D91WHvBR5QOttEYttRr+zfzLNWfPetiOwLqctZcLRBgrfEod627PB4QiQGEyINlC4KDgIv6kdBBvSMlZVOtT8RORi9912Kmxv/KbuVD/TjFLeEeJ2eYQ2elffs4Efm+1MoyFLglMkLCG2nK4xxR0C02QvAdxDWZniBGNkekJHR25DEK4Rdv8KHCK7KS/sV0A90D4gmdpr91tdo6QZ8uFDtpMCXgnGxRfVhKlPtpEnMR/FeJRpN8AH9o+Xw7+yoxHLOXN+oPeMbAWZMpjuXsx2F5lilLg/TZvATxWvpVoV+0daQx+q3Q4n5wZJswrb/xJgnboN7AMXJ9ZJOsFLyRt+6C61zXbl78HXGyYVwn0IpvDjLfkv4e8j2+ZPIIUXadvHHT2yNLLLqqMoEe/RUd1NeLWyEKQAji5mh96AaTMJowEbrdIJ7wkWS8cECskIFdhS9/xemCVCSVgX/yJZ1QgvxQ0ywI9QRh8AGG18sGGH1ipnl0sz6oejwmbKpEvGBTFycjctcDw/H3fLQMLNRkxUO1ZXHC0K/X35wyw48E+agsxMhPgMB+FaJVa7VsoUgUdaDaTXSbMpEk0Gz2gfr2jNGeSYReHOC4zIs53g3qH+Cz8a0BcI+pQ9/fgZrGf0Ut1XihMpyP3fXdmmgGCWNWYrvVAtQLKf7SXubrYlmV+YD0MM6cwPGTJTIKmyZOnPUYfZZCTVp2zKknPpbzaW5iY8xeRgA+tAIKZBneklXOGjxO3RQg2BipQXcA8vgJlKKGnw5cv2ksdLn79k1T5uVDsHGo7hPIofnMmqqD/URJFAbou6PtKJROkjYpoxO/WYIT4OEtVBgnPPm5iOeBWXrP2eDkCJgS6NrT7JM1gfzpqilQadkB5pEF8Z+asoheRAxrws3vkh0x3RVYmch02gl0x0q7kd1Hz3xd9AVXL4ET7iBKjTWy5Nx1NuNpKcdhlO+XcjsvTEFLFkQFM47Ex7/jfbhFD9nYsPGYbVZJrfqatsyYI8sYMI1PjBBTgmPdptWZ3F5E3b9E/d72l+Vjbq/33PAcnLoZief4Ksx1f316DsFGYm9FDdEOVTHKbwe45ZV468+j/tZm6gatluM396pLLOq4k5ZXg/yVmBWzbSwO+0Lrai3XeEDslL3uE442ea0NLubHneUj56o/6gt4T7Zvr7pEXgG3lQ3P8TSLC63/nouI0I7JGQbGNu4m7TqfYfzaZ6qpoAi8ttsupCjnlttDh+Lr/Ww+TFy3vEcJm2GaTOgspi/CjUC/tA0/9Bo6f8yz0lLENpBuJ9OA8qajZe2Q','system','2016-04-13 18:46:27','system','2024-04-22 14:01:19'),('df7ad81e-505b-4399-bf42-3bf82b6fb51d','7ad62dc6-56e4-57bb-218f-349ed1097ad9','chunghwaepkirootca','chunghwaepkirootca','1',NULL,4096,'R',NULL,'ePKI Root Certification Authority','ePKI Root Certification Authority','2034-12-20 02:31:27','67:65:0D:F1:7E:8E:7E:5B:82:40:A4:F4:56:4B:CF:E2:3D:69:C6:F0','1B:2E:00:CA:26:06:90:3D:AD:FE:6F:15:68:D3:6B:B3',_binary '*1:vHNOT4PwuVgrSh40nM0gwaxZdb/p5D3+YreAiI+Y0NS6OQWizquKsd9yh3V2UwpYF8gQvNwfhWHKpmghCQH2kjo8yfDwzvrCL81vHBFOHNITfi77RiHVJX/4eRusMVTN+qTBb0gOT2B/VBzwzlE2yKQH5qA0HPgIRu7eeDxAOeW+QroIb6jkjE9bIhSnEf7Wvi816jLhqW9Rk/8WulihUbLdKViqxMh8a1HKC5PP+fSUbt8ePFlPXau06gC72tzNgbtnEL2FLDmuiDq9qJObrbD6nAHaA3RT/IW4ttMfQzl/wV3fzRTyW/d+nJADlBNLatLzszQb2ZgMzBc59wmztbuJ7lJkh2RU2hyPW3upWSkiFu7DrsSet/mTS7E1eZ7p9ttbDys/PeW4y/hQ+r5RsH9No6WFKmF9Oz9Dutd9Tyd5aHa5mbmrCTeAMSiatlNBOgL1N4HXf4fzM5rRMf9qtAZvRlnwI2IYcy1obJJ0U49Q5VjlMAqDbGYi7P7qGpd5kyUIt9aXTlUxO5P6+W4/FK1rixZVkXGGCDUHM4m38l43pjXFyNnvtlcFCXJAxHRNyb6O9/yc7FZ+67d1pCaG6rUoi0ago1cHggJMVk5gqGyvN0jYss809VX3qReFUKDN2W3Vl04GYbFxY/lNtsKI1C2BhTJZJFpoFwlzJiusjNnLQzuw8umTk8TtxbzQXcZiBK21LB8biA294M4bnLowpMU40BjMxaltwAE6Ywqu6xYOCPGdFI+a0wFABpAmFguuW8Zop2iwNL0aFvWU0l1gdU0hg6OyVVx31pioUWppklv4SMomRPU3GtFfRXU4bIBNiOrbg5BNqS2YfBNj7ht68UwdQarDCFVISqLAhBVPlW1/Fa1dk2fhOBaFSd/1HqmcKn030J2e8YyXVGbJre+7Wra0V8iiG/ts9V+adBSX3z6zY/xGQ8AsmwGHpiVczroymklZVDI/osmUT9IotfMFWy216bcak8xy814vHZgHLmpjOMPbxHTs/Ni1TiaoDHNZd8PuFhf42ZfdzQZIsXjxZQgR08SxpF9uf7eXtXdKThtGq8KojG2h9L8rfsKnr/Mc0rxyI0i2hxES8kPNk7mafudWCMg+iKbF7tqZ6fpjLvjZMI4oSdCFFKuzM677g+3R/sPd1vnDLz4bTaqRm8NEEfI1U031f/yGqby12dlmFi/8A8KaOudpCLPloyyoaZXX6mAqZxN47Vk5dBtWjGM9wWfLuvKAbftozLhF5561hewVfoarbyBl85oW8o6fl4XicWZP3R2An5GewEP6vK5hJIwVLFfjautvSWEIcnZEEyZjqpqmybgL9bItsHDVTMgPiNla4za5gq8UoXIWVHP6ehjLqGH0Ghur5zTd8ztMacjbuvrkH+FRKfHh3+qT0m7pF0uBax6dzIzQKKsmdYMay+QASlvu+IhswkZtK5JV4tgS8pp6mCKdEEkfGcsxSoIz/uz8cSUpYTr/flEvFozRc4sTEdJIrPSlmFlkKiXVDllrY4Q/tx/mjHuQHxpmD1toTFD0NsOI2amQt4ltb9VA1B05Um+E4KQtlULinznW633y8RXr4Y5mSGKMgRQSl1useEGe/s4SY4p3tNWXruHbUSLqXMihZ54E/siYXmEDgNx6tPYXUofQTknYmBpx26Ch7UZvZtDYo7ifoANxOYDqwiwbVBQ2mmHvuZQI/4/fPRFxLtzo8Wy3kInrxNkWMp2sgqGogU3OM5HpZ4gE7N0JJyXtJpl6IwswbzH8e1fVUfMpgmPLFl3ZYf6XXMlQWo7gGs6TxZY4ZnbAao8YUgrtMKZnNkkLM3lzsBtqd+1gNZNCrM9n4Aaks+UEvHziK8F/bOGdxpzFRB4Fo1YiYPmlPrN9vwYfsCD3KJ4ebJcRdMrbOBWpzZ9tyHmcoCY86qtWR2fhv1sqzHspeHEgIAjOg5zps9AC0wAYbfQqpLzAwdQ=','system','2016-04-13 18:46:46','system','2024-04-22 14:01:19'),('eedac59f-5c0b-4140-8108-84563e4a7c59','7ad62dc6-56e4-57bb-218f-349ed1097ad9','thawteprimaryrootca','thawteprimaryrootca','1',NULL,2048,'R',NULL,'thawte Primary Root CA','thawte Primary Root CA','2036-07-16 23:59:59','91:C6:D6:EE:3E:8A:C8:63:84:E5:48:C2:99:29:5C:75:6C:81:7B:81','8C:CA:DC:0B:22:CE:F5:BE:72:AC:41:1A:11:A8:D8:12',_binary '*1:dbnzj+pdkdfLXJ6ewesp5s1Qb3HJ9d6bpRGtEEdyIfEuLKITdtyoi6Xw0U9deAkJli2y6rHpXINAVuzT0XvMAiuEQluQW15Rn57O/IZPBL+xNpYS8TD4mTgvVKeqfCdIhd3+GbzimBjTxUEtCpotpvzTxc4kz2/DQ5wm/6+1twn/CCtfdm6IKh2e69ptCmVzlnnycqKDOiJveHA5a0v9MSFHuZVKh2FYVSLa4fqimg1j/9w4Wkap9JC/mWU8iHQEPMzBd8Vn3lBp9WRZgwRjP7PhyDpvLmTAogFD5vzNZne7QZwGHRCvICFr+JGW5cKFVriWRKfdNySIWcttuuRey8/TvFYQYPHCnaAxnT+0VNMXsjYsRxRLff6Foj/H3SDY1RywPhS/dmptoewlSNPJX2MgKRkWrZTbXphxyBzSGMqoVu1JUCj+idkSIbxf40SE6X7AjLw2vJC5RSE3LAkHuY6XlsdU2RvXQHjcjN9DZzhW56RON6W5Wdds71g7tqIjlbC0UK/9Dz2y1irm8jIxwk2ASMHef0m9OV1ZAZUinkzHChPWMkvvUr+WVtd/FAavgSBISRmLd635+zDhm8MxJ96GIptZ87nZDbPkdk3Zi8aDNdBGRbqle5ToTaYRBxXov7IszA+ubY8QkaXmGc7Qscq+K8djQiICdsMATMu2EO81eJ8VALAa/kn2PKhMH9du4dI15uj6dm/knXpeVc1CjGBmMFPZ6P2Lj4pAtJq41GsGq+IlV1AacN0tI4JuyD9Hs7yrH7Jcs88GbjNd06/Dd+SofhAL2caKR9ANllMJqPrmH0zpRLtu/PEaR2jOtwwOKfRc+AVfVBMGe8zwnRrwpyqWbNKr3Zlw5f8l3ybPHUA7/fuL9hUn8iw9Tczt/iMRL3z76loYeTtqxUGpPpLJQeWPEKRZiDt+odal2K88TcG1jsWd80LrzNjbbnnTnLXoZwtcrpvbe24rZH7vIFAH1mszdeSPmg2RYxq7Q4/s2uxF1Py94ndjcQWD7ndKZq4QIEa/NaaN/11td7d3H0z1/VKYq355kslA6BbOhmcI51lafi8ODMrFzGmP5SropbmDgMTyu7FjfON+byMpW087ih9T4VxBSVYnIs6RZeVmwJCLJE5SuV7nK+cpYUJVXZrQWiGCT/s0Q0A4L9zn27RYI542nWurz/M54Ay9+Kfw5e8HcTEI/QNx6V+jgTKynoYwf/haJ8Oa9o9qqHwKnuKsYLi4xYEIIkdsyy3FFhtqhS9U9qxqpItg2XL4jBfm9MlF6SVmpgaNJWkRdZCxdDM1DWMcO5FwV47t8Djx0e6jfF8VeymTvrKfQ8P11OM6uoT8uwhsF0MGNEji9xTegPRWDIMC4MK85GofcmKwTENjRUyTQruidAySqSG59A1fTt4+l0hocR8iLKThXFwvSc2Hqw==','system','2016-04-13 18:46:40','system','2024-04-22 14:01:19'),('f3c8310a-968d-4158-b3e5-018cbb31285e','7ad62dc6-56e4-57bb-218f-349ed1097ad9','aolrootca1','aolrootca1','1',NULL,2048,'R',NULL,'America Online Root Certification Authority 1','America Online Root Certification Authority 1','2037-11-19 20:43:00','39:21:C1:15:C1:5D:0E:CA:5C:CB:5B:C4:F0:7D:21:D8:05:0B:56:6A','14:F1:08:AD:9D:FA:64:E2:89:E7:1C:CF:A8:AD:7D:5E',_binary '*1:2r2YC2nzpZXNeJlphEukfVJGro7l86luoIvpH1z7NWCvnNbD5gMvZStcsFovwYk2vJA1UV8j+0483gs6o7BKPpv5QaPMy41w/nMCYogL7CZQv3J2j5EySnR47oOslfjFYS6MjNiSjaj0y4q+G7iNAJJ8ylP0P+BXf5v3tzGx1hdwC6GyNTpjl43YzpAfbp/HOGBmh5+BFQa092mTYYP5LBYgxoaCzz3IQZNrMIHGUNGZToxb8zZOc+3kC2Vsz+/XHf35Y4a0pYmH4T++jkNXqYE+Wd8i6peH8BRqm1v/Izmy28kRKAAWyqljJbTuL2vdolEImxzXvrsrkOE5RQjW2hc83viVfWKwIEtQeZwBhkkKHQfW+mLYxL6dQAgPZ+3PbbMzDzWJkO2NZnapF7s54L4TjAc7FMcd6Pg64Fe4uvXTl/kyKw5aDE5+GIzFjp8Jwazwz3UTeozs2m7B7RU3tWoVOYQPHDTXaxedZHobzRTSbITtb/NI5J83CtHNs3FmaYGGLQVIs0Gr4ldTOAGT/Spoh8qEDamDKMCLXFOWpvwH6PLEXiRM+odoM16J1UV+tFNLBycIQXoc8YWNhr3SfH0cpLsD35lJCz7KZDqFgxxnzItQQmANJTyHsrb1N5EW7ZgZ68cCCPcQ7aDi8Ra1xoCr/gYfoQyoWU9m3A4E/7n2Hnge9BJk2umrMkeTLDVFlwk6ubvrjFzP6bwS1DEbGu6N1PmavUDQ9vwXwWWAcb0pzrMVsLI4uWd8hc2bosVvXujOrdsokBFIfoT38E1+WIJff5w7jC8oQMjK5XJhOZkWZmUXse9YfjwFeKsOV/0oxOazFiBQIT/yCmYqSmRo+s2KvhWFBnRrlR4LCao1mxBnBM3BsnZ0qX9GzluDqJFHwS//uwlLHor1fNB2KdSUQtVreGc/Tg53eYLp5utuBNQJFgiFjSmdupumCSk8YN/5hbDJjE4wqVZbILXMOC7nP4HsTu1MDqbQxYaN9wVPy5ZCrcGHexZCLftfsI9w5UQGigZXSIJB+Dd0Tx0gY4BX5E2a9zFsCwHnHqUmV5Y2LVSqiFAEcgU8NboaYlF8jWROou9IMEWPjxuX8A4nvUoAeh0sgvUzIvb4TOaxza+ImZQDAmASIwXYL2JLxvRlFUuj191lp4S4OqltpfFtnOPCexuwAOZd/WD9eewIAK4f480NqGHqfHx73e3kdGizBpSL+m2O+13wKoKga8mV9VUIA5PXNnnfjAvYCa4OGRCk7JU=','system','2016-04-13 18:46:44','system','2024-04-22 14:01:19'),('f56d6601-1c56-4435-bc5e-cb3af641bbfe','7ad62dc6-56e4-57bb-218f-349ed1097ad9','globalsigneccrootcar5','globalsigneccrootcar5','1',NULL,0,'E',NULL,'GlobalSign','GlobalSign','2038-01-19 03:14:07','1F:24:C6:30:CD:A4:18:EF:20:69:FF:AD:4F:DD:5F:46:3A:1B:69:AA','9F:AD:3B:1C:02:1E:8A:BA:17:74:38:81:0C:A2:BC:08',_binary '*1:pW7Zq9vvkTky+eYXdjYvYEO3Wa14rRWOOPtwxxBlfdcvpL1uny4qFJuwqqWecpAR3l+ApdvfOML2AhiuoQtfd3IBp3srrwkNrobIuWrq1Dk5tlgxABY+cosy0r0YY3SZk0hOM0V0SIeqT/Ivy8tVzbjMsileHEc6vrj4qDG0lwRz9bIf07z1YhXDylizKxs75x/4lKB3he6d/CiejBkpq07vuaml1ZsQAuIIsoeSTO7OH4hjKvvJzWoLyBjG1ALLQ/5pqBKwcezejqk3MYriDP5AnN3BNnjLeiFCfpGwRJ459pKFko0UAA2o4bLqnVC6vACVfji8P4bnN4+hl3SrsA/fk4mXr6RdHkyXkkplhsoOK6UmbvfM5r6HJFxttB/gdRmO3fQ01HcuXTH3RQ1t8QSmQli+vvbjlvZP/8EOIAC97B5FnV4qlVK0fMXNLPqGLybFgJOtn/W2Z9PeyVPhdxjbG4S7617sWVHpGLb6bWUsEnJopShmi0c64+gceH8HSzcvtrATVD5nCsNeIbkV6KewqjHRbbHP5HcTPXR2qF2W1XBxfhmwmuruZS2lPfB2a/n3LPjAf52bQKMtDXlUP/44FhyjcMRRQd2BIpQfjS4I4l3T2gCa+LitTfMhS1S8Tc9fVVvxwhyMvAM7tbs2A7eBRTOn0SAgCp3t98sQXB3GifId+pIi0RDEa2+VWUQ969HpZQ3sS36afDIKf5F1x3U+HIm8aJ3FL0QbSxUnu4U=','system','2016-04-13 18:46:27','system','2024-04-22 14:01:19'),('f730a515-2fef-4b55-9bee-2350cf42ec79','7ad62dc6-56e4-57bb-218f-349ed1097ad9','quovadisrootca2','quovadisrootca2','1',NULL,4096,'R',NULL,'QuoVadis Root CA 2','QuoVadis Root CA 2','2031-11-24 18:23:33','CA:3A:FB:CF:12:40:36:4B:44:B2:16:20:88:80:48:39:19:93:7C:F7','5E:39:7B:DD:F8:BA:EC:82:E9:AC:62:BA:0C:54:00:2B',_binary '*1:M+M536WMAWoQP9U++Xo13mUioke7iQ9AnWnxVNovV02jeX0z0x8wUhN+ODNCRjTAxzXTN9BRS/6MI/5N4wNmfq+IHMHMdiLSnBjwluwsb8IhJJW8m6i2petqRzCYhCZJS3XlQXAw5isAf0doVYdg+3MCTH/kOn+svB3qzNfCpF8fB01SPQIO8TMjYd87fUJjBEYUxlRCv+Bn7yPoUg31j1jttOjlKKUraqFLUsy2VIPYApilNYltR+khwuJshk1BY8wdqhKPSSj1GGErUd8JWxPFuOt/jpL8PWFjC8ogwTXwsFR5qr2iVgBbrSzRAGe2q6gCb0JszAxEqWKOI+QfVwZUHsSpNCqYnRbCfxHxnFnODqe1FDxt30IhgxH9jIWINnhGqxXyUkZyJIYe3LYsjZd4jeSM3fu8Im2H1m9Wba9t7te2NfTpERvJtqgfoTpKbNUZwsNydM8kUu/os/Iiux+cKSB1CoX0Z4T6YEt5lcPWn0y3cKsGhnn2l3tcev7EqYrzpUSHbVFV75OZOZuy8roLOVI3frBwG+djqaS0cnhZRviYykf6ZYxR7tBSqkYv8IrkA+cltJjcynWvDbltP3XKQ+R53d8TdbBB755YcASZ4iTM6WJgsg7LuYFyrLfjJXrsGxAcFrCE4Bi4SJHQ4S6BSWgLo3kRjANYjINws2ygcETTN7iHp+DEgN1CNUHJFd72UHeLv9O9j6W4NMxzY4tzkDiRqaz6BHR9d6B28/ywdAxX00rPkCoJ1xNETJ39Sxysh7ItjM6GiIX5G1YS/w+KWzoiAWQKmQtkSQ7JQLGYQhpSCrc3GL5xg5A8Y8fWVE8RihTEHlWiBhMiexKBL4OYLfY1rhLTVtw1XK+71fRgN8oJMbX3Wcfvaxjah8HDnltd3+BGfUoLrSOeP5Go/eAAtvKBev23pJOgAHWifli2odYgogi89Q0o/CrMgTzNb1CnTTDAubBaGxA8Xo9NlzMx/E9Lvdt8e3jyMzj3in0sBMgTnTIlUTELsAa3YbT9aQDakgwsJ6+PruNPBwCdHx2s25jtjSMupJuP3xioOeVQlXdwMMy81ji+WFt/38xiGbtKQfYcKJHhAq2Yj2XLqV/p8/MF/sbKxulSixBPTgiJ/K4xGTZXcz5TdfODeZ+g2ne7gA+nTOuqtT7vhExBpKt8fBDuZgXcDg+Ea7jtOq8y2MMtoVDfg2ni84DZ7n8XoWNaBwEOAOuCoUBDoMlPV91jlnazbCvCbgttcXLKhvpOPJwH9oaBHQ0O5JHh/KSWd/PFa5QKvLt0qrVxvYlLpf6TXw24gxdm4OzaEKe7/P3dkAMBFA6yedtcibNFpDg8SqX6XocscCzApdVV2rjVpB8QPxQPoOkJGwKW15BVumXlQ1FIQLuKR1sY0BzaPSwTbi7FcSmft4XtSz6qoa93mgfeAlAKJEqYQkKme368z7wVLMNPn59UAGyq36e0zNu06j7g0qWl30R/QsX/oyzi38sx6IMI7pp/l1uNS6M/kIP9nYsN/8p9FTcfVinQtw3rnHP1NkcCdWFVGVHcKfMYf4r01pbokay4HM0slsJR/AcPW+D6j0FxLXtEkzi/WBSUoA0QnOGOVuJ+d/tohLu74wIeNm/pw9oGb9Fb8LUdx4GsT2rycFKH5IpDLpVAdfphQI20jc8WrzlNHp939g5Q8F+jOZrz5P42TAJTpinmIgg+RoWE6fLVPojpKtWVsdZ1mFmOoXs9u6K69AgCGermpB+0hxJo6WbBu45keP/M2mv5nrdavKjKopZigV0oeoasd9J0kqtM22FCu19TzOtgw+xn43FDE1u0eDWOrJkdALr4W/hCRw17/1bXpshO+Kd3VC/twMeBtwPnFxJN2sf2Hf13Rlgsbkrz6zl0R+haGUSS1vcrIFbOb46GBeICU4WgaBmXWHHAALvefkF39qE9a0s4DYvaHc81zcG56Q57JsQ=','system','2016-04-13 18:46:29','system','2024-04-22 14:01:19'),('f8dabf4c-e25f-4124-91a3-dcb64c17ce23','7ad62dc6-56e4-57bb-218f-349ed1097ad9','globalsigneccrootcar4','globalsigneccrootcar4','1',NULL,0,'E',NULL,'GlobalSign','GlobalSign','2038-01-19 03:14:07','69:69:56:2E:40:80:F4:24:A1:E7:19:9F:14:BA:F3:EE:58:AB:6A:BB','20:F0:27:68:D1:7E:A0:9D:0E:E6:2A:CA:DF:5C:89:8E',_binary '*1:XhrA2FwZUv71iBp/LGqdajPZbPb3myf6VhvrPaABjQVDHUhxxaD00F2V/m2Uxn13QDAHrVS8Gf+iN+vISdSezgsEIGLNR/suyUQDOiy2fpQwiaZhf7gU/Nz0zlgCpDHF+KWgVbVx3PCT8mvD42dfccugtDZKXx+xthtX13m8phLiiJ+FUbW8oUp2j5fR8jxf5Omjw4OUHUhLov7Kf/4CslCFFTGfzZjqO2Ki8vPLfIY8jYLxh1kYDHXVSe/GlgXM/6RpJRyD60vY3YnFAgHhJemCDpVk/AUPM+zCCGhGRVD0hcdBcYWQ9qhDGPkPiv4a2OfsxL4C2dORRKtsbvaOC5GMfZ2KuSMNKXqIsvbAkKxwkRE3ZwPDMSHaNbnTlXMj3JZJSvP+VBunyCILdC1Vgxnl1OeY4/eTr3mnkhBGM7d3n+80R6LMKH4bfqnn5eUhEoNQTXkfVcvFBS2OFboIr7fu4VkdXO4LRseJC6LMKTDzhiHNZmXZEUvZGxu7JTeN60ctJPmmlhBd7OOPA0MQMA59Td5xibLSEmMa9o+ZXi/RSbppA9iht6kKJ5ccjfzGtBqNwzuoSC66J26kFiMCzsJTaCrj1b+V9g5e6wEKBxfGyjBU0rlznnKoHdwXrXUI8YwUpxOZ9eTdvQ7emfp9ow==','system','2016-04-13 18:46:27','system','2024-04-22 14:01:19'),('fe36d4bb-f4b5-4897-80bb-f8986e09ec8d','7ad62dc6-56e4-57bb-218f-349ed1097ad9','starfieldservicesrootg2ca','starfieldservicesrootg2ca','1',NULL,2048,'R',NULL,'Starfield Services Root Certificate Authority - G2','Starfield Services Root Certificate Authority - G2','2037-12-31 23:59:59','92:5A:8F:8D:2C:6D:04:E0:66:5F:59:6A:FF:22:D8:63:E8:25:6F:3F','17:35:74:AF:7B:61:1C:EB:F4:F9:3C:E2:EE:40:F9:A2',_binary '*1:jes3ijTdxseosralJljYePckHUiKgG4G1SSqvZlHdDX4pWHl6zbwBsZmhCjGlmeHMRQypyu11u5NuYTgmWuWDZ5N0B+xQ7Jxdu9s1L2A5xpgaywQ6vtZkwKpXo9/H+QmujJTieU4zhGg882vDHvBiz52s2us/5TNXZ4mezPe0ZE8zGRyA1m4954prfPHEzsqnMhKFUtIVN7GmeBgy7a7gIelumUC7EdEJ9j6tE/1V9aKVMvRQyYdHsdVPLKWaDX2WXAx681yRlWZXPLEQl8PyX2wBsveo1vvSb1iDb++ELOQoO68bNZ5l9Z5uiJ5Iqa6MXFYDyy1cnruvjHrKkJcaH0G2hU0Hvkkg5YUxityznMmMVxsalWgnBRIJbzSAgdio7g4+fsj0mFCcrpmnPcI8sncQtKQaikbVFw0hRRzG+qwkkK+hWpMwGqVNB9grKS8db4woQPeVLi1Ni3dROgjuuhy1wxp+1eCkvKkPCcY7O1ZpCrF01jYaa10hnkCrIC6dy7vlr7YrP1AVXKAFFuu/87ohK2mMLQXCWkPKpdbRdL9dFhFHgIle44OfrpT83qviw6L8TxeUWaYdp/ZDM9QfI7PI/em9v2J35b1aiIAfmUoSxCYOcIWOm8LszZXvYsvyTLLb21D1jkLvBdI7XzBmd+/xjysszv1skFVo6Nl1aF9CjTSC6olXmtd11BmDjAHq69IetVcBQbi/taa8uFSesKG7es+q2Zj0M5PFE8sGyykhm/Kh1BnE4JESUlhxQhcF7TjO02agTa5ZGfPakwlh8Ea7uAjncGVwm9rBoFOmm74w4ArAyDzqm64MBgPRdanqOGQKqIbnaamtTJsiIsx25QfxxOjpEft+lGJiNfYe1lENnyCISqmNlQzG56qFBNGZD2ee80XLIHBXqg3B1RnYA6sHviW+v58liqkM0ht98+7diItqFUSClC/eFVklWRHJMGBusX2AgJkN29yXxrLi7PF8S1VWk5W7Ulyij2NYWQuPwMrZGaG2n8zcN2hWSlnN5zgtouL6NxmlHS1gan4a1DwropkbsL9ALvy8q2hNqjIZw8T/47u6TF7nyFtEUQNqGF9gviFw5XZLYxO3fzpvgfrYHAAeMScCY6faDpjnVruzNT9+xulLTsBjZdzSuptYuq0WW07WAUO35Cx7rjuBFL0WU4xKYKRnz2mxa/Pgwd1oAq+QEO4SOcL3xxy6tklBBFvz3LkGkCTibghC8pRRWl7qP+yLZ01E/PHm0lszK+IStheylbyAJZziOLes77E8Z9guTtEpAkVdEOQGBcu2DNdnD9XO1wf4jsqJzIIfIEWMx8XOpF7syyhGW+Ot7xWz3dcTLipJ+0RLkzLSBBcSw==','system','2016-04-13 18:46:42','system','2024-04-22 14:01:19'),('fef884c2-e213-47a3-9a77-59d9f76e2d3c','7ad62dc6-56e4-57bb-218f-349ed1097ad9','secomevrootca1','secomevrootca1','1',NULL,2048,'R',NULL,'Security Communication EV RootCA1','Security Communication EV RootCA1','2037-06-06 02:12:32','FE:B8:C4:32:DC:F9:76:9A:CE:AE:3D:D8:90:8F:FD:28:86:65:64:7D','22:2D:A6:01:EA:7C:0A:F7:F0:6C:56:43:3F:77:76:D3',_binary '*1:EvPU+uVUz0Y/ZKM4gPQcUwpCRVy/hU2vuSFw64Pf9P4Sggmhh7Smy0cB336wSMG4FbwE4Al2gzBL3xy9zj1UncBSAw3nmGYwjwvXGhvPBikrqy2OINQIP9virltpbpepCyI0xTNwbnkl6kDE4taZ7mpnSgh8WpCz+FL801zC/q69VdgVpN6E8bBmgMNHAA7qX8o7XP3GQKOooT/1TRnDMdBS0A0KOCdurWbIuemdccxlrXSzIj71Sqtpomjz2erAPT9Sx2grdlJYC7ec1yo6Chp/T5gw8DGbktfrBB1i0dsHH1Sfpz1xfokapQalivtwaOVAdQ+BznJXJEYBtM2SdHZ/lBzrfl3pFcNICVwNxqWos084xTm/+R+RYcFp/l9PnWrhx+xH+0dp1vIgLiporVZY+nRb41eLSqIUWHwz9kj6kXr4TlbT9CTSoya+Gsz907A7WTr0rpLTFkPPjDVI5yw9oCoWcu5TwvGMh2nC+ff2dfOIPtlzkRCxrNPSaictUs39eqTk1PH3qq7BNPAA+V92KyszvUAyqI/B/bMV1pU8OAV3McDHvFmgrmfX08RYlNoxpKIPaC91siHQ8TOeQmqqAJ6D7uc8IzBOSjJxO7Qu9rO3rZ0WcinKiu//3gT58f2Nc1oYE5Iko9jzfWTxyI5/5QAomfjw2quOCizBRhnICJ0m048EJxeWdUWIxHFeBl1S8rMaD8Tdi0E5gL7o1lNdYxhVoDM7mPRRwFlxf8VKuurqrFxRFJ16DZkn59HLFzIKLK49bEpu4lDQB21nMfTwnZps+5ayrEKMLHwJbNsT0WX24JSlWuhjXsIXlbB9pthBpT+F1DMjSQ49hfWmmwk9+QhfqTxpFrpYNkQ/mcTmGWB20s2IqQ1eX06wRWQWUz/Lb2kooe8C5rRepFhPVOBJjrE36sihdZ0yfiTEjILIio5iHCNCBg9imLYq/ImHS0OWId6/CmkfrzAa6gHIcwriMNfetD0yCLR6UEAXm7qpIyXzDq7M4KtXWp6oC7h/zD27G4abWTXjETJdvBNJz4uPxOV4HU3SJEuachMkR48JEIGY3emeKmLRam0usWbw/vEYajnzhC7wVS+0wszT7UI1KHlaXc0SrBfDSItgMzv01jnaekyeIMPxmqb8FASJe5+yxiVQ2Dq7rWdq8gJDUFy7/Os+M7zosBLi3MZCCch1UpLcEaQ0SRLJtauaqMR3','system','2016-04-13 18:46:48','system','2024-04-22 14:01:19'),('ffc5229a-8e62-4faa-9ba8-00018141aed8','7ad62dc6-56e4-57bb-218f-349ed1097ad9','camerfirmachambersignca','camerfirmachambersignca','1',NULL,4096,'R',NULL,'Global Chambersign Root - 2008','Global Chambersign Root - 2008','2038-07-31 12:31:40','4A:BD:EE:EC:95:0D:35:9C:89:AE:C7:52:A1:2C:5B:29:F6:D6:AA:0C','9E:80:FF:78:01:0C:2E:C1:36:BD:FE:96:90:6E:08:F3',_binary '*1:qOSdj/9/BB7V7cf8k0eI4GpZOjAYiNj0CgdTCGwzg/RMPj8XJJipFUN+N3YEP8MiEkSKjgIjZYXqTEIemLq0HNM3J1IGkMHM3VNf4sgTEcbPTP54qH/ioDJZB6SbXVSip3nHyYPBqA7Hoyr1wsjtJ42jE3SNmqbR+fgPpCyzZXK7Uc7wMRWTQZ7NagbWR4/Ke90dHjFAbtAz2T+BmswkAdHtEd9rGIlqIw4QcGSs4qOeb0QpdUVkqmE8dXL/2RzTfOAGWS+X4Bu0wYksoNirE32i7VvL79I3DwFKPnA3xNCfWJK/HxXzd9TGy3qvt8ymmPwq7vEBxid4jOtzstM2tEplNLY9nyROLJkKT9QI9DpanMFp6JKuNgf3cYTPqiMCeLqZhO+eQa5crqgDZ4FE9w2XaUYgFH8W2lj7hILLA88YIyKixnxX+oMjZuI0r49v169Md4vmkz9jT2hOeZ2VJlQ2eOZOKEuzDmSbh40TuZIYvWjGsMyRNidHcqHIS88VWQOqxDvImIelXPc10y4lEfRHZ4BBZDpoAcvtJDVRt22CcWh1dGD5ggWnV7waV+7M9K8bRg/FRvphm8UMbB/aXZUCXxdeSfrJoNq8UcBu418fuXSAn8Tl8MmHn9iceUCW1imF8FASxUyJ1WmtgKmQ9yxvGqZcO39UIUGyV7WCjolgfiNYOmk+sSXJK34cUpxhUDB9blNrk/GnQMcw6j+95Wc1D5izGFHW3rm5E3qNsakPyKdLvZ2cSsnQYg7gowR9gVcRZGhJu4ItGSIOiuUDvladhVFrJ1aW4ysRaAK5tpBDI4dMeW3gf5k5YIILq/9U3/bwbe1zWF0g/M21QSqQcPQq8AUS86Pk2d/j7ZB8Gs58dDXH8vYCyn/qWRvKDjly+oEK9fAtaAU8A5p+XUWUEM/PodZIiEZnhFDT2OYRU0P9xbq0kwHyhmria34m6PCyqc3ElF6WktF2E/ZkeO7vUeNpq6ef4gtvI5pTX61Pab6QQPhbk636F2ijzaVQF3tPzAuacEDnumVdxAIk7oyFqIDbVVaAa+DqJNllr3zf5SW0qmOZaCuTBjdgBou97QVI7pLWvPz9X4oRX6LYDjrmv5lg+7d8LtoxVPlX8WzpNV/s13lJgOOeraIEHAd5vlBG+5aM3GW/uFDoozdvfKFxzIDNgmiFMPYa6nYRbTmmkMIETMaN/n4CraNv19ZceDJcLpil7DBTzwD5ogk5IBJ9BlX8Fuw0DeV6uEKz6b1UZKBUbjJ8JSgDbPeJJAYQT8SZsyNnQTatft7xbBiVTsriB+h8sSCr0SiO59wj02UkHdVxxOrciEWmE50cGbE+BcN022ahaszGF8lS916dUZGT8T4AwLgfN9EW8Xf8aAHSfW5IJoDJ1PPehO12OoYSrb31hY9IpEOZg8IiCosqlDe9Jo39JiZbbMdn+YZZeFm+GjwwLPZtSSJ07TyoiN8qxAYlq1DmE+Omv2URfLXjXot/TV7izFsAb7fZq2aty4dMC+8bLx/v8UK/XAJYCM5ylardfd59YHN85j14MJqH5iOdFnmx62HTqptf/zUT/qrwpEtgrxRF3LuPE6ChH18B+kA7nk5rwJDIppPDh3Qc3YtqArtIN2dJ5Hg7M/r/9NLHye3G6fKCdcsApu/HwWMn9dgU4+CU6paI2wi1u5+qxRa3ZwYI3f6kkT7XX7NjA91Tu2kLtdjtcQJ8ZpasstpUWcbivd9AOz3z9mLHoQKcctLVrY06NHcMAeMorV3fErchnfT2G2seIocqav4Q0G2Iw+Fad4lvVC/Owf96QYPeRbCH8S7HmFkn0ZlRMRfunn+McYkfSVnS8dfqgkBBQRtp29aCgXZYjWKL/TeiOtWBC2j147qTAvYtCZPF7DVEHHcCAxbNB46YjsPPEE5QmupKSsZEq9cQAFnew0gnXVu6FSYhM5gZasPnjh8jQqONXy3Byo5EWhzV+yFAT80WVac3dPBFaj/8a/EmwMcbKG4bBZPkgNqAKuzLdnqBvagmcXmE3wNawz95iREFR46/7Zuvls97giIo4DJViAsZdQRDLrg+10FbLMPrtFI4pig2Kusuvc0iA+8avwyXFk+ZFfIRLkAhSVCrX5QzHqszW+HD538OVChd3Jz4xpp1ylCpwKQ4uljncGAnjAVFo3QVEe2ffT9/L9LgD4I32ouCJSmy4HWd8cBVUQHPThLvrDP7+q4hL3P6j/lRRSIaMjuenSsXegGiDRu4mRv/D9W5zpc+PZJWF3OUdN8XMmwu13d2N9/ZevvHKYEsupavoX0biZB0sLHOphyHZDAw7lLbYFMhamC0wK9DRapzFU5AchuZ+IRW5arSzVe28xAY996OcU0Kq27kmbUG30rM8+bO0dmscLQmOmJRnF4JdStjQaVoDSgP4RCVkMP7D8ZFHbYbyKtn1aj5UO8/SCYVa920ywloTMnIv6Aat8DHAGysQbEKmq73H4ArK1HAdayLSbHFVLPPqMEC','system','2016-04-13 18:46:46','system','2024-04-22 14:01:19');
/*!40000 ALTER TABLE `dpa_kms_cert_key` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_kms_pgp_key`
--

DROP TABLE IF EXISTS `dpa_kms_pgp_key`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_kms_pgp_key` (
  `key_id` varchar(36) NOT NULL,
  `vault_id` varchar(36) NOT NULL,
  `key_name` varchar(128) NOT NULL,
  `key_name_lc` varchar(128) NOT NULL,
  `key_type` char(1) NOT NULL,
  `pgp_key` char(18) NOT NULL,
  `description` varchar(512) DEFAULT NULL,
  `signing_key_size` int NOT NULL,
  `encryption_key_size` int NOT NULL,
  `algorithm` char(1) NOT NULL,
  `key_passphrase` varchar(152) DEFAULT NULL,
  `pgp_user` varchar(128) NOT NULL,
  `fingerprint` char(50) NOT NULL,
  `expires_on` datetime DEFAULT NULL,
  `encryption_algorithms` int NOT NULL,
  `hash_algorithms` int NOT NULL,
  `compression_algorithms` int NOT NULL,
  `created_by` varchar(64) NOT NULL,
  `created_on` datetime NOT NULL,
  `modified_by` varchar(64) NOT NULL,
  `modified_on` datetime NOT NULL,
  PRIMARY KEY (`key_id`),
  UNIQUE KEY `vault_id` (`vault_id`,`key_name_lc`),
  UNIQUE KEY `vault_id_2` (`vault_id`,`pgp_key`),
  CONSTRAINT `dpa_kms_pgp_key_ibfk_1` FOREIGN KEY (`vault_id`) REFERENCES `dpa_kms_vault` (`vault_id`),
  CONSTRAINT `dpa_kms_pgp_key_chk_1` CHECK ((`key_name_lc` = lower(`key_name`)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_kms_pgp_key`
--

LOCK TABLES `dpa_kms_pgp_key` WRITE;
/*!40000 ALTER TABLE `dpa_kms_pgp_key` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_kms_pgp_key` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_kms_pgp_key_type`
--

DROP TABLE IF EXISTS `dpa_kms_pgp_key_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_kms_pgp_key_type` (
  `key_id` varchar(36) NOT NULL,
  `key_pgp_type` char(1) NOT NULL,
  `key_obj` mediumblob NOT NULL,
  PRIMARY KEY (`key_id`,`key_pgp_type`),
  CONSTRAINT `dpa_kms_pgp_key_type_ibfk_1` FOREIGN KEY (`key_id`) REFERENCES `dpa_kms_pgp_key` (`key_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_kms_pgp_key_type`
--

LOCK TABLES `dpa_kms_pgp_key_type` WRITE;
/*!40000 ALTER TABLE `dpa_kms_pgp_key_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_kms_pgp_key_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_kms_ssh_key`
--

DROP TABLE IF EXISTS `dpa_kms_ssh_key`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_kms_ssh_key` (
  `key_id` varchar(36) NOT NULL,
  `vault_id` varchar(36) NOT NULL,
  `key_name` varchar(128) NOT NULL,
  `key_name_lc` varchar(128) NOT NULL,
  `key_type` char(1) NOT NULL,
  `description` varchar(512) DEFAULT NULL,
  `comments` varchar(256) DEFAULT NULL,
  `key_size` int NOT NULL,
  `algorithm` char(1) NOT NULL,
  `format` char(1) DEFAULT NULL,
  `key_passphrase` varchar(152) DEFAULT NULL,
  `fingerprint` varchar(47) NOT NULL,
  `key_obj` mediumblob NOT NULL,
  `created_by` varchar(64) NOT NULL,
  `created_on` datetime NOT NULL,
  `modified_by` varchar(64) NOT NULL,
  `modified_on` datetime NOT NULL,
  `private_key_format` char(1) DEFAULT NULL,
  `encryption_alg` char(1) DEFAULT NULL,
  PRIMARY KEY (`key_id`),
  UNIQUE KEY `vault_id` (`vault_id`,`key_name_lc`,`key_type`),
  CONSTRAINT `dpa_kms_ssh_key_ibfk_1` FOREIGN KEY (`vault_id`) REFERENCES `dpa_kms_vault` (`vault_id`),
  CONSTRAINT `dpa_kms_ssh_key_chk_1` CHECK ((`key_name_lc` = lower(`key_name`)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_kms_ssh_key`
--

LOCK TABLES `dpa_kms_ssh_key` WRITE;
/*!40000 ALTER TABLE `dpa_kms_ssh_key` DISABLE KEYS */;

/*!40000 ALTER TABLE `dpa_kms_ssh_key` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_kms_vault`
--

DROP TABLE IF EXISTS `dpa_kms_vault`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_kms_vault` (
  `vault_id` varchar(36) NOT NULL,
  `vault_name` varchar(50) NOT NULL,
  `vault_name_lc` varchar(50) NOT NULL,
  `description` varchar(512) DEFAULT NULL,
  `vault_type` char(1) NOT NULL,
  `created_by` varchar(64) NOT NULL,
  `created_on` datetime NOT NULL,
  `modified_by` varchar(64) NOT NULL,
  `modified_on` datetime NOT NULL,
  PRIMARY KEY (`vault_id`),
  UNIQUE KEY `vault_name_lc` (`vault_name_lc`),
  CONSTRAINT `dpa_kms_vault_chk_1` CHECK ((`vault_name_lc` = lower(`vault_name`)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_kms_vault`
--

LOCK TABLES `dpa_kms_vault` WRITE;
/*!40000 ALTER TABLE `dpa_kms_vault` DISABLE KEYS */;
INSERT INTO `dpa_kms_vault` VALUES ('7ad62dc6-56e4-57bb-218f-349ed1097ad9','System','system','The Key Vault for storing the trusted CA certificates, as well as the private keys/certificates used in the HTTPS, FTPS, SFTP, AS2 and GoFast server modules.','S','system','2024-04-22 14:01:14','system','2024-04-22 14:01:14'),('cd7f043e-2cf7-ed26-6af5-2e500c1a0e7f','Default','default','The Key Vault used to retrieve a key or certificate if no specific Key Vault was selected in the application.','U','system','2024-04-22 14:01:14','system','2024-04-22 14:01:14');
/*!40000 ALTER TABLE `dpa_kms_vault` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_kms_vault_domain`
--

DROP TABLE IF EXISTS `dpa_kms_vault_domain`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_kms_vault_domain` (
  `vault_id` varchar(36) NOT NULL,
  `domain_id` int NOT NULL,
  PRIMARY KEY (`vault_id`,`domain_id`),
  KEY `domain_id` (`domain_id`),
  CONSTRAINT `dpa_kms_vault_domain_ibfk_1` FOREIGN KEY (`vault_id`) REFERENCES `dpa_kms_vault` (`vault_id`),
  CONSTRAINT `dpa_kms_vault_domain_ibfk_2` FOREIGN KEY (`domain_id`) REFERENCES `dpa_domain` (`domain_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_kms_vault_domain`
--

LOCK TABLES `dpa_kms_vault_domain` WRITE;
/*!40000 ALTER TABLE `dpa_kms_vault_domain` DISABLE KEYS */;
INSERT INTO `dpa_kms_vault_domain` VALUES ('cd7f043e-2cf7-ed26-6af5-2e500c1a0e7f',1);
/*!40000 ALTER TABLE `dpa_kms_vault_domain` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_login_method`
--

DROP TABLE IF EXISTS `dpa_login_method`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_login_method` (
  `method_id` int NOT NULL,
  `method_name` varchar(50) NOT NULL,
  `method_name_lc` varchar(50) NOT NULL,
  `method_desc` varchar(512) DEFAULT NULL,
  `method_type` varchar(512) NOT NULL,
  `editable` char(1) NOT NULL DEFAULT '1',
  `created_by` varchar(64) NOT NULL,
  `created_on` datetime NOT NULL,
  `modified_by` varchar(64) NOT NULL,
  `modified_on` datetime NOT NULL,
  `visible` char(1) NOT NULL DEFAULT '1',
  `last_sync_on` datetime DEFAULT NULL,
  `next_sync_on` datetime DEFAULT NULL,
  `user_type` char(1) NOT NULL DEFAULT 'B',
  PRIMARY KEY (`method_id`),
  UNIQUE KEY `method_name_lc` (`method_name_lc`),
  CONSTRAINT `dpa_login_method_chk_1` CHECK ((`method_name_lc` = lower(`method_name`))),
  CONSTRAINT `dpa_login_method_chk_2` CHECK ((`user_type` in (_utf8mb4'A',_utf8mb4'W',_utf8mb4'B')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_login_method`
--

LOCK TABLES `dpa_login_method` WRITE;
/*!40000 ALTER TABLE `dpa_login_method` DISABLE KEYS */;
INSERT INTO `dpa_login_method` VALUES (100,'Anonymous','anonymous','This method will authenticate the Anonymous web user.','com.linoma.dpa.security.AnonymousLoginMethod','1','system','2024-04-22 14:01:10','system','2024-04-22 14:01:10','0',NULL,NULL,'B'),(101,'GoAnywhere','goanywhere','This method will authenticate against GoAnywhere internal data store.','com.linoma.dpa.security.InternalLoginMethod','0','system','2024-04-22 14:01:10','system','2024-04-22 14:01:10','1',NULL,NULL,'B'),(102,'Fortra One','Fortra one','This method will authenticate against Fortra One via SAML.','hs1saml','0','system','2024-04-22 14:01:10','system','2024-04-22 14:01:10','0',NULL,NULL,'A');
/*!40000 ALTER TABLE `dpa_login_method` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_login_method_saml_filter`
--

DROP TABLE IF EXISTS `dpa_login_method_saml_filter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_login_method_saml_filter` (
  `method_id` int NOT NULL,
  `pattern_type` char(1) NOT NULL,
  `attribute_pattern` varchar(512) NOT NULL,
  `attribute_name` varchar(512) NOT NULL,
  `filter_type` char(1) NOT NULL,
  KEY `method_id` (`method_id`),
  CONSTRAINT `dpa_login_method_saml_filter_ibfk_1` FOREIGN KEY (`method_id`) REFERENCES `dpa_login_method` (`method_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_login_method_saml_filter`
--

LOCK TABLES `dpa_login_method_saml_filter` WRITE;
/*!40000 ALTER TABLE `dpa_login_method_saml_filter` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_login_method_saml_filter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_login_method_setting`
--

DROP TABLE IF EXISTS `dpa_login_method_setting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_login_method_setting` (
  `method_id` int NOT NULL,
  `setting_name` varchar(50) NOT NULL,
  `setting_value` varchar(512) NOT NULL,
  PRIMARY KEY (`method_id`,`setting_name`),
  CONSTRAINT `dpa_login_method_setting_ibfk_1` FOREIGN KEY (`method_id`) REFERENCES `dpa_login_method` (`method_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_login_method_setting`
--

LOCK TABLES `dpa_login_method_setting` WRITE;
/*!40000 ALTER TABLE `dpa_login_method_setting` DISABLE KEYS */;
INSERT INTO `dpa_login_method_setting` VALUES (100,'enabled','false'),(100,'passwordValidation','0'),(100,'showPasswordInRemarks','true');
/*!40000 ALTER TABLE `dpa_login_method_setting` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_mek`
--

DROP TABLE IF EXISTS `dpa_mek`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_mek` (
  `mek_id` int NOT NULL,
  `mek_alias` varchar(20) NOT NULL,
  `mek_type` char(1) NOT NULL DEFAULT 'I',
  `mek_data` varchar(128) NOT NULL,
  `mek_fingerprint` char(191) DEFAULT NULL,
  `created_by` varchar(64) NOT NULL,
  `created_on` datetime NOT NULL,
  `mek_alias_lc` varchar(20) NOT NULL,
  PRIMARY KEY (`mek_id`),
  UNIQUE KEY `mek_alias_lc` (`mek_alias_lc`),
  CONSTRAINT `dpa_mek_chk_1` CHECK ((`mek_alias_lc` = lower(`mek_alias`)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_mek`
--

LOCK TABLES `dpa_mek` WRITE;
/*!40000 ALTER TABLE `dpa_mek` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_mek` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_monitor`
--

DROP TABLE IF EXISTS `dpa_monitor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_monitor` (
  `monitor_id` int NOT NULL,
  `monitor_name` varchar(50) NOT NULL,
  `monitor_name_lc` varchar(50) NOT NULL,
  `monitor_desc` varchar(512) DEFAULT NULL,
  `status` char(1) NOT NULL DEFAULT 'A',
  `monitor_type` int NOT NULL,
  `trigger_def` varchar(128) DEFAULT NULL,
  `prev_fire_time` bigint NOT NULL,
  `next_fire_time` bigint NOT NULL,
  `running` char(1) DEFAULT '0',
  `num_fires` int NOT NULL DEFAULT '0',
  `num_misfires` int NOT NULL DEFAULT '0',
  `created_by` varchar(64) NOT NULL,
  `created_on` datetime NOT NULL,
  `modified_by` varchar(64) NOT NULL,
  `modified_on` datetime NOT NULL,
  `system_name` varchar(20) DEFAULT NULL,
  `domain_id` int NOT NULL DEFAULT '1',
  `proj_loc` varchar(512) DEFAULT NULL,
  `run_user` varchar(64) DEFAULT NULL,
  `user_password` varchar(172) DEFAULT NULL,
  `agent_id` int NOT NULL DEFAULT '0',
  `agent_group_id` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`monitor_id`),
  UNIQUE KEY `monitor_name_lc` (`monitor_name_lc`,`monitor_type`),
  KEY `monitor_type` (`monitor_type`),
  CONSTRAINT `dpa_monitor_ibfk_1` FOREIGN KEY (`monitor_type`) REFERENCES `dpa_monitor_type` (`type_id`) ON DELETE CASCADE,
  CONSTRAINT `dpa_monitor_chk_1` CHECK ((`status` in (_utf8mb4'A',_utf8mb4'I'))),
  CONSTRAINT `dpa_monitor_chk_2` CHECK ((`monitor_name_lc` = lower(`monitor_name`)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_monitor`
--

LOCK TABLES `dpa_monitor` WRITE;
/*!40000 ALTER TABLE `dpa_monitor` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_monitor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_monitor_action`
--

DROP TABLE IF EXISTS `dpa_monitor_action`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_monitor_action` (
  `monitor_id` int NOT NULL,
  `action_type` int NOT NULL,
  `action_def` mediumblob,
  `last_run_time` bigint NOT NULL,
  `run_count` int NOT NULL DEFAULT '0',
  KEY `idx_dpa_monitor_action_mon` (`monitor_id`),
  CONSTRAINT `dpa_monitor_action_ibfk_1` FOREIGN KEY (`monitor_id`) REFERENCES `dpa_monitor` (`monitor_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_monitor_action`
--

LOCK TABLES `dpa_monitor_action` WRITE;
/*!40000 ALTER TABLE `dpa_monitor_action` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_monitor_action` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_monitor_def`
--

DROP TABLE IF EXISTS `dpa_monitor_def`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_monitor_def` (
  `monitor_id` int NOT NULL,
  `monitor_def` mediumblob,
  KEY `idx_dpa_monitor_def_mon` (`monitor_id`),
  CONSTRAINT `dpa_monitor_def_ibfk_1` FOREIGN KEY (`monitor_id`) REFERENCES `dpa_monitor` (`monitor_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_monitor_def`
--

LOCK TABLES `dpa_monitor_def` WRITE;
/*!40000 ALTER TABLE `dpa_monitor_def` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_monitor_def` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_monitor_type`
--

DROP TABLE IF EXISTS `dpa_monitor_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_monitor_type` (
  `type_id` int NOT NULL,
  `type_name` varchar(50) NOT NULL,
  `type_desc` varchar(256) NOT NULL,
  PRIMARY KEY (`type_id`),
  UNIQUE KEY `type_name` (`type_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_monitor_type`
--

LOCK TABLES `dpa_monitor_type` WRITE;
/*!40000 ALTER TABLE `dpa_monitor_type` DISABLE KEYS */;
INSERT INTO `dpa_monitor_type` VALUES (0,'File Monitor','This monitor will poll directories for new, modified and deleted files.'),(1,'FTP Monitor','This monitor will poll directories for new, modified and deleted files on an FTP server.'),(2,'FTPS Monitor','This monitor will poll directories for new, modified and deleted files on an FTPS server.'),(3,'SFTP Monitor','This monitor will poll directories for new, modified and deleted files on an SFTP server.');
/*!40000 ALTER TABLE `dpa_monitor_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_package`
--

DROP TABLE IF EXISTS `dpa_package`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_package` (
  `package_id` varchar(36) NOT NULL,
  `package_status` char(2) NOT NULL,
  `send_status` char(2) DEFAULT NULL,
  `from_address` varchar(128) DEFAULT NULL,
  `to_address_abbr` varchar(50) DEFAULT NULL,
  `subject` varchar(255) DEFAULT NULL,
  `protection_level` char(1) NOT NULL,
  `password_generation` char(1) NOT NULL DEFAULT 'S',
  `package_password` varchar(108) DEFAULT NULL,
  `send_password` char(1) NOT NULL DEFAULT '0',
  `max_downloads` int DEFAULT NULL,
  `expires_after_days` int DEFAULT NULL,
  `expires_on` datetime DEFAULT NULL,
  `send_copy` char(1) NOT NULL DEFAULT '0',
  `notify_when_read` char(1) NOT NULL DEFAULT '0',
  `package_size` bigint NOT NULL DEFAULT '0',
  `files_purged` char(1) NOT NULL DEFAULT '0',
  `created_by` varchar(64) DEFAULT NULL,
  `created_on` datetime NOT NULL,
  `modified_on` datetime NOT NULL,
  `sent_on` datetime DEFAULT NULL,
  `inactivated_on` datetime DEFAULT NULL,
  `enc_key` varchar(256) DEFAULT NULL,
  `reply_allowed` char(1) NOT NULL DEFAULT '0',
  `parent_package_id` varchar(36) DEFAULT NULL,
  `ran_before_triggers` char(1) NOT NULL DEFAULT '0',
  `denial_reason` varchar(256) DEFAULT NULL,
  `domain_id` int NOT NULL DEFAULT '1',
  `template_name` varchar(50) DEFAULT NULL,
  `package_type` char(1) NOT NULL DEFAULT 'S',
  `cc_address_abbr` varchar(50) DEFAULT NULL,
  `bcc_address_abbr` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`package_id`),
  KEY `idx_dpa_package_package_status` (`package_status`),
  KEY `idx_dpa_package_send_status` (`send_status`),
  KEY `idx_dpa_package_expires_on` (`expires_on`),
  KEY `idx_dpa_package_created_by` (`created_by`),
  KEY `idx_dpa_package_modified_on` (`modified_on`),
  KEY `idx_dpa_package_sent_on` (`sent_on`),
  KEY `idx_dpa_package_inactivated_on` (`inactivated_on`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_package`
--

LOCK TABLES `dpa_package` WRITE;
/*!40000 ALTER TABLE `dpa_package` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_package` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_package_bcc_address`
--

DROP TABLE IF EXISTS `dpa_package_bcc_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_package_bcc_address` (
  `package_id` varchar(36) NOT NULL,
  `bcc_address` mediumblob,
  KEY `idx_dpa_package_bcc_address_id` (`package_id`),
  CONSTRAINT `dpa_package_bcc_address_ibfk_1` FOREIGN KEY (`package_id`) REFERENCES `dpa_package` (`package_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_package_bcc_address`
--

LOCK TABLES `dpa_package_bcc_address` WRITE;
/*!40000 ALTER TABLE `dpa_package_bcc_address` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_package_bcc_address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_package_cc_address`
--

DROP TABLE IF EXISTS `dpa_package_cc_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_package_cc_address` (
  `package_id` varchar(36) NOT NULL,
  `cc_address` mediumblob,
  KEY `idx_dpa_package_cc_address_package_id` (`package_id`),
  CONSTRAINT `dpa_package_cc_address_ibfk_1` FOREIGN KEY (`package_id`) REFERENCES `dpa_package` (`package_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_package_cc_address`
--

LOCK TABLES `dpa_package_cc_address` WRITE;
/*!40000 ALTER TABLE `dpa_package_cc_address` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_package_cc_address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_package_file`
--

DROP TABLE IF EXISTS `dpa_package_file`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_package_file` (
  `file_id` int NOT NULL,
  `package_id` varchar(36) NOT NULL,
  `file_name` varchar(128) NOT NULL,
  `file_size` bigint NOT NULL,
  `created_on` datetime NOT NULL,
  `stubbed` char(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`file_id`),
  KEY `idx_dpa_package_file_file_name` (`file_name`),
  KEY `idx_dpa_package_file_package_id` (`package_id`),
  CONSTRAINT `dpa_package_file_ibfk_1` FOREIGN KEY (`package_id`) REFERENCES `dpa_package` (`package_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_package_file`
--

LOCK TABLES `dpa_package_file` WRITE;
/*!40000 ALTER TABLE `dpa_package_file` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_package_file` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_package_message`
--

DROP TABLE IF EXISTS `dpa_package_message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_package_message` (
  `package_id` varchar(36) NOT NULL,
  `message` mediumblob,
  KEY `idx_dpa_package_message_package_id` (`package_id`),
  CONSTRAINT `dpa_package_message_ibfk_1` FOREIGN KEY (`package_id`) REFERENCES `dpa_package` (`package_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_package_message`
--

LOCK TABLES `dpa_package_message` WRITE;
/*!40000 ALTER TABLE `dpa_package_message` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_package_message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_package_recipient`
--

DROP TABLE IF EXISTS `dpa_package_recipient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_package_recipient` (
  `recipient_id` varchar(36) NOT NULL,
  `email_address` varchar(128) NOT NULL,
  `recipient_name` varchar(128) DEFAULT NULL,
  `package_id` varchar(36) NOT NULL,
  `status` char(1) NOT NULL DEFAULT 'N',
  `send_attempts` int NOT NULL DEFAULT '0',
  `sent_on` datetime DEFAULT NULL,
  `read_notification_sent_on` datetime DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `inbox_status` char(1) NOT NULL DEFAULT 'U',
  `sms_phone` varchar(40) DEFAULT NULL,
  `recipient_type` char(1) NOT NULL DEFAULT 'T',
  PRIMARY KEY (`recipient_id`),
  KEY `idx_dpa_package_recipient_package_id` (`package_id`),
  CONSTRAINT `dpa_package_recipient_ibfk_1` FOREIGN KEY (`package_id`) REFERENCES `dpa_package` (`package_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_package_recipient`
--

LOCK TABLES `dpa_package_recipient` WRITE;
/*!40000 ALTER TABLE `dpa_package_recipient` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_package_recipient` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_package_recipient_fldwnld`
--

DROP TABLE IF EXISTS `dpa_package_recipient_fldwnld`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_package_recipient_fldwnld` (
  `recipient_id` varchar(36) NOT NULL,
  `file_id` int NOT NULL,
  `download_count` int NOT NULL DEFAULT '0',
  KEY `idx_dpa_package_recipient_fldwnld_recipient_id` (`recipient_id`),
  KEY `idx_dpa_package_recipient_fldwnld_file_id` (`file_id`),
  CONSTRAINT `dpa_package_recipient_fldwnld_ibfk_1` FOREIGN KEY (`recipient_id`) REFERENCES `dpa_package_recipient` (`recipient_id`),
  CONSTRAINT `dpa_package_recipient_fldwnld_ibfk_2` FOREIGN KEY (`file_id`) REFERENCES `dpa_package_file` (`file_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_package_recipient_fldwnld`
--

LOCK TABLES `dpa_package_recipient_fldwnld` WRITE;
/*!40000 ALTER TABLE `dpa_package_recipient_fldwnld` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_package_recipient_fldwnld` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_package_to_address`
--

DROP TABLE IF EXISTS `dpa_package_to_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_package_to_address` (
  `package_id` varchar(36) NOT NULL,
  `to_address` mediumblob,
  KEY `idx_dpa_package_to_address_package_id` (`package_id`),
  CONSTRAINT `dpa_package_to_address_ibfk_1` FOREIGN KEY (`package_id`) REFERENCES `dpa_package` (`package_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_package_to_address`
--

LOCK TABLES `dpa_package_to_address` WRITE;
/*!40000 ALTER TABLE `dpa_package_to_address` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_package_to_address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_partner`
--

DROP TABLE IF EXISTS `dpa_partner`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_partner` (
  `partner_id` int NOT NULL,
  `partner_name` varchar(64) NOT NULL,
  `partner_name_lc` varchar(64) NOT NULL,
  `description` varchar(512) DEFAULT NULL,
  `created_by` varchar(64) NOT NULL,
  `created_on` datetime NOT NULL,
  `modified_by` varchar(64) NOT NULL,
  `modified_on` datetime NOT NULL,
  PRIMARY KEY (`partner_id`),
  UNIQUE KEY `partner_name_lc` (`partner_name_lc`),
  CONSTRAINT `dpa_partner_chk_1` CHECK ((`partner_name_lc` = lower(`partner_name`)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_partner`
--

LOCK TABLES `dpa_partner` WRITE;
/*!40000 ALTER TABLE `dpa_partner` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_partner` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_partner_document`
--

DROP TABLE IF EXISTS `dpa_partner_document`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_partner_document` (
  `document_id` int NOT NULL,
  `partner_id` int NOT NULL,
  `document_name` varchar(128) NOT NULL,
  `document_name_lc` varchar(128) NOT NULL,
  `document_desc` varchar(512) DEFAULT NULL,
  `enabled` char(1) NOT NULL,
  `created_by` varchar(64) DEFAULT NULL,
  `created_on` datetime DEFAULT NULL,
  `modified_by` varchar(64) DEFAULT NULL,
  `modified_on` datetime DEFAULT NULL,
  `prod_test_indicator` char(1) NOT NULL,
  `usage_indicator` char(1) NOT NULL,
  `addon_uuid` varchar(38) NOT NULL,
  `gs_local_partner_id` varchar(15) DEFAULT NULL,
  `gs_remote_partner_id` varchar(15) DEFAULT NULL,
  `document_data` mediumblob,
  PRIMARY KEY (`document_id`),
  UNIQUE KEY `document_name_lc` (`document_name_lc`,`partner_id`),
  CONSTRAINT `dpa_partner_document_chk_1` CHECK ((`document_name_lc` = lower(`document_name`)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_partner_document`
--

LOCK TABLES `dpa_partner_document` WRITE;
/*!40000 ALTER TABLE `dpa_partner_document` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_partner_document` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_partner_domain`
--

DROP TABLE IF EXISTS `dpa_partner_domain`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_partner_domain` (
  `domain_id` int NOT NULL,
  `partner_id` int NOT NULL,
  PRIMARY KEY (`partner_id`,`domain_id`),
  KEY `domain_id` (`domain_id`),
  CONSTRAINT `dpa_partner_domain_ibfk_1` FOREIGN KEY (`domain_id`) REFERENCES `dpa_domain` (`domain_id`),
  CONSTRAINT `dpa_partner_domain_ibfk_2` FOREIGN KEY (`partner_id`) REFERENCES `dpa_partner` (`partner_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_partner_domain`
--

LOCK TABLES `dpa_partner_domain` WRITE;
/*!40000 ALTER TABLE `dpa_partner_domain` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_partner_domain` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_partner_metadata`
--

DROP TABLE IF EXISTS `dpa_partner_metadata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_partner_metadata` (
  `partner_id` int NOT NULL,
  `key_prefix` varchar(128) NOT NULL,
  `meta_data` mediumblob NOT NULL,
  KEY `partner_id` (`partner_id`),
  CONSTRAINT `dpa_partner_metadata_ibfk_1` FOREIGN KEY (`partner_id`) REFERENCES `dpa_partner` (`partner_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_partner_metadata`
--

LOCK TABLES `dpa_partner_metadata` WRITE;
/*!40000 ALTER TABLE `dpa_partner_metadata` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_partner_metadata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_pass_hist`
--

DROP TABLE IF EXISTS `dpa_pass_hist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_pass_hist` (
  `hist_id` int NOT NULL,
  `user_id` int NOT NULL,
  `pass_val` varchar(128) NOT NULL,
  `created_on` datetime NOT NULL,
  `pass_val_alg` int NOT NULL DEFAULT '-1',
  PRIMARY KEY (`hist_id`),
  KEY `idx_dpa_pass_hist` (`user_id`),
  CONSTRAINT `dpa_pass_hist_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `dpa_user` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_pass_hist`
--

LOCK TABLES `dpa_pass_hist` WRITE;
/*!40000 ALTER TABLE `dpa_pass_hist` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_pass_hist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_pesit_audit_log`
--

DROP TABLE IF EXISTS `dpa_pesit_audit_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_pesit_audit_log` (
  `event_id` bigint NOT NULL,
  `start_time` datetime NOT NULL,
  `end_time` datetime DEFAULT NULL,
  `severity` char(1) NOT NULL,
  `local_ip` varchar(40) DEFAULT NULL,
  `local_port` int DEFAULT NULL,
  `remote_ip` varchar(40) DEFAULT NULL,
  `remote_port` int DEFAULT NULL,
  `session_id` varchar(40) DEFAULT NULL,
  `user_name` varchar(64) DEFAULT NULL,
  `command` int DEFAULT NULL,
  `event_type` int DEFAULT NULL,
  `time_taken` bigint DEFAULT NULL,
  `file_path` varchar(256) DEFAULT NULL,
  `file_size` bigint DEFAULT NULL,
  `remarks` varchar(256) DEFAULT NULL,
  `system_name` varchar(20) DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `domain_id` int NOT NULL DEFAULT '1',
  `preconnect_id` varchar(20) DEFAULT NULL,
  `requester_id` varchar(24) DEFAULT NULL,
  `server_id` varchar(20) DEFAULT NULL,
  `transfer_id` int DEFAULT NULL,
  `application_name` varchar(20) DEFAULT NULL,
  `priority` char(1) DEFAULT NULL,
  `user_message` varchar(256) DEFAULT NULL,
  `max_message_length` int DEFAULT NULL,
  `data_encoding` char(1) DEFAULT NULL,
  `compression_type` char(1) DEFAULT NULL,
  `storage_unit` char(1) DEFAULT NULL,
  `record_format` char(1) DEFAULT NULL,
  `record_length` int DEFAULT NULL,
  `local_file_structure` varchar(2) DEFAULT NULL,
  `local_translation_table_id` varchar(50) DEFAULT NULL,
  `error_code` int DEFAULT NULL,
  `phase` varchar(50) DEFAULT NULL,
  `indexed` char(1) NOT NULL DEFAULT '0',
  `checksum` varchar(91) DEFAULT NULL,
  PRIMARY KEY (`event_id`),
  KEY `idx_dpa_pesit_audit_log` (`start_time` DESC),
  KEY `idx_dpa_pesit_audit_log_usr` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_pesit_audit_log`
--

LOCK TABLES `dpa_pesit_audit_log` WRITE;
/*!40000 ALTER TABLE `dpa_pesit_audit_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_pesit_audit_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_pesit_file_tmp`
--

DROP TABLE IF EXISTS `dpa_pesit_file_tmp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_pesit_file_tmp` (
  `tmp_id` int NOT NULL,
  `file_path` varchar(256) NOT NULL,
  `maximum_block_length` int NOT NULL,
  `record_length` int NOT NULL,
  `data_encoding_type` char(1) NOT NULL,
  `compression_type` char(1) NOT NULL,
  `storage_unit_type` char(1) NOT NULL,
  `record_format_type` char(1) NOT NULL,
  `file_structure_type` varchar(2) NOT NULL,
  `file_label` varchar(80) DEFAULT NULL,
  `free_text` varchar(254) DEFAULT NULL,
  `encoding_source` char(1) NOT NULL DEFAULT 'J',
  PRIMARY KEY (`tmp_id`),
  CONSTRAINT `dpa_pesit_file_tmp_ibfk_1` FOREIGN KEY (`tmp_id`) REFERENCES `dpa_pesit_tmp` (`tmp_id`) ON DELETE CASCADE,
  CONSTRAINT `dpa_pesit_file_tmp_chk_1` CHECK ((`encoding_source` in (_utf8mb4'J',_utf8mb4'F')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_pesit_file_tmp`
--

LOCK TABLES `dpa_pesit_file_tmp` WRITE;
/*!40000 ALTER TABLE `dpa_pesit_file_tmp` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_pesit_file_tmp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_pesit_identification`
--

DROP TABLE IF EXISTS `dpa_pesit_identification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_pesit_identification` (
  `identification_id` int NOT NULL,
  `server_id` varchar(24) NOT NULL,
  `server_id_lc` varchar(24) NOT NULL,
  PRIMARY KEY (`identification_id`),
  UNIQUE KEY `server_id_lc` (`server_id_lc`),
  CONSTRAINT `dpa_pesit_identification_chk_1` CHECK ((`server_id_lc` = lower(`server_id`)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_pesit_identification`
--

LOCK TABLES `dpa_pesit_identification` WRITE;
/*!40000 ALTER TABLE `dpa_pesit_identification` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_pesit_identification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_pesit_ptr`
--

DROP TABLE IF EXISTS `dpa_pesit_ptr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_pesit_ptr` (
  `partner_id` int NOT NULL,
  `user_id` int NOT NULL,
  `preconnect_id` varchar(8) DEFAULT NULL,
  `preconnect_password` varchar(128) DEFAULT NULL,
  `preconnect_pwd_alg` int NOT NULL,
  `requester_id` varchar(24) NOT NULL,
  `requester_password` varchar(128) DEFAULT NULL,
  `requester_pwd_alg` int NOT NULL,
  `restart_supported` char(1) NOT NULL DEFAULT '0',
  `sync_window` int NOT NULL,
  `sync_interval` int NOT NULL,
  `requester_id_lc` varchar(24) NOT NULL,
  PRIMARY KEY (`partner_id`),
  UNIQUE KEY `user_id` (`user_id`),
  UNIQUE KEY `requester_id_lc` (`requester_id_lc`),
  CONSTRAINT `dpa_pesit_ptr_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `dpa_web_user` (`user_id`) ON DELETE CASCADE,
  CONSTRAINT `dpa_pesit_ptr_chk_1` CHECK ((`requester_id_lc` = lower(`requester_id`)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_pesit_ptr`
--

LOCK TABLES `dpa_pesit_ptr` WRITE;
/*!40000 ALTER TABLE `dpa_pesit_ptr` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_pesit_ptr` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_pesit_tmp`
--

DROP TABLE IF EXISTS `dpa_pesit_tmp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_pesit_tmp` (
  `tmp_id` int NOT NULL,
  `tmp_name` varchar(14) NOT NULL,
  `tmp_name_lc` varchar(14) NOT NULL,
  `domain_id` int NOT NULL,
  `tmp_desc` varchar(512) DEFAULT NULL,
  `transfer_type` char(1) NOT NULL,
  `created_by` varchar(64) NOT NULL,
  `created_on` datetime NOT NULL,
  `modified_by` varchar(64) NOT NULL,
  `modified_on` datetime NOT NULL,
  PRIMARY KEY (`tmp_id`),
  UNIQUE KEY `tmp_name_lc` (`tmp_name_lc`,`domain_id`,`transfer_type`),
  CONSTRAINT `dpa_pesit_tmp_chk_1` CHECK ((`tmp_name_lc` = lower(`tmp_name`)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_pesit_tmp`
--

LOCK TABLES `dpa_pesit_tmp` WRITE;
/*!40000 ALTER TABLE `dpa_pesit_tmp` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_pesit_tmp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_pesit_tmp_ptr`
--

DROP TABLE IF EXISTS `dpa_pesit_tmp_ptr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_pesit_tmp_ptr` (
  `partner_id` int NOT NULL,
  `tmp_id` int NOT NULL,
  PRIMARY KEY (`partner_id`,`tmp_id`),
  KEY `tmp_id` (`tmp_id`),
  CONSTRAINT `dpa_pesit_tmp_ptr_ibfk_1` FOREIGN KEY (`partner_id`) REFERENCES `dpa_pesit_ptr` (`partner_id`) ON DELETE CASCADE,
  CONSTRAINT `dpa_pesit_tmp_ptr_ibfk_2` FOREIGN KEY (`tmp_id`) REFERENCES `dpa_pesit_tmp` (`tmp_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_pesit_tmp_ptr`
--

LOCK TABLES `dpa_pesit_tmp_ptr` WRITE;
/*!40000 ALTER TABLE `dpa_pesit_tmp_ptr` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_pesit_tmp_ptr` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_processed_edi_data`
--

DROP TABLE IF EXISTS `dpa_processed_edi_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_processed_edi_data` (
  `process_id` bigint NOT NULL,
  `partner_id` int NOT NULL,
  `interchange_control_num` int NOT NULL,
  `process_date` datetime NOT NULL,
  `interchange_date` datetime NOT NULL,
  `job_id` bigint NOT NULL,
  PRIMARY KEY (`process_id`),
  KEY `partner_id` (`partner_id`),
  KEY `idx_dpa_proccess_edi_ctrl_num` (`interchange_control_num`),
  CONSTRAINT `dpa_processed_edi_data_ibfk_1` FOREIGN KEY (`partner_id`) REFERENCES `dpa_partner` (`partner_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_processed_edi_data`
--

LOCK TABLES `dpa_processed_edi_data` WRITE;
/*!40000 ALTER TABLE `dpa_processed_edi_data` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_processed_edi_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_project`
--

DROP TABLE IF EXISTS `dpa_project`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_project` (
  `proj_id` int NOT NULL,
  `proj_name` varchar(200) NOT NULL,
  `proj_name_lc` varchar(200) NOT NULL,
  `proj_desc` varchar(512) DEFAULT NULL,
  `cat_id` int NOT NULL,
  `created_by` varchar(64) NOT NULL,
  `created_on` datetime NOT NULL,
  `modified_by` varchar(64) NOT NULL,
  `modified_on` datetime NOT NULL,
  `last_run_time` datetime DEFAULT NULL,
  `last_run_user` varchar(64) DEFAULT NULL,
  `domain_id` int NOT NULL DEFAULT '1',
  `agent_id` int NOT NULL DEFAULT '0',
  `agent_group_id` int NOT NULL DEFAULT '0',
  `project_data` mediumblob,
  PRIMARY KEY (`proj_id`),
  UNIQUE KEY `proj_name_lc` (`proj_name_lc`,`cat_id`),
  KEY `cat_id` (`cat_id`),
  CONSTRAINT `dpa_project_ibfk_1` FOREIGN KEY (`cat_id`) REFERENCES `dpa_category` (`cat_id`),
  CONSTRAINT `dpa_project_chk_1` CHECK ((`proj_name_lc` = lower(`proj_name`)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_project`
--

LOCK TABLES `dpa_project` WRITE;
/*!40000 ALTER TABLE `dpa_project` DISABLE KEYS */;
INSERT INTO `dpa_project` VALUES (101,'Test','test','A test project that prints current date and time to the job log',101,'system','2024-04-22 14:01:13','system','2024-04-22 14:01:13',NULL,NULL,1,0,0,NULL);
/*!40000 ALTER TABLE `dpa_project` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_queued_job`
--

DROP TABLE IF EXISTS `dpa_queued_job`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_queued_job` (
  `job_id` bigint NOT NULL,
  `proj_loc` varchar(512) NOT NULL,
  `run_user` varchar(64) NOT NULL,
  `user_password` varchar(172) DEFAULT NULL,
  `submit_time` datetime NOT NULL,
  `queue_priority` int NOT NULL DEFAULT '5',
  `run_priority` int NOT NULL DEFAULT '5',
  `job_type` char(1) NOT NULL DEFAULT 'J',
  `repeat_def` varchar(128) DEFAULT NULL,
  `end_time` bigint DEFAULT NULL,
  `next_run_time` bigint DEFAULT NULL,
  `system_name` varchar(20) DEFAULT NULL,
  `caller_job_id` bigint DEFAULT NULL,
  `caller_project_id` int DEFAULT NULL,
  `job_data` mediumblob,
  `success_emails` varchar(512) DEFAULT NULL,
  `success_attach_joblog` char(1) DEFAULT '0',
  `failure_emails` varchar(512) DEFAULT NULL,
  `failure_attach_joblog` char(1) DEFAULT '0',
  `job_queue_id` int NOT NULL DEFAULT '1',
  `job_queue_name` varchar(20) NOT NULL DEFAULT 'Default',
  `job_queue_priority` int NOT NULL DEFAULT '5',
  `job_name` varchar(200) DEFAULT NULL,
  `submit_src` char(1) NOT NULL DEFAULT '0',
  `submit_src_id` int NOT NULL DEFAULT '-1',
  `submit_src_name` varchar(64) DEFAULT NULL,
  `domain_id` int NOT NULL DEFAULT '1',
  `agent_id` int NOT NULL DEFAULT '0',
  `agent_group_id` int NOT NULL DEFAULT '0',
  `execution_id` bigint DEFAULT '0',
  `mac` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`job_id`),
  KEY `idx_dpa_queued_job_perf` (`job_queue_id`,`job_queue_priority` DESC,`queue_priority` DESC,`submit_time` DESC),
  KEY `idx_dpa_queued_job_job_queue` (`job_type`,`job_queue_id`,`agent_id`,`agent_group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_queued_job`
--

LOCK TABLES `dpa_queued_job` WRITE;
/*!40000 ALTER TABLE `dpa_queued_job` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_queued_job` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_registration_rule`
--

DROP TABLE IF EXISTS `dpa_registration_rule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_registration_rule` (
  `rule_order` int NOT NULL,
  `rule_domain` varchar(128) NOT NULL,
  `allowed` char(1) NOT NULL DEFAULT '1',
  `template_id` int DEFAULT NULL,
  `requires_approval` char(1) NOT NULL DEFAULT '1',
  `notify_managers` char(1) NOT NULL DEFAULT '1',
  `sys_rule` char(1) NOT NULL DEFAULT '0',
  `email_as_user_name` char(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`rule_domain`),
  KEY `template_id` (`template_id`),
  CONSTRAINT `dpa_registration_rule_ibfk_1` FOREIGN KEY (`template_id`) REFERENCES `dpa_web_user_template` (`template_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_registration_rule`
--

LOCK TABLES `dpa_registration_rule` WRITE;
/*!40000 ALTER TABLE `dpa_registration_rule` DISABLE KEYS */;
INSERT INTO `dpa_registration_rule` VALUES (1,'*','0',NULL,'1','1','1','0');
/*!40000 ALTER TABLE `dpa_registration_rule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_res_obj`
--

DROP TABLE IF EXISTS `dpa_res_obj`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_res_obj` (
  `res_id` int NOT NULL,
  `res_obj` mediumblob,
  PRIMARY KEY (`res_id`),
  CONSTRAINT `dpa_res_obj_ibfk_1` FOREIGN KEY (`res_id`) REFERENCES `dpa_resource` (`res_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_res_obj`
--

LOCK TABLES `dpa_res_obj` WRITE;
/*!40000 ALTER TABLE `dpa_res_obj` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_res_obj` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_res_type`
--

DROP TABLE IF EXISTS `dpa_res_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_res_type` (
  `type_code` varchar(20) NOT NULL,
  `type_name` varchar(50) NOT NULL,
  `type_desc` varchar(255) DEFAULT NULL,
  `display_order` int NOT NULL,
  `bean_class` varchar(512) NOT NULL,
  `small_icon` varchar(255) DEFAULT NULL,
  `large_icon` varchar(255) DEFAULT NULL,
  `agent_type` char(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`type_code`),
  UNIQUE KEY `type_name` (`type_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_res_type`
--

LOCK TABLES `dpa_res_type` WRITE;
/*!40000 ALTER TABLE `dpa_res_type` DISABLE KEYS */;
INSERT INTO `dpa_res_type` VALUES ('as2','AS2 Servers','AS2 Servers',160,'com.linoma.ga.projects.resources.AS2Resource','/images/resources/small/as2.gif',NULL,'0'),('as3','AS3 Partners','AS3 Partners',163,'com.linoma.ga.projects.resources.AS3Resource','/images/resources/small/as2.gif',NULL,'0'),('as4','AS4 Servers','AS4 Servers',165,'com.linoma.ga.projects.resources.AS4Resource','/images/resources/small/as2.gif',NULL,'0'),('as400','IBM i Servers','IBM i (iSeries) Servers',950,'com.linoma.ga.projects.resources.AS400Resource','/images/resources/small/as400.png',NULL,'0'),('azureblob','Azure Blob Storage','Azure Blob Storage',170,'com.linoma.ga.projects.resources.AzureResource','/images/resources/small/azure.png',NULL,'1'),('cc','Cloud Connectors','Cloud Connectors',290,'com.linoma.ga.projects.resources.CloudConnectorResource','/images/resources/small/cloud.png',NULL,'0'),('database','Database Servers','Database Servers',410,'com.linoma.ga.projects.resources.DatabaseResource','/images/resources/small/database.gif',NULL,'1'),('filecatalystServer','FileCatalyst Servers','FileCatalyst Servers',640,'com.linoma.ga.projects.resources.FileCatalystServerResource','/images/resources/small/fc_server.png',NULL,'1'),('ftp','FTP Servers','FTP Servers',650,'com.linoma.ga.projects.resources.FTPResource','/images/resources/small/ftp.png',NULL,'1'),('ftps','FTPS Servers','FTPS (FTP over SSL) Servers',660,'com.linoma.ga.projects.resources.FTPSResource','/images/resources/small/ftps.png',NULL,'1'),('gadirector','GoAnywhere MFT Servers','GoAnywhere MFT Servers',750,'com.linoma.ga.projects.resources.GADirectorResource','/images/resources/small/gadirector.svg',NULL,'0'),('ghttps','GoAnywhere HTTPS Servers','GoAnywhere HTTPS Servers',740,'com.linoma.ga.projects.resources.GHTTPSResource','/images/resources/small/ghttps.gif',NULL,'0'),('gofast','GoFast Servers','GoFast Servers',760,'com.linoma.ga.projects.resources.GoFastResource','/images/resources/small/gofast.png',NULL,'1'),('http','HTTP Servers','HTTP Servers',850,'com.linoma.ga.projects.resources.HTTPResource','/images/resources/small/http.gif',NULL,'0'),('https','HTTPS Servers','HTTPS (HTTP over SSL) Servers',860,'com.linoma.ga.projects.resources.HTTPSResource','/images/resources/small/https.gif',NULL,'0'),('icap','ICAP Servers','ICAP Servers',960,'com.linoma.ga.projects.resources.ICAPResource','/images/resources/small/icap.png',NULL,'0'),('mailbox','Mail Boxes','Mail Boxes',1350,'com.linoma.ga.projects.resources.MailBoxResource','/images/resources/small/mailbox.png',NULL,'1'),('mq','MQ Servers','MQ (Messaging) Servers',1360,'com.linoma.ga.projects.resources.MQResource','/images/resources/small/mq.png',NULL,'0'),('pesit','PeSIT Servers','PeSIT Servers',1500,'com.linoma.ga.projects.resources.PeSITResource','/images/resources/small/pesit.png',NULL,'0'),('pgpKeyRing','PGP Key Rings','PGP Public/Secret Key Rings',1550,'com.linoma.ga.projects.resources.PGPKeyRingResource','/images/resources/small/pgpkeyring.gif',NULL,'0'),('rest','REST Servers','REST Servers',1850,'com.linoma.ga.projects.resources.RESTResource','/images/resources/small/rest.png',NULL,'1'),('s3','Amazon S3','Amazon S3',150,'com.linoma.ga.projects.resources.AmazonS3Resource','/images/resources/small/s3.png',NULL,'1'),('smb','Network Shares(SMB/CIFS)','Network Shares (SMB/CIFS)',1450,'com.linoma.ga.projects.resources.SMBResource','/images/resources/small/smb.png',NULL,'1'),('smtp','SMTP Servers','SMTP Servers',1950,'com.linoma.ga.projects.resources.SMTPResource','/images/resources/small/smtp.gif',NULL,'1'),('snmp','SNMP Servers','SNMP Servers',1960,'com.linoma.ga.projects.resources.SNMPResource','/images/resources/small/snmp.png',NULL,'0'),('soap','SOAP Servers','SOAP Servers',1960,'com.linoma.ga.projects.resources.SOAPResource','/images/resources/small/soap.png',NULL,'1'),('ssh','SFTP/SCP/SSH Servers','SFTP(FTP Over SSH), SCP(Secure Copy Protocol) and SSH Servers',1970,'com.linoma.ga.projects.resources.SSHResource','/images/resources/small/sftp.png',NULL,'1'),('webdav','WebDAV','WebDAV',2350,'com.linoma.ga.projects.resources.WebDAVResource','/images/resources/small/webdav.png',NULL,'1');
/*!40000 ALTER TABLE `dpa_res_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_resource`
--

DROP TABLE IF EXISTS `dpa_resource`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_resource` (
  `res_id` int NOT NULL,
  `res_type` varchar(20) NOT NULL,
  `res_name` varchar(50) NOT NULL,
  `res_name_lc` varchar(50) NOT NULL,
  `res_desc` varchar(255) DEFAULT NULL,
  `created_by` varchar(64) NOT NULL,
  `created_on` datetime NOT NULL,
  `modified_by` varchar(64) NOT NULL,
  `modified_on` datetime NOT NULL,
  `domain_id` int NOT NULL DEFAULT '1',
  `agent_id` int NOT NULL DEFAULT '0',
  `agent_group_id` int NOT NULL DEFAULT '0',
  `res_addon_uuid` varchar(38) DEFAULT NULL,
  PRIMARY KEY (`res_id`),
  UNIQUE KEY `res_type` (`res_type`,`res_name_lc`),
  CONSTRAINT `dpa_resource_ibfk_1` FOREIGN KEY (`res_type`) REFERENCES `dpa_res_type` (`type_code`),
  CONSTRAINT `dpa_resource_chk_1` CHECK ((`res_name_lc` = lower(`res_name`)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_resource`
--

LOCK TABLES `dpa_resource` WRITE;
/*!40000 ALTER TABLE `dpa_resource` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_resource` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_role`
--

DROP TABLE IF EXISTS `dpa_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_role` (
  `role_id` int NOT NULL,
  `role_name` varchar(50) NOT NULL,
  `role_desc` varchar(512) DEFAULT NULL,
  `created_by` varchar(64) NOT NULL,
  `created_on` datetime NOT NULL,
  `modified_by` varchar(64) NOT NULL,
  `modified_on` datetime NOT NULL,
  `iam_policy` mediumblob,
  `role_type` int NOT NULL DEFAULT '0',
  `object_id` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`role_id`),
  UNIQUE KEY `role_name` (`role_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_role`
--

LOCK TABLES `dpa_role` WRITE;
/*!40000 ALTER TABLE `dpa_role` DISABLE KEYS */;
INSERT INTO `dpa_role` VALUES (101,'Product Administrator','Admin users with this role can perform product administration tasks such as setting the global preferences, applying product updates and fixes, installing/updating product license and more','system','2024-04-22 14:01:11','system','2024-04-22 14:01:11',_binary '{\r\n  \"Statement\": [\r\n    {\r\n      \"Sid\": \"Allowed Permissions Statement\",\r\n      \"Effect\": \"Allow\",\r\n      \"Action\": [\r\n        \"softwareLibrary:*\",\r\n        \"webClientBrands:*\",\r\n        \"customTasks:*\",\r\n        \"encryptedFolders:*\",\r\n        \"keyVaults:manageSystem\",\r\n        \"logSettings:*\",\r\n        \"reports:generate\",\r\n        \"license:*\",\r\n        \"gatewayManager:*\",\r\n        \"clusterManager:*\",\r\n        \"addons:*\",\r\n        \"checkForUpdates:*\",\r\n        \"adminServer:*\",\r\n        \"jdbcWizard:*\",\r\n        \"goDriveSettings:*\",\r\n        \"activeTransfers:*\",\r\n        \"masterEncryptionKeys:*\",\r\n        \"globalSettings:*\",\r\n        \"queues:*\",\r\n        \"logExemptions:*\",\r\n        \"reports:generateProductUsage\",\r\n        \"systemAlerts:*\",\r\n        \"activeSessions:*\",\r\n        \"systemLogs:*\",\r\n        \"databaseConfiguration:*\",\r\n        \"adminLogs:view\",\r\n        \"services:*\",\r\n        \"diagnostics:*\",\r\n        \"messageChannels:*\",\r\n        \"pesitFileTemplates:*\",\r\n        \"icapSettings:*\",\r\n        \"hs1:*\"\r\n      ],\r\n      \"Object\": [\r\n        \"gon:mft::queues::*\",\r\n        \"gon:mft::services::*\",\r\n        \"gon:mft::webClientBrands::*\",\r\n        \"gon:mft::gatewayManager::*\",\r\n        \"gon:mft::goDriveSettings::*\",\r\n        \"gon:mft::reports::*\",\r\n        \"gon:mft::systemLogs::*\",\r\n        \"gon:mft::logSettings::*\",\r\n        \"gon:mft::logExemptions::*\",\r\n        \"gon:mft::encryptedFolders::*\",\r\n        \"gon:mft::globalSettings::*\",\r\n        \"gon:mft::adminServer::*\",\r\n        \"gon:mft::databaseConfiguration::*\",\r\n        \"gon:mft::clusterManager::*\",\r\n        \"gon:mft::customTasks::*\",\r\n        \"gon:mft::addons::*\",\r\n        \"gon:mft::systemAlerts::*\",\r\n        \"gon:mft::activeSessions::*\",\r\n        \"gon:mft::activeTransfers::*\",\r\n        \"gon:mft::jdbcWizard::*\",\r\n        \"gon:mft::checkForUpdates::*\",\r\n        \"gon:mft::license::*\",\r\n        \"gon:mft::diagnostics::*\",\r\n        \"gon:mft::softwareLibrary::*\",\r\n        \"gon:mft::adminLogs::*\",\r\n        \"gon:mft::masterEncryptionKeys::*\",\r\n        \"gon:mft::keyVaults::*\",\r\n        \"gon:mft::messageChannels::*\",\r\n        \"gon:mft::pesitFileTemplates::*\",\r\n        \"gon:mft::icapSettings::*\",\r\n        \"gon:mft::hs1::*\"\r\n      ],\r\n      \"Domain\": [\r\n        \"*\"\r\n      ]\r\n    }\r\n  ]\r\n}',0,0),(102,'Security Officer','Admin users with this role are allowed to create users, groups and assigning them roles and object authorities','system','2024-04-22 14:01:11','system','2024-04-22 14:01:11',_binary '{\r\n  \"Statement\": [\r\n    {\r\n      \"Sid\": \"Allowed Permissions Statement\",\r\n      \"Effect\": \"Allow\",\r\n      \"Action\": [\r\n        \"loginMethods:*\",\r\n        \"users:*\",\r\n        \"reports:generateSecurityAudit\",\r\n        \"reports:generate\",\r\n        \"userTemplates:*\",\r\n        \"userGroups:*\",\r\n        \"webUserSecuritySettings:*\",\r\n        \"adminSecuritySettings:*\",\r\n        \"agentTemplates:*\",\r\n        \"agentGroups:*\",\r\n        \"ipFilters:*\",\r\n        \"autoIPBlacklist:*\",\r\n        \"masterEncryptionKeys:*\",\r\n        \"agents:*\",\r\n        \"userRoles:*\",\r\n        \"adminLogs:view\",\r\n        \"loginSettings:*\",\r\n        \"domains:*\",\r\n        \"webUserSelfRegistrationSettings:*\",\r\n        \"globalSecuritySettings:*\",\r\n        \"projectCategories:managePermissions\",\r\n        \"resources:managePermissions\",\r\n        \"resources:list\",\r\n        \"projectCategories:list\",\r\n        \"adminUserApiKeys:*\"\r\n      ],\r\n      \"Object\": [\r\n        \"gon:mft::resources:*\",\r\n        \"gon:mft::projectCategories::*\",\r\n        \"gon:mft::projects:*:*\",\r\n        \"gon:mft::agentGroups::*\",\r\n        \"gon:mft::agentTemplates::*\",\r\n        \"gon:mft::agents::*\",\r\n        \"gon:mft::users::*\",\r\n        \"gon:mft::userGroups::*\",\r\n        \"gon:mft::userTemplates::*\",\r\n        \"gon:mft::userRoles::*\",\r\n        \"gon:mft::adminSecuritySettings::*\",\r\n        \"gon:mft::webUserSecuritySettings::*\",\r\n        \"gon:mft::webUserSelfRegistrationSettings::*\",\r\n        \"gon:mft::domains::*\",\r\n        \"gon:mft::loginSettings::*\",\r\n        \"gon:mft::loginMethods::*\",\r\n        \"gon:mft::reports::*\",\r\n        \"gon:mft::globalSecuritySettings::*\",\r\n        \"gon:mft::ipFilters::*\",\r\n        \"gon:mft::autoIPBlacklist::*\",\r\n        \"gon:mft::masterEncryptionKeys::*\",\r\n        \"gon:mft::adminLogs::*\",\r\n        \"gon:mft::adminUserApiKeys::*\"\r\n      ],\r\n      \"Domain\": [\r\n        \"*\"\r\n      ]\r\n    }\r\n  ]\r\n}',0,0),(103,'Web User Manager','Admin users with this role can manage Web Users and Web User Groups','system','2024-04-22 14:01:11','system','2024-04-22 14:01:11',_binary '{\r\n  \"Statement\": [\r\n    {\r\n      \"Sid\": \"Allowed Permissions Statement\",\r\n      \"Effect\": \"Allow\",\r\n      \"Action\": [\r\n        \"reports:generate\",\r\n        \"ftpLogs:*\",\r\n        \"ftpsLogs:*\",\r\n        \"webuserGroups:*\",\r\n        \"adminLogs:view\",\r\n        \"webusers:*\",\r\n        \"httpsLogs:*\",\r\n        \"as2Logs:*\",\r\n        \"as4Logs:*\",\r\n        \"godriveLogs:*\",\r\n        \"gofastLogs:*\",\r\n		\"pesitLogs:*\",\r\n        \"webuserTemplates:*\",\r\n        \"sftpLogs:*\",\r\n        \"addressBooks:*\"\r\n      ],\r\n      \"Object\": [\r\n        \"gon:mft::webusers::*\",\r\n        \"gon:mft::webuserGroups::*\",\r\n        \"gon:mft::webuserTemplates::*\",\r\n        \"gon:mft::reports::*\",\r\n        \"gon:mft::as2Logs::*\",\r\n        \"gon:mft::as4Logs::*\",\r\n        \"gon:mft::ftpLogs::*\",\r\n        \"gon:mft::ftpsLogs::*\",\r\n        \"gon:mft::gofastLogs::*\",\r\n        \"gon:mft::godriveLogs::*\",\r\n        \"gon:mft::sftpLogs::*\",\r\n        \"gon:mft::httpsLogs::*\",\r\n        \"gon:mft::adminLogs::*\",\r\n        \"gon:mft::addressBooks::*\",\r\n        \"gon:mft::pesitLogs::*\"\r\n      ],\r\n      \"Domain\": [\r\n        \"*\"\r\n      ]\r\n    }\r\n  ]\r\n}',0,0),(104,'Key Manager','Admin users with this role can manage various types of encryption keys such as SSH and x509','system','2024-04-22 14:01:11','system','2024-04-22 14:01:11',_binary '{\r\n  \"Statement\":\r\n    {\r\n      \"Sid\": \"Allowed Permissions Statement\",\r\n      \"Effect\": \"Allow\",\r\n      \"Action\": [\r\n        \"keyVaults:manageKeyVaults\",\r\n        \"keyVaults:create\",\r\n        \"keyVaults:edit\",\r\n        \"keyVaults:delete\",\r\n        \"keyVaults:view\",\r\n        \"reports:generate\",\r\n        \"fileBasedKeys:*\"\r\n      ],\r\n      \"Object\": [\r\n        \"gon:mft::reports::*\",\r\n        \"gon:mft::fileBasedKeys::*\",\r\n        \"gon:mft::keyVaults::*\"\r\n      ],\r\n      \"Domain\": [\r\n        \"*\"\r\n      ]\r\n    }\r\n}\r\n',0,0),(105,'File Manager','Admin users with this role can manage (e.g. download, copy, delete, upload) files on the GoAnywhere server','system','2024-04-22 14:01:11','system','2024-04-22 14:01:11',_binary '{\r\n  \"Statement\": [\r\n    {\r\n      \"Sid\": \"Allowed Permissions Statement\",\r\n      \"Effect\": \"Allow\",\r\n      \"Action\": [\r\n        \"reports:generate\",\r\n        \"fileManager:*\"\r\n      ],\r\n      \"Object\": [\r\n        \"gon:mft::reports::*\",\r\n        \"gon:mft::fileManager::*\"\r\n      ],\r\n      \"Domain\": [\r\n        \"*\"\r\n      ]\r\n    }\r\n  ]\r\n}\r\n',0,0),(106,'Trigger Manager','Admin users with this role can manage Triggers and Actions that are executed during events','system','2024-04-22 14:01:11','system','2024-04-22 14:01:11',_binary '{\r\n  \"Statement\": [\r\n    {\r\n      \"Sid\": \"Allowed Permissions Statement\",\r\n      \"Effect\": \"Allow\",\r\n      \"Action\": [\r\n        \"triggerLogs:*\",\r\n        \"reports:generate\",\r\n        \"adminLogs:view\",\r\n        \"triggers:*\"\r\n      ],\r\n      \"Object\": [\r\n        \"gon:mft::triggers::*\",\r\n        \"gon:mft::triggerLogs::*\",\r\n        \"gon:mft::reports::*\",\r\n        \"gon:mft::adminLogs::*\"\r\n      ],\r\n      \"Domain\": [\r\n        \"*\"\r\n      ]\r\n    }\r\n  ]\r\n}',0,0),(107,'Log Viewer','Admin users with this role can access the audit logs','system','2024-04-22 14:01:11','system','2024-04-22 14:01:11',_binary '{\r\n  \"Statement\": [\r\n    {\r\n      \"Sid\": \"Allowed Permissions Statement\",\r\n      \"Effect\": \"Allow\",\r\n      \"Action\": [\r\n        \"triggerLogs:*\",\r\n        \"ftpLogs:*\",\r\n        \"ftpsLogs:*\",\r\n        \"gofastLogs:*\",\r\n        \"jobs:view\",\r\n        \"jobs:manageAllJobs\",\r\n        \"sftpLogs:*\",\r\n        \"reports:generate\",\r\n        \"adminLogs:view\",\r\n        \"adminLogs:all\",\r\n        \"httpsLogs:*\",\r\n        \"as2Logs:*\",\r\n        \"as4Logs:*\",\r\n        \"godriveLogs:*\",\r\n		\"pesitLogs:*\",\r\n		\"antivirusLogs:*\",\r\n        \"serviceLevelAgreementLogs:*\"\r\n      ],\r\n      \"Object\": [\r\n        \"gon:mft::jobs::*\",\r\n        \"gon:mft::reports::*\",\r\n        \"gon:mft::as2Logs::*\",\r\n        \"gon:mft::as4Logs::*\",\r\n        \"gon:mft::httpsLogs::*\",\r\n        \"gon:mft::ftpLogs::*\",\r\n        \"gon:mft::ftpsLogs::*\",\r\n        \"gon:mft::godriveLogs::*\",\r\n        \"gon:mft::sftpLogs::*\",\r\n        \"gon:mft::triggerLogs::*\",\r\n        \"gon:mft::serviceLevelAgreementLogs::*\",\r\n        \"gon:mft::gofastLogs::*\",\r\n        \"gon:mft::adminLogs::*\",\r\n        \"gon:mft::pesitLogs::*\",\r\n        \"gon:mft::antivirusLogs::*\"\r\n      ],\r\n      \"Domain\": [\r\n        \"*\"\r\n      ]\r\n    }\r\n  ]\r\n}',0,0),(108,'Secure Mail Manager','Admin users with this role can manage packages and Secure Mail settings','system','2024-04-22 14:01:11','system','2024-04-22 14:01:11',_binary '{\r\n  \"Statement\": [\r\n    {\r\n      \"Sid\": \"Allowed Permissions Statement\",\r\n      \"Effect\": \"Allow\",\r\n      \"Action\": [\r\n        \"secureMail:*\",\r\n        \"reports:generate\",\r\n        \"adminLogs:view\",\r\n        \"securemailSettings:*\"\r\n      ],\r\n      \"Object\": [\r\n        \"gon:mft::secureMail::*\",\r\n        \"gon:mft::securemailSettings::*\",\r\n        \"gon:mft::reports::*\",\r\n        \"gon:mft::adminLogs::*\"\r\n      ],\r\n      \"Domain\": [\r\n        \"*\"\r\n      ]\r\n    }\r\n  ]\r\n}',0,0),(109,'Resource Manager','Admin users with this role can manage resources such as FTP, SFTP, Databases, and Network Shares','system','2024-04-22 14:01:11','system','2024-04-22 14:01:11',_binary '{\r\n  \"Statement\": [\r\n    {\r\n      \"Sid\": \"Allowed Permissions Statement\",\r\n      \"Effect\": \"Allow\",\r\n      \"Action\": [\r\n        \"resources:list\",\r\n        \"resources:create\",\r\n        \"resources:manage\",\r\n        \"reports:generate\",\r\n        \"encryptionTool:*\",\r\n        \"jdbcWizard:*\",\r\n        \"sqlWizard:*\"\r\n      ],\r\n      \"Object\": [\r\n        \"gon:mft::resources:*\",\r\n        \"gon:mft::reports::*\",\r\n        \"gon:mft::encryptionTool::*\",\r\n        \"gon:mft::sqlWizard::*\",\r\n        \"gon:mft::jdbcWizard::*\"\r\n      ],\r\n      \"Domain\": [\r\n        \"*\"\r\n      ]\r\n    }\r\n  ]\r\n}',0,0),(110,'Web User Device Manager','Admin users with this role can manage Web User devices','system','2024-04-22 14:01:11','system','2024-04-22 14:01:11',_binary '{\r\n  \"Statement\": [\r\n    {\r\n      \"Sid\": \"Allowed Permissions Statement\",\r\n      \"Effect\": \"Allow\",\r\n      \"Action\": [\r\n        \"reports:generate\",\r\n        \"adminLogs:view\",\r\n        \"webUserDevices:*\"\r\n      ],\r\n      \"Object\": [\r\n        \"gon:mft::webUserDevices::*\",\r\n        \"gon:mft::reports::*\",\r\n        \"gon:mft::adminLogs::*\"\r\n      ],\r\n      \"Domain\": [\r\n        \"*\"\r\n      ]\r\n    }\r\n  ]\r\n}',0,0),(111,'Project Designer','Admin users in this role can create, edit and delete projects','system','2024-04-22 14:01:11','system','2024-04-22 14:01:11',_binary '{\r\n  \"Statement\": [\r\n    {\r\n      \"Sid\": \"Allowed Permissions Statement\",\r\n      \"Effect\": \"Allow\",\r\n      \"Action\": [\r\n        \"projectCategories:list\",\r\n        \"projectCategories:manage\",\r\n        \"reports:generate\",\r\n        \"jdbcWizard:*\",\r\n        \"sqlWizard:*\",\r\n        \"encryptionTool:use\"\r\n      ],\r\n      \"Object\": [\r\n        \"gon:mft::projectCategories::*\",\r\n        \"gon:mft::projects:*:*\",\r\n        \"gon:mft::reports::*\",\r\n        \"gon:mft::encryptionTool::*\",\r\n        \"gon:mft::sqlWizard::*\",\r\n        \"gon:mft::jdbcWizard::*\"\r\n      ],\r\n      \"Domain\": [\r\n        \"*\"\r\n      ]\r\n    }\r\n  ]\r\n}',0,0),(112,'Job Manager','Admin users in this role can monitor all active jobs, cancel jobs, pause/resume jobs and view/delete completed jobs','system','2024-04-22 14:01:11','system','2024-04-22 14:01:11',_binary '{\r\n  \"Statement\": [\r\n    {\r\n      \"Sid\": \"Allowed Permissions Statement\",\r\n      \"Effect\": \"Allow\",\r\n      \"Action\": [\r\n        \"activeTransfers:*\",\r\n        \"queues:edit\",\r\n        \"jobs:view\",\r\n        \"monitors:*\",\r\n        \"jobs:export\",\r\n        \"jobs:manageAllJobs\",\r\n        \"queues:manage\",\r\n        \"reports:generate\",\r\n        \"schedules:*\",\r\n        \"adminLogs:view\",\r\n        \"queues:view\",\r\n        \"jobs:jobResolution\",\r\n        \"holidayCalendars:*\",\r\n        \"jobs:manage\"\r\n      ],\r\n      \"Object\": [\r\n        \"gon:mft::schedules::*\",\r\n        \"gon:mft::queues::*\",\r\n        \"gon:mft::jobs::*\",\r\n        \"gon:mft::reports::*\",\r\n        \"gon:mft::activeTransfers::*\",\r\n        \"gon:mft::adminLogs::*\",\r\n        \"gon:mft::monitors::*\",\r\n        \"gon:mft::holidayCalendars::*\"\r\n      ],\r\n      \"Domain\": [\r\n        \"*\"\r\n      ]\r\n    }\r\n  ]\r\n}',0,0),(113,'Project Executor','Admin users in this role can execute projects and view jobs they submitted','system','2024-04-22 14:01:11','system','2024-04-22 14:01:11',_binary '{\r\n  \"Statement\": [\r\n    {\r\n      \"Sid\": \"Allowed Permissions Statement\",\r\n      \"Effect\": \"Allow\",\r\n      \"Action\": [\r\n        \"jobs:view\",\r\n        \"projectCategories:executeProjects\",\r\n        \"projectCategories:list\",\r\n        \"jobs:export\",\r\n        \"reports:generate\",\r\n        \"jobs:jobResolution\",\r\n        \"jobs:manage\"\r\n      ],\r\n      \"Object\": [\r\n        \"gon:mft::projectCategories::*\",\r\n        \"gon:mft::projects:*:*\",\r\n        \"gon:mft::jobs::*\",\r\n        \"gon:mft::reports::*\"\r\n      ],\r\n      \"Domain\": [\r\n        \"*\"\r\n      ]\r\n    }\r\n  ]\r\n}',0,0),(114,'Dashboard Manager','Admin users in this role can manage shared dashboards','system','2024-04-22 14:01:11','system','2024-04-22 14:01:11',_binary '{\r\n  \"Statement\": [\r\n    {\r\n      \"Sid\": \"Allowed Permissions Statement\",\r\n      \"Effect\": \"Allow\",\r\n      \"Action\": [\r\n        \"reports:generate\",\r\n        \"dashboards:*\"\r\n      ],\r\n      \"Object\": [\r\n        \"gon:mft::dashboards::*\",\r\n        \"gon:mft::reports::*\"\r\n      ],\r\n      \"Domain\": [\r\n        \"*\"\r\n      ]\r\n    }\r\n  ]\r\n}',0,0),(115,'Secure Forms Manager','Admin users in this role can manage Secure Forms','system','2024-04-22 14:01:11','system','2024-04-22 14:01:11',_binary '{\r\n  \"Statement\": [\r\n    {\r\n      \"Sid\": \"Allowed Permissions Statement\",\r\n      \"Effect\": \"Allow\",\r\n      \"Action\": [\r\n        \"reports:generate\",\r\n        \"secureForms:*\",\r\n        \"adminLogs:view\",\r\n        \"secureFormSettings:*\"\r\n      ],\r\n      \"Object\": [\r\n        \"gon:mft::secureForms::*\",\r\n        \"gon:mft::secureFormSettings::*\",\r\n        \"gon:mft::reports::*\",\r\n        \"gon:mft::adminLogs::*\"\r\n      ],\r\n      \"Domain\": [\r\n        \"*\"\r\n      ]\r\n    }\r\n  ]\r\n}',0,0),(116,'Agent Manager','Admin users in this role can manage Agents','system','2024-04-22 14:01:11','system','2024-04-22 14:01:11',_binary '{\r\n  \"Statement\": [\r\n    {\r\n      \"Sid\": \"Allowed Permissions Statement\",\r\n      \"Effect\": \"Allow\",\r\n      \"Action\": [\r\n        \"reports:generate\",\r\n        \"agentTemplates:create\",\r\n        \"agentTemplates:edit\",\r\n        \"agentTemplates:view\",\r\n        \"agentTemplates:delete\",\r\n        \"agentGroups:create\",\r\n        \"agentGroups:manage\",\r\n        \"agentGroups:delete\",\r\n        \"agents:create\",\r\n        \"agents:manage\",\r\n        \"agents:delete\"\r\n      ],\r\n      \"Object\": [\r\n        \"gon:mft::agents::*\",\r\n        \"gon:mft::agentGroups::*\",\r\n        \"gon:mft::agentTemplates::*\",\r\n        \"gon:mft::reports::*\"\r\n      ],\r\n      \"Domain\": [\r\n        \"*\"\r\n      ]\r\n    }\r\n  ]\r\n}',0,0),(117,'SLA Manager','Admin users in this role can manage Service Level Agreements','system','2024-04-22 14:01:11','system','2024-04-22 14:01:11',_binary '{  \r\n   \"Statement\":[  \r\n      {  \r\n         \"Sid\":\"Allowed Permissions Statement\",\r\n         \"Effect\":\"Allow\",\r\n         \"Action\":[  \r\n            \"reports:generate\",\r\n            \"serviceLevelAgreements:*\",\r\n            \"serviceLevelAgreementLogs:*\"\r\n         ],\r\n         \"Object\":[  \r\n            \"gon:mft::reports::*\",\r\n            \"gon:mft::serviceLevelAgreements::*\",\r\n            \"gon:mft::serviceLevelAgreementLogs::*\"\r\n         ],\r\n         \"Domain\":[  \r\n            \"*\"\r\n         ]\r\n      }\r\n   ]\r\n}',0,0),(118,'3-101-101g',NULL,'system','2024-04-22 14:01:11','system','2024-04-22 14:01:11',_binary '{\"Statement\":[{\"Effect\":\"Allow\",\"Action\":[\"projects:create\",\"projects:edit\",\"projects:move\",\"projects:delete\",\"projects:execute\",\"projects:export\",\"projects:promote\",\"projects:view\",\"projectCategories:create\",\"projectCategories:edit\",\"projectCategories:delete\",\"projectCategories:export\",\"projectCategories:permissions\"],\"Object\":[\"gon:mft::projectCategories::101\",\"gon:mft::projects:101:*\"],\"Domain\":[\"1\"]}]}\r\n',3,101),(119,'Auditor','Admin users in this role have View Only Access','system','2024-04-22 14:01:11','system','2024-04-22 14:01:11',_binary '{\r\n	\"Statement\" : [\r\n		{\r\n			\"Action\" : [\r\n				\"activeSessions:view\",\r\n				\"schedules:view\",\r\n				\"holidayCalendars:view\",\r\n				\"customTasks:view\",\r\n				\"godriveLogs:view\",\r\n				\"services:view\",\r\n				\"addons:view\",\r\n				\"ftpsLogs:view\",\r\n				\"webuserTemplates:view\",\r\n				\"users:view\",\r\n				\"webUserDevices:view\",\r\n				\"databaseConfiguration:view\",\r\n				\"jobs:view\",\r\n				\"jobs:manageAllJobs\",\r\n				\"adminServer:view\",\r\n				\"ftpLogs:view\",\r\n				\"userGroups:view\",\r\n				\"webClientBrands:view\",\r\n				\"webuserGroups:view\",\r\n				\"triggerLogs:view\",\r\n				\"gofastLogs:view\",\r\n				\"secureMail:view\",\r\n				\"httpsLogs:view\",\r\n				\"loginMethods:view\",\r\n				\"autoIPBlacklist:view\",\r\n				\"keyVaults:view\",\r\n				\"agentTemplates:view\",\r\n				\"logExemptions:view\",\r\n				\"domains:view\",\r\n				\"sftpLogs:view\",\r\n				\"activeTransfers:view\",\r\n				\"userTemplates:view\",\r\n				\"addressBooks:view\",\r\n				\"monitors:view\",\r\n				\"triggers:view\",\r\n				\"masterEncryptionKeys:view\",\r\n				\"ipFilters:view\",\r\n				\"serviceLevelAgreementLogs:view\",\r\n				\"license:view\",\r\n				\"systemLogs:view\",\r\n				\"as2Logs:view\",\r\n				\"as4Logs:view\",\r\n				\"pesitLogs:view\",\r\n				\"antivirusLogs:view\",\r\n				\"secureForms:view\",\r\n				\"serviceLevelAgreements:view\",\r\n				\"adminLogs:view\",\r\n				\"adminLogs:all\",\r\n				\"encryptedFolders:view\",\r\n				\"queues:view\",\r\n				\"gatewayManager:view\",\r\n				\"webusers:view\",\r\n				\"userRoles:view\",\r\n				\"reports:generate\",\r\n				\"projects:viewOnly\",\r\n				\"resources:viewOnly\",\r\n				\"partners:view\",\r\n				\"adminUserApiKeys:view\",\r\n				\"partnerDocuments:view\",\r\n				\"hs1:view\"\r\n			],\r\n			\"Domain\" : [\r\n				\"*\"\r\n			],\r\n			\"Effect\" : \"Allow\",\r\n			\"Object\" : [\r\n				\"gon:mft::activeSessions::*\",\r\n				\"gon:mft::activeTransfers::*\",\r\n				\"gon:mft::addons::*\",\r\n				\"gon:mft::addressBooks::*\",\r\n				\"gon:mft::adminLogs::*\",\r\n				\"gon:mft::adminServer::*\",\r\n				\"gon:mft::userGroups::*\",\r\n				\"gon:mft::userRoles::*\",\r\n				\"gon:mft::userTemplates::*\",\r\n				\"gon:mft::users::*\",\r\n				\"gon:mft::agentTemplates::*\",\r\n				\"gon:mft::as2Logs::*\",\r\n				\"gon:mft::as4Logs::*\",\r\n				\"gon:mft::autoIPBlacklist::*\",\r\n				\"gon:mft::customTasks::*\",\r\n				\"gon:mft::databaseConfiguration::*\",\r\n				\"gon:mft::domains::*\",\r\n				\"gon:mft::encryptedFolders::*\",\r\n				\"gon:mft::ftpLogs::*\",\r\n				\"gon:mft::ftpsLogs::*\",\r\n				\"gon:mft::gatewayManager::*\",\r\n				\"gon:mft::godriveLogs::*\",\r\n				\"gon:mft::gofastLogs::*\",\r\n				\"gon:mft::holidayCalendars::*\",\r\n				\"gon:mft::httpsLogs::*\",\r\n				\"gon:mft::ipFilters::*\",\r\n				\"gon:mft::jobs::*\",\r\n				\"gon:mft::keyVaults::*\",\r\n				\"gon:mft::license::*\",\r\n				\"gon:mft::logExemptions::*\",\r\n				\"gon:mft::loginMethods::*\",\r\n				\"gon:mft::masterEncryptionKeys::*\",\r\n				\"gon:mft::monitors::*\",\r\n				\"gon:mft::pesitLogs::*\",\r\n				\"gon:mft::antivirusLogs::*\",\r\n				\"gon:mft::queues::*\",\r\n				\"gon:mft::schedules::*\",\r\n				\"gon:mft::secureForms::*\",\r\n				\"gon:mft::secureMail::*\",\r\n				\"gon:mft::serviceLevelAgreementLogs::*\",\r\n				\"gon:mft::serviceLevelAgreements::*\",\r\n				\"gon:mft::services::*\",\r\n				\"gon:mft::sftpLogs::*\",\r\n				\"gon:mft::systemLogs::*\",\r\n				\"gon:mft::triggerLogs::*\",\r\n				\"gon:mft::triggers::*\",\r\n				\"gon:mft::webClientBrands::*\",\r\n				\"gon:mft::webUserDevices::*\",\r\n				\"gon:mft::webuserGroups::*\",\r\n				\"gon:mft::webuserTemplates::*\",\r\n				\"gon:mft::webusers::*\",\r\n				\"gon:mft::reports::*\",\r\n				\"gon:mft::projectCategories::*\",\r\n				\"gon:mft::projects:*:*\",\r\n				\"gon:mft::resources:*\",\r\n				\"gon:mft::partners::*\",\r\n				\"gon:mft::adminUserApiKeys::*\",\r\n				\"gon:mft::partnerDocuments::*\",\r\n				\"gon:mft::hs1::*\"\r\n			],\r\n			\"Sid\" : \"Allowed Permissions Statement\"\r\n		}\r\n	]\r\n}',0,0),(120,'Partner Manager','Admin users in this role can manage Partners','system','2024-04-22 14:01:11','system','2024-04-22 14:01:11',_binary '{\n  \"Statement\": [\n    {\n      \"Sid\": \"Allowed Permissions Statement\",\n      \"Effect\": \"Allow\",\n      \"Action\": [\n        \"reports:generate\",\n        \"adminLogs:view\",\n        \"partners:*\",\n        \"partnerDocuments:*\"\n      ],\n      \"Object\": [\n        \"gon:mft::partners::*\",\n        \"gon:mft::adminLogs::*\",\n        \"gon:mft::reports::*\",\n        \"gon:mft::partnerDocuments::*\"\n      ],\n      \"Domain\": [\n        \"*\"\n      ]\n    }\n  ]\n}',0,0);
/*!40000 ALTER TABLE `dpa_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_schedule`
--

DROP TABLE IF EXISTS `dpa_schedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_schedule` (
  `schedule_id` int NOT NULL,
  `schedule_name` varchar(50) NOT NULL,
  `schedule_name_lc` varchar(50) NOT NULL,
  `schedule_desc` varchar(256) DEFAULT NULL,
  `proj_loc` varchar(512) NOT NULL,
  `run_user` varchar(64) NOT NULL,
  `user_password` varchar(172) NOT NULL,
  `queue_priority` int NOT NULL DEFAULT '5',
  `run_priority` int NOT NULL DEFAULT '5',
  `trigger_def` varchar(128) NOT NULL,
  `trigger_state` char(1) NOT NULL DEFAULT 'A',
  `prev_fire_time` bigint NOT NULL,
  `next_fire_time` bigint NOT NULL,
  `num_fires` int NOT NULL DEFAULT '0',
  `num_misfires` int NOT NULL DEFAULT '0',
  `created_by` varchar(64) NOT NULL,
  `created_on` datetime NOT NULL,
  `modified_by` varchar(64) NOT NULL,
  `modified_on` datetime NOT NULL,
  `repeat_def` varchar(128) DEFAULT NULL,
  `calendar_id` int DEFAULT NULL,
  `holiday_rule` char(1) DEFAULT NULL,
  `original_next_fire_time` bigint DEFAULT NULL,
  `job_queue_id` int DEFAULT NULL,
  `job_name` varchar(200) DEFAULT NULL,
  `job_data` mediumblob,
  `success_emails` varchar(512) DEFAULT NULL,
  `success_attach_joblog` char(1) DEFAULT '0',
  `failure_emails` varchar(512) DEFAULT NULL,
  `failure_attach_joblog` char(1) DEFAULT '0',
  `domain_id` int NOT NULL DEFAULT '1',
  `agent_id` int NOT NULL DEFAULT '0',
  `agent_group_id` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`schedule_id`),
  UNIQUE KEY `schedule_name_lc` (`schedule_name_lc`),
  KEY `idx_dpa_schedule_queue` (`job_queue_id`),
  KEY `idx_dpa_schedule_calendar_id` (`calendar_id`),
  CONSTRAINT `dpa_schedule_ibfk_1` FOREIGN KEY (`calendar_id`) REFERENCES `dpa_holiday_calendar` (`calendar_id`),
  CONSTRAINT `dpa_schedule_chk_1` CHECK ((`trigger_state` in (_utf8mb3'A',_utf8mb3'I'))),
  CONSTRAINT `dpa_schedule_chk_2` CHECK ((`schedule_name_lc` = lower(`schedule_name`)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_schedule`
--

LOCK TABLES `dpa_schedule` WRITE;
/*!40000 ALTER TABLE `dpa_schedule` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_schedule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_secure_form`
--

DROP TABLE IF EXISTS `dpa_secure_form`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_secure_form` (
  `sf_id` int NOT NULL,
  `sf_name` varchar(50) NOT NULL,
  `sf_name_lc` varchar(50) NOT NULL,
  `sf_desc` varchar(512) DEFAULT NULL,
  `sf_type` int NOT NULL,
  `title` varchar(128) DEFAULT NULL,
  `instructions` varchar(512) DEFAULT NULL,
  `status` char(1) DEFAULT NULL,
  `public_access` char(1) DEFAULT NULL,
  `public_url` varchar(128) DEFAULT NULL,
  `include_branding` char(1) DEFAULT NULL,
  `redirect_success` char(1) DEFAULT NULL,
  `redirect_success_url` varchar(256) DEFAULT NULL,
  `comp_sequence` int DEFAULT NULL,
  `comp_version` int DEFAULT NULL,
  `domain_id` int DEFAULT NULL,
  `created_by` varchar(64) DEFAULT NULL,
  `created_on` datetime DEFAULT NULL,
  `modified_by` varchar(64) DEFAULT NULL,
  `modified_on` datetime DEFAULT NULL,
  `proj_loc` varchar(512) DEFAULT NULL,
  `run_user` varchar(64) DEFAULT NULL,
  `user_password` varchar(172) DEFAULT NULL,
  `job_name` varchar(200) DEFAULT NULL,
  `webclient_enabled` char(1) DEFAULT NULL,
  `soap_enabled` char(1) DEFAULT NULL,
  `rest_enabled` char(1) NOT NULL DEFAULT '0',
  `allow_embedding` char(1) DEFAULT '0',
  `allow_embedding_from` varchar(128) DEFAULT NULL,
  `languages` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`sf_id`),
  UNIQUE KEY `sf_name_lc` (`sf_name_lc`),
  CONSTRAINT `dpa_secure_form_chk_1` CHECK ((`sf_name_lc` = lower(`sf_name`)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_secure_form`
--

LOCK TABLES `dpa_secure_form` WRITE;
/*!40000 ALTER TABLE `dpa_secure_form` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_secure_form` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_sequence`
--

DROP TABLE IF EXISTS `dpa_sequence`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_sequence` (
  `sequence_name` varchar(50) NOT NULL,
  `next_value` int NOT NULL DEFAULT '1001',
  PRIMARY KEY (`sequence_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_sequence`
--

LOCK TABLES `dpa_sequence` WRITE;
/*!40000 ALTER TABLE `dpa_sequence` DISABLE KEYS */;
INSERT INTO `dpa_sequence` VALUES ('custom_task',10000),('dpa_addon',1001),('dpa_addr_book',1001),('dpa_addr_book_contact',1001),('dpa_addr_book_con_group',1001),('dpa_admin_api_key',1000),('dpa_admin_log',1012),('dpa_agent',1001),('dpa_agent_group',1001),('dpa_agent_template',1000),('dpa_as2_recipient',1001),('dpa_as4_mpc',1001),('dpa_as4_mpc_entries',1001),('dpa_as4_subc',1001),('dpa_as4_web_user_pull',1001),('dpa_as4_web_user_push',1001),('dpa_audit_log_exemption',1001),('dpa_category',1001),('dpa_comp_contact',1001),('dpa_dashboard',1002),('dpa_domain',1000),('dpa_encrypted_folder',1001),('dpa_gadget',1007),('dpa_gdi_user',1001),('dpa_gd_comment',1001),('dpa_gd_item',1001),('dpa_gd_notification',1001),('dpa_gd_revision',1001),('dpa_global_log',1001),('dpa_group',1001),('dpa_holiday_calendar',1001),('dpa_ip_filter',1001),('dpa_job_queue',1001),('dpa_login_method',1001),('dpa_mek',1001),('dpa_monitor',1001),('dpa_package_file',1001),('dpa_partner',1000),('dpa_partner_document',1001),('dpa_pass_hist',1002),('dpa_pesit_identification',1000),('dpa_pesit_ptr',1000),('dpa_pesit_tmp',1000),('dpa_project',1001),('dpa_resource',1001),('dpa_role',1001),('dpa_schedule',1001),('dpa_secure_form',1000),('dpa_service',1001),('dpa_shared_file',1001),('dpa_sla',1000),('dpa_software_library',1001),('dpa_ssh_key',1001),('dpa_task',1001),('dpa_template',1001),('dpa_trigger',1001),('dpa_user',1002),('dpa_user_filter',1001),('dpa_virtual_file',1001),('dpa_wc_brand',1001),('dpa_web_group',1001),('dpa_web_user',1001),('dpa_web_user_template',1001),('dpa_wu_pass_hist',1001);
/*!40000 ALTER TABLE `dpa_sequence` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_setting`
--

DROP TABLE IF EXISTS `dpa_setting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_setting` (
  `setting_name` varchar(100) NOT NULL,
  `setting_value` varchar(2000) NOT NULL,
  PRIMARY KEY (`setting_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_setting`
--

LOCK TABLES `dpa_setting` WRITE;
/*!40000 ALTER TABLE `dpa_setting` DISABLE KEYS */;
INSERT INTO `dpa_setting` VALUES ('admin.language.default','en'),('admin.user.created','true'),('adminsecurity.allowAdminInterfaceIFrameEmbedding','false'),('adminsecurity.allowNeverExpiringApiKeys','false'),('adminsecurity.allowSavingAdminCredentials','false'),('adminsecurity.defaultResourcePermissions','255'),('adminsecurity.fileManagerMaxUpload','4096'),('adminsecurity.header.contentSecurityPolicyType','default'),('adminsecurity.header.contentSecurityPolicyValue','default-src \'self\' *.goanywhere.com https://maps.google.com https://csi.gstatic.com https://maps.googleapis.com https://maps.gstatic.com https://fonts.googleapis.com https://fonts.gstatic.com; img-src * data: blob:; script-src \'self\' https://maps.google.com https://maps.googleapis.com \'unsafe-inline\' \'unsafe-eval\'; style-src \'self\' https://fonts.googleapis.com \'unsafe-inline\';'),('adminsecurity.maxApiKeyAge','365'),('adminsecurity.maxLoginAttempts','10'),('adminsecurity.passwordPolicyAllowableSpecialCharacters','~@#$%^&*()-_=+<>?/\\;:[]{},.'),('adminsecurity.passwordPolicyEnforced','true'),('adminsecurity.passwordPolicyExpirationInterval','0'),('adminsecurity.passwordPolicyExpirationNotification','0,0,0'),('adminsecurity.passwordPolicyHistoryEnforced','false'),('adminsecurity.passwordPolicyHistoryThreshold','5'),('adminsecurity.passwordPolicyMinimumDigits','0'),('adminsecurity.passwordPolicyMinimumLength','8'),('adminsecurity.passwordPolicyMinimumLowerCaseLetters','0'),('adminsecurity.passwordPolicyMinimumPasswordAge','0'),('adminsecurity.passwordPolicyMinimumSpecialCharacters','0'),('adminsecurity.passwordPolicyMinimumUpperCaseLetters','0'),('adminsecurity.sessionTimeout','900'),('agent.autoResume.enabled','true'),('agent.autoResume.interval','30'),('agent.autoResume.retries','3'),('agent.certs.managed','true'),('auditlog.index.version','3'),('auditlogexemptions.enabled','true'),('bandwidth.inbound.enabled','false'),('bandwidth.inbound.limitDays','false'),('bandwidth.inbound.limitDaysOfWeek','62'),('bandwidth.inbound.limitTime','false'),('bandwidth.inbound.limitTimeEnd','1700'),('bandwidth.inbound.limitTimeStart','0800'),('bandwidth.inbound.maxBytes','10'),('bandwidth.inbound.maxBytesUnit','M'),('bandwidth.outbound.enabled','false'),('bandwidth.outbound.limitDays','false'),('bandwidth.outbound.limitDaysOfWeek','62'),('bandwidth.outbound.limitTime','false'),('bandwidth.outbound.limitTimeEnd','1700'),('bandwidth.outbound.limitTimeStart','0800'),('bandwidth.outbound.maxBytes','10'),('bandwidth.outbound.maxBytesUnit','M'),('data.addonWorkspaceDir','userdata/addonWorkspace'),('data.documentsDirectory','userdata/documents'),('data.monitorsDirectory','userdata/monitors'),('database.version','7.5.3'),('db.backup.daysToKeepBackups','7'),('db.backup.directory','userdata/database/backups'),('db.backup.enabled','true'),('db.backup.lastBackupTime','-1'),('db.backup.nextFireTime','1718064000000'),('db.backup.schedule','DLY 20100202 0000 1'),('db.tuning.enabled','false'),('db.tuning.lastTunedTime','-1'),('db.tuning.schedule','WKY 20100202 0000 1 1'),('default.ssh.fingerprints','E0:D2:30:92:38:6C:03:BC:FE:60:50:B3:53:B8:64:D7,19:8E:38:8F:15:6C:3C:FF:0B:8A:23:36:D5:6F:FD:32'),('default.ssl.fingerprints','39:A8:C5:01:7F:FD:3A:ED:01:ED:EE:3C:AB:0A:6B:01:6C:C1:4E:4D'),('file.buffer.size','1'),('file.buffer.unit','M'),('fileLock.enabled','true'),('fileLock.timeout','60'),('gateway.ipfilter.enabled','true'),('gateway.ipfilter.logRejections','false'),('general.adminSiteURL',' '),('general.datePattern',' '),('general.instanceName',' '),('general.locale',' '),('general.timePattern',' '),('general.timestampPattern',' '),('gftp.autoStartup','false'),('gftp.extensionFilter.allowFilesWithExtension','true'),('gftp.extensionFilter.allowFilesWithNoExtension','true'),('gftp.extensionFilter.caseSensitive','true'),('gftp.extensionFilter.type','N'),('gftp.fileExtensions',' '),('gftp.restrictUploadsToInbound','false'),('gftps.autoStartup','false'),('gftps.extensionFilter.allowFilesWithExtension','true'),('gftps.extensionFilter.allowFilesWithNoExtension','true'),('gftps.extensionFilter.caseSensitive','true'),('gftps.extensionFilter.type','N'),('gftps.fileExtensions',' '),('gftps.restrictUploadsToInbound','false'),('ghttps.allowBasicAuthQuickDownloads','false'),('ghttps.allowSavingBrowserCredentials','false'),('ghttps.allowSecureFormEmbedding','0'),('ghttps.allowUIQuickDownloads','false'),('ghttps.allowWebClientInterfaceIFrameEmbedding','false'),('ghttps.allowWfeUserConfiguration','true'),('ghttps.as2AllowFilesWithNoName','true'),('ghttps.as2Enabled','false'),('ghttps.as2ExtensionFilter.allowFilesWithExtension','true'),('ghttps.as2ExtensionFilter.allowFilesWithNoExtension','true'),('ghttps.as2ExtensionFilter.caseSensitive','true'),('ghttps.as2ExtensionFilter.type','N'),('ghttps.as2FileExtensions',' '),('ghttps.as2MaxUploadSize','5'),('ghttps.as4DaysBeforeConsumedMessagePurge','30'),('ghttps.as4MaxWaitTime','10'),('ghttps.as4MaxWaitTimeUnits','M'),('ghttps.asciiFilePatterns',' '),('ghttps.autoStartup','false'),('ghttps.basicClientEnabled','true'),('ghttps.clientEnabled','true'),('ghttps.defaultClient','E'),('ghttps.defaultWfeAction','rename'),('ghttps.displayHelpLink','true'),('ghttps.displayPoweredBy','true'),('ghttps.downloadZipEnabled','true'),('ghttps.enhancedClientEnabled','false'),('ghttps.extensionFilter.allowFilesWithExtension','true'),('ghttps.extensionFilter.allowFilesWithNoExtension','true'),('ghttps.extensionFilter.caseSensitive','true'),('ghttps.extensionFilter.type','N'),('ghttps.fileExtensions',' '),('ghttps.forgotPwdEnabled','false'),('ghttps.forgotPwdMaxAge','24'),('ghttps.header.contentSecurityPolicyType','default'),('ghttps.header.contentSecurityPolicyValue','default-src \'self\' *.goanywhere.com; script-src \'self\' \'unsafe-inline\' \'unsafe-eval\'; style-src \'self\' \'unsafe-inline\'; img-src * data: blob:;'),('ghttps.helpLink',' '),('ghttps.maxAppletConnections','3'),('ghttps.maxDownloadFileCount','1000'),('ghttps.maxLoginAttempts','3'),('ghttps.maxUploadFileSize','4096'),('ghttps.quickDownloadsEnabled','false'),('ghttps.quickUploadsEnabled','false'),('ghttps.restrictUploadsToInbound','false'),('ghttps.sessionTimeout','300'),('ghttps.useDefaultHelp','true'),('ghttps.useSiteUrlForApplet','false'),('godrive.enabled','true'),('godrive.link.enabled','true'),('godrive.mediaViewer.enabled','true'),('godrive.mediaViewer.preferred','true'),('godrive.mediaViewer.selectedFileTypes','BMP,GIF,JFI,JFIF,JIF,JPE,JPEG,JPG,PDF,PNG'),('godrive.revisions.max','5'),('godrive.thumbnails.enabled','true'),('godrive.thumbnails.selectedFileTypes','BMP,GIF,JPG,JPEG,PNG'),('godrive.trashbin.daysToKeepFiles','30'),('godrive.useSenderFromAddress','false'),('gofast.autoStartup','false'),('gofast.debugmode','false'),('gofast.enabled','false'),('gofast.extensionFilter.allowFilesWithExtension','true'),('gofast.extensionFilter.allowFilesWithNoExtension','true'),('gofast.extensionFilter.caseSensitive','true'),('gofast.extensionFilter.type','N'),('gofast.fileExtensions',' '),('gofast.memorylimit.size','512'),('gofast.memorylimit.unit','M'),('gofast.overflowDirectory','userdata/gofast'),('gsftp.autoStartup','false'),('gsftp.extensionFilter.allowFilesWithExtension','true'),('gsftp.extensionFilter.allowFilesWithNoExtension','true'),('gsftp.extensionFilter.caseSensitive','true'),('gsftp.extensionFilter.type','N'),('gsftp.fileExtensions',' '),('gsftp.limitMaxUploadSize','false'),('gsftp.maxUploadFileSize','4096'),('gsftp.restrictUploadsToInbound','false'),('hs1.enabled','false'),('hs1.registrationKey.id',' '),('hs1.user.filePermissions','3'),('hs1.user.homeDirectory','*DOCROOT/*USER'),('hs1.user.restrictedToHomeDir','false'),('http.proxy.host',' '),('http.proxy.password',' '),('http.proxy.port','80'),('http.proxy.type','DIRECT'),('http.proxy.username',' '),('icap.authenticatedGroups',' '),('icap.authenticatedUser',' '),('icap.clientIp',' '),('icap.contentType',' '),('icap.enabled','false'),('icap.fileBufferSize','1'),('icap.previewEnabled','true'),('icap.requestHost',' '),('icap.selectedServices','0'),('icap.serverIp',' '),('icap.serviceLimits','false'),('icap.subscriberId',' '),('icap.url','icap://localhost:1344/policy_service_resp'),('ipFilter.enabled','false'),('ipFilter.type','D'),('login.2faGOTP.enabled','false'),('login.2faGOTP.textMessageFormat','${code} is your Verification Code'),('login.2faRadius.enabled','false'),('login.2faTOTP.displayNameAdmin','GoAnywhere Admin'),('login.2faTOTP.displayNameWebClient','GoAnywhere Web Client'),('login.2faTOTP.enabled','false'),('login.default2faGOTPNotificationOption','E'),('login.defaultAdminUserLoginMethodId','101'),('login.defaultWebUserLoginMethodId','101'),('login.enabled2faGOTPNotificationOptions','E'),('login.kerberos.enabled','false'),('logs.adminLog.archive','true'),('logs.agent.daysToKeepAuditLogs','30'),('logs.contentScan.archive','true'),('logs.contentScan.daysToKeepAuditLogs','90'),('logs.daysToKeepJobLogs','90'),('logs.defaultDateRange','7'),('logs.dir','userdata/logs'),('logs.edi.daysToKeepDocs','30'),('logs.gftp.archive','true'),('logs.gftp.daysToKeepAuditLogs','90'),('logs.gftps.archive','true'),('logs.gftps.daysToKeepAuditLogs','90'),('logs.ghttps.archive','true'),('logs.ghttps.as2Archive','true'),('logs.ghttps.as2DaysToKeepAuditLogs','90'),('logs.ghttps.as4Archive','true'),('logs.ghttps.as4DaysToKeepAuditLogs','90'),('logs.ghttps.daysToKeepAuditLogs','90'),('logs.globalLogExtension','.log'),('logs.globalLogLevel','INFO'),('logs.godrive.archive','true'),('logs.godrive.daysToKeepAuditLogs','90'),('logs.gofast.archive','true'),('logs.gofast.daysToKeepAuditLogs','90'),('logs.gsftp.archive','true'),('logs.gsftp.daysToKeepAuditLogs','90'),('logs.jobFile.archive','true'),('logs.jobFile.daysToKeepLogs','90'),('logs.jobLogExtension','.log'),('logs.jobLogFormat','text'),('logs.maxGlobalLogSize','5'),('logs.pesit.archive','true'),('logs.pesit.daysToKeepAuditLogs','90'),('logs.securemail.daysToKeepActiveMessages','365'),('logs.securemail.daysToKeepDrafts','30'),('logs.securemail.daysToKeepInactiveFiles','7'),('logs.securemail.daysToKeepInactiveMessages','30'),('logs.serviceLevelAgreementLog.archive','true'),('logs.serviceLevelAgreementLog.daysToKeepLogs','90'),('logs.tamperDetection.enabled','true'),('logs.triggers.daysToKeepLogs','365'),('maps.enabled','false'),('monitorRuntime.maxPoolSize','20'),('monitorRuntime.threadKeepAliveTime','900'),('pgp.compressionAlgorithms','ZIP,ZLIB'),('pgp.encryptionAlgorithms','AES128,AES192,AES256,CAST5'),('pgp.hashAlgorithms','SHA1,MD5'),('pgp.pubring','userdata/keys/pgp/pubring.pkr'),('pgp.secring','userdata/keys/pgp/secring.skr'),('runtime.corePoolSize','10'),('runtime.maxPoolSize','50'),('runtime.prestartCoreThreads','false'),('runtime.threadKeepAliveTime','900'),('scheduler.monitorScheduler.enabled','true'),('scheduler.projectScheduler.enabled','true'),('secureforms.publicSessionTimeout','300'),('securemail.enabledPasswordNotificationOptions','E'),('securemail.fileLimitPerPackage','1000'),('securemail.requestfiles.defaultSubject','File Request'),('securemail.textMessageFormat','${password} is your Secure Mail password'),('serviceLevelAgreementEngine.enabled','true'),('serviceLevelAgreementEngine.maxPoolSize','20'),('serviceLevelAgreementEngine.threadKeepAliveTime','900'),('services.maxLoginAttempts','3'),('services.packagesDir','userdata/packages'),('services.webUserConsolidateSubfolders','true'),('services.webUserInactiveDays','0'),('sms.clickatell.api.id',' '),('sms.clickatell.from.number',' '),('sms.clickatell.mobile.originated','false'),('sms.clickatell.password',' '),('sms.clickatell.url','https://api.clickatell.com/http/sendmsg'),('sms.clickatell.user',' '),('sms.enabled','false'),('sms.plivo.auth.id',' '),('sms.plivo.auth.token',' '),('sms.plivo.from.number',' '),('sms.plivo.url','https://api.plivo.com/v1/Account/{auth_id}/Message/'),('sms.provider','clickatell'),('sms.twilio.account.sid',' '),('sms.twilio.auth.token',' '),('sms.twilio.from.number',' '),('sms.twilio.url','https://api.twilio.com/2010-04-01/Accounts/{AccountSid}/Messages'),('smtp.connectionType','normal'),('smtp.fromEmail','admin@GoAnywhere'),('smtp.fromName','GoAnywhere'),('smtp.host','localhost'),('smtp.maxConnections','1'),('smtp.password',' '),('smtp.port','25'),('smtp.timeout',' '),('smtp.user',' '),('syslog.applicationSeverity','ERROR'),('syslog.auditSeverity','ERROR'),('syslog.enabled','false'),('syslog.facility','USER'),('syslog.indent','goanywhere'),('syslog.port','514'),('syslog.protocol','UDP'),('syslog.structuredData.enabled','true'),('systemAlert.clusterChanged.addEmailOpt','false'),('systemAlert.clusterChanged.addEmails',' '),('systemAlert.clusterChanged.notifyManager','false'),('systemAlert.emailSubjectPrefix','[GoAnywhere Alert]'),('systemAlert.enabled','false'),('systemAlert.gatewayConnect.addEmailOpt','false'),('systemAlert.gatewayConnect.addEmails',' '),('systemAlert.gatewayConnect.notifyManagers','false'),('systemAlert.gatewayDisconnect.addEmailOpt','false'),('systemAlert.gatewayDisconnect.addEmails',' '),('systemAlert.gatewayDisconnect.notifyManager','false'),('systemAlert.goanywhereShutdown.addEmailOpt','false'),('systemAlert.goanywhereShutdown.addEmails',' '),('systemAlert.goanywhereShutdown.notifyManagers','false'),('systemAlert.goanywhereStarted.addEmailOpt','false'),('systemAlert.goanywhereStarted.addEmails',' '),('systemAlert.goanywhereStarted.notifyManagers','false'),('systemAlert.jvmMemory.addEmailOpt','false'),('systemAlert.jvmMemory.addEmails',' '),('systemAlert.jvmMemory.notifyManagers','true'),('systemAlert.jvmMemory.threshold','100'),('systemAlert.licenseExpires.addEmailOpt','false'),('systemAlert.licenseExpires.addEmails',' '),('systemAlert.licenseExpires.notifyManagers','true'),('systemAlert.licenseExpires.within','5'),('systemAlert.pgpExpires.addEmailOpt','false'),('systemAlert.pgpExpires.addEmails',' '),('systemAlert.pgpExpires.notifyManagers','true'),('systemAlert.pgpExpires.within','30'),('systemAlert.sslExpires.addEmailOpt','false'),('systemAlert.sslExpires.addEmails',' '),('systemAlert.sslExpires.notifyManagers','true'),('systemAlert.sslExpires.within','30'),('systemAlert.triggerFailed.addEmailOpt','false'),('systemAlert.triggerFailed.addEmails',' '),('systemAlert.triggerFailed.notifyManagers','false'),('systemAlert.webUserDeactivated.addEmailOpt','false'),('systemAlert.webUserDeactivated.addEmails',' '),('systemAlert.webUserDeactivated.notifyManager','false'),('triggers.enabled','true'),('wupf.email.required','false'),('wupf.email.unique','true'),('wupf.firstAndLastName.required','false'),('wupf.firstAndLastName.selfRegistration','true'),('wupf.firstAndLastName.update','true'),('wupf.organization.required','false'),('wupf.organization.selfRegistration','true'),('wupf.organization.update','true'),('wupf.phone.required','false'),('wupf.phone.selfRegistration','true'),('wupf.phone.update','true'),('wupp.allowableSpecialCharacters','~@#$%^&*()-_=+<>?/\\;:[]{},.'),('wupp.expirationNotification','0,0,0'),('wupp.historyEnforced','false'),('wupp.minimumDigits','1'),('wupp.minimumLength','8'),('wupp.minimumLowerCaseLetters','0'),('wupp.minimumPasswordAge','0'),('wupp.minimumSpecialCharacters','0'),('wupp.minimumUpperCaseLetters','1'),('wupp.passwordExpirationInterval','0'),('wupp.passwordHistoryThreshold','5'),('wupp.strengthEnforced','true'),('wusr.registrationEmailVerificationGracePeriod','72'),('x509.keyStoreLocation','userdata/keys/x509/privateKeys.bcfks'),('x509.keyStorePassword','*1:CMsDAQObBxG7WIzD8t29nkY0KDtESOQX5F5xvWR8wIk='),('x509.keyStoreProvider',' '),('x509.keyStoreType','BCFKS'),('x509.trustStoreLocation','userdata/keys/x509/trustedCertificates.bcfks'),('x509.trustStorePassword','*1:CMsDAQObBxG7WIzD8t29nkY0KDtESOQX5F5xvWR8wIk='),('x509.trustStoreProvider',' '),('x509.trustStoreType','BCFKS');
/*!40000 ALTER TABLE `dpa_setting` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_setting_obj`
--

DROP TABLE IF EXISTS `dpa_setting_obj`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_setting_obj` (
  `setting_name` varchar(100) NOT NULL,
  `setting_obj` mediumblob NOT NULL,
  PRIMARY KEY (`setting_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_setting_obj`
--

LOCK TABLES `dpa_setting_obj` WRITE;
/*!40000 ALTER TABLE `dpa_setting_obj` DISABLE KEYS */;
INSERT INTO `dpa_setting_obj` VALUES ('agent.certs.cacertificate',_binary '0��0������0\r	*�H��\r\r\00��10\r	*�H��\r	\010	UUS1	0U\01	0U\010U\nGoAnywhere.com10UGoAnywhere MFT1(0&UGoAnywhere MFT CA - 19003AEFB110 \r240610194517Z20740610194517Z0��10\r	*�H��\r	\010	UUS1	0U\01	0U\010U\nGoAnywhere.com10UGoAnywhere MFT1(0&UGoAnywhere MFT CA - 19003AEFB110�\"0\r	*�H��\r\0�\00�\n�\0�6���L�\rҼ���<���W�����I�9K���3c����.E6�_)�`x2duVY�ɤ�K�����s��̒L����(<u��)�H��\'P|�Ռ�O6Ûs�F~�W&�xp:��6(�i���7�y|T�[����*�-�O����XJ�JN(q|m2kDCp.k6򚷸�Ny9�ϰ�����\nK���{4�����m愫M>qJ��6���!�EX�ݐ �7�!&¬���\0������ҹ3LOY-	t�ƣZzta��?�_-�a�s�H�� WDi96�t�[Ts��~�;�t��7�ED\rr#{Y�ȊB-���S�/�z�R�Q��t��2�*� \n�����\"�3��r\r�j��6^SP$+�OPU����	HA��c?������h���y�݈��B�uDw��3�y�l��؍�N�q�!1�����Uf@�Nl�\0%�>b��Gʕ����0MF�����>��S��<�����֥�ڂNw���\r�Q%-�ȸ�b��Ie�@�$3Y\0�00U0�\00\r	*�H��\r\r\0�\00Lނ�#V�E��R|�3�T��~�J��k�h|o���ԋ�(Z���$���߼1t�iԨ��C�4��32.r�3����T��m������	�{���E���Jp�x�C�/P(�tB�P�.	��|?W=Y MF�2�]��\Z0j�$����a���ݦu�ҟ�f�.ɒ�+-X���R���>j�&��i$�WU�_��^�\\�İv���}k��H�\r�7��\0CCWj�R�9�)��m�\n�L�5,��%\Z]O+m��4��:�����u?����5�ė��7�C�~$�SPէ�h�yWh,��K��\Z��z�XD�!��)w����:v���u{6鎘14�C!��ǠMr�����O������������|\'N���(�(_A:��K�vN%f�(CQ]���]�s���&4g��w\nH������\Zl�ǐ�:HB,�u��cmÞ�c�H�� k{0�1=V �wG&@�(GGlD��[4ڤ�W�5[��9�Q ����b+_��H)x�T5��n\r'),('agent.certs.caprivatekey',_binary '0�	B\00\r	*�H��\r\0�	,0�	(\0�\0�6���L�\rҼ���<���W�����I�9K���3c����.E6�_)�`x2duVY�ɤ�K�����s��̒L����(<u��)�H��\'P|�Ռ�O6Ûs�F~�W&�xp:��6(�i���7�y|T�[����*�-�O����XJ�JN(q|m2kDCp.k6򚷸�Ny9�ϰ�����\nK���{4�����m愫M>qJ��6���!�EX�ݐ �7�!&¬���\0������ҹ3LOY-	t�ƣZzta��?�_-�a�s�H�� WDi96�t�[Ts��~�;�t��7�ED\rr#{Y�ȊB-���S�/�z�R�Q��t��2�*� \n�����\"�3��r\r�j��6^SP$+�OPU����	HA��c?������h���y�݈��B�uDw��3�y�l��؍�N�q�!1�����Uf@�Nl�\0%�>b��Gʕ����0MF�����>��S��<�����֥�ڂNw���\r�Q%-�ȸ�b��Ie�@�$3Y\0�\0��9H�:\0��ю��ltb(�G|�P�[���1J�0�z����tl�1�^a�K*�X|����\\���y�(��w���:I#�x0�*�b��Z��$�`��n@2��0Ucy@��{m�*+9tD.�_]ɀ5[D��Ç�Lx���Er�	������aC@����\n�ݠ���C�7����>V\'�ܒ�*!˟��068�O�V�?#&�n]�iրK���z�iP��)-��aKJ�U�w���b��]c�Ly�\ZH���	��+������j8����v�7/4L��A����M��\\wN��vȱߜ����1�3�t��纋X{rl�`r��+v����_0s\\f��񕪑�����9�!�/�9*r=K������z�MR���N��5G������	X�*1o\'e՗�-��Z3�:]-�,��ݴLh]����Ӷ� �M;P�����J�����V]@�E����yת��g��噗�}ԫ�\\���2Ր��@+�%+��Ub6����\0�\"ЏE#�&,�C��+��_:UC=%=��E�<V��~��T/C�K��m�c�-����s��a�J�.`���}�ʇ`�`[��N�G�A3��\'S=����S�AuO�-��ضaHr����!��/?z��\rKFj���DhЇy1�K��%:LM:�{����*�1b2��)�w|=ݬ�zےO�l��x6���4uO��b����T��U\n\0a���F�W�VV�$���W�r�0�=���Y-�ȢP2ǣ��́�\0�mMy�ə���-x�75#�v���wz��|�^م+ ;5l�>+�0���u��(~$�1��Q,���X��r�m@��n=؀����}�;ˢ]2rDyك�J#��\0�a�Dێ�i�ǖ�5�Z�o���-��X�$B�;֏�����>�r�F�FĴj�a[DL��5Β��bƴ�e���1���W,?��g��}-��nw�I��Γ���CS�t|���s��e���<���5��;#�%�V��0��&Ԍ�����\0ę�2��5�E�� +��Ђ1��ǁ�m�2�����n��7͍�\\Y��SIN����q�⢑Sx%�&��	S�l@ln:\"�U�~����q�3!����>���	�ᐅ�K��P-��K���DO歩\n�ώ���u/%��$�[��20n�JSy�w���,!�բ@0\r���U�AS-��Fl����i,�|܅�v\\������G�\'b���=�r�8i%k�\Z��_$���+N_T�o���*V ����\05F\r�g�<\Z�=7����f���6I��\'����V����,�i۹ӄ3�VB@s���ս!�%�L�V֣�o��I��Q���o{��[�r!�5�b��$��2��?���OKö�Z$�#!�`R�@R��L3y�.���!;5�Q��8�#�R��r�\0� Th=�z\'⽭�N���I_<ֻ�<7��@D�=�(o��ӎ!|K�gr\r��|�0ɠ��5����o,	��N�ˠwF0\r5(��D^D�\\�3�Y�D��2�m^��\0R��Ÿ�U���sK���ql�O��ǫ�o��՚�o�k���IPS��Be�4�\'��#)s�m��v̡�X>dZ�9DG�֖x)4a��_�Gۖ�M,Q[`@S�-md�\r$fGh �՛�e�Y���F�U�ri�yS�^|�Y+%mA�_G2\0���Q��A{c��P�Hv�.0���$(Y�~w�M�r�$�f��U����?X�Uι��\'����L(�e��\ZY�(�Y���)έ<p|mS.�S�D�+Ƥ�X��L�v'),('agent.certs.capublickey',_binary '0�\"0\r	*�H��\r\0�\00�\n�\0�6���L�\rҼ���<���W�����I�9K���3c����.E6�_)�`x2duVY�ɤ�K�����s��̒L����(<u��)�H��\'P|�Ռ�O6Ûs�F~�W&�xp:��6(�i���7�y|T�[����*�-�O����XJ�JN(q|m2kDCp.k6򚷸�Ny9�ϰ�����\nK���{4�����m愫M>qJ��6���!�EX�ݐ �7�!&¬���\0������ҹ3LOY-	t�ƣZzta��?�_-�a�s�H�� WDi96�t�[Ts��~�;�t��7�ED\rr#{Y�ȊB-���S�/�z�R�Q��t��2�*� \n�����\"�3��r\r�j��6^SP$+�OPU����	HA��c?������h���y�݈��B�uDw��3�y�l��؍�N�q�!1�����Uf@�Nl�\0%�>b��Gʕ����0MF�����>��S��<�����֥�ڂNw���\r�Q%-�ȸ�b��Ie�@�$3Y\0'),('agent.certs.servercertificate',_binary '0�0�������0\r	*�H��\r\r\00��10\r	*�H��\r	\010	UUS1	0U\01	0U\010U\nGoAnywhere.com10UGoAnywhere MFT1(0&UGoAnywhere MFT CA - 19003AEFB110\r240610194518Z\r270610194518Z0��10\r	*�H��\r	\010	UUS1	0U\01	0U\010U\nGoAnywhere.com1\Z0UGoAnywhere Agents10UGoAnywhere MFT Agents0�\"0\r	*�H��\r\0�\00�\n�\0��8+��`�K�H�����pǛ��x��}i���*MM\'=��u�]�u�U������6㫃���a\r-C��ئ\r�n`|0���iB$M�o@J7�L�xUX^��%��>���d��4ʩY��qD.OĹGU���F���Я�Ҝ�]�s܀�3K�,K��z?�ow�y�p�Hm�W���}�$w��\05��A�����@漛W�((|�O̾��\rOSΧ��E�%�;U躗\n0�aI���0r֪�iW�����D����hr��Q����~�iZʷ�\'��ɼ�|����{i���e��N\Z�����A(��M�e���́�	��&c��\"��|F^�N^�#����2n\n�o�!Qw���c�`������y�.�9���b��%h���a>��+���L�9���CcY�(HS%uɹ�E��b�a	c���83�YE-ўEl.5�`]-g�Mt{�Y��\\րB��e�7�,���xL(�ҵ�,)1�U�X�x�6�i�x���ݐ1��Tݚ�\0��q0�m0��U#��0��0������0\r	*�H��\r\r\00��10\r	*�H��\r	\010	UUS1	0U\01	0U\010U\nGoAnywhere.com10UGoAnywhere MFT1(0&UGoAnywhere MFT CA - 19003AEFB110 \r240610194517Z20740610194517Z0��10\r	*�H��\r	\010	UUS1	0U\01	0U\010U\nGoAnywhere.com10UGoAnywhere MFT1(0&UGoAnywhere MFT CA - 19003AEFB110�\"0\r	*�H��\r\0�\00�\n�\0�6���L�\rҼ���<���W�����I�9K���3c����.E6�_)�`x2duVY�ɤ�K�����s��̒L����(<u��)�H��\'P|�Ռ�O6Ûs�F~�W&�xp:��6(�i���7�y|T�[����*�-�O����XJ�JN(q|m2kDCp.k6򚷸�Ny9�ϰ�����\nK���{4�����m愫M>qJ��6���!�EX�ݐ �7�!&¬���\0������ҹ3LOY-	t�ƣZzta��?�_-�a�s�H�� WDi96�t�[Ts��~�;�t��7�ED\rr#{Y�ȊB-���S�/�z�R�Q��t��2�*� \n�����\"�3��r\r�j��6^SP$+�OPU����	HA��c?������h���y�݈��B�uDw��3�y�l��؍�N�q�!1�����Uf@�Nl�\0%�>b��Gʕ����0MF�����>��S��<�����֥�ڂNw���\r�Q%-�ȸ�b��Ie�@�$3Y\0�00U0�\00\r	*�H��\r\r\0�\00Lނ�#V�E��R|�3�T��~�J��k�h|o���ԋ�(Z���$���߼1t�iԨ��C�4��32.r�3����T��m������	�{���E���Jp�x�C�/P(�tB�P�.	��|?W=Y MF�2�]��\Z0j�$����a���ݦu�ҟ�f�.ɒ�+-X���R���>j�&��i$�WU�_��^�\\�İv���}k��H�\r�7��\0CCWj�R�9�)��m�\n�L�5,��%\Z]O+m��4��:�����u?����5�ė��7�C�~$�SPէ�h�yWh,��K��\Z��z�XD�!��)w����:v���u{6鎘14�C!��ǠMr�����O������������|\'N���(�(_A:��K�vN%f�(CQ]���]�s���&4g��w\nH������\Zl�ǐ�:HB,�u��cmÞ�c�H�� k{0�1=V �wG&@�(GGlD��[4ڤ�W�5[��9�Q ����b+_��H)x�T5��n\r0��U��0��0�|�����0\r	*�H��\r\r\00��10\r	*�H��\r	\010	UUS1	0U\01	0U\010U\nGoAnywhere.com1\Z0UGoAnywhere Agents10UGoAnywhere MFT Agents0 \r240610194518Z20740610194518Z0��10\r	*�H��\r	\010	UUS1	0U\01	0U\010U\nGoAnywhere.com1\Z0UGoAnywhere Agents10UGoAnywhere MFT Agents0�\"0\r	*�H��\r\0�\00�\n�\0��8+��`�K�H�����pǛ��x��}i���*MM\'=��u�]�u�U������6㫃���a\r-C��ئ\r�n`|0���iB$M�o@J7�L�xUX^��%��>���d��4ʩY��qD.OĹGU���F���Я�Ҝ�]�s܀�3K�,K��z?�ow�y�p�Hm�W���}�$w��\05��A�����@漛W�((|�O̾��\rOSΧ��E�%�;U躗\n0�aI���0r֪�iW�����D����hr��Q����~�iZʷ�\'��ɼ�|����{i���e��N\Z�����A(��M�e���́�	��&c��\"��|F^�N^�#����2n\n�o�!Qw���c�`������y�.�9���b��%h���a>��+���L�9���CcY�(HS%uɹ�E��b�a	c���83�YE-ўEl.5�`]-g�Mt{�Y��\\րB��e�7�,���xL(�ҵ�,)1�U�X�x�6�i�x���ݐ1��Tݚ�\00\r	*�H��\r\r\0�\09���;�ϔ�%b���\'��Ҷ��ɥV����;`JĶv����PYט����a��AVfÈ�Qo5D8t��a��K����<��}ɴn0Y�4%_���yһ*8���Q��	-��T�m,J|_�v���4dO��:w*B�������D{Np��g?Őː��g6�^��(�#�jJ�}�;	i�o�yl��of,՜鶁��ܳ:�Jf��/��}m���|~��`���T��^\r�Y�欣V:�>H�F�=����{K�q���\'U��E�q	ׂ��~\0��p�on��no�a�څk�+)���\nY*\'N�&/J�h�뀥�\'s�	1�I�U�z�c����쬤Uf\nsZ�?�S+�A/����6�\"�t�w�}My���b��;��I>M��fY�u[�1CT(�dl{Z����鉜��1��@�����)��ZF�����s����RUJ�����F�I�1���]ʢ�d�QKc�4i,rs�f4�Yo;�|0\r	*�H��\r\r\0�\0#Y=�+��C�M&�N\"I�x�v�7��Uq��8��|�X��T�a�mܟ���\\p��գ#Q@�;بIx2�ۄ���r[��;���IUYK?��2F�W��\Z���,iɜ�b��T��%q\r�c��dӽ[������VFj\"��}O{ �\0�:z}��s��t��7B��aö�)�[X��5H�����q\\�!�a���)м�B�L2=�|�\r��z��3�jU_���.~�����S��o �.��=W&|�jX��UT]&b�ڎ�������ձH9���~��d�ê�Ҕ�a9��$���Z�Y�n�7d���	-���p|����l���-ã�1*�l@WH\Z	�3i��ar��jV\'C`@DE�H�u2�Əw��:�2��ȻA��`Bu|����U�b�B޾��������/�*��9�z�dAE����zWɐ�[�j�i�f���%�w�B�h�h���V���m��z�S\r�)�b��-؆#��Y(H~�\"&;�����f��#!=�О�XsV'),('agent.certs.serverprivatekey',_binary '0�	C\00\r	*�H��\r\0�	-0�	)\0�\0��8+��`�K�H�����pǛ��x��}i���*MM\'=��u�]�u�U������6㫃���a\r-C��ئ\r�n`|0���iB$M�o@J7�L�xUX^��%��>���d��4ʩY��qD.OĹGU���F���Я�Ҝ�]�s܀�3K�,K��z?�ow�y�p�Hm�W���}�$w��\05��A�����@漛W�((|�O̾��\rOSΧ��E�%�;U躗\n0�aI���0r֪�iW�����D����hr��Q����~�iZʷ�\'��ɼ�|����{i���e��N\Z�����A(��M�e���́�	��&c��\"��|F^�N^�#����2n\n�o�!Qw���c�`������y�.�9���b��%h���a>��+���L�9���CcY�(HS%uɹ�E��b�a	c���83�YE-ўEl.5�`]-g�Mt{�Y��\\րB��e�7�,���xL(�ҵ�,)1�U�X�x�6�i�x���ݐ1��Tݚ�\0�\0O7\rE�?�\r�<\n�3ոVp���8�I�A,�յG���_z-r%(���~2��W\\�A��\\��≾k��Myu�?����wHU6*)/�(�SG�*��9(��hn����\nT,�e*��R����VOc�*�U��s��.t��e�/��:F\n�ɨ]��(&�~ߎT�gy�`=�b�9�U\"7�uVko=p}�|+��UN�9�L��1�R�>_{�)��a��\'�J�/UW/4$K�A*X�\0q\'���`6N���e����8�aCƆ������\0�2����fy\n��ak����GP�$	Q�=��*ۨ����}�DmG�e�8_�7X�Vb7�:D@�];�t�ˤ����0���^F��r�xm�e����倭��;m�(3y�B؂��-��bݞ�}�IgT%IdPTb�\rI�����r��n\\_�@6�\r����W�ߧ_3�J�};�O��e$��:�qvOP\"���v�X&<��[uۓ�fNi�B3��$_3��*^�C>~�ܱ8e�!�\0�ʶ�ϻL�mގ��g�����Kh\\�X����mw���AF�\"�Ă�xs����\0��ā���yW�YU���X���%a�;�Ň0�o��s6m�I1�r�T(\r1�-��Pފ�8KĦ{�[�.̺���k�p��)�5�b���ۊ��2^�]ۀ���qO(��n�)��n��Z�食�ޟ�{�F.��˵ZR)Ii�*}�EH-6R&U�����=���|Z��}���R�RA��{���\\IҗRx�����\r���\0��[����BH}-�����⛵�;�p��%�A�O���d}��3D7��Q�bu�_����*����>p�$�y�VF�w�#F��j�����K?Y�E����(jcw�h���5\'߀L�Jԥzo/!h���=��k������#Πn�h2��;�Rx��;��P\"g\0X�N����E\r�|%����!�����,��Y5�p\n�l(��S�h��F����rTdc�vt�}�$�79+�	L�ܦcc�\Z�A2ô��\0�G���B_�~�r9xezy� )12�f��1ZKO)�r�RYp[�T��Ȉ�g�ٔe�w#d7\n�aWj�q�A����ج�E���� ��\r�d$CȚ�z4���݃1��aY��%�sp��>�㟖���߬�s��[3����:�?�L���}(�ʖ.�� ����ƞѭ�Z�����Cg$����g�,��Ļ�����]�[$!�9��i�����u�.�k�섭��	E\Z�����xY�=�am���c�h��blA9�\0�O�X�p�;~�f�0��z\rO�j!�LklQ�EN.��,�÷�Ʈ������\r,T:D���0�\0ָ�k_�EHcvØ\n�z���q�8���\Z��c\n���|�i��Jh�B�gǿ�׉\n�Ja��6<��HT�W��_l�߻��#�������J�Z4Q�%���^}�y^}�����!�qG(��=$�t�5���-Ӟ�E4B�\ZM��ёy����3&�����:Ɖ�7�v�}�4�+����?|��|��<[9��\0Z�Le]�2��\0ć�*VJ�GZz�����=l�y����3C+�t/���<\"�&�D4ɳV��־[N�,�����6���$U6u_Ƌ�Y��@|Oh��@��Z[a�0�$@U��?*ܸ0N_�!1Ғ*~pG��X�ɿ��>�����9X��EB��Jzv��Ҝ����c�w�4�����񝉋��=ؤ�<���\\+&A�,E��I�zr\\�wf?G����\\�	 �r�fh�ц��F��c�l���Ǿ�L�c'),('agent.certs.serverpublickey',_binary '0�\"0\r	*�H��\r\0�\00�\n�\0��8+��`�K�H�����pǛ��x��}i���*MM\'=��u�]�u�U������6㫃���a\r-C��ئ\r�n`|0���iB$M�o@J7�L�xUX^��%��>���d��4ʩY��qD.OĹGU���F���Я�Ҝ�]�s܀�3K�,K��z?�ow�y�p�Hm�W���}�$w��\05��A�����@漛W�((|�O̾��\rOSΧ��E�%�;U躗\n0�aI���0r֪�iW�����D����hr��Q����~�iZʷ�\'��ɼ�|����{i���e��N\Z�����A(��M�e���́�	��&c��\"��|F^�N^�#����2n\n�o�!Qw���c�`������y�.�9���b��%h���a>��+���L�9���CcY�(HS%uɹ�E��b�a	c���83�YE-ўEl.5�`]-g�Mt{�Y��\\րB��e�7�,���xL(�ҵ�,)1�U�X�x�6�i�x���ݐ1��Tݚ�\0'),('icap.config.obj',_binary '{\n    \"customRequestHeaders\": [],\n    \"fileActions\": [{\n            \"icapResponseObject\": 101,\n            \"responseHeaderName\": \"\",\n            \"expressionId\": 100,\n            \"icapResponseValue\": \"204\",\n            \"fileAction\": \"A\",\n            \"defaultRule\": false,\n            \"unreachableServer\": false\n        }, {\n            \"icapResponseObject\": 100,\n            \"responseHeaderName\": \"X-Virus-ID\",\n            \"expressionId\": 111,\n            \"fileAction\": \"D\",\n            \"defaultRule\": false,\n            \"unreachableServer\": false\n        }, {\n            \"icapResponseObject\": 100,\n            \"responseHeaderName\": \"X-Infection-Found\",\n            \"expressionId\": 106,\n            \"icapResponseValue\": \"Type=0\",\n            \"fileAction\": \"D\",\n            \"defaultRule\": false,\n            \"unreachableServer\": false\n        }, {\n            \"icapResponseObject\": 0,\n            \"responseHeaderName\": \"\",\n            \"expressionId\": 0,\n            \"icapResponseValue\": \"\",\n            \"fileAction\": \"D\",\n            \"defaultRule\": true,\n            \"unreachableServer\": false\n        }, {\n            \"icapResponseObject\": 0,\n            \"responseHeaderName\": \"\",\n            \"expressionId\": 0,\n            \"icapResponseValue\": \"\",\n            \"fileAction\": \"D\",\n            \"defaultRule\": false,\n            \"unreachableServer\": true\n        }\n    ],\n    \"fileExemptions\": []\n}'),('login.routing.admin',_binary '{\"enabled\":false,\"routingRules\":[{\"loginMethod\":-1,\"systemRule\":true}]}'),('login.routing.web',_binary '{\"enabled\":false,\"routingRules\":[{\"loginMethod\":-1,\"systemRule\":true}]}');
/*!40000 ALTER TABLE `dpa_setting_obj` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_sf_comp`
--

DROP TABLE IF EXISTS `dpa_sf_comp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_sf_comp` (
  `comp_id` varchar(21) NOT NULL,
  `comp_type` varchar(10) NOT NULL,
  PRIMARY KEY (`comp_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_sf_comp`
--

LOCK TABLES `dpa_sf_comp` WRITE;
/*!40000 ALTER TABLE `dpa_sf_comp` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_sf_comp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_sf_comp_layout`
--

DROP TABLE IF EXISTS `dpa_sf_comp_layout`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_sf_comp_layout` (
  `sf_id` int NOT NULL,
  `comp_id` varchar(21) NOT NULL,
  `comp_index` int DEFAULT NULL,
  `comp_parent` varchar(21) DEFAULT NULL,
  KEY `sf_id` (`sf_id`),
  KEY `comp_id` (`comp_id`),
  CONSTRAINT `dpa_sf_comp_layout_ibfk_1` FOREIGN KEY (`sf_id`) REFERENCES `dpa_secure_form` (`sf_id`),
  CONSTRAINT `dpa_sf_comp_layout_ibfk_2` FOREIGN KEY (`comp_id`) REFERENCES `dpa_sf_comp` (`comp_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_sf_comp_layout`
--

LOCK TABLES `dpa_sf_comp_layout` WRITE;
/*!40000 ALTER TABLE `dpa_sf_comp_layout` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_sf_comp_layout` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_sf_comp_options`
--

DROP TABLE IF EXISTS `dpa_sf_comp_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_sf_comp_options` (
  `comp_id` varchar(21) NOT NULL,
  `option_label` varchar(100) DEFAULT NULL,
  `option_value` varchar(256) DEFAULT NULL,
  `option_description` varchar(256) DEFAULT NULL,
  `option_index` int DEFAULT NULL,
  `option_default_value` char(1) DEFAULT '0',
  KEY `comp_id` (`comp_id`),
  CONSTRAINT `dpa_sf_comp_options_ibfk_1` FOREIGN KEY (`comp_id`) REFERENCES `dpa_sf_comp` (`comp_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_sf_comp_options`
--

LOCK TABLES `dpa_sf_comp_options` WRITE;
/*!40000 ALTER TABLE `dpa_sf_comp_options` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_sf_comp_options` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_sf_comp_params`
--

DROP TABLE IF EXISTS `dpa_sf_comp_params`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_sf_comp_params` (
  `comp_id` varchar(21) NOT NULL,
  `param_value` varchar(256) DEFAULT NULL,
  `param_index` int DEFAULT NULL,
  KEY `comp_id` (`comp_id`),
  CONSTRAINT `dpa_sf_comp_params_ibfk_1` FOREIGN KEY (`comp_id`) REFERENCES `dpa_sf_comp` (`comp_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_sf_comp_params`
--

LOCK TABLES `dpa_sf_comp_params` WRITE;
/*!40000 ALTER TABLE `dpa_sf_comp_params` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_sf_comp_params` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_sf_comp_setting`
--

DROP TABLE IF EXISTS `dpa_sf_comp_setting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_sf_comp_setting` (
  `comp_id` varchar(21) DEFAULT NULL,
  `comp_type` varchar(10) DEFAULT NULL,
  `setting_name` varchar(50) DEFAULT NULL,
  `setting_value` varchar(1000) DEFAULT NULL,
  KEY `comp_id` (`comp_id`),
  CONSTRAINT `dpa_sf_comp_setting_ibfk_1` FOREIGN KEY (`comp_id`) REFERENCES `dpa_sf_comp` (`comp_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_sf_comp_setting`
--

LOCK TABLES `dpa_sf_comp_setting` WRITE;
/*!40000 ALTER TABLE `dpa_sf_comp_setting` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_sf_comp_setting` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_sf_payload`
--

DROP TABLE IF EXISTS `dpa_sf_payload`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_sf_payload` (
  `sfp_id` varchar(36) NOT NULL,
  `sf_id` int NOT NULL,
  `status` char(1) DEFAULT NULL,
  `submit_status` char(1) DEFAULT NULL,
  `sf_title` varchar(128) DEFAULT NULL,
  `sf_instructions` varchar(512) DEFAULT NULL,
  `job_id` bigint DEFAULT NULL,
  `domain_id` int DEFAULT NULL,
  `created_by` varchar(64) DEFAULT NULL,
  `created_on` datetime DEFAULT NULL,
  `modified_on` datetime DEFAULT NULL,
  `submitted_on` datetime DEFAULT NULL,
  `enc_key` varchar(256) DEFAULT NULL,
  `system_name` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`sfp_id`),
  KEY `sf_id` (`sf_id`),
  KEY `idx_dpa_sf_payload_data` (`status`,`submit_status`,`submitted_on`,`system_name`,`created_by`),
  CONSTRAINT `dpa_sf_payload_ibfk_1` FOREIGN KEY (`sf_id`) REFERENCES `dpa_secure_form` (`sf_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_sf_payload`
--

LOCK TABLES `dpa_sf_payload` WRITE;
/*!40000 ALTER TABLE `dpa_sf_payload` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_sf_payload` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_sf_proj_var`
--

DROP TABLE IF EXISTS `dpa_sf_proj_var`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_sf_proj_var` (
  `sf_id` int NOT NULL,
  `var_name` varchar(64) NOT NULL,
  `var_value` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`sf_id`,`var_name`),
  CONSTRAINT `dpa_sf_proj_var_ibfk_1` FOREIGN KEY (`sf_id`) REFERENCES `dpa_secure_form` (`sf_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_sf_proj_var`
--

LOCK TABLES `dpa_sf_proj_var` WRITE;
/*!40000 ALTER TABLE `dpa_sf_proj_var` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_sf_proj_var` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_sf_web_group`
--

DROP TABLE IF EXISTS `dpa_sf_web_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_sf_web_group` (
  `group_id` int NOT NULL,
  `sf_id` int NOT NULL,
  PRIMARY KEY (`group_id`,`sf_id`),
  KEY `sf_id` (`sf_id`),
  CONSTRAINT `dpa_sf_web_group_ibfk_1` FOREIGN KEY (`group_id`) REFERENCES `dpa_web_group` (`group_id`) ON DELETE CASCADE,
  CONSTRAINT `dpa_sf_web_group_ibfk_2` FOREIGN KEY (`sf_id`) REFERENCES `dpa_secure_form` (`sf_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_sf_web_group`
--

LOCK TABLES `dpa_sf_web_group` WRITE;
/*!40000 ALTER TABLE `dpa_sf_web_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_sf_web_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_sf_web_user`
--

DROP TABLE IF EXISTS `dpa_sf_web_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_sf_web_user` (
  `user_id` int NOT NULL,
  `sf_id` int NOT NULL,
  PRIMARY KEY (`user_id`,`sf_id`),
  KEY `sf_id` (`sf_id`),
  CONSTRAINT `dpa_sf_web_user_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `dpa_web_user` (`user_id`) ON DELETE CASCADE,
  CONSTRAINT `dpa_sf_web_user_ibfk_2` FOREIGN KEY (`sf_id`) REFERENCES `dpa_secure_form` (`sf_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_sf_web_user`
--

LOCK TABLES `dpa_sf_web_user` WRITE;
/*!40000 ALTER TABLE `dpa_sf_web_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_sf_web_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_sfp_file`
--

DROP TABLE IF EXISTS `dpa_sfp_file`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_sfp_file` (
  `sfp_id` varchar(36) NOT NULL,
  `comp_id` varchar(21) DEFAULT NULL,
  `var_name` varchar(64) DEFAULT NULL,
  `file_name` varchar(128) NOT NULL,
  `file_size` bigint DEFAULT NULL,
  `file_type` char(1) DEFAULT NULL,
  `file_id` varchar(36) DEFAULT NULL,
  KEY `idx_dpa_sfp_file_parent` (`sfp_id`),
  KEY `idx_dpa_sfp_file_name` (`sfp_id`,`file_name`),
  CONSTRAINT `dpa_sfp_file_ibfk_1` FOREIGN KEY (`sfp_id`) REFERENCES `dpa_sf_payload` (`sfp_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_sfp_file`
--

LOCK TABLES `dpa_sfp_file` WRITE;
/*!40000 ALTER TABLE `dpa_sfp_file` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_sfp_file` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_sfp_options`
--

DROP TABLE IF EXISTS `dpa_sfp_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_sfp_options` (
  `sfp_id` varchar(36) NOT NULL,
  `comp_id` varchar(21) DEFAULT NULL,
  `var_name` varchar(64) DEFAULT NULL,
  `option_label` varchar(100) DEFAULT NULL,
  `option_value` varchar(256) DEFAULT NULL,
  `sfp_var_order` int DEFAULT NULL,
  KEY `idx_dpa_sfp_options_parent` (`sfp_id`),
  CONSTRAINT `dpa_sfp_options_ibfk_1` FOREIGN KEY (`sfp_id`) REFERENCES `dpa_sf_payload` (`sfp_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_sfp_options`
--

LOCK TABLES `dpa_sfp_options` WRITE;
/*!40000 ALTER TABLE `dpa_sfp_options` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_sfp_options` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_sfp_variable`
--

DROP TABLE IF EXISTS `dpa_sfp_variable`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_sfp_variable` (
  `sfp_id` varchar(36) NOT NULL,
  `comp_id` varchar(21) DEFAULT NULL,
  `comp_label` varchar(100) DEFAULT NULL,
  `var_name` varchar(64) DEFAULT NULL,
  `var_value` varchar(1000) DEFAULT NULL,
  `comp_type` varchar(10) DEFAULT NULL,
  `comp_index` int DEFAULT NULL,
  `parent_id` varchar(21) DEFAULT NULL,
  `sfp_var_order` int DEFAULT NULL,
  `parent_index` int DEFAULT NULL,
  `data_encrypted` char(1) NOT NULL DEFAULT '0',
  KEY `idx_dpa_sfp_variable_parent` (`sfp_id`),
  CONSTRAINT `dpa_sfp_variable_ibfk_1` FOREIGN KEY (`sfp_id`) REFERENCES `dpa_sf_payload` (`sfp_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_sfp_variable`
--

LOCK TABLES `dpa_sfp_variable` WRITE;
/*!40000 ALTER TABLE `dpa_sfp_variable` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_sfp_variable` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_shared_file`
--

DROP TABLE IF EXISTS `dpa_shared_file`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_shared_file` (
  `sf_id` int NOT NULL,
  `vf_id` int NOT NULL,
  `relative_path` varchar(128) DEFAULT NULL,
  `user_id` int NOT NULL,
  `sf_type` char(1) NOT NULL DEFAULT 'D',
  PRIMARY KEY (`sf_id`),
  UNIQUE KEY `vf_id` (`vf_id`,`relative_path`,`user_id`),
  CONSTRAINT `dpa_shared_file_ibfk_1` FOREIGN KEY (`vf_id`) REFERENCES `dpa_virtual_file` (`vf_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_shared_file`
--

LOCK TABLES `dpa_shared_file` WRITE;
/*!40000 ALTER TABLE `dpa_shared_file` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_shared_file` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_shared_file_user`
--

DROP TABLE IF EXISTS `dpa_shared_file_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_shared_file_user` (
  `user_id` int NOT NULL,
  `sf_id` int NOT NULL,
  `shared_by` int NOT NULL,
  `shared_on` datetime DEFAULT NULL,
  `share_name` varchar(128) NOT NULL,
  `share_pending` char(1) NOT NULL DEFAULT '0',
  `permissions` int NOT NULL DEFAULT '0',
  `subfolder_access` char(1) NOT NULL DEFAULT '0',
  UNIQUE KEY `user_id` (`user_id`,`sf_id`),
  KEY `sf_id` (`sf_id`),
  CONSTRAINT `dpa_shared_file_user_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `dpa_web_user` (`user_id`) ON DELETE CASCADE,
  CONSTRAINT `dpa_shared_file_user_ibfk_2` FOREIGN KEY (`sf_id`) REFERENCES `dpa_shared_file` (`sf_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_shared_file_user`
--

LOCK TABLES `dpa_shared_file_user` WRITE;
/*!40000 ALTER TABLE `dpa_shared_file_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_shared_file_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_sla`
--

DROP TABLE IF EXISTS `dpa_sla`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_sla` (
  `sla_id` int NOT NULL,
  `sla_name` varchar(50) NOT NULL,
  `sla_name_lc` varchar(50) NOT NULL,
  `sla_desc` varchar(256) DEFAULT NULL,
  `domain_id` int NOT NULL,
  `status` char(1) NOT NULL DEFAULT 'A',
  `cat_type` varchar(3) NOT NULL,
  `cat_obj_id` bigint DEFAULT NULL,
  `proj_loc` varchar(512) DEFAULT NULL,
  `run_user` varchar(64) DEFAULT NULL,
  `user_password` varchar(172) DEFAULT NULL,
  `created_by` varchar(64) NOT NULL,
  `created_on` datetime NOT NULL,
  `modified_by` varchar(64) NOT NULL,
  `modified_on` datetime NOT NULL,
  PRIMARY KEY (`sla_id`),
  UNIQUE KEY `sla_name_lc` (`sla_name_lc`),
  CONSTRAINT `dpa_sla_chk_1` CHECK ((`status` in (_utf8mb4'A',_utf8mb4'I'))),
  CONSTRAINT `dpa_sla_chk_2` CHECK ((`sla_name_lc` = lower(`sla_name`)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_sla`
--

LOCK TABLES `dpa_sla` WRITE;
/*!40000 ALTER TABLE `dpa_sla` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_sla` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_sla_action`
--

DROP TABLE IF EXISTS `dpa_sla_action`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_sla_action` (
  `sla_id` int NOT NULL,
  `action_type` int NOT NULL,
  `action_def` mediumblob,
  KEY `idx_dpa_sla_action_sla` (`sla_id`),
  CONSTRAINT `dpa_sla_action_ibfk_1` FOREIGN KEY (`sla_id`) REFERENCES `dpa_sla` (`sla_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_sla_action`
--

LOCK TABLES `dpa_sla_action` WRITE;
/*!40000 ALTER TABLE `dpa_sla_action` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_sla_action` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_sla_def`
--

DROP TABLE IF EXISTS `dpa_sla_def`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_sla_def` (
  `sla_id` int NOT NULL,
  `sla_def` mediumblob,
  KEY `idx_dpa_sla_def_sla` (`sla_id`),
  CONSTRAINT `dpa_sla_def_ibfk_1` FOREIGN KEY (`sla_id`) REFERENCES `dpa_sla` (`sla_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_sla_def`
--

LOCK TABLES `dpa_sla_def` WRITE;
/*!40000 ALTER TABLE `dpa_sla_def` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_sla_def` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_sla_event_log`
--

DROP TABLE IF EXISTS `dpa_sla_event_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_sla_event_log` (
  `event_id` bigint NOT NULL,
  `event_time` datetime NOT NULL,
  `sla_id` int NOT NULL,
  `sla_name` varchar(50) NOT NULL,
  `domain_id` int NOT NULL DEFAULT '1',
  `status` char(1) NOT NULL,
  `cat_type` varchar(3) NOT NULL,
  `cat_obj_id` bigint DEFAULT NULL,
  `cat_obj_name` varchar(512) DEFAULT NULL,
  `system_name` varchar(20) DEFAULT NULL,
  `indexed` char(1) NOT NULL DEFAULT '0',
  `checksum` varchar(91) DEFAULT NULL,
  PRIMARY KEY (`event_id`),
  KEY `idx_dpa_sla_event_log` (`event_time` DESC)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_sla_event_log`
--

LOCK TABLES `dpa_sla_event_log` WRITE;
/*!40000 ALTER TABLE `dpa_sla_event_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_sla_event_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_sm_address_rule`
--

DROP TABLE IF EXISTS `dpa_sm_address_rule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_sm_address_rule` (
  `rule_order` int NOT NULL,
  `rule_to_pattern` varchar(128) NOT NULL,
  `rule_from_pattern` varchar(128) NOT NULL,
  `rule_permission` char(1) NOT NULL,
  `sys_rule` char(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`rule_order`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_sm_address_rule`
--

LOCK TABLES `dpa_sm_address_rule` WRITE;
/*!40000 ALTER TABLE `dpa_sm_address_rule` DISABLE KEYS */;
INSERT INTO `dpa_sm_address_rule` VALUES (1,'*','*','1','1');
/*!40000 ALTER TABLE `dpa_sm_address_rule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_sms_country_codes`
--

DROP TABLE IF EXISTS `dpa_sms_country_codes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_sms_country_codes` (
  `country_name` varchar(60) NOT NULL,
  `country_name_lc` varchar(60) NOT NULL,
  `country_code` varchar(15) NOT NULL,
  `mask` varchar(40) NOT NULL,
  PRIMARY KEY (`country_name`),
  UNIQUE KEY `country_name_lc` (`country_name_lc`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_sms_country_codes`
--

LOCK TABLES `dpa_sms_country_codes` WRITE;
/*!40000 ALTER TABLE `dpa_sms_country_codes` DISABLE KEYS */;
INSERT INTO `dpa_sms_country_codes` VALUES ('Argentina','argentina','54','99 9999-9999'),('Armenia','armenia','374','99 999 999'),('Australia','australia','61','9999 999 999'),('Brazil','brazil','55','(99) 99999-9999'),('Canada','canada','1','(999) 999-9999'),('China','china','86','999 9999 9999'),('France','france','33','99 99 99 99 99'),('Germany','germany','49','99999 9999999'),('India','india','91','9999-999999'),('Ireland','ireland','353','999 999 9999'),('Israel','israel','972','99 999 9999'),('Italy','italy','39','999 999 9999'),('Japan','japan','81','99-9999-9999'),('Mexico','mexico','52','999 999 9999'),('Netherlands','netherlands','31','9 9999 9999'),('Other','other',' ','?999999999999999'),('South Korea','south korea','82','999-9999-9999'),('Spain','spain','34','999 999 999'),('United Kingdom','united kingdom','44','99999 999999'),('United States','united states','1','(999) 999-9999');
/*!40000 ALTER TABLE `dpa_sms_country_codes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_software_library`
--

DROP TABLE IF EXISTS `dpa_software_library`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_software_library` (
  `software_id` int NOT NULL,
  `package_code` char(1) NOT NULL,
  `product_code` char(1) NOT NULL,
  `major_version` int NOT NULL DEFAULT '0',
  `minor_version` int NOT NULL DEFAULT '0',
  `patch_version` int NOT NULL DEFAULT '0',
  `release_summary` varchar(256) NOT NULL,
  `release_date` datetime NOT NULL,
  `operating_system_code` char(1) NOT NULL,
  `filename` varchar(50) NOT NULL,
  `filesize` bigint NOT NULL,
  `checksum` varchar(64) NOT NULL,
  `created_by` varchar(64) NOT NULL,
  `created_on` datetime NOT NULL,
  `min_req_version` varchar(11) DEFAULT NULL,
  PRIMARY KEY (`software_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_software_library`
--

LOCK TABLES `dpa_software_library` WRITE;
/*!40000 ALTER TABLE `dpa_software_library` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_software_library` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_state_country_map`
--

DROP TABLE IF EXISTS `dpa_state_country_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_state_country_map` (
  `country_code` int NOT NULL,
  `state_province_code` int NOT NULL,
  PRIMARY KEY (`country_code`,`state_province_code`),
  KEY `state_province_code` (`state_province_code`),
  CONSTRAINT `dpa_state_country_map_ibfk_1` FOREIGN KEY (`country_code`) REFERENCES `dpa_country` (`country_code`),
  CONSTRAINT `dpa_state_country_map_ibfk_2` FOREIGN KEY (`state_province_code`) REFERENCES `dpa_state_province` (`state_province_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_state_country_map`
--

LOCK TABLES `dpa_state_country_map` WRITE;
/*!40000 ALTER TABLE `dpa_state_country_map` DISABLE KEYS */;
INSERT INTO `dpa_state_country_map` VALUES (1000,2000),(1000,2001),(1039,2002),(1000,2003),(1000,2004),(1000,2005),(1000,2006),(1000,2007),(1000,2008),(1000,2009),(1000,2010),(1000,2011),(1000,2012),(1000,2013),(1000,2014),(1000,2015),(1000,2016),(1000,2017),(1000,2018),(1000,2019),(1000,2020),(1000,2021),(1000,2022),(1000,2023),(1000,2024),(1000,2025),(1000,2026),(1000,2027),(1000,2028),(1000,2029),(1000,2030),(1000,2031),(1000,2032),(1000,2033),(1000,2034),(1000,2035),(1000,2036),(1000,2037),(1000,2038),(1000,2039),(1000,2040),(1000,2041),(1000,2042),(1000,2043),(1000,2044),(1000,2045),(1000,2046),(1000,2047),(1000,2048),(1000,2049),(1000,2050),(1000,2051),(1000,2052),(1000,2053),(1039,2054),(1039,2055),(1039,2056),(1039,2057),(1039,2058),(1039,2059),(1039,2060),(1039,2061),(1039,2062),(1039,2063),(1039,2064),(1039,2065);
/*!40000 ALTER TABLE `dpa_state_country_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_state_province`
--

DROP TABLE IF EXISTS `dpa_state_province`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_state_province` (
  `state_province_code` int NOT NULL,
  `state_province_name` varchar(60) NOT NULL,
  PRIMARY KEY (`state_province_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_state_province`
--

LOCK TABLES `dpa_state_province` WRITE;
/*!40000 ALTER TABLE `dpa_state_province` DISABLE KEYS */;
INSERT INTO `dpa_state_province` VALUES (2000,'Alabama'),(2001,'Alaska'),(2002,'Alberta'),(2003,'Arizona'),(2004,'Arkansas'),(2005,'California'),(2006,'Colorado'),(2007,'Connecticut'),(2008,'Delaware'),(2009,'Florida'),(2010,'Georgia'),(2011,'Hawaii'),(2012,'Idaho'),(2013,'Illinois'),(2014,'Indiana'),(2015,'Iowa'),(2016,'Kansas'),(2017,'Kentucky'),(2018,'Louisiana'),(2019,'Maine'),(2020,'Maryland'),(2021,'Massachusetts'),(2022,'Michigan'),(2023,'Minnesota'),(2024,'Mississippi'),(2025,'Missouri'),(2026,'Montana'),(2027,'Nebraska'),(2028,'Nevada'),(2029,'New Hampshire'),(2030,'New Jersey'),(2031,'New Mexico'),(2032,'New York'),(2033,'North Carolina'),(2034,'North Dakota'),(2035,'Ohio'),(2036,'Oklahoma'),(2037,'Oregon'),(2038,'Pennsylvania'),(2039,'Puerto Rico'),(2040,'Rhode Island'),(2041,'South Carolina'),(2042,'South Dakota'),(2043,'Tennessee'),(2044,'Texas'),(2045,'Utah'),(2046,'Vermont'),(2047,'Virgin Islands'),(2048,'Virginia'),(2049,'Washington'),(2050,'Washington DC'),(2051,'West Virginia'),(2052,'Wisconsin'),(2053,'Wyoming'),(2054,'British Columbia'),(2055,'Manitoba'),(2056,'New Brunswick'),(2057,'Newfoundland & Labrador'),(2058,'Northwest Territories'),(2059,'Nova Scotia'),(2060,'Nunavut'),(2061,'Ontario'),(2062,'Prince Edward Island'),(2063,'Quebec'),(2064,'Saskatchewan'),(2065,'Yukon');
/*!40000 ALTER TABLE `dpa_state_province` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_system_blacklist`
--

DROP TABLE IF EXISTS `dpa_system_blacklist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_system_blacklist` (
  `ip_address` varchar(64) NOT NULL,
  `reason_code` char(1) NOT NULL,
  `remarks` varchar(512) DEFAULT NULL,
  `created_on` datetime NOT NULL,
  `expires_on` bigint NOT NULL,
  PRIMARY KEY (`ip_address`),
  KEY `idx_dpa_system_blklst_exp_on` (`expires_on`),
  KEY `idx_dpa_system_blklst_crt_on` (`created_on`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_system_blacklist`
--

LOCK TABLES `dpa_system_blacklist` WRITE;
/*!40000 ALTER TABLE `dpa_system_blacklist` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_system_blacklist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_system_event_map`
--

DROP TABLE IF EXISTS `dpa_system_event_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_system_event_map` (
  `system_name` varchar(20) NOT NULL,
  `system_name_lc` varchar(20) NOT NULL,
  `event_key` int NOT NULL,
  PRIMARY KEY (`system_name_lc`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_system_event_map`
--

LOCK TABLES `dpa_system_event_map` WRITE;
/*!40000 ALTER TABLE `dpa_system_event_map` DISABLE KEYS */;
INSERT INTO `dpa_system_event_map` VALUES ('Default','default',100),('MFT-1','mft-1',101);
/*!40000 ALTER TABLE `dpa_system_event_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_task`
--

DROP TABLE IF EXISTS `dpa_task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_task` (
  `task_id` int NOT NULL,
  `tag_name` varchar(50) NOT NULL,
  `task_name` varchar(50) NOT NULL,
  `task_desc` varchar(512) DEFAULT NULL,
  `impl_class` varchar(512) NOT NULL,
  `version_no` varchar(15) NOT NULL,
  `vendor_name` varchar(50) NOT NULL,
  `deprecated` char(1) NOT NULL DEFAULT '0',
  `custom_task` char(1) NOT NULL DEFAULT '0',
  `created_by` varchar(64) NOT NULL,
  `created_on` datetime NOT NULL,
  `modified_by` varchar(64) NOT NULL,
  `modified_on` datetime NOT NULL,
  `task_type` char(1) NOT NULL DEFAULT 'G',
  PRIMARY KEY (`task_id`),
  UNIQUE KEY `tag_name` (`tag_name`,`version_no`),
  CONSTRAINT `dpa_task_chk_1` CHECK ((`deprecated` in (_utf8mb4'0',_utf8mb4'1'))),
  CONSTRAINT `dpa_task_chk_2` CHECK ((`custom_task` in (_utf8mb4'0',_utf8mb4'1')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_task`
--

LOCK TABLES `dpa_task` WRITE;
/*!40000 ALTER TABLE `dpa_task` DISABLE KEYS */;
INSERT INTO `dpa_task` VALUES (101,'sql','SQL','Runs SQL statements against a given database','com.linoma.ga.projects.tasks.sql.SQLTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','G'),(102,'copy','Copy','Copies local files and directories','com.linoma.ga.projects.tasks.copy.CopyTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','G'),(103,'move','Move','Moves local files and directories','com.linoma.ga.projects.tasks.move.MoveTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','G'),(104,'delete','Delete','Deletes local files and directories','com.linoma.ga.projects.tasks.delete.DeleteTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','G'),(105,'mkdir','Make Directory','Creates a directory','com.linoma.ga.projects.tasks.mkdir.MakeDirTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','G'),(106,'createWorkspace','Create Workspace','Creates a private workspace for the job','com.linoma.ga.projects.tasks.workspace.CreateWorkspaceTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','G'),(107,'deleteWorkspace','Delete Workspace','Deletes workspace for the current job','com.linoma.ga.projects.tasks.workspace.DeleteWorkspaceTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','G'),(108,'print','Print','Prints the given text to job log or to a given file','com.linoma.ga.projects.tasks.print.PrintTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','G'),(109,'writeCSV','Write CSV','Converts a rowset to a CSV file','com.linoma.ga.projects.tasks.converters.csv.CSVWriterTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','G'),(110,'zip','Zip','Zips one or more files','com.linoma.ga.projects.tasks.compression.ZipTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','G'),(111,'writeExcel','Write Excel','Converts a rowset to an Excel file','com.linoma.ga.projects.tasks.converters.excel.ExcelWriterTask','1.0','Fortra','1','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','G'),(112,'createFileList','Create File List','Creates a property containing the files from a File Set','com.linoma.ga.projects.tasks.filelist.CreateFileList','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','G'),(113,'unzip','Unzip','Extracts files from Zip archives','com.linoma.ga.projects.tasks.compression.UnzipTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','G'),(114,'readCSV','Read CSV','Reads one or more CSV files and generates a rowset','com.linoma.ga.projects.tasks.converters.csv.CSVReaderTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','G'),(115,'readFixedWidth','Read Fixed-width','Reads one or more fixed-width formatted files and generates a rowset','com.linoma.ga.projects.tasks.converters.fixedwidth.FixedWidthReaderTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','G'),(116,'writeFixedWidth','Write Fixed-width','Converts a rowset to a fixed-width format file','com.linoma.ga.projects.tasks.converters.fixedwidth.FixedWidthWriterTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','G'),(117,'sendEmail','Send Email','Sends an Email message','com.linoma.ga.projects.tasks.sendemail.EmailTask','1.0','Fortra','1','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','G'),(118,'retrieveMail','Retrieve Email','Retrieves Email messages','com.linoma.ga.projects.tasks.retrievemail.RetrieveMailTask','1.0','Fortra','1','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','G'),(119,'readExcel','Read Excel','Reads one or more Excel files and generates a rowset','com.linoma.ga.projects.tasks.converters.excel.ExcelReaderTask','1.0','Fortra','1','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','G'),(120,'xmlRead','Read XML','Converts XML files to a rowset','com.linoma.ga.projects.tasks.xmlread.XMLReadTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','G'),(121,'timestamp','Timestamp','Creates variables containing the current date/time in default or custom formats','com.linoma.ga.projects.tasks.timestamp.TimestampTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','G'),(122,'pgpEncrypt','PGP Encrypt','Encrypts and optionally signs the given files using PGP','com.linoma.ga.projects.tasks.pgp.EncryptTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','G'),(123,'pgpSign','PGP Sign','Signs the given files using PGP','com.linoma.ga.projects.tasks.pgp.SignTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','G'),(124,'pgpDecrypt','PGP Decrypt','Decrypts and optionally verifies the given files using PGP','com.linoma.ga.projects.tasks.pgp.DecryptTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','G'),(125,'pgpVerify','PGP Verify','Verifies the given files using PGP','com.linoma.ga.projects.tasks.pgp.VerifyTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','G'),(126,'ftp','FTP','Transfer files using FTP','com.linoma.ga.projects.tasks.ftp.FTPTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','G'),(127,'ftps','FTPS','Transfer files using FTPS (FTP over SSL)','com.linoma.ga.projects.tasks.ftp.FTPSTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','G'),(128,'sftp','SFTP','Transfer files using SFTP (FTP over SSH)','com.linoma.ga.projects.tasks.ftp.SFTPTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','G'),(129,'xmlWrite','Write XML','Converts rowsets to an XML file','com.linoma.ga.projects.tasks.xmlwrite.XMLWriteTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','G'),(130,'cmd400','Execute System i Command','Executes one or more System i commands','com.linoma.ga.projects.tasks.as400.ExecuteCommandTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','G'),(131,'pgm400','Execute System i Program','Executes one or more System i programs','com.linoma.ga.projects.tasks.as400.ExecuteProgramTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','G'),(132,'http','HTTP','Communicate with HTTP servers','com.linoma.ga.projects.tasks.http.HTTPTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','G'),(133,'https','HTTPS','Communicate with HTTP servers over SSL','com.linoma.ga.projects.tasks.http.HTTPSTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','G'),(134,'exec','Execute Native Command','Execute any native command or executable','com.linoma.ga.projects.tasks.exec.ExecTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','G'),(135,'mergeFiles','Merge Files','Merge multiple files into one','com.linoma.ga.projects.tasks.merge.MergeFilesTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','G'),(136,'secureSendEmail','Secure Send Email','Sends an Email message over a secure connection','com.linoma.ga.projects.tasks.sendemail.SecureEmailTask','1.0','Fortra','1','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','G'),(137,'secureRetrieveMail','Secure Retrieve Email','Retrieves Email messages over a secure connection','com.linoma.ga.projects.tasks.retrievemail.SecureRetrieveMailTask','1.0','Fortra','1','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','G'),(138,'gunzip','GUnzip','Extracts files from GZIP compressed files','com.linoma.ga.projects.tasks.compression.GUnzipTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','G'),(139,'gzip','GZip','Compresses files using GZIP','com.linoma.ga.projects.tasks.compression.GZipTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','G'),(140,'exec400','Execute IBM i Command or Program','Execute a combination of IBM i Commands and/or Programs all under one job','com.linoma.ga.projects.tasks.exec400.Exec400Task','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','G'),(141,'raiseError','Raise Error','Raises an error with a custom message','com.linoma.ga.projects.tasks.raiseerror.RaiseErrorTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','G'),(142,'rename','Rename','Renames local files','com.linoma.ga.projects.tasks.rename.RenameTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','G'),(143,'tar','Tar','Creates Tar(Tape Archive) files','com.linoma.ga.projects.tasks.compression.TarTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','G'),(144,'untar','Untar','Extracts files from TAR files','com.linoma.ga.projects.tasks.compression.UntarTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','G'),(145,'searchAndReplace','Search and Replace','Searches one or more files for a given sequence of characters and replaces them with the specified value','com.linoma.ga.projects.tasks.searchandreplace.SearchAndReplaceTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','G'),(146,'ghttps','GoAnywhere HTTPS','Transfers files to/from a GoAnywhere HTTPS server','com.linoma.ga.projects.tasks.ghttps.GHTTPSTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','G'),(147,'setVariable','Set Variable','Creates or replaces the specified variable with the specified value','com.linoma.ga.projects.tasks.setvariable.SetVariableTask','1.0','Fortra','1','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','G'),(148,'callProject','Call Project','Executes a project on the local system','com.linoma.ga.projects.tasks.callproject.CallProjectTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','G'),(149,'callRemoteProject','Call Remote Project','Executes a project on a remote system','com.linoma.ga.projects.tasks.callproject.CallRemoteProjectTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','G'),(150,'readFlatFile','Read Flat File','Reads one or more flat files and generates a rowset','com.linoma.ga.projects.tasks.converters.flatfile.FlatFileReaderTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','G'),(151,'setVariable','Set Variable','Creates or replaces the specified variable with the specified value','com.linoma.ga.projects.tasks.setvariable.v2.SetVariableTask','2.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','G'),(152,'delay','Delay','Delays the execution for a given amount of time','com.linoma.ga.projects.tasks.delay.DelayTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','G'),(153,'readExcel','Read Excel','Reads one or more Excel files and generates a rowset','com.linoma.ga.projects.tasks.converters.excel.v2.ExcelReaderTask','2.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','G'),(154,'writeExcel','Write Excel','Converts a rowset to an Excel file','com.linoma.ga.projects.tasks.converters.excel.v2.ExcelWriterTask','2.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','G'),(155,'retrieveMail','Retrieve Email','Retrieves Email messages','com.linoma.ga.projects.tasks.retrievemail.v2.RetrieveMailTask','2.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','G'),(156,'sendEmail','Send Email','Sends an Email message','com.linoma.ga.projects.tasks.sendemail.v2.EmailTask','2.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','G'),(157,'scp','SCP','Transfer files using SCP (Secure Copy)','com.linoma.ga.projects.tasks.ftp.SCPTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','G'),(158,'as2','AS2','Transfer files using AS2','com.linoma.ga.projects.tasks.as2.AS2Task','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','G'),(159,'closeRowSet','Close RowSet','Closes a RowSet and releases the resources and locks of the underlying data source','com.linoma.ga.projects.tasks.closerowset.CloseRowSetTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','G'),(160,'mqOpenSession','Open MQ Session','Opens a session to the specified MQ server','com.linoma.ga.projects.tasks.mq.OpenSessionTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','G'),(161,'mqCloseSession','Close MQ Session','Closes an MQ Session','com.linoma.ga.projects.tasks.mq.CloseSessionTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','G'),(162,'mqSend','MQ Send Message','Sends a message to an MQ Server','com.linoma.ga.projects.tasks.mq.SendMessageTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','G'),(163,'mqRetrieve','MQ Retrieve Message','Retrieves message(s) from an MQ Server','com.linoma.ga.projects.tasks.mq.RetrieveMessageTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','G'),(164,'mqCommitSession','MQ Commit/Rollback','Commits or rollsback the MQ session','com.linoma.ga.projects.tasks.mq.CommitSessionTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','G'),(165,'callModule','Call Module','Executes a module within the current project','com.linoma.ga.projects.tasks.callmodule.CallModuleTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','G'),(166,'exitProject','Exit Project','Exits the current project','com.linoma.ga.projects.tasks.exitproject.ExitProjectTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','G'),(167,'exitModule','Exit Module','Exits the current module','com.linoma.ga.projects.tasks.exitmodule.ExitModuleTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','G'),(168,'ftpCloseSession','Close Session','Closes an FTP, FTPS, SFTP, or SCP Session','com.linoma.ga.projects.tasks.ftp.FTPCloseSessionTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','G'),(169,'execSSH','Execute SSH Command','Executes an SSH command on remote server','com.linoma.ga.projects.tasks.execssh.ExecSSHTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','G'),(170,'modifyRowSet','Modify RowSet','Modify the contents of a RowSet','com.linoma.ga.projects.tasks.modifyrowset.ModifyRowSetTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','G'),(171,'passwordProtectExcel','Password Protect Excel','Password protects an Excel document','com.linoma.ga.projects.tasks.converters.excel.v2.ExcelPasswordProtectTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','G'),(172,'icap','ICAP','Scan files for viruses or data loss prevention','com.linoma.ga.projects.tasks.icap.ICAPTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','G'),(173,'denyTriggerEvent','Deny Trigger Event','Deny the event for a trigger','com.linoma.ga.projects.tasks.denytriggerevent.DenyTriggerEventTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','G'),(174,'dbStatsReport','Database Statistics','Generates a report of the database statistics','com.linoma.ga.projects.tasks.reports.DBStatsReportTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','R'),(175,'blacklistedIPReport','Blocked IP Addresses','Generates a report of the recently blocked IP addresses','com.linoma.ga.projects.tasks.reports.BlacklistedIPReportTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','R'),(176,'packageSizeReport','Secure Mail Package Sizes','Generates a report based on Secure Mail Package sizes','com.linoma.ga.projects.tasks.reports.PackageSizeReportTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','R'),(177,'gdDiskUsageReport','GoDrive Disk Usage','Generates a report based on GoDrive disk usages','com.linoma.ga.projects.tasks.reports.GoDriveDiskUsageReportTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','R'),(178,'webuserLoginReport','Web User Logins','Generates a report of Web User Logins','com.linoma.ga.projects.tasks.reports.WebUserLoginReportTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','R'),(179,'jobCountSumReport','Job Count Summary','Generates a report with Job statistics','com.linoma.ga.projects.tasks.reports.JobCountSumReportTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','R'),(180,'serviceActivitySumReport','Service Activity Summary','Generates a report with Service Activity','com.linoma.ga.projects.tasks.reports.ServiceActivitySumReportTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','R'),(181,'jobDetailReport','Completed Jobs Detail','Generates a report with Completed Jobs','com.linoma.ga.projects.tasks.reports.CompletedJobReportTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','R'),(182,'mergeReports','Merge Reports','Merges multiple reports together','com.linoma.ga.projects.tasks.reports.MergeReportsTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','R'),(183,'webuserTransferCountActivityReport','Web User Transfer Count Activity','Generates a report with web user transfer count activity','com.linoma.ga.projects.tasks.reports.WebUserTransferCountActivityReportTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','R'),(184,'securemailActivityReport','Secure Mail Activity','Generates a report for Secure Mail activity','com.linoma.ga.projects.tasks.reports.SecureMailActivityReportTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','R'),(185,'completedJobStatisticsReport','Completed Job Statistics','Generates a report for Completed Job statistics','com.linoma.ga.projects.tasks.reports.CompletedJobStatisticsReportTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','R'),(186,'securityAuditReport','Security Settings Audit','Generates a report that reviews the security settings in GoAnywhere','com.linoma.ga.projects.tasks.reports.SecurityAuditReportTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','R'),(187,'expiringOpenPGPKeysReport','Expiring PGP Keys','Generates a report of expiring PGP keys','com.linoma.ga.projects.tasks.reports.ExpiringOpenPGPKeysReportTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','R'),(188,'expiringSSLCertsReport','Expiring Certificates','Generates a report of expiring certificates','com.linoma.ga.projects.tasks.reports.ExpiringSSLCertsReportTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','R'),(189,'triggerActivityReport','Trigger Activity','Generates a report for Trigger activity','com.linoma.ga.projects.tasks.reports.TriggerActivityReportTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','R'),(190,'webuserTransferSizeActivityReport','Web User Transfer Size Activity','Generates a report with web user transfer size activity','com.linoma.ga.projects.tasks.reports.WebUserTransferSizeActivityReportTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','R'),(191,'secureMailDiskUsageReport','Secure Mail Disk Usage','Generates a report based on Secure Mail disk usages','com.linoma.ga.projects.tasks.reports.SecureMailDiskUsageReportTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','R'),(192,'globalActivityDetailsReport','Global Activity Details','Generates a report of global log activity details','com.linoma.ga.projects.tasks.reports.GlobalActivityDetailsReportTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','R'),(193,'serviceErrorReport','Service Errors','Generates a report of inbound service errors','com.linoma.ga.projects.tasks.reports.ServiceErrorReportTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','R'),(194,'serviceActivityByModuleReport','Service Activity By Module','Generates a report of service activity by module','com.linoma.ga.projects.tasks.reports.ServiceActivityByModuleReportTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','R'),(195,'snmpTrap','SNMP Trap','Sends an SNMP trap to a SNMP manager','com.linoma.ga.projects.tasks.snmp.SNMPTrapTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','G'),(196,'smsSendMessage','Send SMS Message','Sends an SMS message','com.linoma.ga.projects.tasks.sms.SMSSendMessageTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','G'),(197,'gofast','GoFast','Transfer large files quickly using GoFast','com.linoma.ga.projects.tasks.gofast.GoFastTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','G'),(198,'godriveUpload','GoDrive Upload','Upload a file to a web user GoDrive account','com.linoma.ga.projects.tasks.godrive.GoDriveUploadTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','G'),(199,'checksum','Checksum','Creates checksum for file','com.linoma.ga.projects.tasks.checksum.ChecksumTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','G'),(200,'secureFormResponse','Secure Form Response','Responds to a submitted Secure Form with a status and message.','com.linoma.ga.projects.tasks.secureform.SecureFormResponseTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','G'),(201,'countRowSet','Count RowSet','Counts number of rows and columns in a RowSet','com.linoma.ga.projects.tasks.countrowset.CountRowSetTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','G'),(202,'jsonRead','Read JSON','Converts JSON files to a rowset','com.linoma.ga.projects.tasks.jsonread.JSONReadTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','G'),(203,'validateRowSet','Validate RowSet','Determines whether or not a RowSet is valid.','com.linoma.ga.projects.tasks.validaterowset.ValidateRowSetTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','G'),(204,'jobUnresolvedReport','Unresolved Jobs','Generates a report with Unresolved Jobs','com.linoma.ga.projects.tasks.reports.UnresolvedJobReportTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','R'),(205,'fileTransferSumReport','File Transfer Summary','Generates a report with File Transfers','com.linoma.ga.projects.tasks.reports.FileTransferSummaryReportTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','R'),(206,'customReport','Custom Report','Generates a custom report','com.linoma.ga.projects.tasks.reports.WriteCustomReportTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','R'),(207,'restPost','REST Post','POST Data to a REST server','com.linoma.ga.projects.tasks.webservices.rest.RESTPostTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','G'),(208,'restGet','REST Get','GET Data from a REST server','com.linoma.ga.projects.tasks.webservices.rest.RESTGetTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','G'),(209,'restPut','REST Put','PUT Data to a REST server','com.linoma.ga.projects.tasks.webservices.rest.RESTPutTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','G'),(210,'restDelete','REST Delete','DELETE Data on a REST server','com.linoma.ga.projects.tasks.webservices.rest.RESTDeleteTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','G'),(211,'jsonWrite','Write JSON','Converts rowsets to a JSON file','com.linoma.ga.projects.tasks.jsonwrite.JSONWriteTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','G'),(212,'soap','SOAP','Sends a SOAP Message to a SOAP service','com.linoma.ga.projects.tasks.webservices.soap.SOAPTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','G'),(213,'adminUserActivityDetailsReport','Admin User Activity Details','Generates a report for admin user activity','com.linoma.ga.projects.tasks.reports.AdminUserActivityDetailsReportTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','R'),(214,'completedJobsByProjectReport','Completed Jobs by Project','Displays completed job details based on their projects and the specified date range','com.linoma.ga.projects.tasks.reports.CompletedJobsByProjectReportTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','R'),(215,'callAgentProject','Call Agent Project','Executes a project on the specified Agent','com.linoma.ga.projects.tasks.agent.CallAgentProjectTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','G'),(216,'callAgentGroupProject','Call Agent Group Project','Executes a project on the specified Agent Group','com.linoma.ga.projects.tasks.agent.CallAgentGroupProjectTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','G'),(217,'s3','S3','Work with Amazon S3 Objects','com.linoma.ga.projects.tasks.s3.S3Task','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','G'),(218,'restMultipartPost','REST Multipart Post','Send data in a multipart Post to a REST server','com.linoma.ga.projects.tasks.webservices.rest.RESTMultipartPostTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','G'),(219,'restPatch','REST Patch','PATCH Data to a REST server','com.linoma.ga.projects.tasks.webservices.rest.RESTPatchTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','G'),(220,'restOptions','REST Options','Send an HTTP OPTIONS request to a REST server','com.linoma.ga.projects.tasks.webservices.rest.RESTOptionsTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','G'),(221,'createJwt','Create JWT','Creates a JSON Web Token (JWT)','com.linoma.ga.projects.tasks.jwt.CreateJWTTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','G'),(222,'base64Encode','Base64 Encode','Encodes a file into Base64 format','com.linoma.ga.projects.tasks.encoding.Base64EncodeTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','G'),(223,'base64Decode','Base64 Decode','Decodes a Base64 Encoded file to original format','com.linoma.ga.projects.tasks.encoding.Base64DecodeTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','G'),(224,'productUsageReport','Product Usage','Generates a report with service and workflow statistics','com.linoma.ga.projects.tasks.reports.ProductUsageReportTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','R'),(225,'readX12','Read EDI X12','Reads an X12 Document into a RowSet','com.linoma.ga.projects.tasks.edi.x12.ReadX12Task','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','G'),(226,'writeX12','Write EDI X12','Writes an X12 Document','com.linoma.ga.projects.tasks.edi.x12.WriteX12Task','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','G'),(227,'serviceLevelAgreementReport','Service Level Agreement Summary','Generates a report with service level agreement statistics','com.linoma.ga.projects.tasks.reports.ServiceLevelAgreementReportTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','R'),(228,'pesit','PeSIT','Transfer files using PeSIT','com.linoma.ga.projects.tasks.pesit.PesitTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','G'),(229,'readEDIFACT','Read EDIFACT','Reads an EDIFACT Document into a RowSet','com.linoma.ga.projects.tasks.edi.edifact.ReadEDIFACTTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','G'),(230,'writeEDIFACT','Write EDIFACT','Writes an EDIFACT Document','com.linoma.ga.projects.tasks.edi.edifact.WriteEDIFACTTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','G'),(231,'as3CreateMDN','AS3 Create MDN','Creates an MDN file from an AS3 message file','com.linoma.ga.projects.tasks.as3.AS3CreateMDNTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','G'),(232,'as3CreateMessage','AS3 Create Message','Creates an AS3 Message file','com.linoma.ga.projects.tasks.as3.AS3CreateMessageTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','G'),(233,'as3ProcessMDN','AS3 Process MDN','Processes an AS3 MDN file','com.linoma.ga.projects.tasks.as3.AS3ProcessMDNTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','G'),(234,'as3ProcessMessage','AS3 Process Message','Processes an AS3 Message file','com.linoma.ga.projects.tasks.as3.AS3ProcessMessageTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','G'),(235,'as4Pull','AS4 Pull','Sends an AS4 Pull Request','com.linoma.ga.projects.tasks.as4.AS4PullTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','G'),(236,'as4Push','AS4 Push','Sends an AS4 User Message','com.linoma.ga.projects.tasks.as4.AS4PushTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','G'),(237,'as4SendReceipt','AS4 Send Receipt','Sends an AS4 Receipt in response to a User Message','com.linoma.ga.projects.tasks.as4.AS4SendReceiptTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','G'),(238,'as4EnqueueMessage','AS4 Enqueue Message','Place files on an AS4 Message Channel for partners to retrieve','com.linoma.ga.projects.tasks.as4.AS4EnqueueMessageTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','G'),(239,'as4SendError','AS4 Send Error','Send an AS4 error message to a trading partner','com.linoma.ga.projects.tasks.as4.AS4SendErrorTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','G'),(240,'readX12Envelope','Read X12 Envelope','Read in the X12 Envelope into output variables and perform preprocessing validation','com.linoma.ga.projects.tasks.edi.x12.ReadX12EnvelopeTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','G'),(241,'filecatalyst','FileCatalyst','A task for transferring large files quickly to/from a remote server using FileCatalyst accelerated transfers','com.linoma.ga.projects.tasks.filecatalyst.task.FileCatalystTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','G'),(300,'getAgentInformation','Get Agent Information','Retrieve information related to a specific agent','com.linoma.ga.projects.tasks.agent.GetAgentInformationTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','G'),(301,'getAgentGroupInformation','Get Agent Group Information','Retrieve information related to a specific agent group','com.linoma.ga.projects.tasks.agent.GetAgentGroupInformationTask','1.0','Fortra','0','0','system','2024-04-22 14:01:13','system','2024-04-22 14:01:13','G');
/*!40000 ALTER TABLE `dpa_task` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_template`
--

DROP TABLE IF EXISTS `dpa_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_template` (
  `template_id` int NOT NULL,
  `template_name` varchar(50) NOT NULL,
  `template_name_lc` varchar(50) NOT NULL,
  `template_desc` varchar(512) DEFAULT NULL,
  `home_dir` varchar(256) NOT NULL DEFAULT '*DOCROOT/*USER',
  `restrict_to_home` char(1) NOT NULL DEFAULT '1',
  `file_permissions` int NOT NULL DEFAULT '3',
  `login_method` int NOT NULL DEFAULT '0',
  `created_by` varchar(64) NOT NULL,
  `created_on` datetime NOT NULL,
  `modified_by` varchar(64) NOT NULL,
  `modified_on` datetime NOT NULL,
  `two_factor_type` char(1) DEFAULT NULL,
  `auth_type` char(1) NOT NULL DEFAULT 'P',
  PRIMARY KEY (`template_id`),
  UNIQUE KEY `template_name_lc` (`template_name_lc`),
  CONSTRAINT `dpa_template_chk_1` CHECK ((`template_name_lc` = lower(`template_name`)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_template`
--

LOCK TABLES `dpa_template` WRITE;
/*!40000 ALTER TABLE `dpa_template` DISABLE KEYS */;
INSERT INTO `dpa_template` VALUES (101,'Admin User Template','admin user template','This is the default template shipped with GoAnywhere','*DOCROOT/*USER','0',3,0,'system','2024-04-22 14:01:11','system','2024-04-22 14:01:11',NULL,'P');
/*!40000 ALTER TABLE `dpa_template` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_template_domain`
--

DROP TABLE IF EXISTS `dpa_template_domain`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_template_domain` (
  `template_id` int NOT NULL,
  `domain_id` int NOT NULL,
  PRIMARY KEY (`template_id`,`domain_id`),
  KEY `domain_id` (`domain_id`),
  CONSTRAINT `dpa_template_domain_ibfk_1` FOREIGN KEY (`template_id`) REFERENCES `dpa_template` (`template_id`) ON DELETE CASCADE,
  CONSTRAINT `dpa_template_domain_ibfk_2` FOREIGN KEY (`domain_id`) REFERENCES `dpa_domain` (`domain_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_template_domain`
--

LOCK TABLES `dpa_template_domain` WRITE;
/*!40000 ALTER TABLE `dpa_template_domain` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_template_domain` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_template_group`
--

DROP TABLE IF EXISTS `dpa_template_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_template_group` (
  `template_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`template_id`,`group_id`),
  KEY `group_id` (`group_id`),
  CONSTRAINT `dpa_template_group_ibfk_1` FOREIGN KEY (`template_id`) REFERENCES `dpa_template` (`template_id`) ON DELETE CASCADE,
  CONSTRAINT `dpa_template_group_ibfk_2` FOREIGN KEY (`group_id`) REFERENCES `dpa_group` (`group_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_template_group`
--

LOCK TABLES `dpa_template_group` WRITE;
/*!40000 ALTER TABLE `dpa_template_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_template_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_template_role`
--

DROP TABLE IF EXISTS `dpa_template_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_template_role` (
  `template_id` int NOT NULL,
  `role_id` int NOT NULL,
  PRIMARY KEY (`template_id`,`role_id`),
  KEY `role_id` (`role_id`),
  CONSTRAINT `dpa_template_role_ibfk_1` FOREIGN KEY (`template_id`) REFERENCES `dpa_template` (`template_id`) ON DELETE CASCADE,
  CONSTRAINT `dpa_template_role_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `dpa_role` (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_template_role`
--

LOCK TABLES `dpa_template_role` WRITE;
/*!40000 ALTER TABLE `dpa_template_role` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_template_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_token_key_value`
--

DROP TABLE IF EXISTS `dpa_token_key_value`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_token_key_value` (
  `token` char(36) NOT NULL,
  `token_key` varchar(100) NOT NULL,
  `token_value` varchar(2000) NOT NULL,
  KEY `idx_dpa_token_key_value` (`token_key`),
  KEY `idx_dpa_token_key_value_token` (`token`),
  CONSTRAINT `dpa_token_key_value_ibfk_1` FOREIGN KEY (`token`) REFERENCES `dpa_email_token` (`token`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_token_key_value`
--

LOCK TABLES `dpa_token_key_value` WRITE;
/*!40000 ALTER TABLE `dpa_token_key_value` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_token_key_value` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_trigger`
--

DROP TABLE IF EXISTS `dpa_trigger`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_trigger` (
  `trg_id` int NOT NULL,
  `trg_name` varchar(50) NOT NULL,
  `trg_name_lc` varchar(50) NOT NULL,
  `trg_desc` varchar(512) DEFAULT NULL,
  `trg_status` char(1) NOT NULL DEFAULT 'A',
  `trg_stop_processing` char(1) NOT NULL DEFAULT '0',
  `event_type_id` int NOT NULL,
  `priority` int NOT NULL,
  `service` int NOT NULL,
  `created_by` varchar(64) NOT NULL,
  `created_on` datetime NOT NULL,
  `modified_by` varchar(64) NOT NULL,
  `modified_on` datetime NOT NULL,
  `domain_id` int NOT NULL DEFAULT '1',
  `proj_loc` varchar(512) DEFAULT NULL,
  `run_user` varchar(64) DEFAULT NULL,
  `user_password` varchar(172) DEFAULT NULL,
  PRIMARY KEY (`trg_id`),
  UNIQUE KEY `trg_name_lc` (`trg_name_lc`,`event_type_id`),
  UNIQUE KEY `trg_name_lc_2` (`trg_name_lc`,`event_type_id`,`priority`),
  KEY `event_type_id` (`event_type_id`),
  CONSTRAINT `dpa_trigger_ibfk_1` FOREIGN KEY (`event_type_id`) REFERENCES `dpa_event_type` (`event_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_trigger`
--

LOCK TABLES `dpa_trigger` WRITE;
/*!40000 ALTER TABLE `dpa_trigger` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_trigger` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_trigger_action`
--

DROP TABLE IF EXISTS `dpa_trigger_action`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_trigger_action` (
  `trg_id` int NOT NULL,
  `action_type` smallint NOT NULL,
  `action_obj` mediumblob,
  KEY `trg_id` (`trg_id`),
  CONSTRAINT `dpa_trigger_action_ibfk_1` FOREIGN KEY (`trg_id`) REFERENCES `dpa_trigger` (`trg_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_trigger_action`
--

LOCK TABLES `dpa_trigger_action` WRITE;
/*!40000 ALTER TABLE `dpa_trigger_action` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_trigger_action` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_trigger_condition`
--

DROP TABLE IF EXISTS `dpa_trigger_condition`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_trigger_condition` (
  `trg_id` int NOT NULL,
  `att_id` int NOT NULL,
  `exp_id` int NOT NULL,
  `cond_value` varchar(1024) DEFAULT NULL,
  `open_paren` varchar(20) DEFAULT NULL,
  `close_paren` varchar(20) DEFAULT NULL,
  `operand` char(1) DEFAULT NULL,
  `priority` int NOT NULL DEFAULT '0',
  KEY `trg_id` (`trg_id`),
  CONSTRAINT `dpa_trigger_condition_ibfk_1` FOREIGN KEY (`trg_id`) REFERENCES `dpa_trigger` (`trg_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_trigger_condition`
--

LOCK TABLES `dpa_trigger_condition` WRITE;
/*!40000 ALTER TABLE `dpa_trigger_condition` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_trigger_condition` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_trigger_log`
--

DROP TABLE IF EXISTS `dpa_trigger_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_trigger_log` (
  `trg_event_id` bigint NOT NULL,
  `trg_id` int NOT NULL,
  `service` smallint NOT NULL,
  `trg_name` varchar(50) NOT NULL,
  `event_type_id` int NOT NULL,
  `status` char(1) NOT NULL DEFAULT 'A',
  `start_time` datetime NOT NULL,
  `end_time` datetime DEFAULT NULL,
  `time_taken` bigint DEFAULT NULL,
  `indexed` char(1) NOT NULL DEFAULT '0',
  `domain_id` int NOT NULL DEFAULT '1',
  `checksum` varchar(91) DEFAULT NULL,
  PRIMARY KEY (`trg_event_id`,`trg_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_trigger_log`
--

LOCK TABLES `dpa_trigger_log` WRITE;
/*!40000 ALTER TABLE `dpa_trigger_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_trigger_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_trigger_log_detail`
--

DROP TABLE IF EXISTS `dpa_trigger_log_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_trigger_log_detail` (
  `trg_event_id` bigint NOT NULL,
  `trg_id` int NOT NULL,
  `log_time` datetime NOT NULL,
  `severity` char(1) NOT NULL,
  `remarks` varchar(256) DEFAULT NULL,
  `checksum` varchar(91) DEFAULT NULL,
  KEY `trg_event_id` (`trg_event_id`,`trg_id`),
  KEY `idx_dpa_trigger_log_detail_trg_event_id` (`trg_event_id`),
  CONSTRAINT `dpa_trigger_log_detail_ibfk_1` FOREIGN KEY (`trg_event_id`, `trg_id`) REFERENCES `dpa_trigger_log` (`trg_event_id`, `trg_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_trigger_log_detail`
--

LOCK TABLES `dpa_trigger_log_detail` WRITE;
/*!40000 ALTER TABLE `dpa_trigger_log_detail` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_trigger_log_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_user`
--

DROP TABLE IF EXISTS `dpa_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_user` (
  `user_id` int NOT NULL,
  `user_name` varchar(64) NOT NULL,
  `user_name_lc` varchar(64) NOT NULL,
  `user_desc` varchar(512) DEFAULT NULL,
  `user_pass` varchar(128) DEFAULT NULL,
  `user_email` varchar(128) DEFAULT NULL,
  `enabled` char(1) NOT NULL DEFAULT '1',
  `sys_user` char(1) NOT NULL DEFAULT '0',
  `last_login_date` datetime DEFAULT NULL,
  `home_dir` varchar(256) NOT NULL DEFAULT '*DOCROOT/*USER',
  `restrict_to_home` char(1) NOT NULL DEFAULT '1',
  `file_permissions` int NOT NULL DEFAULT '3',
  `created_by` varchar(64) NOT NULL,
  `created_on` datetime NOT NULL,
  `modified_by` varchar(64) NOT NULL,
  `modified_on` datetime NOT NULL,
  `login_method` int NOT NULL DEFAULT '0',
  `user_pass_alg` int NOT NULL DEFAULT '-1',
  `pwd_changed_on` datetime DEFAULT NULL,
  `pwd_exp_sent_on` datetime DEFAULT NULL,
  `two_factor_type` char(1) DEFAULT NULL,
  `totp_secret` varchar(132) DEFAULT NULL,
  `user_phone` varchar(40) DEFAULT NULL,
  `sms_country_name` varchar(60) DEFAULT NULL,
  `mobile_phone` varchar(15) DEFAULT NULL,
  `auth_type` char(1) NOT NULL DEFAULT 'P',
  `san_dn_validations` int NOT NULL DEFAULT '0',
  `login_attempts` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `user_name_lc` (`user_name_lc`),
  CONSTRAINT `dpa_user_chk_1` CHECK ((`user_name_lc` = lower(`user_name`)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_user`
--

LOCK TABLES `dpa_user` WRITE;
/*!40000 ALTER TABLE `dpa_user` DISABLE KEYS */;
INSERT INTO `dpa_user` VALUES (101,'administrator','administrator','Administrator','$5$Xti8NdgP8sZBxnGr/8eScQ==$O70lYmdNzISjGfCPkzdMjlYVNx+IL4OaB7kMHx4johI=$i=1018$l=256',NULL,'0','1',NULL,'*DOCROOT/*USER','0',3,'system','2024-04-22 14:01:11','system','2024-04-22 14:01:11',101,7,'2024-04-22 14:01:11',NULL,NULL,NULL,NULL,NULL,NULL,'P',0,0),(102,'root','root','Root User (same as administrator)','$5$sPOzakx4VPramYOdRBAyfw==$swMqXPIV7gOhYTFlcCj2nqonzvnJB6dV74eIv1g02cA=$i=1018$l=256',NULL,'0','1',NULL,'*DOCROOT/*USER','0',3,'system','2024-04-22 14:01:11','system','2024-04-22 14:01:11',101,7,'2024-04-22 14:01:11',NULL,NULL,NULL,NULL,NULL,NULL,'P',0,0),(1001,'gaaabaclac','gaaabaclac',NULL,'$5$ce9NeaFP03W6DIMIinum2g==$DEyCbDldi1v8eLo6vuydIt3KW1f8Y2vMbHJYoUWxeiM=',NULL,'1','0','2025-03-21 17:55:39','*DOCROOT/*USER','0',3,'system','2024-06-10 19:49:12','system','2024-06-10 19:49:12',0,7,'2024-06-10 19:49:12',NULL,NULL,NULL,NULL,NULL,NULL,'P',0,0);
/*!40000 ALTER TABLE `dpa_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_user_domain`
--

DROP TABLE IF EXISTS `dpa_user_domain`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_user_domain` (
  `domain_id` int NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`user_id`,`domain_id`),
  KEY `domain_id` (`domain_id`),
  CONSTRAINT `dpa_user_domain_ibfk_1` FOREIGN KEY (`domain_id`) REFERENCES `dpa_domain` (`domain_id`),
  CONSTRAINT `dpa_user_domain_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `dpa_user` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_user_domain`
--

LOCK TABLES `dpa_user_domain` WRITE;
/*!40000 ALTER TABLE `dpa_user_domain` DISABLE KEYS */;
INSERT INTO `dpa_user_domain` VALUES (1,101),(1,102),(1,1001);
/*!40000 ALTER TABLE `dpa_user_domain` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_user_filter`
--

DROP TABLE IF EXISTS `dpa_user_filter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_user_filter` (
  `filter_id` int NOT NULL,
  `filter_name` varchar(50) NOT NULL,
  `filter_name_lc` varchar(50) NOT NULL,
  `page_id` int NOT NULL,
  `filter_def` mediumblob NOT NULL,
  `user_id` int NOT NULL,
  `created_on` datetime NOT NULL,
  `created_by` varchar(64) NOT NULL,
  `modified_on` datetime NOT NULL,
  `modified_by` varchar(64) NOT NULL,
  PRIMARY KEY (`filter_id`),
  UNIQUE KEY `filter_name_lc` (`filter_name_lc`,`page_id`,`user_id`),
  KEY `idx_dpa_user_filter_user_id` (`user_id`),
  KEY `idx_dpa_user_filter_page_id` (`page_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_user_filter`
--

LOCK TABLES `dpa_user_filter` WRITE;
/*!40000 ALTER TABLE `dpa_user_filter` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_user_filter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_user_fp`
--

DROP TABLE IF EXISTS `dpa_user_fp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_user_fp` (
  `user_id` int NOT NULL,
  `fingerprint` varchar(59) NOT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `fingerprint` (`fingerprint`),
  CONSTRAINT `dpa_user_fp_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `dpa_user` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_user_fp`
--

LOCK TABLES `dpa_user_fp` WRITE;
/*!40000 ALTER TABLE `dpa_user_fp` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_user_fp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_user_group`
--

DROP TABLE IF EXISTS `dpa_user_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_user_group` (
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`user_id`,`group_id`),
  KEY `group_id` (`group_id`),
  CONSTRAINT `dpa_user_group_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `dpa_user` (`user_id`) ON DELETE CASCADE,
  CONSTRAINT `dpa_user_group_ibfk_2` FOREIGN KEY (`group_id`) REFERENCES `dpa_group` (`group_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_user_group`
--

LOCK TABLES `dpa_user_group` WRITE;
/*!40000 ALTER TABLE `dpa_user_group` DISABLE KEYS */;
INSERT INTO `dpa_user_group` VALUES (101,101),(102,101),(1001,101);
/*!40000 ALTER TABLE `dpa_user_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_user_key`
--

DROP TABLE IF EXISTS `dpa_user_key`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_user_key` (
  `user_id` int NOT NULL,
  `secret_key` varchar(512) NOT NULL,
  PRIMARY KEY (`user_id`),
  CONSTRAINT `dpa_user_key_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `dpa_user` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_user_key`
--

LOCK TABLES `dpa_user_key` WRITE;
/*!40000 ALTER TABLE `dpa_user_key` DISABLE KEYS */;
INSERT INTO `dpa_user_key` VALUES (101,'*1:/VOgUZCoo4k3TwLeYoDErgJFas/xz7bl5VDhVankfN/t4PzHURLdnZoW1KOHTy7x'),(102,'*1:aKQTTsnXeoqhrnhWCJ35Pys0lpKrRIcXsbK+sgNvogZAznO5JgDPRc29H9oSLFNg'),(1001,'*1:Ukvq2uzfbNsK9i9DY8iyNja7FlLx22L/ud14wVcPdTnALjHDiEGZ8bqyfNOIiW8U');
/*!40000 ALTER TABLE `dpa_user_key` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_user_prefs`
--

DROP TABLE IF EXISTS `dpa_user_prefs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_user_prefs` (
  `user_id` int NOT NULL,
  `prefs_obj` mediumblob,
  PRIMARY KEY (`user_id`),
  CONSTRAINT `dpa_user_prefs_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `dpa_user` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_user_prefs`
--

LOCK TABLES `dpa_user_prefs` WRITE;
/*!40000 ALTER TABLE `dpa_user_prefs` DISABLE KEYS */;
INSERT INTO `dpa_user_prefs` VALUES (1001,_binary '<?xml version=\"1.0\" encoding=\"UTF-8\" ?>\r\n<preferences class=\"com.linoma.dpa.prefs.UserPreferences\">\r\n<dashboardPreferences>\r\n<lastVisitedDashboard>0</lastVisitedDashboard>\r\n</dashboardPreferences>\r\n<auditLogPreferences>\r\n<currentPage>/logs/GlobalSearch.xhtml</currentPage>\r\n</auditLogPreferences>\r\n</preferences>');
/*!40000 ALTER TABLE `dpa_user_prefs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_user_role`
--

DROP TABLE IF EXISTS `dpa_user_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_user_role` (
  `user_id` int NOT NULL,
  `role_id` int NOT NULL,
  PRIMARY KEY (`user_id`,`role_id`),
  KEY `role_id` (`role_id`),
  CONSTRAINT `dpa_user_role_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `dpa_user` (`user_id`) ON DELETE CASCADE,
  CONSTRAINT `dpa_user_role_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `dpa_role` (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_user_role`
--

LOCK TABLES `dpa_user_role` WRITE;
/*!40000 ALTER TABLE `dpa_user_role` DISABLE KEYS */;
INSERT INTO `dpa_user_role` VALUES (101,101),(102,101),(1001,101),(101,102),(102,102),(1001,102),(101,103),(102,103),(1001,103),(101,104),(102,104),(1001,104),(101,105),(102,105),(1001,105),(101,106),(102,106),(1001,106),(101,107),(102,107),(1001,107),(101,108),(102,108),(1001,108),(101,109),(102,109),(1001,109),(101,110),(102,110),(1001,110),(101,111),(102,111),(1001,111),(101,112),(102,112),(1001,112),(101,113),(102,113),(1001,113),(101,114),(102,114),(1001,114),(101,115),(102,115),(1001,115),(101,116),(102,116),(1001,116),(101,117),(102,117),(1001,117),(101,119),(102,119),(1001,119),(101,120),(102,120),(1001,120);
/*!40000 ALTER TABLE `dpa_user_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_username`
--

DROP TABLE IF EXISTS `dpa_username`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_username` (
  `user_id` int NOT NULL,
  `user_type` char(1) NOT NULL,
  `alias` varchar(64) NOT NULL,
  `alias_lc` varchar(64) NOT NULL,
  PRIMARY KEY (`user_type`,`alias_lc`),
  CONSTRAINT `dpa_username_chk_1` CHECK ((`alias_lc` = lower(`alias`)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_username`
--

LOCK TABLES `dpa_username` WRITE;
/*!40000 ALTER TABLE `dpa_username` DISABLE KEYS */;
INSERT INTO `dpa_username` VALUES (101,'A','administrator','administrator'),(1001,'A','gaaabaclac','gaaabaclac'),(102,'A','root','root'),(101,'W','anonymous','anonymous');
/*!40000 ALTER TABLE `dpa_username` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_virtual_file`
--

DROP TABLE IF EXISTS `dpa_virtual_file`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_virtual_file` (
  `vf_id` int NOT NULL,
  `vf_parent_id` int NOT NULL DEFAULT '-1',
  `vf_alias` varchar(128) DEFAULT NULL,
  `vf_path` varchar(256) DEFAULT NULL,
  `vf_desc` varchar(512) DEFAULT NULL,
  `vf_type` char(1) NOT NULL DEFAULT 'D',
  `vf_file_permissions` int NOT NULL DEFAULT '0',
  `vf_folder_permissions` int NOT NULL DEFAULT '0',
  `vf_apply_to_subfolders` char(1) NOT NULL DEFAULT '1',
  `vf_disk_quota_option` char(1) NOT NULL DEFAULT 'B',
  `vf_disk_quota_size` int NOT NULL DEFAULT '0',
  `vf_disk_quota_unit` char(1) NOT NULL DEFAULT 'M',
  PRIMARY KEY (`vf_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_virtual_file`
--

LOCK TABLES `dpa_virtual_file` WRITE;
/*!40000 ALTER TABLE `dpa_virtual_file` DISABLE KEYS */;
INSERT INTO `dpa_virtual_file` VALUES (101,-1,NULL,NULL,NULL,'D',0,0,'1','B',0,'M'),(103,-1,NULL,NULL,NULL,'D',0,0,'1','B',0,'M');
/*!40000 ALTER TABLE `dpa_virtual_file` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_virtual_file_group`
--

DROP TABLE IF EXISTS `dpa_virtual_file_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_virtual_file_group` (
  `group_id` int NOT NULL,
  `vf_id` int NOT NULL,
  PRIMARY KEY (`group_id`,`vf_id`),
  KEY `vf_id` (`vf_id`),
  CONSTRAINT `dpa_virtual_file_group_ibfk_1` FOREIGN KEY (`group_id`) REFERENCES `dpa_web_group` (`group_id`) ON DELETE CASCADE,
  CONSTRAINT `dpa_virtual_file_group_ibfk_2` FOREIGN KEY (`vf_id`) REFERENCES `dpa_virtual_file` (`vf_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_virtual_file_group`
--

LOCK TABLES `dpa_virtual_file_group` WRITE;
/*!40000 ALTER TABLE `dpa_virtual_file_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_virtual_file_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_virtual_file_template`
--

DROP TABLE IF EXISTS `dpa_virtual_file_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_virtual_file_template` (
  `template_id` int NOT NULL,
  `vf_id` int NOT NULL,
  PRIMARY KEY (`template_id`,`vf_id`),
  KEY `vf_id` (`vf_id`),
  CONSTRAINT `dpa_virtual_file_template_ibfk_1` FOREIGN KEY (`template_id`) REFERENCES `dpa_web_user_template` (`template_id`) ON DELETE CASCADE,
  CONSTRAINT `dpa_virtual_file_template_ibfk_2` FOREIGN KEY (`vf_id`) REFERENCES `dpa_virtual_file` (`vf_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_virtual_file_template`
--

LOCK TABLES `dpa_virtual_file_template` WRITE;
/*!40000 ALTER TABLE `dpa_virtual_file_template` DISABLE KEYS */;
INSERT INTO `dpa_virtual_file_template` VALUES (101,101);
/*!40000 ALTER TABLE `dpa_virtual_file_template` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_virtual_file_user`
--

DROP TABLE IF EXISTS `dpa_virtual_file_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_virtual_file_user` (
  `user_id` int NOT NULL,
  `vf_id` int NOT NULL,
  PRIMARY KEY (`user_id`,`vf_id`),
  KEY `vf_id` (`vf_id`),
  CONSTRAINT `dpa_virtual_file_user_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `dpa_web_user` (`user_id`) ON DELETE CASCADE,
  CONSTRAINT `dpa_virtual_file_user_ibfk_2` FOREIGN KEY (`vf_id`) REFERENCES `dpa_virtual_file` (`vf_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_virtual_file_user`
--

LOCK TABLES `dpa_virtual_file_user` WRITE;
/*!40000 ALTER TABLE `dpa_virtual_file_user` DISABLE KEYS */;
INSERT INTO `dpa_virtual_file_user` VALUES (101,103);
/*!40000 ALTER TABLE `dpa_virtual_file_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_wc_brand`
--

DROP TABLE IF EXISTS `dpa_wc_brand`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_wc_brand` (
  `brand_id` int NOT NULL,
  `brand_name` varchar(64) NOT NULL,
  `brand_name_lc` varchar(64) NOT NULL,
  `default_brand` char(1) NOT NULL,
  `created_by` varchar(64) NOT NULL,
  `created_on` datetime NOT NULL,
  `modified_by` varchar(64) NOT NULL,
  `modified_on` datetime NOT NULL,
  PRIMARY KEY (`brand_id`),
  UNIQUE KEY `brand_name_lc` (`brand_name_lc`),
  CONSTRAINT `dpa_wc_brand_chk_1` CHECK ((`brand_name_lc` = lower(`brand_name`)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_wc_brand`
--

LOCK TABLES `dpa_wc_brand` WRITE;
/*!40000 ALTER TABLE `dpa_wc_brand` DISABLE KEYS */;
INSERT INTO `dpa_wc_brand` VALUES (101,'Default','default','1','system','2024-04-22 14:01:12','system','2024-04-22 14:01:12');
/*!40000 ALTER TABLE `dpa_wc_brand` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_wc_brand_setting`
--

DROP TABLE IF EXISTS `dpa_wc_brand_setting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_wc_brand_setting` (
  `brand_id` int NOT NULL,
  `setting_name` varchar(100) NOT NULL,
  `setting_value` varchar(2000) NOT NULL,
  PRIMARY KEY (`brand_id`,`setting_name`),
  CONSTRAINT `dpa_wc_brand_setting_ibfk_1` FOREIGN KEY (`brand_id`) REFERENCES `dpa_wc_brand` (`brand_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_wc_brand_setting`
--

LOCK TABLES `dpa_wc_brand_setting` WRITE;
/*!40000 ALTER TABLE `dpa_wc_brand_setting` DISABLE KEYS */;
INSERT INTO `dpa_wc_brand_setting` VALUES (101,'ghttps.da.clientTitle',' '),(101,'ghttps.da.disclaimerDescription',' '),(101,'ghttps.da.disclaimerHeading',' '),(101,'ghttps.da.disclaimerLink',' '),(101,'ghttps.da.displayDisclaimer','false'),(101,'ghttps.da.enabled','false'),(101,'ghttps.de.clientTitle',' '),(101,'ghttps.de.disclaimerDescription',' '),(101,'ghttps.de.disclaimerHeading',' '),(101,'ghttps.de.disclaimerLink',' '),(101,'ghttps.de.displayDisclaimer','false'),(101,'ghttps.de.enabled','false'),(101,'ghttps.en.clientTitle','GoAnywhere Web Client'),(101,'ghttps.en.disclaimerDescription','By clicking the Login button you acknowledge that you have read the <link>disclaimer</link>.'),(101,'ghttps.en.disclaimerHeading',' '),(101,'ghttps.en.disclaimerLink',' '),(101,'ghttps.en.displayDisclaimer','false'),(101,'ghttps.en.enabled','true'),(101,'ghttps.es.clientTitle',' '),(101,'ghttps.es.disclaimerDescription',' '),(101,'ghttps.es.disclaimerHeading',' '),(101,'ghttps.es.disclaimerLink',' '),(101,'ghttps.es.displayDisclaimer','false'),(101,'ghttps.es.enabled','false'),(101,'ghttps.fr.clientTitle',' '),(101,'ghttps.fr.disclaimerDescription',' '),(101,'ghttps.fr.disclaimerHeading',' '),(101,'ghttps.fr.disclaimerLink',' '),(101,'ghttps.fr.displayDisclaimer','false'),(101,'ghttps.fr.enabled','false'),(101,'ghttps.hu.clientTitle',' '),(101,'ghttps.hu.disclaimerDescription',' '),(101,'ghttps.hu.disclaimerHeading',' '),(101,'ghttps.hu.disclaimerLink',' '),(101,'ghttps.hu.displayDisclaimer','false'),(101,'ghttps.hu.enabled','false'),(101,'ghttps.in.clientTitle',' '),(101,'ghttps.in.disclaimerDescription',' '),(101,'ghttps.in.disclaimerHeading',' '),(101,'ghttps.in.disclaimerLink',' '),(101,'ghttps.in.displayDisclaimer','false'),(101,'ghttps.in.enabled','false'),(101,'ghttps.it.clientTitle',' '),(101,'ghttps.it.disclaimerDescription',' '),(101,'ghttps.it.disclaimerHeading',' '),(101,'ghttps.it.disclaimerLink',' '),(101,'ghttps.it.displayDisclaimer','false'),(101,'ghttps.it.enabled','false'),(101,'ghttps.ja.clientTitle',' '),(101,'ghttps.ja.disclaimerDescription',' '),(101,'ghttps.ja.disclaimerHeading',' '),(101,'ghttps.ja.disclaimerLink',' '),(101,'ghttps.ja.displayDisclaimer','false'),(101,'ghttps.ja.enabled','false'),(101,'ghttps.nl.clientTitle',' '),(101,'ghttps.nl.disclaimerDescription',' '),(101,'ghttps.nl.disclaimerHeading',' '),(101,'ghttps.nl.disclaimerLink',' '),(101,'ghttps.nl.displayDisclaimer','false'),(101,'ghttps.nl.enabled','false'),(101,'ghttps.pt.clientTitle',' '),(101,'ghttps.pt.disclaimerDescription',' '),(101,'ghttps.pt.disclaimerHeading',' '),(101,'ghttps.pt.disclaimerLink',' '),(101,'ghttps.pt.displayDisclaimer','false'),(101,'ghttps.pt.enabled','false'),(101,'ghttps.style.head.logo.file',' '),(101,'ghttps.style.head.logo.type','D'),(101,'ghttps.style.login.logo.file',' '),(101,'ghttps.style.login.logo.type','D'),(101,'ghttps.zh.clientTitle',' '),(101,'ghttps.zh.disclaimerDescription',' '),(101,'ghttps.zh.disclaimerHeading',' '),(101,'ghttps.zh.disclaimerLink',' '),(101,'ghttps.zh.displayDisclaimer','false'),(101,'ghttps.zh.enabled','false');
/*!40000 ALTER TABLE `dpa_wc_brand_setting` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_wc_link`
--

DROP TABLE IF EXISTS `dpa_wc_link`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_wc_link` (
  `link_uuid` varchar(36) NOT NULL,
  `link_type` char(1) NOT NULL,
  `link_ref` varchar(36) NOT NULL,
  `link_settings` mediumblob,
  `created_by_id` int NOT NULL,
  `created_by` varchar(64) NOT NULL,
  `created_on` datetime NOT NULL,
  PRIMARY KEY (`link_uuid`),
  KEY `idx_dpa_wc_link` (`link_ref`,`link_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_wc_link`
--

LOCK TABLES `dpa_wc_link` WRITE;
/*!40000 ALTER TABLE `dpa_wc_link` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_wc_link` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_web_group`
--

DROP TABLE IF EXISTS `dpa_web_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_web_group` (
  `group_id` int NOT NULL,
  `group_name` varchar(50) NOT NULL,
  `group_name_lc` varchar(50) NOT NULL,
  `group_desc` varchar(512) DEFAULT NULL,
  `sys_group` char(1) NOT NULL DEFAULT '0',
  `service_permissions` int NOT NULL DEFAULT '7',
  `created_by` varchar(64) NOT NULL,
  `created_on` datetime NOT NULL,
  `modified_by` varchar(64) NOT NULL,
  `modified_on` datetime NOT NULL,
  `change_password_permission` char(1) NOT NULL DEFAULT '1',
  `secure_mail_permission` int NOT NULL DEFAULT '0',
  `invite_user_permission` char(1) NOT NULL DEFAULT '0',
  `view_activity_permission` char(1) NOT NULL DEFAULT '0',
  `login_method_id` int NOT NULL DEFAULT '-1',
  `ldap_group_dn` varchar(256) DEFAULT NULL,
  `go_drive_permission` char(1) NOT NULL DEFAULT '0',
  `gd_access` char(1) NOT NULL DEFAULT 'F',
  `secure_folder_permission` char(1) NOT NULL DEFAULT '0',
  `gd_limit_space` char(1) NOT NULL DEFAULT 'B',
  `gd_disk_quota` int NOT NULL DEFAULT '5',
  `gd_disk_quota_unit` char(1) NOT NULL DEFAULT 'G',
  `domain_id` int NOT NULL DEFAULT '1',
  `secure_form_permission` char(1) NOT NULL DEFAULT '0',
  `gd_link_permission` char(1) NOT NULL DEFAULT '0',
  `personal_address_book` char(1) NOT NULL DEFAULT '1',
  `address_book_restriction` char(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`group_id`),
  UNIQUE KEY `group_name_lc` (`group_name_lc`),
  CONSTRAINT `dpa_web_group_chk_1` CHECK ((`group_name_lc` = lower(`group_name`)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_web_group`
--

LOCK TABLES `dpa_web_group` WRITE;
/*!40000 ALTER TABLE `dpa_web_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_web_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_web_user`
--

DROP TABLE IF EXISTS `dpa_web_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_web_user` (
  `user_id` int NOT NULL,
  `user_name` varchar(64) NOT NULL,
  `user_name_lc` varchar(64) NOT NULL,
  `user_fname` varchar(60) DEFAULT NULL,
  `user_lname` varchar(60) DEFAULT NULL,
  `user_desc` varchar(512) DEFAULT NULL,
  `user_email` varchar(128) DEFAULT NULL,
  `user_org` varchar(60) DEFAULT NULL,
  `user_phone` varchar(40) DEFAULT NULL,
  `user_pass` varchar(128) DEFAULT NULL,
  `ghttps_auth_type` char(1) NOT NULL DEFAULT 'E',
  `gftps_auth_type` char(1) NOT NULL DEFAULT 'P',
  `gsftp_auth_type` char(1) NOT NULL DEFAULT 'E',
  `enabled` char(1) NOT NULL DEFAULT '1',
  `expires_on` datetime DEFAULT NULL,
  `pwd_exp_interval` int DEFAULT NULL,
  `pwd_changed_on` datetime DEFAULT NULL,
  `force_pwd_change` char(1) DEFAULT '0',
  `service_permissions` int NOT NULL DEFAULT '7',
  `last_login_date` datetime DEFAULT NULL,
  `login_attempts` int NOT NULL DEFAULT '0',
  `created_by` varchar(64) NOT NULL,
  `created_on` datetime NOT NULL,
  `modified_by` varchar(64) NOT NULL,
  `modified_on` datetime NOT NULL,
  `ip_filter_enabled` char(1) NOT NULL DEFAULT '0',
  `ip_filter_type` char(1) NOT NULL DEFAULT 'A',
  `login_method` int NOT NULL DEFAULT '0',
  `inactive_days` int NOT NULL DEFAULT '-1',
  `gftpes_auth_type` char(1) NOT NULL DEFAULT 'P',
  `ftpes_fingerprint` varchar(59) DEFAULT NULL,
  `ftps_fingerprint` varchar(59) DEFAULT NULL,
  `change_password_permission` char(1) NOT NULL DEFAULT '1',
  `as2_id` varchar(128) DEFAULT NULL,
  `as2_signature_alias` varchar(128) DEFAULT NULL,
  `as2_upload_dir` varchar(256) DEFAULT NULL,
  `as2_when_file_exist` int NOT NULL DEFAULT '-1',
  `as2_require_encryption` char(1) DEFAULT NULL,
  `as2_require_signature` char(1) DEFAULT NULL,
  `as2_mdn_approval` char(1) DEFAULT NULL,
  `secure_mail_permission` int NOT NULL DEFAULT '0',
  `approved` char(1) NOT NULL DEFAULT '1',
  `approved_by` varchar(64) DEFAULT NULL,
  `approved_on` datetime DEFAULT NULL,
  `pwd_exp_sent_on` datetime DEFAULT NULL,
  `max_sessions` int NOT NULL DEFAULT '-1',
  `invite_user_permission` char(1) NOT NULL DEFAULT '0',
  `invited_by` varchar(64) DEFAULT NULL,
  `invited_on` datetime DEFAULT NULL,
  `limit_time` int NOT NULL DEFAULT '0',
  `limit_time_start` varchar(4) DEFAULT NULL,
  `limit_time_end` varchar(4) DEFAULT NULL,
  `limit_days` int NOT NULL DEFAULT '0',
  `limit_days_of_week` int NOT NULL DEFAULT '0',
  `view_activity_permission` char(1) NOT NULL DEFAULT '0',
  `user_pass_alg` int NOT NULL DEFAULT '-1',
  `uek` varchar(256) DEFAULT NULL,
  `uek_iv` varchar(256) DEFAULT NULL,
  `go_drive_permission` char(1) NOT NULL DEFAULT '0',
  `gd_access` char(1) NOT NULL DEFAULT 'F',
  `secure_folder_permission` char(1) NOT NULL DEFAULT '0',
  `gd_limit_space` char(1) NOT NULL DEFAULT 'B',
  `gd_disk_quota` int NOT NULL DEFAULT '5',
  `gd_disk_quota_unit` char(1) NOT NULL DEFAULT 'G',
  `gd_lic_activation` datetime DEFAULT NULL,
  `as2_require_authentication` char(1) DEFAULT NULL,
  `gas2_auth_type` char(1) NOT NULL DEFAULT 'P',
  `as2_fingerprint` varchar(59) DEFAULT NULL,
  `past_expiration` char(1) NOT NULL DEFAULT '0',
  `as2_mdn_signature_alg_format` char(1) DEFAULT NULL,
  `ghttps_two_factor_type` char(1) DEFAULT NULL,
  `gofast_auth_type` char(1) NOT NULL DEFAULT 'P',
  `gofast_fingerprint` varchar(59) DEFAULT NULL,
  `domain_id` int NOT NULL DEFAULT '1',
  `secure_form_permission` char(1) NOT NULL DEFAULT '0',
  `certificate_key_location` char(1) NOT NULL DEFAULT '0',
  `certificate_key_vault_name` varchar(50) DEFAULT NULL,
  `as2_signature_key_location` char(1) NOT NULL DEFAULT '0',
  `as2_signature_key_vault_name` varchar(50) DEFAULT NULL,
  `as2_signature_key_name` varchar(128) DEFAULT NULL,
  `gd_link_permission` char(1) NOT NULL DEFAULT '0',
  `totp_secret` varchar(132) DEFAULT NULL,
  `sms_country_name` varchar(60) DEFAULT NULL,
  `mobile_phone` varchar(15) DEFAULT NULL,
  `personal_address_book` char(1) NOT NULL DEFAULT '1',
  `address_book_restriction` char(1) NOT NULL DEFAULT '0',
  `sm_lic_activation` datetime DEFAULT NULL,
  `pesit_auth_type` char(1) NOT NULL DEFAULT 'P',
  `pesit_fingerprint` varchar(59) DEFAULT NULL,
  `pesit_enabled` char(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `user_name_lc` (`user_name_lc`),
  CONSTRAINT `dpa_web_user_chk_1` CHECK ((`user_name_lc` = lower(`user_name`))),
  CONSTRAINT `dpa_web_user_chk_2` CHECK ((`ghttps_auth_type` in (_utf8mb4'C',_utf8mb4'E',_utf8mb4'P'))),
  CONSTRAINT `dpa_web_user_chk_3` CHECK ((`gftpes_auth_type` in (_utf8mb4'B',_utf8mb4'C',_utf8mb4'E',_utf8mb4'P'))),
  CONSTRAINT `dpa_web_user_chk_4` CHECK ((`gftps_auth_type` in (_utf8mb4'B',_utf8mb4'C',_utf8mb4'E',_utf8mb4'P'))),
  CONSTRAINT `dpa_web_user_chk_5` CHECK ((`gsftp_auth_type` in (_utf8mb4'B',_utf8mb4'E',_utf8mb4'K',_utf8mb4'P'))),
  CONSTRAINT `dpa_web_user_chk_6` CHECK ((`force_pwd_change` in (_utf8mb4'0',_utf8mb4'1'))),
  CONSTRAINT `dpa_web_user_chk_7` CHECK ((`gas2_auth_type` in (_utf8mb4'B',_utf8mb4'C',_utf8mb4'E',_utf8mb4'P'))),
  CONSTRAINT `dpa_web_user_chk_8` CHECK ((`gofast_auth_type` in (_utf8mb4'B',_utf8mb4'C',_utf8mb4'E',_utf8mb4'P'))),
  CONSTRAINT `dpa_web_user_chk_9` CHECK ((`pesit_auth_type` in (_utf8mb4'B',_utf8mb4'C',_utf8mb4'E',_utf8mb4'P')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_web_user`
--

LOCK TABLES `dpa_web_user` WRITE;
/*!40000 ALTER TABLE `dpa_web_user` DISABLE KEYS */;
INSERT INTO `dpa_web_user` VALUES (101,'anonymous','anonymous',' ',' ',' ',' ',' ',' ',NULL,'P','P','P','0',NULL,-1,'2024-04-22 14:01:11','0',0,NULL,0,'system','2024-04-22 14:01:11','system','2024-04-22 14:01:11','0','A',100,-1,'P',NULL,NULL,'0',' ',' ',NULL,-1,NULL,NULL,NULL,0,'1',NULL,NULL,NULL,-1,'0',NULL,NULL,0,NULL,NULL,0,0,'0',-1,NULL,NULL,'0','F','0','B',5,'G',NULL,NULL,'P',NULL,'0',NULL,NULL,'P',NULL,1,'0','1',NULL,'1',NULL,NULL,'0',NULL,NULL,NULL,'1','0',NULL,'P',NULL,'0');
/*!40000 ALTER TABLE `dpa_web_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_web_user_cidr`
--

DROP TABLE IF EXISTS `dpa_web_user_cidr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_web_user_cidr` (
  `user_id` int NOT NULL,
  `cidr` varchar(64) DEFAULT NULL,
  KEY `user_id` (`user_id`),
  CONSTRAINT `dpa_web_user_cidr_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `dpa_web_user` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_web_user_cidr`
--

LOCK TABLES `dpa_web_user_cidr` WRITE;
/*!40000 ALTER TABLE `dpa_web_user_cidr` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_web_user_cidr` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_web_user_ext`
--

DROP TABLE IF EXISTS `dpa_web_user_ext`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_web_user_ext` (
  `entity_id` int NOT NULL,
  `entity_type` varchar(30) NOT NULL,
  `attribute_key` varchar(100) NOT NULL,
  `attribute_value` varchar(2000) DEFAULT NULL,
  PRIMARY KEY (`entity_id`,`entity_type`,`attribute_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_web_user_ext`
--

LOCK TABLES `dpa_web_user_ext` WRITE;
/*!40000 ALTER TABLE `dpa_web_user_ext` DISABLE KEYS */;
INSERT INTO `dpa_web_user_ext` VALUES (101,'web.user','as4.authType','P'),(101,'web.user.template','as4.authType','P');
/*!40000 ALTER TABLE `dpa_web_user_ext` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_web_user_group`
--

DROP TABLE IF EXISTS `dpa_web_user_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_web_user_group` (
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`user_id`,`group_id`),
  KEY `group_id` (`group_id`),
  CONSTRAINT `dpa_web_user_group_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `dpa_web_user` (`user_id`) ON DELETE CASCADE,
  CONSTRAINT `dpa_web_user_group_ibfk_2` FOREIGN KEY (`group_id`) REFERENCES `dpa_web_group` (`group_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_web_user_group`
--

LOCK TABLES `dpa_web_user_group` WRITE;
/*!40000 ALTER TABLE `dpa_web_user_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_web_user_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_web_user_ip_filter`
--

DROP TABLE IF EXISTS `dpa_web_user_ip_filter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_web_user_ip_filter` (
  `user_id` int NOT NULL,
  `entry_def` varchar(128) NOT NULL,
  PRIMARY KEY (`user_id`,`entry_def`),
  CONSTRAINT `dpa_web_user_ip_filter_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `dpa_web_user` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_web_user_ip_filter`
--

LOCK TABLES `dpa_web_user_ip_filter` WRITE;
/*!40000 ALTER TABLE `dpa_web_user_ip_filter` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_web_user_ip_filter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_web_user_template`
--

DROP TABLE IF EXISTS `dpa_web_user_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_web_user_template` (
  `template_id` int NOT NULL,
  `template_name` varchar(50) NOT NULL,
  `template_name_lc` varchar(50) NOT NULL,
  `template_desc` varchar(512) DEFAULT NULL,
  `ghttps_auth_type` char(1) NOT NULL DEFAULT 'P',
  `gftps_auth_type` char(1) NOT NULL DEFAULT 'P',
  `gsftp_auth_type` char(1) NOT NULL DEFAULT 'P',
  `pwd_exp_interval` int DEFAULT NULL,
  `force_pwd_change` char(1) DEFAULT '0',
  `service_permissions` int NOT NULL DEFAULT '7',
  `created_by` varchar(64) NOT NULL,
  `created_on` datetime NOT NULL,
  `modified_by` varchar(64) NOT NULL,
  `modified_on` datetime NOT NULL,
  `ip_filter_enabled` char(1) NOT NULL DEFAULT '0',
  `ip_filter_type` char(1) NOT NULL DEFAULT 'A',
  `generate_pwd` char(1) NOT NULL DEFAULT '1',
  `display_pwd` char(1) NOT NULL DEFAULT '1',
  `email_pwd` char(1) NOT NULL DEFAULT '1',
  `expires_after` int NOT NULL DEFAULT '0',
  `login_method` int NOT NULL DEFAULT '0',
  `inactive_days` int NOT NULL DEFAULT '-1',
  `gftpes_auth_type` char(1) NOT NULL DEFAULT 'P',
  `change_password_permission` char(1) NOT NULL DEFAULT '1',
  `as2_upload_dir` varchar(256) DEFAULT NULL,
  `as2_when_file_exist` int NOT NULL DEFAULT '-1',
  `as2_require_encryption` char(1) DEFAULT NULL,
  `as2_require_signature` char(1) DEFAULT NULL,
  `as2_mdn_approval` char(1) DEFAULT NULL,
  `secure_mail_permission` int NOT NULL DEFAULT '0',
  `max_sessions` int NOT NULL DEFAULT '-1',
  `invite_user_permission` char(1) NOT NULL DEFAULT '0',
  `limit_time` int NOT NULL DEFAULT '0',
  `limit_time_start` varchar(4) DEFAULT NULL,
  `limit_time_end` varchar(4) DEFAULT NULL,
  `limit_days` int NOT NULL DEFAULT '0',
  `limit_days_of_week` int NOT NULL DEFAULT '0',
  `view_activity_permission` char(1) NOT NULL DEFAULT '0',
  `go_drive_permission` char(1) NOT NULL DEFAULT '0',
  `gd_access` char(1) NOT NULL DEFAULT 'F',
  `secure_folder_permission` char(1) NOT NULL DEFAULT '0',
  `gd_limit_space` char(1) NOT NULL DEFAULT 'B',
  `gd_disk_quota` int NOT NULL DEFAULT '5',
  `gd_disk_quota_unit` char(1) NOT NULL DEFAULT 'G',
  `as2_require_authentication` char(1) DEFAULT NULL,
  `gas2_auth_type` char(1) NOT NULL DEFAULT 'P',
  `as2_mdn_signature_alg_format` char(1) DEFAULT NULL,
  `ghttps_two_factor_type` char(1) DEFAULT NULL,
  `gofast_auth_type` char(1) NOT NULL DEFAULT 'P',
  `domain_id` int NOT NULL DEFAULT '1',
  `secure_form_permission` char(1) NOT NULL DEFAULT '0',
  `certificate_key_location` char(1) NOT NULL DEFAULT '0',
  `certificate_key_vault_name` varchar(50) DEFAULT NULL,
  `as2_signature_key_location` char(1) NOT NULL DEFAULT '0',
  `as2_signature_key_vault_name` varchar(50) DEFAULT NULL,
  `gd_link_permission` char(1) NOT NULL DEFAULT '0',
  `personal_address_book` char(1) NOT NULL DEFAULT '1',
  `address_book_restriction` char(1) NOT NULL DEFAULT '0',
  `pesit_auth_type` char(1) NOT NULL DEFAULT 'P',
  PRIMARY KEY (`template_id`),
  UNIQUE KEY `template_name_lc` (`template_name_lc`),
  CONSTRAINT `dpa_web_user_template_chk_1` CHECK ((`template_name_lc` = lower(`template_name`))),
  CONSTRAINT `dpa_web_user_template_chk_10` CHECK ((`gas2_auth_type` in (_utf8mb4'B',_utf8mb4'C',_utf8mb4'E',_utf8mb4'P'))),
  CONSTRAINT `dpa_web_user_template_chk_11` CHECK ((`gofast_auth_type` in (_utf8mb4'B',_utf8mb4'C',_utf8mb4'E',_utf8mb4'P'))),
  CONSTRAINT `dpa_web_user_template_chk_12` CHECK ((`pesit_auth_type` in (_utf8mb4'B',_utf8mb4'C',_utf8mb4'E',_utf8mb4'P'))),
  CONSTRAINT `dpa_web_user_template_chk_2` CHECK ((`ghttps_auth_type` in (_utf8mb4'C',_utf8mb4'E',_utf8mb4'P'))),
  CONSTRAINT `dpa_web_user_template_chk_3` CHECK ((`gftpes_auth_type` in (_utf8mb4'B',_utf8mb4'C',_utf8mb4'E',_utf8mb4'P'))),
  CONSTRAINT `dpa_web_user_template_chk_4` CHECK ((`gftps_auth_type` in (_utf8mb4'B',_utf8mb4'C',_utf8mb4'E',_utf8mb4'P'))),
  CONSTRAINT `dpa_web_user_template_chk_5` CHECK ((`gsftp_auth_type` in (_utf8mb4'B',_utf8mb4'E',_utf8mb4'K',_utf8mb4'P'))),
  CONSTRAINT `dpa_web_user_template_chk_6` CHECK ((`force_pwd_change` in (_utf8mb4'0',_utf8mb4'1'))),
  CONSTRAINT `dpa_web_user_template_chk_7` CHECK ((`generate_pwd` in (_utf8mb4'0',_utf8mb4'1'))),
  CONSTRAINT `dpa_web_user_template_chk_8` CHECK ((`display_pwd` in (_utf8mb4'0',_utf8mb4'1'))),
  CONSTRAINT `dpa_web_user_template_chk_9` CHECK ((`email_pwd` in (_utf8mb4'0',_utf8mb4'1')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_web_user_template`
--

LOCK TABLES `dpa_web_user_template` WRITE;
/*!40000 ALTER TABLE `dpa_web_user_template` DISABLE KEYS */;
INSERT INTO `dpa_web_user_template` VALUES (101,'Web User Template','web user template','This is the default template shipped with GoAnywhere','P','P','P',-1,'0',0,'system','2024-04-22 14:01:11','system','2024-04-22 14:01:11','0','A','1','1','0',0,0,-1,'P','0',NULL,-1,NULL,NULL,NULL,0,-1,'0',0,NULL,NULL,0,0,'0','0','F','0','B',5,'G',NULL,'P',NULL,NULL,'P',1,'0','1',NULL,'1',NULL,'0','1','0','P');
/*!40000 ALTER TABLE `dpa_web_user_template` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_web_user_template_group`
--

DROP TABLE IF EXISTS `dpa_web_user_template_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_web_user_template_group` (
  `template_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`template_id`,`group_id`),
  KEY `group_id` (`group_id`),
  CONSTRAINT `dpa_web_user_template_group_ibfk_1` FOREIGN KEY (`template_id`) REFERENCES `dpa_web_user_template` (`template_id`) ON DELETE CASCADE,
  CONSTRAINT `dpa_web_user_template_group_ibfk_2` FOREIGN KEY (`group_id`) REFERENCES `dpa_web_group` (`group_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_web_user_template_group`
--

LOCK TABLES `dpa_web_user_template_group` WRITE;
/*!40000 ALTER TABLE `dpa_web_user_template_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_web_user_template_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_web_user_template_ip_fltr`
--

DROP TABLE IF EXISTS `dpa_web_user_template_ip_fltr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_web_user_template_ip_fltr` (
  `template_id` int NOT NULL,
  `entry_def` varchar(128) NOT NULL,
  PRIMARY KEY (`template_id`,`entry_def`),
  CONSTRAINT `dpa_web_user_template_ip_fltr_ibfk_1` FOREIGN KEY (`template_id`) REFERENCES `dpa_web_user_template` (`template_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_web_user_template_ip_fltr`
--

LOCK TABLES `dpa_web_user_template_ip_fltr` WRITE;
/*!40000 ALTER TABLE `dpa_web_user_template_ip_fltr` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_web_user_template_ip_fltr` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_wu_fp_req`
--

DROP TABLE IF EXISTS `dpa_wu_fp_req`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_wu_fp_req` (
  `user_id` int NOT NULL,
  `token` varchar(36) NOT NULL,
  `created_on` datetime NOT NULL,
  PRIMARY KEY (`user_id`),
  CONSTRAINT `dpa_wu_fp_req_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `dpa_web_user` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_wu_fp_req`
--

LOCK TABLES `dpa_wu_fp_req` WRITE;
/*!40000 ALTER TABLE `dpa_wu_fp_req` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_wu_fp_req` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_wu_https_fp`
--

DROP TABLE IF EXISTS `dpa_wu_https_fp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_wu_https_fp` (
  `user_id` int NOT NULL,
  `https_fingerprint` varchar(59) NOT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `https_fingerprint` (`https_fingerprint`),
  CONSTRAINT `dpa_wu_https_fp_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `dpa_web_user` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_wu_https_fp`
--

LOCK TABLES `dpa_wu_https_fp` WRITE;
/*!40000 ALTER TABLE `dpa_wu_https_fp` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_wu_https_fp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_wu_kms_ssh_key`
--

DROP TABLE IF EXISTS `dpa_wu_kms_ssh_key`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_wu_kms_ssh_key` (
  `user_id` int NOT NULL,
  `key_id` varchar(36) NOT NULL,
  PRIMARY KEY (`user_id`,`key_id`),
  KEY `key_id` (`key_id`),
  CONSTRAINT `dpa_wu_kms_ssh_key_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `dpa_web_user` (`user_id`) ON DELETE CASCADE,
  CONSTRAINT `dpa_wu_kms_ssh_key_ibfk_2` FOREIGN KEY (`key_id`) REFERENCES `dpa_kms_ssh_key` (`key_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_wu_kms_ssh_key`
--

LOCK TABLES `dpa_wu_kms_ssh_key` WRITE;
/*!40000 ALTER TABLE `dpa_wu_kms_ssh_key` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_wu_kms_ssh_key` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_wu_pass_hist`
--

DROP TABLE IF EXISTS `dpa_wu_pass_hist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_wu_pass_hist` (
  `hist_id` int NOT NULL,
  `user_id` int NOT NULL,
  `pass_val` varchar(128) NOT NULL,
  `created_on` datetime NOT NULL,
  `pass_val_alg` int NOT NULL DEFAULT '-1',
  PRIMARY KEY (`hist_id`),
  KEY `idx_dpa_wu_pass_hist` (`user_id`),
  CONSTRAINT `dpa_wu_pass_hist_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `dpa_web_user` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_wu_pass_hist`
--

LOCK TABLES `dpa_wu_pass_hist` WRITE;
/*!40000 ALTER TABLE `dpa_wu_pass_hist` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_wu_pass_hist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_wu_preference`
--

DROP TABLE IF EXISTS `dpa_wu_preference`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_wu_preference` (
  `user_id` int NOT NULL,
  `pref_type` char(1) NOT NULL,
  `pref_name` varchar(50) NOT NULL,
  `pref_value` varchar(2000) DEFAULT NULL,
  PRIMARY KEY (`user_id`,`pref_type`,`pref_name`),
  CONSTRAINT `dpa_wu_preference_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `dpa_web_user` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_wu_preference`
--

LOCK TABLES `dpa_wu_preference` WRITE;
/*!40000 ALTER TABLE `dpa_wu_preference` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_wu_preference` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_wu_recent_contact`
--

DROP TABLE IF EXISTS `dpa_wu_recent_contact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_wu_recent_contact` (
  `user_id` int NOT NULL,
  `recent_email` varchar(128) NOT NULL,
  `last_used` datetime NOT NULL,
  `recent_sms_country_name` varchar(60) DEFAULT NULL,
  `recent_sms_phone` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`user_id`,`recent_email`),
  CONSTRAINT `dpa_wu_recent_contact_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `dpa_web_user` (`user_id`) ON DELETE CASCADE,
  CONSTRAINT `dpa_wu_recent_contact_chk_1` CHECK ((`recent_email` = lower(`recent_email`)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_wu_recent_contact`
--

LOCK TABLES `dpa_wu_recent_contact` WRITE;
/*!40000 ALTER TABLE `dpa_wu_recent_contact` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_wu_recent_contact` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dpa_wu_reg_req`
--

DROP TABLE IF EXISTS `dpa_wu_reg_req`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dpa_wu_reg_req` (
  `token` varchar(36) NOT NULL,
  `email` varchar(128) NOT NULL,
  `created_on` datetime NOT NULL,
  `invited_by` varchar(64) DEFAULT NULL,
  `virtual_file_id` int NOT NULL DEFAULT '0',
  `recipient_id` varchar(36) DEFAULT NULL,
  `user_id` int NOT NULL DEFAULT '0',
  `verification_code` varchar(36) DEFAULT NULL,
  `invited_by_id` int DEFAULT NULL,
  `gdi_id` int DEFAULT NULL,
  `gdi_role_id` int DEFAULT NULL,
  `gdi_shared_name` varchar(128) DEFAULT NULL,
  `sf_id` int DEFAULT NULL,
  `sf_permissions` int DEFAULT NULL,
  `sf_name` varchar(128) DEFAULT NULL,
  `sf_subfolder_access` char(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`token`),
  KEY `idx_dpa_wu_reg_req_email` (`email`),
  KEY `idx_dpa_wu_reg_req_gd` (`gdi_id`,`created_on`,`invited_by_id`),
  KEY `idx_dpa_wu_reg_req_sf` (`sf_id`,`created_on`,`invited_by_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dpa_wu_reg_req`
--

LOCK TABLES `dpa_wu_reg_req` WRITE;
/*!40000 ALTER TABLE `dpa_wu_reg_req` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpa_wu_reg_req` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-03-27 19:20:54
