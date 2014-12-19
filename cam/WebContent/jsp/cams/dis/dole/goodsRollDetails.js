var NDate = L5.server.getSysDate();
function init() {
	var mainFrame = document.getElementById("mainFrame");
	if (reliefType == "DC") {
		mainFrame.src = "../relief/dc/dcApproveSumListTop.jsp?batchId=" + batchId
				+ "&batchDetailId=" + batchDetailId;
	} else if (reliefType == "SW") {
		mainFrame.src = "../relief/sw/swApproveSumListTop.jsp?batchId=" + batchId
				+ "&batchDetailId=" + batchDetailId;
	} else if (reliefType == "GD") {
		mainFrame.src = "../relief/gd/gdApproveSumListTop.jsp?batchId=" + batchId
				+ "&batchDetailId=" + batchDetailId;
	} else if (reliefType == "YJ") {
		mainFrame.src = "../relief/yj/yjApproveSumListTop.jsp?batchId=" + batchId
				+ "&batchDetailId=" + batchDetailId;
	} else if (reliefType == "CJ") {
		mainFrame.src = "../relief/cj/cjApproveSumListTop.jsp?batchId=" + batchId
				+ "&batchDetailId=" + batchDetailId;
	}
	
	query();
}
function query() {
	disReliefDoleDs.setParameter("BATCH_DETAIL_ID", batchDetailId);
	disReliefDoleDs.load();
}
function back() {
	window.close();
}
// 新增
function addInfo() {
	if(reliefType=="SW"){
		L5.Msg.alert('提示', "遇难人员家属抚慰不能进行物资发放!");
		return false;
	}
	if(reliefType=="CJ"){
		L5.Msg.alert('提示', "灾区民房恢复重建不能进行物资发放!");
		return false;
	}
	// 先判断是否存在未确认的发放,存在则提示
	// ...
	var url = "";
	var width = 1024;
	var height = 768;
	url = "dc/dcDoleGoodsRollList.jsp?batchId=" + batchId + "&batchDetailId="
			+ batchDetailId;
	var reValue = window.showModalDialog(url, window,
			"scroll:yes;status:no;dialogWidth:" + width + "px;dialogHeight:"
					+ height + "px;resizable:1");
	query();
}
// 修改
function editInfo() {
	var editGrid = L5.getCmp('doleGrid');
	var selected = editGrid.getSelectionModel().getSelections();
	if (selected.length != 1) {
		L5.Msg.alert('提示', "请选择一条记录!");
		return false;
	}
	if(selected[0].get("doleType")=="1") {
		L5.Msg.alert('提示', "请选择一条物资发放记录进行修改!");
		return false;
	}
	if(reliefType=="SW"){
		L5.Msg.alert('提示', "遇难人员家属抚慰不能进行物资发放!");
		return false;
	}
	if(reliefType=="CJ"){
		L5.Msg.alert('提示', "灾区民房恢复重建不能进行物资发放!");
		return false;
	}
	//先判断是否已确认
	var cmd = new L5.Command("com.inspur.cams.dis.base.cmd.DisReliefInfoCmd");
	cmd.setParameter("doleId", selected[0].get("doleId"));
	cmd.execute("queryIfConfirmDole");
	var msg = cmd.getReturn("msg");	
	if(msg!=null) {
		L5.Msg.alert('提示', "选中流水已确认，不可修改!");
		return false;
	}
	
	var url = "";
	var width = 1024;
	var height = 768;
	url = "dc/dcDoleGoodsRollList.jsp?batchId=" + batchId + "&batchDetailId="
			+ batchDetailId + "&doleId=" + selected[0].get("doleId");
	var reValue = window.showModalDialog(url, window,
			"scroll:yes;status:no;dialogWidth:" + width + "px;dialogHeight:"
					+ height + "px;resizable:1");
	
	query();
}
// 删除
function deleteInfo() {
	var editGrid = L5.getCmp('doleGrid');
	var selected = editGrid.getSelectionModel().getSelections();
	if (selected.length != 1) {
		L5.Msg.alert('提示', "请选择一条记录!");
		return false;
	}
	if(selected[0].get("doleType")=="1") {
		L5.Msg.alert('提示', "请选择一条物资发放记录进行删除!");
		return false;
	}
	//先判断是否已确认
	var cmd = new L5.Command("com.inspur.cams.dis.base.cmd.DisReliefInfoCmd");
	cmd.setParameter("doleId", selected[0].get("doleId"));
	cmd.execute("queryIfConfirmDole");
	var msg = cmd.getReturn("msg");	
	if(msg!=null) {
		L5.Msg.alert('提示', "选中流水已确认，不可删除!");
		return false;
	}
	//撤销
	L5.MessageBox.confirm('确定', '确定要删除选中的记录吗?', function(state) {
		if (state == "yes") {
			var command = new L5.Command("com.inspur.cams.dis.base.cmd.DisReliefDoleCmd");
			command.setParameter("doleId", selected[0].get("doleId"));
			command.execute("deleteReq");
			if (!command.error) {
				L5.Msg.alert('提示', "删除成功！", function(){
					query();
				});
			} else {
				L5.Msg.alert('提示', "删除时出现错误！" + command.error);
			}
		} else {
			return false;
		}
	});
}
// 明细
function detailInfo() {
	var editGrid = L5.getCmp('doleGrid');
	var selected = editGrid.getSelectionModel().getSelections();
	if (selected.length != 1) {
		L5.Msg.alert('提示', "请选择一条记录!");
		return false;
	}
	
	var url = "";
	var width = 1024;
	var height = 768;
	if(selected[0].get("doleType")=="1") {
		if (reliefType == 'DC'||reliefType == 'YJ'||reliefType == 'GD'||reliefType == 'SW') {
			url = "dc/dcDoleRollList.jsp?batchId=" + batchId + "&batchDetailId="
					+ batchDetailId + "&doleId=" + selected[0].get("doleId")+"&ifDetail=T";
		} else if (reliefType == 'CJ') {
			url = "cj/cjDoleRollList.jsp?batchId=" + batchId + "&batchDetailId="
					+ batchDetailId + "&doleId=" + selected[0].get("doleId")+"&ifDetail=T";
		}
	}else if(selected[0].get("doleType")=="2") {
		//物资明细页面
		url = "dc/dcDoleGoodsRollList.jsp?batchId=" + batchId + "&batchDetailId="
				+ batchDetailId + "&doleId=" + selected[0].get("doleId")+"&ifDetail=T";
	}
	var reValue = window.showModalDialog(url, window,
			"scroll:yes;status:no;dialogWidth:" + width + "px;dialogHeight:"
					+ height + "px;resizable:1");
}

// 渲染发放类型
function doleTypeRenderer(value, cellmeta, record, rowindex, colindex,
		dataset) {
	var pos = doleTypeDS.find("value", value, 0);
	if (pos != -1) {
		var rec = doleTypeDS.getAt(pos);
		if(value=="2") {
			if(record.get("inConfirm")=="0")
				return "<font color=red>"+rec.get("text")+"</font>";
			else
				return rec.get("text");
		}else {
			return "<font color=green>"+rec.get("text")+"</font>";
		}
	}
	return "";
}