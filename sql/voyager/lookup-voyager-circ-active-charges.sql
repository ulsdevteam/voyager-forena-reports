--ACCESS=access content
select ct.circ_transaction_id,
                 ct.item_id,
                 ct.charge_location,
                 ct.patron_group_id
          from   pittdb.circ_transactions ct
          where  ct.charge_location = :locid
          and    to_char(ct.charge_date, 'YYYY/MM/DD') between :begin_date and :end_date
