DROP TABLE IF EXISTS joueur;
DROP TABLE IF EXISTS activite;
DROP TABLE IF EXISTS capsule;

-- CREATE TYPE genre1 AS ENUM ('h', 'f', 'x');

CREATE TABLE joueur(

	alias				VARCHAR(32) 	PRIMARY KEY,
	courriel			VARCHAR(128)	NOT NULL,
	mot_de_passe		VARCHAR(32)		NOT NULL,
	genre				genre1			DEFAULT NULL,
	inscription			DATE			DEFAULT CURRENT_DATE,
	naissance			DATE			NOT NULL,
	activite 			INTEGER[],
	avatars				INTEGER[],
	
	CONSTRAINT uc_email			UNIQUE(courriel),
	CONSTRAINT cc_naissance		CHECK( naissance > DATE '1900-01-01' ),
	CONSTRAINT cc_inscription2	CHECK(inscription > naissance + INTERVAL'13 YEARS'),
	CONSTRAINT cc_inscription	CHECK( inscription >= DATE '2020-01-01')
	

);



CREATE TABLE capsule(
	id				SERIAL 		PRIMARY KEY,
	login			TIMESTAMP	NOT NULL,
	logout			TIMESTAMP 	NOT NULL,
	intervalCap		BIGINT		DEFAULT NULL,
	jeu				CHAR(6)		NOT NULL

);

		
INSERT INTO capsule 
	VALUES(
			1,
			'2018-03-25 12:00:00',
			'2018-04-05 07:30:00',
			DEFAULT,
			'MARI1');
			

UPDATE capsule
	SET intervalcap = 
		EXTRACT(EPOCH FROM 
					((SELECT logout FROM capsule) - (SELECT login FROM capsule)));
			

	

CREATE TABLE activite(
	
	id			SERIAL	 PRIMARY KEY,		
	date_debut	DATE	 DEFAULT CURRENT_DATE,
	capsules	INTEGER[],
	duree_act	BIGINT		DEFAULT NULL,
	
	CONSTRAINT cc_duree CHECK(duree_act>0)
);

INSERT INTO activite
	VALUES(
			1,DEFAULT,ARRAY[1,2,3], DEFAULT);




SELECT * FROM activite






-- INSERT INTO joueur
-- 	VALUES(
-- 			'aROMAStique',
-- 			'aaaa@etu.cvm.qc.ca',
-- 			'mdp',
-- 			'f',
-- 			DEFAULT,
-- 			'2003-04-01'
-- 			);
-- SELECT * FROM joueur