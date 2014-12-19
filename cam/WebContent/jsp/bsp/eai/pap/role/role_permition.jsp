<%@page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ include file="/jsp/public/resources_jspdir.jsp"%>
<html>
	<head>
	<meta http-equiv="Content-Tres" content="text/html; charset=utf-8">
	<next:ScriptManager/>
	<script type="text/javascript" >
		var roleId = '<%=request.getParameter("roleId")%>';
		var appCode = '<%=request.getParameter("appCode")%>';
	</script>
	<script type="text/javascript" src="role_permition.js"></script>
<title></title>
</head>
<body>
<next:ViewPort>
<next:Panel  id="function_permit" title='<%=res.get("ROLE.FUNCTION")%>'  autoHeight="true" border="false" >
<next:TopBar>
	<next:ToolBarItem symbol="->"></next:ToolBarItem>
	<next:ToolBarItem iconCls="save" id="saveBtn"  text='<%=res.get("BUT.SAVE")%>' handler="save"/>
	<next:ToolBarItem iconCls="undo" id="backBtn" text='<%=res.get("PUB_DATA_TYPE.BACK")%>' handler="backToRoles"/>
</next:TopBar>
	<next:Html>
		<next:Tree name="functiontree" id="functiontree" autoScroll="true" height="100%" lines="true" border="false" >
		<next:TreeDataSet dataset="function_tree_dataset" root="rootdata">
			<next:TreeLoader cmd="org.loushang.bsp.eai.pap.role.cmd.RolePermitTreeQuery" >
				<next:treeRecord name="treeRecord" idField="treeId" >
					<model:field name="treeId" type="string"/>
					<model:field name="treeName" type="string"/>
					<model:field name="treeType" type="string"/>
					<model:field name="treeState" type="string"/>
					<model:field name="operation_flag" type="string" defaultValue="0"/>
				</next:treeRecord>
				<next:TreeBaseparam name="treeType" value="getTreeType"/>
				<next:TreeBaseparam name="treeId" value="getTreeId"/>
				<next:TreeBaseparam name="roleId" value="getRoleId"/>
				<next:TreeBaseparam name="appCode" value="getAppCode"/>
			</next:TreeLoader>
		</next:TreeDataSet>
		<next:TreeNodemodel recordType="treeRecord">
			<next:TreeNodeAttribute name="text" mapping="treeName"></next:TreeNodeAttribute>
			<next:TreeNodeAttribute name="icon" handler="getIcon"></next:TreeNodeAttribute>
			<next:TreeNodeAttribute name="showType" handler="getShowType"></next:TreeNodeAttribute>
			<next:TreeNodeAttribute name="checked" handler="getChecked"></next:TreeNodeAttribute>
			<next:TreeNodeAttribute name="leaf" handler="isLeaf"></next:TreeNodeAttribute>
		</next:TreeNodemodel>
		<next:Listeners>
			<next:Listener eventName="checkchange" handler="eachClick">
			</next:Listener>
		</next:Listeners>
	</next:Tree>
	</next:Html>
</next:Panel>
</next:ViewPort>
</body>
</html>
