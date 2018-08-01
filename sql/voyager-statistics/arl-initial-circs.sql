SELECT
        COUNT(*) COUNT,
        CASE
                WHEN location.library_id = 7 THEN 'Law' 
                WHEN location.library_id = 10 THEN 'HSLS'
                WHEN location.library_id in (1, 2, 5, 6, 9, 11) THEN 'ULS'
                ELSE '' || location.library_id
        END library
FROM
        -- Check the transaction for the item type at the time of the transaction via the policy matrix, if possible
        -- Note that this UNION also creates a distinct select on item_id and charge_date, eliminating bound-with bib duplication
        (
                SELECT
                        c.item_id,
                        c.charge_date,
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
                        c.charge_date,
                        CASE WHEN m.item_type_id > 0 THEN m.item_type_id ELSE i.item_type_id END item_type_id,
                        c.patron_group_id,
                        c.charge_location
                FROM
                        circ_trans_archive c
                        LEFT OUTER JOIN circ_policy_matrix m ON (m.circ_policy_matrix_id = c.circ_policy_matrix_id)
                        LEFT OUTER JOIN item i ON (c.item_id = i.item_id)
        ) ct
        -- Join the charge location for the association with the library system
        LEFT OUTER JOIN location ON (location.location_id = ct.charge_location)
WHERE
        -- Per fiscal year
        --IF=:FY_YEAR
        ct.charge_date BETWEEN TO_DATE(:FY_YEAR-1||'-07-01') AND TO_DATE(:FY_YEAR||'-07-01')
        --ELSE
        1 = 0
        --END
        -- Remove "InLibrary" and "University Department" use (certain transfers, technical processing) by patron group
        -- Remove "ILL" and "PALCI" use (per ARL clarification) by patron group
        AND ct.patron_group_id NOT IN (23, 27, 25, 32)
        -- Remove reserve transactions
        AND ct.item_type_id NOT IN (SELECT item_type.item_type_id FROM item_type WHERE item_type.item_type_code LIKE 'Reserve%')
        -- Remove items not considered the "general collection"
        AND ct.item_type_id NOT IN (SELECT item_type.item_type_id FROM item_type WHERE item_type.item_type_code LIKE '%Equip%' OR item_type.item_type_code in ('HL ER', 'Misc Tech') OR item_type_code IN ('PALCI', 'ILL'))
GROUP BY
        CASE
                WHEN location.library_id = 7 THEN 'Law' 
                WHEN location.library_id = 10 THEN 'HSLS'
                WHEN location.library_id in (1, 2, 5, 6, 9, 11) THEN 'ULS'
                ELSE '' || location.library_id
        END
