
<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ include file="/jsp/public/resources_jspdir.jsp"%>
<html>

<head>
<meta http-equiv="Content-Tres" content="text/html; charset=utf-8">
<next:ScriptManager/>
<script type="text/javascript" >
var RES_ADD='新增';
var RES_EDIT='修改';
var PUB_FUNCTIONS_TITLE = '<%=res.get("TREE.TITLE")%>';

</script>
<script type="text/javascript" src="app_function_tree.js"></script>
<title></title>
</head>
<body>
<model:datasets>
	<model:dataset id="appDataset" global="true">
		<model:record fromBean="org.loushang.bsp.eai.pap.application.data.App"/>
	</model:dataset>

	<model:dataset id="moduleDataset" global="true">
		<model:record fromBean="org.loushang.bsp.eai.pap.function.data.Module"/>
	</model:dataset>
	<model:dataset id="moduleCheckDataset" global="true">
		<model:record >
			<model:field name="moduleCode" type="string"/>
		</model:record>
	</model:dataset>
	<model:dataset id="functionDataset" global="true">
		<model:record fromBean="org.loushang.bsp.eai.pap.function.data.Function"/>
	</model:dataset>
	<model:dataset id="operationDataset" global="true" >
		<model:record fromBean="org.loushang.bsp.eai.pap.function.data.Operation"/>
	</model:dataset>
	<model:dataset id="urlDataset" global="true">
		<model:record fromBean="org.loushang.bsp.eai.pap.function.data.Url"/>
	</model:dataset>
