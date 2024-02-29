

-- -- ALTER TABLE items_avatar
-- -- ADD COLUMN  niv_temp INTEGER DEFAULT 1;


-- -- UPDATE items_avatar
-- -- SET niv_temp= id*10

-- -- ALTER TABLE item
-- -- ADD COLUMN  moX NUMERIC

-- UPDATE item
-- set mox = (items_avatar.niv_temp*22.5) +20
-- 	FROM items_avatar
-- 	WHERE
-- 	items_avatar.sigle = item.sigle;




-- -- ALTER TABLE item
-- -- ADD COLUMN  moX2 NUMERIC;

-- UPDATE item
-- set mox2 = (((items_avatar.niv_temp * items_avatar.niv_temp) * 0.75) +(20 * items_avatar.niv_temp) +10)
-- 	FROM items_avatar
-- 	WHERE
-- 	items_avatar.sigle = item.sigle