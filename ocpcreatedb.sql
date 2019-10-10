################################################################################
# CREATE DATABASE                                                     OC PIZZA #
################################################################################
CREATE DATABASE oc_pizza CHARACTER SET 'utf8';

USE oc_pizza;


################################################################################
#                                                                       GLOBAL #
################################################################################

####################################################################### ERREUR #
DROP TABLE IF EXISTS erreur;
CREATE TABLE erreur (
   id TINYINT UNSIGNED AUTO_INCREMENT NOT NULL,
   message VARCHAR(100) UNIQUE,
   PRIMARY KEY (id)
   )ENGINE=InnoDB;

DESCRIBE erreur;

INSERT INTO erreur (message) VALUES ('ERREUR : l''adresse doit être unique!');
INSERT INTO erreur (message) VALUES ('ERREUR : le login doit être unique!');
INSERT INTO erreur (message) VALUES ('ERREUR : le nom du magasin doit être unique!');
INSERT INTO erreur (message) VALUES ('ERREUR : le nom du fournisseur doit être unique!');
INSERT INTO erreur (message) VALUES ('ERREUR : un produit n''est plus disponible!');

SELECT * FROM erreur;

###################################################################### ADRESSE #
DROP TABLE IF EXISTS adresse;
CREATE TABLE adresse (
   id INT UNSIGNED AUTO_INCREMENT NOT NULL,
   appartement VARCHAR(4),
   etage VARCHAR(3),
   couloir VARCHAR(3),
   escalier VARCHAR(3),
   entree VARCHAR(3),
   immeuble VARCHAR(10),
   residence VARCHAR(20),
   numero VARCHAR(5),
   voie VARCHAR(50),
   place VARCHAR(50),
   code VARCHAR(5) NOT NULL,
   ville VARCHAR(20) NOT NULL,
   pays VARCHAR(20) DEFAULT 'FRANCE' NOT NULL,
   commentaire TEXT,
   PRIMARY KEY (id)
)ENGINE=InnoDB;
DESCRIBE adresse;

DROP TRIGGER IF EXISTS before_insert_adresse;
DELIMITER |
CREATE TRIGGER before_insert_adresse 
BEFORE INSERT ON adresse FOR EACH ROW
BEGIN
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
END |
DELIMITER ;

DROP TRIGGER IF EXISTS before_update_adresse;
DELIMITER |
CREATE TRIGGER before_update_adresse 
BEFORE UPDATE ON adresse FOR EACH ROW
BEGIN
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
END |
DELIMITER ;

################################################################## FOURNISSEUR #
DROP TABLE IF EXISTS fournisseur;
CREATE TABLE fournisseur (
                id INT UNSIGNED AUTO_INCREMENT NOT NULL,
                nom VARCHAR(50) NOT NULL,
                telephone VARCHAR(10) NOT NULL,
                email VARCHAR(255) NOT NULL,
                adresse_id INT UNSIGNED NOT NULL,
                PRIMARY KEY (id,nom)
)ENGINE=InnoDB;

