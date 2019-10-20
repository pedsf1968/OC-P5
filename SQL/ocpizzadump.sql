-- MySQL dump 10.13  Distrib 8.0.15, for Win64 (x86_64)
--
-- Host: localhost    Database: oc_pizza
-- ------------------------------------------------------
-- Server version	8.0.15

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8mb4 ;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `oc_pizza`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `oc_pizza` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `oc_pizza`;

--
-- Table structure for table `adresse`
--

DROP TABLE IF EXISTS `adresse`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `adresse` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `appartement` varchar(4) DEFAULT NULL,
  `etage` varchar(3) DEFAULT NULL,
  `couloir` varchar(3) DEFAULT NULL,
  `escalier` varchar(3) DEFAULT NULL,
  `entree` varchar(3) DEFAULT NULL,
  `immeuble` varchar(10) DEFAULT NULL,
  `residence` varchar(20) DEFAULT NULL,
  `numero` varchar(5) DEFAULT NULL,
  `voie` varchar(50) DEFAULT NULL,
  `place` varchar(50) DEFAULT NULL,
  `code` varchar(5) NOT NULL,
  `ville` varchar(20) NOT NULL,
  `pays` varchar(20) NOT NULL DEFAULT 'FRANCE',
  `commentaire` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `adresse`
--

