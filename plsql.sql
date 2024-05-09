-- Creation des tables


-- Creation de table la table Personnel
CREATE TABLE Personnel(
    personnelId INT,
    nom VARCHAR2(40) NOT NUll,
    dateNaissance DATE NOT NULL,
    dateEmbauche DATE NOT NULL,
    typePersonnel VARCHAR2(15) NOT NULL,
    salaire DECIMAL(10,2) NOT NULL,
    commission NUMBER(2,2)NOT NULL,
    sexe CHAR(1),
    telephone VARCHAR2(15) UNIQUE
);

-- Creation de table la table estination
CREATE TABLE Destination(
    destinationId INT,
    ville VARCHAR2(100) NOT NULL,
    pays VARCHAR2(80) NOT NULL,
    distance NUMBER(9,2) NOT NULL
);

-- Creation de table la table Compagnie
CREATE TABLE Compagnie(
    compagnieId INT,
    nom VARCHAR2(30) NOT NULL,
    sigle VARCHAR2(15) NOT NULL
);

-- Creation de table la table Avion
CREATE TABLE Avion (
    avionId INT,
    compagnieId INT,
    nomAv VARCHAR2(30) NOT NULL,
    vitesse NUMBER(3,2) NOT NULL,
    capacite INT NOT NULL,
    typeAv VARCHAR2(15) NOT NULL
);

-- Creation de table la table Vol
CREATE TABLE Vol (
    volId INT,
    avionId INT,
    destinationId INT,
    dateDepart DATE NOT NULL
);

-- Creation de table la table Reservation
CREATE TABLE Reservation(
    reservationId INT,
    volId INT,
    nom VARCHAR2(40) NOT NULL,
    prix NUMBER(7,2) NOT NULL,
    reduction NUMBER(4,2)
);

-- Creation de table la table Equipage
CREATE TABLE Equipage(
    volId INT,
    personnelId INT
);


-- Ajout des contraintes check

-- Dans la table Personnel
ALTER TABLE Personnel ADD CONSTRAINT ck_dateEmbauche CHECK(dateEmbauche > dateNaissance);
ALTER TABLE Personnel ADD CONSTRAINT ck_typePersonnel CHECK(typePersonnel IN ('pilote', 'mecanicien', 'electricien', 'hotesse'));
ALTER TABLE Personnel ADD CONSTRAINT ck_salaire CHECK(salaire BETWEEN 20000 AND 50000);
ALTER TABLE Personnel ADD CONSTRAINT ck_commission CHECK(commission < (0.20 * salaire));
ALTER TABLE Personnel ADD CONSTRAINT ck_sexe CHECK(sexe IN('M', 'F'));

-- Dans la table Avion
ALTER TABLE Avion ADD CONSTRAINT ck_typeAv CHECK(typeAv IN('caravelle', 'concorde', 'A300'));

-- Ajout des contraintes de cles primaires et étrangères

-- Dans la table Personnel
ALTER TABLE Personnel ADD CONSTRAINT pk_Personnel PRIMARY KEY(personnelId);

-- Dans la table Destination
ALTER TABLE Destination ADD CONSTRAINT pk_Destination PRIMARY KEY(destinationId);

-- Dans la table Compagnie
ALTER TABLE Compagnie ADD CONSTRAINT pk_Compagnie PRIMARY KEY(compagnieId);

-- Dans la table Avion
ALTER TABLE Avion ADD CONSTRAINT pk_Avion PRIMARY KEY(avionId);
ALTER TABLE Avion ADD CONSTRAINT fk_Avion_compagnieId FOREIGN KEY(compagnieId) REFERENCES Compagnie(compagnieId);

-- Dans la table Vol
ALTER TABLE Vol ADD CONSTRAINT pk_Vol PRIMARY KEY(volId);
ALTER TABLE Vol ADD CONSTRAINT fk_Vol_avionId FOREIGN KEY(avionId) REFERENCES Avion(avionId);
ALTER TABLE Vol ADD CONSTRAINT fk_Vol_destinationId FOREIGN KEY(destinationId) REFERENCES Destination(destinationId);

