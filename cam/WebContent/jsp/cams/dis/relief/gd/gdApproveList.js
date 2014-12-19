var tDate = L5.server.getSysDate();
function init() {
	if(ifApprove!="T") {
		document.getElementById("btnAgree").style.display = 'none';
		document.getElementById("btnBack").style.display = 'none';
	}
}
//审批同意
function agree() {
	var win = L5.getCmp("approveWin");
	win.show();
	document.getElementById("checkDate").value = formatDateToString(tDate);
	document.getElementById("checkOption").value = "同意";
	document.getElementById("btnConfirmBack").style.display = 'none';
	document.getElementById("btnConfirmAgree").style.display = '';
}
//审批驳回
function reject() {
	var win = L5.getCmp("approveWin");
	win.show();
	
	document.getElementById("checkDate").value = formatDateToString(tDate);
	document.getElementById("checkOption").value = "";
	document.getElementById("btnConfirmAgree").style.display = 'none';
	document.getElementById("btnConfirmBack").style.display = '';
}
//关闭
function back() {
	window.close();
}
//审批同意
function confirmAgree(){
	L5.Msg.wait("正在加载，请等待...", "加载数据");
	confirm("A");
}
//审批驳回
function confirmBack(){
	L5.Msg.wait("正在加载，请等待...", "加载数据");
	confirm("B");
}
function confirm(flag) {
	if(!getParam("checkDate")) {
		L5.Msg.alert('提示', '请输入审批日期！');
		return false;
	}
	if(!getParam("checkOption")) {
		L5.Msg.alert('提示', '请输入审批意见！');
		return false;
	}
	var command = new L5.Command("com.inspur.cams.dis.base.cmd.DisReliefBatchDetailCmd");
	command.setParameter("batchDetailId", batchDetailId);
	command.setParameter("checkDate", getParam("checkDate"));
	command.setParameter("checkOption", getParam("checkOption"));
	if (flag == "A")
		command.execute("approveAgree");
	else if (flag == "B")
		command.execute("approveBack");
	if (!command.error) {
		L5.Msg.alert('提示', '审批完成！', function() {
					back();
				});
	} else {
		L5.Msg.alert('提示', '审批时出现错误！' + command.error);
	}
}

