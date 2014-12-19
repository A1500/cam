function init(){}

function updatepwd(){
	var oldPasswd = document.getElementById('oldPasswd').value;
	var newPasswd = document.getElementById('newPasswd').value;
	var newPasswd2= document.getElementById('newPasswd2').value;
	if(document.getElementById('functionHint').innerHTML =='*'&&document.getElementById('functionHint1').innerHTML =='*'&&document.getElementById('functionHint2').innerHTML =='*'){
		if(oldPasswd==""){
			L5.MessageBox.alert('提示','原密码不能为空,请输入');
		}else if(newPasswd==""){
			L5.MessageBox.alert('提示','新密码不能为空,请输入');
		}else if(newPasswd2==""){
		    L5.MessageBox.alert('提示','确认新密码不能为空,请输入');
		}else{
		var cmd = new L5.Command('org.loushang.bsp.permit.pap.user.cmd.UserCmd');
		cmd.setParameter('oldPasswd',oldPasswd);
		cmd.setParameter('newPasswd',newPasswd);
		cmd.execute('updatePassword');
		L5.MessageBox.alert('提示','密码修改成功！');
	   }
	 }else {
	   L5.MessageBox.alert('提示','所填信息有误，请检查！');
	 }
}
function check_newpwd(){
	var oldPasswd = document.getElementById('oldPasswd').value;
	var newPasswd = document.getElementById('newPasswd').value;
	var newPasswd2 = document.getElementById('newPasswd2').value;
	/**
	 * 山东民政要求添加密码长度校验，密码长度不能小于6位
	 */
	if(newPasswd.length<6){
		L5.MessageBox.alert("提示","新密码长度不能小于6位！");
		document.getElementById('newPasswd').value="";
		return;
	}
    if(newPasswd2!=null&&newPasswd2!=""&&newPasswd2!=undefined){
    	if(newPasswd!=newPasswd2){
    		document.getElementById('functionHint2').innerHTML ='确认密码输入不正确，请重新输入';
    		document.getElementById('newPasswd2').value="";
    		document.getElementById('newPasswd2').focus();
    	}else{
    		document.getElementById('functionHint2').innerHTML = "*";
    	}
    }
	var cmd = new L5.Command('org.loushang.bsp.permit.pap.user.cmd.UserCmd');
	cmd.setParameter('oldPasswd',oldPasswd);
	cmd.setParameter('newPasswd',newPasswd);
	cmd.execute('checkNewPassword');
	var result=cmd.getReturn('result');

	if(result!='false'){
		document.getElementById('functionHint1').innerHTML =result;
		document.getElementById('newPasswd').value="";
		document.getElementById('newPasswd').focus();

	}else{
		document.getElementById('functionHint1').innerHTML = "*";
	}
}

function check_user(){
	var oldPasswd = document.getElementById('oldPasswd').value;
    if(oldPasswd==null || oldPasswd==""){
		document.getElementById('oldPasswd').focus();
		return;
	}
	var cmd = new L5.Command('org.loushang.bsp.permit.pap.user.cmd.UserCmd');
	cmd.setParameter('oldPasswd',oldPasswd);
	cmd.execute('check');
	var notUserPwd=cmd.getReturn('notUserPwd');
	if(notUserPwd=='true'){
		document.getElementById('functionHint').innerHTML ='*';
	}else{
		document.getElementById('functionHint').innerHTML = "原密码输入不正确，请重新输入";
		document.getElementById('oldPasswd').value="";
    	document.getElementById('oldPasswd').focus();
	}
}

function check_newpwd2(){
	var newPasswd = document.getElementById('newPasswd').value;
	var newPasswd2 = document.getElementById('newPasswd2').value;
	if(newPasswd!=newPasswd2){
		document.getElementById('functionHint2').innerHTML ='确认密码输入不正确，请重新输入';
		document.getElementById('newPasswd2').value="";
		document.getElementById('newPasswd2').focus();
	}else{
		document.getElementById('functionHint2').innerHTML = "*";
	}

}

