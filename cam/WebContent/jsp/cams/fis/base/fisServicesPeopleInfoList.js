function init() {
	var fisServicesOrganManageDs = L5.DatasetMgr.lookup("fisServicesOrganManageDs");
	fisServicesOrganManageDs.load();
	var fisPeoInfoDS = L5.DatasetMgr.lookup("fisPeoInfoDS");
	fisPeoInfoDS.load();
	fisPeoInfoDS.on("load", function() {
				var qrToolbar = L5.getCmp("qrToolbar");
				if (fisPeoInfoDS.getCount() > 0)
					qrToolbar.setText("查询结果(" + fisPeoInfoDS.getTotalCount()
							+ "条)");
				else
					qrToolbar.setText("查询结果");
			});
}
// 资源查询
function query() {
	var fisPeoInfoDS = L5.DatasetMgr.lookup("fisPeoInfoDS");
	fisPeoInfoDS.setParameter("name", document.getElementById("qName").value);
//	fisPeoInfoDS.setParameter("WORK_TYPE",document.getElementById("qWorkType").value);
	fisPeoInfoDS.setParameter("PEOPLE_TYPE", document
					.getElementById("qPeopleType").value);
//	fisPeoInfoDS.setParameter("IF_CANCEL", "0");
	fisPeoInfoDS.load();
	fisPeoInfoDS.on("load", function() {
				var qrToolbar = L5.getCmp("qrToolbar");
				if (fisPeoInfoDS.getCount() > 0)
					qrToolbar.setText("查询结果(" + fisPeoInfoDS.getTotalCount()
							+ "条)");
				else
					qrToolbar.setText("查询结果");
			});
}
// 明细
function detailHref(value, cellmeta, record, rowindex, colindex, dataset) {
	return '<a href="javascript:detail(\'' + record.get("peopleId") + '\')">'
			+ value + '</a>';
}

function detail(peopleId) {
	var data = new L5.Map();
	var selected = L5.getCmp("serviceUsePeoGrid").getSelectionModel()
			.getSelections();
	data.put("peopleId", peopleId);//selected[0].get("PEOPLE_ID")
	var url = 'jsp/cams/fis/base/fisServicesPeopleDetail.jsp';
	var text = '工作人员信息';
	L5.forward(url, text, data);
}

// 导出excel
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
	document.getElementById("qName").value = '';
	document.getElementById("qPeopleType").value = '';
	document.getElementById("qWorkType").value = '';
}
// 新增
function addFuneral() {
	var method = 'INSERT';
	var url = 'jsp/cams/fis/base/fisServicesPeopleEdit.jsp';
	var map = new L5.Map();
	map.put("method", method);
	L5.forward(url, '', map);
}

// 修改
function updateFuneral() {
	var editGridPanel = L5.getCmp("serviceUsePeoGrid");
	var selectedRecord = editGridPanel.getSelectionModel().getSelected();
	if (!selectedRecord) {
		L5.Msg.alert("提示", "请先选择一条记录");
		return false;
	}
	var method = 'UPDATE';
	var peopleId = selectedRecord.get("peopleId");
	var url = 'jsp/cams/fis/base/fisServicesPeopleEdit.jsp';
	var map = new L5.Map();
	map.put("method", method);
	map.put("peopleId", peopleId);
	L5.forward(url, '', map);

}
function formatDate2String(date) {
	return date.getYear()
			+ "-"
			+ ((date.getMonth() + 1) > 9 ? (date.getMonth() + 1) : "0"
					+ (date.getMonth() + 1)) + "-"
			+ (date.getDate() > 9 ? date.getDate() : "0" + date.getDate());
}

//渲染所属单位
function rendererCreateOrgan(value, cellmeta, record, rowindex, colindex, dataset) {
	var pos = fisServicesOrganManageDs.find("unitId",value,0);
	if(pos != -1) {
		return fisServicesOrganManageDs.getAt(pos).get("unitName");
	}
	return value;
}