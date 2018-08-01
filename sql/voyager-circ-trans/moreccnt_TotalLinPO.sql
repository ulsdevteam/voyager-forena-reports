--ACCESS=access content
select 
	count(case when lic.line_item_id in (select lic.line_item_id from pittdb.location l, pittdb.purchase_order po, pittdb.line_item_copy lic, pittdb.item i, pittdb.library lb, item_barcode ib 
		where  
			lic.location_id = l.location_id 
		and 
			l.library_id = lb.library_id 
		and 
			i.item_id = ib.item_id 
		and 
			lb.library_name = 'Bradford') 
		then lic.line_item_id end) Bradford,
	count(case when lic.line_item_id in (select lic.line_item_id from pittdb.location l, pittdb.purchase_order po, pittdb.line_item_copy lic, pittdb.item i, pittdb.library lb, item_barcode ib 
		where  
			lic.location_id = l.location_id 
		and 
			l.library_id = lb.library_id 
		and 
			i.item_id = ib.item_id 
		and 
			lb.library_name = 'Greensburg') 
		then lic.line_item_id end) Greensburg,
	count(case when lic.line_item_id in (select lic.line_item_id from pittdb.location l, pittdb.purchase_order po, pittdb.line_item_copy lic, pittdb.item i, pittdb.library lb, item_barcode ib 
		where  
			lic.location_id = l.location_id 
		and 
			l.library_id = lb.library_id 
		and 
			i.item_id = ib.item_id 
		and 
			lb.library_name = 'HSLS') 
		then lic.line_item_id end) HSLS,
	count(case when lic.line_item_id in (select lic.line_item_id from pittdb.location l, pittdb.purchase_order po, pittdb.line_item_copy lic, pittdb.item i, pittdb.library lb, item_barcode ib 
		where  
			lic.location_id = l.location_id 
		and 
			l.library_id = lb.library_id 
		and 
			i.item_id = ib.item_id 
		and 
			lb.library_name = 'Johnstown') 
		then lic.line_item_id end) Johnstown,
	count(case when lic.line_item_id in (select lic.line_item_id from pittdb.location l, pittdb.purchase_order po, pittdb.line_item_copy lic, pittdb.item i, pittdb.library lb, item_barcode ib 
		where  
			lic.location_id = l.location_id 
		and 
			l.library_id = lb.library_id 
		and 
			i.item_id = ib.item_id 
		and 
			lb.library_name = 'Law') 
		then lic.line_item_id end) Law,
	count(case when lic.line_item_id in (select lic.line_item_id from pittdb.location l, pittdb.purchase_order po, pittdb.line_item_copy lic, pittdb.item i, pittdb.library lb, item_barcode ib 
		where  
			lic.location_id = l.location_id 
		and 
			l.library_id = lb.library_id 
		and 
			i.item_id = ib.item_id 
		and 
			lb.library_name = 'Titusville')
		then lic.line_item_id end) Titusville,
	count(case when lic.line_item_id in (select lic.line_item_id from pittdb.location l, pittdb.purchase_order po, pittdb.line_item_copy lic, pittdb.item i, pittdb.library lb, item_barcode ib 
		where  
			lic.location_id = l.location_id 
		and 
			l.library_id = lb.library_id 
		and 
			i.item_id = ib.item_id 
		and 
			lb.library_name = 'ULS')
		then lic.line_item_id end) ULS,
	count(case when lic.line_item_id in (select lic.line_item_id from pittdb.location l, pittdb.purchase_order po, pittdb.line_item_copy lic, pittdb.item i, pittdb.library lb, item_barcode ib 
		where  
			lic.location_id = l.location_id 
		and 
			l.library_id = lb.library_id 
		and 
			i.item_id = ib.item_id 
		and 
			lb.library_name = 'Semester at Sea') 
		then lic.line_item_id end) SSEA
	from   PITTDB.line_item_copy lic, PITTDB.line_item li
        where li.line_item_id = lic.line_item_id
        and create_date between :startdate and :enddate
