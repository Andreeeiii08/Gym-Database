# Gym-Database
Base de datos de un Gym. Es el proyecto final de MP02 UF2 de ASIR.

Finalment el pes d'aquesta activitat serà equivalent a un examen. 60%

Segons la BBDD que ha triat cada equip haureu de realitzar les següents fases:

1.- Redactar un enunciat formal on s'ha d'explicar de forma detallada què farem i amb quines restriccions o fites a complir.
2.- Codi font SQL de l'estructura de la BBDD: nombbdd-create.sql
3.- Codi font SQL de les dades i/o la seva importació cap a la BBDD i les taules de destí: nombbdd-insert.sql
4.- Esquema de la BBDD obtingut mitjançant enginyeria inversa. nombbdd-esquema.png
5.- Diccionari de dades. https://dataedo.com/kb/databases/all/data-dictionary  nombbdd-diccio.html
6.- Possibles utilitats d'aquesta BBDD tenint en compte la seva estructura i dades que conté i  possibles utilitats reals de la BBDD indicant que faltaria (columnes i tipus de dades) per a poder implementar-les
7.- SELECT * complet de cadascuna de les taules de la BBDD en un arxiu de nom: nombbdd-select.txt
8.- Dues consultes multi-taula i tres subconsultes que permetin obtenir un creuament realista de les dades per a obtenir informació substancial.
9.- Presentació de la BBDD amb un màxim de 5 diapositives + portada. Enllaç a l'arxiu de presentació
L'últim dia tindreu un màxim de 5 minuts per exposar-la a classe

10.- Bibliografia indicant tot allò que hem consultat per a la realització de l'activitat així com de les dades obtingudes per inserir o importar.

[ NOTA: 
Una restricció que hauran de tenir totes les BBDD és que inclouran arxius dintre d'alguna columna de taula.
Per exemple en el cas de jocs, les armes i/o els personatges es poden incloure com arxius d'imatge.
En el cas de vehicles o menjars el mateix, poden incloure les seves imatges.
En el cas de receptes de cuina o llibres, poden incloure un arxiu .txt o .pdf amb la recepta o la resenya del llibre.

Què necessitem:
Una columna de tipus LONGBLOB
Per inserir les imatges o arxius .txt o .pdf ho farem amb LOAD_FILE ('/ruta/nomarxiu.ext') on .ext és l'extensió de l'arxiu
Per decodificar els arxius i veure'ls (extraure'ls) farem servir en el SELECT l'opció: INTO DUMPFILE '/ruta/nomarxiu.ext'

És important que els arxius no siguin molt voluminosos i en el cas de les imatges reduir la resolució.

Més info en: https://database.guide/how-the-load_file-function-works-in-mysql/

EON ]

S'hauran d'adjuntar tots els arxius creats com a codi font (estructura i dades) i tots aquells que podem importar (csv, etc.. així com els diferents esquemes i documents)

En un PDF s'haurà de recopilar tota la informació i detallar-la de forma ordenada punt a punt, incloent els arxius de codi font, excepte els arxius de dades (CSV i el SELECT * de l'apartat 7.

Tothom haurà d'enviar la documentació (tots el membres de l'equip).
Recordeu que no és una tasca individual i que els grups poden ser de 2 o tres persones màxim.
