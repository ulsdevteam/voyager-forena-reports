--ACCESS=access content
select 
   bi.bib_id, bt.title, it.item_id, itt.item_type_name, it.price/100 as price, it.pieces, it.historical_charges, it.historical_browses
from 
   pittdb.ITEM it,
   pittdb.ITEM_TYPE itt,
   pittdb.bib_item bi,
   pittdb.bib_text bt
where 
   itt.item_type_id = it.item_type_id
   and bi.item_id = it.item_id
   and bt.bib_id = bi.bib_id
   and it.perm_location = :location_id
