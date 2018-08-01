--ACCESS=access content
select 
        'Total Bibs' rowtype,
	count(case when library_id = '1' then library_id end) Bradford,
	count(case when library_id = '5' then library_id end) Greensburg,
	count(case when library_id = '10' then library_id end) HSLS,
	count(case when library_id = '6' then library_id end) Johnstown,
	count(case when library_id = '7' then library_id end) Law,
	count(case when library_id = '9' then library_id end) Titusville,
	count(case when library_id = '2' then library_id end) ULS,
	count(case when library_id = '8' then library_id end) SemesterSea 
	from pittdb.bib_master
        where create_date between :startdate and to_date(:enddate) +1
union
select
                'Suppressed Bibs', 
                count(case when library_id = '1' and suppress_in_opac = 'Y' then library_id end),
                count(case when library_id = '5' and suppress_in_opac = 'Y' then library_id end),
                count(case when library_id = '10' and suppress_in_opac = 'Y' then library_id end),
                count(case when library_id = '6' and suppress_in_opac = 'Y' then library_id end),
                count(case when library_id = '7' and suppress_in_opac = 'Y' then library_id end),
                count(case when library_id = '9' and suppress_in_opac = 'Y' then library_id end),
                count(case when library_id = '2' and suppress_in_opac = 'Y' then library_id end),
                count(case when library_id = '8' and suppress_in_opac = 'Y' then library_id end)
        from 
                pittdb.bib_master
        where create_date between :startdate and to_date(:enddate) +1
union
select
                'Total MFHDS', 
                count(case when location_id in (select l.location_id from   pittdb.location l, pittdb.library lb where  l.library_id = lb.library_id and lb.library_name = 'Bradford') then location_id end),
                count(case when location_id in (select l.location_id from   pittdb.location l, pittdb.library lb where  l.library_id = lb.library_id and lb.library_name = 'Greensburg') then location_id end),
                count(case when location_id in (select l.location_id from   pittdb.location l, pittdb.library lb where  l.library_id = lb.library_id and lb.library_name = 'HSLS') then location_id end),
                count(case when location_id in (select l.location_id from   pittdb.location l, pittdb.library lb where  l.library_id = lb.library_id and lb.library_name = 'Johnstown') then location_id end),
                count(case when location_id in (select l.location_id from   pittdb.location l, pittdb.library lb where  l.library_id = lb.library_id and lb.library_name = 'Law') then location_id end),
                count(case when location_id in (select l.location_id from   pittdb.location l, pittdb.library lb where  l.library_id = lb.library_id and lb.library_name = 'Titusville') then location_id end),
                count(case when location_id in (select l.location_id from   pittdb.location l, pittdb.library lb where  l.library_id = lb.library_id and lb.library_name = 'ULS') then location_id end),
                count(case when location_id in (select l.location_id from   pittdb.location l, pittdb.library lb where  l.library_id = lb.library_id and lb.library_name = 'Semester at Sea') then location_id end)
        from 
                pittdb.mfhd_master
        where create_date between :startdate and to_date(:enddate) +1
union
select
                'Total Items', 
                count(case when perm_location in (select l.location_id from pittdb.location l, pittdb.item i, pittdb.library lb where  l.library_id = lb.library_id and lb.library_name = 'Bradford') then perm_location end),
                count(case when perm_location in (select l.location_id from pittdb.location l, pittdb.item i, pittdb.library lb where  l.library_id = lb.library_id and lb.library_name = 'Greensburg') then perm_location end),
                count(case when perm_location in (select l.location_id from pittdb.location l, pittdb.item i, pittdb.library lb where  l.library_id = lb.library_id and lb.library_name = 'HSLS') then perm_location end),
                count(case when perm_location in (select l.location_id from pittdb.location l, pittdb.item i, pittdb.library lb where  l.library_id = lb.library_id and lb.library_name = 'Johnstown') then perm_location end),
                count(case when perm_location in (select l.location_id from pittdb.location l, pittdb.item i, pittdb.library lb where  l.library_id = lb.library_id and lb.library_name = 'Law') then perm_location end),
                count(case when perm_location in (select l.location_id from pittdb.location l, pittdb.item i, pittdb.library lb where  l.library_id = lb.library_id and lb.library_name = 'Titusville') then perm_location end),
                count(case when perm_location in (select l.location_id from pittdb.location l, pittdb.item i, pittdb.library lb where  l.library_id = lb.library_id and lb.library_name = 'ULS') then perm_location end),
                count(case when perm_location in (select l.location_id from pittdb.location l, pittdb.item i, pittdb.library lb where  l.library_id = lb.library_id and lb.library_name = 'Semester at Sea') then perm_location end)
        from 
                PITTDB.item
        where create_date between :startdate and to_date(:enddate) +1
