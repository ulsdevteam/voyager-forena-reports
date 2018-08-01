--ACCESS=access content
select fftr.fine_fee_id,
                  to_char(fftr.trans_date, 'YYYY/MM/DD HH12:MI AM') disdate,
                  to_char(fftr.trans_date, 'YYYY/MM/DD HH24:MI:SS') tdate,
                  fftr.trans_amount/100 "TRANS_AMOUNT",
                  fftr.operator_id,
                  fft.fine_fee_desc,
                  fftt.transaction_desc,
                  fftm.method_desc,
                  lo.location_code,
                  ib.item_barcode,
                  pa.last_name,
                  pa.first_name,
                  pa.middle_name
          from   pittdb.fine_fee_transactions fftr,
                  pittdb.fine_fee ff,
                  pittdb.fine_fee_type fft,
                  pittdb.fine_fee_trans_type fftt,
                  pittdb.fine_fee_trans_method fftm,
                  pittdb.item it,
                  pittdb.location lo,
                  pittdb.item_barcode ib,
                  pittdb.patron pa                                                    
           where  fftr.trans_location = :circ_location_id
	   and   to_char(fftr.trans_date, 'YYYY/MM/DD') between :begin_date and :end_date
           and   fftr.fine_fee_id = ff.fine_fee_id
           and   ff.fine_fee_type = fft.fine_fee_type
           and   fftr.trans_type = fftt.transaction_type
           and   fftr.trans_method = fftm.method_type (+)
           and   ff.item_id = it.item_id (+)
           and   it.perm_location = lo.location_id (+)
           and   it.item_id = ib.item_id (+)
           and   ib.barcode_status(+) = 1
           and   ff.patron_id = pa.patron_id (+)   
           order by tdate
