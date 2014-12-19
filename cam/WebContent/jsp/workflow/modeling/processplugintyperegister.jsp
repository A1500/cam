<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>插件类型注册</title>
<next:ScriptManager></next:ScriptManager>
</head>
<body>

<model:datasets>
	<model:dataset id="processPluginTypeDefDataset"
		cmd="org.loushang.workflow.processdefinition.processplugintypedef.cmd.ProcessPluginTypeDefQueryCmd"
		autoLoad="true" global="true">
		<model:record
			fromBean="org.loushang.workflow.processdefinition.processplugintypedef.data.ProcessPluginTypeDef">
		</model:record>
	</model:dataset>
</model:datasets>

<next:ViewPort>
	<next:BorderLayout>
		<next:Center floatable="true" cmargins="0 0 0 0" margins="0 0 0 0">
			<next:Panel>
				<next:EditGridPanel id="processPluginTypeGridPanel" width="100%" height="100%" 
					dataset="processPluginTypeDefDataset" title="插件类型注册信息">
					<next:TopBar>
						<next:ToolBarItem symbol="->"/>
						<next:ToolBarItem iconCls="add" text="增加" handler="forInsert"/>
						<next:ToolBarItem iconCls="delete" text="删除" handler="forDelete"/>
						<next:ToolBarItem iconCls="undo" text="取消" handler="forCancel"/>
						<next:ToolBarItem iconCls="save" text="保存" handler="forSave"/>
					</next:TopBar>
					<next:Columns>
						<next:RowNumberColumn width="30" />
						<next:CheckBoxColumn></next:CheckBoxColumn>
						<next:Column field="pluginName" header="插件名称" width="140">
							<next:TextField allowBlank="false"></next:TextField>
						</next:Column>
						<next:Column field="pluginType" header="插件类型" width="140">
							<next:TextField allowBlank="false"></next:TextField>
						</next:Column>
						<next:Column field="pluginPath" header="插件路径" width="350" >
							<next:TextField allowBlank="false"></next:TextField>
						</next:Column>
						<next:Column field="xmlParser" header="XML解析类" width="400">
							<next:TextField allowBlank="false"></next:TextField>
						</next:Column>
					</next:Columns>
					<next:BottomBar>
						<next:PagingToolBar dataset="processPluginTypeDefDataset"></next:PagingToolBar>
					</next:BottomBar>
				</next:EditGridPanel>
			</next:Panel>
		</next:Center>
	</next:BorderLayout>
</next:ViewPort>
</body>
<script>
// 新增
function forInsert() {
	processPluginTypeDefDataset.newRecord();
}
// 取消
function forCancel()
{
	processPluginTypeDefDataset.rejectChanges();
}
// 删除
function forDelete()
{
	var processPluginTypeGridPanel = L5.getCmp('processPluginTypeGridPanel');
	var selected = processPluginTypeGridPanel.getSelectionModel().getSelections();
	if (selected.length < 1) {
		L5.Msg.alert("提示", "请选择要删除的记录！");
		return false;
	}
	L5.MessageBox.confirm('确定', '确定要删除选中的记录吗？',function(state){
		if(state=="yes"){
			var deleteSelected = [];
			for(var i = 0; i < selected.length; i++) {
				if(selected[i].state == 1) {
					processPluginTypeDefDataset.remove(selected[i]);
				} else {
					deleteSelected[i] = selected[i];
				}
			}
			if (deleteSelected.length < 1) {
				return;
			} else {
				var command=new L5.Command(
						"org.loushang.workflow.processdefinition.processplugintypedef.cmd.ProcessPluginTypeDefCmd"); 
				command.setParameter("selected", deleteSelected);
				command.execute("delete");
				if (!command.error) {
					L5.Msg.alert("提示","删除成功!");
					processPluginTypeDefDataset.load();
				} else {
					alert(command.error);
				}
			}   
		}else{
			return false;
		}
	});
}
// 保存
function forSave()
{
	var records = processPluginTypeDefDataset.getAllChangedRecords();
	if (records.length < 1)
	{
		// 没有做任何修改,返回
		L5.Msg.alert("提示", "没有需要保存的数据!");
		return;
	}
	// 校验
	var isValidate= processPluginTypeDefDataset.isValidate();
	if(isValidate!=true){
		L5.Msg.alert("提示", "校验未通过,不能保存!");
		return;		
	}
	
	var idStr = ";";
	var patrn=/^[a-zA-Z_]{0,}$/;  
	for(var i=0;i<records.length;i++){
		if(records[i].get("pluginName").indexOf("'")>=0){
			L5.Msg.alert("提示","插件名称不接受单引号输入!");
			return;
		}else if(!patrn.exec(records[i].get("pluginType"))){
			L5.Msg.alert("提示","插件类型只接受字母和下划线!");
			return;
		}else if(idStr.indexOf(";"+records[i].get("pluginType")+";")!=-1){
			L5.Msg.alert("提示","插件类型不能重复!");
			return;
		}else{
			idStr = idStr+records[i].get("pluginType")+";";	
		}
	}
	
	// 保存
	var command = new L5.Command(
			"org.loushang.workflow.processdefinition.processplugintypedef.cmd.ProcessPluginTypeDefCmd");
	command.setParameter("records", records);
	command.execute("save");
	// 返回执行结果
	if (!command.error) {
		processPluginTypeDefDataset.commitChanges();
		processPluginTypeDefDataset.reload();
		L5.Msg.alert("提示","保存数据成功! ");
	}else{
		L5.Msg.alert("提示",command.error);
	}
}
</script>
</html>