--ACCESS=administer modules
select 		p.patron_id,
                p.last_name,
                p.first_name,
                case when p.middle_name is null then ' ' else p.middle_name end Middle_Name,
                sum(ff.fine_fee_balance / 100) Total_Voyager,
		count(case when ff.fine_fee_balance > 0 then ff.fine_fee_balance end ) test,
		sum(case when ff.fine_fee_location = :circ_loc then ff.fine_fee_balance / 100 else 0 end) total_hillCI,
		count(case when ff.fine_fee_location = :circ_loc then ff.fine_fee_balance end ) test2
        from     pittdb.fine_fee ff,
		pittdb.patron p
	where p.total_fees_due >= :dollaramount * 100 
	and ff.patron_id = p.patron_id
	group by p.patron_id,
	        p.last_name,
                p.first_name,
                p.middle_name
	order by p.last_name, p.first_name, p.middle_name
