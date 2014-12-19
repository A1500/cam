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
//	disReliefDoleDs.setParameter("IN_CONFIRM", "1");
	disReliefDoleDs.load();
}
function back() {
	window.close();
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