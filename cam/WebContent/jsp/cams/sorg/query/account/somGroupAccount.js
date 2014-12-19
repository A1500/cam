function init() {
	ds.load();
	//ds.on('load', showDiv);
	L5.QuickTips.init();
};

function showDiv() {
	document.getElementById("reDiv").style.display = "";
}
function forExcel(){
	if(ds.getCount()<=0){
		L5.Msg.alert('提示', "无查询结果，不能导出!");
		return false;
	}
	var pageSize = ds.pageInfo.pageSize;
	var pageIndex = ds.pageInfo.pageIndex;
	var startCursor = ds.pageInfo.startCursor;
	ds.baseParams["excelType"]="1";  //导出类型 0：导出当前页；1：导出符合查询条件所有记录
	ds.baseParams["startExcel"]=startCursor;  //总记录中当前页记录起始位置
	ds.baseParams["limitExcel"]=ds.getTotalCount();  //导出记录数，如导出类型为导出符合查询条件所有记录时，其值为dataset.getTotalCount()
	var filename="社会团体台账";
	var class_path = "com.inspur.cams.sorg.query.cmd.SomAccountCSVCommand";
	var gridObj = L5.getCmp("accountGrid");
	L5.grid2excel(ds, gridObj, filename, class_path);
}

//导出Excel
function forExcel2(){
	var dataset=L5.DatasetMgr.lookup("ds");
	if(dataset.getCount()<=0){
		L5.Msg.alert('提示', "无查询结果，不能导出!");
		return false;
	}
	var pageSize = dataset.pageInfo.pageSize;
	var pageIndex = dataset.pageInfo.pageIndex;
	var startCursor = dataset.pageInfo.startCursor;
	dataset.baseParams["excelType"]="1";  //导出类型 0：导出当前页；1：导出符合查询条件所有记录
	dataset.baseParams["startExcel"]=startCursor;  //总记录中当前页记录起始位置
	dataset.baseParams["limitExcel"]=dataset.getTotalCount();  //导出记录数，如导出类型为导出符合查询条件所有记录时，其值为dataset.getTotalCount()
	var filename="社会组织台帐";
	var class_path = "org.loushang.next.web.cmd.ExcelCSVCommand";
	var gridObj = L5.getCmp("accountGrid");
	L5.grid2excel(dataset, gridObj, filename, class_path);

}