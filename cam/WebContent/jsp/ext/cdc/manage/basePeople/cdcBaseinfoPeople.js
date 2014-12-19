function init(){
	var cdcBaseinfoPeopleDataSet=L5.DatasetMgr.lookup("cdcBaseinfoPeopleDataSet");
	if(method=="insert"){
		cdcBaseinfoPeopleDataSet.newRecord();
	}else{
		cdcBaseinfoPeopleDataSet.setParameter("PEOPLE_ID@=",peopleId);
		cdcBaseinfoPeopleDataSet.load();
	}
}
function save(){
	var cdcBaseinfoPeopleDataSet=L5.DatasetMgr.lookup("cdcBaseinfoPeopleDataSet");
	var valid=cdcBaseinfoPeopleDataSet.isValidate(true);
	if(valid!=true){
		L5.Msg.alert("提示","校验未通过，不能保存！"+valid);
		return false;
	}
	var record=cdcBaseinfoPeopleDataSet.getCurrent();
	var command=new L5.Command("com.inspur.cams.cdc.base.cmd.CdcBaseinfoPeopleCmd");
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