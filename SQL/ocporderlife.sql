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
SELECT "
	CALL etape_1;
	CALL etape_2;
	CALL etape_3;
	CALL etape_4;
	CALL etape_5;
	CALL etape_6;
	CALL etape_7;
	CALL etape_8;" AS "Lancez les commandes suivantes :";


#CALL etape_1;
#CALL etape_2;
#CALL etape_3;
#CALL etape_4;
#CALL etape_5;
#CALL etape_6;
#CALL etape_7;
#CALL etape_8;