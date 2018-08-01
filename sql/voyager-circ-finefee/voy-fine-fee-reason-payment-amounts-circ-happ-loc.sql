--ACCESS=access content
select l.location_code "Circ_Loc",                  
	          SUM(CASE f.trans_type WHEN 9 THEN f.trans_amount / 100 else 0 END) "Accrued_Demerit",
		  SUM(CASE f.trans_type WHEN 8 THEN f.trans_amount / 100  ELSE 0 END) "Accrued_Fine",
		  SUM(CASE f.trans_type WHEN 15 THEN f.trans_amount / 100  ELSE 0 END) "Damage_Repair",
		  SUM(CASE f.trans_type WHEN 21 THEN f.trans_amount / 100  ELSE 0 END) "Database",
	          SUM(CASE f.trans_type WHEN 10 THEN f.trans_amount / 100  ELSE 0 END) "Demerit",
		  SUM(CASE f.trans_type WHEN 25 THEN f.trans_amount / 100  ELSE 0 END) "EAL_Printing",
		  SUM(CASE f.trans_type WHEN 6 THEN f.trans_amount / 100  ELSE 0 END) "Equip_Replace",
		  SUM(CASE f.trans_type WHEN 23 THEN f.trans_amount / 100  ELSE 0 END) "HSLS_Doc_Express",
	          SUM(CASE f.trans_type WHEN 24 THEN f.trans_amount / 100  ELSE 0 END) "HSLS_Member_Services",
		  SUM(CASE f.trans_type WHEN 20 THEN f.trans_amount / 100  ELSE 0 END) "ILL",
		  SUM(CASE f.trans_type WHEN 22 THEN f.trans_amount / 100  ELSE 0 END) "Library_Lib_Card_Purchase",
		  SUM(CASE f.trans_type WHEN 7 THEN f.trans_amount / 100  ELSE 0 END) "Lost_Equip_Process",
	          SUM(CASE f.trans_type WHEN 3 THEN f.trans_amount / 100  ELSE 0 END) "Lost_Item_Process",
		  SUM(CASE f.trans_type WHEN 2 THEN f.trans_amount / 100  ELSE 0 END) "Lost_Item_Replace",
		  SUM(CASE f.trans_type WHEN 4 THEN f.trans_amount / 100  ELSE 0 END) "Media_Late_Charge",
		  SUM(CASE f.trans_type WHEN 5 THEN f.trans_amount / 100  ELSE 0 END) "Media_Usage_Fee",
	          SUM(CASE f.trans_type WHEN 13 THEN f.trans_amount / 100  ELSE 0 END) "Misc",
		  SUM(CASE f.trans_type WHEN 1 THEN f.trans_amount / 100  ELSE 0 END) "Overdue",
		  SUM(CASE f.trans_type WHEN 17 THEN f.trans_amount / 100  ELSE 0 END) "Owes_Other_Schools",
		  SUM(CASE f.trans_type WHEN 16 THEN f.trans_amount / 100  ELSE 0 END) "Photo_Copy",
	          SUM(CASE f.trans_type WHEN 11 THEN f.trans_amount / 100  ELSE 0 END) "Recall_Fine",
		  SUM(CASE f.trans_type WHEN 19 THEN f.trans_amount / 100  ELSE 0 END) "Returned_Check",
		  SUM(CASE f.trans_type WHEN 12 THEN f.trans_amount / 100  ELSE 0 END) "Rush_Recall_Fine",
		  SUM(CASE f.trans_type WHEN 18 THEN f.trans_amount / 100  ELSE 0 END) "See_Notes",
		  SUM(CASE f.trans_type WHEN 14 THEN f.trans_amount / 100  ELSE 0 END) "Vendor_card",
		  
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
		  CASE f.trans_type WHEN 14 THEN f.trans_amount / 100  ELSE 0 END) "Location_Fine_Fee_Total"
		  
	          FROM pittdb.fine_fee_transactions f, pittdb.location l, pittdb.fine_fee_type fft, pittdb.fine_fee ff
where (l.library_id = 2 or l.library_id = 1 or l.library_id = 3 or l.library_id = 5 or l.library_id = 6 or l.library_id = 7 or l.library_id = 9 or l.library_id = 10) and
	l.location_id = f.trans_location and
	(f.fine_fee_id = ff.fine_fee_id) and
	(fft.fine_fee_type = 9 or fft.fine_fee_type = 8 or fft.fine_fee_type = 15 or fft.fine_fee_type = 21 or fft.fine_fee_type = 21 or fft.fine_fee_type = 10 or fft.fine_fee_type = 25 or fft.fine_fee_type = 6 or fft.fine_fee_type = 23 or
	fft.fine_fee_type = 24 or fft.fine_fee_type = 20 or fft.fine_fee_type = 22 or fft.fine_fee_type = 7 or fft.fine_fee_type = 3 or fft.fine_fee_type = 2 or fft.fine_fee_type = 4 or fft.fine_fee_type = 5 or fft.fine_fee_type = 13 or
	fft.fine_fee_type = 1 or fft.fine_fee_type = 17 or fft.fine_fee_type = 16 or fft.fine_fee_type = 11 or fft.fine_fee_type = 19 or fft.fine_fee_type = 12 or fft.fine_fee_type = 18 or fft.fine_fee_type = 14) and
	trans_date between :startdate and to_date(:enddate) +1
GROUP BY
	l.location_code 
	ORDER BY
	l.location_code
