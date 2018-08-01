SELECT
	TO_CHAR(i.item_id)||TO_CHAR(cv.charge_date_time, 'YYYYMMDDHH24MISS') row_id,
	cv.charge_date_time,
	l.location_name charge_location_name,
	DECODE(p.patron_group_name, 'PhDissertation', 'UPGrad', 'UP Grad Law', 'UPGrad', 'UPfacLaw', 'UPFac', p.patron_group_name) patron_group_name,
	CASE WHEN m.call_no_type = '0' THEN REGEXP_REPLACE(m.normalized_call_no, ' .*', '') WHEN m.normalized_call_no LIKE 'BD-%' OR m.normalized_call_no LIKE 'CD %' OR m.normalized_call_no LIKE 'DVD-%' OR m.normalized_call_no LIKE 'DVD %' OR m.normalized_call_no LIKE 'V-%' OR m.normalized_call_no LIKE 'VIDEORECORDING %' THEN 'A/V Material' ELSE 'Unclassified' END call_no_prefix,
	bt.title_brief,
	pl.location_display_name perm_location,
	tl.location_display_name temp_location,
	mi.item_enum,
	mi.chron
FROM
        -- Check the transaction for the item type at the time of the transaction via the policy matrix, if possible
        (
                SELECT
                        c.item_id,
                        c.charge_date charge_date_time,
                        CASE WHEN m.item_type_id > 0 THEN m.item_type_id ELSE i.item_type_id END item_type_id,
                        c.patron_group_id,
                        c.charge_location
                FROM
                        circ_transactions c
                        LEFT OUTER JOIN circ_policy_matrix m ON (m.circ_policy_matrix_id = c.circ_policy_matrix_id)
                        LEFT OUTER JOIN item i ON (c.item_id = i.item_id)
                UNION
                SELECT
                        c.item_id,
                        c.charge_date charge_date_time,
                        CASE WHEN m.item_type_id > 0 THEN m.item_type_id ELSE i.item_type_id END item_type_id,
                        c.patron_group_id,
                        c.charge_location
                FROM
                        circ_trans_archive c
                        LEFT OUTER JOIN circ_policy_matrix m ON (m.circ_policy_matrix_id = c.circ_policy_matrix_id)
                        LEFT OUTER JOIN item i ON (c.item_id = i.item_id)
        ) cv
	JOIN patron_group p ON (cv.patron_group_id = p.patron_group_id)
	JOIN location l ON (cv.charge_location = l.location_id)
	JOIN item i ON (cv.item_id = i.item_id)
	JOIN item_type it ON (it.item_type_id = cv.item_type_id)
	JOIN mfhd_item mi ON (cv.item_id = mi.item_id)
	JOIN mfhd_master m ON (mi.mfhd_id = m.mfhd_id)
	JOIN bib_mfhd bm ON (bm.mfhd_id = mi.mfhd_id)
	JOIN bib_text bt ON (bm.bib_id = bt.bib_id)
	JOIN location pl ON (i.perm_location = pl.location_id)
	LEFT OUTER JOIN location tl ON (i.temp_location = tl.location_id)
WHERE
	cv.charge_date_time BETWEEN TO_DATE(:start_date) and TO_DATE(:end_date) + 1
	AND l.location_code NOT IN ('wpicavCI','chpCI','falkmCI','falkCI','hillillCI','wpicCI','palciCI','shadCI','lawCI')
	AND p.patron_group_name NOT IN ('ILL')
	AND it.item_type_code NOT LIKE 'Reserve%'
	AND it.item_type_code NOT LIKE '%Equip%'
	AND it.item_type_code NOT IN ('Misc Tech', 'HL ER', 'PALCI', 'ILL')

