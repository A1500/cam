//页面初始化
function init() {
	var gvnReportDS=L5.DatasetMgr.lookup("gvnReportDS");
	gvnReportDS.setParameter("endTime",getCurDate());	
//	gvnReportDS.setParameter("domicileCode",organCode);
//	gvnReportDS.load();
}
//查询方法
function query(){
	var gvnReportDS=L5.DatasetMgr.lookup("gvnReportDS");
	gvnReportDS.setParameter("hosStatus","0");	
	if(getParam("qapanageCode")){
		gvnReportDS.setParameter("domicileCode",getParam("qapanageCode"));		
	}else{
		gvnReportDS.setParameter("domicileCode",organCode);
	}
	gvnReportDS.setParameter("beginTime",getParam("beginTime"));		
	gvnReportDS.setParameter("endTime",getParam("endTime"));			
	gvnReportDS.setParameter("sex",getParam("qSex"));			
	gvnReportDS.setParameter("hospitalId",getParam("hosId"));
	gvnReportDS.setParameter("name",getParam("name"));
	gvnReportDS.setParameter("idCard",getParam("idCard"));
	var sAge=getParam("sAge");
	var eAge=getParam("eAge");
	if(sAge){
		gvnReportDS.setParameter("sAge",(new Date().getFullYear()-sAge)+'-'+(new Date()+'').substring(5));
	}
	if(eAge){
		gvnReportDS.setParameter("eAge",(new Date().getFullYear()-eAge)+'-'+(new Date()+'').substring(5));
	}
	gvnReportDS.setParameter("qAssistanceType",getParam("qAssistanceType"));
	gvnReportDS.setParameter("dataSource",getParam("dataSource"));
	
	gvnReportDS.load();
}
function ToExcel(){
	var dataset=L5.DatasetMgr.lookup("gvnReportDS");
	if(dataset.getCount()<1){
		L5.Msg.alert("提示","没有要导出的信息！");
		return;
	}
	var pageSize = dataset.pageInfo.pageSize;
	var pageIndex = dataset.pageInfo.pageIndex;
	var startCursor = dataset.pageInfo.startCursor;
	dataset.baseParams["excelType"]="1";  //导出类型 0：导出当前页；1：导出符合查询条件所有记录
	dataset.baseParams["startExcel"]=startCursor;  //总记录中当前页记录起始位置
	dataset.baseParams["limitExcel"]=dataset.getTotalCount();  //导出记录数，如导出类型为导出符合查询条件所有记录时，其值为ds.getTotalCount()
	L5.dataset2excel(dataset,"/jsp/cams/drel/mbalance/samMBalanceExcel.jsp");
	dataset.baseParams["excelType"]="reset"; //重置导出类型
} 