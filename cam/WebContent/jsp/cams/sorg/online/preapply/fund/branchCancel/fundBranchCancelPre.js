var sorgIdExist='';
function init() {
	somApplyDataSet.setParameter("TASK_CODE@=", taskCode);
	somApplyDataSet.on("load", loadInfo);
	somApplyDataSet.load();
	//电子档案上传窗口关闭事件
	var win=L5.getCmp("uploadList");
	win.on("hide",function(el){
		somElectronicDataSet_load();
	});	
	//过滤处理意见
	opinionSelect.filterBy(function(record, id){
		if("1".indexOf(record.get("value"))>-1){
			return record;
		}
	});
	L5.QuickTips.init();
}
function loadInfo(){
	//加载社会组织信息
	sorgId = somApplyDataSet.get("sorgId");
	somOrganQueryDataSet.setParameter("SORG_ID@=", sorgId);
	somOrganQueryDataSet.on("load",function(){	
		loadSorg();
	});
	somOrganQueryDataSet.load();
	
	//加载电子档案
	somElectronicDataSet_load();
}
//根据登记证号加载社会组织信息
function loadSorg(){
	var sorgCode=somOrganQueryDataSet.get("sorgCode");
	if(sorgCode==null||sorgCode==""){
		return;
	}
	somOrganDataSet.setParameter("SORG_CODE@=",sorgCode);
	somOrganDataSet.setParameter("SORG_TYPE","J");
	somOrganDataSet.setParameter("SORG_STATUS@=","22");
	somOrganDataSet.setParameter("MORG_AREA@=",morgArea);
	somOrganDataSet.on("load",funAdd);	
	somOrganDataSet.load();
}
//加载时触发事件
function funAdd(somOrganDataset){
	var num=somOrganDataset.getCount();
	if(num!=1){
		somOrganDataSet.newRecord();
		document.forms["cbForm"].reset();
		L5.Msg.alert("提示","根据录入的登记证号没有查到相应的社会组织，不能进行注销登记，请确认并修改登记证号！");
	}else{
		sorgIdExist=somOrganDataset.get("sorgId");
		mainSorgId=somOrganDataSet.get("mainSorgId");
		somOrganDataSet.set("cancelDate",somOrganQueryDataSet.get("cancelDate"));
		somOrganDataSet.set("cancelReason",somOrganQueryDataSet.get("cancelReason"));
		//查看社会组织主体状态
		var command = new L5.Command("com.inspur.cams.sorg.apply.fund.cmd.FundBranchCancelCmd");
		command.setParameter("sorgId",mainSorgId);
		command.setParameter("ifBranch","0");
		command.execute("querySorgStatus");
		var mainSorgStatus = command.getReturn("sorgStatus");
		if(mainSorgStatus!="22"){
			somOrganDataSet.newRecord();
			L5.Msg.alert("提示","基金会主体机构不是已成立状态，不能进行注销操作！");
			return;
		}			
	}
}
//根据登记证号加载社会组织信息
function checkSorgCode(){
	var sorgCode=_$("sorgCode");
	if(sorgCode==null||sorgCode==""){
		return;
	}
	somOrganDataSet.setParameter("SORG_CODE",sorgCode);
	somOrganDataSet.setParameter("SORG_TYPE","J");
	somOrganDataSet.setParameter("SORG_STATUS@=","22");
	somOrganDataSet.setParameter("MORG_AREA@=",morgArea);
	somOrganDataSet.load();
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
	
	var command = new L5.Command("com.inspur.cams.sorg.apply.fund.cmd.FundBranchCancelCmd");
	//查看社会组织状态
	command.setParameter("sorgId",sorgIdExist);
	command.setParameter("ifBranch","1");
	command.execute("querySorgStatus");
	var sorgStatus = command.getReturn("sorgStatus");
	if(sorgStatus!="22"){
		L5.Msg.alert("提示","基金会分支（代表）机构不是已成立状态，不能进行注销操作！",function(){
			goBack();
		});
		return;
	}		

	//查看社会组织主体状态
	command = new L5.Command("com.inspur.cams.sorg.apply.fund.cmd.FundBranchCancelCmd");
	command.setParameter("sorgId",mainSorgId);
	command.setParameter("ifBranch","0");
	command.execute("querySorgStatus");
	var mainSorgStatus = command.getReturn("sorgStatus");
	if(mainSorgStatus!="22"){
		L5.Msg.alert("提示","基金会主体机构不是已成立状态，不能进行注销操作！",function(){
			goBack();
		});
		return;
	}
	
	command = new L5.Command("com.inspur.cams.sorg.apply.fund.cmd.FundBranchCancelCmd");
	//提交保存
	command.setParameter("somOrganRd",somOrganRd);
	somApplyRd.set("sorgId",sorgIdExist);
	command.setParameter("somApplyRd",somApplyRd);
	command.execute("create");
	if(!command.error){	
		L5.Msg.alert("提示","保存成功！",function(){
			updateOnlineStatusAccept();
			goBack();
		});
	}else{
		L5.Msg.alert("错误","保存时出现错误！"+command.error);	
	}
}
//提交
function submit() {
	var somOrganRd = somOrganDataSet.getCurrent();	
	var somApplyRd = somApplyDataSet.getCurrent();	
	var somOrganDataSetIsValidate = somOrganDataSet.isValidate();
	var somApplyDataSetIsValidate = somApplyDataSet.isValidate();
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

	var command = new L5.Command("com.inspur.cams.sorg.apply.fund.cmd.FundBranchCancelCmd");
	//查看社会组织状态
	command.setParameter("sorgId",sorgIdExist);
	command.setParameter("ifBranch","1");
	command.execute("querySorgStatus");
	var sorgStatus = command.getReturn("sorgStatus");
	if(sorgStatus!="22"){
		L5.Msg.alert("提示","基金会分支（代表）机构不是已成立状态，不能进行注销操作！",function(){
			goBack();
		});
		return;
	}		

	//查看社会组织主体状态
	command = new L5.Command("com.inspur.cams.sorg.apply.fund.cmd.FundBranchCancelCmd");
	command.setParameter("sorgId",mainSorgId);
	command.setParameter("ifBranch","0");
	command.execute("querySorgStatus");
	var mainSorgStatus = command.getReturn("sorgStatus");
	if(mainSorgStatus!="22"){
		L5.Msg.alert("提示","基金会主体机构不是已成立状态，不能进行注销操作！",function(){
			goBack();
		});
		return;
	}
	
	command = new L5.Command("com.inspur.cams.sorg.apply.fund.cmd.FundBranchCancelCmd");
	command.setParameter("somOrganRd",somOrganRd);
	somApplyRd.set("sorgId",sorgIdExist);
	command.setParameter("somApplyRd",somApplyRd);
	command.execute("createAndSend");
	if(!command.error){
		L5.Msg.alert("提示","成功提交至下一环节！",function(){
		updateOnlineStatusAccept();
			goBack();
		});
	}else{
		L5.Msg.alert("提示","提交时出现错误！"+command.error);
	}
}
//打印不予受理通知
function printNoAccept(){
	var cnName=$("name").innerHTML;
	if(cnName==""){
		L5.Msg.alert("提示","请先输入分支/代表机构登记证号！");
		return;
	}
	var url=rootPath+"/jsp/cams/sorg/comm/print/noAcceptForPrint.jsp?sorgType=J";
	url+="&taskCode="+taskCode+"&applyType="+applyType+"&cnName="+encodeURIComponent(encodeURIComponent(cnName));	
	window.open(url);
}
//打印受理通知
function printAccept(){
	var cnName=$("name").innerHTML;
	if(cnName==""){
		L5.Msg.alert("提示","请先输入分支/代表机构登记证号！");
		return;
	}
	var url=rootPath+"/jsp/cams/sorg/comm/print/acceptForPrint.jsp?sorgType=J";
	url+="&taskCode="+taskCode+"&applyType="+applyType+"&cnName="+encodeURIComponent(encodeURIComponent(cnName));	
	window.open(url);
}
//打印一次性补正材料通知
function sendForPolishing(){

}
//返回
function goBack(){
	history.go(-1);
}


//确认流程历史意见窗口
function detailSomFlow(){
	var grid = L5.getCmp("gridSomFlow");
	var sm = grid.getSelectionModel();
	var record = sm.getSelected();
	if(!record){
		L5.Msg.alert("提示","请选择一条记录!");
		return;
	}
	var winSomFlowDataSet = L5.DatasetMgr.lookup("winSomFlowDataSet");
	winSomFlowDataSet.removeAll();
	var newRecord = winSomFlowDataSet.newRecord();
	var win = L5.getCmp("winSomFlow");
	win.show();
	newRecord.set("activity",record.get("activity"));
	newRecord.set("organId",record.get("organId"));
	newRecord.set("deptId",record.get("deptId"));
	newRecord.set("actorId",record.get("actorId"));
	newRecord.set("commitTime",record.get("commitTime"));
	newRecord.set("opinionId",record.get("opinionId"));
	newRecord.set("opinion",record.get("opinion"));
}
//关闭流程历史意见窗口
function winCloseSomFlow(){
	var win = L5.getCmp("winSomFlow");
	win.setVisible(false);
}