ALTER TABLE fournisseur ADD CONSTRAINT adresse_fournisseur_fk
FOREIGN KEY (adresse_id)
REFERENCES adresse (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

DESCRIBE fournisseur;


###################################################################### MAGASIN #
DROP TABLE IF EXISTS magasin;
CREATE TABLE magasin (
                id INT UNSIGNED AUTO_INCREMENT NOT NULL,
                nom VARCHAR(50) NOT NULL,
                telephone VARCHAR(10) NOT NULL,
                email VARCHAR(255) NOT NULL,
                adresse_id INT UNSIGNED NOT NULL,
                PRIMARY KEY (id,nom)
)ENGINE=InnoDB;

ALTER TABLE magasin ADD CONSTRAINT adresse_magasin_fk
FOREIGN KEY (adresse_id)
REFERENCES adresse (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE magasin
ADD INDEX magasin_nom_idx (nom);

DESCRIBE magasin;


################################################################################
#                                                                  UTILISATEUR #
################################################################################

################################################################## UTILISATEUR #
DROP TABLE IF EXISTS utilisateur;
CREATE TABLE utilisateur (
                id INT UNSIGNED AUTO_INCREMENT NOT NULL,
                civilite ENUM('Mlle','Mme','M') NOT NULL,
                nom VARCHAR(50) NOT NULL,
                prenom VARCHAR(50) NOT NULL,
                login VARCHAR(50) NOT NULL UNIQUE,
                mot_de_passe VARCHAR(255) NOT NULL,
                magasin_id INT UNSIGNED NOT NULL,
                PRIMARY KEY (id)
)ENGINE=InnoDB;

ALTER TABLE utilisateur ADD CONSTRAINT magasin_utilisateur_fk
FOREIGN KEY (magasin_id)
REFERENCES magasin (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE utilisateur
ADD INDEX utilisateur_nom_idx (nom);

DESCRIBE utilisateur;


###################################################################### EMPLOYE #
DROP TABLE IF EXISTS employe;
CREATE TABLE employe (
                utilisateur_id INT UNSIGNED NOT NULL,
                role ENUM ('Accueil','Pizzaiolo','Livreur','Manager',
                        'Gestionnaire','Comptable','Direction') NOT NULL,
                PRIMARY KEY (utilisateur_id)
)ENGINE=InnoDB;

ALTER TABLE employe ADD CONSTRAINT utilisateur_employe_fk
FOREIGN KEY (utilisateur_id)
REFERENCES utilisateur (id)
ON DELETE CASCADE
ON UPDATE CASCADE;

DESCRIBE employe;


####################################################################### CLIENT #
DROP TABLE IF EXISTS client;
CREATE TABLE client (
                utilisateur_id INT UNSIGNED NOT NULL,
                telephone VARCHAR(10) NOT NULL,
                adresse_id INT UNSIGNED NOT NULL,
                email VARCHAR(255) NOT NULL UNIQUE,
                PRIMARY KEY (utilisateur_id)
)ENGINE=InnoDB;

ALTER TABLE client ADD CONSTRAINT utilisateur_client_fk
FOREIGN KEY (utilisateur_id)
REFERENCES utilisateur (id)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE client ADD CONSTRAINT adresse_client_fk
FOREIGN KEY (adresse_id)
REFERENCES adresse (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

DESCRIBE client;

################################################################################
#                                                                      PRODUIT #
################################################################################

###################################################################### PRODUIT #
DROP TABLE IF EXISTS produit;
CREATE TABLE produit (
                id INT UNSIGNED AUTO_INCREMENT NOT NULL,
                designation VARCHAR(100) UNIQUE NOT NULL,
                categorie ENUM ('pack','vrac','ingrédient','pizza','boisson','dessert','emballage','sauce') NOT NULL,
                fournisseur_id INT UNSIGNED,
                reference VARCHAR(20),
                quantite DECIMAL(5,2) DEFAULT (0.0),
                unite VARCHAR(3),
                prix_achat_ht DECIMAL(5,2) DEFAULT (0.0),
                prix_vente_ht DECIMAL(5,2) DEFAULT (0.0),
                PRIMARY KEY (id)
)ENGINE=InnoDB;

ALTER TABLE produit ADD CONSTRAINT fournisseur_produit_fk
FOREIGN KEY (fournisseur_id)
REFERENCES fournisseur (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

DESCRIBE produit;


################################################################## PREPARATION #
DROP TABLE IF EXISTS preparation;
CREATE TABLE preparation (
                produit_id INT UNSIGNED NOT NULL,
                recette TEXT NOT NULL,
                PRIMARY KEY (produit_id)
)ENGINE=InnoDB;

ALTER TABLE preparation ADD CONSTRAINT produit_preparation_fk
FOREIGN KEY (produit_id)
REFERENCES produit (id)
ON DELETE CASCADE
ON UPDATE CASCADE;

DESCRIBE preparation;


################################################################## COMPOSITION #
DROP TABLE IF EXISTS composition;
CREATE TABLE composition (
                produit_id INT UNSIGNED NOT NULL,
                formule TEXT NOT NULL,
                PRIMARY KEY (produit_id)
)ENGINE=InnoDB;

ALTER TABLE composition ADD CONSTRAINT produit_composition_fk
FOREIGN KEY (produit_id)
REFERENCES produit (id)
ON DELETE CASCADE
ON UPDATE CASCADE;

DESCRIBE composition;


#################################################################### COMPOSANT #
DROP TABLE IF EXISTS composant;
CREATE TABLE composant (
                produit_id INT UNSIGNED NOT NULL,
                ingredient_id INT UNSIGNED NOT NULL,
                quantite DECIMAL(5,2) DEFAULT (0) NOT NULL,
                unite VARCHAR(3) NOT NULL,
                PRIMARY KEY (produit_id, ingredient_id)
)ENGINE=InnoDB;

ALTER TABLE composant ADD CONSTRAINT produit_composition_produit_fk
FOREIGN KEY (produit_id)
REFERENCES produit (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE composant ADD CONSTRAINT produit_composition_ingredient_fk
FOREIGN KEY (ingredient_id)
REFERENCES produit (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

DESCRIBE composant; 


######################################################################## STOCK #
DROP TABLE IF EXISTS stock;
CREATE TABLE stock (
                magasin_id INT UNSIGNED NOT NULL,
                produit_id INT UNSIGNED NOT NULL,
                quantite DECIMAL(5,2) DEFAULT (0) NOT NULL,
                quantite_min DECIMAL(5,2) DEFAULT (0.0) NOT NULL,
                unite VARCHAR(3) DEFAULT 'KG' NOT NULL,
                PRIMARY KEY (magasin_id, produit_id)
)ENGINE=InnoDB;

ALTER TABLE stock ADD CONSTRAINT magasin_stock_fk
FOREIGN KEY (magasin_id)
REFERENCES magasin (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE stock ADD CONSTRAINT produit_stock_fk
FOREIGN KEY (produit_id)
REFERENCES produit (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

DESCRIBE stock;

################################################################################
#                                                                     COMMANDE #
################################################################################

####################################################################### PANIER #
DROP TABLE IF EXISTS panier;
CREATE TABLE panier (
                utilisateur_id INT UNSIGNED NOT NULL,
                jour DATE DEFAULT (CURRENT_DATE()) NOT NULL,
                heure TIME DEFAULT (CURRENT_TIME()) NOT NULL,
                montant DECIMAL(5,2) DEFAULT (0.0) NOT NULL,
                PRIMARY KEY (utilisateur_id)
)ENGINE=InnoDB;

ALTER TABLE panier ADD CONSTRAINT client_panier_fk
FOREIGN KEY (utilisateur_id)
REFERENCES client (utilisateur_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

DESCRIBE panier;


############################################################## LIGNE_DE_PANIER #
DROP TABLE IF EXISTS ligne_de_panier;
CREATE TABLE ligne_de_panier (
                utilisateur_id INT UNSIGNED NOT NULL,
                produit_id INT UNSIGNED NOT NULL,
                quantite DECIMAL(2) DEFAULT (0) NOT NULL,
                prix_unitaire_ht DECIMAL(5,2) DEFAULT (0.0) NOT NULL,
                taux_tva DECIMAL(3,1) DEFAULT (10.0) NOT NULL,
                PRIMARY KEY (utilisateur_id, produit_id)
)ENGINE=InnoDB;

ALTER TABLE ligne_de_panier ADD CONSTRAINT panier_ligne_de_panier_fk
FOREIGN KEY (utilisateur_id)
REFERENCES panier (utilisateur_id)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE ligne_de_panier ADD CONSTRAINT produit_ligne_de_panier_fk
FOREIGN KEY (produit_id)
REFERENCES produit (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

DESCRIBE ligne_de_panier;


##################################################################### COMMANDE #
DROP TABLE IF EXISTS commande;
CREATE TABLE commande (
                id INT UNSIGNED AUTO_INCREMENT NOT NULL,
                utilisateur_id INT UNSIGNED NOT NULL,
                adresse_id INT UNSIGNED NOT NULL,
                status ENUM ('En attente', 'En préparation', 'Préparée', 'En livraison', 'Livrée', 'Clos') NOT NULL,
                jour DATE DEFAULT (CURRENT_DATE()) NOT NULL,
                heure TIME DEFAULT (CURRENT_TIME()) NOT NULL,
                preparation_delai TIME,
                preparation_duree TIME,
                livraison_delais TIME,
                livraison_duree TIME,
                paiement_OK BOOLEAN DEFAULT false NOT NULL,
                montant DECIMAL(5,2) DEFAULT (0.0) NOT NULL,
                PRIMARY KEY (id)
)ENGINE=InnoDB;

ALTER TABLE commande ADD CONSTRAINT adresse_commande_fk
FOREIGN KEY (adresse_id)
REFERENCES adresse (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE commande ADD CONSTRAINT client_commande_fk
FOREIGN KEY (utilisateur_id)
REFERENCES client (utilisateur_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

DESCRIBE commande;


############################################################ LIGNE_DE_COMMANDE #
DROP TABLE IF EXISTS ligne_de_commande;
CREATE TABLE ligne_de_commande (
                commande_id INT UNSIGNED NOT NULL,
                produit_id INT UNSIGNED NOT NULL,
                quantite DECIMAL(2) DEFAULT 1 NOT NULL,
                prix_unitaire_ht DECIMAL(5,2) NOT NULL,
                taux_tva DECIMAL(3,1) DEFAULT (0.0) NOT NULL,
                PRIMARY KEY (commande_id, produit_id)
)ENGINE=InnoDB;

ALTER TABLE ligne_de_commande ADD CONSTRAINT commande_ligne_de_commande_fk
FOREIGN KEY (commande_id)
REFERENCES commande (id)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE ligne_de_commande ADD CONSTRAINT produit_ligne_de_commande_fk
FOREIGN KEY (produit_id)
REFERENCES produit (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

DESCRIBE ligne_de_commande;

################################################################################
#                                                                     PAIEMENT #
################################################################################

################################################################ ETABLISSEMENT #
DROP TABLE IF EXISTS etablissement;
CREATE TABLE etablissement (
                id TINYINT UNSIGNED AUTO_INCREMENT NOT NULL,
                nom VARCHAR(20) NOT NULL,
                PRIMARY KEY (id)
)ENGINE=InnoDB;
DESCRIBE etablissement;

##################################################################### PAIEMENT #
DROP TABLE IF EXISTS paiement;
CREATE TABLE paiement (
                id INT UNSIGNED AUTO_INCREMENT NOT NULL,
                type ENUM ('espèce','carte bancaire','ticket restaurant','chèque bancaire','sans') NOT NULL,
                PRIMARY KEY (id)
)ENGINE=InnoDB;
DESCRIBE paiement;


############################################################ TICKET_RESTAURANT #
DROP TABLE IF EXISTS ticket_restaurant;
CREATE TABLE ticket_restaurant (
                paiement_id INT UNSIGNED NOT NULL,
                numero VARCHAR(50) NOT NULL,
                etablissement_id TINYINT UNSIGNED NOT NULL,
                PRIMARY KEY (paiement_id)
)ENGINE=InnoDB;

ALTER TABLE ticket_restaurant ADD CONSTRAINT paiement_ticket_restaurant_fk
FOREIGN KEY (paiement_id)
REFERENCES paiement (id)
ON DELETE CASCADE
ON UPDATE CASCADE;

DESCRIBE ticket_restaurant;


############################################################### CARTE_BANCAIRE #
DROP TABLE IF EXISTS carte_bancaire;
CREATE TABLE carte_bancaire (
                paiement_id INT UNSIGNED NOT NULL,
                reference VARCHAR(100) NOT NULL,
                jour DATE DEFAULT (CURRENT_DATE()),
                heure TIME DEFAULT (CURRENT_TIME()),
                PRIMARY KEY (paiement_id)
)ENGINE=InnoDB;

ALTER TABLE carte_bancaire ADD CONSTRAINT paiement_carte_bancaire_fk
FOREIGN KEY (paiement_id)
REFERENCES paiement (id)
ON DELETE CASCADE
ON UPDATE CASCADE;

DESCRIBE carte_bancaire;


####################################################################### CHEQUE #
DROP TABLE IF EXISTS cheque;
CREATE TABLE cheque (
                paiement_id INT UNSIGNED NOT NULL,
                banque TINYINT UNSIGNED NOT NULL,
                numero VARCHAR(100) NOT NULL,
                jour DATE DEFAULT (CURRENT_DATE()),
                PRIMARY KEY (paiement_id)
)ENGINE=InnoDB;

ALTER TABLE cheque ADD CONSTRAINT paiement_cheque_fk
FOREIGN KEY (paiement_id)
REFERENCES paiement (id)
ON DELETE CASCADE
ON UPDATE CASCADE;

DESCRIBE cheque;


############################################################### LISTE PAIEMENT #
DROP TABLE IF EXISTS liste_paiement;
CREATE TABLE liste_paiement (
                commande_id INT UNSIGNED NOT NULL,
                paiement_id INT UNSIGNED NOT NULL,
                montant DECIMAL(5,2) DEFAULT (0.0)NOT NULL,
                PRIMARY KEY (commande_id,paiement_id )
)ENGINE=InnoDB;

ALTER TABLE liste_paiement ADD CONSTRAINT paiement_liste_paiement_fk
FOREIGN KEY (paiement_id)
REFERENCES paiement (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE liste_paiement ADD CONSTRAINT commande_liste_paiement_fk
FOREIGN KEY (commande_id)
REFERENCES commande (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

DESCRIBE liste_paiement;

SHOW TABLES;

