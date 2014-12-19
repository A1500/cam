var sorgId="";
var mainSorgId="";
var applyType="206";
function init() {
	if(method=="INSERT"){
		somOrganDataSet.newRecord();		
		somApplyDataSet.newRecord({"taskCode":taskCode, "curActivity":"受理", "curOpinionId":"1"});
		somElectronicDataSet_load();
	}else if(method=="UPDATE"){
		somApplyDataSet.setParameter("PROCESS_ID@=", processId);
		somApplyDataSet.on("load", loadInfo);
		somApplyDataSet.load();
	}
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
	taskCode = somApplyDataSet.get("taskCode");
	somOrganDataSet.setParameter("SORG_ID@=", sorgId);
	somOrganDataSet.load();
	
	//加载电子档案
	somElectronicDataSet_load();
}
//根据登记证号加载社会组织信息
function loadSorg(){
	var sorgCode=_$("sorgCode");
	if(sorgCode==null||sorgCode==""){
		return;
	}
	somOrganDataSet.setParameter("SORG_CODE@=",sorgCode);
	somOrganDataSet.setParameter("SORG_TYPE","J");
	somOrganDataSet.on("load",funAdd);	
	somOrganDataSet.load();
	
}
//加载时触发事件
function funAdd(somOrganDataset){
	var num=somOrganDataset.getCount();
	if(num==0){
		somOrganDataSet.newRecord();
		L5.Msg.alert("提示","登记证号不存在或不是基金会分支/代表机构的登记证号！");
	}else if(num>1){
		somOrganDataSet.newRecord();
		L5.Msg.alert("提示","登记证号重复！");	
	}else{
		sorgId=somOrganDataset.get("sorgId");
		var sorgType=somOrganDataSet.get("sorgType");
		var sorgStatus=somOrganDataSet.get("sorgStatus");
		mainSorgId=somOrganDataSet.get("mainSorgId");
		//查看社会组织类型
		if(sorgType!="J"){
			somOrganDataSet.newRecord();
			L5.Msg.alert("提示","该登记证号不是基金会分支/代表机构的登记证号！");		
			return;
		}
		//查看社会组织状态
		if(sorgStatus!="22"){
			somOrganDataSet.newRecord();
			L5.Msg.alert("提示","基金会分支/代表机构不是已成立状态，不能进行注销操作！");
			return;
		}	
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
		document.getElementById("cancelReason").value="";
		document.getElementById("cancelDate").value="";
	}
}
//保存
function save(){
	var somOrganRd = somOrganDataSet.getCurrent();	
	var somApplyRd = somApplyDataSet.getCurrent();
	if(method=="INSERT"){
		//somOrganRd.set("cancelDate",_$("cancelDate"));
		//somOrganRd.set("cancelReason",_$("cancelReason"));
	}
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
		L5.getCmp("tabSomOrgan").setActiveTab("2");
		return;
	}	
	
	var command = new L5.Command("com.inspur.cams.sorg.apply.fund.cmd.FundBranchCancelCmd");
	if(method=="INSERT"){
		//查看社会组织状态
		command.setParameter("sorgId",sorgId);
		command.setParameter("ifBranch","1");
		command.execute("querySorgStatus");
		var sorgStatus = command.getReturn("sorgStatus");
		if(sorgStatus!="22"){
			L5.Msg.alert("提示","基金会分支/代表机构不是已成立状态，不能进行注销操作！",function(){
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
	}
	
	command = new L5.Command("com.inspur.cams.sorg.apply.fund.cmd.FundBranchCancelCmd");
	//提交保存
	command.setParameter("somOrganRd",somOrganRd);
	command.setParameter("somApplyRd",somApplyRd);
	if(method=="INSERT"){
		command.execute("create");
	}else if(method=="UPDATE"){
		command.execute("update");
	}
	if(!command.error){	
		L5.Msg.alert("提示","保存成功！",function(){
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
	if(method=="INSERT"){
		//somOrganRd.set("cancelDate",_$("cancelDate"));
		//somOrganRd.set("cancelReason",_$("cancelReason"));
	}
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
		L5.getCmp("tabSomOrgan").setActiveTab("2");
		return;
	}	
	var command = new L5.Command("com.inspur.cams.sorg.apply.fund.cmd.FundBranchCancelCmd");
	if(method=="INSERT"){
		//查看社会组织状态
		command.setParameter("sorgId",sorgId);
		command.setParameter("ifBranch","1");
		command.execute("querySorgStatus");
		var sorgStatus = command.getReturn("sorgStatus");
		if(sorgStatus!="22"){
			L5.Msg.alert("提示","基金会分支/代表机构不是已成立状态，不能进行注销操作！",function(){
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
	}
	
	command = new L5.Command("com.inspur.cams.sorg.apply.fund.cmd.FundBranchCancelCmd");
	command.setParameter("somOrganRd",somOrganRd);
	command.setParameter("somApplyRd",somApplyRd);
	if(method=="INSERT"){
		command.execute("createAndSend");
	}else if(method=="UPDATE"){
		command.execute("updateAndSend");
	}
	if(!command.error){
		L5.Msg.alert("提示","成功提交至下一环节！",function(){
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
