--ACCESS=access content
select ff.trans_date, ff.trans_amount, fine_fee_trans_type.transaction_desc, fine_fee_trans_method.method_desc, location.location_name
    from pittdb.fine_fee_transactions ff
    inner join location
    on ff.trans_location=location.location_id
    inner join fine_fee_trans_type
    on ff.trans_type=FINE_FEE_TRANS_TYPE.transaction_type
    inner join fine_fee_trans_method
    on ff.trans_method=fine_fee_trans_method.method_type
    where to_char(ff.trans_date, 'YYYY-MM-DD') between :begin_date and to_date(:end_date) +1
    order by ff.trans_date
