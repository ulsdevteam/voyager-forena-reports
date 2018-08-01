select rr.rule_id,
       rr.rule_name,
       rr.fiscal_period_id,
         fp.fiscal_period_name,
       rr.new_fiscal_period_id new_fiscal_period_name,
         nfp.fiscal_period_name new_fiscal_period_name,
         ld.ledger_id,
         ld.ledger_name
from   pittdb.rollover_rules rr,
         pittdb.fiscal_period fp,
         pittdb.fiscal_period nfp,
         pittdb.ledger ld
where  rr.fiscal_period_id = :fiscal_period
and    fp.fiscal_period_id = rr.fiscal_period_id
and    nfp.fiscal_period_id = rr.new_fiscal_period_id
and      ld.rule_id = rr.rule_id
order by rr.rule_name
