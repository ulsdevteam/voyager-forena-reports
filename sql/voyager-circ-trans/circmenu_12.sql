--ACCESS=access content
select  sysdate,
	ib.item_barcode, 
	bs.barcode_status_desc, 
	ib.item_id, 
	it.copy_number, 
	itp.item_type_display, 
	l.location_code, 
	bt.title_brief, 
	bt.author,
	it.historical_charges,
	it.historical_browses,
	it.reserve_charges,
	it.holds_placed,
	it.recalls_placed,
	ist.item_status_desc,
	itst.item_status_date
from 
	dual,
	pittdb.item_barcode ib,
	item_barcode_status bs,
	item it,
	item_type itp,
	location l,
	pittdb.bib_text bt,
	pittdb.bib_item bi,
	item_status_type  ist,
	item_status itst
            where ib.item_barcode = :itembarcode
and
	ib.barcode_status = bs.barcode_status_type
and
	it.item_id = ib.item_id
and
	it.item_type_id = itp.item_type_id
and
	it.perm_location = l.location_id
and
	bi.item_id = it.item_id
and
	bi.bib_id = bt.bib_id
and
	itst.item_id = it.item_id
and
	ist.item_status_type = itst.item_status
