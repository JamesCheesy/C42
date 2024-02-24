DROP TABLE IF EXISTS items_avatar;

CREATE TABLE items_avatar (
	sigle 			CHAR(4) PRIMARY KEY,
	date_obtention 	DATE 	NOT NULL DEFAULT CURRENT_DATE,
	quantite_item	INTEGER NOT NULL DEFAULT 1,
	
	CONSTRAINT fk_sigle_item	FOREIGN KEY (sigle) REFERENCES item(sigle), 
	CONSTRAINT cc_qte_items	CHECK (quantite_item BETWEEN 1 AND 1e9)
);

INSERT INTO items_avatar 
	VALUES ('IAAA', DEFAULT, 9);
	
SELECT * FROM items_avatar