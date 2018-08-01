--ACCESS=access content
select 
		count(*) BIBS_TOTAL,
		count(case when suppress_in_opac = 'Y' then bib_id end) BIBS_Suppressed,
		count(case when suppress_in_opac != 'Y' then bib_id end) BIBS_Unsuppressed
	from 
		pittdb.bib_master
        where to_char(create_date, 'yyyy/mm/dd') between :startdate and to_date(:enddate) +1
