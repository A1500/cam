function init(){
	var jcmCompanyHisDataSet=L5.DatasetMgr.lookup("jcmCompanyHisDataSet");
	if(method=="insert"){
		jcmCompanyHisDataSet.newRecord();
	}else{
		jcmCompanyHisDataSet.setParameter("COMPANY_ID@=",companyId);
		jcmCompanyHisDataSet.load();
	}
}
function save(){
	var jcmCompanyHisDataSet=L5.DatasetMgr.lookup("jcmCompanyHisDataSet");
	var valid=jcmCompanyHisDataSet.isValidate(true);
	if(valid!=true){
		L5.Msg.alert("提示","校验未通过，不能保存！"+valid);
		return false;
	}
	var record=jcmCompanyHisDataSet.getCurrent();
	var command=new L5.Command("com.inspur.cams.jcm.cmd.JcmCompanyHisCmd");
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