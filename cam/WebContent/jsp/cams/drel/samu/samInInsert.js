function init(){
	var baseinfoPeopleDS=L5.DatasetMgr.lookup("baseinfoPeopleDS");
	if(method=="insert"){
		baseinfoPeopleDS.setParameter("domicileCode",organArea);
		baseinfoPeopleDS.setParameter("queryDate","2012-09");
		baseinfoPeopleDS.setParameter("supportWay","03");
		baseinfoPeopleDS.setParameter("inHospital",null);
		baseinfoPeopleDS.load();
	}else{
		samGeroKeptPersonDataSet.setParameter("PERSON_ID@=",personId);
		samGeroKeptPersonDataSet.load();
	}
}
function save(){
    var recordPerson=new Array();
    var recordApply=new Array();
	var baseinfoPeopleDS=L5.DatasetMgr.lookup("baseinfoPeopleDS");
	var grid=L5.getCmp("infoQueryGrid");
	var recordPeople=grid.getSelectionModel().getSelections();
	if(recordPeople.length==0){
		L5.Msg.alert("提示","请选中记录！");
		return false;
	}
	var samGeroKeptPersonDataSet=L5.DatasetMgr.lookup("samGeroKeptPersonDataSet");
	var valid=samGeroKeptPersonDataSet.isValidate(true);
	if(valid!=true){
		L5.Msg.alert("提示","校验未通过，不能保存！"+valid);
		return false;
	}
	var samGeroApplyDataSet=L5.DatasetMgr.lookup("samGeroApplyDataSet");
	var valid=samGeroApplyDataSet.isValidate(true);
	if(valid!=true){
		L5.Msg.alert("提示","校验未通过，不能保存！"+valid);
		return false;
	}
	if(method=="insert"){
		for(var i=0;i<recordPeople.length;i++){
			var samGeroKeptPersonDataSet=L5.DatasetMgr.lookup("samGeroKeptPersonDataSet");
			var samGeroApplyDataSet=L5.DatasetMgr.lookup("samGeroApplyDataSet");
			var command=new L5.Command("com.inspur.cams.comm.util.IdHelpCmd");
			command.setParameter("IdHelp","Id32");
			command.execute();
			var newId=command.getReturn("id");
			samGeroKeptPersonDataSet.newRecord({"personId":newId});
			recordPerson[i]=samGeroKeptPersonDataSet.getCurrent();
			samGeroApplyDataSet.newRecord({"personId":newId});
			recordApply[i]=samGeroApplyDataSet.getCurrent();
			recordPerson[i].set("personName",recordPeople[i].get('NAME'));
			recordPerson[i].set("sex",recordPeople[i].get('SEX'));
			recordPerson[i].set("idCard",recordPeople[i].get('ID_CARD'));
			recordPerson[i].set("birthday",getBirthByCode(recordPeople[i].get('ID_CARD')));
			recordPerson[i].set("nation",recordPeople[i].get('NATION_CODE'));
			recordPerson[i].set("familyAdd",recordPeople[i].get('ADDRESS'));
			recordPerson[i].set("politicsStatus",recordPeople[i].get('POLITICAL_CODE'));
			recordPerson[i].set("gerocomiumId",recordPeople[i].get('SUPPOTR_ORG'));
			recordPerson[i].set("inRoom",recordPeople[i].get('IN_ROOM'));
			recordPerson[i].set("inBed",recordPeople[i].get('IN_BED'));
			recordApply[i].set("inRoom",recordPeople[i].get('IN_ROOM'));
			recordApply[i].set("inBed",recordPeople[i].get('IN_BED'));
			recordApply[i].set("gerocomiumId",recordPeople[i].get('SUPPOTR_ORG'));
		}
	}
	var command=new L5.Command("com.inspur.cams.drel.samu.cmd.SamGeroKeptPersonCmd");
	command.setParameter("recordPerson",recordPerson);
	command.setParameter("recordApply",recordApply);
	command.setParameter("recordPeople",recordPeople);
	if(method=="insert"){
		command.execute("insertAll");
	}else if(method=="update"){
		command.execute("update");
	}
	if (!command.error){
		L5.Msg.alert("提示","批量入院成功！",function(){
			returnBack();
		});
	}else{
		L5.Msg.alert("提示","批量入院出错！");
	}
}
function returnBack(){
	window.close();
}