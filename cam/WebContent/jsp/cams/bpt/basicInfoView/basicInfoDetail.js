
function init() {
		var BaseinfoPeopleDataSet = L5.DatasetMgr.lookup("BaseinfoPeopleDataSet");
		BaseinfoPeopleDataSet.load();
		var BaseinfoFamilyDataSet = L5.DatasetMgr.lookup("BaseinfoFamilyDataSet");
		BaseinfoFamilyDataSet.load();
		
		var replacementTabPanel = L5.getCmp("replacement");
		if(replacementTabPanel!=undefined){
			replacementTabPanel.on("activate",function () {
				var obj = document.getElementById("replacementtable");
				obj.src=obj.src;
			});
		}
		
		L5.QuickTips.init(); 
}

function returnClick(){	
	var url='jsp/cams/bpt/basicInfoView/basicInfoList.jsp';
	var text='基础信息_人员信息';
	L5.forward(url,text);	
}

