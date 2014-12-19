function init() {
	var DependantDataset = L5.DatasetMgr.lookup("DependantDataset");
	DependantDataset.setParameter("APPLY_ID",applyId);
	DependantDataset.load();
	L5.QuickTips.init(); 
}

function func_SaveClick(){
    
    var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptApplyIntoprovinceCommand");
	//人员信息验证
	var dependantRecord=DependantDataset.getCurrent();
	
	var isValidate = DependantDataset.isValidate();
	if(isValidate != true){
		L5.Msg.alert("提示",isValidate);
		return false;
	}


   
   var lezswBirthday = dependantRecord.get("lezswBirthday");
   if(lezswBirthday!=''&&!validateDateFormat(lezswBirthday)){
   		L5.Msg.alert("提示","烈士出生日期格式不正确");
   	   return false;
   }
   
   var conscriptDate = dependantRecord.get("conscriptDate");
   if(conscriptDate!=''&&!validateDateFormat(conscriptDate)){
   		L5.Msg.alert("提示","烈士入伍(工作)时间格式不正确");
   	   return false;
   }
   
   var deathDate = dependantRecord.get("deathDate");
   if(deathDate!=''&&!validateDateFormat(deathDate)){
   		L5.Msg.alert("提示","烈士牺牲病故时间格式不正确");
   	   return false;
   }
   
   var lezswApproveDate = dependantRecord.get("lezswApproveDate");
   if(lezswApproveDate!=''&&!validateDateFormat(lezswApproveDate)){
   		L5.Msg.alert("提示","烈士（牺牲、病故军人）批准时间格式不正确");
   	   return false;
   }
   
   var allowanceMonth = dependantRecord.get("allowanceMonth");
   if(allowanceMonth!=''&&!validateDateFormat(allowanceMonth+'-01')){
   		L5.Msg.alert("提示","抚恤金已发至月份格式不正确");
   	   return false;
   }
	//校验开户银行
/*	var bank = dependantRecord.get("bank");
	if(bank == ''){
		L5.Msg.alert('提示','开户银行不能为空！');
		return false;
	}
	//校验开户名称
	var accountName = dependantRecord.get("accountName");
	if(accountName == ''){
		L5.Msg.alert('提示','开户名称不能为空！');
		return false;
	}
	//校验银行账号
	var accountCode = dependantRecord.get("accountCode");
	if(accountCode == ''){
		Lt.Msg.alert('提示','校验银行账号不能为空！');
		return false;
	}
	*/
	
	
	command.setParameter("record", dependantRecord);
	command.setParameter("applyId", applyId);
	command.execute("updateDependInProvice");
	if (!command.error) {
		DependantDataset.getCurrent().state = L5.model.Record.STATE_MODIFIED;
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

 function getCodeAndName(){
		var revalue=window.showModalDialog(L5.webPath+"/jsp/cams/comm/diccity/dicPubCant.jsp?organCode=CN&organName=中国","","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
		if(revalue!=""&&revalue!=undefined){
		var list = revalue.split(";");
			 DependantDataset.getCurrent().set("ingoingCode",list[0]);
			 DependantDataset.getCurrent().set("ingoingAddress",list[1]);
		}
}

