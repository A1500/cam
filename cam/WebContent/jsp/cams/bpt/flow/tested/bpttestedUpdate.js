function init(){
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
	
	var conscriptcDate = testedEntity.get("conscriptcDate");
	if(conscriptcDate!=''&&!validateDateFormat(conscriptcDate)){
		L5.Msg.alert("提示","入伍时间格式不正确！");
		return false;
	}
	
	var decruitmentDate = testedEntity.get("decruitmentDate");
	if(decruitmentDate!=''&&!validateDateFormat(decruitmentDate)){
		L5.Msg.alert("提示","退伍时间格式不正确！");
		return false;
	}
	
	var retiredDate = testedEntity.get("retiredDate");
	if(retiredDate!=''&&!validateDateFormat(retiredDate)){
		L5.Msg.alert("提示","离退休时间格式不正确！");
		return false;
	}
	
	var thisExaminationDate = testedEntity.get("thisExaminationDate");
	if(thisExaminationDate!=''&&!validateDateFormat(thisExaminationDate)){
		L5.Msg.alert("提示","本次查体时间格式不正确！");
		return false;
	}
	
	var theExaminationDate = testedEntity.get("theExaminationDate");
	if(theExaminationDate!=''&&!validateDateFormat(theExaminationDate)){
		L5.Msg.alert("提示","上次查体时间格式不正确！");
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

function queryhealthName() {
	var type = document.getElementById("healthType").value;
	var dshealthname = L5.DatasetMgr.lookup("dsHealthName");
	dshealthname.setParameter("type",type);
	dshealthname.load();
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
		dsTested.set("healthStateCode", list[0]);
	}
}