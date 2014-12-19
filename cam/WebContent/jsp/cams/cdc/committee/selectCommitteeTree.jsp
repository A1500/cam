<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<next:ScriptManager/>
<html>
<head>
<title>选择社区</title>
<script type="text/javascript" src="selectCommitteeTree.js"></script>
</head>
<body>
<next:Panel anchor="100% 100%" border="false" autoScroll="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem id="saveButoon" iconCls="yes" text="确定" handler="confirmValue()"></next:ToolBarItem>
		<next:ToolBarItem id="closeButoon" iconCls="no" text="关闭" handler="closeWin()"></next:ToolBarItem>
	</next:TopBar>
	<next:Tree id="usertree" width="100%" border="false" lines="true">
		<next:TreeDataSet dataset="stru" root="rootdata">
			<next:TreeLoader cmd="com.inspur.cams.comm.diccity.cmd.DicCityQueryCommand" method="getPermitWithoutSelf" trigger="cityTrigger">
				<next:treeRecord name="cityRecord" idField="id" fromBean="com.inspur.cams.comm.diccity.data.DicCity"/>
				<next:TreeBaseparam name="id" value="getId"></next:TreeBaseparam>
				<next:TreeBaseparam name="name" value="getName"></next:TreeBaseparam>
				<next:TreeBaseparam name="leve" value="getLeve"></next:TreeBaseparam>
				<next:TreeBaseparam name="ups" value="getUps"></next:TreeBaseparam>
			</next:TreeLoader>
			<next:TreeLoader cmd="com.inspur.cams.comm.extuser.cmd.ComExtUserQueryCmd" method="queryUser" trigger="userTrigger">
				<next:treeRecord name="userRecord" idField="userId" fromBean="com.inspur.cams.comm.extuser.data.ComExtUser"/>
				<next:TreeBaseparam name="userId" value="getUserId"></next:TreeBaseparam>
				<next:TreeBaseparam name="userName" value="getUserName"></next:TreeBaseparam>
				<next:TreeBaseparam name="organId" value="getId"></next:TreeBaseparam>
			</next:TreeLoader>
		</next:TreeDataSet>
		<next:TreeNodemodel recordType="cityRecord">
			<next:TreeNodeAttribute name="text" mapping="name"></next:TreeNodeAttribute>
			<next:TreeNodeAttribute name="disabled" handler="getStrudisabled"></next:TreeNodeAttribute>
			<next:TreeNodeAttribute name="icon" handler="getIcon"></next:TreeNodeAttribute>
		</next:TreeNodemodel>
		<next:TreeNodemodel recordType="userRecord">
			<next:TreeNodeAttribute name="text" mapping="userName"></next:TreeNodeAttribute>
			<next:TreeNodeAttribute name="icon" handler="getIcon"></next:TreeNodeAttribute>
			<next:TreeNodeAttribute name="showType" handler="'checkbox'"></next:TreeNodeAttribute>
			<next:TreeNodeAttribute name="leaf" handler="true"></next:TreeNodeAttribute>
		</next:TreeNodemodel>
	</next:Tree>
</next:Panel>
</body>
</html>