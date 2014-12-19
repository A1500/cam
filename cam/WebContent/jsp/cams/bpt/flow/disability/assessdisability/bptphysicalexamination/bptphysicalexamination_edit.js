function init() {
	ds.baseParams["peopleId"]=peopleId;
	ds.baseParams["applyId"]=applyId;
	ds.baseParams["serviceType"]="11";
	ds.load();
}
function save(){
	var ds = L5.DatasetMgr.lookup("ds");
    var record = ds.getCurrent();
	var command=new L5.Command("com.inspur.cams.bpt.manage.cmd.BptPhysicalExaminationCommand"); 
	command.setParameter("record",record);
	command.execute("update");
	
	if (!command.error) {
		L5.Msg.alert('提示',"保存成功!");
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}




