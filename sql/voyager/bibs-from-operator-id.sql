--ACCESS=access content
SELECT distinct bh.bib_id
FROM pittdb.bib_history bh
WHERE bh.operator_id = :operator_id
and bh.suppress_in_opac = 'N'
ORDER BY bh.bib_id
