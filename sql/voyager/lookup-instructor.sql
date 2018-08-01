--ACCESS=access content
select ins.instructor_id, ins.last_name, ins.first_name
             from pittdb.instructor ins
             order by ins.last_name, ins.first_name

