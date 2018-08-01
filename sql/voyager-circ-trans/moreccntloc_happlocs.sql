--ACCESS=access content
select count(suppress_in_opac) from location where suppress_in_opac = 'Y' and location_name not like 'zzz%' and location_name not like 'lcb%'
