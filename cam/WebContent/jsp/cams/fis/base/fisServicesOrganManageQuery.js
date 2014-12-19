var userInfo;
function init() {
	userInfo = initArea();
	document.getElementById("manaLevelId").value = userInfo.cantCode;
	document.getElementById("manaLevel").value = userInfo.cantName;
	ds.on("load", function(ds) {
				var qrToolbar = L5.getCmp("qrToolbar");
				if (ds.getTotalCount() == 0) {
					qrToolbar.setText("查询结果");
				} else {
					qrToolbar.setText("查询结果(" + ds.getTotalCount() + "条)");
				}
			});
	query();
};

function resetQuery() {
	document.getElementById("manaLevelId").value = userInfo.cantCode;
	document.getElementById("manaLevel").value = userInfo.cantName;
	document.getElementById("areaLevelId").value = "";
	document.getElementById("areaLevel").value = "";
	document.getElementById("queryUnitId").value = "";
	document.getElementById("queryUnitName").value = "";
	document.getElementById("qProperties").value = "";
	document.getElementById("qTitle").value = "";
	document.getElementById("qOrganizer").value = "";
}

// 查询
function query() {
	var manaId = getParam("manaLevelId");
	if (manaId.substring(2) == "0000000000") {
		ds.setParameter("PARENT_ORGAN_CODE@rlike@String", manaId
						.substring(0, 2));
	} else if (manaId.substring(4) == "00000000") {
		ds.setParameter("PARENT_ORGAN_CODE@rlike@String", manaId
						.substring(0, 4));
	} else {
		ds.setParameter("PARENT_ORGAN_CODE@rlike@String", manaId
						.substring(0, 6));
	}

	var areaLevelId = getParam("areaLevelId");
	if (areaLevelId == undefined) {
		ds.setParameter("AREA_CODE@rlike@String", undefined);
	} else if (areaLevelId.substring(2) == "0000000000") {
		ds.setParameter("AREA_CODE@rlike@String", areaLevelId.substring(0, 2));
	} else if (areaLevelId.substring(4) == "00000000") {
		ds.setParameter("AREA_CODE@rlike@String", areaLevelId.substring(0, 4));
	} else {
		ds.setParameter("AREA_CODE@rlike@String", areaLevelId.substring(0, 6));
	}

	ds.setParameter("UNIT_ID@like@String", getParam("queryUnitId"));
	ds.setParameter("PROPERTIES@=@String", getParam("qProperties"));
	ds.setParameter("TITLE@=@String", getParam("qTitle"));
	var qOrganizer = getParam("qOrganizer");
	ds.setParameter("ORGANIZER@=@String", qOrganizer);
	ds.load();
}
// 导出excel
function excel_click() {
	var ds = L5.DatasetMgr.lookup("ds");
	if (ds.getTotalCount() == 0) {
		// L5.Msg.alert("消息","无可导出数据！");
		return;
	}
	// L5.dataset2excel(ds,
	// "/jsp/cams/fis/base/funeralOrganUserDetailListExcel.jsp");
}
// 明细
function detail() {
	var editGridPanel = L5.getCmp("editGridPanel");
	var selectedRecord = editGridPanel.getSelectionModel().getSelected();
	if (!selectedRecord) {
		L5.Msg.alert("提示", "请先选择一条记录");
		return false;
	}
	showDetails(selectedRecord.get("recordId"), selectedRecord.get("unitId"));
}

function showDetailsRendener(value, cellmeta, record, rowindex, colindex,
		dataset) {
	return '<a href="javascript:showDetails(\'' + record.data["recordId"]
			+ '\',\'' + record.data["unitId"] + '\')">' + value + '</a>';
}

function showDetails(recordId, unitId) {
	var url = L5.webPath+"/jsp/cams/fis/base/fisServicesOrganManageDetail.jsp?method=detail&recordId="+recordId;
	window.showModalDialog(url,window,"scroll:yes;status:no;dialogWidth:1024px;dialogHeight:768px;resizable:1");
}