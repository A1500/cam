function init(){
		var somRuleDataSet=L5.DatasetMgr.lookup("somRuleDataSet");
		somRuleDataSet.setParameter("TASK_CODE@=",taskCode);
		somRuleDataSet.load();
	somRuleDataSet.on('load', function(){
		var somApplyDataSet=L5.DatasetMgr.lookup("somApplyDataSet");
		somApplyDataSet.setParameter("TASK_CODE@=",taskCode);
		somApplyDataSet.load();
		somApplyDataSet.on("load",fillOrganInfo);
	});
	//电子档案
	somElectronicDataSet_load();		
	//电子档案上传窗口关闭事件
	var win=L5.getCmp("uploadList");
	if(win!=null){
		win.on("hide",function(el){
			somElectronicDataSet_load();
		});	
	}
}
function fillOrganInfo(){
	var sorgId = somApplyDataSet.get("sorgId");
	somOrganDataSet.setParameter("SORG_ID@=",sorgId);
	somOrganDataSet.load();
	somOrganDataSet.on("load",function(){
		$("cnName").innerHTML = somOrganDataSet.get("cnName");
		$("sorgCode").innerHTML = somOrganDataSet.get("sorgCode");
	});
}
function returnBackHistory(){
	window.history.go(-1);	
}
