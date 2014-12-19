function getParam(ElementId) {
	var value = document.getElementById(ElementId).value;
	if (value == "")
		value = undefined;
	return value;
}
function init() {
	var specialpoorSupportUnitDataSet = L5.DatasetMgr
			.lookup("specialpoorSupportUnitDataSet");
	specialpoorSupportUnitDataSet.load();
}
function query() {
	var specialpoorSupportUnitDataSet = L5.DatasetMgr
			.lookup("specialpoorSupportUnitDataSet");
	specialpoorSupportUnitDataSet.setParameter("SUPPORT_UNIT_CODE@rlike",
			getParam("qSupportUnitCode"));
	specialpoorSupportUnitDataSet.setParameter("SUPPORT_UNIT_NAME@rlike",
			getParam("qSupportUnitName"));
	specialpoorSupportUnitDataSet.load();
}
function insert() {
	var data = new L5.Map();
	data.put("method", "insert");
	var url = "jsp/cams/drel/specialpoorHelp/specialpoorSupportUnitEdit.jsp";
	L5.forward(url, '', data);
}
function update() {
	var grid = L5.getCmp("grid");
	var records = grid.getSelectionModel().getSelections();
	if (records.length == 0) {
		L5.Msg.alert("提示", "请先选中一行!");
		return;
	}
	var data = new L5.Map();
	data.put("method", "update");
	data.put("supportUnitCode", records[0].get("supportUnitCode"));
	var url = "jsp/cams/drel/specialpoorHelp/specialpoorSupportUnitEdit.jsp";
	L5.forward(url, '', data);
}
function detail() {
	var grid = L5.getCmp("grid");
	var records = grid.getSelectionModel().getSelections();
	if (records.length == 0) {
		L5.Msg.alert("提示", "请先选中一行!");
		return;
	}
	var data = new L5.Map();
	data.put("supportUnitCode", records[0].get("supportUnitCode"));
	var url = "jsp/cams/drel/specialpoorHelp/specialpoorSupportUnitDetail.jsp";
	L5.forward(url, '', data);
}
function del() {
	var grid = L5.getCmp("grid");
	var records = grid.getSelectionModel().getSelections();
	if (records.length != 1) {
		L5.Msg.alert("提示", "请先选中一行!");
		return;
	}
	L5.MessageBox.confirm("提示", "是否删除该数据？", function(sta) {
		if (sta == "yes") {
			var command = new L5.Command("com.inspur.cams.drel.special.cmd.SpecialpoorSupportUnitCmd");
			command.setParameter("supportUnitCode", records[0]
							.get("supportUnitCode"));
			command.execute("delete");
			if (!command.error) {
				var specialpoorSupportUnitDataSet = L5.DatasetMgr
						.lookup("specialpoorSupportUnitDataSet");
				specialpoorSupportUnitDataSet.load();
			} else {
				L5.Msg.alert("提示", "删除出错！");
			}
		}
	});
}
//导出Excel
function exportExcel() {
	
	return;
	var dataset=L5.DatasetMgr.lookup("specialpoorSupportUnitDataSet");	
	if(dataset.getCount()<=0){
		L5.Msg.alert('提示', "无查询结果，不能导出!");
		return false;
	}	
	var pageSize = dataset.pageInfo.pageSize;
	var pageIndex = dataset.pageInfo.pageIndex;
	var startCursor = dataset.pageInfo.startCursor;
	dataset.baseParams["excelType"]="1";  //导出类型 0：导出当前页；1：导出符合查询条件所有记录
	dataset.baseParams["startExcel"]=startCursor;  //总记录中当前页记录起始位置
	dataset.baseParams["limitExcel"]=dataset.getTotalCount();  //导出记录数，如导出类型为导出符合查询条件所有记录时，其值为dataset.getTotalCount()
	L5.dataset2excel(dataset,"/jsp/cams/drel/specialpoorHelp/specialpoorSupportUnitListExcel.jsp");
	dataset.baseParams["excelType"]="reset"; //重置导出类型
}