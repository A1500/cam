<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ include file="/jsp/public/resources_jspdir.jsp"%>
<html>
<head>
<meta http-equiv="Content-Tres" content="text/html; charset=utf-8">
<script type="text/javascript" >
var showId= '<%=request.getParameter("treeId")%>';
var showType = '<%=request.getParameter("treeType")%>';
var menuId= '<%=request.getParameter("menuId")%>';
</script>
<script type="text/javascript" src="select_function_tree.js"></script>
<title></title>
</head>
<next:ScriptManager/>
<body>
<model:datasets>
</model:datasets>
<next:Panel  id="leftPanel"  collapsible="true" anchor="100% 100%" border="false"  >
<next:Tree name="selectfunctiontree" id="selectfunctiontree" autoScroll="true" lines="true" border="false" >
		<next:TreeDataSet dataset="select_function_dataset" root="rootdata">
			<next:TreeLoader cmd="org.loushang.bsp.permit.pap.function.cmd.FunctionSelectTreeQuery" >
				<next:treeRecord name="treeRecord" idField="treeId" >
					<model:field name="treeId" type="string"/>
					<model:field name="treeName" type="string"/>
					<model:field name="treeType" type="string"/>
					<model:field name="isLeafModule" type="string"/>
					<model:field name="isWithMenu" type="string"/>
					<model:field name="menuId" type="string"/>
					<model:field name="operation_flag" type="string" defaultValue="0"/>
				</next:treeRecord>
				<next:TreeBaseparam name="treeType" value="getTreeType"/>
				<next:TreeBaseparam name="treeId" value="getTreeId"/>
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
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem  iconCls="yes" text="确定" handler="confirmValue" />
	</next:TopBar>
</next:Panel>
</body>
</html>