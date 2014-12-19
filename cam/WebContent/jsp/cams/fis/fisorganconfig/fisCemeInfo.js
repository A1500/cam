function init(){
	var CemeInfoDs = L5.DatasetMgr.lookup("CemeInfoDs");
    if(fisCemeCodeRec==""||fisCemeCodeRec=="undefined"){
    	CemeInfoDs.setParameter("sort","ORGAN_ID");
    	CemeInfoDs.setParameter("dir","ASC");
    	CemeInfoDs.load(true);
    }else{
    	CemeInfoDs.setParameter("ORGAN_ID@LIKE",fisCemeCodeRec);
    	CemeInfoDs.load(true);
    }
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

function query(){
	var cemeInfoDs = L5.DatasetMgr.lookup("CemeInfoDs");
	var name=document.getElementById("cemeteryName").value;
	      cemeInfoDs.setParameter("NAME@LIKE",name);
	      cemeInfoDs.load(true);
}