-- Requête no 6, fait par James Dünkler-Wettlin

SELECT joueur.alias AS "Nom joueur", avatar.nom AS "Nom avatar", array_length(items, 1) as "Nombre d''items"
	FROM avatar
		INNER JOIN joueur
			ON avatar.id IN (joueur.avatar1, joueur.avatar2, joueur.avatar3)
		WHERE array_length(items, 1) > 1;