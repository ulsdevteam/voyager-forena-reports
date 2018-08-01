--ACCESS=access content
elect 
		count(*),
		count(case when suppress_in_opac = 'Y' then bib_id end),
		count(case when suppress_in_opac != 'Y' then bib_id end)
	from 
		pittdb.bib_master;
	   
	   
	   
select 
		count(*),
		count(case when suppress_in_opac = 'Y' then mfhd_id end),
		count(case when suppress_in_opac != 'Y' then mfhd_id end)
	from 
		pittdb.mfhd_master;
		
		
		
select 
		count(*),
		count(case when barcode_status = '1' then item_id end)
	from
		pittdb.item_barcode;
		
		

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
		pittdb.location;

		
select count(suppress_in_opac) "LOCS_Happening_locations" from location where suppress_in_opac = 'Y' and location_name not like 'zzz%' and location_name not like 'lcb%';
