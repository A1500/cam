function init() {
	var keptPersonDs=L5.DatasetMgr.lookup("pocketApplyDetailDs");
	pocketApplyDetailDs.setParameter("gerocomiumId",gerocomiumId);
	pocketApplyDetailDs.setParameter("pocketYm",pocketYm);
	pocketApplyDetailDs.load();
	
}

function query(){
	var pocketApplyDetailDs = L5.DatasetMgr.lookup("pocketApplyDetailDs");
	pocketApplyDetailDs.setParameter("gerocomiumId",gerocomiumId);
	pocketApplyDetailDs.setParameter("pocketYm",pocketYm);	
	pocketApplyDetailDs.setParameter("personName",getParam("personNameQuery"));	
	pocketApplyDetailDs.setParameter("idCard",getParam("idCardQuery"));
	pocketApplyDetailDs.setParameter("inRoom",getParam("inRoomQuery"));
	pocketApplyDetailDs.setParameter("inBed",getParam("inBedQuery"));		
	pocketApplyDetailDs.load();
}
function getParam(ElementId) {
	var value = document.getElementById(ElementId).value;
	if (value == "")
		value = undefined;
	return value;
}
function conf(){
	var pocketApplyDetailDs=L5.DatasetMgr.lookup("pocketApplyDetailDs");
		var records=pocketApplyDetailDs.getAllChangedRecords();
		var command=new L5.Command("com.inspur.cams.drel.samu.cmd.SamGeroApplyCmd");
		command.setParameter("records",records);
		command.execute("saveCheckM");
		if (!command.error){
			L5.Msg.alert("提示","维护名册成功！",function(){
				returnBack();
			});
		}else{
			L5.Msg.alert("提示","维护名册出错！");
		}
}

function insert() {
	var recordPersonId=new Array();
	var win=L5.getCmp("applyDetailWin");
	win.show(this);
	var samGeroKeptPersonDataSet=L5.DatasetMgr.lookup("samGeroKeptPersonDataSet");
	var pocketApplyDetailDs=L5.DatasetMgr.lookup("pocketApplyDetailDs");
	var records=pocketApplyDetailDs.getAllRecords();
	samGeroKeptPersonDataSet.setParameter("gerocomiumId",gerocomiumId);
	if(records.length==0){
		samGeroKeptPersonDataSet.load();
	}else{
		for(var i=0;i<records.length;i++){
			recordPersonId[i]=records[i].get('PERSON_ID');
		}
		samGeroKeptPersonDataSet.setParameter("recordPersonId",recordPersonId);
		samGeroKeptPersonDataSet.load();
	}

}

function delPocketDetail() {
	var editGrid = L5.getCmp('editGridPanel');
	var records= editGrid.getSelectionModel().getSelections();
	var pocketApplyDetailDs=L5.DatasetMgr.lookup("pocketApplyDetailDs");
	if (records.length < 1) {
		L5.Msg.alert('提示', "请选择要删除的记录!");
		return false;
	}
	for(var i=0;i<records.length;i++){
		pocketApplyDetailDs.remove(records[i]);
	}
}

function closeInsertWin(){
	L5.getCmp("applyDetailWin").setVisible(false);
}

function saveInsert(){
	var pocketApplyDs=L5.DatasetMgr.lookup("pocketApplyDs");
	
	var grid=L5.getCmp("insertDetail");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请选择要增加的供养对象！");
		return false;
	}else{
		for(var i=0;i<records.length;i++){
			var pocketApplyDetailDs=L5.DatasetMgr.lookup("pocketApplyDetailDs");
			pocketApplyDetailDs.newRecord({PERSON_NAME :records[i].get('PERSON_NAME'),
											 PERSON_ID :records[i].get('PERSON_ID'),
											 GEROCOMIUM_ID :records[i].get('GEROCOMIUM_ID'),
											 ID_CARD :records[i].get('ID_CARD'),
											 IN_ROOM :records[i].get('IN_ROOM'),
											 IN_BED :records[i].get('IN_BED'),
											 POCKET_YM :pocketYm
											});
		}
		closeInsertWin();
		/*var record=pocketApplyDs.newRecord();
		var command=new L5.Command("com.inspur.cams.drel.samu.cmd.SamGeroApplyCmd");
		for(var i=0;i<records.length;i++){
			var commandId=new L5.Command("com.inspur.cams.comm.util.IdHelpCmd");
			commandId.setParameter("IdHelp","Id32");
			commandId.execute();
			var newId=commandId.getReturn("id");
			record.set("personId",records[i].get('PERSON_ID'));
			record.set("gerocomiumId",records[i].get('GEROCOMIUM_ID'));
			record.set("applyId",newId);
			record.set("applyType","2");
			record.set("pocketYm",pocketYm);
			record.set("pocketStatus","0");
			record.set("pocketMoney","");
			command.setParameter("record",record);
			command.execute("insert");
		}
		if (!command.error){
			closeInsertWin();
			var pocketApplyDetailDs=L5.DatasetMgr.lookup("pocketApplyDetailDs");
			pocketApplyDetailDs.setParameter("gerocomiumId",gerocomiumId);
			pocketApplyDetailDs.setParameter("pocketYm",pocketYm);
			pocketApplyDetailDs.load();
		}else{
			L5.Msg.alert("提示","保存出错！");
		}**/
	}
}
function returnBack(){
	window.close();
	var parent=window.dialogArguments;
	var geroApplyDs=parent.geroApplyDs;
	geroApplyDs.setParameter("areaLevelId",organCode);
	geroApplyDs.load();
}