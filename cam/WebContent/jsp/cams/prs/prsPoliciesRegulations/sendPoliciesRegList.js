
/**
 * 页面初始化操作
 */
function init() {
	var policRegDS = L5.DatasetMgr.lookup("policRegDS");
	policRegDS.setParameter("releaseCompany", organArea);
	policRegDS.setParameter("flag", "send");
	policRegDS.load();
}

/**
 * 事件处理：点击增加按钮
 */
function click_add() {
	window.location = "addPoliciesReg.jsp";
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
	window.location = "viewPoliciesReg.jsp?queryId=" + queryId + "&page=send";
}

/**
 * 事件处理：点击删除按钮
 */
function click_delete() {
	var gridPanel = L5.getCmp('gridPanel');
	var selected = gridPanel.getSelectionModel().getSelections();
	if (selected.length == 0) {
		L5.Msg.alert('提示', "请选择一条或多条记录！");
		return false;
	}
	if(selected[0].get("RELEASE_COMPANY")!=organArea){
		L5.Msg.alert('提示', "不是本单位下发的法规，不能删除！");
		return false;
	}
	L5.MessageBox.confirm('提示', '确认执行删除操作吗?该操作不能恢复！', function(state) {
		if (state == "yes") {
			var policRegDS = L5.DatasetMgr.lookup("policRegDS");
			var delIds=[];
			for (var i = 0; i < selected.length; i++) {
				delIds[i]=selected[i].get("POLICIES_REGULATIONS_ID");
				policRegDS.remove(selected[i]);
			}
			// 构造Command对象,并将修改的record数组作为参数,并执行
			var command = new L5.Command("com.inspur.cams.prs.prspoliciesregulations.cmd.PrsPoliciesRegulationsCmd");
			command.setParameter("delIds", delIds);
			command.execute("batchDelete");
			// 如果执行没有错误,dataset接受所有修改,否则弹出错误信息：
			if (!command.error) {
				policRegDS.commitChanges();
				L5.Msg.alert('提示', '删除成功！');
			} else {
				L5.Msg.alert('提示', '删除出错：'+command.error);
			}
			
	 		policRegDS.reload();
		} else {
			return false;
		}
	});
}

/**
 * 事件处理：点击查询按钮
 */
var win;// 查询窗口对象
function click_query() {
	win = L5.getCmp("organize");
	win.setPosition(300,50);
	// 显示查询窗口,动画效果，从点击处弹出
	win.show();
}
function query() {
	var policRegDS = L5.DatasetMgr.lookup("policRegDS");
	policRegDS.setParameter("flag", "send");
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

