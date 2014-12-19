//页面初始化
function init() {
	var ds=L5.DatasetMgr.lookup("ds");
	ds.on('load',function(){
		document.getElementById('label1').innerHTML=getMoneyFormatNoPoint(ds.sum("NUM_SUM"));
		document.getElementById('label2').innerHTML=getMoneyFormat(ds.sum("FIXED_ASSETS_SUM"));
		document.getElementById('label3').innerHTML=getMoneyFormat(ds.sum("MANAGEMENT_FUNDS_SUM"));
		document.getElementById('label4').innerHTML=getMoneyFormat(ds.sum("YEAR_SIDELINE_SUM"));
		document.getElementById('label5').innerHTML=getMoneyFormat(ds.sum("SUPPORT_STANDARD_SUM"));
		document.getElementById('label6').innerHTML=getMoneyFormat(ds.sum("VEGETABLES_AREA_SUM"));
		document.getElementById('label7').innerHTML=getMoneyFormat(ds.sum("VEGETABLES_YIELD_SUM"));
	});
}
function getMoneyFormatNoPoint(value){
	return formatMoney(nullToZero(value),0);
}
//查询
function query(){
	var queryYear = document.getElementById("queryYear").value;
	if(queryYear==''){
		L5.Msg.alert("提示","请输入统计年份！");
		return;
	}
	var ds=L5.DatasetMgr.lookup("ds");
	ds.setParameter("queryYear",queryYear);
	ds.setParameter("areaLevelId",organArea);
	ds.load();
	document.getElementById("statisticsTime").innerText=queryYear+"年";
	document.getElementById("reDiv").style.display = "";
}
//重置
function resetQuery() {
	document.getElementById("queryYear").value='';
}
function queryNextLevel(obj){
	var ds=L5.DatasetMgr.lookup("ds");
	var organCode = obj.parentNode.parentNode.parentNode.cells[0].firstChild.innerHTML; // 行政区划
    var queryYear = document.getElementById("queryYear").value;//查询结束时间止
    if(queryYear=="") {
		L5.Msg.alert("提示","请填写统计日期！");
		return;
	}
	if(organCode.indexOf('000')==-1){
		return;
	}
	var ds=L5.DatasetMgr.lookup("ds");
	ds.setParameter("areaLevelId",organCode);
	ds.setParameter("queryYear",queryYear);
	ds.load();
	document.getElementById("statisticsTime").innerText=queryYear+"年";
	document.getElementById("reDiv").style.display = "";
}
//两位小数格式化
function getMoneyFormat(value){
	return formatMoney(nullToZero(value),2);
}
//导出Excel
function exportExcel(){
	var statisticsTime=document.getElementById("statisticsTime").innerText;
	var dataset=L5.DatasetMgr.lookup("ds");
	var pageSize = dataset.pageInfo.pageSize;
	var pageIndex = dataset.pageInfo.pageIndex;
	var startCursor = dataset.pageInfo.startCursor;
	dataset.baseParams["excelType"]='1';  //导出类型 0：导出当前页；1：导出符合查询条件所有记录
	dataset.baseParams["startExcel"]=startCursor;  //总记录中当前页记录起始位置
	dataset.baseParams["limitExcel"]=dataset.getTotalCount();
	L5.dataset2excel(dataset,"/jsp/cams/drel/samu/reportExcel/geroInfoOtherExcel.jsp?statisticsTime="+statisticsTime);
	dataset.baseParams["excelType"]="reset"; //重置导出类型
}