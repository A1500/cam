<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>流程定义按钮定义</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="procdefpagebuttonconf.js"></script>
</head>
<body>

<model:datasets>
	<model:dataset pageSize="-1" id="processPluginTypeDefDataset"
		cmd="org.loushang.workflow.processdefinition.processplugintypedef.cmd.ProcessPluginTypeDefQueryCmd"
		autoLoad="true" global="true">
		<model:record
			fromBean="org.loushang.workflow.processdefinition.processplugintypedef.data.ProcessPluginTypeDef">
		</model:record>
	</model:dataset>
	<!--procDefPageButtonDefDataset 对应的cmd是继承自BaseQueryCommand，可以在dataset标签中通过cmd指定，并使用autoLoad属性设置为自动加载，在页面加载时就会自动加载该数据了。-->
	<model:dataset id="procDefPageButtonDefDataset"
		cmd="org.loushang.workflow.processdefinition.procdefpagebuttondef.cmd.ProcDefPageButtonDefQueryCmd"
		autoLoad="false" global="true">
		<!--record标签指明该数据集中对应的Bean-->
		<model:record
			fromBean="org.loushang.workflow.processdefinition.procdefpagebuttondef.data.ProcDefPageButtonDef"></model:record>
	</model:dataset>
	<model:dataset id="procDefButtonConfSetProcType" enumName="PROC_DEF_BUTTON_CONF_SET_PROC_TYPE" autoLoad="true">
	</model:dataset>
</model:datasets>
<next:ViewPort>
	<next:BorderLayout>
		<next:Defaults>{collapsible:true,split:true,animFloat:true,autoHide:true,useSplitTips:true,bodyStyle:'padding:6px;'}</next:Defaults>
		<next:Center floatable="true" cmargins="0 0 0 0" margins="0 0 0 0">
			<next:Panel>
				<next:EditGridPanel id="editGridPanel" width="100%" height="100%" 
					dataset="procDefPageButtonDefDataset" title="流程定义页面按钮配置信息">
					<next:TopBar>
						<next:ToolBarItem symbol="->"></next:ToolBarItem>
						<next:ToolBarItem iconCls="add" text="增加" handler="Evt_butinsert_click()"/>
						<next:ToolBarItem iconCls="delete" text="删除" handler="Evt_butdelete_click()"/>
						<next:ToolBarItem iconCls="undo" text="取消" handler="Evt_butundo_click()"/>
						<next:ToolBarItem iconCls="save" text="保存" handler="Evt_butsave_click()"/>
					</next:TopBar>
					<next:Columns>
						<next:RowNumberColumn width="30" ></next:RowNumberColumn>
						<next:CheckBoxColumn></next:CheckBoxColumn>
						<next:Column header="按钮ID" id="id" field="id" width="200" hidden="true">
							<next:TextField allowBlank="false" />
						</next:Column>
						<next:Column field="displayName" header="按钮名称" width="200">
							<next:TextField allowBlank="false"></next:TextField>
						</next:Column>
						<next:Column field="description" header="按钮说明" width="200">
							<next:TextField allowBlank="false"></next:TextField>
						</next:Column>
						<next:Column field="displayOrder" header="显示顺序" width="100">
							<next:NumberField allowBlank="false"></next:NumberField>
						</next:Column>
						<next:Column field="pluginType" header="插件类型" width="180">
							<next:TextField allowBlank="false"></next:TextField>
							<next:ComboBox triggerAction="all" dataset="processPluginTypeDefDataset" displayField="pluginType" valueField="pluginType" typeAble="false"></next:ComboBox>
						</next:Column>
						<next:Column field="needSetProcType" header="是否设置流程类型" width="150">
							<next:TextField allowBlank="false"></next:TextField>
							<next:ComboBox triggerAction="all" dataset="procDefButtonConfSetProcType" typeAble="false"/>
						</next:Column>
					</next:Columns>
					<next:BottomBar>
						<next:PagingToolBar dataset="procDefPageButtonDefDataset"></next:PagingToolBar>
					</next:BottomBar>
				</next:EditGridPanel>
	</next:Panel>
		</next:Center>
	</next:BorderLayout>
</next:ViewPort>
</body>
</html>