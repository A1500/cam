
<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ include file="/jsp/public/resources_jspdir.jsp"%>
<html>
<head>
<meta http-equiv="Content-Tres" content="text/html; charset=utf-8">
<next:ScriptManager/>
<script type="text/javascript" >
var RES_ADD='<%=res.get("BUT.ADD")%>';
var RES_EDIT='<%=res.get("MSG.EDIT")%>';
var PUB_FUNCTIONS_TITLE = '<%=res.get("TREE.TITLE")%>';
</script>
<script type="text/javascript" src="function_tree.js"></script>
<title></title>
</head>

<body>
<model:datasets>
	<model:dataset id="appDataset" cmd="org.loushang.bsp.permit.pap.function.cmd.AppQueryCommand" global="true">
		<model:record fromBean="org.loushang.bsp.permit.pap.function.data.App"/>
	</model:dataset>
	<model:dataset id="moduleDataset" global="true">
		<model:record fromBean="org.loushang.bsp.permit.pap.function.data.Module"/>
	</model:dataset>
	<model:dataset id="moduleCheckDataset" global="true">
		<model:record >
			<model:field name="moduleCode" type="string"/>
		</model:record>
	</model:dataset>
	<model:dataset id="functionDataset" global="true">
		<model:record fromBean="org.loushang.bsp.permit.pap.function.data.Function"/>
	</model:dataset>
	<model:dataset id="operationDataset" global="true" >
		<model:record fromBean="org.loushang.bsp.permit.pap.function.data.Operation"/>
	</model:dataset>
	<model:dataset id="urlDataset" global="true">
		<model:record fromBean="org.loushang.bsp.permit.pap.function.data.Url"/>
	</model:dataset>
