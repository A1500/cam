function init(){
	var samGeroKeptPersonDataSet=L5.DatasetMgr.lookup("samGeroKeptPersonDataSet");
	samGeroKeptPersonDataSet.setParameter("PERSON_ID@=",personId);
	samGeroKeptPersonDataSet.load();
	document.getElementById("gerocomiumName").value=gerocomiumName;
	var samGeroApplyDataSet=L5.DatasetMgr.lookup("samGeroApplyDataSet");
	samGeroApplyDataSet.newRecord();
}
function save(){
	var samGeroKeptPersonDataSet=L5.DatasetMgr.lookup("samGeroKeptPersonDataSet");
	var recordPerson=samGeroKeptPersonDataSet.getCurrent();
	recordPerson.set("updateDate",getCurDate());
	var samGeroApplyDataSet=L5.DatasetMgr.lookup("samGeroApplyDataSet");
	var valid=samGeroKeptPersonDataSet.isValidate(true);
	if(valid!=true){
		L5.Msg.alert("提示","校验未通过，不能保存！"+valid);
		return false;
	}
	var recordApply=samGeroApplyDataSet.getCurrent();
	var commandId=new L5.Command("com.inspur.cams.comm.util.IdHelpCmd");
	commandId.setParameter("IdHelp","Id32");
	commandId.execute();
	var newId=commandId.getReturn("id");
	recordApply.set("applyId",newId);
	recordApply.set("personId",recordPerson.get("personId"));
	recordApply.set("gerocomiumId",recordPerson.get("gerocomiumId"));
	recordApply.set("applyType","1");
	recordApply.set("updateDate",getCurDate());
	var command=new L5.Command("com.inspur.cams.drel.samu.cmd.SamGeroKeptPersonCmd");
	command.setParameter("recordApply",recordApply);
	command.setParameter("recordPerson",recordPerson);
	command.execute("outGero");
	if (!command.error){
		L5.Msg.alert("提示","保存成功！",function(){
			returnBack();
		});
	}else{
		L5.Msg.alert("提示","保存出错！");
	}
}
function returnBack(){
	window.close();
	var parent=window.dialogArguments;
	var samGeroKeptPersonDataSet=parent.samGeroKeptPersonDataSet;
	samGeroKeptPersonDataSet.setParameter("isStatus","1");	
	samGeroKeptPersonDataSet.load();
}