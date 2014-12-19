function init(){
	document.getElementById("queryDate").value=getCurDate().substring(0,7);
	document.getElementById("reDiv").style.display="none";
	ds.on('load',function(){
		document.getElementById('label0').innerHTML=getMoneyFormatNoPoint(ds.sum("RELEASE_FAMILY_SUM"));
		document.getElementById('label1').innerHTML=getMoneyFormatNoPoint(ds.sum("RELEASE_PEOPLE_SUM"));
		document.getElementById('label2').innerHTML=formatMoney(ds.sum("ASSISTANCE_MON_SUM"),2);
		if(assistanceType == '01'){
			document.getElementById('label4').innerHTML=formatMoney(ds.sum("WATER_RELEASE_SUM"),2);
			document.getElementById('label6').innerHTML=formatMoney(ds.sum("ASSISTANCE_MON_SUM")/ds.sum("RELEASE_PEOPLE_SUM"),2);	
		}
		if(assistanceType != '03'){
			document.getElementById('label3').innerHTML=formatMoney(ds.sum("ASSISTANCE_CLASS_MON_SUM"),2);
			document.getElementById('label5').innerHTML=formatMoney(ds.sum("RELEASE_MON_SUM"),2);
		}
	});
}
//两位小数格式化
function getMoneyFormat(value){
	return formatMoney(nullToZero(value),2);
}

function getMoneyFormatNoPoint(value){
	return formatMoney(nullToZero(value),0);
}
var startTime="";
function query(){
	document.getElementById("reDiv").style.display="block";
    var beginDate = document.getElementById("queryDate").value;//查询结束时间止
    var endDate = document.getElementById("queryDate").value;
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
	L5.dataset2excel(dataset,"/jsp/cams/drel/report/exportCityPeopleExcel.jsp?assistanceType="+assistanceType+'&startTime='+startTime);
	dataset.baseParams["excelType"]="reset"; //重置导出类型
}