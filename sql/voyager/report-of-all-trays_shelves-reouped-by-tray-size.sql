--ACCESS=access content
-- Report of all trays and shelves grouped by tray size
select traysize "Tray Size",count(*) "Number of Shelves",sum(numtrays) "Number of Trays"
from HDSSHELF
group by traysize
order by traysize
