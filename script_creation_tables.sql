ALTER TABLE IF EXISTS activite DROP CONSTRAINT fk_act_joueur;
ALTER TABLE IF EXISTS capsule DROP CONSTRAINT fk_cap_act;

DROP TABLE IF EXISTS activite CASCADE;
DROP TABLE IF EXISTS capsule CASCADE;
DROP TABLE IF EXISTS joueur CASCADE;
DROP TABLE IF EXISTS avatar CASCADE;
DROP TABLE IF EXISTS items_avatar CASCADE;
DROP TABLE IF EXISTS habiletes_avatar CASCADE;
DROP TABLE IF EXISTS jeu CASCADE;
DROP TABLE IF EXISTS habilete CASCADE;
DROP TABLE IF EXISTS item CASCADE;


CREATE TABLE item (
	sigle			CHAR(4)				PRIMARY KEY,
	nom 			VARCHAR(32) 		NOT NULL,
	probabilite		NUMERIC(4,3)		NOT NULL 	DEFAULT 0.025,
	description 	VARCHAR(1024),
	jeu 			CHAR(6),	
	
	CONSTRAINT cc_item_sigle 			CHECK (sigle ~ '^I'),	
	CONSTRAINT uc_item_nom 				UNIQUE (nom),
	
	CONSTRAINT cc_probabilite 			CHECK (probabilite BETWEEN 0.001 AND 0.999)
);

CREATE TABLE habilete (
	sigle 			CHAR(3)				PRIMARY KEY,
	nom 			VARCHAR(32)			NOT NULL,
	energie_max 	NUMERIC(7,3)		NOT NULL,	
	coef1 			DOUBLE PRECISION 	NOT NULL DEFAULT 0.0,
	coef2 			DOUBLE PRECISION 	NOT NULL DEFAULT 0.0,
	coef3 			DOUBLE PRECISION 	NOT NULL DEFAULT 1.0,
	niveau 			INTEGER,	
	cout_niveau 	DOUBLE PRECISION,	
	description 	VARCHAR(1024),
	jeu 			CHAR(6),	
	
	CONSTRAINT cc_habilete_sigle		CHECK(sigle ~ '^S'),
	CONSTRAINT uc_habilete_nom			UNIQUE (nom),
	CONSTRAINT cc_energie_max 			CHECK(energie_max BETWEEN 10.000 AND 1000.000),
	CONSTRAINT cc_niveau 				CHECK(niveau BETWEEN 1 AND 100)	
);

CREATE TABLE jeu (
	sigle 			CHAR(6) 			PRIMARY KEY,
	nom 			VARCHAR(16) 		NOT NULL,
	description 	VARCHAR(2048),
	habiletes 		CHAR(3)[],
	items 			CHAR(4)[],	
	
	CONSTRAINT uc_jeu_nom 				UNIQUE (nom),
	CONSTRAINT uc_habil_jeu				UNIQUE (habiletes),
	CONSTRAINT uc_items_jeu				UNIQUE (items)
);

CREATE TABLE habiletes_avatar (
	sigle			CHAR(3)				PRIMARY KEY,
	date_obtention	DATE				NOT NULL DEFAULT CURRENT_DATE,
	niveau_actuel	INT					NOT NULL DEFAULT 1,
	
	CONSTRAINT cc_niv_habil				CHECK (niveau_actuel BETWEEN 1 AND 100)
);

CREATE TABLE items_avatar (
	sigle 			CHAR(4) 			PRIMARY KEY,
	date_obtention 	DATE 				NOT NULL DEFAULT CURRENT_DATE,
	quantite_item	INTEGER 			NOT NULL DEFAULT 1,
	
	CONSTRAINT cc_qte_items				CHECK (quantite_item BETWEEN 1 AND 1e9)
);

