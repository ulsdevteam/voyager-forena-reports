SELECT
	DATE(tstamp) log_date,
	TIME(tstamp) log_time,
	lname,
	fname,
	id_type,
	note,
	REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(account, '0', ''), '1', ''), '2', ''), '3', ''), '4', ''), '5', ''), '6', ''), '7', ''), '8', ''), '9', '') account
FROM
	Assignments
WHERE
	DATE(tstamp) BETWEEN :begin_date and :end_date
ORDER BY
	REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(account, '0', ''), '1', ''), '2', ''), '3', ''), '4', ''), '5', ''), '6', ''), '7', ''), '8', ''), '9', ''),
	tstamp
