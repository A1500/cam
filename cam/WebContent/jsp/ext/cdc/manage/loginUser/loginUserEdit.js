function init(){
	var cdcComExtUserDataSet=L5.DatasetMgr.lookup("cdcComExtUserDataSet");
	if(method=="insert"){
		cdcComExtUserDataSet.newRecord({"organCode":organCode,"organName":organName});
	}else{
		cdcComExtUserDataSet.setParameter("USER_ID@=",userId);
		cdcComExtUserDataSet.load();
	}
}
function save(){
	var cdcComExtUserDataSet=L5.DatasetMgr.lookup("cdcComExtUserDataSet");
	var record=cdcComExtUserDataSet.getCurrent();
	var phone = record.get("phone");
	var email = record.get("email");
	var emailReg = /^([A-Za-z0-9])(\w)+@(\w)+(\.)(com|com\.cn|net|cn|net\.cn|org|biz|info|gov|gov\.cn|edu|edu\.cn)/;
	var phoneReg = /^(0[0-9]{2,3}\-)?([2-9][0-9]{6,7})+(\-[0-9]{1,4})?/;
	if(phone==""){
		L5.Msg.alert("提示","办公电话不能为空！");
		return false;
	}
	if(!phoneReg.test(phone)){
		L5.Msg.alert("提示","办公电话格式不正确！");
		return false;
	}
	if(email==""){
		L5.Msg.alert("提示","电子邮箱不能为空！");
		return false;
	}
	if(!emailReg.test(email)){
		L5.Msg.alert("提示","电子邮箱格式不正确！");
		return false;
	}
	if(record.get("adds")==""){
		L5.Msg.alert("提示","通讯地址不能为空！");
		return false;
	}
	if(record.get("communityType")==""){
		L5.Msg.alert("提示","社区类型不能为空！");
		return false;
	}
	if(record.get("ifVillage")==""){
		L5.Msg.alert("提示","是否为自然村不能为空！");
		return false;
	}
	var command=new L5.Command("com.inspur.cams.comm.extuser.cmd.ComExtUserCmd");
	command.setParameter("comExtUser",record);
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