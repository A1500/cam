function init(){
	var daiBanDataset = L5.DatasetMgr.lookup("daiBanDataset");
	daiBanDataset.setParameter("applyType","1");
	daiBanDataset.load();
}
function queryDaiban(){
	var daiBanDataset = L5.DatasetMgr.lookup("daiBanDataset");
	var queryCompanyName=document.getElementById("queryCompanyName").value;
	daiBanDataset.setParameter("companyName",queryCompanyName);
	daiBanDataset.setParameter("applyType","1");
	daiBanDataset.load();
}
function print(){
	var editGrid=L5.getCmp('daiBanTaskGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录!");
		return false;
	}
	var data = new L5.Map();
	/*data.put("taskCode",selected[0].get("TASK_CODE"));
	data.put("applyState",selected[0].get("APPLY_STAUTS"));
	data.put("companyName",encodeURIComponent(selected[0].get("COMPANY_NAME")));
	alert(encodeURI(selected[0].get("COMPANY_NAME")));
	alert(selected[0].get("COMPANY_NAME"));*/
	var url='jsp/cams/welfare/prosthesis/apply/prosthesisQualification/applytask/qualificationPrintMain.jsp'
		+'?taskCode='+selected[0].get("TASK_CODE")
		+'&applyState='+selected[0].get("APPLY_STAUTS")+'&companyName='+encodeURI(encodeURI(selected[0].get("COMPANY_NAME")));
	var text = '认定信息采集';
	//L5.forward(url,text,data);
	L5.forward(url);
	
}
