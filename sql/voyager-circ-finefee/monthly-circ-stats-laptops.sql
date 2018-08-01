--ACCESS=access content
select i.item_id,
		l.location_code,
		bt.title,
		mi.item_enum,
		ib.item_barcode,
                (p.last_name || ' , ' || p.first_name || ' ' || p.middle_name) "PatronName",
                p.institution_id,
		(ff.fine_fee_balance/100) "Amount Owed",
		fft.fine_fee_desc,
		ff.orig_charge_date,
                ff.due_date,
                ff.fine_fee_notice_date,
                l.location_code,
                ff.operator_id
	from    pittdb.item i,
	        pittdb.location l,
		pittdb.bib_text bt,
		pittdb.bib_item bi,
		pittdb.mfhd_item mi,
		pittdb.item_barcode ib,
		pittdb.fine_fee ff,
                pittdb.fine_fee_type fft,
                pittdb.patron p
	where   ff.item_id = i.item_id
         and    ff.fine_fee_balance > 0
         and    ff.patron_id = p.patron_id
         and    ff.fine_fee_type = fft.fine_fee_type
	and     bi.item_id = i.item_id
	and     ib.item_id =  i.item_id
	and     ib.barcode_status = '1'
	and    bi.bib_id = bt.bib_id
	and    i.item_id = mi.item_id
	and (i.perm_location = :location_code
	or      i.perm_location = 1015)
	and     i.perm_location = l.location_id
	order	by i.item_id, l.location_code desc