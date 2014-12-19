function init(){
   // var BaseinfoPeopleDataSet= L5.DatasetMgr.lookup("BaseinfoPeopleDataSet");
	/*BaseinfoPeopleDataSet.setParameter("BASEINFO_PEOPLE.FAMILY_ID@=",familyId);
	BaseinfoPeopleDataSet.setParameter("BASEINFO_PEOPLE.PERSONAL_STATS_TAG@=","0");
	BaseinfoPeopleDataSet.load();
	
    DemobilizedIllnessDataset.setParameter("peopleId",peopleId);
    DemobilizedIllnessDataset.load();
    
    BaseinfoFamilyDataSet.setParameter("BASEINFO_FAMILY.FAMILY_ID@=",familyId);
	BaseinfoFamilyDataSet.load();*/
	
	L5.QuickTips.init();
	L5.getCmp("demobilizeApp").on("activate",func);
	L5.getCmp("decisionLetterTabPanel1").on("activate",decisionLetterfunc);
	L5.getCmp("physicalPanel").on("activate",physicalfunc);
	L5.getCmp("checkPanel").on("activate",checkfunc);
	L5.getCmp("openLetterPanel").on("activate",openLetterfunc);
}
function func(){  
		var src = document.getElementById("demobilize").src;
		document.getElementById("demobilize").src=src;
}
function decisionLetterfunc(){  
		var src = document.getElementById("decisionTabPanel").src;
		document.getElementById("decisionTabPanel").src=src;
}
function physicalfunc(){  
		var src = document.getElementById("physical").src;
		document.getElementById("physical").src=src;
}
function checkfunc(){  
		var src = document.getElementById("check").src;
		document.getElementById("check").src=src;
}
function openLetterfunc(){  
		var src = document.getElementById("openLetter").src;
		document.getElementById("openLetter").src=src;
}
/*
function stop(){
  window.close();
}*/