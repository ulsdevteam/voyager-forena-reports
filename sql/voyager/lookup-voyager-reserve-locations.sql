--ACCESS=access content
select distinct(l.location_id), l.location_name from location l, reserve_list rl  where rl.reserve_location = l.location_id order by l.location_name asc
