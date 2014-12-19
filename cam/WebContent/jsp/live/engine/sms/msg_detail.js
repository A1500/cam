//获取页面输入域值，并对空进行处理
function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}


//回复邮件触发事件
function reply() {
//	var userId=document.getElementById("userId").value;
	if(msgType=="m"){
		var url="msg_edit.jsp?msgType="+msgType+"&msgId="+msgId+"&method=reply";
		var text = "回复消息";
		showWindow(url , "" , msgType , false);
	}else if(msgType=="s"){
		var url="sms_edit.jsp?msgType="+msgType+"&msgId="+msgId+"&method=reply";
		var text = "回复短信";
		showWindow(url , "" , msgType , false);
	}
}
//转发邮件触发事件
function forward(){	
	if(msgType=="m"){
		var url="msg_edit.jsp?msgType="+msgType+"&msgId="+msgId+"&method=forward";
		var text = "转发消息";
		showWindow(url , "" , msgType , false);
	}else if(msgType=="s"){
		var url="sms_edit.jsp?msgType="+msgType+"&msgId="+msgId+"&method=forward";
		var text = "转发短信";
		showWindow(url , "" , msgType , false);
	}
}
