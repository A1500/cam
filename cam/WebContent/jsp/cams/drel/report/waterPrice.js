var isSpecial='1';
function init(){
	document.getElementById("reDiv").style.display="none";
    document.getElementById("cxsj_q").value=getCurDate().substring(0,7);
	var ds=L5.DatasetMgr.lookup("ds"); 
	ds.on('load',showDiv);
}
var startTime="";
function showDiv(){
	document.getElementById("reDiv").style.display="block";
    var beginDate = document.getElementById("cxsj_q").value;//查询时间
    startTime=beginDate.substring(0,4)+"年"+beginDate.substring(5,7)+"月";
    document.getElementById("statisticsTime").innerText =startTime;
}
//两位小数格式化
function getMoneyFormat(value){
	return formatMoney(nullToZero(value),2);
}

function getMoneyFormatNoPoint(value){
	return formatMoney(nullToZero(value),0);
}
function queryNextLevel(obj){
	organCode = obj.parentNode.parentNode.parentNode.cells[0].firstChild.innerHTML; // 行政区划
	if(organCode.indexOf('000')==-1){
		return;
	}
    query();
}
function query(){
    var beginDate = document.getElementById("cxsj_q").value;//查询时间
	if(beginDate=="") {
		L5.Msg.alert("提示","请填写统计起始日期！");
		return;
	}
	ds.removeAll();
	ds.setParameter("releaseArea",organCode);
	ds.setParameter("organArea",organCode);
	ds.setParameter("releaseDate", beginDate);
	ds.setParameter("isSpecial",isSpecial);
	ds.load();
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
	L5.dataset2excel(dataset,"/jsp/cams/drel/report/exportWaterPriceExcel.jsp?startTime="+startTime);
	dataset.baseParams["excelType"]="reset"; //重置导出类型
}