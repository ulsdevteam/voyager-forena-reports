select substr(upper(i.spine_label),0,15) tray, hdsshelf.traysize, sum(i.pieces) pieces, count(*) count
from pittdb.item i
left join voyapps.hdsshelf hdsshelf on hdsshelf.shelfaddr = substr(upper(i.spine_label),0,11)
where REGEXP_LIKE(i.spine_label, 'R[0-9][0-9]-M[0-9][0-9]-S[0-9][0-9]-T[0-9][0-9]','i')
and hdsshelf.traysize = 'G'
and i.item_type_id in (3,14)
group by substr(upper(i.spine_label),0,15), hdsshelf.traysize
order by substr(upper(i.spine_label),0,15)
