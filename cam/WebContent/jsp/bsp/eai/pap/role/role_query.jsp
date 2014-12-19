<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ include file="/jsp/public/resources_jspdir.jsp"%>
<html>
<head>
<title><%=res.get("TREE.TITLE")%></title>
<next:ScriptManager />
<script type="text/javascript" src="role_query.js"></script>
<script language="javascript">
var RES_DELETE='<%=res.get("ASK.DELETE")%>';
</script>
</head>
<body>

<model:datasets>
	<model:dataset id="roleDataSet" cmd="org.loushang.bsp.eai.pap.role.cmd.RoleQueryCommand" global="true"  pageSize="15" >
		<model:record fromBean="org.loushang.bsp.eai.pap.role.data.Role">
			<model:field name="roleName" type="string"/>
			<model:field name="appName" type="string"/>
		</model:record>
	</model:dataset>
</model:datasets>
<next:ViewPort>
<next:AnchorLayout>
<next:Panel border="false" width="100%">
<next:Panel border="false" width="100%">
<next:Html>
							<form onsubmit="return false;" class="L5form">
<fieldset style="overflow: visible;"><legend
								class="GroupBoxTitle">查询条件 <img
								class="GroupBoxExpandButton"
								src="<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>"
								onclick="collapse(this);" /> </legend>
							<div>
							<table width="100%">
								<tr height="100">
								<td class="FieldLabel">角色名称:</td>
								<td class="FieldInput"><input  type="text" name="roleId" field="roleId" style="display:none"/>
			                    <input  type="text"  id="roleName" name="roleName" field="roleName" />
									<td class="FieldLabel">所属应用:</td>
									<td class="FieldInput"><input  type="text" name="appCode" field="appCode"   style="display:none"/>
				<input  type="text" name="appName" field="appName"   disabled="disabled" />
				<img src="<%=SkinUtils.getImage(request,"l5/help.gif")%>" style="cursor:hand" onclick="forHelpApp()"/></td>
									<td class="FieldLabel">所属组织：</td>
									<td class="FieldInput"><input type="text" id="relationId"
										class="TextEditor"  style="display: none;" /><input type="text" id="organName"
										class="TextEditor" disabled="disabled" />  <img
										src="<%=SkinUtils.getImage(request,"l5/help.gif")%>"
										style="cursor: hand" onclick="forHelp()" /></td>
									<td >
										<button onclick="search()">
										 <img
										src="<%=SkinUtils.getImage(request,"default/toolbar/query.png")%>"
										style="width:15"  title="查询"/>
										 查询
										 </button>
										 <button onclick="reset()">
										 <img
										src="<%=SkinUtils.getImage(request,"default/toolbar/undo.gif")%>"
										style="width:15" />
										重置
										 </button>
									</td>
								</tr>
							</table>
							
					</div>
	</fieldset>
			</form>
						</next:Html>
</next:Panel>
<next:GridPanel id="roleGrid" name="roleGrid" width="100%" height="100%" dataset="roleDataSet" notSelectFirstRow="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem text="操作集" iconCls="edit" handler="rolePermit_click"/>
		<next:ToolBarItem text='<%=res.get("BUT.ADD") %>' iconCls="add" handler="add_click" />
		<next:ToolBarItem text="修改" iconCls="edit" handler="update_click"/>
		<next:ToolBarItem text='<%=res.get("BUT.REMOVE") %>' iconCls="remove" handler="remove_click"/>
	</next:TopBar>
	
	<next:Columns>
		<next:RowNumberColumn width="30"/>
		<next:CheckBoxColumn></next:CheckBoxColumn>
		<next:Column id="roleName" header='<%=res.get("PUB_ROLE.ROLE_NAME")%>' field="roleName" width="250">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="appName" header='所属应用' field="appName" width="250">
		<next:TextField allowBlank="false" />
	</next:Column>
		<next:Column id="discription" header='<%=res.get("PUB_ROLE.DESCRIPTION")%>' field="discription" width="500">
			<next:TextField allowBlank="false" />
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar  dataset="roleDataSet"/>
	</next:BottomBar>
</next:GridPanel>
</next:Panel>
</next:AnchorLayout>
</next:ViewPort>
</body>
</html>