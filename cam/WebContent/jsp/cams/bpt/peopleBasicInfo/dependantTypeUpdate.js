function init(){
//	document.getElementById("dependantTypeCode").disabled=true;//优抚对象类别
//	document.getElementById("relationship").disabled=true;//与牺牲病故军人关系
//	document.getElementById("dependantNo").disabled=true;//定期抚恤证编号
//	document.getElementById("lezswCertificateId").disabled=true;//烈士（牺牲，病故军人）证书字号
//	document.getElementById("deathDate").disabled=true;//牺牲病故时间
//	document.getElementById("deathAddress").disabled=true;//牺牲病故地点
//	document.getElementById("deathReason").disabled=true;//牺牲病故原因
//	document.getElementById("dependantStateCode").disabled=true;//优抚对象状态
//	document.getElementById("dependantNo").disabled=true;//定期抚恤证编号
//	document.getElementById("approvalDate").disabled=true;//批准日期
	var DependantDataset= L5.DatasetMgr.lookup("DependantDataset");
	DependantDataset.setParameter("PEOPLE_ID",peopleId);
	DependantDataset.load();
	
	L5.QuickTips.init();
}

function save(){
	var DependantDataset = L5.DatasetMgr.lookup("DependantDataset");
	var DependantRecord=DependantDataset.getCurrent();
	
	var isValidate = DependantDataset.isValidate();
	if(isValidate != true){
		L5.Msg.alert("提示",isValidate);
		return false;
	}
	
	//校验批准日期
	var approvalDate = DependantRecord.get("approvalDate");
	if(approvalDate==''){
	   L5.Msg.alert('提示','批准日期不能为空！');
	   return false;
	}
	if(!validateDateFormat(approvalDate)){
		L5.Msg.alert('提示','批准日期格式不正确！');
	   return false;
	}
	
	var lezswBirthday = DependantRecord.get("lezswBirthday");
	if(lezswBirthday!=''&&!validateDateFormat(lezswBirthday)){
		L5.Msg.alert('提示','烈士（牺牲、病故军人）出生日期格式不正确！');
		return false;
	}
	
	var conscriptDate = DependantRecord.get("conscriptDate");
	if(conscriptDate!=''&&!validateDateFormat(conscriptDate)){
		L5.Msg.alert('提示','烈士（牺牲、病故军人）入伍(工作)时间格式不正确！');
		return false;
	}
	
	var deathDate = DependantRecord.get("deathDate");
	if(deathDate!=''&&!validateDateFormat(deathDate)){
		L5.Msg.alert('提示','烈士（牺牲、病故军人）牺牲病故格式不正确！');
		return false;
	}
	
	var lezswApproveDate = DependantRecord.get("lezswApproveDate");
	if(lezswApproveDate!=''&&!validateDateFormat(lezswApproveDate)){
		L5.Msg.alert('提示','烈士（牺牲、病故军人）批准时间格式不正确！');
		return false;
	}
	
	
	var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptPeopleDependantCommand");
	
	command.setParameter("DependantRecord", DependantRecord);
	command.execute("updateDependant");
	
	if (!command.error) {
		DependantDataset.getCurrent().state = L5.model.Record.STATE_MODIFIED;
		L5.Msg.alert('提示','保存成功！');
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}

//关闭
function func_Close(){
	window.close();
}