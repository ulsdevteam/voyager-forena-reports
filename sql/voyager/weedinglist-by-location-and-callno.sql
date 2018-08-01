SELECT
	NVL(tl.location_code, pl.location_code) item_location,
	m.normalized_call_no,
	m.display_call_no,
	mi.item_enum,
	mi.chron,
	mi.year,
	i.copy_number,
	ib.item_barcode,
	bt.begin_pub_date,
	bt.title_brief,
	bt.author,
	bt.edition,
	i.historical_charges,
	i.historical_browses,
	(SELECT max(v.charge_date_only) FROM (SELECT TRUNC(xct.charge_date) charge_date_only, xct.item_id FROM circ_transactions xct UNION SELECT TRUNC(xcta.charge_date) charge_date_only, xcta.item_id FROM circ_trans_archive xcta) v WHERE v.item_id = i.item_id) last_charged,
	(SELECT v.item_status_desc FROM (SELECT t.item_status_desc, s.item_id FROM item_status_type t JOIN item_status s ON (t.item_status_type = s.item_status) ORDER BY s.item_status_date DESC) v where v.item_id = i.item_id and ROWNUM = 1) item_status_desc,
	(SELECT v.item_status_date FROM (SELECT s.item_status_date, s.item_id FROM item_status s ORDER BY s.item_status_date DESC) v WHERE v.item_id = i.item_id AND ROWNUM = 1) item_status_date,
	ml.location_code mfhd_location,
	i.item_id,
	m.mfhd_id,
	b.bib_id,
	--IF=:duplicate_list
	(
		SELECT
			MIN(xi.item_id)
		FROM
			item xi
			JOIN mfhd_item xmi ON (xi.item_id = xmi.item_id)
			JOIN mfhd_master xm ON (xm.mfhd_id = xmi.mfhd_id)
			JOIN bib_mfhd xbm ON (xbm.mfhd_id = xmi.mfhd_id)
		WHERE
			xi.item_id != i.item_id
			AND xbm.bib_id = bm.bib_id
			AND xm.suppress_in_opac = 'N'
			AND xi.item_id NOT IN (SELECT s.item_id FROM item_status s WHERE s.item_status IN (12, 13, 14, 17))
			AND NVL(xmi.item_enum, ' ') = NVL(mi.item_enum, ' ')
			AND NVL(xmi.chron, ' ') = NVL(mi.chron, ' ')
			AND NVL(xmi.year, ' ') = NVL(mi.year, ' ')
			AND xi.perm_location IN :duplicate_list
	) duplicate_there,
	--ELSE
	'' duplicate_there,
	--END
	--IF=:these_duplicates
	(
		SELECT
			MIN(xi.item_id)
		FROM
			item xi
			JOIN mfhd_item xmi ON (xi.item_id = xmi.item_id)
			JOIN mfhd_master xm ON (xm.mfhd_id = xmi.mfhd_id)
			JOIN bib_mfhd xbm ON (xbm.mfhd_id = xmi.mfhd_id)
		WHERE
			xi.item_id != i.item_id
			AND xbm.bib_id = bm.bib_id
			AND xm.suppress_in_opac = 'N'
			AND xi.item_id NOT IN (SELECT s.item_id FROM item_status s WHERE s.item_status IN (12, 13, 14, 17))
			AND NVL(xmi.item_enum, ' ') = NVL(mi.item_enum, ' ')
			AND NVL(xmi.chron, ' ') = NVL(mi.chron, ' ')
			AND NVL(xmi.year, ' ') = NVL(mi.year, ' ')
			AND xi.perm_location IN :location_list
	) duplicate_here,
	--ELSE
	'' duplicate_here,
	--END
	--IF=:other_list
	(
		SELECT
			MIN(xi.item_id)
		FROM
			item xi
			JOIN mfhd_item xmi ON (xi.item_id = xmi.item_id)
			JOIN mfhd_master xm ON (xm.mfhd_id = xmi.mfhd_id)
			JOIN bib_mfhd xbm ON (xbm.mfhd_id = xmi.mfhd_id)
		WHERE
			xi.item_id != i.item_id
			AND xbm.bib_id = bm.bib_id
			AND xm.suppress_in_opac = 'N'
			AND xi.item_id NOT IN (SELECT s.item_id FROM item_status s WHERE s.item_status IN (12, 13, 14, 17))
			AND NVL(xmi.item_enum, ' ') = NVL(mi.item_enum, ' ')
			AND NVL(xmi.chron, ' ') = NVL(mi.chron, ' ')
			AND NVL(xmi.year, ' ') = NVL(mi.year, ' ')
			AND xi.perm_location IN :other_list
	) duplicate_other,
	--ELSE
	'' duplicate_other,
	--END
	(
		SELECT
			MIN(CASE WHEN i.item_id < xi.item_id THEN i.item_id ELSE xi.item_id END)
		FROM
			item xi
			JOIN mfhd_item xmi ON (xi.item_id = xmi.item_id)
			JOIN mfhd_master xm ON (xm.mfhd_id = xmi.mfhd_id)
			JOIN bib_mfhd xbm ON (xbm.mfhd_id = xmi.mfhd_id)
		WHERE
			xi.item_id != i.item_id
			AND xbm.bib_id = bm.bib_id
			AND xm.suppress_in_opac = 'N'
			AND xi.item_id NOT IN (SELECT s.item_id FROM item_status s WHERE s.item_status IN (12, 13, 14, 17))
			AND (NVL(xmi.item_enum, ' ') > ' ' OR NVL(xmi.chron, ' ') > ' ' OR NVL(xmi.year, ' ') > ' ')
			AND ((NVL(xmi.item_enum, ' ') != NVL(mi.item_enum, ' ') OR NVL(xmi.chron, ' ') != NVL(mi.chron, ' ') OR NVL(xmi.year, ' ') != NVL(mi.year, ' ')))
			AND xi.perm_location IN :location_list
	) shelved_with
