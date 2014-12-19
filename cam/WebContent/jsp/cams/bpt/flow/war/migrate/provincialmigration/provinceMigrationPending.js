var width = screen.width-100;;
var height = screen.height-120;
function init() {
	var ProvinceMigratDataSet = L5.DatasetMgr.lookup("ProvinceMigratDataSet");
	ProvinceMigratDataSet.setParameter("organCode", organCode);
	ProvinceMigratDataSet.load();
	L5.QuickTips.init();
}

function insert() {
 	var url = "provinceMigrationInsert.jsp";
 	window.showModalDialog(url,window,"scroll:no;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
	init();
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
	
	var url = "provinceUpdateManage.jsp?peopleId="+peopleId+"&familyId="+familyId+"&applyId="+applyId;
 	window.showModalDialog(url,window,"scroll:no;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
	init();
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
	
	var url = 'provinceDetailManage.jsp?familyId=' + familyId + '&peopleId='+ peopleId + '&applyId=' + applyId;
	var win = window.showModalDialog(url, window,"scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:"+ height + "px;resizable:1");
	if (win == null) {
		return;
	}
}

// 发起单个流程
function createAndSend() {

	var editGrid = L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if (selected.length != 1) {
		L5.Msg.alert("提示", "请选择一个人员进行提交！");
		return false;
	}
	var DisabilityEmigrateRecord = selected[0];
	var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptProvinceMigrateCommand");
	command.setParameter("record", DisabilityEmigrateRecord);
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

// 批量发起流程
function batchSend() {

}