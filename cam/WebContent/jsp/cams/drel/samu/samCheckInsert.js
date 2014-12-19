function init(){
	var samCheckDetailDataSet=L5.DatasetMgr.lookup("samCheckDetailDataSet");
		samCheckDetailDataSet.setParameter("gerocomiumId",gerocomiumId);
		samCheckDetailDataSet.setParameter("checkDate",checkDate);
		samCheckDetailDataSet.load();
}
function save(){
	var samCheckDetailDataSet=L5.DatasetMgr.lookup("samCheckDetailDataSet");
	var valid=samGeroKeptPersonDataSet.isValidate(true);
	if(valid!=true){
		L5.Msg.alert("提示","校验未通过，不能保存！"+valid);
		return false;
	}
}
function insertRecord(){
	var win=L5.getCmp("insertWin");
	win.show(this);
	var samGeroKeptPersonDataSet=L5.DatasetMgr.lookup("samGeroKeptPersonDataSet");
	samGeroKeptPersonDataSet.setParameter("GEROCOMIUM_ID@=",gerocomiumId);
	samGeroKeptPersonDataSet.setParameter("IS_STATUS@=","1");
	samGeroKeptPersonDataSet.load();
}
function deleteRecord(){
	var grid=L5.getCmp("infoQueryGrid");
	var records=grid.getSelectionModel().getSelections();
	var samCheckDetailDataSet=L5.DatasetMgr.lookup("samCheckDetailDataSet");
	if(records.length==0){
		L5.Msg.alert("提示","请选择删除记录！");
		return false;
	}
	for(var i=0;i<records.length;i++){
		samCheckDetailDataSet.remove(records[i]);
	}
}
function saveInsert(){
	var samCheckDetailDataSet=L5.DatasetMgr.lookup("samCheckDetailDataSet");
	var record=samCheckDetailDataSet.newRecord();
	var grid=L5.getCmp("insertDetail");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请选择要增加的供养对象！");
		return false;
	}else{
		var command=new L5.Command("com.inspur.cams.drel.samu.cmd.SamGeroApplyCmd");
		for(var i=0;i<records.length;i++){
			var commandId=new L5.Command("com.inspur.cams.comm.util.IdHelpCmd");
			commandId.setParameter("IdHelp","Id32");
			commandId.execute();
			var newId=commandId.getReturn("id");
			record.set("personId",records[i].get('personId'));
			record.set("gerocomiumId",records[i].get('gerocomiumId'));
			record.set("applyId",newId);
			record.set("applyType","4");
			record.set("checkDate",checkDate);
			record.set("checkResult","0");
			command.setParameter("record",record);
			command.execute("insert");
		}
		if (!command.error){
			closeInsertWin();
			var samCheckDetailDataSet=L5.DatasetMgr.lookup("samCheckDetailDataSet");
			samCheckDetailDataSet.setParameter("gerocomiumId",gerocomiumId);
			samCheckDetailDataSet.setParameter("checkDate",checkDate);
			samCheckDetailDataSet.load();
		}else{
			L5.Msg.alert("提示","保存出错！");
		}
	}
}
function closeInsertWin(){
	L5.getCmp("insertWin").setVisible(false);
}
function saveRecord(){
	var samCheckDetailDataSet=L5.DatasetMgr.lookup("samCheckDetailDataSet");
	var records=samCheckDetailDataSet.getAllChangedRecords();
	var command=new L5.Command("com.inspur.cams.drel.samu.cmd.SamGeroApplyCmd");
	command.setParameter("records",records);
	command.execute("saveCheck");
	if (!command.error){
		L5.Msg.alert("提示","维护名册成功！",function(){
			window.close();
		});
	}else{
		L5.Msg.alert("提示","维护名册出错！");
	}
}
function returnBack(){
	window.close();
	var parent=window.dialogArguments;
	var samListDataSet=parent.samListDataSet;
	samListDataSet.load();
}