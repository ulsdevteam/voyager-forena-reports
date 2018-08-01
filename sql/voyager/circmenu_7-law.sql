--ACCESS=access content
select ct.circ_transaction_id,
                 ct.item_id,
                 ct.charge_location,
                 ct.patron_group_id,
                    pg.patron_group_code,
                    it.item_type_code,
                    i.perm_location,
                    i.temp_location
          from   pittdb.circ_transactions ct,
                  pittdb.patron_group pg,
                  pittdb.item_type it,
                  pittdb.item i
            where  ct.charge_location = '518'
          and    ct.charge_date between :transdate_start and :transdate_end
            and    ct.patron_group_id = pg.patron_group_id
            and ct.item_id = i.item_id
            and i.item_type_id = it.item_type_id

