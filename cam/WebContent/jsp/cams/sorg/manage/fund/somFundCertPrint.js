function init(){
	var somFundCertDataset=L5.DatasetMgr.lookup("somFundCertDataset");
	somFundCertDataset.newRecord();
	//给有效期起设置当前时间为初始时间
	var time=getCurDate();
	document.getElementById('signBeginDate').value=time;
	document.getElementById('signDate').value=time;
	document.getElementById('printTime').value=time;
}
//返回按钮 返回基金会证书主功能页面
function returnList(){
	returnCertList("fund");
}
function forSave(){
	saveCert("somFundCertDataset","fund","print");
}