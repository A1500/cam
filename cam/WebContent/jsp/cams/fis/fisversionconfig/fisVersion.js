function init(){
	var fisVersionDataSet=L5.DatasetMgr.lookup("fisVersionDataSet");
	if(method=="insert"){
		fisVersionDataSet.newRecord();
	}else{
		fisVersionDataSet.setParameter("ORGAN_TYPE@=",organType);
		fisVersionDataSet.load(true);
	}
}
function save(){
	var fisVersionDataSet=L5.DatasetMgr.lookup("fisVersionDataSet");
	var valid=fisVersionDataSet.isValidate(true);
	if(valid!=true){
		L5.Msg.alert("提示","校验未通过，不能保存！"+valid);
		return false;
	}
	var record=fisVersionDataSet.getCurrent();
	var command=new L5.Command("com.inspur.cams.fis.base.cmd.FisVersionCmd");
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