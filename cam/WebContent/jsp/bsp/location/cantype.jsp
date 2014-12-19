<%@page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ include file="/jsp/public/resources_jspdir.jsp" %>
<html>
<head>
<title><%=res.get("LABLE_CANTYPE")%></title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript">
	var res = {};
	res.prompts = '<%=res.get("MSG.PROMOT")%>';
	res.nochange = '<%=res.get("MSG_NOCHANGE")%>';
	res.saveOK = '<%=res.get("MSG.SAVE")%>';
	res.askRemove = '<%=res.get("ASK.DELETE")%>';
	res.noselected = '<%=res.get("MSG_NOSELECTED")%>';
	res.removeOk = '<%=res.get("MSG.DELETE")%>';
	res.onusing = '<%=res.get("MSG.ONUSING")%>';
</script>
<script type="text/javascript" src="cantype.js"></script>
</head>
<body>
<model:datasets>
	<model:dataset id="cantype_ds" pageSize="-1" global="true"
		cmd="org.loushang.bsp.ext.location.cmd.CantTypeQueryCmd">
		<model:record
			fromBean="org.loushang.bsp.ext.location.data.CantType">
		</model:record>
	</model:dataset>
</model:datasets>
<next:ViewPort>
	<next:EditGridPanel id="cantype_panel" stripeRows="true" dataset="cantype_ds" height="300">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="add" text='<%=res.get("LABLE_ADD")%>' handler="add_cantype_info"></next:ToolBarItem>
		<next:ToolBarItem iconCls="save" text='<%=res.get("LABLE_SAVE")%>' handler="save_cantype_info"></next:ToolBarItem>
		<next:ToolBarItem iconCls="remove" text='<%=res.get("LABLE_REMOVE")%>' handler="remove_cantype_info"></next:ToolBarItem>
		<next:ToolBarItem iconCls="undo" text='<%=res.get("LABLE_RESET")%>' handler="reset_cantype_info"></next:ToolBarItem>
	</next:TopBar>
		<next:Columns>
			<next:NumberField></next:NumberField>
			<next:CheckBoxColumn></next:CheckBoxColumn>
			<next:Column  header='<%=res.get("COL_CANTYPE_CODE")%>'  field="cantType" width="100">
				<next:TextField allowBlank="false"></next:TextField>
			</next:Column>
			<next:Column  header='<%=res.get("COL_CANTYPE_NAME")%>'  field="typeName" width="300">
				<next:TextField allowBlank="false"></next:TextField>
			</next:Column>
		</next:Columns>
	</next:EditGridPanel>
</next:ViewPort>

</body>
</html>