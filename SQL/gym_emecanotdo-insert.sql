/*CSV de les zones*/
LOAD DATA LOCAL INFILE '/home/usuari/GitHub/Gym-Database/csv/zones.csv'
INTO TABLE Zones FIELDS TERMINATED BY '\t'
IGNORE 1 LINES
(Zona_instalacio, Descripcio);

/*Carreguem les dades de la taula d'espais. De moment, no carreguem les imatges ja que es farà a final de tot.*/
LOAD DATA LOCAL INFILE '/home/usuari/GitHub/Gym-Database/csv/espais.csv'
INTO TABLE Espais FIELDS TERMINATED BY '\t'
IGNORE 1 LINES
(Id_zona, Superficie, Dutxes, Taquilles, Expendedores, Font_aigua, Pantalles, Altaveus, Miralls, Descripcio);

/*Carregant les dades dels clients; només els DNI perquè després assignem els entrenadors manualment amb un insert. Més informació està en la taula "Matricula".*/
LOAD DATA LOCAL INFILE '/home/usuari/GitHub/Gym-Database/csv/clients.csv'
INTO TABLE Clients
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
IGNORE 1 LINES
(DNI);

/*Carreguem les dades de matrícula a on hi ha més informació.*/
LOAD DATA LOCAL INFILE '/home/usuari/GitHub/Gym-Database/csv/clients.csv'
INTO TABLE Matricula
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
IGNORE 1 LINES
(DNI, Nom, Cognoms, Correu, Tlf, Adreça, Data_naixement, NºBanc);

/*Actualitzem el preu de matrícula i el preu mensual.*/
UPDATE Matricula SET Preu_matricula = 80.00;
UPDATE Matricula SET Preu_mensual = 32.98;

/*Per fer això, hem consultat aquesta pàgina web per aleatoritzar les dades: https://stackoverflow.com/questions/34281905/how-do-you-update-an-existing-date-to-a-random-date-in-a-range*/
UPDATE Matricula
SET Data_alta = DATE_ADD('2022-01-01', INTERVAL RAND() * (DATEDIFF(CURRENT_DATE(), '2022-01-01')) DAY);

/*Carreguem les dades dels treballadors.*/
LOAD DATA LOCAL INFILE '/home/usuari/GitHub/Gym-Database/csv/treballadors.csv'
INTO TABLE Treballadors
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
IGNORE 1 LINES
(DNI_treballador, Nom, Cognom, Correu, Tlf, @dummy, Data_naixement, Estudis);

/*Establim el salari dels treballadors a l'atzar.*/
UPDATE Treballadors
SET Salari = ROUND(1000 + (RAND() * (1440 - 1000)), 2);

/*Insertem 22 treballadors com a monitors mitjançant el DNI.*/
INSERT INTO Monitors (DNI_treballador, Rol)
SELECT DNI_treballador, NULL AS Rol
FROM Treballadors
LIMIT 22;

/*Fem inserts manuals sobre cada cosa que ha de fer el monitor en el gimnàs.*/
UPDATE Monitors
SET Rol = 'Fa control dels vestuaris del gimnàs.'
WHERE DNI_treballador = '05514189P';

UPDATE Monitors
SET Rol = 'Fa control dels vestuaris del gimnàs.'
WHERE DNI_treballador = '30105661H';

UPDATE Monitors
SET Rol = 'Fa control dels vestuaris del gimnàs.'
WHERE DNI_treballador = '49354886Z';

UPDATE Monitors
SET Rol = 'Fa control dels vestuaris del gimnàs.'
WHERE DNI_treballador = '77753405L';

UPDATE Monitors
SET Rol = 'Vigila les saunes.'
WHERE DNI_treballador = '06090311A';

UPDATE Monitors
SET Rol = 'Vigila les saunes.'
WHERE DNI_treballador = '31751799T';

UPDATE Monitors
SET Rol = 'Vigila les saunes.'
WHERE DNI_treballador = '49790137J';

UPDATE Monitors
SET Rol = 'Vigila les saunes.'
WHERE DNI_treballador = '78571815C';

