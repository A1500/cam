
<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<next:ScriptManager/>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>职称</title>
<script type="text/javascript" src="dicBptCareer.js"></script>
</head>
<body>
<model:datasets>
	<model:dataset id="dicBptCareer_detaildataset" global="true">
		<model:record fromBean="com.inspur.cams.bpt.base.data.DicBptCareer"></model:record>
	</model:dataset>
</model:datasets>

		<next:Panel title="职称"  anchor="100% 100%" border="false" height="100%" width="100%" autoScroll="false" >
			<next:TopBar>
				<next:ToolBarItem symbol="->"></next:ToolBarItem>
				<next:ToolBarItem id="saveButoon" iconCls="yes" text="确定" handler="confirmValue()"></next:ToolBarItem>
				<next:ToolBarItem id="closeButoon" iconCls="no" text="关闭" handler="closew()"></next:ToolBarItem>
				<next:ToolBarItem id="closeButoon" iconCls="no" text="清除" handler="clears()"></next:ToolBarItem>
			</next:TopBar>
		
			<next:Tree name="dicBptCareertree" id="dicBptCareertree" collapsible="true" rootExpanded="true" autoScroll="true" height="100%" lines="true">
				<next:TreeDataSet dataset="dicCityDataSet" root="rootdata">
					<next:TreeLoader cmd="com.inspur.cams.bpt.manage.cmd.DicBptCareerQueryCommand">
						<next:treeRecord name="dicBptCareerRecord" idField="id">
		  					<model:field name="leve" type="string"/>
		   					<model:field name="code" type="string"/>	
		   					<model:field name="name" type="string"/>	
		   					<model:field name="ups" type="string"/>
						</next:treeRecord>
						<next:TreeBaseparam name="UPS@=" value="getParent"/>
					</next:TreeLoader>
				</next:TreeDataSet>
				<next:TreeNodemodel recordType="dicBptCareerRecord">
					<next:TreeNodeAttribute name="text" mapping="name"></next:TreeNodeAttribute>
					<next:TreeNodeAttribute name="disabled" handler="getDicCitydisabled"></next:TreeNodeAttribute>
					<next:TreeNodeAttribute name="icon" handler="getIcon" ></next:TreeNodeAttribute>
	   				<next:TreeNodeAttribute name="showType" handler="getChoiceBox"></next:TreeNodeAttribute>
				</next:TreeNodemodel>
			</next:Tree>
		</next:Panel>
	
</body>

</html>
