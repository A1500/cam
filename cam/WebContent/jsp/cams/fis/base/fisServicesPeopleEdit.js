var dutyFlag;
function init() {
	var fisServicesOrganManageDs = L5.DatasetMgr
			.lookup("fisServicesOrganManageDs");
	fisServicesOrganManageDs.load();
	var peopleInfoDS = L5.DatasetMgr.lookup("peopleInfoDS");
	var dutyInfoDS = L5.DatasetMgr.lookup("dutyInfoDS");
	if (method == null || method == "") {
		L5.Msg.alert('提示', "未知的页面命令!");
		back();
	} else if (method == "INSERT") {
		peopleInfoDS.newRecord({
					ifCancel : "0"
				}); 
	} else if (method == "UPDATE") {
		peopleInfoDS.baseParams["PEOPLE_ID@="] = peopleId;
		dutyInfoDS.baseParams["PEOPLE_ID@="] = peopleId;
		peopleInfoDS.load();
		dutyInfoDS.load();
	} else {
		L5.Msg.alert('提示', "未知的页面命令!");
		back();
	}
	L5.QuickTips.init();
}
// 全部保存
function save() {
	// 服务机构人员信息
	var peopleInfoDS = L5.DatasetMgr.lookup("peopleInfoDS");
	var recordPeople = peopleInfoDS.getCurrent();
	// 岗位信息
	var dutyInfoDS = L5.DatasetMgr.lookup("dutyInfoDS");
	var recordDuty = dutyInfoDS.getAllRecords();

	var command = new L5.Command("com.inspur.cams.fis.base.cmd.FisServicesPeopleInfoCmd");
	command.setParameter("recordPeople", recordPeople);
	command.setParameter("recordDuty", recordDuty);

	if (method == "INSERT") {
		command.execute("insert");
	} else if (method == "UPDATE") {
		if (recordPeople.length < 1) {
			L5.Msg.alert('提示', '没有需要保存的数据!');
			return false;
		} else {
			command.execute("update");
		}
	}
	if (!command.error) {
		L5.Msg.alert('提示', "保存成功!");
	} else {
		L5.Msg.alert('提示', "保存时出现错误！" + command.error);
	}
}

// 全部取消
function back() {
	history.go(-1);
}

// 服务机构人员岗位信息：岗位添加
function insertWin() {
	var dutyInfoWinDS = L5.DatasetMgr.lookup("dutyInfoWinDS");
	dutyInfoWinDS.newRecord();
	var detail = L5.getCmp("detail");
	dutyFlag = "insert";
	detail.show();
}

// 服务机构人员岗位信息：岗位修改
function updateWin() {

	if (L5.getCmp("editGridPanel").getSelectionModel().getSelections().length != 1) {
		L5.Msg.alert("提示", "请选中一条记录！");
		return;
	}
	var dutyInfoWinDS = L5.DatasetMgr.lookup("dutyInfoWinDS");
	dutyInfoWinDS.removeAll();
	dutyInfoWinDS.add(L5.getCmp("editGridPanel").getSelectionModel()
			.getSelections()[0]);

	dutyFlag = "update";
	var detail = L5.getCmp("detail");
	detail.show();
}

// 服务机构人员岗位信息：保存
function saveWin() {

	var dutyInfoDS = L5.DatasetMgr.lookup("dutyInfoDS");
	var dutyInfoWinDS = L5.DatasetMgr.lookup("dutyInfoWinDS");
	if (dutyFlag == "insert") {
		var record = dutyInfoWinDS.getCurrent();
		dutyInfoDS.add(record);
		dutyInfoWinDS.removeAll();
	} else if (dutyFlag == "update") {
		var selected = L5.getCmp("editGridPanel").getSelectionModel()
				.getSelections();
		dutyInfoDS.remove(selected[0]);
		var record = dutyInfoWinDS.getCurrent();
		dutyInfoDS.add(record);
	}
	closeWin();
}

// 服务机构人员岗位信息：岗位删除
function deteleWin() {
	var editGrid = L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if (selected.length != 1) {
		L5.Msg.alert('提示', "请选择一条记录修改!");
		return false;
	}
	var dutyInfoDS = L5.DatasetMgr.lookup("dutyInfoDS");
	L5.MessageBox.confirm("提示", "你确定要删除该记录！", function(sta) {
				if (sta == "yes") {
					var delIds = [];
					dutyInfoDS.remove(selected[0]);
				}
			});
}

// 服务机构人员岗位信息：关闭
function closeWin() {
	var win = L5.getCmp('detail');
	win.hide();
}