UPDATE Monitors
SET Rol = 'Fa classes en el solàrium.'
WHERE DNI_treballador = '07219390N';

UPDATE Monitors
SET Rol = 'Fa classes en el solàrium.'
WHERE DNI_treballador = '33585098S';

UPDATE Monitors
SET Rol = 'Fa classes en el solàrium.'
WHERE DNI_treballador = '81311320H';

UPDATE Monitors
SET Rol = 'Fa classes en el solàrium.'
WHERE DNI_treballador = '52696384A';

UPDATE Monitors
SET Rol = 'Vigila la securetat en les piscines'
WHERE DNI_treballador = '07875785X';

UPDATE Monitors
SET Rol = 'Fa classes en la piscina.'
WHERE DNI_treballador = '35597917N';

UPDATE Monitors
SET Rol = 'Fa classes en la piscina.'
WHERE DNI_treballador = '67874490H';

UPDATE Monitors
SET Rol = 'Vigila la securetat en les piscines.'
WHERE DNI_treballador = '82677449Q';

UPDATE Monitors
SET Rol = 'Vigila i fa classes en la zona entrenament.'
WHERE DNI_treballador = '08176925B';

UPDATE Monitors
SET Rol = 'Vigila i fa classes en la zona entrenament.'
WHERE DNI_treballador = '36612536D';

UPDATE Monitors
SET Rol = 'Vigila i fa classes en la zona entrenament.'
WHERE DNI_treballador = '68324689S';

UPDATE Monitors
SET Rol = 'Fa classes en les sales.'
WHERE DNI_treballador = '28816250X';

UPDATE Monitors
SET Rol = 'Fa classes en les sales.'
WHERE DNI_treballador = '36908345S';

UPDATE Monitors
SET Rol = 'Fa classes en les sales.'
WHERE DNI_treballador = '77564026E';

/*Els DNIs que no estàn en la taula de "Monitors" hi estàn en la taula de "Entrenadors_personals".*/
INSERT INTO Entrenadors_personals (DNI_treballador, Descripcio)
SELECT DNI_treballador, NULL AS Descripcio
FROM Treballadors
WHERE DNI_treballador NOT IN (SELECT DNI_treballador FROM Monitors);

/*Ens hem inventant les especialitat i descripcions de cada entrenador personal.*/
UPDATE Entrenadors_personals
SET Descripcio = 'Entrenador especialitzat en escalada, tant en interiors com en exteriors de forma segura per millorar la força i coordinació.'
WHERE DNI_treballador = '84605514Z';

UPDATE Entrenadors_personals
SET Descripcio = 'Massatgista professional que alivia la tensió muscular i millora la circulació sanguinea amb el seu treball.'
WHERE DNI_treballador = '86989486J';

UPDATE Entrenadors_personals
SET Descripcio = 'Experència en diseny de programes de rutina eficients amb resultats ràpids i efectius.'
WHERE DNI_treballador = '87250359C';

UPDATE Entrenadors_personals
SET Descripcio = 'Expert en entrenament de força i acondiconament físic que descaca en el levantament de peçes.'
WHERE DNI_treballador = '91354962C';

UPDATE Entrenadors_personals
SET Descripcio = 'Coach especialitzat en mentalitat i motivació que ajuda als clients per arribar al màxim potencia'
WHERE DNI_treballador = '92348206D';

UPDATE Entrenadors_personals
SET Descripcio = 'Especialitzada en resistència i força, amb un enfoc de levantament de força i donar volum corporal.'
WHERE DNI_treballador = '95379746B';

/*Assigno els treballadors a les zones de manera manual, només els que estàn en la taula de "Monitors".*/
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

/*Estem introduïnt les classes dirigides amb un CSV que recopila tota la informació que ens interessa tenint en compte que siguin dades amb sentit basant en les descripcions anteriors i sense repeticions.*/
LOAD DATA LOCAL INFILE '/home/usuari/GitHub/Gym-Database/csv/classes_dirigides.csv'
INTO TABLE Classes_Dirigides
FIELDS TERMINATED BY '\t'
ENCLOSED BY '"'
IGNORE 1 LINES
(Id_monitor, Id_espai, Hora_inici, Hora_final, Nom_clase, Dia, Descripcio);

