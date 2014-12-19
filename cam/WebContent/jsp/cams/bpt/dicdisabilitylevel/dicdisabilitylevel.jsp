
<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<next:ScriptManager/>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>伤残等级</title>
<script type="text/javascript" src="dicdisabilitylevel.js"></script>
</head>
<body>
<model:datasets>
	<model:dataset id="dicDisabilityLevel_detaildataset" global="true">
		<model:record fromBean="com.inspur.cams.bpt.dicdisabilitylevel.dao.DicDisabilityLevel"></model:record>
	</model:dataset>
</model:datasets>
		<next:Panel title="伤残等级" collapsible="true" width="100%" >
				<next:TopBar>
				<next:ToolBarItem symbol="->"></next:ToolBarItem>
				<next:ToolBarItem id="saveButoon" iconCls="yes" text="确定" handler="confirmValue()"></next:ToolBarItem>
				<next:ToolBarItem id="closeButoon" iconCls="no" text="关闭" handler="closew()"></next:ToolBarItem>
				<next:ToolBarItem id="closeButoon" iconCls="no" text="清除" handler="clears()"></next:ToolBarItem>
		</next:TopBar>
			<next:Tree name="dicDisabilityLeveltree" id="dicDisabilityLeveltree" collapsible="true" width="100%" height="550" rootExpanded="true" autoScroll="true" lines="true">
				<next:TreeDataSet dataset="dicDisabilityLevelDataSet" root="rootdata">
					<next:TreeLoader cmd="com.inspur.cams.bpt.dicdisabilitylevel.cmd.DicDisabilityLevelQueryCommand">
						<next:treeRecord name="dicDisabilityLevelRecord" idField="code">
		  
		   					<model:field name="code" type="string"/>	
		   					<model:field name="name" type="string"/>	
		   					<model:field name="organId" type="string"/>	
		   					<model:field name="parentId" type="string"/>	
		   					<model:field name="sortOrder" type="string"/>	
		   					<model:field name="levelId" type="string"/>	
						</next:treeRecord>
						<next:TreeBaseparam name="PARENT_ID@=" value="getParent"/>
					</next:TreeLoader>
				</next:TreeDataSet>
				<next:TreeNodemodel recordType="dicDisabilityLevelRecord">
				<next:TreeNodeAttribute name="showType" handler="'checkbox'" ></next:TreeNodeAttribute>
					<next:TreeNodeAttribute name="text" mapping="name"></next:TreeNodeAttribute>
					<next:TreeNodeAttribute name="disabled" handler="getDicDisabilityLeveldisabled"></next:TreeNodeAttribute>
					
				</next:TreeNodemodel>
			</next:Tree>
		</next:Panel>
</body>
</html>
