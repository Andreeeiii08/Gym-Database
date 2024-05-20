DROP DATABASE IF EXISTS gym_emecanotdo;
CREATE DATABASE IF NOT EXISTS gym_emecanotdo;

USE gym_emecanotdo;

CREATE TABLE Treballadors(
   DNI_treballador CHAR(10) PRIMARY KEY COMMENT 'Està en CHAR perquè cada identificador serà un DNI.',
   Nom VARCHAR(55) COMMENT 'El nom del treballador.',
   Cognom VARCHAR(55) COMMENT 'Cognoms del treballadors.',
   Data_Naixement DATE COMMENT 'Ens interessa registrar la data de naixament de cada treballador.',
   tlf INT(9) COMMENT 'El telèfon personal de cada treballador.',
   Correu VARCHAR(55) COMMENT 'El correu personal de cada treballador.',
   Estudis TEXT	COMMENT 'Els estudis personals de cada treballador.',
   Salari DECIMAL(12,2) COMMENT 'El salari que guanya cada treballador.'
)engine=InnoDB; /*Tecnologia que portà la base de dades.*/

CREATE TABLE Entrenadors_personals(
  Id_entrenador INT PRIMARY KEY AUTO_INCREMENT COMMENT 'És el valor que identificarà als entrenadors personals.',
  DNI_treballador CHAR(10) COMMENT 'El DNI del treballador que el seu ús és de clau forana de la taula de treballador.',
  Descripcio TEXT COMMENT 'Hi ha una breu introducció de com es cada entrenador.',
  FOREIGN KEY (DNI_treballador) REFERENCES Treballadors (DNI_treballador)
);

CREATE TABLE Monitors(
   Id_monitor INT PRIMARY KEY AUTO_INCREMENT COMMENT 'És el valor que identificarà als monitors.',
   DNI_treballador CHAR(10) COMMENT 'El DNI del treballador que el seu ús és de clau forana de la taula de treballador',
   Rol TEXT COMMENT 'La funció de cada monitor en el gimnàs.',
   FOREIGN KEY (DNI_treballador) REFERENCES Treballadors (DNI_treballador)
);

CREATE TABLE Zones(
   Id_zona INT PRIMARY KEY AUTO_INCREMENT COMMENT 'Cada zona té un identificador únic.',
   Zona_instalacio ENUM('Vestuaris','Saunes','Solàrium','Piscines','Entrenament','Sales') COMMENT 'El gimnàs gestiona les seves instal·lacions dividint-las en zones.',
   Descripcio TEXT COMMENT 'Petita descripció de la zona de la instal·lació.'
);

/*Taula interelacion entre Treballadors i Instal·lacions per a assignar en quina zona de instal·lacio es mou el treballador.*/
CREATE TABLE Treballadors_Zones(
   Id_zona INT COMMENT 'Clau forana de la zona.',
   DNI_treballador CHAR(10) PRIMARY KEY COMMENT 'Clau forana del treballador.',
   FOREIGN KEY (Id_zona) REFERENCES Zones (Id_zona),
   FOREIGN KEY (DNI_treballador) REFERENCES Treballadors (DNI_treballador)
);

CREATE TABLE Espais(
   Id_espai INT PRIMARY KEY AUTO_INCREMENT COMMENT 'Cada espai té el seu identificador únic.',
   Id_zona INT COMMENT 'Clau forana de la zona.',
   Superficie DECIMAL(12,2) COMMENT 'La superfície de cada espai del gimnàs.',
   Dutxes ENUM('Disponible', 'No disponible') COMMENT 'Alguns espais tenen dutxes.',
   Taquilles ENUM('Disponible', 'No disponible') COMMENT 'Alguns espais tenen taquilles.',
   Expendedores ENUM('Disponible', 'No disponible') COMMENT 'Alguns espais tenen expendedores.',
   Font_aigua ENUM('Disponible', 'No disponible') COMMENT 'Alguns espais tenen fonts aigua.',
   Pantalles ENUM('Disponible', 'No disponible') COMMENT 'Alguns espais tenen pantalles.',
   Altaveus ENUM('Disponible', 'No disponible') COMMENT 'Tots els espais tenen altaveus.' ,
   Miralls ENUM('Disponible', 'No disponible') COMMENT 'Tots els espais tenen miralls.',
   Descripcio TEXT COMMENT 'Cada espai té una petita descripció per els clients.',
   img_espai longblob COMMENT 'Imatge per representar cada espai del gimnàs.',
   FOREIGN KEY (Id_zona) REFERENCES Zones (Id_zona)
);

CREATE TABLE Clients(
   DNI CHAR(10) PRIMARY KEY COMMENT 'Clau primària dels clients.',
   Entrenador_assignat INT COMMENT 'Aquí com hi ha alguns entrenadors assignats a alguns clients es posarà la seva ID, en cas de no tindre serà NULL; és una clau forana.',
   FOREIGN KEY (Entrenador_assignat) REFERENCES Entrenadors_personals (Id_entrenador) ON DELETE SET NULL
);

