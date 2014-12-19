<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils" %>
<%@ include file="/jsp/public/resources_jspdir.jsp" %>

<next:ScriptManager/>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title></title>
<script type="text/javascript">
	var struTypeId='<%=request.getParameter("struTypeId")%>';
</script>
<script type="text/javascript" src="select_user.js"></script>
</head>
<body>
<next:Panel name="border-div" height="500" bodyBorder="false" title='<%=res.get("TREE.TITLE")%>'>
	<next:Tree id="usertree" height="100%" width="100%" bodyBorder="2" autoScroll="true" lines="true" >
		<next:TreeDataSet dataset="stru" root="rootdata">
			<next:TreeLoader cmd="org.loushang.bsp.organization.cmd.StruQueryCommand"  method="getUserRoleTreeRoot" trigger="struLoaderTrigger">
				<next:treeRecord name="struRecord" idField="struId" fromBean="org.loushang.bsp.share.organization.bean.StruView"/>
				<next:TreeBaseparam name="parentId" value="getStruParent"></next:TreeBaseparam>
				<next:TreeBaseparam name="struId" value="getStruId"></next:TreeBaseparam>
				<next:TreeBaseparam name="struType" value="getStruType"></next:TreeBaseparam>
				<next:TreeBaseparam name="struTypeId" value="getStruTypeId"></next:TreeBaseparam>
			</next:TreeLoader>
			<next:TreeLoader cmd="org.loushang.bsp.permit.pap.user.cmd.UserQueryCommand" trigger="userLoaderTrigger" method="queryUserByOrgan">
				<next:treeRecord name="userRecord" idField="userId" fromBean="org.loushang.bsp.permit.pap.user.data.User">
				</next:treeRecord>
				<next:TreeBaseparam name="nodeType" value="getNodeType"></next:TreeBaseparam>
				<next:TreeBaseparam name="organId" value="getOrganId"></next:TreeBaseparam>
			</next:TreeLoader>
		</next:TreeDataSet>
		<next:TreeNodemodel recordType="struRecord">
			<next:TreeNodeAttribute name="text" mapping="organName"></next:TreeNodeAttribute>
			<next:TreeNodeAttribute name="icon" handler="getIcon" ></next:TreeNodeAttribute>
			<next:TreeNodeAttribute name="struPath" mapping="struId"></next:TreeNodeAttribute>
		</next:TreeNodemodel>
		<next:TreeNodemodel recordType="userRecord">
			<next:TreeNodeAttribute name="text" mapping="userName"></next:TreeNodeAttribute>
			<next:TreeNodeAttribute name="icon" handler="getIcon" ></next:TreeNodeAttribute>
			<next:TreeNodeAttribute name="showType" handler="getChoiceBox"></next:TreeNodeAttribute>
		</next:TreeNodemodel>
	</next:Tree>
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem  text='<%=res.get("BUT.CONFIRM")%>' handler="confirmValue" />
		<next:ToolBarItem  text='<%=res.get("BUT.CLOSE")%>' handler="closeDig" />
	</next:TopBar>
</next:Panel>
</body>
</html>