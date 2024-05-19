LOAD DATA LOCAL INFILE '/home/usuari/GitHub/Gym-Database/csv/BORRADOR_TEMPORAL_maquines.csv'
INTO TABLE Maquines_gimnas FIELDS TERMINATED BY '\t'
IGNORE 1 LINES
(Id_espai, Nom_maquina, Estat, Pes_maquina, Pes_max, Pes_min, Quantitat_maquina, img_maquina);
