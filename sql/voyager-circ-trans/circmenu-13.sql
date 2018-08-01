select
		   case when cta.item_id = ib.item_id then 'Archived' else '*' end "Type of Trans", 
		   ib.item_id "Item ID",
		   ib.item_barcode "Item Barcode",
		   ibs.barcode_status_desc "Item Barcode Status",
		   cpg.circ_group_name "Circ Policy Group",
		   ppg.patron_group_code "Patron Group",
		   ity.item_type_code "Item Type",
                   to_char(cta.charge_date, 'yyyy/mm/dd hh24:mi') ctachgdate,
                   lchg.location_code "charge Loc",
                   case cta.charge_type when 'N' then  'Normal' else ' ' end "Charge Type",
                   cta.charge_oper_id "Charge OperID",
                   to_char(cta.due_date, 'yyyy/mm/dd hh24:mi') "Due Date",
                   to_char(cta.discharge_date, 'yyyy/mm/dd hh24:mi') "Discharge Date",
                   ldis.location_code "Discharge Loc",
                   case cta.discharge_type when 'N' then 'Normal' else ' ' end "Discharge Type",
                   cta.discharge_oper_id "Discharge OperID",
                   cta.renewal_count "Renew Count",
                   case when to_char(cta.recall_date) is null then '*' else to_char(cta.recall_date) end "Recall Date",
                   case when to_char(cta.recall_due_date) is null then '*' else to_char(cta.recall_due_date) end "Recall Due Date",
                   cta.recall_notice_count" Recall Notice Count",
                   case when to_char(cta.recall_notice_date) is null then '*' else to_char(cta.recall_notice_date) end "Recall Notice Date",
                   cta.overdue_notice_count "Overdue Notice Count",
                    case when to_char(cta.overdue_notice_date, 'yyyy/mm/dd hh24:mi') is null then '*' else to_char(cta.overdue_notice_date, 'yyyy/mm/dd hh24:mi') end "Overdue Notice Date",
                   cta.over_recall_notice_count "Over-Recall Notice Count",
                   case when to_char(cta.over_recall_notice_date) is null then '*' else to_char(cta.over_recall_notice_date) end "Over-Recall Notice Date",
                   cta.patron_id "Patrin ID",
                   cta.patron_id_proxy "Patron ID Proxy",
                   case when to_char(cta.courtesy_notice_date) is null then '*' else to_char(cta.courtesy_notice_date) end "Courtesy Notice Date",
		   cta.circ_transaction_id "Circ Tran ID",
		   cta.due_date "Current Due Date",
		   bt.title_brief "Title"
            from  pittdb.circ_trans_archive cta,
                  pittdb.location lchg,
                  pittdb.location ldis,
                  pittdb.patron_group ppg,
                  pittdb.item_barcode ib,
                  PITTDB.ITEM_BARCODE_STATUS ibs,
                  pittdb.item i,
                  pittdb.item_type ity,
		  pittdb.circ_policy_matrix cpm,
                  pittdb.circ_policy_group cpg,
		  pittdb.bib_text bt,
		  pittdb.bib_item bi
            where
                   bi.item_id = ib.item_id
            and     cta.item_id = ib.item_id
	    and    bi.bib_id = bt.bib_id
            and    cta.patron_group_id = ppg.patron_group_id
            and    cta.charge_location = lchg.location_id
            and    cta.discharge_location = ldis.location_id
            and    cta.item_id = ib.item_id
            and    ib.barcode_status = ibs.barcode_status_type
            and    cta.item_id = :itemid
            and    i.item_type_id = ity.item_type_id
	  and cpm.circ_policy_matrix_id = cta.circ_policy_matrix_id
          and   cpm.circ_group_id = cpg.circ_group_id
	  and    cta.item_id = i.item_id
union
select
                   case when ct.item_id = ib.item_id then 'Active' else '*' end "Type of Trans",
                   ib.item_id "Item ID",
                   ib.item_barcode "Item Barcode",
                   ibs.barcode_status_desc "Item Barcode Status",
                   cpg.circ_group_name "Circ Policy Group",
                   ppg.patron_group_code "Patron Group",
                   ity.item_type_code "Item Type",
                   to_char(ct.charge_date, 'yyyy/mm/dd hh24:mi') ctachgdate,
                   lchg.location_code "charge Loc",
                   case ct.charge_type when 'N' then  'Normal' else ' ' end "Charge Type",
                   ct.charge_oper_id "Charge OperID",
                   to_char(ct.charge_due_date, 'yyyy/mm/dd hh24:mi') "Due Date",
                   to_char(ct.discharge_date, 'yyyy/mm/dd hh24:mi') "Discharge Date",
                   '' "Discharge Loc",
                   case ct.discharge_type when 'N' then 'Normal' else ' ' end "Discharge Type",
                   ct.discharge_oper_id "Discharge OperID",
                   ct.renewal_count "Renew Count",
                   case when to_char(ct.recall_date) is null then '*' else to_char(ct.recall_date) end "Recall Date",
                   case when to_char(ct.recall_due_date) is null then '*' else to_char(ct.recall_due_date) end "Recall Due Date",
                   ct.recall_notice_count" Recall Notice Count",
                   case when to_char(ct.recall_notice_date) is null then '*' else to_char(ct.recall_notice_date) end "Recall Notice Date",
                   ct.overdue_notice_count "Overdue Notice Count",
                    case when to_char(ct.overdue_notice_date, 'yyyy/mm/dd hh24:mi') is null then '*' else to_char(ct.overdue_notice_date, 'yyyy/mm/dd hh24:mi') end "Overdue Notice Date",
                   ct.over_recall_notice_count "Over-Recall Notice Count",
                   case when to_char(ct.over_recall_notice_date) is null then '*' else to_char(ct.over_recall_notice_date) end "Over-Recall Notice Date",
                   ct.patron_id "Patrin ID",
                   ct.patron_id_proxy "Patron ID Proxy",
                   case when to_char(ct.courtesy_notice_date) is null then '*' else to_char(ct.courtesy_notice_date) end "Courtesy Notice Date",
                   ct.circ_transaction_id "Circ Tran ID",
                   ct.charge_due_date "Current Due Date",
                   bt.title_brief "Title"
            from  pittdb.circ_transactions ct,
                  pittdb.location lchg,
                  pittdb.patron_group ppg,
                  pittdb.item_barcode ib,
                  PITTDB.ITEM_BARCODE_STATUS ibs,
                  pittdb.item i,
                  pittdb.item_type ity,
                  pittdb.circ_policy_matrix cpm,
                  pittdb.circ_policy_group cpg,
                  pittdb.bib_text bt,
                  pittdb.bib_item bi
            where
                   bi.item_id = ib.item_id
            and     ct.item_id = ib.item_id
            and    bi.bib_id = bt.bib_id
            and    ct.patron_group_id = ppg.patron_group_id
            and    ct.charge_location = lchg.location_id
            and    ct.item_id = :itemid
            and    ib.barcode_status = ibs.barcode_status_type
            and    ct.item_id = i.item_id
            and    i.item_type_id = ity.item_type_id
          and cpm.circ_policy_matrix_id = ct.circ_policy_matrix_id
          and   cpm.circ_group_id = cpg.circ_group_id
          and    ct.item_id = i.item_id
            order by ctachgdate desc
