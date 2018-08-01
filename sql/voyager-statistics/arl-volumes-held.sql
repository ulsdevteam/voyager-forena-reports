SELECT
	SUM(CASE WHEN I.ITEM_ID IS NULL AND NVL(v.ARLEB, 'N') = 'Y' THEN 1 WHEN I.ITEM_ID IS NOT NULL AND NVL(v.ARLEB, 'N') != 'Y' THEN 1 ELSE 0 END) COUNT,
	v.ARLEB,
	CASE
		WHEN l.library_id = 7 THEN 'Law'
		WHEN l.library_id = 10 THEN 'HSLS'
		WHEN l.library_id in (1, 2, 5, 6, 9, 11) THEN 'ULS'
		ELSE 'Err:' || l.library_id
	END library
FROM
	bib_master b
	JOIN bib_text bt ON (b.bib_id = bt.bib_id)
	JOIN bib_mfhd bm ON (b.bib_id = bm.bib_id)
	JOIN mfhd_master m ON (bm.mfhd_id = m.mfhd_id)
	LEFT OUTER JOIN mfhd_item mi ON (m.mfhd_id = mi.mfhd_id)
	LEFT OUTER JOIN item i ON (mi.item_id = i.item_id)
	LEFT OUTER JOIN item_type it ON (i.item_type_id = it.item_type_id)
	JOIN location l ON (m.location_id = l.location_id)
	JOIN VOYAPPS.VOYLOCS v ON (v.locid = l.location_id)
WHERE
	--SWITCH=:FY_YEAR
	--CASE=NOW
	b.suppress_in_opac = 'N'
	AND m.suppress_in_opac = 'N'
	AND i.item_id NOT IN (SELECT s.item_id FROM item_status s WHERE s.item_status IN (12, 13, 14, 17) AND s.item_id = i.item_id)
	--ELSE
	-- Created before the end of the fiscal year
	:FY_YEAR > 0 
	AND b.create_date < TO_DATE(:FY_YEAR||'-07-01')
	AND m.create_date < TO_DATE(:FY_YEAR||'-07-01')
	AND (i.create_date < TO_DATE(:FY_YEAR||'-07-01') OR i.create_date IS NULL)
	AND i.item_id NOT IN (SELECT s.item_id FROM item_status s WHERE s.item_status IN (12, 13, 14, 17) AND s.item_id = i.item_id AND s.item_status_date < TO_DATE(:FY_YEAR||'-07-01'))
	-- the last time, prior to the end of the fiscal year, that the BIB was unsuppressed 
	AND (
		SELECT MAX(bh.ACTION_DATE)
		FROM BIB_HISTORY bh
		WHERE bh.SUPPRESS_IN_OPAC = 'N' AND bh.ACTION_DATE < TO_DATE(:FY_YEAR||'-07-01') AND bh.BIB_ID = b.BIB_ID
	)
	-- is after or at
	>=      
	-- the last time the, prior to the end of the fiscal year, the BIB was suppressed (or the record creation date if never suppressed)
	(       
		SELECT MAX(bh.ACTION_DATE)
		FROM BIB_HISTORY bh
		WHERE (bh.ACTION_TYPE_ID = 1 OR bh.SUPPRESS_IN_OPAC = 'Y') AND bh.ACTION_DATE < TO_DATE(:FY_YEAR||'-07-01') AND bh.BIB_ID = b.BIB_ID
	)
	-- the last time, prior to the end of the fiscal year, that the MFHD was unsuppressed 
	AND (
		SELECT MAX(mh.ACTION_DATE)
		FROM MFHD_HISTORY mh
		WHERE mh.SUPPRESS_IN_OPAC = 'N' AND mh.ACTION_DATE < TO_DATE(:FY_YEAR||'-07-01') AND mh.MFHD_ID = m.MFHD_ID
	)
	-- is after or at
	>=      
	-- the last time the, prior to the end of the fiscal year, the MFHD was suppressed (or the record creation date if never suppressed)
	(       
		SELECT MAX(mh.ACTION_DATE)
		FROM MFHD_HISTORY mh
		WHERE (mh.ACTION_TYPE_ID = 1 OR mh.SUPPRESS_IN_OPAC = 'Y') AND mh.ACTION_DATE < TO_DATE(:FY_YEAR||'-07-01') AND mh.mfhd_id = m.MFHD_ID
	)
	--END
	-- Exclude any titles which are loaned DDA/PDA
	AND NOT l.location_code in ('webdda', 'wpicwebb')
	-- Exclude "titles" which are really equipment or not owned locally
	AND (i.item_id IS NULL OR NOT (it.item_type_code LIKE '%Equip%' OR it.item_type_code in ('HL ER', 'Misc Tech') OR it.item_type_code IN ('PALCI', 'ILL')))
	-- Exclude microform
	AND NOT (bt.bib_format in ('aa', 'ta', 'ac', 'tc', 'ad', 'td', 'am', 'tm', 'ab', 'ai', 'as') AND SUBSTR(bt.field_008, 24, 1) in ('a', 'b'))
	-- Exclude maps
	AND NOT (REGEXP_LIKE(bt.bib_format, '[ef].') AND SUBSTR(bt.field_008, 26, 1) != 'e')
	-- Exclude nonprint
	AND NOT REGEXP_LIKE(bt.bib_format, '[gkorm].')
	-- ARL Volumes Held Flag
	AND v.ARLVOLH = 'Y'
	-- Law mixes ebooks with eserials, so exclude eserials for thier location(s)
	AND NOT (l.location_code = 'lawnet' AND bt.bib_format != 'am')
GROUP BY
	v.ARLEB,
	CASE
		WHEN l.library_id = 7 THEN 'Law'
		WHEN l.library_id = 10 THEN 'HSLS'
		WHEN l.library_id in (1, 2, 5, 6, 9, 11) THEN 'ULS'
		ELSE 'Err:' || l.library_id
	END
ORDER BY
	CASE
		WHEN l.library_id = 7 THEN 'Law'
		WHEN l.library_id = 10 THEN 'HSLS'
		WHEN l.library_id in (1, 2, 5, 6, 9, 11) THEN 'ULS'
		ELSE 'Err:' || l.library_id
	END DESC,
	v.ARLEB

