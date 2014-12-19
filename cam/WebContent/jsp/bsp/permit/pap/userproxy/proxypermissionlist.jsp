<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%
org.loushang.next.i18n.ResourceBundle res0=org.loushang.next.i18n.ResourceBundle.getJspDirBundle(request,pageContext);
%>
<html>
<head>
<meta http-equiv="Content-Tres" content="text/html; charset=utf-8">
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="proxypermissionlist.js"></script>
<script type="text/javascript" src="proxypermission.js"></script>
<script type="text/javascript">
var RES_PROMOT='<%=res0.get("MSG.PROMOT")%>';
var RES_NOCHANGE='<%=res0.get("MSG.NOCHANGE")%>';
var RES_SAVE='<%=res0.get("MSG.SAVE")%>';
var RES_DELETE='<%=res0.get("ASK.DELETE")%>';
var RES_UNVALIDATED='<%=res0.get("MSG.UNVALIDATED")%>';
</script>
</head>
<body >
<model:datasets>
	<model:dataset id="proxyPermissionDst"
		cmd="org.loushang.bsp.permit.pap.userproxy.cmd.ProxyPermissionQueryCommand"
		global="true" pageSize="10">
		<model:record
			fromBean="org.loushang.bsp.permit.pap.userproxy.data.ProxyPermission">
		</model:record>
	</model:dataset>
	<model:dataset id="ableRolesDataset" pageSize="-1" cmd="org.loushang.bsp.permit.pap.user.cmd.UserQueryCommand" method="getUserAbleRoles" autoLoad="true" >
		<model:record fromBean="org.loushang.bsp.permit.pap.role.data.Role">
		</model:record>
	</model:dataset>
	<model:dataset id="proxyPermissionItemDst" global="true">
		<model:record fromBean="org.loushang.bsp.permit.pap.userproxy.data.ProxyPermissionItem"></model:record>
	</model:dataset>
	<model:dataset id="userProxyDst" cmd="org.loushang.bsp.permit.pap.userproxy.cmd.UserProxyQueryCommand" global="true">
		<model:record  fromBean="org.loushang.bsp.permit.pap.userproxy.data.UserProxy"></model:record>
	</model:dataset>
	<model:dataset id="proxyRoleDataSet" cmd="org.loushang.bsp.permit.pap.userproxy.cmd.ProxyPermissionQueryCommand" method="getProxyRole" global="true">
		<model:record>
			<model:field name="proxyRole"/>
		</model:record>
	</model:dataset>
</model:datasets>
<next:ViewPort>
	<next:Panel id="cards" autoScroll="true">
		<next:CardLayout >
				<next:GridPanel dataset="proxyPermissionDst" id="permissionGrid"
					  autoScroll="true" height="100%" width="100%"  notSelectFirstRow="true">
					<next:TopBar>
						<next:ToolBarItem  symbol="->"  />
						<next:ToolBarItem text="增加委托项" iconCls="add" handler="addProxyPermission"></next:ToolBarItem>
						<next:ToolBarItem text="修改/查看委托信息" iconCls="edit" handler="editProxyPermission"></next:ToolBarItem>
						<next:ToolBarItem text="删除" iconCls="remove" handler="removeProxyPermission"></next:ToolBarItem>
						<next:ToolBarItem></next:ToolBarItem>
					</next:TopBar>
					<next:Columns onRowSelect="RowSelect">
						<next:RowNumberColumn width="30" />
						<next:CheckBoxColumn></next:CheckBoxColumn>
						<next:Column header="委托项" field="proxyPermissionName" width="150">
							<next:TextField allowBlank="false"></next:TextField>
						</next:Column>
						<next:Column id="note" header="描述" field="note" width="400">
							 <next:TextField allowBlank="false"></next:TextField>
						</next:Column>
					</next:Columns>
					<next:BottomBar>
						<next:PagingToolBar  dataset="proxyPermissionDst"/>
					</next:BottomBar>
				</next:GridPanel>
			<next:TabPanel  id="card1" autoScroll="true" height="100%">
				<next:TopBar>
					<next:ToolBarItem  symbol="->"  />
					<next:ToolBarItem text="取消" iconCls="undo" handler="cancelsaveProxyPermission"></next:ToolBarItem>
					<next:ToolBarItem text="保存" iconCls="save" handler="saveProxyPermission"></next:ToolBarItem>
					<next:ToolBarItem text="返回" iconCls="undo" handler="backProxyPermissionList"></next:ToolBarItem>
				</next:TopBar>
				<%@include file="proxypermission.jsp"%>
			</next:TabPanel>
			</next:CardLayout>
	</next:Panel>
</next:ViewPort>
</body>
</html>