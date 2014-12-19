
function init() {
		
		if (method==null||method==""){
			L5.Msg.alert('提示',"未知的页面命令!");
			back();
			}
		else if (method=="INSERT"){
			BaseinfoPeopleDataSet.newRecord({peopleId:document.forms[0].peopleId.value,familyId:document.forms[0].familyId.value});
			var DependantDataset = L5.DatasetMgr.lookup("DependantDataset");
			DependantDataset.newRecord({peopleId: document.forms[0].peopleId.value});
			var BaseinfoFamilyDataSet=L5.DatasetMgr.lookup("BaseinfoFamilyDataSet");
			BaseinfoFamilyDataSet.newRecord({familyId: document.forms[0].familyId.value});
			BaseinfoPeopleDataSet.set("employmentCode",71);	
			DependantDataset.set("dependantStateCode",2);//优抚对象状态 默认为“享受待遇”
			DependantDataset.set("supportPattern",1);
			var typeInfo =L5.getCmp("typeInfo");
			typeInfo.on("activate",func_BankName);
			return;
		}else if (method=="UPDATE"){
			document.getElementById("peopleId").readOnly=true;
			BaseinfoPeopleDataSet.baseParams["PEOPLE_ID@="]=idField;
			BaseinfoPeopleDataSet.on("load",getValue);
			BaseinfoPeopleDataSet.load();
		var BptPeopleDisabilityDataSet=L5.DatasetMgr.lookup("BptPeopleDisabilityDataSet");
			
		}
		L5.QuickTips.init(); 
}

function func_BankName(){
  DependantDataset.set("accountName",BaseinfoPeopleDataSet.get("name"));
}

function saveClick(){
	var img = document.getElementById("photoTemp").value;
    var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptPeopleDependantCommand");
    
	//人员信息验证
	var BaseinfoPeopleDataSet = L5.DatasetMgr.lookup("BaseinfoPeopleDataSet");
	var BaseinfoPeopleRecord=BaseinfoPeopleDataSet.getCurrent();
	BaseinfoPeopleRecord.set('photoTemp', img);
	
	//三属信息验证
	var DependantDataset = L5.DatasetMgr.lookup("DependantDataset");
	var DependantRecord=DependantDataset.getCurrent();
	//新增人员信息
	if(BaseinfoPeopleRecord.get("peopleId")==""&&BaseinfoPeopleRecord.get("familyId")==""){
	   BaseinfoPeopleRecord.set("peopleId",peopleId);
	   BaseinfoPeopleRecord.set("familyId",familyId);
	   DependantRecord.set("peopleId",peopleId);
	}else{//修改人员信息
	   DependantRecord.set("peopleId",BaseinfoPeopleRecord.get("peopleId"));
	   peopleId = BaseinfoPeopleRecord.get("peopleId");
	   familyId = BaseinfoPeopleRecord.get("familyId");
	}
	
	var isValidate = BaseinfoPeopleDataSet.isValidate();
	if(isValidate != true){
		L5.Msg.alert("提示",isValidate);
		return false;
	}
	
	getCrjCnStrSpell('namebase','phoneticCode','m'); 
	var phoneticCode = document.getElementById("phoneticCode").value;
	BaseinfoPeopleRecord.set('phoneticCode', phoneticCode);
	
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
	if(L5.getDom("lezswName")==null||L5.getDom("lezswName")=="")
	{
		 L5.Msg.alert('提示','请录入类别信息后再保存！');
		 return false;
	}
	DependantRecord.set("lezswName",L5.getDom("lezswName").value);
	DependantRecord.set("lezswSex",L5.getDom("lezswSex").value);
	var lezswBirthday = L5.getDom("lezswBirthday").value;
	if(lezswBirthday!=''&&!validateDateFormat(lezswBirthday)){
		L5.Msg.alert('提示', '烈士出生日期格式不正确！');
		return false;
	}
	DependantRecord.set("lezswBirthday",lezswBirthday);
	
	var conscriptDate = L5.getDom("conscriptDate").value;
	if(conscriptDate!=''&&!validateDateFormat(conscriptDate)){
		L5.Msg.alert('提示', '烈士入伍(工作)时间格式不正确！');
		return false;
	}
	DependantRecord.set("conscriptDate",conscriptDate);
	DependantRecord.set("workUnit",L5.getDom("workUnit").value);
	DependantRecord.set("position",L5.getDom("position").value);
	
	var deathDate = L5.getDom("deathDate").value;
	if(deathDate!=''&&!validateDateFormat(deathDate)){
		L5.Msg.alert('提示', '烈士牺牲病故时间格式不正确！');
		return false;
	}
	DependantRecord.set("deathDate",deathDate);
	DependantRecord.set("deathAddress",L5.getDom("deathAddress").value);
	
	var lezswApproveDate = L5.getDom("lezswApproveDate").value;
	if(lezswApproveDate!=''&&!validateDateFormat(lezswApproveDate)){
		L5.Msg.alert('提示', '烈士（牺牲、病故军人）批准时间格式不正确！');
		return false;
	}
	DependantRecord.set("lezswApproveDate",lezswApproveDate);
	DependantRecord.set("deathReason",L5.getDom("deathReason").value);
	var isValidate = DependantDataset.isValidate();
	if(isValidate != true){
		L5.Msg.alert("提示",isValidate);
		return false;
	}
	//校验批准日期
	var approvalDate = DependantRecord.get("approvalDate");
	if(approvalDate==''){
	   L5.Msg.alert('提示','批准日期不能为空！');
	   return false;
	}
	if(!validateDateFormat(approvalDate)){
		L5.Msg.alert('提示','批准日期格式不正确！');
	   return false;
	}
	//校验开户银行
	var bank = DependantRecord.get("bank");
	if(bank == ''){
		L5.Msg.alert('提示','开户银行不能为空！');
		return false;
	}
	//校验开户名称
	var accountName = DependantRecord.get("accountName");
	if(accountName == ''){
		L5.Msg.alert('提示','开户名称不能为空！');
		return false;
	}
	//校验银行账号
	var accountCode = DependantRecord.get("accountCode");
	if(accountCode == ''){
		L5.Msg.alert('提示','校验银行账号不能为空！');
		return false;
	}
	var idCard = BaseinfoPeopleDataSet.get("idCard");
	if(!writeAble(idCard,"2",false)){
		L5.Msg.alert('提示', '该人员已经是三属人员！');
		return false;
	}
	
	
	command.setParameter("flag",document.forms[0].flag.value);
	command.setParameter("BaseinfoPeopleRecord", BaseinfoPeopleRecord);
	command.setParameter("DependantRecord", DependantRecord);
	command.execute("insert");
	
	if (!command.error) {
		BaseinfoPeopleDataSet.getCurrent().state = L5.model.Record.STATE_MODIFIED;
	//	L5.Msg.alert('提示','保存成功！');
//		var data = new L5.Map();
//		data.put("peopleId",BaseinfoPeopleRecord.get("peopleId"));
//		data.put("familyId",BaseinfoPeopleRecord.get("familyId"));
//		var url='jsp/cams/bpt/dataCollection/dependant/dependantUpdateManage.jsp';
//		var text = '三属人员信息修改';
//		L5.forward(url,text,data);
		var peopleId1 = command.getReturn("peopleId");
		var familyId1 = command.getReturn("familyId");
	    window.returnValue = peopleId1+";"+familyId1;
		window.close();
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}

function func_Close(){
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

function func_Close(){
	window.close();
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
