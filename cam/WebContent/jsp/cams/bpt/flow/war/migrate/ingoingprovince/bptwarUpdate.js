function init(){
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

	
	
	var conscriptcDate = warEntity.get("conscriptcDate");
	if(conscriptcDate!=''&&!validateDateFormat(conscriptcDate)){
		L5.Msg.alert("提示","入伍（参加工作）时间格式不正确！");
		return false;
	}
	
	var decruitmentDate = warEntity.get("decruitmentDate");
	if(decruitmentDate!=''&&!validateDateFormat(decruitmentDate)){
		L5.Msg.alert("提示","退伍时间格式不正确！");
		return false;
	}
	
	var retiredDate = warEntity.get("retiredDate");
	if(retiredDate!=''&&!validateDateFormat(retiredDate)){
		L5.Msg.alert("提示","离退休时间格式不正确！");
		return false;
	}
	//校验抚恤金已发至月份
	var allowanceMonth = warEntity.get("allowanceMonth");
	if(allowanceMonth!=''&&!validateDateFormat(allowanceMonth+'-01')){
		L5.Msg.alert("提示","抚恤金已发至月份格式不正确！");
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
function getCodeAndName(){
		var revalue=window.showModalDialog(L5.webPath+"/jsp/cams/comm/diccity/dicPubCant.jsp?organCode=CN&organName=中国","","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
		if(revalue!=""&&revalue!=undefined){
		var list = revalue.split(";");
			 dsWar.getCurrent().set("ingoingCode",list[0]);
			 dsWar.getCurrent().set("ingoingAddress",list[1]);
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