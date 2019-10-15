################################################################################
# OC PIZZA                                                       FILL DATABASE #
################################################################################


################################################################################
#                                                                  GLOBAL DATA #
################################################################################

################################################################ ETABLISSEMENT #
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
SELECT * FROM etablissement;

###################################################################### MAGASIN #
CALL create_magasin('Pizza Napoli',	'0381501111','napoli@ocpizza.com',	'1',	'rue des Teinturiers',	'Lyon','69003', @ID);
CALL create_magasin('Pizza Firenze','0381501654','firenze@ocpizza.com',	'45',	'rue des Bleuet',		'Dole','39000',@ID);
CALL create_magasin('Pizza Roma',	'0381501112','roma@ocpizza.com',	'4',	'rue des Acacias',		'Vesoul','70000',@ID);
CALL create_magasin('Pizza Torino',	'0381501113','torino@ocpizza.com',	'12',	'rue des Chataigniers',	'Belfort','90000',@ID);
SELECT magasin.id,nom,telephone,email,CONCAT(numero,',',voie,',',code,',',ville)  AS adresse FROM magasin JOIN adresse ON adresse_id = adresse.id;

################################################################## FOURNISSEUR #
CALL create_fournisseur('Global Food',	'0145686811','client@globalfood.com',	'14',	'rue de Paris',	'RUNGIS','94150', @ID);
CALL create_fournisseur('Italia Food',	'0181654654','commande@italiafood.com',	'15',	'rue de Paris',	'RUNGIS','94150', @ID);
SELECT fournisseur.id,nom,telephone,email,CONCAT(numero,',',voie,',',code,',',ville)  AS adresse FROM fournisseur JOIN adresse ON adresse_id = adresse.id;


################################################################################
#                                                             UTILISATEUR DATA #
################################################################################

###################################################################### EMPLOYE #
CALL create_employe('Mlle','CASTAFIORE','Bianca','Bianca',SHA1('CASTAFIORE'),1,'Accueil',@ID);
CALL create_employe('M','TINTIN','Milou','Milou',SHA1('TINTIN'),1,'Livreur',@ID);
CALL create_employe('M','HADDOCK','Capitaine','Capitaine',SHA1('HADDOCK'),1,'Direction',@ID);
CALL create_employe('M','ALCAZAR','Général','Général',SHA1('ALCAZAR'),1,'Pizzaiolo',@ID);
CALL create_employe('M','MULLER','Docteur','Docteur',SHA1('MULLER'),1,'Comptable',@ID);
CALL create_employe('M','LAMPION','Séraphin','Séraphin',SHA1('LAMPION'),1,'Manager',@ID);
CALL create_employe('M','SPONSZ','Colonel','Colonel',SHA1('SPONSZ'),1,'Gestionnaire',@ID);

EXECUTE l_employe;

####################################################################### CLIENT #
CALL create_client('M','RACKHAM','Red','Red',SHA1('RACKHAM'),1,'0381565422','red.rackham@gmail.com','1', 'Rue de Naple','Besançon','25000',@ID);
CALL create_client('M','DA FIGUEIRA','Oliveira','Oliveira',SHA1('DA FIGUEIRA'),1,'0381565422','oliveira.dafigueira@hotmail.com','10', 'Rue des Frères Mercier','Besançon','25000',@ID);
CALL create_client('M','WOLF','Frank','Frank',SHA1('WOLF'),2,'0381565422','frank.wolf@orange.fr','7', 'Rue des Grand Bas','Besançon','25000',@ID);
CALL create_client('M','THOMPSON','Alan','Alan',SHA1('THOMPSON'),2,'0381565422','alan.thompson@red.com','4', 'Rue de la Paix','Besançon','25000',@ID);
CALL create_client('M','DUPON','ThierryAlan','Thierry',SHA1('DUPON'),1,'0381565422','thierry.dupon@belga.be','34', 'Rue de la Résistance','Besançon','25000',@ID);
CALL create_client('M','DUPON','Daniel','Daniel',SHA1('DUPON'),2,'0381565422','daniel.dupon@belga.be','9', 'Rue Battant','Besançon','25000',@ID);

EXECUTE l_client;


################################################################################
#                                                                 PRODUIT DATA #
################################################################################

################################################################# LES PRODUITS #
# create_produit( IN p_designation,p_categorie,p_fournisseur_id,p_reference,   #
#                    p_quantite,p_unite, p_prix_achat_ht, p_prix_vente_ht,     #
#                    p_tva_emporte, p_tva_livre, p_formule, p_recette,         #
#                 OUT p_id INT(10))                                            #
################################################################################

