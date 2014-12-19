<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<next:ScriptManager ></next:ScriptManager>
<%String struType = (String)request.getParameter("struType");
	String struId = (String)request.getParameter("struId");
%>
<html>
<head>
<title>选择组织</title>
<script type="text/javascript">
	var struTypeId='<%=request.getParameter("struTypeId")%>';
	var choiceOrganType='<%=request.getParameter("choiceOrganType")%>';
	var choiceBox='<%=request.getParameter("choiceBox")%>';
</script>
<script type="text/javascript" src="selectstru.js"></script>
</head>
<body>
<next:Panel  anchor="100% 100%" border="false">
<next:TopBar>
	<next:ToolBarItem symbol="->"></next:ToolBarItem>
	<next:ToolBarItem id="saveButoon" iconCls="yes" text="确定" handler="confirmValue()"></next:ToolBarItem>
	<next:ToolBarItem id="closeButoon" iconCls="no" text="关闭" handler="closew()"></next:ToolBarItem>
	<next:ToolBarItem id="closeButoon" iconCls="no" text="清除" handler="clears()"></next:ToolBarItem>
</next:TopBar>
<next:Tree name="orgstrutree" id="orgstrutree" title="选择组织"  rootVisible="false" rootExpanded="true"
	collapsible="true" border="false" autoScroll="true" lines="true" allowCheck="isCheckedSub" >
	<next:TreeDataSet dataset="orgstru" root="rootdata">
		<next:TreeLoader cmd="org.loushang.bsp.organization.cmd.StruQueryCommand"  method="getSelectStru"  >
			<next:treeRecord name="stru"  idField="struId" fromBean="org.loushang.bsp.share.organization.bean.StruView">
			</next:treeRecord>
			<next:TreeBaseparam name="parentId"    value="getParentId" />
			<next:TreeBaseparam name="struId"    value="getStruId" />
			<next:TreeBaseparam name="struType" value="getStruType"></next:TreeBaseparam>
		</next:TreeLoader>
	</next:TreeDataSet>
	<next:TreeNodemodel recordType="stru">
		<next:TreeNodeAttribute name="text" mapping="organName"></next:TreeNodeAttribute>
		<next:TreeNodeAttribute name="icon" handler="getIcon" ></next:TreeNodeAttribute>
		<next:TreeNodeAttribute name="leaf" handler="getIsLeaf"></next:TreeNodeAttribute>
	   <next:TreeNodeAttribute name="showType" handler="getRadioBox"></next:TreeNodeAttribute>
	</next:TreeNodemodel>
</next:Tree>
</next:Panel>
</body>
</html>
<script type="text/javascript">

</script>