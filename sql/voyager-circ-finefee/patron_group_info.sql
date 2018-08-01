--ACCESS=access content
select distinct(patron.patron_id),
        patron_group.patron_group_code,
        patron.first_name,
        patron.last_name,
        patron.total_fees_due / 100 total_fees_due
from
        patron, patron_group, patron_barcode
where
        patron_barcode.patron_id = patron.patron_id
and
        patron_barcode.patron_group_id = patron_group.patron_group_id
and
        patron_group.patron_group_code = :patrongroup
order by patron_id
