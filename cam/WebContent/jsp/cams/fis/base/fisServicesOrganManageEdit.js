function init() {
	var ds = L5.DatasetMgr.lookup("ds");
	if (method == "insert") {
		ds.newRecord();
	} else if (method == "update") {
		ds.setParameter("RECORD_ID@=", recordId);
		ds.load();
	}
	L5.QuickTips.init();
}

function save() {
	var ds = L5.DatasetMgr.lookup("ds");
	var record = ds.getCurrent();

	if (record.length < 1) {
		L5.Msg.alert('提示', '没有需要保存的数据!');
		return false;
	}
	// 校验
	var valid = ds.isValidate();
	if (valid != true) {
		L5.Msg.alert('提示', "校验未通过!" + valid);
		return false;
	}
	var command = new L5.Command("com.inspur.cams.fis.base.cmd.FisServicesOrganManageCmd");
	command.setParameter("record", record);
	if (method == "insert") {
		command.execute("insert");
	} else if (method == "update") {
		command.execute("update");
	}
	if (!command.error) {
		var error = command.getReturn("error");
		if (error != undefined) {
			L5.Msg.alert('提示', error);
		} else {
			L5.Msg.alert('提示', "保存成功!");
			history.go(-1);
		}
	} else {
		L5.Msg.alert('提示', "保存时出现错误！" + command.error);
	}
}

function reset() {
	L5.DatasetMgr.lookup("ds").load();
	L5.QuickTips.init();
}
function goBack() {
	history.go(-1);
}
// 校验数字
function checkNum(domId) {
	if (document.getElementById(domId).value) {
		if (!_isNum(document.getElementById(domId).value)) {
			document.getElementById(domId).value = "";
			L5.Msg.alert("提示", "请输入数字");
			return;
		}
	}
}

// 小数点位数处理
function checkAssMon(domId) {
	if (document.getElementById(domId).value) {
		if (!isFloat(document.getElementById(domId).value)) {
			document.getElementById(domId).value = "";
			L5.Msg.alert("提示", "请输入数字");
			return;
		}
		document.getElementById(domId).value = changeTwoDecimal(document
				.getElementById(domId).value);
	}
}

// 更新业务主管单位信息
function updateSelectParentOrganCode() {
	var choiceBox = "radiobox";
	var choiceOrganType = '1';// 1为单位，2为部门
	var revalue = window.showModalDialog(
			"../../../bsp/organization/selectstru.jsp?choiceBox=" + choiceBox
					+ "&choiceOrganType=" + choiceOrganType, "",
			"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;dialogLeft:"
					+ (window.screen.width - 300) / 2 + ";dialogTop:"
					+ (window.screen.height - 400) / 2);
	var record = ds.getCurrent();
	if (revalue != undefined && revalue != "") {
		var list = revalue.split(";");// list[0] ==
		// organId,list[1]==organName,list[2]==struId,list[3]==recordId
		record.set("parentOrganCode", list[3]);
		record.set("parentOrganName", list[1]);
		L5.fly('parentOrganName').dom.value = list[1];
		record.set("parentStruId", list[2]);
	}
}
// 更新所属行政区划信息
function updateSelectAreaCode() {
	var choiceBox = "radiobox";
	var revalue = window.showModalDialog("fisDicCityTreeWindow.jsp?choiceBox="
					+ choiceBox, "",
			"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;dialogLeft:"
					+ (window.screen.width - 300) / 2 + ";dialogTop:"
					+ (window.screen.height - 400) / 2);
	var record = ds.getCurrent();
	if (revalue != undefined && revalue != "") {
		var list = revalue.split(";");// list[0] == areaCode,list[1]==areaName
		record.set("areaCode", list[0]);
		record.set("areaName", list[1]);
		L5.fly('areaName').dom.value = list[1];
	}
}