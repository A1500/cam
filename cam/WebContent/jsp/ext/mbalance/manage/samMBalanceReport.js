//页面初始化
function init() {
	domicileDataset.setParameter("filterSql"," id like '"+organCode.substring(0,4)+"%000000'  order by id ");
	domicileDataset.load();
	var gvnReportDS=L5.DatasetMgr.lookup("gvnReportDS");
	gvnReportDS.setParameter("endTime",getCurDate());	
	gvnReportDS.setParameter("hospitalId","21");
	gvnReportDS.setParameter("regId",userId);
	gvnReportDS.load();
}
//查询方法
function query(){
	var gvnReportDS=L5.DatasetMgr.lookup("gvnReportDS");
	gvnReportDS.setParameter("hosStatus","0");	
	gvnReportDS.setParameter("domicileCode",getParam("qDomicileCode"));	
	gvnReportDS.setParameter("hospitalId",organId);
	gvnReportDS.setParameter("beginTime",getParam("beginTime"));	
	gvnReportDS.setParameter("endTime",getParam("endTime"));		
	gvnReportDS.setParameter("sex",getParam("qSex"));			
	gvnReportDS.setParameter("age",getParam("qage"));
	gvnReportDS.setParameter("regId",userId);
	gvnReportDS.load();
}
function ToExcel(){
	var dataset=L5.DatasetMgr.lookup("gvnReportDS");
	var pageSize = dataset.pageInfo.pageSize;
	var pageIndex = dataset.pageInfo.pageIndex;
	var startCursor = dataset.pageInfo.startCursor;
	dataset.baseParams["excelType"]="1";  //导出类型 0：导出当前页；1：导出符合查询条件所有记录
	dataset.baseParams["startExcel"]=startCursor;  //总记录中当前页记录起始位置
	dataset.baseParams["limitExcel"]=dataset.getTotalCount();  //导出记录数，如导出类型为导出符合查询条件所有记录时，其值为ds.getTotalCount()
	L5.dataset2excel(dataset,"/jsp/ext/mbalance/manage/samMBalanceExcel.jsp");
	dataset.baseParams["excelType"]="reset"; //重置导出类型
} 