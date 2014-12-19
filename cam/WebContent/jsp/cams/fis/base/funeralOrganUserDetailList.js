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
	document.getElementById("qProperties").value = "";
	document.getElementById("qTitle").value = "";
	document.getElementById("qDemonUnit").value = "";
	document.getElementById("qGrade").value = "";
	document.getElementById("qGestionTimeFrom").value = "";
	document.getElementById("qGestionTimeTo").value = "";
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
	if(getParam("qManaGrade")=='1'){
		ds.setParameter("UNIT_ID@like","00-");
	}else if(getParam("qManaGrade")=='0'){
		ds.setParameter("SUBSTR(PARENT_ORGAN_CODE,5,2)@<>","00");
	}
	ds.setParameter("UNIT_ID@like@String", getParam("queryUnitId"));
	ds.setParameter("PROPERTIES@=@String", getParam("qProperties"));
	ds.setParameter("TITLE@=@String", getParam("qTitle"));
	ds.setParameter("DEMON_UNIT@=@String", getParam("qDemonUnit"));
	ds.setParameter("GRADE@=@String", getParam("qGrade"));
	var qGestionTimeFrom = getParam("qGestionTimeFrom");
	var qGestionTimeTo = getParam("qGestionTimeTo");
	if (qGestionTimeFrom && qGestionTimeTo) {
		ds.setParameter("GESTION_TIME@>=@String", qGestionTimeFrom);
		ds.setParameter("GESTION_TIME@<=@String", qGestionTimeTo);
	} else {
		ds.setParameter("GESTION_TIME@>=@String", undefined);
		ds.setParameter("GESTION_TIME@<=@String", undefined);
	}
	ds.load();
}
// 导出excel
function excel_click() {
	var ds = L5.DatasetMgr.lookup("ds");
	if (ds.getTotalCount() == 0) {
		// L5.Msg.alert("消息","无可导出数据！");
		return;
	}
	L5.dataset2excel(ds,
			"/jsp/cams/fis/base/funeralOrganUserDetailListExcel.jsp");
}
// 明细
function detail() {
	var editGridPanel = L5.getCmp("editGridPanel");
	var selectedRecord = editGridPanel.getSelectionModel().getSelected();
	if (!selectedRecord) {
		L5.Msg.alert("提示", "请先选择一条记录");
	}
	
	var organCode = selectedRecord.get("organCode");
	var unitId = selectedRecord.get("unitId");
	showDetails(unitId,organCode);
}

function showDetailsRendener(value, cellmeta, record, rowindex, colindex,
		dataset) {
	return '<a href="javascript:showDetails(\'' + record.data["unitId"]
			+ '\',\'' + record.data["organCode"] + '\')">' + value + '</a>';
}

function showDetails(unitId, code) {
//	var data = new L5.Map();
//	data.put("method", 'detail');
//	data.put("unitId", unitId);
//	data.put("organCode", code);
//	var url = 'jsp/cams/fis/base/funeralOrganUserDetail.jsp';
//	var text = '殡仪馆信息';
//	L5.forward(url, text, data);
	
	var url = "funeralOrganUserDetail.jsp?method=detail&unitId="+unitId+"&organCode="+code;
	window.showModalDialog(url,window,"scroll:yes;status:no;dialogWidth:1024px;dialogHeight:768px;resizable:1");
}
