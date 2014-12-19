<%@page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ include file="/jsp/public/resources_jspdir.jsp" %>
<html>
<head>
<title><%=res.get("LABLE_COUNTRY")%></title>
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
<script type="text/javascript" src="country.js"></script>
</head>
<body>
<model:datasets>
	<model:dataset id="country_ds" pageSize="15" global="true"
		cmd="org.loushang.bsp.ext.location.cmd.CountryQueryCmd" >
		<model:record
			fromBean="org.loushang.bsp.ext.location.data.Country">
		</model:record>
	</model:dataset>
</model:datasets>
<next:ViewPort>
	<next:EditGridPanel id="country_panel" stripeRows="true" dataset="country_ds" height="100%">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="add" text='<%=res.get("LABLE_ADD")%>' handler="add_country_info"></next:ToolBarItem>
		<next:ToolBarItem iconCls="save" text='<%=res.get("LABLE_SAVE")%>' handler="save_country_info"></next:ToolBarItem>
		<next:ToolBarItem iconCls="remove" text='<%=res.get("LABLE_REMOVE")%>' handler="remove_country_info"></next:ToolBarItem>
		<next:ToolBarItem iconCls="undo" text='<%=res.get("LABLE_RESET")%>' handler="reset_country_info"></next:ToolBarItem>
	</next:TopBar>
		<next:Columns>
		    <next:RowNumberColumn width="30"/>
			<next:CheckBoxColumn></next:CheckBoxColumn>
			<next:Column  header='<%=res.get("COL_COUNTRY_CODE")%>'  field="countryCode" editable="setEditable" width="100">
				<next:TextField allowBlank="false" ></next:TextField>
			</next:Column>
			<next:Column  header='<%=res.get("COL_COUNTRY_NAME")%>'  field="countryName" width="300">
				<next:TextField allowBlank="false"></next:TextField>
			</next:Column>
			<next:Column  header='<%=res.get("COL_COUNTRY_SHORT_NAME")%>'  field="countryShortName" width="100">
				<next:TextField allowBlank="false"></next:TextField>
			</next:Column>
		</next:Columns>
		<next:BottomBar>
					<next:PagingToolBar dataset="country_ds"></next:PagingToolBar>
				</next:BottomBar>
	</next:EditGridPanel>
</next:ViewPort>
</body>
</html>