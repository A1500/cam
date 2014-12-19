var _doleType = "2";// 拨付类型标识为资金
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
}
function query() {
	reliefDoleds.setParameter("requiredOrganCode",
			getParam("requiredOrganCode"));
	reliefDoleds.setParameter("reliefType", getParam("reliefType"));
	reliefDoleds.setParameter("fillState", "E");
	reliefDoleds.setParameter("doleType", "2");
	reliefDoleds.load();
}

// 选择住址行政区划窗口
function forOrganSelect() {
	var revalue = window.showModalDialog("../comm/dicCity.jsp?organCode="
					+ organCode + "&organName="
					+ escape(encodeURIComponent(organName))
					+ "&level=3&radioMaxlevel=0", "",
			"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		document.getElementById("requiredOrganName").value = list[4];
		document.getElementById("requiredOrganCode").value = list[0];
	}
}// 查看明细
function detailReq() {
	var editGrid = L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if (selected.length != 1) {
		L5.Msg.alert('提示', "请选择一条记录!");
		return false;
	}
	var url = "";
	width = 800;
	height = 600;
	url = "goodsRollQueryDetails.jsp?batchId=" + selected[0].get("BATCH_ID")
			+ "&batchDetailId=" + selected[0].get("BATCH_DETAIL_ID")
			+ "&reliefType=" + selected[0].get("RELIEF_TYPE") + "&flag=FUNDS";
	var reValue = window.showModalDialog(url, window,
			"scroll:yes;status:no;dialogWidth:" + width + "px;dialogHeight:"
					+ height + "px;resizable:1");
	query();
}
// 渲染发放数
function doleNumsRenderer(value, cellmeta, record, rowindex, colindex, dataset) {
	return record.get("METES_NUMS") + "/" + value;
}