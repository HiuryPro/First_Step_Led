-- MariaDB dump 10.19  Distrib 10.4.24-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: teagames
-- ------------------------------------------------------
-- Server version	10.4.24-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `fases_memoria`
--

DROP TABLE IF EXISTS `fases_memoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fases_memoria` (
  `ID_USUARIO` int(11) NOT NULL,
  `FASE_1` bit(1) NOT NULL DEFAULT b'0',
  `FASE_2` bit(1) NOT NULL DEFAULT b'0',
  `FASE_3` bit(1) NOT NULL DEFAULT b'0',
  `FASE_4` bit(1) NOT NULL DEFAULT b'0',
  `FASE_5` bit(1) NOT NULL DEFAULT b'0',
  `FASE_6` bit(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`ID_USUARIO`),
  CONSTRAINT `fases_memoria_ibfk_1` FOREIGN KEY (`ID_USUARIO`) REFERENCES `usuario` (`ID_USUARIO`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fases_memoria_ibfk_2` FOREIGN KEY (`ID_USUARIO`) REFERENCES `usuario` (`ID_USUARIO`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fases_memoria`
--

LOCK TABLES `fases_memoria` WRITE;
/*!40000 ALTER TABLE `fases_memoria` DISABLE KEYS */;
INSERT INTO `fases_memoria` VALUES (1,'\0','\0','\0','\0','\0','\0'),(3,'\0','\0','\0','\0','\0','\0'),(5,'','','\0','','\0','\0');
/*!40000 ALTER TABLE `fases_memoria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fases_pareamento`
--

DROP TABLE IF EXISTS `fases_pareamento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fases_pareamento` (
  `ID_USUARIO` int(11) NOT NULL,
  `FASE_1` bit(1) NOT NULL DEFAULT b'0',
  `FASE_2` bit(1) NOT NULL DEFAULT b'0',
  `FASE_3` bit(1) NOT NULL DEFAULT b'0',
  `FASE_4` bit(1) NOT NULL DEFAULT b'0',
  `FASE_5` bit(1) NOT NULL DEFAULT b'0',
  `FASE_6` bit(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`ID_USUARIO`),
  CONSTRAINT `fases_pareamento_ibfk_1` FOREIGN KEY (`ID_USUARIO`) REFERENCES `usuario` (`ID_USUARIO`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fases_pareamento_ibfk_2` FOREIGN KEY (`ID_USUARIO`) REFERENCES `usuario` (`ID_USUARIO`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fases_pareamento`
--

LOCK TABLES `fases_pareamento` WRITE;
/*!40000 ALTER TABLE `fases_pareamento` DISABLE KEYS */;
INSERT INTO `fases_pareamento` VALUES (1,'\0','\0','\0','\0','\0','\0'),(3,'\0','\0','\0','\0','\0','\0'),(5,'','\0','\0','','\0','\0');
/*!40000 ALTER TABLE `fases_pareamento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `score`
--

DROP TABLE IF EXISTS `score`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `score` (
  `ID_USUARIO` int(11) NOT NULL,
  `JOGO_MEMORIA` int(11) NOT NULL DEFAULT 0,
  `JOGO_PAREAMENTO` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID_USUARIO`),
  CONSTRAINT `score_ibfk_1` FOREIGN KEY (`ID_USUARIO`) REFERENCES `usuario` (`ID_USUARIO`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `score_ibfk_2` FOREIGN KEY (`ID_USUARIO`) REFERENCES `usuario` (`ID_USUARIO`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `score`
--

LOCK TABLES `score` WRITE;
/*!40000 ALTER TABLE `score` DISABLE KEYS */;
INSERT INTO `score` VALUES (1,0,0),(3,0,0),(5,10,0);
/*!40000 ALTER TABLE `score` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usuario` (
  `ID_USUARIO` int(11) NOT NULL AUTO_INCREMENT,
  `NOME_USUARIO` varchar(100) NOT NULL,
  `EMAIL` varchar(100) NOT NULL,
  `SENHA` varchar(30) NOT NULL,
  `IS_ATIVO` bit(1) NOT NULL DEFAULT b'0',
  `CODIGO` varchar(6) DEFAULT NULL,
  `DATA_NASC` date DEFAULT NULL,
  PRIMARY KEY (`ID_USUARIO`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` VALUES (1,'Jorge','claudia121@gmail.com','12345678','\0','861612','2017-07-04'),(3,'Ricardo','ricardobalbino@unipam.edu.br','12345678','',NULL,'2023-05-09'),(5,'Hiury','hiurylucas@unipam.edu.br','12345678','',NULL,'2002-12-28');
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER new_usuario AFTER INSERT ON usuario 

FOR EACH ROW 

BEGIN 

INSERT into score(ID_USUARIO) VALUES(NEW.ID_USUARIO);

INSERT into fases_memoria(ID_USUARIO) VALUES(NEW.ID_USUARIO);

INSERT into fases_pareamento(ID_USUARIO) VALUES(NEW.ID_USUARIO);

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-06-16 12:08:20
