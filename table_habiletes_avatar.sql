DROP TABLE IF EXISTS habilete_avatar;

CREATE TABLE habilete_avatar (
	sigle			CHAR(3)			PRIMARY KEY,
	date_obtention	DATE			NOT NULL DEFAULT CURRENT_DATE,
	niveau_actuel	INT				NOT NULL DEFAULT 1,
	
	CONSTRAINT fk_sigle_habil		FOREIGN KEY (sigle) REFERENCES habilete(sigle)
									ON DELETE CASCADE ON UPDATE SET NULL,
	CONSTRAINT cc_niv_habil			CHECK (niveau_actuel BETWEEN 1 AND 100)
									ON DELETE CASCADE ON UPDATE SET NULL
);

INSERT INTO habilete_avatar
	VALUES ('SAA', DEFAULT, 56);
	
SELECT * FROM habilete_avatar;