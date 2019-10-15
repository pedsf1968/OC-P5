################################################################################
# OC PIZZA                                                     CREATE FUNCTION #
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
   WHERE categorie = 'vrac' AND designation LIKE CONCAT("%", p_designation, "%")
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

SHOW PROCEDURE STATUS WHERE Db ='oc_pizza';