######################################################################## SECHE #
CALL create_produit('farine de blé T55 - 25Kg','ingrédient',1,'fkjh6546',25.00,'KG',33.40,NULL,0.0,0.0,'farine',NULL,@COMP);
CALL create_produit('farine de blé T55 - Vrac','vrac',1,'fkjh6546',1.0,'KG',NULL,NULL,0.0,0.0,'farine',NULL,@ING);
CALL add_composant(@COMP,@ING,25.0,'KG');

###################################################################### PRIMEUR #
CALL create_produit('Champignon pied coupé moyen catégorie 1 - 3Kg','ingrédient',1,'31347',3.00,'KG',14.5,NULL,0.0,0.0,'champignon',NULL,@COMP);
CALL create_produit('Champignon pied coupé moyen catégorie 1 - Vrac','vrac',1,'31347',1.00,'KG',NULL,NULL,0.0,0.0,'champignon',NULL,@ING);
CALL add_composant(@COMP,@ING,3.0,'KG');

CALL create_produit('Poivron mixte calibre 80/100 catégorie 1 - 4Kg','ingrédient',1,'82657',4.00,'KG',15.00,NULL,0.0,0.0,'poivron',NULL,@COMP);
CALL create_produit('Poivron mixte calibre 80/100 catégorie 1 - Vrac','vrac',1,'82657',1.00,'KG',NULL,NULL,0.0,0.0,'poivron',NULL,@ING);
CALL add_composant(@COMP,@ING,4.0,'KG');

CALL create_produit('Tomate ronde calibre 57/67 océanecatégorie extra - 6Kg','ingrédient',1,'93945',6.00,'KG',15.00,NULL,0.0,0.0,'tomate',NULL,@COMP);
CALL create_produit('Tomate ronde calibre 57/67 océanecatégorie extra - Vrac','vrac',1,'93945',1.0,'KG',NULL,NULL,0.0,0.0,'tomate',NULL,@ING);
CALL add_composant(@COMP,@ING,6.0,'KG');

CALL create_produit('Aubergine calibre 300/400 catégorie 1 - 6Kg','ingrédient',1,'59884',6.00,'KG',20.00,NULL,0.0,0.0,'aubergine',NULL,@COMP);
CALL create_produit('Aubergine calibre 300/400 catégorie 1 - Vrac','vrac',1,'59884',1.00,'KG',NULL,NULL,0.0,0.0,'aubergine',NULL,@ING);
CALL add_composant(@COMP,@ING,6.0,'KG');

CALL create_produit('Oignon charcutier calibre 70/100 catégorie 1 - 10Kg','ingrédient',1,'702815',10.00,'KG',20.00,NULL,0.0,0.0,'oignon',NULL,@COMP);
CALL create_produit('Oignon charcutier calibre 70/100 catégorie 1 - Vrac','vrac',1,'702815',1.00,'KG',NULL,NULL,0.0,0.0,'oignon',NULL,@ING);
CALL add_composant(@COMP,@ING,10.0,'KG');

#################################################################### BOUCHERIE #
CALL create_produit('Bacon standard sous vide fumé - 1.5Kg','ingrédient',2,'236179',1.50,'KG',55.00,NULL,0.0,0.0,'porc',NULL,@COMP);
CALL create_produit('Bacon standard sous vide fumé - Vrac','vrac',2,'236179',1.0,'KG',NULL,NULL,0.0,0.0,'porc',NULL,@ING);
CALL add_composant(@COMP,@ING,1.5,'KG');

CALL create_produit('Jambon de Vendée à l''ancienne - 3Kg','ingrédient',2,'235440',3.00,'KG',35.00,NULL,0.0,0.0,'porc',NULL,@COMP);
CALL create_produit('Jambon de Vendée à l''ancienne - Vrac','vrac',2,'235440',1.0,'KG',NULL,NULL,0.0,0.0,'porc',NULL,@ING);
CALL add_composant(@COMP,@ING,3.0,'KG');

CALL create_produit('Pepperoni - 1.8Kg','ingrédient',2,'157623',1.8,'KG',35.00,NULL,0.0,0.0,'porc',NULL,@COMP);
CALL create_produit('Pepperoni - Vrac','vrac',2,'157623',1.0,'KG',NULL,NULL,0.0,0.0,'porc',NULL,@ING);
CALL add_composant(@COMP,@ING,1.8,'KG');

