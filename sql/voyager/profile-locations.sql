--ACCESS=access content
select 'Catloging' as profile_type, cp.cat_profile_name as profile_name, loc.location_code, loc.location_name
from pittdb.cat_profile cp,
pittdb.cat_security_locs csl,
pittdb.location loc
where csl.location_id = loc.location_id
and cp.cat_profile_id = csl.cat_profile_id
UNION
select 'Acquisitions' as profile_type, cp.acq_profile_name as profile_name, loc.location_code, loc.location_name
from pittdb.acq_profile cp,
pittdb.acq_security_locs csl,
pittdb.location loc
where csl.location_id = loc.location_id
and cp.acq_profile_id = csl.acq_profile_id
UNION
select 'Circulation' as profile_type, cp.circ_profile_name as profile_name, loc.location_code, loc.location_name
from pittdb.circ_profile cp,
pittdb.circ_security_locs csl,
pittdb.location loc
where csl.location_id = loc.location_id
and cp.circ_profile_id = csl.circ_profile_id
UNION
select 'Master' as profile_type, cp.master_profile_name as profile_name, loc.location_code, loc.location_name
from pittdb.MASTER_PROFILE cp,
pittdb.master_security_locs msl,
pittdb.location loc
where msl.location_id = loc.location_id
and cp.master_profile_id = msl.master_profile_id
ORDER BY profile_type,profile_name
