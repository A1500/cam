function init(){
	var time = myDate+" "+mytime;
	var ds=L5.DatasetMgr.lookup("ds");
	if(method=="insert"){
		ds.newRecord({"organId":organId,"organName":organName,"organType":"SQ","accountStatus":"1","inUse":"1","ifVillage":"1","communityType":"N","areaName":organName,"createPeople":organName,"createTime":time});
		document.getElementById("userId").value=organId.substr(0,9)+"a";
	}else{
		ds.setParameter("USER_ID@=",userId);
		ds.load();
		document.getElementById("userId").disabled="disabled";
		document.getElementById("userName").disabled="disabled";
	}
}
function save(){
	var ds=L5.DatasetMgr.lookup("ds");
	if(method=="insert"){
		var id=document.getElementById("userId").value+document.getElementById("endUserId").value;
		if(id.length<12){
			L5.Msg.alert("提示","社区账号不足12位.");
			return false;
		}
	}
	if(document.getElementById("userName").value.length==0){
		L5.Msg.alert("提示","社区名称不能为空");
		return false;
	}
	if(document.getElementById("pwd").value.length==0){
		L5.Msg.alert("提示","密码不能为空");
		return false;
	}
	var record = ds.getCurrent();
	var command=new L5.Command("com.inspur.cams.comm.extuser.cmd.ComExtUserCmd");
	record.set("areaName",document.getElementById("userName").value);
	if(method=="insert"){
		record.set("communityBelongs",document.getElementById("userId").value+document.getElementById("endUserId").value);
		record.set("areaCode",document.getElementById("userId").value+document.getElementById("endUserId").value);
		record.set("userId",document.getElementById("userId").value+document.getElementById("endUserId").value);
		command.setParameter("record",record);
		command.execute("insertUser");
	}else{
		command.setParameter("comExtUser",record);
		command.execute("update");
	}
	
	if (!command.error){
		var parentWin = window.parent.window;
		var tree = parentWin.L5.getCmp("usertree");
		if(method=="insert"){
			var node = tree.getNodeByRecordId(organId, "cityRecord");
			var rec = new parentWin.L5.tree.TreeRecord.recordTypes["userRecord"](ds.getCurrent().data, ds.getCurrent().get("userId"));
			node.record.insert(rec);
		}else{
			//var node = tree.getNodeByRecordId(ds.getCurrent().get(ds), "userRecord");
			//node.record.set("userName", ds.getCurrent().get("userName"));
			//node.record.commit();
			//var parentWin = window.parent.window;
		}
		L5.Msg.alert("提示","保存成功！");
	}else{
		L5.Msg.alert("提示","账号已存在！");
	}
}


