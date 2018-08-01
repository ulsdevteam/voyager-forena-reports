--ACCCESS=access content
SELECT 
CASE WHEN fftp.transaction_type = any (2,3,4,7) THEN fftp.transaction_desc else 'Busar Ammount' end "Transaction Type",
                SUM(CASE WHEN trans_date between :startdate and to_date(:enddate) +1  THEN fft.trans_amount / 100 ELSE 0 END) "Amount",
                SUM(CASE WHEN trans_date BETWEEN TRUNC(TRUNC(SYSDATE, 'YEAR') -1, 'YEAR') AND TRUNC(SYSDATE, 'YEAR') - .00001 THEN fft.trans_amount / 100 ELSE 0 END) "Yearly Amount"
FROM
fine_fee_trans_type fftp
INNER JOIN
        pittdb.fine_fee_transactions fft ON (fft.trans_type = fftp.transaction_type) and fft.trans_location = :circ_location
group by (CASE WHEN fftp.transaction_type = any (2,3,4,7) THEN fftp.transaction_desc else 'Busar Ammount' end)
