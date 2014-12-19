function init(){
	var somGroupCertDataset=L5.DatasetMgr.lookup("somGroupCertDataset");
	somGroupCertDataset.newRecord();
	//给有效期起设置当前时间为初始时间
	var time=getCurDate();
	document.getElementById('signBeginDate').value=time;
	document.getElementById('signDate').value=time;
	document.getElementById('printTime').value=time;
}
function returnList(){
	returnCertList("group");
}
//保存
function forSave(){
	saveCert("somGroupCertDataset","group","print");
}
