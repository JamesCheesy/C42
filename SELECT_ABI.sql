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

