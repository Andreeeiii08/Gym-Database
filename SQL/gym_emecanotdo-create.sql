DROP DATABASE IF EXISTS gym_emecanotdo;
CREATE DATABASE IF NOT EXISTS gym_emecanotdo;

USE gym_emecanotdo;

CREATE TABLE Treballadors(
   Id_treballador CHAR(10) PRIMARY KEY COMMENT 'Esta en CHAR perque al identificador sera un DNI.',
   Nom VARCHAR(55),
   Cognom VARCHAR(55),
   Data_Naixement DATE,
   tlf INT(9),
   Correu VARCHAR(55),
   Estudis VARCHAR(100),
   Salari DECIMAL(12,2),
   img_treballador longblob
)engine=InnoDB;

CREATE TABLE Entrenadors_personals(
  Id_treballador CHAR(10) PRIMARY KEY,
  Descripcio TEXT COMMENT 'Aquí basicament hi haura una breu introducció de com es cada entrenador.',
  FOREIGN KEY (Id_treballador) REFERENCES Treballadors (Id_Treballador)
);

CREATE TABLE Monitors(
   Id_treballador CHAR(10) PRIMARY KEY,
   Rol TEXT COMMENT 'En rol explicara una mica la seva funció com a monitor i que es lo que fa diariament.',
   FOREIGN KEY (Id_treballador) REFERENCES Treballadors (Id_treballador)
);

CREATE TABLE Zones(
   Id_zona INT PRIMARY KEY AUTO_INCREMENT,
   Zona_instalacio ENUM('Vestuaris','Saunes','Solàrium','Piscines','Entrenament','Sales') COMMENT 'Aquest ENUM es degut a que el gimnás gestiona les seves instal·lacions dividint-las en zones.',
   Descripcio TEXT COMMENT 'Petita descripció de la zona de la instal·lacio.'
);

/*Taula interelacion entre Treballadors i Instal·lacions per a assignar en quina zona de instal·lacio es mou el treballador.*/
CREATE TABLE Treballadors_Zones(
   Id_zona INT PRIMARY KEY,
   Id_treballador CHAR(10),
   FOREIGN KEY (Id_zona) REFERENCES Zones (Id_zona),
   FOREIGN KEY (Id_treballador) REFERENCES Treballadors (Id_treballador)
);

CREATE TABLE Espais(
   Id_espai INT PRIMARY KEY AUTO_INCREMENT,
   Id_zona INT,
   Superficie DECIMAL(12,2),
   Dutxes BOOL,
   Taquilles BOOL,
   Expendedores BOOL,
   Font_aigua BOOL,
   Pantalles BOOL,
   Altaveus BOOL,
   Miralls BOOL,
   img_espai longblob COMMENT 'Imatge per representar cada espai del gimnàs.',
   FOREIGN KEY (Id_zona) REFERENCES Zones (Id_zona)
);

CREATE TABLE Clients(
   DNI CHAR(10) PRIMARY KEY,
   Entrenador_assignat CHAR COMMENT 'Aqui com hi ha alguns entrenadors assignats a alguns clients es posara la seva ID, en cas de no tindre sera NULL.',
   img_client longblob,
   FOREIGN KEY (Entrenador_assignat) REFERENCES Entrenadors_personals (Id_treballador)
);

/*Els clients tenen la seva matrícula on dona constancia que estan apuntats al nostre gimnás.*/
CREATE TABLE Matricula(
   DNI CHAR(10) PRIMARY KEY,
   Nom VARCHAR(13),
   Cognoms VARCHAR(27),
   Data_naixement DATE,
   Tlf INT(9),
   Correu VARCHAR(29),
   Adreça VARCHAR(60),
   Data_alta DATE COMMENT 'Data en la que el client es dona de alta en el nostre gimnas.',
   Preu_matricula DECIMAL(12,2),
   Preu_mensual DECIMAL(12,2),   
   NºBanc CHAR(26) COMMENT 'Aqui es posa el numero de banc on es facturara els pagaments menuals del gimnas.',
   FOREIGN KEY (DNI) REFERENCES Clients (DNI)
);

/*Aqui es mostrara les clases que dirigeixen els monitors.*/
CREATE TABLE Classes_Dirigides(
   Id_classe INT PRIMARY KEY AUTO_INCREMENT,
   Id_monitor CHAR(10),
   Id_espai INT,
   Hora_inici TIME COMMENT 'Hora en la que inicia la classe.',
   Hora_final TIME COMMENT 'Hora en la que finalitza la classe.',
   Nom_clase VARCHAR(25),
   Dia ENUM('Dilluns','Dimarts','Dimecres','Dijous','Divendres','Dissabte','Diumenge'),
   Descripcio TEXT COMMENT 'Una petita introducció de la classe.',
   FOREIGN KEY (Id_monitor) REFERENCES Monitors ( Id_treballador),
   FOREIGN KEY (Id_espai) REFERENCES Espais (Id_espai)
);

/*Aquesta taula es la tabla interelacio entren la taula 'Client' i la taula 'Classes_Dirigides' básicament servira per donar constancia de quins clients estan apuntats a les classes.*/
CREATE TABLE Client_Classe(
   DNI_client CHAR(10) PRIMARY KEY,
   Id_classe INT,
   FOREIGN KEY (DNI_Client) REFERENCES Clients (DNI),
   FOREIGN KEY (Id_classe) REFERENCES Classes_Dirigides (Id_classe)
);

/*Aquesta es la taula de les maquines del gimnas, hi han alguns espais de les zones que consten de maquinaria. Aquí tenim cada màquina a nivell general*/ 
CREATE TABLE Maquina(
   Id_espai INT,
   Id_Maquina INT PRIMARY KEY AUTO_INCREMENT,
   Estat ENUM('Operativa','En manteniment','Inoperativa'),
   FOREIGN KEY (Id_espai) REFERENCES Espais (Id_espai) 
);

/*A nivell més específic, cada màquina te petites diferences entre les del mateix tipus.*/
CREATE TABLE Tipus_maquina(
   Id_Maquina INT PRIMARY KEY,
   tipus CHAR(50),
   Pes_maquina DECIMAL(12,2) COMMENT 'Aixó es quant pesa la maquina.',
   Pes_max DECIMAL(12,2) COMMENT 'Pes máxim amb el que es pot treballar amb la máquina.',
   Pes_min DECIMAL(12,2) COMMENT 'Pes mínim amb el que es pot treballar amb la máquina.',
   img_maquina longblob COMMENT 'Imatge de la maquina.',
   FOREIGN KEY (Id_Maquina) REFERENCES Maquina (Id_Maquina)
);