</model:datasets>
<next:ViewPort>
<next:BorderLayout>
	<next:Left  cmargins="5 0 0 0 0 " margins="5 0 0 0" split="true" floatable="true">
	<next:Panel  id="leftPanel" collapsible="true"  title='<%=res.get("TREE.TITLE")%>'  autoScroll="true" width="20%" border="false">
			<next:Tree name="functiontreeName" id="functiontree"
				  border="false" lines="true">
				<next:TreeDataSet dataset="function_tree_dataset"  root="rootdata">
					<next:TreeLoader cmd="org.loushang.bsp.permit.pap.function.cmd.AppQueryCommand" trigger="appLoaderTrigger"
					  method="queryWithMenuInTree" >
						<next:treeRecord name="appRecord" idField="appCode" fromBean="org.loushang.bsp.permit.pap.function.data.App" >
							<model:field name="appCode" type="string"/>
							<model:field name="appName" type="string"/>
							<model:field name="menuId" type="string"/>
							<model:field name="seq" type="int"/>
						</next:treeRecord>
					</next:TreeLoader>
					<next:TreeLoader  cmd="org.loushang.bsp.permit.pap.function.cmd.ModuleQueryCommand"
						method="queryWithMenuInTree" trigger="moduleLoaderTrigger">
						<next:treeRecord name="moduleRecord" idField="moduleCode" fromBean="org.loushang.bsp.permit.pap.function.data.Module">
							<model:field name="moduleCode" type="string"/>
							<model:field name="moduleName" type="string"/>
							<model:field name="parentModuleCode" type="string"/>
							<model:field name="parentModuleName" type="string"/>
							<model:field name="isLeafModule" type="string"/>
							<model:field name="seq" type="int"/>
							<model:field name="moduleAppCode"  type="string"/>
							<model:field name="appName" type="string"/>
							<model:field name="menuId" type="string"/>
						</next:treeRecord>
						<next:TreeBaseparam name="appCode" value="getModuleApp"/>
						<next:TreeBaseparam name="parentModuleCode" value="getParentModule"/>
					</next:TreeLoader>
					<next:TreeLoader cmd="org.loushang.bsp.permit.pap.function.cmd.FunctionQueryCommand"
						method="queryWithMenuInTree" trigger="functionLoaderTrigger">
						<next:treeRecord name="functionRecord" idField="functionCode" fromBean="org.loushang.bsp.permit.pap.function.data.Function">
							<model:field name="functionCode" type="string"/>
							<model:field name="functionName" type="string"/>
							<model:field name="moduleCode" type="string"/>
							<model:field name="seq" type="int"/>
							<model:field name="menuId" type="string"/>
						</next:treeRecord>
						<next:TreeBaseparam name="moduleCode" value="getFunctionModule"/>

					</next:TreeLoader>
					<next:TreeLoader cmd="org.loushang.bsp.permit.pap.function.cmd.OperationQueryCommand"
						trigger="operationLoaderTrigger">
						<next:treeRecord name="operationRecord" idField="operationCode" fromBean="org.loushang.bsp.permit.pap.function.data.Operation">
							<model:field name="operationCode" type="string"/>
							<model:field name="operationName" type="string"/>
							<model:field name="functionCode" type="string"/>
							<model:field name="operationType" type="string"/>
							<model:field name="isDefault" type="string"/>
							<model:field name="seq" type="string"/>
						</next:treeRecord>
						<next:TreeBaseparam name="pub_operations.FUNCTION_CODE@=" value="getOperationFunction"/>
						<next:TreeBaseparam name="sort" value="function(){return 'SEQ';}"></next:TreeBaseparam>
						<next:TreeBaseparam name="dir" value="function(){return 'asc'}"></next:TreeBaseparam>
					</next:TreeLoader>
				</next:TreeDataSet>
				<next:TreeNodemodel recordType="appRecord">
					<next:TreeNodeAttribute name="text" mapping="appName"></next:TreeNodeAttribute>
					<next:TreeNodeAttribute name="icon" handler="getIcon"></next:TreeNodeAttribute>
					<next:RightmouseMenu menuId="app" trigger="isAppNode">
						<next:MenuItem text='<%=res.get("MENU.ADD_MODULE")%>' handler="addNode"></next:MenuItem>
						<next:MenuItem text='<%=res.get("MENU.DEL_APP")%>' handler="deleteNode"></next:MenuItem>
						<next:MenuItem text='导入' handler="importInfo"></next:MenuItem>
						<next:MenuItem text='导出' handler="exportInfo"></next:MenuItem>
					</next:RightmouseMenu>
					<next:RightmouseMenu menuId="app2" trigger="isRootNode">
						<next:MenuItem text='<%=res.get("MENU.ADD_APP")%>' handler="addNode"></next:MenuItem>
						<next:MenuItem text='<%=res.get("MENU.ADD_MODULE")%>' handler="addNode"></next:MenuItem>
						<next:MenuItem text='导入' handler="importInfo"></next:MenuItem>
						<next:MenuItem text='导出' handler="exportInfo"></next:MenuItem>
					</next:RightmouseMenu>
					<next:Listeners>
						<next:Listener eventName="selected" handler="selectedNode"></next:Listener>
					</next:Listeners>
				</next:TreeNodemodel>
				<next:TreeNodemodel recordType="moduleRecord" >
					<next:TreeNodeAttribute name="text"  mapping="moduleName"></next:TreeNodeAttribute>
					<next:TreeNodeAttribute name="icon" handler="getIcon"></next:TreeNodeAttribute>
					<next:TreeNodeAttribute name="leaf" handler="false"></next:TreeNodeAttribute>
					<next:RightmouseMenu menuId="module" trigger="isModuleNode">
						<next:MenuItem text='<%=res.get("MENU.ADD_MODULE")%>' handler="addNode"></next:MenuItem>
						<next:MenuItem text='<%=res.get("MENU.DEL_MODULE")%>' handler="deleteNode"></next:MenuItem>
						<next:MenuItem text='转移到' handler="alterPath"></next:MenuItem>
						<next:MenuItem text='导入' handler="importInfo"></next:MenuItem>
						<next:MenuItem text='导出' handler="exportInfo"></next:MenuItem>
						<next:MenuItem text='主键校正' handler="updateInfo"></next:MenuItem>
					</next:RightmouseMenu>
					<next:RightmouseMenu menuId="module2" trigger="isLeafModule">
						<next:MenuItem text='<%=res.get("MENU.ADD_FUNCTION")%>' handler="addNode"></next:MenuItem>
						<next:MenuItem text='<%=res.get("MENU.DEL_MODULE")%>' handler="deleteNode"></next:MenuItem>
						<next:MenuItem text='转移到' handler="alterPath"></next:MenuItem>
						<next:MenuItem text='导入' handler="importInfo"></next:MenuItem>
						<next:MenuItem text='导出' handler="exportInfo"></next:MenuItem>
					</next:RightmouseMenu>

					<next:Listeners>
						<next:Listener eventName="selected" handler="selectedNode"></next:Listener>
					</next:Listeners>
				</next:TreeNodemodel>
				<next:TreeNodemodel recordType="functionRecord">
					<next:TreeNodeAttribute name="text" mapping="functionName"></next:TreeNodeAttribute>
					<next:TreeNodeAttribute name="icon" handler="getIcon"></next:TreeNodeAttribute>
					<next:TreeNodeAttribute name="leaf" handler="false"></next:TreeNodeAttribute>
					<next:RightmouseMenu menuId="function" trigger="isFunctionNode">
						<next:MenuItem text='<%=res.get("MENU.ADD_OPERATION")%>' handler="addNode"></next:MenuItem>
						<next:MenuItem text='<%=res.get("MENU.DEL_FUNCTION")%>' handler="deleteNode"></next:MenuItem>
						<next:MenuItem text='转移到' handler="alterPath"></next:MenuItem>
						<next:MenuItem text='导入' handler="importInfo"></next:MenuItem>
						<next:MenuItem text='导出' handler="exportInfo"></next:MenuItem>
					</next:RightmouseMenu>
					<next:Listeners>
						<next:Listener eventName="selected" handler="selectedNode"></next:Listener>
					</next:Listeners>
				</next:TreeNodemodel>
				<next:TreeNodemodel recordType="operationRecord">
					<next:TreeNodeAttribute name="text" mapping="operationName"></next:TreeNodeAttribute>
					<next:TreeNodeAttribute name="icon" handler="getIcon"></next:TreeNodeAttribute>
					<next:TreeNodeAttribute name="leaf" handler="true"></next:TreeNodeAttribute>
					<next:RightmouseMenu menuId="operation" trigger="isOprNode">
						<next:MenuItem text='<%=res.get("MENU.DEL_OPERATION")%>' handler="deleteNode"></next:MenuItem>
						<next:MenuItem text='转移到' handler="alterPath"></next:MenuItem>
						<next:MenuItem text='导出' handler="exportInfo"></next:MenuItem>
					</next:RightmouseMenu>
					<next:Listeners>
						<next:Listener eventName="selected" handler="selectedNode"></next:Listener>
					</next:Listeners>
				</next:TreeNodemodel>
			</next:Tree>
		</next:Panel>
	</next:Left>
	<next:Center floatable="true" margins="5 0 0 0" cmargins="5 0 0 0 0 ">
	<next:Panel id="center" width="100%" height="100%">
		<next:Panel id="detail" hidden="ture" width="100%" height="100%" >
				<next:Html>
						<iframe id="nodeFrame" name="nodeFrame" height="100%" width="100%">
						</iframe>
				</next:Html>
		</next:Panel>
		<next:Panel id="dao" title="" height="100%" width="100%" border="false" >
				 <next:Html>
					<div id="loadmask" style="display: none;" class="loading" >
				 <img src="<%=request.getContextPath()%>/skins/images/default/extanim32.gif"
				                        width="32" height="32" style="margin-right: 8px;" />正在处理...</div>
				 <iframe id="frame1" frameborder="no"  marginwidth="0" marginheight="0" allowtransparency="yes" 
					 style="overflow: auto" height="100%" width="100%" 
							src="../../../demo/blank.jsp"></iframe>
				</next:Html>
		</next:Panel>
	</next:Panel>	
	</next:Center>
