function init() {
	document.getElementById("requiredOrganCode").value = organCode;
	document.getElementById("requiredOrganName").value = organName;
	L5.QuickTips.init();
	query();
};
function getParam(ElementId) {
	var value = document.getElementById(ElementId).value;
	if (value == "")
		value = undefined;
	return value;
}
function query() {
	batchds.setParameter("BATCH_NAME@like", getParam("batchName"));
	batchds.setParameter("RELIEF_TYPE@=", getParam("reliefType"));
	batchds.setParameter("YEAR@=", getParam("year"));
	batchds.setParameter("CREATE_ORGAN_CODE@=", getParam("requiredOrganCode"));
	batchds.setParameter("GRANT_TYPE@=", getParam("grantType"));
	batchds.setParameter("ALLOCATION_TYPE@=", getParam("allocationType"));
	batchds.load();
}
function resetClick() {
	document.getElementById("requiredOrganCode").value = organCode;
	document.getElementById("requiredOrganName").value = organName;
	document.getElementById("reliefType").value = '';
	document.getElementById("year").value = nowYear;
	document.getElementById("batchName").value = '';
	document.getElementById("grantType").value = '';
	document.getElementById("allocationType").value = '';
}
function insert() {
	/*L5.Msg.alert('提示', "现为补录阶段，请到【救助任务补录（县级）】进行补录!");
	return false;*/
	var url = "batch_info_insert.jsp";
	var revalue = window.showModalDialog(url, window,
			"scroll:yes;status:no;dialogWidth:800px;dialogHeight:600px;resizable:0");
	if (revalue == "-1") {
		L5.Msg.alert('提示', "保存成功!");
		query();
	}
}
function update() {
	/*L5.Msg.alert('提示', "现为补录阶段，请到【救助任务补录（县级）】进行补录!");
	return false;*/
	var editGrid = L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if (selected.length != 1) {
		L5.Msg.alert('提示', "请选择一条记录!");
		return false;
	}
	var url = "batch_info_edit.jsp?batchId=" + selected[0].get("batchId");
	var revalue = window.showModalDialog(url, window,
			"scroll:yes;status:no;dialogWidth:800px;dialogHeight:600px;resizable:0");
	if (revalue == "-1") {
		query();
	}
}
function detail() {
	var editGrid = L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if (selected.length != 1) {
		L5.Msg.alert('提示', "请选择一条记录!");
		return false;
	}
	var url = "batch_info_detail.jsp?batchId=" + selected[0].get("batchId");
	window.showModalDialog(url, window,
					"scroll:yes;status:no;dialogWidth:800px;dialogHeight:600px;resizable:0");
}
function del() {
	/*L5.Msg.alert('提示', "现为补录阶段，请到【救助任务补录（县级）】进行补录!");
	return false;*/
	var editGrid = L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if (selected.length != 1) {
		L5.Msg.alert('提示', "请选择要删除的记录!");
		return false;
	}
	L5.MessageBox.confirm('确定', '确定要删除选中的记录吗?', function(state) {
		if (state == "yes") {
			var command = new L5.Command("com.inspur.cams.dis.base.cmd.DisReliefBatchCmd");
			command.setParameter("batchId", selected[0].get("batchId"));
			command.execute("batchDelete");
			if (!command.error) {
				if (command.getReturn("info") == '') {
					for (var i = 0; i < selected.length; i++) {
						batchds.remove(selected[i]);
					}
					batchds.commitChanges();
				} else {
					L5.Msg.alert('提示', command.getReturn("info") + "已经填报，不能删除！");
				}
			} else {
				L5.Msg.alert('提示', "保存时出现错误！" + command.error);
			}
		} else {
			return false;
		}
	});
}
function forOrganSelect() {
	var revalue = window.showModalDialog(
			"../comm/dicCity.jsp?organCode=" + organCode
					+ "&organName=" + escape(encodeURIComponent(organName))
					+ "&level=3", "",
			"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		if(revalue=="qingchu"){
			document.getElementById("requiredOrganName").value = organName;
			document.getElementById("requiredOrganCode").value = organCode;
		}else {
			var list = revalue.split(";");
			document.getElementById("requiredOrganName").value = list[4];
			document.getElementById("requiredOrganCode").value = list[0];
		}
	}
}
function batchRenderer(value, cellmeta, record, rowindex, colindex,dataset){
	 if(record.get("ifOld")){
		 return value+"<font color=red>"+"（历史补录信息）"+"</font>";
	 }else{
		 return value;
	 }
}