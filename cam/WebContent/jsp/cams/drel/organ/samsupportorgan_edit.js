function init() {
	if (method==null||method==""){
		L5.Msg.alert('提示',"未知的页面命令!");
		back();
		}
	else if (method=="INSERT"){
		ds.newRecord();
	}
	else if (method=="UPDATE"){
		ds.baseParams["ORGAN_ID@="]=idField;
		ds.load();
	}
	else{
		L5.Msg.alert('提示',"未知的页面命令!");
		back();
	}
	L5.QuickTips.init(); 
}

function save(){
	var valid = ds.isValidate();
	if(valid != true){
		L5.Msg.alert('提示',"校验未通过,不能保存!"+valid);
		return false;
	}	
    var record = ds.getCurrent();
	var command=new L5.Command("com.inspur.cams.drel.organ.cmd.SamSupportOrganCmd"); 
	command.setParameter("record",record);
	if (method=="INSERT"){
		command.execute("insert");
	}else{
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
 {	 	var url='jsp/cams/drel/organ/samsupportorgan_list.jsp';
		var text = '救助机构列表';
		L5.forward(url,text);	 
 }



