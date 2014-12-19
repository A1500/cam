<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils" %>
<%@ include file="/jsp/public/resources_jspdir.jsp" %>

<next:ScriptManager/>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title></title>
<script type="text/javascript">
	var _struId='<%=request.getParameter("struId")%>';
	var _includeRoleInSubStru = '<%=request.getParameter("includeRoleInSubStru")%>';
	_includeRoleInSubStru = _includeRoleInSubStru === 'true'?true:false;
</script>
<script type="text/javascript" src="select_role_list.js"></script>
</head>
<body>
<model:datasets>
	<model:dataset id="roleDataset" pageSize="-1" global="true" 
		cmd="org.loushang.bsp.permit.pap.role.cmd.RoleQueryCommand" method="queryRole">
		<model:record fromBean="org.loushang.bsp.permit.pap.role.data.Role"></model:record>
	</model:dataset>
</model:datasets>
<next:ViewPort>
<next:Panel title='<%=res.get("TREE.TITLE")%>'    border="false" >
	 <next:GridPanel id="rolePanel" dataset="roleDataset" width="100%" height="100%">
	 <next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="yes" text="确定" handler="confirmValue" />
		<next:ToolBarItem  iconCls="no" text="关闭" handler="closeDig" />
	</next:TopBar>
	 	<next:Columns>
	 		<next:NumberField> </next:NumberField>
	 		<next:CheckBoxColumn></next:CheckBoxColumn>
	 		<next:Column header='<%=res.get("PUB_ROLE.ROLE_NAME")%>' field="roleName" width="200"></next:Column>
	 		<next:Column header='<%=res.get("PUB_ROLE.RELATION_ID")%>' field="relationId"
	 		 renderer="relationName" width="200"
	 		 ></next:Column>
	 	</next:Columns>
	 	<next:BottomBar>
	 		<next:PagingToolBar dataset="roleDataset"></next:PagingToolBar>
	 	</next:BottomBar>
	 </next:GridPanel>
	
</next:Panel>
</next:ViewPort>
</body>
</html>