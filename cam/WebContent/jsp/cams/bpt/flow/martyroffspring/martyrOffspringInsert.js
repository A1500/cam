function init() {
		BaseinfoPeopleDataSet.newRecord();
		MartyrOffspringDataSet.newRecord();
		BaseinfoPeopleDataSet.set("employmentCode",71);	
		MartyrOffspringDataSet.set("supportPattern",1);
		var typeinfo = L5.getCmp("typeInfo");
		typeinfo.on("activate",func_BankName);
		L5.QuickTips.init(); 
}
 
function func_BankName(){	
 	 MartyrOffspringDataSet.set("accountName",BaseinfoPeopleDataSet.get("name"));
}

function saveClick(){ //  保存添加信息

   var photoTemp=_$("photoTemp");
   var phoneticCode=_$("phoneticCode");
   
   var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptPeopleMartyrOffspringCommand");
   var BaseinfoPeopleRecord = BaseinfoPeopleDataSet.getCurrent(); // 人员家庭信息
   var MartyrOffspringRecord =　MartyrOffspringDataSet.getCurrent();     
   
   BaseinfoPeopleRecord.set('photoTemp',photoTemp);
   BaseinfoPeopleRecord.set('phoneticCode',phoneticCode); 
   //新增人员信息
	if(BaseinfoPeopleRecord.get("peopleId")==""&&BaseinfoPeopleRecord.get("familyId")==""){
	   BaseinfoPeopleRecord.set("peopleId","0");//标识是否为已存在人员
	   BaseinfoPeopleRecord.set("familyId","0");//标识是否为已存在家庭
	   MartyrOffspringRecord.set("peopleId","");//标识是否为已存在家庭
	}else{//修改人员信息
	   MartyrOffspringRecord.set("peopleId",BaseinfoPeopleRecord.get("peopleId"));
	}
   var idCard = $("idCard");
   if(!checkIDCard(idCard)){
	    L5.Msg.alert("提示", "身份证格式不正确!");
	    return false;
   }
   var isValidate = BaseinfoPeopleDataSet.isValidate();
   if(isValidate != true) {
   	   L5.Msg.alert("提示",isValidate);
   	   return false;
   }
   //校验属地行政规划
	var domicileCode = BaseinfoPeopleRecord.get("domicileCode");
	if(domicileCode==''){
		 L5.Msg.alert('提示','属地行政规划不能为空！');
		 return false;
	}
	//校验住址行政规划                                     
	var apanageCode = BaseinfoPeopleRecord.get("apanageCode");
	if(apanageCode==''){
		 L5.Msg.alert('提示','地址行政规划不能为空！');
		 return false;
	}
   // 医疗保障方式验证
   var safeguardType = BaseinfoPeopleRecord.get("safeguardType");
   if(safeguardType == "" || safeguardType == null) {
   	   L5.Msg.alert("提示","医疗保障方式不能为空");
   	   return false;
   }
   // 户籍类别验证
   var domicileType = BaseinfoPeopleRecord.get("domicileType");
   if(domicileType == "" || domicileType == null) {
   	   L5.Msg.alert("提示","户籍类别不能为空");
   	   return false;
   } 
   //验证输入类别信息
   var obj = L5.getDom("typeInfo");
   if(obj == null || obj == "") {
   	   L5.Msg.alert("提示","请录入类别信息后再保存");
   	   return false;
   }
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
   if(sacrificeDate!=''&&!validateDateFormat(sacrificeDate)){
		L5.Msg.alert("提示","牺牲时间格式不正确！");
		return false;
	}
   //验证批准烈士（平反）时间
   var lezswApproveDate = MartyrOffspringDataSet.get("lezswApproveDate");
   if(lezswApproveDate==''||lezswApproveDate==null){
	   	L5.Msg.alert("提示","批准烈士（平反）时间不能为空！");
	   	return false;
   }
   if(lezswApproveDate!=''&&!validateDateFormat(lezswApproveDate)){
		L5.Msg.alert("提示","批准烈士（平反）时间格式不正确！");
		return false;
	}
   //是否孤老
   var oldLonelyFlag = MartyrOffspringDataSet.get("oldLonelyFlag");
   if(oldLonelyFlag==''|| oldLonelyFlag==null){
	   	L5.Msg.alert("提示","是否孤老不能为空！");
	   	return false;
   }
   //是否孤儿
   var orphanFlag = MartyrOffspringDataSet.get("orphanFlag");
   if(orphanFlag==''|| orphanFlag==null){
	   	L5.Msg.alert("提示","是否孤儿不能为空！");
	   	return false;
   }
   //生活状况
   var lifeStateCode = MartyrOffspringDataSet.get("lifeStateCode");
   if(lifeStateCode==''|| lifeStateCode==null){
	   	L5.Msg.alert("提示","生活状况不能为空！");
	   	return false;
   }
   //劳动能力
   var workAbilityCode = MartyrOffspringDataSet.get("workAbilityCode");
   if(workAbilityCode==''|| workAbilityCode==null){
	   	L5.Msg.alert("提示","劳动能力不能为空！");
	   	return false;
   }
   //生活能力
   var viabilityCode = MartyrOffspringDataSet.get("viabilityCode");
   if(viabilityCode==''|| viabilityCode==null){
	   	L5.Msg.alert("提示","生活能力不能为空！");
	   	return false;
   }
   //供养方式
   var supportPattern = MartyrOffspringDataSet.get("supportPattern");
   if(supportPattern==''|| supportPattern==null){
	   	L5.Msg.alert("提示","供养方式不能为空！");
	   	return false;
   }
   
   var idCard = BaseinfoPeopleDataSet.get("idCard");
	if(!writeAble(idCard,"B1",true)){
		L5.Msg.alert('提示', '该人员已经是老烈子女！');
		return false;
	}
   
   command.setParameter("BaseinfoPeopleRecord",BaseinfoPeopleRecord);
   command.setParameter("MartyrOffspringRecord",MartyrOffspringRecord);
   command.setParameter("flag",document.forms[0].flag.value);
   command.execute("insert");
   peopleId= command.getReturn("peopleId");
   familyId= command.getReturn("familyId");
   applyId= command.getReturn("applyId");
   if(!command.error) {
		BaseinfoPeopleDataSet.getCurrent().state = L5.model.Record.STATE_MODIFIED;
		window.returnValue = peopleId+";"+familyId+";"+applyId;
		window.close();
   } else {
       L5.Msg.alert('提示',"保存时出现错误！"+command.error);
   }
}

function funClose(){	
	window.close();	
}


/**
 * 根据户籍类别不同显示不同字段
 */
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
function idcardlookup(){
	L5.getCmp("imgshow").show();
	//window.open (L5.webPath+'/jsp/cams/bpt/comm/idCardDetail.jsp?src=data:image/jpeg;base64,'+ pPrintPhotoBuffer,'身份证件',
	//'height=500,width=400,top=0,left=0,toolbar=no,menubar=no,scrollbars=no,resizable=no,location=no, status=no');
}
function idcardclose(){
	var win = L5.getCmp("imgshow");
	win.hide();
}