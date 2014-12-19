function init(){
	var jcmPeopleExamDataSet=L5.DatasetMgr.lookup("jcmPeopleExamDataSet");
	if(method=="insert"){
		jcmPeopleExamDataSet.newRecord();
	}else{
		jcmPeopleExamDataSet.setParameter("PEOPLE_EXAM_ID@=",peopleExamId);
		jcmPeopleExamDataSet.load();
	}
}
function save(){
	var jcmPeopleExamDataSet=L5.DatasetMgr.lookup("jcmPeopleExamDataSet");
	var valid=jcmPeopleExamDataSet.isValidate(true);
	if(valid!=true){
		L5.Msg.alert("提示","校验未通过，不能保存！"+valid);
		return false;
	}
	var record=jcmPeopleExamDataSet.getCurrent();
	var command=new L5.Command("com.inspur.cams.jcm.cmd.JcmPeopleExamCmd");
	command.setParameter("record",record);
	if(method=="insert"){
		command.execute("insert");
	}else if(method=="update"){
		command.execute("update");
	}
	if (!command.error){
		L5.Msg.alert("提示","保存成功！",function(){
			returnBack();
		});
	}else{
		L5.Msg.alert("提示","保存出错！");
	}
}
function returnBack(){
	history.go(-1);
}