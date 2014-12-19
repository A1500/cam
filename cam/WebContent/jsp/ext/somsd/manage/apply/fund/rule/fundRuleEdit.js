function init(){
	if(method=="INSERT"){
		var somApplyDataSet=L5.DatasetMgr.lookup("somApplyDataSet");
		somOrganDataSet.newRecord({"cnName":userId,"sorgCode":sorgCode,"sorgId":sorgId,"sorgStatus":'22',
			"sorgType":"J","ifBranch":'0',"morgName":userId,"morgArea":morgArea});

		somApplyDataSet.newRecord({"curActivity":"受理","taskCode":taskCode,
		"sorgId":sorgId,"applyType":applyType,"dataSource":"ONLINE","sorgType":"J",
		"acceptArea":morgArea,"createOrgan":morgArea,"createPerson":userId,"ifFinish":"0"});

		var somRuleDataSet=L5.DatasetMgr.lookup("somRuleDataSet");
		somRuleDataSet.newRecord({"cnName":userId,"sorgCode":sorgCode,"sorgId":sorgId,"taskCode":taskCode,"ifDraft":"1","regStatus":'1'});

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
			document.getElementById("borgName").value = borgName;
			document.getElementById("borgNameDispaly").value = borgCode;
		}
	}
	somOrganDataSet.setParameter("SORG_ID@=",sorgId);
	somOrganDataSet.load();
	somOrganDataSet.on('load',loadRule);
}
function loadRule(ds){
	ds.un('load',loadRule);
	if(ds.getCount() > 0){
		document.getElementById("cnName").value = ds.get('cnName');
		document.getElementById("sorgCode").value= ds.get('sorgCode');
	}
	var somRuleDataSet=L5.DatasetMgr.lookup("somRuleDataSet");
	somRuleDataSet.setParameter("TASK_CODE@=",taskCode);
	somRuleDataSet.load();
	somRuleDataSet.on('load', function(ds){
		ds.set("cnName",userId);
		ds.set("sorgCode",sorgCode);
	});
}
function save(){
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
	if(document.getElementById("borgName").value == '' ){
		L5.Msg.alert("提示","请选择业务主管单位！");
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

	var somRuleRecord=somRuleDataSet.getCurrent();
	var somApplyDataSet=L5.DatasetMgr.lookup("somApplyDataSet");
	var somRuleRecord=somRuleDataSet.getCurrent();
	var somApplyRecord=somApplyDataSet.getCurrent();
	if(method=="insert"){
		somRuleRecord.set("ifDraft","1");
	}
	var organRecord  = somOrganDataSet.getCurrent();
	organRecord.set('borgName',document.getElementById("borgName").value);
	somApplyRecord.set('borgName',document.getElementById("borgName").value);
	var command = new L5.Command("com.inspur.cams.sorg.online.apply.fund.cmd.SomFundOnlineCmd");

	command.setParameter("somRuleRecord",somRuleRecord);
	command.setParameter("somApplyRecord",somApplyRecord);
	command.setParameter("organRecord",organRecord);

	command.execute("saveRule");
	if(!command.error){
		L5.Msg.alert("提示","保存成功！",function(){
			method="UPDATE";
			var somApplyDataSet=L5.DatasetMgr.lookup("somApplyDataSet");
			somApplyDataSet.setParameter("TASK_CODE@=",taskCode);
			somApplyDataSet.load();
			somApplyDataSet.on('load',loadOrgan);
		});
	}else{
		L5.Msg.alert("提示","保存出错！");
	}
}
function returnBack(){
	window.history.go(-1);
}

//点击上传附件按钮
function clickUploadFile(){
	uploadFile();
}
function returnBackHistory(){
	window.history.go(-1);
}