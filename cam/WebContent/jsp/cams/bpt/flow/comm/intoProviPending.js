function init() {
	var IntoProviDataSet = L5.DatasetMgr.lookup("IntoProviDataSet");
	IntoProviDataSet.setParameter("organCode", organCode);
	IntoProviDataSet.load();
	L5.QuickTips.init();
	hideButton("editGridPanel",[10,11,12,13],[],[2,3,4,5,8,9,10,11,12,13],[2,3,4,5,8,9,10,11,12,13]);
}
//根据区划级别隐藏按钮
function hideButton( grid,jbuts,qbuts,citybuts,sbuts){//街道,区县,市,省
	if(organType=='14'){//街道
		for(var i=0;i<jbuts.length;i++){
			L5.getCmp(grid).getTopToolbar().items.items[jbuts[i]].hide();
		}
	}else if(organType=='13'){//区县
		for(var i=0;i<qbuts.length;i++){
			L5.getCmp(grid).getTopToolbar().items.items[qbuts[i]].hide();
		}
	}else if(organType=='12'){//市
		for(var i=0;i<citybuts.length;i++){
			L5.getCmp(grid).getTopToolbar().items.items[citybuts[i]].hide();
		}
	}else if(organType=='11'){//省
		for(var i=0;i<sbuts.length;i++){
			L5.getCmp(grid).getTopToolbar().items.items[sbuts[i]].hide();
		}
	}
}
// 启用按钮
function enableButtons() {
	L5.getCmp("add_button").setDisabled(false);
	L5.getCmp("update_button").setDisabled(false);
	L5.getCmp("detail_button").setDisabled(false);
	L5.getCmp("del_button").setDisabled(false);
	L5.getCmp("submitButton").setDisabled(false);
	L5.getCmp("bthSmtBtn").setDisabled(false);

}
// 停用按钮
function disableButtons() {
	L5.getCmp("add_button").setDisabled(true);
	L5.getCmp("update_button").setDisabled(true);
	L5.getCmp("detail_button").setDisabled(true);
	L5.getCmp("del_button").setDisabled(true);
	L5.getCmp("submitButton").setDisabled(true);
	L5.getCmp("bthSmtBtn").setDisabled(true);
}
function del() {
	disableButtons();
	var editGrid = L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if (selected.length < 1) {
		L5.Msg.alert('提示', "请选择要删除的记录!");
		enableButtons();
		return false;
	}
	L5.MessageBox.confirm('确定', '确定要删除选中的记录吗?', function(state) {
		if (state == "yes") {
			var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptApplyIntoprovinceCommand");
			command.setParameter("records", selected);
			command.execute("deleteIntoprovince");
			if (!command.error) {
				for (var i = 0; i < selected.length; i++) {
					IntoProviDataSet.remove(selected[i]);
				}
				IntoProviDataSet.commitChanges();
				L5.Msg.alert('提示', "删除成功！");
			} else {
				L5.Msg.alert('提示', "删除时出现错误！" + command.error);
			}
		enableButtons();
		} else {
		enableButtons();
			return false;
		}
	});
}

