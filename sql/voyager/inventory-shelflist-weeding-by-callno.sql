--ACCESS=access content
select 
       mm.display_call_no,
       bt.title_brief,
       bt.author,
       bt.publisher,
       bt.begin_pub_date,
       bt.edition,
       mm.mfhd_id,
       bt.bib_id,
       iv.item_id,			 
       bt.bib_format,
       bt.isbn,
       bt.issn,
       iv.barcode,		
       iv.historical_browses,
       iv.historical_charges
from   pittdb.mfhd_master mm,
       pittdb.bib_mfhd bm,
       pittdb.bib_item bi,
       pittdb.bib_text bt,
       pittdb.bib_master bms,
       pittdb.item_vw iv
where  mm.location_id = :location_id
and    mm.mfhd_id = bm.mfhd_id
and    bm.bib_id = bt.bib_id
and    bm.bib_id = bms.bib_id
and    bi.bib_id = bm.bib_id
and    iv.item_id = bi.item_id
and    bms.suppress_in_opac = 'N'
and    mm.suppress_in_opac = 'N'
order by mm.display_call_no
