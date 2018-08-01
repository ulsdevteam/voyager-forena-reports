--ACCESS=access content
select        fp.fiscal_period_name,
                  lg.ledger_name,
                 v.vendor_code,
                  v.vendor_name,
                  i.invoice_number,
                  ilif.amount,
                  ili.line_price,
                  ili.prepay_amount,
                  i.invoice_total,
                 invs.invoice_status_desc,
                  to_char(i.invoice_status_date, 'yyyy/mm/dd') invoice_status_date,
                  i.voucher_number,
                  po.po_number,
                  po.total,
                  bt.isbn,
                  bt.issn,
                  bt.title,
                  bt.author,
                  bt.publisher,
                  bt.language
           from   pittdb.invoice_line_item_funds ilif
	          join pittdb.invoice_line_item ili on ili.inv_line_item_id = ilif.inv_line_item_id
		  join pittdb.invoice i on i.invoice_id = ili.invoice_id
		  join pittdb.invoice_status invs on invs.invoice_status = i.invoice_status
		  join pittdb.vendor v on v.vendor_id = i.vendor_id
		  join pittdb.line_item li on li.line_item_id = ili.line_item_id
		  join pittdb.purchase_order po on li.po_id = po.po_id
		  join pittdb.bib_text bt on bt.bib_id = li.bib_id
		  join ledger lg on ilif.ledger_id = lg.ledger_id
		  join fiscal_period fp on fp.fiscal_period_id = lg.fiscal_year_id
           where  
                    ilif.fund_id = :fund
	   and lg.fiscal_year_id = :fiscal
