function init(){
   // var BaseinfoPeopleDataSet= L5.DatasetMgr.lookup("BaseinfoPeopleDataSet");
	BaseinfoPeopleDataSet.setParameter("BASEINFO_PEOPLE.FAMILY_ID@=",familyId);
	BaseinfoPeopleDataSet.setParameter("BASEINFO_PEOPLE.PERSONAL_STATS_TAG@=","0");
	BaseinfoPeopleDataSet.load();
	
    DemobilizedIllnessDataset.setParameter("peopleId",peopleId);
    DemobilizedIllnessDataset.load();
    
    BaseinfoFamilyDataSet.setParameter("BASEINFO_FAMILY.FAMILY_ID@=",familyId);
	BaseinfoFamilyDataSet.load();
}
function stop(){
  window.close();
}