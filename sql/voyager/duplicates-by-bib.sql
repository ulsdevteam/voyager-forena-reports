SELECT
        NVL(temp_location.location_code, perm_location.location_code) item_location,
        mfhd_master.normalized_call_no,
        mfhd_master.display_call_no,
        mfhd_item.item_enum,
        mfhd_item.chron,
        mfhd_item.year,
        item.copy_number,
        item_barcode.item_barcode,
        bib_text.begin_pub_date,
        bib_text.title_brief,
        bib_text.author,
        bib_text.edition,
        item.historical_charges,
        item.historical_browses,
        (SELECT max(v.charge_date_only) FROM circcharges_vw v WHERE v.item_id = item.item_id) last_charged,
        (SELECT v.item_status_desc FROM (SELECT t.item_status_desc, s.item_id FROM item_status_type t JOIN item_status s ON (t.item_status_type = s.item_status) ORDER BY s.item_status_date DESC) v where v.item_id = item.item_id and ROWNUM = 1) item_status_desc,
        (SELECT v.item_status_date FROM (SELECT s.item_status_date, s.item_id FROM item_status s ORDER BY s.item_status_date DESC) v WHERE v.item_id = item.item_id AND ROWNUM = 1) item_status_date,
        mfhd_location.location_code mfhd_location,
        item.item_id,
        mfhd_master.mfhd_id,
        bib_master.bib_id
FROM
        bib_mfhd
	JOIN bib_master ON (bib_mfhd.bib_id = bib_master.bib_id)
	JOIN bib_text ON (bib_mfhd.bib_id = bib_text.bib_id)
	JOIN mfhd_master ON (bib_mfhd.mfhd_id = mfhd_master.mfhd_id)
	JOIN mfhd_item ON (bib_mfhd.mfhd_id = mfhd_item.mfhd_id)
	JOIN item ON (item.item_id = mfhd_item.item_id)
	LEFT OUTER JOIN item_barcode ON (item.item_id = item_barcode.item_id)
	JOIN location perm_location ON (item.perm_location = perm_location.location_id)
	LEFT OUTER JOIN location temp_location ON (item.temp_location = temp_location.location_id)
	JOIN location mfhd_location ON (mfhd_master.location_id = mfhd_location.location_id)
WHERE
	perm_location.location_id in :location_list AND
        bib_master.suppress_in_opac = 'N' AND
        mfhd_master.suppress_in_opac = 'N' AND
	item.item_id NOT IN (SELECT s.item_id FROM item_status s WHERE s.item_status IN (12, 13, 14, 17)) AND
	bib_master.bib_id IN (
		SELECT
			b.bib_id
		FROM
			bib_master b
			JOIN bib_mfhd bm ON (b.bib_id = bm.bib_id)
			JOIN mfhd_master m ON (m.mfhd_id = bm.mfhd_id)
			JOIN mfhd_item mi ON (m.mfhd_id = mi.mfhd_id)
			JOIN item i ON (mi.item_id = i.item_id)
			JOIN location l ON (i.perm_location = l.location_id)
		WHERE
			b.suppress_in_opac = 'N'
			AND m.suppress_in_opac = 'N'
			AND i.item_id NOT IN (SELECT s.item_id FROM item_status s WHERE s.item_status IN (12, 13, 14, 17))
			AND l.location_id in :location_list
		GROUP BY
			b.bib_id,
			mi.item_enum,
			mi.chron,
			mi.year
		HAVING
			COUNT(*) > 1
	)
ORDER BY
	bib_master.bib_id,
        mfhd_master.normalized_call_no,
        mfhd_item.item_enum,
        mfhd_item.chron,
        mfhd_item.year,
        item.item_id
--INFO
type[location_list]=array
