function init() {
		somOrganDataSet.setParameter("SORG_ID",sorgId);
		somOrganDataSet.load();
		somApplyDataSet.setParameter("TASK_CODE", taskCode);
		somApplyDataSet.load();
	//加载电子档案
	somElectronicDataSet_load();
	//电子档案上传窗口关闭事件
	var win=L5.getCmp("uploadList");
	win.on("hide",function(el){
		somElectronicDataSet_load();
	});	
	L5.QuickTips.init();
}
//返回
function goBack(){
	history.go(-1);
}

