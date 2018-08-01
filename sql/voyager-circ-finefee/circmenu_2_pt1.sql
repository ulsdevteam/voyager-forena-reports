--ACCCESS=access content
SELECT 
CASE WHEN fftm.method_type = any (1,2,3,4,5,6,7) THEN fftm.method_desc end "Transaction Method",
                SUM(CASE WHEN trans_date between :startdate and to_date(:enddate) +1  THEN fft.trans_amount / 100 ELSE 0 END) "Amount",
                SUM(CASE WHEN trans_date BETWEEN TRUNC(TRUNC(SYSDATE, 'YEAR') -1, 'YEAR') AND TRUNC(SYSDATE, 'YEAR') - .00001 THEN fft.trans_amount / 100 ELSE 0 END) "Yearly Amount"
FROM
fine_fee_trans_method fftm
INNER JOIN
        pittdb.fine_fee_transactions fft ON (fft.trans_method = fftm.method_type) and fft.trans_location = :circ_location
group by (CASE WHEN fftm.method_type = any (1,2,3,4,5,6,7) THEN fftm.method_desc end)
