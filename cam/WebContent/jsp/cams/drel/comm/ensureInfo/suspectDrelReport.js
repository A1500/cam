function init() {
	suspectds.load();
	if(codeLength=="9"){
		L5.getCmp("cityGrid").hide();
	}else{
		L5.getCmp("countryGrid").hide();
	}
}
function detail(){
	var grid = L5.getCmp('countryGrid');
	var sm = grid.getSelectionModel();
	var records=sm.getSelections();
	if(records.length!=1){
		L5.Msg.alert("提示","请选择一条记录！");
		return;
	}
	var _url="peopleInfoDetail.jsp?commissionId="+records[0].get("APPLY_ID");
	var width = screen.width;
	var height = screen.height;
	var returnValue = window.showModalDialog(_url, window,
			"scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:"
					+ height + "px;resizable:0");
}