union
select 
                'Items with Active Barcodes',
                count(case when perm_location in (select l.location_id from pittdb.location l, pittdb.item i, pittdb.library lb, item_barcode ib where  l.library_id = lb.library_id and i.item_id = ib.item_id and ib.barcode_status = 1 and lb.library_name = 'Bradford') then perm_location end),
                count(case when perm_location in (select l.location_id from pittdb.location l, pittdb.item i, pittdb.library lb, item_barcode ib where  l.library_id = lb.library_id and i.item_id = ib.item_id and ib.barcode_status = 1 and lb.library_name = 'Greensburg') then perm_location end),
                count(case when perm_location in (select l.location_id from pittdb.location l, pittdb.item i, pittdb.library lb, item_barcode ib where  l.library_id = lb.library_id and i.item_id = ib.item_id and ib.barcode_status = 1 and lb.library_name = 'HSLS') then perm_location end),
                count(case when perm_location in (select l.location_id from pittdb.location l, pittdb.item i, pittdb.library lb, item_barcode ib where  l.library_id = lb.library_id and i.item_id = ib.item_id and ib.barcode_status = 1 and lb.library_name = 'Johnstown') then perm_location end),
                count(case when perm_location in (select l.location_id from pittdb.location l, pittdb.item i, pittdb.library lb, item_barcode ib where  l.library_id = lb.library_id and i.item_id = ib.item_id and ib.barcode_status = 1 and lb.library_name = 'Law') then perm_location end),
                count(case when perm_location in (select l.location_id from pittdb.location l, pittdb.item i, pittdb.library lb, item_barcode ib where  l.library_id = lb.library_id and i.item_id = ib.item_id and ib.barcode_status = 1 and lb.library_name = 'Titusville') then perm_location end),
                count(case when perm_location in (select l.location_id from pittdb.location l, pittdb.item i, pittdb.library lb, item_barcode ib where  l.library_id = lb.library_id and i.item_id = ib.item_id and ib.barcode_status = 1 and lb.library_name = 'ULS') then perm_location end),
                count(case when perm_location in (select l.location_id from pittdb.location l, pittdb.item i, pittdb.library lb, item_barcode ib where  l.library_id = lb.library_id and i.item_id = ib.item_id and ib.barcode_status = 1 and lb.library_name = 'Semester at Sea') then perm_location end)
        from 
                PITTDB.item
        where create_date between :startdate and to_date(:enddate) +1
