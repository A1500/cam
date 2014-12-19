function init() {
		BaseinfoPeopleDataSet.newRecord();
		dsTested.newRecord();
		dsTested.set("warStateCode",1);
		dsTested.set("supportPattern",1);
		var typeinfo = L5.getCmp("typeInfo");
		typeinfo.on("activate",func_BankName);
		L5.QuickTips.init(); 
}
function func_BankName(){
  dsTested.set("accountName",BaseinfoPeopleDataSet.get("name"));
  dsTested.set("warStateCode",1);
}

function saveClick(){
    var img=document.getElementById("photoTemp").value;

    
    var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptApplyIntoprovinceCommand");
	//人员信息验证
	var BaseinfoPeopleRecord=BaseinfoPeopleDataSet.getCurrent();
	
	BaseinfoPeopleRecord.set('photoTemp',img);

	//类别信息
	var testedRecord=dsTested.getCurrent();
	
	var peopleIdOld = BaseinfoPeopleRecord.get("peopleId");
	var familyIdOld = BaseinfoPeopleRecord.get("familyId");
	if(peopleIdOld != null && peopleIdOld != "") {
		BaseinfoPeopleRecord.set("peopleId",peopleIdOld);
		testedRecord.set("peopleId",peopleIdOld);
	} else {
		BaseinfoPeopleRecord.set("peopleId",peopleId);
		testedRecord.set("peopleId",peopleId);
	}
	if(familyIdOld != null && familyIdOld != "") {
		BaseinfoPeopleRecord.set("familyId",familyIdOld);
	} else {
		BaseinfoPeopleRecord.set("familyId",familyId);
	}
	 
	BaseinfoPeopleRecord.set("warFlag","1");
	BaseinfoPeopleRecord.set("warStateCode",testedRecord.get("warStateCode"));
	BaseinfoPeopleRecord.set("warNo",testedRecord.get("oldPaperNo"));
	
	testedRecord.set("serviceType","62");
	//var allowanceMonth = testedRecord.get("allowanceMonth")+'-12';
		//testedRecord.set("allowanceMonth",allowanceMonth);
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
		//L5.Msg.alert("提示","姓名拼音码不能为空!");
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
	
	var isValidate = dsTested.isValidate();
	if(isValidate != true){
		L5.Msg.alert("提示",isValidate);
		return false;
	}
	//校验批准日期
	/*var approvalDate = testedRecord.get("approvalDate");
	if(approvalDate==''){
	   L5.Msg.alert('提示','批准日期不能为空！');
	   return false;
	}*/
	
/*	//校验开户银行
	var bank = testedRecord.get("bank");
	if(bank == ''){
		L5.Msg.alert('提示','开户银行不能为空！');
		return false;
	}
	//校验开户名称
	var accountName = testedRecord.get("accountName");
	if(accountName == ''){
		L5.Msg.alert('提示','开户名称不能为空！');
		return false;
	}
	//校验银行账号
	var accountCode = testedRecord.get("accountCode");
	if(accountCode == ''){
		L5.Msg.alert('提示','校验银行账号不能为空！');
		return false;
	}*/
	var idCard = BaseinfoPeopleDataSet.get("idCard");
	if(!writeAble(idCard,"61",true)){
		L5.Msg.alert('提示', '该人员已经是参试人员！');
		return false;
	}
	command.setParameter("flag",document.getElementById("flag").value);
	command.setParameter("BaseinfoPeopleRecord", BaseinfoPeopleRecord);
	command.setParameter("BptCategoryRecord", testedRecord);
	command.execute("insertTestedIntoProvince");
	if (!command.error) {
		BaseinfoPeopleDataSet.getCurrent().state = L5.model.Record.STATE_MODIFIED;
		 
		var applyId = command.getReturn("applyId");
		peopleId = command.getReturn("peopleId");
		familyId =command.getReturn("familyId");
		/*var url="intoProviUpdateManage.jsp?applyId="  + applyId+"&peopleId="+peopleId+"&familyId="+familyId;
		var width = screen.width-100;
		var height = screen.height-120;
		var returnValue = window.showModalDialog (url,window,"scroll:no;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
		*/
		window.returnValue=applyId+";"+peopleId+";"+familyId+";62";
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
			 dsTested.getCurrent().set("ingoingCode",list[0]);
			 dsTested.getCurrent().set("ingoingAddress",list[1]);
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