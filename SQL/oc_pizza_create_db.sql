################################################################################
# CREATE DATABASE                                                     OC PIZZA #
################################################################################
# CREATE TABLE erreur                                                          #
# CREATE TABLE adresse                                                         #
# CREATE TABLE fournisseur                                                     #
# CREATE TABLE magasin                                                         #
# CREATE TABLE utilisateur                                                     #
# CREATE TABLE employe                                                         #
# CREATE TABLE client                                                          #
# CREATE TABLE produit                                                         #
# CREATE TABLE                                                                 #
# CREATE TABLE preparation                                                     #
# CREATE TABLE composition                                                     #
# CREATE TABLE composant                                                       #
# CREATE TABLE stock                                                           #
# CREATE TABLE panier                                                          #
# CREATE TABLE ligne_de_panier                                                 #
# CREATE TABLE commande                                                        #
# CREATE TABLE ligne_de_commande                                               #
# CREATE TABLE etablissement                                                   #
# CREATE TABLE paiement                                                        #
# CREATE TABLE ticket_restaurant                                               #
# CREATE TABLE carte_bancaire                                                  #
# CREATE TABLE cheque                                                          #
# CREATE TABLE liste_paiement                                                  #
#                                                                              #
# CREATE TRIGGER before_insert_adresse                                         #
# CREATE TRIGGER before_update_adresse                                         #
################################################################################

CREATE DATABASE oc_pizza CHARACTER SET 'utf8';

USE oc_pizza;


################################################################################
#                                                                       GLOBAL #
################################################################################

####################################################################### ERREUR #
DROP TABLE IF EXISTS erreur;
CREATE TABLE erreur (
   id TINYINT UNSIGNED AUTO_INCREMENT NOT NULL, # identifiant de l'erreur
   message VARCHAR(100) UNIQUE,                 # message d'erreur
   PRIMARY KEY (id)
   )ENGINE=InnoDB;

DESCRIBE erreur;

# remplissage de la table des erreurs pour créer une erreur lors d'une ré-insertion
INSERT INTO erreur (message) VALUES ('ERREUR : l''adresse doit être unique!');
INSERT INTO erreur (message) VALUES ('ERREUR : le login doit être unique!');
INSERT INTO erreur (message) VALUES ('ERREUR : le nom du magasin doit être unique!');
INSERT INTO erreur (message) VALUES ('ERREUR : le nom du fournisseur doit être unique!');
INSERT INTO erreur (message) VALUES ('ERREUR : un produit n''est plus disponible!');
INSERT INTO erreur (message) VALUES ('ERREUR : la commande n''est pas en attente!');
INSERT INTO erreur (message) VALUES ('ERREUR : la commande n''est pas en préparation!');   
INSERT INTO erreur (message) VALUES ('ERREUR : la commande n''est pas préparée!');   

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
   commentaire TEXT, # pour un code de digicode ou informations complémentaires
   PRIMARY KEY (id)
)ENGINE=InnoDB;
DESCRIBE adresse;

# trigger pour vérifier l'insertion d'adresse unique
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
                adresse_id INT UNSIGNED NOT NULL, -- identifiant de l'adresse
                PRIMARY KEY (id,nom)
)ENGINE=InnoDB;

# l'identifiant de l'adresse et la la table adresse sont liés
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
                adresse_id INT UNSIGNED NOT NULL, -- identifiant de l'adresse
                PRIMARY KEY (id,nom)
)ENGINE=InnoDB;

# l'identifiant de l'adresse et la la table adresse sont liés
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
                magasin_id INT UNSIGNED NOT NULL, -- identifiant du magasin
                PRIMARY KEY (id)
)ENGINE=InnoDB;

# un utilisateur est lié à un magasin par son identifiant
ALTER TABLE utilisateur ADD CONSTRAINT magasin_utilisateur_fk
FOREIGN KEY (magasin_id)
REFERENCES magasin (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

# ajout d'un index pour une recherche sur les noms
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

# un employé est un utilisateur
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
                adresse_id INT UNSIGNED NOT NULL, -- identifiant de l'adresse
                email VARCHAR(255) NOT NULL UNIQUE,
                PRIMARY KEY (utilisateur_id)
)ENGINE=InnoDB;

#un client est un utilisateur
ALTER TABLE client ADD CONSTRAINT utilisateur_client_fk
FOREIGN KEY (utilisateur_id)
REFERENCES utilisateur (id)
ON DELETE CASCADE
ON UPDATE CASCADE;

# l'identifiant de l'adresse et la la table adresse sont liés
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
                fournisseur_id INT UNSIGNED, -- identifiant du fournisseur
                reference VARCHAR(20),
                quantite DECIMAL(5,2) DEFAULT (0.0),
                unite VARCHAR(3),
                prix_achat_ht DECIMAL(5,2) DEFAULT (0.0),
                prix_vente_ht DECIMAL(5,2) DEFAULT (0.0),
                tva_emporte DECIMAL(3,1) DEFAULT (10.0) NOT NULL,
                tva_livre DECIMAL(3,1) DEFAULT (10.0) NOT NULL,
                PRIMARY KEY (id)
)ENGINE=InnoDB;

# un produit peut être lié à un fournisseur
ALTER TABLE produit ADD CONSTRAINT fournisseur_produit_fk
FOREIGN KEY (fournisseur_id)
REFERENCES fournisseur (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

DESCRIBE produit;


################################################################## PREPARATION #
DROP TABLE IF EXISTS preparation;
CREATE TABLE preparation (
                produit_id INT UNSIGNED NOT NULL, -- identifiant du produit
                recette TEXT NOT NULL,            -- recette de la pizza
                PRIMARY KEY (produit_id)
)ENGINE=InnoDB;

# un produit comme la pizza peut avoir une recette donc l'identifiant de la 
# préparation est le même que celui du produit
ALTER TABLE preparation ADD CONSTRAINT produit_preparation_fk
FOREIGN KEY (produit_id)
REFERENCES produit (id)
ON DELETE CASCADE
ON UPDATE CASCADE;

DESCRIBE preparation;


################################################################## COMPOSITION #
DROP TABLE IF EXISTS composition;
CREATE TABLE composition (
                produit_id INT UNSIGNED NOT NULL, -- identifiant du produit
                formule TEXT NOT NULL,            -- composition du produit 
                PRIMARY KEY (produit_id)
)ENGINE=InnoDB;

# un produit comme peut avoir une composition donc l'identifiant de la 
# composition est le même que celui du produit
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

# le produit composant est un produit identifié par son id
ALTER TABLE composant ADD CONSTRAINT produit_composition_produit_fk
FOREIGN KEY (produit_id)
REFERENCES produit (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

# un ingrédient est un produit identifié par son id
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

# liaison entre le stock et les magasins
ALTER TABLE stock ADD CONSTRAINT magasin_stock_fk
FOREIGN KEY (magasin_id)
REFERENCES magasin (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

# liaison entre le stock et les produits
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
                montant_ttc DECIMAL(5,2) DEFAULT (0.0) NOT NULL,
                livraison TINYINT UNSIGNED DEFAULT TRUE NOT NULL,
                PRIMARY KEY (utilisateur_id)
)ENGINE=InnoDB;

# un panier est lié à un client
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
                taux_tva DECIMAL(3,1) DEFAULT (0.0) NOT NULL,
                PRIMARY KEY (utilisateur_id, produit_id)
)ENGINE=InnoDB;

# une ligne de panier est liée à un client donc un utilisateur
ALTER TABLE ligne_de_panier ADD CONSTRAINT utilisateur_ligne_de_panier_fk
FOREIGN KEY (utilisateur_id)
REFERENCES  utilisateur (id)
ON DELETE CASCADE
ON UPDATE CASCADE;

# une ligne de panier est liée à un produit
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
                statut ENUM ('En attente', 'En préparation', 'Préparée', 'En livraison', 'Livrée', 'Clos') NOT NULL,
                jour DATE DEFAULT (CURRENT_DATE()) NOT NULL,
                heure TIME DEFAULT (CURRENT_TIME()) NOT NULL,
                preparation_delai TIME,
                preparation_duree TIME,
                livraison_delai TIME,
                livraison_duree TIME,
                paiement_OK BOOLEAN DEFAULT false NOT NULL,
                montant_ttc DECIMAL(5,2) DEFAULT (0.0) NOT NULL,
                PRIMARY KEY (id)
)ENGINE=InnoDB;