CALL create_produit('Chorizo fort - 1.8Kg','ingrédient',2,'157623',1.8,'KG',35.00,NULL,0.0,0.0,'porc',NULL,@COMP);
CALL create_produit('Chorizo fort - Vrac','vrac',2,'157623',1.0,'KG',NULL,NULL,0.0,0.0,'porc',NULL,@ING);
CALL add_composant(@COMP,@ING,1.8,'KG');

######################################################################## MAREE #
CALL create_produit('Saumon sauvage filet sous vide - 5Kg','ingrédient',1,'706424',5.0,'KG',111.10,NULL,0.0,0.0,'poisson',NULL,@COMP);
CALL create_produit('Saumon sauvage filet sous vide - Vrac','vrac',1,'706424',1.0,'KG',NULL,NULL,0.0,0.0,'poisson',NULL,@ING);
CALL add_composant(@COMP,@ING,5.0,'KG');


##################################################################### CREMERIE #
CALL create_produit('Oeuf calibre gros fermier - 30U','ingrédient',1,'159123',30,'U',10.1,NULL,0.0,0.0,'oeuf',NULL,@COMP);
CALL create_produit('Oeuf calibre gros fermier - Vrac','vrac',1,'159123',1,'U',NULL,NULL,0.0,0.0,'oeuf',NULL,@ING);
CALL add_composant(@COMP,@ING,30,'U');

CALL create_produit('Lait 1/2 écrémé UHT 1.6% MG brique - 6L','ingrédient',1,'247890',6,'L',0.89,NULL,0.0,0.0,'lait',NULL,@COMP);
CALL create_produit('Lait 1/2 écrémé UHT 1.6% MG brique - Vrac','vrac',1,'247890',1,'L',NULL,NULL,0.0,0.0,'lait',NULL,@ING);
CALL add_composant(@COMP,@ING,6.0,'L');

CALL create_produit('Crème liquide UHT 30% MG - 6L','ingrédient',1,'246755',6,'L',1.10,NULL,0.0,0.0,'lait',NULL,@COMP);
CALL create_produit('Crème liquide UHT 30% MG - Vrac','vrac',1,'246755',1,'L',NULL,NULL,0.0,0.0,'lait',NULL,@ING);
CALL add_composant(@COMP,@ING,6.0,'L');

CALL create_produit('Sauce tomate - 6L','ingrédient',1,'247890',6,'L',2.59,NULL,0.0,0.0,'tomate,poivre,sel',NULL,@COMP);
CALL create_produit('Sauce tomate - Vrac','vrac',1,'247890',1,'L',NULL,NULL,0.0,0.0,'tomate,poivre,sel',NULL,@ING);
CALL add_composant(@COMP,@ING,6.0,'L');

CALL create_produit('Fromage rapé - 5Kg','ingrédient',2,'654654',5.00,'KG',50.00,NULL,0.0,0.0,'fromage',NULL,@COMP);
CALL create_produit('Fromage rapé - Vrac','vrac',2,'654654',1.0,'KG',NULL,NULL,0.0,0.0,'fromage',NULL,@ING);
CALL add_composant(@COMP,@ING,5.0,'KG');

CALL create_produit('Mozzarella - 5Kg','ingrédient',2,'78989',5.00,'KG',80.00,NULL,0.0,0.0,'fromage',NULL,@COMP);
CALL create_produit('Mozzarella - Vrac','vrac',2,'78989',1.0,'KG',NULL,NULL,0.0,0.0,'fromage',NULL,@ING);
CALL add_composant(@COMP,@ING,5.0,'KG');

CALL create_produit('Chèvre - 2Kg','ingrédient',2,'78989',2.00,'KG',40.00,NULL,0.0,0.0,'fromage',NULL,@COMP);
CALL create_produit('Chèvre - Vrac','vrac',2,'78989',1.0,'KG',NULL,NULL,0.0,0.0,'fromage',NULL,@ING);
CALL add_composant(@COMP,@ING,2.0,'KG');

CALL create_produit('Fourme d''Amber AOP - 2Kg','ingrédient',2,'78989',2.00,'KG',40.00,NULL,0.0,0.0,'fromage',NULL,@COMP);
CALL create_produit('Fourme d''Amber AOP - Vrac','vrac',2,'78989',1.0,'KG',NULL,NULL,0.0,0.0,'fromage',NULL,@ING);
CALL add_composant(@COMP,@ING,2.0,'KG');

