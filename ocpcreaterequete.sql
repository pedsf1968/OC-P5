################################################################################
# OC PIZZA                                                      CREATE REQUETE #
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

PREPARE l_client_dans_magasin FROM
'SELECT utilisateur.id,utilisateur.civilite,utilisateur.prenom,utilisateur.nom,utilisateur.login,client.telephone,client.email  FROM utilisateur
JOIN client ON client.utilisateur_id = utilisateur.id
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


SHOW PROCEDURE STATUS WHERE Db ='oc_pizza';
