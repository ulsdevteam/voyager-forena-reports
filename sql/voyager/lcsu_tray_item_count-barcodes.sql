--ACCESS=access content
-- Return of barcodes related to a specific tray in the highbay
-- this is queried from the voyager database
SELECT item_barcode.item_barcode
FROM pittdb.item, pittdb.item_barcode
WHERE REGEXP_LIKE (item.spine_label, 'R[0-9][0-9]-M[0-9][0-9]-S[0-9][0-9]-T[0-9][0-9]','i')
and SUBSTR(item.spine_label,1,3) like UPPER(:range)
and SUBSTR(item.spine_label,5,3) like UPPER(:module)
and SUBSTR(item.spine_label,9,3) like UPPER(:shelf)
and SUBSTR(item.spine_label,13,3) like UPPER(:tray)
and item.item_id = item_barcode.item_id
group by item_barcode.item_barcode order by item_barcode.item_barcode asc

