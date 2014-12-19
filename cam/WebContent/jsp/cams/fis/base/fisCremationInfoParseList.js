function init(){
	var fisCremationInfoParseDataSet=L5.DatasetMgr.lookup("fisCremationInfoParseDataSet");
	fisCremationInfoParseDataSet.load();
}
function query(){
	var fisCremationInfoParseDataSet=L5.DatasetMgr.lookup("fisCremationInfoParseDataSet");
	var unitName = document.getElementById("unitName").value;
	fisCremationInfoParseDataSet.setParameter("unitName",unitName);
	fisCremationInfoParseDataSet.load();
}
function exportExcel(){
	var dataset=L5.DatasetMgr.lookup("fisCremationInfoParseDataSet");
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
	L5.dataset2excel(dataset,"/jsp/cams/fis/base/fisCremationParseExcel.jsp");
	dataset.baseParams["excelType"]="reset"; //重置导出类型s
}
