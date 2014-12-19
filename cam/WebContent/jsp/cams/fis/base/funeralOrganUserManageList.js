var userInfo;
function init() {
	userInfo = initArea();
	ds.on("load", function(ds) {
				var qrToolbar = L5.getCmp("qrToolbar");
				if (ds.getTotalCount() == 0) {
					// L5.Msg.alert("提示", "无符合条件的结果！");
					qrToolbar.setText("查询结果");
				} else {
					qrToolbar.setText("查询结果(" + ds.getTotalCount() + "条)");
				}
			});
	if(orgCode.substring(2)== "0000000000"){
		L5.getCmp("editFuneral").show();
	}else{
		L5.getCmp("editFuneral").hide();
	}
	query();
};

// 查询
function query() {
	var manaId = userInfo.cantCode;
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

	ds.setParameter("UNIT_ID@like@String", getParam("queryUnitId"));
	ds.setParameter("UNIT_NAME@like@String", getParam("queryUnitName"));
	ds.load();
}

function resetQuery() {
	document.getElementById("queryUnitId").value = "";
	document.getElementById("queryUnitName").value = "";
}

// 新增
function addFuneral() {
	var method = 'insert';
	var url = 'jsp/cams/fis/base/funeralOrganUserManage.jsp';
	var map = new L5.Map();
	map.put("method", method);
	L5.forward(url, '', map);
}

// 修改
function updateFuneral() {
	var editGridPanel = L5.getCmp("editGridPanel");
	var selectedRecord = editGridPanel.getSelectionModel().getSelected();
	if (!selectedRecord) {
		L5.Msg.alert("提示", "请先选择一条记录");
	}
	var method = 'update';
	var organCode = selectedRecord.get("organCode");
	var url = 'jsp/cams/fis/base/funeralOrganUserManage.jsp';
	var map = new L5.Map();
	map.put("method", method);
	map.put("organCode", organCode);
	L5.forward(url, '', map);

}

// 导出excel
function excel_click() {
	var ds = L5.DatasetMgr.lookup("ds");
	if (ds.getTotalCount() == 0) {
		// L5.Msg.alert("消息","无可导出数据！");
		return;
	}
	L5.dataset2excel(ds,
			"/jsp/cams/fis/base/funeralOrganUserManageListExcel.jsp");
}

// 渲染-明细功能
function showDetailsRendener(value, cellmeta, record, rowindex, colindex,
		dataset) {
	return '<a href="javascript:showDetails(\'' + record.data["unitId"]
			+ '\',\'' + record.data["organCode"] + '\')">' + value + '</a>';
}

// 进入明细页面
function showDetails(unitId, code) {
//	var data = new L5.Map();
//	data.put("method", 'detail');
//	data.put("organCode", code);
//	data.put("unitId", unitId);
//	var url = 'jsp/cams/fis/base/funeralOrganUserDetail.jsp';
//	var text = '殡仪馆信息';
//	L5.forward(url, text, data);
	
	var url = "funeralOrganUserDetail.jsp?method=detail&unitId="+unitId+"&organCode="+code;
	window.showModalDialog(url,window,"scroll:yes;status:no;dialogWidth:1024px;dialogHeight:768px;resizable:1");
}