/*Script aleatori per assignari als clients algunes classes.*/
INSERT INTO Client_Classe (DNI_client, Id_classe)
SELECT
    DNI,
    Id_classe
FROM
    Clients
JOIN
    Classes_Dirigides
ORDER BY
    RAND()
LIMIT 222;

/*Assignació d'entrenadors a alguns clients manualment.*/
UPDATE Clients
SET Entrenador_assignat = '6'
WHERE DNI = 'Z6650879C';

UPDATE Clients
SET Entrenador_assignat = '6'
WHERE DNI = 'Z6578685T';

UPDATE Clients
SET Entrenador_assignat = '6'
WHERE DNI = 'Y9707024A';

UPDATE Clients
SET Entrenador_assignat = '5'
WHERE DNI = 'X4482664X';

UPDATE Clients
SET Entrenador_assignat = '5'
WHERE DNI = '99776218X';

UPDATE Clients
SET Entrenador_assignat = '5'
WHERE DNI = '88428356A';

UPDATE Clients
SET Entrenador_assignat = '4'
WHERE DNI = '81221692K';

UPDATE Clients
SET Entrenador_assignat = '4'
WHERE DNI = '80482715B';

UPDATE Clients
SET Entrenador_assignat = '4'
WHERE DNI = '68391900C';

UPDATE Clients
SET Entrenador_assignat = '3'
WHERE DNI = '67711844M';

UPDATE Clients
SET Entrenador_assignat = '3'
WHERE DNI = '65725288M';

UPDATE Clients
SET Entrenador_assignat = '3'
WHERE DNI = '65099652S';

UPDATE Clients
SET Entrenador_assignat = '2'
WHERE DNI = '52901724E';

UPDATE Clients
SET Entrenador_assignat = '2'
WHERE DNI = '37590422G';

UPDATE Clients
SET Entrenador_assignat = '2'
WHERE DNI = '36452461Z';

UPDATE Clients
SET Entrenador_assignat = '1'
WHERE DNI = '23253721P';

UPDATE Clients
SET Entrenador_assignat = '1'
WHERE DNI = '01687342Q';

UPDATE Clients
SET Entrenador_assignat = '1'
WHERE DNI = '64590852K';

/*En aquesta carrega de dades i la següent, estem afegint les dades de les màquines del gimnàs a partir d'un mateix CSV seleccionant les dades que ens interessen per a cada taula.*/
LOAD DATA LOCAL INFILE '/home/usuari/GitHub/Gym-Database/csv/maquines.csv'
INTO TABLE Maquina_estacions FIELDS TERMINATED BY '\t'
IGNORE 1 LINES
(Id_Maquina, Id_espai, @dummy, Estat);

LOAD DATA LOCAL INFILE '/home/usuari/GitHub/Gym-Database/csv/maquines.csv'
INTO TABLE Tipus_maquina_estacions FIELDS TERMINATED BY '\t'
IGNORE 1 LINES
(Id_Maquina, @dummy, tipus, @dummy, Pes_maquina, Pes_max, Pes_min);

/*A continuació, explicarem com carregar imatges longblob en SQL.*/

/*Carrega de imatges en el MySQL - va al final del gym_emecanotdo-insert.sql.*/
UPDATE Espais
SET img_espai = LOAD_FILE('/var/lib/mysql/gym_emecanotdo/espais/piscina_1.png')
WHERE Id_espai = 9;

/*Comprovem que la imatge s'ha carregar correctament, per tant, ho extraem per poder veure-la en el sistema operatiu.*/
SELECT img_espai FROM Espais WHERE Id_espai = 9 INTO DUMPFILE '/tmp/verify_piscina_1.png';

/*La imatge s'ha carregat però ha quedat una cadena de text molt llarga. Per simplificar la vista, ho convertim a una cadena de text hexadecimal de 10 caràcters*/
UPDATE Espais
SET img_espai = UNHEX(SUBSTRING(HEX(LOAD_FILE('/var/lib/mysql/gym_emecanotdo/espais/piscina_1.png')), 1, 10))
WHERE Id_espai = 9;

