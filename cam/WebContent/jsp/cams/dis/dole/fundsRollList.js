var _doleType = "1";// 拨付类型标识为资金
function init() {
	document.getElementById("requiredOrganCode").value = organCode;
	document.getElementById("requiredOrganName").value = organName;

	query();
	L5.QuickTips.init();
};
function getParam(ElementId) {
	var value = document.getElementById(ElementId).value;
	if (value == "")
		value = undefined;
	return value;
}
function resetClick() {
	document.getElementById("requiredOrganCode").value = organCode;
	document.getElementById("requiredOrganName").value = organName;
	document.getElementById("reliefType").value = '';
	document.getElementById("fillState").value = '';
}
function query() {
	reliefDoleds.setParameter("requiredOrganCode",
			getParam("requiredOrganCode"));
	reliefDoleds.setParameter("reliefType", getParam("reliefType"));
	if (getParam("fillState") != undefined) {
		reliefDoleds.setParameter("fillState", getParam("fillState"));
	} else {
		reliefDoleds.setParameter("fillState", "9,E");
	}
	reliefDoleds.setParameter("doleType", _doleType);
	reliefDoleds.load();
}
function confirmCommit(selected){
	// 拿取填报状态，如果不是已审批，也不是已发放的 就不可以进行资金发放
	if (selected[0].get("FILL_STATE") != "E"
			&& selected[0].get("FILL_STATE") != "9") {
		L5.Msg.alert('提示', "该记录还未审批，不能发放资金");
		return false;
	}
	var url = "";
	var width = 1024;
	var height = 768;

	// 先判断是否存在资金发放记录
	var cmd = new L5.Command("com.inspur.cams.dis.base.cmd.DisReliefDoleCmd");
	cmd.setParameter("batchDetailId", selected[0].get("BATCH_DETAIL_ID"));
	cmd.setParameter("doleType", _doleType);
	cmd.execute("queryIfUseDole");
	var flag = cmd.getReturn("flag");
	if (flag == null) {
		// 无则进入新增页面
		if (selected[0].get("RELIEF_TYPE") == 'DC'||selected[0].get("RELIEF_TYPE") == 'YJ'||selected[0].get("RELIEF_TYPE") == 'GD'||selected[0].get("RELIEF_TYPE") == 'SW') {
			url = "dc/dcDoleRollList.jsp?batchId="
					+ selected[0].get("BATCH_ID") + "&batchDetailId="
					+ selected[0].get("BATCH_DETAIL_ID");
		} else if (selected[0].get("RELIEF_TYPE") == 'CJ') {
			url = "cj/cjDoleRollList.jsp?batchId="
					+ selected[0].get("BATCH_ID") + "&batchDetailId="
					+ selected[0].get("BATCH_DETAIL_ID");
		}
	} else if (flag != "MORE") {
		// 一条则返回此条的主键进入修改页面
		if (selected[0].get("RELIEF_TYPE") == 'DC'||selected[0].get("RELIEF_TYPE") == 'YJ'||selected[0].get("RELIEF_TYPE") == 'GD'||selected[0].get("RELIEF_TYPE") == 'SW') {
			url = "dc/dcDoleRollList.jsp?batchId="
					+ selected[0].get("BATCH_ID") + "&batchDetailId="
					+ selected[0].get("BATCH_DETAIL_ID") + "&doleId=" + flag;
		} else if (selected[0].get("RELIEF_TYPE") == 'CJ') {
			url = "cj/cjDoleRollList.jsp?batchId="
					+ selected[0].get("BATCH_ID") + "&batchDetailId="
					+ selected[0].get("BATCH_DETAIL_ID") + "&doleId=" + flag;
		}
	} else {
		// 多条则进入选择列表
		width = 800;
		height = 600;
		url = "fundsRollDetails.jsp?batchId=" + selected[0].get("BATCH_ID")
				+ "&batchDetailId=" + selected[0].get("BATCH_DETAIL_ID")
				+ "&reliefType=" + selected[0].get("RELIEF_TYPE");
	}
	var reValue = window.showModalDialog(url, window,
			"scroll:yes;status:no;dialogWidth:" + width + "px;dialogHeight:"
					+ height + "px;resizable:1");
	query();
}
// 发放
function editDole() {
	var editGrid = L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if (selected.length != 1) {
		L5.Msg.alert('提示', "请选择一条记录!");
		return false;
	}
	if (organType == "13" && selected[0].get("GRANT_TYPE") == "02") {
		L5.MessageBox.confirm('确定', '是否代发该乡镇拨付批次?', function(state) {
					if (state == "yes") {
						confirmCommit(selected);
					} else {
						return false;
					}
				});
	} else {
		confirmCommit(selected);
	}
}
// 选择住址行政区划窗口
function forOrganSelect() {
	var revalue = window.showModalDialog("../comm/dicCity.jsp?organCode="
					+ organCode + "&organName="
					+ escape(encodeURIComponent(organName)) + "&level=3", "",
			"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		document.getElementById("requiredOrganName").value = list[4];
		document.getElementById("requiredOrganCode").value = list[0];
	}
}

// 渲染发放数
function doleNumsRenderer(value, cellmeta, record, rowindex, colindex, dataset) {
	return record.get("FUNDS_NUMS") + "/" + value;
}