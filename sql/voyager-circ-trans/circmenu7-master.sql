--ACCESS=access content
select distinct(perm_item_type_code) "Item_Type_code",
		count(*) "Totals",
		charge_location_code "Location"
	from pittdb.CIRCCHARGES_VW 
	where charge_location = :circ_loc 
	and charge_date_time between :transdate_start and :transdate_end 
union
elect distinct(perm_location_code)"Perm_Location",
                count(*) "Totals",
                charge_location_code "Location"
        from pittdb.CIRCCHARGES_VW
        where charge_location = :circ_loc
        and charge_date_time between :transdate_start and :transdate_end
        group by perm_location_code, charge_location_code
        order by perm_location_code asc


