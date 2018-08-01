--ACCESS=access content
SELECT
	location.location_id,
	location.location_code || ' - ' || location.location_name location_key,
	COUNT(*) item_count,
	(COUNT(*) - SUM(CASE WHEN mfhd_master.location_id = item.perm_location THEN 1 ELSE 0 END)) item_discrepancy,
	(COUNT(*) - SUM(CASE WHEN mfhd_master.location_id = item.perm_location THEN 1 ELSE 0 END)) / COUNT(*) * 100 discrepancy_percent
FROM
	mfhd_master JOIN
	mfhd_item USING (mfhd_id) JOIN
	item USING (item_id) JOIN
	location ON (location.location_id = mfhd_master.location_id)
WHERE
	mfhd_master.suppress_in_opac != 'Y'
GROUP BY
	location.location_id,
	location.location_code || ' - ' || location.location_name
UNION
SELECT
	-1,
	'[All Locations]' location_key,
	COUNT(*) item_count,
	(COUNT(*) - SUM(CASE WHEN mfhd_master.location_id = item.perm_location THEN 1 ELSE 0 END)) item_discrepancy,
	(COUNT(*) - SUM(CASE WHEN mfhd_master.location_id = item.perm_location THEN 1 ELSE 0 END)) / COUNT(*) * 100 discrepancy_percent
FROM
	mfhd_master JOIN
	mfhd_item USING (mfhd_id) JOIN
	item USING (item_id) JOIN
	location ON (location.location_id = mfhd_master.location_id)
WHERE
	mfhd_master.suppress_in_opac != 'Y'
ORDER BY
	location_key
