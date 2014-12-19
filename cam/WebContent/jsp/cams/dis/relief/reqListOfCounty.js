function init() {
	document.getElementById("requiredOrganCode").value = organCode;
	document.getElementById("requiredOrganName").value = organName;
	batchDetailds.setParameter("requiredOrganCode",getParam("requiredOrganCode"));
	batchDetailds.setParameter("fillState@OR", "2,3,5,6");
	batchDetailds.load();
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
	batchDetailds.setParameter("requiredOrganCode",getParam("requiredOrganCode"));
	batchDetailds.setParameter("reliefType", getParam("reliefType"));
	if(getParam("fillState")!=undefined){
		batchDetailds.setParameter("fillState", getParam("fillState"));
	}else{
		batchDetailds.setParameter("fillState@OR", "2,3,5,6");
	}
	batchDetailds.load();
}
// 分析
function sumReq() {
	var editGrid = L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if (selected.length != 1) {
		L5.Msg.alert('提示', "请选择一条记录!");
		return false;
	}
	var url = "";
	// 分页面处理
	if (selected[0].get("RELIEF_TYPE") == 'DC') {
		url = "dc/dcApproveList.jsp?batchId=" + selected[0].get("BATCH_ID")
			+ "&batchDetailId=" + selected[0].get("BATCH_DETAIL_ID");
	}else if(selected[0].get("RELIEF_TYPE") == 'YJ') {
		url = "yj/yjApproveList.jsp?batchId=" + selected[0].get("BATCH_ID")
			+ "&batchDetailId=" + selected[0].get("BATCH_DETAIL_ID");
	}else if(selected[0].get("RELIEF_TYPE") == 'GD') {
		url = "gd/gdApproveList.jsp?batchId=" + selected[0].get("BATCH_ID")
			+ "&batchDetailId=" + selected[0].get("BATCH_DETAIL_ID");
	}else if(selected[0].get("RELIEF_TYPE") == 'CJ') {
		url = "cj/cjApproveList.jsp?batchId=" + selected[0].get("BATCH_ID")
			+ "&batchDetailId=" + selected[0].get("BATCH_DETAIL_ID");
	}else if(selected[0].get("RELIEF_TYPE") == 'SW') {
		url = "sw/swApproveList.jsp?batchId=" + selected[0].get("BATCH_ID")
			+ "&batchDetailId=" + selected[0].get("BATCH_DETAIL_ID");
	}
	var width = 1024;
	var height = 768;
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
	if(value=="2")
		return "<font color=red>"+fillstateDs.getAt(pos).get("text")+"</font>";
	return fillstateDs.getAt(pos).get("text");
}