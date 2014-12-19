function init(){
	var PeopleDemobilizedDataset = L5.DatasetMgr.lookup("PeopleDemobilizedDataset");
	PeopleDemobilizedDataset.setParameter("peopleId",peopleId);
	PeopleDemobilizedDataset.load();
	L5.QuickTips.init();
}