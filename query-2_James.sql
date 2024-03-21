-- Requête no 2, fait par James Dünkler-Wettlin

SELECT nom, rgb[1][1], rgb[1][2], rgb[1][3], TO_CHAR(avatar.inscription, 'yyyy | mm | dd') as inscription, qte_mox 
	FROM avatar
		INNER JOIN joueur
				ON avatar.id IN (joueur.avatar1, joueur.avatar2, joueur.avatar3)
		WHERE joueur.alias ~ ('[A-Za-z0-9]+\*');