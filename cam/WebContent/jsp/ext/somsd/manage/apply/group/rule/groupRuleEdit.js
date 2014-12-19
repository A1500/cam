function init(){
	if(method=="INSERT"){
		var somRuleDataSet=L5.DatasetMgr.lookup("somRuleDataSet");
		somRuleDataSet.newRecord({"cnName":userId,"sorgCode":sorgCode,"sorgId":sorgId,"taskCode":taskCode,"ifDraft":"1"});
		var somApplyDataSet=L5.DatasetMgr.lookup("somApplyDataSet");
		somApplyDataSet.newRecord({"cnName":userId,"taskCode":taskCode,"sorgId":sorgId,"applyType":applyType,"dataSource":"ONLINE","sorgType":"S","acceptArea":morgArea,"createOrgan":morgArea,"createPerson":userId});
		somOrganDataSet.newRecord({"cnName":userId,"sorgCode":sorgCode,"sorgStatus":"00","sorgId":sorgId,"sorgType":"S","ifBranch":"0","morgName":userId,"morgArea":morgArea});
	}else{
		var somRuleDataSet=L5.DatasetMgr.lookup("somRuleDataSet");
		somRuleDataSet.setParameter("TASK_CODE@=",taskCode);
		somRuleDataSet.load();
	}
	somRuleDataSet.on('load', function(ds){
		ds.set("cnName",userId);
		ds.set("sorgCode",sorgCode);
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
		$("cnName").value = somOrganDataSet.get("cnName");
		$("sorgCode").value = somOrganDataSet.get("sorgCode");
	});
}
function save(){
	if(_$("cnName")==""){
		L5.Msg.alert("提示","请输入社团名称！");
		return false;
	}
	if(_$("sorgCode")==""){
		L5.Msg.alert("提示","请输入登记证号！");
		return false;
	}
	var somRuleDataSet=L5.DatasetMgr.lookup("somRuleDataSet");
	var somApplyDataSet=L5.DatasetMgr.lookup("somApplyDataSet");
	var validate=somRuleDataSet.isValidate(true);
	if(validate!=true){
		L5.Msg.alert("提示","校验未通过，"+validate);
		return;
	}
	var validate=somApplyDataSet.isValidate(true);
	if(validate!=true){
		L5.Msg.alert("提示","校验未通过，"+validate);
		return;
	}
	var shouldNum=_$("shouldNum");
	var realNum=_$("realNum");
	var passNum=_$("passNum");
	var nopassNum=_$("nopassNum");
	var givenupNum=_$("giveupNum");
	if(givenupNum!=""|nopassNum!=""|passNum!=""|realNum!=""){
		var num=parseInt(givenupNum)+parseInt(nopassNum)+parseInt(passNum);
		if(num!=realNum){
			L5.Msg.alert("提示","人数逻辑出错！");
			return false;
		}
	}
	var somApplyDataSet=L5.DatasetMgr.lookup("somApplyDataSet");
	var somRuleRecord=somRuleDataSet.getCurrent();
	var somApplyRecord=somApplyDataSet.getCurrent();
	var somOrganRecord=somOrganDataSet.getCurrent();
	var command=new L5.Command("com.inspur.cams.sorg.online.apply.rule.cmd.SomRuleOnlineCmd");
	command.setParameter("somOrganRecord",somOrganRecord);
	command.setParameter("somRuleRecord",somRuleRecord);
	command.setParameter("somApplyRecord",somApplyRecord);
	if(method=="INSERT"){
		command.execute("insert");
	}else if(method=="UPDATE"){
		command.execute("update");
	}
	if(!command.error){
		L5.Msg.alert("提示","保存成功！",function(){
			method="UPDATE";
			var somRuleDataSet=L5.DatasetMgr.lookup("somRuleDataSet");
			somRuleDataSet.setParameter("TASK_CODE@=",taskCode);
			somRuleDataSet.load();
		});
	}else{
		L5.Msg.alert("提示","保存出错！");
	}
}
function returnBackHistory(){
	window.history.go(-1);
}
//点击上传附件按钮
function clickUploadFile(){
	uploadFile();
}