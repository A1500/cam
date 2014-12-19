
<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ include file="/jsp/public/resources_jspdir.jsp"%>
<html>
<head>
<meta http-equiv="Content-Tres" content="text/html; charset=utf-8">
<script type="text/javascript" >
var RES_ADD='<%=res.get("BUT.ADD")%>';
var RES_EDIT='<%=res.get("MSG.EDIT")%>';
var PUB_FUNCTIONS_TITLE = '<%=res.get("TREE.TITLE")%>';
var showType = '<%=request.getParameter("showType")%>';
</script>
<script type="text/javascript" src="select_function.js"></script>
<title></title>
</head>
<next:ScriptManager/>
<body>
<model:datasets>
	<model:dataset id="appDataset" global="true">
		<model:record fromBean="org.loushang.bsp.eai.pap.application.data.App"/>
	</model:dataset>
	<model:dataset id="moduleDataset" global="true">
		<model:record fromBean="org.loushang.bsp.eai.pap.function.data.Module"/>
	</model:dataset>
	<model:dataset id="functionDataset" global="true">
		<model:record fromBean="org.loushang.bsp.eai.pap.function.data.Function"/>
	</model:dataset>
	<model:dataset id="operationDataset" global="true" >
		<model:record fromBean="org.loushang.bsp.eai.pap.function.data.Operation"/>
	</model:dataset>
</model:datasets>
<next:Panel  id="leftPanel" collapsible="true" anchor="100% 100%" border="false"  >
	<next:Tree name="functiontree" id="functiontree" title='<%=res.get("TREE.TITLE")%>' rootVisible="true" rootExpanded="false"
		  border="false" lines="true">
		<next:TreeDataSet dataset="function_tree_dataset"  root="rootdata">
			<next:TreeLoader cmd="org.loushang.bsp.eai.pap.application.cmd.AppQueryCommand" trigger="appLoaderTrigger"
			  method="queryWithMenuInTree" >
				<next:treeRecord name="appRecord" idField="appCode" >
					<model:field name="appCode" type="string"/>
					<model:field name="appName" type="string"/>
				</next:treeRecord>
			</next:TreeLoader>
			<next:TreeLoader cmd="org.loushang.bsp.eai.pap.function.cmd.ModuleQueryCommand"
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
			</next:TreeLoader>
		</next:TreeDataSet>
		<next:TreeNodemodel recordType="appRecord">
			<next:TreeNodeAttribute name="text" mapping="appName"></next:TreeNodeAttribute>
			<next:TreeNodeAttribute name="icon" handler="getIcon"></next:TreeNodeAttribute>
			<next:TreeNodeAttribute name="showType" handler="getChoiceBox"></next:TreeNodeAttribute>
		</next:TreeNodemodel>
		<next:TreeNodemodel recordType="moduleRecord" >
			<next:TreeNodeAttribute name="text"  mapping="moduleName"></next:TreeNodeAttribute>
			<next:TreeNodeAttribute name="icon" handler="getIcon"></next:TreeNodeAttribute>
			<next:TreeNodeAttribute name="showType" handler="getChoiceBox"></next:TreeNodeAttribute>
		</next:TreeNodemodel>
		<next:TreeNodemodel recordType="functionRecord">
			<next:TreeNodeAttribute name="text" mapping="functionName"></next:TreeNodeAttribute>
			<next:TreeNodeAttribute name="icon" handler="getIcon"></next:TreeNodeAttribute>
			<next:TreeNodeAttribute name="showType" handler="getChoiceBox"></next:TreeNodeAttribute>
		</next:TreeNodemodel>
		<next:TreeNodemodel recordType="operationRecord">
			<next:TreeNodeAttribute name="text" mapping="operationName"></next:TreeNodeAttribute>
			<next:TreeNodeAttribute name="icon" handler="getIcon"></next:TreeNodeAttribute>
			<next:TreeNodeAttribute name="showType" handler="getChoiceBox"></next:TreeNodeAttribute>
			<next:TreeNodeAttribute name="leaf" handler="true"></next:TreeNodeAttribute>
		</next:TreeNodemodel>
	</next:Tree>
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem  iconCls="yes" text="确定" handler="confirmValue" />
		<next:ToolBarItem  iconCls="no" text="关闭" handler="closeDig" />
	</next:TopBar>
</next:Panel>
</body>
</html>