<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<next:ScriptManager/>
<html>
<head>
<title>婚姻登记机构管理</title>
<script type="text/javascript" src="mrmregisorganinfoTree.js"></script>
</head>
<body>
<next:ViewPort>
<next:BorderLayout>
	<next:Left split="true" cmargins="5 0 0 0" margins="5 0 0 0">
		<next:Panel title="婚姻登记机构管理" collapsible="true" autoScroll="true" width="20%" anchor="100% 100%">
			<next:Html>
				<next:Tree id="usertree" width="100%" border="false" lines="true">
					<next:TreeDataSet dataset="stru" root="rootdata">
						<next:TreeLoader cmd="com.inspur.cams.comm.diccity.cmd.DicCityQueryCommand" method="getCityPermitTree" trigger="cityTrigger">
							<next:treeRecord name="cityRecord" idField="id" fromBean="com.inspur.cams.comm.diccity.data.DicCity"/>
							<next:TreeBaseparam name="id" value="getId"></next:TreeBaseparam>
							<next:TreeBaseparam name="name" value="getName"></next:TreeBaseparam>
							<next:TreeBaseparam name="leve" value="getLeve"></next:TreeBaseparam>
							<next:TreeBaseparam name="ups" value="getUps"></next:TreeBaseparam>
						</next:TreeLoader>
						<next:TreeLoader cmd="com.inspur.cams.marry.base.cmd.MrmRegisOrganInfoQueryCommand" method="getOrgan" trigger="organTrigger">
							<next:treeRecord name="organRecord" idField="organId" fromBean="com.inspur.cams.marry.base.data.MrmRegisOrganInfo"/>
							<next:TreeBaseparam name="id" value="getId"></next:TreeBaseparam>
						</next:TreeLoader>
						<next:TreeLoader cmd="com.inspur.cams.comm.extuser.cmd.ComExtUserQueryCmd" method="queryUser" trigger="userTrigger">
							<next:treeRecord name="userRecord" idField="userId" fromBean="com.inspur.cams.comm.extuser.data.ComExtUser"/>
							<next:TreeBaseparam name="userId" value="getUserId"></next:TreeBaseparam>
							<next:TreeBaseparam name="userName" value="getUserName"></next:TreeBaseparam>
							<next:TreeBaseparam name="organId" value="getOrganId"></next:TreeBaseparam>
						</next:TreeLoader>
					</next:TreeDataSet>
					<next:TreeNodemodel recordType="cityRecord">
						<next:TreeNodeAttribute name="text" mapping="name"></next:TreeNodeAttribute>
						<next:TreeNodeAttribute name="disabled" handler="getStrudisabled"></next:TreeNodeAttribute>
						<next:TreeNodeAttribute name="icon" handler="getIcon"></next:TreeNodeAttribute>
						<next:RightmouseMenu menuId="cityMenu">
							<next:MenuItem text="增加单位" handler="addOrgan"></next:MenuItem>
						</next:RightmouseMenu>
					</next:TreeNodemodel>
					<next:TreeNodemodel recordType="organRecord">
						<next:TreeNodeAttribute name="text" mapping="name"></next:TreeNodeAttribute>
						<next:TreeNodeAttribute name="icon" handler="getIcon"></next:TreeNodeAttribute>
						<next:TreeNodeAttribute name="leaf" handler="false"></next:TreeNodeAttribute>
						<next:RightmouseMenu menuId="organMenu">
							<next:MenuItem text="删除单位" handler="delOrgan"></next:MenuItem>
						</next:RightmouseMenu>
						<next:Listeners>
							<next:Listener eventName="selected" handler="selectedNode"></next:Listener>
						</next:Listeners>
					</next:TreeNodemodel>
					<next:TreeNodemodel recordType="userRecord">
						<next:TreeNodeAttribute name="text" mapping="userName"></next:TreeNodeAttribute>
						<next:TreeNodeAttribute name="icon" handler="getIcon"></next:TreeNodeAttribute>
						<next:TreeNodeAttribute name="leaf" handler="true"></next:TreeNodeAttribute>
						<next:RightmouseMenu menuId="userMenu">
							<next:MenuItem text="删除用户" handler="delUser"></next:MenuItem>
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