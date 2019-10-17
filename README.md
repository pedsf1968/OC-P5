# OC-P5
OpenClassrooms Project 5 - Concevez la solution technique d’un système de gestion de pizzeria

Pré-requis
Avoir une connaissance du fonctionnement général d’Internet et des systèmes informatiques
Savoir, dans les grandes lignes, ce qu’est une base de données et un service tiers (comme un web service par exemple). Il n'est pas nécessaire d'être capable de les mettre en œuvre.
Contexte
Vous avez déjà rencontré ce scenario si vous avez fait le projet Analysez les besoins de votre client pour son groupe de pizzerias. C'est tout à fait normal, le travail que vous allez faire maintenant est complémentaire à celui du projet précédent.

« OC Pizza » est un jeune groupe de pizzeria en plein essor et spécialisé dans les pizzas livrées ou à emporter. Il compte déjà 5 points de vente et prévoit d’en ouvrir au moins 3 de plus d’ici la fin de l’année. Un des responsables du groupe a pris contact avec vous afin de mettre en place un système informatique, déployé dans toutes ses pizzerias et qui lui permettrait notamment :

d’être plus efficace dans la gestion des commandes, de leur réception à leur livraison en passant par leur préparation ;
de suivre en temps réel les commandes passées et en préparation ;
de suivre en temps réel le stock d’ingrédients restants pour savoir quelles pizzas sont encore réalisables ;
de proposer un site Internet pour que les clients puissent :
passer leurs commandes, en plus de la prise de commande par téléphone ou sur place
payer en ligne leur commande s’ils le souhaitent – sinon, ils paieront directement à la livraison
modifier ou annuler leur commande tant que celle-ci n’a pas été préparée
de proposer un aide mémoire aux pizzaiolos indiquant la recette de chaque pizza
d’informer ou notifier les clients sur l’état de leur commande
Le client a déjà fait une petite prospection et les logiciels existants qu’il a pu trouver ne lui conviennent pas.

Dans votre proposition de solution, vous partirez du principe que vous disposez dans votre société de toutes les ressources et compétences nécessaires à la réalisation du projet.

Travail demandé
En tant qu’analyste-programmeur, votre travail consiste, à ce stade, à définir le domaine fonctionnel et à concevoir l’architecture technique de la solution répondant aux besoins du client, c’est-à-dire :

modéliser les objets du domaine fonctionnel
identifier les différents éléments composant le système à mettre en place et leurs interactions
décrire le déploiement des différents composants que vous envisagez
élaborer le schéma de la ou des bases de données que vous comptez créer
Votre travail sera validé par un des développeurs expérimentés de votre société (ce rôle est assuré par le mentor qui vous fera passer la soutenance du projet).

Vous utiliserez UML pour réaliser cette conception.

Livrables attendus
Un document (format PDF) de spécifications techniques comprenant :
une description du domaine fonctionnel
les différents composants du système et les composants externes utilisés par celui-ci et leur interaction
la description de l’organisation physique de ces composants (déploiement)
Le modèle physique de données (MPD) ou modèle relationnel de la base de données au format PDF ou image (PNG)
Base de données MySQL ou PostgreSQL avec un jeu de données de démo :
un fichier ZIP contenant un dump de votre base de données
un fichier ZIP contenant l’ensemble des scripts SQL de création de la base de données et du jeu de données de démo
 

**Création de la base de données sous MySQL**
source ocpcreatedb.sql;

-- génération des procédures
source ocpcreateprocedure.sql;

-- génération des fonctions
source ocpcreatefunction.sql;

-- génération des requêtes
source ocpcreaterequete.sql;

-- remplissage de la base
source ocpfilldb.sql;

-- exécution de commande
source ocp.sql;

