--ACCESS=access content
SELECT
                V.LIBNAME1 "OWN_Lib",
                L.LOCATION_CODE "Location_Code",
                L.LOCATION_NAME "Location_Name",
                CASE WHEN L.LOCATION_DISPLAY_NAME IS NULL THEN ' ' ELSE L.LOCATION_DISPLAY_NAME END "Location_Display_Name",
                CASE WHEN ACT_CHG.ACTIVE_COUNT IS NULL THEN 0 ELSE ACT_CHG.ACTIVE_COUNT END "Active_Charges",
                CASE WHEN ARC_CHG.ARCHIVE_COUNT IS NULL THEN 0 ELSE ARC_CHG.ARCHIVE_COUNT END "Archive_Charges",
                CASE WHEN ACT_CHG.ACTIVE_COUNT IS NULL THEN 0 ELSE ACT_CHG.ACTIVE_COUNT END + CASE WHEN ARC_CHG.ARCHIVE_COUNT IS NULL THEN 0 ELSE ARC_CHG.ARCHIVE_COUNT END "Total_Charges",
                CASE WHEN ACT_RENEW.ACTIVE_COUNT IS NULL THEN 0 ELSE ACT_RENEW.ACTIVE_COUNT END "Active_Renewals",
                CASE WHEN ARC_RENEW.ARCHIVE_COUNT IS NULL THEN 0 ELSE ARC_RENEW.ARCHIVE_COUNT END "Archive_Renewals",
                CASE WHEN ACT_RENEW.ACTIVE_COUNT IS NULL THEN 0 ELSE ACT_RENEW.ACTIVE_COUNT END + CASE WHEN ARC_RENEW.ARCHIVE_COUNT IS NULL THEN 0 ELSE ARC_RENEW.ARCHIVE_COUNT END "Total_Renewals",
                CASE WHEN ACT_CHG.ACTIVE_COUNT IS NULL THEN 0 ELSE ACT_CHG.ACTIVE_COUNT END + CASE WHEN ARC_CHG.ARCHIVE_COUNT IS NULL THEN 0 ELSE ARC_CHG.ARCHIVE_COUNT END + CASE WHEN ACT_RENEW.ACTIVE_COUNT IS NULL THEN 0 ELSE ACT_RENEW.ACTIVE_COUNT END + CASE WHEN ARC_RENEW.ARCHIVE_COUNT IS NULL THEN 0 ELSE ARC_RENEW.ARCHIVE_COUNT END "TOTAL_Charges_and_Renewals"
FROM
VOYAPPS.VOYLOCS V JOIN
PITTDB.LOCATION L ON (V.LOCID = L.LOCATION_ID)
LEFT OUTER JOIN
(
SELECT
                CASE WHEN I.TEMP_LOCATION = 0 THEN I.PERM_LOCATION ELSE I.PERM_LOCATION END LOCATION_ID,
                COUNT(I.ITEM_ID) ACTIVE_COUNT FROM
                PITTDB.ITEM I
                JOIN PITTDB.CIRC_TRANSACTIONS C ON (I.ITEM_ID = C.ITEM_ID) WHERE
                C.CHARGE_DATE BETWEEN :startdate and :enddate
                GROUP BY
                CASE WHEN I.TEMP_LOCATION = 0 THEN I.PERM_LOCATION ELSE I.PERM_LOCATION END
) ACT_CHG
ON (ACT_CHG.LOCATION_ID = L.LOCATION_ID) LEFT OUTER JOIN ( SELECT
                CASE WHEN I.TEMP_LOCATION = 0 THEN I.PERM_LOCATION ELSE I.PERM_LOCATION END LOCATION_ID,
                COUNT(I.ITEM_ID) ARCHIVE_COUNT FROM
                PITTDB.ITEM I
                JOIN PITTDB.CIRC_TRANS_ARCHIVE C ON (I.ITEM_ID = C.ITEM_ID) WHERE
                C.CHARGE_DATE BETWEEN :startdate and :enddate
                GROUP BY
                CASE WHEN I.TEMP_LOCATION = 0 THEN I.PERM_LOCATION ELSE I.PERM_LOCATION END
) ARC_CHG
ON (ARC_CHG.LOCATION_ID = L.LOCATION_ID) LEFT OUTER JOIN ( SELECT
                CASE WHEN I.TEMP_LOCATION = 0 THEN I.PERM_LOCATION ELSE I.PERM_LOCATION END LOCATION_ID,
                COUNT(I.ITEM_ID) ACTIVE_COUNT FROM
                PITTDB.ITEM I
                JOIN PITTDB.CIRC_TRANSACTIONS C ON (I.ITEM_ID = C.ITEM_ID)
                JOIN PITTDB.RENEW_TRANSACTIONS R ON (R.CIRC_TRANSACTION_ID = C.CIRC_TRANSACTION_ID) WHERE
                R.RENEW_DATE BETWEEN :startdate and :enddate
                GROUP BY
                CASE WHEN I.TEMP_LOCATION = 0 THEN I.PERM_LOCATION ELSE I.PERM_LOCATION END
) ACT_RENEW
ON (ACT_RENEW.LOCATION_ID = L.LOCATION_ID) LEFT OUTER JOIN ( SELECT
                CASE WHEN I.TEMP_LOCATION = 0 THEN I.PERM_LOCATION ELSE I.PERM_LOCATION END LOCATION_ID,
                COUNT(I.ITEM_ID) ARCHIVE_COUNT FROM
                PITTDB.ITEM I
                JOIN PITTDB.CIRC_TRANS_ARCHIVE C ON (I.ITEM_ID = C.ITEM_ID)
                JOIN PITTDB.RENEW_TRANS_ARCHIVE R ON (C.CIRC_TRANSACTION_ID = R.CIRC_TRANSACTION_ID) WHERE
                R.RENEW_DATE BETWEEN :startdate and :enddate
                GROUP BY
                CASE WHEN I.TEMP_LOCATION = 0 THEN I.PERM_LOCATION ELSE I.PERM_LOCATION END
) ARC_RENEW
ON (ARC_RENEW.LOCATION_ID = L.LOCATION_ID) 
ORDER BY V.LIBNAME1, L.LOCATION_CODE ASC