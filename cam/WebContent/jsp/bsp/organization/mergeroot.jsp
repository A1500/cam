<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%
String organId=request.getParameter("organId");
String struType=request.getParameter("struType");
String struId=request.getParameter("struId");

String organType=request.getParameter("organType");

%>
<next:ScriptManager ></next:ScriptManager>

<html>
<head>

<title>选择新上级</title>

<script type="text/javascript">

 	var srcStruId='<%=request.getParameter("srcStruId")%>';
	var struTypeId='<%=request.getParameter("struType")%>';

</script>
<script type="text/javascript" src="mergeroot.js"></script>
</head>
<body>
<next:Panel anchor="100% 100%" border="false">
<next:TopBar>
	<next:ToolBarItem symbol="->"></next:ToolBarItem>
	<next:ToolBarItem id="saveButoon" iconCls="yes" text="确定" handler="confirmValue()"></next:ToolBarItem>
	<next:ToolBarItem id="closeButoon" iconCls="no" text="关闭" handler="closew()"></next:ToolBarItem>
</next:TopBar>
<next:Tree name="orgstrutree" id="orgstrutree" title="选择新上级"  rootVisible="false" rootExpanded="true"
	collapsible="true"  border="false" autoScroll="true" lines="true" >
	<next:TreeDataSet dataset="orgstru" root="rootdata" >
		<next:TreeLoader
			cmd="org.loushang.bsp.organization.cmd.StruQueryCommand"  method="getMergeRoot" >
			<next:treeRecord name="stru"  idField="struId" fromBean="org.loushang.bsp.share.organization.bean.StruView">
			</next:treeRecord>
			<next:TreeBaseparam name="srcStruId"    value="getsrcStruId" />
			<next:TreeBaseparam name="struId"    value="getStruId" />
			<next:TreeBaseparam name="struType"    value="getStruType" />
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