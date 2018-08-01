--ACCESS=administer modules
SELECT distinct SUBSTR(spine_label,1,15)
FROM pittdb.item
WHERE REGEXP_LIKE (item.spine_label, 'R[0-9][0-9]-M[0-9][0-9]-S[0-9][0-9]-T[0-9][0-9]','i')
and SUBSTR(spine_label,1,3) = :range
and SUBSTR(spine_label,5,3) = :module
order by SUBSTR(spine_label,1,15) asc
