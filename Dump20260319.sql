CREATE DATABASE  IF NOT EXISTS `parksys` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `parksys`;
-- MySQL dump 10.13  Distrib 8.0.42, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: parksys
-- ------------------------------------------------------
-- Server version	8.0.42

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `espacios_parqueo`
--

DROP TABLE IF EXISTS `espacios_parqueo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `espacios_parqueo` (
  `id` int NOT NULL AUTO_INCREMENT,
  `numero` int NOT NULL,
  `estado` enum('disponible','ocupado') DEFAULT 'disponible',
  `habilitado` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `numero` (`numero`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `espacios_parqueo`
--

LOCK TABLES `espacios_parqueo` WRITE;
/*!40000 ALTER TABLE `espacios_parqueo` DISABLE KEYS */;
INSERT INTO `espacios_parqueo` VALUES (1,1,'disponible',1),(2,2,'disponible',1),(3,3,'disponible',1),(4,4,'disponible',1),(5,5,'disponible',1),(6,6,'disponible',1),(7,7,'disponible',1),(8,8,'disponible',1),(9,9,'disponible',1),(10,10,'disponible',1),(11,11,'disponible',1),(12,12,'disponible',1),(13,13,'disponible',1),(14,14,'disponible',1),(15,15,'disponible',1),(16,16,'disponible',1),(17,17,'disponible',1),(18,18,'disponible',1),(19,19,'disponible',1),(20,20,'disponible',1);
/*!40000 ALTER TABLE `espacios_parqueo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `movimientos`
--

DROP TABLE IF EXISTS `movimientos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `movimientos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `vehiculo_id` int NOT NULL,
  `espacio_id` int NOT NULL,
  `hora_entrada` datetime NOT NULL,
  `hora_salida` datetime DEFAULT NULL,
  `tiempo_total` int DEFAULT NULL,
  `monto_total` decimal(10,2) DEFAULT NULL,
  `estado` enum('activo','finalizado') DEFAULT 'activo',
  PRIMARY KEY (`id`),
  KEY `vehiculo_id` (`vehiculo_id`),
  KEY `espacio_id` (`espacio_id`),
  CONSTRAINT `movimientos_ibfk_1` FOREIGN KEY (`vehiculo_id`) REFERENCES `vehiculos` (`id`),
  CONSTRAINT `movimientos_ibfk_2` FOREIGN KEY (`espacio_id`) REFERENCES `espacios_parqueo` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movimientos`
--

LOCK TABLES `movimientos` WRITE;
/*!40000 ALTER TABLE `movimientos` DISABLE KEYS */;
INSERT INTO `movimientos` VALUES (1,1,3,'2026-03-06 19:56:22','2026-03-06 19:56:46',NULL,NULL,'finalizado'),(2,2,2,'2026-03-12 00:12:32','2026-03-12 00:12:41',NULL,NULL,'finalizado'),(3,2,2,'2026-03-12 00:27:34','2026-03-12 00:27:49',NULL,NULL,'finalizado'),(4,3,14,'2026-03-14 00:16:07','2026-03-14 00:53:42',NULL,NULL,'finalizado'),(5,2,2,'2026-03-17 00:35:52','2026-03-17 00:36:01',NULL,NULL,'finalizado'),(6,2,1,'2026-03-18 03:01:56','2026-03-18 03:02:27',NULL,NULL,'finalizado'),(7,4,2,'2026-03-18 03:02:16','2026-03-18 03:02:52',NULL,NULL,'finalizado'),(8,2,20,'2026-03-18 03:11:14','2026-03-18 03:11:26',NULL,NULL,'finalizado');
/*!40000 ALTER TABLE `movimientos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pagos`
--

DROP TABLE IF EXISTS `pagos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pagos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `movimiento_id` int NOT NULL,
  `monto` decimal(10,2) NOT NULL,
  `metodo_pago` enum('efectivo','tarjeta','transferencia') DEFAULT NULL,
  `fecha_pago` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `movimiento_id` (`movimiento_id`),
  CONSTRAINT `pagos_ibfk_1` FOREIGN KEY (`movimiento_id`) REFERENCES `movimientos` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pagos`
--

LOCK TABLES `pagos` WRITE;
/*!40000 ALTER TABLE `pagos` DISABLE KEYS */;
/*!40000 ALTER TABLE `pagos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `reporte_movimientos`
--

DROP TABLE IF EXISTS `reporte_movimientos`;
/*!50001 DROP VIEW IF EXISTS `reporte_movimientos`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `reporte_movimientos` AS SELECT 
 1 AS `id`,
 1 AS `placa`,
 1 AS `espacio`,
 1 AS `hora_entrada`,
 1 AS `hora_salida`,
 1 AS `monto_total`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `tarifas`
--

DROP TABLE IF EXISTS `tarifas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tarifas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `precio_por_hora` decimal(10,2) NOT NULL,
  `fecha_actualizacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tarifas`
--

LOCK TABLES `tarifas` WRITE;
/*!40000 ALTER TABLE `tarifas` DISABLE KEYS */;
INSERT INTO `tarifas` VALUES (1,30.00,'2026-03-05 14:03:53');
/*!40000 ALTER TABLE `tarifas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `rol` enum('admin','operador') NOT NULL,
  `fecha_creacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (1,'Administrador','admin@parksys.com','admin123','admin','2026-03-05 14:03:53'),(2,'Operador Parqueo','operador@parksys.com','1234','operador','2026-03-06 15:31:58');
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vehiculos`
--

DROP TABLE IF EXISTS `vehiculos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vehiculos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `placa` varchar(20) NOT NULL,
  `nombre_propietario` varchar(100) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `fecha_registro` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `placa` (`placa`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vehiculos`
--

LOCK TABLES `vehiculos` WRITE;
/*!40000 ALTER TABLE `vehiculos` DISABLE KEYS */;
INSERT INTO `vehiculos` VALUES (1,'ABC','Juan','99','2026-03-06 19:56:22'),(2,'AAA','Nestor','9999','2026-03-12 00:12:32'),(3,'HBF3272','Nestor Mejia','96323714','2026-03-14 00:16:07'),(4,'BBB','Juan','98989898','2026-03-18 03:02:16');
/*!40000 ALTER TABLE `vehiculos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'parksys'
--

--
-- Dumping routines for database 'parksys'
--

--
-- Final view structure for view `reporte_movimientos`
--

/*!50001 DROP VIEW IF EXISTS `reporte_movimientos`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `reporte_movimientos` AS select `m`.`id` AS `id`,`v`.`placa` AS `placa`,`e`.`numero` AS `espacio`,`m`.`hora_entrada` AS `hora_entrada`,`m`.`hora_salida` AS `hora_salida`,`m`.`monto_total` AS `monto_total` from ((`movimientos` `m` join `vehiculos` `v` on((`m`.`vehiculo_id` = `v`.`id`))) join `espacios_parqueo` `e` on((`m`.`espacio_id` = `e`.`id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-03-19 20:40:13
