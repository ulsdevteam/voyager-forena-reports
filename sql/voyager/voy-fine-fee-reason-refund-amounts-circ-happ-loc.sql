--ACCESS=access content
select l.location_code "Circ Loc",                  
	          SUM(CASE ff.fine_fee_type WHEN 9 THEN f.trans_amount / 100 else 0 END) "Accured Demerit",
		  SUM(CASE ff.fine_fee_type WHEN 8 THEN f.trans_amount / 100  ELSE 0 END) "Accured Fine",
		  SUM(CASE ff.fine_fee_type WHEN 15 THEN f.trans_amount / 100  ELSE 0 END) "Damage Repair",
		  SUM(CASE ff.fine_fee_type WHEN 21 THEN f.trans_amount / 100  ELSE 0 END) "Database",
	          SUM(CASE ff.fine_fee_type WHEN 10 THEN f.trans_amount / 100  ELSE 0 END) "Demerit",
		  SUM(CASE ff.fine_fee_type WHEN 25 THEN f.trans_amount / 100  ELSE 0 END) "EAL Printing",
		  SUM(CASE ff.fine_fee_type WHEN 6 THEN f.trans_amount / 100  ELSE 0 END) "Equip Replace",
		  SUM(CASE ff.fine_fee_type WHEN 23 THEN f.trans_amount / 100  ELSE 0 END) "HSLS Doc Express",
	          SUM(CASE ff.fine_fee_type WHEN 24 THEN f.trans_amount / 100  ELSE 0 END) "HSLS Member Services",
		  SUM(CASE ff.fine_fee_type WHEN 20 THEN f.trans_amount / 100  ELSE 0 END) "ILL",
		  SUM(CASE ff.fine_fee_type WHEN 22 THEN f.trans_amount / 100  ELSE 0 END) "Library Lib Card Purchase",
		  SUM(CASE ff.fine_fee_type WHEN 7 THEN f.trans_amount / 100  ELSE 0 END) "Lost Equip Process",
	          SUM(CASE ff.fine_fee_type WHEN 3 THEN f.trans_amount / 100  ELSE 0 END) "Lost Item Process",
		  SUM(CASE ff.fine_fee_type WHEN 2 THEN f.trans_amount / 100  ELSE 0 END) "Lost Item Replace",
		  SUM(CASE ff.fine_fee_type WHEN 4 THEN f.trans_amount / 100  ELSE 0 END) "Media Late Charge",
		  SUM(CASE ff.fine_fee_type WHEN 5 THEN f.trans_amount / 100  ELSE 0 END) "Media Usage Fee",
	          SUM(CASE ff.fine_fee_type WHEN 13 THEN f.trans_amount / 100  ELSE 0 END) "Misc",
		  SUM(CASE ff.fine_fee_type WHEN 1 THEN f.trans_amount / 100  ELSE 0 END) "Overdue",
		  SUM(CASE ff.fine_fee_type WHEN 17 THEN f.trans_amount / 100  ELSE 0 END) "Owes Other Schools",
		  SUM(CASE ff.fine_fee_type WHEN 16 THEN f.trans_amount / 100  ELSE 0 END) "Photo Copy",
	          SUM(CASE ff.fine_fee_type WHEN 11 THEN f.trans_amount / 100  ELSE 0 END) "Recall Fine",
		  SUM(CASE ff.fine_fee_type WHEN 19 THEN f.trans_amount / 100  ELSE 0 END) "Returned Check",
		  SUM(CASE ff.fine_fee_type WHEN 12 THEN f.trans_amount / 100  ELSE 0 END) "Rush Recall Fine",
		  SUM(CASE ff.fine_fee_type WHEN 18 THEN f.trans_amount / 100  ELSE 0 END) "See Notes",
		  SUM(CASE ff.fine_fee_type WHEN 14 THEN f.trans_amount / 100  ELSE 0 END) "Vendor card",
		  
		  SUM(CASE f.trans_type WHEN 9 THEN f.trans_amount / 100 else 0 END + CASE f.trans_type WHEN 8 THEN f.trans_amount / 100  ELSE 0 END + 
                  CASE f.trans_type WHEN 15 THEN f.trans_amount / 100  ELSE 0 END + CASE f.trans_type WHEN 21 THEN f.trans_amount / 100  ELSE 0 END +
	          CASE f.trans_type WHEN 10 THEN f.trans_amount / 100  ELSE 0 END + CASE f.trans_type WHEN 25 THEN f.trans_amount / 100  ELSE 0 END + 
		  CASE f.trans_type WHEN 6 THEN f.trans_amount / 100  ELSE 0 END + CASE f.trans_type WHEN 23 THEN f.trans_amount / 100  ELSE 0 END + 
	          CASE f.trans_type WHEN 24 THEN f.trans_amount / 100  ELSE 0 END + CASE f.trans_type WHEN 20 THEN f.trans_amount / 100  ELSE 0 END + 
		  CASE f.trans_type WHEN 22 THEN f.trans_amount / 100  ELSE 0 END + CASE f.trans_type WHEN 7 THEN f.trans_amount / 100  ELSE 0 END + 
	          CASE f.trans_type WHEN 3 THEN f.trans_amount / 100  ELSE 0 END + CASE f.trans_type WHEN 2 THEN f.trans_amount / 100  ELSE 0 END + 
		  CASE f.trans_type WHEN 4 THEN f.trans_amount / 100  ELSE 0 END + CASE f.trans_type WHEN 5 THEN f.trans_amount / 100  ELSE 0 END + 
	          CASE f.trans_type WHEN 13 THEN f.trans_amount / 100  ELSE 0 END + CASE f.trans_type WHEN 1 THEN f.trans_amount / 100  ELSE 0 END + 
		  CASE f.trans_type WHEN 17 THEN f.trans_amount / 100  ELSE 0 END + CASE f.trans_type WHEN 16 THEN f.trans_amount / 100  ELSE 0 END + 
	          CASE f.trans_type WHEN 11 THEN f.trans_amount / 100  ELSE 0 END + CASE f.trans_type WHEN 19 THEN f.trans_amount / 100  ELSE 0 END + 
		  CASE f.trans_type WHEN 12 THEN f.trans_amount / 100  ELSE 0 END + CASE f.trans_type WHEN 18 THEN f.trans_amount / 100  ELSE 0 END + 
		  CASE f.trans_type WHEN 14 THEN f.trans_amount / 100  ELSE 0 END) "Location Fine/Fee Total"
		  
	          FROM pittdb.fine_fee_transactions f, pittdb.location l, pittdb.fine_fee ff inner join
		  pittdb.fine_fee_type fft ON (ff.fine_fee_type = fft.fine_fee_type)
where l.library_id in(2,1,3,5,6,7,9,10) and
	l.location_id = f.trans_location and
	(f.fine_fee_id = ff.fine_fee_id) and
	f.trans_type  in (4) and
        trans_date between :startdate and to_date(:enddate) +1
GROUP BY
	l.location_code 
	ORDER BY
	l.location_code
