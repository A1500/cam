var command = new L5.Command("org.loushang.live.engine.view.MessageSendCmd");
//获取页面输入域值，并对空进行处理

/**
* 事件处理：发送
*/
function msgSend() {
	var method = getParam("method");
	if(!checkSendParams()){
		return;
	}
	setCmdParam();	
	//调用后台验证方法
	command.setParameter("isvalidate" ,	"true");
		if(method=="detail"){
			command.execute("updateMessage");		
		}else{
			command.execute("saveMessage");	
		}
		//执行保存后的结果
		if (!command.error) {
			msgDs.commitChanges();
			command.execute("sendById");
			//执行发送后的结果
			if(!command.error){		
				L5.Msg.alert("提示","消息发送成功!",function(){
					//关闭窗口
					window.close();	
				});
			}else{
				L5.Msg.alert("错误",command.error);
			}		
		}else{
			//执行保存出错
			L5.Msg.alert("错误",command.error);
		}
}

/**
* 事件处理：保存
*/
function msgSave() {
	var method = getParam("method");
	//验证标题长度
	if(!checkTitle(false)){
		return;
	}
	setCmdParam();	
	if(method=="detail"){
		command.execute("updateMessage");
	}else{
		command.execute("saveMessage");
	}
	//保存结果处理
	if (!command.error) {
		msgDs.commitChanges();
		L5.Msg.alert("提示","消息保存成功!",function(){
			//关闭窗口
			window.close();	
		});
	}else{
		L5.Msg.alert("错误",command.error);
	}	
}
/*
*设置cmd参数
*/
function setCmdParam(){
	checkInput();
	command.reset();
	command.setParameter("partyInfo" , getParam("partyInfo"));
	command.setParameter("partyName" , getParam("partyName"));
	if(CKEDITOR.instances.htmlEditor){
	 	var title = CKEDITOR.instances.htmlEditor.getData();
	}
	command.setParameter("title" , title);
//	command.setParameter("userId" , getParam("userId"));
	command.setParameter("msgType" , getParam("msgType"));
	command.setParameter("msgId" , getParam("msgId"));
	command.setParameter("corrMsgId" , getParam("corrMsgId"));
	command.setParameter("bizType" , getParam("bizType"));
}