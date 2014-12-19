function init() {
	
	if (method == null || method == "") {
		L5.Msg.alert('提示', "未知的页面命令!");
		back();
	} else if (method == "INSERT") {
		BaseinfoPeopleDataSet.newRecord({
					peopleId : document.forms[0].peopleId.value,
					familyId : document.forms[0].familyId.value
				});
		var BptPeopleDisabilityDataSet = L5.DatasetMgr
				.lookup("BptPeopleDisabilityDataSet");
		BptPeopleDisabilityDataSet.newRecord({
					peopleId : document.forms[0].peopleId.value
				});
		var BaseinfoFamilyDataSet = L5.DatasetMgr
				.lookup("BaseinfoFamilyDataSet");
		BaseinfoFamilyDataSet.newRecord({
					familyId : document.forms[0].familyId.value
				});
		BptPeopleDisabilityDataSet.set("disabilityStateCode", 2);
		BptPeopleDisabilityDataSet.set("supportPattern", 1);
		var typeInfo = L5.getCmp("typeInfo");
		typeInfo.on("activate", func_BankName);
		return;
	} else if (method == "UPDATE") {
		document.getElementById("peopleId").readOnly = true;
		BaseinfoPeopleDataSet.baseParams["PEOPLE_ID@="] = idField;
		BaseinfoPeopleDataSet.on("load", getValue);
		BaseinfoPeopleDataSet.load();
		var BptPeopleDisabilityDataSet = L5.DatasetMgr
				.lookup("BptPeopleDisabilityDataSet");

	}
	
	L5.QuickTips.init();
}

