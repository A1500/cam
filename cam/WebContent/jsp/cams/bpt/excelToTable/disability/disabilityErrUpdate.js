function init() {

var BaseinfoPeopleDataSet=L5.DatasetMgr.lookup("BaseinfoPeopleDataSet");
	    BaseinfoPeopleDataSet.setParameter("organCode",organCode);
		BaseinfoPeopleDataSet.setParameter("makeTable","bpt_imp_people_disability_make");
		BaseinfoPeopleDataSet.setParameter("id",id);
		BaseinfoPeopleDataSet.load();

	L5.QuickTips.init();
}
function func_BankName() {
	BptPeopleDisabilityDataSet.set("accountName", BaseinfoPeopleDataSet
					.get("name"));
}
function func_SaveClick() {
	
	// var flag= document.forms[0].flag.value;
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
	
	// 医疗保障方式规划
	var safeguardType = BaseinfoPeopleRecord.get("safeguardType");
	if (safeguardType == '') {
		L5.Msg.alert('提示', '医疗保障方式不能为空！');
		return false;
	}

	// 校验户籍类别
	var domicileType = BaseinfoPeopleRecord.get("domicileType");
	if (domicileType == '') {
		L5.Msg.alert('提示', '户籍类别不能为空！');
		return false;
	}
	
	var disabilityLevelCode = BaseinfoPeopleRecord.get("disabilityLevelCode");
	if (disabilityLevelCode == '') {
		L5.Msg.alert('提示', '伤残等级不能为空！');
		return false;
	}
	var disabilityCaseCode = BaseinfoPeopleRecord.get("disabilityCaseCode");
	if (disabilityCaseCode == '') {
		L5.Msg.alert('提示', '伤残性质不能为空！');
		return false;
	}

	/*if (document.getElementById("viabilityCode") == null) {
		L5.Msg.alert('提示', '请录入类别信息后再保存！');
		return false;
	}*/

	// 校验批准日期
	var approveDate = BaseinfoPeopleRecord.get("approveDate");
	if (approveDate == '') {
		L5.Msg.alert('提示', '批准日期不能为空！');
		return false;
	}
	if (!validateDateFormat(approveDate)) {
		L5.Msg.alert('提示', '批准日期格式不正确！');
		return false;
	}

	// 入伍时间和退伍时间
	var disabilityTypeCode = BaseinfoPeopleRecord
			.get("disabilityTypeCode");
	if (disabilityTypeCode == '11') {
		var conscriptDate = BaseinfoPeopleRecord.get("conscriptDate");
		var veteransDate = BaseinfoPeopleRecord.get("veteransDate");
		if (conscriptDate == '' || veteransDate == '') {
			L5.Msg.alert('提示', '入伍(参加工作时间)或退伍时间不能为空！');
			return false;
		}
		if (!validateDateFormat(conscriptDate)) {
			L5.Msg.alert('提示', '入伍时间格式不正确！');
			return false;
		}
		if (!validateDateFormat(veteransDate)) {
			L5.Msg.alert('提示', '退伍时间格式不正确！');
			return false;
		}
	}
		//离退休时间
	var retiredDate = BaseinfoPeopleRecord.get("retiredDate");
	if(retiredDate!=''&&!validateDateFormat(retiredDate)){
		L5.Msg.alert('提示', '离退休时间格式不正确！');
		return false;
	}
	
		//致残时间
	/*var disabilityDate = document.getElementById("disabilityDate").value;
	if(disabilityDate!=''&&!validateDateFormat(disabilityDate)){
		L5.Msg.alert('提示', '致残时间格式不正确！');
		return false;
	}
	
	// 证书编号验证
	if (BaseinfoPeopleRecord.get("disabilityNo").length != 8) {
		L5.Msg.alert('提示', '请输入有效证书编号无效！');
		return false;
	} else {
		var disabilityNo = BaseinfoPeopleRecord.get("disabilityNo")
				.substr(2, 6);
		if (!_isNum(disabilityNo)) {
			L5.Msg.alert('提示', '证书编号无效！');
			return false;
		}
	}*/
	command.setParameter("makeTable", "bpt_imp_people_disability_make");
	command.setParameter("record", BaseinfoPeopleRecord);
	command.execute("updateDisabilityMakeTable");
	if (!command.error) {
		L5.Msg.alert('提示', "修改成功！");
	} else {
		L5.Msg.alert('提示', "保存时出现错误！" + command.error);
	}
}

function func_Close() {
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
function func_Level() {
	if (document.getElementById("disabilityLevelCode").value <= '04'
			&& document.getElementById("disabilityLevelCode").value != '') {
		document.getElementById("viabilityCode").value = 2;
	}
	if (document.getElementById("disabilityLevelCode").value > '04') {
		document.getElementById("viabilityCode").value = '';
	}
	if (document.getElementById("disabilityLevelCode").value == '') {
		document.getElementById("viabilityCode").value = '';
	}
}

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

function func_DisabilityType() {
	if (document.getElementById("disabilityTypeCode").value == '11') {
		document.getElementById("disabilityNo").value = '鲁军';
	} else if (document.getElementById("disabilityTypeCode").value == '12') {
		document.getElementById("disabilityNo").value = '鲁工';
	} else if (document.getElementById("disabilityTypeCode").value == '13') {
		document.getElementById("disabilityNo").value = '鲁警';
	} else if (document.getElementById("disabilityTypeCode").value == '14') {
		document.getElementById("disabilityNo").value = '鲁民';
	} else if (document.getElementById("disabilityTypeCode").value == '15') {
		document.getElementById("disabilityNo").value = '鲁民';
	} else {
		document.getElementById("disabilityNo").value = '';
	}
}
function func_Close() {
	window.close();
}
