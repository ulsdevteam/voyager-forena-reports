--ACCESS=access content
SELECT DISTINCT
	bib_master.bib_id,
	bib_mfhd.mfhd_id
FROM
	bib_master JOIN
	bib_mfhd ON (bib_master.bib_id = bib_mfhd.bib_id) LEFT OUTER JOIN
	mfhd_master ON (bib_mfhd.mfhd_id = mfhd_master.mfhd_id AND mfhd_master.suppress_in_opac = 'N')
WHERE
	bib_master.suppress_in_opac = 'N' AND
	mfhd_master.suppress_in_opac IS NULL
