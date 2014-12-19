<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.extuser.util.ExtBspInfo"%>
<next:ScriptManager/>
<html>
<head>
<title>社区账号管理</title>
<%
	String organName = ExtBspInfo.getUserInfo(request).getUserName();
	String userId= ExtBspInfo.getUserInfo(request).getAreaCode();
	String peopleArea= ExtBspInfo.getUserInfo(request).getUserId();
%>
<script type="text/javascript" src="createUsers.js"></script>
<script type="text/javascript">
	var userId ='<%=userId.substring(0,9)+"000"%>';
	var loginName='<%=organName%>';
	var peopleArea='<%=peopleArea%>';
</script>
</head>
<body>
<next:ViewPort>
<next:BorderLayout>
	<next:Left split="true" cmargins="5 0 0 0" margins="5 0 0 0">
		<next:Panel title="社区账号管理" collapsible="true" autoScroll="true" width="20%" anchor="100% 100%">
			<next:Html>
				<next:Tree id="usertree" width="100%" border="false" lines="true">
					<next:TreeDataSet dataset="stru" root="rootdata">
						<next:TreeLoader cmd="com.inspur.cams.comm.diccity.cmd.DicCityQueryCommand" method="getCityTree" trigger="cityTrigger">
							<next:treeRecord name="cityRecord" idField="id" fromBean="com.inspur.cams.comm.diccity.data.DicCity"/>
							<next:TreeBaseparam name="id" value="getId"></next:TreeBaseparam>
							<next:TreeBaseparam name="name" value="getName"></next:TreeBaseparam>
							<next:TreeBaseparam name="leve" value="getLeve"></next:TreeBaseparam>
							<next:TreeBaseparam name="ups" value="getUps"></next:TreeBaseparam>
						</next:TreeLoader>
  						<next:TreeLoader cmd="com.inspur.cams.comm.extuser.cmd.ComExtUserQueryCmd" method="queryUserNode" trigger="userTrigger">
							<next:treeRecord name="userRecord" idField="id" fromBean="com.inspur.cams.comm.extuser.data.ComExtUser"/>
							<next:TreeBaseparam name="userId" value="getUserId"></next:TreeBaseparam>
							<next:TreeBaseparam name="userName" value="getUserName"></next:TreeBaseparam>
							<next:TreeBaseparam name="organId" value="getOrganId"></next:TreeBaseparam>
							<next:TreeBaseparam name="id" value="getId"></next:TreeBaseparam>
						</next:TreeLoader>
					</next:TreeDataSet>
					<next:TreeNodemodel recordType="cityRecord">
						<next:TreeNodeAttribute name="text" mapping="name"></next:TreeNodeAttribute>
						<next:TreeNodeAttribute name="disabled" handler="getStrudisabled"></next:TreeNodeAttribute>
						<next:TreeNodeAttribute name="icon" handler="getIcon"></next:TreeNodeAttribute>
						<next:RightmouseMenu menuId="cityMenu">
							<next:MenuItem text="增加农村社区" handler="addOrgan"></next:MenuItem>
							<next:MenuItem text="增加城市社区" handler="addCity"></next:MenuItem>
						</next:RightmouseMenu>
					</next:TreeNodemodel>
					<next:TreeNodemodel recordType="userRecord">
						<next:TreeNodeAttribute name="text" mapping="userName"></next:TreeNodeAttribute>
						<next:TreeNodeAttribute name="icon" handler="getIcon"></next:TreeNodeAttribute>
						<next:TreeNodeAttribute name="leaf" handler="true"></next:TreeNodeAttribute>
						<next:RightmouseMenu menuId="userMenu">
							<next:MenuItem text="删除用户" handler="delUser"></next:MenuItem>
							<next:MenuItem text="修改用户" handler="editUser"></next:MenuItem>
						</next:RightmouseMenu>
						<next:Listeners>
							<next:Listener eventName="selected" handler="selectedNode"></next:Listener>
						</next:Listeners>
					</next:TreeNodemodel>
				</next:Tree>
			</next:Html>
		</next:Panel>
	</next:Left>
	<next:Center floatable="true">
		<next:Panel>
			<next:Html><iframe id="nodeFrame" name="nodeFrame" width="100%" height="100%"></iframe></next:Html>
		</next:Panel>
	</next:Center>
</next:BorderLayout>
</next:ViewPort>
</body>
</html>