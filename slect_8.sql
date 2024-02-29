-- nO REQUETE: 8 BONI
-- BUT: On désire modifier la structure de prix pour deux des items de faço à avoir les montans
--     indiqué [dans la docs] selon le niveau associé.
--AUTEUR:Abigail Palma E.
-- FONCTIONNELLE: OUI

-- ALTER TABLE habilete
-- ADD COLUMN  moX1 NUMERIC DEFAULT NULL;
-- UPDATE habilete
-- set moX1 = (habilete.niveau*22.5) +20


-- ALTER TABLE habilete
-- ADD COLUMN  moX2 NUMERIC DEFAULT NULL;
-- UPDATE habilete
-- set moX2 = ((habilete.niveau*habilete.niveau)*0.75)+(habilete.niveau*20) +10
