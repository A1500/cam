function init(){
	/*var BaseinfoFamilyDataSet = L5.DatasetMgr.lookup("BaseinfoFamilyDataSet");
	BaseinfoFamilyDataSet.setParameter("BASEINFO_FAMILY.FAMILY_ID@=",familyId);
	BaseinfoFamilyDataSet.load();
	
	var BptPeopleDisabilityDataSet= L5.DatasetMgr.lookup("BptPeopleDisabilityDataSet");
	//BptPeopleDisabilityDataSet.setParameter("FAMILY_ID@=",familyId);
	BptPeopleDisabilityDataSet.load();*/
	L5.QuickTips.init();
	
	L5.getCmp("intoTable").on("activate",func);
	function func(){  
		var src = document.getElementById("tableFrame").src;
		document.getElementById("tableFrame").src=src;
	}
}

	

	

