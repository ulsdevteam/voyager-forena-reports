--ACCESS=access content
select 
		count(*) MFHDS_Total,
		count(case when suppress_in_opac = 'Y' then mfhd_id end) MFHDS_Suppressed,
		count(case when suppress_in_opac != 'Y' then mfhd_id end) MFHDS_Unsuppressed
	from 
		pittdb.mfhd_master
        where to_char(create_date, 'yyyy/mm/dd') between :startdate and to_date(:enddate) +1
