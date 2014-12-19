function init(){
	var jcmPeopleResumeDataSet=L5.DatasetMgr.lookup("jcmPeopleResumeDataSet");
	if(method=="insert"){
		jcmPeopleResumeDataSet.newRecord();
	}else{
		jcmPeopleResumeDataSet.setParameter("RESUME_ID@=",resumeId);
		jcmPeopleResumeDataSet.load();
	}
}
function save(){
	var jcmPeopleResumeDataSet=L5.DatasetMgr.lookup("jcmPeopleResumeDataSet");
	var valid=jcmPeopleResumeDataSet.isValidate(true);
	if(valid!=true){
		L5.Msg.alert("提示","校验未通过，不能保存！"+valid);
		return false;
	}
	var record=jcmPeopleResumeDataSet.getCurrent();
	var command=new L5.Command("com.inspur.cams.jcm.cmd.JcmPeopleResumeCmd");
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