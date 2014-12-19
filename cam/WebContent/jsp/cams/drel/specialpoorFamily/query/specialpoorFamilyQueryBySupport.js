function init(){
	document.getElementById("reDiv").style.display="none";
	ds.on('load',countTotle);
}
function countTotle(ds){
	for(var i = 0 ; i<ds.getCount() ;i++){
		var record = ds.getAt(i);
		record.set("NUM",i+1);
	}
	document.getElementById('label1').innerHTML=ds.getCount();
	document.getElementById('label2').innerHTML=ds.sum("FAMILY_SUM");
	document.getElementById('label3').innerHTML=ds.sum("PEOPLE_NUM");
}
//查询按钮
function query(){
	document.getElementById("reDiv").style.display="block";
	ds.load();
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
	L5.dataset2excel(dataset,"/jsp/cams/drel/specialpoorFamily/query/specialpoorFamilyQueryBySupportExcel.jsp");
	dataset.baseParams["excelType"]="reset"; //重置导出类型
}
function reset(){

	
}