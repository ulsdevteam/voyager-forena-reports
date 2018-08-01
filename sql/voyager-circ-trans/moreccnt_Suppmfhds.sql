--ACCESS=access content
select 
		count(case when location_id in (select l.location_id from   pittdb.location l, pittdb.library lb where  l.library_id = lb.library_id and lb.library_name = 'Bradford') then location_id end) Bradford,
		count(case when location_id in (select l.location_id from   pittdb.location l, pittdb.library lb where  l.library_id = lb.library_id and lb.library_name = 'Greensburg') then location_id end) Greensburg,
		count(case when location_id in (select l.location_id from   pittdb.location l, pittdb.library lb where  l.library_id = lb.library_id and lb.library_name = 'HSLS') then location_id end) HSLS,
		count(case when location_id in (select l.location_id from   pittdb.location l, pittdb.library lb where  l.library_id = lb.library_id and lb.library_name = 'Johnstown') then location_id end) Johnstown,
		count(case when location_id in (select l.location_id from   pittdb.location l, pittdb.library lb where  l.library_id = lb.library_id and lb.library_name = 'Law') then location_id end) Law,
		count(case when location_id in (select l.location_id from   pittdb.location l, pittdb.library lb where  l.library_id = lb.library_id and lb.library_name = 'Titusville') then location_id end) Titus,
		count(case when location_id in (select l.location_id from   pittdb.location l, pittdb.library lb where  l.library_id = lb.library_id and lb.library_name = 'ULS') then location_id end) ULS,
		count(case when location_id in (select l.location_id from   pittdb.location l, pittdb.library lb where  l.library_id = lb.library_id and lb.library_name = 'Semester at Sea') then location_id end) SSEA	
	from 
		pittdb.mfhd_master mm
	where
		mm.suppress_in_opac = 'Y'
        and
                mm.create_date between :startdate and to_date(:enddate) +1
