//回复邮件触发事件
function reply() {
//获取jsp中定义的ID为editGridPanel的EditGridPanel
	var grid  = L5.getCmp("editGridPanel");
	//获取被选中的记录行
	var sm = grid.getSelectionModel();
	var records=sm.getSelections();
	//如果只被选中一条记录行，则跳转到任务设定页面mail_edit.jsp，并把参数传递到该页面
	if(records&&records.length==1){
		var msgId=records[0].get("msgId");	
		var msgType=records[0].get("msgType");
		if(msgType=="w"||msgType=="e"){
			var url="../mail/mail_edit.jsp?msgType="+msgType+"&msgId="+msgId+"&method=reply";
			var text = "回复邮件";
		}else if(msgType=='m'){
			var url="../sms/msg_edit.jsp?msgType="+msgType+"&msgId="+msgId+"&method=reply";
			var text = "回复消息";
		}else{
			var url = L5.webPath + "/jsp/" +DeliveryMode[msgType].editUrl + "?msgType=" + msgType+ "&msgId="+msgId+"&method=reply";
			var text = DeliveryMode[msgType].text;
		}
		showWindow(url , "" , msgType , false);
	}else{
		L5.Msg.alert("提示","请选择一条记录！");
	}
}
//回复全部触发事件
function replyAll() {
//获取jsp中定义的ID为editGridPanel的EditGridPanel
	var grid  = L5.getCmp("editGridPanel");
	//获取被选中的记录行
	var sm = grid.getSelectionModel();
	var records=sm.getSelections();
	//如果只被选中一条记录行，则跳转到任务设定页面mail_edit.jsp，并把参数传递到该页面
	if(records&&records.length==1){
		var msgId=records[0].get("msgId");
		var msgType=records[0].get("msgType");	
		//var url="../mail/mail_edit.jsp?msgType="+msgType+"&msgId="+msgId+"&method=reply";
		//var text = "回复邮件";
		var url = L5.webPath + "/jsp/" +DeliveryMode[msgType].editUrl + "?msgType=" + msgType+ "&msgId="+msgId+"&method=reply";
		var text = DeliveryMode[msgType].text;
		showWindow(url , "" , msgType , false);
	}else{
		L5.Msg.alert("提示","请选择一条记录！");
	}
}
//转发邮件触发事件
function forward(){
	//获取jsp中定义的ID为editGridPanel的EditGridPanel
	var grid  = L5.getCmp("editGridPanel");
	//获取被选中的记录行
	var sm = grid.getSelectionModel();
	var records=sm.getSelections();
	if(records&&records.length==1){
		var msgId = records[0].get("msgId");
		var msgType = records[0].get("msgType");
		if(msgType=="w"||msgType=="e"){
			var newMsgId = handleForward(msgId , msgType);
			if(newMsgId == null)
				return;
			var url="../mail/mail_edit.jsp?msgId="+newMsgId+"&msgType="+msgType+"&method=forward";
			var text = "转发邮件";
		}else if (msgType == 's'){
			var url="../sms/sms_edit.jsp?msgType="+msgType+"&msgId="+msgId+"&method=forward";
			var text = "转发短信";
		}else if(msgType == 'm'){
			var url="../sms/msg_edit.jsp?msgType="+msgType+"&msgId="+msgId+"&method=forward";
			var text = "转发消息";
		}else{
			//如果有内容或者附件则需要先处理转发
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

//显示邮件具体信息
function showReMail(){
var grid  = L5.getCmp("editGridPanel");
//获取被选中的记录行
	var sm = grid.getSelectionModel();
	var records=sm.getSelections();
	if(records!=""){
		var msgType = records[0].get("msgType");
		var panel  = L5.getCmp("insertRoot");
		var attach = L5.getCmp("attachGridPanel");
		var envId=records[0].get("envId");
		var msgId=records[0].get("msgId");
		records[0].set("stat","2");	
		mailDs.setParameter("envId",envId);
		mailDs.load(true);
		if(msgType=="w"||msgType=="e"){		
			if(mailDs.getAt(0).get("content").length){
				panel.show();
				window.frames["contentFrame"].document.body.innerHTML = mailDs.getAt(0).get("content");
			}else{
				panel.hide();
			}
			var hasAttach = records[0].get("hasAttach");
			if(hasAttach=="true"){			
				attach.show();
				attachDs.setParameter("msgId",msgId);
				attachDs.setParameter("boxType","in");
				attachDs.setParameter("method","detail");
				attachDs.load();	
			}else{
				attach.hide();
			}
		}else if(msgType == 'm'){
			panel.hide();
			attach.hide();
		}else{
			if(DeliveryMode[msgType].withContent){
				if(mailDs.getAt(0).get("content").length){
					panel.show();
					window.frames["contentFrame"].document.body.innerHTML = mailDs.getAt(0).get("content");
				}else{
					panel.hide();
				}
			}else{
				panel.hide();
			}		
			if(DeliveryMode[msgType].withAttach){
				var hasAttach=records[0].get("hasAttach");
				if(hasAttach == "true"){	
					attach.show();
					attachDs.setParameter("msgId" , msgId);
					attachDs.setParameter("boxType" , "in");
					attachDs.setParameter("method" , "detail");
					attachDs.load();
				}else{
					attach.hide();
				}
			}else{
				attach.hide();
			}
		}
	}
}


function readMark(stat){
	document.getElementById("statMark").value = stat;
}

function isRead(stat){
	var msgState = L5.DatasetMgr.lookup("msgState");
	if(stat == 1)
		return '<font style="font-weight:bold">' + msgState.getAt(stat).get("text") + '</font>';
	else
		return msgState.getAt(stat).get("text");
}
function isBold(arg){
	var stat = document.getElementById("statMark").value;
	if(stat == 1){
		return '<font style="font-weight:bold">' + arg + '</font>';
	}else{
		return arg;
	}
}
function titleRead(title){
	var stat = document.getElementById("statMark").value;
	var msgType = document.getElementById("typeMark").value;
	var htmlReg = /<[^>]+>/g;
	if(stat == 1){
		return '<font style="font-weight:bold">' + title.replace(htmlReg , "") + '</font>';
	}else{
		return title.replace(htmlReg , "");
	}
}
