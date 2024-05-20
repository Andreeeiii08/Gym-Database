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
(DNI_treballador, Nom, Cognom, Correu, Tlf, @dummy, Data_naixement, Estudis);

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

UPDATE Entrenadors_personals
SET Descripcio = 'Geraldine Adams Cash - Entrenador de Entrenamiento en Escalada: Elvis es un experto en entrenamiento en escalada, tanto en interiores como en exteriores. Con un profundo conocimiento en técnicas de escalada, fuerza de agarre y entrenamiento de potencia, guía a sus clientes a través de sesiones de escalada seguras y efectivas que mejoran la fuerza, la coordinación y la confianza en sí mismos.'
WHERE DNI_treballador = '84605514Z';

UPDATE Entrenadors_personals
SET Descripcio = 'Vincent Bean Cooke - Masajista Terapéutico Especializado: Vincent, conocido como Rama, es un masajista terapéutico especializado con experiencia en técnicas de masaje deportivo y rehabilitación. Su habilidad para aliviar la tensión muscular y mejorar la circulación sanguínea lo convierte en un recurso invaluable para aquellos que buscan alivio del dolor y una recuperación más rápida.'
WHERE DNI_treballador = '86989486J';

UPDATE Entrenadors_personals
SET Descripcio = 'Kitra Nguyen Chang - Entrenador de Entrenamiento en Circuito: Kitra es un especialista en entrenamiento en circuito con experiencia en diseño de programas de entrenamiento eficientes y efectivos. Su enfoque en la variedad, la intensidad y el trabajo en grupo lo convierte en un recurso invaluable para aquellos que buscan resultados rápidos y variados en su rutina de ejercicios.'
WHERE DNI_treballador = '87250359C';

UPDATE Entrenadors_personals
SET Descripcio = 'Wade Davis Velazquez - Entrenador de Entrenamiento de Fuerza: Wade, conocido como Vincent, es un experto en entrenamiento de fuerza y acondicionamiento físico. Con su enfoque en el levantamiento de pesas, la periodización y la progresión del entrenamiento, ayuda a sus clientes a desarrollar fuerza, potencia y resistencia muscular para mejorar su rendimiento atlético y su salud general.'
WHERE DNI_treballador = '91354962C';

UPDATE Entrenadors_personals
SET Descripcio = 'Xenos Rodgers Delacruz - Coach de Mentalidad y Motivación: Xenos es un coach de mentalidad y motivación que ayuda a sus clientes a superar barreras mentales y alcanzar su máximo potencial. Con su enfoque en el pensamiento positivo, la visualización y el establecimiento de metas, les enseña herramientas y estrategias para cultivar una mentalidad fuerte y resiliente.'
WHERE DNI_treballador = '92348206D';

UPDATE Entrenadors_personals
SET Descripcio = 'Elvis Randolph Howard - Especialista en Entrenamiento de Resistencia: Elvis, también conocido como Iliana, es una entrenadora experimentada en el ámbito de la resistencia y la fuerza. Con un enfoque en el levantamiento de pesas y el entrenamiento de fuerza, ayuda a sus clientes a alcanzar niveles óptimos de fuerza y acondicionamiento físico.'
WHERE DNI_treballador = '95379746B';

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



