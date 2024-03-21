INSERT INTO jeu
	VALUES('MAMAAA', 'Cooking Mama', 'Ta mère nous fait à manger', ARRAY['SAA', 'SBB'], ARRAY['IAAA', 'IBBB', 'ICCC', 'IDDD']),
			('DADDYY', 'Dream Daddy', 'Ton père nous met au lit', ARRAY['SCC', 'SDD'], ARRAY['IEEE', 'IFFF', 'IGGG', 'IHHH']);

INSERT INTO habilete (sigle, nom, energie_max, coef1, coef2, coef3, niveau, description, jeu) 
	VALUES('SAA', 'Perturbation', 13.333, 3, 1, 2, 13, 'Les effets hallucinogènes des plats de Mama désorientent et affaiblissent l''adversaire', 'MAMAAA'),
	('SBB', 'Explosion', 1000.000, 10, 10, 10, 100, 'Les plats de Mama sont tellement ''hot'' qu''ils font exploser l''adversaire', 'MAMAAA'),
	('SCC', 'Rêves obscurs', 50.000, 2, 3, 8, 35, 'L''adversaire est hanté par des cauchemars terrifiants qui le laissent figé dans la position du ''Cri'' de Munch.', 'DADDYY'),
	('SDD', 'Pouvoir de séduction', 13.333, DEFAULT, DEFAULT, DEFAULT, 1, 'Avec un sourire envoûtant et des biceps de l''enfer Daddy ensorcèle l''adversaire et le contrôle', 'DADDYY');
	
UPDATE habilete
	SET cout_niveau = ((coef1 * (niveau * niveau)) + (coef2 * niveau) + coef3);

INSERT INTO item
	VALUES('IAAA', 'Épices olé olé', 0.131, 'Elles sauront ajouter la passion enflamméee de Mama dans chaque plat.', 'MAMAAA'),
	('IBBB', 'Brownies décadents', 0.999, '''LA'' grignotise par excellence pour accompagner votre voyage.', 'MAMAAA'),
	('ICCC', 'Sauce du chaos', 0.001, 'Une sauce audacieuse qui défie les papilles gustatives.', 'MAMAAA'),
	('IDDD', 'Vino juice box', 0.666, 'Un nectar qui réinvente le plaisir de cuisiner, sans avoir l''air de picoler.' , 'MAMAAA'),
	('IEEE', 'Botox à vie', 0.750, 'Des injections infinies pour la jeunesse éternelle.', 'DADDYY'),
	('IFFF', 'Toison douce', 0.888, 'Le remplissage le plus doux ayant jamais existé pour le V-Neck de Daddy.', 'DADDYY'),
	('IGGG', 'Recueil de ''Dad jokes''', 0.376, 'Daddy aura enfin accès au répertoire absolu des meilleures blagues.', 'DADDYY'),
	('IHHH', 'Engrais magique', DEFAULT, 'Le gazon du voisin ne sera jamais plus vert que celui de Daddy.', 'DADDYY');
	


INSERT INTO joueur
	VALUES(
			'Abi*',
			'abi@abi.com',
			'abisecret',
			'x',
			'2020-01-02',
			'2003-04-01',ARRAY[1,2,3],1,2
			);
			
INSERT INTO joueur
	VALUES(
			'Julie',
			'julie@abi.com',
			'juliesecret',
			NULL,
			'2023-03-08',
			'1979-09-13',ARRAY[4],
			3
			);
			
INSERT INTO joueur
	VALUES(
			'James',
			'james@abi.com',
			'jamessecret',
			'h',
			'2021-10-19',
			'1999-08-23',ARRAY[5],
			4
			);



INSERT INTO activite
	VALUES(
			DEFAULT, 'Abi*', '2018-03-25', DEFAULT);

INSERT INTO activite
	VALUES(
			DEFAULT, 'Abi*', '2018-03-28', DEFAULT);

INSERT INTO activite
	VALUES(
			DEFAULT, 'Abi*', '2020-05-28', DEFAULT);

INSERT INTO activite
	VALUES(
			DEFAULT, 'Julie', '2022-04-12', DEFAULT);

INSERT INTO activite
	VALUES(
			DEFAULT, 'James','2023-09-30', DEFAULT);


-- ABI

		
INSERT INTO capsule 
	VALUES(
			DEFAULT,
			1,
			'2018-03-25 05:00:00',
			'2018-03-25 07:30:00',
			DEFAULT,
			'MAMAAA',
			1);
			

	
INSERT INTO capsule 
	VALUES(
			DEFAULT,
			1,
			'2018-03-25 12:00:00',
			'2018-03-25 15:30:00',
			DEFAULT,
			'MAMAAA',
			1);

	
INSERT INTO capsule 
	VALUES(
			DEFAULT,
			1,
			'2018-03-25 18:00:00',
			'2018-03-25 20:30:00',
			DEFAULT,
			'DADDYY',
			1);
			
			
			
INSERT INTO capsule 
	VALUES(
			DEFAULT,
			2,
			'2018-03-28 05:00:00',
			'2018-03-28 07:30:00',
			DEFAULT,
			'DADDYY',
			1);
			
	
