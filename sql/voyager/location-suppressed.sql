--ACCESS=access content
select location_id,
	location_code,
	location_name,
	location_display_name,
	suppress_in_opac
from
	pittdb.location
where 
	location_id = :location_id

