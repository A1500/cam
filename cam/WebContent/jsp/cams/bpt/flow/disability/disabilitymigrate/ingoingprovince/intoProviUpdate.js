function init() {
	var BptPeopleDisabilityDataSet = L5.DatasetMgr.lookup("BptPeopleDisabilityDataSet");
	BptPeopleDisabilityDataSet.setParameter("PEOPLE_ID",peopleId);
	BptPeopleDisabilityDataSet.setParameter("APPLY_ID",applyId);
	BptPeopleDisabilityDataSet.load();
	L5.QuickTips.init(); 
}

function func_SaveClick(){
    
    var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptApplyIntoprovinceCommand");
	//类别信息
	var BptPeopleDisabilityDataSet = L5.DatasetMgr.lookup("BptPeopleDisabilityDataSet");
	var BptPeopleDisabilityRecord=BptPeopleDisabilityDataSet.getCurrent();
	BptPeopleDisabilityDataSet.set("viabilityCode",_$("viabilityCode"));
	
	//伤残信息验证
	var isValidate = BptPeopleDisabilityDataSet.isValidate();
	if(isValidate != true){
		L5.Msg.alert("提示",isValidate);
		return false;
	}
	//校验伤残等级
	var disabilityLevelCode = BptPeopleDisabilityRecord.get("disabilityLevelCode");
	if(disabilityLevelCode==''){
		 L5.Msg.alert('提示','伤残等级不能为空！');
		 return false;
	}
	//校验伤残性质
	var disabilityCaseCode = BptPeopleDisabilityRecord.get("disabilityCaseCode");
	if(disabilityCaseCode==''){
		 L5.Msg.alert('提示','伤残性质不能为空！');
		 return false;
	}

	//入伍时间和退伍时间
	var disabilityTypeCode = BptPeopleDisabilityRecord.get("disabilityTypeCode");
	if(disabilityTypeCode=='11'){
	  var conscriptDate  = BptPeopleDisabilityRecord.get("conscriptDate");
	  var veteransDate = BptPeopleDisabilityRecord.get("veteransDate");
	   if(conscriptDate==''||veteransDate==''){
	      L5.Msg.alert('提示','入伍(参加工作时间)或退伍时间不能为空！');
	      return false;
	   }
	}
	var conscriptDate = BptPeopleDisabilityRecord.get("conscriptDate");
	if (conscriptDate != "" && !validateDateFormat(conscriptDate)) {
		L5.Msg.alert('提示', '入伍(参加工作时间)格式不正确！');
		return false;
	}
	var veteransDate = BptPeopleDisabilityRecord.get("veteransDate");
	if (veteransDate != "" && !validateDateFormat(veteransDate)) {
		L5.Msg.alert('提示', '退伍时间格式不正确！');
		return false;
	}

	var retiredDate = BptPeopleDisabilityRecord.get("retiredDate");
	if (retiredDate != "" && !validateDateFormat(retiredDate)) {
		L5.Msg.alert('提示', '离退休时间格式不正确！');
		return false;
	}

	var disabilityDate = BptPeopleDisabilityRecord.get("disabilityDate");
	if (disabilityDate != "" && !validateDateFormat(disabilityDate)) {
		L5.Msg.alert('提示', '致残时间格式不正确！');
		return false;
	}
	var allowanceMonth = document.getElementById("allowanceMonth").value;
	if (allowanceMonth != "" && !validateDateFormat(allowanceMonth + "-01")) {
		L5.Msg.alert('提示', '抚恤金已发至月份格式不正确！');
		return false;
	}
	command.setParameter("BptPeopleDisabilityRecord", BptPeopleDisabilityRecord);
	command.execute("updateDisaIntoProvince");
	if (!command.error) {
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

function func_Type(){
  if(document.getElementById("domicileType").value=='1'){
     document.getElementById("work").style.display='none';
     document.getElementById("workAddress").style.display='none';
     document.getElementById("employmentCode").disabled=true;
  }else{
     document.getElementById("work").style.display='';
     document.getElementById("workAddress").style.display='';
     document.getElementById("employmentCode").disabled=false;
  }
}

function getCodeAndName(){
		var revalue=window.showModalDialog(L5.webPath+"/jsp/cams/comm/diccity/dicPubCant.jsp?organCode=CN&organName=中国","","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
		if(revalue!=""&&revalue!=undefined){
		var list = revalue.split(";");
			 BptPeopleDisabilityDataSet.getCurrent().set("ingoingCode",list[0]);
			 BptPeopleDisabilityDataSet.getCurrent().set("ingoingAddress",list[1]);
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