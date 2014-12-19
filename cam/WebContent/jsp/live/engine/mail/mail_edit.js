var xmlRequestHttp;
var closeMark = false;
var command = new L5.Command("org.loushang.live.engine.view.MessageSendCmd");

function isEmailAddr(s){   
	var patrn=/^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/; 
	if (!patrn.exec(s)) return false;
	return true;
}
/**
* 发送邮件使用cmd
*/
function sendCmd() {
	//调用检验参数方法，检验并向command中传参
	if(!checkSendParams())
		return;
	setCmdParam(true);
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
		//保存完成后sendByID
		if (!command.error) {
			//如果保存邮件没错，执行发送邮件操作
			command.execute("sendById");
			if(!command.error){
				L5.MessageBox.alert("提示","邮件正在发送!",function(){
					//关闭窗口
					closeMark = true;
					window.parent.close();
				});
			}else{
				L5.Msg.alert("错误",command.error);
			}
		}else{
			L5.Msg.alert("错误",command.error);
		}
	
}
/**
* 使用servlet发送消息不使用jms
*/
function sendServlet() {
	//调用检验参数方法，检验并向command中传参
	if(!checkSendParams())
		return;
	setCmdParam(true);
	command.setParameter("isvalidate" ,	"true");
		var method = getParam("method");
		if(method == "detail" || method == "forward"){
			command.execute("updateMessage");						
		}else{
			command.execute("saveMessage");
		}
		//保存后发送sendById
		if (!command.error) {
			//如果修改邮件没错，执行发送邮件操作
			//提交表单
			setParam("method" , "sendById"); 
			L5.Msg.alert("提示","邮件正在发送!",function(){
				//关闭窗口
				closeMark = true;
				document.getElementById("msgForm").submit();
				window.close();
			});			
		}else{
			L5.Msg.alert("错误",command.error);
		}
}

/**
* 事件处理：保存邮件
*/
function mailSave() {
	//调用检验参数方法，检验并向command中传参
	setCmdParam(true);
	//验证标题长度
	if(!checkTitle(false)){
		return;
	}
	var method = getParam("method");
	if(method == "detail" || method == "forward"){
		//通过对象调用Command中的updateMessage方法，执行保存邮件操作
		command.execute("updateMessage");
	}else{
		//通过对象调用Command中的saveMessage方法，执行保存邮件操作
		command.execute("saveMessage");
	}
	//保存提示
	if (!command.error) {
		L5.Msg.alert("提示","邮件保存成功!",function(){
			closeMark = true;
			window.parent.close();
		});
	}else{
		L5.Msg.alert("错误",command.error);
	}	
}


//设置焦点
function setFocus(){
	var editorDoc = CKEDITOR.instances.htmlEditor.document;
	var range = new CKEDITOR.dom.range(editorDoc);
	range.moveToElementEditEnd(editorDoc.getBody());
	range.select(true);
}

//设置cmd参数
//saveMark 表示是正常保存验证
function setCmdParam(saveMark){
	if(getParam("msgType") == 'e'){
		checkEmailAddr();
	}else if(getParam("msgType") == 'w'){
		checkInput();
	}
	//关闭的时候为了保证标题长度合法 验证截断300
	if(!saveMark){
		if(getInputLength(getParam("title")) > 1024){
			setParam("title" , getParam("title").substring(0 ,300));
		}
	}
	command.reset();
	command.setParameter("partyInfo" ,	getParam("partyInfo"));
	command.setParameter("partyName" , 	getParam("partyName"));
	command.setParameter("title"	 , 	getParam("title"));
 	command.setParameter("content"	 , 	CKEDITOR.instances.htmlEditor.getData());
//	command.setParameter("userId"	 , 	getParam("userId"));
	command.setParameter("sendTime"	 , 	getParam("sendTime"));
	command.setParameter("msgType" 	 , 	getParam("msgType"));
	command.setParameter("msgId" 	 , 	getParam("msgId"));
	command.setParameter("corrMsgId" , 	getParam("corrMsgId"));
	command.setParameter("bizType" , getParam("bizType"));
	return true;
}