<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<next:ScriptManager></next:ScriptManager>
<html>
<head>
<title>选择用户</title>
<script type="text/javascript">
    var struTypeId='<%=request.getParameter("struTypeId")%>';
	if(struTypeId == null) struTypeId = '00';
</script>
<script type="text/javascript" src="selectuser.js"></script>
</head>
<body>
<next:Panel anchor="100% 100%" border="false" autoScroll="true">
	<next:TopBar>
	<next:ToolBarItem symbol="->"></next:ToolBarItem>
	<next:ToolBarItem id="saveButoon" iconCls="yes" text="确定" handler="confirmValue()"></next:ToolBarItem>
	<next:ToolBarItem id="closeButoon" iconCls="no" text="清除" handler="clears()"></next:ToolBarItem>
	</next:TopBar>
	<next:Tree id="usertree" name="usertree" title="选择用户"  rootVisible="true"   autoScroll="true" width="100%" height="100%">
		<next:TreeDataSet dataset="stru" root="rootdata">
			<next:TreeLoader
				cmd="org.loushang.bsp.organization.cmd.StruQueryCommand"
				method="getUserRoleTreeRoot" trigger="struLoaderTrigger">
				<next:treeRecord name="struRecord" idField="struId"
					fromBean="org.loushang.bsp.share.organization.bean.StruView" />
				<next:TreeBaseparam name="parentId" value="getStruParent"></next:TreeBaseparam>
				<next:TreeBaseparam name="struId" value="getStruId"></next:TreeBaseparam>
				<next:TreeBaseparam name="struType" value="getStruType"></next:TreeBaseparam>
				<next:TreeBaseparam name="struTypeId" value="getStruTypeId"></next:TreeBaseparam>
				<next:TreeBaseparam name="isUseDataPermit" value="true"></next:TreeBaseparam>
			</next:TreeLoader>
			<next:TreeLoader
				cmd="org.loushang.bsp.permit.pap.user.cmd.UserQueryCommand"
				trigger="userLoaderTrigger" method="queryUserByOrgan">
				<next:treeRecord name="userRecord" idField="userId"
					fromBean="org.loushang.bsp.permit.pap.user.data.User">
				</next:treeRecord>
				<next:TreeBaseparam name="nodeType" value="getNodeType"></next:TreeBaseparam>
				<next:TreeBaseparam name="organId" value="getOrganId"></next:TreeBaseparam>
			</next:TreeLoader>
		</next:TreeDataSet>
		<next:TreeNodemodel recordType="struRecord">
			<next:TreeNodeAttribute name="text" mapping="organName"></next:TreeNodeAttribute>
			<next:TreeNodeAttribute name="disabled" handler="getStrudisabled"></next:TreeNodeAttribute>
			<next:TreeNodeAttribute name="icon" handler="getIcon"></next:TreeNodeAttribute>
			<next:TreeNodeAttribute name="struPath" mapping="struId"></next:TreeNodeAttribute>

		</next:TreeNodemodel>
		<next:TreeNodemodel recordType="userRecord">
			<next:TreeNodeAttribute name="text" mapping="userId"></next:TreeNodeAttribute>
			<next:TreeNodeAttribute name="icon" handler="getIcon"></next:TreeNodeAttribute>
			<next:TreeNodeAttribute name="showType" handler="'radiobox'"></next:TreeNodeAttribute>
			<next:TreeNodeAttribute name="leaf" handler="true"></next:TreeNodeAttribute>
		</next:TreeNodemodel>
	</next:Tree>
</next:Panel>
</body>
</html>