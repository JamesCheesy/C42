/* Requête 7/ 5 tables : James Dünkler-Wettlin (Collaboration Abigail Palma-Espinoza, Julie Scarpino) ; Fonctionnel
Le studio souhaite créer une liste de l'avatar ayant été le plus utilisé par son joueur respectif lors de sa dernière connexion.
La liste doit contenir le nom du joueur, la date de sa dernière connexion, le nom de son avatar, le jeu dans lequel il a passé
la plus grande partie de son temps et finalement, la durée de jeu de l'avatar en question. */

SELECT DISTINCT ON ("Nom du joueur")
joueur.alias AS "Nom du joueur", activite.date_debut AS "Dernière connexion", 
avatar.nom AS "Nom de l''avatar", jeu.nom AS "Jeu", SUM(capsule.intervalcap) AS "Durée de jeu de l''avatar"
	FROM avatar, jeu, capsule, activite, joueur
		WHERE
			capsule.avatar = avatar.id
			AND avatar.id IN (joueur.avatar1, joueur.avatar2, joueur.avatar3)
			AND capsule.jeu = jeu.sigle
		GROUP BY joueur.alias, activite.date_debut, avatar.nom, jeu.nom, capsule.intervalcap, capsule.activitecap
			HAVING activite.date_debut = (SELECT MAX(activite.date_debut) FROM activite WHERE activite.joueur = joueur.alias) 
			--AND capsule.activitecap = (SELECT MAX(capsule.activitecap) FROM capsule WHERE capsule.avatar = avatar.id)
		ORDER BY "Nom du joueur", "Durée de jeu de l''avatar" DESC, "Dernière connexion", "Jeu"
			;