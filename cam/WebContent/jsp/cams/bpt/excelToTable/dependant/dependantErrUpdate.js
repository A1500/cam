function init() {

var BaseinfoPeopleDataSet=L5.DatasetMgr.lookup("BaseinfoPeopleDataSet");
	    BaseinfoPeopleDataSet.setParameter("organCode",organCode);
		BaseinfoPeopleDataSet.setParameter("makeTable","bpt_imp_dependant_make");
		BaseinfoPeopleDataSet.setParameter("id",id);
		BaseinfoPeopleDataSet.load();

	L5.QuickTips.init();
}

function func_BankName(){
  BaseinfoPeopleDataSet.set("accountName",BaseinfoPeopleDataSet.get("name"));
}

function saveClick(){
	var command = new L5.Command("com.inspur.cams.bpt.excelToTable.ExcelToTableCommand");
	// 人员信息验证
	var BaseinfoPeopleDataSet = L5.DatasetMgr.lookup("BaseinfoPeopleDataSet");
	var BaseinfoPeopleRecord = BaseinfoPeopleDataSet.getCurrent();

	var isValidate = BaseinfoPeopleDataSet.isValidate();
	if (isValidate != true) {
		L5.Msg.alert("提示", isValidate);
		return false;
	}
	
	
	
	// 校验户口薄(行政区划)
	var domicileCode = BaseinfoPeopleRecord.get("domicileCode");
	if (domicileCode == '') {
		L5.Msg.alert('提示', '户口薄(行政区划)不能为空！');
		return false;
	}
	
	
	// 校验实际居住(行政区划)
	var apanageCode = BaseinfoPeopleRecord.get("apanageCode");
	if (apanageCode == '') {
		L5.Msg.alert('提示', '实际居住(行政区划)不能为空！');
		return false;
	}
	
	//医疗保障方式规划
	var safeguardType = BaseinfoPeopleRecord.get("safeguardType");
	if(safeguardType==''){
		 L5.Msg.alert('提示','医疗保障方式不能为空！');
		 return false;
	}
	
	//校验户籍类别
	var domicileType = BaseinfoPeopleRecord.get("domicileType");
	if(domicileType==''){
		 L5.Msg.alert('提示','户籍类别不能为空！');
		 return false;
	}
	//三属信息验证	
	//DependantRecord.set("peopleId",peopleId);
	/*if(L5.getDom("lezswName")==null||L5.getDom("lezswName")=="")
	{
		 L5.Msg.alert('提示','请录入类别信息后再保存！');
		 return false;
	}*/
	//BaseinfoPeopleRecord.set("lezswName",L5.getCmp("lezswName").value);
	//BaseinfoPeopleRecord.set("lezswSex",L5.getCmp("lezswSex").value);
	//var lezswBirthday = L5.getCmp("lezswBirthday").value;
	var lezswBirthday = BaseinfoPeopleRecord.get("lezswBirthday");
	if(lezswBirthday!=''&&!validateDateFormat(lezswBirthday)){
		L5.Msg.alert('提示', '烈士出生日期格式不正确！');
		return false;
	}
	BaseinfoPeopleRecord.set("lezswBirthday",lezswBirthday);
	
	var conscriptDate = BaseinfoPeopleRecord.get("conscriptDate");
	//var conscriptDate = L5.getCmp("conscriptDate").value;
	if(conscriptDate!=''&&!validateDateFormat(conscriptDate)){
		L5.Msg.alert('提示', '烈士入伍(工作)时间格式不正确！');
		return false;
	}
	BaseinfoPeopleRecord.set("conscriptDate",conscriptDate);
	//BaseinfoPeopleRecord.set("workUnit",L5.getCmp("workUnit").value);
	//BaseinfoPeopleRecord.set("position",L5.getCmp("position").value);
	
	var deathDate = BaseinfoPeopleRecord.get("deathDate");
	//var deathDate = L5.getCmp("deathDate").value;
	if(deathDate!=''&&!validateDateFormat(deathDate)){
		L5.Msg.alert('提示', '烈士牺牲病故时间格式不正确！');
		return false;
	}
	//BaseinfoPeopleRecord.set("deathDate",deathDate);
	//BaseinfoPeopleRecord.set("deathAddress",L5.getDom("deathAddress").value);
	
	var lezswApproveDate = BaseinfoPeopleRecord.get("lezswApproveDate");
	//var lezswApproveDate = L5.getCmp("lezswApproveDate").value;
	if(lezswApproveDate!=''&&!validateDateFormat(lezswApproveDate)){
		L5.Msg.alert('提示', '烈士（牺牲、病故军人）批准时间格式不正确！');
		return false;
	}
	BaseinfoPeopleRecord.set("lezswApproveDate",lezswApproveDate);
	//BaseinfoPeopleRecord.set("deathReason",L5.getCmp("deathReason").value);
	//校验批准日期
	var approvalDate = BaseinfoPeopleRecord.get("approvalDate");
	if(approvalDate==''){
	   L5.Msg.alert('提示','批准日期不能为空！');
	   return false;
	}
	if(!validateDateFormat(approvalDate)){
		L5.Msg.alert('提示','批准日期格式不正确！');
	   return false;
	}
	//校验开户银行
	var bank = BaseinfoPeopleRecord.get("bank");
	if(bank == ''){
		L5.Msg.alert('提示','开户银行不能为空！');
		return false;
	}
	//校验开户名称
	var accountName = BaseinfoPeopleRecord.get("accountName");
	if(accountName == ''){
		L5.Msg.alert('提示','开户名称不能为空！');
		return false;
	}
	//校验银行账号
	var accountCode = BaseinfoPeopleRecord.get("accountCode");
	if(accountCode == ''){
		L5.Msg.alert('提示','校验银行账号不能为空！');
		return false;
	}
	command.setParameter("makeTable","bpt_imp_dependant_make");
	command.setParameter("record", BaseinfoPeopleRecord);
	command.execute("updateDisabilityMakeTable");
	if (!command.error) {
		L5.Msg.alert('提示', "修改成功！");
	} else {
		L5.Msg.alert('提示', "保存时出现错误！" + command.error);
	}
}

