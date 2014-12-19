var userInfo;
function init() {
	userInfo = initArea();
	var fisPeoInfoDS = L5.DatasetMgr.lookup("fisPeoInfoDS");
	fisPeoInfoDS.on("load", function() {
				var qrToolbar = L5.getCmp("qrToolbar");
				if (fisPeoInfoDS.getCount() > 0)
					qrToolbar.setText("查询结果(" + fisPeoInfoDS.getTotalCount()
							+ "条)");
				else
					qrToolbar.setText("查询结果");
			});
	document.getElementById("qIfCancel").value = "0";
	
	query();
}

// 资源查询
function query() {
	var fisPeoInfoDS = L5.DatasetMgr.lookup("fisPeoInfoDS");
	fisPeoInfoDS.setParameter("name", document.getElementById("qName").value);
	fisPeoInfoDS.setParameter("sex", document.getElementById("qSex").value);
	fisPeoInfoDS.setParameter("idCard",
			document.getElementById("qIdCard").value);
	fisPeoInfoDS.setParameter("workType",
			document.getElementById("qWorkType").value);
	fisPeoInfoDS.setParameter("ifCancel",
			document.getElementById("qIfCancel").value);
	fisPeoInfoDS.setParameter("peopleType", document
					.getElementById("qPeopleType").value);
	fisPeoInfoDS.setParameter("education", document
					.getElementById("qEducation").value);
	fisPeoInfoDS.setParameter("profession", document
					.getElementById("qProfession").value);
	fisPeoInfoDS.setParameter("startdate",
			document.getElementById("startDate").value);
	fisPeoInfoDS.setParameter("enddate",
			document.getElementById("endDate").value);
	fisPeoInfoDS.load();
}

// 渲染明细
function detailHref(value, cellmeta, record, rowindex, colindex, dataset) {
	return '<a href="javascript:detail(\'' + record.get("peopleId") + '\')">'
			+ value + '</a>';
}

//明细
function detail(peopleId) {
	var url = "fisServicesPeopleDetail.jsp?peopleId=" + peopleId;
	window.showModalDialog(url, window,
					"scroll:yes;status:no;dialogWidth:1024px;dialogHeight:768px;resizable:1");
}

// 点击明细
function showDetails() {
	var editGridPanel = L5.getCmp("editGridPanel");
	var selectedRecord = editGridPanel.getSelectionModel().getSelected();
	if (!selectedRecord) {
		L5.Msg.alert("提示", "请先选择一条记录");
		return false;
	}
	var peopleId = selectedRecord.get("peopleId");
	detail(peopleId);
}

// 导出excle
function print() {
	var startDate = document.getElementById("startDate").value;
	var endDate = document.getElementById("endDate").value;
	var dataset = L5.DatasetMgr.lookup("fisPeoInfoDS");
	if (dataset.getCount() <= 0) {
		L5.Msg.alert('提示', "无查询结果，不能导出!");
		return false;
	}
	var pageSize = dataset.pageInfo.pageSize;
	var pageIndex = dataset.pageInfo.pageIndex;
	var startCursor = dataset.pageInfo.startCursor;
	dataset.baseParams["excelType"] = "1"; // 导出类型 0：导出当前页；1：导出符合查询条件所有记录
	dataset.baseParams["startExcel"] = startCursor; // 总记录中当前页记录起始位置
	dataset.baseParams["limitExcel"] = dataset.getTotalCount(); // 导出记录数，如导出类型为导出符合查询条件所有记录时，其值为dataset.getTotalCount()
	L5.dataset2excel(dataset,
			"/jsp/cams/fis/query/fisPeopleQueryExcel.jsp?startDate="
					+ startDate + "&endDate=" + endDate);
	dataset.baseParams["excelType"] = "reset"; // 重置导出类型
}
// 重置
function resetQuery() {
	document.getElementById("endDate").value = '';
	document.getElementById("startDate").value = '';
	document.getElementById("qName").value = '';
	document.getElementById("qIdCard").value = '';
	document.getElementById("qSex").value = '';
	document.getElementById("qPeopleType").value = '';
	document.getElementById("qEducation").value = '';
	document.getElementById("qWorkType").value = '';
	document.getElementById("qProfession").value = '';
	document.getElementById("qIfCancel").value = '0';
}