/*Hem cortat la cadena del codi de la imatge, per tant, ja no es pot llegir. Amb aquest arxiu ho comprovem, ja que no es pot obrir.*/
SELECT img_espai FROM Espais WHERE Id_espai = 9 INTO DUMPFILE '/tmp/verify_piscina_1_shortened.png';

/*A partir d'ara es repetirà el mateix procés. Ens hem deixat comentaris buits per separar cada espai.*/
UPDATE Espais
SET img_espai = LOAD_FILE('/var/lib/mysql/gym_emecanotdo/espais/piscina_2.png')
WHERE Id_espai = 10;

SELECT img_espai FROM Espais WHERE Id_espai = 10 INTO DUMPFILE '/tmp/verify_piscina_2.png';

UPDATE Espais
SET img_espai = UNHEX(SUBSTRING(HEX(LOAD_FILE('/var/lib/mysql/gym_emecanotdo/espais/piscina_2.png')), 1, 10))
WHERE Id_espai = 10;

SELECT img_espai FROM Espais WHERE Id_espai = 10 INTO DUMPFILE '/tmp/verify_piscina_2_shortened.png';

/**/
UPDATE Espais
SET img_espai = LOAD_FILE('/var/lib/mysql/gym_emecanotdo/espais/piscina_3.png')
WHERE Id_espai = 11;

SELECT img_espai FROM Espais WHERE Id_espai = 11 INTO DUMPFILE '/tmp/verify_piscina_3.png';

UPDATE Espais
SET img_espai = UNHEX(SUBSTRING(HEX(LOAD_FILE('/var/lib/mysql/gym_emecanotdo/espais/piscina_3.png')), 1, 10))
WHERE Id_espai = 11;

SELECT img_espai FROM Espais WHERE Id_espai = 11 INTO DUMPFILE '/tmp/verify_ppiscina_3_shortened.png';

/**/
UPDATE Espais
SET img_espai = LOAD_FILE('/var/lib/mysql/gym_emecanotdo/espais/vestuari_personal_masc.png')
WHERE Id_espai = 1;

SELECT img_espai FROM Espais WHERE Id_espai = 1 INTO DUMPFILE '/tmp/verify_vestuari_personal_masc.png';

UPDATE Espais
SET img_espai = UNHEX(SUBSTRING(HEX(LOAD_FILE('/var/lib/mysql/gym_emecanotdo/espais/vestuari_personal_masc.png')), 1, 10))
WHERE Id_espai = 1;

SELECT img_espai FROM Espais WHERE Id_espai = 1 INTO DUMPFILE '/tmp/verify_vestuari_personal_masc_shortened.png';

/**/
UPDATE Espais
SET img_espai = LOAD_FILE('/var/lib/mysql/gym_emecanotdo/espais/vestuari_personal_fem.png')
WHERE Id_espai = 2;

SELECT img_espai FROM Espais WHERE Id_espai = 2 INTO DUMPFILE '/tmp/verify_vestuari_personal_fem.png';

UPDATE Espais
SET img_espai = UNHEX(SUBSTRING(HEX(LOAD_FILE('/var/lib/mysql/gym_emecanotdo/espais/vestuari_personal_fem.png')), 1, 10))
WHERE Id_espai = 2;

SELECT img_espai FROM Espais WHERE Id_espai = 2 INTO DUMPFILE '/tmp/verify_vestuari_vestuari_personal_fem_shortened.png';

/**/
UPDATE Espais
SET img_espai = LOAD_FILE('/var/lib/mysql/gym_emecanotdo/espais/vestuari_public_masc.png')
WHERE Id_espai = 3;

SELECT img_espai FROM Espais WHERE Id_espai = 3 INTO DUMPFILE '/tmp/verify_vestuari_public_masc.png';

UPDATE Espais
SET img_espai = UNHEX(SUBSTRING(HEX(LOAD_FILE('/var/lib/mysql/gym_emecanotdo/espais/vestuari_public_masc.png')), 1, 10))
WHERE Id_espai = 3;

