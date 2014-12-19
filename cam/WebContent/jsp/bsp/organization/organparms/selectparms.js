

function search(){
	 var parmsTypeDs = L5.DatasetMgr.lookup("parmsTypeDs");
	 var name = document.getElementById("name").value
	 if(name!=''){
	 	parmsTypeDs.setParameter("ORGAN_PARMS_NAME",name);
	 }
	 parmsTypeDs.load();
}

function  confirmValue(){
	var parmsGrid=L5.getCmp('parmsGrid');
	//判断是否选择了要删除的记录
	var selected = parmsGrid.getSelectionModel().getSelections();
	//alert(selected.length);
	if(selected.length<1){
		L5.Msg.alert('提示',"请选择一条记录");
		return false;
	}else{
		var record=selected[0];
		var organParmsName=record.get("organParmsName");
		var organParmsDes=record.get("organParmsDes");
		window.returnValue=organParmsName+";"+organParmsDes;
		window.close();
	}
}

function closew(){
	//return false;
	window.returnValue="";
	window.close();

}

