function init(){
	var CemeInfoDs = L5.DatasetMgr.lookup("CemeInfoDs");
	CemeInfoDs.setParameter("MANA_LEVEL_ID",manaCode);
	CemeInfoDs.setParameter("PROP",prop);
	if(isYs=='1'){
		CemeInfoDs.setParameter("ORGAN_STATE@IN","4,6");
	}
	else{
		CemeInfoDs.setParameter("ORGAN_STATE","0");
	}
	CemeInfoDs.load(true);
}
//选中回填
function select(){
	var selected = L5.getCmp("grid").getSelectionModel().getSelections();
	if (selected.length != 1) {
		L5.Msg.alert("提示", "请选中一条记录！");
		return;
	}
	window.returnValue = selected[0].get("organId") + ',' + selected[0].get("name") + ',' + selected[0].get("recordId");
	window.close();
}
