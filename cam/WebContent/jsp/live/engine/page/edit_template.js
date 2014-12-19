function getParam(obj){
	return document.getElementById(obj).value;
}
function setParam(obj , value){
	document.getElementById(obj).value = value;
}
function sendMessage(){
	//验证表单
	if(!form_validator())
		return;
	var command = new L5.Command("org.loushang.live.engine.view.MessageSendCmd");
	setCmdParam(command);
	var method = getParam("method");
	var msgType = getParam("msgType");
	if(DeliveryMode[msgType].isPersist){
		//调用后台验证方法
		command.setParameter("isvalidate" ,	"true");
		if(method=="detail" || method=="forward"){
			//通过对象调用Command中的updateMessage方法，执行修改邮件操作
			command.execute("updateMessage");		
		}else{
			//通过对象调用Command中的saveMessage方法，执行保存邮件操作
			command.execute("saveMessage");		
		}
		//保存完成后sendByID
		if (!command.error) {
			//如果保存邮件没错，执行发送邮件操作
			setParam("method" , "sendById"); 
			L5.Msg.alert("提示" , "消息正在发送!",function(){
				//关闭窗口
				document.getElementById("msgForm").submit();
				closeMark = true;
				window.close();
			});		
		}else{
			L5.Msg.alert("错误",command.error);
		}
	}else{
		//调用后台验证方法
		command.setParameter("isvalidate" ,	"true");
		command.execute("sendMessage");			
		if (!command.error) {
			//如果保存邮件没错，执行发送邮件操作
			L5.Msg.alert("提示" , "消息发送成功!",function(){
				closeMark = true;
				window.close()
			});		
		}else{
			L5.Msg.alert("错误",command.error);
		}
	}
}
function saveMessage(){
	//验证表单
	if(!form_validator())
		return;
	var command = new L5.Command("org.loushang.live.engine.view.MessageSendCmd");
	setCmdParam(command);
	var method = getParam("method");
	//调用后台验证方法
	command.setParameter("isvalidate" ,	"true");
	if(method=="detail" || method=="forward"){
		//通过对象调用Command中的updateMessage方法，执行修改邮件操作
		command.execute("updateMessage");		
	}else{
		//通过对象调用Command中的saveMessage方法，执行保存邮件操作
		command.execute("saveMessage");		
	}
	if (!command.error) {
		L5.Msg.alert("提示" , "保存成功!",function(){
			//关闭窗口
			closeMark = true;
			window.close()
		});		
	}else{
		L5.Msg.alert("错误",command.error);
	}
}
/**
* 事件处理：显示联系人列表
*/
function queryParty(){
	if(window.partyWndExist)
		return;
	var url =  "../party/frame.jsp";
	var params = "height=400px,width=530px,resizable=no,scrollbars=yes,top="+(screen.height-400)/2 + "px,left=" + (screen.width-530)/2 + "px";
	window.partyWndExist = true;
	window.open(url , "" , params);
}
//设置cmd方法的表单参数
function setCmdParam(cmd){
	var msgType = getParam("msgType");
	setPartyInfo();
	cmd.setParameter("partyInfo" ,	getParam("partyInfo"));
	cmd.setParameter("partyName" , 	getParam("partyName"));
	cmd.setParameter("title"	 , 	getParam("title"));
	cmd.setParameter("msgId" 	 , 	getParam("msgId"));
	cmd.setParameter("msgType" 	 , 	msgType);
	if(DeliveryMode[msgType].withContent)
 		cmd.setParameter("content"	 ,  getParam("content"));
 	if(DeliveryMode[msgType].timerEnable)
		cmd.setParameter("sendTime"	 , 	getParam("sendTime"));
}
//验证表单
function form_validator(){
	var msgType = getParam("msgType");
	//验证收件人
	var partyName = getParam("partyName");
	var status = Validator.partyName(partyName);
	if(status != true){
		L5.Msg.alert("提示" , status);
		return false;
	}
	//验证主题
	var title = getParam("title");
	status = Validator.title(title , DeliveryMode[msgType].withContent);
	if(status != true){
		L5.Msg.alert("提示" , status);
		return false;
	}
	//发送时间
	if(DeliveryMode[msgType].timerEnable){
		var sendTime = getParam("sendTime");
		status = Validator.dateTime(sendTime);
		if(status != true){
			L5.Msg.alert("提示" , status);
			return false;
		}
	}
	return true;
}
function isIE(){
	if(navigator.appName.indexOf("Microsoft") != -1) {
		return true;
	}
	else{
		return false;
	}
}