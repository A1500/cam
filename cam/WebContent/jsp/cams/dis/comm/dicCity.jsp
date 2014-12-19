
<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<next:ScriptManager/>
<% 
	//String str = request.getParameter("organName");
    String organName = java.net.URLDecoder.decode(request.getParameter("organName"), "UTF-8");
    String radioMaxlevel = request.getParameter("radioMaxlevel");
    String radioType = request.getParameter("radioType");
    String level = request.getParameter("level");
    String hasBenJi = request.getParameter("hasBenJi");
%>

<script type="text/javascript">
	var radioMaxlevel = 2 //最大不含按钮level值（包含radioMaxlevel本身即<=radioMaxlevel）
	var radioType = "radiobox";// 按钮类型（默认为单选按钮）
	var organCode = '<%=request.getParameter("organCode")%>';
	var organName = '<%=organName%>';
	var level = "4" ;//  默认查询最大级别
	
	<%
		if(hasBenJi != null && !"".equals(hasBenJi)){
	%>
		hasBenJi = '<%= hasBenJi%>';
	<%
		}
	
		if(radioMaxlevel != null && !"".equals(radioMaxlevel)) {
	%>
		 	radioMaxlevel = '<%= radioMaxlevel%>';
	<%		
		}
		
		if(radioType != null && !"".equals(radioType)) {
	%>
			radioType = '<%= radioType%>';
	<%		
		}
		
		if(level != null && !"".equals(level)) {
	%>
			level = '<%= level%>';
	<%		
		}
	%>
	 
</script>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>选择行政区划</title>
<script type="text/javascript" src="dicCity.js"></script>
</head>
<body>
<model:datasets>
	<model:dataset id="dicCity_detaildataset" global="true">
		<model:record fromBean="com.inspur.cams.comm.diccity.data.DicCity"></model:record>
	</model:dataset>
</model:datasets>

		<next:Panel id="treePanel" title="行政区划"  anchor="100% 100%" border="false" height="100%" width="100%" autoScroll="false" >
			<next:TopBar>
				<next:ToolBarItem symbol="->"></next:ToolBarItem>
				<next:ToolBarItem id="saveButoon" iconCls="yes" text="确定" handler="confirmValue()"></next:ToolBarItem>
				<next:ToolBarItem id="closeButoon" iconCls="no" text="关闭" handler="closew()"></next:ToolBarItem>
				<next:ToolBarItem id="closeButoon" iconCls="no" text="清除" handler="clears()"></next:ToolBarItem>
			</next:TopBar>
		
			<next:Tree allowCheck="false" name="dicCitytree" id="dicCitytree" collapsible="true" rootExpanded="true" autoScroll="true" height="100%" lines="true" >
				<next:TreeDataSet dataset="dicCityDataSet" root="rootdata">
					<next:TreeLoader cmd="com.inspur.cams.comm.diccity.cmd.DicCityQueryCommand" 
						    >
						<next:treeRecord name="dicCityRecord" idField="id" >
		  
		   					<model:field name="id" type="string"/>	
		   					<model:field name="name" type="string"/>	
		   					<model:field name="leve" type="string"/>	
		   					<model:field name="ups" type="string"/>
		   					<model:field name="fullName" type="string"/>		
		   					<model:field name="flag" type="string"/>	
						</next:treeRecord>
						<next:TreeBaseparam name="UPS@=" value="getParent"/>
						<next:TreeBaseparam name="IS_SELF@=" value="0"></next:TreeBaseparam>
					</next:TreeLoader>
				</next:TreeDataSet>
				<next:TreeNodemodel recordType="dicCityRecord" >
					<next:TreeNodeAttribute name="text" mapping="name" ></next:TreeNodeAttribute>
					<next:TreeNodeAttribute name="disabled" handler="getDicCitydisabled"></next:TreeNodeAttribute>
					<next:TreeNodeAttribute name="icon" handler="getIcon" ></next:TreeNodeAttribute>
	   				<next:TreeNodeAttribute name="showType" handler="getChoiceBox"></next:TreeNodeAttribute>
				</next:TreeNodemodel>
			</next:Tree>
		</next:Panel>
	
</body>
</html>
