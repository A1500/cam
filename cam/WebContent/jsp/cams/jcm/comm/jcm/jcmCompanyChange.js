function init(){
	var jcmCompanyChangeDataSet=L5.DatasetMgr.lookup("jcmCompanyChangeDataSet");
	if(method=="insert"){
		jcmCompanyChangeDataSet.newRecord();
	}else{
		jcmCompanyChangeDataSet.setParameter("COMPANY_CHANGE_ID@=",companyChangeId);
		jcmCompanyChangeDataSet.load();
	}
}
function save(){
	var jcmCompanyChangeDataSet=L5.DatasetMgr.lookup("jcmCompanyChangeDataSet");
	var valid=jcmCompanyChangeDataSet.isValidate(true);
	if(valid!=true){
		L5.Msg.alert("提示","校验未通过，不能保存！"+valid);
		return false;
	}
	var record=jcmCompanyChangeDataSet.getCurrent();
	var command=new L5.Command("com.inspur.cams.jcm.cmd.JcmCompanyChangeCmd");
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