CREATE DATABASE oc_pizza CHARACTER SET 'utf8';

USE oc_pizza;

DROP TABLE IF EXISTS status;
CREATE TABLE status (
                id TINYINT UNSIGNED AUTO_INCREMENT NOT NULL,
                designation VARCHAR(20) NOT NULL,
                PRIMARY KEY (id)
)ENGINE=InnoDB;
DESCRIBE status;


DROP TABLE IF EXISTS etablissement;
CREATE TABLE etablissement (
                id TINYINT UNSIGNED AUTO_INCREMENT NOT NULL,
                nom VARCHAR(20) NOT NULL,
                PRIMARY KEY (id)
)ENGINE=InnoDB;
DESCRIBE etablissement;

DROP TABLE IF EXISTS paiement;
CREATE TABLE paiement (
                id INT UNSIGNED AUTO_INCREMENT NOT NULL,
                type ENUM ('espèce','carte bancaire','ticket restaurant','chèque bancaire','sans') NOT NULL,
                PRIMARY KEY (id)
)ENGINE=InnoDB;
DESCRIBE paiement;

DROP TABLE IF EXISTS ticket_restaurant;
CREATE TABLE ticket_restaurant (
                paiement_id INT UNSIGNED NOT NULL,
                numero VARCHAR(50) NOT NULL,
                etablissement_id TINYINT UNSIGNED NOT NULL,
                PRIMARY KEY (paiement_id)
)ENGINE=InnoDB;
DESCRIBE ticket_restaurant;

DROP TABLE IF EXISTS carte_bancaire;
CREATE TABLE carte_bancaire (
                paiement_id INT UNSIGNED NOT NULL,
                reference VARCHAR(100) NOT NULL,
                jour DATE DEFAULT (CURRENT_DATE()),
                heure TIME DEFAULT (CURRENT_TIME()),
                PRIMARY KEY (paiement_id)
)ENGINE=InnoDB;
DESCRIBE carte_bancaire;

DROP TABLE IF EXISTS cheque;
CREATE TABLE cheque (
                paiement_id INT UNSIGNED NOT NULL,
                banque TINYINT UNSIGNED NOT NULL,
                numero VARCHAR(100) NOT NULL,
                jour DATE DEFAULT (CURRENT_DATE()),
                PRIMARY KEY (paiement_id)
)ENGINE=InnoDB;
DESCRIBE cheque;

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

DROP TABLE IF EXISTS fournisseur;
CREATE TABLE fournisseur (
                id INT UNSIGNED AUTO_INCREMENT NOT NULL,
                nom VARCHAR(50) NOT NULL,
                telephone VARCHAR(10) NOT NULL,
                email VARCHAR(255) NOT NULL,
                adresse_id INT UNSIGNED NOT NULL,
                PRIMARY KEY (id)
)ENGINE=InnoDB;
DESCRIBE fournisseur;

DROP TABLE IF EXISTS magasin;
CREATE TABLE magasin (
                id INT UNSIGNED AUTO_INCREMENT NOT NULL,
                nom VARCHAR(50) NOT NULL,
                telephone VARCHAR(10) NOT NULL,
                email VARCHAR(255) NOT NULL,
                adresse_id INT UNSIGNED NOT NULL,
                PRIMARY KEY (id)
)ENGINE=InnoDB;
DESCRIBE magasin;

DROP TABLE IF EXISTS utilisateur;
CREATE TABLE utilisateur (
                id INT UNSIGNED AUTO_INCREMENT NOT NULL,
                civilite ENUM('Mlle','Mme','M') NOT NULL,
                nom VARCHAR(50) NOT NULL,
                prenom VARCHAR(50) NOT NULL,
                login VARCHAR(50) NOT NULL,
                mot_de_passe VARCHAR(255) NOT NULL,
                magasin_id INT UNSIGNED NOT NULL,
                PRIMARY KEY (id)
)ENGINE=InnoDB;
DESCRIBE utilisateur;

DROP TABLE IF EXISTS employe;
CREATE TABLE employe (
                utilisateur_id INT UNSIGNED NOT NULL,
                role ENUM ('Accueil','Pizzaiolo','Livreur','Manager',
                        'Gestionnaire','Comptable','Direction') NOT NULL,
                PRIMARY KEY (utilisateur_id)
)ENGINE=InnoDB;
DESCRIBE employe;

