function init(){
	var cdcMailListDataSet=L5.DatasetMgr.lookup("cdcMailListDataSet");
	if(method=="insert"){
		cdcMailListDataSet.newRecord({"organCode":organCode,"organName":organName});
	}else{
		cdcMailListDataSet.setParameter("LIST_ID@=",listId);
		cdcMailListDataSet.load();
	}
}
function save(){
	var cdcMailListDataSet=L5.DatasetMgr.lookup("cdcMailListDataSet");
	var record=cdcMailListDataSet.getCurrent();
	var phoneReg = /^(0[0-9]{2,3}\-)?([2-9][0-9]{6,7})+(\-[0-9]{1,4})?/;
	if(_$("name")==""){
		alert("姓名不能为空!");
		return;
	}
	if(_$("organ")==""){
		alert("单位不能为空!");
		return;
	}
	if(_$("dept")==""){
		alert("部门不能为空!");
		return;
	}
	if(_$("postAdds")==""){
		alert("通信地址不能为空!");
		return;
	}
	if(_$("phone")==""){
		alert("办公电话不能为空!");
		return;
	}
	if(!phoneReg.test(_$("phone"))){
		L5.Msg.alert("提示","办公电话格式不正确!");
	 	return false;
	}
	var command=new L5.Command("com.inspur.cams.cdc.base.cmd.CdcMailListCmd");
	command.setParameter("record",record);
	if(method=="insert"){
		command.execute("insert");
	}else if(method=="update"){
		command.execute("update");
	}
	if (!command.error){
		L5.Msg.alert("提示","保存成功！",function(){
			returnBack();
		});
	}else{
		L5.Msg.alert("提示","保存出错！");
	}
}
function returnBack(){
	history.go(-1);
}