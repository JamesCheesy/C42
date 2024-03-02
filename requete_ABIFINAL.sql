-- nO REQUETE: 1
-- ENONCE: Donner la liste de tous les joueurs en presentant: alias, courriel, date d'inscription.
--AUTEUR:Abigail Palma E.
-- FONCTIONNELLE: OUI


-- SELECT alias || ', ' || courriel || ', ' || inscription  AS Joueurs FROM joueur

-- nO REQUETE: 5
-- ENONCE: Pour le joueur principal, donnez le nombre total d'heure passees dans chauqe jeu joue
-- AUTEUR:Abigail Palma E.
-- FONCTIONNELLE: OUI

-- SELECT 
-- 	SUM(CASE WHEN jeu ='MAMAAA' AND avatar <= 2 THEN intervalCap END)/3600 AS CookingMama,
-- 	SUM(CASE WHEN jeu= 'DADDYY' AND avatar <=2 THEN intervalCap END)/3600 AS DreamDaddy
-- 	FROM capsule;


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
	
	
-- 	b)f(x)= 0.75x^2+20x+ 10

-- UPDATE habilete
-- SET coef1 = 0.75,
--     coef2 = 20,
--     coef3 = 10
-- WHERE sigle=(SELECT sigle FROM habilete OFFSET 1 LIMIT 1);