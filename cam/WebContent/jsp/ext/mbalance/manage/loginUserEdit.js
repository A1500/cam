function init(){
	var ds=L5.DatasetMgr.lookup("comExtUserDs");
	ds.setParameter("USER_ID@=", userId);
	ds.load();
	document.getElementById("userId").disabled=true;
	document.getElementById("userName").disabled=true;
}
function save(){
	var ds=L5.DatasetMgr.lookup("comExtUserDs");
	var pwd=document.getElementById("pwd").value;
	var repwd=document.getElementById("repwd").value;
	if(pwd==''){
		L5.Msg.alert("提示","请输入密码！");
		return;
	}
	if(repwd==''){
		L5.Msg.alert("提示","请重新输入密码！");
		return;
	}
	if(pwd!=repwd){
		L5.Msg.alert("提示","两次输入密码不一致，请重新输入！");
		return;
	}
	var comExtUser=ds.getCurrent();
	var command=new L5.Command("com.inspur.cams.comm.extuser.cmd.ComExtUserCmd");
	command.setParameter("comExtUser", comExtUser);
	command.execute("update");
	
	if(!command.error){
		L5.Msg.alert("提示","保存成功！");
	}else{
		L5.Msg.alert("提示","保存出错！");
	}
}