/*Els clients tenen la seva matrícula on dona constancia que estan apuntats al nostre gimnás.*/
CREATE TABLE Matricula(
   DNI CHAR(10) PRIMARY KEY COMMENT 'Clau forana i primària que ve dels clients, els quals es identifiquen amb els seus DNIs.',
   Nom VARCHAR(13) COMMENT 'Cada client té un nom.',
   Cognoms VARCHAR(27) COMMENT 'Els clients tenen dos cognoms, nosaltres els hem juntat en una sola columna.',
   Data_naixement DATE COMMENT 'Cada client ha nascut un dia en la vida.',
   Tlf INT(9) COMMENT 'El telèfon de cada client.',
   Correu VARCHAR(29) COMMENT 'El correu personal de cada client.',
   Adreça VARCHAR(60) COMMENT 'La adreça de cada client.',
   Data_alta DATE COMMENT 'Data en la que el client es dona de alta en el nostre gimnàs.',
   Preu_matricula DECIMAL(12,2) COMMENT 'Cada cop que un client es matricula, ha de pagar unes taxes administratives.',
   Preu_mensual DECIMAL(12,2) COMMENT 'Una cop al mes, el client matriculat ha de pagar una taxa.',   
   NºBanc CHAR(26) COMMENT 'Aquí es posa el número de banc on es facturarà els pagaments mensuals del gimnàs.',
   FOREIGN KEY (DNI) REFERENCES Clients (DNI)
);

/*Aqui es mostrara les clases que dirigeixen els monitors.*/
CREATE TABLE Classes_Dirigides(
   Id_classe INT PRIMARY KEY AUTO_INCREMENT COMMENT 'Cada classe té un identificador únic.',
   Id_monitor INT COMMENT 'El monitor que fa la classe.',
   Id_espai INT COMMENT 'Espai a on es fa clase.',
   Hora_inici TIME COMMENT 'Hora en la que inicia la classe.',
   Hora_final TIME COMMENT 'Hora en la que finalitza la classe.',
   Nom_clase VARCHAR(25) COMMENT 'Cada classe té un nom distintiu.',
   Dia ENUM('Dilluns','Dimarts','Dimecres','Dijous','Divendres','Dissabte','Diumenge') COMMENT 'Les classes es poden fer qualsevol dia de la setmana.',
   Descripcio TEXT COMMENT 'Una petita introducció de la classe.',
   FOREIGN KEY (Id_monitor) REFERENCES Monitors (Id_monitor),
   FOREIGN KEY (Id_espai) REFERENCES Espais (Id_espai)
);

/*Aquesta taula es la tabla interelacio entren la taula 'Client' i la taula 'Classes_Dirigides' básicament servira per donar constancia de quins clients estan apuntats a les classes.*/
CREATE TABLE Client_Classe(
   DNI_client CHAR(10) COMMENT 'Clau forana i primària del client.',
   Id_classe INT COMMENT 'Clau forana i primària de la classe.',
   PRIMARY KEY (DNI_client, Id_classe),
   FOREIGN KEY (DNI_Client) REFERENCES Clients (DNI),
   FOREIGN KEY (Id_classe) REFERENCES Classes_Dirigides (Id_classe)
);

/*Aquesta es la taula de les maquines del gimnas, hi han alguns espais de les zones que consten de maquinaria. Aquí tenim cada màquina a nivell general*/ 
CREATE TABLE Maquina_estacions(
   Id_espai INT COMMENT 'Les màquines estàn assignat a un espai.',
   Id_Maquina CHAR(5) PRIMARY KEY COMMENT 'Cada màquina té un identificador únic.',
   Estat ENUM('Operativa','En manteniment','Inoperativa') COMMENT 'Estat de la màquina que varia segons el seu estat actual.',
   FOREIGN KEY (Id_espai) REFERENCES Espais (Id_espai) 
);

/*A nivell més específic, cada màquina te petites diferences entre les del mateix tipus.*/
CREATE TABLE Tipus_maquina_estacions(
   Id_Maquina CHAR(5) PRIMARY KEY COMMENT 'Cada màquina té un identificador únic.',
   tipus CHAR(50) COMMENT 'El nom de la màquina.',
   Pes_maquina DECIMAL(12,2) COMMENT 'Aixó es quant pesa la maquina.',
   Pes_max DECIMAL(12,2) COMMENT 'Pes máxim amb el que es pot treballar amb la màquina.',
   Pes_min DECIMAL(12,2) COMMENT 'Pes mínim amb el que es pot treballar amb la màquina.',
   FOREIGN KEY (Id_Maquina) REFERENCES Maquina_estacions (Id_Maquina)
);
