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
	batchDetailds.setParameter("requiredOrganCode",getParam("requiredOrganCode"));
	batchDetailds.setParameter("reliefType", getParam("reliefType"));
	batchDetailds.setParameter("fillState", getParam("fillState"));
	batchDetailds.load();
}
// 审核
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
// 审批
function approveReq() {
	var editGrid = L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if (selected.length != 1) {
		L5.Msg.alert('提示', "请选择一条记录!");
		return false;
	}
	//分析处理前状态
	if(selected[0].get("FILL_STATE")=="0") {
		L5.Msg.alert('提示', "未填报，不可审批!");
		return false;
	}
	if(selected[0].get("FILL_STATE")=="1"|| 
		selected[0].get("FILL_STATE")=="2") {
		L5.Msg.alert('提示', "未提交不可审批，等待下级单位提交!");
		return false;
	}
	if(selected[0].get("FILL_STATE")=="5") {
		L5.Msg.alert('提示', "已驳回，不可重复审批!");
		return false;
	}
	if(selected[0].get("FILL_STATE")=="9") {
		L5.Msg.alert('提示', "已审批完成，不可重复审批!");
		return false;
	}
	if(selected[0].get("FILL_STATE")=="E") {
		L5.Msg.alert('提示', "已发放，不可审批!");
		return false;
	}
	if(selected[0].get("FILL_STATE")!="3" 
		&&　selected[0].get("FILL_STATE")!="6") {
		L5.Msg.alert('提示', "未知状态，不能处理!");
		return false;
	}
	var url = "";
	// 分页面处理
	if (selected[0].get("RELIEF_TYPE") == 'DC') {
		url = "dc/dcApproveList.jsp?ifApprove=T&batchId=" + selected[0].get("BATCH_ID")
			+ "&batchDetailId=" + selected[0].get("BATCH_DETAIL_ID");
	}else if(selected[0].get("RELIEF_TYPE") == 'YJ') {
		url = "yj/yjApproveList.jsp?ifApprove=T&batchId=" + selected[0].get("BATCH_ID")
			+ "&batchDetailId=" + selected[0].get("BATCH_DETAIL_ID");
	}else if(selected[0].get("RELIEF_TYPE") == 'GD') {
		url = "gd/gdApproveList.jsp?ifApprove=T&batchId=" + selected[0].get("BATCH_ID")
			+ "&batchDetailId=" + selected[0].get("BATCH_DETAIL_ID");
	}else if(selected[0].get("RELIEF_TYPE") == 'CJ') {
		url = "cj/cjApproveList.jsp?ifApprove=T&batchId=" + selected[0].get("BATCH_ID")
			+ "&batchDetailId=" + selected[0].get("BATCH_DETAIL_ID");
	}else if(selected[0].get("RELIEF_TYPE") == 'SW') {
		url = "sw/swApproveList.jsp?ifApprove=T&batchId=" + selected[0].get("BATCH_ID")
			+ "&batchDetailId=" + selected[0].get("BATCH_DETAIL_ID");
	}
	var width = 1024;
	var height = 768;
	var reValue = window.showModalDialog(url, window,
			"scroll:yes;status:no;dialogWidth:" + width + "px;dialogHeight:"
					+ height + "px;resizable:1");
	query();
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