--ACCESS=access content
select 
		count(*) LOCS_Total,
		count(case when library_id = '1' then library_id end) LOCS_Bradford,
		count(case when library_id = '5' then library_id end)LOCS_Greensburg,
		count(case when library_id = '6' then library_id end) LOCS_Johnstown,
		count(case when library_id = '9' then library_id end) LOCS_Titusville,
		count(case when library_id = '10' then library_id end) LOCS_HSLS,
		count(case when library_id = '7' then library_id end) LOCS_Law,
		count(case when library_id = '8' then library_id end) LOCS_SSEA,
		count(case when library_id = '2' then library_id end) LOCS_ULS
	from 
		pittdb.location
