function init() {
	var MartyrOffspringDataSet = L5.DatasetMgr.lookup("MartyrOffspringDataSet");
	MartyrOffspringDataSet.setParameter("applyId",applyId);
	MartyrOffspringDataSet.setParameter("peopleId",peopleId);
	MartyrOffspringDataSet.load();
	L5.QuickTips.init(); 
}

function saveClick(){
   var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptPeopleMartyrOffspringCommand");
   var MartyrOffspringRecord =　MartyrOffspringDataSet.getCurrent();     
   //验证身份类别
   var statusType = MartyrOffspringDataSet.get("statusType");
   if(statusType==''||statusType==null){
	   	L5.Msg.alert("提示","身份类别不能为空！");
	   	return false;
   }
   //验证牺牲时间
   var sacrificeDate = MartyrOffspringDataSet.get("sacrificeDate");
   if(sacrificeDate==''||sacrificeDate==null){
	   	L5.Msg.alert("提示","牺牲时间不能为空！");
	   	return false;
   }
   //验证批准烈士（平反）时间
   var lezswApproveDate = MartyrOffspringDataSet.get("lezswApproveDate");
   if(lezswApproveDate==''||lezswApproveDate==null){
	   	L5.Msg.alert("提示","批准烈士（平反）时间不能为空！");
	   	return false;
   }
   var isValidate1 = MartyrOffspringDataSet.isValidate();
   if(isValidate1 != true) {
   	   L5.Msg.alert("提示",isValidate1);
   	   return false;
   }
   command.setParameter("MartyrOffspringRecord",MartyrOffspringRecord);
   command.execute("updateIntoProvi");
   if(!command.error) {
		L5.Msg.alert('提示',"保存成功！");
		return;
   } else {
       L5.Msg.alert('提示',"保存时出现错误！"+command.error);
       return false;
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