-- Dans la table Reservation
ALTER TABLE Reservation ADD CONSTRAINT pk_Reservation PRIMARY KEY(reservationId);
ALTER TABLE Reservation ADD CONSTRAINT fk_Reservation_volId FOREIGN KEY(volId) REFERENCES Vol(volId);

-- Dans la table Equipage
ALTER TABLE Equipage ADD CONSTRAINT pk_Equipage PRIMARY KEY(volId, personnelId);
ALTER TABLE Equipage ADD CONSTRAINT fk_Equipage_volId FOREIGN KEY(volId) REFERENCES Vol(volId);
ALTER TABLE Equipage ADD CONSTRAINT fk_Equipage_personnelId FOREIGN KEY(personnelId) REFERENCES Personnel(personnelId);


-- PARTIE 1 : DEFINITION DE DONNEES

-- 2. Ecrivons les commandes SQL permettant de commenter la table PERSONNEL ainsi que ses colonnes.
COMMENT ON TABLE Personnel IS 'Table of Personnel';
COMMENT ON COLUMN Personnel.personnelId IS 'Column personnelId of table Personnel';
COMMENT ON COLUMN Personnel.nom IS 'Column nom of table Personnel';
COMMENT ON COLUMN Personnel.dateNaissance IS 'Column dateNaissance of table Personnel';
COMMENT ON COLUMN Personnel.dateEmbauche IS 'Column dateEmbauche of table Personnel';
COMMENT ON COLUMN Personnel.typePersonnel IS 'Column typePersonnel of table Personnel';
COMMENT ON COLUMN Personnel.salaire IS 'Column salaire of table Personnel';
COMMENT ON COLUMN Personnel.commission IS 'Column commission of table Personnel';
COMMENT ON COLUMN Personnel.sexe IS 'Column sexe of table Personnel';
COMMENT ON COLUMN Personnel.telephone IS 'Column telephone of table Personnel';

-- 3. Ecrivons permettant de modifier certains types de données précédemment définis Vitesse devient number(6) , Nom devient char(10)
ALTER TABLE Avion MODIFY vitesse NUMBER(6);
ALTER TABLE Personnel MODIFY nom CHAR(10);

-- 4. Peut-on changer un type en diminuant sa taille ?
/* Reponse :
    Oui, on peut changer un type en diminuant sa taille puisqu'il n'y a pas d'enregistrements de données dans les tables.
    Cela simplifie les choses, mais dans le cas contraire, on aurait des pertes de données si la taille des données
    précédemment enregistrées est supérieure à la nouvelle taille.
*/

-- 5. Ecrivez les commandes permettant de suppression des contraintes clés primaires et étrangères
-- Les contraintes clés étrangères
ALTER TABLE Equipage DROP CONSTRAINT fk_Equipage_volId;
ALTER TABLE Equipage DROP CONSTRAINT fk_Equipage_personnelId;
ALTER TABLE Reservation DROP CONSTRAINT fk_Reservation_volId;
ALTER TABLE Vol DROP CONSTRAINT fk_Vol_avionId;
ALTER TABLE Vol DROP CONSTRAINT fk_Vol_destinationId;
ALTER TABLE Avion DROP CONSTRAINT fk_Avion_compagnieId;


-- Les contraintes clés primaires
ALTER TABLE Equipage DROP CONSTRAINT pk_Equipage;
ALTER TABLE Reservation DROP CONSTRAINT pk_Reservation;
ALTER TABLE Vol DROP CONSTRAINT pk_Vol;
ALTER TABLE Avion DROP CONSTRAINT pk_Avion;
ALTER TABLE Compagnie DROP CONSTRAINT pk_Compagnie;
ALTER TABLE Destination DROP CONSTRAINT pk_Destination;
ALTER TABLE Personnel DROP CONSTRAINT pk_Personnel;

-- 6. Ecrivez les commandes permettant de remettre en place les contraintes clés primaires et étrangères sans recréer les tables
-- Dans la table Personnel
ALTER TABLE Personnel ADD CONSTRAINT pk_Personnel PRIMARY KEY(personnelId);

-- Dans la table Destination
ALTER TABLE Destination ADD CONSTRAINT pk_Destination PRIMARY KEY(destinationId);

-- Dans la table Compagnie
ALTER TABLE Compagnie ADD CONSTRAINT pk_Compagnie PRIMARY KEY(compagnieId);

