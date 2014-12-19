function init() {
	var TestedIngoProvinceDataSet = L5.DatasetMgr.lookup("TestedIngoProvinceDataSet");
	TestedIngoProvinceDataSet.setParameter("organCode", organCode);
	TestedIngoProvinceDataSet.load();
	L5.QuickTips.init();
}

 
function insert() {
	var url="intoProviInsert.jsp";
	var width = screen.width-100;
    var height = screen.height-140;
 	var returnValue = window.showModalDialog(url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
	init();
//	var url = "jsp/cams/bpt/flow/disability/disabilitymigrate/emigration/emigrationInsert.jsp";
//	var text = '添加伤残人员抚恤关系跨省迁出信息';
//	L5.forward(url, text);
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
	
	var url='intoProviUpdateManage.jsp?applyId=' + applyId + '&peopleId=' + peopleId + '&familyId=' + familyId;
	var width = screen.width-100;
    var height = screen.height-140;
 	var returnValue = window.showModalDialog(url,window,"scroll:no;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
	init()
//	var data = new L5.Map();
//	data.put("peopleId", peopleId);
//	data.put("familyId", familyId);
//	data.put("applyId",applyId);
//	var url = 'jsp/cams/bpt/flow/disability/disabilitymigrate/emigration/emigrationUpdate.jsp';
//	var text = '伤残人员抚恤关系跨省迁出信息修改';
//	L5.forward(url, text, data);
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
	var width = screen.width-100;
    var height = screen.height-140;  
	var url = 'intoProviDetailManage.jsp?applyId=' + applyId +'&peopleId=' + peopleId + '&familyId=' + familyId;
	var win = window.showModalDialog(url, window,"scroll:yes;status:no;dialogWidth:" + width + "px;dialogHeight:"+ height + "px;resizable:1");
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
	var record = selected[0];
	var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptApplyIntoprovinceCommand");
	command.setParameter("record", record);
	command.execute("createAndSendIntoProvince");
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