function init(){
	var daiBanDataset = L5.DatasetMgr.lookup("daiBanDataset");
	daiBanDataset.setParameter("applyType","3");
	daiBanDataset.load();
}
function queryDaiban(){
	var daiBanDataset = L5.DatasetMgr.lookup("daiBanDataset");
	var queryCompanyName=document.getElementById("queryCompanyName").value;
	daiBanDataset.setParameter("companyName",queryCompanyName);
	daiBanDataset.setParameter("applyType","3");
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
	var applyState=selected[0].get("APPLY_STAUTS");
	if(applyState=="5"){
		L5.Msg.alert('提示',"换证审批未通过，不能进行证书打印!");
		return false;
	}else if(applyState=="4"){
		var url='jsp/cams/welfare/prosthesis/certChange/tasklist/certChangeCertPrint.jsp'
			+'?taskCode='+selected[0].get("TASK_CODE");
		var text = '换证证书打印';
		//L5.forward(url,text,data);
		L5.forward(url);
	}
}
