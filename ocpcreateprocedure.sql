################################################################################
# OC PIZZA                                                   CREATE PROCEDURES #
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
END |
DELIMITER ;


################################################################ CREATE CLIENT #
DROP PROCEDURE IF EXISTS create_client;
DELIMITER |
CREATE PROCEDURE create_client( 
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
      SET v_preparation_duree = TIMEDIFF(NOW(),TIMESTAMP(v_start_date,v_start_time)) - v_preparation_delai;   
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
      SET v_livraison_delai = TIMEDIFF(NOW(),TIMESTAMP(v_start_date,v_start_time)) - v_preparation_delai - v_preparation_duree;
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

   -- un client peut prendre la commande directement en magasin donc elle ne passe pas par la livraison
   IF v_livraison_delai IS NULL THEN
      SET v_livraison_duree = TIMEDIFF(NOW(),TIMESTAMP(v_start_date,v_start_time)) - v_preparation_delai - v_preparation_duree;
      UPDATE commande SET statut = 'Livrée',  livraison_delai = 0, livraison_duree = v_livraison_duree WHERE id = p_commande_id;      
   ELSE
      SET v_livraison_duree = TIMEDIFF(NOW(),TIMESTAMP(v_start_date,v_start_time)) - v_preparation_delai - v_preparation_duree - v_livraison_delai;
      UPDATE commande SET statut = 'Livrée',  livraison_duree = v_preparation_duree WHERE id = p_commande_id;
   END IF;

END |
DELIMITER ;


SHOW PROCEDURE STATUS WHERE Db ='oc_pizza';

