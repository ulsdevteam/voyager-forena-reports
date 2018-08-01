--ACCESS=report rapid locations
select
	l.location_code,
	l.location_display_name,
	l.suppress_in_opac,
	l.mfhd_count
from
	pittdb.location l 
order by
	location_code