DROP TABLE IF EXISTS client;
CREATE TABLE client (
                utilisateur_id INT UNSIGNED NOT NULL,
                telephone VARCHAR(10) NOT NULL,
                adresse_id INT UNSIGNED NOT NULL,
                email VARCHAR(255) NOT NULL,
                PRIMARY KEY (utilisateur_id)
)ENGINE=InnoDB;
DESCRIBE client;

DROP TABLE IF EXISTS panier;
CREATE TABLE panier (
                utilisateur_id INT UNSIGNED NOT NULL,
                jour DATE DEFAULT (CURRENT_DATE()) NOT NULL,
                heure TIME DEFAULT (CURRENT_TIME()) NOT NULL,
                montant DECIMAL(5,2) NOT NULL,
                PRIMARY KEY (utilisateur_id)
)ENGINE=InnoDB;
DESCRIBE panier;

DROP TABLE IF EXISTS command;
CREATE TABLE command (
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
                montant DECIMAL(5,2) NOT NULL,
                PRIMARY KEY (id)
)ENGINE=InnoDB;
DESCRIBE command;

DROP TABLE IF EXISTS liste_paiement;
CREATE TABLE liste_paiement (
                commande_id INT UNSIGNED NOT NULL,
                paiement_id INT UNSIGNED NOT NULL,
                montant DECIMAL(5,2) NOT NULL,
                PRIMARY KEY (commande_id,paiement_id )
)ENGINE=InnoDB;
DESCRIBE liste_paiement;

DROP TABLE IF EXISTS produit;
CREATE TABLE produit (
                id INT UNSIGNED AUTO_INCREMENT NOT NULL,
                designation VARCHAR(50) NOT NULL,
                categorie ENUM ('ingrédient','pizza','boisson','dessert','emballage','sauce') NOT NULL,
                fournisseur_id INT UNSIGNED NOT NULL,
                prix_achat_ht DECIMAL(5,2) DEFAULT (0.0) NOT NULL,
                prix_vent_ht DECIMAL(5,2) DEFAULT (0.0)NOT NULL,
                PRIMARY KEY (id)
)ENGINE=InnoDB;
DESCRIBE produit;

DROP TABLE IF EXISTS composant;
CREATE TABLE composant (
                produit_id INT UNSIGNED NOT NULL,
                ingredient_id INT UNSIGNED NOT NULL,
                quantite DECIMAL(5,2) NOT NULL,
                unite VARCHAR(3) NOT NULL,
                PRIMARY KEY (produit_id, ingredient_id)
)ENGINE=InnoDB;
DESCRIBE composant;

DROP TABLE IF EXISTS stock;
CREATE TABLE stock (
                magasin_id INT UNSIGNED NOT NULL,
                produit_id INT UNSIGNED NOT NULL,
                quantite DECIMAL(5,2),
                quantite_min DECIMAL(5,2),
                unite VARCHAR(3) NOT NULL,
                PRIMARY KEY (magasin_id, produit_id)
)ENGINE=InnoDB;
DESCRIBE stock;

DROP TABLE IF EXISTS preparation;
CREATE TABLE preparation (
                produit_id INT UNSIGNED NOT NULL,
                recette TEXT NOT NULL,
                PRIMARY KEY (produit_id)
)ENGINE=InnoDB;
DESCRIBE preparation;

DROP TABLE IF EXISTS composition;
CREATE TABLE composition (
                produit_id INT UNSIGNED NOT NULL,
                formule TEXT NOT NULL,
                PRIMARY KEY (produit_id)
)ENGINE=InnoDB;
DESCRIBE composition;

DROP TABLE IF EXISTS ligne_de_commande;
CREATE TABLE ligne_de_commande (
                command_id INT UNSIGNED NOT NULL,
                produit_id INT UNSIGNED NOT NULL,
                quantite DECIMAL(2) DEFAULT 1 NOT NULL,
                prix_unitaire_ht DECIMAL(5,2) NOT NULL,
                taux_tva DECIMAL(2,2) NOT NULL,
                PRIMARY KEY (command_id, produit_id)
)ENGINE=InnoDB;
DESCRIBE ligne_de_commande;

DROP TABLE IF EXISTS ligne_de_panier;
CREATE TABLE ligne_de_panier (
                utilisateur_id INT UNSIGNED NOT NULL,
                produit_id INT UNSIGNED NOT NULL,
                quantite DECIMAL(2) NOT NULL,
                prix_unitaire_ht DECIMAL(5,2) NOT NULL,
                taux_tva DECIMAL(2,2) NOT NULL,
                PRIMARY KEY (utilisateur_id, produit_id)
)ENGINE=InnoDB;
DESCRIBE ligne_de_panier;