union
select
        'Total Purchase Orders', 
        count(case when po.po_id in (select po.po_id from pittdb.location l, pittdb.purchase_order po, pittdb.item i, pittdb.library lb, item_barcode ib 
                where  
                        po.create_location_id = l.location_id 
                and 
                        l.library_id = lb.library_id 
                and 
                        i.item_id = ib.item_id 
                and 
                        lb.library_name = 'Bradford') 
                then po.po_id end),
        count(case when po.po_id in (select po.po_id from pittdb.location l, pittdb.purchase_order po, pittdb.item i, pittdb.library lb, item_barcode ib 
                where  
                        po.create_location_id = l.location_id 
                and 
                        l.library_id = lb.library_id 
                and 
                        i.item_id = ib.item_id 
                and 
                        lb.library_name = 'Greensburg') 
                then po.po_id end),
        count(case when po.po_id in (select po.po_id from pittdb.location l, pittdb.purchase_order po, pittdb.item i, pittdb.library lb, item_barcode ib 
                where  
                        po.create_location_id = l.location_id 
                and 
                        l.library_id = lb.library_id 
                and 
                        i.item_id = ib.item_id 
                and 
                        lb.library_name = 'HSLS') 
                then po.po_id end),
        count(case when po.po_id in (select po.po_id from pittdb.location l, pittdb.purchase_order po, pittdb.item i, pittdb.library lb, item_barcode ib 
                where  
                        po.create_location_id = l.location_id 
                and 
                        l.library_id = lb.library_id 
                and 
                        i.item_id = ib.item_id 
                and 
                        lb.library_name = 'Johnstown') 
                then po.po_id end),
        count(case when po.po_id in (select po.po_id from pittdb.location l, pittdb.purchase_order po, pittdb.item i, pittdb.library lb, item_barcode ib 
                where  
                        po.create_location_id = l.location_id 
                and 
                        l.library_id = lb.library_id 
                and 
                        i.item_id = ib.item_id 
                and 
                        lb.library_name = 'Law') 
                then po.po_id end),
        count(case when po.po_id in (select po.po_id from pittdb.location l, pittdb.purchase_order po, pittdb.item i, pittdb.library lb, item_barcode ib 
                where  
                        po.create_location_id = l.location_id 
                and 
                        l.library_id = lb.library_id 
                and 
                        i.item_id = ib.item_id 
                and 
                        lb.library_name = 'Titusville') 
                then po.po_id end),
        count(case when po.po_id in (select po.po_id from pittdb.location l, pittdb.purchase_order po, pittdb.item i, pittdb.library lb, item_barcode ib 
                where  
                        po.create_location_id = l.location_id 
                and 
                        l.library_id = lb.library_id 
                and 
                        i.item_id = ib.item_id 
                and 
                        lb.library_name = 'ULS') 
                then po.po_id end),
        count(case when po.po_id in (select po.po_id from pittdb.location l, pittdb.purchase_order po, pittdb.item i, pittdb.library lb, item_barcode ib 
                where  
                        po.create_location_id = l.location_id 
                and 
                        l.library_id = lb.library_id 
                and 
                        i.item_id = ib.item_id 
                and 
                        lb.library_name = 'Semester at Sea') 
                then po.po_id end)
        from   pittdb.purchase_order po, PITTDB.location l
        where po.create_location_id = l.location_id
        and   po.po_create_date between :startdate and to_date(:enddate) +1
