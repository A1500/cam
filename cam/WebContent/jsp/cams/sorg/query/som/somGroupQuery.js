
function returnQueryList(){
	window.history.go(-1);
}

function examine(){
	var grid = L5.getCmp("grid");
	var sm = grid.getSelectionModel();
	var record = sm.getSelected();
	if(!record){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var winPresidePeopleDataSet = L5.DatasetMgr.lookup("winPresidePeopleDataSet");
	winPresidePeopleDataSet.setParameter("SORG_ID@=",sorgId);
	winPresidePeopleDataSet.setParameter("PEOPLE_ID@=",record.get("peopleId"));
	winPresidePeopleDataSet.setParameter("PEOPLE_TYPE@=", "C");
	winPresidePeopleDataSet.setParameter("IF_VALID@=", "2");
	winPresidePeopleDataSet.load();
	var win = L5.getCmp("win");
	win.show();
}
function closeWin(){
	var win = L5.getCmp("win");
	win.hide();
}