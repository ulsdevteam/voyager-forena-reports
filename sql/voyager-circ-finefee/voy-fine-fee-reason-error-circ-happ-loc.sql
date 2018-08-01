--ACCESS=access content
select l.location_code "Circ_Loc",                  
	          SUM(CASE ff.fine_fee_type WHEN 9 THEN f.trans_amount / 100 else 0 END) "Accrued_Demerit",
		  SUM(CASE ff.fine_fee_type WHEN 8 THEN f.trans_amount / 100  ELSE 0 END) "Accrued_Fine",
		  SUM(CASE ff.fine_fee_type WHEN 15 THEN f.trans_amount / 100  ELSE 0 END) "Damage_Repair",
		  SUM(CASE ff.fine_fee_type WHEN 21 THEN f.trans_amount / 100  ELSE 0 END) "Database",
	          SUM(CASE ff.fine_fee_type WHEN 10 THEN f.trans_amount / 100  ELSE 0 END) "Demerit",
		  SUM(CASE ff.fine_fee_type WHEN 25 THEN f.trans_amount / 100  ELSE 0 END) "EAL_Printing",
		  SUM(CASE ff.fine_fee_type WHEN 6 THEN f.trans_amount / 100  ELSE 0 END) "Equip_Replace",
		  SUM(CASE ff.fine_fee_type WHEN 23 THEN f.trans_amount / 100  ELSE 0 END) "HSLS_Doc_Express",
	          SUM(CASE ff.fine_fee_type WHEN 24 THEN f.trans_amount / 100  ELSE 0 END) "HSLS_Member_Services",
		  SUM(CASE ff.fine_fee_type WHEN 20 THEN f.trans_amount / 100  ELSE 0 END) "ILL",
		  SUM(CASE ff.fine_fee_type WHEN 22 THEN f.trans_amount / 100  ELSE 0 END) "Library_Lib_Card_Purchase",
		  SUM(CASE ff.fine_fee_type WHEN 7 THEN f.trans_amount / 100  ELSE 0 END) "Lost_Equip_Process",
	          SUM(CASE ff.fine_fee_type WHEN 3 THEN f.trans_amount / 100  ELSE 0 END) "Lost_Item_Process",
		  SUM(CASE ff.fine_fee_type WHEN 2 THEN f.trans_amount / 100  ELSE 0 END) "Lost_Item_Replace",
		  SUM(CASE ff.fine_fee_type WHEN 4 THEN f.trans_amount / 100  ELSE 0 END) "Media_Late_Charge",
		  SUM(CASE ff.fine_fee_type WHEN 5 THEN f.trans_amount / 100  ELSE 0 END) "Media_Usage_Fee",
	          SUM(CASE ff.fine_fee_type WHEN 13 THEN f.trans_amount / 100  ELSE 0 END) "Misc",
		  SUM(CASE ff.fine_fee_type WHEN 1 THEN f.trans_amount / 100  ELSE 0 END) "Overdue",
		  SUM(CASE ff.fine_fee_type WHEN 17 THEN f.trans_amount / 100  ELSE 0 END) "Owes_Other_Schools",
		  SUM(CASE ff.fine_fee_type WHEN 16 THEN f.trans_amount / 100  ELSE 0 END) "Photo_Copy",
	          SUM(CASE ff.fine_fee_type WHEN 11 THEN f.trans_amount / 100  ELSE 0 END) "Recall_Fine",
		  SUM(CASE ff.fine_fee_type WHEN 19 THEN f.trans_amount / 100  ELSE 0 END) "Returned_Check",
		  SUM(CASE ff.fine_fee_type WHEN 12 THEN f.trans_amount / 100  ELSE 0 END) "Rush_Recall_Fine",
		  SUM(CASE ff.fine_fee_type WHEN 18 THEN f.trans_amount / 100  ELSE 0 END) "See_Notes",
		  SUM(CASE ff.fine_fee_type WHEN 14 THEN f.trans_amount / 100  ELSE 0 END) "Vendor_card",
		  
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
		  
	          FROM pittdb.fine_fee_transactions f, pittdb.location l, pittdb.fine_fee ff inner join
		  pittdb.fine_fee_type fft ON (ff.fine_fee_type = fft.fine_fee_type)
where 
	l.location_id = f.trans_location and
	(f.fine_fee_id = ff.fine_fee_id) and
	f.trans_type  in (3) and
	trans_date between :startdate and to_date(:enddate) +1
GROUP BY
	l.location_code 
	ORDER BY
	l.location_code
