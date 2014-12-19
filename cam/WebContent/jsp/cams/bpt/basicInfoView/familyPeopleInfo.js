function init(){
    BaseinfoPeopleDataSet.setParameter("BASEINFO_PEOPLE.FAMILY_ID@=",familyId);
	BaseinfoPeopleDataSet.setParameter("BASEINFO_PEOPLE.PERSONAL_STATS_TAG@=","0");
	BaseinfoPeopleDataSet.load();
	
    PeopleDemobilizedDataset.setParameter("peopleId",peopleId);
    PeopleDemobilizedDataset.load();
    
    BaseinfoFamilyDataSet.setParameter("BASEINFO_FAMILY.FAMILY_ID@=",familyId);
	BaseinfoFamilyDataSet.load();
	var queryTotalDataset = L5.DatasetMgr.lookup("queryTotalDataset");
	queryTotalDataset.setParameter("familyId",familyId);
	queryTotalDataset.load();
}
function stop(){
    window.close();
}