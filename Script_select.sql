-- SELECT '  [' || habAva.sigle ||' , ' || hab.nom || ']'  AS "Habilite", 
-- 	habAva.date_obtention AS "Obtenue",
-- 	habAva.niveau_actuel AS "Niveau",
-- 	((habAva.niveau_actuel *habAva.niveau_actuel)* hab.coef1) +  (hab.coef2 * habAva.niveau_actuel) + hab.coef3  AS "Valeau Mox Courant",
-- 	((habAva.niveau_actuel+1) *(habAva.niveau_actuel+1)* hab.coef1) +  (hab.coef2 * (habAva.niveau_actuel +1)) + hab.coef3  AS "Mox ProchainNiveau"
-- 	FROM habiletes_Avatar as habAva, habilete as hab
-- 		WHERE
-- 			habAva.sigle = hab.sigle AND
-- 			habAva.avatar =1;
			

SELECT
	items.sigle AS "item",
	((habAva.niveau_actuel *habAva.niveau_actuel)* hab.coef1) +  (hab.coef2 * habAva.niveau_actuel) + hab.coef3  AS "Valeau Mox Courant"
	FROM items_avatar as items,  habiletes_Avatar as habAva, habilete as hab
		WHERE
			habAva.sigle = hab.sigle AND
			habAva.avatar =1 AND
		 	items.avatar=1 ;