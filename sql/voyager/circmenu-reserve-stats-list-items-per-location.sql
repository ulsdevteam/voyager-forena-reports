--ACCESS=access content
select 
	rli.item_id,
	rl.create_location_id,
        rl.list_title as reserve_list_title,
	i.last_name as instructor_last_name,
	i.first_name as instructor_first_name,
        to_char(rl.effect_date, 'YYYY/MM/DD') effective_date,
        to_char(rl.expire_date, 'YYYY/MM/DD') expire_date,
        c.course_name,
        c.course_number,
        to_char(c.begin_date, 'YYYY/MM/DD') begin_date,
        to_char(c.end_date, 'YYYY/MM/DD') end_date,
        replace(bt.title_brief, '[', '&#91;') title_brief,
        ib.item_barcode,
        rl.reserve_list_id                       
from 
	pittdb.reserve_list_items rli,
        pittdb.reserve_list rl,
        pittdb.reserve_list_courses rlc,
        pittdb.course c,
        pittdb.bib_text bt,
        pittdb.bib_item bi,
        pittdb.item_barcode ib,
	pittdb.instructor i
where 
	rl.create_location_id = '511'             
        and   rl.reserve_list_id = rlc.reserve_list_id (+)
        and   rl.reserve_list_id = rli.reserve_list_id (+)
        and   rlc.course_id = c.course_id
        and   rli.item_id = bi.item_id
        and   bi.bib_id = bt.bib_id
        and   bi.item_id = ib.item_id  
	and   rlc.instructor_id = i.instructor_id
order by 
	c.course_name,
        c.course_number,
        bt.title
