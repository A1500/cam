function init(){
	var jcmCompanyMoneyDataSet=L5.DatasetMgr.lookup("jcmCompanyMoneyDataSet");
	if(method=="insert"){
		jcmCompanyMoneyDataSet.newRecord();
	}else{
		jcmCompanyMoneyDataSet.setParameter("COMPANY_MONEY_ID@=",companyMoneyId);
		jcmCompanyMoneyDataSet.load();
	}
}
function save(){
	var jcmCompanyMoneyDataSet=L5.DatasetMgr.lookup("jcmCompanyMoneyDataSet");
	var valid=jcmCompanyMoneyDataSet.isValidate(true);
	if(valid!=true){
		L5.Msg.alert("提示","校验未通过，不能保存！"+valid);
		return false;
	}
	var record=jcmCompanyMoneyDataSet.getCurrent();
	var command=new L5.Command("com.inspur.cams.jcm.cmd.JcmCompanyMoneyCmd");
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