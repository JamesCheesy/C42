DROP TABLE IF EXISTS avatar;

CREATE TABLE avatar (
	id 			SERIAL 			PRIMARY KEY,
	nom 		VARCHAR(32)		NOT NULL,
	phrase 		VARCHAR(64)[],
	rgb 		BIGINT[3][3],
	inscription DATE 			NOT NULL DEFAULT CURRENT_DATE,
	qte_mox 	INT 			NOT NULL,
	items 		CHAR(4)[],
	habiletes 	CHAR(3)[],
	couleur1 	BIGINT			NOT NULL,
	couleur2 	BIGINT,
	couleur3 	BIGINT,
	
	CONSTRAINT cc_phrase_length 	CHECK (ARRAY_LENGTH(phrase,1) >=1),
	CONSTRAINT cc_couleur_length	CHECK (ARRAY_LENGTH(rgb,1) >=1),
	CONSTRAINT cc_qte_mox 			CHECK (qte_mox BETWEEN -1e9 AND 1e9)
);


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

SELECT * FROM avatar;