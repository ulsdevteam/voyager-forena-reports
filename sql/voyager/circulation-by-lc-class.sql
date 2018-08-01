--ACCESS=forena category Voyager - Statistics

--- yale/harvard report with fiscal years.
--- Yale Harvard stats without null LC_CLASS and Grouped by LC_CLASS restrict by item_code.
select 
	 SUBSTR(iv.normalized_call_no, 1, INSTR(iv.normalized_call_no,' ', 1, 1)-1) lc_class,
	 EXTRACT(YEAR FROM ADD_MONTHS(cc.charge_date_only, 6)) fiscal_year,
      count(*) TOTAL_CHARGES
from
      pittdb.circcharges_vw cc,
      pittdb.bib_text b,
      pittdb.bib_item bi,
      pittdb.item_vw iv
where
      bi.item_id = cc.item_id
      and bi.bib_id = b.bib_id
      and iv.item_id = cc.item_id
	 and SUBSTR(iv.normalized_call_no, 1, INSTR(iv.normalized_call_no, ' ', 1, 1) -1) is not NULL
	 and LENGTH(SUBSTR(iv.normalized_call_no, 1, INSTR(iv.normalized_call_no, ' ', 1, 1) -1)) < 4
	 and EXTRACT(YEAR FROM ADD_MONTHS(cc.charge_date_only, 6)) = :fiscal_year
	 and iv.perm_item_type in :item_type_code
group by
	 SUBSTR(iv.normalized_call_no, 1, INSTR(iv.normalized_call_no,' ', 1, 1)-1),
	 EXTRACT(YEAR FROM ADD_MONTHS(cc.charge_date_only, 6))
order by
	 SUBSTR(iv.normalized_call_no, 1, INSTR(iv.normalized_call_no,' ', 1, 1)-1),
	 EXTRACT(YEAR FROM ADD_MONTHS(cc.charge_date_only, 6))
--- 	 and EXTRACT(YEAR FROM ADD_MONTHS(cc.charge_date_only, 6)) = '2015'
