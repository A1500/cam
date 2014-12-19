function init() {
	L5.Msg.wait("正在加载数据，请等待...", "加载数据");
	document.getElementById("reDiv").style.display="block";
	ds.setParameter("domicileCode",organArea);
	L5.Ajax.timeout = 900000;
	ds.load(true);
	if(ds.getCount()>0){
		setTimeout(stopLoad, 100);
	}
}
function stopLoad(){
	L5.Msg.hide();
}
function queryNextLevel(obj){
	var organCode = obj.parentNode.parentNode.parentNode.cells[0].firstChild.innerHTML; // 行政区划
	if(organCode.indexOf('000')==-1){
		return;
	}
	ds.setParameter("domicileCode",organCode);
	ds.load();
}
function exportExcel(){
	var dataset=L5.DatasetMgr.lookup("ds");
	var pageSize = dataset.pageInfo.pageSize;
	var pageIndex = dataset.pageInfo.pageIndex;
	var startCursor = dataset.pageInfo.startCursor;
	dataset.baseParams["excelType"]='1';  //导出类型 0：导出当前页；1：导出符合查询条件所有记录
	dataset.baseParams["startExcel"]=startCursor;  //总记录中当前页记录起始位置
	dataset.baseParams["limitExcel"]=dataset.getTotalCount();
	L5.dataset2excel(dataset,"/jsp/cams/welfare/report/fit/fitBuildReportExcel.jsp");
	dataset.baseParams["excelType"]="reset"; //重置导出类型
}
function nullToZero(value){
	if(value == ''){
		return 0;
	}
}