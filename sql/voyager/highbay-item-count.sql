--ACCESS=access content
-- Return a count of all items where the spine label field matches 'R-M-S-T' regardless
-- of Case.  This includes suppressed records as well which are considered data errors
-- but should be counted.
SELECT count(*) Total
FROM pittdb.item
WHERE REGEXP_LIKE (item.spine_label, 'R[0-9][0-9]-M[0-9][0-9]-S[0-9][0-9]-T[0-9][0-9]','i')
