function init() {
	var BaseinfoPeopleDataSet= L5.DatasetMgr.lookup("BaseinfoPeopleDataSet");
	BaseinfoPeopleDataSet.setParameter("PEOPLE_ID",peopleId);
	BaseinfoPeopleDataSet.load();
	L5.QuickTips.init();
}