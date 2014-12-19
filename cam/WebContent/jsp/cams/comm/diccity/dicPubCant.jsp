
<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<next:ScriptManager/>
<% 
	//String str = request.getParameter("organName");
   String organName = java.net.URLDecoder.decode(request.getParameter("organName"), "UTF-8");
%>

<script type="text/javascript">
	var organCode = '<%=request.getParameter("organCode")%>';
	var organName = '<%=organName%>';
</script>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>选择行政区划</title>
<script type="text/javascript" src="dicPubCant.js"></script>
</head>
<body>
<model:datasets>
	<model:dataset id="dicCity_detaildataset" global="true">
		<model:record fromBean="com.inspur.cams.comm.diccity.data.DicPubCant"></model:record>
	</model:dataset>
</model:datasets>

		<next:Panel title="行政区划"  anchor="100% 100%" border="false" height="100%" width="100%" autoScroll="false" >
			<next:TopBar>
				<next:ToolBarItem symbol="->"></next:ToolBarItem>
				<next:ToolBarItem id="saveButoon" iconCls="yes" text="确定" handler="confirmValue"></next:ToolBarItem>
				<next:ToolBarItem id="closeButoon" iconCls="no" text="关闭" handler="closew"></next:ToolBarItem>
				<next:ToolBarItem id="closeButoon" iconCls="no" text="清除" handler="clears"></next:ToolBarItem>
			</next:TopBar>
		
			<next:Tree name="dicCitytree" id="dicCitytree" collapsible="true" rootExpanded="true" autoScroll="true" height="100%" lines="true">
				<next:TreeDataSet dataset="dicCityDataSet" root="rootdata">
					<next:TreeLoader cmd="com.inspur.cams.comm.diccity.cmd.DicCityQueryCommand" method="getProvice">
						<next:treeRecord name="dicCityRecord" idField="cantCode">
		   					<model:field name="cantCode" type="string"/>	
		   					<model:field name="cantName" type="string"/>	
		   					<model:field name="superCode" type="string"/>	
		   					<model:field name="countryCode" type="string"/>	
		   					<model:field name="cantNote" type="string"/>	
		   					<model:field name="inUse" type="string"/>	
		   					<model:field name="cantType" type="string"/>	
		   					<model:field name="shortName" type="string"/>
						</next:treeRecord>
						<next:TreeBaseparam name="SUPER_CODE@=" value="getParent"/>
					</next:TreeLoader>
				</next:TreeDataSet>
				<next:TreeNodemodel recordType="dicCityRecord">
					<next:TreeNodeAttribute name="text" mapping="cantName"></next:TreeNodeAttribute>
					<next:TreeNodeAttribute name="disabled" handler="getDicCitydisabled"></next:TreeNodeAttribute>
					<next:TreeNodeAttribute name="icon" handler="getIcon" ></next:TreeNodeAttribute>
	   				<next:TreeNodeAttribute name="showType" handler="getChoiceBox"></next:TreeNodeAttribute>
				</next:TreeNodemodel>
			</next:Tree>
		</next:Panel>
	
</body>
</html>
