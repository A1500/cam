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
function query(){
	var samCheckDetailDataSet=L5.DatasetMgr.lookup("samCheckDetailDataSet");
	samCheckDetailDataSet.setParameter("gerocomiumId",gerocomiumId);
	samCheckDetailDataSet.setParameter("checkDate",checkDate);
	samCheckDetailDataSet.setParameter("personName",document.getElementById("personNameQuery").value);
	samCheckDetailDataSet.setParameter("idCard",document.getElementById("idCardQuery").value);
	samCheckDetailDataSet.setParameter("inRoom",document.getElementById("inRoomQuery").value);
	samCheckDetailDataSet.setParameter("inBed",document.getElementById("inBedQuery").value);
	samCheckDetailDataSet.load();
}
function insertRecord(){
	var recordPersonId=new Array();
	var win=L5.getCmp("insertWin");
	win.show(this);
	var samGeroKeptPersonDataSet=L5.DatasetMgr.lookup("samGeroKeptPersonDataSet");
	var samCheckDetailDataSet=L5.DatasetMgr.lookup("samCheckDetailDataSet");
	var records=samCheckDetailDataSet.getAllRecords();
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
	var samGeroApplyDataSet=L5.DatasetMgr.lookup("samGeroApplyDataSet");
	var grid=L5.getCmp("insertDetail");
	var records=grid.getSelectionModel().getSelections();
	var recordAdd=new Array();
	if(records.length==0){
		L5.Msg.alert("提示","请选择要增加的供养对象！");
		return false;
	}else{
		for(var i=0;i<records.length;i++){
			var samCheckDetailDataSet=L5.DatasetMgr.lookup("samCheckDetailDataSet");
			samCheckDetailDataSet.newRecord({PERSON_NAME :records[i].get('PERSON_NAME'),
											 PERSON_ID :records[i].get('PERSON_ID'),
											 GEROCOMIUM_ID :records[i].get('GEROCOMIUM_ID'),
											 ID_CARD :records[i].get('ID_CARD'),
											 IN_ROOM :records[i].get('IN_ROOM'),
											 IN_BED :records[i].get('IN_BED'),
											 CHECK_DATE :checkDate,
											 CHECK_RESULT :remarks,
											 REMARKS :remarks    	});
		}
		closeInsertWin();
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
			returnBack();
		});
	}else{
		L5.Msg.alert("提示","维护名册出错！");
	}
}
function returnBack(){
	window.close();
	var parent=window.dialogArguments;
	var samListDataSet=parent.samListDataSet;
	samListDataSet.setParameter("areaLevelId",organCode);
	samListDataSet.load();
}