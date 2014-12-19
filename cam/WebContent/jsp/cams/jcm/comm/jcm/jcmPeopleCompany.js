function init(){
	var jcmPeopleCompanyDataSet=L5.DatasetMgr.lookup("jcmPeopleCompanyDataSet");
	if(method=="insert"){
		jcmPeopleCompanyDataSet.newRecord();
	}else{
		jcmPeopleCompanyDataSet.setParameter("PEOPLE_COMPANY_ID@=",peopleCompanyId);
		jcmPeopleCompanyDataSet.load();
	}
}
function save(){
	var jcmPeopleCompanyDataSet=L5.DatasetMgr.lookup("jcmPeopleCompanyDataSet");
	var valid=jcmPeopleCompanyDataSet.isValidate(true);
	if(valid!=true){
		L5.Msg.alert("提示","校验未通过，不能保存！"+valid);
		return false;
	}
	var record=jcmPeopleCompanyDataSet.getCurrent();
	var command=new L5.Command("com.inspur.cams.jcm.cmd.JcmPeopleCompanyCmd");
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