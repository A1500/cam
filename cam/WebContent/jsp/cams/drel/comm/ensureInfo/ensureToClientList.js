function init(){
	var ensureToClientDataSet=L5.DatasetMgr.lookup("ensureToClientDataSet");
	ensureToClientDataSet.load();
}
function query(){
	var ensureToClientDataSet=L5.DatasetMgr.lookup("ensureToClientDataSet");
	
	ensureToClientDataSet.load();
}
function insert(){
	var data=new L5.Map();
	data.put("method","insert");
	var url="jsp/cams/comm/ensureInfo/ensureToClientEdit.jsp";
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
	data.put("ensureId",records[0].get("ensureId"));
	var url="jsp/cams/comm/ensureInfo/ensureToClientEdit.jsp";
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
	data.put("ensureId",records[0].get("ensureId"));
	var url="jsp/cams/comm/ensureInfo/ensureToClientDetail.jsp";
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
			var command=new L5.Command("com.inspur.cams.comm.ensureInfo.cmd.EnsureToClientCmd");
			command.setParameter("ensureId",records[0].get("ensureId"));
			command.execute("delete");
			if (!command.error){
				var ensureToClientDataSet=L5.DatasetMgr.lookup("ensureToClientDataSet");
				ensureToClientDataSet.load();
			}else{
				L5.Msg.alert("提示","删除出错！");
			}
		}
	});
}