union
select 
              'Total Lines in Purchase Order',
        count(case when lic.line_item_id in (select lic.line_item_id from pittdb.location l, pittdb.purchase_order po, pittdb.line_item_copy lic, pittdb.item i, pittdb.library lb, item_barcode ib 
                where  
                        lic.location_id = l.location_id 
                and 
                        l.library_id = lb.library_id 
                and 
                        i.item_id = ib.item_id 
                and 
                        lb.library_name = 'Bradford') 
                then lic.line_item_id end),
        count(case when lic.line_item_id in (select lic.line_item_id from pittdb.location l, pittdb.purchase_order po, pittdb.line_item_copy lic, pittdb.item i, pittdb.library lb, item_barcode ib 
                where  
                        lic.location_id = l.location_id 
                and 
                        l.library_id = lb.library_id 
                and 
                        i.item_id = ib.item_id 
                and 
                        lb.library_name = 'Greensburg') 
                then lic.line_item_id end),
        count(case when lic.line_item_id in (select lic.line_item_id from pittdb.location l, pittdb.purchase_order po, pittdb.line_item_copy lic, pittdb.item i, pittdb.library lb, item_barcode ib 
                where  
                        lic.location_id = l.location_id 
                and 
                        l.library_id = lb.library_id 
                and 
                        i.item_id = ib.item_id 
                and 
                        lb.library_name = 'HSLS') 
                then lic.line_item_id end),
        count(case when lic.line_item_id in (select lic.line_item_id from pittdb.location l, pittdb.purchase_order po, pittdb.line_item_copy lic, pittdb.item i, pittdb.library lb, item_barcode ib 
                where  
                        lic.location_id = l.location_id 
                and 
                        l.library_id = lb.library_id 
                and 
                        i.item_id = ib.item_id 
                and 
                        lb.library_name = 'Johnstown') 
                then lic.line_item_id end),
        count(case when lic.line_item_id in (select lic.line_item_id from pittdb.location l, pittdb.purchase_order po, pittdb.line_item_copy lic, pittdb.item i, pittdb.library lb, item_barcode ib 
                where  
                        lic.location_id = l.location_id 
                and 
                        l.library_id = lb.library_id 
                and 
                        i.item_id = ib.item_id 
                and 
                        lb.library_name = 'Law') 
                then lic.line_item_id end),
        count(case when lic.line_item_id in (select lic.line_item_id from pittdb.location l, pittdb.purchase_order po, pittdb.line_item_copy lic, pittdb.item i, pittdb.library lb, item_barcode ib 
                where  
                        lic.location_id = l.location_id 
                and 
                        l.library_id = lb.library_id 
                and 
                        i.item_id = ib.item_id 
                and 
                        lb.library_name = 'Titusville')
                then lic.line_item_id end),
        count(case when lic.line_item_id in (select lic.line_item_id from pittdb.location l, pittdb.purchase_order po, pittdb.line_item_copy lic, pittdb.item i, pittdb.library lb, item_barcode ib 
                where  
                        lic.location_id = l.location_id 
                and 
                        l.library_id = lb.library_id 
                and 
                        i.item_id = ib.item_id 
                and 
                        lb.library_name = 'ULS')
                then lic.line_item_id end),
        count(case when lic.line_item_id in (select lic.line_item_id from pittdb.location l, pittdb.purchase_order po, pittdb.line_item_copy lic, pittdb.item i, pittdb.library lb, item_barcode ib 
                where  
                        lic.location_id = l.location_id 
                and 
                        l.library_id = lb.library_id 
                and 
                        i.item_id = ib.item_id 
                and 
                        lb.library_name = 'Semester at Sea') 
                then lic.line_item_id end)
        from   PITTDB.line_item_copy lic, PITTDB.line_item li
        where li.line_item_id = lic.line_item_id
        and create_date between :startdate and to_date(:enddate) +1
union
select
                'Suppressed MFHD', 
                count(case when location_id in (select l.location_id from   pittdb.location l, pittdb.library lb where  l.library_id = lb.library_id and lb.library_name = 'Bradford') then location_id end),
                count(case when location_id in (select l.location_id from   pittdb.location l, pittdb.library lb where  l.library_id = lb.library_id and lb.library_name = 'Greensburg') then location_id end),
                count(case when location_id in (select l.location_id from   pittdb.location l, pittdb.library lb where  l.library_id = lb.library_id and lb.library_name = 'HSLS') then location_id end),
                count(case when location_id in (select l.location_id from   pittdb.location l, pittdb.library lb where  l.library_id = lb.library_id and lb.library_name = 'Johnstown') then location_id end),
                count(case when location_id in (select l.location_id from   pittdb.location l, pittdb.library lb where  l.library_id = lb.library_id and lb.library_name = 'Law') then location_id end),
                count(case when location_id in (select l.location_id from   pittdb.location l, pittdb.library lb where  l.library_id = lb.library_id and lb.library_name = 'Titusville') then location_id end),
                count(case when location_id in (select l.location_id from   pittdb.location l, pittdb.library lb where  l.library_id = lb.library_id and lb.library_name = 'ULS') then location_id end),
                count(case when location_id in (select l.location_id from   pittdb.location l, pittdb.library lb where  l.library_id = lb.library_id and lb.library_name = 'Semester at Sea') then location_id end)
        from 
                pittdb.mfhd_master mm
        where
                mm.suppress_in_opac = 'Y'
        and
                mm.create_date between :startdate and to_date(:enddate) +1
