function init(){
	var cdcPeopleInfoDataSet=L5.DatasetMgr.lookup("cdcPeopleInfoDataSet");
	if(method=="INSERT"){
		cdcPeopleInfoDataSet.newRecord({"ifGroupHeadman":"1","organCode":organCode});
	}else{
		cdcPeopleInfoDataSet.setParameter("PEOPLE_ID@=",peopleId);
		cdcPeopleInfoDataSet.load();
	}
}
function save(){
	var cdcPeopleInfoDataSet=L5.DatasetMgr.lookup("cdcPeopleInfoDataSet");
	var valid=cdcPeopleInfoDataSet.isValidate(true);
	if(valid!=true){
		L5.Msg.alert("提示","校验未通过，不能保存！"+valid);
		return false;
	}
	var record=cdcPeopleInfoDataSet.getCurrent();
	if(record.get("name")==''){
		L5.Msg.alert("提示","姓名不能为空！");
		return false;
	}
	var command=new L5.Command("com.inspur.cams.cdc.base.cmd.CdcPeopleInfoCmd");
	command.setParameter("record",record);
	if(method=="INSERT"){
		command.execute("insert");
	}else if(method=="UPDATE"){
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