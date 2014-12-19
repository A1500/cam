
<%@ page language="java" contentType="text/html;charset=utf-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>操作列表</title>
<next:ScriptManager></next:ScriptManager>
</head>
<body>

<model:datasets>
	<model:dataset pageSize="10" id="proxyOperationDefDs" method="query"
		cmd="org.loushang.workflow.tripproxy.cmd.TripProxyOperationDefQueryCmd"
		autoLoad="true" global="true">>
		<model:record excluding="xpdlContent,xmlContent"
			fromBean="org.loushang.workflow.tripproxy.data.TripProxyOperationDef"></model:record>
	</model:dataset>
</model:datasets>

<next:ViewPort>
<next:BorderLayout>
	<next:Defaults>{collapsible:true,split:true,animFloat:true,autoHide:true,useSplitTips:true,bodyStyle:'padding:6px;'}</next:Defaults>
	<next:Center>
	<next:Panel>
		<next:GridPanel id="proxyGridPanel" name="proxyGridPanel"
			anchor="100%" width="100%" height="100%" dataset="proxyOperationDefDs"
			title="委托操作列表" notSelectFirstRow="true">
			<next:TopBar>
				<next:ToolBarItem symbol="->"></next:ToolBarItem>
				<next:ToolBarItem iconCls="add" text="新增操作" handler="addOperation" />
				<next:ToolBarItem iconCls="remove" text="删除操作" handler="deleteOperation" />
			</next:TopBar>
			<next:Columns>
				<next:RowNumberColumn width="30" />
				<next:CheckBoxColumn></next:CheckBoxColumn>
				<next:Column id="id" header="主键" field="id" width="50" hidden="true">
					<next:TextField allowBlank="false" />
				</next:Column>
				<next:Column id="id" header="操作内码" field="operationCode" width="50" hidden="true">
					<next:TextField allowBlank="false" />
				</next:Column>
				<next:Column header="操作名称" field="operationName" width="250">
					<next:TextField allowBlank="false" />
				</next:Column>
			</next:Columns>
			<next:BottomBar>
				<next:PagingToolBar displayMsg="从第{0}条到{1}条，一共{2}条"
					displayInfo="true" dataset="proxyOperationDefDs" />
			</next:BottomBar>
		</next:GridPanel>
	</next:Panel>
	</next:Center>
	</next:BorderLayout>
</next:ViewPort>
</body>
<script language="javascript" type="text/javascript">
//新增操作
function addOperation(){
	var url="jsp/workflow/tripproxy/processpermisionforinsert.jsp";
	L5.forward(url,"新增操作");
}
//删除操作
function deleteOperation(){
	var proxyOperationDefDs=L5.DatasetMgr.lookup("proxyOperationDefDs");
	if(proxyOperationDefDs.getCount()==0){
		L5.MessageBox.alert("消息提示",'没有要删除的记录!');
		return;
	}
	var proxyGridPanel = L5.getCmp('proxyGridPanel');
	var selected = proxyGridPanel.getSelectionModel().getSelections();
	var leng = selected.length;
	if( leng< 1){
		L5.MessageBox.alert("消息提示",'请选择要删除的记录!');
		return;
	}
	var ids=[];
	for(var i=0;i<leng;i++){
		ids[i]=selected[i].get("id");
		}

	L5.MessageBox.confirm("消息提示", "你确定要删除吗?",
			function(sta){
		if(sta =='yes'){
	var command =new L5.Command("org.loushang.workflow.tripproxy.cmd.TripProxyOperationDefCmd");
	command.setParameter("ids",ids);
	command.afterExecute = function() {
		if (!command.error) {
			L5.Msg.alert("消息提示","删除成功");
			for(var i=0;i<leng;i++){
				proxyOperationDefDs.remove(selected[i]);
				}
		}else {
			L5.Msg.alert("错误:", command.error);
		}
		}
	command.execute("delete");}});
	
}

		</script>
</html>