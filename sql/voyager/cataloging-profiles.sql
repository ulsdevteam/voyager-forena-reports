select cp.cat_profile_name,
	o.first_name,
	o.last_name,
	co.operator_id,
	cp.bib_add,
	cp.bib_delete,
	cp.bib_export_ok,
	cp.bib_update,
	cp.bib_view_only,
	cp.item_add,
	cp.item_delete,
	cp.item_update,
	cp.item_view_only,
	cp.hold_add,
	cp.hold_delete,
	cp.mfhd_export_ok,
	cp.hold_update,
	cp.hold_view_only,
	cp.auth_add,
	cp.auth_delete,
	cp.auth_export_ok,
	cp.auth_update,
	cp.auth_view_only,
	cp.marcauth_add_update,
	cp.marcauth_view_only,
	cp.marcbib_add_update,
	cp.marcbib_view_only,
	cp.marchold_add_update,
	cp.marchold_view_only,
	cp.global_replace,
	cp.change_ownership,
	cp.hold_ignore_ownership
from pittdb.cat_profile cp,
	pittdb.cat_operator co,
	pittdb.operator o
where cp.cat_profile_id = co.cat_profile_id
	and co.operator_id = o.operator_id
order by cp.cat_profile_name
