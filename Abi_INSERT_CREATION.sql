ALTER TABLE IF EXISTS activite DROP CONSTRAINT fk_act_joueur;
ALTER TABLE IF EXISTS capsule DROP CONSTRAINT fk_cap_act;

DROP TABLE IF EXISTS activite;
DROP TABLE IF EXISTS capsule;


DROP TABLE IF EXISTS joueur;


CREATE TABLE joueur(

	alias				VARCHAR(32) 	PRIMARY KEY,
	courriel			VARCHAR(128)	NOT NULL,
	mot_de_passe		VARCHAR(32)		NOT NULL,
	genre				CHAR			DEFAULT NULL,
	inscription			DATE			DEFAULT CURRENT_DATE,
	naissance			DATE			NOT NULL,
	activite 			INTEGER[],
	avatar1				INTEGER,
	avatar2				INTEGER,
	avatar3				INTEGER,
	
	
	CONSTRAINT uc_email			UNIQUE(courriel),
	CONSTRAINT cc_naissance		CHECK( naissance > DATE '1900-01-01' ),
	CONSTRAINT cc_inscription2	CHECK(inscription > naissance + INTERVAL'13 YEARS'),
	CONSTRAINT cc_inscription	CHECK( inscription >= DATE '2020-01-01'),
	CONSTRAINT cc_genre 		CHECK(genre IN ('f', 'h', 'x', NULL)),
	CONSTRAINT cc_courriel 		CHECK( courriel ~'^[A-Za-z0-9._%-]+@[A-Za-z0-9.-]+[.][A-Za-z]+$')
	

);



CREATE TABLE activite(
	
	id			SERIAL	 		PRIMARY KEY,	
	joueur		VARCHAR(32)		NOT NULL,	
	date_debut	TIMESTAMP	 	DEFAULT CURRENT_DATE,
	duree_act	BIGINT			DEFAULT NULL,
	
	CONSTRAINT cc_duree CHECK(duree_act>0)
);



CREATE TABLE capsule(
	id				SERIAL 		PRIMARY KEY,
	activiteCap		INTEGER		NOT NULL,
	login			TIMESTAMP	NOT NULL,
	logout			TIMESTAMP 	NOT NULL,
	intervalCap		BIGINT		DEFAULT NULL,
	jeu				CHAR(6)		NOT NULL,
	avatar			INTEGER 	NOT NULL
);


ALTER TABLE activite
	ADD CONSTRAINT fk_act_joueur FOREIGN KEY (joueur) REFERENCES joueur(alias) ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE capsule 
	ADD CONSTRAINT fk_cap_act FOREIGN KEY (activiteCap) REFERENCES activite(id)  ON DELETE SET NULL ON UPDATE CASCADE;





INSERT INTO joueur
	VALUES(
			'Abi*',
			'abi@abi.com',
			'abisecret',
			'x',
			'2020-01-02',
			'2003-04-01',ARRAY[1,2,3],1,2
			);
			
INSERT INTO joueur
	VALUES(
			'Julie',
			'julie@abi.com',
			'juliesecret',
			NULL,
			'2023-03-08',
			'1979-09-13',ARRAY[4],
		3
			);
			
INSERT INTO joueur
	VALUES(
			'James',
			'james@abi.com',
			'jamessecret',
			'h',
			'2021-10-19',
			'1999-08-23',ARRAY[5],
			4
			);



INSERT INTO activite
	VALUES(
			DEFAULT, 'Abi*', '2018-03-25', DEFAULT);

INSERT INTO activite
	VALUES(
			DEFAULT, 'Abi*', '2018-03-28', DEFAULT);

INSERT INTO activite
	VALUES(
			DEFAULT, 'Abi*', '2020-05-28', DEFAULT);

INSERT INTO activite
	VALUES(
			DEFAULT, 'Julie', '2022-04-12', DEFAULT);

INSERT INTO activite
	VALUES(
			DEFAULT, 'James','2023-09-30', DEFAULT);


-- ABI

		
INSERT INTO capsule 
	VALUES(
			DEFAULT,
			1,
			'2018-03-25 05:00:00',
			'2018-03-25 07:30:00',
			DEFAULT,
			'MAMAAA',
			1);
			

	
INSERT INTO capsule 
	VALUES(
			DEFAULT,
			1,
			'2018-03-25 12:00:00',
			'2018-03-25 15:30:00',
			DEFAULT,
			'MAMAAA',
			1);

	
INSERT INTO capsule 
	VALUES(
			DEFAULT,
			1,
			'2018-03-25 18:00:00',
			'2018-03-25 20:30:00',
			DEFAULT,
			'DADDYY',
			1);
			
			
			
INSERT INTO capsule 
	VALUES(
			DEFAULT,
			2,
			'2018-03-28 05:00:00',
			'2018-03-28 07:30:00',
			DEFAULT,
			'DADDYY',
			1);
			
	
INSERT INTO capsule 
	VALUES(
			DEFAULT,
			2,
			'2018-03-28 12:00:00',
			'2018-03-28 15:30:00',
			DEFAULT,
			'DADDYY',
			1);
	
INSERT INTO capsule 
	VALUES(
			DEFAULT,
			2,
			'2018-03-28 18:00:00',
			'2018-03-28 20:30:00',
			DEFAULT,
			'DADDYY',
			1);

			

INSERT INTO capsule 
	VALUES(
			DEFAULT,
			3,
			'2021-05-28 12:00:00',
			'2021-05-28 15:30:00',
			DEFAULT,
			'DADDYY',
			2);
	
INSERT INTO capsule 
	VALUES(
			DEFAULT,
			3,
			'2021-05-28 18:00:00',
			'2021-05-28 20:30:00',
			DEFAULT,
			'DADDYY',
			2);


-- Julie
INSERT INTO capsule 
	VALUES(
			DEFAULT,
			4,
			'2022-04-12 12:00:00',
			'2022-04-12 15:30:00',
			DEFAULT,
			'DADDYY',
			1);
	
INSERT INTO capsule 
	VALUES(
			DEFAULT,
			4,
			'2022-04-12 18:00:00',
			'2022-04-12 20:30:00',
			DEFAULT,
			'DADDYY',
			1);


-- James

INSERT INTO capsule 
	VALUES(
			DEFAULT,
			5,
			'2023-09-30 12:00:00',
			'2023-09-30 15:30:00',
			DEFAULT,
			'DADDYY',
			3);
	
INSERT INTO capsule 
	VALUES(
			DEFAULT,
			5,
			'2023-09-30 18:00:00',
			'2023-09-30 20:30:00',
			DEFAULT,
			'DADDYY',
			4);


UPDATE capsule
	SET intervalcap = 
		EXTRACT(EPOCH FROM 
					(logout - login ));
					
UPDATE activite
	SET duree_act = (SELECT SUM(intervalCap)
    FROM capsule
    WHERE activite.id = activiteCap );





