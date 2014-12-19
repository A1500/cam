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
	document.getElementById('label8').innerHTML=getMoneyFormatNoPoint(ds.sum("CENTRAL_FAMILY_SUM"));
	document.getElementById('label9').innerHTML=getMoneyFormatNoPoint(ds.sum("CENTRAL_CLASS_FAMILY_SUM"));
	document.getElementById('label10').innerHTML=getMoneyFormatNoPoint(ds.sum("CENTRAL_PEOPLE_SUM"));
	document.getElementById('label11').innerHTML=getMoneyFormatNoPoint(ds.sum("CENTRAL_CLASS_PEOPLE_SUM"));
	document.getElementById('label12').innerHTML=getMoneyFormat(ds.sum("CENTRAL_MATCHING_MON"));
	document.getElementById('label13').innerHTML=getMoneyFormat(ds.sum("CENTRAL_ASSISTANCE_MON"));
	document.getElementById('label14').innerHTML=getMoneyFormat(ds.sum("CENTRAL_CLASS_MON"));
	document.getElementById('label15').innerHTML=getMoneyFormatNoPoint(ds.sum("PROVINCE_FAMILY_SUM"));
	document.getElementById('label16').innerHTML=getMoneyFormatNoPoint(ds.sum("PROVINCE_CLASS_FAMILY_SUM"));
	document.getElementById('label17').innerHTML=getMoneyFormatNoPoint(ds.sum("PROVINCE_PEOPLE_SUM"));
	document.getElementById('label18').innerHTML=getMoneyFormatNoPoint(ds.sum("PROVINCE_CLASS_PEOPLE_SUM"));
	document.getElementById('label19').innerHTML=getMoneyFormat(ds.sum("PROVINCE_MATCHING_MON"));
	document.getElementById('label20').innerHTML=getMoneyFormat(ds.sum("PROVINCE_ASSISTANCE_MON"));
	document.getElementById('label21').innerHTML=getMoneyFormat(ds.sum("PROVINCE_CLASS_MON"));
	document.getElementById('label22').innerHTML=getMoneyFormatNoPoint(ds.sum("CITY_FAMILY_SUM"));
	document.getElementById('label23').innerHTML=getMoneyFormatNoPoint(ds.sum("CITY_CLASS_FAMILY_SUM"));
	document.getElementById('label24').innerHTML=getMoneyFormatNoPoint(ds.sum("CITY_PEOPLE_SUM"));
	document.getElementById('label25').innerHTML=getMoneyFormatNoPoint(ds.sum("CITY_CLASS_PEOPLE_SUM"));
	document.getElementById('label26').innerHTML=getMoneyFormat(ds.sum("CITY_MATCHING_MON"));
	document.getElementById('label27').innerHTML=getMoneyFormat(ds.sum("CITY_ASSISTANCE_MON"));
	document.getElementById('label28').innerHTML=getMoneyFormat(ds.sum("CITY_CLASS_MON"));
	document.getElementById('label29').innerHTML=getMoneyFormatNoPoint(ds.sum("COUNTY_FAMILY_SUM"));
	document.getElementById('label30').innerHTML=getMoneyFormatNoPoint(ds.sum("COUNTY_CLASS_FAMILY_SUM"));
	document.getElementById('label31').innerHTML=getMoneyFormatNoPoint(ds.sum("COUNTY_PEOPLE_SUM"));
	document.getElementById('label32').innerHTML=getMoneyFormatNoPoint(ds.sum("COUNTY_CLASS_PEOPLE_SUM"));
	document.getElementById('label33').innerHTML=getMoneyFormat(ds.sum("COUNTY_MATCHING_MON"));
	document.getElementById('label34').innerHTML=getMoneyFormat(ds.sum("COUNTY_ASSISTANCE_MON"));
	document.getElementById('label35').innerHTML=getMoneyFormat(ds.sum("COUNTY_CLASS_MON"));
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
	L5.dataset2excel(dataset,"/jsp/cams/drel/report/exportCityBaseCaseExcel.jsp?assistanceType="+assistanceType+'&startTime='+startTime);
	dataset.baseParams["excelType"]="reset"; //重置导出类型
}
function reset(){

	
}