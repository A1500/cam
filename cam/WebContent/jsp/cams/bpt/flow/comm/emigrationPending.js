function init() {
	var EmigratDataSet = L5.DatasetMgr.lookup("EmigratDataSet");
	EmigratDataSet.setParameter("organCode", organCode);
	EmigratDataSet.load();
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
			var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptApplyEmigrationCommand");
			command.setParameter("records", selected);
			command.execute("deleteEmigration");
			if (!command.error) {
				for (var i = 0; i < selected.length; i++) {
					EmigratDataSet.remove(selected[i]);
				}
				EmigratDataSet.commitChanges();
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
	var url;
	url = "emigrationInsert.jsp";
	var width = screen.width - 100;
	var height = screen.height - 120;
	var returnValue = window.showModalDialog(url, window,
			"scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:"
					+ height + "px;resizable:1");
	window.close();
	if (returnValue != undefined && returnValue != "") {
		var list = returnValue.split(";");
		var applyId = list[0];
		var peopleId = list[1];
		var familyId = list[2];
		var serviceType = list[3];
		var service_type = list[3];
		var idCard = list[4];
		if (service_type == "19") { // 伤残跨省迁出
			url = '../disability/disabilitymigrate/emigration/emigrationUpdate.jsp?applyId='
					+ applyId
					+ "&peopleId="
					+ peopleId
					+ "&familyId="
					+ familyId;
		} else if (service_type == "25") { // 三属跨省迁出
			url = '../dependant/dependantmigrate/emigration/emigrationUpdateManage.jsp?applyId='
					+ applyId
					+ "&peopleId="
					+ peopleId
					+ "&familyId="
					+ familyId;
		} else if (service_type == "55") {// 参战跨省迁出
			url = '../war/migrate/emigration/emigrationUpdateManage.jsp?applyId='
					+ applyId
					+ "&peopleId="
					+ peopleId
					+ "&familyId="
					+ familyId;
		} else if (service_type == "65") {// 参试跨省迁出
			url = '../tested/testedmigrate/emigration/emigrationUpdateManage.jsp?applyId='
					+ applyId
					+ "&peopleId="
					+ peopleId
					+ "&familyId="
					+ familyId;
		} else if (service_type == "4A") {// 在乡复员跨省迁出
			url = '../demobilized/demobilizedmigrate/demomigrationUpdate.jsp?applyId='
					+ applyId
					+ "&peopleId="
					+ peopleId
					+ "&familyId="
					+ familyId;
		} else if (service_type == "4B") {// 带病回乡跨省迁出
			url = '../demobilizedillness/illmigrate/illMigrationUpdatetManage.jsp?applyId='
					+ applyId
					+ "&peopleId="
					+ peopleId
					+ "&familyId="
					+ familyId + "&idCard=" + idCard;
		} else if (service_type == "B4") {// 平反子女跨省迁出
			url = '../martyroffspring/martymigrate/emigration/martyEmigrationUpdateManage.jsp?applyId='
					+ applyId
					+ "&peopleId="
					+ peopleId
					+ "&familyId="
					+ familyId + "&idCard=" + idCard;
		} else if (service_type == "84") {// 年满60周岁农村籍退役士兵定补关系跨省迁出
			url = '../countretiredsoldier/soldiermigrate/emigration/sEmigrationUpdateManage.jsp?applyId='
					+ applyId
					+ "&peopleId="
					+ peopleId
					+ "&familyId="
					+ familyId + "&idCard=" + idCard;
		}
		var width = screen.width - 100;
		var height = screen.height - 120;
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
	var applyId = selected[0].get('APPLY_ID');
	var peopleId = selected[0].get('PEOPLE_ID');
	var familyId = selected[0].get('FAMILY_ID');
	var idCard = selected[0].get('ID_CARD');
	var service_type = selected[0].get("SERVICE_TYPE");
	var url = "";
	if (service_type == "19") { // 伤残跨省迁出
		url = '../disability/disabilitymigrate/emigration/emigrationUpdate.jsp?applyId='
				+ applyId + "&peopleId=" + peopleId + "&familyId=" + familyId;
	} else if (service_type == "25") { // 三属跨省迁出
		url = '../dependant/dependantmigrate/emigration/emigrationUpdateManage.jsp?applyId='
				+ applyId + "&peopleId=" + peopleId + "&familyId=" + familyId;
	} else if (service_type == "55") {// 参战跨省迁出
		url = '../war/migrate/emigration/emigrationUpdateManage.jsp?applyId='
				+ applyId + "&peopleId=" + peopleId + "&familyId=" + familyId;
	} else if (service_type == "65") {// 参试跨省迁出
		url = '../tested/testedmigrate/emigration/emigrationUpdateManage.jsp?applyId='
				+ applyId + "&peopleId=" + peopleId + "&familyId=" + familyId;
	} else if (service_type == "4A") {// 在乡复员跨省迁出
		url = '../demobilized/demobilizedmigrate/demomigrationUpdate.jsp?applyId='
				+ applyId + "&peopleId=" + peopleId + "&familyId=" + familyId;
	} else if (service_type == "4B") {// 带病回乡跨省迁出
		url = '../demobilizedillness/illmigrate/illMigrationUpdatetManage.jsp?applyId='
				+ applyId
				+ "&peopleId="
				+ peopleId
				+ "&familyId="
				+ familyId
				+ "&idCard=" + idCard;
	} else if (service_type == "B4") {// 平反子女跨省迁出
		url = '../martyroffspring/martymigrate/emigration/martyEmigrationUpdateManage.jsp?applyId='
				+ applyId
				+ "&peopleId="
				+ peopleId
				+ "&familyId="
				+ familyId
				+ "&idCard=" + idCard;
	} else if (service_type == "84") {// 年满60周岁农村籍退役士兵定补关系跨省迁出
		url = '../countretiredsoldier/soldiermigrate/emigration/sEmigrationUpdateManage.jsp?applyId='
				+ applyId
				+ "&peopleId="
				+ peopleId
				+ "&familyId="
				+ familyId
				+ "&idCard=" + idCard;
	}

	var width = screen.width - 100;
	var height = screen.height - 120;
	var returnValue = window.showModalDialog(url, window,
			"scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:"
					+ height + "px;resizable:1");
	init();
	if (returnValue == "createSend") {
		createAndSend();
	} else {
		return;
	}
}

function detail() {
	var editGrid = L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if (selected.length != 1) {
		L5.Msg.alert('提示', "请选择一条记录查看!");
		return false;
	}
	var applyId = selected[0].get('APPLY_ID');
	var peopleId = selected[0].get('PEOPLE_ID');
	var familyId = selected[0].get('FAMILY_ID');
	var idCard = selected[0].get('ID_CARD');
	var service_type = selected[0].get("SERVICE_TYPE");
	var url = "";
	if (service_type == "19") { // 伤残跨省迁出
		url = '../disability/disabilitymigrate/emigration/emigrationDetail.jsp?applyId='
				+ applyId + "&peopleId=" + peopleId + "&familyId=" + familyId;
	} else if (service_type == "25") { // 三属跨省迁出
		url = '../dependant/dependantmigrate/emigration/emigrationDetailManage.jsp?applyId='
				+ applyId + "&peopleId=" + peopleId + "&familyId=" + familyId;
	} else if (service_type == "55") {// 参战跨省迁出
		url = '../war/migrate/emigration/emigrationDetailManage.jsp?applyId='
				+ applyId + "&peopleId=" + peopleId + "&familyId=" + familyId;
	} else if (service_type == "65") {// 参试跨省迁出
		url = '../tested/testedmigrate/emigration/emigrationDetailManage.jsp?applyId='
				+ applyId + "&peopleId=" + peopleId + "&familyId=" + familyId;
	} else if (service_type == "4A") {// 在乡复员跨省迁出
		url = '../demobilized/demobilizedmigrate/demomigrationDetail.jsp?applyId='
				+ applyId + "&peopleId=" + peopleId + "&familyId=" + familyId;
	} else if (service_type == "4B") {// 带病回乡跨省迁出
		url = '../demobilizedillness/illmigrate/illMigrationDetailManage.jsp?applyId='
				+ applyId
				+ "&peopleId="
				+ peopleId
				+ "&familyId="
				+ familyId
				+ "&idCard=" + idCard;
	} else if (service_type == "B4") {// 平反子女跨省迁出
		url = '../martyroffspring/martymigrate/emigration/martyEmigrationDetailManage.jsp?applyId='
				+ applyId
				+ "&peopleId="
				+ peopleId
				+ "&familyId="
				+ familyId
				+ "&idCard=" + idCard;
	} else if (service_type == "84") {// 年满60周岁农村籍退役士兵定补关系跨省迁出
		url = '../countretiredsoldier/soldiermigrate/emigration/sEmigrationDetailManage.jsp?applyId='
				+ applyId
				+ "&peopleId="
				+ peopleId
				+ "&familyId="
				+ familyId
				+ "&idCard=" + idCard;
	}

	var width = screen.width - 100;
	var height = screen.height - 120;
	var win = window.showModalDialog(url, window,
			"scroll:yes;status:no;dialogWidth:" + width + "px;dialogHeight:"
					+ height + "px;resizable:1");
	if (win == null) {
		return;
	}
}
// 不予评定并结束流程
function createSendOver() {
	disableButtons();
	var Condition = 'stop';
	Send(Condition);
		enableButtons();
}
// 提交流程
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
	var DisabilityEmigrateRecord = selected[0];
	var applyId = DisabilityEmigrateRecord.get('APPLY_ID');
	var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptApplyEmigrationCommand");
	command.setParameter("APPLY_ID", applyId);
	command.execute("queryApplyInfo");
	var townAduitIncharge = command.getReturn("townAduitIncharge");
	if (townAduitIncharge != null && townAduitIncharge != "1") {
		var Condition = 'pass';
		Send(Condition);
	} else {
		L5.getCmp("submitButton").setDisabled(false);
		L5.Msg.alert("提示", "请在修改页面保存县级审批信息!");
	}
		enableButtons();
}
// 发起单个流程
function Send(Condition) {
	var editGrid = L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if (selected.length != 1) {
		L5.Msg.alert("提示", "请选择一个人员进行提交！");
		return false;
	}
	var record = selected[0];
	var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptApplyEmigrationCommand");
	command.setParameter("record", record);
	command.setParameter("Condition", Condition);
	command.execute("createAndSend");
	if (!command.error) {
		alert("流程发起并发送成功!");
		// 跳转到已办任务页面
		var url = "jsp/cams/bpt/flow/queryyiban_bpt.jsp";
		L5.forward(url, "已办任务页面");
	} else {
		L5.getCmp("submitButton").setDisabled(false);
		alert(command.error);
	}
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
		var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptApplyEmigrationCommand");
		command.setParameter("APPLY_ID", applyId);
		command.execute("queryApplyInfo");
		var townAduitIncharge = command.getReturn("townAduitIncharge");
		if (townAduitIncharge != null && townAduitIncharge != "1") {
			var Condition = 'pass';
			var record = selected[i];
			var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptApplyEmigrationCommand");
			command.setParameter("record", record);
			command.setParameter("Condition", Condition);
			command.execute("createAndSend");
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
		enableButtons();
				alert("【" + name + "】提交失败!" + command.error);
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

// 插入信息时提交
function casById(applyId, peopleId, serviceType) {
	var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptApplyEmigrationCommand");
	command.setParameter("APPLY_ID", applyId);
	command.execute("queryApplyInfo");
	var townAduitIncharge = command.getReturn("townAduitIncharge");
	if (townAduitIncharge != null && townAduitIncharge != "1") {
		var Condition = 'pass';
		SendById(Condition, applyId, peopleId, serviceType);
	} else {
		L5.Msg.alert("提示", "请在修改页面保存县级审批信息!");
	}
}
// 插入信息时提交
function SendById(Condition, applyId, peopleId, serviceType) {
	var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptApplyEmigrationCommand");
	command.setParameter("applyId", applyId);
	command.setParameter("peopleId", peopleId);
	command.setParameter("serviceType", serviceType);
	command.setParameter("Condition", Condition);
	command.execute("createAndSend");
	if (!command.error) {
		alert("流程发起并发送成功!");
		// 跳转到已办任务页面
		var url = "jsp/cams/bpt/flow/queryyiban_bpt.jsp";
		L5.forward(url, "已办任务页面");
	} else {
		alert(command.error);
	}
}