-- NO REQUÊTE : 3
-- ENONCÉ: Pour l'avatar principal, donnez toutes les habiletés qu'il possède en présentant : le sigle et le nom
-- entre crochets dans la même colonne, la date d'obtention, le niveau courant, la valeur en moX du niveau courant
-- et le coût en moX pour acheter le prochain niveau.
-- AUTEUR : Julie Scarpino (Aide de Abigail Palma E.)
-- FONCTIONNELLE: Oui

-- SELECT '  [' || habAva.sigle ||' , ' || hab.nom || ']'  AS "Habilete", 
-- 	habAva.date_obtention AS "Obtenue",
-- 	habAva.niveau_actuel AS "Niveau",
-- 	((habAva.niveau_actuel *habAva.niveau_actuel)* hab.coef1) +  (hab.coef2 * habAva.niveau_actuel) + hab.coef3
--		AS "Valeur Mox Courant",
-- 	((habAva.niveau_actuel+1) *(habAva.niveau_actuel+1)* hab.coef1) +  (hab.coef2 * (habAva.niveau_actuel +1)) + hab.coef3
--		AS "Mox ProchainNiveau"
-- 	FROM habiletes_avatar as habAva, habilete as hab
-- 		WHERE habAva.sigle = hab.sigle AND habAva.avatar = 1;
			
-- NO REQUÊTE : 4
-- ENONCÉ: Pour l'avatar principal, donnez la valeur totale de tous les items qu'il possède (les habiletés considérant le niveau et les items
-- considérant la quantité.
-- AUTEUR : Julie Scarpino (Aide de Abigail Palma E.)
-- FONCTIONNELLE: Oui
--SELECT 
--    (SELECT SUM(quantite_item)
--		FROM items_avatar
--			WHERE avatar = 1)
--				AS "Total items",
--    (SELECT SUM(((niveau_actuel * niveau_actuel) * coef1) + (coef2 * niveau_actuel) + coef3)
--	 	FROM habiletes_avatar, habilete
--     		WHERE habiletes_avatar.sigle = habilete.sigle AND habiletes_avatar.avatar = 1)
--				AS "Total habiletés";

-- NO REQUÊTE : 7
-- ENONCÉ: Trouver les joueurs ayant le plus grand nombre d'activités enregistrées et les classer en ordre décroissant.
-- AUTEUR : Julie Scarpino
-- FONCTIONNELLE: Oui


-- SELECT joueur.alias AS "Joueur", COUNT(activite.id) AS "Nombre d'activités"
-- 	FROM joueur, activite, capsule, avatar
--		WHERE joueur.alias IN (SELECT joueur.alias
--    								FROM joueur
--    								GROUP BY joueur.alias
--    								HAVING COUNT(joueur.alias) > 0)
--		AND activite.joueur = joueur.alias
--		AND activite.id = capsule.activiteCap
--		AND capsule.avatar = avatar.id
--			GROUP BY joueur.alias
--			ORDER BY COUNT(activite.id) DESC
--			LIMIT 5;
