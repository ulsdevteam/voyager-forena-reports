--ACCESS=access content
select to_char(fftr.trans_date, 'YYYY/MM/DD HH12:MI AM') "TransDate",
                  pa.last_name "LastName",
                  pa.first_name "FirstName",
                  pa.middle_name "MiddleName",
                  fft.fine_fee_desc,
                  ib.item_barcode,
                  lo.location_code,
                  fftr.operator_id,
                  fftt.transaction_desc,
                  fftm.method_desc,
                  ('$' || fftr.trans_amount / 100) "Ammount"
          from   pittdb.fine_fee_transactions fftr,
                  pittdb.fine_fee ff,
                  pittdb.fine_fee_type fft,
                  pittdb.fine_fee_trans_type fftt,
                  PITTDB.FINE_FEE_TRANS_METHOD fftm,
                  pittdb.item it,
                  pittdb.location lo,
                  pittdb.item_barcode ib,
                  pittdb.patron pa           
           where fftr.trans_location = :circ_location
           and   fftr.trans_date between :transdate_start and :transdate_end
           and   fftr.fine_fee_id = ff.fine_fee_id
           and   ff.fine_fee_type = fft.fine_fee_type
           and   fftr.trans_type = fftt.transaction_type
           and   fftr.trans_method = fftm.method_type (+)
           and   ff.item_id = it.item_id (+)
           and   it.perm_location = lo.location_id (+)
           and   it.item_id = ib.item_id (+)
           and   ib.barcode_status(+) = 1
           and   ff.patron_id = pa.patron_id (+)
