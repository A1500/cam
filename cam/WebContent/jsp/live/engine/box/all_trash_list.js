function delMsg() {
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
					ids[i] = cell[i].get("envId");
				}			
				//删除后台的数据
			if(ids.length !==0){
				var command = new L5.Command("org.loushang.live.engine.view.MessageSendCmd");
				//将所有被修改过的Record作为command参数传递给后台command
				command.setParameter("envs", ids);
				//通过对象调用LsPlanCommand中的deletePlan方法，执行计划删除功能
				command.execute("delete");
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

function delAllMsg() {	
	L5.MessageBox.confirm("提示","确认删除所有邮件?",
		function(sta){
			if(sta ==='yes'){

				var command = new L5.Command("org.loushang.live.engine.view.MessageSendCmd");

				//通过对象调用Command中的deleteAll方法，执行删除功能
				command.execute("deleteAll");
				if (!command.error) {				
					L5.Msg.alert("提示","删除成功!");	
					//清除所有前台记录				
					msgDs.removeAll();					
					var panel  = L5.getCmp("insertRoot");
					panel.hide();
					var attach = L5.getCmp("attachGridPanel");
					attach.hide();
				}else{
					L5.Msg.alert("错误",command.error);
					return;
				}			
	}});	
}