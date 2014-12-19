function init(){
   // var BaseinfoPeopleDataSet= L5.DatasetMgr.lookup("BaseinfoPeopleDataSet");
	BaseinfoPeopleDataSet.setParameter("BASEINFO_PEOPLE.FAMILY_ID@=",familyId);
	BaseinfoPeopleDataSet.setParameter("BASEINFO_PEOPLE.PERSONAL_STATS_TAG@=","0");
	BaseinfoPeopleDataSet.load();
	
    DemobilizedIllnessDataset.setParameter("peopleId",peopleId);
    DemobilizedIllnessDataset.load();
    
    BaseinfoFamilyDataSet.setParameter("BASEINFO_FAMILY.FAMILY_ID@=",familyId);
	BaseinfoFamilyDataSet.load();
	
	//迁入信息word重复打开
	L5.getCmp("intoPrintPanel").on("activate",demoIllInPrtRpt);
}

//迁入信息word重复打开
function demoIllInPrtRpt(){
	var src = document.getElementById("intoPrint").src;
	document.getElementById("intoPrint").src = src;
}

function stop(){
  window.close();
}