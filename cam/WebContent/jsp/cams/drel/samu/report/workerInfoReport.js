//页面初始化
function init() {
	var ds=L5.DatasetMgr.lookup("ds");
	ds.on('load',function(){
		
	});
}
function getMoneyFormatNoPoint(value){
	return formatMoney(nullToZero(value),0);
}
//查询
function query(){
	var ds=L5.DatasetMgr.lookup("ds");
	ds.setParameter("areaLevelId",organArea);
	ds.load();
	document.getElementById("reDiv").style.display = "";
}
//重置
function resetQuery() {

}
function queryNextLevel(obj){
	var organCode = obj.parentNode.parentNode.parentNode.cells[0].firstChild.innerHTML; // 行政区划
	if(organCode.indexOf('000')==-1){
		return;
	}
	var ds=L5.DatasetMgr.lookup("ds");
	ds.setParameter("areaLevelId",organCode);
	ds.load();
	document.getElementById("reDiv").style.display = "";
}
//两位小数格式化
function getMoneyFormat(value){
	return formatMoney(nullToZero(value),2);
}
//导出Excel
function exportExcel(){
	var dataset=L5.DatasetMgr.lookup("ds");
	var pageSize = dataset.pageInfo.pageSize;
	var pageIndex = dataset.pageInfo.pageIndex;
	var startCursor = dataset.pageInfo.startCursor;
	dataset.baseParams["excelType"]='1';  //导出类型 0：导出当前页；1：导出符合查询条件所有记录
	dataset.baseParams["startExcel"]=startCursor;  //总记录中当前页记录起始位置
	dataset.baseParams["limitExcel"]=dataset.getTotalCount();
	L5.dataset2excel(dataset,"/jsp/cams/drel/samu/reportExcel/workerInfoExcel.jsp");
	dataset.baseParams["excelType"]="reset"; //重置导出类型
}