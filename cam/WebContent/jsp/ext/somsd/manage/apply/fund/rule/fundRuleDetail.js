function init(){
	if(method=="INSERT"){
		var somApplyDataSet=L5.DatasetMgr.lookup("somApplyDataSet");
		somOrganDataSet.newRecord({"sorgId":sorgId,"sorgStatus":'22',
			"sorgType":"J","ifBranch":'0',"morgName":userId,"morgArea":morgArea});
			
		somApplyDataSet.newRecord({"curActivity":"受理","taskCode":taskCode,
		"sorgId":sorgId,"applyType":applyType,"dataSource":"ONLINE","sorgType":"J",
		"acceptArea":morgArea,"createOrgan":morgArea,"createPerson":userId,"ifFinish":"0"});
		
		var somRuleDataSet=L5.DatasetMgr.lookup("somRuleDataSet");
		somRuleDataSet.newRecord({"sorgId":sorgId,"taskCode":taskCode,"ifDraft":"1","regStatus":'1'});
		
	}else{
		var somApplyDataSet=L5.DatasetMgr.lookup("somApplyDataSet");
		somApplyDataSet.setParameter("TASK_CODE@=",taskCode);
		somApplyDataSet.load();
		somApplyDataSet.on('load',loadOrgan);
	}
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
function loadOrgan(ds){
	ds.un('load',loadOrgan);
	if(typeof businessOrganSelectDic !="undefined"){
		var borgName = ds.get('borgName');
		var records = businessOrganSelectDic.query("value",borgName);
		if(records.length>0){
			var borgCode = records.items[0].get("text");
			document.getElementById("borgNameDispaly").innerHTML = borgCode;
		}
	}
	somOrganDataSet.setParameter("SORG_ID@=",sorgId);
	somOrganDataSet.load();
	somOrganDataSet.on('load',loadRule);
}
function loadRule(ds){
	ds.un('load',loadRule);
	if(ds.getCount() > 0){
		document.getElementById("cnName").innerHTML = ds.get('cnName');
		document.getElementById("sorgCode").innerHTML= ds.get('sorgCode');
	}
	var somRuleDataSet=L5.DatasetMgr.lookup("somRuleDataSet");
	somRuleDataSet.setParameter("TASK_CODE@=",taskCode);
	somRuleDataSet.load();
}

function returnBack(){
	window.history.go(-1);
}


function returnBackHistory(){
	window.history.go(-1);	
}