# une commande à une adresse de livraison unique
ALTER TABLE commande ADD CONSTRAINT adresse_commande_fk
FOREIGN KEY (adresse_id)
REFERENCES adresse (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

# une commande est liée à un utilisateur
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

# chaque ligne de commande est liée à une commande
ALTER TABLE ligne_de_commande ADD CONSTRAINT commande_ligne_de_commande_fk
FOREIGN KEY (commande_id)
REFERENCES commande (id)
ON DELETE CASCADE
ON UPDATE CASCADE;

# chaque ligne de commande est liée à un produit
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

# ticket_restaurant est un paiement
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

# carte_bancaire est un paiement
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

# cheque est un paiement
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

# une liste de paiement est liée à un paiement
ALTER TABLE liste_paiement ADD CONSTRAINT paiement_liste_paiement_fk
FOREIGN KEY (paiement_id)
REFERENCES paiement (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

# une liste de paiement est liée à une commande
ALTER TABLE liste_paiement ADD CONSTRAINT commande_liste_paiement_fk
FOREIGN KEY (commande_id)
REFERENCES commande (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

DESCRIBE liste_paiement;

SHOW TABLES;

################################################################################
# OC PIZZA                                                   CREATE PROCEDURES #
################################################################################
# CREATE PROCEDURE create_adresse                                              #
# CREATE PROCEDURE create_magasin                                              #
# CREATE PROCEDURE create_fournisseur                                          #
# CREATE PROCEDURE create_utilisateur                                          #
# CREATE PROCEDURE create_employe                                              #
# CREATE PROCEDURE create_client                                               #
# CREATE PROCEDURE create_paiement                                             #
# CREATE PROCEDURE add_paiement_ticket_restaurant                              #
# CREATE PROCEDURE add_paiement_carte_bancaire                                 #
# CREATE PROCEDURE add_paiement_cheque                                         #
# CREATE PROCEDURE add_paiement_espece                                         #
# CREATE PROCEDURE create_produit                                              #
# CREATE PROCEDURE cherche_produit_id                                          #
# CREATE PROCEDURE add_composant                                               #
# CREATE PROCEDURE livraison                                                   #
# CREATE PROCEDURE livre_magasin                                               #
# CREATE PROCEDURE ajoute_panier                                               #
# CREATE PROCEDURE enleve_panier                                               #
# CREATE PROCEDURE diminue_stock                                               #
# CREATE PROCEDURE valide_commande                                             #
# CREATE PROCEDURE pizzaiolo_prend_commande                                    #
# CREATE PROCEDURE pizzaiolo_termine_commande                                  #
# CREATE PROCEDURE livreur_prend_commande                                      #
# CREATE PROCEDURE client_prend_commande                                       #
# CREATE PROCEDURE liste_magasin_suivant_nom                                   #
# CREATE PROCEDURE liste_fournisseur_suivant_nom                               #
# CREATE PROCEDURE liste_employe_suivant_nom                                   #
# CREATE PROCEDURE liste_employe_suivant_prenom                                #
# CREATE PROCEDURE liste_employe_suivant_role                                  #
# CREATE PROCEDURE liste_client_suivant_nom                                    #
# CREATE PROCEDURE liste_client_suivant_prenom                                 #
# CREATE PROCEDURE liste_ingredient_produit_par_id                             #
# CREATE PROCEDURE liste_ingredient_produit_par_designation                    #
# CREATE PROCEDURE liste_produit_vendable                                      #
################################################################################


############################################################### CREATE ADRESSE #
DROP PROCEDURE IF EXISTS create_adresse;
DELIMITER |
CREATE PROCEDURE create_adresse(
   IN p_numero VARCHAR(5),       -- numéro de la rue
	IN p_voie VARCHAR(50),        -- nom de la voie
	IN p_ville VARCHAR(20),       -- nom de la ville
	IN p_code VARCHAR(5),         -- code postal
	OUT p_id INT(10) UNSIGNED)    -- retourne identifiant de l'adresse correspondante
BEGIN
	SET p_id = 0;

   -- on cherche si l'adresse existe déjà
	SELECT DISTINCT id INTO p_id FROM adresse
	WHERE numero = p_numero AND voie = p_voie AND ville = p_ville AND code = p_code
   ORDER BY id DESC LIMIT 1;

   -- si l'adresse n'existe pas on la créé sinon on renvoie l'identifiant trouvé
	IF p_id =  0 THEN 
		INSERT INTO adresse(numero, voie, ville, code) 
		VALUES (p_numero,p_voie, p_ville, p_code);

      #on recherche ID de l'adresse créée
		SELECT DISTINCT id INTO p_id 
		FROM adresse 
		WHERE numero=p_numero AND voie=p_voie AND ville = p_ville AND code = p_code
      ORDER BY id DESC LIMIT 1;
	END IF;
END |
DELIMITER ;

############################################################### CREATE MAGASIN #
DROP PROCEDURE IF EXISTS create_magasin;
DELIMITER |
CREATE PROCEDURE create_magasin( 
   IN p_nom VARCHAR(50),        -- nom du magasin
	IN p_telephone VARCHAR(10),  -- téléphone du magasin
	IN p_email VARCHAR(255),     -- email du magasin
	IN p_numero VARCHAR(5),      -- numéro de la rue
	IN p_voie VARCHAR(50),       -- nom de la voie
	IN p_ville VARCHAR(20),      -- nom de la ville
   IN p_code VARCHAR(5),        -- code postal
	OUT p_id INT(10) UNSIGNED)   -- retourne l'identifiant du magasin correspondant
BEGIN
   DECLARE v_adresse_id INT(10) UNSIGNED;
   
   SET p_id = 0;
   SET v_adresse_id = 0;

   -- on effectue la création de l'adresse pour avoir l'identifiant
	CALL create_adresse(p_numero, p_voie, p_ville, p_code, v_adresse_id);

   -- on cherche si un magasin existe déjà
   SELECT DISTINCT id INTO p_id FROM magasin
   WHERE nom = p_nom AND telephone = p_telephone AND email = p_email AND adresse_id = v_adresse_id
      ORDER BY id DESC LIMIT 1;

   IF p_id > 0 THEN
      INSERT INTO erreur (message) VALUES ('ERREUR : le nom du magasin doit être unique!');
   ELSE
      INSERT INTO magasin (nom, telephone,email,adresse_id) 
      VALUES (p_nom, p_telephone,p_email,v_adresse_id);

      #on recherche ID du magasin créée
      SELECT id INTO p_id 
      FROM magasin 
      WHERE nom=p_nom;
   END IF;  
END |
DELIMITER ;

########################################################### CREATE FOURNISSEUR #
DROP PROCEDURE IF EXISTS create_fournisseur;
DELIMITER |
CREATE PROCEDURE create_fournisseur( 
   IN p_nom VARCHAR(50),         -- nom du fournisseur
	IN p_telephone VARCHAR(10),   -- téléphone du fournisseur
	IN p_email VARCHAR(255),      -- email du fournisseur
	IN p_numero VARCHAR(5),       -- numéro du fournisseur
	IN p_voie VARCHAR(50),        -- nom de la voie 
	IN p_ville VARCHAR(20),       -- nom de la ville 
	IN p_code VARCHAR(5),         -- code postal
	OUT p_id INT(10) UNSIGNED)    -- retourne l'identifiant du fournisseur créé
BEGIN
	DECLARE v_adresse_id INT(10) UNSIGNED;
   
   SET p_id = 0;
   SET v_adresse_id = 0;

   -- création de l'adresse
   CALL create_adresse(p_numero, p_voie, p_ville, p_code, v_adresse_id);

   -- recherche si le fournisseur existe
   SELECT id INTO p_id FROM fournisseur
   WHERE nom = p_nom AND telephone = p_telephone AND email = p_email AND adresse_id = v_adresse_id
   ORDER BY id DESC LIMIT 1;

   -- si il existe il y a une erreur de duplication sinon on créé le fournisseur
   IF p_id > 0 THEN
      INSERT INTO erreur (message) VALUES ('ERREUR : le nom du fournisseur doit être unique!');
   ELSE
   	INSERT INTO fournisseur (nom, telephone,email,adresse_id) 
   	VALUES (p_nom, p_telephone,p_email,v_adresse_id);
   	
      -- on recherche ID du fournisseur créée
   	SELECT id INTO p_id 
   	FROM fournisseur 
   	WHERE nom=p_nom;
   END IF;
END |
DELIMITER ;

################################################################################
#                                                                 UTILISATEURS #
################################################################################


########################################################### CREATE UTILISATEUR #
DROP PROCEDURE IF EXISTS create_utilisateur;
DELIMITER |
CREATE PROCEDURE create_utilisateur( 
   IN p_civilite ENUM ('Mlle','Mme','M'), -- civilité
   IN p_nom VARCHAR(50),                  -- nom de l'utilisateur
   IN p_prenom VARCHAR(50),               -- prénom de l'utilisateur
   IN p_login VARCHAR(50),                -- login
   IN p_mot_de_passe VARCHAR(255),        -- mot de passe
   IN p_magasin_id INT UNSIGNED,          -- son magasin attitré
   OUT p_id INT(10) UNSIGNED)             -- retourne l'identifiant
BEGIN
   SET p_id = 0;

   SELECT id INTO p_id FROM utilisateur
   WHERE login = p_login;

   IF p_id > 0 THEN
      INSERT INTO erreur (message) VALUES ('ERREUR : le login doit être unique!');
   ELSE 
      INSERT INTO utilisateur (civilite, nom, prenom, login, mot_de_passe, magasin_id)
      VALUES (p_civilite, p_nom, p_prenom, p_login, p_mot_de_passe, p_magasin_id);

      #on recherche ID de l'utilisateur créée
      SELECT id INTO p_id
      FROM utilisateur 
      WHERE login = p_login;
   END IF;
END |
DELIMITER ;

############################################################### CREATE EMPLOYE #
DROP PROCEDURE IF EXISTS create_employe;
DELIMITER |
CREATE PROCEDURE create_employe( 
   IN p_civilite ENUM ('Mlle','Mme','M'), -- civilité
   IN p_nom VARCHAR(50),                  -- nom de l'employé
   IN p_prenom VARCHAR(50),               -- prénom de l'employé
   IN p_login VARCHAR(50),                -- login de l'employé
   IN p_mot_de_passe VARCHAR(255),        -- mot de passe de l'employé 
   IN p_magasin_id INT(10) UNSIGNED,      -- magasin ou il travaille 
   IN p_role ENUM ('Accueil','Pizzaiolo','Livreur','Manager',
                  'Gestionnaire','Comptable','Direction'),     -- son poste
   OUT p_id INT(10) UNSIGNED)                         -- retourne l'identifiant
BEGIN
	CALL create_utilisateur(p_civilite, p_nom, p_prenom, p_login, p_mot_de_passe, p_magasin_id, p_id);

	INSERT INTO employe (utilisateur_id, role)
	VALUES (p_id, p_role);
END |
DELIMITER ;


################################################################ CREATE CLIENT #
DROP PROCEDURE IF EXISTS create_client;
DELIMITER |
CREATE PROCEDURE create_client( 
   IN p_civilite ENUM ('Mlle','Mme','M'), -- civilité
   IN p_nom VARCHAR(50),                  -- nom du client
   IN p_prenom VARCHAR(50),               -- prénom du client
   IN p_login VARCHAR(50),                -- login du client
   IN p_mot_de_passe VARCHAR(255),        -- mot de passe du client
   IN p_magasin_id INT(10) UNSIGNED,      -- magasin préféré
   IN p_telephone VARCHAR(10),            -- téléphone du client
   IN p_email VARCHAR(255),               -- email du client
   IN p_numero VARCHAR(5),                -- addresse simplifiée
   IN p_voie VARCHAR(50), 
   IN p_ville VARCHAR(20),
   IN p_code VARCHAR(5),
   OUT p_id INT(10) UNSIGNED)             -- retourne l'identifiant
BEGIN
   DECLARE v_adresse_id INT(10) UNSIGNED;
        
	CALL create_adresse(p_numero, p_voie, p_ville, p_code, v_adresse_id);
	CALL create_utilisateur(p_civilite, p_nom, p_prenom, p_login, p_mot_de_passe, p_magasin_id, p_id);

	INSERT INTO client (utilisateur_id, telephone, adresse_id, email)
	VALUES (p_id, p_telephone, v_adresse_id, p_email);
END |
DELIMITER ;


################################################################################
#                                                                     PAIEMENT #
################################################################################

############################################################## CREATE PAIEMENT #
DROP PROCEDURE IF EXISTS create_paiement;
DELIMITER |
CREATE PROCEDURE create_paiement(
   IN p_type ENUM ('espèce','carte bancaire','ticket restaurant','chèque bancaire','sans'),
   OUT p_id INT(10) UNSIGNED)
BEGIN
   INSERT INTO paiement (type) VALUES (p_type);
   SELECT id INTO p_id FROM paiement
   WHERE type = p_type
   ORDER BY id DESC LIMIT 1;
END |
DELIMITER ;

############################################### ADD PAIEMENT TICKET RESTAURANT #
DROP PROCEDURE IF EXISTS add_paiement_ticket_restaurant;
DELIMITER |
CREATE PROCEDURE add_paiement_ticket_restaurant(
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

END |
DELIMITER ;


################################################## ADD PAIEMENT CARTE BANCAIRE #
DROP PROCEDURE IF EXISTS add_paiement_carte_bancaire;
DELIMITER |
CREATE PROCEDURE add_paiement_carte_bancaire(
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
END |
DELIMITER ;


########################################################## ADD PAIEMENT CHEQUE #
DROP PROCEDURE IF EXISTS add_paiement_cheque;
DELIMITER |
CREATE PROCEDURE add_paiement_cheque(
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

END |
DELIMITER ;

########################################################## ADD PAIEMENT ESPECE #
DROP PROCEDURE IF EXISTS add_paiement_espece;
DELIMITER |
CREATE PROCEDURE add_paiement_espece(
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
END |
DELIMITER ;


################################################################################
#                                                                      PRODUIT #
################################################################################

############################################################### CREATE PRODUIT #
DROP PROCEDURE IF EXISTS create_produit;
DELIMITER |
CREATE PROCEDURE create_produit(
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

   -- on récupère l'identifiant du produit créé
   SELECT id INTO p_id FROM produit WHERE designation = p_designation;

   -- création de la composition 
   IF p_formule IS NOT NULL THEN
      INSERT INTO composition (produit_id,formule) VALUES (p_id,p_formule); 
   END IF;

   -- création de la recette
   IF p_recette IS NOT NULL THEN
      INSERT INTO preparation (produit_id,recette) VALUES (p_id,p_recette); 
   END IF;

END |
DELIMITER ;

##########################################################  CHERCHE PRODUIT ID #
DROP PROCEDURE IF EXISTS cherche_produit_id;
DELIMITER |
CREATE PROCEDURE cherche_produit_id(
   IN p_designation VARCHAR(100),
   IN p_categorie ENUM ('pack','vrac','ingrédient','pizza','boisson','dessert','emballage','sauce'),
   OUT p_id INT(10) UNSIGNED)
BEGIN
   
   SELECT DISTINCT id INTO p_id FROM produit
   WHERE categorie = p_categorie AND designation LIKE CONCAT("%", p_designation, "%");
END |
DELIMITER ;


################################################################ ADD COMPOSANT #
DROP PROCEDURE IF EXISTS add_composant;
DELIMITER |
CREATE PROCEDURE add_composant(
   IN p_produit_id INT(10) UNSIGNED,
   IN p_ingredient_id INT(10) UNSIGNED,
   IN p_quantite DECIMAL(5,2),
   IN p_unite VARCHAR(3))
BEGIN
   INSERT INTO composant (produit_id,ingredient_id,quantite,unite) 
   VALUES (p_produit_id,p_ingredient_id,p_quantite,p_unite);
END |
DELIMITER ;

#################################################################### LIVRAISON #
DROP PROCEDURE IF EXISTS livraison;
DELIMITER |
CREATE PROCEDURE livraison(
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

END |
DELIMITER ;

############################################################ LIVRE MAGASIN #
DROP PROCEDURE IF EXISTS livre_magasin;
DELIMITER |
CREATE PROCEDURE livre_magasin()
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
END |
DELIMITER ;


################################################################################
#                                                                     COMMANDE #
################################################################################

######################################################## UPDATE MONTANT PANIER #
DROP PROCEDURE IF EXISTS update_panier;
DELIMITER |
CREATE PROCEDURE update_panier(
   IN p_utilisateur_id INT(10),
   IN p_livraison TINYINT UNSIGNED)
BEGIN
   DECLARE v_montant DECIMAL(5,2) DEFAULT (0.0);
   DECLARE v_livraison_modifie TINYINT DEFAULT FALSE;

   -- on cherche si on a modifier le type de livraison
   SELECT (livraison <> p_livraison) INTO v_livraison_modifie FROM panier WHERE utilisateur_id = p_utilisateur_id;

   IF v_livraison_modifie THEN
      IF p_livraison THEN
         -- livraison
         UPDATE ligne_de_panier
         SET taux_tva = (SELECT tva_livre FROM produit WHERE produit.id = ligne_de_panier.produit_id)  
         WHERE ligne_de_panier.utilisateur_id = p_utilisateur_id;
      ELSE
         -- take away
         UPDATE ligne_de_panier
         SET taux_tva = (SELECT tva_emporte FROM produit WHERE produit.id = ligne_de_panier.produit_id)  
         WHERE ligne_de_panier.utilisateur_id = p_utilisateur_id;
      END IF;
   END IF;

   SELECT SUM(quantite*prix_unitaire_ht*(1+taux_tva/100)) INTO v_montant FROM ligne_de_panier WHERE utilisateur_id = p_utilisateur_id;

   INSERT INTO  panier (utilisateur_id,jour,heure,montant_ttc,livraison)
   VALUES ( p_utilisateur_id,CURRENT_DATE(), CURRENT_TIME(), v_montant, p_livraison)
   ON DUPLICATE KEY UPDATE jour = CURRENT_DATE(), heure = CURRENT_TIME(), montant_ttc = v_montant, livraison = p_livraison;
END |
DELIMITER ;



################################################################# AJOUT PANIER #
DROP PROCEDURE IF EXISTS ajoute_panier;
DELIMITER |
CREATE PROCEDURE ajoute_panier(
   IN p_utilisateur_id INT(10),
   IN p_produit_id INT(10),
   IN p_quantite DECIMAL(2,0),
   IN p_livraison TINYINT UNSIGNED)
BEGIN
   DECLARE v_quantite_old DECIMAL(2,0) DEFAULT (0.0);
   DECLARE v_prix_unitaire_ht DECIMAL(5,2) DEFAULT (0.0);
   DECLARE v_taux_tva DECIMAL(5,2) DEFAULT (0.0);
   

   -- on récupère l'ancienne quantité
   SELECT quantite INTO v_quantite_old FROM ligne_de_panier 
   WHERE utilisateur_id = p_utilisateur_id AND produit_id = p_produit_id;

   IF v_quantite_old IS NULL THEN
      SET v_quantite_old = 0;
   END IF;

   IF p_livraison THEN
      -- livraison à domicile
      SELECT prix_vente_ht, tva_livre INTO v_prix_unitaire_ht,v_taux_tva FROM produit WHERE id = p_produit_id;
   ELSE
      -- vente à emporter
      SELECT prix_vente_ht, tva_emporte INTO v_prix_unitaire_ht,v_taux_tva FROM produit WHERE id = p_produit_id;
   END IF;

   
   INSERT INTO ligne_de_panier (utilisateur_id,produit_id,quantite,prix_unitaire_ht,taux_tva)
   VALUES (p_utilisateur_id,p_produit_id,p_quantite+v_quantite_old,v_prix_unitaire_ht,v_taux_tva)
   ON DUPLICATE KEY UPDATE quantite = p_quantite + v_quantite_old, prix_unitaire_ht = v_prix_unitaire_ht, taux_tva = v_taux_tva;

  CALL update_panier(p_utilisateur_id,p_livraison);
END |
DELIMITER ;



################################################################ ENLEVE PANIER #
DROP PROCEDURE IF EXISTS enleve_panier;
DELIMITER |
CREATE PROCEDURE enleve_panier(
   IN p_utilisateur_id INT(10),
   IN p_produit_id INT(10),
   IN p_quantite DECIMAL(2,0),
   IN p_livraison TINYINT UNSIGNED)
BEGIN
   DECLARE v_quantite_old DECIMAL(2,0) DEFAULT (0.0);
   DECLARE v_prix_unitaire_ht DECIMAL(5,2) DEFAULT (0.0);
   DECLARE v_taux_tva DECIMAL(5,2) DEFAULT (0.0);
      
   -- on récupère l'ancienne quantité
   SELECT quantite INTO v_quantite_old FROM ligne_de_panier 
   WHERE utilisateur_id = p_utilisateur_id AND produit_id = p_produit_id;

   -- on sélectionne le prix et la tva suivant la livraison
   IF p_livraison THEN
      -- livraison à domicile
      SELECT prix_vente_ht, tva_livre INTO v_prix_unitaire_ht,v_taux_tva FROM produit WHERE id = p_produit_id;
   ELSE
      -- vente à emporter
      SELECT prix_vente_ht, tva_emporte INTO v_prix_unitaire_ht,v_taux_tva FROM produit WHERE id = p_produit_id;
   END IF;

   -- on diminue la quantité
   IF v_quantite_old IS NULL  OR v_quantite_old <= p_quantite THEN
      DELETE FROM ligne_de_panier WHERE utilisateur_id = p_utilisateur_id AND produit_id = p_produit_id;
   ELSE 
      INSERT INTO ligne_de_panier (utilisateur_id,produit_id,quantite,prix_unitaire_ht,taux_tva)
      VALUES (p_utilisateur_id,p_produit_id,v_quantite_old - p_quantite,v_prix_unitaire_ht,v_taux_tva)
      ON DUPLICATE KEY UPDATE quantite = v_quantite_old - p_quantite, prix_unitaire_ht = v_prix_unitaire_ht, taux_tva = v_taux_tva;
   END IF;

   -- on met à jour le panier   
   CALL update_panier(p_utilisateur_id,p_livraison);

END |
DELIMITER ;


################################################################ DIMINUE STOCK #
DROP PROCEDURE IF EXISTS diminue_stock;
DELIMITER |
CREATE PROCEDURE diminue_stock(
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
   
   -- on vérifie si le produit est composé
   SELECT (COUNT(*)>0) INTO v_compose FROM composant WHERE produit_id = p_produit_id;

   IF v_compose THEN
      -- le produit est composé on utilise le cursor     
      OPEN curs_produit_panier;

      loop_curseur: LOOP 
         -- On récupère les valeurs du curseur dans deux variables
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
      -- produit simple
      SELECT quantite INTO v_quantite_old FROM stock WHERE magasin_id = p_magasin_id AND produit_id = p_produit_id;
      IF v_quantite_old <= p_quantite THEN 
         UPDATE stock SET quantite = 0 WHERE magasin_id = p_magasin_id AND produit_id = v_produit_id;
      ELSE
         UPDATE stock SET quantite = v_quantite_old - p_quantite WHERE magasin_id = p_magasin_id AND produit_id = v_produit_id;
      END IF;
   END IF;
   
END |
DELIMITER ;


############################################################## VALIDE COMMANDE #
DROP PROCEDURE IF EXISTS valide_commande;
DELIMITER |
CREATE PROCEDURE valide_commande(
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

   -- on sélectionne le magasin du client pour chercher les stock
   SELECT magasin_id INTO v_magasin_id FROM utilisateur WHERE id = p_utilisateur_id;

   -- vérification de la présence de tous les produits en stock
   OPEN curseur_verification;
   loop_vérification: LOOP 
      FETCH curseur_verification INTO v_produit_id,v_quantite;

      IF done THEN
         LEAVE loop_vérification;
      END IF;

      IF produit_est_disponible(v_magasin_id,v_produit_id,v_quantite) = FALSE THEN
         -- on enlève le produit correspondant et on provoque une erreur
         CALL enleve_panier(p_utilisateur_id,v_produit_id,v_quantite);
         INSERT INTO erreur (message) VALUES ('ERREUR : un produit n''est plus disponible!');
      END IF;
   END LOOP loop_vérification;

   CLOSE curseur_verification;

   -- on récupère le montant du panier et savoir si c'est une livraison
   SELECT montant_ttc,livraison INTO v_montant_ttc,v_livraison from panier WHERE utilisateur_id = p_utilisateur_id;

   IF v_livraison THEN
      -- on prend l'adresse du client
      SELECT adresse.id INTO v_adresse_id FROM adresse
      JOIN client ON adresse.id = client.adresse_id
      WHERE client.utilisateur_id = p_utilisateur_id;
   ELSE
      -- on prend l'adresse du magasin
      SELECT adresse.id INTO v_adresse_id FROM adresse
      JOIN magasin ON adresse.id = magasin.adresse_id
      WHERE magasin.id = v_magasin_id;
   END IF;

   -- on créée une nouvelle commande a
   INSERT INTO commande (utilisateur_id, adresse_id, statut, jour, heure, montant_ttc)
   VALUES (p_utilisateur_id, v_adresse_id, 'En attente', v_jour, v_heure, v_montant_ttc);

   -- on récupère l'identifiant de la commande
   SELECT DISTINCT id INTO p_commande_id FROM commande
   WHERE utilisateur_id = p_utilisateur_id AND adresse_id = v_adresse_id AND statut = 'En attente' AND jour = v_jour AND heure = v_heure;

   -- diminution des stocks 
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

   -- on copie les lignes de panier dans les lignes de commande
   INSERT INTO ligne_de_commande (commande_id,produit_id,quantite,prix_unitaire_ht, taux_tva)
   SELECT p_commande_id,produit_id,quantite,prix_unitaire_ht, taux_tva FROM ligne_de_panier 
   WHERE utilisateur_id = p_utilisateur_id;
   
   
   -- on vide le panier
   DELETE FROM ligne_de_panier WHERE utilisateur_id = p_utilisateur_id;
   DELETE FROM panier WHERE utilisateur_id = p_utilisateur_id;

END |
DELIMITER ;


##################################################### PIZZAIOLO PREND COMMANDE #
DROP PROCEDURE IF EXISTS pizzaiolo_prend_commande;
DELIMITER |
CREATE PROCEDURE pizzaiolo_prend_commande(
   IN p_commande_id INT(10) UNSIGNED) 
BEGIN
   DECLARE v_start_date DATE;
   DECLARE v_start_time TIME;
   DECLARE v_preparation_delai TIME;
   DECLARE v_statut ENUM ('En attente', 'En préparation', 'Préparée', 'En livraison', 'Livrée', 'Clos');

   SELECT statut, jour, heure INTO v_statut,v_start_date,v_start_time FROM commande WHERE id = p_commande_id;

   -- le pizzaiolo ne peut prendre que les statut en attente
   IF v_statut = 'En attente' THEN
      SET v_preparation_delai = TIMEDIFF(NOW(),TIMESTAMP(v_start_date,v_start_time));
      UPDATE commande SET statut = 'En préparation', preparation_delai = v_preparation_delai WHERE id = p_commande_id;
   ELSE
      INSERT INTO erreur (message) VALUES ('ERREUR : la commande n''est pas en attente!');
   END IF;
END |
DELIMITER ;

################################################### PIZZAIOLO TERMINE COMMANDE #
DROP PROCEDURE IF EXISTS pizzaiolo_termine_commande;
DELIMITER |
CREATE PROCEDURE pizzaiolo_termine_commande(
   IN p_commande_id INT(10) UNSIGNED) 
BEGIN
   DECLARE v_start_date DATE;
   DECLARE v_start_time TIME;
   DECLARE v_preparation_delai TIME;
   DECLARE v_preparation_duree TIME;
   DECLARE v_statut ENUM ('En attente', 'En préparation', 'Préparée', 'En livraison', 'Livrée', 'Clos');

   SELECT statut, jour, heure, preparation_delai INTO v_statut, v_start_date,v_start_time,v_preparation_delai FROM commande WHERE id = p_commande_id;

   -- le pizzaiolo ne peut terminer une commande qui n'est pas en préparation
   IF v_statut = 'En préparation' THEN
      SET v_preparation_duree = TIMEDIFF(NOW(),TIMESTAMP(v_start_date,v_start_time));   
      SET v_preparation_duree = TIMEDIFF(v_preparation_duree, v_preparation_delai);   
      UPDATE commande SET statut = 'Préparée', preparation_duree = v_preparation_duree WHERE id = p_commande_id;
   ELSE
      INSERT INTO erreur (message) VALUES ('ERREUR : la commande n''est pas en préparation!');   
   END IF;
END |
DELIMITER ;


####################################################### LIVREUR PREND COMMANDE #
DROP PROCEDURE IF EXISTS livreur_prend_commande;
DELIMITER |
CREATE PROCEDURE livreur_prend_commande(
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
END |
DELIMITER ;

######################################################## CLIENT PREND COMMANDE #
DROP PROCEDURE IF EXISTS client_prend_commande;
DELIMITER |
CREATE PROCEDURE client_prend_commande(
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

   -- la commande doit être préparée pour pouvoir passer en status livrée
   IF v_statut <> 'Préparée' AND v_statut <> 'En livraison' THEN
      INSERT INTO erreur (message) VALUES ('ERREUR : la commande n''est pas préparée!');   
   END IF;

   SET v_livraison_duree = TIMEDIFF(NOW(),TIMESTAMP(v_start_date,v_start_time));
   SET v_livraison_duree = TIMEDIFF(v_livraison_duree,v_preparation_delai);
   SET v_livraison_duree = TIMEDIFF(v_livraison_duree,v_preparation_duree);

   -- un client peut prendre la commande directement en magasin donc elle ne passe pas par la livraison

   IF v_livraison_delai IS NULL THEN
      UPDATE commande SET statut = 'Livrée',  livraison_delai = 0, livraison_duree = v_livraison_duree WHERE id = p_commande_id;      
   ELSE
      SET v_livraison_duree = TIMEDIFF(v_livraison_duree, v_livraison_delai);
      UPDATE commande SET statut = 'Livrée',  livraison_duree = v_livraison_duree WHERE id = p_commande_id;
   END IF;

END |
DELIMITER ;



#################################################### LISTE MAGASIN SUIVANT NOM #
DROP PROCEDURE IF EXISTS liste_magasin_suivant_nom;
DELIMITER |
CREATE PROCEDURE liste_magasin_suivant_nom(
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
END |
DELIMITER ;

################################################ LISTE FOURNISSEUR SUIVANT NOM #
DROP PROCEDURE IF EXISTS liste_fournisseur_suivant_nom;
DELIMITER |
CREATE PROCEDURE liste_fournisseur_suivant_nom(
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
END |
DELIMITER ;

################################################################################
#                                                   REQUETE SELECT UTILISATEUR #
################################################################################

#################################################### LISTE EMPLOYE SUIVANT NOM #
DROP PROCEDURE IF EXISTS liste_employe_suivant_nom;
DELIMITER |
CREATE PROCEDURE liste_employe_suivant_nom(
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
END |
DELIMITER ;

################################################# LISTE EMPLOYE SUIVANT PRENOM #
DROP PROCEDURE IF EXISTS liste_employe_suivant_prenom;
DELIMITER |
CREATE PROCEDURE liste_employe_suivant_prenom(
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
END |
DELIMITER ;

################################################### LISTE EMPLOYE SUIVANT ROLE #
DROP PROCEDURE IF EXISTS liste_employe_suivant_role;
DELIMITER |
CREATE PROCEDURE liste_employe_suivant_role(
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
END |
DELIMITER ;

##################################################### LISTE CLIENT SUIVANT NOM #
DROP PROCEDURE IF EXISTS liste_client_suivant_nom;
DELIMITER |
CREATE PROCEDURE liste_client_suivant_nom(
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

END |
DELIMITER ;


################################################## LISTE CLIENT SUIVANT PRENOM #
DROP PROCEDURE IF EXISTS liste_client_suivant_prenom;
DELIMITER |
CREATE PROCEDURE liste_client_suivant_prenom(
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

END |
DELIMITER ;


################################################################################
#                                                       REQUETE SELECT PRODUIT #
################################################################################


############################################## LISTE INGREDIENT PRODUIT PAR ID #
DROP PROCEDURE IF EXISTS liste_ingredient_produit_par_id;
DELIMITER |
CREATE PROCEDURE liste_ingredient_produit_par_id(
   IN p_id INT(10) UNSIGNED)
BEGIN
   SELECT produit.id AS ID,
      produit.designation AS Désignation,
      composant.quantite AS Quantité,
      composant.unite AS Unité FROM composant
   INNER JOIN produit
   ON composant.ingredient_id = produit.id
   WHERE composant.produit_id = p_id;
END|
DELIMITER ;


##################################### LISTE INGREDIENT PRODUIT PAR DESIGNATION #
DROP PROCEDURE IF EXISTS liste_ingredient_produit_par_designation;
DELIMITER |
CREATE PROCEDURE liste_ingredient_produit_par_designation(
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
END|
DELIMITER ;

####################################################### LISTE PRODUIT VENDABLE #
DROP PROCEDURE IF EXISTS liste_produit_vendable;
DELIMITER |
CREATE PROCEDURE liste_produit_vendable(
   IN p_magasin_id INT(10) UNSIGNED)
BEGIN
   SELECT produit.id, produit.designation, produit.prix_vente_ht FROM produit 
   LEFT  JOIN stock ON produit.id = stock.produit_id
   WHERE (magasin_id = p_magasin_id OR magasin_id IS NULL) 
   AND (categorie NOT IN ('pack','vrac','ingrédient'))
   AND (stock.quantite > 0 OR stock.quantite IS NULL);

END |
DELIMITER ;


SHOW PROCEDURE STATUS WHERE Db ='oc_pizza';


################################################################################
# OC PIZZA                                                     CREATE FUNCTION #
################################################################################
# CREATE FUNCTION produit_est_disponible                                       #
# CREATE FUNCTION get_produit_id                                               #
# CREATE FUNCTION get_vrac_id                                                  #
# CREATE FUNCTION get_client_adresse_id                                        #
# CREATE FUNCTION get_etablissement_id                                         #
# CREATE FUNCTION est_adresse_de_magasin                                       #
# CREATE FUNCTION get_produit_id                                               #
# CREATE FUNCTION reste_du                                                     #
################################################################################

####################################################### PRODUIT EST DISPONIBLE #
DROP FUNCTION IF EXISTS produit_est_disponible;
DELIMITER |
CREATE FUNCTION produit_est_disponible(
	p_magasin_id INT(10) UNSIGNED,
	p_produit_id INT(10) UNSIGNED,
	p_quantite DECIMAL(2))
RETURNS INT
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
END |
DELIMITER ;

##############################################################  GET PRODUIT ID #
DROP FUNCTION IF EXISTS get_produit_id;
DELIMITER |
CREATE FUNCTION get_produit_id(
   p_designation VARCHAR(100),
   p_categorie ENUM ('pack','vrac','ingrédient','pizza','boisson','dessert','emballage','sauce'))
RETURNS INT
DETERMINISTIC
BEGIN
	DECLARE v_id INT(10) UNSIGNED;

   SELECT DISTINCT id INTO v_id FROM produit
   WHERE categorie = p_categorie AND designation LIKE CONCAT("%", p_designation, "%")
   ORDER BY id LIMIT 1;

   RETURN (v_id);
END |
DELIMITER ;

################################################################  GET VRAC ID #
DROP FUNCTION IF EXISTS get_vrac_id;
DELIMITER |
CREATE FUNCTION get_vrac_id(
   p_designation VARCHAR(100))
RETURNS INT
DETERMINISTIC
BEGIN
	DECLARE v_id INT(10) UNSIGNED;

   SELECT DISTINCT id INTO v_id FROM produit
   WHERE categorie = 'vrac' AND designation LIKE CONCAT("%", p_designation, "%")
   ORDER BY id LIMIT 1;

   RETURN (v_id);
END |
DELIMITER ;

################################################################  GET PIZZA ID #
DROP FUNCTION IF EXISTS get_pizza_id;
DELIMITER |
CREATE FUNCTION get_pizza_id(
   p_designation VARCHAR(100))
RETURNS INT
DETERMINISTIC
BEGIN
	DECLARE v_id INT(10) UNSIGNED;

   SELECT DISTINCT id INTO v_id FROM produit
   WHERE categorie = 'pizza' AND designation LIKE CONCAT("%", p_designation, "%")
   ORDER BY id LIMIT 1;

   RETURN (v_id);
END |
DELIMITER ;

################################################################  GET BOISSON ID #
DROP FUNCTION IF EXISTS get_boisson_id;
DELIMITER |
CREATE FUNCTION get_boisson_id(
   p_designation VARCHAR(100))
RETURNS INT
DETERMINISTIC
BEGIN
	DECLARE v_id INT(10) UNSIGNED;

   SELECT DISTINCT id INTO v_id FROM produit
   WHERE categorie = 'boisson' AND designation LIKE CONCAT("%", p_designation, "%")
   ORDER BY id LIMIT 1;

   RETURN (v_id);
END |
DELIMITER ;


######################################################## GET CLIENT ADRESSE ID #
DROP FUNCTION IF EXISTS get_client_adresse_id;
DELIMITER |
CREATE FUNCTION get_client_adresse_id(
	p_utilisateur_id INT(10) UNSIGNED)
RETURNS INT(10) UNSIGNED
DETERMINISTIC
BEGIN
	DECLARE v_adresse_id INT(10) UNSIGNED DEFAULT 0;

	SELECT adresse_id INTO v_adresse_id FROM client WHERE utilisateur_id = p_utilisateur_id;

	RETURN (v_adresse_id);
END |
DELIMITER ;



######################################################### GET ETABLISSEMENT ID #
DROP FUNCTION IF EXISTS get_etablissement_id;
DELIMITER |
CREATE FUNCTION get_etablissement_id(
	p_nom VARCHAR(20))
RETURNS INT(10) UNSIGNED
DETERMINISTIC
BEGIN
	DECLARE v_id INT(10) UNSIGNED DEFAULT 0;

	SELECT DISTINCT id INTO v_id FROM etablissement WHERE nom LIKE CONCAT('%',p_nom,'%')
	ORDER BY id ASC LIMIT 1;

	RETURN (v_id);
END |
DELIMITER ;


################################################################## EST MAGASIN #
DROP FUNCTION IF EXISTS est_adresse_de_magasin;
DELIMITER |
CREATE FUNCTION est_adresse_de_magasin(
	p_adresse_id INT(10) UNSIGNED)
RETURNS TINYINT
DETERMINISTIC
BEGIN
	DECLARE v_reponse TINYINT DEFAULT FALSE;

	SELECT COUNT(*) INTO v_reponse FROM magasin INNER JOIN adresse ON magasin.adresse_id = adresse.id WHERE adresse.id = p_adresse_id;

	RETURN (v_reponse);
END |
DELIMITER ;


##################################################################### RESTE DU #
DROP FUNCTION IF EXISTS reste_du;
DELIMITER |
CREATE FUNCTION reste_du(
   p_commande_id INT(10) UNSIGNED)
RETURNS DECIMAL(5,2)
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
END |
DELIMITER ;

SHOW FUNCTION STATUS WHERE Db ='oc_pizza';

################################################################################
# OC PIZZA                                                      CREATE REQUETE #
################################################################################
# PREPARE l_employe                                                            #
# PREPARE l_employe_dans_magasin                                               #                         
# PREPARE l_client                                                             #
# PREPARE l_client_dans_magasin                                                #
# PREPARE l_paiement_TR                                                        #
# PREPARE l_paiement_CB                                                        #
# PREPARE l_paiement_cheque                                                    #
# PREPARE l_commande_en_attente                                                #
# PREPARE l_commande_en_preparation                                            #
# PREPARE l_commande_préparee                                                  #
# PREPARE l_commande_livree                                                    #
# PREPARE all_recette                                                          #
# PREPARE recette_produit ?                                                    #
# PREPARE all_formule ?                                                        #
# PREPARE all_composition                                                      #
# PREPARE composition_produit ?                                                #
# PREPARE stock_all_magasin                                                    #
# PREPARE stock_magasin ?                                                      #
################################################################################


################################################################################
#                                                                  UTILISATEUR #
################################################################################
PREPARE l_employe FROM
'SELECT utilisateur.id AS id, CONCAT(civilite," ", prenom," ", utilisateur.nom) AS nom, login, role, magasin.nom FROM employe
INNER JOIN utilisateur ON employe.utilisateur_id = utilisateur.id 
INNER JOIN magasin ON utilisateur.magasin_id = magasin.id';

PREPARE l_employe_dans_magasin FROM
'SELECT utilisateur.id, utilisateur.prenom, utilisateur.nom, utilisateur.login, employe.role  FROM utilisateur
JOIN employe ON employe.utilisateur_id = utilisateur.id
WHERE utilisateur.magasin_id = ?';

PREPARE l_client FROM
'SELECT utilisateur.id AS id, CONCAT(civilite," ", prenom," ", utilisateur.nom) AS nom, login,client.telephone,client.email,CONCAT(numero,",",voie,",",code,",",ville)  AS adresse, magasin.nom AS magasin FROM client 
INNER JOIN utilisateur ON client.utilisateur_id = utilisateur.id
INNER JOIN adresse ON client.adresse_id = adresse.id
INNER JOIN magasin ON utilisateur.magasin_id = magasin.id';

PREPARE l_employe_dans_magasin FROM
'SELECT utilisateur.id AS id, CONCAT(civilite," ", prenom," ", utilisateur.nom) AS nom, login,client.telephone,client.email,CONCAT(numero,",",voie,",",code,",",ville)  AS adresse, magasin.nom AS magasin FROM client 
INNER JOIN utilisateur ON client.utilisateur_id = utilisateur.id
INNER JOIN adresse ON client.adresse_id = adresse.id
INNER JOIN magasin ON utilisateur.magasin_id = magasin.id
WHERE utilisateur.magasin_id = ?';


################################################################################
#                                                                     PAIEMENT #
################################################################################

PREPARE l_paiement_TR FROM
'SELECT paiement.id, paiement.type, ticket_restaurant.numero, etablissement.nom FROM paiement 
JOIN ticket_restaurant ON ticket_restaurant.paiement_id = paiement.id
JOIN etablissement ON etablissement.id = ticket_restaurant.etablissement_id';

PREPARE l_paiement_CB FROM
'SELECT paiement.id, paiement.type, carte_bancaire.reference, carte_bancaire.jour, carte_bancaire.heure FROM paiement 
JOIN carte_bancaire ON carte_bancaire.paiement_id = paiement.id';

PREPARE l_paiement_cheque FROM
'SELECT paiement.id, paiement.type, cheque.banque, cheque.numero, cheque.jour FROM paiement 
JOIN cheque ON cheque.paiement_id = paiement.id';


################################################################################
#                                                                     COMMANDE #
################################################################################
PREPARE l_commande FROM
'SELECT id, utilisateur_id, statut, jour, heure, preparation_delai AS Attente, 
		preparation_duree AS Préparation, livraison_delai AS Finalisation, 
		livraison_duree AS Livraison, paiement_OK FROM commande';


PREPARE l_commande_en_attente FROM
'SELECT id,utilisateur_id, statut, jour, heure, paiement_OK FROM commande WHERE statut = "En attente"';

PREPARE l_commande_en_preparation FROM
'SELECT id,utilisateur_id, statut, jour, heure, paiement_OK FROM commande WHERE statut = "En préparation"';

PREPARE l_commande_préparee FROM
'SELECT id,utilisateur_id, statut, jour, heure, paiement_OK FROM commande WHERE statut = "Préparée"';

PREPARE l_commande_en_livraison FROM
'SELECT id,utilisateur_id, statut, jour, heure, paiement_OK FROM commande WHERE statut = "En livraison"';

PREPARE l_commande_livree FROM
'SELECT id,utilisateur_id, statut, jour, heure, paiement_OK FROM commande WHERE statut = "Livrée"';

################################################################################
#                                                                      PRODUIT #
################################################################################
PREPARE all_recette FROM
'SELECT produit.id, produit.designation, recette from preparation 
JOIN produit ON produit.id = preparation.produit_id';

PREPARE recette_produit FROM
'SELECT produit.id, produit.designation, recette from preparation 
JOIN produit ON produit.id = preparation.produit_id
WHERE produit.id = ?';

PREPARE all_formule FROM
'SELECT produit.id AS id, produit.designation AS designation, formule from composition JOIN produit ON produit.id = composition.produit_id';

PREPARE formule_produit FROM
'SELECT produit.id AS id, produit.designation AS designation, formule from composition JOIN produit ON produit.id = composition.produit_id
WHERE produit.id = ?';

PREPARE all_composition FROM
'SELECT produit.designation, ing.designation, composant.quantite, composant.unite FROM composant 
JOIN produit ON composant.produit_id = produit.id
JOIN produit AS ing ON composant.ingredient_id = ing.id';

PREPARE composition_produit FROM
'SELECT produit.designation, ing.designation, composant.quantite, composant.unite FROM composant 
JOIN produit ON composant.produit_id = produit.id
JOIN produit AS ing ON composant.ingredient_id = ing.id
WHERE composant.produit_id = ?';


PREPARE stock_all_magasin FROM
'SELECT magasin.id, magasin.nom, produit.designation, stock.quantite, stock.unite FROM stock 
JOIN magasin ON stock.magasin_id = magasin.id
JOIN produit ON stock.produit_id = produit.id';

PREPARE stock_magasin FROM
'SELECT magasin.id, magasin.nom, produit.designation, stock.quantite, stock.unite FROM stock 
JOIN magasin ON stock.magasin_id = magasin.id
JOIN produit ON stock.produit_id = produit.id
WHERE stock.magasin_id = ?';

SHOW PROCEDURE STATUS WHERE Db ='oc_pizza';


################################################################################
# OC PIZZA                                                DEROULEMENT COMMANDE #
################################################################################

DROP PROCEDURE IF EXISTS etape_1;
DELIMITER |
CREATE PROCEDURE etape_1()
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
END |
DELIMITER ;


DROP PROCEDURE IF EXISTS etape_2;
DELIMITER |
CREATE PROCEDURE etape_2()
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

END |
DELIMITER ;


DROP PROCEDURE IF EXISTS etape_3;
DELIMITER |
CREATE PROCEDURE etape_3()
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
END |
DELIMITER ;


DROP PROCEDURE IF EXISTS etape_4;
DELIMITER |
CREATE PROCEDURE etape_4()
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
END |
DELIMITER ;

DROP PROCEDURE IF EXISTS etape_5;
DELIMITER |
CREATE PROCEDURE etape_5()
BEGIN
	EXECUTE l_commande;

	SELECT "Le pizzaiolo prend la commande 1" AS Action;
	CALL pizzaiolo_prend_commande(1);
	
	EXECUTE l_commande;
END |
DELIMITER ;


DROP PROCEDURE IF EXISTS etape_6;
DELIMITER |
CREATE PROCEDURE etape_6()
BEGIN
	
	SELECT "Le pizzaiolo termine la commande 1 et prend la commande 2" AS Action;
	CALL pizzaiolo_termine_commande(1);
	CALL pizzaiolo_prend_commande(2);

	EXECUTE l_commande;
END |
DELIMITER ;

DROP PROCEDURE IF EXISTS etape_7;
DELIMITER |
CREATE PROCEDURE etape_7()
BEGIN
	SELECT "Le pizzaiolo termine la commande 2 et le livreur prend la commande 1" AS Action;
	CALL livreur_prend_commande(1);
	CALL pizzaiolo_termine_commande(2);

	EXECUTE l_commande;
END |
DELIMITER ;

DROP PROCEDURE IF EXISTS etape_8;
DELIMITER |
CREATE PROCEDURE etape_8()
BEGIN
	SELECT "Le client prend la commande 1 et un autre la commande 2" AS Action;
	CALL client_prend_commande(1);
	CALL client_prend_commande(2);

	EXECUTE l_commande;
END |
DELIMITER ;

DROP PROCEDURE IF EXISTS etape_9;
DELIMITER |
CREATE PROCEDURE etape_9()
BEGIN
	CALL etape_1;
	CALL etape_2;
	CALL etape_3;
	CALL etape_4;
	CALL etape_5;
	CALL etape_6;
	CALL etape_7;
	CALL etape_8;
END |
DELIMITER ;


SELECT "
	CALL etape_1;
	CALL etape_2;
	CALL etape_3;
	CALL etape_4;
	CALL etape_5;
	CALL etape_6;
	CALL etape_7;
	CALL etape_8;" AS "Lancez les commandes suivantes :";

