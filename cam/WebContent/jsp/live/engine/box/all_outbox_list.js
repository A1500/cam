var xmlRequestHttp = null;

//删除邮件
function delTemp() {
	//获取jsp中定义的ID为editGridPanel的EditGridPanel
	var grid  = L5.getCmp("editGridPanel");
	//获取被选中的记录行
	var sm = grid.getSelectionModel();
	var cell = sm.getSelections();
	var ids;
	if(cell==null || cell.length == 0){
		L5.Msg.alert("提示","请选择一条记录");
		return;
	}
	L5.MessageBox.confirm("提示","确认删除所选邮件?",
		function(sta){
			if(sta ==='yes'){
				ids = [];	
				for(var i=0; i<cell.length; i++){					
					ids[i] = cell[i].get("msgId");
				}			
				//删除后台的数据
			if(ids.length !==0){
				var command = new L5.Command("org.loushang.live.engine.view.MessageSendCmd");
				//将所有被修改过的Record作为command参数传递给后台command
				command.setParameter("msgs", ids);
				//通过对象调用LsPlanCommand中的deletePlan方法，执行计划删除功能
				command.execute("deleteTemp");
				if (!command.error) {
				//	msgDs.commitChanges();
					L5.Msg.alert("提示","删除成功!");
					for(var i=0; i<cell.length; i++){
						msgDs.remove(cell[i]);
					}
					var panel  = L5.getCmp("insertRoot");
					panel.hide();
					var attach = L5.getCmp("attachGridPanel");
					attach.hide();
				}else{
					L5.Msg.alert("错误",command.error);
					return;
				}
			}			
	}});
	
}

/**
* 发送邮件cmd
*/
function mailSendCmd() {
	var grid  = L5.getCmp("editGridPanel");
	//获取被选中的记录行
	var sm = grid.getSelectionModel();
	var records=sm.getSelections();
	if(records!=""){
		for(var i=0; i<records.length; i++){
			var partyName = records[i].get("partyName");
			var title = records[i].get("title");
			var msgType = records[i].get("msgType");
			if(partyName == null || title==null || partyName == "" || title==""){
				L5.Msg.alert("提示","发件人与邮件主题不可为空！");
				return ;
			}
			if(!checkDateTime(records[i].get("sendTime"))){
				L5.Msg.alert("提示","发送时间格式有误！");
				return ;
			}
			
			var command = new L5.Command("org.loushang.live.engine.view.MessageSendCmd");
			command.setParameter("msgId", records[i].get("msgId"));
			command.setParameter("msgType",msgType );
			command.setParameter("isvalidate" , "true");
			command.execute("sendById");
			//保存提示
			if (!command.error) {	
				if(msgType=="m"){
					L5.Msg.alert("提示","消息正在发送!");
				}else if(msgType=="s"){
					L5.Msg.alert("提示","短信正在发送!");
				}else if(msgType=="w" || msgType=="e"){
					L5.Msg.alert("提示","邮件正在发送!");
				}else{
					L5.Msg.alert("提示" , DeliveryMode[msgType].text + "正在发送!");	
				}
				var panel  = L5.getCmp("insertRoot");
				panel.hide();
				var attach = L5.getCmp("attachGridPanel");
				attach.hide();
				msgDs.setParameter("boxType",document.getElementById("boxType").value);	
				msgDs.load();	
			}else{
				L5.Msg.alert("错误",command.error);
			}
		}//for
	}else{
		L5.Msg.alert("提示","请选择一条记录！");
	}
}

/**
* 发送邮件servlet
*/
function mailSendServlet() {
	xmlRequestHttp = GetXmlHttpObject();
	var grid  = L5.getCmp("editGridPanel");
	//获取被选中的记录行
	var sm = grid.getSelectionModel();
	var records=sm.getSelections();
	if(records!=""){
		for(var i=0; i<records.length;i++){
			var partyName = records[i].get("partyName");
			var title = records[i].get("title");
			var msgType = records[i].get("msgType");
			if(partyName == null || title==null || partyName == "" || title==""){
				L5.Msg.alert("提示","发件人与主题不可为空！");
				return ;
			}
			if(!checkDateTime(records[i].get("sendTime"))){
				L5.Msg.alert("提示","发送时间格式有误！");
				return ;
			}
			var url = L5.webPath+"/MessageSender?";
			url += "msgId=" + records[i].get("msgId");
			url += "&msgType=" + msgType;
			url += "&method=sendById";
			url += "&isvalidate=true";
			url += "&" + new Date().getTime(); //防止缓存
			xmlRequestHttp.onreadystatechange = sendStatus;
			xmlRequestHttp.open("GET" , url , true);
			xmlRequestHttp.send(null);	
			var panel  = L5.getCmp("insertRoot");
			panel.hide();
			var attach = L5.getCmp("attachGridPanel");
			attach.hide();
			msgDs.setParameter("boxType",document.getElementById("boxType").value);	
			msgDs.load();		
		}//for
	}else{
		L5.Msg.alert("提示","请选择一条记录！");
	}
}



//取消发送
function cancelSend(){
	var grid  = L5.getCmp("editGridPanel");
	//获取被选中的记录行
	var sm = grid.getSelectionModel();
	var records=sm.getSelections();
	if(records!=""){
		for(var i=0; i<records.length;i++){
		var stat = records[i].get("stat");
		if(stat=="1"){
		var command = new L5.Command("org.loushang.live.engine.view.MessageSendCmd");
		command.setParameter("msgId", records[i].get("msgId"));
		command.execute("cancelSend");
		}else{
			L5.Msg.alert("错误","只有等待状态的消息可以取消!");
			return;
		}
	}
		//保存提示
		if (!command.error) {
			
			L5.Msg.alert("提示","邮件取消成功!");		
			for(var j=0; j<records.length; j++){
				records[j].set("stat","0");	
			}
			msgDs.commitChanges();
		}else{
			L5.Msg.alert("错误",command.error);
		}
	}

}

