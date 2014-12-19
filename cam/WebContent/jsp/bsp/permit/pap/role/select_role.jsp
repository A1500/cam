<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils" %>
<%@ include file="/jsp/public/resources_jspdir.jsp" %>
<%
 String showType = (String)request.getParameter("showType");
 if("grid".equals(showType)) {
	String query = request.getQueryString();
	response.sendRedirect("select_role_list.jsp?"+query);
 }

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
var struTypeId='<%=request.getParameter("struTypeId")%>';
struTypeId = pure(struTypeId);
var parentStruId = '<%=request.getParameter("struId")%>';
parentStruId = pure(parentStruId);
var expandAll = '<%=request.getParameter("expandAll")%>';
expandAll = pure(expandAll);
var nodeType = '<%=request.getParameter("nodeType")%>';
nodeType = pure(nodeType);
//设置返回值的形式：字符串或者数据，默认情况为字符串形式；如果returnValueType=“array”时，返回一维数组形式；否则返回字符串形式
var returnValueType='<%=request.getParameter("returnValueType")%>';
</script>
<script type="text/javascript" src="select_role.js"></script>
</head>
<body>
<model:datasets>
	<model:dataset id="struDataset" cmd="org.loushang.bsp.organization.cmd.StruQueryCommand" method="getUnderling" pageSize="-1" global="true">
		<model:record fromBean="org.loushang.bsp.share.organization.bean.StruView"></model:record>
	</model:dataset>
	<model:dataset id="roleGroupDataset" pageSize="-1">
		<model:record fromBean="org.loushang.bsp.permit.pap.rolegroup.data.RoleGroup"></model:record>
	</model:dataset>
	<model:dataset id="roleDataset" pageSize="-1">
		<model:record fromBean="org.loushang.bsp.permit.pap.role.data.Role"></model:record>
	</model:dataset>
</model:datasets>
<next:Panel title='<%=res.get("TREE.TITLE")%>' collapsible="true"  anchor="100% 100%" border="false" >
	<next:Html>
 		<next:Tree id="roletree" autoHeight="true" width="90%" bodyBorder="2" autoScroll="true" lines="true" >
			<next:TreeDataSet dataset="stru" root="rootdata">
				<next:TreeLoader cmd="org.loushang.bsp.organization.cmd.StruQueryCommand"  method="getUserRoleTreeRoot" trigger="struLoaderTrigger">
					<next:treeRecord name="struRecord" idField="struId" fromBean="org.loushang.bsp.share.organization.bean.StruView"/>
					<next:TreeBaseparam name="parentId" value="getStruParent"></next:TreeBaseparam>
					<next:TreeBaseparam name="struId" value="getStruId"></next:TreeBaseparam>
					<next:TreeBaseparam name="struType" value="getStruType"></next:TreeBaseparam>
					<next:TreeBaseparam name="isUseDataPermit" value='<%=request.getParameter("isUseDataPermit")%>'></next:TreeBaseparam>
				</next:TreeLoader>
				<next:TreeLoader cmd="org.loushang.bsp.permit.pap.rolegroup.cmd.RoleGroupQueryCmd" trigger="roleGroupLoaderTrigger">
					<next:treeRecord name="roleGroupRecord" fromBean="org.loushang.bsp.permit.pap.rolegroup.data.RoleGroup"></next:treeRecord>
					<next:TreeBaseparam name="CORPORATION@=" value="getStruId"></next:TreeBaseparam>
				</next:TreeLoader>
				<next:TreeLoader cmd="org.loushang.bsp.permit.pap.role.cmd.RoleQueryCommand" trigger="roleLoaderTrigger">
					<next:treeRecord name="roleRecord" idField="roleId">
						<model:field name="roleId" type="string"/>
						<model:field name="roleName" type="string"/>
						<model:field name="relationId" type="string"/>
						<model:field name="organName" type="string"/>
						<model:field name="roleGroupId" type="string"/>
						<model:field name="roleGroupName" type="string"/>
						<model:field name="discription" type="string"/>
					</next:treeRecord>
					<next:TreeBaseparam name="nodeType" value="getNodeType"></next:TreeBaseparam>
					<next:TreeBaseparam name="RELATION_ID@=" value="getStruId"></next:TreeBaseparam>
					<next:TreeBaseparam name="ROLE_GROUP_ID@=" value="getRoleGroupId"></next:TreeBaseparam>
				</next:TreeLoader>
			</next:TreeDataSet>
			<next:TreeNodemodel recordType="struRecord">
				<next:TreeNodeAttribute name="text" mapping="organName"></next:TreeNodeAttribute>
				<next:TreeNodeAttribute name="disabled" handler="getStrudisabled"></next:TreeNodeAttribute>
				<next:TreeNodeAttribute name="icon" handler="getIcon" ></next:TreeNodeAttribute>
				<next:TreeNodeAttribute name="struPath" mapping="struId"></next:TreeNodeAttribute>
			</next:TreeNodemodel>
			<next:TreeNodemodel recordType="roleGroupRecord">
				<next:TreeNodeAttribute name="text" mapping="roleGroupName"></next:TreeNodeAttribute>
				<next:TreeNodeAttribute name="icon" handler="getIcon" ></next:TreeNodeAttribute>
			</next:TreeNodemodel>
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