function init(){
	var FuneralInfoDs = L5.DatasetMgr.lookup("FuneralInfoDs");
	FuneralInfoDs.load(true);
	if(fisFuneralCodeRec==""||fisFuneralCodeRec=="undefined"){
		FuneralInfoDs.setParameter("sort","UNIT_ID");
		FuneralInfoDs.setParameter("dir","ASC");
		  FuneralInfoDs.load(true);
	}else{
	      FuneralInfoDs.setParameter("UNIT_ID@LIKE",fisFuneralCodeRec);
	      FuneralInfoDs.load(true);
	}

}
//选中回填
function select(){
	var selected = L5.getCmp("grid").getSelectionModel().getSelections();
	if (selected.length != 1) {
		L5.Msg.alert("提示", "请选中一条记录！");
		return;
	}
	window.returnValue = selected[0].get("unitId") + ',' + selected[0].get("unitName");
	window.close();
}

function query(){
	var FuneralInfoDs = L5.DatasetMgr.lookup("FuneralInfoDs");
	var unitName=document.getElementById("funeralName").value;
		  FuneralInfoDs.setParameter("UNIT_NAME@LIKE",unitName);
	      FuneralInfoDs.load(true);
}