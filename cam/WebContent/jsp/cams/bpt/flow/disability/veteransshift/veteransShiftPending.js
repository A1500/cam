function init() {
	var DisabilityPeopleDataSet = L5.DatasetMgr
			.lookup("DisabilityPeopleDataSet");
	DisabilityPeopleDataSet.setParameter("organCode", organCode);
	DisabilityPeopleDataSet.setParameter("serviceType", '14');
	DisabilityPeopleDataSet.load();
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
			var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptApplyDisabilityCommand");
			command.setParameter("records", selected);
			command.setParameter("disType", "veterans");
			command.execute("deleteAboutDisability");
			if (!command.error) {
				for (var i = 0; i < selected.length; i++) {
					DisabilityPeopleDataSet.remove(selected[i]);
				}
				DisabilityPeopleDataSet.commitChanges();
				enableButtons();
			} else {
				L5.Msg.alert('提示', "删除时出现错误！" + command.error);
				enableButtons();
			}
		} else {
			enableButtons();
			return false;
		}
	});
}
function insert() {
	// var url =
	// "jsp/cams/bpt/flow/disability/veteransshift/veteransShiftInsert.jsp?method='INSERT'";
	// var text = '添加部队退役残疾军人抚恤关系迁移人员信息';
	// L5.forward(url, text);
	var url = 'veteransShiftInsert.jsp?method=INSERT';
	var width = screen.width - 100;
	var height = screen.height - 140;
	var returnValue = window.showModalDialog(url, window,
			"scroll:yes;status:no;dialogWidth:" + width + "px;dialogHeight:"
					+ height + "px;resizable:1");
	if (returnValue != "" & returnValue != undefined) {
		var list = returnValue.split(";");
		var peopleId = list[0];
		var familyId = list[1];
		var applyId = list[2];

		var url2 = "veteransShiftUpdate.jsp?familyId=" + familyId
				+ "&peopleId=" + peopleId + '&applyId=' + applyId;;
		var win = window.showModalDialog(url2, window,
				"scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:"
						+ height + "px;resizable:1");
		init();
		if (win == null) {
			return;
		} else if (win == "createSend") {
			casById(applyId, peopleId);
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
	var familyId = selected[0].get('FAMILY_ID');
	var applyId = selected[0].get('APPLY_ID');
	var width = screen.width - 100;
	var height = screen.height - 140;
	var url = 'veteransShiftUpdate.jsp?familyId=' + familyId + '&peopleId='
			+ peopleId + '&applyId=' + applyId;
	var win = window.showModalDialog(url, window,
			"scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:"
					+ height + "px;resizable:1");
	init();
	if (win == "createSend") {
		createAndSend();
	} else {
		return;
	}
	// var data = new L5.Map();
	// data.put("peopleId", peopleId);
	// data.put("familyId", familyId);
	// data.put("applyId",applyId);
	// var url =
	// 'jsp/cams/bpt/flow/disability/veteransshift/veteransShiftUpdate.jsp';
	// var text = '部队退役残疾军人抚恤关系迁移信息修改';
	// L5.forward(url, text, data);
}

function detail() {
	var editGrid = L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if (selected.length != 1) {
		L5.Msg.alert('提示', "请选择一条记录查看!");
		return false;
	}

	var familyId = selected[0].get('FAMILY_ID');
	var peopleId = selected[0].get('PEOPLE_ID');
	var applyId = selected[0].get('APPLY_ID');

	var width = screen.width - 100;
	var height = screen.height - 140;
	var url = 'veteransShiftDetail.jsp?familyId=' + familyId + '&peopleId='
			+ peopleId + '&applyId=' + applyId;
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
	var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptApplyDisabilityCommand");
	command.setParameter("APPLY_ID", applyId);
	command.execute("queryApplyInfo");
	var townAduitIncharge = command.getReturn("townAduitIncharge");
	var townFlag = command.getReturn("townFlag");
	var townReport = command.getReturn("townReport");
	if (townAduitIncharge != null && townAduitIncharge != "1") {
		if (townFlag == '0') { // 同意审批
			operation("pass");
		} else if (townFlag == '1') { // 不予认定
			if (townReport == '1') { // 上报
				operation("pass");
			} else if (townReport == '0') { // 不上报
				var commandValidate = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptDecisionLetterCommand");
				commandValidate.setParameter("applyId", applyId);
				commandValidate.execute("ifHave");
				operation("end");
			}
		}
		enableButtons();
	} else {
		L5.getCmp("submitButton").setDisabled(false);
		L5.Msg.alert("提示", "请在修改页面保存县级审批信息!");
		enableButtons();
	}
}

function operation(value) {
	var editGrid = L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if (selected.length != 1) {
		L5.Msg.alert("提示", "请选择一个人员进行提交！");
		enableButtons();
		return false;
	}
	var DisabilityPeopleRecord = selected[0];
	var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptApplyDisabilityCommand");
	command.setParameter("record", DisabilityPeopleRecord);
	command.setParameter("condition", value);
	command.execute("createAndSend");
	if (!command.error) {
		alert("流程发起并发送成功!");
		// 跳转到已办任务页面
		var url = "";
		if (value == "pass") {
			url = "jsp/cams/bpt/flow/queryyiban_bpt.jsp";
		} else if (value == "end") {
			url = "jsp/cams/bpt/flow/queryend_bpt.jsp";
		}
		L5.forward(url, "已办任务页面");
	} else {
		alert(command.error);
	}
}

function end() {
	operation("end");
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
		var applyId = selected[i].get("APPLY_ID");
		name = selected[i].get("NAME");
		var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptApplyDisabilityCommand");
		command.setParameter("APPLY_ID", applyId);
		command.execute("queryApplyInfo");
		DisabilityPeopleRecord = selected[i];
		var townAduitIncharge = command.getReturn("townAduitIncharge");
		var townFlag = command.getReturn("townFlag");
		var townReport = command.getReturn("townReport");
		if (townAduitIncharge != null && townAduitIncharge != "1") {
			if (townFlag == '0') { // 同意审批
				var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptApplyDisabilityCommand");
				command.setParameter("record", DisabilityPeopleRecord);
				command.setParameter("condition", "pass");
				command.execute("createAndSend");
				if (command.error) {
					L5.getCmp("bthSmtBtn").setDisabled(false);
					alert("【" + name + "】提交失败！");
					enableButtons();
					return false;
				}
				enableButtons();
			} else if (townFlag == '1') { // 不予认定
				if (townReport == '1') { // 上报
					var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptApplyDisabilityCommand");
					command.setParameter("record", DisabilityPeopleRecord);
					command.setParameter("condition", "pass");
					command.execute("createAndSend");
					if (command.error) {
						L5.getCmp("bthSmtBtn").setDisabled(false);
						alert("【" + name + "】提交失败！");
						enableButtons();
						return false;
					}
					enableButtons();
				} else if (townReport == '0') { // 不上报
					var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptApplyDisabilityCommand");
					command.setParameter("record", DisabilityPeopleRecord);
					command.setParameter("condition", "end");
					command.execute("createAndSend");
					enableButtons();
					if (command.error) {
						L5.getCmp("bthSmtBtn").setDisabled(false);
						alert("【" + name + "】提交失败！");
						enableButtons();
						return false;
					}
				}
			}
			if (selected.length == i + 1) {
				alert("批量提交成功！")
				var url = "jsp/cams/bpt/flow/queryyiban_bpt.jsp";
				L5.forward(url, "已办任务页面");
			}
		} else {
			L5.getCmp("bthSmtBtn").setDisabled(false);
			L5.Msg.alert("提示", "请在修改页面保存【" + name + "】县级审批信息!");
			enableButtons();
			return false;
		}
	}
}

// 发起单个流程
function casById(applyId, peopleId) {
	disableButtons();
	var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptApplyDisabilityCommand");
	command.setParameter("APPLY_ID", applyId);
	command.execute("queryApplyInfo");
	var townAduitIncharge = command.getReturn("townAduitIncharge");
	var townFlag = command.getReturn("townFlag");
	var townReport = command.getReturn("townReport");
	if (townAduitIncharge != null && townAduitIncharge != "1") {
		if (townFlag == '0') { // 同意审批
			operationById("pass", applyId, peopleId);
		} else if (townFlag == '1') { // 不予认定
			if (townReport == '1') { // 上报
				operationById("pass", applyId, peopleId);
			} else if (townReport == '0') { // 不上报
				var commandValidate = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptDecisionLetterCommand");
				commandValidate.setParameter("applyId", applyId);
				commandValidate.execute("ifHave");
				operationById("end", applyId, peopleId);
			}
		}
		enableButtons();
	} else {
		L5.Msg.alert("提示", "请在修改页面保存县级审批信息!");
		enableButtons();
	}
}

function operationById(value, applyId, peopleId) {

	var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptApplyDisabilityCommand");
	command.setParameter("condition", value);
	command.setParameter("peopleId", peopleId);
	command.setParameter("applyId", applyId);
	command.setParameter("serviceType", "14");
	command.execute("createAndSend");
	if (!command.error) {
		alert("流程发起并发送成功!");
		// 跳转到已办任务页面
		var url = "";
		if (value == "pass") {
			url = "jsp/cams/bpt/flow/queryyiban_bpt.jsp";
		} else if (value == "end") {
			url = "jsp/cams/bpt/flow/queryend_bpt.jsp";
		}
		L5.forward(url, "已办任务页面");
	} else {
		alert(command.error);
	}
}