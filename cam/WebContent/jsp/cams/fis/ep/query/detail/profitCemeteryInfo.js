function init() {
	var ds = L5.DatasetMgr.lookup("ds");
	ds.setParameter("APPLY_ID", idField)
	ds.load();
	L5.QuickTips.init();
}

function back() {
	history.go(-1);
}