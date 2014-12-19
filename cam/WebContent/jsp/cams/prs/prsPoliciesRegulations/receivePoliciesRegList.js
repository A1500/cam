
/**
 * 页面初始化操作
 */
function init() {
	var policRegDS = L5.DatasetMgr.lookup("policRegDS");
	policRegDS.setParameter("flag", "receive");
	policRegDS.setParameter("releaseCompany", organArea);
	policRegDS.load();
}

/**
 * 事件处理：查看明细
 */
function click_view() {
	var GridPanelOne = L5.getCmp('gridPanel');
	var selected = GridPanelOne.getSelectionModel().getSelections();
	if (selected.length != 1) {
		L5.Msg.alert('提示', "请选择一条记录！");
		return false;
	}
	var queryId = selected[0].get('POLICIES_REGULATIONS_ID');
	window.location = "viewPoliciesReg.jsp?queryId=" + queryId + "&page=receive";
}

function query() {
	var policRegDS = L5.DatasetMgr.lookup("policRegDS");
	policRegDS.setParameter("flag", "receive");
	policRegDS.setParameter("releaseCompany", organArea);
	policRegDS.setParameter("titlequery",document.getElementById("titlequery").value);
	policRegDS.setParameter("fileNum",document.getElementById("fileNum").value);
	policRegDS.setParameter("yearly",document.getElementById("yearly").value);
	policRegDS.setParameter("sendDateBegin",document.getElementById("sendDateBegin").value);
	policRegDS.setParameter("sendDateEnd",document.getElementById("sendDateEnd").value);
	policRegDS.setParameter("releaseCompany", organArea);
	policRegDS.load();
}
function undoit() {
	win = L5.getCmp("organize");
	win.hide();
}

