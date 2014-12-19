function init() {
	var BptPeopleDisabilityDataSet = L5.DatasetMgr
			.lookup("BptPeopleDisabilityDataSet");
	BptPeopleDisabilityDataSet.setParameter("PEOPLE_ID", peopleId);
	BptPeopleDisabilityDataSet.load();
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
function save() {
	var BptPeopleDisabilityDataSet = L5.DatasetMgr
			.lookup("BptPeopleDisabilityDataSet");
	var BptPeopleDisabilityRecord = BptPeopleDisabilityDataSet.getCurrent();

	var isValidate = BptPeopleDisabilityDataSet.isValidate();
	if (isValidate != true) {
		L5.Msg.alert("提示", isValidate);
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
	var conscriptDate = BptPeopleDisabilityRecord.get("conscriptDate");
	if (conscriptDate != '' && !validateDateFormat(conscriptDate)) {
		L5.Msg.alert('提示', '入伍(参加工作)时间格式不正确！');
		return false;
	}
	
	var veteransDate = BptPeopleDisabilityRecord.get("veteransDate");
	if (veteransDate != '' && !validateDateFormat(veteransDate)) {
		L5.Msg.alert('提示', '退伍时间格式不正确！');
		return false;
	}
		
	var retiredDate = BptPeopleDisabilityRecord.get("retiredDate");
	if (retiredDate != '' && !validateDateFormat(retiredDate)) {
		L5.Msg.alert('提示', '离退休时间格式不正确！');
		return false;
	}

	var disabilityDate = BptPeopleDisabilityRecord.get("disabilityDate");
	if (disabilityDate != '' && !validateDateFormat(disabilityDate)) {
		L5.Msg.alert('提示', '致残时间格式不正确！');
		return false;
	}
	
	var disabilityNo = BptPeopleDisabilityRecord.get("disabilityNo").substr(2,
			6);
	// 证书编号验证
	/*if (BptPeopleDisabilityRecord.get("disabilityNo").length != 8) {
		L5.Msg.alert('提示', '请输入有效证书编号无效！');
		return false;
	} else {
		var disabilityNo = BptPeopleDisabilityRecord.get("disabilityNo")
				.substr(2, 6);
		if (!_isNum(disabilityNo)) {
			L5.Msg.alert('提示', '证书编号无效！');
			return false;
		}
	}*/

	var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptPeopleDisabilityCommand");

	command
			.setParameter("BptPeopleDisabilityRecord",
					BptPeopleDisabilityRecord);
	command.execute("updateDisability");

	if (!command.error) {
		BptPeopleDisabilityDataSet.getCurrent().state = L5.model.Record.STATE_MODIFIED;
		L5.Msg.alert('提示', '保存成功！');
	} else {
		L5.Msg.alert('提示', "保存时出现错误！" + command.error);
	}
}

function func_Close() {
	window.close();
}

function fun_Level() {
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

function fun_DisabilityType() {
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