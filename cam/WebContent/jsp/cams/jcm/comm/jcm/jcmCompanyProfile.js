function init(){
	var jcmCompanyProfileDataSet=L5.DatasetMgr.lookup("jcmCompanyProfileDataSet");
	if(method=="insert"){
		jcmCompanyProfileDataSet.newRecord();
	}else{
		jcmCompanyProfileDataSet.setParameter("COMPANY_ID@=",companyId);
		jcmCompanyProfileDataSet.load();
	}
}
function save(){
	var jcmCompanyProfileDataSet=L5.DatasetMgr.lookup("jcmCompanyProfileDataSet");
	var valid=jcmCompanyProfileDataSet.isValidate(true);
	if(valid!=true){
		L5.Msg.alert("提示","校验未通过，不能保存！"+valid);
		return false;
	}
	var record=jcmCompanyProfileDataSet.getCurrent();
	var command=new L5.Command("com.inspur.cams.jcm.cmd.JcmCompanyProfileCmd");
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