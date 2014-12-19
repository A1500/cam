
function userReg(){	

	var command = new L5.Command("org.loushang.live.contact.register.cmd.ServiceSaveCmd");
	//向command中传递参数
	// execute方法可以指定参数
	command.execute("userOpenService");
	//如果执行没有错误,dataset接受所有修改,否则弹出错误信息：
	if (!command.error) {
		//scDataset.commitChanges();
		L5.Msg.alert("提示","开通成功!");
	}else{
		L5.Msg.alert("错误",command.error);
	}
}
function sysReg(){	

	var command = new L5.Command("org.loushang.live.contact.register.cmd.ServiceSaveCmd");
	//向command中传递参数
	// execute方法可以指定参数
	command.execute("sysOpenService");
	//如果执行没有错误,dataset接受所有修改,否则弹出错误信息：
	if (!command.error) {
		//scDataset.commitChanges();
		L5.Msg.alert("提示","开通成功!");
	}else{
		L5.Msg.alert("错误",command.error);
	}
}
