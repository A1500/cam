function init(){
	var jcmPeopleInfoDataSet=L5.DatasetMgr.lookup("jcmPeopleInfoDataSet");
	jcmPeopleInfoDataSet.setParameter("COMPANY_ID",companyId);
	jcmPeopleInfoDataSet.load(true);
}
//选中回填
function select(){
	var selected = L5.getCmp("grid").getSelectionModel().getSelections();
	if (selected.length != 1) {
		L5.Msg.alert("提示", "请选中一条记录！");
		return;
	}
	window.returnValue = selected[0].get("peopleId") + ',' + selected[0].get("companyId") + ',' + selected[0].get("peopleName");
	window.close();
}