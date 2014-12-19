function init() {
	if (method == "INSERT") {
		var dsTested = L5.DatasetMgr.lookup("dsTested");
		dsTested.newRecord({
					peopleId : document.forms[0].peopleId.value
				});

		BaseinfoPeopleDataSet.newRecord({
					peopleId : document.forms[0].peopleId.value,
					familyId : document.forms[0].familyId.value
				});
		var BaseinfoFamilyDataSet = L5.DatasetMgr
				.lookup("BaseinfoFamilyDataSet");
		dsTested.set("warStateCode", 2);
		dsTested.set("supportPattern", 1);
		var typeInfo = L5.getCmp("typeInfo");
		typeInfo.on("activate", func_BankName);
		return;
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

	var img = document.getElementById("photoTemp").value;
	var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptPeopleTestedCommand");
	// 人员信息验证
	var BaseinfoPeopleDataSet = L5.DatasetMgr.lookup("BaseinfoPeopleDataSet");
	var BaseinfoPeopleRecord = BaseinfoPeopleDataSet.getCurrent();
	BaseinfoPeopleRecord.set('photoTemp', img);
	
	// 参试信息
	var dsTested = L5.DatasetMgr.lookup("dsTested");
	var testedEntity = dsTested.getCurrent();
	// 新增人员信息
	if (BaseinfoPeopleRecord.get("peopleId") == ""
			&& BaseinfoPeopleRecord.get("familyId") == "") {
		BaseinfoPeopleRecord.set("peopleId", peopleId);
		BaseinfoPeopleRecord.set("familyId", familyId);
		testedEntity.set("peopleId", peopleId);
	} else {// 修改人员信息
		testedEntity.set("peopleId", BaseinfoPeopleRecord.get("peopleId"));
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
	
	if (BaseinfoPeopleDataSet.get("safeguardType") == '') {
		L5.Msg.alert("提示", "医疗保障方式不能为空");
		return false;
	}
	if (BaseinfoPeopleDataSet.get("domicileType") == '') {
		L5.Msg.alert("提示", "户籍类别不能为空");
		return false;
	}
	
	
	if (L5.getDom("warNo") == null || L5.getDom("warNo") == "") {
		L5.Msg.alert('提示', '请录入类别信息后再保存！');
		return false;
	}
	
	

	var isValidate = dsTested.isValidate();
	if (isValidate != true) {
		L5.Msg.alert("提示", isValidate);
		return false;
	}

	var approvalDate = testedEntity.get("approvalDate");
	if (approvalDate != '' && !validateDateFormat(approvalDate)) {
		L5.Msg.alert('提示', '批准时间格式不正确！');
		return false;
	}
	if(approvalDate==''){
		L5.Msg.alert('提示', '批准时间不能为空！');
		return false;
	}

	var conscriptcDate = testedEntity.get("conscriptcDate");
	if (conscriptcDate != '' && !validateDateFormat(conscriptcDate)) {
		L5.Msg.alert('提示', '入伍(参加工作)时间格式不正确！');
		return false;
	}
	if(conscriptcDate==''){
		L5.Msg.alert('提示', '入伍(参加工作)时间不能为空！');
		return false;
	}
	var decruitmentDate = testedEntity.get("decruitmentDate");
	if (decruitmentDate != '' && !validateDateFormat(decruitmentDate)) {
		L5.Msg.alert('提示', '退伍时间格式不正确！');
		return false;
	}
	if(decruitmentDate==''){
		L5.Msg.alert('提示', '退伍时间不能为空！');
		return false;
	}
	var retiredDate = testedEntity.get("retiredDate");
	if (retiredDate != '' && !validateDateFormat(retiredDate)) {
		L5.Msg.alert('提示', '离退休时间格式不正确！');
		return false;
	}
	var thisExaminationDate = testedEntity.get("thisExaminationDate");
	if (thisExaminationDate != '' && !validateDateFormat(thisExaminationDate)) {
		L5.Msg.alert('提示', '本次查体时间格式不正确！');
		return false;
	}
	var theExaminationDate = testedEntity.get("theExaminationDate");
	if (theExaminationDate != '' && !validateDateFormat(theExaminationDate)) {
		L5.Msg.alert('提示', '上次查体时间格式不正确！');
		return false;
	}

	// 校验开户银行
	var bank = testedEntity.get("bank");
	if (bank == '') {
		L5.Msg.alert('提示', '开户银行不能为空！');
		return false;
	}
	// 校验开户名称
	var accountName = testedEntity.get("accountName");
	if (accountName == '') {
		L5.Msg.alert('提示', '开户名称不能为空！');
		return false;
	}
	// 校验银行账号
	var accountCode = testedEntity.get("accountCode");
	if (accountCode == '') {
		L5.Msg.alert('提示', '校验银行账号不能为空！');
		return false;
	}
	var idCard = BaseinfoPeopleDataSet.get("idCard");
	if(!writeAble(idCard,"61")){
		L5.Msg.alert('提示', '该人员已经是参试人员！');
		return false;
	}
	
	command.setParameter("flag", document.forms[0].flag.value);
	command.setParameter("BaseinfoPeopleRecord", BaseinfoPeopleRecord);
	command.setParameter("testedEntity", testedEntity);
	command.execute("insert");
	if (!command.error) {
		// L5.Msg.alert('提示','保存成功！');
		// var data = new L5.Map();
		// data.put("peopleId",BaseinfoPeopleRecord.get("peopleId"));
		// data.put("familyId",BaseinfoPeopleRecord.get("familyId"));
		// var url='jsp/cams/bpt/dataCollection/tested/bpttested_edit.jsp';
		// var text = '参战人员信息修改';
		// L5.forward(url,text,data);
		var peopleId1 = command.getReturn("peopleId");
		var familyId1 = command.getReturn("familyId");
		window.returnValue = peopleId1 + ";" + familyId1;
		window.close();
	} else {
		L5.Msg.alert('提示', "保存时出现错误！" + command.error);
	}
}

// 关闭
function func_Close() {
	window.close();
}

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

function func_Close() {
	window.close();
}
/**
 * 选择健康状况
 */
function func_HealthSelect() {

	var revalue = window.showModalDialog(
			L5.webPath + "/jsp/cams/comm/dichealth/dichealth.jsp", "",
			"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		document.getElementById("healthStateName").value = list[1];
		dsTested.set("healthStateCode", list[0]);
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