CREATE TABLE avatar (
	id 				SERIAL 				PRIMARY KEY,
	nom 			VARCHAR(32)			NOT NULL,
	phrase 			VARCHAR(64)[],
	rgb 			BIGINT[3][3],
	inscription 	DATE 				NOT NULL DEFAULT CURRENT_DATE,
	qte_mox 		INT 				NOT NULL,
	items 			CHAR(4)[],
	habiletes 		CHAR(3)[],
	couleur1 		BIGINT				NOT NULL,
	couleur2 		BIGINT,
	couleur3 		BIGINT,
	
	CONSTRAINT cc_phrase_length 		CHECK (ARRAY_LENGTH(phrase,1) >=1),
	CONSTRAINT cc_couleur_length		CHECK (ARRAY_LENGTH(rgb,1) >=1),
	CONSTRAINT cc_qte_mox 				CHECK (qte_mox BETWEEN -1e9 AND 1e9)
);

CREATE TABLE capsule(
	id			SERIAL 				PRIMARY KEY,
	activiteCap		INTEGER				NOT NULL,
	login			TIMESTAMP			NOT NULL,
	logout			TIMESTAMP 			NOT NULL,
	intervalCap		BIGINT				DEFAULT NULL,
	jeu			CHAR(6)				NOT NULL,
	avatar			INTEGER				NOT NULL,
	
	CONSTRAINT uc_jeu_capsule			UNIQUE (jeu)
);

CREATE TABLE activite (
	id			SERIAL	 			PRIMARY KEY,
	joueur			VARCHAR(32)			NOT NULL,
	date_debut		DATE	 			DEFAULT CURRENT_DATE,
	duree_act		BIGINT				DEFAULT NULL,
	
	CONSTRAINT cc_duree 				CHECK(duree_act>0)
);

CREATE TABLE joueur(
	alias			VARCHAR(32) 		PRIMARY KEY,
	courriel		VARCHAR(128)		NOT NULL,
	mot_de_passe	VARCHAR(32)			NOT NULL,
	genre			CHAR				DEFAULT NULL,
	inscription		DATE				DEFAULT CURRENT_DATE,
	naissance		DATE				NOT NULL,
	activite 		INTEGER[],
	avatar1			INTEGER,
	avatar2			INTEGER,
	avatar3			INTEGER,
	
	CONSTRAINT uc_email				UNIQUE(courriel),
	CONSTRAINT cc_naissance				CHECK( naissance > DATE '1900-01-01' ),
	CONSTRAINT cc_inscription2			CHECK(inscription > naissance + INTERVAL'13 YEARS'),
	CONSTRAINT cc_inscription			CHECK( inscription >= DATE '2020-01-01'),
	CONSTRAINT cc_courriel 		CHECK( courriel ~'^[A-Za-z0-9._%-]+@[A-Za-z0-9.-]+[.][A-Za-z]+$')
);



ALTER TABLE item 				
	ADD CONSTRAINT fk_item_jeu 	FOREIGN KEY (jeu) REFERENCES jeu(sigle)
																ON DELETE CASCADE ON UPDATE SET NULL;
ALTER TABLE habilete 			
	ADD CONSTRAINT fk_habilete_jeu 	FOREIGN KEY (jeu) REFERENCES jeu(sigle)
																ON DELETE CASCADE ON UPDATE SET NULL;
ALTER TABLE items_avatar 		
	ADD CONSTRAINT fk_sigle_item	FOREIGN KEY (sigle) REFERENCES item(sigle)
																ON DELETE CASCADE ON UPDATE SET NULL;
ALTER TABLE habiletes_avatar	
	ADD CONSTRAINT fk_sigle_habil	FOREIGN KEY (sigle) REFERENCES habilete(sigle)
															ON DELETE CASCADE ON UPDATE SET NULL;
ALTER TABLE activite
	ADD CONSTRAINT fk_act_joueur FOREIGN KEY (joueur) REFERENCES joueur(alias) ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE capsule 
	ADD CONSTRAINT fk_cap_act FOREIGN KEY (activiteCap) REFERENCES activite(id)  ON DELETE SET NULL ON UPDATE CASCADE;
	