-- Dans la table Avion
ALTER TABLE Avion ADD CONSTRAINT pk_Avion PRIMARY KEY(avionId);
ALTER TABLE Avion ADD CONSTRAINT fk_Avion_compagnieId FOREIGN KEY(compagnieId) REFERENCES Compagnie(compagnieId);

-- Dans la table Vol
ALTER TABLE Vol ADD CONSTRAINT pk_Vol PRIMARY KEY(volId);
ALTER TABLE Vol ADD CONSTRAINT fk_Vol_avionId FOREIGN KEY(avionId) REFERENCES Avion(avionId);
ALTER TABLE Vol ADD CONSTRAINT fk_Vol_destinationId FOREIGN KEY(destinationId) REFERENCES Destination(destinationId);

-- Dans la table Reservation
ALTER TABLE Reservation ADD CONSTRAINT pk_Reservation PRIMARY KEY(reservationId);
ALTER TABLE Reservation ADD CONSTRAINT fk_Reservation_volId FOREIGN KEY(volId) REFERENCES Vol(volId);

-- Dans la table Equipage
ALTER TABLE Equipage ADD CONSTRAINT pk_Equipage PRIMARY KEY(volId, personnelId);
ALTER TABLE Equipage ADD CONSTRAINT fk_Equipage_volId FOREIGN KEY(volId) REFERENCES Vol(volId);
ALTER TABLE Equipage ADD CONSTRAINT fk_Equipage_personnelId FOREIGN KEY(personnelId) REFERENCES Personnel(personnelId);

-- 7. Ecrivez les commandes permettant de supprimer la colonne téléphone de la table personnel
ALTER TABLE Personnel DROP COLUMN telephone;


-- PARTIE 2 : MANIPULATION DE DONNEES

-- 1. Insérer un jeu de données cohérent dans vos relations

-- Dans la table Personnel
INSERT INTO Personnel VALUES(1, 'Jaures PIERRE', TO_DATE('1980-05-15','YYYY-MM-DD'), TO_DATE('2005-10-20','YYYY-MM-DD'), 'pilote', 45000.00, 0.15, 'M');
INSERT INTO Personnel VALUES(2, 'Marie JEAN LOUIS', TO_DATE('1985-09-28','YYYY-MM-DD'), TO_DATE('2010-03-12','YYYY-MM-DD'), 'hotesse', 30000.00, 0.10, 'F');
INSERT INTO Personnel VALUES(3, 'Bertho DAVILUS', TO_DATE('1976-02-10','YYYY-MM-DD'), TO_DATE('2000-12-05','YYYY-MM-DD'), 'mecanicien', 38000.00, 0.12, 'M');
INSERT INTO Personnel VALUES(4, 'Sophie JOSEPH', TO_DATE('1990-11-20','YYYY-MM-DD'), TO_DATE('2018-06-15','YYYY-MM-DD'), 'electricien', 32000.00, 0.08, 'F');
INSERT INTO Personnel VALUES(5, 'Thomas LORWENS', TO_DATE('1982-07-03','YYYY-MM-DD'), TO_DATE('2006-09-08','YYYY-MM-DD'), 'pilote', 48000.00, 0.14, 'M');
INSERT INTO Personnel VALUES(6, 'Stephania CHERY', TO_DATE('1988-04-18','YYYY-MM-DD'), TO_DATE('2015-11-22','YYYY-MM-DD'), 'hotesse', 31000.00, 0.09, 'F');
INSERT INTO Personnel VALUES(7, 'Wilvens JEAN', TO_DATE('1975-12-30','YYYY-MM-DD'), TO_DATE('2002-08-17','YYYY-MM-DD'), 'mecanicien', 37000.00, 0.11, 'M');
INSERT INTO Personnel VALUES(8, 'Lyncold S CHERY', TO_DATE('1995-08-25','YYYY-MM-DD'), TO_DATE('2020-04-30','YYYY-MM-DD'), 'electricien', 33000.00, 0.07, 'F');
INSERT INTO Personnel VALUES(9, 'Gabens PIERRE', TO_DATE('1987-03-08','YYYY-MM-DD'), TO_DATE('2012-07-10','YYYY-MM-DD'), 'pilote', 46000.00, 0.13, 'M');
INSERT INTO Personnel VALUES(10, 'Tamara OXIL', TO_DATE('1993-06-12','YYYY-MM-DD'), TO_DATE('2017-02-18','YYYY-MM-DD'), 'hotesse', 32000.00, 0.08, 'F');
COMMIT;

