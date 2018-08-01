--ACCESS=access content
select 
		count(*) ITEMS_Total,
		count(case when barcode_status = '1' then ib.item_id end) ITEMS_Active_Barcodes
	from
		pittdb.item_barcode ib, pittdb.item it
where
                it.item_id = ib.item_id
 and
                to_char(it.create_date, 'yyyy/mm/dd') between :startdate and to_date(:enddate) +1 
