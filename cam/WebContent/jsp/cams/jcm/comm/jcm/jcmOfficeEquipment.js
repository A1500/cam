function init(){
	var jcmOfficeEquipmentDataSet=L5.DatasetMgr.lookup("jcmOfficeEquipmentDataSet");
	if(method=="insert"){
		jcmOfficeEquipmentDataSet.newRecord();
	}else{
		jcmOfficeEquipmentDataSet.setParameter("OFFICE_ID@=",officeId);
		jcmOfficeEquipmentDataSet.load();
	}
}
function save(){
	var jcmOfficeEquipmentDataSet=L5.DatasetMgr.lookup("jcmOfficeEquipmentDataSet");
	var valid=jcmOfficeEquipmentDataSet.isValidate(true);
	if(valid!=true){
		L5.Msg.alert("提示","校验未通过，不能保存！"+valid);
		return false;
	}
	var record=jcmOfficeEquipmentDataSet.getCurrent();
	var command=new L5.Command("com.inspur.cams.jcm.cmd.JcmOfficeEquipmentCmd");
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