--ACCESS=access content
SELECT DISTINCT
	mfhd_master.mfhd_id,
	bib_mfhd.bib_id
FROM
	mfhd_master JOIN
	bib_mfhd ON (mfhd_master.mfhd_id = bib_mfhd.mfhd_id) LEFT OUTER JOIN
	bib_master ON (bib_mfhd.bib_id = bib_master.bib_id AND bib_master.suppress_in_opac = 'N')
WHERE
	mfhd_master.suppress_in_opac = 'N' AND
	bib_master.suppress_in_opac IS NULL

