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
		ds.baseParams["PYBZY_ID@="]=idField;
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
	var command=new L5.Command("com.inspur.cams.marry.base.cmd.MrmPybzyCommand"); 
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
 {	/* 	var url='jsp/cams/marry/mrmpybzy_list.jsp';
		var text = '聘用颁证员';
		L5.forward(url,text);	*/ 
		window.close();
 }
function otherCase(value) {
 	if(value == "04") {
 		document.getElementById("otherCase").style.display="";
 	} else {
 		document.getElementById("otherCase").style.display="none";
 	}
 }


