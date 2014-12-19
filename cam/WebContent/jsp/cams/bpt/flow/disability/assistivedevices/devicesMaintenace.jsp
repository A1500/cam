
<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<next:ScriptManager/>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>伤残辅助器械选择</title>
<script type="text/javascript" src="devicesMaintenace.js"></script>
<script>
			var applyApparatusId= '<%=request.getParameter("applyApparatusId")%>';
			var applyId='<%=request.getParameter("applyId")%>';
		</script>
</head>
<body>
<model:datasets>
	<model:dataset id="devicesMaintenaDataset" cmd="com.inspur.cams.bpt.manage.cmd.BptAssistiveDevicesMaintenaQueryCommand" global="true" > 
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptAssistiveDevicesMaintena">
		</model:record>
	</model:dataset>
</model:datasets>
<next:ViewPort>
<next:BorderLayout>
<next:Left   split="true" floatable="true">
		<next:Panel  border="false" height="100%" width="30%" autoScroll="false" >
		
			<next:Tree name="dicBptDevicetree" id="dicBptDevicetree" collapsible="true" rootExpanded="true" autoScroll="true" height="100%" lines="true">
				<next:TreeDataSet dataset="DevicesMaintenaDataset" root="rootdata">
					<next:TreeLoader cmd="com.inspur.cams.bpt.manage.cmd.BptAssistiveDevicesMaintenaQueryCommand">
						<next:treeRecord name="bptdevicesRecord" idField="applyApparatusId">
		  					<model:field name="leve" type="string"/>
		  					<model:field name="id" type="string"/>
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
	   				<next:RightmouseMenu menuId="function" trigger="isEndNode">
						<next:MenuItem text='添加' handler="addNode"></next:MenuItem>
						<next:MenuItem text='删除' handler="deleteNode"></next:MenuItem>
					</next:RightmouseMenu>
					<next:Listeners>
						<next:Listener eventName="selected" handler="selectedNode"></next:Listener>
					</next:Listeners>
				</next:TreeNodemodel>
			</next:Tree>
   </next:Panel>
</next:Left>
<next:Center floatable="true" >
<next:Panel width="100%" height="100%" >
   <next:Panel id="editpanel" width="100%" height="100%" >
   <next:TopBar>
				<next:ToolBarItem symbol="->"></next:ToolBarItem>
				<next:ToolBarItem id="saveButoon" iconCls="yes" text="保存" handler="save()"></next:ToolBarItem>
	</next:TopBar>
			<next:Html>
				<form id="editForm"   dataset="devicesMaintenaDataset" onsubmit="return false" class="L5form">
				<table   width="100%" >
			   		<tr>
						<td class="FieldLabel" style="width:15%" >器械编号</td>
						<td class="FieldInput"><input type="text" id="moduleCodeFld" name="applyApparatusId" field="applyApparatusId" onblur="testId(this)" /><font color="red">*</font> </td>
					</tr>
			   		<tr>
						<td  class="FieldLabel" >器械名称</td>
						<td class="FieldInput"><input type="text" name="apparatusName" field="apparatusName"  /><font color="red">*</font> </td>
					</tr>
			   		<tr>
						<td  class="FieldLabel" >单位</td>
						<td class="FieldInput"><input id="unit" field="unit" type="text" name="unit" /></td>
					</tr>
					<input type="hidden" name="id" field="id"  />
			   		<input type="hidden" name="leve" field="leve"  />
			   		<input type="hidden" name="ups" field="ups"  />
			   		<input type="hidden" name="isEfficient" field="isEfficient"  value='1'/>
				</table>
				</form>
				
			</next:Html>
   </next:Panel>
 </next:Panel>
</next:Center>
</next:BorderLayout>
</next:ViewPort>
</body>

</html>
