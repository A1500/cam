function init(){
	var BptPeopleDisabilityDataSet = L5.DatasetMgr.lookup("BptPeopleDisabilityDataSet");
	BptPeopleDisabilityDataSet.setParameter("peopleId",peopleId);
	BptPeopleDisabilityDataSet.load();
	L5.QuickTips.init();
}