--ACCESS=access content
select
	l.location_id,
	l.location_code || ' - ' || l.location_name location_name
from
	pittdb.location l 
where
	l.suppress_in_opac != 'Y'
--IF=:location_id
	AND l.location_id = :location_id
--END
--IF=:location_list
	AND l.location_id IN :location_list
--END
order by
	l.location_code || ' - ' || l.location_name
--INFO
type[location_list]=array
