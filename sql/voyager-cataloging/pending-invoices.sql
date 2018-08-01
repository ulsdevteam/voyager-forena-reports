select
      lb.library_name owning_library,
      l.location_code billing_location,
      v.vendor_code vendor,
      inv.invoice_number,
                   to_char(inv.invoice_status_date, 'yyyy/mm/dd') invoice_status_date,
                   inv.invoice_quantity invoice_qty,
                   inv.invoice_total /100 "invoice_total",
                   inv.adjustments_subtotal,
                   inv.line_item_count,
                   inv.line_item_subtotal/100 "Line Item Subtotal" 
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

