<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>LDAP用户同步</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="ldap_syn_users.js"></script>
</head>
<body>
<model:datasets>
	<model:dataset id="pubLdapSynUsersDs"
		cmd="org.loushang.bsp.permit.pap.ldap.cmd.PubLdapSynUsersQueryCmd"
		method="query" global="true">
		<model:record
			fromBean="org.loushang.bsp.permit.pap.ldap.data.PubLdapSynUser"></model:record>
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
						<td class="FieldLabel">用户</td>
						<td class="FieldInput"><input type="text" id="userId0"
							class="TextEditor" title="用户" maxlength="50"/></td>
						<td class="FieldLabel">用户名称</td>
						<td class="FieldInput"><input type="text" id="userName0"
							class="TextEditor" title="用户名称" maxlength="50"/></td>
						<td class="FieldLabel">
						<button  type="button" iconCls="query" onclick="query()">查询</button>&nbsp;
						<button  type="button" iconCls="undo" onclick="reset()">重置</button>
						</td>
					</tr>
				</table>
			</form>
		</div>
	</fieldset>
	</next:Html>
</next:Panel>
<next:EditGridPanel id="Syngrid" name="SynGrid" width="100%"
	stripeRows="true" hidden="false" height="100%"
	dataset="pubLdapSynUsersDs">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="edit" text='执行同步' handler="Evt_butSyn_click"/>
		<next:ToolBarItem iconCls="add" text='添加用户' handler="Evt_butadd_click" />
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn width="30"/>
		<next:CheckBoxColumn></next:CheckBoxColumn>
		<next:Column header="用户" field="userId" width="160">
			<next:TextField allowBlank="false" editable="false" />
		</next:Column>
		<next:Column header="用户名称" field="userName" width="160">
			<next:TextField editable="false" />
		</next:Column>
		<next:Column header="电话" field="mobile" width="160">
			<next:TextField editable="false" />
		</next:Column>
		<next:Column header="邮箱" field="email" width="240">
			<next:TextField editable="false" />
		</next:Column>
		<next:Column header="" field="password" hidden="true">
			<next:TextField editable="false"/>
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="pubLdapSynUsersDs" ></next:PagingToolBar>
	</next:BottomBar>
</next:EditGridPanel>
</next:AnchorLayout>
</next:ViewPort>
</body>
</html>