</model:datasets>
<next:ViewPort>
<next:BorderLayout>
	<next:Left  cmargins="5 0 0 0 0 " margins="5 0 0 0" split="true" floatable="true">
	<next:Panel  id="leftPanel" collapsible="true"  title='目标树'  autoScroll="true" width="20%" border="false">
			<next:Tree name="functiontreeName" id="functiontree"
				  border="false" lines="true">
				<next:TreeDataSet dataset="function_tree_dataset"  root="rootdata" >
					<next:TreeLoader cmd="org.loushang.bsp.eai.pap.application.cmd.AppQueryCommand" trigger="appLoaderTrigger"
					  method="queryWithMenuInTree" >
						<next:treeRecord name="appRecord" idField="appCode" >
							<model:field name="appCode" type="string"/>
							<model:field name="appName" type="string"/>
							<model:field name="menuId" type="string"/>
							<model:field name="seq" type="int"/>
						</next:treeRecord>
					</next:TreeLoader>
					<next:TreeLoader  cmd="org.loushang.bsp.eai.pap.function.cmd.ModuleQueryCommand"
						method="queryWithMenuInTree" trigger="moduleLoaderTrigger">
						<next:treeRecord name="moduleRecord" idField="moduleCode">
							<model:field name="moduleCode" type="string"/>
							<model:field name="moduleName" type="string"/>
							<model:field name="parentModuleCode" type="string"/>
							<model:field name="parentModuleName" type="string"/>
							<model:field name="isLeafModule" type="string"/>
							<model:field name="seq" type="int"/>
							<model:field name="moduleAppCode"  type="string"/>
							<model:field name="appName" type="string"/>
							<model:field name="menuId" type="string"/>
							<model:field name="modulePath" type="string"/>
						</next:treeRecord>
						<next:TreeBaseparam name="appCode" value="getModuleApp"/>
						<next:TreeBaseparam name="parentModuleCode" value="getParentModule"/>
					</next:TreeLoader>
					<next:TreeLoader cmd="org.loushang.bsp.eai.pap.function.cmd.FunctionQueryCommand"
						method="queryWithMenuInTree" trigger="functionLoaderTrigger">
						<next:treeRecord name="functionRecord" idField="functionCode">
							<model:field name="functionCode" type="string"/>
							<model:field name="functionName" type="string"/>
							<model:field name="moduleCode" type="string"/>
							<model:field name="seq" type="int"/>
							<model:field name="menuId" type="string"/>
						</next:treeRecord>
						<next:TreeBaseparam name="moduleCode" value="getFunctionModule"/>
					</next:TreeLoader>
					<next:TreeLoader cmd="org.loushang.bsp.eai.pap.function.cmd.OperationQueryCommand"
						trigger="operationLoaderTrigger">
						<next:treeRecord name="operationRecord" idField="operationCode">
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
						<next:MenuItem text='新增业务组件' handler="addNode"></next:MenuItem>
						<next:MenuItem text='删除应用' handler="deleteNode"></next:MenuItem>
					</next:RightmouseMenu>
					<next:RightmouseMenu menuId="app2" trigger="isRootNode">
						<next:MenuItem text='新增应用' handler="addNode"></next:MenuItem>
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
						<next:MenuItem text='新增模块' handler="addNodeUnderModule"></next:MenuItem>
						<next:MenuItem text='删除模块' handler="deleteNode"></next:MenuItem>
						<next:MenuItem text='上移模块' handler="upNode"></next:MenuItem>
						<next:MenuItem text='下移模块' handler="downNode"></next:MenuItem>
						<next:MenuItem text='转移到' handler="alterPath"></next:MenuItem>
					</next:RightmouseMenu>
					<next:RightmouseMenu menuId="module2" trigger="isLeafModule">
						<next:MenuItem text='添加功能' handler="addNode"></next:MenuItem>
						<next:MenuItem text='删除模块' handler="deleteNode"></next:MenuItem>
						<next:MenuItem text='上移模块' handler="upNode"></next:MenuItem>
						<next:MenuItem text='下移模块' handler="downNode"></next:MenuItem>
						<next:MenuItem text='转移到' handler="alterPath"></next:MenuItem>
					</next:RightmouseMenu>
					<next:RightmouseMenu menuId="module3" trigger="isCompModule">
						<next:MenuItem text='新增模块' handler="addNodeUnderComp"></next:MenuItem>
						<next:MenuItem text='删除业务组件' handler="deleteNode"></next:MenuItem>
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
						<next:MenuItem text='添加操作' handler="addNode"></next:MenuItem>
						<next:MenuItem text='删除功能' handler="deleteNode"></next:MenuItem>
						<next:MenuItem text='上移功能' handler="upNode"></next:MenuItem>
						<next:MenuItem text='下移功能' handler="downNode"></next:MenuItem>
						<next:MenuItem text='转移到' handler="alterPath"></next:MenuItem>
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
						<next:MenuItem text='删除操作' handler="deleteNode"></next:MenuItem>
						<next:MenuItem text='上移操作' handler="upNode"></next:MenuItem>
						<next:MenuItem text='下移操作' handler="downNode"></next:MenuItem>
						<next:MenuItem text='转移到' handler="alterPath"></next:MenuItem>
					</next:RightmouseMenu>
					<next:Listeners>
						<next:Listener eventName="selected" handler="selectedNode"></next:Listener>
					</next:Listeners>
				</next:TreeNodemodel>
			</next:Tree>
		</next:Panel>
	</next:Left>
	<next:Center floatable="true" margins="5 0 0 0">
			<next:Panel width="100%">
					<next:Html>
						<iframe id="nodeFrame" name="nodeFrame" height="100%" width="100%">
						</iframe>
					</next:Html>
			</next:Panel>
	</next:Center>
	</next:BorderLayout>
</next:ViewPort>
<next:Window id="zhuanyi" name="zhuanyiName" hidden="true" width="400" height="270">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text='确定' iconCls="add" handler="ok"></next:ToolBarItem>
		<next:ToolBarItem text='关闭'iconCls="add" handler="closeWin"></next:ToolBarItem>
	</next:TopBar>
	<next:Tree name="functiontree2" id="functiontree2"   height="400" title='目标树'
				lines="true" frame="true" autoScroll="true" >
				<next:TreeDataSet dataset="function_tree_dataset2"  root="rootdata2">
					<next:TreeLoader cmd="org.loushang.bsp.eai.pap.application.cmd.AppQueryCommand"
					method="queryWithMenuInTree" trigger="appLoaderTrigger" >
						<next:treeRecord name="appRecord2" idField="appCode" >
							<model:field name="appCode" type="string"/>
							<model:field name="appName" type="string"/>
							<model:field name="menuId" type="string"/>
						</next:treeRecord>
						</next:TreeLoader>
					<next:TreeLoader cmd="org.loushang.bsp.eai.pap.function.cmd.ModuleQueryCommand"
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
					<next:TreeLoader cmd="org.loushang.bsp.eai.pap.function.cmd.FunctionQueryCommand"
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