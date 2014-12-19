function init(){
	/*
	var tabPanel = L5.getCmp("tabPanel");
	tabPanel.setActiveTab(2);
	tabPanel.setActiveTab(1);
	tabPanel.setActiveTab(0);
	*/
	var jcmCompanyProfileDataSet=L5.DatasetMgr.lookup("jcmCompanyProfileDataSet");
	
	if(method=="insert"){
		jcmCompanyProfileDataSet.newRecord();
		jcmCompanyProfileDataSet.set("companyId",newCompanyId);
		jcmCompanyProfileDataSet.set("organCode",organCode);
		jcmCompanyProfileDataSet.set("organName",organName);
		jcmCompanyProfileDataSet.set("orderCompanyId",companyId);
		jcmCompanyProfileDataSet.set("organType",organType);
	}else{
		jcmCompanyProfileDataSet.setParameter("COMPANY_ID@=",companyId);
		jcmCompanyProfileDataSet.load();
		
		var jcmCompanyMoneyDataSet=L5.DatasetMgr.lookup("jcmCompanyMoneyDataSet");
		jcmCompanyMoneyDataSet.setParameter("COMPANY_ID@=",companyId);
		jcmCompanyMoneyDataSet.load();
		
		var jcmOfficeEquipmentDataSet=L5.DatasetMgr.lookup("jcmOfficeEquipmentDataSet");
		jcmOfficeEquipmentDataSet.setParameter("COMPANY_ID@=",companyId);
		jcmOfficeEquipmentDataSet.load();
	}
}
function save(){
	var jcmCompanyProfileDataSet=L5.DatasetMgr.lookup("jcmCompanyProfileDataSet");
	//工作经费
	var jcmCompanyMoneyDataSet=L5.DatasetMgr.lookup("jcmCompanyMoneyDataSet");
	//办公设备
	var jcmOfficeEquipmentDataSet=L5.DatasetMgr.lookup("jcmOfficeEquipmentDataSet");
	
	var valid=jcmCompanyProfileDataSet.isValidate(true);
	if(valid!=true){
		L5.Msg.alert("提示","校验未通过，不能保存！"+valid);
		return false;
	}
	
	var companyJobNum = document.getElementById("companyJobNum").value;//从业人数
	if(companyJobNum != ""){
		if(!_isNum(companyJobNum)){
			document.getElementById("companyJobNum").value="";
			L5.Msg.alert("提示","从业人数,请输入数字");
			return false;
		}
	}
	var companyEstNum = document.getElementById("companyEstNum").value;//在编人数
	if(companyEstNum != ""){
		if(!_isNum(companyEstNum)){
			document.getElementById("companyEstNum").value="";
			L5.Msg.alert("提示","在编人数,请输入数字");
			return false;
		}
	}
	var roomsNum = document.getElementById("roomsNum").value;//房屋人数
	if(roomsNum != ""){
		if(!_isNum(roomsNum)){
			document.getElementById("roomsNum").value="";
			L5.Msg.alert("提示","房屋间数,请输入数字");
			return false;
		}
	}
	var companyMon = document.getElementById("companyMon").value;//房屋人数
	if(companyMon != ""){
		if(!isFloat(companyMon)){
			document.getElementById("companyMon").value="";
			L5.Msg.alert("提示","固定资产,请输入数字");
			return false;
		}
	}
	var record=jcmCompanyProfileDataSet.getCurrent();
	var moneyRecords=jcmCompanyMoneyDataSet.getAllChangedRecords();
	var equipMentRecords=jcmOfficeEquipmentDataSet.getAllChangedRecords();
	
	var command=new L5.Command("com.inspur.cams.jcm.cmd.JcmCompanyProfileCmd");
	
	command.setParameter("record",record);
	command.setParameter("moneyRecords",moneyRecords);
	command.setParameter("equipMentRecords",equipMentRecords);
	command.execute("save");
	if (!command.error){
		var parentWin = window.parent.window;
		var tree = parentWin.L5.getCmp("companytree");
		if(method == "insert"){
			var node = tree.getNodeByRecordId(companyId, "cityRecord");
			var rec = new parentWin.L5.tree.TreeRecord.recordTypes["cityRecord"](jcmCompanyProfileDataSet.getCurrent().data, jcmCompanyProfileDataSet.getCurrent().get("companyId"));
			node.record.insert(rec);
		}else{
			var node = tree.getNodeByRecordId(companyId, "cityRecord");
			node.record.set("companyName", jcmCompanyProfileDataSet.getCurrent().get("companyName"));
			node.record.commit();
		}
		L5.Msg.alert("提示","保存成功！",function(){
//			returnBack();
		});
	}else{
		L5.Msg.alert("提示","保存出错！"+command.error);
	}
}
function returnBack(){
	history.go(-1);
}
function addMoney(){
	var jcmCompanyMoneyDataSet=L5.DatasetMgr.lookup("jcmCompanyMoneyDataSet");
	var command=new L5.Command("com.inspur.cams.comm.util.IdHelpCmd");
		command.setParameter("IdHelp","Id32");
		command.execute("execute");
		var companyMoneyId = command.getReturn("id");
	if(method=="insert"){
		jcmCompanyMoneyDataSet.newRecord({"companyId":newCompanyId,"companyMoneyId":companyMoneyId});
	}else{
		jcmCompanyMoneyDataSet.newRecord({"companyId":companyId,"companyMoneyId":companyMoneyId});
	}
	
}
function removeMoney(){
	var grid=L5.getCmp("gridMoney");
	var records=grid.getSelectionModel().getSelections();
	if(records.length!=1){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var jcmCompanyMoneyDataSet=L5.DatasetMgr.lookup("jcmCompanyMoneyDataSet");
	jcmCompanyMoneyDataSet.remove(records[0]);
}
function insertE(){
	var jcmOfficeEquipmentDataSet=L5.DatasetMgr.lookup("jcmOfficeEquipmentDataSet");
	var command=new L5.Command("com.inspur.cams.comm.util.IdHelpCmd");
		command.setParameter("IdHelp","Id32");
		command.execute("execute");
		var officeId = command.getReturn("id");
	if(method=="insert"){
		jcmOfficeEquipmentDataSet.newRecord({"companyId":newCompanyId,"officeId":officeId});
	}else{
		jcmOfficeEquipmentDataSet.newRecord({"companyId":companyId,"officeId":officeId});
	}
	
}
function delE(){
	var grid=L5.getCmp("gridEquipment");
	var records=grid.getSelectionModel().getSelections();
	if(records.length!=1){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var jcmOfficeEquipmentDataSet=L5.DatasetMgr.lookup("jcmOfficeEquipmentDataSet");
	jcmOfficeEquipmentDataSet.remove(records[0]);
}
//选择负责人信息 回填
function selectPep(){
	var reValue = openCemeChoose();
	if (reValue != "" && reValue != undefined) {
		var arrs = reValue.split(",");
		document.getElementById("principalName").value=arrs[2];
	}
}
function openCemeChoose(){
	return window.showModalDialog("jcmPeopleInfoList.jsp?companyId="+companyId, "","dialogHeight:400px;dialogWidth:480px;resizable:yes;scroll:yes;status:no;");
}
function showP(){
	window.showModalDialog("summary.jsp?companyId="+companyId, "","dialogHeight:390px;dialogWidth:800px;resizable:yes;scroll:yes;status:no;");
}