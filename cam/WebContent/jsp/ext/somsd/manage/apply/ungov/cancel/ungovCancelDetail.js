function init() {
		somOrganDataSet.setParameter("SORG_ID",sorgId);
		somOrganDataSet.load();
		//加载电子档案
		somElectronicDataSet_load();
	somOrganDataSet.on("load",function(){
		somApplyDataSet.setParameter("TASK_CODE", taskCode);
		somApplyDataSet.load();
		somApplyDataSet.on("load",loadSomLiqpeopleDataSet);
	});
	//电子档案上传窗口关闭事件
	var win=L5.getCmp("uploadList");
	win.on("hide",function(el){
		somElectronicDataSet_load();
	});	
	L5.QuickTips.init();
}
function loadSomLiqpeopleDataSet(){
	//加载社会组织清算组织人员信息
	somLiqpeopleDataSet.setParameter("SORG_ID@=",sorgId);
	somLiqpeopleDataSet.load();
}
function loadCancelReasonDesc(){
	if(_$("cancelReason") == "4"){
		$("cancelReasonDescTr").style.display = "block";
	}else{
		$("cancelReasonDescTr").style.display = "none";
	}
}
//返回
function goBack(){
	history.go(-1);
}



