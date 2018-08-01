--ACCESS=access content
select
        lc.location_code "loc_code", (fft.trans_amount/100) "Trans_amount", fftp.transaction_desc
from
        pittdb.fine_fee_transactions fft,
        pittdb.fine_fee ff,
        pittdb.location lc,
        pittdb.fine_fee_trans_type fftp
where
        lc.location_id = :circ_location
and     fft.trans_location = :circ_location
and     fft.trans_date between :begin_date and :end_date
and     fft.fine_fee_id = ff.fine_fee_id
and     ff.fine_fee_type = :fine_fee_type
and     fftp.transaction_type = ff.fine_fee_type
