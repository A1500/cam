function init(){
	var cdcOrganInfoDataSet=L5.DatasetMgr.lookup("cdcOrganInfoDataSet");
	cdcOrganInfoDataSet.setParameter("ORGAN_CODE@=",organCode);
	cdcOrganInfoDataSet.setParameter("ORGAN_TYPE@=","2");
	cdcOrganInfoDataSet.setParameter("sort","ROWID");
	cdcOrganInfoDataSet.setParameter("dir","desc");
	cdcOrganInfoDataSet.load();
}
function query(){
	var cdcOrganInfoDataSet=L5.DatasetMgr.lookup("cdcOrganInfoDataSet");
	cdcOrganInfoDataSet.setParameter("CORP_NAME@LIKE",getParam("query_name"));
	cdcOrganInfoDataSet.setParameter("ORGAN_KIND@=",getParam("query_kind"));
	cdcOrganInfoDataSet.setParameter("ORGAN_CODE@=",organCode);
	cdcOrganInfoDataSet.setParameter("ORGAN_TYPE@=","2");
	cdcOrganInfoDataSet.load();
}
function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}
function insert(){
	var data=new L5.Map();
	data.put("method","insert");
	var url="jsp/ext/cdc/manage/buildOrganInfo/cdcOrganInfoEdit.jsp";
	L5.forward(url,'',data);
}
function update(){
	var grid=L5.getCmp("grid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var data=new L5.Map();
	data.put("method","update");
	data.put("organId",records[0].get("organId"));
	var url="jsp/ext/cdc/manage/buildOrganInfo/cdcOrganInfoEdit.jsp";
	L5.forward(url,'',data);
}
function detail(){
	var grid=L5.getCmp("grid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var data=new L5.Map();
	data.put("organId",records[0].get("organId"));
	var url="jsp/ext/cdc/manage/buildOrganInfo/cdcOrganInfoDetail.jsp";
	L5.forward(url,'',data);
}
function del(){
	var grid=L5.getCmp("grid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length!=1){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	L5.MessageBox.confirm("提示", "是否删除该数据？",function(sta){
		if(sta=="yes"){
			var command=new L5.Command("com.inspur.cams.cdc.base.cmd.CdcOrganInfoCmd");
			command.setParameter("id",records[0].get("organId"));
			command.execute("delete");
			if (!command.error){
				var cdcOrganInfoDataSet=L5.DatasetMgr.lookup("cdcOrganInfoDataSet");
				cdcOrganInfoDataSet.reload();
			}else{
				L5.Msg.alert("提示","删除出错！");
			}
		}
	});
}