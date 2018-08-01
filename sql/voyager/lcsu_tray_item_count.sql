--ACCESS=access content
-- Return a count of all items in a specified tray in the highbay
SELECT count(*) Total
FROM pittdb.item
WHERE REGEXP_LIKE (item.spine_label, 'R[0-9][0-9]-M[0-9][0-9]-S[0-9][0-9]-T[0-9][0-9]','i')
and SUBSTR(item.spine_label,1,3) like UPPER(:range)
and SUBSTR(item.spine_label,5,3) like UPPER(:module)
and SUBSTR(item.spine_label,9,3) like UPPER(:shelf)
and SUBSTR(item.spine_label,13,3) like UPPER(:tray)
