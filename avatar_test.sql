DROP TABLE IF EXISTS avatar;

CREATE TABLE avatar (
	
	id SERIAL PRIMARY KEY,
	
	nom VARCHAR(32) NOT NULL,
	
	phrase VARCHAR(64)[],
	
	rgb 	BIGINT[3][3],
	
	inscription DATE NOT NULL DEFAULT CURRENT_DATE,
	
	qte_mox INT NOT NULL,
	
	items SERIAL,
	habiletes SERIAL,
	
	couleur1 	BIGINT,
	couleur2 	BIGINT,
	couleur3 	BIGINT,
	
	CONSTRAINT cc_phrase_length CHECK (ARRAY_LENGTH(phrase,1) >=1),
	CONSTRAINT cc_couleur_length CHECK (ARRAY_LENGTH(rgb,1) >=1),
	CONSTRAINT cc_qte_mox CHECK (qte_mox BETWEEN -1e9 AND 1e9)
	
);


INSERT INTO avatar
	VALUES(1,'joe',ARRAY['AA'],ARRAY[[12,0,90],[0,1,0]], default, 1000);
	

UPDATE avatar
	SET couleur1 = (SELECT rgb[1][2]+ 255 * rgb[1][3] * (255*255) * rgb[1][1] FROM avatar);
	
UPDATE avatar
	SET couleur2 = (SELECT rgb[2][2] +255 * rgb[2][3] * (255*255) * rgb[2][1] FROM avatar);
	
UPDATE avatar
	SET couleur3 = (SELECT rgb[3][2] +255 * rgb[3][3] * (255*255) * rgb[3][1] FROM avatar);

SELECT * FROM avatar;
	 





