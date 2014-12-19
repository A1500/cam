function init() {
	var BaseinfoPeopleDataSet = L5.DatasetMgr.lookup("BaseinfoPeopleDataSet");
	BaseinfoPeopleDataSet.setParameter("organCode", organCode);
	BaseinfoPeopleDataSet.load();
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
			var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptPeopleTestedCommand");
			command.setParameter("record", selected);
			command.setParameter("warOrTest", "test");
			command.execute("deleteWarOrTest");
			if (!command.error) {
				for (var i = 0; i < selected.length; i++) {
					BaseinfoPeopleDataSet.remove(selected[i]);
				}
				BaseinfoPeopleDataSet.commitChanges();
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
	var width = screen.width - 100;
	var height = screen.height - 140;
	var url = L5.webPath + '/jsp/cams/bpt/flow/tested/bpttestedAdd.jsp';
	var returnValue = window.showModalDialog(url, window,
			"scroll:yes;status:no;dialogWidth:" + width + "px;dialogHeight:"
					+ height + "px;resizable:1");
	if (returnValue != "" & returnValue != undefined) {
		var list = returnValue.split(";");
		var peopleId = list[0];
		var familyId = list[1];
		var applyId = list[2];
		var url2 = "bpttested_edit.jsp?familyId=" + familyId + "&peopleId="
				+ peopleId + "&applyId=" + applyId;
		var win = window.showModalDialog(url2, window,
				"scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:"
						+ height + "px;resizable:1");
		init();
		if (win == null) {
			return;
		} else if (win == "createSend") {
			sureById(applyId);
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
	var familyId = selected[0].get('FAMILY_ID');
	var peopleId = selected[0].get('PEOPLE_ID');
	var applyId = selected[0].get('APPLY_ID');
	var url = L5.webPath
			+ '/jsp/cams/bpt/flow/tested/bpttested_edit.jsp?peopleId='
			+ peopleId + '&familyId=' + familyId + '&applyId=' + applyId;
	var width = screen.width - 100;
	var height = screen.height - 140;
	var win = window.showModalDialog(url, window,
			"scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:"
					+ height + "px;resizable:1");
	init();
	if (win == "createSend") {
		sure();
	} else {
		return;
	}
}

function detailTested() {
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
	var url = 'bpttestedDetailMain.jsp?familyId=' + familyId + '&peopleId='
			+ peopleId + '&applyId=' + applyId;
	var win = window.showModalDialog(url, window,
			"scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:"
					+ height + "px;resizable:1");
	if (win == null) {
		return;
	}
}
function sure() {// 认定人员信息
	disableButtons();
	var editGrid = L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if (selected.length != 1) {
		L5.Msg.alert('提示', "请选择一条记录修改!");
		enableButtons();
		return false;
	}
	L5.getCmp("submitButton").setDisabled(true);
	var applyId = selected[0].get('APPLY_ID');
	var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptApplyDependantCommand");
	command.setParameter("applyId", applyId);
	command.execute("isSave");
	var save = command.getReturn("save");
	if (save) {
		var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptPeopleWarCommand");
		command.setParameter("applyId", applyId);
		command.execute("sureWar");
		if (!command.error) {
			L5.Msg.alert('提示', '认定成功！');
			var BaseinfoPeopleDataSet = L5.DatasetMgr
					.lookup("BaseinfoPeopleDataSet");
			BaseinfoPeopleDataSet.setParameter("organCode", organCode);
			BaseinfoPeopleDataSet.load();
		} else {
			L5.Msg.alert('提示', "认定时出现错误！" + command.error);
		}
	} else {
		L5.Msg.alert('提示', '请在修改页面填写申请审批表！');
	}
	L5.getCmp("submitButton").setDisabled(false);
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
		var applyId = selected[i].get("APPLY_ID");
		name = selected[i].get("NAME");
		var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptApplyDependantCommand");
		command.setParameter("applyId", applyId);
		command.execute("isSave");
		var save = command.getReturn("save");
		if (save) {
			var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptPeopleWarCommand");
			command.setParameter("applyId", applyId);
			command.execute("sureWar");
			if (!command.error) {
				if (selected.length == (i + 1)) {
					L5.Msg.alert('提示', '批量认定成功！');
				}
				var DisabilityPeopleDataSet = L5.DatasetMgr
						.lookup("BaseinfoPeopleDataSet");
				DisabilityPeopleDataSet.setParameter("organCode", organCode);
				DisabilityPeopleDataSet.load();
				L5.getCmp("bthSmtBtn").setDisabled(false);
		enableButtons();
			} else {
				L5.getCmp("bthSmtBtn").setDisabled(false);
				L5.Msg.alert('提示', "【" + name + "】认定时出现错误！" + command.error);
		enableButtons();
				return false;
			}
		} else {
			L5.getCmp("bthSmtBtn").setDisabled(false);
			L5.Msg.alert('提示', '请在修改页面填写【' + name + '】申请审批表！');
		enableButtons();
			return false;
		}
	}
}
/*
 * function createAndSend() { var editGrid = L5.getCmp("editGridPanel"); var
 * selected = editGrid.getSelectionModel().getSelections(); if(selected.length !=
 * 1) { L5.Msg.alert("提示","请选择一个人员进行提交！"); return false; } var record =
 * selected[0]; var applyId = record.get("APPLY_ID"); var peopleId =
 * record.get("PEOPLE_ID"); var command = new
 * L5.Command("com.inspur.cams.bpt.manage.cmd.BptPeopleTestedCommand");
 * command.setParameter("applyId",applyId);
 * command.setParameter("peopleId",peopleId); command.execute("createAndSend");
 * if(!command.error){ alert("流程发起并发送成功!"); //跳转到已办任务页面 var url =
 * "jsp/workflow/tasklist/queryyiban.jsp"; L5.forward(url,"已办任务页面"); }else {
 * alert(command.error); } }
 */
// 插入信息时直接提交
function sureById(applyId) {// 认定人员信息
	var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptApplyDependantCommand");
	command.setParameter("applyId", applyId);
	command.execute("isSave");
	var save = command.getReturn("save");
	if (save) {
		var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptPeopleWarCommand");
		command.setParameter("applyId", applyId);
		command.execute("sureWar");
		if (!command.error) {
			L5.Msg.alert('提示', '认定成功！');
			var BaseinfoPeopleDataSet = L5.DatasetMgr
					.lookup("BaseinfoPeopleDataSet");
			BaseinfoPeopleDataSet.setParameter("organCode", organCode);
			BaseinfoPeopleDataSet.load();
		} else {
			L5.Msg.alert('提示', "认定时出现错误！" + command.error);
		}
	} else {
		L5.Msg.alert('提示', '请在修改页面填写申请审批表！');
	}
}