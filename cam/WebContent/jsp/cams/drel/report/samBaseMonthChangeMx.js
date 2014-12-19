function init(){
	query();
}
function query(){
	var ds=L5.DatasetMgr.lookup("baseinfoFamilyDS");
	ds.setParameter("startMonth", startmonth);
	ds.setParameter("endMonth", endmonth);
	ds.setParameter("domicileCode",organCode);
	ds.setParameter("assistanceType",assistanceType);
	ds.setParameter("changeItem",changeItem);
	ds.load();
}
function exportExcel(){
	var dataset=L5.DatasetMgr.lookup("baseinfoFamilyDS");	
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
	var startMonth=startmonth;
	var endMonth=endmonth;
	var filename="";
	if(startMonth!=endMonth){
		filename=startMonth+"至"+endMonth+"基本情况变动查询信息";
	}else{
		filename=startMonth+"基本情况变动查询信息";
	}
	var class_path = "com.inspur.cams.drel.funds.release.cmd.SamReleaseCSVCommand";
	var gridObj = L5.getCmp("infoQueryGrid");
	L5.grid2excel(dataset, gridObj, filename, class_path);
}