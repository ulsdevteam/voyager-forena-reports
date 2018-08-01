--ACCESS=access content
select 
	count(case when po.po_id in (select po.po_id from pittdb.location l, pittdb.purchase_order po, pittdb.item i, pittdb.library lb, item_barcode ib 
		where  
			po.create_location_id = l.location_id 
		and 
			l.library_id = lb.library_id 
		and 
			i.item_id = ib.item_id 
		and 
			lb.library_name = 'Bradford') 
		then po.po_id end) Bradford,
	count(case when po.po_id in (select po.po_id from pittdb.location l, pittdb.purchase_order po, pittdb.item i, pittdb.library lb, item_barcode ib 
		where  
			po.create_location_id = l.location_id 
		and 
			l.library_id = lb.library_id 
		and 
			i.item_id = ib.item_id 
		and 
			lb.library_name = 'Greensburg') 
		then po.po_id end) Greensburg,	
	count(case when po.po_id in (select po.po_id from pittdb.location l, pittdb.purchase_order po, pittdb.item i, pittdb.library lb, item_barcode ib 
		where  
			po.create_location_id = l.location_id 
		and 
			l.library_id = lb.library_id 
		and 
			i.item_id = ib.item_id 
		and 
			lb.library_name = 'HSLS') 
		then po.po_id end) HSLS,
	count(case when po.po_id in (select po.po_id from pittdb.location l, pittdb.purchase_order po, pittdb.item i, pittdb.library lb, item_barcode ib 
		where  
			po.create_location_id = l.location_id 
		and 
			l.library_id = lb.library_id 
		and 
			i.item_id = ib.item_id 
		and 
			lb.library_name = 'Johnstown') 
		then po.po_id end) Johnstown,
	count(case when po.po_id in (select po.po_id from pittdb.location l, pittdb.purchase_order po, pittdb.item i, pittdb.library lb, item_barcode ib 
		where  
			po.create_location_id = l.location_id 
		and 
			l.library_id = lb.library_id 
		and 
			i.item_id = ib.item_id 
		and 
			lb.library_name = 'Law') 
		then po.po_id end) Law,	
	count(case when po.po_id in (select po.po_id from pittdb.location l, pittdb.purchase_order po, pittdb.item i, pittdb.library lb, item_barcode ib 
		where  
			po.create_location_id = l.location_id 
		and 
			l.library_id = lb.library_id 
		and 
			i.item_id = ib.item_id 
		and 
			lb.library_name = 'Titusville') 
		then po.po_id end) Titusville,
	count(case when po.po_id in (select po.po_id from pittdb.location l, pittdb.purchase_order po, pittdb.item i, pittdb.library lb, item_barcode ib 
		where  
			po.create_location_id = l.location_id 
		and 
			l.library_id = lb.library_id 
		and 
			i.item_id = ib.item_id 
		and 
			lb.library_name = 'ULS') 
		then po.po_id end) ULS,
	count(case when po.po_id in (select po.po_id from pittdb.location l, pittdb.purchase_order po, pittdb.item i, pittdb.library lb, item_barcode ib 
		where  
			po.create_location_id = l.location_id 
		and 
			l.library_id = lb.library_id 
		and 
			i.item_id = ib.item_id 
		and 
			lb.library_name = 'Semester at Sea') 
		then po.po_id end) SSEA
	from   pittdb.purchase_order po, PITTDB.location l
        where po.create_location_id = l.location_id
        and   po.po_create_date between :startdate and :enddate
