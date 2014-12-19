function init(){
	var somUngovCertDataset=L5.DatasetMgr.lookup("somUngovCertDataset");
	somUngovCertDataset.newRecord();
	//给有效期起设置当前时间为初始时间
	var time=getCurDate();
	document.getElementById('signBeginDate').value=time;
	document.getElementById('signDate').value=time;
	document.getElementById('printTime').value=time;
}
//返回按钮 返回民办非企业组织证书主功能页面
function returnList(){
	returnCertList("ungov");
}
//保存
function forSave(){
	saveCert("somUngovCertDataset","ungov","print");
}