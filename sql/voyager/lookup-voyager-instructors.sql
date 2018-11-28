--ACCESS=access content
select i.instructor_id,
                 i.last_name || ' ' || i.first_name fullname
           from pittdb.instructor i WHERE i.instructor_id in (select r.instructor_id from reserve_list_courses r)
           order by i.last_name, i.first_name asc
