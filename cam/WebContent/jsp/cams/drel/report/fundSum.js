var isSpecial="0";
var assistanceType="01";
function init(){
	document.getElementById("queryDate").value=getCurDate().substring(0,7);
	document.getElementById("reDiv").style.display="none";
	ds.on('load',function(){
		document.getElementById('label1').innerHTML=getMoneyFormat(ds.sum("CENTRAL_ASSISTANCE_MON"));
		document.getElementById('label2').innerHTML=getMoneyFormat(ds.sum("PROVINCE_ASSISTANCE_MON"));
		document.getElementById('label3').innerHTML=getMoneyFormat(ds.sum("CITY_ASSISTANCE_MON"));
		document.getElementById('label4').innerHTML=getMoneyFormat(ds.sum("COUNTY_ASSISTANCE_MON"));
		document.getElementById('label5').innerHTML=getMoneyFormat(ds.sum("CENTRAL_CLASS_MON"));
		document.getElementById('label6').innerHTML=getMoneyFormat(ds.sum("PROVINCE_CLASS_MON"));
		document.getElementById('label7').innerHTML=getMoneyFormat(ds.sum("CITY_CLASS_MON"));
		document.getElementById('label8').innerHTML=getMoneyFormat(ds.sum("COUNTY_CLASS_MON"));
		document.getElementById('label9').innerHTML=getMoneyFormat(ds.sum("ASSISTANCE_MON_SUM"));
		document.getElementById('label10').innerHTML=getMoneyFormat(ds.sum("ASSISTANCE_CLASS_MON_SUM"));
		document.getElementById('label11').innerHTML=getMoneyFormat(ds.sum("RELEASE_MON_SUM"));
	});
}
//两位小数格式化
function getMoneyFormat(value){
	return formatMoney(nullToZero(value),2);
}
var startTime="";
function query(){
	document.getElementById("reDiv").style.display="block";
    var beginDate = document.getElementById("queryDate").value;//查询结束时间止
    var endDate = document.getElementById("queryDate").value;//行政区划
    startTime=beginDate.substring(0,4)+"年"+beginDate.substring(5,7)+"月";
	document.getElementById("statisticsTime").innerText =startTime;
    if(beginDate=="") {
		L5.Msg.alert("提示","请填写统计起始日期！");
		return;
	}
	if(endDate=="") {
		L5.Msg.alert("提示","请填写统计截止日期！");
		return;
	}
	ds.setParameter("beginDate", beginDate);
	ds.setParameter("endDate",endDate);
	ds.setParameter("releaseArea",organCode);
	ds.setParameter("isSpecial",isSpecial);
	ds.setParameter("assistanceType",assistanceType);
	ds.load();
}
/**
 *  8-事件处理：点击地区链接跳转下级明细数据
 *  最低生活保障家庭信息列表
 *  licb
 */
function queryNextLevel(obj){
	var organCode = obj.parentNode.parentNode.parentNode.cells[0].firstChild.innerHTML; // 行政区划
    var beginDate = document.getElementById("queryDate").value;//查询结束时间止
    var endDate = document.getElementById("queryDate").value;//行政区划
    if(beginDate=="") {
		L5.Msg.alert("提示","请填写统计起始日期！");
		return;
	}
	if(endDate=="") {
		L5.Msg.alert("提示","请填写统计截止日期！");
		return;
	}
	if(organCode.indexOf('000')==-1){
		return;
	}
	ds.setParameter("beginDate", beginDate);
	ds.setParameter("endDate",endDate);
	ds.setParameter("releaseArea",organCode);
	ds.setParameter("isSpecial",isSpecial);
	ds.setParameter("assistanceType",assistanceType);
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
	L5.dataset2excel(dataset,"/jsp/cams/drel/report/exportFundSumExcel.jsp?startTime="+startTime);
	dataset.baseParams["excelType"]="reset"; //重置导出类型
}