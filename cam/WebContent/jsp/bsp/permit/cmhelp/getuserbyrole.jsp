<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<next:ScriptManager/>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title></title>
<script type="text/javascript">
var struTypeId='<%=request.getParameter("struTypeId")%>';
//获取角色Id
var roleId ='<%=request.getParameter("roleId")%>';

var rootId ='<%=request.getParameter("rootId")%>';
//用来设置返回值的形式：默认情况为字符串，如果returnValueType=“array”,表示返回值为数组形式
var returnValueType='<%=request.getParameter("returnValueType")%>';

</script>
<script type="text/javascript" src="getuserbyrole.js"></script>
</head>
<body>
<next:Panel title='用户树' collapsible="true"  anchor="100% 100%" border="false" >
	<next:Html>
 		<next:Tree id="usertree" autoHeight="true" width="100%" bodyBorder="2" autoScroll="true" lines="true" >
			<next:TreeDataSet dataset="stru" root="rootdata">
				<next:TreeLoader cmd="org.loushang.bsp.organization.cmd.StruQueryCommand"  method="getUserRoleTreeRoot" trigger="struLoaderTrigger">
					<next:treeRecord name="struRecord" idField="struId" fromBean="org.loushang.bsp.share.organization.bean.StruView"/>
					<next:TreeBaseparam name="parentId" value="getStruParent"></next:TreeBaseparam>
					<next:TreeBaseparam name="struId" value="getStruId"></next:TreeBaseparam>
					<next:TreeBaseparam name="struType" value="getStruType"></next:TreeBaseparam>
				</next:TreeLoader>
				<next:TreeLoader cmd="org.loushang.bsp.permit.pap.user.cmd.UserQueryCommand" method="getUserByRoleId"  trigger="userLoaderTrigger">
					<next:treeRecord name="userRecord" idField="userId">
					     <model:field name="userId" type="string"/>
					       <model:field name="userName" type="string"/>
					        <model:field name="userEmployeeId" type="string"/>
					</next:treeRecord>
					<next:TreeBaseparam name="nodeType" value="getNodeType"></next:TreeBaseparam>
					<next:TreeBaseparam name="organId" value="getOrganId"></next:TreeBaseparam>
					<next:TreeBaseparam name="roleId" value="getRoleId"></next:TreeBaseparam>
				</next:TreeLoader>
			</next:TreeDataSet>
			<next:TreeNodemodel recordType="struRecord">
				<next:TreeNodeAttribute name="text" mapping="organName"></next:TreeNodeAttribute>
				<next:TreeNodeAttribute name="disabled" handler="getStrudisabled"></next:TreeNodeAttribute>
				<next:TreeNodeAttribute name="icon" handler="getIcon" ></next:TreeNodeAttribute>
			</next:TreeNodemodel>
			<next:TreeNodemodel recordType="userRecord">
				<next:TreeNodeAttribute name="text" mapping="userId"></next:TreeNodeAttribute>
				<next:TreeNodeAttribute name="showType" handler="getChoiceBox"></next:TreeNodeAttribute>
				<next:TreeNodeAttribute name="icon" handler="getIcon" ></next:TreeNodeAttribute>
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