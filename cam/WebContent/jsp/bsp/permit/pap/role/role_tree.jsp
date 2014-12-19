<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ include file="/jsp/public/resources_jspdir.jsp" %>

<next:ScriptManager/>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title></title>
<script type="text/javascript">
	var struTypeId='<%=request.getParameter("struTypeId")%>';
</script>
<script type="text/javascript" src="role_tree.js"></script>
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
<next:ViewPort>
<next:BorderLayout>
	<next:Left split="true" cmargins="5 0 0 0" margins="5 0 0 0" >
		<next:Panel title='<%=res.get("TREE.TITLE")%>' collapsible="true" height="100%" autoScroll="true" width="20%" >
			<next:Html>
	   			<next:Tree id="roletree"  width="100%"   border="false" lines="true" >
					<next:TreeDataSet dataset="stru" root="rootdata">
						<next:TreeLoader cmd="org.loushang.bsp.organization.cmd.StruQueryCommand"  method="getUserRoleTreeRoot" trigger="struLoaderTrigger">
							<next:treeRecord name="struRecord" idField="struId" fromBean="org.loushang.bsp.share.organization.bean.StruView"/>
							<next:TreeBaseparam name="parentId" value="getStruParent"></next:TreeBaseparam>
							<next:TreeBaseparam name="struId" value="getStruId"></next:TreeBaseparam>
							<next:TreeBaseparam name="struType" value="getStruType"></next:TreeBaseparam>
							<next:TreeBaseparam name="struTypeId" value="getStruTypeId"></next:TreeBaseparam>
							<next:TreeBaseparam name="isUseDataPermit" value="true"></next:TreeBaseparam>
						</next:TreeLoader>
						<next:TreeLoader cmd="org.loushang.bsp.permit.pap.rolegroup.cmd.RoleGroupQueryCmd" method="queryfortree" trigger="roleGroupLoaderTrigger">
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
						<next:RightmouseMenu menuId="menuId1" trigger="istRoot">
							<next:MenuItem text='<%=res.get("ROLE.ADD_ROLE")%>' handler="addRole"></next:MenuItem>
						</next:RightmouseMenu>
						<next:Listeners>
							<next:Listener eventName="selected" handler="selectedStruNode"></next:Listener>
						</next:Listeners>
					</next:TreeNodemodel>
					<next:TreeNodemodel recordType="roleGroupRecord">
						<next:TreeNodeAttribute name="text" mapping="roleGroupName"></next:TreeNodeAttribute>
						<next:TreeNodeAttribute name="icon" handler="getIcon" ></next:TreeNodeAttribute>
					</next:TreeNodemodel>
					<next:TreeNodemodel recordType="roleRecord">
						<next:TreeNodeAttribute name="text" mapping="roleName"></next:TreeNodeAttribute>
						<next:TreeNodeAttribute name="icon" handler="getIcon" ></next:TreeNodeAttribute>
						<next:TreeNodeAttribute name="leaf" handler="true"></next:TreeNodeAttribute>
						<next:TreeNodeAttribute name="href" handler="'#'"></next:TreeNodeAttribute>
						<next:RightmouseMenu menuId="roleMenu" trigger="isStruRole">
							<next:MenuItem text='<%=res.get("ROLE.DEL_ROLE")%>' handler="delRole"></next:MenuItem>
							<next:MenuItem text="批量授权" handler="batchAuthorized"></next:MenuItem>
						</next:RightmouseMenu>
						<next:Listeners>
							<next:Listener eventName="selected" handler="selectedNode"></next:Listener>
						</next:Listeners>
					</next:TreeNodemodel>
				</next:Tree>
			</next:Html>
		</next:Panel>
	 </next:Left>
	 <next:Center floatable="true"  >
	 	<next:Panel autoScroll="true"  width="100%">
	 		<next:Html>
				<iframe id="nodeFrame" name="nodeFrame" width="100%" scrolling="yes" height="100%" >
				</iframe>
			</next:Html>
	 	</next:Panel>
	 </next:Center>
  </next:BorderLayout>
</next:ViewPort>
</body>
</html>