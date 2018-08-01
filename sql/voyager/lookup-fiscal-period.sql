--ACCESS=access content
select fp.fiscal_period_id,fp.fiscal_period_name
from pittdb.fiscal_period fp
order by fp.fiscal_period_id desc
