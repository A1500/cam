function init(){
	var DemobilizedIllnessDataset = L5.DatasetMgr.lookup("DemobilizedIllnessDataset");
	DemobilizedIllnessDataset.setParameter("peopleId",peopleId);
	DemobilizedIllnessDataset.load();
	L5.QuickTips.init();
}