function insert() {
	var url = "intoProviInsert.jsp";
	var width = screen.width - 100;
	var height = screen.height - 140;
	var returnValue = window.showModalDialog(url, window,
			"scroll:yes;status:no;dialogWidth:" + width + "px;dialogHeight:"
					+ height + "px;resizable:1");
	window.close();
	if (returnValue != undefined && returnValue != "") {
		var list = returnValue.split(";");
		var applyId = list[0];
		var peopleId = list[1];
		var familyId = list[2];
		var serviceType = list[3];
		var service_type = list[3];
		if (service_type == "15") { // 伤残跨省迁入
			url = '../disability/disabilitymigrate/ingoingprovince/intoProviUpdateManage.jsp?applyId='
					+ applyId
					+ "&peopleId="
					+ peopleId
					+ "&familyId="
					+ familyId;
		} else if (service_type == "22") { // 三属跨省迁入
			url = '../dependant/dependantmigrate/ingoingprovince/intoProviUpdateManage.jsp?applyId='
					+ applyId
					+ "&peopleId="
					+ peopleId
					+ "&familyId="
					+ familyId;
		} else if (service_type == "52") {// 参战跨省迁入
			url = '../war/migrate/ingoingprovince/intoProviUpdate.jsp?applyId='
					+ applyId + "&peopleId=" + peopleId + "&familyId="
					+ familyId;
		} else if (service_type == "62") {// 参试跨省迁入
			url = '../tested/testedmigrate/ingoingprovince/intoProviUpdateManage.jsp?applyId='
					+ applyId
					+ "&peopleId="
					+ peopleId
					+ "&familyId="
					+ familyId;
		} else if (service_type == "42") {// 在乡复员跨省迁入
			url = '../demobilized/demoingoingprovince/demobilizedUpdateManage.jsp?applyId='
					+ applyId
					+ "&peopleId="
					+ peopleId
					+ "&familyId="
					+ familyId;
		} else if (service_type == "46") {// 带病回乡跨省迁入
			url = '../demobilizedillness/illingoingmigrate/demobilizedIllnessUpdateManage.jsp?applyId='
					+ applyId
					+ "&peopleId="
					+ peopleId
					+ "&familyId="
					+ familyId;
		} else if (service_type == "B2") {// 部分烈士（错杀被平反人员）子女定补关系跨省迁入
			url = '../martyroffspring/martymigrate/ingoingprovince/mintoProviUpdateManage.jsp?applyId='
					+ applyId
					+ "&peopleId="
					+ peopleId
					+ "&familyId="
					+ familyId;
		} else if (service_type == "82") {// 年满60周岁农村籍退役士兵定补关系跨省迁入
			url = '../countretiredsoldier/soldiermigrate/ingoingprovince/sintoProviUpdateManage.jsp?applyId='
					+ applyId
					+ "&peopleId="
					+ peopleId
					+ "&familyId="
					+ familyId;
		}

		var width = screen.width - 100;
		var height = screen.height - 140;
		var returnValue = window.showModalDialog(url, window,
				"scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:"
						+ height + "px;resizable:1");
		init();
		if (returnValue == "createSend") {
			casById(applyId, peopleId, serviceType);
		} else {
			return;
		}
	}
}

function update() {
	var editGrid = L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if (selected.length != 1) {
		L5.Msg.alert('提示', "请选择一条记录修改!");
		return false;
	}
	var peopleId = selected[0].get('PEOPLE_ID');
	var applyId = selected[0].get('APPLY_ID');
	var familyId = selected[0].get("FAMILY_ID");
	var service_type = selected[0].get("SERVICE_TYPE");
	var url = "";
	if (service_type == "15") { // 伤残跨省迁入
		url = '../disability/disabilitymigrate/ingoingprovince/intoProviUpdateManage.jsp?applyId='
				+ applyId + "&peopleId=" + peopleId + "&familyId=" + familyId;
	} else if (service_type == "22") { // 三属跨省迁入
		url = '../dependant/dependantmigrate/ingoingprovince/intoProviUpdateManage.jsp?applyId='
				+ applyId + "&peopleId=" + peopleId + "&familyId=" + familyId;
	} else if (service_type == "52") {// 参战跨省迁入
		url = '../war/migrate/ingoingprovince/intoProviUpdate.jsp?applyId='
				+ applyId + "&peopleId=" + peopleId + "&familyId=" + familyId;
	} else if (service_type == "62") {// 参试跨省迁入
		url = '../tested/testedmigrate/ingoingprovince/intoProviUpdateManage.jsp?applyId='
				+ applyId + "&peopleId=" + peopleId + "&familyId=" + familyId;
	} else if (service_type == "42") {// 在乡复员跨省迁入
		url = '../demobilized/demoingoingprovince/demobilizedUpdateManage.jsp?applyId='
				+ applyId + "&peopleId=" + peopleId + "&familyId=" + familyId;
	} else if (service_type == "46") {// 带病回乡跨省迁入
		url = '../demobilizedillness/illingoingmigrate/demobilizedIllnessUpdateManage.jsp?applyId='
				+ applyId + "&peopleId=" + peopleId + "&familyId=" + familyId;
	} else if (service_type == "B2") {// 部分烈士（错杀被平反人员）子女定补关系跨省迁入
		url = '../martyroffspring/martymigrate/ingoingprovince/mintoProviUpdateManage.jsp?applyId='
				+ applyId + "&peopleId=" + peopleId + "&familyId=" + familyId;
	} else if (service_type == "82") {// 年满60周岁农村籍退役士兵定补关系跨省迁入
		url = '../countretiredsoldier/soldiermigrate/ingoingprovince/sintoProviUpdateManage.jsp?applyId='
				+ applyId + "&peopleId=" + peopleId + "&familyId=" + familyId;
	}

	var width = screen.width - 100;
	var height = screen.height - 140;
	var returnValue = window.showModalDialog(url, window,
			"scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:"
					+ height + "px;resizable:1");
	init();
	if (returnValue == "createSend") {
		createAndSend();
	} else {
		return;
	}
	// var data = new L5.Map();
	// data.put("peopleId", peopleId);
	// data.put("familyId", familyId);
	// data.put("applyId",applyId);
	// var url =
	// 'jsp/cams/bpt/flow/disability/disabilitymigrate/emigration/emigrationUpdate.jsp';
	// var text = '伤残人员抚恤关系跨省迁出信息修改';
	// L5.forward(url, text, data);
}

