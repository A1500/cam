function init() {

var BaseinfoPeopleDataSet=L5.DatasetMgr.lookup("BaseinfoPeopleDataSet");
	    BaseinfoPeopleDataSet.setParameter("organCode",organCode);
		BaseinfoPeopleDataSet.setParameter("makeTable","bpt_imp_tested_make");
		BaseinfoPeopleDataSet.setParameter("id",id);
		BaseinfoPeopleDataSet.load();

	L5.QuickTips.init();
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
function func_BankName() {
	dsTested.set("accountName", BaseinfoPeopleDataSet.get("name"));
}

function func_examination() {
	var isHealthFlag = document.getElementById("isHealthFlag").value;
	if (isHealthFlag == '1') {
		document.getElementById("thisExaminationDate").disabled = false;
		document.getElementById("theExaminationDate").disabled = false;
	}
	if (isHealthFlag == '2') {
		document.getElementById("thisExaminationDate").disabled = true;
		document.getElementById("theExaminationDate").disabled = true;
	}
}
function saveClick() {

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
	
	if (BaseinfoPeopleRecord.get("safeguardType") == '') {
		L5.Msg.alert("提示", "医疗保障方式不能为空");
		return false;
	}
	if (BaseinfoPeopleRecord.get("domicileType") == '') {
		L5.Msg.alert("提示", "户籍类别不能为空");
		return false;
	}
	
	
/*	if (L5.getDom("warNo") == null || L5.getDom("warNo") == "") {
		L5.Msg.alert('提示', '请录入类别信息后再保存！');
		return false;
	}*/
	
	


	var approvalDate = BaseinfoPeopleRecord.get("approvalDate");
	if (approvalDate != '' && !validateDateFormat(approvalDate)) {
		L5.Msg.alert('提示', '批准时间格式不正确！');
		return false;
	}
	if(approvalDate==''){
		L5.Msg.alert('提示', '批准时间不能为空！');
		return false;
	}

	var conscriptcDate = BaseinfoPeopleRecord.get("conscriptcDate");
	if (conscriptcDate != '' && !validateDateFormat(conscriptcDate)) {
		L5.Msg.alert('提示', '入伍(参加工作)时间格式不正确！');
		return false;
	}
	if(conscriptcDate==''){
		L5.Msg.alert('提示', '入伍(参加工作)时间不能为空！');
		return false;
	}
	var decruitmentDate = BaseinfoPeopleRecord.get("decruitmentDate");
	if (decruitmentDate != '' && !validateDateFormat(decruitmentDate)) {
		L5.Msg.alert('提示', '退伍时间格式不正确！');
		return false;
	}
	if(decruitmentDate==''){
		L5.Msg.alert('提示', '退伍时间不能为空！');
		return false;
	}
	var retiredDate = BaseinfoPeopleRecord.get("retiredDate");
	if (retiredDate != '' && !validateDateFormat(retiredDate)) {
		L5.Msg.alert('提示', '离退休时间格式不正确！');
		return false;
	}
	var thisExaminationDate = BaseinfoPeopleRecord.get("thisExaminationDate");
	if (thisExaminationDate != '' && !validateDateFormat(thisExaminationDate)) {
		L5.Msg.alert('提示', '本次查体时间格式不正确！');
		return false;
	}
	var theExaminationDate = BaseinfoPeopleRecord.get("theExaminationDate");
	if (theExaminationDate != '' && !validateDateFormat(theExaminationDate)) {
		L5.Msg.alert('提示', '上次查体时间格式不正确！');
		return false;
	}

	// 校验开户银行
	var bank = BaseinfoPeopleRecord.get("bank");
	if (bank == '') {
		L5.Msg.alert('提示', '开户银行不能为空！');
		return false;
	}
	// 校验开户名称
	var accountName = BaseinfoPeopleRecord.get("accountName");
	if (accountName == '') {
		L5.Msg.alert('提示', '开户名称不能为空！');
		return false;
	}
	// 校验银行账号
	var accountCode = BaseinfoPeopleRecord.get("accountCode");
	if (accountCode == '') {
		L5.Msg.alert('提示', '校验银行账号不能为空！');
		return false;
	}
	command.setParameter("makeTable","bpt_imp_tested_make");
	command.setParameter("record", BaseinfoPeopleRecord);
	command.execute("updateDisabilityMakeTable");
	if (!command.error) {
		L5.Msg.alert('提示', "修改成功！");
	} else {
		L5.Msg.alert('提示', "保存时出现错误！" + command.error);
	}
}

// 关闭
function func_Close() {
	window.close();
}
/*
function submit() {
	var records = BptPeopleDisabilityDataSet.getAllChangedRecords();
	if (records.length < 1) {
		L5.Msg.alert('提示', '没有需要保存的数据！');
		return false;
	}
	var command = new L5.Command("com.inspur.cams.bpt.disability.cmd.BptPeopleDisabilityCommand");
	command.setParameter("bptpeopledisabilityRecords", records);
	command.execute("save");
	if (!command.error) {
		BptPeopleDisabilityDataSet.commitChanges();
	} else {
		L5.Msg.alert('提示', "保存时出现错误！" + command.error);
	}
}
function undo() {
	BptPeopleDisabilityDataSet.rejectChanges();
}*/
function func_Type() {
	if (document.getElementById("domicileType").value == '1') {
		document.getElementById("work").style.display = 'none';
		document.getElementById("workAddress").style.display = 'none';
		document.getElementById("employmentCode").disabled = true;
	} else {
		document.getElementById("work").style.display = '';
		document.getElementById("workAddress").style.display = '';
		document.getElementById("employmentCode").disabled = false;
	}
}

function func_Close() {
	window.close();
}
