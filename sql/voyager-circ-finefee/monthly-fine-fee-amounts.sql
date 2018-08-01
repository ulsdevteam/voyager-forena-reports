--ACCESS=access content
SELECT
	l.location_code,
	l.location_name,
	SUM(f.trans_amount / 100) "Total_Payment_Amount",
	SUM(CASE f.trans_type WHEN 1 THEN f.trans_amount / 100  ELSE 0 END) "CASH",
	SUM(CASE WHEN f.trans_type = 2 THEN f.trans_amount / 100 ELSE 0 END) "CHECK",
	SUM(CASE f.trans_type WHEN 3 THEN f.trans_amount / 100 ELSE 0 END) "VOUCHER",
	SUM(CASE WHEN f.trans_type = 4 THEN f.trans_amount / 100 ELSE 0 END) "CREDIT_CARD",
	SUM(CASE WHEN f.trans_type = 6 THEN f.trans_amount / 100 ELSE 0 END) "PANTHER_FUNDS",
	SUM(CASE WHEN f.trans_type = 7 THEN f.trans_amount / 100 ELSE 0 END) "BANKRUPTCY",
	SUM(CASE WHEN f.trans_type = 0 THEN f.trans_amount / 100 ELSE 0 END) "OTHER",
	SUM(CASE WHEN f.trans_method = 2 THEN f.trans_amount / 100 ELSE 0 END) "FORGIVE_AMOUNT",
	SUM(CASE WHEN f.trans_method = 3 THEN f.trans_amount / 100 ELSE 0 END) "ERROR_AMOUNT",
	SUM(CASE WHEN f.trans_method = 4 THEN f.trans_amount / 100 ELSE 0 END) "REFUND_AMOUNT",
	SUM(CASE WHEN f.trans_method = 6 THEN f.trans_amount / 100 ELSE 0 END) "BUSAR_AMOUNT",
	CASE f.trans_type WHEN 1 THEN SUM(f.trans_amount / 100) ELSE 0 END + CASE f.trans_type WHEN 2 THEN SUM(f.trans_amount / 100) ELSE 0 END + CASE f.trans_type WHEN 3 THEN SUM(f.trans_amount / 100) ELSE 0 END + CASE f.trans_type WHEN 4 THEN SUM(f.trans_amount / 100) ELSE 0 END +
	CASE f.trans_type WHEN 6 THEN SUM(f.trans_amount / 100) ELSE 0 END + CASE f.trans_type WHEN 7 THEN SUM(f.trans_amount / 100) ELSE 0 END + CASE f.trans_type WHEN 0 THEN SUM(f.trans_amount / 100) ELSE 0 END +
	CASE f.trans_method WHEN 2 THEN SUM(f.trans_amount / 100) ELSE 0 END + CASE f.trans_method WHEN 3 THEN SUM(f.trans_amount / 100) ELSE 0 END + CASE f.trans_method WHEN 4 THEN SUM(f.trans_amount / 100) ELSE 0 END + 
	CASE f.trans_method WHEN 6 THEN SUM(f.trans_amount / 100) ELSE 0 END "TOTAL_AMOUNT",
	COUNT(l.location_name) "TOTAL_TRANS"
FROM
	pittdb.location l INNER JOIN
	pittdb.fine_fee_transactions f ON (l.location_id = f.trans_location)	
WHERE
	l.location_code like '%CI%' AND
	(l.library_id = 2 or l.library_id = 1 or l.library_id = 5 or l.library_id = 6 or l.library_id = 7 or l.library_id = 9 or l.library_id = 10)
and     trans_date between :startdate and to_date(:enddate) +1
GROUP BY
	l.location_code,
	l.location_name,
	f.trans_type,
	f.trans_method
ORDER BY
	l.location_code
