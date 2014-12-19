function init(){
		somApplyDataSet.setParameter("TASK_CODE",taskCode);
		somApplyDataSet.load();
		somApplyDataSet.on('load',loadElection);
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
//加载环节审批信息
function loadElection(ds){
	ds.un("load",loadElection);
	somElectionDataSet.setParameter("TASK_CODE",taskCode);
	somElectionDataSet.load();
	somElectionDataSet.on('load',loadAspchief);
	
	var sorgId = somApplyDataSet.get("sorgId");
	somOrganDataSet.setParameter("SORG_ID@=",sorgId);
	somOrganDataSet.load();
	somOrganDataSet.on("load",function(){
		$("cnName").innerHTML = somOrganDataSet.get("cnName");
		$("sorgCode").innerHTML = somOrganDataSet.get("sorgCode");
		//从organ表里取业务主管单位
		if(typeof businessOrganSelectDic !="undefined"){
			var borgName = somOrganDataSet.get('borgName');
			var records = businessOrganSelectDic.query("value",borgName);
			if(records.length>0){
				var borgCode = records.items[0].get("text");
				document.getElementById("borgNameDispaly").innerHTML = borgCode;
			}
		}
	});
}
//加载拟任负责人
function loadAspchief(ds){
	ds.un("load",loadAspchief);
	somOrganDataSet.setParameter("SORG_ID",ds.get('sorgId'));
	somOrganDataSet.load();
}
function returnBack(){
	window.history.back(-1);
}

