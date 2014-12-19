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
// 填报
function editReq() {
	var editGrid = L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if (selected.length != 1) {
		L5.Msg.alert('提示', "请选择一条记录!");
		return false;
	}
	//分析处理前状态
	if(selected[0].get("FILL_STATE")=="3" || selected[0].get("FILL_STATE")=="6") {
		L5.Msg.alert('提示', "已提交档案，不可填报，等待上级单位审批!");
		return false;
	}
	if(selected[0].get("FILL_STATE")=="9") {
		L5.Msg.alert('提示', "已审批完成，不可填报!");
		return false;
	}
	if(selected[0].get("FILL_STATE")=="E") {
		L5.Msg.alert('提示', "已发放，不可填报!");
		return false;
	}
	if(selected[0].get("FILL_STATE")!="0" 
		&&  selected[0].get("FILL_STATE")!="1" 
		&&　selected[0].get("FILL_STATE")!="2" 
		&&　selected[0].get("FILL_STATE")!="5") {
		L5.Msg.alert('提示', "未知状态，不能处理!");
		return false;
	}
	var url = "";
	// 分页面处理
	if (selected[0].get("RELIEF_TYPE") == 'DC') {
		url = "dc/dcList.jsp?ifFill=T&batchId=" + selected[0].get("BATCH_ID")
			+ "&batchDetailId=" + selected[0].get("BATCH_DETAIL_ID");
	}else if(selected[0].get("RELIEF_TYPE") == 'YJ') {
		url = "yj/yjList.jsp?ifFill=T&batchId=" + selected[0].get("BATCH_ID")
			+ "&batchDetailId=" + selected[0].get("BATCH_DETAIL_ID");
	}else if(selected[0].get("RELIEF_TYPE") == 'GD') {
		url = "gd/gdList.jsp?ifFill=T&batchId=" + selected[0].get("BATCH_ID")
			+ "&batchDetailId=" + selected[0].get("BATCH_DETAIL_ID");
	}else if(selected[0].get("RELIEF_TYPE") == 'CJ') {
		url = "cj/cjList.jsp?ifFill=T&batchId=" + selected[0].get("BATCH_ID")
			+ "&batchDetailId=" + selected[0].get("BATCH_DETAIL_ID");
	}else if(selected[0].get("RELIEF_TYPE") == 'SW') {
		url = "sw/swList.jsp?ifFill=T&batchId=" + selected[0].get("BATCH_ID")
			+ "&batchDetailId=" + selected[0].get("BATCH_DETAIL_ID");
	}
	var width = 1024;
	var height = 768;
	var reValue = window.showModalDialog(url, window,
			"scroll:yes;status:no;dialogWidth:" + width + "px;dialogHeight:"
					+ height + "px;resizable:1");
	query();
}
// 上报需求
function reportReq() {
	L5.Msg.wait("正在加载，请等待...", "加载数据");
	var editGrid = L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if (selected.length != 1) {
		L5.Msg.alert('提示', "请选择一条记录!");
		return false;
	}
	//分析处理前状态
	if(selected[0].get("FILL_STATE")=="0") {
		L5.Msg.alert('提示', "请先进行填报!");
		return false;
	}
	if(selected[0].get("FILL_STATE")=="3" || selected[0].get("FILL_STATE")=="6") {
		L5.Msg.alert('提示', "已提交档案，不可上报需求，等待上级单位审批!");
		return false;
	}
	if(selected[0].get("FILL_STATE")=="9") {
		L5.Msg.alert('提示', "已审批完成，不可上报需求!");
		return false;
	}
	if(selected[0].get("FILL_STATE")=="E") {
		L5.Msg.alert('提示', "已发放，不可上报需求!");
		return false;
	}
	if(selected[0].get("FILL_STATE")!="1" 
		&&　selected[0].get("FILL_STATE")!="2" 
		&&　selected[0].get("FILL_STATE")!="5") {
		L5.Msg.alert('提示', "未知状态，不能处理!");
		return false;
	}
	L5.Msg.confirm("提示", "已填报完成的信息是否上报需求？", function(isOk) {
		if (isOk == 'yes') {
			var command = new L5.Command("com.inspur.cams.dis.base.cmd.DisReliefBatchDetailCmd");
			command.setParameter("batchDetailId", selected[0].get("BATCH_DETAIL_ID"));
			command.execute("reportInfo");
			if (!command.error) {
				L5.Msg.alert('提示', '上报需求成功！', function() {
							query();
						});
			} else {
				L5.Msg.alert('提示', '上报需求出现错误！' + command.error);
			}
		}
	});
}
// 提交档案
function commitReq() {
	L5.Msg.wait("正在加载，请等待...", "加载数据");
	var editGrid = L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if (selected.length != 1) {
		L5.Msg.alert('提示', "请选择一条记录!");
		return false;
	}
	//分析处理前状态
	if(selected[0].get("FILL_STATE")=="0") {
		L5.Msg.alert('提示', "请先进行填报!");
		return false;
	}
	if(selected[0].get("FILL_STATE")=="1") {
		L5.Msg.alert('提示', "请先进行上报需求!");
		return false;
	}
	if(selected[0].get("FILL_STATE")=="3" || selected[0].get("FILL_STATE")=="6") {
		L5.Msg.alert('提示', "已提交档案，不可重复提交，等待上级单位审批!");
		return false;
	}
	if(selected[0].get("FILL_STATE")=="9") {
		L5.Msg.alert('提示', "已审批完成，不可提交档案!");
		return false;
	}
	if(selected[0].get("FILL_STATE")=="E") {
		L5.Msg.alert('提示', "已发放，不可提交档案!");
		return false;
	}
	if(selected[0].get("FILL_STATE")!="2" && selected[0].get("FILL_STATE")!="5") {
		L5.Msg.alert('提示', "未知状态，不能处理!");
		return false;
	}
	var cmd = new L5.Command("com.inspur.cams.dis.base.cmd.DisReliefBatchDetailCmd");
	cmd.setParameter("batchDetailId", selected[0].get("BATCH_DETAIL_ID"));
	cmd.execute("queryIfCommit");
	var msg = cmd.getReturn("msg");	
	if(msg!="0") {
		L5.Msg.alert('提示', "有"+msg+"条未上报信息，请先上报需求!");
		return false;
	}
	L5.Msg.confirm("提示", "是否提交档案至上级单位，提交后不可修改？", function(isOk) {
		if (isOk == 'yes') {
			var command = new L5.Command("com.inspur.cams.dis.base.cmd.DisReliefBatchDetailCmd");
			command.setParameter("batchDetailId", selected[0].get("BATCH_DETAIL_ID"));
			command.execute("commitInfo");
			if (!command.error) {
				L5.Msg.alert('提示', '提交档案成功！', function() {
							query();
						});
			} else {
				L5.Msg.alert('提示', '提交档案出现错误！' + command.error);
			}
		}
	});
}
// 查看明细
function detailReq() {
	var editGrid = L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if (selected.length != 1) {
		L5.Msg.alert('提示', "请选择一条记录!");
		return false;
	}
	var url = "";
	// 分页面处理
	if (selected[0].get("RELIEF_TYPE") == 'DC') {
		url = "dc/dcList.jsp?batchId=" + selected[0].get("BATCH_ID")
			+ "&batchDetailId=" + selected[0].get("BATCH_DETAIL_ID");
	}else if(selected[0].get("RELIEF_TYPE") == 'YJ') {
		url = "yj/yjList.jsp?batchId=" + selected[0].get("BATCH_ID")
			+ "&batchDetailId=" + selected[0].get("BATCH_DETAIL_ID");
	}else if(selected[0].get("RELIEF_TYPE") == 'GD') {
		url = "gd/gdList.jsp?batchId=" + selected[0].get("BATCH_ID")
			+ "&batchDetailId=" + selected[0].get("BATCH_DETAIL_ID");
	}else if(selected[0].get("RELIEF_TYPE") == 'CJ') {
		url = "cj/cjList.jsp?batchId=" + selected[0].get("BATCH_ID")
			+ "&batchDetailId=" + selected[0].get("BATCH_DETAIL_ID");
	}else if(selected[0].get("RELIEF_TYPE") == 'SW') {
		url = "sw/swList.jsp?batchId=" + selected[0].get("BATCH_ID")
			+ "&batchDetailId=" + selected[0].get("BATCH_DETAIL_ID");
	}
	var width = 1024;
	var height = 768;
	var reValue = window.showModalDialog(url, window,
			"scroll:yes;status:no;dialogWidth:" + width + "px;dialogHeight:"
					+ height + "px;resizable:1");
	query();
}
// 查看明细
function detailFlow() {
	var editGrid = L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if (selected.length != 1) {
		L5.Msg.alert('提示', "请选择一条记录!");
		return false;
	}
	var url = "";
	// 分页面处理
	if (selected[0].get("RELIEF_TYPE") == 'DC') {
		url = "dc/dcWorkFlow.jsp?batchId=" + selected[0].get("BATCH_ID")
			+ "&batchDetailId=" + selected[0].get("BATCH_DETAIL_ID");
	}else if(selected[0].get("RELIEF_TYPE") == 'YJ') {
		url = "yj/yjWorkFlow.jsp?batchId=" + selected[0].get("BATCH_ID")
			+ "&batchDetailId=" + selected[0].get("BATCH_DETAIL_ID");
	}else if(selected[0].get("RELIEF_TYPE") == 'GD') {
		url = "gd/gdWorkFlow.jsp?batchId=" + selected[0].get("BATCH_ID")
			+ "&batchDetailId=" + selected[0].get("BATCH_DETAIL_ID");
	}else if(selected[0].get("RELIEF_TYPE") == 'CJ') {
		url = "cj/cjWorkFlow.jsp?batchId=" + selected[0].get("BATCH_ID")
			+ "&batchDetailId=" + selected[0].get("BATCH_DETAIL_ID");
	}else if(selected[0].get("RELIEF_TYPE") == 'SW') {
		url = "sw/swWorkFlow.jsp?batchId=" + selected[0].get("BATCH_ID")
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
	if(value=="0")
		return "<font color=green>"+fillstateDs.getAt(pos).get("text")+"</font>";
	else if(value=="1")
		return "<font color=blue>"+fillstateDs.getAt(pos).get("text")+"</font>";
	else if(value=="5")
		return "<font color=red>"+fillstateDs.getAt(pos).get("text")+"</font>";
	return fillstateDs.getAt(pos).get("text");
}