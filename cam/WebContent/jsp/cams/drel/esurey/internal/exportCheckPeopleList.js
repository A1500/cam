function init(){
	applyDataSet.load();
	InTheWarrantyDs.load();
}
//导出Excel
function exportNew(){
	var grid = L5.getCmp('daiBanGridPanel2');
	var sm = grid.getSelectionModel();
	var records=sm.getSelections();
	
	var domicileCode=records[0].get("DOMICILE_CODE");
	var applyType=records[0].get("APPLY_TYPE");
	var dataset=L5.DatasetMgr.lookup("applyDetail");
	dataset.setParameter("domicileCode",domicileCode.substr(0,6));
	dataset.setParameter("applyType",applyType);
	dataset.load(true);
	if(dataset.getCount()>0){
		var pageSize = dataset.pageInfo.pageSize;
		var pageIndex = dataset.pageInfo.pageIndex;
		var startCursor = dataset.pageInfo.startCursor;
		dataset.baseParams["excelType"]="1";  //导出类型 0：导出当前页；1：导出符合查询条件所有记录
		dataset.baseParams["startExcel"]=startCursor;  //总记录中当前页记录起始位置
		dataset.baseParams["limitExcel"]=pageSize;  //导出记录数，如导出类型为导出符合查询条件所有记录时，其值为dataset.getTotalCount()
		L5.dataset2excel(dataset, "/jsp/cams/drel/export/commExcel.jsp?domicileCode="+domicileCode);
		//disDateStart="+disDateStart+"&disDateEnd="+disDateEnd+"&empDateStart="+empDateStart+"&empDateEnd="+empDateEnd+"&expDateStart="+expDateStart+"&expDateEnd="+expDateEnd+"&checkDate="+checkDate
		dataset.baseParams["excelType"]="reset"; //重置导出类型

	}else{
		L5.Msg.alert("提示","请至少选择一条记录！");
	}
}

//导出Excel
function batchExportNew(){
	var grid = L5.getCmp('daiBanGridPanel2');
	var sm = grid.getSelectionModel();
	var records=sm.getSelections();
	
	var dataset=L5.DatasetMgr.lookup("applyDetail");
	dataset.load(true);
	if(dataset.getCount()>1){
		var pageSize = dataset.pageInfo.pageSize;
		var pageIndex = dataset.pageInfo.pageIndex;
		var startCursor = dataset.pageInfo.startCursor;
		dataset.baseParams["excelType"]="1";  //导出类型 0：导出当前页；1：导出符合查询条件所有记录
		dataset.baseParams["startExcel"]=startCursor;  //总记录中当前页记录起始位置
		dataset.baseParams["limitExcel"]=pageSize;  //导出记录数，如导出类型为导出符合查询条件所有记录时，其值为dataset.getTotalCount()
		L5.dataset2excel(dataset, "/jsp/cams/drel/export/commExcel.jsp");
		dataset.baseParams["excelType"]="reset"; //重置导出类型

	}else{
		L5.Msg.alert("提示","请至少选择一条记录！");
	}
}

//测试
//导出核对结果信息
function exportXML(){
	var grid=L5.getCmp("daiBanGridPanel");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请至少先选中一行!");
		return;
	}
	var domicileCode=records[0].get("DOMICILE_CODE");
	var applyType=records[0].get("APPLY_TYPE");
	
	applyDetail.setParameter("domicileCode",domicileCode.substr(0,6));
	applyDetail.setParameter("applyType",applyType);
	applyDetail.load(true);
	
	
	
	var applyIds="";
	for(var i =0; i<applyDetail.getCount(); i++){
		applyIds+=applyDetail.getAt(i).get("APPLY_ID")+",";
	}
	var command = new L5.Command("com.inspur.cams.drel.ensureInfo.cmd.EnsureToClientCmd");
	command.setParameter("applyIds",applyIds);
	command.execute("createXML");
	if(!command.error){
		L5.Msg.alert("提示","导出成功！");
	}else{
		L5.Msg.alert("提示","导出失败！"+command.error);
	}
}


function showEnsureInfo(){
	var grid = L5.getCmp('daiBanGridPanel');
	var sm = grid.getSelectionModel();
	var records=sm.getSelections();
	if(records.length==1){
		if(records[0].get("ENSURE_ID")==""){
			L5.Msg.alert("提示","核对信息未反馈！");
			return;
		}
		var applyId=records[0].get("APPLY_ID");
		var url = "../../../comm/ensureInfo/ensureToClientDetail.jsp?applyId="+applyId;
		var width = "1200";
	    var height = "300";
	    //var width = screen.availWidth;
	    //var height = screen.availHeight;
		var returnValue = window.showModalDialog(url, window, "scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:0");
		if(true || returnValue) {
			//reQuery();
		}
	}else{
		L5.Msg.alert("提示","请选择一条记录！");
	}
}

