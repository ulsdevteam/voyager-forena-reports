SELECT
        COUNT(DISTINCT NVL(duplicate_bib.bib_id, bib_master.bib_id)) COUNT,
        CASE
                WHEN bib_master.library_id = 7 THEN 'Law'
                WHEN bib_master.library_id = 10 THEN 'HSLS'
                WHEN bib_master.library_id in (1, 2, 5, 6, 9, 11) THEN 'ULS'
                ELSE 'Err:' || bib_master.library_id
        END library
FROM
        bib_master
        -- deduplicate by selecting an arbitrary (minimum) bib_id as "primary"
        LEFT OUTER JOIN (
                SELECT
                        MIN(duplicate_bibs.bib_id) bib_id,
                        duplicate_bibs.duplicate_id
                FROM
                        voyapps.duplicate_bibs
                GROUP BY
                        duplicate_bibs.duplicate_id
        ) duplicate_bib ON (duplicate_bib.duplicate_id = bib_master.bib_id)
WHERE
        -- Created before the end of the fiscal year
        --SWITCH=:FY_YEAR
        --CASE=NOW
        bib_master.suppress_in_opac = 'N'
        --ELSE
        bib_master.create_date < TO_DATE(:FY_YEAR||'-07-01')
        -- the last time, prior to the end of the fiscal year, that the record was unsuppressed 
        AND (
                SELECT
                        MAX(BIB_HISTORY.ACTION_DATE)
                FROM
                        BIB_HISTORY
                WHERE
                        BIB_HISTORY.SUPPRESS_IN_OPAC = 'N'
                        AND BIB_HISTORY.ACTION_DATE < TO_DATE(:FY_YEAR||'-07-01')
                        AND BIB_HISTORY.BIB_ID = BIB_MASTER.BIB_ID
        )
        -- is after or at
        >=
        -- the last time the, prior to the end of the fiscal year, that the record was suppressed (or the record creation date if never suppressed)
        (
                SELECT
                        MAX(BIB_HISTORY.ACTION_DATE)
                FROM
                        BIB_HISTORY
                WHERE
                        (BIB_HISTORY.ACTION_TYPE_ID = 1 OR BIB_HISTORY.SUPPRESS_IN_OPAC = 'Y')
                        AND BIB_HISTORY.ACTION_DATE < TO_DATE(:FY_YEAR||'-07-01')
                        AND BIB_HISTORY.BIB_ID = BIB_MASTER.BIB_ID
        )
        --END
        -- Exclude any titles which are loaned DDA/PDA
        AND bib_master.bib_id NOT IN (
                SELECT
                        bib_mfhd.bib_id
                FROM
                        bib_mfhd
                        JOIN mfhd_master ON (bib_mfhd.mfhd_id = mfhd_master.mfhd_id)
                        JOIN location ON (mfhd_master.location_id = location.location_id AND location.location_code IN ('webdda', 'wpicwebb'))
                        LEFT OUTER JOIN mfhd_master xmfhd_master ON (bib_mfhd.mfhd_id = xmfhd_master.mfhd_id AND mfhd_master.mfhd_id != xmfhd_master.mfhd_id)
                        LEFT OUTER JOIN location xlocation ON (xmfhd_master.location_id = xlocation.location_id AND xlocation.location_code NOT IN ('webdda', 'wpicwebb'))
                WHERE
                        xlocation.location_id IS NULL
        )
        -- Exclude "titles" which are really equipment or not owned locally
        AND bib_master.bib_id NOT IN (
                SELECT
                        bib_item.bib_id
                FROM
                        bib_item
                        JOIN item ON (bib_item.item_id = item.item_id)
                        JOIN item_type ON (item.item_type_id = item_type.item_type_id AND (item_type.item_type_code LIKE '%Equip%' OR item_type.item_type_code in ('HL ER', 'Misc Tech') OR item_type.item_type_code IN ('PALCI', 'ILL')))
                        LEFT OUTER JOIN item xitem ON (bib_item.item_id = xitem.item_id AND item.item_id != xitem.item_id)
                        LEFT OUTER JOIN item_type xitem_type ON (xitem.item_type_id = xitem_type.item_type_id AND NOT (xitem_type.item_type_code LIKE '%Equip%' OR xitem_type.item_type_code in ('HL ER', 'Misc Tech') OR xitem_type.item_type_code IN ('PALCI', 'ILL')))
                WHERE
                        xitem_type.item_type_id IS NULL
        )
GROUP BY
        CASE
                WHEN bib_master.library_id = 7 THEN 'Law'
                WHEN bib_master.library_id = 10 THEN 'HSLS'
                WHEN bib_master.library_id in (1, 2, 5, 6, 9, 11) THEN 'ULS'
                ELSE 'Err:' || bib_master.library_id
        END
ORDER BY
        CASE
                WHEN bib_master.library_id = 7 THEN 'Law'
                WHEN bib_master.library_id = 10 THEN 'HSLS'
                WHEN bib_master.library_id in (1, 2, 5, 6, 9, 11) THEN 'ULS'
                ELSE 'Err:' || bib_master.library_id
        END DESC