SELECT img_espai FROM Espais WHERE Id_espai = 3 INTO DUMPFILE '/tmp/verify_vestuari_public_masc_shortened.png';

/**/
UPDATE Espais
SET img_espai = LOAD_FILE('/var/lib/mysql/gym_emecanotdo/espais/vestuari_public_fem.png')
WHERE Id_espai = 4;

SELECT img_espai FROM Espais WHERE Id_espai = 4 INTO DUMPFILE '/tmp/verify_vestuari_public_fem.png';

UPDATE Espais
SET img_espai = UNHEX(SUBSTRING(HEX(LOAD_FILE('/var/lib/mysql/gym_emecanotdo/espais/vestuari_public_fem.png')), 1, 10))
WHERE Id_espai = 4;

SELECT img_espai FROM Espais WHERE Id_espai = 4 INTO DUMPFILE '/tmp/verify_vestuari_public_fem_shortened.png';

/**/
UPDATE Espais
SET img_espai = LOAD_FILE('/var/lib/mysql/gym_emecanotdo/espais/sauna_vapor.png')
WHERE Id_espai = 5;

SELECT img_espai FROM Espais WHERE Id_espai = 5 INTO DUMPFILE '/tmp/verify_sauna_vapor.png';

UPDATE Espais
SET img_espai = UNHEX(SUBSTRING(HEX(LOAD_FILE('/var/lib/mysql/gym_emecanotdo/espais/sauna_vapor.png')), 1, 10))
WHERE Id_espai = 5;

SELECT img_espai FROM Espais WHERE Id_espai = 5 INTO DUMPFILE '/tmp/verify_sauna_vapor_shortened.png';

/**/
UPDATE Espais
SET img_espai = LOAD_FILE('/var/lib/mysql/gym_emecanotdo/espais/sauna_seca.png')
WHERE Id_espai = 6;

SELECT img_espai FROM Espais WHERE Id_espai = 6 INTO DUMPFILE '/tmp/verify_sauna_seca.png';

UPDATE Espais
SET img_espai = UNHEX(SUBSTRING(HEX(LOAD_FILE('/var/lib/mysql/gym_emecanotdo/espais/sauna_seca.png')), 1, 10))
WHERE Id_espai = 6;

SELECT img_espai FROM Espais WHERE Id_espai = 6 INTO DUMPFILE '/tmp/verify_sauna_seca_shortened.png';

/**/
UPDATE Espais
SET img_espai = LOAD_FILE('/var/lib/mysql/gym_emecanotdo/espais/solàrium_1.png')
WHERE Id_espai = 7;

SELECT img_espai FROM Espais WHERE Id_espai = 7 INTO DUMPFILE '/tmp/verify_solàrium_1.png';

UPDATE Espais
SET img_espai = UNHEX(SUBSTRING(HEX(LOAD_FILE('/var/lib/mysql/gym_emecanotdo/espais/solàrium_1.png')), 1, 10))
WHERE Id_espai = 7;

SELECT img_espai FROM Espais WHERE Id_espai = 7 INTO DUMPFILE '/tmp/verify_solàrium_1_shortened.png';

/**/
UPDATE Espais
SET img_espai = LOAD_FILE('/var/lib/mysql/gym_emecanotdo/espais/solàrium_2.png')
WHERE Id_espai = 8;

SELECT img_espai FROM Espais WHERE Id_espai = 8 INTO DUMPFILE '/tmp/verify_solàrium_2.png';

UPDATE Espais
SET img_espai = UNHEX(SUBSTRING(HEX(LOAD_FILE('/var/lib/mysql/gym_emecanotdo/espais/solàrium_2.png')), 1, 10))
WHERE Id_espai = 8;

SELECT img_espai FROM Espais WHERE Id_espai = 8 INTO DUMPFILE '/tmp/verify_solàrium_2_shortened.png';

/**/
UPDATE Espais
SET img_espai = LOAD_FILE('/var/lib/mysql/gym_emecanotdo/espais/zona_maquinària.png') WHERE Id_espai = 12;

