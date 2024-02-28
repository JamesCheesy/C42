INSERT INTO jeu
	VALUES('MAMAAA', 'Cooking Mama', 'Ta mère nous fait à manger', ARRAY['SAA', 'SBB'], ARRAY['IAAA', 'IBBB', 'ICCC', 'IDDD']),
			('DADDYY', 'Dream Daddy', 'Ton père nous met au lit', ARRAY['SCC', 'SDD'], ARRAY['IEEE', 'IFFF', 'IGGG', 'IHHH']);

INSERT INTO habilete (sigle, nom, energie_max, coef1, coef2, coef3, niveau, description, jeu) 
	VALUES('SAA', 'Perturbation', 13.333, 3, 1, 2, 13, 'Les effets hallucinogènes des plats de Mama désorientent et affaiblissent l''adversaire', 'MAMAAA'),
	('SBB', 'Explosion', 1000.000, 10, 10, 10, 100, 'Les plats de Mama sont tellement ''hot'' qu''ils font exploser l''adversaire', 'MAMAAA'),
	('SCC', 'Rêves obscurs', 50.000, 2, 3, 8, 35, 'L''adversaire est hanté par des cauchemars terrifiants qui le laissent figé dans la position du ''Cri'' de Munch.', 'DADDYY'),
	('SDD', 'Pouvoir de séduction', 13.333, DEFAULT, DEFAULT, DEFAULT, 1, 'Avec un sourire envoûtant et des biceps de l''enfer Daddy ensorcèle l''adversaire et le contrôle', 'DADDYY');
	
UPDATE habilete
	SET cout_niveau = (coef1 * (niveau * niveau) + coef2 * niveau + coef3);

INSERT INTO item
	VALUES('IAAA', 'Épices olé olé', 0.131, 'Elles sauront ajouter la passion enflamméee de Mama dans chaque plat.', 'MAMAAA'),
	('IBBB', 'Brownies décadents', 0.999, '''LA'' grignotise par excellence pour accompagner votre voyage.', 'MAMAAA'),
	('ICCC', 'Sauce du chaos', 0.001, 'Une sauce audacieuse qui défie les papilles gustatives.', 'MAMAAA'),
	('IDDD', 'Vino juice box', 0.666, 'Un nectar qui réinvente le plaisir de cuisiner, sans avoir l''air de picoler.' , 'MAMAAA'),
	('IEEE', 'Botox à vie', 0.750, 'Des injections infinies pour la jeunesse éternelle.', 'DADDYY'),
	('IFFF', 'Toison douce', 0.888, 'Le remplissage le plus doux ayant jamais existé pour le V-Neck de Daddy.', 'DADDYY'),
	('IGGG', 'Recueil de ''Dad jokes''', 0.376, 'Daddy aura enfin accès au répertoire absolu des meilleures blagues.', 'DADDYY'),
	('IHHH', 'Engrais magique', DEFAULT, 'Le gazon du voisin ne sera jamais plus vert que celui de Daddy.', 'DADDYY');
	
