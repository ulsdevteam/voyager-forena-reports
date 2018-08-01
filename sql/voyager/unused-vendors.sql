--ACCESS=access content
SELECT vendor.vendor_name, vendor.vendor_code
FROM vendor
WHERE vendor.vendor_code NOT IN (SELECT v.vendor_code FROM vendorinvoice_vw v WHERE v.expenditures is not null)
AND vendor.vendor_code NOT IN (SELECT v.vendor_code FROM vendororder_vw v WHERE v.total > 0)
ORDER BY vendor.vendor_name
