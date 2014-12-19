function init(){
//	document.getElementById("warNo").disabled=true;//生活补助证编号
//	document.getElementById("approvalDate").disabled=true;//批准日期
//	document.getElementById("conscriptcDate").disabled=true;//入伍（参加工作）时间
//	document.getElementById("decruitmentDate").disabled=true;//退伍时间
//	document.getElementById("retiredDate").disabled=true;//离退休时间
//	document.getElementById("asdpNo").disabled=true;//退伍证号
//	document.getElementById("warTypeCode").disabled=true;//参战类别
//	document.getElementById("warStateCode").disabled=true;//优抚对象状态
	var dsWar= L5.DatasetMgr.lookup("dsWar");
	dsWar.setParameter("PEOPLE_ID",peopleId);
	dsWar.load();
	
	L5.QuickTips.init();
}

function save(){
	var dsWar = L5.DatasetMgr.lookup("dsWar");
	var warEntity=dsWar.getCurrent();
//	warEntity.set("peopleId",peopleId);
	
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