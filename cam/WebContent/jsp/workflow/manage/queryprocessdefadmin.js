function getParam(ElementId) {
	var value = document.getElementById(ElementId).value;
	if(value.indexOf("'")!=-1){
		  L5.Msg.alert("提示", "不接受单引号输入!");
		  return;
	}
	if (value == "")
		value = undefined;
	return value;
}
function query() {
	ds.setParameter("name@like", getParam("name"));
	ds.load();
}
function addLink(value) {
	return value < 1 ? 0 : "<a href='javascript:page.toProcess()'>" + value
			+ "</a>";
}
function addLink2(value) {
	return value < 1 ? 0 : "<a href='javascript:page.toProcess2()'>" + value
			+ "</a>";
}

function queryAct() {
	var edit = L5.getCmp('GridPanel');
	var selected = edit.getSelectionModel().getSelections();
	var len = selected.length;
	if (len < 1) {
		L5.Msg.alert("提示：", "请选择要查看的记录!");
		return;
	}
	else if(len>1){
		L5.Msg.alert("提示","只能选择一条记录查看!");
	}
	else {
		var proCount = selected[0].get("processCount");
			if (proCount > 0) {
				var id = ds.getCurrent().get("procDefUniqueId");
				var text = '活动流程实例';
				var url = "jsp/workflow/manage/queryprocessadmin.jsp?procDefUniqueId="
					+ id+"&procName="+getParam("name");
				url = encodeURI(encodeURI(url));
				L5.forward(url, text);
			}
			else{
				L5.Msg.alert("提示","没有活动流程实例!");
			}
		

	}
}

function queryEnd() {
	var edit = L5.getCmp('GridPanel');
	var selected = edit.getSelectionModel().getSelections();
	var len = selected.length;
	if (len < 1) {
		L5.Msg.alert("提示：", "请选择要查看的记录!");
		return;
	} 
	else if(len>1){
		L5.Msg.alert("提示","只能选择一条记录查看!");
	}
	else {
		var proCount = selected[0].get("processEndCount");
			if (proCount > 0) {
				var id = ds.getCurrent().get("procDefUniqueId");
				var text = '办结流程实例';
				var url = "jsp/workflow/manage/queryprocessend.jsp?procDefUniqueId="
					+ id+"&procName="+getParam("name");
				url = encodeURI(encodeURI(url));
				L5.forward(url, text);
			}
			else{
				L5.Msg.alert("提示","没有办结流程实例!");
			}
		

	}

}

