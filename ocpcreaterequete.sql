################################################################################
# OC PIZZA                                                      CREATE REQUETE #
################################################################################

################################################################################
#                                                      REQUETE SELECT GENERALE #
################################################################################

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

############################################################### GET PRODUIT ID #
DROP FUNCTION IF EXISTS get_produit_id;
DELIMITER |
CREATE FUNCTION get_produit_id(
	p_designation VARCHAR(100))
RETURNS INT(10) UNSIGNED
DETERMINISTIC
BEGIN
	DECLARE v_id INT(10) UNSIGNED;

	SELECT id INTO v_id
	FROM produit
	WHERE designation LIKE CONCAT('%',p_designation,'%') 
	ORDER BY id ASC LIMIT 1;

	RETURN (v_id);
END |
DELIMITER ;

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



PREPARE liste_employe FROM
'SELECT utilisateur.id, utilisateur.prenom, utilisateur.nom, utilisateur.login, utilisateur.magasin_id,employe.role  FROM utilisateur
JOIN employe ON employe.utilisateur_id = utilisateur.id';

PREPARE liste_employe_dans_magasin FROM
'SELECT utilisateur.id, utilisateur.prenom, utilisateur.nom, utilisateur.login, employe.role  FROM utilisateur
JOIN employe ON employe.utilisateur_id = utilisateur.id
WHERE utilisateur.magasin_id = ?';

PREPARE liste_client FROM
'SELECT utilisateur.id,utilisateur.civilite,utilisateur.prenom,utilisateur.nom,utilisateur.login,utilisateur.magasin_id,client.telephone,client.email  FROM utilisateur
JOIN client ON client.utilisateur_id = utilisateur.id';

PREPARE liste_client_dans_magasin FROM
'SELECT utilisateur.id,utilisateur.civilite,utilisateur.prenom,utilisateur.nom,utilisateur.login,client.telephone,client.email  FROM utilisateur
JOIN client ON client.utilisateur_id = utilisateur.id
WHERE utilisateur.magasin_id = ?';

SELECT paiement.id, paiement.type, ticket_restaurant.numero, etablissement.nom FROM paiement 
JOIN ticket_restaurant ON ticket_restaurant.paiement_id = paiement.id
JOIN etablissement ON etablissement.id = ticket_restaurant.etablissement_id;


SELECT paiement.id, paiement.type, carte_bancaire.reference, carte_bancaire.jour, carte_bancaire.heure FROM paiement 
JOIN carte_bancaire ON carte_bancaire.paiement_id = paiement.id;


SELECT paiement.id, paiement.type, cheque.banque, cheque.numero, cheque.jour FROM paiement 
JOIN cheque ON cheque.paiement_id = paiement.id;


SELECT paiement.id, paiement.type FROM paiement;

SHOW PROCEDURE STATUS WHERE Db ='oc_pizza';
