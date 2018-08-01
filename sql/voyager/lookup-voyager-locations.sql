--ACCESS=access content
select
	l.location_id,
	l.location_code || ' - ' || l.location_name || ' - ' || l.location_display_name location_name
from
	pittdb.location l 
where
	l.suppress_in_opac != 'Y'
order by
	l.location_code || ' - ' || l.location_name || ' - ' || l.location_display_name
--INFO
type[location_list]=array