SHOW TABLES;

#
#contraintes sur les tables utilisateur/employe/client
#
ALTER TABLE utilisateur ADD CONSTRAINT magasin_utilisateur_fk
FOREIGN KEY (magasin_id)
REFERENCES magasin (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;


ALTER TABLE employe ADD CONSTRAINT utilisateur_employe_fk
FOREIGN KEY (utilisateur_id)
REFERENCES utilisateur (id)
ON DELETE CASCADE
ON UPDATE CASCADE;


ALTER TABLE client ADD CONSTRAINT adresse_client_fk
FOREIGN KEY (adresse_id)
REFERENCES adresse (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE client ADD CONSTRAINT utilisateur_client_fk
FOREIGN KEY (utilisateur_id)
REFERENCES utilisateur (id)
ON DELETE CASCADE
ON UPDATE CASCADE;

#
# Contraintes sur les tables paiement/cheque/carte_bancaire/ticket_restaurant/liste_paiement
#
ALTER TABLE cheque ADD CONSTRAINT paiement_cheque_fk
FOREIGN KEY (paiement_id)
REFERENCES paiement (id)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE carte_bancaire ADD CONSTRAINT paiement_carte_bancaire_fk
FOREIGN KEY (paiement_id)
REFERENCES paiement (id)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE ticket_restaurant ADD CONSTRAINT paiement_ticket_restaurant_fk
FOREIGN KEY (paiement_id)
REFERENCES paiement (id)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE liste_paiement ADD CONSTRAINT paiement_liste_paiement_fk
FOREIGN KEY (paiement_id)
REFERENCES paiement (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE liste_paiement ADD CONSTRAINT command_liste_paiement_fk
FOREIGN KEY (commande_id)
REFERENCES command (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;


#
# Contraintes sur les tables magasin/fournisseur
#
ALTER TABLE magasin ADD CONSTRAINT adresse_magasin_fk
FOREIGN KEY (adresse_id)
REFERENCES adresse (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE fournisseur ADD CONSTRAINT adresse_fournisseur_fk
FOREIGN KEY (adresse_id)
REFERENCES adresse (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;


#
# Contrainte sur les tables produits/recette/composition/composant/stock
#

ALTER TABLE produit ADD CONSTRAINT fournisseur_produit_fk
FOREIGN KEY (fournisseur_id)
REFERENCES fournisseur (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;


ALTER TABLE preparation ADD CONSTRAINT produit_preparation_fk
FOREIGN KEY (produit_id)
REFERENCES produit (id)
ON DELETE CASCADE
ON UPDATE CASCADE;


ALTER TABLE composition ADD CONSTRAINT produit_composition_fk
FOREIGN KEY (produit_id)
REFERENCES produit (id)
ON DELETE CASCADE
ON UPDATE CASCADE;


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


#
# Contrainte sur les tables command
#
ALTER TABLE command ADD CONSTRAINT adresse_command_fk
FOREIGN KEY (adresse_id)
REFERENCES adresse (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE command ADD CONSTRAINT client_command_fk
FOREIGN KEY (utilisateur_id)
REFERENCES client (utilisateur_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;


ALTER TABLE ligne_de_commande ADD CONSTRAINT command_ligne_de_commande_fk
FOREIGN KEY (command_id)
REFERENCES command (id)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE ligne_de_commande ADD CONSTRAINT produit_ligne_de_commande_fk
FOREIGN KEY (produit_id)
REFERENCES produit (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;


ALTER TABLE panier ADD CONSTRAINT client_panier_fk
FOREIGN KEY (utilisateur_id)
REFERENCES client (utilisateur_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

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





LOCK TABLE etablissement WRITE;
INSERT INTO etablissement VALUES
	(1,'La Banque Poste'),
	(2,'BNP Paribas'),
	(3,'Société Générale'),
	(4,'Crédit Agricole'),
	(5,'LCL'),
	(6,'Banque Populaire'),
	(7,'Caisse d\'Epargne'),
	(8,'HSBC'),
	(9,'Crédit Mutuel'),
	(10,'Chèque Déjeuner'),
	(11,'Pass Restaurant'),
	(12,'Ticket Restaurant'),
	(13,'Chèque Apetiz'),
	(14,'Ticket Restaurant');
UNLOCK TABLE;

