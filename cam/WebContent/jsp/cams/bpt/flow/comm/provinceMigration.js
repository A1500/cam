var width = screen.width - 100;
var height = screen.height - 120;
function init() {
	var ProvinceEmigratDataSet = L5.DatasetMgr.lookup("ProvinceEmigratDataSet");
	ProvinceEmigratDataSet.setParameter("organCode", organCode);
	ProvinceEmigratDataSet.load();
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
			var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptProvinceMigrateCommand");
			command.setParameter("records", selected);
			command.execute("deleteProvinceMigrate");
			if (!command.error) {
				for (var i = 0; i < selected.length; i++) {
					ProvinceEmigratDataSet.remove(selected[i]);
				}
				ProvinceEmigratDataSet.commitChanges();
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
	url = "provinceMigrationInsert.jsp";
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
		if (service_type == "23") { // 三属省内迁移
			url = '../dependant/dependantmigrate/provincemigration/provinceUpdateManage.jsp?applyId='
					+ applyId
					+ "&peopleId="
					+ peopleId
					+ "&familyId="
					+ familyId;
		} else if (service_type == "53") {// 参战省内迁移
			url = '../war/migrate/provincialmigration/provinceUpdateManage.jsp?applyId='
					+ applyId
					+ "&peopleId="
					+ peopleId
					+ "&familyId="
					+ familyId;
		} else if (service_type == "63") {// 参试省内迁移
			url = '../tested/testedmigrate/provincemigration/provinceUpdateManage.jsp?applyId='
					+ applyId
					+ "&peopleId="
					+ peopleId
					+ "&familyId="
					+ familyId;
		} else if (service_type == "43") {// 在乡复员省内迁移
			url = '../demobilized/demoprovincemigrate/demoProvinceMigrationUpdate.jsp?applyId='
					+ applyId
					+ "&peopleId="
					+ peopleId
					+ "&familyId="
					+ familyId;
		} else if (service_type == "47") {// 带病回乡省内迁移
			url = '../demobilizedillness/illprovincemigrate/illprovinceMigrationUpdatetManage.jsp?applyId='
					+ applyId
					+ "&peopleId="
					+ peopleId
					+ "&familyId="
					+ familyId;
		} else if (service_type == "16") {// 伤残省内迁移
			url = '../disability/disabilitymigrate/provincemigration/provinceMigrationUpdate.jsp?applyId='
					+ applyId
					+ "&peopleId="
					+ peopleId
					+ "&familyId="
					+ familyId;
		} else if (service_type == "B3") {// 平反省内迁移
			url = '../martyroffspring/martymigrate/provincemigration/mprovinceUpdateManage.jsp?applyId='
					+ applyId
					+ "&peopleId="
					+ peopleId
					+ "&familyId="
					+ familyId;
		} else if (service_type == "83") {// 部分烈士（错杀被平反人员）子女定补关系省内迁移信息
			url = '../countretiredsoldier/soldiermigrate/provincemigration/sprovinceUpdateManage.jsp?applyId='
					+ applyId
					+ "&peopleId="
					+ peopleId
					+ "&familyId="
					+ familyId;
		}
		var getReturnValue = window.showModalDialog(url, window,
				"scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:"
						+ height + "px;resizable:1");
		init();
		if (getReturnValue == "createSend") {
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
	var familyId = selected[0].get("FAMILY_ID");
	var service_type = selected[0].get("SERVICE_TYPE");
	var url = "";
	if (service_type == "23") { // 三属省内迁移
		url = '../dependant/dependantmigrate/provincemigration/provinceUpdateManage.jsp?applyId='
				+ applyId + "&peopleId=" + peopleId + "&familyId=" + familyId;
	} else if (service_type == "53") {// 参战省内迁移
		url = '../war/migrate/provincialmigration/provinceUpdateManage.jsp?applyId='
				+ applyId + "&peopleId=" + peopleId + "&familyId=" + familyId;
	} else if (service_type == "63") {// 参试省内迁移
		url = '../tested/testedmigrate/provincemigration/provinceUpdateManage.jsp?applyId='
				+ applyId + "&peopleId=" + peopleId + "&familyId=" + familyId;
	} else if (service_type == "43") {// 在乡复员省内迁移
		url = '../demobilized/demoprovincemigrate/demoProvinceMigrationUpdate.jsp?applyId='
				+ applyId + "&peopleId=" + peopleId + "&familyId=" + familyId;
	} else if (service_type == "47") {// 带病回乡省内迁移
		url = '../demobilizedillness/illprovincemigrate/illprovinceMigrationUpdatetManage.jsp?applyId='
				+ applyId + "&peopleId=" + peopleId + "&familyId=" + familyId;
	} else if (service_type == "16") {// 伤残省内迁移
		url = '../disability/disabilitymigrate/provincemigration/provinceMigrationUpdate.jsp?applyId='
				+ applyId + "&peopleId=" + peopleId + "&familyId=" + familyId;
	} else if (service_type == "B3") {// 部分烈士（错杀被平反人员）子女定补关系省内迁移信息
		url = '../martyroffspring/martymigrate/provincemigration/mprovinceUpdateManage.jsp?applyId='
				+ applyId + "&peopleId=" + peopleId + "&familyId=" + familyId;
	} else if (service_type == "83") {// 60岁退役士兵
		url = '../countretiredsoldier/soldiermigrate/provincemigration/sprovinceUpdateManage.jsp?applyId='
				+ applyId + "&peopleId=" + peopleId + "&familyId=" + familyId;
	}
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
	var familyId = selected[0].get("FAMILY_ID");
	var service_type = selected[0].get("SERVICE_TYPE");
	var url = "";
	if (service_type == "23") { // 三属省内迁移
		url = '../dependant/dependantmigrate/provincemigration/provinceDetailManage.jsp?applyId='
				+ applyId + "&peopleId=" + peopleId + "&familyId=" + familyId;
	} else if (service_type == "53") {// 参战省内迁移
		url = '../war/migrate/provincialmigration/provinceDetailManage.jsp?applyId='
				+ applyId + "&peopleId=" + peopleId + "&familyId=" + familyId;
	} else if (service_type == "63") {// 参试省内迁移
		url = '../tested/testedmigrate/provincemigration/provinceDetailManage.jsp?applyId='
				+ applyId + "&peopleId=" + peopleId + "&familyId=" + familyId;
	} else if (service_type == "43") {// 在乡复员省内迁移
		url = '../demobilized/demoprovincemigrate/demoProvinceMigrationDetail.jsp?applyId='
				+ applyId + "&peopleId=" + peopleId + "&familyId=" + familyId;
	} else if (service_type == "47") {// 带病回乡省内迁移
		url = '../demobilizedillness/illprovincemigrate/illprovinceMigrationDetailManage.jsp?applyId='
				+ applyId + "&peopleId=" + peopleId + "&familyId=" + familyId;
	} else if (service_type == "16") {// 伤残省内迁移
		url = '../disability/disabilitymigrate/provincemigration/provinceMigrationDetail.jsp?applyId='
				+ applyId + "&peopleId=" + peopleId + "&familyId=" + familyId;
	} else if (service_type == "B3") {// 平反省内迁移
		url = '../martyroffspring/martymigrate/provincemigration/mprovinceDetailManage.jsp?applyId='
				+ applyId + "&peopleId=" + peopleId + "&familyId=" + familyId;
	} else if (service_type == "83") {// 部分烈士（错杀被平反人员）子女定补关系省内迁移信息
		url = '../countretiredsoldier/soldiermigrate/provincemigration/sprovinceDetailManage.jsp?applyId='
				+ applyId + "&peopleId=" + peopleId + "&familyId=" + familyId;
	}
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
	var DisabilityEmigrateRecord = selected[0];
	var applyId = DisabilityEmigrateRecord.get('APPLY_ID');
	var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptProvinceMigrateCommand");
	command.setParameter("APPLY_ID", applyId);
	command.execute("queryApplyInfo");
	var townAduitIncharge = command.getReturn("outTownAduitIncharge");
	if (townAduitIncharge != null && townAduitIncharge != "1") {
		var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptProvinceMigrateCommand");
		command.setParameter("record", DisabilityEmigrateRecord);
		command.setParameter("Condition", "pass");
		command.execute("createAndSend");
		if (!command.error) {
			alert("流程提交成功!");
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
		var DisabilityEmigrateRecord = selected[i];
		var applyId = DisabilityEmigrateRecord.get('APPLY_ID');
		var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptProvinceMigrateCommand");
		command.setParameter("APPLY_ID", applyId);
		command.execute("queryApplyInfo");
		var townAduitIncharge = command.getReturn("outTownAduitIncharge");
		if (townAduitIncharge != null && townAduitIncharge != "1") {
			var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptProvinceMigrateCommand");
			command.setParameter("record", DisabilityEmigrateRecord);
			command.setParameter("Condition", "pass");
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
	var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptProvinceMigrateCommand");
	command.setParameter("APPLY_ID", applyId);
	command.execute("queryApplyInfo");
	var townAduitIncharge = command.getReturn("outTownAduitIncharge");
	if (townAduitIncharge != null && townAduitIncharge != "1") {
		var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptProvinceMigrateCommand");
		command.setParameter("Condition", "pass");
		command.setParameter("applyId", applyId);
		command.setParameter("peopleId", peopleId);
		command.setParameter("serviceType", serviceType);
		command.execute("createAndSend");
		if (!command.error) {
			alert("流程提交成功!");
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
