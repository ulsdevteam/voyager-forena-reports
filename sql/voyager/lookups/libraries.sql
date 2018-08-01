--ACCESS=access content
select lb.library_id, 
             lb.library_name            
             from pittdb.library lb
             where  lb.library_id != 4 
             and    lb.library_id != 8
             and    lb.library_id != 11          
             order by library_name

