--ALTER TABLE IF EXISTS jeu DROP CONSTRAINT fk_jeu_items;
--ALTER TABLE IF EXISTS jeu etudiant DROP CONSTRAINT fk_jeu_habiletes;
--ALTER TABLE IF EXISTS habilete DROP CONSTRAINT fk_habilete_jeu;
--ALTER TABLE IF EXISTS item DROP CONSTRAINT fk_item_jeu;


DROP TABLE IF EXISTS item;
DROP TABLE IF EXISTS habilete;
DROP TABLE IF EXISTS jeu; 

CREATE TABLE item (
	sigle		CHAR(4)				PRIMARY KEY,
	nom 		VARCHAR(32) 		NOT NULL,
	probabilite NUMERIC(4,3)		NOT NULL 	DEFAULT 0.025,
	description VARCHAR(1024),
	jeu 		CHAR(6),	
	
	CONSTRAINT cc_item_sigle 		CHECK(sigle ~ '^I'),	
	CONSTRAINT uc_item_nom 			UNIQUE(nom),
	CONSTRAINT cc_probabilite 		CHECK(probabilite BETWEEN 0.00001 AND 0.999)
);

INSERT INTO item
	VALUES('IOIO', 'Glitter', DEFAULT, 'Ça shine all over', 'ZIGOTO');

CREATE TABLE habilete (
	sigle 		CHAR(3)				PRIMARY KEY,
	nom 		VARCHAR(32)			NOT NULL,
	energie_max NUMERIC(7,3)		NOT NULL,	
	coef1 		DOUBLE PRECISION 	NOT NULL DEFAULT 0.0,
	coef2 		DOUBLE PRECISION 	NOT NULL DEFAULT 0.0,
	coef3 		DOUBLE PRECISION 	NOT NULL DEFAULT 1.0,
	niveau 		INTEGER,	
	cout_niveau DOUBLE PRECISION,	
	description VARCHAR(1024),
	jeu 		CHAR(6),	
	
	CONSTRAINT cc_habilete_sigle	CHECK(sigle ~ '^S'),
	CONSTRAINT uc_habilete_nom		UNIQUE (nom),
	CONSTRAINT cc_energie_max 		CHECK(energie_max BETWEEN 10.000 AND 1000.000),
	CONSTRAINT cc_niveau 			CHECK(niveau BETWEEN 1 AND 100)	
);


INSERT INTO habilete (sigle, nom, energie_max, coef1, coef2, coef3, niveau, description, jeu) 
	VALUES('SSS', 'Reveal', 13.333, 3, 1, 2, 13, 'Description', 'ZIGOTO');
	
UPDATE habilete
	SET cout_niveau = (coef1 * (niveau * niveau) + coef2 * niveau + coef3);


CREATE TABLE jeu (
	sigle 		CHAR(6) 			PRIMARY KEY,
	nom 		VARCHAR(16) 		NOT NULL,
	description VARCHAR(2048),
	habiletes 	CHAR(3)[],
	items 		CHAR(4)[],	
	
	CONSTRAINT uc_jeu_nom 			UNIQUE (nom)
);

INSERT INTO jeu
	VALUES('TONDRE', 'Raser l''ennemi', 'Description', ARRAY['SSS'], ARRAY['IOIO']);

SELECT * FROM jeu;

--ALTER TABLE item ADD CONSTRAINT fk_item_jeu FOREIGN KEY (jeu) REFERENCES jeu(items);
--ALTER TABLE habilete ADD CONSTRAINT fk_habilete_jeu FOREIGN KEY (jeu) REFERENCES jeu(habiletes);
--ALTER TABLE jeu ADD CONSTRAINT fk_jeu_habiletes FOREIGN KEY (habiletes) REFERENCES habilete(jeu);
--ALTER TABLE jeu ADD CONSTRAINT fk_jeu_items FOREIGN KEY (items) REFERENCES item(jeu);

