function init(){
    BaseinfoPeopleDataSet.setParameter("BASEINFO_PEOPLE.FAMILY_ID@=",familyId);
	BaseinfoPeopleDataSet.setParameter("BASEINFO_PEOPLE.PERSONAL_STATS_TAG@=","0");
	BaseinfoPeopleDataSet.load();
	
    PeopleDemobilizedDataset.setParameter("peopleId",peopleId);
    PeopleDemobilizedDataset.load();
    
    BaseinfoFamilyDataSet.setParameter("BASEINFO_FAMILY.FAMILY_ID@=",familyId);
	BaseinfoFamilyDataSet.load();
	
	//迁入信息word重复打开
	L5.getCmp("demobiInPrintPanel").on("activate",demoInPrtRpt);
}

//迁入信息word重复打开
function demoInPrtRpt(){
	var src = document.getElementById("demobiInPrintFrm").src;
	document.getElementById("demobiInPrintFrm").src = src;
}

function stop(){
    window.close();
}
