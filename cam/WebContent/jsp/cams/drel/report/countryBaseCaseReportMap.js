function init(){
	document.getElementById("queryDate").value=getCurDate().substring(0,7);
	document.getElementById("reDiv").style.display="none";
	ds.on('load',countTotle);
}
function countTotle(ds){
	document.getElementById('label1').innerHTML=getMoneyFormatNoPoint(ds.sum("FAMILY_SUM"));
	document.getElementById('label2').innerHTML=getMoneyFormatNoPoint(ds.sum("CLASS_FAMILY_SUM"));
	document.getElementById('label3').innerHTML=getMoneyFormatNoPoint(ds.sum("ASSISTANCE_PEOPLE_SUM"));
	document.getElementById('label4').innerHTML=getMoneyFormatNoPoint(ds.sum("CLASS_PEOPLE_SUM"));
	document.getElementById('label5').innerHTML=getMoneyFormat(ds.sum("MONEY_SUM"));
	document.getElementById('label6').innerHTML=getMoneyFormat(ds.sum("ASSISTANCE_MONEY_SUM"));
	document.getElementById('label7').innerHTML=getMoneyFormat(ds.sum("CLASS_MONEY_SUM"));
	setButtonAble();
}
//按钮启用
function setButtonAble(){
	document.getElementById('queryId').disabled = false;
	document.getElementById('resetId').disabled = false;
	document.getElementById('excelId').disabled = false;
	
}
//按钮禁用
function setButtonUnAble(){
	document.getElementById('queryId').disabled = true;
	document.getElementById('resetId').disabled = true;
	document.getElementById('excelId').disabled = true;
}
//查询按钮
var startTime="";
function query(){
	document.getElementById("reDiv").style.display="block";
	setButtonUnAble();
    var queryDate = document.getElementById("queryDate").value;//查询时间
    
    if(queryDate=="") {
		L5.Msg.alert("提示","请填写统计查询时间！");
		return;
	}
	startTime=queryDate.substring(0,4)+"年"+queryDate.substring(5,7)+"月";
	document.getElementById("statisticsTime").innerText =startTime;
	ds.setParameter("repMonth", queryDate);
	if(code!=""){
		organCode=code;
	}
	ds.setParameter("domicileCode",organCode);
	ds.setParameter("assistanceType",assistanceType);
	ds.load();
	
}
/**
 *  8-事件处理：点击地区链接跳转下级明细数据
 *  最低生活保障家庭信息列表
 *  
 */
function queryNextLevel(obj){
	var organCode =  obj.parentNode.parentNode.parentNode.cells[0].firstChild.innerHTML; // 行政区划
	if(organCode.indexOf('000')==-1){
		return;
	}
   	var queryDate = document.getElementById("queryDate").value;//查询时间
    if(queryDate=="") {
		L5.Msg.alert("提示","请填写统计查询时间！");
		return;
	}
	ds.setParameter("repMonth", queryDate);
	ds.setParameter("domicileCode",organCode);
	ds.setParameter("assistanceType",assistanceType);
	ds.load();
}
//两位小数格式化
function getMoneyFormat(value){
	return formatMoney(nullToZero(value),2);
}
function getMoneyFormatNoPoint(value){
	return formatMoney(nullToZero(value),0);
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
	L5.dataset2excel(dataset,"/jsp/cams/drel/report/exportCountryBaseCaseExcel.jsp?assistanceType="+assistanceType+'&startTime='+startTime);
	dataset.baseParams["excelType"]="reset"; //重置导出类型
}
function reset(){

	
}