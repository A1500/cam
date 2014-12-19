<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils" %>
<%@ include file="/jsp/public/resources_jspdir.jsp" %>
<%


%>
<next:ScriptManager/>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title></title>
<script type="text/javascript">
function pure(value) {
	var v = value;
	if 	(value === 'null' || value === undefined || value === "") {
		v = null;
	}
	return v;
}


//设置返回值的形式：字符串或者数据，默认情况为字符串形式；如果returnValueType=“array”时，返回一维数组形式；否则返回字符串形式
var returnValueType='<%=request.getParameter("returnValueType")%>';
</script>
<script type="text/javascript" src="select_only_role.js"></script>
</head>
<body>
<next:Panel title='<%=res.get("TREE.TITLE")%>' collapsible="true"  anchor="100% 100%" border="false" >
	<next:Html>
 		<next:Tree id="roletree" autoHeight="true" width="90%" bodyBorder="2" autoScroll="true" lines="true" >
			<next:TreeDataSet dataset="stru" root="rootdata">
				<next:TreeLoader cmd="org.loushang.bsp.permit.pap.role.cmd.RoleQueryCommand" method="queryRole" trigger="roleLoaderTrigger">
					<next:treeRecord name="roleRecord" idField="roleId">
						<model:field name="roleId" type="string"/>
						<model:field name="roleName" type="string"/>
						<model:field name="relationId" type="string"/>
						<model:field name="organName" type="string"/>
						<model:field name="roleGroupId" type="string"/>
						<model:field name="roleGroupName" type="string"/>
						<model:field name="discription" type="string"/>
					</next:treeRecord>
				</next:TreeLoader>
			</next:TreeDataSet>
			<next:TreeNodemodel recordType="roleRecord">
				<next:TreeNodeAttribute name="text" mapping="roleName"></next:TreeNodeAttribute>
				<next:TreeNodeAttribute name="icon" handler="getIcon" ></next:TreeNodeAttribute>
				<next:TreeNodeAttribute name="showType" handler="getChoiceBox"></next:TreeNodeAttribute>
				<next:TreeNodeAttribute name="leaf" handler="true"></next:TreeNodeAttribute>
			</next:TreeNodemodel>
		</next:Tree>
	</next:Html>
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="yes" text="确定" handler="confirmValue" />
		<next:ToolBarItem  iconCls="no" text="关闭" handler="closeDig" />
	</next:TopBar>
</next:Panel>
</body>

</html>