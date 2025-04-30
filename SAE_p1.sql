//Rendu

//1. Identifier les clÃ©s Ã©trangÃ¨res dans le schÃ©ma de la base de donnÃ©es.
//Les clÃ©s Ã©trangÃ¨res sont :
//  - codeMembre : dans la table s_adhesion
//  - codeType : dans la table s_materiel
//  - idMateriel et numClub : dans la table s_stock
//  - codeMembre et numClub : dans la table s_location
//  - numLoc et idMateriel : dans la table s_detaillocation
//  - numClub : dans la table s_activite
//  - numActivite et codeMembre : dans la table s_participation

//2. [SQL] Lâ€™utilisateur Â« ensinfo Â» dispose dâ€™une copie des tables de la base.
//RÃ©cupÃ©rer ces tables et leurs donnÃ©es depuis ce compte. Ajouter les contraintes de
//clÃ©s primaires et Ã©trangÃ¨res. Consulter le contenu de chaque table. 
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

alter table s_club add primary key(numClub);
alter table s_membre add primary key(codeMembre);
alter table s_typemateriel add primary key(codeType);
alter table s_adhesion add primary key(numAdhesion);
alter table s_adhesion add foreign key(codeMembre) references s_membre(codeMembre);
alter table s_materiel add primary key(idMateriel);
alter table s_materiel add foreign key(codeType) references s_typemateriel(codeType);
alter table s_location add primary key(numLoc);
alter table s_location add foreign key(codeMembre) references s_membre(codeMembre);
alter table s_location add foreign key(numClub) references s_club(numClub);
alter table s_activite add primary key(numActivite);
alter table s_activite add foreign key(numClub) references s_club(numClub);
alter table s_stock add primary key(idMateriel, numClub);
alter table s_stock add foreign key(idMateriel) references s_materiel(idMateriel);
alter table s_stock add foreign key(numClub) references s_club(numClub);
alter table s_detaillocation add primary key(numLoc, idMateriel);
alter table s_detaillocation add foreign key(numLoc) references s_location(numLoc);
alter table s_detaillocation add foreign key(idMateriel) references s_materiel(idMateriel);
alter table s_participation add primary key(numActivite, codeMembre);
alter table s_participation add foreign key(numActivite) references s_activite(numActivite);
alter table s_participation add foreign key(codeMembre) references s_membre(codeMembre);


//3. [PL/SQL] La colonne REDUCTION de la table S_LOCATION est à NULL. Une mauvaise
//manipulation a effacé ces données. Ecrire une procédure stockée MAJ_REDUCTION
//avec un curseur de mise à jour permettant d’indiquer le montant de la réduction (0 ou
//0.10) en vérifiant que le membre avait une adhésion en cours de validité au moment
//de la location.
Create or Replace procedure reducLocation
is
    cursor estAdherent is select DATELOC, CODEMEMBRE from S_LOCATION;
    locDate DATE;
    membreC VARCHAR2(10);
    dateDeb DATE;
    dateFin DATE;
begin
    open estAdherent;
    fetch estAdherent into locDate, membreC;
    while estAdherent%FOUND LOOP
        Begin
        SELECT DATEDEBADHESION, DATEFINADHESION into dateDeb, dateFin from S_ADHESION where S_ADHESION.CODEMEMBRE = membreC AND locDate between DATEDEBADHESION AND DATEFINADHESION AND ROWNUM = 1;
            update S_LOCATION set REDUCTION = 0.1 where CODEMEMBRE = membreC and DATELOC = locDate;
        Exception
            when NO_DATA_FOUND THEN
            UPDATE S_LOCATION
            SET REDUCTION = 0
            WHERE CODEMEMBRE = membreC AND DATELOC = locDate;
        End;
        fetch estAdherent into locDate, membreC;
    END LOOP;
    close estAdherent;
end;

declare
begin
reducLocation;
end;