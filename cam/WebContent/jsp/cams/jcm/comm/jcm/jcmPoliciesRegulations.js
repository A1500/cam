function init(){
	var jcmPoliciesRegulationsDataSet=L5.DatasetMgr.lookup("jcmPoliciesRegulationsDataSet");
	if(method=="insert"){
		jcmPoliciesRegulationsDataSet.newRecord();
	}else{
		jcmPoliciesRegulationsDataSet.setParameter("PR_ID@=",prId);
		jcmPoliciesRegulationsDataSet.load();
	}
}
function save(){
	var jcmPoliciesRegulationsDataSet=L5.DatasetMgr.lookup("jcmPoliciesRegulationsDataSet");
	var valid=jcmPoliciesRegulationsDataSet.isValidate(true);
	if(valid!=true){
		L5.Msg.alert("提示","校验未通过，不能保存！"+valid);
		return false;
	}
	var record=jcmPoliciesRegulationsDataSet.getCurrent();
	var command=new L5.Command("com.inspur.cams.jcm.cmd.JcmPoliciesRegulationsCmd");
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