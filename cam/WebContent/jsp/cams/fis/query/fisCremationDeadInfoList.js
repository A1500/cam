function init() {
	L5.getCmp("qrToolbar").setText("逝者信息(" + organName + ")");
	var fisFuneralDeadInfoDS = L5.DatasetMgr.lookup("fisFuneralDeadInfoDS");
	// 下转过来的
	if (organCode != 'null') {
		if (organCode.substring(2) == "0000000000") {
			fisFuneralDeadInfoDS.setParameter("AREA_CODE", organCode.substring(
							0, 2));
		} else if (organCode.substring(4) == "00000000") {
			fisFuneralDeadInfoDS.setParameter("AREA_CODE", organCode.substring(
							0, 4));
		} else if (organCode.substring(6) == "000000") {
			fisFuneralDeadInfoDS.setParameter("AREA_CODE", organCode.substring(
							0, 6));
		} else {
			fisFuneralDeadInfoDS.setParameter("AREA_CODE", organCode.substring(
							0, 9));
		}
		fisFuneralDeadInfoDS.setParameter("FLAG", flag);
	} else if (unitId != 'null') {
		fisFuneralDeadInfoDS.setParameter("UNIT_ID", unitId);
	}

	fisFuneralDeadInfoDS.setParameter("START_TIME", qStartTime);
	fisFuneralDeadInfoDS.setParameter("END_TIME", qEndTime);
	fisFuneralDeadInfoDS.load();
}

// 详情
function deadInfo_detail() {
	var grid = L5.getCmp("editDeadPanel");
	var selected = grid.getSelectionModel().getSelections();
	if (selected.length != 1) {
		L5.Msg.alert('提示', "请选择一条记录!");
		return false;
	}
	var deathDetailWin = L5.getCmp("deathDetailWin");
	deathDetailWin.show();
}

// 导出为Excel
function exportExcel() {
	var dataset = L5.DatasetMgr.lookup("fisFuneralDeadInfoDS");
	if (dataset.getCount() <= 0) {
		L5.Msg.alert('提示', "无查询结果，不能导出!");
		return false;
	}
	var pageSize = dataset.pageInfo.pageSize;
	var pageIndex = dataset.pageInfo.pageIndex;
	var startCursor = dataset.pageInfo.startCursor;
	// var total = dataset.getTotalCount();
	dataset.baseParams["excelType"] = '1'; // 导出类型 0：导出当前页；1：导出符合查询条件所有记录
	dataset.baseParams["startExcel"] = startCursor; // 总记录中当前页记录起始位置
	dataset.baseParams["limitExcel"] = dataset.getTotalCount();
	// dataset.baseParams["limitExcel"]=total;
	// //导出记录数，如导出类型为导出符合查询条件所有记录时，其值为dataset.getTotalCount()
	L5.dataset2excel(dataset,
			"/jsp/cams/fis/query/fisCremationDeadInfoListExcel.jsp");
	dataset.baseParams["excelType"] = "reset"; // 重置导出类型
}

function close_DeadInfo() {
	var deathDetailWin = L5.getCmp("deathDetailWin");
	deathDetailWin.hide();
}