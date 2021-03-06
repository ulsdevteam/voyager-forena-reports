--ACCESS=access content
select 
		count(case when library_id = '1' and suppress_in_opac = 'Y' then library_id end) SuppBIB_Bradford,
		count(case when library_id = '5' and suppress_in_opac = 'Y' then library_id end)SuppBIB_Greensburg,
		count(case when library_id = '10' and suppress_in_opac = 'Y' then library_id end) SuppBIB_HSLS,
		count(case when library_id = '6' and suppress_in_opac = 'Y' then library_id end) SuppBIB_Johnstown,
		count(case when library_id = '7' and suppress_in_opac = 'Y' then library_id end) SuppBIB_Law,
		count(case when library_id = '9' and suppress_in_opac = 'Y' then library_id end) SuppBIB_Titusville,
		count(case when library_id = '2' and suppress_in_opac = 'Y' then library_id end) SuppBIB_ULS,
		count(case when library_id = '8' and suppress_in_opac = 'Y' then library_id end) SuppBIB_SSEA
	from 
		pittdb.bib_master
        where create_date between :startdate and :enddate 
