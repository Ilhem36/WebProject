-- #Création du schéma de tables
-- #CREATE SCHEMA GeneDB;
SET SCHEMA 'GeneDB';

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
EtatAnnot TypeAnnot,
Commentaires VARCHAR(500),
PRIMARY KEY (Email, Mdp));

-- #Création de la relation Génome
CREATE TABLE Genome (
NomGenome VARCHAR(500),
SeqNucl VARCHAR(500),
Espece VARCHAR(500),
EtatAnnot TypeAnnot,
EmailAnnot VARCHAR(500),
Commentaires VARCHAR(500),
PRIMARY KEY (NomGenome),
FOREIGN KEY (EtatAnnot) REFERENCES Utilisateur(EtatAnnot),
FOREIGN KEY (EmailAnnot) REFERENCES Utilisateur(Email),
FOREIGN KEY (Commentaires) REFERENCES Utilisateur(Commentaires));

-- #Création de la relation Gènes/Protéines
CREATE TABLE Gene_Prot (
NomGenProt VARCHAR(500),
SeqGenProt VARCHAR(500),
Position VARCHAR(500),
Peptides VARCHAR(500),
EtatAnnot TypeAnnot,
EmailAnnot VARCHAR(500),
PRIMARY KEY (NomGenProt),
FOREIGN KEY (EtatAnnot) REFERENCES Utilisateur(EtatAnnot),
FOREIGN KEY (EmailAnnot) REFERENCES Utilisateur(Email));