INSERT INTO capsule 
	VALUES(
			DEFAULT,
			2,
			'2018-03-28 12:00:00',
			'2018-03-28 15:30:00',
			DEFAULT,
			'DADDYY',
			1);
	
INSERT INTO capsule 
	VALUES(
			DEFAULT,
			2,
			'2018-03-28 18:00:00',
			'2018-03-28 20:30:00',
			DEFAULT,
			'DADDYY',
			1);

			

INSERT INTO capsule 
	VALUES(
			DEFAULT,
			3,
			'2021-05-28 12:00:00',
			'2021-05-28 15:30:00',
			DEFAULT,
			'DADDYY',
			2);
	
INSERT INTO capsule 
	VALUES(
			DEFAULT,
			3,
			'2021-05-28 18:00:00',
			'2021-05-28 20:30:00',
			DEFAULT,
			'DADDYY',
			2);


-- Julie
INSERT INTO capsule 
	VALUES(
			DEFAULT,
			4,
			'2022-04-12 12:00:00',
			'2022-04-12 15:30:00',
			DEFAULT,
			'DADDYY',
			1);
	
INSERT INTO capsule 
	VALUES(
			DEFAULT,
			4,
			'2022-04-12 18:00:00',
			'2022-04-12 20:30:00',
			DEFAULT,
			'DADDYY',
			1);


-- James

INSERT INTO capsule 
	VALUES(
			DEFAULT,
			5,
			'2023-09-30 12:00:00',
			'2023-09-30 15:30:00',
			DEFAULT,
			'DADDYY',
			3);
	
INSERT INTO capsule 
	VALUES(
			DEFAULT,
			5,
			'2023-09-30 18:00:00',
			'2023-09-30 20:30:00',
			DEFAULT,
			'DADDYY',
			4);


UPDATE capsule
	SET intervalcap = 
		EXTRACT(EPOCH FROM 
					(logout - login ));
					
UPDATE activite
	SET duree_act = (SELECT SUM(intervalCap)
    FROM capsule
    WHERE activite.id = activiteCap );
	
INSERT INTO avatar
	VALUES (1, 'Link*',ARRAY['Hyeeeh', 'Kyaah', 'Hyaaah', 'Haa', 'Hyet', 'Haa', 'Jum', 'Haaa'],ARRAY[[12,0,90],[0,1,0]],
		   DEFAULT, 100000, ARRAY['IAAA', 'IBBB', 'ICCC'], ARRAY['SAA', 'SBB', 'SCC'], 0),
		   (2, 'Le Slayer', ARRAY['SSSSCHHHZZWOUIINNNGG'], ARRAY[[89, 43, 2], [100, 100, 100], [12, 34, 56]],
			TO_DATE('2023/03/08', 'YYYY/MM/DD'),439820, ARRAY['IDDD', 'IEEE', 'IFFF', 'IGGG', 'IHHH'], ARRAY['SDD', 'SEE', 'SFF', 'SGG'], 0),
		   (3, 'Ben Dover', ARRAY['J''ai pas vraiment le gout', 'Ca me tente plus'], ARRAY[[78,90,12], [34, 56, 78], [90, 12, 34]],
		   TO_DATE('2021/10/19', 'YYYY/MM/DD'), 25, ARRAY['IIII', 'IJJJ'], ARRAY['SHH', 'SII', 'SJJ'], 0),
		   (4, 'TechNinja', ARRAY['Je suis le maître du code'], ARRAY[[13, 83, 8], [43, 78, 20], [15, 38, 58]],
			TO_DATE('2023/09/02', 'YYYY/MM/DD'),43, ARRAY['IHHH'], ARRAY['SAA', 'SBB', 'SCC', 'SDD'], 0);

UPDATE avatar
 	SET couleur1 = (rgb[1][1] * 65536 + rgb[1][2] * 256 + rgb[1][3]),
 		couleur2 = (rgb[2][1] * 65536 + rgb[2][2] * 256 + rgb[2][3]),
 		couleur3 = (rgb[3][1] * 65536 + rgb[3][2] * 256 + rgb[3][3]);


INSERT INTO habiletes_avatar
	VALUES (DEFAULT,'SAA', DEFAULT,1, 56),
	(DEFAULT,'SAA', DEFAULT,2, 56),
	 (DEFAULT,'SBB', DEFAULT,3, 56),
	(DEFAULT,'SCC', DEFAULT,1, 9);
	
	
INSERT INTO items_avatar
	VALUES
	(DEFAULT, 1, 'IAAA',DEFAULT, DEFAULT),
	(DEFAULT, 1, 'IEEE',DEFAULT, 2),
	(DEFAULT, 2 ,'ICCC',DEFAULT, DEFAULT),
	(DEFAULT, 3, 'IDDD',DEFAULT, DEFAULT),
	(DEFAULT, 1, 'IFFF',DEFAULT, 3),
	(DEFAULT, 4, 'IHHH',DEFAULT, DEFAULT),
	(DEFAULT, 2 ,'IGGG',DEFAULT, DEFAULT);
