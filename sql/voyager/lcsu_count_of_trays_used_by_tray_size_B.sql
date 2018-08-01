--ACCESS=access content
select traysize "Tray Size",count(*) "Number of Shelves",sum(numtrays) "Number of Trays"
from VOYAPPS.HDSSHELF
where shelfstat='1'
group by traysize
order by traysize
