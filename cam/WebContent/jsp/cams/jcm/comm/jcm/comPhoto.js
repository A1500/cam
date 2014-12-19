function init(){
	var comPhotoDataSet=L5.DatasetMgr.lookup("comPhotoDataSet");
	if(method=="insert"){
		comPhotoDataSet.newRecord();
	}else{
		comPhotoDataSet.setParameter("PHOTO_ID@=",photoId);
		comPhotoDataSet.load();
	}
}
function save(){
	var comPhotoDataSet=L5.DatasetMgr.lookup("comPhotoDataSet");
	var valid=comPhotoDataSet.isValidate(true);
	if(valid!=true){
		L5.Msg.alert("提示","校验未通过，不能保存！"+valid);
		return false;
	}
	var record=comPhotoDataSet.getCurrent();
	var command=new L5.Command("com.inspur.cams.jcm.cmd.ComPhotoCmd");
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