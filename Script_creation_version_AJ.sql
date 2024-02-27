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
	id 				SERIAL				PRIMARY KEY,
	sigle			CHAR(3)				NOT NULL,
	date_obtention	DATE				NOT NULL DEFAULT CURRENT_DATE,
	avatar 			INTEGER				NOT NULL,
	niveau_actuel	INTEGER				NOT NULL DEFAULT 1,
	
	CONSTRAINT cc_niv_habil				CHECK (niveau_actuel BETWEEN 1 AND 100)
);

CREATE TABLE items_avatar (
	id 				SERIAL	 			PRIMARY KEY,
	avatar			INTEGER			NOT NULL,
	sigle 			CHAR(4)				NOT NULL,
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
	avatar			INTEGER				NOT NULL	
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
	
INSERT INTO jeu
	VALUES('MAMAAA', 'Cooking Mama', 'Ta mère nous fait à manger', ARRAY['SAA', 'SBB'], ARRAY['IAAA', 'IBBB', 'ICCC', 'IDDD']),
			('DADDYY', 'Dream Daddy', 'Ton père nous met au lit', ARRAY['SCC', 'SDD'], ARRAY['IEEE', 'IFFF', 'IGGG', 'IHHH']);

INSERT INTO habilete (sigle, nom, energie_max, coef1, coef2, coef3, niveau, description, jeu) 
	VALUES('SAA', 'Perturbation', 13.333, 3, 1, 2, 13, 'Les effets hallucinogènes des plats de Mama désorientent et affaiblissent l''adversaire', 'MAMAAA'),
	('SBB', 'Explosion', 1000.000, 10, 10, 10, 100, 'Les plats de Mama sont tellement ''hot'' qu''ils font exploser l''adversaire', 'MAMAAA'),
	('SCC', 'Rêves obscurs', 50.000, 2, 3, 8, 35, 'L''adversaire est hanté par des cauchemars terrifiants qui le laissent figé dans la position du ''Cri'' de Munch.', 'DADDYY'),
	('SDD', 'Pouvoir de séduction', 13.333, DEFAULT, DEFAULT, DEFAULT, 1, 'Avec un sourire envoûtant et des biceps de l''enfer Daddy ensorcèle l''adversaire et le contrôle', 'DADDYY');
	
UPDATE habilete
	SET cout_niveau = (coef1 * (niveau * niveau) + coef2 * niveau + coef3);

INSERT INTO item
	VALUES('IAAA', 'Épices olé olé', 0.131, 'Elles sauront ajouter la passion enflamméee de Mama dans chaque plat.', 'MAMAAA'),
	('IBBB', 'Brownies décadents', 0.999, '''LA'' grignotise par excellence pour accompagner votre voyage.', 'MAMAAA'),
	('ICCC', 'Sauce du chaos', 0.001, 'Une sauce audacieuse qui défie les papilles gustatives.', 'MAMAAA'),
	('IDDD', 'Vino juice box', 0.666, 'Un nectar qui réinvente le plaisir de cuisiner, sans avoir l''air de picoler.' , 'MAMAAA'),
	('IEEE', 'Botox à vie', 0.750, 'Des injections infinies pour la jeunesse éternelle.', 'DADDYY'),
	('IFFF', 'Toison douce', 0.888, 'Le remplissage le plus doux ayant jamais existé pour le V-Neck de Daddy.', 'DADDYY'),
	('IGGG', 'Recueil de ''Dad jokes''', 0.376, 'Daddy aura enfin accès au répertoire absolu des meilleures blagues.', 'DADDYY'),
	('IHHH', 'Engrais magique', DEFAULT, 'Le gazon du voisin ne sera jamais plus vert que celui de Daddy.', 'DADDYY');
	


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
	
INSERT INTO avatar
	VALUES (1, 'Link*',ARRAY['Hyeeeh', 'Kyaah', 'Hyaaah', 'Haa', 'Hyet', 'Haa', 'Jum', 'Haaa'],ARRAY[[12,0,90],[0,1,0]],
		   DEFAULT, 100000, ARRAY['IAAA', 'IBBB', 'ICCC'], ARRAY['SAA', 'SBB', 'SCC'], 0),
		   (2, 'Le Slayer', ARRAY['SSSSCHHHZZWOUIINNNGG'], ARRAY[[89, 43, 2], [100, 100, 100], [12, 34, 56]],
			TO_DATE('2023/03/08', 'YYYY/MM/DD'),439820, ARRAY['IDDD', 'IEEE', 'IFFF', 'IGGG', 'IHHH'], ARRAY['SDD', 'SEE', 'SFF', 'SGG'], 0),
		   (3, 'Ben Dover', ARRAY['J''ai pas vraiment le gout', 'Ca me tente plus'], ARRAY[[78,90,12], [34, 56, 78], [90, 12, 34]],
		   TO_DATE('2021/10/19', 'YYYY/MM/DD'), 25, ARRAY['IIII', 'IJJJ'], ARRAY['SHH', 'SII', 'SJJ'], 0);

UPDATE avatar
 	SET couleur1 = (rgb[1][1] * 65536 + rgb[1][2] * 256 + rgb[1][3]),
 		couleur2 = (rgb[2][1] * 65536 + rgb[2][2] * 256 + rgb[2][3]),
 		couleur3 = (rgb[3][1] * 65536 + rgb[3][2] * 256 + rgb[3][3]);


INSERT INTO habiletes_avatar
	VALUES (DEFAULT,'SAA', DEFAULT,1, 56),
	(DEFAULT,'SAA', DEFAULT,2, 56),
	 (DEFAULT,'SBB', DEFAULT,3, 56),
	(DEFAULT,'SCC', DEFAULT,1, 9);
	
	
INSERT INTO items_avatar
	VALUES
	(DEFAULT,1, 'IAAA',DEFAULT, DEFAULT),
	(DEFAULT,1 ,'IEEE',DEFAULT, 2),
	(DEFAULT,2 ,'ICCC',DEFAULT, DEFAULT),
	(DEFAULT,3, 'IDDD',DEFAULT, DEFAULT),
	(DEFAULT,1, 'IFFF',DEFAULT, 3),
	(DEFAULT,4, 'IHHH',DEFAULT,2),
	(DEFAULT,2 ,'IGGG',DEFAULT, DEFAULT);

-- SELECT sigle || '=[' || nom || ']' AS "Habiletés"
-- 	FROM habilete
-- 		WHERE sigle IN (SELECT sigle
-- 				FROM avatar WHERE nom LIKE '%*%')
--  --LIMIT 1
 
-- (SELECT date_obtention AS "Date obtention" 
--         FROM habiletes_avatar
-- 			WHERE sigle IN (SELECT sigle
-- 				FROM avatar WHERE nom LIKE '%*%')
--  LIMIT 1
-- );        

/*SELECT habiletes
	FROM avatar
		WHERE nom LIKE '%*%';
		
SELECT nom, prenom 
	FROM employe 
	WHERE ville IN (SELECT ville 
		FROM employe 
		WHERE departement = 'r&d'); */

   