//Rendu

//1. Identifier les clés étrangères dans le schéma de la base de données.
//Les clés étrangères sont :
//  - codeMembre : dans la table s_adhesion
//  - codeType : dans la table s_materiel
//  - idMateriel et numClub : dans la table s_stock
//  - codeMembre et numClub : dans la table s_location
//  - numLoc et idMateriel : dans la table s_detaillocation
//  - numClub : dans la table s_activite
//  - numActivite et codeMembre : dans la table s_participation

//2. [SQL] L’utilisateur « ensinfo » dispose d’une copie des tables de la base.
//Récupérer ces tables et leurs données depuis ce compte. Ajouter les contraintes de
//clés primaires et étrangères. Consulter le contenu de chaque table. 
create table s_club as
select * from ensinfo.S_CLUB;
create table s_membre as
select * from ensinfo.S_MEMBRE;
create table s_adhesion as
select * from ensinfo.S_ADHESION;
create table s_typemateriel as
select * from ensinfo.S_TYPEMATERIEL;
create table s_materiel as
select * from ensinfo.S_MATERIEL;
create table s_stock as
select * from ensinfo.S_STOCK;
create table s_location as
select * from ensinfo.S_LOCATION;
create table s_detaillocation as
select * from ensinfo.S_DETAILLOCATION;
create table s_activite as
select * from ensinfo.S_ACTIVITE;
create table s_participation as
select * from ensinfo.S_PARTICIPATION;