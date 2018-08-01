--ACCESS=access content
select 
		count(case when perm_location in (select l.location_id from pittdb.location l, pittdb.item i, pittdb.library lb, item_barcode ib where  l.library_id = lb.library_id and i.item_id = ib.item_id and ib.barcode_status = 1 and lb.library_name = 'Bradford') then perm_location end) Bradford,
		count(case when perm_location in (select l.location_id from pittdb.location l, pittdb.item i, pittdb.library lb, item_barcode ib where  l.library_id = lb.library_id and i.item_id = ib.item_id and ib.barcode_status = 1 and lb.library_name = 'Greensburg') then perm_location end) Greensburg,
		count(case when perm_location in (select l.location_id from pittdb.location l, pittdb.item i, pittdb.library lb, item_barcode ib where  l.library_id = lb.library_id and i.item_id = ib.item_id and ib.barcode_status = 1 and lb.library_name = 'HSLS') then perm_location end) HSLS,
		count(case when perm_location in (select l.location_id from pittdb.location l, pittdb.item i, pittdb.library lb, item_barcode ib where  l.library_id = lb.library_id and i.item_id = ib.item_id and ib.barcode_status = 1 and lb.library_name = 'Johnstown') then perm_location end) Johnstown,
		count(case when perm_location in (select l.location_id from pittdb.location l, pittdb.item i, pittdb.library lb, item_barcode ib where  l.library_id = lb.library_id and i.item_id = ib.item_id and ib.barcode_status = 1 and lb.library_name = 'Law') then perm_location end) Law,
		count(case when perm_location in (select l.location_id from pittdb.location l, pittdb.item i, pittdb.library lb, item_barcode ib where  l.library_id = lb.library_id and i.item_id = ib.item_id and ib.barcode_status = 1 and lb.library_name = 'Titusville') then perm_location end) Titusville,
		count(case when perm_location in (select l.location_id from pittdb.location l, pittdb.item i, pittdb.library lb, item_barcode ib where  l.library_id = lb.library_id and i.item_id = ib.item_id and ib.barcode_status = 1 and lb.library_name = 'ULS') then perm_location end) ULS,
		count(case when perm_location in (select l.location_id from pittdb.location l, pittdb.item i, pittdb.library lb, item_barcode ib where  l.library_id = lb.library_id and i.item_id = ib.item_id and ib.barcode_status = 1 and lb.library_name = 'Semester at Sea') then perm_location end) SSEA
	from 
		PITTDB.item
        where create_date between :startdate and :enddate
