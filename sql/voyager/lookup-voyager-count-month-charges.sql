--ACCESS=access content
select count(ct.circ_transaction_id) ccnt
          from   pittdb.circ_transactions ct
          where  ct.charge_location = :loc_id
          and    ct.charge_date between :begin_date and :end_date; 
