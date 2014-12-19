function init(){

}

function edit(){
	var record = L5.DatasetMgr.lookup("userDataset").getCurrent();
	if(!record){
		L5.MessageBox.alert('提示','没有选择用户');
		return;
	}
	var url;
	url = "jsp/bsp/permit/pap/user/user_edit.jsp?method=UPDATE&primeKey=" + record.get("USER_ID")+"&queryEdit=queryEdit";
	L5.forward(url);
}

function selectEmployee(){
	revalue=window.showModalDialog("../../../organization/getselect.jsp?rootId=rootId&showOrganType=0&organType=8"
			+"&isExact=0&isCheckBox=0&isTree=1&userId="+loginUserId,"","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if(revalue){
		var values = revalue.split(";");
		document.getElementById("employeeId").value = values[2];
		document.getElementById("employeeName").value = values[1];
	} 
//	else {
//		document.getElementById("employeeId").value = "";
//		document.getElementById("employeeName").value = "";
//	}
}

function selectDept(){
	revalue=window.showModalDialog("../../../organization/getselect.jsp?rootId=rootId&showOrganType=0&organType=1,2"
			+"&isExact=0&isCheckBox=0&isTree=1&userId="+loginUserId,"","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if(revalue){
		var values = revalue.split(";");
		document.getElementById("deptId").value = values[0];
		document.getElementById("deptName").value = values[1];
		document.getElementById("organType").value=values[7];
	} 
//	else {
//		document.getElementById("deptId").value = "";
//		document.getElementById("deptName").value = "";
//	}
}

function query(){
	var employee = document.getElementById("employeeId").value;
	var dept = document.getElementById("deptId").value;
	var organType = document.getElementById("organType").value;
	var userId = document.getElementById("userid").value;
	var userName = document.getElementById("username").value;
	//var organType=document.getElementById("organType").value;
	var command = new L5.Command("org.loushang.bsp.permit.pap.user.cmd.UserQueryCommand");
   
	if(employee !== null && employee !== ""){
		//command.setParameter("employeeId", employee);
		userDataset.setParameter("employeeId", employee);
	}
	if(dept !== null && dept !== ""){
		//command.setParameter("dept", dept);
		userDataset.setParameter("organId", dept);
		userDataset.setParameter("organType", organType);
		//userDataset.setParameter("organType",organType);
	}
	
	if(userId !== null && userId !== ""){
	  if(userId.indexOf("'")!=-1){//输入框中存在单引号
		  L5.MessageBox.alert('提示','查询条件中不能包含单引号字符');
		  return;
	  }
		//command.setParameter("userId", userId);
		userDataset.setParameter("userId", userId);
	}
	if(userName !== null && userName !== ""){
		 if(userName.indexOf("'")!=-1){//输入框中存在单引号
			  L5.MessageBox.alert('提示','查询条件中不能包含单引号字符');
			  return;
		  }
		//command.setParameter("userName", userName);
		userDataset.setParameter("userName", userName);
	}
	//command.execute("queryUsers");
//	if (!command.error) {
//	}else{
//		L5.MessageBox.alert('提示',command.error);
//	}
	userDataset.load();
}

//修改“是否系统管理员”的列显示
function isSysLabel(value,col,record){
	var isSysRecord = isSysDataset.getById(value);
	if(isSysRecord){
		return isSysRecord.get("text");
	}

	return value;
}

//修改“ 帐户状态 ”的列显示
function accountStatusLabel(value,col,record){
	var accountStatusRecord = accountStatusDataset.getById(value);
	if(accountStatusRecord){
		return accountStatusRecord.get("text");
	}

	return value;
}

function reset(){
	document.getElementById("employeeId").value="";
	document.getElementById("deptId").value="";
	document.getElementById("userid").value="";
	document.getElementById("username").value="";
}