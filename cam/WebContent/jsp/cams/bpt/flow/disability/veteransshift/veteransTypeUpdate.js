function init(){
	var BptPeopleDisabilityDataSet= L5.DatasetMgr.lookup("BptPeopleDisabilityDataSet");
	BptPeopleDisabilityDataSet.setParameter("PEOPLE_ID",peopleId);
	BptPeopleDisabilityDataSet.setParameter("APPLY_ID",applyId);
	BptPeopleDisabilityDataSet.load();
	
	L5.QuickTips.init();
}

function save(){
	var BptPeopleDisabilityDataSet = L5.DatasetMgr.lookup("BptPeopleDisabilityDataSet");
	var BptPeopleDisabilityRecord=BptPeopleDisabilityDataSet.getCurrent();
	
	var isValidate = BptPeopleDisabilityDataSet.isValidate();
	if(isValidate != true){
		L5.Msg.alert("提示",isValidate);
		return false;
	}
	var conscriptDate = BptPeopleDisabilityRecord.get("conscriptDate");
	if(conscriptDate!=''&&!validateDateFormat(conscriptDate)){
		L5.Msg.alert("提示","入伍(参加工作)时间格式不正确！");
		return false;
	}
	
	var veteransDate = BptPeopleDisabilityRecord.get("veteransDate");
	if(veteransDate!=''&&!validateDateFormat(veteransDate)){
		L5.Msg.alert("提示","退伍时间格式不正确！");
		return false;
	}
	
	var retiredDate = BptPeopleDisabilityRecord.get("retiredDate");
	if(retiredDate!=''&&!validateDateFormat(retiredDate)){
		L5.Msg.alert("提示","离退休时间格式不正确！");
		return false;
	}
	
	var disabilityDate = BptPeopleDisabilityRecord.get("disabilityDate");
	if(disabilityDate!=''&&!validateDateFormat(disabilityDate)){
		L5.Msg.alert("提示","致残时间格式不正确！");
		return false;
	}
	
	var allowanceMonth = BptPeopleDisabilityRecord.get("allowanceMonth");
	if(allowanceMonth!=''&&!validateDateFormat(allowanceMonth+'-01')){
		L5.Msg.alert("提示","抚恤金发至格式不正确！");
		return false;
	}
	
	var conscriptDate  = BptPeopleDisabilityRecord.get("conscriptDate");
 	var veteransDate = BptPeopleDisabilityRecord.get("veteransDate");
 	
  	if(conscriptDate==''||veteransDate==''){
      L5.Msg.alert('提示','入伍(参加工作时间)或退伍时间不能为空！');
      return false;
  	}
	var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptPeopleDisabilityCommand");
	
	command.setParameter("BptPeopleDisabilityRecord", BptPeopleDisabilityRecord);
	command.execute("update");
	var command2 = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptApplyDisabilityCommand");
	command2.setParameter("record", BptPeopleDisabilityRecord);
	command2.execute("update");
	if (!command.error&&!command2.error) {
		BptPeopleDisabilityDataSet.getCurrent().state = L5.model.Record.STATE_MODIFIED;
		L5.Msg.alert('提示','保存成功！');
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}

function func_Close(){
	window.close();
}

function func_Level(){
  if(document.getElementById("disabilityLevelCode").value<='04'&&document.getElementById("disabilityLevelCode").value !=''){
     document.getElementById("viabilityCode").value=2;
  }if(document.getElementById("disabilityLevelCode").value>'04'){
     document.getElementById("viabilityCode").value='';
  }if(document.getElementById("disabilityLevelCode").value ==''){
     document.getElementById("viabilityCode").value='';
  }
}
function KoreaWar(k){

	if(k.value==3){
		document.getElementById("k1").style.display='';
		document.getElementById("k2").style.display='';
	}else{
		document.getElementById("k1").style.display='none';
		document.getElementById("k2").style.display='none';
	}
}