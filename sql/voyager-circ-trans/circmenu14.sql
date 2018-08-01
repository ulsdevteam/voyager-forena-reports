--ACCESS=access content
select rli.item_id,
                  i.last_name,
                  i.first_name,
                  c.course_name,
                  c.course_number,
                  c.begin_date,
                  c.end_date,
                  rl.list_title,
                  rl.effect_date,
                  rl.expire_date,
                  bt.title_brief,
                  ib.item_barcode,
		  (select count(*) from circ_transactions ct where ct.item_id = rli.item_id and ct.charge_date between rl.effect_date and rl.expire_date) +
		  (select count(*) from circ_trans_archive cta where cta.item_id = rli.item_id and cta.charge_date between rl.effect_date and rl.expire_date) trans
           from pittdb.reserve_list_items rli,
                pittdb.reserve_list rl,
                pittdb.reserve_list_courses rlc,
                pittdb.instructor i,
                pittdb.course c,
                pittdb.bib_text bt,
                pittdb.bib_item bi,
                pittdb.item_barcode ib
           where   rl.reserve_list_id = rlc.reserve_list_id(+)
           and   rl.reserve_list_id = rli.reserve_list_id(+)
           --IF=:location
	   and rl.reserve_location = :location
           --END
	   --IF=:effect_date
           and   rl.effect_date = :effect_date
	   --END
	   --IF=:instructor
           and   i.instructor_id = :instructor
	   --END
           and   rlc.course_id = c.course_id
           and   rli.item_id = bi.item_id
           and   rlc.instructor_id = i.instructor_id
           and   bi.bib_id = bt.bib_id
           and   bi.item_id = ib.item_id
           order by c.course_name,
                    c.course_number,
                    bt.title
