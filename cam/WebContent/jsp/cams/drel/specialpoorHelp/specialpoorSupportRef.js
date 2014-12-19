function init() {
	var specialpoorSupportUnitDataSet = L5.DatasetMgr.lookup("specialpoorSupportUnitDataSet");
	specialpoorSupportUnitDataSet.setParameter("SUPPORT_UNIT_CODE@=", supportUnitCode);
	specialpoorSupportUnitDataSet.load(true);
	
	var specialpoorSupportRefDataSet = L5.DatasetMgr.lookup("specialpoorSupportRefDataSet");
	specialpoorSupportRefDataSet.setParameter("supportUnitCode", supportUnitCode);
	specialpoorSupportRefDataSet.load(true);
}
function insert() {
	var specialpoorSupportUnitDataSet = L5.DatasetMgr.lookup("specialpoorSupportUnitDataSet");
	var url = "specialpoorHelpVillageWin.jsp?defOrgan=" + specialpoorSupportUnitDataSet.getAt(0).get("supportTownCode");
	var width = 655;
    var height = 568;
	var returnValue = window.showModalDialog(url, window, "scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:0");
	if(returnValue) {
		L5.Msg.wait("正在保存增加数据，请等待...", "保存增加数据");
		var command = new L5.Command("com.inspur.cams.drel.special.cmd.SpecialpoorSupportRefCmd");
		command.setParameter("supportUnitCode", supportUnitCode);
		command.setParameter("helpVillageCode", returnValue);
		command.execute("batchInsert");
		if (!command.error) {
			var specialpoorSupportRefDataSet = L5.DatasetMgr.lookup("specialpoorSupportRefDataSet");
			specialpoorSupportRefDataSet.setParameter("supportUnitCode", supportUnitCode);
			specialpoorSupportRefDataSet.load(true);
			L5.Msg.alert("提示", "增加成功！");
		} else {
			L5.Msg.alert("提示", "增加出错！");
		}
	}
}
function del() {
	var grid = L5.getCmp("grid");
	var records = grid.getSelectionModel().getSelections();
	if (records.length != 1) {
		L5.Msg.alert("提示", "请先选中一行!");
		return;
	}
	L5.MessageBox.confirm("提示", "是否删除该数据？", function(sta) {
		if (sta == "yes") {
			var command = new L5.Command("com.inspur.cams.drel.special.cmd.SpecialpoorSupportRefCmd");
			command.setParameter("recordId", records[0].get("RECORD_ID"));
			command.execute("delete");
			if (!command.error) {
				var specialpoorSupportRefDataSet = L5.DatasetMgr.lookup("specialpoorSupportRefDataSet");
				specialpoorSupportRefDataSet.setParameter("supportUnitCode", supportUnitCode);
				specialpoorSupportRefDataSet.load(true);
			} else {
				L5.Msg.alert("提示", "删除出错！");
			}
		}
	});
}
function returnBack() {
	history.go(-1);
}