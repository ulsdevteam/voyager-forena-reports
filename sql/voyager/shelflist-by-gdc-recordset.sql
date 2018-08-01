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
	mfhd_master.suppress_in_opac mfhd_suppressed,
	bib_master.bib_id,
	bib_master.suppress_in_opac bib_suppressed
FROM
	record_set_records
	JOIN record_set ON (record_set_records.record_set_id = record_set.record_set_id)
	JOIN bib_mfhd ON ((record_set_records.record_id = bib_mfhd.bib_id AND record_set.record_type_id = 1) OR (record_set_records.record_id = bib_mfhd.mfhd_id AND record_set.record_type_id = 2))
	JOIN bib_master ON (bib_mfhd.bib_id = bib_master.bib_id)
	JOIN bib_text ON (bib_mfhd.bib_id = bib_text.bib_id)
	JOIN mfhd_master ON (bib_mfhd.mfhd_id = mfhd_master.mfhd_id)
	LEFT OUTER JOIN (
		mfhd_item
		JOIN item ON (item.item_id = mfhd_item.item_id)
		LEFT OUTER JOIN item_barcode ON (item.item_id = item_barcode.item_id AND item_barcode.barcode_status = 1)
		JOIN location perm_location ON (item.perm_location = perm_location.location_id)
		LEFT OUTER JOIN location temp_location ON (item.temp_location = temp_location.location_id)
	) ON (bib_mfhd.mfhd_id = mfhd_item.mfhd_id)
	JOIN location mfhd_location ON (mfhd_master.location_id = mfhd_location.location_id)
WHERE
	record_set.record_set_id = :recordsetid
ORDER BY
	mfhd_master.normalized_call_no,
	mfhd_item.item_enum,
	mfhd_item.chron,
	mfhd_item.year,
	item.item_id
