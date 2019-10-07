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

############################################## LISTE INGREDIENT PRODUIT PAR ID #
DROP PROCEDURE IF EXISTS liste_ingredient_produit_par_id;
DELIMITER |
CREATE PROCEDURE liste_ingredient_produit_par_id(
	IN p_id INT(10) UNSIGNED)
BEGIN
	SELECT produit.id,produit.designation,composant.quantite,composant.unite FROM produit
	INNER JOIN composant ON ingredient_id = produit.id
	WHERE composant.produit_id = p_id;
END|
DELIMITER ;

##################################### LISTE INGREDIENT PRODUIT PAR DESIGNATION #
DROP PROCEDURE IF EXISTS liste_ingredient_produit_par_designation;
DELIMITER |
CREATE PROCEDURE liste_ingredient_produit_par_designation(
	IN p_designation VARCHAR(100))
BEGIN
	SELECT produit.id,produit.designation,composant.quantite,composant.unite FROM produit
	INNER JOIN composant ON ingredient_id = produit.id
	WHERE produit.designation LIKE CONCAT('%',p_designation,'%');
END|
DELIMITER ;



SELECT utilisateur.id, utilisateur.prenom, utilisateur.nom, utilisateur.login, utilisateur.magasin_id,employe.role  FROM utilisateur
JOIN employe ON employe.utilisateur_id = utilisateur.id;

SELECT utilisateur.id,utilisateur.civilite,utilisateur.prenom,utilisateur.nom,utilisateur.login,utilisateur.magasin_id,client.telephone,client.email  FROM utilisateur
JOIN client ON client.utilisateur_id = utilisateur.id;


SELECT paiement.id, paiement.type, ticket_restaurant.numero, etablissement.nom FROM paiement 
JOIN ticket_restaurant ON ticket_restaurant.paiement_id = paiement.id
JOIN etablissement ON etablissement.id = ticket_restaurant.etablissement_id;


SELECT paiement.id, paiement.type, carte_bancaire.reference, carte_bancaire.jour, carte_bancaire.heure FROM paiement 
JOIN carte_bancaire ON carte_bancaire.paiement_id = paiement.id;


SELECT paiement.id, paiement.type, cheque.banque, cheque.numero, cheque.jour FROM paiement 
JOIN cheque ON cheque.paiement_id = paiement.id;


SELECT paiement.id, paiement.type FROM paiement;

SHOW PROCEDURE STATUS WHERE Db ='oc_pizza';
