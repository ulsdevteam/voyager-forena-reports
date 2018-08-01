SELECT
        l.location_code,
        l.location_name,
        l.location_display_name,
        v.arlvolh,
        v.arleb,
        CASE
                WHEN library_id = 7 THEN 'Law'
                WHEN library_id = 10 THEN 'HSLS'
                WHEN library_id in (1, 2, 5, 6, 9, 11) THEN 'ULS'
                ELSE 'Err:' || library_id
        END library
FROM
        location l
        LEFT OUTER JOIN voyapps.voylocs v ON (l.location_id = v.locid)
ORDER BY
        CASE
                WHEN library_id = 7 THEN 'Law'
                WHEN library_id = 10 THEN 'HSLS'
                WHEN library_id in (1, 2, 5, 6, 9, 11) THEN 'ULS'
                ELSE 'Err:' || library_id
        END DESC,
        l.location_code
