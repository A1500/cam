function init() {
    L5.QuickTips.init();
     ds.load();
};

function getParam(ElementId) {
    var value = document.getElementById(ElementId).value;
    if (value == "") value = undefined;
    return value;
}
function query() {
	var startDate = getParam("startDate");
	var endDate = getParam("endDate");
    ds.setParameter("startDate", startDate==""?"":(startDate+" 00:00:00"));
    ds.setParameter("endDate", endDate==""?"":(endDate+" 00:00:00"));
    ds.load();
}
function exportExcel() {
	var pageSize = ds.pageInfo.pageSize;
	var pageIndex = ds.pageInfo.pageIndex;
	var startCursor = ds.pageInfo.startCursor;
	ds.baseParams["excelType"]="0";  //导出类型 0：导出当前页；1：导出符合查询条件所有记录
	ds.baseParams["startExcel"]=startCursor;  //总记录中当前页记录起始位置
	ds.baseParams["limitExcel"]=pageSize;  //导出记录数，如导出类型为导出符合查询条件所有记录时，其值为ds.getTotalCount()
	L5.dataset2excel(ds,"/jsp/sdmz/comm/query/assistanceOfAreaQuery/forexcel.jsp");
	ds.baseParams["excelType"]="reset"; //重置导出类型
	
}
