function init(){
	var jcmPeopleInfoDataSet=L5.DatasetMgr.lookup("jcmPeopleInfoDataSet");
	if(method=="insert"){
		jcmPeopleInfoDataSet.newRecord();
	}else{
		jcmPeopleInfoDataSet.setParameter("PEOPLE_ID@=",peopleId);
		jcmPeopleInfoDataSet.load();
	}
}
function save(){
	var jcmPeopleInfoDataSet=L5.DatasetMgr.lookup("jcmPeopleInfoDataSet");
	var valid=jcmPeopleInfoDataSet.isValidate(true);
	if(valid!=true){
		L5.Msg.alert("提示","校验未通过，不能保存！"+valid);
		return false;
	}
	var record=jcmPeopleInfoDataSet.getCurrent();
	var command=new L5.Command("com.inspur.cams.jcm.cmd.JcmPeopleInfoCmd");
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