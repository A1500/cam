function init(){

}

function query(){
	if(_$("unitNameID")!=""){
		ds.setParameter("UNIT_NAME@like", _$("unitNameID"));
	}
	if(_$("businessCategoryID")!=""){
		ds.setParameter("BUSINESS_CATEGORY@=", _$("businessCategoryID"));
	}
	var queryDate = _$("queryDate");
	if(queryDate!=""){
		if(queryDate!='' && queryDate.indexOf('~')!=-1){//alert('buildDate');
			ds.setParameter("QUERY_DATE@between",queryDate);
		}
		if(queryDate!='' && queryDate.indexOf('~')==-1){//alert('buildDate');
			ds.setParameter("QUERY_DATE@like",queryDate);
		}
	}
	ds.load();
}

function exportExcel(){
	var dataset=L5.DatasetMgr.lookup("ds");	
	if(dataset.getCount()<=0){
		L5.Msg.alert('提示', "无查询结果，不能导出!");
		return false;
	}	
	L5.dataset2excel(ds, "/jsp/ext/dataexchange/manage/exportExchangeLogExcel.jsp");
}

function queryDetails(){

}