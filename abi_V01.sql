DROP TABLE IF EXISTS joueur;
DROP TABLE IF EXISTS activite;

CREATE TYPE genre AS ENUM ('h', 'f', 'x');

CREATE TABLE joueur(

	alias				VARCHAR(32) 	PRIMARY KEY,
	courriel			VARCHAR(128)	NOT NULL,
	mot_de_passe		VARCHAR(32)		NOT NULL,
	genre				genre			DEFAULT NULL,
	inscription			DATE			DEFAULT CURRENT_DATE,
	naissance			DATE			NOT NULL,
	activite 			INTEGER[],
	avatars				INTEGER[],
	
	CONSTRAINT uc_email			UNIQUE(courriel),
	CONSTRAINT cc_naissance		CHECK( naissance > DATE '1900-01-01' ),
	CONSTRAINT cc_inscription2	CHECK(inscription > naissance + INTERVAL'13 YEARS'),
	CONSTRAINT cc_inscription	CHECK( inscription >= DATE '2020-01-01')
	

);

CREATE TABLE activite(
	
	id			SERIAL	 PRIMARY KEY,		
	date_debut	DATE	 DEFAULT CURRENT_DATE,
	capsules	INTEGER[],
	durree_act	DATE,


);

CREATE TABLE capsule(
	id	SERIAL PRIMARY KEY,
	login
	logout
	intervalCap		SECOND
	jeu				CHAR(6)		NOT NULL,

);






INSERT INTO joueur
	VALUES(
			'aROMAStique',
			'aaaa@etu.cvm.qc.ca',
			'mdp',
			'f',
			DEFAULT,
			'2003-04-01'
			);
SELECT * FROM joueur


