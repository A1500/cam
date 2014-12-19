function init(){
	var ds=L5.DatasetMgr.lookup("comExtUserDs");
	if(method=="insert"){
		ds.newRecord({"organId":organId,"organName":organName,"organType":organType,"areaCode":areaCode,"areaName":areaName});
	}else if(method=="update"){
		ds.setParameter("USER_ID@=", userId);
		ds.load();
		document.getElementById("userId").disabled=true;
	}
}
function save(){
	var ds=L5.DatasetMgr.lookup("comExtUserDs");
	var valid =ds.isValidate(true);
	if(valid !== true){
		L5.Msg.alert("提示","校验未通过，不能保存！"+valid);
		return false;
	}
	
	var comExtUser=ds.getCurrent();
	var command=new L5.Command("com.inspur.cams.comm.extuser.cmd.ComExtUserCmd");
	command.setParameter("comExtUser", comExtUser);
	if(method=="insert"){
		command.execute("insert");
	}else if(method=="update"){
		command.execute("update");
	}
	
	if(!command.error){
		var parentWin = window.parent.window;
		var tree = parentWin.L5.getCmp("usertree");
		if(method=="insert"){
			var node = tree.getNodeByRecordId(organId, "organRecord");
			var rec = new parentWin.L5.tree.TreeRecord.recordTypes["userRecord"](ds.getCurrent().data, ds.getCurrent().get("userId"));
			node.record.insert(rec);
		}else if(method=="update"){
			var node = tree.getNodeByRecordId(ds.getCurrent().get("userId"), "userRecord");
			node.record.set("userName", ds.getCurrent().get("userName"));
			node.record.commit();
		}
		L5.Msg.alert("提示","保存成功！");
		var url="jsp/cams/comm/extuser/comExtUserEdit.jsp?method=update&userId="+ds.getCurrent().get("userId");
		L5.forward(url);
	}else{
		L5.Msg.alert("提示","保存出错！");
	}
}