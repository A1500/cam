function getParam(ElementId) {
	var value = document.getElementById(ElementId).value;
	if (value == "")
		value = undefined;
	return value;
}
function init() {
	if(defOrgan!="")
		document.getElementById("qHelpVillageCode").value = defOrgan;
	query();
}
function query() {
	var specialpoorHelpVillageDataSet = L5.DatasetMgr.lookup("specialpoorHelpVillageDataSet");
	specialpoorHelpVillageDataSet.setParameter("HELP_VILLAGE_FLAG@=", "1");
	specialpoorHelpVillageDataSet.setParameter("HELP_VILLAGE_CODE@rlike", getParam("qHelpVillageCode"));
	specialpoorHelpVillageDataSet.setParameter("HELP_VILLAGE_NAME@rlike", getParam("qHelpVillageName"));
	specialpoorHelpVillageDataSet.load();
}
function insert() {
	var data = new L5.Map();
	data.put("method", "insert");
	var url = "jsp/cams/drel/specialpoorHelp/specialpoorHelpVillageEdit.jsp";
	L5.forward(url, '', data);
}
function update() {
	var grid = L5.getCmp("grid");
	var records = grid.getSelectionModel().getSelections();
	if (records.length == 0) {
		L5.Msg.alert("提示", "请先选中一行!");
		return;
	}
	var data = new L5.Map();
	data.put("method", "update");
	data.put("helpVillageCode", records[0].get("helpVillageCode"));
	var url = "jsp/cams/drel/specialpoorHelp/specialpoorHelpVillageEdit.jsp";
	L5.forward(url, '', data);
}
function detail() {
	var grid = L5.getCmp("grid");
	var records = grid.getSelectionModel().getSelections();
	if (records.length == 0) {
		L5.Msg.alert("提示", "请先选中一行!");
		return;
	}
	var data = new L5.Map();
	data.put("helpVillageCode", records[0].get("helpVillageCode"));
	var url = "jsp/cams/drel/specialpoorHelp/specialpoorHelpVillageDetail.jsp";
	L5.forward(url, '', data);
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
			var command = new L5.Command("com.inspur.cams.drel.special.cmd.SpecialpoorHelpVillageCmd");
			command.setParameter("helpVillageCode", records[0]
							.get("helpVillageCode"));
			command.execute("delete");
			if (!command.error) {
				var specialpoorHelpVillageDataSet = L5.DatasetMgr
						.lookup("specialpoorHelpVillageDataSet");
				specialpoorHelpVillageDataSet.load();
			} else {
				L5.Msg.alert("提示", "删除出错！");
			}
		}
	});
}
//选择回填
function sel() {
	var grid = L5.getCmp("grid");
	var records = grid.getSelectionModel().getSelections();
	if (records.length <= 0) {
		L5.Msg.alert("提示", "请先选中需回填的信息!");
		return;
	}

	var str = "";
	for (var i = 0; i < records.length; i++) {
		str += records[i].get("helpVillageCode") + ";";
	}
	if (str.length > 0)
		str = str.substring(0, str.length - 1);

	window.returnValue = str;
	window.close();
}