-- Dans la table Destination
INSERT INTO Destination VALUES (1, 'Paris', 'France', 12658);
INSERT INTO Destination VALUES(2, 'New York City', 'USA', 5839);
INSERT INTO Destination VALUES(3, 'Dubai', 'Émirats arabes unis', 5515);
INSERT INTO Destination VALUES(4, 'Tokyo', 'Japon', 9713);
INSERT INTO Destination VALUES(5, 'Londres', 'Royaume-Uni', 3347);
INSERT INTO Destination VALUES(6, 'Los Angeles', 'USA', 9041);
INSERT INTO Destination VALUES(7, 'Sydney', 'Australie', 10538);
INSERT INTO Destination VALUES(8, 'Hong Kong', 'Chine', 9331);
INSERT INTO Destination VALUES(9, 'Lima', 'Perou', 6723);
INSERT INTO Destination VALUES(10, 'Rome', 'Italie', 671);
COMMIT;

-- Dans la table Compagnie
INSERT INTO Compagnie VALUES(1, 'Air France', 'AF');
INSERT INTO Compagnie VALUES(2, 'Lufthansa', 'LH');
INSERT INTO Compagnie VALUES(3, 'Emirates', 'EK');
INSERT INTO Compagnie VALUES(4, 'Delta Air Lines', 'DL');
INSERT INTO Compagnie VALUES(5, 'British Airways', 'BA');
INSERT INTO Compagnie VALUES(6, 'American Airlines', 'AA');
INSERT INTO Compagnie VALUES(7, 'Singapore Airlines', 'SQ');
INSERT INTO Compagnie VALUES(8, 'Qantas', 'QF');
INSERT INTO Compagnie VALUES(9, 'Cathay Pacific', 'CX');
INSERT INTO Compagnie VALUES(10, 'Etihad Airways', 'EY');
COMMIT;

-- Dans la table Avion
INSERT INTO Avion VALUES(1, 1, 'Boeing 747', 0.85, 416, 'caravelle');
INSERT INTO Avion VALUES(2, 2, 'Airbus A380', 0.89, 555, 'concorde');
INSERT INTO Avion VALUES(3, 3, 'Boeing 777', 0.84, 396, 'A300');
INSERT INTO Avion VALUES(4, 4, 'Airbus A320', 0.82, 186, 'caravelle');
INSERT INTO Avion VALUES(5, 5, 'Boeing 787', 0.85, 242, 'A300');
INSERT INTO Avion VALUES(6, 6, 'Airbus A330', 0.86, 277, 'concorde');
INSERT INTO Avion VALUES(7, 7, 'Airbus A350', 0.87, 440, 'caravelle');
INSERT INTO Avion VALUES(8, 8, 'Boeing 737', 0.81, 215, 'concorde');
INSERT INTO Avion VALUES(9, 9, 'Airbus A319', 0.80, 124, 'A300');
INSERT INTO Avion VALUES(10, 10, 'Boeing 767', 0.83, 375, 'A300');
COMMIT;

-- Dans la table Vol
INSERT INTO Vol VALUES(1, 1, 2, TO_DATE('2024-05-10','YYYY-MM-DD')); 
INSERT INTO Vol VALUES(2, 2, 5, TO_DATE('2024-05-12','YYYY-MM-DD'));
INSERT INTO Vol VALUES(3, 3, 7, TO_DATE('2024-05-15','YYYY-MM-DD'));
INSERT INTO Vol VALUES(4, 4, 3, TO_DATE('2024-05-17','YYYY-MM-DD'));
INSERT INTO Vol VALUES(5, 5, 8, TO_DATE('2024-05-20','YYYY-MM-DD'));
INSERT INTO Vol VALUES(6, 6, 4, TO_DATE('2024-05-22','YYYY-MM-DD'));
INSERT INTO Vol VALUES(7, 7, 9, TO_DATE('2024-05-25','YYYY-MM-DD'));
INSERT INTO Vol VALUES(8, 8, 6, TO_DATE('2024-05-27','YYYY-MM-DD'));
INSERT INTO Vol VALUES(9, 9, 10, TO_DATE('2024-05-30','YYYY-MM-DD'));
INSERT INTO Vol VALUES(10, 10, 1, TO_DATE('2024-06-02','YYYY-MM-DD'));
COMMIT;

