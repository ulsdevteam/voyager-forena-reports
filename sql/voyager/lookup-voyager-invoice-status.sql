--ACCESS=access content
select i.invoice_status, i.invoice_status_desc
	from    pittdb.invoice_status i
	order by i.invoice_status, i.invoice_status_desc

