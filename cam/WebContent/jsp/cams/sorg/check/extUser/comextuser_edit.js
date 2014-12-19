function init() {
	if (method==null||method==""){
		L5.Msg.alert('提示',"未知的页面命令!");
		back();
		}
	else if (method=="INSERT"){
		ds.newRecord({"accountStatus":"1","areaCode":"370000000000"});
	}
	else if (method=="UPDATE"){
		ds.baseParams["USER_ID@="]=idField;
		ds.load();
	}
	else{
		L5.Msg.alert('提示',"未知的页面命令!");
		back();
	}
	L5.QuickTips.init(); 
}

function save(){
	var record = ds.getCurrent();
	//校验
	var valid = ds.isValidate();
	if(valid != true){
		L5.Msg.alert('提示',"校验未通过,不能保存!"+valid);
		return false;
	}	
	var command=new L5.Command("com.inspur.cams.comm.extuser.cmd.ComExtUserCmd"); 
	command.setParameter("comExtUser",record);
	if(method=="INSERT"){
		command.execute("insert");	
	}
	if(method=="UPDATE"){
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
 {	 	var url='jsp/cams/sorg/check/extUser/comextuser_list.jsp';
		var text = 'COM_EXT_USER';
		L5.forward(url,text);	 
 }



