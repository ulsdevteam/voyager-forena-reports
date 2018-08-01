--ACCESS=access content
select pg.patron_group_code
                 from pittdb.patron_group pg
                 where pg.patron_group_id = :pid
