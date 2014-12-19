function init(){
		var ensureToClientDataSet=L5.DatasetMgr.lookup("ensureToClientDataSet");
		ensureToClientDataSet.setParameter("APPLY_ID@=",applyId);
		ensureToClientDataSet.load();
}
function closeWin(){
	window.close();
}
function showHistory(){
	var url = "ensureToClientList.jsp";
	var width = screen.availWidth;
    var height = screen.availHeight;
	var returnValue = window.showModalDialog(url, window, "scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:0");
	if(true || returnValue) {
		//reQuery();
	}
}


function showEnsureInfo(){
	var grid = L5.getCmp('daiBanGridPanel');
	var sm = grid.getSelectionModel();
	var records=sm.getSelections();
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
}