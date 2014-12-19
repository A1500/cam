function init() {
	var specialpoorHelpVillageDataSet = L5.DatasetMgr
			.lookup("specialpoorHelpVillageDataSet");
	if (method == "insert") {
		specialpoorHelpVillageDataSet.newRecord({
					"helpVillageFlag" : "1"
				});
	} else {
		specialpoorHelpVillageDataSet.setParameter("HELP_VILLAGE_CODE@=",
				helpVillageCode);
		specialpoorHelpVillageDataSet.load();
		document.getElementById("helpVillageCode").disabled="disabled";
	}
}
function save() {
	var specialpoorHelpVillageDataSet = L5.DatasetMgr
			.lookup("specialpoorHelpVillageDataSet");
	var valid = specialpoorHelpVillageDataSet.isValidate(true);
	if (valid != true) {
		L5.Msg.alert("提示", "校验未通过，不能保存！" + valid);
		return false;
	}
	var record = specialpoorHelpVillageDataSet.getCurrent();
	var command = new L5.Command("com.inspur.cams.drel.special.cmd.SpecialpoorHelpVillageCmd");
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