--ACCESS=access content
SELECT distinct SUBSTR(spine_label,1,3)
FROM pittdb.item
WHERE REGEXP_LIKE (item.spine_label, 'R[0-9][0-9]','i')
and substr(spine_label,1,1) = 'R'
and SUBSTR(spine_label,2,2) between 1 and 20
order by SUBSTR(spine_label,1,3) asc
