function init() {
	var peopleInfoDS = L5.DatasetMgr.lookup("peopleInfoDS");
	var dutyInfoDS = L5.DatasetMgr.lookup("dutyInfoDS");
	peopleInfoDS.baseParams["PEOPLE_ID@="] = peopleId;
	dutyInfoDS.baseParams["PEOPLE_ID@="] = peopleId;
	peopleInfoDS.load();
	dutyInfoDS.load();
}

// 全部取消
function back() {
	history.go(-1);
}