SELECT
        CASE WHEN m.call_no_type = '0' THEN REGEXP_REPLACE(m.normalized_call_no, ' .*', '') WHEN m.normalized_call_no LIKE 'BD-%' OR m.normalized_call_no LIKE 'CD %' OR m.normalized_call_no LIKE 'DVD-%' OR m.normalized_call_no LIKE 'DVD %' OR m.normalized_call_no LIKE 'V-%' OR m.normalized_call_no LIKE 'VIDEORECORDING %' THEN 'A/V Material' ELSE 'Unclassified' END call_no_prefix,
	COUNT(*) current_count,
	SUM(CASE WHEN i.create_date IS NULL or i.create_date < TO_DATE(TO_CHAR(CASE WHEN EXTRACT(MONTH FROM SYSDATE) >= 7 THEN SYSDATE ELSE SYSDATE - 365 END, 'YYYY') || '-07-01', 'YYYY-MM-DD') THEN 1 ELSE 0 END) year_old,
	SUM(CASE WHEN i.create_date IS NULL or i.create_date < TO_DATE(TO_CHAR(CASE WHEN EXTRACT(MONTH FROM SYSDATE) >= 7 THEN SYSDATE ELSE SYSDATE - 365 END, 'YYYY') || '-07-01', 'YYYY-MM-DD') - 365 THEN 1 ELSE 0 END) two_year_old,
	SUM(CASE WHEN i.create_date IS NULL or i.create_date < TO_DATE(TO_CHAR(CASE WHEN EXTRACT(MONTH FROM SYSDATE) >= 7 THEN SYSDATE ELSE SYSDATE - 365 END, 'YYYY') || '-07-01', 'YYYY-MM-DD') - 365 * 2 THEN 1 ELSE 0 END) three_year_old
FROM
        item i JOIN
        mfhd_item mi ON (i.item_id = mi.item_id) JOIN
        bib_item bi ON (i.item_id = bi.item_id) JOIN
        mfhd_master m ON (mi.mfhd_id = m.mfhd_id) JOIN
        bib_text bt ON (bi.bib_id = bt.bib_id) JOIN
        bib_master bm ON (bi.bib_id = bm.bib_id) JOIN
        location pl ON (i.perm_location = pl.location_id) JOIN
	library l ON (l.library_id = pl.library_id)
WHERE
        l.nuc_code LIKE 'PPiU%' AND l.nuc_code NOT IN ('PPiU-L', 'PPiU-H') AND
        bm.suppress_in_opac = 'N' AND
        m.suppress_in_opac = 'N'
GROUP BY
        CASE WHEN m.call_no_type = '0' THEN REGEXP_REPLACE(m.normalized_call_no, ' .*', '') WHEN m.normalized_call_no LIKE 'BD-%' OR m.normalized_call_no LIKE 'CD %' OR m.normalized_call_no LIKE 'DVD-%' OR m.normalized_call_no LIKE 'DVD %' OR m.normalized_call_no LIKE 'V-%' OR m.normalized_call_no LIKE 'VIDEORECORDING %' THEN 'A/V Material' ELSE 'Unclassified' END
ORDER BY
        CASE WHEN m.call_no_type = '0' THEN REGEXP_REPLACE(m.normalized_call_no, ' .*', '') WHEN m.normalized_call_no LIKE 'BD-%' OR m.normalized_call_no LIKE 'CD %' OR m.normalized_call_no LIKE 'DVD-%' OR m.normalized_call_no LIKE 'DVD %' OR m.normalized_call_no LIKE 'V-%' OR m.normalized_call_no LIKE 'VIDEORECORDING %' THEN 'A/V Material' ELSE 'Unclassified' END
