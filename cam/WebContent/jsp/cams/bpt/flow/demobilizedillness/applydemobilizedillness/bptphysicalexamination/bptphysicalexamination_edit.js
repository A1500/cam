function init() {

	ds.baseParams["peopleId"]=peopleId;
	ds.baseParams["applyId"]=applyId;
	ds.baseParams["serviceType"]="45";
	ds.load();
}
function save(){
	var records = ds.getAllChangedRecords();
	if(records.length<1){
		L5.Msg.alert('提示','没有需要保存的数据!');
		return false;
	}
    var record = ds.getCurrent();
    record.set("applyId",applyId);
	var command=new L5.Command("com.inspur.cams.bpt.manage.cmd.BptPhysicalExaminationCommand"); 
	command.setParameter("record",record);
	command.execute("update");
	
	if (!command.error) {
		L5.Msg.alert('提示',"保存成功!");
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
		}
	}




