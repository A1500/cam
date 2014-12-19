function init(){
}
function queryItem(){
	var somOrganDataset=L5.DatasetMgr.lookup("somOrganDataset");
	somOrganDataset.setParameter("SORG_TYPE","S");
	somOrganDataset.setParameter("CN_NAME",_$("cnName"));
	somOrganDataset.setParameter("SORG_CODE",_$("sorgCode"));
	somOrganDataset.load();
}
// 进入归档页面
function archives(){
	var grid=L5.getCmp("organGrid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var data=new L5.Map();
	data.put("sorgId",(records[0].get("sorgId")));
	var url="jsp/cams/sorg/archives/group/groupArchivesEdit.jsp";
	L5.forward(url,'',data);
}
