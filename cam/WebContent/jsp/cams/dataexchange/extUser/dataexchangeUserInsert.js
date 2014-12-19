function init() {
	if (method=="INSERT"){
		ds.newRecord({"accountStatus":"1","areaCode":"370000000000","organType":"EX"});
	} else if (method=="UPDATE"){
		ds.baseParams["USER_ID@="]=idField;
		ds.load();
	} else{
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
		command.setParameter("comExtUser",record);
		command.execute("update");	
	}
	if (!command.error) {
		L5.Msg.alert('提示',"保存成功!",function(){
			back();
		});
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
function back()
{	var url='jsp/cams/dataexchange/extUser/dataexchangeUserList.jsp';
	var text = '数据共享平台用户维护列表';
	L5.forward(url,text);	 
}
