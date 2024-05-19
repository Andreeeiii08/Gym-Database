/**Como placeholder, creamos cosas TEMPORALES en las otras tablas para asegurarnos que las máquinas van**/

INSERT INTO Treballadors (Id_treballador, Nom, Cognom, Data_Naixement, tlf, Correu, Estudis, Salari, img_treballador) VALUES
('1', 'Antonio', 'Recio', '1985-04-23', 123456789, 'antonio.recio@mariscosrecio.com', 'Ser su propio jefe', 25000.00, NULL);

INSERT INTO Zones (Zona_instalacio, Descripcio) VALUES
('Entrenament', 'Àrea equipada amb màquines de musculació i cardio per a entrenament complet.');

INSERT INTO Espais (Id_instalacio, Superficie, Dutxes, Taquilles, Expendedores, Font_aigua, Pantalles, Altaveus, Miralls, img_espai) VALUES
(1, 150.00, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, NULL);

INSERT INTO Treballadors_Zones (Id_instalacio, Id_treballador) VALUES
(1, 1);

/*Intento de cargar el CSV pero da error.*/

LOAD DATA LOCAL INFILE '/home/usuari/GitHub/Gym-Database/csv/BORRADOR_TEMPORAL_maquines.csv'
INTO TABLE Maquines_gimnas FIELDS TERMINATED BY '\t'
IGNORE 1 LINES
(Id_espai, Nom_maquina, Estat, Pes_maquina, Pes_max, Pes_min, Quantitat_maquina);


