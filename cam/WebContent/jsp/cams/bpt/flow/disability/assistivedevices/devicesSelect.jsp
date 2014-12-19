
<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<next:ScriptManager/>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>伤残辅助器械选择</title>
<script type="text/javascript" src="devicesSelect.js"></script>
<script>
			var applyApparatusId= '<%=request.getParameter("applyApparatusId")%>';
			var applyId='<%=request.getParameter("applyId")%>';
		</script>
</head>
<body>
<model:datasets>
	<model:dataset id="DevicesMaintenaDataset" cmd="com.inspur.cams.bpt.manage.cmd.BptAssistiveDevicesMaintenaQueryCommand" global="true" > 
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptAssistiveDevicesMaintena">
			<model:field name="num" type="string"/>
		</model:record>
	</model:dataset>
</model:datasets>

		<next:Panel  border="false" height="100%" width="100%" >
			<next:TopBar>
				<next:ToolBarItem symbol="->"></next:ToolBarItem>
				<next:ToolBarItem id="saveButoon" iconCls="yes" text="确定" handler="confirmValue()"></next:ToolBarItem>
				<next:ToolBarItem id="closeButoon" iconCls="no" text="关闭" handler="closew()"></next:ToolBarItem>
				<next:ToolBarItem id="closeButoon" iconCls="no" text="清除" handler="clears()"></next:ToolBarItem>
			</next:TopBar>
		<next:Panel  border="false" width="100%" >
			<next:Tree name="dicBptDevicetree" id="dicBptDevicetree" collapsible="true" rootExpanded="true" autoScroll="true" height="70%" lines="true">
				<next:TreeDataSet dataset="DevicesMaintenaDataset" root="rootdata">
					<next:TreeLoader cmd="com.inspur.cams.bpt.manage.cmd.BptAssistiveDevicesMaintenaQueryCommand">
						<next:treeRecord name="bptdevicesRecord" idField="applyApparatusId">
		  					<model:field name="leve" type="string"/>
		   					<model:field name="applyApparatusId" type="string"/>	
		   					<model:field name="apparatusName" type="string"/>	
		   					<model:field name="ups" type="string"/>
		   					<model:field name="unit" type="string"/>
		   					<model:field name="num" type="string"/>
						</next:treeRecord>
						<next:TreeBaseparam name="UPS@=" value="getParent"/>
						<next:TreeBaseparam name="IS_EFFICIENT@=" value="1"/>
					</next:TreeLoader>
				</next:TreeDataSet>
				<next:TreeNodemodel recordType="bptdevicesRecord">
					<next:TreeNodeAttribute name="text" mapping="apparatusName"></next:TreeNodeAttribute>
					<next:TreeNodeAttribute name="icon" handler="getIcon" ></next:TreeNodeAttribute>
	   				<next:TreeNodeAttribute name="showType" handler="getChoiceBox"></next:TreeNodeAttribute>
	   				<next:TreeNodeAttribute name="checked" handler="getChecked"></next:TreeNodeAttribute>
				</next:TreeNodemodel>
				<next:Listeners>
					<next:Listener eventName="checkchange" handler="eachCheck">
					</next:Listener>
				</next:Listeners>
			</next:Tree>
   </next:Panel>
   <next:EditGridPanel id="editGridPanel" name="bptcontentnummaintainGrid" width="100%" stripeRows="true" height="30%" dataset="DevicesMaintenaDataset" title="伤残辅助器械数量">
  <next:Columns>
      <next:RowNumberColumn width="30"/>
      <next:CheckBoxColumn></next:CheckBoxColumn>
      <next:Column id="applyApparatusId" header="器械id" field="applyApparatusId" width="95" hidden="true">      
	      <next:TextField allowBlank="false" />
	   </next:Column>
    <next:Column id="apparatusName" header="器械名称" field="apparatusName" width="150" >      
      <next:TextField editable="false"/>
    </next:Column>
    <next:Column id="num" header="器械数量" field="num" width="95" >			
			<next:TextField  allowBlank="false" />
		</next:Column>
		<next:Column id="unit" header="单位" field="unit" width="50" >			
			<next:TextField  editable="false"/>
		</next:Column>
	</next:Columns>
</next:EditGridPanel>
</next:Panel>
</body>

</html>