FROM
	bib_mfhd bm
	JOIN bib_master b ON (bm.bib_id = b.bib_id)
	JOIN bib_text bt ON (bm.bib_id = bt.bib_id) JOIN
	mfhd_master m ON (bm.mfhd_id = m.mfhd_id)
	JOIN mfhd_item mi ON (bm.mfhd_id = mi.mfhd_id)
	JOIN item i ON (i.item_id = mi.item_id)
	LEFT OUTER JOIN item_barcode ib ON (i.item_id = ib.item_id AND ib.barcode_status = 1)
	JOIN location pl ON (i.perm_location = pl.location_id)
	LEFT OUTER JOIN location tl ON (i.temp_location = tl.location_id)
	JOIN location ml ON (m.location_id = ml.location_id)
	JOIN location l ON (i.perm_location = l.location_id)
WHERE
	l.location_id IN :location_list
	AND b.suppress_in_opac = 'N'
	AND m.suppress_in_opac = 'N'
	AND (m.normalized_call_no BETWEEN :start_call||' ' AND :end_call||'~' OR (:include_missing_callno = '1' AND m.normalized_call_no IS NULL))
	AND i.item_id NOT IN (SELECT s.item_id FROM item_status s WHERE s.item_status IN (12, 13, 14, 17))
	--IF:weeding
	AND (
		(
			AND REGEXP_LIKE(bt.begin_pub_date, '[0-9]{4}')
			AND bt.begin_pub_date <= '2005'
			AND (SELECT max(v.charge_date_only) FROM (SELECT TRUNC(xct.charge_date) charge_date_only, xct.item_id FROM circ_transactions xct UNION SELECT TRUNC(xcta.charge_date) charge_date_only, xcta.item_id FROM circ_trans_archive xcta) v WHERE v.item_id = i.item_id) < '2006-01-01'
		)
		OR (
			AND REGEXP_LIKE(bt.begin_pub_date, '[0-9]{4}')
			AND bt.begin_pub_date <= '2005'
			AND NVL(i.historical_charges, 0) < 2
		)
		OR (
			AND REGEXP_LIKE(bt.begin_pub_date, '[0-9]{4}')
			AND bt.begin_pub_date <= '2010'
			AND (SELECT max(v.charge_date_only) FROM (SELECT TRUNC(xct.charge_date) charge_date_only, xct.item_id FROM circ_transactions xct UNION SELECT TRUNC(xcta.charge_date) charge_date_only, xcta.item_id FROM circ_trans_archive xcta) v WHERE v.item_id = i.item_id) IS NULL
			AND NVL(i.historical_charges, 0) = 0
		)
	) AND NOT EXISTS (
		SELECT
			xi.item_id
		FROM
			item xi
			JOIN mfhd_item xmi ON (xi.item_id = xmi.item_id)
			JOIN mfhd_master xm ON (xm.mfhd_id = xmi.mfhd_id)
			JOIN bib_mfhd xbm ON (xbm.mfhd_id = xmi.mfhd_id)
		WHERE
			xi.item_id != i.item_id
			AND xbm.bib_id = bm.bib_id
			AND xm.suppress_in_opac = 'N'
			AND xi.item_id NOT IN (SELECT s.item_id FROM item_status s WHERE s.item_status IN (12, 13, 14, 17))
			AND (NVL(xmi.item_enum, ' ') > ' ' OR NVL(xmi.chron, ' ') > ' ' OR NVL(xmi.year, ' ') > ' ')
			AND ((NVL(xmi.item_enum, ' ') != NVL(mi.item_enum, ' ') OR NVL(xmi.chron, ' ') != NVL(mi.chron, ' ') OR NVL(xmi.year, ' ') != NVL(mi.year, ' ')))
			AND xi.perm_location IN :location_list
			AND (
				(
					AND REGEXP_LIKE(bt.begin_pub_date, '[0-9]{4}')
					AND bt.begin_pub_date <= '2005'
					AND (SELECT max(v.charge_date_only) FROM (SELECT TRUNC(xct.charge_date) charge_date_only, xct.item_id FROM circ_transactions xct UNION SELECT TRUNC(xcta.charge_date) charge_date_only, xcta.item_id FROM circ_trans_archive xcta) v WHERE v.item_id = xi.item_id) < '2006-01-01'
				)
				OR (
					AND REGEXP_LIKE(bt.begin_pub_date, '[0-9]{4}')
					AND bt.begin_pub_date <= '2005'
					AND NVL(xi.historical_charges, 0) < 2
				)
				OR (
					AND REGEXP_LIKE(bt.begin_pub_date, '[0-9]{4}')
					AND bt.begin_pub_date <= '2010'
					AND (SELECT max(v.charge_date_only) FROM (SELECT TRUNC(xct.charge_date) charge_date_only, xct.item_id FROM circ_transactions xct UNION SELECT TRUNC(xcta.charge_date) charge_date_only, xcta.item_id FROM circ_trans_archive xcta) v WHERE v.item_id = xi.item_id) IS NULL
					AND NVL(xi.historical_charges, 0) = 0
				)
			)
	)
	--END
ORDER BY
	m.normalized_call_no,
	mi.item_enum,
	mi.chron,
	mi.year,
	i.item_id
--INFO
type[location_list]=array
type[duplicate_list]=array
type[other_list]=array