</next:BorderLayout>
</next:ViewPort>
			
<next:Window id="zhuanyi" name="zhuanyiName" hidden="true" width="400" height="270">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text='<%=res.get("BTN.OK")%>' iconCls="add" handler="ok"></next:ToolBarItem>
		<next:ToolBarItem text='<%=res.get("BTN.CLOSE")%>'iconCls="add" handler="closeWin"></next:ToolBarItem>
	</next:TopBar>
	<next:Tree name="functiontree2" id="functiontree2"   height="400" title='<%=res.get("MOVETREE.TITLE")%>'
				lines="true" frame="true" autoScroll="true" >
				<next:TreeDataSet dataset="function_tree_dataset2"  root="rootdata2">
					<next:TreeLoader cmd="org.loushang.bsp.permit.pap.function.cmd.AppQueryCommand"
					method="queryWithMenuInTree" trigger="appLoaderTrigger" >
						<next:treeRecord name="appRecord2" idField="appCode" >
							<model:field name="appCode" type="string"/>
							<model:field name="appName" type="string"/>
							<model:field name="menuId" type="string"/>
						</next:treeRecord>
						</next:TreeLoader>
					<next:TreeLoader cmd="org.loushang.bsp.permit.pap.function.cmd.ModuleQueryCommand"
						method="queryWithMenuInTree2" trigger="moduleLoaderTrigger">
						<next:treeRecord name="moduleRecord2" idField="moduleCode">
							<model:field name="moduleCode" type="string"/>
							<model:field name="moduleName" type="string"/>
							<model:field name="parentModuleCode" type="string"/>
							<model:field name="parentModuleName" type="string"/>
							<model:field name="isLeafModule" type="string"/>
							<model:field name="seq" type="int"/>
							<model:field name="appCode" type="string"/>
							<model:field name="appName" type="string"/>
							<model:field name="menuId" type="string"/>
						</next:treeRecord>
						<next:TreeBaseparam name="withLeaf" value="isWithLeaf"/>
						<next:TreeBaseparam name="module_code@!=" value="getSelfParentId"/>
						<next:TreeBaseparam name="appCode" value="getModuleApp"/>
						<next:TreeBaseparam name="parentModuleCode" value="getParentModule"/>
					</next:TreeLoader>
					<next:TreeLoader cmd="org.loushang.bsp.permit.pap.function.cmd.FunctionQueryCommand"
						method="queryWithMenuInTree2" trigger="functionLoaderTrigger">
						<next:treeRecord name="functionRecord2" idField="functionCode">
							<model:field name="functionCode" type="string"/>
							<model:field name="functionName" type="string"/>
							<model:field name="moduleCode" type="string"/>
							<model:field name="seq" type="int"/>
							<model:field name="menuId" type="string"/>
						</next:treeRecord>
						<next:TreeBaseparam name="moduleCode" value="getFunctionModule"/>
						<next:TreeBaseparam name="function_Code@!=" value="getSelfParentId"/>
						</next:TreeLoader>
				</next:TreeDataSet>
				<next:TreeNodemodel recordType="appRecord2">
					<next:TreeNodeAttribute name="text" mapping="appName"></next:TreeNodeAttribute>
					<next:TreeNodeAttribute name="icon" handler="getIcon"></next:TreeNodeAttribute>
					<next:TreeNodeAttribute name="showType" handler="showNode" ></next:TreeNodeAttribute>
				</next:TreeNodemodel>
				<next:TreeNodemodel recordType="moduleRecord2" >
					<next:TreeNodeAttribute name="text" mapping="moduleName"></next:TreeNodeAttribute>
					<next:TreeNodeAttribute name="icon" handler="getIcon"></next:TreeNodeAttribute>
					<next:TreeNodeAttribute name="leaf" handler="false"></next:TreeNodeAttribute>
                    <next:TreeNodeAttribute name="showType" handler="showNode" ></next:TreeNodeAttribute>
				</next:TreeNodemodel>
				<next:TreeNodemodel recordType="functionRecord2">
					<next:TreeNodeAttribute name="text" mapping="functionName"></next:TreeNodeAttribute>
					<next:TreeNodeAttribute name="icon" handler="getIcon"></next:TreeNodeAttribute>
					<next:TreeNodeAttribute name="leaf" handler="false"></next:TreeNodeAttribute>
                     <next:TreeNodeAttribute name="showType" handler="showNode" ></next:TreeNodeAttribute>
				</next:TreeNodemodel>
			</next:Tree>
</next:Window>
</body>
</html>