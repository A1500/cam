<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="org.loushang.next.skin.SkinUtils" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ include file="/jsp/public/resources_jspdir.jsp"%>
<html>
<head>
<title></title>
<next:ScriptManager/>
<script type="text/javascript" src="role_query.js"></script>
<script type="text/javascript">
var struId = '<%=request.getParameter("struId")%>';
	struId = decodeURI(struId);
var roleGroupId = '<%=request.getParameter("roleGroupId")%>';
	roleGroupId = decodeURI(roleGroupId);
var roleGroupName = '<%=request.getParameter("roleGroupName")%>';
	roleGroupName = decodeURI(roleGroupName);
var definition_role = '<%=res.get("ROLE.DEFINITION")%>';
var RES_PROMOT='<%=res.get("MSG.PROMOT")%>';
var RES_NOCHANGE='<%=res.get("MSG.NOCHANGE")%>';
var RES_SAVE='<%=res.get("MSG.SAVE")%>';
var RES_DELETE='<%=res.get("ASK.DELETE")%>';
var RES_UNVALIDATED='<%=res.get("MSG.UNVALIDATED")%>';
var ASK_SELETE_DELETE = '<%=res.get("ALETR_SELECT_DELETE")%>';
var ALERT_SELECT_ONE = '<%=res.get("ALETR_SELECT_ONE")%>';
var alert_delete_mes = "角色已被授予用户，不允许删除！";
</script>
</head>
<body>
<model:datasets>
	<model:dataset id="roleDataSet" cmd="org.loushang.bsp.permit.pap.role.cmd.RoleQueryCommand" method="getRoleByRoleGroup" global="true">
		<model:record fromBean="org.loushang.bsp.permit.pap.role.data.Role">
			<model:field name="organName" type="string"/>
		</model:record>
	</model:dataset>
</model:datasets>
<next:ViewPort>
<next:AnchorLayout>
<next:GridPanel id="roleGrid" name="roleGrid" width="100%" height="100%" dataset="roleDataSet" autoScroll="true">
	<next:ExtendConfig>
		tbar:[
			{text: '<%=res.get("ROLE.NAME")%>'},
            {xtype: 'textfield',id: 'name'},
  			{iconCls:'query',text:'<%=res.get("BUT.QUERY")%>',handler:search},
			 '->',
			{iconCls:'add',text:'<%=res.get("BUT.ADD")%>',handler:add_click},
			{iconCls:'edit',text:'<%=res.get("BUT.EDIT")%>',handler:update_click},
			{iconCls:'remove',text:'<%=res.get("BUT.REMOVE")%>',handler:remove_click},
				{iconCls:'undo',text:'<%=res.get("BUT_BACK")%>',handler:back_click}
			]
	</next:ExtendConfig>
	<next:Columns>
		<next:RowNumberColumn width="30"/>
		<next:CheckBoxColumn></next:CheckBoxColumn>
		<next:Column id="roleName" header='<%=res.get("ROLE.NAME")%>' field="roleName" width="200">	
			<next:TextField allowBlank="false" />
		</next:Column>
	</next:Columns>

</next:GridPanel>
</next:AnchorLayout>
</next:ViewPort>
</body>
</html>