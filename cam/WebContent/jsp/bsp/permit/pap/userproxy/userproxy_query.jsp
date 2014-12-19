<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%
org.loushang.next.i18n.ResourceBundle res0=org.loushang.next.i18n.ResourceBundle.getJspDirBundle(request,pageContext);
%>
<html>
<head>
<title></title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="userproxy_query.js"></script>
<script type="text/javascript">
var title = '<%=res0.get("PROXY.PROXY_ADD")%>';
var ASK_SELETE_DELETE = '<%=res0.get("ALETR_SELECT_DELETE")%>';
var RES_PROMOT='<%=res0.get("MSG.PROMOT")%>';
var RES_NOCHANGE='<%=res0.get("MSG.NOCHANGE")%>';
var RES_SAVE='<%=res0.get("MSG.SAVE")%>';
var RES_DELETE='<%=res0.get("ASK.DELETE")%>';
var RES_UNVALIDATED='<%=res0.get("MSG.UNVALIDATED")%>';
</script>
</head>
<body>
<model:datasets>
	<model:dataset id="userproxyDataSet" cmd="org.loushang.bsp.permit.pap.userproxy.cmd.UserProxyQueryCommand"  
	 global="true" method="queryUserProxy">
		<model:record>
			<model:field name="userid" type="string"/>
			<model:field name="proxyuserid" type="string"/>
			<model:field name="proxytype" type="string"/>
			<model:field name="proxypermission" type="string"/>
			<model:field name="proxypermissionInfo" type="string"/>
			<model:field name="proxypermissionId" type="string"/>
			<model:field name="starttime" type="string"/>
			<model:field name="endtime" type="string"/>
		</model:record>
	</model:dataset>
</model:datasets>
<next:ViewPort>
<next:AnchorLayout>
<next:GridPanel id="userproxyGrid" name="userproxyGrid" width="100%" height="600" dataset="userproxyDataSet" notSelectFirstRow="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="add" text='<%=res0.get("BUT.ADD")%>' handler="add_click"></next:ToolBarItem>
		<next:ToolBarItem iconCls="edit" text='<%=res0.get("BUT_EDIT")%>' handler="edit_click"></next:ToolBarItem>
		<next:ToolBarItem iconCls="remove" text='<%=res0.get("BUT.REMOVE")%>' handler="remove_click"></next:ToolBarItem>
	</next:TopBar>
	
	<next:Columns>
		<next:RowNumberColumn width="30"/>
		<next:CheckBoxColumn></next:CheckBoxColumn>
		<next:Column id="userId" header='委托人' field="userid" width="200">	
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="proxyUserId" header='代理人' field="proxyuserid" width="200">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="proxytype" header='<%=res0.get("PROXY.PROXY_TYPE")%>' field="proxypermissionInfo" width="200" >
			<next:TextField allowBlank="false" />
		</next:Column>
		
	</next:Columns>
</next:GridPanel>
</next:AnchorLayout>
</next:ViewPort>
</body>
</html>