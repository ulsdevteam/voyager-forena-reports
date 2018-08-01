--ACCESS=access content
select	mp.master_profile_name,
	o.first_name,
	o.last_name,
	mo.operator_id,
	mp.security,
	mp.security_view,
	mp.acq_policies,
	mp.acq_policies_view,
	mp.cat_policies,
	mp.cat_policies_view,
	mp.circ_policies,
	mp.circ_policies_view,
	mp.patron_group_edit,
	mp.patron_group_view,
	mp.system_definitions,
	mp.system_defs_view,
	mp.cluster_create,
	mp.cluster_edit,
	mp.cluster_delete,
	mp.cluster_view,
	mp.media_policies
from pittdb.master_profile mp,
	pittdb.master_operator mo,
	pittdb.operator o
where	mp.master_profile_id = mo.master_profile_id
	and mo.operator_id = o.operator_id
order by mp.master_profile_name
