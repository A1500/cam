function init(){
	L5.getCmp("tab").setActiveTab("0");
	

		somApplyDataSet.setParameter("TASK_CODE",taskCode);
		somApplyDataSet.load();
		somApplyDataSet.on('load',loadElection);
	

}
//加载环节审批信息
function loadElection(ds){
	ds.un("load",loadElection);
	somElectionDataSet.setParameter("TASK_CODE",taskCode);
	somElectionDataSet.load();
	somElectionDataSet.on('load',loadAspchief);
	
	if(typeof businessOrganSelectDic !="undefined"){
		var borgName = somApplyDataSet.get('borgName');
		var records = businessOrganSelectDic.query("value",borgName);
		if(records.length>0){
			var borgCode = records.items[0].get("text");
			document.getElementById("borgNameDispaly").innerHTML = borgCode;
		}
	}
}
//加载拟任负责人
function loadAspchief(ds){
	ds.un("load",loadAspchief);
	somOrganDataSet.setParameter("SORG_ID",ds.get('sorgId'));
	somOrganDataSet.load();
	somOrganDataSet.on('load',getSorgCode);
}
//获取登记证号
function getSorgCode(ds){
	ds.un("load",getSorgCode);
	if(ds.getCount() == 1){
		document.getElementById('sorgCode').innerHTML = ds.get('sorgCode');
		document.getElementById('cnName').innerHTML = ds.get('cnName');
	}
	somElectronicDataSet_load();
}
function returnBack(){
	window.history.back(-1);
}


function closePrintWin(){
	var win = L5.getCmp("printPartyWin");
	win.setVisible(false);
}
