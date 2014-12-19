function init() {
	var infocommand = new L5.Command("com.inspur.cams.comm.informUtil.InformSessionCmd");
		infocommand.execute("getUserInfo");
		var userLoginName ="";
		if (!infocommand.error) {
			var info = infocommand.getReturn("userInfo");
			  userLoginName =info.userLoginName;//通过登录账号查找对应的婚姻登记处。
			}
			
	var mrmBasePersonCommand = new L5.Command("com.inspur.cams.marry.base.cmd.MrmBasePersonCommand");
		mrmBasePersonCommand.setParameter("loginId",userLoginName);
		mrmBasePersonCommand.execute("getDeptId");
		var deptId ="";
		var deptName ="";
		if (!mrmBasePersonCommand.error) {
			 deptId = mrmBasePersonCommand.getReturn("deptId");
			 deptName = mrmBasePersonCommand.getReturn("deptName");
			}
	
			
			
    	
	if (method==null||method==""){
		L5.Msg.alert('提示',"未知的页面命令!");
		back();
		}
	else if (method=="INSERT"){
		var record=ds.newRecord();
		record.set("deptId",deptId);
		record.set("deptName",deptName);
	}
	else if (method=="UPDATE"){
		ds.baseParams["FUNCTION_ID@="]=idField;
		ds.load();
	}
	else{
		L5.Msg.alert('提示',"未知的页面命令!");
		back();
	}
	L5.QuickTips.init(); 
}

function insert(){
	var record = ds.getCurrent();
	//校验
	var valid = ds.isValidate();
	if(valid != true){
		L5.Msg.alert('提示',"校验未通过,不能保存!"+valid);
		return false;
	}	
	var command=new L5.Command("com.inspur.cams.marry.base.cmd.MrmRegisAreaCommand"); 
	command.setParameter("record",record);
	command.execute("insert");	
	if (!command.error) {
		L5.Msg.alert('提示',"保存成功!");
		back();
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
 function back()
 {	 	var url='jsp/cams/marry/dept/area/mrmregisarea_list.jsp';
		var text = '登记机关功能区面积表';
		L5.forward(url,text);	 
 }