function KoreaWar(k){

	if(k.value==3){
		document.getElementById("k1").style.display='';
		document.getElementById("k2").style.display='';
	}else{
		document.getElementById("k1").style.display='none';
		document.getElementById("k2").style.display='none';
	}
}
function func_BankName() {
	BptPeopleDisabilityDataSet.set("accountName", BaseinfoPeopleDataSet
					.get("name"));
}
function func_SaveClick() {
	var img = document.getElementById("photoTemp").value;
	
	// var flag= document.forms[0].flag.value;
	var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptPeopleDisabilityCommand");
	// 人员信息验证
	var BaseinfoPeopleDataSet = L5.DatasetMgr.lookup("BaseinfoPeopleDataSet");
	var BaseinfoPeopleRecord = BaseinfoPeopleDataSet.getCurrent();
	BaseinfoPeopleRecord.set('photoTemp', img);

	// 类别信息
	var BptPeopleDisabilityDataSet = L5.DatasetMgr
			.lookup("BptPeopleDisabilityDataSet");
	var BptPeopleDisabilityRecord = BptPeopleDisabilityDataSet.getCurrent();
	// 新增人员信息
	if (BaseinfoPeopleRecord.get("peopleId") == ""
			&& BaseinfoPeopleRecord.get("familyId") == "") {
		BaseinfoPeopleRecord.set("peopleId", peopleId);
		BaseinfoPeopleRecord.set("familyId", familyId);
		BptPeopleDisabilityRecord.set("peopleId", peopleId);
	} else {// 修改人员信息
		BptPeopleDisabilityRecord.set("peopleId", BaseinfoPeopleRecord
						.get("peopleId"));
		peopleId = BaseinfoPeopleRecord.get("peopleId");
		familyId = BaseinfoPeopleRecord.get("familyId");
	}
	
	
	
	var isValidate = BaseinfoPeopleDataSet.isValidate();
	if (isValidate != true) {
		L5.Msg.alert("提示", isValidate);
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
	
	var disabilityLevelCode = BptPeopleDisabilityRecord.get("disabilityLevelCode");
	if (disabilityLevelCode == '') {
		L5.Msg.alert('提示', '伤残等级不能为空！');
		return false;
	}
	var disabilityCaseCode = BptPeopleDisabilityRecord.get("disabilityCaseCode");
	if (disabilityCaseCode == '') {
		L5.Msg.alert('提示', '伤残性质不能为空！');
		return false;
	}
	if (disabilityCaseCode == '3') {
		if(disabilityLevelCode=='07'||disabilityLevelCode=='08'||disabilityLevelCode=='09'||disabilityLevelCode=='10'){
			L5.Msg.alert('提示', '您选择的伤残性质为“因病”,伤残等级只能为1至6级！');
			return false;
		}
	}
	if (document.getElementById("viabilityCode") == null) {
		L5.Msg.alert('提示', '请录入类别信息后再保存！');
		return false;
	}
	// 伤残信息验证
	BptPeopleDisabilityDataSet.set("viabilityCode", document
					.getElementById("viabilityCode").value);
	var isValidate = BptPeopleDisabilityDataSet.isValidate();
	if (isValidate != true) {
		L5.Msg.alert("提示", isValidate);
		return false;
	}

	// 校验批准日期
	var approveDate = BptPeopleDisabilityRecord.get("approveDate");
	if (approveDate == '') {
		L5.Msg.alert('提示', '批准日期不能为空！');
		return false;
	}
	if (!validateDateFormat(approveDate)) {
		L5.Msg.alert('提示', '批准日期格式不正确！');
		return false;
	}

	// 入伍时间和退伍时间
	var disabilityTypeCode = BptPeopleDisabilityRecord
			.get("disabilityTypeCode");
	if (disabilityTypeCode == '11') {
		var conscriptDate = BptPeopleDisabilityRecord.get("conscriptDate");
		var veteransDate = BptPeopleDisabilityRecord.get("veteransDate");
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
	var retiredDate = document.getElementById("retiredDate").value;
	if(retiredDate!=''&&!validateDateFormat(retiredDate)){
		L5.Msg.alert('提示', '离退休时间格式不正确！');
		return false;
	}
	
		//致残时间
	var disabilityDate = document.getElementById("disabilityDate").value;
	if(disabilityDate!=''&&!validateDateFormat(disabilityDate)){
		L5.Msg.alert('提示', '致残时间格式不正确！');
		return false;
	}
	
	// 证书编号验证
	/*if (BptPeopleDisabilityRecord.get("disabilityNo").length != 9) {
		L5.Msg.alert('提示', '请输入有效证书编号无效！');
		return false;
	} else {
		var disabilityNo = BptPeopleDisabilityRecord.get("disabilityNo")
				.substr(3, 6);
		if (!_isNum(disabilityNo)) {
			L5.Msg.alert('提示', '证书编号无效！');
			return false;
		}
	}*/
	
	
	var idCard = BaseinfoPeopleDataSet.get("idCard");
	if(!writeAble(idCard,"1",false)){
		L5.Msg.alert('提示', '该人员已经是伤残人员！');
		return false;
	}
	
	command.setParameter("flag", document.forms[0].flag.value);
	command.setParameter("BaseinfoPeopleRecord", BaseinfoPeopleRecord);
	command
			.setParameter("BptPeopleDisabilityRecord",
					BptPeopleDisabilityRecord);
	command.execute("save");
	if (!command.error) {
		BaseinfoPeopleDataSet.getCurrent().state = L5.model.Record.STATE_MODIFIED;
		// L5.Msg.alert('提示','保存成功！');
		// var data = new L5.Map();
		// data.put("peopleId",BaseinfoPeopleRecord.get("peopleId"));
		// data.put("familyId",BaseinfoPeopleRecord.get("familyId"));
		// var
		// url='jsp/cams/bpt/dataCollection/disability/disabilityUpdateManage.jsp';
		// var text = '伤残人员信息修改';
		// L5.forward(url,text,data);
		var peopleId1 = command.getReturn("peopleId");
		var familyId1 = command.getReturn("familyId");
		window.returnValue = peopleId1 + ";" + familyId1;
		window.close();
	} else {
		L5.Msg.alert('提示', "保存时出现错误！" + command.error);
	}
}

function func_Close() {
	window.close();
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
function idcardlookup(){
	L5.getCmp("imgshow").show();
	//window.open (L5.webPath+'/jsp/cams/bpt/comm/idCardDetail.jsp?src=data:image/jpeg;base64,'+ pPrintPhotoBuffer,'身份证件',
	//'height=500,width=400,top=0,left=0,toolbar=no,menubar=no,scrollbars=no,resizable=no,location=no, status=no');
}
function idcardclose(){
	var win = L5.getCmp("imgshow");
	win.hide();
}