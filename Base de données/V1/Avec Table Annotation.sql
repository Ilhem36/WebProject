-- #Création du schéma de tables
-- #CREATE SCHEMA GeneDB;
SET SCHEMA 'GeneDB';
--#SET search_path TO genedb; --#pcq mon postgres bugue

-- #Création des types : TypeRole et Etat Annotation
CREATE TYPE TypeRole AS ENUM ('lecteur', 'annotateur', 'validateur');
CREATE TYPE TypeAnnot AS ENUM ('non annoté', 'non validé', 'annoté et validé');

-- #Création de la relation Utilisateur
CREATE TABLE Utilisateur (
Email VARCHAR(500),
Mdp VARCHAR(500),
Nom VARCHAR(500),
Prenom VARCHAR(500),
NumTel VARCHAR(20),
Role TypeRole,
Date Date,
Heure VARCHAR(10),
PRIMARY KEY (Email, Mdp));

CREATE TABLE Annotation (
EmailAnnot VARCHAR(500),
EtatAnnot TypeAnnot,
Commentaires VARCHAR(500),
PRIMARY KEY(EmailAnnot, EtatAnnot, Commentaires));
--#EmailAnnot != Email, faire une jointure des deux attributs dans les requêtes pour avoir la liste des mails des annotateurs ?
--#Faire une clé étrangère sur emailannot ref Email ne marche pas  
--Table annotation pour pas avoir trop de clés primaires dans Utilisateur ? 

-- #Création de la relation Génome
CREATE TABLE Genome (
NomGenome VARCHAR(500),
SeqNucl VARCHAR(500),
Espece VARCHAR(500),
EmailAnnot VARCHAR(500),
EtatAnnot TypeAnnot,
Commentaires VARCHAR(500),
PRIMARY KEY (NomGenome, EmailAnnot, EtatAnnot, Commentaires),
FOREIGN KEY (EmailAnnot, EtatAnnot,Commentaires) REFERENCES Annotation(EmailAnnot, EtatAnnot, Commentaires));
--#VARCHAR(500) pour SeqNucl = pas suffisant !! Mais cb ? 

-- #Création de la relation Gènes/Protéines
CREATE TABLE Gene_Prot (
NomGenProt VARCHAR(500),
SeqGenProt VARCHAR(500),
Position VARCHAR(500),
Peptides VARCHAR(500),
EmailAnnot VARCHAR(500),
EtatAnnot TypeAnnot,
Commentaires VARCHAR(500),
PRIMARY KEY (NomGenProt, EmailAnnot, EtatAnnot, Commentaires),
FOREIGN KEY (EmailAnnot, EtatAnnot, Commentaires) REFERENCES Annotation(EmailAnnot, EtatAnnot, Commentaires));
