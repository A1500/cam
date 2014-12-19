function init() {
	//根据登录人员获得婚姻登记处
		var infocommand = new L5.Command("com.inspur.cams.comm.informUtil.InformSessionCmd");
		infocommand.execute("getUserInfo");
		var userLoginName ="";
		var organCode ="";
		var organName ="";
		if (!infocommand.error) {
			var info = infocommand.getReturn("userInfo");
			  userLoginName =info.userLoginName;//通过登录账号查找对应的婚姻登记处。
			  organCode =info.cantCode;//通过登录账号查找对应的婚姻登记处。
			  organName =info.userDepOrganName;
			}
	var mrmBasePersonCommand = new L5.Command("com.inspur.cams.marry.base.cmd.MrmBasePersonCommand");
		mrmBasePersonCommand.setParameter("loginId",userLoginName);
		mrmBasePersonCommand.execute("getDeptId");
		if (!mrmBasePersonCommand.error) {
			 deptId = mrmBasePersonCommand.getReturn("deptId");
			 deptName= mrmBasePersonCommand.getReturn("deptName");
			}
			
			if(deptId=="" || deptId==null){
				ds.newRecord();
				alert("没有对应的婚姻登记处！");
				return false;
			
			}
	if (method==null||method==""){
		L5.Msg.alert('提示',"未知的页面命令!");
		back();
		}
	else if (method=="INSERT"){
		ds.newRecord();
	}
	else if (method=="UPDATE"){
		ds.baseParams["FDY_ID@="]=idField;
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
    if(record.get("ryly")=="04"){
    	if(record.get("qtqk")==""){
    		alert("人员来源如果选”其他“，”其他情况“不能为空！");
    		return false;
    	}
    }
	var records = ds.getAllChangedRecords();
	if(records.length<1){
		L5.Msg.alert('提示','没有需要保存的数据!');
		return false;
	}
	if (document.getElementById("xb").value == '') {
		L5.Msg.alert('提示', "性别不能为空!");
		return false;
	}
	
    
	var command=new L5.Command("com.inspur.cams.marry.base.cmd.MrmFdyCommand"); 
	command.setParameter("record",record);
	if(method=="INSERT"){
	record.set("organId",deptId);
	command.execute("insert");	
	
	}else if(method=="UPDATE"){
	command.execute("update");	
	
	}
	if (!command.error) {
		L5.Msg.alert('提示',"保存成功!");
		window.returnValue="true";
		window.close();
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}

 function back()
 {	 /*	var url='jsp/cams/marry/mrmfdy_list.jsp';
		var text = 'MRM_FDY';
		L5.forward(url,text);*/
		window.close();	 
 }

 
 function otherCase(value) {
 	if(value == "04") {
 		document.getElementById("otherCase").style.display="";
 	} else {
 		document.getElementById("otherCase").style.display="none";
 	}
 }


