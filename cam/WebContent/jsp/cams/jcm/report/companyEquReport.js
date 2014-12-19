function init(){
	document.getElementById("reDiv").style.display="none";
}
//查询按钮
var startTime="";
function query(){
	var jcmOfficeEquipmentDataSet=L5.DatasetMgr.lookup("jcmOfficeEquipmentDataSet");
	jcmOfficeEquipmentDataSet.setParameter("areaCode",organCode);
	jcmOfficeEquipmentDataSet.load();
	document.getElementById("reDiv").style.display="";
}
/**
 *  8-事件处理：点击地区链接跳转下级明细数据
 *  最低生活保障家庭信息列表
 *  
 */
function queryNextLevel(obj){
	var jcmOfficeEquipmentDataSet=L5.DatasetMgr.lookup("jcmOfficeEquipmentDataSet");
	jcmOfficeEquipmentDataSet.setParameter("areaCode",organCode);
	jcmOfficeEquipmentDataSet.load();
	document.getElementById("reDiv").style.display="";
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