function detail() {
	var editGrid = L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if (selected.length != 1) {
		L5.Msg.alert('提示', "请选择一条记录查看!");
		return false;
	}
	var peopleId = selected[0].get('PEOPLE_ID');
	var applyId = selected[0].get('APPLY_ID');
	var familyId = selected[0].get("FAMILY_ID");

	var service_type = selected[0].get("SERVICE_TYPE");
	var url = "";
	if (service_type == "15") { // 伤残跨省迁入
		url = '../disability/disabilitymigrate/ingoingprovince/intoProviDetailManage.jsp?applyId='
				+ applyId + "&peopleId=" + peopleId + "&familyId=" + familyId;
	} else if (service_type == "22") { // 三属跨省迁入
		url = '../dependant/dependantmigrate/ingoingprovince/intoProviDetailManage.jsp?applyId='
				+ applyId + "&peopleId=" + peopleId + "&familyId=" + familyId;
	} else if (service_type == "52") {// 参战跨省迁入
		url = '../war/migrate/ingoingprovince/intoProviDetail.jsp?applyId='
				+ applyId + "&peopleId=" + peopleId + "&familyId=" + familyId;
	} else if (service_type == "62") {// 参试跨省迁入
		url = '../tested/testedmigrate/ingoingprovince/intoProviDetailManage.jsp?applyId='
				+ applyId + "&peopleId=" + peopleId + "&familyId=" + familyId;
	} else if (service_type == "42") {// 在乡复员跨省迁入
		url = '../demobilized/demoingoingprovince/demobilizedDetail.jsp?applyId='
				+ applyId + "&peopleId=" + peopleId + "&familyId=" + familyId;
	} else if (service_type == "46") {// 带病回乡跨省迁入
		url = '../demobilizedillness/illingoingmigrate/demobilizedIllnessDetail.jsp?applyId='
				+ applyId + "&peopleId=" + peopleId + "&familyId=" + familyId;
	} else if (service_type == "B2") {// 部分烈士（错杀被平反人员）子女定补关系跨省迁入
		url = '../martyroffspring/martymigrate/ingoingprovince/mintoProviDetailManage.jsp?applyId='
				+ applyId + "&peopleId=" + peopleId + "&familyId=" + familyId;
	} else if (service_type == "82") {// 年满60周岁农村籍退役士兵定补关系跨省迁入
		url = '../countretiredsoldier/soldiermigrate/ingoingprovince/sintoProviDetailManage.jsp?applyId='
				+ applyId + "&peopleId=" + peopleId + "&familyId=" + familyId;
	}

	var width = screen.width - 100;
	var height = screen.height - 140;
	var win = window.showModalDialog(url, window,
			"scroll:yes;status:no;dialogWidth:" + width + "px;dialogHeight:"
					+ height + "px;resizable:1");
	if (win == null) {
		return;
	}
}

