--ACCESS=access content
SELECT
        count(*) errors
FROM    
        bib_master JOIN
        bib_mfhd ON (bib_master.bib_id = bib_mfhd.bib_id) JOIN
        mfhd_master ON (bib_mfhd.mfhd_id = mfhd_master.mfhd_id) JOIN
        mfhd_item ON (mfhd_master.mfhd_id = mfhd_item.mfhd_id) JOIN
        item ON (mfhd_item.item_id = item.item_id) JOIN
        location mfhd_location ON (mfhd_master.location_id = mfhd_location.location_id) JOIN
        location item_location ON (item.perm_location = item_location.location_id)
WHERE   
        bib_master.suppress_in_opac != 'Y'
        AND mfhd_master.suppress_in_opac != 'Y'
        AND mfhd_master.location_id != item.perm_location
	AND (mfhd_master.location_id = :location_id OR :location_id = -1)