LOCK TABLES `adresse` WRITE;
/*!40000 ALTER TABLE `adresse` DISABLE KEYS */;
INSERT INTO `adresse` VALUES (1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','rue des Teinturiers',NULL,'69003','Lyon','FRANCE',NULL),(2,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'45','rue des Bleuet',NULL,'39000','Dole','FRANCE',NULL),(3,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'4','rue des Acacias',NULL,'70000','Vesoul','FRANCE',NULL),(4,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'12','rue des Chataigniers',NULL,'90000','Belfort','FRANCE',NULL),(5,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'14','rue de Paris',NULL,'94150','RUNGIS','FRANCE',NULL),(6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'15','rue de Paris',NULL,'94150','RUNGIS','FRANCE',NULL),(7,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','Rue de Naple',NULL,'25000','Besançon','FRANCE',NULL),(8,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'10','Rue des Frères Mercier',NULL,'25000','Besançon','FRANCE',NULL),(9,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'7','Rue des Grand Bas',NULL,'25000','Besançon','FRANCE',NULL),(10,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'4','Rue de la Paix',NULL,'25000','Besançon','FRANCE',NULL),(11,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'34','Rue de la Résistance',NULL,'25000','Besançon','FRANCE',NULL),(12,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'9','Rue Battant',NULL,'25000','Besançon','FRANCE',NULL);
/*!40000 ALTER TABLE `adresse` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `before_insert_adresse` BEFORE INSERT ON `adresse` FOR EACH ROW BEGIN
   DECLARE existedeja INTEGER;

   SELECT COUNT(*) INTO existedeja 
      FROM adresse 
      WHERE  IFNULL(appartement,'NULL') = IFNULL(NEW.appartement,'NULL')
         AND IFNULL(etage,'NULL') = IFNULL(NEW.etage,'NULL')
         AND IFNULL(couloir,'NULL') = IFNULL(NEW.couloir,'NULL')
         AND IFNULL(escalier,'NULL') = IFNULL(NEW.escalier,'NULL')
         AND IFNULL(entree,'NULL') = IFNULL(NEW.entree,'NULL')
         AND IFNULL(immeuble,'NULL') = IFNULL(NEW.immeuble,'NULL')
         AND IFNULL(residence,'NULL') = IFNULL(NEW.residence,'NULL')
         AND IFNULL(numero,'NULL') = IFNULL(NEW.numero,'NULL')
         AND IFNULL(voie,'NULL') = IFNULL(NEW.voie,'NULL')
         AND IFNULL(place,'NULL') = IFNULL(NEW.place,'NULL')
         AND IFNULL(code,'NULL') = IFNULL(NEW.code,'NULL')
         AND IFNULL(ville,'NULL') = IFNULL(NEW.ville,'NULL')
         AND IFNULL(pays,'NULL') = IFNULL(NEW.pays,'NULL');
         
    IF existedeja > 0 THEN
      INSERT INTO erreur (message) VALUES ('ERREUR : l''adresse doit être unique!');
   END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `before_update_adresse` BEFORE UPDATE ON `adresse` FOR EACH ROW BEGIN
 DECLARE existedeja INTEGER;

   SELECT COUNT(*) INTO existedeja 
      FROM adresse 
      WHERE  IFNULL(appartement,'NULL') = IFNULL(NEW.appartement,'NULL')
         AND IFNULL(etage,'NULL') = IFNULL(NEW.etage,'NULL')
         AND IFNULL(couloir,'NULL') = IFNULL(NEW.couloir,'NULL')
         AND IFNULL(escalier,'NULL') = IFNULL(NEW.escalier,'NULL')
         AND IFNULL(entree,'NULL') = IFNULL(NEW.entree,'NULL')
         AND IFNULL(immeuble,'NULL') = IFNULL(NEW.immeuble,'NULL')
         AND IFNULL(residence,'NULL') = IFNULL(NEW.residence,'NULL')
         AND IFNULL(numero,'NULL') = IFNULL(NEW.numero,'NULL')
         AND IFNULL(voie,'NULL') = IFNULL(NEW.voie,'NULL')
         AND IFNULL(place,'NULL') = IFNULL(NEW.place,'NULL')
         AND IFNULL(code,'NULL') = IFNULL(NEW.code,'NULL')
         AND IFNULL(ville,'NULL') = IFNULL(NEW.ville,'NULL')
         AND IFNULL(pays,'NULL') = IFNULL(NEW.pays,'NULL');
         
    IF existedeja > 0 THEN
      INSERT INTO erreur (message) VALUES ('ERREUR : l''adresse doit être unique!');
   END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `carte_bancaire`
--

DROP TABLE IF EXISTS `carte_bancaire`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `carte_bancaire` (
  `paiement_id` int(10) unsigned NOT NULL,
  `reference` varchar(100) NOT NULL,
  `jour` date DEFAULT (curdate()),
  `heure` time DEFAULT (curtime()),
  PRIMARY KEY (`paiement_id`),
  CONSTRAINT `paiement_carte_bancaire_fk` FOREIGN KEY (`paiement_id`) REFERENCES `paiement` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `carte_bancaire`
--

LOCK TABLES `carte_bancaire` WRITE;
/*!40000 ALTER TABLE `carte_bancaire` DISABLE KEYS */;
/*!40000 ALTER TABLE `carte_bancaire` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cheque`
--

DROP TABLE IF EXISTS `cheque`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `cheque` (
  `paiement_id` int(10) unsigned NOT NULL,
  `banque` tinyint(3) unsigned NOT NULL,
  `numero` varchar(100) NOT NULL,
  `jour` date DEFAULT (curdate()),
  PRIMARY KEY (`paiement_id`),
  CONSTRAINT `paiement_cheque_fk` FOREIGN KEY (`paiement_id`) REFERENCES `paiement` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cheque`
--

LOCK TABLES `cheque` WRITE;
/*!40000 ALTER TABLE `cheque` DISABLE KEYS */;
/*!40000 ALTER TABLE `cheque` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `client`
--

DROP TABLE IF EXISTS `client`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `client` (
  `utilisateur_id` int(10) unsigned NOT NULL,
  `telephone` varchar(10) NOT NULL,
  `adresse_id` int(10) unsigned NOT NULL,
  `email` varchar(255) NOT NULL,
  PRIMARY KEY (`utilisateur_id`),
  UNIQUE KEY `email` (`email`),
  KEY `adresse_client_fk` (`adresse_id`),
  CONSTRAINT `adresse_client_fk` FOREIGN KEY (`adresse_id`) REFERENCES `adresse` (`id`),
  CONSTRAINT `utilisateur_client_fk` FOREIGN KEY (`utilisateur_id`) REFERENCES `utilisateur` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `client`
--

LOCK TABLES `client` WRITE;
/*!40000 ALTER TABLE `client` DISABLE KEYS */;
INSERT INTO `client` VALUES (8,'0381565422',7,'red.rackham@gmail.com'),(9,'0381565422',8,'oliveira.dafigueira@hotmail.com'),(10,'0381565422',9,'frank.wolf@orange.fr'),(11,'0381565422',10,'alan.thompson@red.com'),(12,'0381565422',11,'thierry.dupon@belga.be'),(13,'0381565422',12,'daniel.dupon@belga.be');
/*!40000 ALTER TABLE `client` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `commande`
--

DROP TABLE IF EXISTS `commande`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `commande` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `utilisateur_id` int(10) unsigned NOT NULL,
  `adresse_id` int(10) unsigned NOT NULL,
  `statut` enum('En attente','En préparation','Préparée','En livraison','Livrée','Clos') NOT NULL,
  `jour` date NOT NULL DEFAULT (curdate()),
  `heure` time NOT NULL DEFAULT (curtime()),
  `preparation_delai` time DEFAULT NULL,
  `preparation_duree` time DEFAULT NULL,
  `livraison_delai` time DEFAULT NULL,
  `livraison_duree` time DEFAULT NULL,
  `paiement_OK` tinyint(1) NOT NULL DEFAULT '0',
  `montant_ttc` decimal(5,2) NOT NULL DEFAULT (0.0),
  PRIMARY KEY (`id`),
  KEY `adresse_commande_fk` (`adresse_id`),
  KEY `client_commande_fk` (`utilisateur_id`),
  CONSTRAINT `adresse_commande_fk` FOREIGN KEY (`adresse_id`) REFERENCES `adresse` (`id`),
  CONSTRAINT `client_commande_fk` FOREIGN KEY (`utilisateur_id`) REFERENCES `client` (`utilisateur_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `commande`
--

LOCK TABLES `commande` WRITE;
/*!40000 ALTER TABLE `commande` DISABLE KEYS */;
/*!40000 ALTER TABLE `commande` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `composant`
--

DROP TABLE IF EXISTS `composant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `composant` (
  `produit_id` int(10) unsigned NOT NULL,
  `ingredient_id` int(10) unsigned NOT NULL,
  `quantite` decimal(5,2) NOT NULL DEFAULT (0),
  `unite` varchar(3) NOT NULL,
  PRIMARY KEY (`produit_id`,`ingredient_id`),
  KEY `produit_composition_ingredient_fk` (`ingredient_id`),
  CONSTRAINT `produit_composition_ingredient_fk` FOREIGN KEY (`ingredient_id`) REFERENCES `produit` (`id`),
  CONSTRAINT `produit_composition_produit_fk` FOREIGN KEY (`produit_id`) REFERENCES `produit` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `composant`
--

LOCK TABLES `composant` WRITE;
/*!40000 ALTER TABLE `composant` DISABLE KEYS */;
INSERT INTO `composant` VALUES (1,2,25.00,'KG'),(3,4,3.00,'KG'),(5,6,4.00,'KG'),(7,8,6.00,'KG'),(9,10,6.00,'KG'),(11,12,10.00,'KG'),(13,14,1.50,'KG'),(15,16,3.00,'KG'),(17,18,1.80,'KG'),(19,20,1.80,'KG'),(21,22,5.00,'KG'),(23,24,30.00,'U'),(25,26,6.00,'L'),(27,28,6.00,'L'),(29,30,6.00,'L'),(31,32,5.00,'KG'),(33,34,5.00,'KG'),(35,36,2.00,'KG'),(37,38,2.00,'KG'),(39,40,24.00,'U'),(41,42,24.00,'U'),(43,44,24.00,'U'),(45,46,24.00,'U'),(47,48,24.00,'U'),(49,2,0.10,'KG'),(49,16,0.10,'KG'),(49,30,0.05,'L'),(49,32,0.10,'KG'),(50,2,0.10,'KG'),(50,30,0.05,'L'),(50,32,0.10,'KG'),(50,34,0.10,'KG'),(50,36,0.10,'KG'),(50,38,0.10,'KG'),(51,2,0.10,'KG'),(51,4,0.05,'KG'),(51,6,0.05,'KG'),(51,14,0.10,'KG'),(51,16,0.10,'KG'),(51,18,0.10,'KG'),(51,30,0.05,'L'),(51,32,0.10,'KG'),(51,34,0.10,'KG');
/*!40000 ALTER TABLE `composant` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `composition`
--

DROP TABLE IF EXISTS `composition`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `composition` (
  `produit_id` int(10) unsigned NOT NULL,
  `formule` text NOT NULL,
  PRIMARY KEY (`produit_id`),
  CONSTRAINT `produit_composition_fk` FOREIGN KEY (`produit_id`) REFERENCES `produit` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `composition`
--

LOCK TABLES `composition` WRITE;
/*!40000 ALTER TABLE `composition` DISABLE KEYS */;
INSERT INTO `composition` VALUES (1,'farine'),(2,'farine'),(3,'champignon'),(4,'champignon'),(5,'poivron'),(6,'poivron'),(7,'tomate'),(8,'tomate'),(9,'aubergine'),(10,'aubergine'),(11,'oignon'),(12,'oignon'),(13,'porc'),(14,'porc'),(15,'porc'),(16,'porc'),(17,'porc'),(18,'porc'),(19,'porc'),(20,'porc'),(21,'poisson'),(22,'poisson'),(23,'oeuf'),(24,'oeuf'),(25,'lait'),(26,'lait'),(27,'lait'),(28,'lait'),(29,'tomate,poivre,sel'),(30,'tomate,poivre,sel'),(31,'fromage'),(32,'fromage'),(33,'fromage'),(34,'fromage'),(35,'fromage'),(36,'fromage'),(37,'fromage'),(38,'fromage'),(39,'eau'),(40,'eau'),(41,'eau'),(42,'eau'),(49,'farine, porc, tomate, fromage'),(50,'farine, tomate, fromage'),(51,'farine, tomate, poivron, champignons porc, fromage');
/*!40000 ALTER TABLE `composition` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employe`
--

DROP TABLE IF EXISTS `employe`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `employe` (
  `utilisateur_id` int(10) unsigned NOT NULL,
  `role` enum('Accueil','Pizzaiolo','Livreur','Manager','Gestionnaire','Comptable','Direction') NOT NULL,
  PRIMARY KEY (`utilisateur_id`),
  CONSTRAINT `utilisateur_employe_fk` FOREIGN KEY (`utilisateur_id`) REFERENCES `utilisateur` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employe`
--

LOCK TABLES `employe` WRITE;
/*!40000 ALTER TABLE `employe` DISABLE KEYS */;
INSERT INTO `employe` VALUES (1,'Accueil'),(2,'Livreur'),(3,'Direction'),(4,'Pizzaiolo'),(5,'Comptable'),(6,'Manager'),(7,'Gestionnaire');
/*!40000 ALTER TABLE `employe` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `erreur`
--

DROP TABLE IF EXISTS `erreur`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `erreur` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `message` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `message` (`message`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `erreur`
--

LOCK TABLES `erreur` WRITE;
/*!40000 ALTER TABLE `erreur` DISABLE KEYS */;
INSERT INTO `erreur` VALUES (1,'ERREUR : l\'adresse doit être unique!'),(6,'ERREUR : la commande n\'est pas en attente!'),(7,'ERREUR : la commande n\'est pas en préparation!'),(8,'ERREUR : la commande n\'est pas préparée!'),(2,'ERREUR : le login doit être unique!'),(4,'ERREUR : le nom du fournisseur doit être unique!'),(3,'ERREUR : le nom du magasin doit être unique!'),(5,'ERREUR : un produit n\'est plus disponible!');
/*!40000 ALTER TABLE `erreur` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `etablissement`
--

DROP TABLE IF EXISTS `etablissement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `etablissement` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `nom` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `etablissement`
--

LOCK TABLES `etablissement` WRITE;
/*!40000 ALTER TABLE `etablissement` DISABLE KEYS */;
INSERT INTO `etablissement` VALUES (1,'La Banque Poste'),(2,'BNP Paribas'),(3,'Société Générale'),(4,'Crédit Agricole'),(5,'LCL'),(6,'Banque Populaire'),(7,'Caisse d\'Epargne'),(8,'HSBC'),(9,'Crédit Mutuel'),(10,'Chèque Déjeuner'),(11,'Pass Restaurant'),(12,'Ticket Restaurant'),(13,'Chèque Apetiz'),(14,'Ticket Restaurant');
/*!40000 ALTER TABLE `etablissement` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fournisseur`
--

DROP TABLE IF EXISTS `fournisseur`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `fournisseur` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nom` varchar(50) NOT NULL,
  `telephone` varchar(10) NOT NULL,
  `email` varchar(255) NOT NULL,
  `adresse_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`,`nom`),
  KEY `adresse_fournisseur_fk` (`adresse_id`),
  CONSTRAINT `adresse_fournisseur_fk` FOREIGN KEY (`adresse_id`) REFERENCES `adresse` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fournisseur`
--

LOCK TABLES `fournisseur` WRITE;
/*!40000 ALTER TABLE `fournisseur` DISABLE KEYS */;
INSERT INTO `fournisseur` VALUES (1,'Global Food','0145686811','client@globalfood.com',5),(2,'Italia Food','0181654654','commande@italiafood.com',6);
/*!40000 ALTER TABLE `fournisseur` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ligne_de_commande`
--

DROP TABLE IF EXISTS `ligne_de_commande`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `ligne_de_commande` (
  `commande_id` int(10) unsigned NOT NULL,
  `produit_id` int(10) unsigned NOT NULL,
  `quantite` decimal(2,0) NOT NULL DEFAULT '1',
  `prix_unitaire_ht` decimal(5,2) NOT NULL,
  `taux_tva` decimal(3,1) NOT NULL DEFAULT (0.0),
  PRIMARY KEY (`commande_id`,`produit_id`),
  KEY `produit_ligne_de_commande_fk` (`produit_id`),
  CONSTRAINT `commande_ligne_de_commande_fk` FOREIGN KEY (`commande_id`) REFERENCES `commande` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `produit_ligne_de_commande_fk` FOREIGN KEY (`produit_id`) REFERENCES `produit` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ligne_de_commande`
--

LOCK TABLES `ligne_de_commande` WRITE;
/*!40000 ALTER TABLE `ligne_de_commande` DISABLE KEYS */;
/*!40000 ALTER TABLE `ligne_de_commande` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ligne_de_panier`
--

DROP TABLE IF EXISTS `ligne_de_panier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `ligne_de_panier` (
  `utilisateur_id` int(10) unsigned NOT NULL,
  `produit_id` int(10) unsigned NOT NULL,
  `quantite` decimal(2,0) NOT NULL DEFAULT (0),
  `prix_unitaire_ht` decimal(5,2) NOT NULL DEFAULT (0.0),
  `taux_tva` decimal(3,1) NOT NULL DEFAULT (0.0),
  PRIMARY KEY (`utilisateur_id`,`produit_id`),
  KEY `produit_ligne_de_panier_fk` (`produit_id`),
  CONSTRAINT `produit_ligne_de_panier_fk` FOREIGN KEY (`produit_id`) REFERENCES `produit` (`id`),
  CONSTRAINT `utilisateur_ligne_de_panier_fk` FOREIGN KEY (`utilisateur_id`) REFERENCES `utilisateur` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ligne_de_panier`
--

LOCK TABLES `ligne_de_panier` WRITE;
/*!40000 ALTER TABLE `ligne_de_panier` DISABLE KEYS */;
/*!40000 ALTER TABLE `ligne_de_panier` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `liste_paiement`
--

DROP TABLE IF EXISTS `liste_paiement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `liste_paiement` (
  `commande_id` int(10) unsigned NOT NULL,
  `paiement_id` int(10) unsigned NOT NULL,
  `montant` decimal(5,2) NOT NULL DEFAULT (0.0),
  PRIMARY KEY (`commande_id`,`paiement_id`),
  KEY `paiement_liste_paiement_fk` (`paiement_id`),
  CONSTRAINT `commande_liste_paiement_fk` FOREIGN KEY (`commande_id`) REFERENCES `commande` (`id`),
  CONSTRAINT `paiement_liste_paiement_fk` FOREIGN KEY (`paiement_id`) REFERENCES `paiement` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `liste_paiement`
--

LOCK TABLES `liste_paiement` WRITE;
/*!40000 ALTER TABLE `liste_paiement` DISABLE KEYS */;
/*!40000 ALTER TABLE `liste_paiement` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `magasin`
--

DROP TABLE IF EXISTS `magasin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `magasin` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nom` varchar(50) NOT NULL,
  `telephone` varchar(10) NOT NULL,
  `email` varchar(255) NOT NULL,
  `adresse_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`,`nom`),
  KEY `adresse_magasin_fk` (`adresse_id`),
  KEY `magasin_nom_idx` (`nom`),
  CONSTRAINT `adresse_magasin_fk` FOREIGN KEY (`adresse_id`) REFERENCES `adresse` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `magasin`
--

LOCK TABLES `magasin` WRITE;
/*!40000 ALTER TABLE `magasin` DISABLE KEYS */;
INSERT INTO `magasin` VALUES (1,'Pizza Napoli','0381501111','napoli@ocpizza.com',1),(2,'Pizza Firenze','0381501654','firenze@ocpizza.com',2),(3,'Pizza Roma','0381501112','roma@ocpizza.com',3),(4,'Pizza Torino','0381501113','torino@ocpizza.com',4);
/*!40000 ALTER TABLE `magasin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `paiement`
--

DROP TABLE IF EXISTS `paiement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `paiement` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` enum('espèce','carte bancaire','ticket restaurant','chèque bancaire','sans') NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `paiement`
--

LOCK TABLES `paiement` WRITE;
/*!40000 ALTER TABLE `paiement` DISABLE KEYS */;
/*!40000 ALTER TABLE `paiement` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `panier`
--

DROP TABLE IF EXISTS `panier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `panier` (
  `utilisateur_id` int(10) unsigned NOT NULL,
  `jour` date NOT NULL DEFAULT (curdate()),
  `heure` time NOT NULL DEFAULT (curtime()),
  `montant_ttc` decimal(5,2) NOT NULL DEFAULT (0.0),
  `livraison` tinyint(3) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`utilisateur_id`),
  CONSTRAINT `client_panier_fk` FOREIGN KEY (`utilisateur_id`) REFERENCES `client` (`utilisateur_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `panier`
--

LOCK TABLES `panier` WRITE;
/*!40000 ALTER TABLE `panier` DISABLE KEYS */;
/*!40000 ALTER TABLE `panier` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `preparation`
--

DROP TABLE IF EXISTS `preparation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `preparation` (
  `produit_id` int(10) unsigned NOT NULL,
  `recette` text NOT NULL,
  PRIMARY KEY (`produit_id`),
  CONSTRAINT `produit_preparation_fk` FOREIGN KEY (`produit_id`) REFERENCES `produit` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `preparation`
--

LOCK TABLES `preparation` WRITE;
/*!40000 ALTER TABLE `preparation` DISABLE KEYS */;
INSERT INTO `preparation` VALUES (49,'Faire la pâte, l\'étaler, étaler la sauce tomate, étaler le jambon, recouvrer de fromage rapé, enfourner'),(50,'Faire la pâte, l\'étaler, étaler la sauce tomate, étaler les 4 promages également sur la pizza, enfourner'),(51,'Faire la pâte, l\'étaler, étaler la sauce tomate, étaler le jambon, étaler le bacon, etaler les poivrons, \n	étaler les champiognons, étaler les pepperoni, etaler le fromage, enfourner');
/*!40000 ALTER TABLE `preparation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `produit`
--

DROP TABLE IF EXISTS `produit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `produit` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `designation` varchar(100) NOT NULL,
  `categorie` enum('pack','vrac','ingrédient','pizza','boisson','dessert','emballage','sauce') NOT NULL,
  `fournisseur_id` int(10) unsigned DEFAULT NULL,
  `reference` varchar(20) DEFAULT NULL,
  `quantite` decimal(5,2) DEFAULT (0.0),
  `unite` varchar(3) DEFAULT NULL,
  `prix_achat_ht` decimal(5,2) DEFAULT (0.0),
  `prix_vente_ht` decimal(5,2) DEFAULT (0.0),
  `tva_emporte` decimal(3,1) NOT NULL DEFAULT (10.0),
  `tva_livre` decimal(3,1) NOT NULL DEFAULT (10.0),
  PRIMARY KEY (`id`),
  UNIQUE KEY `designation` (`designation`),
  KEY `fournisseur_produit_fk` (`fournisseur_id`),
  CONSTRAINT `fournisseur_produit_fk` FOREIGN KEY (`fournisseur_id`) REFERENCES `fournisseur` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produit`
--

LOCK TABLES `produit` WRITE;
/*!40000 ALTER TABLE `produit` DISABLE KEYS */;
INSERT INTO `produit` VALUES (1,'farine de blé T55 - 25Kg','ingrédient',1,'fkjh6546',25.00,'KG',33.40,NULL,0.0,0.0),(2,'farine de blé T55 - Vrac','vrac',1,'fkjh6546',1.00,'KG',NULL,NULL,0.0,0.0),(3,'Champignon pied coupé moyen catégorie 1 - 3Kg','ingrédient',1,'31347',3.00,'KG',14.50,NULL,0.0,0.0),(4,'Champignon pied coupé moyen catégorie 1 - Vrac','vrac',1,'31347',1.00,'KG',NULL,NULL,0.0,0.0),(5,'Poivron mixte calibre 80/100 catégorie 1 - 4Kg','ingrédient',1,'82657',4.00,'KG',15.00,NULL,0.0,0.0),(6,'Poivron mixte calibre 80/100 catégorie 1 - Vrac','vrac',1,'82657',1.00,'KG',NULL,NULL,0.0,0.0),(7,'Tomate ronde calibre 57/67 océanecatégorie extra - 6Kg','ingrédient',1,'93945',6.00,'KG',15.00,NULL,0.0,0.0),(8,'Tomate ronde calibre 57/67 océanecatégorie extra - Vrac','vrac',1,'93945',1.00,'KG',NULL,NULL,0.0,0.0),(9,'Aubergine calibre 300/400 catégorie 1 - 6Kg','ingrédient',1,'59884',6.00,'KG',20.00,NULL,0.0,0.0),(10,'Aubergine calibre 300/400 catégorie 1 - Vrac','vrac',1,'59884',1.00,'KG',NULL,NULL,0.0,0.0),(11,'Oignon charcutier calibre 70/100 catégorie 1 - 10Kg','ingrédient',1,'702815',10.00,'KG',20.00,NULL,0.0,0.0),(12,'Oignon charcutier calibre 70/100 catégorie 1 - Vrac','vrac',1,'702815',1.00,'KG',NULL,NULL,0.0,0.0),(13,'Bacon standard sous vide fumé - 1.5Kg','ingrédient',2,'236179',1.50,'KG',55.00,NULL,0.0,0.0),(14,'Bacon standard sous vide fumé - Vrac','vrac',2,'236179',1.00,'KG',NULL,NULL,0.0,0.0),(15,'Jambon de Vendée à l\'ancienne - 3Kg','ingrédient',2,'235440',3.00,'KG',35.00,NULL,0.0,0.0),(16,'Jambon de Vendée à l\'ancienne - Vrac','vrac',2,'235440',1.00,'KG',NULL,NULL,0.0,0.0),(17,'Pepperoni - 1.8Kg','ingrédient',2,'157623',1.80,'KG',35.00,NULL,0.0,0.0),(18,'Pepperoni - Vrac','vrac',2,'157623',1.00,'KG',NULL,NULL,0.0,0.0),(19,'Chorizo fort - 1.8Kg','ingrédient',2,'157623',1.80,'KG',35.00,NULL,0.0,0.0),(20,'Chorizo fort - Vrac','vrac',2,'157623',1.00,'KG',NULL,NULL,0.0,0.0),(21,'Saumon sauvage filet sous vide - 5Kg','ingrédient',1,'706424',5.00,'KG',111.10,NULL,0.0,0.0),(22,'Saumon sauvage filet sous vide - Vrac','vrac',1,'706424',1.00,'KG',NULL,NULL,0.0,0.0),(23,'Oeuf calibre gros fermier - 30U','ingrédient',1,'159123',30.00,'U',10.10,NULL,0.0,0.0),(24,'Oeuf calibre gros fermier - Vrac','vrac',1,'159123',1.00,'U',NULL,NULL,0.0,0.0),(25,'Lait 1/2 écrémé UHT 1.6% MG brique - 6L','ingrédient',1,'247890',6.00,'L',0.89,NULL,0.0,0.0),(26,'Lait 1/2 écrémé UHT 1.6% MG brique - Vrac','vrac',1,'247890',1.00,'L',NULL,NULL,0.0,0.0),(27,'Crème liquide UHT 30% MG - 6L','ingrédient',1,'246755',6.00,'L',1.10,NULL,0.0,0.0),(28,'Crème liquide UHT 30% MG - Vrac','vrac',1,'246755',1.00,'L',NULL,NULL,0.0,0.0),(29,'Sauce tomate - 6L','ingrédient',1,'247890',6.00,'L',2.59,NULL,0.0,0.0),(30,'Sauce tomate - Vrac','vrac',1,'247890',1.00,'L',NULL,NULL,0.0,0.0),(31,'Fromage rapé - 5Kg','ingrédient',2,'654654',5.00,'KG',50.00,NULL,0.0,0.0),(32,'Fromage rapé - Vrac','vrac',2,'654654',1.00,'KG',NULL,NULL,0.0,0.0),(33,'Mozzarella - 5Kg','ingrédient',2,'78989',5.00,'KG',80.00,NULL,0.0,0.0),(34,'Mozzarella - Vrac','vrac',2,'78989',1.00,'KG',NULL,NULL,0.0,0.0),(35,'Chèvre - 2Kg','ingrédient',2,'78989',2.00,'KG',40.00,NULL,0.0,0.0),(36,'Chèvre - Vrac','vrac',2,'78989',1.00,'KG',NULL,NULL,0.0,0.0),(37,'Fourme d\'Amber AOP - 2Kg','ingrédient',2,'78989',2.00,'KG',40.00,NULL,0.0,0.0),(38,'Fourme d\'Amber AOP - Vrac','vrac',2,'78989',1.00,'KG',NULL,NULL,0.0,0.0),(39,'Eau plate - 50cl/24','pack',1,'65465',24.00,'U',NULL,NULL,0.0,0.0),(40,'Eau plate - 50cl/1','boisson',1,'65465',1.00,'U',NULL,1.80,5.5,10.0),(41,'Eau gazeuze - 50cl/24','pack',1,'654898',1.00,'U',NULL,NULL,0.0,0.0),(42,'Eau gazeuze - 50cl/1','boisson',1,'654898',1.00,'U',NULL,1.80,5.5,10.0),(43,'Cola - 33cl/24','pack',1,'654898',1.00,'U',NULL,NULL,0.0,0.0),(44,'Cola - 33cl/1','boisson',1,'654898',1.00,'U',NULL,1.80,5.5,10.0),(45,'Jus d\'orange - 33cl/24','pack',1,'888554',1.00,'U',NULL,NULL,0.0,0.0),(46,'Jus d\'orange - 33cl/1','boisson',1,'888554',1.00,'U',NULL,1.80,5.5,10.0),(47,'Jus de pomme - 33cl/24','pack',1,'644898',1.00,'U',NULL,NULL,0.0,0.0),(48,'Jus de pomme - 33cl/1','boisson',1,'644898',1.00,'U',NULL,2.10,5.5,10.0),(49,'Pizza margarita','pizza',1,'Pmargarita',1.00,'U',NULL,15.30,10.0,10.0),(50,'Pizza 4 fromages','pizza',1,'P4fromages',1.00,'U',NULL,13.30,10.0,10.0),(51,'Pizza extravaganzza','pizza',1,'Pextravag',1.00,'U',NULL,16.50,10.0,10.0);
/*!40000 ALTER TABLE `produit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stock`
--

DROP TABLE IF EXISTS `stock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `stock` (
  `magasin_id` int(10) unsigned NOT NULL,
  `produit_id` int(10) unsigned NOT NULL,
  `quantite` decimal(5,2) NOT NULL DEFAULT (0),
  `quantite_min` decimal(5,2) NOT NULL DEFAULT (0.0),
  `unite` varchar(3) NOT NULL DEFAULT 'KG',
  PRIMARY KEY (`magasin_id`,`produit_id`),
  KEY `produit_stock_fk` (`produit_id`),
  CONSTRAINT `magasin_stock_fk` FOREIGN KEY (`magasin_id`) REFERENCES `magasin` (`id`),
  CONSTRAINT `produit_stock_fk` FOREIGN KEY (`produit_id`) REFERENCES `produit` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stock`
--

LOCK TABLES `stock` WRITE;
/*!40000 ALTER TABLE `stock` DISABLE KEYS */;
INSERT INTO `stock` VALUES (1,2,25.00,0.00,'KG'),(1,4,3.00,0.00,'KG'),(1,6,4.00,0.00,'KG'),(1,8,6.00,0.00,'KG'),(1,10,6.00,0.00,'KG'),(1,12,10.00,0.00,'KG'),(1,14,1.50,0.00,'KG'),(1,16,3.00,0.00,'KG'),(1,18,1.80,0.00,'KG'),(1,20,1.80,0.00,'KG'),(1,22,5.00,0.00,'KG'),(1,24,30.00,0.00,'KG'),(1,26,6.00,0.00,'KG'),(1,28,6.00,0.00,'KG'),(1,30,6.00,0.00,'KG'),(1,32,5.00,0.00,'KG'),(1,34,5.00,0.00,'KG'),(1,36,2.00,0.00,'KG'),(1,38,2.00,0.00,'KG'),(1,40,24.00,0.00,'KG'),(1,42,24.00,0.00,'KG'),(1,44,24.00,0.00,'KG'),(1,46,24.00,0.00,'KG'),(1,48,24.00,0.00,'KG'),(2,2,25.00,0.00,'KG'),(2,4,3.00,0.00,'KG'),(2,6,4.00,0.00,'KG'),(2,8,6.00,0.00,'KG'),(2,10,6.00,0.00,'KG'),(2,12,10.00,0.00,'KG'),(2,14,1.50,0.00,'KG'),(2,16,3.00,0.00,'KG'),(2,18,1.80,0.00,'KG'),(2,20,1.80,0.00,'KG'),(2,22,5.00,0.00,'KG'),(2,24,30.00,0.00,'KG'),(2,26,6.00,0.00,'KG'),(2,28,6.00,0.00,'KG'),(2,30,6.00,0.00,'KG'),(2,32,5.00,0.00,'KG'),(2,34,5.00,0.00,'KG'),(2,36,2.00,0.00,'KG'),(2,38,2.00,0.00,'KG'),(2,40,24.00,0.00,'KG'),(2,42,24.00,0.00,'KG'),(2,44,24.00,0.00,'KG'),(2,46,24.00,0.00,'KG'),(2,48,24.00,0.00,'KG'),(3,2,25.00,0.00,'KG'),(3,4,3.00,0.00,'KG'),(3,6,4.00,0.00,'KG'),(3,8,6.00,0.00,'KG'),(3,10,6.00,0.00,'KG'),(3,12,10.00,0.00,'KG'),(3,14,1.50,0.00,'KG'),(3,16,3.00,0.00,'KG'),(3,18,1.80,0.00,'KG'),(3,20,1.80,0.00,'KG'),(3,22,5.00,0.00,'KG'),(3,24,30.00,0.00,'KG'),(3,26,6.00,0.00,'KG'),(3,28,6.00,0.00,'KG'),(3,30,6.00,0.00,'KG'),(3,32,5.00,0.00,'KG'),(3,34,5.00,0.00,'KG'),(3,36,2.00,0.00,'KG'),(3,38,2.00,0.00,'KG'),(3,40,24.00,0.00,'KG'),(3,42,24.00,0.00,'KG'),(3,44,24.00,0.00,'KG'),(3,46,24.00,0.00,'KG'),(3,48,24.00,0.00,'KG'),(4,2,25.00,0.00,'KG'),(4,4,3.00,0.00,'KG'),(4,6,4.00,0.00,'KG'),(4,8,6.00,0.00,'KG'),(4,10,6.00,0.00,'KG'),(4,12,10.00,0.00,'KG'),(4,14,1.50,0.00,'KG'),(4,16,3.00,0.00,'KG'),(4,18,1.80,0.00,'KG'),(4,20,1.80,0.00,'KG'),(4,22,5.00,0.00,'KG'),(4,24,30.00,0.00,'KG'),(4,26,6.00,0.00,'KG'),(4,28,6.00,0.00,'KG'),(4,30,6.00,0.00,'KG'),(4,32,5.00,0.00,'KG'),(4,34,5.00,0.00,'KG'),(4,36,2.00,0.00,'KG'),(4,38,2.00,0.00,'KG'),(4,40,24.00,0.00,'KG'),(4,42,24.00,0.00,'KG'),(4,44,24.00,0.00,'KG'),(4,46,24.00,0.00,'KG'),(4,48,24.00,0.00,'KG');
/*!40000 ALTER TABLE `stock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ticket_restaurant`
--

DROP TABLE IF EXISTS `ticket_restaurant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `ticket_restaurant` (
  `paiement_id` int(10) unsigned NOT NULL,
  `numero` varchar(50) NOT NULL,
  `etablissement_id` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`paiement_id`),
  CONSTRAINT `paiement_ticket_restaurant_fk` FOREIGN KEY (`paiement_id`) REFERENCES `paiement` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ticket_restaurant`
--

LOCK TABLES `ticket_restaurant` WRITE;
/*!40000 ALTER TABLE `ticket_restaurant` DISABLE KEYS */;
/*!40000 ALTER TABLE `ticket_restaurant` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `utilisateur`
--

DROP TABLE IF EXISTS `utilisateur`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `utilisateur` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `civilite` enum('Mlle','Mme','M') NOT NULL,
  `nom` varchar(50) NOT NULL,
  `prenom` varchar(50) NOT NULL,
  `login` varchar(50) NOT NULL,
  `mot_de_passe` varchar(255) NOT NULL,
  `magasin_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `login` (`login`),
  KEY `magasin_utilisateur_fk` (`magasin_id`),
  KEY `utilisateur_nom_idx` (`nom`),
  CONSTRAINT `magasin_utilisateur_fk` FOREIGN KEY (`magasin_id`) REFERENCES `magasin` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `utilisateur`
--

LOCK TABLES `utilisateur` WRITE;
/*!40000 ALTER TABLE `utilisateur` DISABLE KEYS */;
INSERT INTO `utilisateur` VALUES (1,'Mlle','CASTAFIORE','Bianca','Bianca','f473446011255c740bf7928c2aee1864ca35a7ea',1),(2,'M','TINTIN','Milou','Milou','b572ea601addd4d4256e624706d22e1d14bb59d0',1),(3,'M','HADDOCK','Capitaine','Capitaine','7459fd3490b080c478a967fe2d20b0ffdd0d7505',1),(4,'M','ALCAZAR','Général','Général','468dc2fe177cf7b52894acdae83473df9ca7c408',1),(5,'M','MULLER','Docteur','Docteur','844d370944fa2be3ed017be043843005050e93f4',1),(6,'M','LAMPION','Séraphin','Séraphin','0d7f9b51f1e3fea43c66730998ad03fbdb7af59d',1),(7,'M','SPONSZ','Colonel','Colonel','6ed7fcbf0b68ff3c4146eb6901d33b1015c3c41c',1),(8,'M','RACKHAM','Red','Red','312144a6cb91294f668706ea276c6b340dca1908',1),(9,'M','DA FIGUEIRA','Oliveira','Oliveira','b945aa24c97ea70d4df10004e555d01ab9ab7236',1),(10,'M','WOLF','Frank','Frank','ed5a89fc28b4cb4b05c1a67660a45283d7e9dc8d',2),(11,'M','THOMPSON','Alan','Alan','f92502e7769ccaf23df8957327a966f1d99c204d',2),(12,'M','DUPON','ThierryAlan','Thierry','f756419ec48345fd07a03338d3ddb1f3ec1b94d7',1),(13,'M','DUPON','Daniel','Daniel','f756419ec48345fd07a03338d3ddb1f3ec1b94d7',2);
/*!40000 ALTER TABLE `utilisateur` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'oc_pizza'
--
/*!50003 DROP FUNCTION IF EXISTS `est_adresse_de_magasin` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `est_adresse_de_magasin`(
	p_adresse_id INT(10) UNSIGNED) RETURNS tinyint(4)
    DETERMINISTIC
BEGIN
	DECLARE v_reponse TINYINT DEFAULT FALSE;

	SELECT COUNT(*) INTO v_reponse FROM magasin INNER JOIN adresse ON magasin.adresse_id = adresse.id WHERE adresse.id = p_adresse_id;

	RETURN (v_reponse);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `get_boisson_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `get_boisson_id`(
   p_designation VARCHAR(100)) RETURNS int(11)
    DETERMINISTIC
BEGIN
	DECLARE v_id INT(10) UNSIGNED;

   SELECT DISTINCT id INTO v_id FROM produit
   WHERE categorie = 'boisson' AND designation LIKE CONCAT("%", p_designation, "%")
   ORDER BY id LIMIT 1;

   RETURN (v_id);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `get_client_adresse_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `get_client_adresse_id`(
	p_utilisateur_id INT(10) UNSIGNED) RETURNS int(10) unsigned
    DETERMINISTIC
BEGIN
	DECLARE v_adresse_id INT(10) UNSIGNED DEFAULT 0;

	SELECT adresse_id INTO v_adresse_id FROM client WHERE utilisateur_id = p_utilisateur_id;

	RETURN (v_adresse_id);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `get_etablissement_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `get_etablissement_id`(
	p_nom VARCHAR(20)) RETURNS int(10) unsigned
    DETERMINISTIC
BEGIN
	DECLARE v_id INT(10) UNSIGNED DEFAULT 0;

	SELECT DISTINCT id INTO v_id FROM etablissement WHERE nom LIKE CONCAT('%',p_nom,'%')
	ORDER BY id ASC LIMIT 1;

	RETURN (v_id);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `get_pizza_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `get_pizza_id`(
   p_designation VARCHAR(100)) RETURNS int(11)
    DETERMINISTIC
BEGIN
	DECLARE v_id INT(10) UNSIGNED;

   SELECT DISTINCT id INTO v_id FROM produit
   WHERE categorie = 'pizza' AND designation LIKE CONCAT("%", p_designation, "%")
   ORDER BY id LIMIT 1;

   RETURN (v_id);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `get_produit_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `get_produit_id`(
   p_designation VARCHAR(100),
   p_categorie ENUM ('pack','vrac','ingrédient','pizza','boisson','dessert','emballage','sauce')) RETURNS int(11)
    DETERMINISTIC
BEGIN
	DECLARE v_id INT(10) UNSIGNED;

   SELECT DISTINCT id INTO v_id FROM produit
   WHERE categorie = p_categorie AND designation LIKE CONCAT("%", p_designation, "%")
   ORDER BY id LIMIT 1;

   RETURN (v_id);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `get_vrac_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `get_vrac_id`(
   p_designation VARCHAR(100)) RETURNS int(11)
    DETERMINISTIC
BEGIN
	DECLARE v_id INT(10) UNSIGNED;

   SELECT DISTINCT id INTO v_id FROM produit
   WHERE categorie = 'vrac' AND designation LIKE CONCAT("%", p_designation, "%")
   ORDER BY id LIMIT 1;

   RETURN (v_id);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `produit_est_disponible` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `produit_est_disponible`(
	p_magasin_id INT(10) UNSIGNED,
	p_produit_id INT(10) UNSIGNED,
	p_quantite DECIMAL(2)) RETURNS int(11)
    DETERMINISTIC
BEGIN
	DECLARE v_disponible INT DEFAULT FALSE;

	SELECT quantite>=p_quantite INTO v_disponible FROM stock
	WHERE magasin_id = p_magasin_id AND produit_id = p_produit_id;

	IF v_disponible = 1 THEN
		RETURN (v_disponible);
	ELSE
		SELECT SUM(stock.quantite>= composant.quantite*p_quantite)=COUNT(*) INTO v_disponible FROM composant
		JOIN stock ON composant.ingredient_id = stock.produit_id
		WHERE magasin_id = p_magasin_id AND composant.produit_id = p_produit_id; 
	END IF;

	RETURN (v_disponible);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `reste_du` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `reste_du`(
   p_commande_id INT(10) UNSIGNED) RETURNS decimal(5,2)
    DETERMINISTIC
BEGIN
   DECLARE v_total_paiement DECIMAL(5,2);
   DECLARE v_montant DECIMAL(5,2);

   SELECT montant_TTC INTO v_montant FROM commande WHERE id = p_commande_id;
   SELECT SUM(montant) INTO v_total_paiement FROM liste_paiement WHERE commande_id = p_commande_id;

   IF v_total_paiement IS NULL THEN
      RETURN (v_montant);
   ELSE
      RETURN (v_montant - v_total_paiement);
   END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_composant` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_composant`(
   IN p_produit_id INT(10) UNSIGNED,
   IN p_ingredient_id INT(10) UNSIGNED,
   IN p_quantite DECIMAL(5,2),
   IN p_unite VARCHAR(3))
BEGIN
   INSERT INTO composant (produit_id,ingredient_id,quantite,unite) 
   VALUES (p_produit_id,p_ingredient_id,p_quantite,p_unite);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_paiement_carte_bancaire` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_paiement_carte_bancaire`(
   IN p_commande_id INT(10) UNSIGNED,
   IN p_montant DECIMAL(5,2),   
   IN p_reference VARCHAR(100),
   OUT p_paiement_id INT(10) UNSIGNED)
BEGIN
   CALL create_paiement('carte bancaire',p_paiement_id);

   INSERT INTO carte_bancaire (paiement_id,reference,jour,heure) 
   VALUES (p_paiement_id, p_reference,CURRENT_DATE(), CURRENT_TIME());

   INSERT INTO liste_paiement (commande_id,paiement_id,montant)
   VALUES (p_commande_id, p_paiement_id, p_montant); 

   IF reste_du(p_commande_id) = 0 THEN
      UPDATE commande SET paiement_ok = TRUE WHERE id = p_commande_id;
   END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_paiement_cheque` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_paiement_cheque`(
   IN p_commande_id INT(10) UNSIGNED,
   IN p_montant DECIMAL(5,2),   
   IN p_banque TINYINT UNSIGNED,
   IN p_numero VARCHAR(100),
   OUT p_paiement_id INT(10) UNSIGNED)
BEGIN
   CALL create_paiement('chèque bancaire',p_paiement_id);

   INSERT INTO cheque (paiement_id,banque,numero,jour) 
   VALUES (p_paiement_id, p_banque,p_numero,CURRENT_DATE);

   INSERT INTO liste_paiement (commande_id,paiement_id,montant)
   VALUES (p_commande_id, p_paiement_id, p_montant); 

   IF reste_du(p_commande_id) = 0 THEN
      UPDATE commande SET paiement_ok = TRUE WHERE id = p_commande_id;
   END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_paiement_espece` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_paiement_espece`(
   IN p_commande_id INT(10) UNSIGNED,
   IN p_montant DECIMAL(5,2),   
   OUT p_paiement_id INT(10) UNSIGNED)
BEGIN
   CALL create_paiement('espèce',p_paiement_id);

   INSERT INTO liste_paiement (commande_id,paiement_id,montant)
   VALUES (p_commande_id, p_paiement_id, p_montant); 

   IF reste_du(p_commande_id) = 0 THEN
      UPDATE commande SET paiement_ok = TRUE WHERE id = p_commande_id;
   END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_paiement_ticket_restaurant` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_paiement_ticket_restaurant`(
   IN p_commande_id INT(10) UNSIGNED,
   IN p_montant DECIMAL(5,2),   
   IN p_numero VARCHAR(50),
   IN p_etablissement_id TINYINT UNSIGNED,
   OUT p_paiement_id INT(10) UNSIGNED)
BEGIN
   CALL create_paiement('ticket restaurant',p_paiement_id);

   INSERT INTO ticket_restaurant (paiement_id,numero,etablissement_id) 
   VALUES (p_paiement_id, p_numero, p_etablissement_id);

   INSERT INTO liste_paiement (commande_id,paiement_id,montant)
   VALUES (p_commande_id, p_paiement_id, p_montant); 

   IF reste_du(p_commande_id) = 0 THEN
      UPDATE commande SET paiement_ok = TRUE WHERE id = p_commande_id;
   END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ajoute_panier` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ajoute_panier`(
   IN p_utilisateur_id INT(10),
   IN p_produit_id INT(10),
   IN p_quantite DECIMAL(2,0),
   IN p_livraison TINYINT UNSIGNED)
BEGIN
   DECLARE v_quantite_old DECIMAL(2,0) DEFAULT (0.0);
   DECLARE v_prix_unitaire_ht DECIMAL(5,2) DEFAULT (0.0);
   DECLARE v_taux_tva DECIMAL(5,2) DEFAULT (0.0);
   

   
   SELECT quantite INTO v_quantite_old FROM ligne_de_panier 
   WHERE utilisateur_id = p_utilisateur_id AND produit_id = p_produit_id;

   IF v_quantite_old IS NULL THEN
      SET v_quantite_old = 0;
   END IF;

   IF p_livraison THEN
      
      SELECT prix_vente_ht, tva_livre INTO v_prix_unitaire_ht,v_taux_tva FROM produit WHERE id = p_produit_id;
   ELSE
      
      SELECT prix_vente_ht, tva_emporte INTO v_prix_unitaire_ht,v_taux_tva FROM produit WHERE id = p_produit_id;
   END IF;

   
   INSERT INTO ligne_de_panier (utilisateur_id,produit_id,quantite,prix_unitaire_ht,taux_tva)
   VALUES (p_utilisateur_id,p_produit_id,p_quantite+v_quantite_old,v_prix_unitaire_ht,v_taux_tva)
   ON DUPLICATE KEY UPDATE quantite = p_quantite + v_quantite_old, prix_unitaire_ht = v_prix_unitaire_ht, taux_tva = v_taux_tva;

  CALL update_panier(p_utilisateur_id,p_livraison);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cherche_produit_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `cherche_produit_id`(
   IN p_designation VARCHAR(100),
   IN p_categorie ENUM ('pack','vrac','ingrédient','pizza','boisson','dessert','emballage','sauce'),
   OUT p_id INT(10) UNSIGNED)
BEGIN
   
   SELECT DISTINCT id INTO p_id FROM produit
   WHERE categorie = p_categorie AND designation LIKE CONCAT("%", p_designation, "%");
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `client_prend_commande` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `client_prend_commande`(
   IN p_commande_id INT(10) UNSIGNED)
BEGIN
   DECLARE v_start_date DATE;
   DECLARE v_start_time TIME;
   DECLARE v_preparation_delai TIME;
   DECLARE v_preparation_duree TIME;
   DECLARE v_livraison_delai TIME;
   DECLARE v_livraison_duree TIME;
   DECLARE v_statut ENUM ('En attente', 'En préparation', 'Préparée', 'En livraison', 'Livrée', 'Clos');

   SELECT statut, jour, heure, preparation_delai,preparation_duree,livraison_delai 
   INTO v_statut, v_start_date,v_start_time, v_preparation_delai, v_preparation_duree, v_livraison_delai
   FROM commande WHERE id = p_commande_id;

   
   IF v_statut <> 'Préparée' AND v_statut <> 'En livraison' THEN
      INSERT INTO erreur (message) VALUES ('ERREUR : la commande n''est pas préparée!');   
   END IF;

   SET v_livraison_duree = TIMEDIFF(NOW(),TIMESTAMP(v_start_date,v_start_time));
   SET v_livraison_duree = TIMEDIFF(v_livraison_duree,v_preparation_delai);
   SET v_livraison_duree = TIMEDIFF(v_livraison_duree,v_preparation_duree);

   

   IF v_livraison_delai IS NULL THEN
      UPDATE commande SET statut = 'Livrée',  livraison_delai = 0, livraison_duree = v_livraison_duree WHERE id = p_commande_id;      
   ELSE
      SET v_livraison_duree = TIMEDIFF(v_livraison_duree, v_livraison_delai);
      UPDATE commande SET statut = 'Livrée',  livraison_duree = v_livraison_duree WHERE id = p_commande_id;
   END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `create_adresse` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `create_adresse`(
   IN p_numero VARCHAR(5),       
	IN p_voie VARCHAR(50),        
	IN p_ville VARCHAR(20),       
	IN p_code VARCHAR(5),         
	OUT p_id INT(10) UNSIGNED)
BEGIN
	SET p_id = 0;

   
	SELECT DISTINCT id INTO p_id FROM adresse
	WHERE numero = p_numero AND voie = p_voie AND ville = p_ville AND code = p_code
   ORDER BY id DESC LIMIT 1;

   
	IF p_id =  0 THEN 
		INSERT INTO adresse(numero, voie, ville, code) 
		VALUES (p_numero,p_voie, p_ville, p_code);

      
		SELECT DISTINCT id INTO p_id 
		FROM adresse 
		WHERE numero=p_numero AND voie=p_voie AND ville = p_ville AND code = p_code
      ORDER BY id DESC LIMIT 1;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `create_client` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `create_client`( 
   IN p_civilite ENUM ('Mlle','Mme','M'), 
   IN p_nom VARCHAR(50),                  
   IN p_prenom VARCHAR(50),               
   IN p_login VARCHAR(50),                
   IN p_mot_de_passe VARCHAR(255),        
   IN p_magasin_id INT(10) UNSIGNED,      
   IN p_telephone VARCHAR(10),            
   IN p_email VARCHAR(255),               
   IN p_numero VARCHAR(5),                
   IN p_voie VARCHAR(50), 
   IN p_ville VARCHAR(20),
   IN p_code VARCHAR(5),
   OUT p_id INT(10) UNSIGNED)
BEGIN
   DECLARE v_adresse_id INT(10) UNSIGNED;
        
	CALL create_adresse(p_numero, p_voie, p_ville, p_code, v_adresse_id);
	CALL create_utilisateur(p_civilite, p_nom, p_prenom, p_login, p_mot_de_passe, p_magasin_id, p_id);

	INSERT INTO client (utilisateur_id, telephone, adresse_id, email)
	VALUES (p_id, p_telephone, v_adresse_id, p_email);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `create_employe` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `create_employe`( 
   IN p_civilite ENUM ('Mlle','Mme','M'), 
   IN p_nom VARCHAR(50),                  
   IN p_prenom VARCHAR(50),               
   IN p_login VARCHAR(50),                
   IN p_mot_de_passe VARCHAR(255),        
   IN p_magasin_id INT(10) UNSIGNED,      
   IN p_role ENUM ('Accueil','Pizzaiolo','Livreur','Manager',
                  'Gestionnaire','Comptable','Direction'),     
   OUT p_id INT(10) UNSIGNED)
BEGIN
	CALL create_utilisateur(p_civilite, p_nom, p_prenom, p_login, p_mot_de_passe, p_magasin_id, p_id);

	INSERT INTO employe (utilisateur_id, role)
	VALUES (p_id, p_role);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `create_fournisseur` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `create_fournisseur`( 
   IN p_nom VARCHAR(50),         
	IN p_telephone VARCHAR(10),   
	IN p_email VARCHAR(255),      
	IN p_numero VARCHAR(5),       
	IN p_voie VARCHAR(50),        
	IN p_ville VARCHAR(20),       
	IN p_code VARCHAR(5),         
	OUT p_id INT(10) UNSIGNED)
BEGIN
	DECLARE v_adresse_id INT(10) UNSIGNED;
   
   SET p_id = 0;
   SET v_adresse_id = 0;

   
   CALL create_adresse(p_numero, p_voie, p_ville, p_code, v_adresse_id);

   
   SELECT id INTO p_id FROM fournisseur
   WHERE nom = p_nom AND telephone = p_telephone AND email = p_email AND adresse_id = v_adresse_id
   ORDER BY id DESC LIMIT 1;

   
   IF p_id > 0 THEN
      INSERT INTO erreur (message) VALUES ('ERREUR : le nom du fournisseur doit être unique!');
   ELSE
   	INSERT INTO fournisseur (nom, telephone,email,adresse_id) 
   	VALUES (p_nom, p_telephone,p_email,v_adresse_id);
   	
      
   	SELECT id INTO p_id 
   	FROM fournisseur 
   	WHERE nom=p_nom;
   END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `create_magasin` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `create_magasin`( 
   IN p_nom VARCHAR(50),        
	IN p_telephone VARCHAR(10),  
	IN p_email VARCHAR(255),     
	IN p_numero VARCHAR(5),      
	IN p_voie VARCHAR(50),       
	IN p_ville VARCHAR(20),      
   IN p_code VARCHAR(5),        
	OUT p_id INT(10) UNSIGNED)
BEGIN
   DECLARE v_adresse_id INT(10) UNSIGNED;
   
   SET p_id = 0;
   SET v_adresse_id = 0;

   
	CALL create_adresse(p_numero, p_voie, p_ville, p_code, v_adresse_id);

   
   SELECT DISTINCT id INTO p_id FROM magasin
   WHERE nom = p_nom AND telephone = p_telephone AND email = p_email AND adresse_id = v_adresse_id
      ORDER BY id DESC LIMIT 1;

   IF p_id > 0 THEN
      INSERT INTO erreur (message) VALUES ('ERREUR : le nom du magasin doit être unique!');
   ELSE
      INSERT INTO magasin (nom, telephone,email,adresse_id) 
      VALUES (p_nom, p_telephone,p_email,v_adresse_id);

      
      SELECT id INTO p_id 
      FROM magasin 
      WHERE nom=p_nom;
   END IF;  
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `create_paiement` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `create_paiement`(
   IN p_type ENUM ('espèce','carte bancaire','ticket restaurant','chèque bancaire','sans'),
   OUT p_id INT(10) UNSIGNED)
BEGIN
   INSERT INTO paiement (type) VALUES (p_type);
   SELECT id INTO p_id FROM paiement
   WHERE type = p_type
   ORDER BY id DESC LIMIT 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `create_produit` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `create_produit`(
   IN p_designation VARCHAR(100),
   IN p_categorie ENUM ('pack','vrac','ingrédient','pizza','boisson','dessert','emballage','sauce'),
   IN p_fournisseur_id INT UNSIGNED,
   IN p_reference VARCHAR(20),
   IN p_quantite DECIMAL(5,2),
   IN p_unite VARCHAR(3),
   IN p_prix_achat_ht DECIMAL(5,2),
   IN p_prix_vente_ht DECIMAL(5,2), 
   IN p_tva_emporte DECIMAL(3,1),
   IN p_tva_livre DECIMAL(3,1),
   IN p_formule TEXT,
   IN p_recette TEXT,
   OUT p_id INT(10) UNSIGNED)
BEGIN
   INSERT INTO produit (designation,categorie,fournisseur_id,reference,quantite,unite,prix_achat_ht,prix_vente_ht,tva_emporte,tva_livre) 
   VALUES (p_designation,p_categorie,p_fournisseur_id,p_reference,p_quantite,p_unite,p_prix_achat_ht,p_prix_vente_ht,p_tva_emporte,p_tva_livre);

   
   SELECT id INTO p_id FROM produit WHERE designation = p_designation;

   
   IF p_formule IS NOT NULL THEN
      INSERT INTO composition (produit_id,formule) VALUES (p_id,p_formule); 
   END IF;

   
   IF p_recette IS NOT NULL THEN
      INSERT INTO preparation (produit_id,recette) VALUES (p_id,p_recette); 
   END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `create_utilisateur` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `create_utilisateur`( 
   IN p_civilite ENUM ('Mlle','Mme','M'), 
   IN p_nom VARCHAR(50),                  
   IN p_prenom VARCHAR(50),               
   IN p_login VARCHAR(50),                
   IN p_mot_de_passe VARCHAR(255),        
   IN p_magasin_id INT UNSIGNED,          
   OUT p_id INT(10) UNSIGNED)
BEGIN
   SET p_id = 0;

   SELECT id INTO p_id FROM utilisateur
   WHERE login = p_login;

   IF p_id > 0 THEN
      INSERT INTO erreur (message) VALUES ('ERREUR : le login doit être unique!');
   ELSE 
      INSERT INTO utilisateur (civilite, nom, prenom, login, mot_de_passe, magasin_id)
      VALUES (p_civilite, p_nom, p_prenom, p_login, p_mot_de_passe, p_magasin_id);

      
      SELECT id INTO p_id
      FROM utilisateur 
      WHERE login = p_login;
   END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `diminue_stock` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `diminue_stock`(
   IN p_magasin_id INT(10),
   IN p_produit_id INT(10),
   IN p_quantite DECIMAL(5,2))
BEGIN
   DECLARE v_compose INT DEFAULT FALSE;
   DECLARE done INT DEFAULT FALSE;
   DECLARE v_quantite_old DECIMAL(5,2);
   DECLARE v_produit_id INT(10) UNSIGNED;
   DECLARE v_quantite DECIMAL(5,2);
   DECLARE curs_produit_panier CURSOR FOR 
         SELECT ingredient_id, quantite FROM composant WHERE produit_id = p_produit_id;

   DECLARE CONTINUE HANDLER FOR 
         NOT FOUND SET done = TRUE;
   
   
   SELECT (COUNT(*)>0) INTO v_compose FROM composant WHERE produit_id = p_produit_id;

   IF v_compose THEN
      
      OPEN curs_produit_panier;

      loop_curseur: LOOP 
         
         FETCH curs_produit_panier INTO v_produit_id,v_quantite;

         IF done THEN
            LEAVE loop_curseur;
         END IF;

         SELECT quantite INTO v_quantite_old FROM stock WHERE magasin_id = p_magasin_id AND produit_id = v_produit_id;
         IF v_quantite_old <= v_quantite THEN 
            UPDATE stock SET quantite = 0 WHERE magasin_id = p_magasin_id AND produit_id = v_produit_id;
         ELSE
            UPDATE stock SET quantite = v_quantite_old - v_quantite WHERE magasin_id = p_magasin_id AND produit_id = v_produit_id;
         END IF;
      END LOOP loop_curseur;

      CLOSE curs_produit_panier;
   ELSE
      
      SELECT quantite INTO v_quantite_old FROM stock WHERE magasin_id = p_magasin_id AND produit_id = p_produit_id;
      IF v_quantite_old <= p_quantite THEN 
         UPDATE stock SET quantite = 0 WHERE magasin_id = p_magasin_id AND produit_id = v_produit_id;
      ELSE
         UPDATE stock SET quantite = v_quantite_old - p_quantite WHERE magasin_id = p_magasin_id AND produit_id = v_produit_id;
      END IF;
   END IF;
   
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `enleve_panier` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `enleve_panier`(
   IN p_utilisateur_id INT(10),
   IN p_produit_id INT(10),
   IN p_quantite DECIMAL(2,0),
   IN p_livraison TINYINT UNSIGNED)
BEGIN
   DECLARE v_quantite_old DECIMAL(2,0) DEFAULT (0.0);
   DECLARE v_prix_unitaire_ht DECIMAL(5,2) DEFAULT (0.0);
   DECLARE v_taux_tva DECIMAL(5,2) DEFAULT (0.0);
      
   
   SELECT quantite INTO v_quantite_old FROM ligne_de_panier 
   WHERE utilisateur_id = p_utilisateur_id AND produit_id = p_produit_id;

   
   IF p_livraison THEN
      
      SELECT prix_vente_ht, tva_livre INTO v_prix_unitaire_ht,v_taux_tva FROM produit WHERE id = p_produit_id;
   ELSE
      
      SELECT prix_vente_ht, tva_emporte INTO v_prix_unitaire_ht,v_taux_tva FROM produit WHERE id = p_produit_id;
   END IF;

   
   IF v_quantite_old IS NULL  OR v_quantite_old <= p_quantite THEN
      DELETE FROM ligne_de_panier WHERE utilisateur_id = p_utilisateur_id AND produit_id = p_produit_id;
   ELSE 
      INSERT INTO ligne_de_panier (utilisateur_id,produit_id,quantite,prix_unitaire_ht,taux_tva)
      VALUES (p_utilisateur_id,p_produit_id,v_quantite_old - p_quantite,v_prix_unitaire_ht,v_taux_tva)
      ON DUPLICATE KEY UPDATE quantite = v_quantite_old - p_quantite, prix_unitaire_ht = v_prix_unitaire_ht, taux_tva = v_taux_tva;
   END IF;

   
   CALL update_panier(p_utilisateur_id,p_livraison);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `etape_1` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `etape_1`()
BEGIN
	SELECT "Le client 8 rempli son panier" AS Action;
	CALL ajoute_panier(8,get_pizza_id("Pizza margarita"),1,TRUE);
	CALL ajoute_panier(8,get_pizza_id("Pizza margarita"),1,TRUE);
	CALL ajoute_panier(8,get_boisson_id("Cola - 33cl/1"),1,TRUE);
	CALL ajoute_panier(8,get_boisson_id("Eau gazeuze - 50cl/1"),1,TRUE);

	SELECT "Le panier" AS Résultat;
	SELECT * FROM panier WHERE utilisateur_id = 8;
	SELECT * FROM ligne_de_panier WHERE utilisateur_id = 8;

	SELECT "Le client 8 enleve un produit et passe en take away" AS Action;
	CALL enleve_panier(8,get_pizza_id("margarita"),1,FALSE);

	SELECT "Le panier" AS Résultat;
	SELECT * FROM panier ;
	SELECT * FROM ligne_de_panier;

	SELECT "Le client 8 ajoute un produit et repasse en livraison" AS Action;
	CALL ajoute_panier(8,get_pizza_id("4 fromages"),1,TRUE);
	
	SELECT "Le panier" AS Résultat;
	SELECT * FROM panier ;
	SELECT * FROM ligne_de_panier;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `etape_2` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `etape_2`()
BEGIN
	SELECT "Le client 8 valide son panier" AS Action;
	CALL valide_commande(8,@ID);

	SELECT "Le panier est vide" AS Resultat;
	SELECT * FROM panier WHERE utilisateur_id = 8;
	SELECT * FROM ligne_de_panier WHERE utilisateur_id = 8;

	SELECT "La commande est validée non payée et avec le statut En attente";
	SELECT id,utilisateur_id, statut, jour, heure, paiement_OK 
	FROM commande WHERE utilisateur_id = 8;
	
	SELECT commande_id AS IDC, 
		produit_id AS IDP,
	 	quantite AS Quantité, 
	 	prix_unitaire_ht*(1+taux_tva/100) AS Prix 
	FROM ligne_de_commande 
	WHERE commande_id = @ID;
	
	SELECT reste_du(@ID) AS "Reste du";

	SELECT "Le client 8 effectue le paiement par CB" AS Action;
	CALL add_paiement_carte_bancaire(@ID,35.42,"ERGQGQD6546",@IDPAIEMENT);
	
	SELECT "La commande est payée" AS Resultat;
	SELECT id,utilisateur_id, statut, jour, heure, paiement_OK 
	FROM commande 
	WHERE utilisateur_id = 8;
	

	SELECT commande_id, paiement_id, montant, type 
	FROM liste_paiement 
	JOIN paiement ON paiement.id = liste_paiement.paiement_id 
	WHERE commande_id = @ID;
	
	SELECT reste_du(@ID) AS "Reste du";

	SELECT "Le paiement apparait dans les paiements" AS Resultat;
	SELECT * FROM liste_paiement;
	SELECT * FROM paiement;
	SELECT "paiement par carte bancaire" AS Resultat;
	SELECT paiement_id AS id, reference, jour, heure FROM carte_bancaire;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `etape_3` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `etape_3`()
BEGIN
	SELECT "Le client 9 rempli son panier en take away" AS Action;
	CALL ajoute_panier(9,get_pizza_id("Pizza margarita"),1,FALSE);
	CALL ajoute_panier(9,get_boisson_id("Cola - 33cl/1"),1,FALSE);
	SELECT * FROM panier;
	SELECT * FROM ligne_de_panier ;

	SELECT "Le client 9 valide son panier" AS Action;
	CALL valide_commande(9, @commande);

	SELECT "Le panier est vide";
	SELECT * FROM panier WHERE utilisateur_id = 9;
	SELECT * FROM ligne_de_panier WHERE utilisateur_id = 9;

	SELECT "La commande est validée non payée et avec le statut En attente" AS Résultat;
	SELECT id,utilisateur_id, statut, jour, heure, paiement_OK
	FROM commande WHERE utilisateur_id = 9;

	SELECT commande_id AS IDC, 
		produit_id AS IDP, 
		quantite AS Quantité, 
		prix_unitaire_ht*(1+taux_tva/100) AS Prix 
		FROM ligne_de_commande 
		WHERE commande_id = @commande;

	SELECT reste_du(@commande) AS "Reste du";
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `etape_4` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `etape_4`()
BEGIN
	SELECT "Le client 9 effectue le paiement par Ticket Restaurant" AS Action;
	CALL add_paiement_ticket_restaurant(@commande,8.20,"ERGQGQD6546",get_etablissement_id("Pass"),@IDPAIEMENT);

	SELECT id,utilisateur_id, statut, jour, heure, paiement_OK 
	FROM commande 
	WHERE utilisateur_id = 9;

	SELECT commande_id, paiement_id, montant, type 
	FROM liste_paiement 
	JOIN paiement ON paiement.id = liste_paiement.paiement_id 
	WHERE commande_id = @commande;

	SELECT reste_du(@commande) AS "Reste du";

	SELECT "Le paiement apparait dans les paiements" AS Résultat;
	SELECT * FROM liste_paiement;
	SELECT * FROM paiement;
	
	SELECT paiement_id AS id, numero, etablissement.nom AS nom
	FROM ticket_restaurant
		JOIN etablissement ON ticket_restaurant.etablissement_id = etablissement.id;

	SELECT "Le client 9 effectue le reste du paiement en espèce" AS Action;
	CALL add_paiement_espece(@commande,10.53,@IDPAIEMENT);

	SELECT "Le paiement apparait dans les paiements" AS Résultat;
	SELECT * FROM liste_paiement;
	SELECT * FROM paiement;

	SELECT "La commande est payée" AS Résultat;
	SELECT id,utilisateur_id, statut, jour, heure, paiement_OK 
	FROM commande 
	WHERE utilisateur_id = 9;

	SELECT commande_id, paiement_id, montant, type 
	FROM liste_paiement 
	JOIN paiement ON paiement.id = liste_paiement.paiement_id 
	WHERE commande_id = @commande;

	SELECT reste_du(@commande) AS "Reste du";
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `etape_5` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `etape_5`()
BEGIN
	EXECUTE l_commande;

	SELECT "Le pizzaiolo prend la commande 1" AS Action;
	CALL pizzaiolo_prend_commande(1);
	
	EXECUTE l_commande;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `etape_6` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `etape_6`()
BEGIN
	
	SELECT "Le pizzaiolo termine la commande 1 et prend la commande 2" AS Action;
	CALL pizzaiolo_termine_commande(1);
	CALL pizzaiolo_prend_commande(2);

	EXECUTE l_commande;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `etape_7` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `etape_7`()
BEGIN
	SELECT "Le pizzaiolo termine la commande 2 et le livreur prend la commande 1" AS Action;
	CALL livreur_prend_commande(1);
	CALL pizzaiolo_termine_commande(2);

	EXECUTE l_commande;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `etape_8` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `etape_8`()
BEGIN
	SELECT "Le client prend la commande 1 et un autre la commande 2" AS Action;
	CALL client_prend_commande(1);
	CALL client_prend_commande(2);

	EXECUTE l_commande;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `etape_9` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `etape_9`()
BEGIN
	CALL etape_1;
	CALL etape_2;
	CALL etape_3;
	CALL etape_4;
	CALL etape_5;
	CALL etape_6;
	CALL etape_7;
	CALL etape_8;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `liste_client_suivant_nom` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `liste_client_suivant_nom`(
   IN p_nom VARCHAR(50))
BEGIN
   IF p_nom IS NULL OR p_nom = '*'THEN
      SELECT utilisateur.id,
               utilisateur.civilite,
               utilisateur.prenom,
               utilisateur.nom,
               client.telephone,
               client.email,
               CONCAT_WS("",adresse.appartement,
            adresse.etage,
            adresse.couloir,
            adresse.escalier,
            adresse.entree,
            adresse.immeuble,
            adresse.residence,
            adresse.numero,
            adresse.voie,
            adresse.place,
            adresse.code,
            adresse.ville,
            adresse.pays)  AS adresse
      FROM utilisateur
      INNER JOIN client ON client.utilisateur_id = utilisateur.id
      INNER JOIN adresse ON adresse.id = client.adresse_id;
   ELSE
      SELECT utilisateur.id,
            utilisateur.civilite,
            utilisateur.prenom,
            utilisateur.nom,
            client.telephone,
            client.email,
            CONCAT_WS("",adresse.appartement,
            adresse.etage,
            adresse.couloir,
            adresse.escalier,
            adresse.entree,
            adresse.immeuble,
            adresse.residence,
            adresse.numero,
            adresse.voie,
            adresse.place,
            adresse.code,
            adresse.ville,
            adresse.pays)  AS adresse
      FROM utilisateur
      INNER JOIN client ON client.utilisateur_id = utilisateur.id
      INNER JOIN adresse ON adresse.id = client.adresse_id
      WHERE utilisateur.nom LIKE CONCAT('%',p_nom,'%');
   END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `liste_client_suivant_prenom` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `liste_client_suivant_prenom`(
   IN p_prenom VARCHAR(50))
BEGIN
   IF p_prenom IS NULL OR p_prenom = '*'THEN
      SELECT utilisateur.id,
               utilisateur.civilite,
               utilisateur.prenom,
               utilisateur.nom,
               client.telephone,
               client.email,
               CONCAT_WS("",adresse.appartement,
            adresse.etage,
            adresse.couloir,
            adresse.escalier,
            adresse.entree,
            adresse.immeuble,
            adresse.residence,
            adresse.numero,
            adresse.voie,
            adresse.place,
            adresse.code,
            adresse.ville,
            adresse.pays)  AS adresse
      FROM utilisateur
      INNER JOIN client ON client.utilisateur_id = utilisateur.id
      INNER JOIN adresse ON adresse.id = client.adresse_id;
   ELSE
      SELECT utilisateur.id,
            utilisateur.civilite,
            utilisateur.prenom,
            utilisateur.nom,
            client.telephone,
            client.email,
            CONCAT_WS("",adresse.appartement,
            adresse.etage,
            adresse.couloir,
            adresse.escalier,
            adresse.entree,
            adresse.immeuble,
            adresse.residence,
            adresse.numero,
            adresse.voie,
            adresse.place,
            adresse.code,
            adresse.ville,
            adresse.pays)  AS adresse
      FROM utilisateur
      INNER JOIN client ON client.utilisateur_id = utilisateur.id
      INNER JOIN adresse ON adresse.id = client.adresse_id
      WHERE utilisateur.prenom LIKE CONCAT('%',p_prenom,'%');
   END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `liste_employe_suivant_nom` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `liste_employe_suivant_nom`(
   IN p_nom VARCHAR(50))
BEGIN
   IF p_nom IS NULL OR p_nom = '*'THEN
   SELECT utilisateur.id,
         utilisateur.civilite,
         utilisateur.prenom,
         utilisateur.nom,
         employe.role FROM utilisateur
      INNER JOIN employe 
      ON employe.utilisateur_id = utilisateur.id;
   ELSE
      SELECT utilisateur.id,
         utilisateur.civilite,
         utilisateur.prenom,
         utilisateur.nom,
         employe.role FROM utilisateur
      INNER JOIN employe 
      ON employe.utilisateur_id = utilisateur.id 
      WHERE nom LIKE CONCAT('%',p_nom,'%');
   END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `liste_employe_suivant_prenom` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `liste_employe_suivant_prenom`(
   IN p_prenom VARCHAR(50))
BEGIN
   IF p_prenom IS NULL OR p_prenom = '*'THEN
   SELECT utilisateur.id,
         utilisateur.civilite,
         utilisateur.prenom,
         utilisateur.nom,
         employe.role FROM utilisateur
      INNER JOIN employe 
      ON employe.utilisateur_id = utilisateur.id;
   ELSE
      SELECT utilisateur.id,
         utilisateur.civilite,
         utilisateur.prenom,
         utilisateur.nom,
         employe.role FROM utilisateur
      INNER JOIN employe 
      ON employe.utilisateur_id = utilisateur.id
            WHERE prenom LIKE CONCAT('%',p_prenom,'%');
   END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `liste_employe_suivant_role` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `liste_employe_suivant_role`(
   IN p_role ENUM('Accueil','Pizzaiolo','Livreur','Manager','Gestionnaire','Comptable','Direction') )
BEGIN
   IF p_role IS NULL OR p_role = '*'THEN
   SELECT utilisateur.id,
         utilisateur.civilite,
         utilisateur.prenom,
         utilisateur.nom,
         employe.role FROM utilisateur
      INNER JOIN employe 
      ON utilisateur.id = employe.utilisateur_id;
   ELSE
      SELECT utilisateur.id,
         utilisateur.civilite,
         utilisateur.prenom,
         utilisateur.nom,
         employe.role FROM utilisateur
      INNER JOIN employe 
      ON employe.utilisateur_id = utilisateur.id
      WHERE role LIKE CONCAT('%',p_role,'%');
   END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `liste_fournisseur_suivant_nom` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `liste_fournisseur_suivant_nom`(
   IN p_nom VARCHAR(50))
BEGIN

   IF p_nom IS NULL OR p_nom = '*'THEN
   SELECT fournisseur.id,
         fournisseur.nom,
         fournisseur.telephone,
         fournisseur.email,
         CONCAT_WS("",adresse.appartement,
            adresse.etage,
            adresse.couloir,
            adresse.escalier,
            adresse.entree,
            adresse.immeuble,
            adresse.residence,
            adresse.numero,
            adresse.voie,
            adresse.place,
            adresse.code,
            adresse.ville,
            adresse.pays) AS adresse
      FROM fournisseur
      INNER JOIN adresse 
      ON fournisseur.adresse_id = adresse.id;
   ELSE
      SELECT fournisseur.id,
         fournisseur.nom,
         fournisseur.telephone,
         fournisseur.email,
         CONCAT_WS("",adresse.appartement,
            adresse.etage,
            adresse.couloir,
            adresse.escalier,
            adresse.entree,
            adresse.immeuble,
            adresse.residence,
            adresse.numero,
            adresse.voie,
            adresse.place,
            adresse.code,
            adresse.ville,
            adresse.pays)  AS adresse
      FROM fournisseur
      INNER JOIN adresse 
      ON fournisseur.adresse_id = adresse.id
      WHERE nom LIKE CONCAT('%',p_nom,'%');
   END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `liste_ingredient_produit_par_designation` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `liste_ingredient_produit_par_designation`(
   IN p_designation VARCHAR(100))
BEGIN
   DECLARE v_id INT(10) UNSIGNED;

   SET v_id = get_produit_id(p_designation);

   SELECT produit.id AS ID,
      produit.designation AS Désignation,
      composant.quantite AS Quantité,
      composant.unite AS Unité FROM composant
   INNER JOIN produit
   ON composant.ingredient_id = produit.id
   WHERE composant.produit_id = v_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `liste_ingredient_produit_par_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `liste_ingredient_produit_par_id`(
   IN p_id INT(10) UNSIGNED)
BEGIN
   SELECT produit.id AS ID,
      produit.designation AS Désignation,
      composant.quantite AS Quantité,
      composant.unite AS Unité FROM composant
   INNER JOIN produit
   ON composant.ingredient_id = produit.id
   WHERE composant.produit_id = p_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `liste_magasin_suivant_nom` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `liste_magasin_suivant_nom`(
   IN p_nom VARCHAR(50))
BEGIN

   IF p_nom IS NULL OR p_nom = '*'THEN
   SELECT magasin.id,
         magasin.nom,
         magasin.telephone,
         magasin.email,
         CONCAT_WS("",adresse.appartement,
            adresse.etage,
            adresse.couloir,
            adresse.escalier,
            adresse.entree,
            adresse.immeuble,
            adresse.residence,
            adresse.numero,
            adresse.voie,
            adresse.place,
            adresse.code,
            adresse.ville,
            adresse.pays)  AS adresse
      FROM magasin
      INNER JOIN adresse 
      ON magasin.adresse_id = adresse.id;
   ELSE
      SELECT magasin.id,
         magasin.nom,
         magasin.telephone,
         magasin.email,
         CONCAT_WS("",adresse.appartement,
            adresse.etage,
            adresse.couloir,
            adresse.escalier,
            adresse.entree,
            adresse.immeuble,
            adresse.residence,
            adresse.numero,
            adresse.voie,
            adresse.place,
            adresse.code,
            adresse.ville,
            adresse.pays)  AS adresse
      FROM magasin
      INNER JOIN adresse 
      ON magasin.adresse_id = adresse.id
      WHERE nom LIKE CONCAT('%',p_nom,'%');
   END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `liste_produit_vendable` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `liste_produit_vendable`(
   IN p_magasin_id INT(10) UNSIGNED)
BEGIN
   SELECT produit.id, produit.designation, produit.prix_vente_ht FROM produit 
   LEFT  JOIN stock ON produit.id = stock.produit_id
   WHERE (magasin_id = p_magasin_id OR magasin_id IS NULL) 
   AND (categorie NOT IN ('pack','vrac','ingrédient'))
   AND (stock.quantite > 0 OR stock.quantite IS NULL);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `livraison` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `livraison`(
   IN p_magasin_id INT(10) UNSIGNED,
   IN p_produit_id INT(10) UNSIGNED,
   IN p_quantite DECIMAL(5,2))
BEGIN
   DECLARE v_unite_par_produit DECIMAL(5,2) DEFAULT (1.0);
   DECLARE v_vrac_id INT(10) UNSIGNED;
   DECLARE v_exist INT DEFAULT 0 ;
   DECLARE v_stock_initial DECIMAL(5,2) DEFAULT (0.0);

   SELECT quantite,ingredient_id INTO v_unite_par_produit,v_vrac_id FROM composant WHERE produit_id = p_produit_id;

   SELECT quantite, COUNT(*) INTO v_stock_initial,v_exist FROM stock 
   WHERE magasin_id = p_magasin_id AND produit_id = v_vrac_id;

  IF v_exist = 0 THEN
    INSERT INTO stock (magasin_id,produit_id,quantite)
    VALUES (p_magasin_id, v_vrac_id,p_quantite*v_unite_par_produit);
  ELSE    
    UPDATE stock
    SET quantite = p_quantite*v_unite_par_produit + v_stock_initial
    WHERE magasin_id = p_magasin_id AND produit_id = v_vrac_id;    
  END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `livreur_prend_commande` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `livreur_prend_commande`(
   IN p_commande_id INT(10) UNSIGNED)
BEGIN
   DECLARE v_start_date DATE;
   DECLARE v_start_time TIME;
   DECLARE v_preparation_delai TIME;
   DECLARE v_preparation_duree TIME;
   DECLARE v_livraison_delai TIME;
   DECLARE v_statut ENUM ('En attente', 'En préparation', 'Préparée', 'En livraison', 'Livrée', 'Clos');

   SELECT statut, jour, heure, preparation_delai,preparation_duree 
   INTO v_statut,v_start_date,v_start_time, v_preparation_delai, v_preparation_duree 
   FROM commande WHERE id = p_commande_id;

   IF v_statut = 'Préparée' THEN
      SET v_livraison_delai = TIMEDIFF(NOW(),TIMESTAMP(v_start_date,v_start_time));
      SET v_livraison_delai = TIMEDIFF(v_livraison_delai, v_preparation_delai);   
      SET v_livraison_delai = TIMEDIFF(v_livraison_delai, v_preparation_duree);   
      UPDATE commande SET statut = 'En livraison', livraison_delai = v_livraison_delai WHERE id = p_commande_id;
   ELSE 
      INSERT INTO erreur (message) VALUES ('ERREUR : la commande n''est pas préparée!');   
   END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `livre_magasin` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `livre_magasin`()
BEGIN
   DECLARE v_magasin_id INT(10) DEFAULT 1;
   DECLARE v_produit_id INT(10) DEFAULT 1;
   DECLARE done INT DEFAULT FALSE;

   DECLARE curs_produit CURSOR FOR SELECT id FROM produit WHERE categorie IN ("ingrédient","pack");

   DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

   OPEN curs_produit;

   loop_curseur: LOOP 
      FETCH curs_produit INTO v_produit_id;

      IF done THEN
         LEAVE loop_curseur;
      END IF;

      REPEAT
         CALL livraison(v_magasin_id,v_produit_id,1);   
         SET v_magasin_id = v_magasin_id + 1;
      UNTIL v_magasin_id > 4
      END REPEAT;
      SET v_magasin_id = 1;
   END LOOP loop_curseur;

   CLOSE curs_produit;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `pizzaiolo_prend_commande` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `pizzaiolo_prend_commande`(
   IN p_commande_id INT(10) UNSIGNED)
BEGIN
   DECLARE v_start_date DATE;
   DECLARE v_start_time TIME;
   DECLARE v_preparation_delai TIME;
   DECLARE v_statut ENUM ('En attente', 'En préparation', 'Préparée', 'En livraison', 'Livrée', 'Clos');

   SELECT statut, jour, heure INTO v_statut,v_start_date,v_start_time FROM commande WHERE id = p_commande_id;

   
   IF v_statut = 'En attente' THEN
      SET v_preparation_delai = TIMEDIFF(NOW(),TIMESTAMP(v_start_date,v_start_time));
      UPDATE commande SET statut = 'En préparation', preparation_delai = v_preparation_delai WHERE id = p_commande_id;
   ELSE
      INSERT INTO erreur (message) VALUES ('ERREUR : la commande n''est pas en attente!');
   END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `pizzaiolo_termine_commande` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `pizzaiolo_termine_commande`(
   IN p_commande_id INT(10) UNSIGNED)
BEGIN
   DECLARE v_start_date DATE;
   DECLARE v_start_time TIME;
   DECLARE v_preparation_delai TIME;
   DECLARE v_preparation_duree TIME;
   DECLARE v_statut ENUM ('En attente', 'En préparation', 'Préparée', 'En livraison', 'Livrée', 'Clos');

   SELECT statut, jour, heure, preparation_delai INTO v_statut, v_start_date,v_start_time,v_preparation_delai FROM commande WHERE id = p_commande_id;

   
   IF v_statut = 'En préparation' THEN
      SET v_preparation_duree = TIMEDIFF(NOW(),TIMESTAMP(v_start_date,v_start_time));   
      SET v_preparation_duree = TIMEDIFF(v_preparation_duree, v_preparation_delai);   
      UPDATE commande SET statut = 'Préparée', preparation_duree = v_preparation_duree WHERE id = p_commande_id;
   ELSE
      INSERT INTO erreur (message) VALUES ('ERREUR : la commande n''est pas en préparation!');   
   END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_panier` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_panier`(
   IN p_utilisateur_id INT(10),
   IN p_livraison TINYINT UNSIGNED)
BEGIN
   DECLARE v_montant DECIMAL(5,2) DEFAULT (0.0);
   DECLARE v_livraison_modifie TINYINT DEFAULT FALSE;

   
   SELECT (livraison <> p_livraison) INTO v_livraison_modifie FROM panier WHERE utilisateur_id = p_utilisateur_id;

   IF v_livraison_modifie THEN
      IF p_livraison THEN
         
         UPDATE ligne_de_panier
         SET taux_tva = (SELECT tva_livre FROM produit WHERE produit.id = ligne_de_panier.produit_id)  
         WHERE ligne_de_panier.utilisateur_id = p_utilisateur_id;
      ELSE
         
         UPDATE ligne_de_panier
         SET taux_tva = (SELECT tva_emporte FROM produit WHERE produit.id = ligne_de_panier.produit_id)  
         WHERE ligne_de_panier.utilisateur_id = p_utilisateur_id;
      END IF;
   END IF;

   SELECT SUM(quantite*prix_unitaire_ht*(1+taux_tva/100)) INTO v_montant FROM ligne_de_panier WHERE utilisateur_id = p_utilisateur_id;

   INSERT INTO  panier (utilisateur_id,jour,heure,montant_ttc,livraison)
   VALUES ( p_utilisateur_id,CURRENT_DATE(), CURRENT_TIME(), v_montant, p_livraison)
   ON DUPLICATE KEY UPDATE jour = CURRENT_DATE(), heure = CURRENT_TIME(), montant_ttc = v_montant, livraison = p_livraison;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `valide_commande` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `valide_commande`(
   IN p_utilisateur_id INT(10) UNSIGNED,
   OUT p_commande_id INT(10) UNSIGNED)
BEGIN
   DECLARE v_jour DATE DEFAULT CURRENT_DATE();
   DECLARE v_heure TIME DEFAULT CURRENT_TIME();
   DECLARE v_montant_ttc DECIMAL(5,2) DEFAULT (0.0);
   DECLARE v_adresse_id INT(10) UNSIGNED;
   DECLARE v_livraison TINYINT UNSIGNED DEFAULT TRUE;
   DECLARE v_magasin_id INT(10) UNSIGNED;
   DECLARE v_produit_id INT(10) UNSIGNED;
   DECLARE v_quantite DECIMAL(5,2) DEFAULT (0.0);
   DECLARE done INT DEFAULT FALSE;
   DECLARE curseur_verification CURSOR FOR 
      SELECT produit_id,quantite FROM ligne_de_panier WHERE utilisateur_id = p_utilisateur_id;
   DECLARE curseur_modification CURSOR FOR 
      SELECT produit_id,quantite FROM ligne_de_panier WHERE utilisateur_id = p_utilisateur_id;

   DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

   
   SELECT magasin_id INTO v_magasin_id FROM utilisateur WHERE id = p_utilisateur_id;

   
   OPEN curseur_verification;
   loop_vérification: LOOP 
      FETCH curseur_verification INTO v_produit_id,v_quantite;

      IF done THEN
         LEAVE loop_vérification;
      END IF;

      IF produit_est_disponible(v_magasin_id,v_produit_id,v_quantite) = FALSE THEN
         
         CALL enleve_panier(p_utilisateur_id,v_produit_id,v_quantite);
         INSERT INTO erreur (message) VALUES ('ERREUR : un produit n''est plus disponible!');
      END IF;
   END LOOP loop_vérification;

   CLOSE curseur_verification;

   
   SELECT montant_ttc,livraison INTO v_montant_ttc,v_livraison from panier WHERE utilisateur_id = p_utilisateur_id;

   IF v_livraison THEN
      
      SELECT adresse.id INTO v_adresse_id FROM adresse
      JOIN client ON adresse.id = client.adresse_id
      WHERE client.utilisateur_id = p_utilisateur_id;
   ELSE
      
      SELECT adresse.id INTO v_adresse_id FROM adresse
      JOIN magasin ON adresse.id = magasin.adresse_id
      WHERE magasin.id = v_magasin_id;
   END IF;

   
   INSERT INTO commande (utilisateur_id, adresse_id, statut, jour, heure, montant_ttc)
   VALUES (p_utilisateur_id, v_adresse_id, 'En attente', v_jour, v_heure, v_montant_ttc);

   
   SELECT DISTINCT id INTO p_commande_id FROM commande
   WHERE utilisateur_id = p_utilisateur_id AND adresse_id = v_adresse_id AND statut = 'En attente' AND jour = v_jour AND heure = v_heure;

   
   SET done = FALSE;
  
   OPEN curseur_modification;
   loop_modification: LOOP 
      FETCH curseur_modification INTO v_produit_id,v_quantite;

      IF done THEN
         LEAVE loop_modification;
      END IF;

      CALL diminue_stock(v_magasin_id,v_produit_id,v_produit_id);

   END LOOP loop_modification;

   CLOSE curseur_modification;

   
   INSERT INTO ligne_de_commande (commande_id,produit_id,quantite,prix_unitaire_ht, taux_tva)
   SELECT p_commande_id,produit_id,quantite,prix_unitaire_ht, taux_tva FROM ligne_de_panier 
   WHERE utilisateur_id = p_utilisateur_id;
   
   
   
   DELETE FROM ligne_de_panier WHERE utilisateur_id = p_utilisateur_id;
   DELETE FROM panier WHERE utilisateur_id = p_utilisateur_id;

END ;;
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

-- Dump completed on 2019-10-20 18:49:56
