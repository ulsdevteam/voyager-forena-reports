--ACCESS=access content
SELECT distinct SUBSTR(spine_label,4,3)
FROM pittdb.item
WHERE REGEXP_LIKE (item.spine_label, 'M[0-9][0-9]','i')
and substr(spine_label,4,1) = 'M'
and SUBSTR(spine_label,5,2) between 1 and 24
order by SUBSTR(spine_label,4,3) asc
