function init(){
	var ds = L5.DatasetMgr.lookup("roleDataSet");
	if (method=="INSERT"){
		ds.newRecord({"roleId":newId});
	}else if (method=="UPDATE"){
		var command=new L5.Command("org.loushang.bsp.eai.pap.role.cmd.RoleCommand");
		command.setParameter("ROLE_ID", pk);
		command.execute("getRole");
		
	} else{
		L5.MessageBox.alert(RES_PROMPT,RES_UNKOWN_CMD);
		return;
	}
}
var res;
if(!res) res = {};
res.prompts = '提示 ';
/*
* 保存
*/
function save(){
	var roleDataSet = L5.DatasetMgr.lookup("roleDataSet");
	var record = roleDataSet.getCurrent();
	if(!role_valid())return;
	var retRecord;
	var command = new L5.Command("org.loushang.bsp.eai.pap.role.cmd.RoleCommand");
	command.setParameter("record", record);
	if(method=='INSERT'){
		command.execute("insert");
	}
	if(method=='UPDATE'){
		command.execute("update");
	}
	retRecord = command.getReturn("retRecord");
	if (!command.error) {
		roleDataSet.commitChanges();
		L5.forward("jsp/bsp/eai/pap/role/role_query.jsp",'查询');
		return retRecord;
	}else{
		L5.Msg.alert(res.prompts,command.error);
	}
	return retRecord;
}

//字段检测
function role_valid(){
	var roleName = document.getElementById("roleName").value;
	if(roleName==''){
		L5.MessageBox.alert("提示","角色名称不能为空");
		return false;
	}
	var relationId = document.getElementById("relationId").value;
	if(relationId==''){
		L5.MessageBox.alert("提示","所属组织不能为空");
		return false;
	}
	var appCode = document.getElementById("appCode").value;
	if(appCode==''){
		L5.MessageBox.alert("提示","所属应用不能为空");
		return false;
	}
	return true;
}
/*
* 通用帮助
*/
function backToRoles(){
	L5.forward("jsp/bsp/eai/pap/role/role_query.jsp",'查询');
}
/*
* 通用帮助
*/
function forHelp(){
	var revalue=window.showModalDialog("../../../organization/getselect.jsp?rootId=rootId&showOrganType=0&organType=1&isExact=0&isCheckBox=0&isTree=1","","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if(revalue!=""&&revalue!=undefined){
		var list = revalue.split(";");
		document.getElementById("relationId").value = list[2];
		document.getElementById("organName").value = list[1];
		var roleDataSet = L5.DatasetMgr.lookup("roleDataSet");
		var record = roleDataSet.getCurrent();
		record.set("relationId",list[2]);
		record.set("organName",list[1]);
	}
}
function forHelpApp(){
	var revalue=window.showModalDialog("../application/app_query_list.jsp","","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if(revalue!=""&&revalue!=undefined){
		var list = revalue.split(";");
		document.getElementById("appCode").value = list[0];
		document.getElementById("appName").value = list[1];
		var roleDataSet = L5.DatasetMgr.lookup("roleDataSet");
		var record = roleDataSet.getCurrent();
		record.set("appCode",list[0]);
		record.set("appName",list[1]);
	}
}