################################################################# LES BOISSONS #
CALL create_produit('Eau plate - 50cl/24','pack',1,'65465',24,'U',NULL,NULL,0.0,0.0,'eau',NULL,@COMP);
CALL create_produit('Eau plate - 50cl/1','boisson',1,'65465',1,'U',NULL,1.8,5.5,10.0,'eau',NULL,@ING);
CALL add_composant(@COMP,@ING,24,'U');

CALL create_produit('Eau gazeuze - 50cl/24','pack',1,'654898',1,'U',NULL,NULL,0.0,0.0,'eau',NULL,@COMP);
CALL create_produit('Eau gazeuze - 50cl/1','boisson',1,'654898',1,'U',NULL,1.8,5.5,10.0,'eau',NULL,@ING);
CALL add_composant(@COMP,@ING,24,'U');

CALL create_produit('Cola - 33cl/24','pack',1,'654898',1,'U',NULL,NULL,0.0,0.0,NULL,NULL,@COMP);
CALL create_produit('Cola - 33cl/1','boisson',1,'654898',1,'U',NULL,1.8,5.5,10.0,NULL,NULL,@ING);
CALL add_composant(@COMP,@ING,24,'U');

CALL create_produit('Jus d''orange - 33cl/24','pack',1,'888554',1,'U',NULL,NULL,0.0,0.0,NULL,NULL,@COMP);
CALL create_produit('Jus d''orange - 33cl/1','boisson',1,'888554',1,'U',NULL,1.8,5.5,10.0,NULL,NULL,@ING);
CALL add_composant(@COMP,@ING,24,'U');

CALL create_produit('Jus de pomme - 33cl/24','pack',1,'644898',1,'U',NULL,NULL,0.0,0.0,NULL,NULL,@COMP);
CALL create_produit('Jus de pomme - 33cl/1','boisson',1,'644898',1,'U',NULL,2.1,5.5,10.0,NULL,NULL,@ING);
CALL add_composant(@COMP,@ING,24,'U');

################################################################### LES PIZZAS #
CALL create_produit('Pizza margarita','pizza',1,'Pmargarita',1,'U',NULL,15.3,10.0,10.0,NULL,NULL,@COMP);
CALL add_composant(@COMP,get_vrac_id('farine'),0.10,'KG');
CALL add_composant(@COMP,get_vrac_id('jambon'),0.10,'KG');
CALL add_composant(@COMP,get_vrac_id('Sauce tomate'),0.05,'L');
CALL add_composant(@COMP,get_vrac_id('Fromage rapé'),0.10,'KG');

CALL create_produit('Pizza 4 fromages','pizza',1,'P4fromages',1,'U',NULL,13.3,10.0,10.0,NULL,NULL,@COMP);
CALL add_composant(@COMP,get_vrac_id('farine'),0.10,'KG');
CALL add_composant(@COMP,get_vrac_id('Mozzarella'),0.10,'KG');
CALL add_composant(@COMP,get_vrac_id('Fromage rapé'),0.10,'KG');
CALL add_composant(@COMP,get_vrac_id('Fourme'),0.10,'KG');
CALL add_composant(@COMP,get_vrac_id('Chevre'),0.10,'KG');
CALL add_composant(@COMP,get_vrac_id('Sauce tomate'),0.05,'L');

CALL create_produit('Pizza extravaganzza','pizza',1,'Pextravag',1,'U',NULL,16.5,10.0,10.0,NULL,NULL,@COMP);
CALL add_composant(@COMP,get_vrac_id('farine'),0.10,'KG');
CALL add_composant(@COMP,get_vrac_id('Champignon'),0.05,'KG');
CALL add_composant(@COMP,get_vrac_id('Poivron'),0.05,'KG');
CALL add_composant(@COMP,get_vrac_id('Mozzarella'),0.10,'KG');
CALL add_composant(@COMP,get_vrac_id('Fromage rapé'),0.10,'KG');
CALL add_composant(@COMP,get_vrac_id('Pepperoni'),0.10,'KG');
CALL add_composant(@COMP,get_vrac_id('Jambon'),0.10,'KG');
CALL add_composant(@COMP,get_vrac_id('Bacon'),0.10,'KG');
CALL add_composant(@COMP,get_vrac_id('Sauce tomate'),0.05,'L');


SELECT * FROM produit;
SELECT * FROM composition;
SELECT * FROM preparation;
SELECT * FROM composant;

SELECT "Livraison des magasins";
CALL livre_magasin();
SELECT * FROM stock;

