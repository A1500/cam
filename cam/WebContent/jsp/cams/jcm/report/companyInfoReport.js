function init(){
	document.getElementById("reDiv").style.display="none";
}
//查询按钮
var startTime="";
function query(){
	var jcmCompanyProfileDataSet=L5.DatasetMgr.lookup("jcmCompanyProfileDataSet");
	jcmCompanyProfileDataSet.setParameter("areaCode",organCode);
	jcmCompanyProfileDataSet.load();
	document.getElementById("reDiv").style.display="";
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
