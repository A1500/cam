
<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<next:ScriptManager/>
<html>
<head>
<title>健康状况</title>
<script type="text/javascript" src="dichealth.js"></script>
<script type="text/javascript">
	var radioType = "radiobox";// 按钮类型（默认为单选按钮）
</script>
</head>  
<body>
<model:datasets>
	<model:dataset id="dicHealth_detaildataset" global="true">
		<model:record fromBean="com.inspur.cams.bpt.dichealth.dao.DicHealth"></model:record>
	</model:dataset>
</model:datasets>
		<next:Panel title="健康状况" collapsible="true" >
			<next:TopBar>
				<next:ToolBarItem symbol="->"></next:ToolBarItem>
				<next:ToolBarItem id="saveButoon" iconCls="yes" text="确定" handler="confirmValue()"></next:ToolBarItem>
				<next:ToolBarItem id="closeButoon" iconCls="no" text="关闭" handler="closew()"></next:ToolBarItem>
				<next:ToolBarItem id="closeButoon" iconCls="no" text="清除" handler="clears()"></next:ToolBarItem>
			</next:TopBar>
			<next:Tree name="dicHealthtree" id="dicHealthtree"rootExpanded="true" collapsible="true" width="100%" height="550" autoScroll="true" lines="true">
				<next:TreeDataSet dataset="dicHealthDataSet" root="rootdata">
					<next:TreeLoader cmd="com.inspur.cams.bpt.dichealth.cmd.DicHealthQueryCommand">
						<next:treeRecord name="dicHealthRecord" idField="code">
		  
		   					<model:field name="code" type="string"/>	
		   					<model:field name="type" type="string"/>	
		   					<model:field name="typeName" type="string"/>	
		   					<model:field name="name" type="string"/>	
						</next:treeRecord>
						<next:TreeBaseparam name="TYPE@=" value="getParent"/>
					</next:TreeLoader>
				</next:TreeDataSet>
				<next:TreeNodemodel recordType="dicHealthRecord">
					<next:TreeNodeAttribute name="text" mapping="name"></next:TreeNodeAttribute>
					<next:TreeNodeAttribute name="disabled" handler="getDicHealthdisabled"></next:TreeNodeAttribute>
	   				<next:TreeNodeAttribute name="showType" handler="'radiobox'"></next:TreeNodeAttribute>
				</next:TreeNodemodel>
			</next:Tree>
		</next:Panel>
</body>
</html>
