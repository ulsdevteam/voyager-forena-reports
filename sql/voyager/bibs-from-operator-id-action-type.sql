--ACCESS=access content
SELECT at.action_type, count(at.action_type) as total 
FROM pittdb.bib_history bh,
	pittdb.action_type at
WHERE bh.operator_id = :operator_id
and bh.suppress_in_opac = 'N'
and bh.action_type_id = at.action_type_id
group by at.action_type
