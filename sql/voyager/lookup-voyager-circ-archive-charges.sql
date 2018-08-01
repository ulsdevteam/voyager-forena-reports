--ACCESS=access content
select cta.circ_transaction_id,
                 cta.item_id,
                 cta.patron_group_id
          from   pittdb.circ_trans_archive cta
          where  cta.charge_location = :loc_id
          and    cta.charge_date between :begin_date and :end_date;