// 发起单个流程
function createAndSend() {
	disableButtons();
	var editGrid = L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if (selected.length != 1) {
		L5.Msg.alert("提示", "请选择一个人员进行提交！");
		enableButtons();
		return false;
	}
	L5.getCmp("submitButton").setDisabled(true);
	var record = selected[0];
	var applyId = record.get('APPLY_ID');
	var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptApplyIntoprovinceCommand");
	command.setParameter("APPLY_ID", applyId);
	command.execute("queryApplyInfo");
	var townAduitIncharge = command.getReturn("townAduitIncharge");
	if (townAduitIncharge != null && townAduitIncharge != "1") {
		var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptApplyIntoprovinceCommand");
		command.setParameter("record", record);
		command.setParameter("contion", "pass");
		command.execute("createAndSendIntoProvince");
		if (!command.error) {
			alert("流程发起并发送成功!");
			// 跳转到已办任务页面
			var url = "jsp/cams/bpt/flow/queryyiban_bpt.jsp";
			L5.forward(url, "已办任务页面");
		} else {
			L5.getCmp("submitButton").setDisabled(false);
			alert(command.error);
		}
	} else {
		L5.getCmp("submitButton").setDisabled(false);
		L5.Msg.alert("提示", "请在修改页面保存县级审批信息!");
	}
	enableButtons();
}
// 批量发起流程
function batchSend() {
	disableButtons();
	var name;
	var editGrid = L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if (selected.length < 1) {
		L5.Msg.alert('提示', "请选择记录提交!");
		enableButtons();
		return false;
	}
	L5.getCmp("bthSmtBtn").setDisabled(true);
	for (var i = 0; i < selected.length; i++) {
		name = selected[i].get("NAME");
		var record = selected[i];
		var applyId = record.get('APPLY_ID');
		var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptApplyIntoprovinceCommand");
		command.setParameter("APPLY_ID", applyId);
		command.execute("queryApplyInfo");
		var townAduitIncharge = command.getReturn("townAduitIncharge");
		if (townAduitIncharge != null && townAduitIncharge != "1") {
			var Condition = 'pass';
			var record = selected[i];
			var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptApplyIntoprovinceCommand");
			command.setParameter("record", record);
			command.setParameter("contion", "pass");
			command.execute("createAndSendIntoProvince");
			if (!command.error) {
				if (selected.length == i + 1) {
					alert("流程批量提交成功!");
					// 跳转到已办任务页面
					var url = "jsp/cams/bpt/flow/queryyiban_bpt.jsp";
					L5.forward(url, "已办任务页面");
				}
				enableButtons();
			} else {
				L5.getCmp("bthSmtBtn").setDisabled(false);
				alert("【" + name + "】提交失败!" + command.error);
				enableButtons();
				return false;
			}
		} else {
			L5.getCmp("bthSmtBtn").setDisabled(false);
			L5.Msg.alert("提示", "请在修改页面保存【" + name + "】县级审批信息!");
			enableButtons();
			return false;
		}
	}
}

// 插入信息时直接提交
function casById(applyId, peopleId, serviceType) {
	var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptApplyIntoprovinceCommand");
	command.setParameter("APPLY_ID", applyId);
	command.execute("queryApplyInfo");
	var townAduitIncharge = command.getReturn("townAduitIncharge");
	if (townAduitIncharge != null && townAduitIncharge != "1") {
		var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptApplyIntoprovinceCommand");
		command.setParameter("applyId", applyId);
		command.setParameter("peopleId", peopleId);
		command.setParameter("serviceType", serviceType);
		command.setParameter("contion", "pass");
		command.execute("createAndSendIntoProvince");
		if (!command.error) {
			alert("流程发起并发送成功!");
			// 跳转到已办任务页面
			var url = "jsp/cams/bpt/flow/queryyiban_bpt.jsp";
			L5.forward(url, "已办任务页面");
		} else {
			alert(command.error);
		}
	} else {
		L5.Msg.alert("提示", "请在修改页面保存县级审批信息!");
	}
}