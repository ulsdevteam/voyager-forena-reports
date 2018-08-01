--ACCESS=access content
select bh.operator_id
from pittdb.bib_history bh
group by bh.operator_id
order by bh.operator_id

