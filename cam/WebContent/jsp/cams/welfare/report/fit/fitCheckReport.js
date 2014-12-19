function init() {
	document.getElementById("startDate").value=getCurDate().substring(0,7)+"-01";
	document.getElementById("endDate").value=getCurDate();
}
var startDate="";
var endDate="";
var statisticsTime="";
function query(){
	startDate = document.getElementById("startDate").value;//查询结束时间止
    endDate = document.getElementById("endDate").value;//
	if(startDate=="") {
		L5.Msg.alert("提示","请填写统计起始日期！");
		return;
	}
	if(endDate=="") {
		L5.Msg.alert("提示","请填写统计截止日期！");
		return;
	}
	document.getElementById("reDiv").style.display="block";
	statisticsTime=startDate+"至"+endDate;
	document.getElementById("statisticsTime").innerText =statisticsTime;
	ds.setParameter("domicileCode",organArea);
	ds.setParameter("startDate",startDate);
	ds.setParameter("endDate",endDate);
	ds.load(true);
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
	ds.setParameter("startDate",startDate);
	ds.setParameter("endDate",endDate);
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
	L5.dataset2excel(dataset,"/jsp/cams/welfare/report/fit/fitCheckReportExcel.jsp?statisticsTime="+statisticsTime);
	dataset.baseParams["excelType"]="reset"; //重置导出类型
}
function nullToZero(value){
	if(value == ''){
		return 0;
	}
}