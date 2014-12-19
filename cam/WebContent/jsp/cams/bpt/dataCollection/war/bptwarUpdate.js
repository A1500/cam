function init(){
	var dsWar= L5.DatasetMgr.lookup("dsWar");
	dsWar.setParameter("PEOPLE_ID",peopleId);
	dsWar.load();
}

function save(){
	var dsWar = L5.DatasetMgr.lookup("dsWar");
	var warEntity=dsWar.getCurrent();
//	warEntity.set("peopleId",peopleId);
	//校验健康状况
	if(warEntity.get("healthStateCode") == ''){
		L5.Msg.alert("提示","健康状况不能为空！");
		return false;
	}
	var isValidate = dsWar.isValidate();
	if(isValidate != true){
		L5.Msg.alert("提示",isValidate);
		return false;
	}
	var approvalDate = warEntity.get("approvalDate");
	if(approvalDate!=''&&!validateDateFormat(approvalDate)){
		L5.Msg.alert('提示','批准日期格式不正确！');
		  return false;
	}
	if(approvalDate==""){
		L5.Msg.alert('提示','批准日期不能为空！');
		return false;
	}
	var conscriptcDate = warEntity.get("conscriptcDate");
	if(conscriptcDate!=''&&!validateDateFormat(conscriptcDate)){
		L5.Msg.alert('提示','入伍（参加工作）时间格式不正确！');
		  return false;
	}
	var decruitmentDate = warEntity.get("decruitmentDate");
	if(decruitmentDate!=''&&!validateDateFormat(decruitmentDate)){
		L5.Msg.alert('提示','退伍时间格式不正确！');
		  return false;
	}
	var retiredDate = warEntity.get("retiredDate");
	if(retiredDate!=""&&!validateDateFormat(retiredDate)){
		L5.Msg.alert('提示','离退休时间格式不正确！');
		  return false;
	}
	//生活补助证编号
	var stateCode = warEntity.get("warStateCode");
	var warNo = document.getElementById("warNo").value;
	if(stateCode=='2'&&warNo==""){
	    L5.Msg.alert('提示','生活补助证编号不能为空！');
		return false;
	}
	var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptPeopleWarCommand");
	
	command.setParameter("warEntity", warEntity);
	command.execute("updateWar");
	
	if (!command.error) {
		dsWar.getCurrent().state = L5.model.Record.STATE_MODIFIED;
		L5.Msg.alert('提示','保存成功！');
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}

//关闭
function func_Close(){
	window.close();
}

function func_blur(){
  if(dsWar.get("forcesNo")!=''){
     document.getElementById("forcesNo").disabled=true;
  }
}
/**
 * 选择健康状况
 */
function func_HealthSelect() {

	var revalue = window.showModalDialog(
			L5.webPath + "/jsp/cams/comm/dichealth/dichealth.jsp", "",
			"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		document.getElementById("healthStateName").value = list[1];
		dsWar.set("healthStateCode", list[0]);
	}
}