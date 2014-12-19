function init(){
//	document.getElementById("warNo").disabled=true;//生活补助证编号
//	document.getElementById("approvalDate").disabled=true;//批准日期
//	document.getElementById("conscriptcDate").disabled=true;//入伍(参加工作)时间
//	document.getElementById("decruitmentDate").disabled=true;//退伍时间
//	document.getElementById("retiredDate").disabled=true;//离退休时间
//	document.getElementById("asdpNo").disabled=true;//退伍证号
//	document.getElementById("identityBasis").disabled=true;//身份认定依据
//	document.getElementById("warStateCode").disabled=true;//优抚对象状态
	var dsTested= L5.DatasetMgr.lookup("dsTested");
	dsTested.setParameter("PEOPLE_ID",peopleId);
	dsTested.load();
	L5.QuickTips.init();
}

function save(){
	var dsTested = L5.DatasetMgr.lookup("dsTested");
	var testedEntity=dsTested.getCurrent();
//	warEntity.set("peopleId",peopleId);
	
	var isValidate = dsTested.isValidate();
	if(isValidate != true){
		L5.Msg.alert("提示",isValidate);
		return false;
	}
	
	
	var approvalDate = testedEntity.get("approvalDate");
	if (approvalDate !='' && !validateDateFormat(approvalDate)) {
		L5.Msg.alert('提示', '批准时间格式不正确！');
		return false;
	}

	var conscriptcDate = testedEntity.get("conscriptcDate");
	if (conscriptcDate != '' && !validateDateFormat(conscriptcDate)) {
		L5.Msg.alert('提示', '入伍(参加工作)时间格式不正确！');
		return false;
	}

	var decruitmentDate = testedEntity.get("decruitmentDate");
	if (decruitmentDate != '' && !validateDateFormat(decruitmentDate)) {
		L5.Msg.alert('提示', '退伍时间格式不正确！');
		return false;
	}

	var retiredDate = testedEntity.get("retiredDate");
	if (retiredDate != '' && !validateDateFormat(retiredDate)) {
		L5.Msg.alert('提示', '离退休时间格式不正确！');
		return false;
	}

	var thisExaminationDate = testedEntity.get("thisExaminationDate");
	if (thisExaminationDate != '' && !validateDateFormat(thisExaminationDate)) {
		L5.Msg.alert('提示', '本次查体时间格式不正确！');
		return false;
	}
	var theExaminationDate = testedEntity.get("theExaminationDate");
	if (theExaminationDate != '' && !validateDateFormat(theExaminationDate)) {
		L5.Msg.alert('提示', '上次查体时间格式不正确！');
		return false;
	}
	
	var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptPeopleTestedCommand");
	command.setParameter("testedEntity", testedEntity);
	command.execute("updateTested");
	
	if (!command.error) {
		dsTested.getCurrent().state = L5.model.Record.STATE_MODIFIED;
		L5.Msg.alert('提示','保存成功！');
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}

//关闭
function func_Close(){
	window.close();
}

function func_examination(){
  var isHealthFlag =document.getElementById("isHealthFlag").value;
  if(isHealthFlag=='1'){
     document.getElementById("thisExaminationDate").disabled=false;
     document.getElementById("theExaminationDate").disabled=false;
  }
  if(isHealthFlag=='2'){
     document.getElementById("thisExaminationDate").disabled=true;
     document.getElementById("theExaminationDate").disabled=true;
  }
}