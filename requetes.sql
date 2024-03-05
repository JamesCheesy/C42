-- nO REQUETE: 1
-- ENONCE: Donner la liste de tous les joueurs en presentant: alias, courriel, date d'inscription.
--AUTEUR:Abigail Palma E.
-- FONCTIONNELLE: OUI


-- SELECT alias || ', ' || courriel || ', ' || inscription  AS Joueurs FROM joueur




-- nO REQUETE: 2
-- ENONCE: Donner la liste des avatars d'un joueur quelconque (pour l'exemple, prendre le joueur principal), en donnant: 
-- 			Nom, couleur préféré transformée en trois composantes(rouge,vert,bleu), date de création suivant le format(2000|12|25),
-- 			le nombre de mox.
--AUTEUR:James  James Dünkler-Wettlin
-- FONCTIONNELLE: OUI


-- SELECT nom, rgb[1][1], rgb[1][2], rgb[1][3], TO_CHAR(avatar.inscription, 'yyyy | mm | dd') as inscription, qte_mox 
-- 	FROM avatar
-- 		INNER JOIN joueur
-- 				ON avatar.id IN (joueur.avatar1, joueur.avatar2, joueur.avatar3)
-- 		WHERE joueur.alias ~ ('[A-Za-z0-9]+\*');





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
-- 		AS "Valeur Mox Courant",
-- 	((habAva.niveau_actuel+1) *(habAva.niveau_actuel+1)* hab.coef1) +  (hab.coef2 * (habAva.niveau_actuel +1)) + hab.coef3
-- 		AS "Mox ProchainNiveau"
-- 	FROM habiletes_avatar as habAva, habilete as hab
-- 		WHERE habAva.sigle = hab.sigle AND habAva.avatar = 1;
	
	
	
	
	
-- NO REQUÊTE : 4
-- ENONCÉ: Pour l'avatar principal, donnez la valeur totale de tous les items qu'il possède (les habiletés considérant le niveau et les items
-- considérant la quantité.
-- AUTEUR : Julie Scarpino (Aide de Abigail Palma E.)
-- FONCTIONNELLE: Oui


-- SELECT 
--    (SELECT SUM(quantite_item)
-- 		FROM items_avatar
-- 			WHERE avatar = 1)
-- 				AS "Total items",
--    (SELECT SUM(((niveau_actuel * niveau_actuel) * coef1) + (coef2 * niveau_actuel) + coef3)
-- 	 	FROM habiletes_avatar, habilete
--     		WHERE habiletes_avatar.sigle = habilete.sigle AND habiletes_avatar.avatar = 1)
-- 				AS "Total habiletés";





-- nO REQUETE: 5
-- ENONCE: Pour le joueur principal, donnez le nombre total d'heure passees dans chauqe jeu joue
-- AUTEUR:Abigail Palma E.
-- FONCTIONNELLE: OUI


-- SELECT 
-- 	SUM(CASE WHEN jeu ='MAMAAA' AND avatar <= 2 THEN intervalCap END)/3600 AS CookingMama,
-- 	SUM(CASE WHEN jeu= 'DADDYY' AND avatar <=2 THEN intervalCap END)/3600 AS DreamDaddy
-- 	FROM capsule;




-- nO REQUETE: 6
-- ENONCE: Donnez la liste de tout les avatars qui possèdent plus de un item: nom du joueur,nom de l'avatar
-- 			et nombre d'items.
--AUTEUR:James  James Dünkler-Wettlin
-- FONCTIONNELLE: OUI


-- SELECT joueur.alias AS "Nom joueur", avatar.nom AS "Nom avatar", array_length(items, 1) as "Nombre d''items"
-- 	FROM avatar
-- 		INNER JOIN joueur
-- 			ON avatar.id IN (joueur.avatar1, joueur.avatar2, joueur.avatar3)
-- 		WHERE array_length(items, 1) > 1;




-- NO REQUÊTE : 7
-- ENONCÉ: Trouver les joueurs ayant le plus grand nombre d'activités enregistrées et les classer en ordre décroissant.
-- AUTEUR : Julie Scarpino
-- FONCTIONNELLE: Oui


-- SELECT joueur.alias AS "Joueur", COUNT(activite.id) AS "Nombre d'activités"
-- 	FROM joueur, activite, capsule, avatar
-- 		WHERE joueur.alias IN (SELECT joueur.alias
--    								FROM joueur
--    								GROUP BY joueur.alias
--    								HAVING COUNT(joueur.alias) > 0)
-- 		AND activite.joueur = joueur.alias
-- 		AND activite.id = capsule.activiteCap
-- 		AND capsule.avatar = avatar.id
-- 			GROUP BY joueur.alias
-- 			ORDER BY COUNT(activite.id) DESC
-- 			LIMIT 5;





-- nO REQUETE: 7
-- BUT: Retourne tout les avatars selon leurs joueurs et la somme des temps ou les
-- 		joueurs ont utilise l'avatar. 
-- 		AKA: me retourne les 5 premiers avatars les plus utilises
--AUTEUR:Abigail Palma E.
-- FONCTIONNELLE: OUI


-- SELECT
-- 	joueur.alias as proprio,avatar.nom as nom_avatar, SUM(cap.intervalCap) AS total_temps_jeu
-- FROM avatar as avatar, capsule as cap, joueur
-- 	WHERE
-- 		joueur.avatar1= avatar.id AND avatar.id = cap.avatar
-- 		OR
-- 		joueur.avatar2=avatar.id AND avatar.id=cap.avatar
-- 		OR
-- 		joueur.avatar3=avatar.id AND avatar.id=cap.avatar

-- GROUP BY avatar.nom, joueur.alias
-- HAVING SUM(cap.intervalcap) > 1000
-- ORDER BY total_temps_jeu DESC
-- LIMIT 5;




-- nO REQUETE: 8
-- BUT: UPDATER LA STRUCTURE DE PRIX POUR DEUX ITEMS selon f(x)=22.5x+20 et f(x)= 0.75x^2+20x+ 10
--AUTEUR:Abigail Palma E.
-- FONCTIONNELLE: OUI


-- A) f(x)=22.5x+20

-- UPDATE habilete
-- SET coef1 = 0,
--     coef2 = 22.50,
--     coef3 = 20
-- WHERE sigle=(SELECT sigle FROM habilete LIMIT 1);

-- SELECT * FROM habilete;
	
	
-- 	b)f(x)= 0.75x^2+20x+ 10

-- UPDATE habilete
-- SET coef1 = 0.75,
--     coef2 = 20,
--     coef3 = 10
-- WHERE sigle=(SELECT sigle FROM habilete OFFSET 1 LIMIT 1);


-- SELECT * FROM habilete;