-- Dans la table Reservation
INSERT INTO Reservation VALUES(1, 1, 'Jaures PIERRE', 800.00, 0.05);
INSERT INTO Reservation VALUES(2, 2, 'Marie JEAN LOUIS', 900.00, 0.07);
INSERT INTO Reservation VALUES(3, 3, 'Bertho DAVILUS', 1200.00, 0.10);
INSERT INTO Reservation VALUES(4, 4, 'Sophie JOSEPH', 1000.00, 0.06);
INSERT INTO Reservation VALUES(5, 5, 'homas LORWENS', 850.00, 0.04);
INSERT INTO Reservation VALUES(6, 6, 'Stephania CHERY', 1100.00, 0.08);
INSERT INTO Reservation VALUES(7, 7, 'Wilvens JEAN', 950.00, 0.05);
INSERT INTO Reservation VALUES(8, 8, 'Lyncold S CHERY', 1050.00, 0.07);
INSERT INTO Reservation VALUES(9, 9, 'Gabens PIERRE', 875.00, 0.03);
INSERT INTO Reservation VALUES(10, 10, 'Tamara OXIL', 920.00, 0.06);
COMMIT;

-- Dans la table Equipage
INSERT INTO Equipage VALUES(1, 1);
INSERT INTO Equipage VALUES(1, 2);
INSERT INTO Equipage VALUES(2, 3);
INSERT INTO Equipage VALUES(2, 4);
INSERT INTO Equipage VALUES(3, 5);
INSERT INTO Equipage VALUES(3, 6);
INSERT INTO Equipage VALUES(4, 7);
INSERT INTO Equipage VALUES(4, 8);
INSERT INTO Equipage VALUES(5, 9);
INSERT INTO Equipage VALUES(5, 10);
COMMIT;

-- 2. Parmi tous les vols effectués le 10 janvier 2023, donnez celui dont la moyenne d'âge de l'équipage est la plus basse.
SELECT * Vol WHERE AVG()

-- 3. Donnez le nom de toutes les compagnies possédant au moins un appareil de même type que la compagnie d'identifiant 3.

-- 4. Donnez pour chaque compagnie la liste des avions qu'elle possède, classée par ordre de capacité croissante.

-- 5. Donnez le nom du pilote ayant piloté, entre le 10 et le 13 janvier 2023, l'avion le plus rapide.

/* 6. Donnez le nom de toutes les personnes ayant une réservation sur un vol où l’employé le moins expérimenté
      (cad avec le moins d’heures de vol) participe. */

-- 7. Informations sur les employés plus âgés que 40 années

-- 8. Ecrire la requête qui affiche pour chaque employé le nom, le salaire, la commission ainsi que le gain annuel

-- 9. Donner la masse salariale du personnel par type.

/* 10. Afficher pour chaque vol le numéro de l’avion, la destination et la date du vol pour les avions qui n’ont
       effectués aucun vol, seulement leur numéro, capacité et type seront affichés
*/
-- 11. Ecrire la requête qui affiche le nom, le salaire mensuel des employés ainsi que le salaire augmenté de :

-- 15% si le salaire est >20000

-- 25% si le salaire est compris entre 15000 et 20000

-- 45% si le salaire est inférieur à 15000

/* 12. Respectant le format de chaque modèle suivant, écrivez les requêtes vous permettant d’afficher :

    • Le nom du personnel et son revenue annuel (qu’il reçoit de commission ou pas)
    Personnel a un gain annuel sur 12 mois
    -------------------- ----- ----------- --------------------
    <Nom&Prenon> gagne <salaire> par an.
    • Le nom et le prénom de l’employé et sa fonction.
    --------------------------------------------------------------
    <Nom&Prenon> est pilote de l’institution.
*/