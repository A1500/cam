function init() {
	var TestedDataset = L5.DatasetMgr.lookup("TestedDataset");
	TestedDataset.setParameter("APPLY_ID",applyId);
	TestedDataset.load();
	L5.QuickTips.init(); 
}

function func_SaveClick(){
    
    var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptApplyIntoprovinceCommand");
	//人员信息验证
	var testedEntity=TestedDataset.getCurrent();
	
	var isValidate = TestedDataset.isValidate();
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
	var allowanceMonth = testedEntity.get("allowanceMonth");
	if(allowanceMonth==''){
		L5.Msg.alert('提示',"残疾抚恤金已发至不能为空!");
		return false;
	}
	if(allowanceMonth!=''&&!validateDateFormat(allowanceMonth+'-01')){
		L5.Msg.alert("提示","残疾抚恤金已发至格式不正确！");
		return false;
	}
	
	//校验开户银行
	/*var bank = testedEntity.get("bank");
	if(bank == ''){
		L5.Msg.alert('提示','开户银行不能为空！');
		return false;
	}*/
	 

	
	
	
	command.setParameter("record", testedEntity);
	command.setParameter("applyId", applyId);
	command.execute("updateTestedInProvice");
	if (!command.error) {
		TestedDataset.getCurrent().state = L5.model.Record.STATE_MODIFIED;
		L5.Msg.alert('提示','保存成功！');
		/*var data = new L5.Map();
		data.put("peopleId",BaseinfoPeopleRecord.get("peopleId"));
		data.put("familyId",BaseinfoPeopleRecord.get("familyId"));
		var url='jsp/cams/bpt/dataCollection/disability/disabilityUpdateManage.jsp';
		var text = '伤残人员信息修改';
		L5.forward(url,text,data);*/
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


function func_examination(){
  var isHealthFlag =document.getElementById("isHealthFlag").value;
  if(isHealthFlag=='0'){
     document.getElementById("thisExaminationDate").disabled=false;
     document.getElementById("theExaminationDate").disabled=false;
  }
  if(isHealthFlag=='1'){
     document.getElementById("thisExaminationDate").disabled=true;
     document.getElementById("theExaminationDate").disabled=true;
  }
}

function getCodeAndName(){
		var revalue=window.showModalDialog(L5.webPath+"/jsp/cams/comm/diccity/dicPubCant.jsp?organCode=CN&organName=中国","","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
		if(revalue!=""&&revalue!=undefined){
		var list = revalue.split(";");
			 TestedDataset.getCurrent().set("ingoingCode",list[0]);
			 TestedDataset.getCurrent().set("ingoingAddress",list[1]);
		}
}
