function init() {
	var specialpoorSupportUnitDataSet = L5.DatasetMgr
			.lookup("specialpoorSupportUnitDataSet");
	if (method == "insert") {
		specialpoorSupportUnitDataSet.newRecord();
	} else {
		specialpoorSupportUnitDataSet.setParameter("SUPPORT_UNIT_CODE@=",
				supportUnitCode);
		specialpoorSupportUnitDataSet.load();
		document.getElementById("supportUnitCode").disabled="disabled";
	}
}
function save() {
	var specialpoorSupportUnitDataSet = L5.DatasetMgr
			.lookup("specialpoorSupportUnitDataSet");
	var valid = specialpoorSupportUnitDataSet.isValidate(true);
	if (valid != true) {
		L5.Msg.alert("提示", "校验未通过，不能保存！" + valid);
		return false;
	}
	var record = specialpoorSupportUnitDataSet.getCurrent();
	var command = new L5.Command("com.inspur.cams.drel.special.cmd.SpecialpoorSupportUnitCmd");
	command.setParameter("record", record);
	if (method == "insert") {
		command.execute("insert");
	} else if (method == "update") {
		command.execute("update");
	}
	if (!command.error) {
		L5.Msg.alert("提示", "保存成功！", function() {
					returnBack();
				});
	} else {
		L5.Msg.alert("提示", "保存出错！");
	}
}
function returnBack() {
	history.go(-1);
}