SELECT img_espai FROM Espais WHERE Id_espai = 12 INTO DUMPFILE '/tmp/verify_zona_maquinària.png';

UPDATE Espais
SET img_espai = UNHEX(SUBSTRING(HEX(LOAD_FILE('/var/lib/mysql/gym_emecanotdo/espais/zona_maquinària.png')), 1, 10))
WHERE Id_espai = 12;

SELECT img_espai FROM Espais WHERE Id_espai = 12 INTO DUMPFILE '/tmp/verify_zona_maquinària_shortened.png';

/**/
UPDATE Espais
SET img_espai = LOAD_FILE('/var/lib/mysql/gym_emecanotdo/espais/sala_1.png') WHERE Id_espai = 13;

SELECT img_espai FROM Espais WHERE Id_espai = 13 INTO DUMPFILE '/tmp/verify_sala_1.png';

UPDATE Espais
SET img_espai = UNHEX(SUBSTRING(HEX(LOAD_FILE('/var/lib/mysql/gym_emecanotdo/espais/sala_1.png')), 1, 10))
WHERE Id_espai = 13;

SELECT img_espai FROM Espais WHERE Id_espai = 13 INTO DUMPFILE '/tmp/verify_sala_1_shortened.png';

/**/
UPDATE Espais
SET img_espai = LOAD_FILE('/var/lib/mysql/gym_emecanotdo/espais/sala_2.png') WHERE Id_espai = 14;

SELECT img_espai FROM Espais WHERE Id_espai = 14 INTO DUMPFILE '/tmp/verify_sala_2.png';

UPDATE Espais
SET img_espai = UNHEX(SUBSTRING(HEX(LOAD_FILE('/var/lib/mysql/gym_emecanotdo/espais/sala_2.png')), 1, 10))
WHERE Id_espai = 14;

SELECT img_espai FROM Espais WHERE Id_espai = 14 INTO DUMPFILE '/tmp/verify_sala_2_shortened.png';
/**/
UPDATE Espais
SET img_espai = LOAD_FILE('/var/lib/mysql/gym_emecanotdo/espais/sala_3.png') WHERE Id_espai = 15;

SELECT img_espai FROM Espais WHERE Id_espai = 15 INTO DUMPFILE '/tmp/verify_sala_3.png';

UPDATE Espais
SET img_espai = UNHEX(SUBSTRING(HEX(LOAD_FILE('/var/lib/mysql/gym_emecanotdo/espais/sala_3.png')), 1, 10))
WHERE Id_espai = 15;

SELECT img_espai FROM Espais WHERE Id_espai = 15 INTO DUMPFILE '/tmp/verify_sala_3_shortened.png';

/**/
UPDATE Espais
SET img_espai = LOAD_FILE('/var/lib/mysql/gym_emecanotdo/espais/sala_4.png') WHERE Id_espai = 16;

SELECT img_espai FROM Espais WHERE Id_espai = 16 INTO DUMPFILE '/tmp/verify_sala_4.png';

UPDATE Espais
SET img_espai = UNHEX(SUBSTRING(HEX(LOAD_FILE('/var/lib/mysql/gym_emecanotdo/espais/sala_4.png')), 1, 10))
WHERE Id_espai = 16;

SELECT img_espai FROM Espais WHERE Id_espai = 16 INTO DUMPFILE '/tmp/verify_sala_4_shortened.png';

/**/
UPDATE Espais
SET img_espai = LOAD_FILE('/var/lib/mysql/gym_emecanotdo/espais/sala_5.png') WHERE Id_espai = 17;

SELECT img_espai FROM Espais WHERE Id_espai = 17 INTO DUMPFILE '/tmp/verify_sala_5.png';

UPDATE Espais
SET img_espai = UNHEX(SUBSTRING(HEX(LOAD_FILE('/var/lib/mysql/gym_emecanotdo/espais/sala_5.png')), 1, 10))
WHERE Id_espai = 17;

SELECT img_espai FROM Espais WHERE Id_espai = 17 INTO DUMPFILE '/tmp/verify_sala_5_shortened.png';
