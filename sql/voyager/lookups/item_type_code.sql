--ACCESS=access content
-- Obtain a list of item types
select
	it.item_type_code item_type_code,
	it.item_type_code || ' - ' || it.item_type_display item_type_display
from
	pittdb.item_type it
order by
	it.item_type_id
