function init() {
		BaseinfoPeopleDataSet.newRecord();
		DependantDataset.newRecord();
		DependantDataset.set("dependantStateCode",1);
		DependantDataset.set("supportPattern",1);
		var typeinfo = L5.getCmp("typeInfo");
		typeinfo.on("activate",func_BankName);
		L5.QuickTips.init(); 
}
function func_BankName(){
  DependantDataset.set("accountName",BaseinfoPeopleDataSet.get("name"));
  DependantDataset.set("dependantStateCode",1);
}

function saveClick(){
    var img=document.getElementById("photoTemp").value;

    
    var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptApplyIntoprovinceCommand");
	//人员信息验证
	var BaseinfoPeopleRecord=BaseinfoPeopleDataSet.getCurrent();
	//类别信息
	var dependantRecord=DependantDataset.getCurrent();
	
	var peopleIdOld = BaseinfoPeopleRecord.get("peopleId");
	var familyIdOld = BaseinfoPeopleRecord.get("familyId");
	if(peopleIdOld != null && peopleIdOld != "") {
		BaseinfoPeopleRecord.set("peopleId",peopleIdOld);
		dependantRecord.set("peopleId",peopleIdOld);
	} else {
		BaseinfoPeopleRecord.set("peopleId",peopleId);
		dependantRecord.set("peopleId",peopleId);
	}
	if(familyIdOld != null && familyIdOld != "") {
		BaseinfoPeopleRecord.set("familyId",familyIdOld);
	} else {
		BaseinfoPeopleRecord.set("familyId",familyId);
	}
	 
	BaseinfoPeopleRecord.set("dependantFlag","1");
	BaseinfoPeopleRecord.set("dependantStateCode",dependantRecord.get("dependantStateCode"));
	BaseinfoPeopleRecord.set("dependantNo",dependantRecord.get("oldPaperNo"));
	
	
	var allowanceMonth = dependantRecord.get("allowanceMonth")+"-12";
	dependantRecord.set("allowanceMonth",allowanceMonth);
	dependantRecord.set("serviceType","22");
	
	
	BaseinfoPeopleRecord.set('photoTemp',img);
	
	
	
	var idCard = document.getElementById("idCard");
   if(!checkIDCard(idCard)){
	    L5.Msg.alert("提示", "身份证格式不正确!");
	    return false;
   }
	
	var isValidate = BaseinfoPeopleDataSet.isValidate();
	if(isValidate != true){
		L5.Msg.alert("提示",isValidate);
		return false;
	}
	
	//if(phoneticCode == null || phoneticCode == "" ) {
	//	L5.Msg.alert("提示","姓名拼音码不能为空!");
	//	return false;
	//}
	getCrjCnStrSpell('namebase','phoneticCode','m');
		var phoneticCode=document.getElementById("phoneticCode").value;
		BaseinfoPeopleRecord.set('phoneticCode',phoneticCode);
	
	//校验属地行政规划
	var domicileCode = BaseinfoPeopleRecord.get("domicileCode");
	if(domicileCode==''){
		 L5.Msg.alert('提示','户口薄(行政区划)不能为空！');
		 return false;
	}
	
	//医疗保障方式规划
	var safeguardType = BaseinfoPeopleRecord.get("safeguardType");
	if(safeguardType==''){
		 L5.Msg.alert('提示','医疗保障方式不能为空！');
		 return false;
	}
	
	//校验住址行政规划
	var apanageCode = BaseinfoPeopleRecord.get("apanageCode");
	if(apanageCode==''){
		 L5.Msg.alert('提示','实际居住(行政区划)不能为空！');
		 return false;
	}
	
	//校验户籍类别
	var domicileType = BaseinfoPeopleRecord.get("domicileType");
	if(domicileType==''){
		 L5.Msg.alert('提示','户籍类别不能为空！');
		 return false;
	}
	 
	var obj = L5.getDom("typeInfo");
    if(obj == null || obj == "") {
       L5.Msg.alert("提示","请录入类别信息后再保存");
   	   return false;
    }
	
	var isValidate = DependantDataset.isValidate();
	if(isValidate != true){
		L5.Msg.alert("提示",isValidate);
		return false;
	}
	//校验批准日期
	/*var approvalDate = dependantRecord.get("approvalDate");
	if(approvalDate==''){
	   L5.Msg.alert('提示','批准日期不能为空！');
	   return false;
	}*/
	
	//校验开户银行
	/*var bank = dependantRecord.get("bank");
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
		L5.Msg.alert('提示','校验银行账号不能为空！');
		return false;
	}*/
	
	var idCard = BaseinfoPeopleDataSet.get("idCard");
	if(!writeAble(idCard,"2",true)){
		L5.Msg.alert('提示', '该人员已经是三属人员！');
		return false;
	}
	
	command.setParameter("BaseinfoPeopleRecord", BaseinfoPeopleRecord);
	command.setParameter("BptCategoryRecord", dependantRecord);
	command.setParameter("flag",document.getElementById("flag").value);
	command.execute("insertDependInProvice");
	if (!command.error) {
		BaseinfoPeopleDataSet.getCurrent().state = L5.model.Record.STATE_MODIFIED;
		 
		var applyId = command.getReturn("applyId");
		peopleId = command.getReturn("peopleId");
		familyId =command.getReturn("familyId");
	/*	var url="intoProviUpdateManage.jsp?applyId="  + applyId+"&peopleId="+peopleId+"&familyId="+familyId;
		var width = screen.width-100;
		var height = screen.height-120;
		var returnValue = window.showModalDialog (url,window,"scroll:no;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
		*/
		window.returnValue=applyId+";"+peopleId+";"+familyId+";22";
		window.close();
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}

function func_Close(){	
	window.close();
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
 	    var  paraName = escape(encodeURIComponent('中国'));;
		var revalue=window.showModalDialog(L5.webPath+"/jsp/cams/comm/diccity/dicPubCant.jsp?organCode=CN&organName="+paraName,"","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
		if(revalue!=""&&revalue!=undefined){
		var list = revalue.split(";");
			 DependantDataset.getCurrent().set("ingoingCode",list[0]);
			 DependantDataset.getCurrent().set("ingoingAddress",list[1]);
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