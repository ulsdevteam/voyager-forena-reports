--ACCESS=access content
select 
distinct(p.po_number),
v.vendor_code,
v.vendor_name,
po.po_type_desc,
ps.po_status_desc,
p.po_status_date,
l.location_code,
p.po_approve_date,
p.line_item_count,
p.total / 100,
p.prepay_conversion_rate,
lg.ledger_name, 
lt.line_item_type_desc,
ii.line_price / 100,
ls.line_item_status_desc,
lc.status_date,
iv.invoice_number,
ii.line_price / 100,
iv.invoice_status_date,
case when p.po_status = 1 then to_char(current_date - p.po_approve_date, 999) else ' ' end "po status",
bt.language,
li.bib_id,
lc.mfhd_id,
bt.isbn,
case when bt.issn = null then bt.issn else '*issn' end "issn",
bt.title,
bt.author,
bt.publisher
from
	purchase_order p
inner join VENDORORDER_VW on p.po_number = VENDORORDER_VW.po_number,
	po_type po,
	vendor v,
	po_status ps,
	location l,
	ledger lg,
	line_item li,
	line_item_type lt,
	invoice_line_item ii,
	invoice iv,
	line_item_copy_status lc,
	line_item_status ls,
	bib_text bt,
	line_item_funds lf
where
	p.po_status_date between :start_date and :end_date
and
	v.vendor_id = p.vendor_id
and
	po.po_type_desc = :po_type_desc 
and
	ps.po_status_desc = :po_status_desc
and
	l.location_id = p.approve_location_id
and
	l.location_code = :location_code
and
	lg.ledger_name like :ledger_name
and
	p.po_id = li.po_id
and
	li.line_item_type = lt.line_item_type
and
	lt.line_item_type_desc = :line_item_type_desc
and
	li.line_item_id = lc.line_item_id
and
	lc.line_item_status = ls.line_item_status
and
	lc.line_item_id = ii.line_item_id
and
	ii.invoice_id = iv.invoice_id
and
	bt.bib_id = li.bib_id
and
	lg.ledger_id = lf.ledger_id
and
	lf.copy_id = lc.copy_id
and
	bt.language = :language
and
lt.line_item_type_desc = :line_item_type_desc	
