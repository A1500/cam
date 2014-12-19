
<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<next:ScriptManager/>
<script type="text/javascript">
</script>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>选择公墓</title>
<script type="text/javascript">
	var rootId='<%=request.getParameter("rootId")%>';
	var radioType='<%=request.getParameter("radioType")%>';//0:单选；1：多选
</script>
<script type="text/javascript" src="fisCemeOrganTree.js"></script>
</head>
<body>
<model:datasets>
	<model:dataset id="dicCity_detaildataset" global="true">
		<model:record fromBean="com.inspur.cams.fis.base.data.FisDicCity"></model:record>
	</model:dataset>
</model:datasets>
<next:ViewPort>
	<next:Panel  border="false" anchor="100% 100%" >
		<next:TopBar>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem id="saveButoon" iconCls="yes" text="确定" handler="confirmValue()"></next:ToolBarItem>
			<next:ToolBarItem id="closeButoon" iconCls="no" text="关闭" handler="closew()"></next:ToolBarItem>
			<next:ToolBarItem id="closeButoon" iconCls="no" text="清除" handler="clears()"></next:ToolBarItem>
		</next:TopBar>
		<next:Tree name="dicCitytree" id="dicCitytree" collapsible="true" rootExpanded="true" autoScroll="true" height="100%" lines="true">
			<next:TreeDataSet dataset="dicCityDataSet" root="rootdata">
				<next:TreeLoader cmd="com.inspur.cams.fis.base.cmd.FisDicCityQueryCommand">
					<next:treeRecord name="dicCityRecord" idField="id" fromBean="com.inspur.cams.fis.base.data.FisDicCity">
	   					<model:field name="id" type="string"/>	
	   					<model:field name="name" type="string"/>	
	   					<model:field name="leve" type="string"/>	
	   					<model:field name="ups" type="string"/>
	   					<model:field name="fullName" type="string"/>		
	   					<model:field name="flag" type="string"/>	
					</next:treeRecord>
					<next:TreeBaseparam name="UPS@=" value="getParent"/>
				</next:TreeLoader>
				<next:TreeLoader cmd="com.inspur.cams.fis.ep.base.cmd.FisCemeQueryCmd" method="queryOrganByUnitId" trigger="getOrganManage">
					<next:treeRecord name="fisCemeOrganRecord" idField="ORGAN_CODE" >
	   					<model:field name="ORGAN_CODE" type="string"/>	
	   					<model:field name="UNIT_ID" type="string"/>	
	   					<model:field name="UNIT_NAME" type="string"/>	
	   					<model:field name="UNIT_CODE" type="string"/>
					</next:treeRecord>
					<next:TreeBaseparam name="unitId" value="getParentOrgan"/>
				</next:TreeLoader>
			</next:TreeDataSet>
			<next:TreeNodemodel recordType="dicCityRecord">
				<next:TreeNodeAttribute name="text" mapping="name"></next:TreeNodeAttribute>
				<next:TreeNodeAttribute name="icon" handler="getIcon"></next:TreeNodeAttribute>
				<next:TreeNodeAttribute name="showType" handler="getRadioBox"></next:TreeNodeAttribute>
			</next:TreeNodemodel>
			<next:TreeNodemodel recordType="fisCemeOrganRecord">
				<next:TreeNodeAttribute name="text" mapping="UNIT_NAME"></next:TreeNodeAttribute>
   				<next:TreeNodeAttribute name="showType" handler="getRadioBox"></next:TreeNodeAttribute>
			</next:TreeNodemodel>
		</next:Tree>
	</next:Panel>
</next:ViewPort>
</body>
</html>
