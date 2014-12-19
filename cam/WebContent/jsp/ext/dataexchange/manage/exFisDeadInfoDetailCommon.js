// 查看逝者信息
function getDeadInfo(applyId, deadId) {
	if (deadId == "" || deadId == undefined) {
		L5.Msg.alert("提示", "没有逝者信息！");
		return;
	}
	if (applyId == "" || applyId == undefined) {
		L5.Msg.alert("提示", "没有逝者信息！");
		return;
	}
	var url = "jsp/cams/fis/comm/fisDeadInfoDetail.jsp?applyId=" + applyId + "&deadId="
			+ deadId;
	var win = window
			.showModalDialog(url, window,
					"dialogHeight:768px;dialogWidth:1024px;resizable:no;scroll:yes;status:no;");
}

// 查看逝者信息
function getFisDeadInfo(deadId) {
	if (deadId == "" || deadId == undefined) {
		L5.Msg.alert("提示", "没有逝者信息！");
		return;
	}
	var url = "jsp/cams/fis/comm/fisDeadInfoComm.jsp?deadId=" + deadId;
	var win = window
			.showModalDialog(url, window,
					"dialogHeight:768px;dialogWidth:1024px;resizable:no;scroll:yes;status:no;");
}