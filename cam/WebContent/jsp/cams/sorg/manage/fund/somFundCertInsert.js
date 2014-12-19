function init(){
	var somFundCertDataset=L5.DatasetMgr.lookup("somFundCertDataset");
	somFundCertDataset.newRecord();
	//给有效期起设置当前时间为初始时间
	var time=getCurDate();
	document.getElementById('signBeginDate').value=time;
	document.getElementById('signDate').value=time;
	document.getElementById('ifReceive').value="0";
	document.getElementById('printTime').value=time;
	document.getElementById('certType').value="0";//默认保存证书类型为正本
}
//返回按钮 返回证书主功能页面
function returnList(){
	returnCertList("fund");
}
//保存
function forSave(){
	saveCert("somFundCertDataset","fund","insert");
}
