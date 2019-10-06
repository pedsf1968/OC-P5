################################################################################
# OC PIZZA                                                      CREATE PREPARE #
################################################################################

PREPARE s_all_fournisseur
FROM 'SELECT id,nom,telephone,email,adresse.numero,adresse.voie FROM fournisseur ';