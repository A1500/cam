function init() {
	var IntoProvinceDataSet = L5.DatasetMgr.lookup("IntoProvinceDataSet");
	IntoProvinceDataSet.setParameter("organCode", organCode);
	IntoProvinceDataSet.load();
	L5.QuickTips.init();
}

function insert() {
//	var url = "jsp/cams/bpt/flow/disability/disabilitymigrate/ingoingprovince/intoProviInsert.jsp";
//	var text = '添加外省残疾人员抚恤关系迁入我省人员信息';
//	var data = new L5.Map();
//	data.put("method","INSERT");
//	L5.forward(url, text,data);
	var url="intoProviInsert.jsp?method=INSERT";
	var width = screen.width-100;
    var height = screen.height-140;
 	var returnValue = window.showModalDialog(url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
	init()
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
	var url='intoProviUpdateManage.jsp?familyId=' + familyId + '&peopleId=' + peopleId + '&applyId=' + applyId;
	var width = screen.width-100;
    var height = screen.height-140;
    var returnValue = window.showModalDialog(url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
	init()
//	var data = new L5.Map();
//	data.put("peopleId", peopleId);
//	data.put("familyId", familyId);
//	data.put("applyId",applyId);
//	var url = 'jsp/cams/bpt/flow/disability/disabilitymigrate/ingoingprovince/intoProviUpdateManage.jsp';
//	var text = '修改外省残疾人员抚恤关系迁入我省信息修改';
//	L5.forward(url, text, data);
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
	
	var width = screen.width-100;
    var height = screen.height-140;
	var url = 'intoProviDetailManage.jsp?familyId=' + familyId + '&peopleId='
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

	var editGrid = L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if (selected.length != 1) {
		L5.Msg.alert("提示", "请选择一条记录发起流程！");
		return false;
	}
	var DisabilityIntoProvinceRecord = selected[0];
	
	var applyId= DisabilityIntoProvinceRecord.get('APPLY_ID');
	
	var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptApplyIntoprovinceCommand");
	command.setParameter("APPLY_ID",applyId);
	command.execute("queryApplyInfo");
	var townAduitIncharge=command.getReturn("townAduitIncharge");
	if(townAduitIncharge!=null&&townAduitIncharge!="1"){
		var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptApplyIntoprovinceCommand");
		command.setParameter("record", DisabilityIntoProvinceRecord);
		command.execute("createAndSendIntoProvince");
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