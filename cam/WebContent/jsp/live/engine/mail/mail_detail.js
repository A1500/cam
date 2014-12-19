//回复邮件触发事件
function reply() {
//	var userId=document.getElementById("userId").value;
	var msgType=document.getElementById("msgType").value;
	var msgId=document.getElementById("msgId").value;
	var url="mail_edit.jsp?msgType="+msgType+"&msgId="+msgId+"&method=reply";
	var text = "回复邮件";
	showWindow(url , "" , msgType , false);
}
//转发邮件触发事件
function forward(){
	var msgType=document.getElementById("msgType").value;
	var msgId=document.getElementById("msgId").value;
	var newMsgId = handleForward(msgId , msgType);
	if(newMsgId == null){
		return;
	}		
	var url="../mail/mail_edit.jsp?msgId="+newMsgId+"&msgType="+msgType+"&method=forward";
	var text = "转发邮件";
	showWindow(url , "" , msgType , false);
}

function download(){
	var grid  = L5.getCmp("attachGridPanel");
	//获取被选中的记录行
	var sm = grid.getSelectionModel();
	var records=sm.getSelections();
	if(records.length != 1){
		L5.Msg.alert("提示","请选中一行下载！");
		return;
	}
	var fileID=records[0].get("fileID");
	
	var url = document.getElementById("realurl").value + "/UploadServlet?method=download&uuid="+fileID;
	var elemIF = document.createElement("iframe");   
	elemIF.src = url;   
	elemIF.style.display = "none";   
	document.body.appendChild(elemIF);
}



