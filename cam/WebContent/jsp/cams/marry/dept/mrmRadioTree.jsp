<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<next:ScriptManager/>
<html>
<head>
<title>婚姻登记机构管理</title>
<script type="text/javascript" src="mrmRadioTree.js"></script>
</head>
<body>
		<next:Panel title="婚姻登记机构" anchor="100% 100%" border="false" height="100%" width="100%" autoScroll="false"  >
			<next:TopBar>
				<next:ToolBarItem symbol="->"></next:ToolBarItem>
				<next:ToolBarItem id="saveButoon" iconCls="yes" text="确定" handler="confirmValue()"></next:ToolBarItem>
				<next:ToolBarItem id="closeButoon" iconCls="no" text="关闭" handler="closew()"></next:ToolBarItem>
				<next:ToolBarItem id="closeButoon" iconCls="no" text="清除" handler="clears()"></next:ToolBarItem>
			</next:TopBar>
				<next:Tree id="marryTree" width="100%" collapsible="true" rootExpanded="true" autoScroll="true" height="100%" lines="true">
					<next:TreeDataSet dataset="stru" root="rootdata">
						<next:TreeLoader cmd="com.inspur.cams.comm.diccity.cmd.DicCityQueryCommand" method="getCityPermitTree" trigger="cityTrigger">
							<next:treeRecord name="cityRecord" idField="id" fromBean="com.inspur.cams.comm.diccity.data.DicCity"/>
							<next:TreeBaseparam name="id" value="getId"></next:TreeBaseparam>
							<next:TreeBaseparam name="name" value="getName"></next:TreeBaseparam>
							<next:TreeBaseparam name="leve" value="getLeve"></next:TreeBaseparam>
							<next:TreeBaseparam name="ups" value="getUps"></next:TreeBaseparam>
						</next:TreeLoader>
						<next:TreeLoader cmd="com.inspur.cams.marry.base.cmd.MrmRegisOrganInfoQueryCommand" method="getOrgan" trigger="organTrigger">
							<next:treeRecord name="organRecord" idField="organId" fromBean="com.inspur.cams.marry.base.data.MrmRegisOrganInfo">
								<model:field name="organId" type="string"/>	
			   					<model:field name="name" type="string"/>	
		   					</next:treeRecord>
							<next:TreeBaseparam name="id" value="getId"></next:TreeBaseparam>
							<next:TreeBaseparam name="UPS@=" value="getParent"/>
						</next:TreeLoader>
					</next:TreeDataSet>
					<next:TreeNodemodel recordType="cityRecord">
						<next:TreeNodeAttribute name="text" mapping="name"></next:TreeNodeAttribute>
						<next:TreeNodeAttribute name="disabled" handler="getStrudisabled"></next:TreeNodeAttribute>
						<next:TreeNodeAttribute name="icon" handler="getIcon"></next:TreeNodeAttribute>
					</next:TreeNodemodel>
					<next:TreeNodemodel recordType="organRecord">
						<next:TreeNodeAttribute name="text" mapping="name"></next:TreeNodeAttribute>
						<next:TreeNodeAttribute name="icon" handler="getIcon"></next:TreeNodeAttribute>
						<next:TreeNodeAttribute name="leaf" handler="false"></next:TreeNodeAttribute>
						<next:TreeNodeAttribute name="showType" handler="getChoiceBox"></next:TreeNodeAttribute>
					</next:TreeNodemodel>
					 
				</next:Tree>
		</next:Panel>
</body>
</html>