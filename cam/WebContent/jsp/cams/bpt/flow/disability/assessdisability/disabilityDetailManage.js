function init(){
	/*var BaseinfoFamilyDataSet = L5.DatasetMgr.lookup("BaseinfoFamilyDataSet");
	BaseinfoFamilyDataSet.setParameter("BASEINFO_FAMILY.FAMILY_ID@=",familyId);
	BaseinfoFamilyDataSet.load();
	
	var BptPeopleDisabilityDataSet= L5.DatasetMgr.lookup("BptPeopleDisabilityDataSet");
	//BptPeopleDisabilityDataSet.setParameter("FAMILY_ID@=",familyId);
	BptPeopleDisabilityDataSet.load();*/
	L5.QuickTips.init();
	
/*	L5.getCmp("ass_dis_appTabPanel").on("activate",func);
	function func(){  
		var src = document.getElementById("apptable").src;
		document.getElementById("apptable").src=src;
	}*/
	L5.getCmp("ass_dis_appTabPanel").on("activate",func);
	
	
	var noticeTabPanel = L5.getCmp("noticeTabPanel");
	noticeTabPanel.on("activate",function () {
		var obj = document.getElementById("noticTabPanelframe");
		obj.src=obj.src;
	});
	var disabilityIdentiTabPanel = L5.getCmp("disabilityIdentiTabPanel");
	disabilityIdentiTabPanel.on("activate",function () {
		var obj = document.getElementById("disabilityIdentiTabPanelframe");
		obj.src=obj.src;
	});
	var openTabPanel = L5.getCmp("openTabPanel");
	openTabPanel.on("activate",function () {
		var obj = document.getElementById("openTabPanelframe");
		obj.src=obj.src;
	});
	var decisionLetterTabPanel = L5.getCmp("decisionLetterTabPanel");
	decisionLetterTabPanel.on("activate",function () {
		var obj = document.getElementById("decisionTabPanel");
		obj.src=obj.src;
	});
	var physical = L5.getCmp("physical");
	physical.on("activate",function () {
		var obj = document.getElementById("physicalframe");
		obj.src=obj.src;
	});
	var physicale = L5.getCmp("physicale");
	physicale.on("activate",function () {
		var obj = document.getElementById("physicaleframe");
		obj.src=obj.src;
	});
}

function func(){  
		var src = document.getElementById("apptable").src;
		document.getElementById("apptable").src=src;
}
	

	