//链接明细
function editHref(value,cellmeta,record,rowindex,colindex,dataset){
		return 	'<a href="javascript:detail(\''+record.get("DOMICILE_CODE")+','+record.get("APPLY_TYPE")+','+record.get("TOWN_NAME")+'\')">'+value+'</a>';
}
function detail(domicileCode){
	var str = domicileCode.split(",");
	var url = "ensurePeopleInfoList.jsp?domicileCode="+str[0]+"&applyType="+str[1]+"&townName="+encodeURIComponent(encodeURIComponent(str[2]));
	var width = screen.availWidth;
    var height = screen.availHeight;
	var returnValue = window.showModalDialog(url, window, "scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:0");
	if(true || returnValue) {
		//reQuery();
	}
}

/***************************************在保人员********************************************/

//导出Excel
function exportDetail11(){
	var grid = L5.getCmp('daiBanGridPanel');
	var sm = grid.getSelectionModel();
	var records=sm.getSelections();
	
	var domicileCode=records[0].get("DOMICILE_CODE");
	var applyType=records[0].get("APPLY_TYPE");
	
	var dataset=L5.DatasetMgr.lookup("inAssitanceDs");
	dataset.setParameter("domicileCode",domicileCode.substr(0,6));
	dataset.setParameter("applyType",applyType);
	dataset.load(true);
	alert(dataset.getCount());
	L5.Msg.wait("正在导出...");
	L5.Ajax.timeout = 900000;
	if(dataset.getCount()>1){
		var pageSize = dataset.pageInfo.pageSize;
		var pageIndex = dataset.pageInfo.pageIndex;
		var startCursor = dataset.pageInfo.startCursor;
		dataset.baseParams["excelType"]="1";  //导出类型 0：导出当前页；1：导出符合查询条件所有记录
		dataset.baseParams["startExcel"]=startCursor;  //总记录中当前页记录起始位置
		dataset.baseParams["limitExcel"]=pageSize;  //导出记录数，如导出类型为导出符合查询条件所有记录时，其值为dataset.getTotalCount()
		L5.dataset2excel(dataset, "/jsp/cams/drel/export/commExcel.jsp");
		
		//disDateStart="+disDateStart+"&disDateEnd="+disDateEnd+"&empDateStart="+empDateStart+"&empDateEnd="+empDateEnd+"&expDateStart="+expDateStart+"&expDateEnd="+expDateEnd+"&checkDate="+checkDate
		dataset.baseParams["excelType"]="reset"; //重置导出类型

	}else{
		L5.Msg.alert("提示","请至少选择一条记录！");
	}
	setTimeout(stopLoad, 9000);
}

function exportDetail() {
	
	var grid = L5.getCmp('daiBanGridPanel');
	var sm = grid.getSelectionModel();
	var records=sm.getSelections();
	
	var domicileCode=records[0].get("DOMICILE_CODE");
	var applyType=records[0].get("APPLY_TYPE");
	
	var dataset=L5.DatasetMgr.lookup("inAssitanceDs");
	dataset.setParameter("domicileCode",domicileCode.substr(0,6));
	dataset.setParameter("applyType",applyType);
	dataset.load(true);
	var pageSize = dataset.pageInfo.pageSize;
	var pageIndex = dataset.pageInfo.pageIndex;
	var startCursor = dataset.pageInfo.startCursor;
	var filename="在保人员导出";
	var class_path = "com.inspur.cams.comm.excel.SamReleaseExcelCommand";
	var gridObj = L5.getCmp("daiBanGridPanel3");
	L5.grid2excel(dataset, gridObj, filename, class_path);
}
function stopLoad(){
	L5.Msg.hide();
}
//导出Excel
function batchExport(){
	var dataset=L5.DatasetMgr.lookup("inAssitanceDs");
	dataset.load(true);
	var pageSize = dataset.pageInfo.pageSize;
	var pageIndex = dataset.pageInfo.pageIndex;
	var startCursor = dataset.pageInfo.startCursor;
	dataset.baseParams["excelType"]="1";  //导出类型 0：导出当前页；1：导出符合查询条件所有记录
	dataset.baseParams["startExcel"]=startCursor;  //总记录中当前页记录起始位置
	dataset.baseParams["limitExcel"]=pageSize;  //导出记录数，如导出类型为导出符合查询条件所有记录时，其值为dataset.getTotalCount()
	L5.dataset2excel(dataset, "/jsp/cams/drel/export/commExcel.jsp");
	dataset.baseParams["excelType"]="reset"; //重置导出类型
}

