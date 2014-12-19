function init(){
	var cityDs=L5.DatasetMgr.lookup("cityDs");
	cityDs.setParameter("ups",organId);
	//cityDs.setParameter("LEVE@=","4");
	cityDs.load();
}

function insert(){
	var selectedGrid=L5.getCmp("selectedGrid");
	var records=selectedGrid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var ds=L5.DatasetMgr.lookup("userDs");
	var cityDs=L5.DatasetMgr.lookup("cityDs");
	for(var i=0;i<records.length;i++) {
		ds.newRecord({"userName":records[i].get("NAME"),"userId":records[i].get("ID"),"organId":organId,"pwd":"1","communityBelongs":records[i].get("ID"),"organName":organName,"organType":"SQ","areaCode":records[i].get("ID"),"areaName":records[i].get("NAME"),"communityType":"C"});
		cityDs.remove(records[i]);
	}
	var records = ds.getAllChangedRecords();
	var command=new L5.Command("com.inspur.cams.comm.extuser.cmd.ComExtUserCmd");
	command.setParameter("records",records);
	command.execute("saveUser");
	if (!command.error){
		for(var i=0;i<records.length;i++){
			var parentWin = window.parent.window;
			var tree = parentWin.L5.getCmp("usertree");
			var node = tree.getNodeByRecordId(organId, "cityRecord");
			var rec = new parentWin.L5.tree.TreeRecord.recordTypes["userRecord"](records[i].data, records[i].get("userId"));
			node.record.insert(rec);
		}
		L5.Msg.alert("提示","添加成功！");
	}else{
		L5.Msg.alert("提示","不能重复添加账号！");
	}
}

