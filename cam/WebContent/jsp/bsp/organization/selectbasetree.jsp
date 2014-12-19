<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>

<%
String  struType=request.getParameter("struType");
if(struType==null  || "".equals(struType.trim())){
	struType="00";
}

String upstruId=request.getParameter("upstruId");
%>
<next:ScriptManager ></next:ScriptManager>

<html>
<head>

<title>选择下级成员</title>
<script type="text/javascript">
	var upstruId='<%=request.getParameter("upstruId")%>';
	var struTypeId='<%=request.getParameter("struTypeId")%>';
</script>
<script type="text/javascript" src="selectbasetree.js"></script>
</head>
<body>

<next:Panel id="selectSubPanel"  border="false">
<next:TopBar>
	<next:ToolBarItem symbol="->"></next:ToolBarItem>
	<next:ToolBarItem id="saveButoon" iconCls="yes" text="确定" handler="confirmValue()"></next:ToolBarItem>
	<next:ToolBarItem id="closeButoon" iconCls="no" text="关闭" handler="closew()"></next:ToolBarItem>
</next:TopBar>
<next:Tree name="orgstrutree" id="orgstrutree" title="选择下级成员"  rootVisible="false" rootExpanded="true"
	collapsible="true"  autoScroll="true" lines="true" border="false"
	frame="true">
	<next:TreeDataSet dataset="stru" root="rootdata">
		<next:TreeLoader cmd="org.loushang.bsp.organization.cmd.StruQueryCommand"  method="getSelectBaseRoot" >
			<next:treeRecord name="stru"  idField="struId" fromBean="org.loushang.bsp.share.organization.bean.StruView">
			</next:treeRecord>
			<next:TreeBaseparam name="struId"    value="getStruId" />
			<next:TreeBaseparam name="upstruId" value="getUpStruId"></next:TreeBaseparam>
			<next:TreeBaseparam name="struType" value="getStruType"></next:TreeBaseparam>
		</next:TreeLoader>

	</next:TreeDataSet>

	<next:TreeNodemodel recordType="stru">
		<next:TreeNodeAttribute name="text" mapping="organName"></next:TreeNodeAttribute>
		<next:TreeNodeAttribute name="icon" handler="getIcon" ></next:TreeNodeAttribute>
	   <next:TreeNodeAttribute name="showType" handler="getRadioBox"></next:TreeNodeAttribute>
	</next:TreeNodemodel>


</next:Tree>
</next:Panel>
</body>
</html>