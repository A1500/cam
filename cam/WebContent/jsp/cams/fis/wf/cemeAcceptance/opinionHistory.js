function init(){
	var hisDs = L5.DatasetMgr.lookup("hisDs");
	hisDs.setParameter("cemeApplyId",cemeApplyId);
	hisDs.load(true);
}

//单击返回按钮
function returnClick(){
	history.go(-1);
}
function hisDetail(){
	var userGrid=L5.getCmp("cemePanel");
	var selected = userGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert("提示","请选择一条记录进行处理!");
		return false;
	}
	var historyBackup = L5.DatasetMgr.lookup("historyBackup");
	historyBackup.setParameter("HIS_ID@=",selected[0].get("HIS_ID"));
	historyBackup.load(true);
	var win=L5.getCmp("cemeWin");
	win.show()
	
}