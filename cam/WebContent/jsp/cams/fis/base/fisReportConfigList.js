function init(){
	var funeralOrganDs=L5.DatasetMgr.lookup("funeralOrganDs");
	funeralOrganDs.load();
}

function saveOrgan(){
	var funeralOrganDs=L5.DatasetMgr.lookup("funeralOrganDs");
	var records=funeralOrganDs.getAllChangedRecords();
	if(records.length<1){
		L5.Msg.alert("提示","没有需要保存的数据！");
		return false;
	}
	var command=new L5.Command("com.inspur.cams.fis.base.cmd.FisFuneralOrganManageCmd");
	command.setParameter("records",records);
	command.execute("save");
	if(!command.error){
		funeralOrganDs.commitChanges();
		L5.Msg.alert('提示',"数据保存成功!");
	}else{
		L5.Msg.alert("错误","保存时出错！"+command.error);
	}
}