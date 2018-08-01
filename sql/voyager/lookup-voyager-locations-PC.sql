--ACCESS=access content
select l.location_id, l.location_code
	from    pittdb.item i,
	        pittdb.location l
	where   i.perm_location in (236, 1009, 910, 971, 1036)
	and     i.perm_location = l.location_id
	group by l.location_code, l.location_id
	order	by l.location_id, l.location_code desc

