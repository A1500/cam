function init(){
	var ds=L5.DatasetMgr.lookup("mrmBasePersonDataSet");
	ds.setParameter("PERSON_ID@=",personId);
	ds.load();
}
function save(){
	var ds=L5.DatasetMgr.lookup("mrmBasePersonDataSet");
	
	var mrmBasePerson=ds.getCurrent();
	//校验
	if(mrmBasePerson.get("loginid")==""){
		alert("登陆账号不能为空！");
		return false;
	}
	if(mrmBasePerson.get("pwd")==""){
		alert("登陆密码不能为空！");
		return false;
	}
	
	if(mrmBasePerson.get("repwd")==""){
		alert("确认密码不能为空！");
		return false;
	}
	
	if(mrmBasePerson.get("roleId")==""){
		alert("请选择角色！");
		return false;
	}
	var command=new L5.Command("com.inspur.cams.marry.base.cmd.MrmBasePersonCommand");
	command.setParameter("MrmBasePerson", mrmBasePerson);
	command.execute("insert");
	
	if(!command.error){
	/*
		var parentWin = window.parent.window;
		var tree = parentWin.L5.getCmp("usertree");
		if(method=="insert"){
			//var node = tree.getNodeByRecordId(organId, "organRecord");
			//var rec = new parentWin.L5.tree.TreeRecord.recordTypes["userRecord"](ds.getCurrent().data, ds.getCurrent().get("userId"));
			//node.record.insert(rec);
		}else if(method=="update"){
			var node = tree.getNodeByRecordId(ds.getCurrent().get("userId"), "userRecord");
			node.record.set("userName", ds.getCurrent().get("userName"));
			node.record.set("deptId", deptId);
			node.record.set("parentOrganId", ds.getCurrent().get("pubOrganId"));
			node.record.commit();
		}
		*/
		L5.Msg.alert("提示","保存成功！");
	}else{
		L5.Msg.alert("提示","保存出错，该用户名已存在！");
	}
}