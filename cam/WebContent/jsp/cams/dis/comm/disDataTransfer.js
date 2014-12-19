function excuteProvinceToCpc(){
	L5.MessageBox.confirm('', '请先备份纪委前置机数据库数据，如果已备份将继续转移数据！', function(sure) {
		if (sure == "yes") {
			 var waitConfig = {
					   interval: 10000, 
					   duration: 70000,
					   increment: 7,
					   text: '转移中...',
					   scope:this,
					   fn:function(){
						   var command = new L5.Command("com.inspur.cams.dis.base.cmd.DisReliefInfoQueryCmd");
						      command.execute("proviceToCpc");
						if (!command.error) {
							L5.Msg.alert('提示', "执行成功！");
						} else {
							L5.Msg.alert('提示', "执行时出现错误！" + command.error);
						}
						}
					};
					L5.Msg.wait("正在执行，请等待...", "转移数据",waitConfig);
		   } else
				return;
				});   	
}
