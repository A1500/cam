function init(){
	var jcmPtPendingDataSet=L5.DatasetMgr.lookup("jcmPtPendingDataSet");
	jcmPtPendingDataSet.load();
}

function save(){
	var jcmPtPendingDataSet=L5.DatasetMgr.lookup("jcmPtPendingDataSet");
	var records = jcmPtPendingDataSet.getAllChangedRecords();
	records.setValue("auditDate","");
	records.setValue("auditPeopleId","");
	var isValidate1 = jcmPtPendingDataSet.isValidate();
	if(isValidate1 != true){
		L5.Msg.alert('提示',"校验未通过,不能保存!"+isValidate1);
		return false;
	}
	
	var command=new L5.Command("com.inspur.cams.jcm.cmd.JcmPeopleTransferManageCmd");
	command.setParameter("records",records);
	command.execute("save");
	if (!command.error){
		L5.Msg.alert("提示","保存成功！",function(){
			//returnBack();
			jcmPtPendingDataSet.load(true);
		});
	}else{
		L5.Msg.alert("提示","保存出错！"+command.error);
	}
}
function returnBack(){
	history.go(-1);
}
