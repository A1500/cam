<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="org.loushang.next.skin.SkinUtils" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ include file="/jsp/public/resources_jspdir.jsp"%>
<html>
<head>
<title><%=res.get("ROLEGROUP.TITLE")%></title>
<next:ScriptManager/>
<script type="text/javascript" src="rolegroup_query.js"></script>

<script type="text/javascript">
var rolegroup_add = '<%=res.get("ROLEGROUP.ADD")%>';
var definition_role = '<%=res.get("ROLE.DEFINITION")%>';
var RES_PROMOT='<%=res.get("MSG.PROMOT")%>';
var RES_NOCHANGE='<%=res.get("MSG.NOCHANGE")%>';
var RES_SAVE='<%=res.get("MSG.SAVE")%>';
var RES_DELETE='<%=res.get("ASK.DELETE")%>';
var RES_UNVALIDATED='<%=res.get("MSG.UNVALIDATED")%>';
var ASK_SELETE_DELETE = '<%=res.get("UTIL.SELECT_DELETE")%>';
var ALERT_SELECT_ONE = '<%=res.get("ALETR_SELECT_ONE")%>';
var MENU_TREE_MANAGER = '<%=res.get("MENU_TREE_MANAGER")%>';
var ROLE_QUERY = '<%=res.get("ROLE.QUERY")%>';
var alert_delete_mes = '<%=res.get("ROLEGROUP.ALERT_DELETE_MES")%>';
</script>
</head>
<body  style="width:100%">
<model:datasets>
	<model:dataset id="roleGroupDataSet" cmd="org.loushang.bsp.permit.pap.rolegroup.cmd.RoleGroupQueryCmd" global="true">
		<model:record fromBean="org.loushang.bsp.permit.pap.rolegroup.data.RoleGroup">
			<model:field name="corporationName" type="string"/>
		</model:record>
	</model:dataset>
</model:datasets>

<next:ViewPort>
<next:AnchorLayout> 
<next:Panel  name="form"  border="false" anchor="100%" >
	<next:Html>
	<fieldset style="overflow: visible;" class="GroupBox" >
		<legend class="GroupBoxTitle">查询条件</legend>
		<div>
		<form class="L5form">
				<table width="80%">
					<tr>
						<td class="FieldLabel"><%=res.get("ROLEGROUP.NAME") %></td>
						<td class="FieldInput"><input type="text" id="name"
							class="TextEditor" title="角色组名称" maxlength="50"/></td>
						
						<td class="FieldLabel">
						<button  type="button" iconCls="query" onclick="search()"><%=res.get("BUT.QUERY")%></button>&nbsp;
						<button  type="button" iconCls="undo" onclick="reset()">重置</button>
						</td>
					</tr>
				</table>
			</form></div>
	</fieldset>
	</next:Html>
</next:Panel>
<next:GridPanel id="roleGroupGrid" name="roleGroupGrid" width="100%" height="100%" dataset="roleGroupDataSet" >
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem text='<%=res.get("BUT.ADD") %>' iconCls="add" handler="add_click" />
		<next:ToolBarItem text="修改" iconCls="edit" handler="update_click"/>
		<next:ToolBarItem text="角色列表" iconCls="detail" handler="detail_click"/>
		<next:ToolBarItem text='<%=res.get("BUT.REMOVE") %>' iconCls="remove" handler="remove_click"/>
		<next:ToolBarItem text='<%=res.get("ROLEGROUP.MANAGEROLE") %>' iconCls="add" handler="addrole_click"/>
	</next:TopBar>

	<next:Columns>
		<next:RowNumberColumn width="30"/>
		<next:CheckBoxColumn></next:CheckBoxColumn>
		<next:Column id="roleGroupName" header='<%=res.get("ROLEGROUP.NAME")%>' field="roleGroupName" width="200">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="corporationName" header='<%=res.get("ROLEGROUP.CORPORATION")%>' field="corporationName" width="200">
			<next:TextField allowBlank="false" />
		</next:Column>
	</next:Columns>

	<next:BottomBar>
		<next:PagingToolBar  dataset="roleGroupDataSet"/>
	</next:BottomBar>
</next:GridPanel>
</next:AnchorLayout>
</next:ViewPort>
</body>
</html>