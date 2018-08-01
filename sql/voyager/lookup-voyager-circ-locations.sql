--ACCESS=access content
select l.location_id, 
             l.location_code || ' - ' || l.location_name
             from pittdb.location l
	     where l.location_code like '%CI'
	     --IF=:library_id
	     and   l.library_id = :library_id
	     --END
             and   l.location_id not in (503, 504, 509, 514, 519, 523, 524, 526, 580, 584, 638, 757, 763, 764)
             order by location_code
