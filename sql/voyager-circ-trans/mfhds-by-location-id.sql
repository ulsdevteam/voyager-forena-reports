--ACCESS=access content
select mm.mfhd_id,
                mm.display_call_no,
                mm.normalized_call_no,
                cnt.call_no_desc,
                bt.bib_id,
                bt.title_brief,
                bt.bib_format,
                bt.author,
                bt.publisher,
                bt.begin_pub_date,
                bt.edition,
                bms.suppress_in_opac,
                mm.suppress_in_opac,
                to_char(mm.create_date, 'yyyy/mm/dd') create_date,
                to_char(mm.update_date, 'yyyy/mm/dd') update_date,
                bt.isbn,
                bt.issn,
                bh.operator_id
         from   pittdb.mfhd_master mm,
                pittdb.bib_mfhd bm,
                pittdb.bib_text bt,
                pittdb.call_no_type cnt,
                pittdb.bib_master bms,
                pittdb.bib_history bh
         where  mm.location_id = :location_id
         and    mm.call_no_type = cnt.call_no_type (+)
         and    mm.mfhd_id = bm.mfhd_id
         and    bm.bib_id = bt.bib_id
         and    bm.bib_id = bms.bib_id
         and    bm.bib_id = bh.bib_id
         and    bh.action_type_id = 1

