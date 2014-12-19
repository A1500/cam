function init() {
	if (method==null||method==""){
		L5.Msg.alert('提示',"未知的页面命令!");
		back();
		}
	else if (method=="INSERT"){
		ds.newRecord({"batchYear":year,"ifValid":"1"});
	}
	else if (method=="UPDATE"){
		ds.baseParams["TASK_ID@="]=idField;
		ds.load();
	}
	else{
		L5.Msg.alert('提示',"未知的页面命令!");
		back();
	}
	L5.QuickTips.init(); 
}

function save(){
	var records = ds.getAllChangedRecords();
	if(records.length<1){
		L5.Msg.alert('提示','没有需要保存的数据!');
		return false;
	}
	//校验
	var valid = ds.isValidate();
	if(valid != true){
		L5.Msg.alert('提示',"校验未通过,不能保存!"+valid);
		return false;
	}	
    var record = ds.getCurrent();
	var command=new L5.Command("com.inspur.cams.sorg.check.checktask.cmd.SomCheckTaskCommand"); 
	command.setParameter("record",record);
	if (method=="INSERT"){
		command.execute("insert");
	}	
	if (method=="UPDATE"){
		command.execute("update");
	}	
	if (!command.error) {
		L5.Msg.alert('提示',"保存成功!");
		back();
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
 function back()
 {	 	var url='jsp/cams/sorg/check/group/somchecktask/somchecktaskconfig_list.jsp';
		var text = 'SOM_CHECK_TASK';
		L5.forward(url,text);	 
 }



