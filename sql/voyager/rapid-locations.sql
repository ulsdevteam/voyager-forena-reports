--ACCESS=forena category RAPID
select
	l.location_code,
	l.location_display_name,
	NVL(r.branch, 'Main Library') library_display_name,
	case when r.location_id is not null then 'print' else '' end material_type,
	case when r.location_id is not null then 'Y' else 'N' end loan
from
	pittdb.location l 
	join pittdb.library b using (library_id)
	join voyapps.rapid_service s on (s.service_type = :service_code)
	left outer join voyapps.location_rapid r on (r.location_id = l.location_id and r.service_type = s.service_type)
order by
	location_code
