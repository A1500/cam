function init(){
	document.getElementById("reDiv").style.display="none";
	queryDataSet.on('load',countTotle);
}
function countTotle(ds){
	document.getElementById('label1').innerHTML=ds.sum("Y_NUM");
	document.getElementById('label2').innerHTML=ds.sum("FACILITIES_NUM");
	document.getElementById('label3').innerHTML=ds.sum("Y_NUM");
	document.getElementById('label4').innerHTML=ds.sum("ORGAN_NUM");
	document.getElementById('label5').innerHTML=ds.sum("Y_NUM");
	document.getElementById('label6').innerHTML=ds.sum("COORDINATE_NUM");
	document.getElementById('label7').innerHTML=ds.sum("Y_NUM");
	document.getElementById('label8').innerHTML=ds.sum("PLAN_NUM");
	document.getElementById('label9').innerHTML=ds.sum("Y_NUM");
	document.getElementById('label10').innerHTML=ds.sum("FINANCE_NUM");
	document.getElementById('label11').innerHTML=ds.sum("Y_NUM");
	document.getElementById('label12').innerHTML=ds.sum("SERVICE_NUM");
	document.getElementById('label13').innerHTML=ds.sum("Y_NUM");
	document.getElementById('label14').innerHTML=ds.sum("MODE_NUM");
}
//查询按钮
var startTime="";
function query(){
	var reportDate = document.getElementById("reportDate").value;//填报日期
    if(reportDate=="") {
		L5.Msg.alert("提示","请选择填报日期！");
		return;
	}
	document.getElementById("reDiv").style.display="block";
	queryDataSet.setParameter("reportDate",_$("reportDate"));
	queryDataSet.setParameter("releaseArea", organCode);
	queryDataSet.load();
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
   	var reportDate = document.getElementById("reportDate").value;//填报日期
    if(reportDate=="") {
		L5.Msg.alert("提示","请选择填报日期！");
		return;
	}
	queryDataSet.setParameter("reportDate",_$("reportDate"));
	queryDataSet.setParameter("releaseArea", organCode);
	queryDataSet.load();
}
//导出Excel
function exportExcel(){
	var dataset=L5.DatasetMgr.lookup("queryDataSet");
	var pageSize = dataset.pageInfo.pageSize;
	var pageIndex = dataset.pageInfo.pageIndex;
	var startCursor = dataset.pageInfo.startCursor;
	dataset.baseParams["excelType"]='1';  //导出类型 0：导出当前页；1：导出符合查询条件所有记录
	dataset.baseParams["startExcel"]=startCursor;  //总记录中当前页记录起始位置
	dataset.baseParams["limitExcel"]=dataset.getTotalCount();
	L5.dataset2excel(dataset,"/jsp/ext/cdc/query/cdcStreetExcel.jsp?reportDate="+getSelected("reportDate"));
	dataset.baseParams["excelType"]="reset"; //重置导出类型
}
function getSelected(selectedId){
   var ddl = document.getElementById(selectedId);  
   var index = ddl.selectedIndex;   
   //var Value = ddl.options[index].value;   
   return ddl.options[index].text;
}
