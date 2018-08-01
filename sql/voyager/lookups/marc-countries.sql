SELECT
	COUNTRY_CODE,
	COUNTRY_REGION || ' - ' || COUNTRY_NAME COUNTRY_TEXT
FROM
	VOYAPPS.MARC_COUNTRIES
ORDER BY
	COUNTRY_REGION || ' - ' || COUNTRY_NAME
