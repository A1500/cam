function init(){
	var fisCremationExportBackupDataSet=L5.DatasetMgr.lookup("fisCremationExportBackupDataSet");
	if(method=="insert"){
		fisCremationExportBackupDataSet.newRecord();
	}else{
		fisCremationExportBackupDataSet.setParameter("RECORD_ID@=",recordId);
		fisCremationExportBackupDataSet.load();
	}
}
function save(){
	var fisCremationExportBackupDataSet=L5.DatasetMgr.lookup("fisCremationExportBackupDataSet");
	var valid=fisCremationExportBackupDataSet.isValidate(true);
	if(valid!=true){
		L5.Msg.alert("提示","校验未通过，不能保存！"+valid);
		return false;
	}
	var record=fisCremationExportBackupDataSet.getCurrent();
	var command=new L5.Command("com.inspur.cams.fis.base.cmd.FisCremationExportBackupCmd");
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