--ACCESS=access content
select 
inv.invoice_number,
to_char(inv.invoice_status_date, 'yyyy/mm/dd') "INVOICE_DATE",
                   inv.invoice_quantity,
                   inv.invoice_total/100 "INVOICE_TOTAL",
                   inv.adjustments_subtotal/100 "ADJUSTMENTS_SUBTOTAL", 
                   inv.Line_item_count,
                   inv.line_item_subtotal/100 "LINE_ITEM_SUBTOTAL",
                   v.vendor_code,
                   l.location_code,
                   lb.library_name
            from   pittdb.invoice inv,
                   pittdb.vendor v,
                   pittdb.location l,
                   pittdb.library lb
            where  inv.invoice_status = 0
            and    inv.vendor_id = v.vendor_id
            and    inv.bill_location = l.location_id
            and    l.library_id = lb.library_id
            order by lb.library_name,
                     l.location_code,
                     v.vendor_code,
                     inv.invoice_number

