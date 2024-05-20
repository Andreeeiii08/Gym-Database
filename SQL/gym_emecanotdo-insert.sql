/**Como placeholder, creamos cosas TEMPORALES en las otras tablas para asegurarnos que las máquinas van**/

/*CSV de les zones*/
LOAD DATA LOCAL INFILE '/home/usuari/GitHub/Gym-Database/csv/zones.csv'
INTO TABLE Zones FIELDS TERMINATED BY '\t'
IGNORE 1 LINES
(Zona_instalacio, Descripcio);

LOAD DATA LOCAL INFILE '/home/usuari/GitHub/Gym-Database/csv/espais.csv'
INTO TABLE Zones FIELDS TERMINATED BY '\t'
IGNORE 1 LINES
();

/*LOAD DATA LOCAL INFILE '/home/usuari/GitHub/Gym-Database/csv/BORRADOR_TEMPORAL_maquines.csv'
INTO TABLE Maquines_gimnas FIELDS TERMINATED BY '\t'
IGNORE 1 LINES
(Id_espai, Nom_maquina, Estat, Pes_maquina, Pes_max, Pes_min, Quantitat_maquina);*/

LOAD DATA LOCAL INFILE '/home/usuari/GitHub/Gym-Database/csv/clients.csv'
INTO TABLE Clients
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
IGNORE 1 LINES
(DNI);

UPDATE Clients
SET Entrenador_assignat = (
    SELECT Id_entrenador
    FROM Entrenadors_personals
    WHERE Id_entrenador = '4'
)
WHERE DNI = 'Z6650879C';


LOAD DATA LOCAL INFILE '/home/usuari/GitHub/Gym-Database/csv/clients.csv'
INTO TABLE Matricula
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
IGNORE 1 LINES
(DNI, Nom, Cognoms, Correu, Tlf, Adreça, Data_naixement, NºBanc);

UPDATE Matricula SET Preu_matricula = 80.00;
UPDATE Matricula SET Preu_mensual = 32.98;

/*https://stackoverflow.com/questions/34281905/how-do-you-update-an-existing-date-to-a-random-date-in-a-range*/
UPDATE Matricula
SET Data_alta = DATE_ADD('2022-01-01', INTERVAL RAND() * (DATEDIFF(CURRENT_DATE(), '2022-01-01')) DAY);

LOAD DATA LOCAL INFILE '/home/usuari/GitHub/Gym-Database/csv/treballadors.csv'
INTO TABLE Treballadors
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
IGNORE 1 LINES
(DNI_treballador, Nom, Cognom, Correu, Tlf, @dummy, Data_naixement);

UPDATE Treballadors
SET Salari = ROUND(1000 + (RAND() * (1440 - 1000)), 2);

INSERT INTO Monitors (DNI_treballador, Rol)
SELECT DNI_treballador, NULL AS Rol
FROM Treballadors
LIMIT 22;

INSERT INTO Entrenadors_personals (DNI_treballador, Descripcio)
SELECT DNI_treballador, NULL AS Descripcio
FROM Treballadors
WHERE DNI_treballador NOT IN (SELECT DNI_treballador FROM Monitors);

/*Assigno el entrenadors a les zones de manera manual yo mateix.*/
INSERT INTO Treballadors_Zones (Id_zona, DNI_treballador)
VALUES
    (1, '05514189P'),
    (2, '06090311A'),
    (3, '07219390N'),
    (4, '07875785X'),
    (5, '08176925B'),
    (6, '28816250X'),
    (1, '30105661H'),
    (2, '31751799T'),
    (3, '33585098S'),
    (4, '35597917N'),
    (5, '36612536D'),
    (6, '36908345S'),
    (1, '49354886Z'),
    (2, '49790137J'),
    (3, '52696384A'),
    (4, '67874490H'),
    (5, '68324689S'),
    (6, '77564026E'),
    (1, '77753405L'),
    (2, '78571815C'),
    (3, '81311320H'),
    (4, '82677449Q');



