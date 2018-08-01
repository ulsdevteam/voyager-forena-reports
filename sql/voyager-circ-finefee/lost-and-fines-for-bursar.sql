select
	p.patron_id,
	p.last_name,
	p.first_name,
	p.middle_name,
	(
		select
			x.patron_barcode
		from
			(
				select
					b.patron_id,
					b.patron_barcode,
					g.patron_group_name
				from
					patron_barcode b left outer join
					patron_group g on (b.patron_group_id = g.patron_group_id)
				where
					b.barcode_status = 1
				order by
					case when nvl(g.patron_group_code, '') in ('UPgrad', 'UPundergrd', 'UPPhDdiss', 'UPgradLaw') then 1 else 0 end desc,
					b.barcode_status_date desc
			) x
		where
			x.patron_id = p.patron_id and
			ROWNUM = 1
	) patron_barcode,
	(
		select
			x.patron_group_name
		from
			(
				select
					b.patron_id,
					b.patron_barcode,
					g.patron_group_name
				from
					patron_barcode b left outer join
					patron_group g on (b.patron_group_id = g.patron_group_id)
				where
					b.barcode_status = 1
				order by
					case when nvl(g.patron_group_code, '') in ('UPgrad', 'UPundergrd', 'UPPhDdiss', 'UPgradLaw') then 1 else 0 end desc,
					b.barcode_status_date desc
			) x
		where
			x.patron_id = p.patron_id and
			ROWNUM = 1
	) patron_group_name,
	sum(f.fine_fee_balance/100) total_balance,
	sum(case when f.create_date between ds.since_date and du.until_date then f.fine_fee_balance/100 else 0 end) new_balance,
	max(case when f.create_date between ds.since_date and du.until_date then f.create_date end) create_date,
	max(case when l.patron_id > 0 then 'LOST' end) lost_items
from
	(select to_date(:begin_date) since_date from dual) ds cross join
	(select to_date(:end_date) + 1 until_date from dual) du cross join
	patron p left outer join
	fine_fee f on (f.patron_id = p.patron_id and f.create_date < du.until_date) left outer join
	patron l on (
		p.patron_id = l.patron_id and
		exists
		(
			select
				c.circ_transaction_id
			from
				circ_transactions c join
				item i on (c.item_id = i.item_id) join
				item_status s on (i.item_id = s.item_id) join
				item_status_type t on (s.item_status = t.item_status_type)
			where
				c.patron_id = p.patron_id and
				t.item_status_desc like 'Lost%' and
				s.item_status_date between ds.since_date and du.until_date
		)
	)
where
	exists (select fx.fine_fee_id from fine_fee fx where fx.create_date between ds.since_date and du.until_date and fx.patron_id = p.patron_id) or l.patron_id is not null
group by
	p.patron_id,
	p.last_name,
	p.first_name,
	p.middle_name
having
	sum(f.fine_fee_balance/100) >= 35 or max(l.patron_id) is not null
order by
	create_date,
	last_name,
	first_name,
	middle_name
