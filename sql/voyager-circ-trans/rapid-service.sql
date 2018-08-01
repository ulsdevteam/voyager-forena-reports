SELECT
	s.service_type,
	s.service_description
FROM
	voyapps.rapid_service s
WHERE
	s.service_type = :service_code

