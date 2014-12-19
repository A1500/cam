function init() {
	ds.baseParams["applyId"]=applyId;
	ds.baseParams["peopleId"]=peopleId;
	ds.baseParams["serviceType"]="61";
	ds.load();
}
function save(){
	var records = ds.getAllChangedRecords();
	if(records.length<1){
		L5.Msg.alert('提示','没有需要保存的数据!');
		return false;
	}
	var lastTime = records[0].get("lastTime");
	if(lastTime!=''&&!validateDateFormat(lastTime)){
		L5.Msg.alert("提示","上次体检时间格式不正确！");
		return false;
	}
	
	var countyTime = records[0].get("countyTime");
	if(countyTime!=''&&!validateDateFormat(countyTime)){
		L5.Msg.alert("提示","时间格式不正确！");
		return false;
	}
	var hospitalTime = records[0].get("hospitalTime");
	if(hospitalTime!=''&&!validateDateFormat(hospitalTime)){
		L5.Msg.alert("提示","签名时间格式不正确！");
		return false;
	}
	//校验
	var valid = ds.isValidate();
	if(valid != true){
		L5.Msg.alert('提示',"校验未通过,不能保存!"+valid);
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




