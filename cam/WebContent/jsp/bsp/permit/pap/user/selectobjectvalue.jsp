<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ include file="/jsp/public/resources_jspdir.jsp" %>
<next:ScriptManager/>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>选择数据</title>
<script type="text/javascript">
	//var dataType='<%=request.getParameter("dataTypeRecord")%>';
	var dataType='<%=request.getParameter("dataType")%>';

</script>
<script type="text/javascript" src="selectobjectvalue.js">
</script>
</head>
<body>
<model:datasets>
	<model:dataset id="objectValueDataset" pageSize="15" global="true" cmd="org.loushang.bsp.permit.pap.user.cmd.UserQueryCommand" method="getObjectValue">
		<model:record>
			<model:field name="selCol" mapping="SEL_COL" type="string"/>
			<model:field name="dispCol" mapping="DISP_COL" type="string"/>
		</model:record>
	</model:dataset>
</model:datasets>
<next:GridPanel dataset="objectValueDataset" width="100%" height="100%" autoScroll="true">
	<next:Columns>
		<next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column header='<%=res.get("PUB_USER_DATA_PERMIT.OBJECT_VALUE")%>' field="selCol"></next:Column>
		<next:Column header='<%=res.get("PUB_USER_DATA_PERMIT.OBJECT_NAME")%>' field="dispCol"></next:Column>
	</next:Columns>
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem  iconCls="yes" text='<%=res.get("BUT.CONFIRM")%>' handler="confirmValue" />
		<next:ToolBarItem  iconCls="no" text='<%=res.get("BUT.CLOSE")%>' handler="closeDig" />
	</next:TopBar>
	<next:BottomBar>
		<next:PagingToolBar dataset="objectValueDataset"/>
	</next:BottomBar>
</next:GridPanel>
</body>
</html>