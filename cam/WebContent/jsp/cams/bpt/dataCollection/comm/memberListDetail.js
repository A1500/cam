function init(){
	var BaseinfoPeopleDataSet = L5.DatasetMgr.lookup("BaseinfoPeopleDataSet");
	BaseinfoPeopleDataSet.setParameter("BASEINFO_PEOPLE.FAMILY_ID@=",familyId);
	BaseinfoPeopleDataSet.setParameter("BASEINFO_PEOPLE.PERSONAL_STATS_TAG@=","0");
	BaseinfoPeopleDataSet.load();
	var queryTotalDataset = L5.DatasetMgr.lookup("queryTotalDataset");
	queryTotalDataset.setParameter("familyId",familyId);
	queryTotalDataset.load();
	L5.QuickTips.init();
}
