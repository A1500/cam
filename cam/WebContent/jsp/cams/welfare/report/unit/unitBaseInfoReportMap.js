var queryArea="";
function init() {
	document.getElementById("reDiv").style.display="none";
	ds.on('load',countTotle);
	query();
}
function countTotle(ds){
	document.getElementById('label1').innerHTML=getMoneyFormatNoPoint(ds.sum("UNIT_NUM"));
	document.getElementById('label2').innerHTML=getMoneyFormatNoPoint(ds.sum("ECONOMIC_ONE"));
	document.getElementById('label3').innerHTML=getMoneyFormatNoPoint(ds.sum("ECONOMIC_TWO"));
	document.getElementById('label4').innerHTML=getMoneyFormatNoPoint(ds.sum("ECONOMIC_THREE"));
	document.getElementById('label5').innerHTML=getMoneyFormatNoPoint(ds.sum("ECONOMIC_FOUR"));
	document.getElementById('label6').innerHTML=getMoneyFormatNoPoint(ds.sum("ECONOMIC_FIVE"));
	document.getElementById('label7').innerHTML=getMoneyFormatNoPoint(ds.sum("ECONOMIC_SIX"));
	var workersAll=getMoneyFormatNoPoint(ds.sum("WORKERS_ALL"));
	var workersDeform=getMoneyFormatNoPoint(ds.sum("WORKERS_DEFORM"));
	document.getElementById('label8').innerHTML=workersAll;
	document.getElementById('label9').innerHTML=workersDeform;
	if(workersAll!=0){
		document.getElementById('label10').innerHTML=getMoneyFormat(workersDeform/workersAll*100);
	}else{
		document.getElementById('label10').innerHTML=getMoneyFormat(0);
	}
	document.getElementById('label11').innerHTML=getMoneyFormat(ds.sum("REG_FUND"));
	//是否显示合计行
	if(queryArea.substring(2,12)=='0000000000'){
		document.getElementById("countTotle").style.display="none";
	}else{
		document.getElementById("countTotle").style.display="block";
	}
	setButtonAble();
}
//按钮启用
function setButtonAble(){
	//document.getElementById('queryId').disabled = false;
	document.getElementById('excelId').disabled = false;
}
//按钮禁用
function setButtonUnAble(){
	//document.getElementById('queryId').disabled = true;
	document.getElementById('excelId').disabled = true;
}
function query(){
	document.getElementById("reDiv").style.display="block";
	setButtonUnAble();
	if(code!=""){
		organArea=code;
	}
	ds.setParameter("domicileCode",organArea);
	queryArea=organArea;
	ds.load();
}
function queryNextLevel(obj){
	setButtonUnAble();
	var organCode = obj.parentNode.parentNode.parentNode.cells[0].firstChild.innerHTML; // 行政区划
	if(organCode.indexOf('000')==-1){
		return;
	}
	queryArea=organCode;
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
	L5.dataset2excel(dataset,"/jsp/cams/welfare/report/unit/unitBaseInfoReportExcel.jsp?organArea="+queryArea);
	dataset.baseParams["excelType"]="reset"; //重置导出类型
}
//两位小数格式化
function getMoneyFormat(value){
	return formatMoney(nullToZero(value),2);
}
function getMoneyFormatNoPoint(value){
	return formatMoney(nullToZero(value),0);
}