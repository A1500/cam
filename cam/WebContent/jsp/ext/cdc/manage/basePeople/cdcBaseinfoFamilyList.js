function init(){
	var cdcBaseinfoPeopleDataSet=L5.DatasetMgr.lookup("cdcBaseinfoPeopleDataSet");
	cdcBaseinfoPeopleDataSet.setParameter("DOMICILE_CODE@=",organCode);
	cdcBaseinfoPeopleDataSet.setParameter("RELATIONSHIP_TYPE@=",'01');
	cdcBaseinfoPeopleDataSet.setParameter("sort","ROWID");
	cdcBaseinfoPeopleDataSet.setParameter("dir","desc");
	cdcBaseinfoPeopleDataSet.load();
}
function query(){
	var cdcBaseinfoPeopleDataSet=L5.DatasetMgr.lookup("cdcBaseinfoPeopleDataSet");
	cdcBaseinfoPeopleDataSet.setParameter("NAME@LIKE",getParam("query_name"));
	cdcBaseinfoPeopleDataSet.setParameter("ADDRESS@LIKE",getParam("query_address"));
	
	cdcBaseinfoPeopleDataSet.setParameter("DOMICILE_CODE@=",organCode);
	cdcBaseinfoPeopleDataSet.setParameter("RELATIONSHIP_TYPE@=",'01');
	cdcBaseinfoPeopleDataSet.setParameter("sort","ROWID");
	cdcBaseinfoPeopleDataSet.setParameter("dir","desc");
	cdcBaseinfoPeopleDataSet.load();
}
function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}
function addFamily(){
	var data=new L5.Map();
	data.put("method","insert");
	var url="jsp/ext/cdc/manage/basePeople/cdcBaseinfoFamilyHeadEdit.jsp";
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
	data.put("databeanId",records[0].get("peopleId"));
	var url="jsp/ext/cdc/manage/basePeople/cdcBaseinfoFamilyUpdateEdit.jsp";
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
	data.put("peopleId",records[0].get("peopleId"));
	var url="jsp/ext/cdc/manage/basePeople/cdcBaseinfoPeopleDetail.jsp";
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
			var command=new L5.Command("com.inspur.cams.cdc.base.cmd.CdcBaseinfoPeopleCmd");
			command.setParameter("peopleId",records[0].get("peopleId"));
			command.execute("deleteFamily");
			if (!command.error){
				var cdcBaseinfoPeopleDataSet=L5.DatasetMgr.lookup("cdcBaseinfoPeopleDataSet");
				cdcBaseinfoPeopleDataSet.reload();
			}else{
				L5.Msg.alert("提示","删除出错！");
			}
		}
	});
}