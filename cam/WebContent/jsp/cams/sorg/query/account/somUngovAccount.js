function init() {
	ds.load();
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
	var filename="民办非企业单位台账";
	var class_path = "com.inspur.cams.sorg.query.cmd.SomAccountCSVCommand";
	var gridObj = L5.getCmp("accountGrid");
	L5.grid2excel(ds, gridObj, filename, class_path);
}