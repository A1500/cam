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
	reliefDoleds.setParameter("requiredOrganCode", getParam("requiredOrganCode"));
	reliefDoleds.setParameter("reliefType", getParam("reliefType"));
	reliefDoleds.setParameter("fillState", "E");
	reliefDoleds.setParameter("inConfirm", "1");
	reliefDoleds.load();
}
// 管理打印
function sumReq() {
	var editGrid = L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if (selected.length != 1) {
		L5.Msg.alert('提示', "请选择一条记录!");
		return false;
	}
	var url = "cardDetails.jsp?batchId=" + selected[0].get("BATCH_ID")
			+ "&batchDetailId=" + selected[0].get("BATCH_DETAIL_ID")
			+ "&reliefType=" + selected[0].get("RELIEF_TYPE");
	var width = 800;
	var height = 600;
	var reValue = window.showModalDialog(url, window,
			"scroll:yes;status:no;dialogWidth:" + width + "px;dialogHeight:"
					+ height + "px;resizable:1");
}
// 选择住址行政区划窗口
function forOrganSelect() {
	var revalue = window.showModalDialog(
			"../comm/dicCity.jsp?organCode=" + organCode
					+ "&organName=" + escape(encodeURIComponent(organName))
					+ "&level=3", "",
			"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		document.getElementById("requiredOrganName").value = list[4];
		document.getElementById("requiredOrganCode").value = list[0];
	}
}
// 渲染填报状态
// 0:未填报,1:未上报,2:已上报,3:已提交,5:复核上报,6:复核提交,9:已审批
var pos = -1;
function fillStateRenderer(value, cellmeta, record,
		rowindex, colindex, dataset) {
	pos = fillstateDs.find("value",value,0);
	if(value=="6")
		return "<font color=blue>"+fillstateDs.getAt(pos).get("text")+"</font>";
	else if(value=="3")
		return "<font color=red>"+fillstateDs.getAt(pos).get("text")+"</font>";
	return fillstateDs.getAt(pos).get("text");
}
// 渲染发放数
function doleNumsRenderer(value, cellmeta, record, rowindex, colindex, dataset) {
	return value + "(" + record.get("FUNDS_NUMS") + "-"
			+ record.get("METES_NUMS") + ")";
}