################################################################################
# OC PIZZA                                                DEROULEMENT COMMANDE #
################################################################################

SELECT "Le client 8 rempli son panier avec une livraison";
CALL ajoute_panier(8,get_produit_id("Pizza margarita","pizza"),1,TRUE);
CALL ajoute_panier(8,get_produit_id("Pizza margarita","pizza"),1,TRUE);
CALL ajoute_panier(8,get_produit_id("Cola - 33cl/1","boisson"),1,TRUE);
CALL ajoute_panier(8,get_produit_id("Eau gazeuze - 50cl/1","boisson"),1,TRUE);
SELECT * FROM panier WHERE utilisateur_id = 8;
SELECT * FROM ligne_de_panier WHERE utilisateur_id = 8;

SELECT "Le client 8 enleve un produit et passe en take away";
CALL enleve_panier(8,get_produit_id("margarita","pizza"),1,FALSE);
SELECT * FROM panier ;
SELECT * FROM ligne_de_panier;

SELECT "Le client 8 ajoute un produit et repasse en livraison";
CALL ajoute_panier(8,get_produit_id("4 fromages","pizza"),1,TRUE);
SELECT * FROM panier ;
SELECT * FROM ligne_de_panier;


SELECT "Le client 9 rempli son panier en take away";
CALL ajoute_panier(9,get_produit_id("Pizza margarita","pizza"),1,FALSE);
CALL ajoute_panier(9,get_produit_id("Cola - 33cl/1","boisson"),1,FALSE);
SELECT * FROM panier;
SELECT * FROM ligne_de_panier ;


SELECT "Le client 8 valide son panier";
CALL valide_commande(8,@ID);

SELECT "Le panier est vide";
SELECT * FROM panier WHERE utilisateur_id = 8;
SELECT * FROM ligne_de_panier WHERE utilisateur_id = 8;

SELECT "La commande est validée non payée et avec le statut En attente";
SELECT id,utilisateur_id, statut, jour, heure, paiement_OK FROM commande WHERE utilisateur_id = 8;
SELECT commande_id AS IDC, produit_id AS IDP, quantite AS Quantité, prix_unitaire_ht*(1+taux_tva/100) AS Prix FROM ligne_de_commande WHERE commande_id = @ID;
SELECT reste_du(@ID);

SELECT "Le client 8 effectue le paiement par CB";
CALL add_paiement_carte_bancaire(@ID,35.42,"ERGQGQD6546",@IDPAIEMENT);
SELECT "La commande est payée";
SELECT id,utilisateur_id, statut, jour, heure, paiement_OK FROM commande WHERE utilisateur_id = 8;
SELECT commande_id, paiement_id, montant, type FROM liste_paiement JOIN paiement ON paiement.id = liste_paiement.paiement_id WHERE commande_id = @ID;
SELECT reste_du(@ID);

SELECT "Le client 9 valide son panier";
CALL valide_commande(9, @commande);

SELECT "Le panier est vide";
SELECT * FROM panier WHERE utilisateur_id = 9;
SELECT * FROM ligne_de_panier WHERE utilisateur_id = 9;

SELECT "La commande est validée non payée et avec le statut En attente";
SELECT id,utilisateur_id, statut, jour, heure, paiement_OK FROM commande WHERE utilisateur_id = 9;
SELECT commande_id AS IDC, produit_id AS IDP, quantite AS Quantité, prix_unitaire_ht*(1+taux_tva/100) AS Prix FROM ligne_de_commande WHERE commande_id = @commande;
SELECT reste_du(@commande);

SELECT "Le client 9 effectue le paiement par Ticket Restaurant";
CALL add_paiement_ticket_restaurant(@commande,8.20,"ERGQGQD6546",get_etablissement_id("Pass"),@IDPAIEMENT);
SELECT id,utilisateur_id, statut, jour, heure, paiement_OK FROM commande WHERE utilisateur_id = 9;
SELECT commande_id, paiement_id, montant, type FROM liste_paiement JOIN paiement ON paiement.id = liste_paiement.paiement_id WHERE commande_id = @commande;
SELECT reste_du(@commande);

SELECT "Le client 9 effectue le reste du paiement en espèce";
CALL add_paiement_espece(@commande,10.53,@IDPAIEMENT);

SELECT "La commande est payée";
SELECT id,utilisateur_id, statut, jour, heure, paiement_OK FROM commande WHERE utilisateur_id = 9;
SELECT commande_id, paiement_id, montant, type FROM liste_paiement JOIN paiement ON paiement.id = liste_paiement.paiement_id WHERE commande_id = @commande;
SELECT reste_du(@commande);

SELECT id,utilisateur_id, statut, jour, heure, preparation_delai AS Attente, preparation_duree AS Préparation, livraison_delai AS Finalisation, livraison_duree AS Livraison,paiement_OK FROM commande;

CALL pizzaiolo_prend_commande(1);
SELECT id,utilisateur_id, statut, jour, heure, preparation_delai AS Attente, preparation_duree AS Préparation, livraison_delai AS Finalisation, livraison_duree AS Livraison,paiement_OK FROM commande;

CALL pizzaiolo_termine_commande(1);
SELECT id,utilisateur_id, statut, jour, heure, preparation_delai AS Attente, preparation_duree AS Préparation, livraison_delai AS Finalisation, livraison_duree AS Livraison,paiement_OK FROM commande;

CALL pizzaiolo_prend_commande(2);
SELECT id,utilisateur_id, statut, jour, heure, preparation_delai AS Attente, preparation_duree AS Préparation, livraison_delai AS Finalisation, livraison_duree AS Livraison,paiement_OK FROM commande;



CALL livreur_prend_commande(1);
SELECT id,utilisateur_id, statut, jour, heure, preparation_delai AS Attente, preparation_duree AS Préparation, livraison_delai AS Finalisation, livraison_duree AS Livraison,paiement_OK FROM commande;

CALL pizzaiolo_termine_commande(2);
SELECT id,utilisateur_id, statut, jour, heure, preparation_delai AS Attente, preparation_duree AS Préparation, livraison_delai AS Finalisation, livraison_duree AS Livraison,paiement_OK FROM commande;

CALL client_prend_commande(1);
SELECT id,utilisateur_id, statut, jour, heure, preparation_delai AS Attente, preparation_duree AS Préparation, livraison_delai AS Finalisation, livraison_duree AS Livraison,paiement_OK FROM commande;

CALL client_prend_commande(2);
SELECT id,utilisateur_id, statut, jour, heure, preparation_delai AS Attente, preparation_duree AS Préparation, livraison_delai AS Finalisation, livraison_duree AS Livraison,paiement_OK FROM commande;
