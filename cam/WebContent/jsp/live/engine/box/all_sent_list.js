//转发邮件触发事件
function forward(){
	//获取jsp中定义的ID为editGridPanel的EditGridPanel
	var grid  = L5.getCmp("editGridPanel");
	//获取被选中的记录行
	var sm = grid.getSelectionModel();
	var records=sm.getSelections();
	//如果只被选中一条记录行，则跳转到任务设定页面mail_edit.jsp
	if(records&&records.length==1){
		var msgId=records[0].get("msgId");
		var msgType=records[0].get("msgType");
		if(msgType=="w"||msgType=="e"){
			var newMsgId = handleForward(msgId , msgType);
			if(newMsgId == null)
				return;
			var url="../mail/mail_edit.jsp?msgId="+newMsgId+"&msgType="+msgType+"&method=forward";
			var text = "转发邮件";
		}else if (msgType=="s"){
			var url="../sms/sms_edit.jsp?msgType="+msgType+"&msgId="+msgId+"&method=forward";
			var text = "转发短信";
		}else if(msgType=="m"){
			var url="../sms/msg_edit.jsp?msgType="+msgType+"&msgId="+msgId+"&method=forward";
			var text = "转发消息";
		}else{
			if(DeliveryMode[msgType].withContent || DeliveryMode[msgType].withAttach){
				msgId = handleForward(msgId , msgType);
				if(msgId == null)
					return;
			}
			var url = L5.webPath + "/jsp/" +DeliveryMode[msgType].editUrl + "?msgId=" + msgId+"&msgType="+msgType+"&method=forward";
			var text = "转发" + DeliveryMode[msgType].text;
		}
		showWindow(url , "" , msgType, false);
	}else{
		L5.Msg.alert("提示","请选择一条记录！");
	}	
}

