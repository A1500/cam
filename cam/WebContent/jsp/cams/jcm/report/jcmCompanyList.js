function init(){
	var jcmCompanyProfileDataSet=L5.DatasetMgr.lookup("jcmCompanyProfileDataSet");
	jcmCompanyProfileDataSet.load(true);
}
//选中回填
function select(){
	var selected = L5.getCmp("grid").getSelectionModel().getSelections();
	if (selected.length != 1) {
		L5.Msg.alert("提示", "请选中一条记录！");
		return;
	}
	window.returnValue = selected[0].get("companyId") + ',' + selected[0].get("companyName");
	window.close();
}