function init() {
		BaseinfoPeopleDataSet.newRecord();
		//var DependantDataset = L5.DatasetMgr.lookup("DependantDataset");
		DependantDataset.newRecord();
		//var BaseinfoFamilyDataSet=L5.DatasetMgr.lookup("BaseinfoFamilyDataSet");
		//BaseinfoFamilyDataSet.newRecord({familyId: document.forms[0].familyId.value});
		BaseinfoPeopleDataSet.set("employmentCode",71);	
		DependantDataset.set("supportPattern",1);
		var typeinfo = L5.getCmp("typeInfo");
		typeinfo.on("activate",func_BankName);
		L5.QuickTips.init(); 
}
 
function func_BankName(){	
 	 DependantDataset.set("accountName",BaseinfoPeopleDataSet.get("name"));
 	 DependantDataset.set("dependantStateCode",1);
}

function saveClick(){ //  保存添加信息

   var img=document.getElementById("photoTemp").value;
   var phoneticCode=document.getElementById("phoneticCode").value;

   var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptPeopleDependantCommand");
   var BaseinfoPeopleRecord = BaseinfoPeopleDataSet.getCurrent(); // 人员家庭信息
          
   BaseinfoPeopleRecord.set('photoTemp',img);
   BaseinfoPeopleRecord.set('phoneticCode',phoneticCode); 
                           
   var DependantRecord =　DependantDataset.getCurrent(); // 三属人员信息
   
   
   //新增人员信息
	if(BaseinfoPeopleRecord.get("peopleId")==""&&BaseinfoPeopleRecord.get("familyId")==""){
	   BaseinfoPeopleRecord.set("peopleId",peopleId);
	   BaseinfoPeopleRecord.set("familyId",familyId);
	   DependantRecord.set("peopleId",peopleId);
	}else{//修改人员信息
	   DependantRecord.set("peopleId",BaseinfoPeopleRecord.get("peopleId"));
	}
   
   var idCard = document.getElementById("idCard");
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
   
   var lezswBirthday = DependantRecord.get("lezswBirthday");
   if(lezswBirthday!=''&&!validateDateFormat(lezswBirthday)){
   		L5.Msg.alert("提示","烈士出生日期格式不正确");
   	   return false;
   }
   
   var conscriptDate = DependantRecord.get("conscriptDate");
   if(conscriptDate!=''&&!validateDateFormat(conscriptDate)){
   		L5.Msg.alert("提示","烈士入伍(工作)时间格式不正确");
   	   return false;
   }
   
   var deathDate = DependantRecord.get("deathDate");
   if(deathDate!=''&&!validateDateFormat(deathDate)){
   		L5.Msg.alert("提示","烈士牺牲病故时间格式不正确");
   	   return false;
   }
   
   var lezswApproveDate = DependantRecord.get("lezswApproveDate");
   if(lezswApproveDate!=''&&!validateDateFormat(lezswApproveDate)){
   		L5.Msg.alert("提示","烈士（牺牲、病故军人）批准时间格式不正确");
   	   return false;
   }
   
   
   
  /* if(phoneticCode == null || phoneticCode == "" ) {
		L5.Msg.alert("提示","姓名拼音码不能为空!");
		return false;
   }*/
   
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
    
   
   var obj = L5.getDom("typeInfo");
   if(obj == null || obj == "") {
   	   L5.Msg.alert("提示","请录入类别信息后再保存");
   	   return false;
   }
   
   var isValidate_dependant = DependantDataset.isValidate();
   if(isValidate_dependant != true) {
   	   L5.Msg.alert("提示",isValidate_dependant);
   	   return false;
   }  
   var idCard = BaseinfoPeopleDataSet.get("idCard");
	if(!writeAble(idCard,"2",true)){
		L5.Msg.alert('提示', '该人员已经是三属人员！');
		return false;
	}
   
   command.setParameter("BaseinfoPeopleRecord",BaseinfoPeopleRecord);
   command.setParameter("DependantRecord",DependantRecord);
   command.setParameter("flag",document.getElementById("flag").value);
   command.setParameter("ifApplyAdd","applyAdd");
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

function returnClick(){	
	window.close();	
}

/**
 * 验证批准日期
 */
function approveDateCheck(){
	var approvalDate = document.getElementById("approvalDate").value;
	if(approvalDate==''){
	alert("输入批准日期!");
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

function checkExist(){

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