function dele() {
	var editGrid = L5.getCmp('GridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	var leng = selected.length;
	if (leng < 1) {
		L5.Msg.alert("提示：", "请选择要删除的记录!");
		return;
	} else {
		var proCount;
		for ( var i = 0; i < leng; i++) {
			proCount = selected[i].get("processCount");
			if (proCount > 0) {
				L5.Msg.alert("提示：", selected[i].get("procDefName") + " ：存在"
						+ proCount + "个活动流程实例！");
				return;
			}
			proCount = selected[i].get("processEndCount");
			if (proCount > 0) {
				L5.Msg.alert("提示：", selected[i].get("procDefName") + " ：存在"
						+ proCount + "个办结流程实例！");
				return;
			}
		}
	}
	L5.MessageBox
			.confirm(
					'确定',
					'确定要删除选中的记录吗?',
					function(state) {
						if (state == "yes") {
							var delIds = [];
							for ( var i = 0; i < selected.length; i++) {
								delIds[i] = selected[i].get("procDefUniqueId");
							}
							var command = new L5.Command(
									"org.loushang.workflow.manage.processdef.cmd.ProcessDefManageCmd");
							command.setParameter("delIds", delIds);
							command.execute("delete");
							if (!command.error) {
								for ( var i = 0; i < selected.length; i++) {
									ds.remove(selected[i]);
								}
								L5.Msg.alert("提示：", "删除流程定义完成");
								ds.commitChanges();
							} else {
								L5.Msg.alert("提示：", command.error);
							}
						} else {
							return false;
						}
					});
}
var page;
if (!page)
	page = {};
page.toProcess = function() {
	var id = ds.getCurrent().get("procDefUniqueId");
	var text = '活动流程实例';
	var url ="jsp/workflow/manage/queryprocessadmin.jsp?procDefUniqueId=" + id +"&procName="+getParam("name");
	url = encodeURI(encodeURI(url));
	L5.forward(url,text);
}
page.toProcess2 = function() {
	var id = ds.getCurrent().get("procDefUniqueId");
	var text = '办结流程实例';
	var url ="jsp/workflow/manage/queryprocessend.jsp?procDefUniqueId=" + id +"&procName="+getParam("name");
	url = encodeURI(encodeURI(url));
	L5.forward(url, text);
}

function delAll() {
	var editGrid = L5.getCmp('GridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	var leng = selected.length;
	if (leng < 1) {
		L5.Msg.alert("提示：", "请选择要删除的记录!");
		return;
	}
	L5.MessageBox
			.confirm(
					'确定',
					'确定要删除选中的记录吗?',
					function(state) {
						if (state == "yes") {
							var delIds = [];
							var proCount;
							var proEndCount;
							for ( var i = 0; i < leng; i++) {
								delIds[i] = selected[i].get("procDefUniqueId");
								proCount = selected[i].get("processCount");
								proEndCount = selected[i]
										.get("processEndCount");
								if (proCount > 0) {
									var processIds = [];
									// for(i=0;i<proCount;i++)
									// {
									var procDefUniqueId;
									var command = new L5.Command(
											"org.loushang.workflow.manage.processdef.cmd.ProcessDefManageCmd");
									command.setParameter("procDefUniqueId",
											delIds[i]);
									command.execute("queryProcessIds");
									var processIdArray = [];
									processIdArray = command
											.getReturn("processIds");

									for (j = 0; j < processIdArray.length; j++) {
										if (processIdArray[j] != null) {
											processIds[j] = processIdArray[j];
										}

									}
									// }
									var cmd = new L5.Command(
											"org.loushang.workflow.manage.processdef.cmd.ProcessDefManageCmd");
									cmd.setParameter("deletes", processIds);
									cmd.execute("deleteAll");

								}

								if (proEndCount > 0) {
									var processIds = [];
									// for(i=0;i<proEndCount;i++)
									// {
									var procDefUniqueId;
									var cmd = new L5.Command(
											"org.loushang.workflow.manage.processdef.cmd.ProcessDefManageCmd");
									cmd.setParameter("procDefUniqueId",
											delIds[i]);
									cmd.execute("getProcessIds");
									var processIdArray = [];
									processIdArray = cmd
											.getReturn("processIds");

									for (j = 0; j < processIdArray.length; j++) {
										if (processIdArray[j] != null) {
											processIds[j] = processIdArray[j];
										}
									}
									// }
									var cmd = new L5.Command(
											"org.loushang.workflow.manage.processdef.cmd.ProcessDefManageCmd");
									cmd.setParameter("ids", processIds);
									cmd.execute("delete");
								}
							}

							var command = new L5.Command(
									"org.loushang.workflow.manage.processdef.cmd.ProcessDefManageCmd");
							command.setParameter("delIds", delIds);
							command.execute("delete");
							if (!command.error) {
								for ( var i = 0; i < selected.length; i++) {
									ds.remove(selected[i]);
								}
								L5.Msg.alert("提示：", "删除流程定义完成");
								ds.commitChanges();
							} else {
								L5.Msg.alert("提示：", command.error);
							}
						} else {
							return false;
						}
					});
}

function directDelete() {
	var editGrid = L5.getCmp('GridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	var leng = selected.length;
	if (leng < 1) {
		L5.Msg.alert("提示：", "请选择要删除的记录!");
		return;
	}
	L5.MessageBox
			.confirm(
					'确定',
					'确定要删除选中的记录吗?',
					function(state) {
						if (state == "yes") {
							var delIds = [];
							for ( var i = 0; i < selected.length; i++) {
								delIds[i] = selected[i].get("procDefUniqueId");
							}
							var command = new L5.Command(
									"org.loushang.workflow.manage.processdef.cmd.ProcessDefManageCmd");
							command.setParameter("delIds", delIds);
							command.execute("directDelect");
							if (!command.error) {
								for ( var i = 0; i < selected.length; i++) {
									ds.remove(selected[i]);
								}
								L5.Msg.alert("提示：", "删除流程定义完成");
								ds.commitChanges();
							} else {
								L5.Msg.alert("提示：", command.error);
							}
						} else {
							return false;
						}
					});
}
