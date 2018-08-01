--ACCESS=access content
select 
                   lt.location_code "Item Temp Loc",
                   lp.location_code "Item Perm Loc",
                   mm.display_call_no "Mfhd Call Number",
                   lm.location_code "Mfhd Loc",
                   its.item_id "Item ID",
                   ib.item_barcode "Item Barcode",
                   ist.item_status_desc "Item Status",
                   its.item_status_date "Item Status Date",
                   dl.location_code "Discharge Loc",
                   ct.discharge_date "Discharge Date",
                   ct.charge_oper_id "Discharge Oper ID",
                   case ct.charge_type when 'N' then 'Normal' when 'O' then 'Override' else ' ' end "Discharge Type",
                   bt.title_brief "Title Brief",
                  case when i.spine_label like 'R__-M__-S__%' then i.spine_label else ' ' end "Tray Address"
            from pittdb.mfhd_master mm,
                 pittdb.mfhd_item mi,
                 pittdb.item i,
                 pittdb.item_barcode ib,
                 pittdb.location lp,
                 pittdb.location lt,
                 pittdb.location lm,
                 pittdb.location dl,
                 pittdb.item_status its,
                 pittdb.circ_trans_archive ct,
                 pittdb.bib_text bt,
                 pittdb.bib_item bi,
                 pittdb.item_status_type ist
            where its.item_status in (8, 9, 10)
            and   its.item_id = i.item_id
            and   its.item_status = ist.item_status_type
            and   ist.item_status_type in (8,9,10)
            and   i.perm_location = lp.location_id
            and   i.temp_location = lt.location_id(+)
            and   i.item_id = mi.item_id
            and   i.item_id = ib.item_id
            and   mi.mfhd_id = mm.mfhd_id
            and   mm.location_id = lm.location_id
            and   ct.discharge_date between :start_date and :end_date 
            and   ct.discharge_location = dl.location_id
            and   ct.item_id = i.item_id
            and   bi.item_id = i.item_id
            and   bi.bib_id = bt.bib_id
            order by lt.location_code,
                     lp.location_code,
                     mm.display_call_no
