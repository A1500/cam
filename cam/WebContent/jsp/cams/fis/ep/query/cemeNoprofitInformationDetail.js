function init() {
	ds.baseParams["CEME_ID@="] = idField;
	ds.load();
	L5.QuickTips.init();
}

function back() {
	history.go(-1);
}
