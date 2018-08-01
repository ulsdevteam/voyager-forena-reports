--ACCESS=access content

--Used to provide a dropdown list for all of the existing fiscal periods.
SELECT 
     EXTRACT(YEAR FROM ADD_MONTHS(fp.START_DATE,12)) fiscal_year,
     fp.FISCAL_PERIOD_NAME fiscal_name
FROM  
     PITTDB.FISCAL_PERIOD fp
WHERE fp.FISCAL_PERIOD_NAME LIKE '%June%'  
ORDER BY fp.START_DATE
