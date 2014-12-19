function init() {
	var ds = L5.DatasetMgr.lookup("ds");
	ds.setParameter("PEOPLE_ID",peopleId);
	ds.setParameter("serviceType",serviceType);
	ds.setParameter("ORGAN_ID", organCode);
	ds.load();
};


//打印预览调用方法
function printBill(){
	var printDataset=L5.DatasetMgr.lookup("ds");
	var url = L5.webPath+'/jsp/cams/bpt/edoc/print/Electronic2.fr3'; 
	var reportName="归档文件目录";
	
	doReportPrint(reportName,"fdfd","dfa",printDataset ,url);
}

