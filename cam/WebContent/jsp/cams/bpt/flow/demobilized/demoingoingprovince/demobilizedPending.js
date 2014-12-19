function init() {
	var DemobilizedPeopleDataSet = L5.DatasetMgr
			.lookup("DemobilizedPeopleDataSet");
	DemobilizedPeopleDataSet.load();
	L5.QuickTips.init();
}

function insert() {
	var url = "jsp/cams/bpt/demobilized/demobilizedList.jsp";
	var text = '添加在乡复员军人信息';
	L5.forward(url, text);
}

function update() {
}

function createAndSend() {

	var editGrid = L5.getCmp('editGridPanel');

	var selected = editGrid.getSelectionModel().getSelections();

	if (selected.length != 1) {
		L5.Msg.alert("提示", "请选择一个人员进行提交！");
		return false;
	}

	var DemobilizedPeopleRecord = selected[0];

	var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.");

	command.setParameter("record", DemobilizedPeopleRecord);
	command.execute("createAndSend");
	if (!command.error) {
		alert("流程发起并发送成功!");
		// 跳转到已办任务页面
		var url = "jsp/workflow/tasklist/queryyiban.jsp";
		L5.forward(url, "已办任务页面");
	} else {
		alert(command.error);
	}
}
