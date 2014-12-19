
function init(){
	//dsUser.load();
	//dsUser.removeAll();
	var mgr=dsUser.newRecord();
	organName=unescape(organName);
	mgr.set("employeeName",organName);
	mgr.set("userName",organName);
	mgr.set("userTypeId","00");
}

function getParams(elementId){
   return document.getElementById(elementId).value;
}

function  save(){
	if(!validate()){
		return false;
	}
	var record=dsUser.getCurrent();
	var employeeId=struId;
	var employeeName=organName;
	if(getParams("passWord")!==getParams("passWord2")){
	   L5.Msg.alert("提示","两次输入的密码不一致，请重新输入");
	   return false;
	}
 	var command=new L5.Command("org.loushang.bsp.permit.pap.user.cmd.UserCmd");
   //复制
   record.set("employeeId",employeeId);
   record.set("departmentId","departmentId");
   record.set("accountStatus","11");
   if(!record.get("isSys")){
  	 record.set("isSys","0");
   }
   record.set("userTypeId","00");
   command.setParameter("record",record);
   //command.setParameter("departmentId","departmentId");
  	command.execute("addEmployeeUser");
  	if (!command.error) {
		L5.Msg.alert("提示","操作成功！");
		window.close();
	}else{
		L5.MessageBox.alert(RES_PROMOT,command.error);
		return false;
	}
	L5.Msg.alert("提示","操作成功！");
}

function saveBack(){
	window.close();
}

/*
 * 检验必填项
 */
function validate(){
	//
	var userId = document.getElementById("userId").value;
	if(userId==''){
		L5.MessageBox.alert(RES_PROMOT,"用户ID不能为空");
		return false;
	}
	//
	var userName = document.getElementById("userName").value;
	if(userName==''){
		L5.MessageBox.alert(RES_PROMOT,"用户名称不能为空");
		return false;
	}
	//
	var passWord = document.getElementById("passWord").value;
	if(passWord==''){
		L5.MessageBox.alert(RES_PROMOT,"密码不能为空");
		return false;
	}
	//
	var passwordConfirm = document.getElementById("passWord2").value;
	if(passwordConfirm==''){
		L5.MessageBox.alert(RES_PROMOT, "确认密码不能为空");
		return false;
	}

	return true;
}
/*
 * 密码验证
 */
function ValidatePwd(src){
//	alert(src.value);
	var command = new L5.Command("org.loushang.bsp.permit.pap.user.cmd.UserCmd");
	command.setParameter("password",src.value);
	//	if(method=='INSERT'){
		command.setParameter("method","insert");
	//}
	command.execute("validatePwd");
	//alert(src.value);
	if (!command.error) {
		document.getElementById('passWordHint').innerHTML='*';
	}else{
		document.getElementById('passWordHint').innerHTML=command.error;
//		L5.MessageBox.alert(RES_PROMOT,command.error);
		src.value="";
	}
}
/*
 * 验证确认密码
 */
function ValidatePwdConfirm(src){
	var value = document.getElementById("passWord").value;
	var c_password=document.getElementById("passwordConfirm");
	var re_password = document.forms[0].passwordConfirm;
	if(value!=src.value){
		src.value="";
//		L5.MessageBox.alert(RES_PROMOT,"确认密码输入不正确，请重新输入!");
		document.getElementById('passWord2Hint').innerHTML="确认密码输入不正确，请重新输入!";
	}else{
		document.getElementById('passWord2Hint').innerHTML='*';
	}

}