function func_Close(){
	window.close();
}
// 验证身份证合法性
function func_CheckIdCard() {
	idCard = document.forms[0].idCard;
	stype = document.forms[0].stype.value;
	idCardValue = idCard.value;
	if (idCardValue == null || idCardValue == "") {
		return;
	}
	if (!checkIDCard(idCard)) {
		L5.Msg.alert("提示", "身份证格式不正确!");
		return false;
	}
	func_GetBirthday();
}
/*
*由身份证自动生成出生日期
*/
function func_GetBirthday() 
{ 
   var val=document.forms[0].idCard.value;
   var birthdayValue; 
   if(15==val.length){ //15位身份证号码 
       birthdayValue = val.charAt(6)+val.charAt(7); 
       if(parseInt(birthdayValue)<10){ 
           birthdayValue = '20'+birthdayValue; 
       }else { 
           birthdayValue = '19'+birthdayValue; 
       } 
           birthdayValue=birthdayValue+'-'+val.charAt(8)+val.charAt(9)+'-'+val.charAt(10)+val.charAt(11);
           BaseinfoPeopleDataSet.getCurrent().set("birthday",birthdayValue);
    } 
   if(18==val.length){ //18位身份证号码 
           birthdayValue=val.charAt(6)+val.charAt(7)+val.charAt(8)+val.charAt(9)+'-'+val.charAt(10)+val.charAt(11)+'-'+val.charAt(12)+val.charAt(13);
           BaseinfoPeopleDataSet.getCurrent().set("birthday",birthdayValue);
   } 
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

function func_Close(){
	window.close();
}

