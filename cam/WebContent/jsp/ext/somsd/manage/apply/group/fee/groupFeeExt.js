function init(){
	var somFeeDataSet=L5.DatasetMgr.lookup("somFeeDataSet");
	if(method=="INSERT"){
		somFeeDataSet.newRecord({"cnName":userId,"sorgCode":sorgCode,"sorgId":sorgId ,"taskCode":taskCode});
		var somApplyDataSet=L5.DatasetMgr.lookup("somApplyDataSet");
		somApplyDataSet.newRecord({"sorgName":userId,"taskCode":taskCode,"sorgId":sorgId,"applyType":applyType,"dataSource":"ONLINE","sorgType":"S","acceptArea":morgArea,"createOrgan":morgArea,"createPerson":userId,"onlineStatus":0});
		somOrganDataSet.newRecord({"cnName":userId,"sorgCode":sorgCode,"sorgStatus":"00","sorgId":sorgId,"sorgType":"S","ifBranch":"0","morgName":userId,"morgArea":morgArea});
	}else{
		somFeeDataSet.setParameter("TASK_CODE@=",taskCode);
		somFeeDataSet.load();
	}
	somElectronicDataSet_load();
	//电子档案上传窗口关闭事件
	var win=L5.getCmp("uploadList");
	if(win!=null){
		win.on("hide",function(el){
			somElectronicDataSet_load();
		});
	}
	somFeeDataSet.on('load', function(ds){
		ds.set("cnName",userId);
		ds.set("sorgCode",sorgCode);
		var somApplyDataSet=L5.DatasetMgr.lookup("somApplyDataSet");
		somApplyDataSet.setParameter("TASK_CODE@=",taskCode);
		somApplyDataSet.load();
		somApplyDataSet.on("load",fillOrganInfo);
	});
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
//点击上传附件按钮
function clickUploadFile(){
	uploadFile();
}
function save(){
	var somFeeDataSet=L5.DatasetMgr.lookup("somFeeDataSet");
	var validate=somFeeDataSet.isValidate(true);
	if(validate!=true){
		L5.Msg.alert("提示","校验未通过，"+validate);
		return;
	}

	//数字校验
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
	var somApplyRecord=somApplyDataSet.getCurrent();
	var somOrganRecord=somOrganDataSet.getCurrent();

	var somFeeDataSet=L5.DatasetMgr.lookup("somFeeDataSet");
	var somFeeRecord=somFeeDataSet.getCurrent();
		var command=new L5.Command("com.inspur.cams.sorg.online.apply.fee.cmd.SomFeeOnlineCmd");
	command.setParameter("somFeeRecord",somFeeRecord);
	command.setParameter("somOrganRecord",somOrganRecord);
	command.setParameter("somApplyRecord",somApplyRecord);
	if(method=="INSERT"){
		command.execute("insert");
	}else if(method=="UPDATE"){
		command.execute("update");
	}
	if(!command.error){
		L5.Msg.alert("提示","保存成功！",function(){
			method="UPDATE";
			var somFeeDataSet=L5.DatasetMgr.lookup("somFeeDataSet");
			somFeeDataSet.setParameter("TASK_CODE@=",taskCode);
			somFeeDataSet.load();
		});
	}else{
		L5.Msg.alert("提示","保存出错！");
	}
}
function returnBack(){
	window.history.go(-1);
}
