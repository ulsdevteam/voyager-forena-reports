--ACCESS=access content
select distinct(patron_group_code) "Patron_Group",
		count(*) "Totals",
		charge_location_code "Location"
	from pittdb.CIRCCHARGES_VW 
	where charge_location = :circ_loc 
	and charge_date_time between :transdate_start and :transdate_end 
	group by patron_group_code, charge_location_code
	order by patron_group_code asc
