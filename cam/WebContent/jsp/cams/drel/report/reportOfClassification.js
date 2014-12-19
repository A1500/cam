var ifQuery = false;
var startTime="";
//页面初始化
function init() {
	document.getElementById("statTime").value=getCurYM();
	var ds=L5.DatasetMgr.lookup("ds");
	ds.on('load',function(){
		document.getElementById('label1').innerHTML=getMoneyFormatNoPoint(ds.sum("RELEASE_FAMILY_SUM"));
		document.getElementById('label2').innerHTML=getMoneyFormatNoPoint(ds.sum("CENTRAL_FAMILY_SUM"));
		document.getElementById('label3').innerHTML=getMoneyFormat(ds.sum("CENTRAL_CLASS_MON"));
		document.getElementById('label4').innerHTML=getMoneyFormatNoPoint(ds.sum("PROVINCE_FAMILY_SUM"));
		document.getElementById('label5').innerHTML=getMoneyFormat(ds.sum("PROVINCE_CLASS_MON"));
		document.getElementById('label6').innerHTML=getMoneyFormatNoPoint(ds.sum("CITY_FAMILY_SUM"));
		document.getElementById('label7').innerHTML=getMoneyFormat(ds.sum("CITY_CLASS_MON"));
		document.getElementById('label8').innerHTML=getMoneyFormatNoPoint(ds.sum("COUNTY_FAMILY_SUM"));
		document.getElementById('label9').innerHTML=getMoneyFormat(ds.sum("COUNTY_CLASS_MON"));
		document.getElementById('label10').innerHTML=getMoneyFormat(ds.sum("ASSISTANCE_CLASS_MON_SUM"));
	});
}
function getMoneyFormatNoPoint(value){
	return formatMoney(nullToZero(value),0);
}
//查询
function query(){
	var statTime = document.getElementById("statTime").value;
	startTime=statTime.substring(0,4)+"年"+statTime.substring(5,7)+"月";
	document.getElementById("statisticsTime").innerText =startTime;
	var ds=L5.DatasetMgr.lookup("ds");
	ds.setParameter("domicileCode",organArea);
	ds.setParameter("statTime",statTime);
	ds.load();
	document.getElementById("reDiv").style.display = "";
}

function queryNextLevel(obj){
	var ds=L5.DatasetMgr.lookup("ds");
	var organCode = obj.parentNode.parentNode.parentNode.cells[0].firstChild.innerHTML; // 行政区划
    var beginDate = document.getElementById("statTime").value;//查询结束时间止
    if(beginDate=="") {
		L5.Msg.alert("提示","请填写统计起始日期！");
		return;
	}
	if(organCode.indexOf('000')==-1){
		return;
	}
	var statTime = document.getElementById("statTime").value;
	var ds=L5.DatasetMgr.lookup("ds");
	ds.setParameter("domicileCode",organCode);
	ds.setParameter("statTime",beginDate);
	ds.load();
	document.getElementById("reDiv").style.display = "";
}
//重置
function resetQuery() {
	document.getElementById("statTime").value=getCurYM();
}

//获得当前日期 YYYY-MM
function getCurYM(){
	var date=new Date();
	var year=""+date.getFullYear();
	var month=date.getMonth()+1;
	if(month<10){
		month="0"+month;
	}
	return year+"-"+month;
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
	L5.dataset2excel(dataset,"/jsp/cams/drel/report/exportExcel.jsp?startTime="+startTime);
	dataset.baseParams["excelType"]="reset"; //重置导出类型
}