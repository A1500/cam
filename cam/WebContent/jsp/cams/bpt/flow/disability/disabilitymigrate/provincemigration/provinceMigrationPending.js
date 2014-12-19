function init() {
	var ProvinceMigratDataSet = L5.DatasetMgr.lookup("ProvinceMigratDataSet");
	ProvinceMigratDataSet.setParameter("organCode", organCode);
	ProvinceMigratDataSet.load();
	L5.QuickTips.init();
}

function insert() {
 	var url = "provinceMigrationInsert.jsp";
//	var text = '添加伤残人员省内迁移信息';
//	L5.forward(url, text);
	var width = screen.width-100;
    var height = screen.height-140;
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
	var width = screen.width-100;
    var height = screen.height-140;
	var peopleId = selected[0].get('PEOPLE_ID');
	var familyId = selected[0].get('FAMILY_ID');
	var applyId = selected[0].get('APPLY_ID');
//	var data = new L5.Map();
//	data.put("peopleId", peopleId);
//	data.put("familyId", familyId);
//	data.put("applyId",applyId);
//	var url = 'jsp/cams/bpt/flow/disability/disabilitymigrate/provincemigration/provinceMigrationUpdate.jsp';
//	var text = '伤残人员省内迁移信息修改';
//	L5.forward(url, text, data);
	var url = "provinceMigrationUpdate.jsp?peopleId="+peopleId+"&familyId="+familyId+"&applyId="+applyId;
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
	var width = screen.width-100;
    var height = screen.height-140;
	var familyId = selected[0].get('FAMILY_ID');
	var peopleId = selected[0].get('PEOPLE_ID');
	var applyId = selected[0].get('APPLY_ID');
	var url = 'provinceMigrationDetail.jsp?familyId=' + familyId + '&peopleId='+ peopleId + '&applyId=' + applyId;
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
	
	var applyId= DisabilityEmigrateRecord.get('APPLY_ID');
	
	var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptProvinceMigrateCommand");
	command.setParameter("APPLY_ID",applyId);
	command.execute("queryApplyInfo");
	var townAduitIncharge=command.getReturn("outTownAduitIncharge");
	if(townAduitIncharge!=null&&townAduitIncharge!="1"){
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
	}else{
		L5.Msg.alert("提示","请在修改页面保存县级审批信息!");
	}
}

// 批量发起流程
function batchSend() {

}