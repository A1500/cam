function init() {
	if(method=="INSERT"){
		somOrganDataSet.newRecord({"mainSorgName":userId,"mainSorgCode":sorgCode,"sorgId":sorgId,"sorgStatus":'31',"sorgType":"J","ifBranch":"1","morgName":userId,"morgArea":morgArea});
		somApplyDataSet.newRecord({"curActivity":"受理","curOpinionId":"1","taskCode":taskCode,"sorgId":sorgId,"applyType":applyType,"dataSource":"ONLINE","sorgType":"J","acceptArea":morgArea,"createOrgan":morgArea,"createPerson":userId});
		//加载电子档案
		somElectronicDataSet_load();
	}else{
		somOrganDataSet.setParameter("SORG_ID",sorgId);
		somOrganDataSet.load();
		somOrganDataSet.on('load',function(){
		if(somOrganDataSet.getCount() > 0 ){
			if(typeof businessOrganSelectDic !="undefined"){
				var borgName = somOrganDataSet.get('borgName');
				var records = businessOrganSelectDic.query("value",borgName);
				if(records.length>0){
					var borgCode = records.items[0].get("text");
					document.getElementById("borgName").value = borgName;
					document.getElementById("borgNameDispaly").value = borgCode;
				}
			}
		}
		});

		somApplyDataSet.setParameter("TASK_CODE", taskCode);
		somApplyDataSet.load();
		//加载电子档案
		somElectronicDataSet_load();
	}
	//电子档案上传窗口关闭事件
	var win=L5.getCmp("uploadList");
	win.on("hide",function(el){
		somElectronicDataSet_load();
	});
	L5.QuickTips.init();
}
function loadCancelReasonDesc(){
	if(_$("cancelReason") == "4"){
		$("cancelReasonDescTr").style.display = "block";
	}else{
		$("cancelReasonDescTr").style.display = "none";
	}
}
//保存
function save(){
	var somOrganRd = somOrganDataSet.getCurrent();
	var somApplyRd = somApplyDataSet.getCurrent();
	var somOrganDataSetIsValidate = somOrganDataSet.isValidate();
	var somApplyDataSetIsValidate = somApplyDataSet.isValidate();
	somOrganRd.set('borgName',document.getElementById("borgName").value);
	//校验社会组织信息
	if(somOrganDataSetIsValidate!=true){
		L5.Msg.alert("提示",somOrganDataSetIsValidate);
		L5.getCmp("tabSomOrgan").setActiveTab("0");
		return;
	 }
	//校验业务意见
	if(somApplyDataSetIsValidate!=true){
		L5.Msg.alert("提示",somApplyDataSetIsValidate);
		L5.getCmp("tabSomOrgan").setActiveTab("0");
		return;
	}
	somOrganRd.set('borgName',document.getElementById("borgName").value);
	somApplyRd.set("sorgName",_$("cnName"));
	var command = new L5.Command("com.inspur.cams.sorg.online.apply.fund.cmd.SomFundOnlineCmd");
	//提交保存
	command.setParameter("somOrganRd",somOrganRd);
	command.setParameter("somApplyRd",somApplyRd);
	if(method=="INSERT"){
		command.execute("saveBranchCancel");
	}else if(method=="UPDATE"){
		command.execute("updateBranchCancel");
	}
	if(!command.error){
		L5.Msg.alert("提示","保存成功！",function(){
			method="UPDATE";
			somOrganDataSet.setParameter("SORG_ID",sorgId);
			somOrganDataSet.load();
			somApplyDataSet.setParameter("TASK_CODE", taskCode);
			somApplyDataSet.load();
		});
	}else{
		L5.Msg.alert("错误","保存时出现错误！"+command.error);
	}
}
//返回
function goBack(){
	history.go(-1);
}

//点击增加上传附件按钮
function clickUploadFile(){
	uploadFile();
}