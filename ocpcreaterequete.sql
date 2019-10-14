################################################################################
# OC PIZZA                                                      CREATE REQUETE #
################################################################################

################################################################################
#                                                      REQUETE SELECT GENERALE #
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

##############################################################  GET VRAC ID #
DROP FUNCTION IF EXISTS get_vrac_id;
DELIMITER |
CREATE FUNCTION get_vrac_id(
   p_designation VARCHAR(100))
RETURNS INT
DETERMINISTIC
BEGIN
	DECLARE v_id INT(10) UNSIGNED;

   SELECT DISTINCT id INTO v_id FROM produit
   WHERE categorie = p_categorie AND categorie = 'vrac' AND designation LIKE CONCAT("%", p_designation, "%")
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


PREPARE l_employe FROM
'SELECT utilisateur.id AS id, CONCAT(civilite,' ', prenom,' ', utilisateur.nom) AS nom, login, role, magasin.nom FROM employe
INNER JOIN utilisateur ON employe.utilisateur_id = utilisateur.id 
INNER JOIN magasin ON utilisateur.magasin_id = magasin.id';


PREPARE l_employe_dans_magasin FROM
'SELECT utilisateur.id, utilisateur.prenom, utilisateur.nom, utilisateur.login, employe.role  FROM utilisateur
JOIN employe ON employe.utilisateur_id = utilisateur.id
WHERE utilisateur.magasin_id = ?';

PREPARE l_client FROM
'SELECT utilisateur.id AS id, CONCAT(civilite,' ', prenom,' ', utilisateur.nom) AS nom, login,client.telephone,client.email,CONCAT(numero,',',voie,',',code,',',ville)  AS adresse, magasin.nom AS magasin FROM client 
INNER JOIN utilisateur ON client.utilisateur_id = utilisateur.id
INNER JOIN adresse ON client.adresse_id = adresse.id
INNER JOIN magasin ON utilisateur.magasin_id = magasin.id';


PREPARE l_client_dans_magasin FROM
'SELECT utilisateur.id,utilisateur.civilite,utilisateur.prenom,utilisateur.nom,utilisateur.login,client.telephone,client.email  FROM utilisateur
JOIN client ON client.utilisateur_id = utilisateur.id
WHERE utilisateur.magasin_id = ?';

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


SHOW PROCEDURE STATUS WHERE Db ='oc_pizza';
