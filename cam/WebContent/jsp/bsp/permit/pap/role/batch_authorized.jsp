<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<next:ScriptManager/>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>批量授权</title>
<script type="text/javascript">
	var struTypeId='<%=request.getParameter("struTypeId")%>';
	var roleId='<%=request.getParameter("roleId")%>';
	var organId='<%=request.getParameter("organId")%>';
</script>
<script type="text/javascript" src="batch_authorized.js"></script>
</head>
<body>
<model:datasets>
	<model:dataset id="authorizedDataSet"  global="true" >
		<model:record fromBean="org.loushang.bsp.permit.pap.user.data.User">
			<model:field name="userId" type="string"/>
		</model:record>
	</model:dataset>
</model:datasets>
<next:Panel   anchor="100% 100%" border="false" width="100%" height="500" >
<next:TopBar>
	<next:ToolBarItem symbol="->"></next:ToolBarItem>
	<next:ToolBarItem iconCls="save" text="确定" handler="confirmValue" />
	<next:ToolBarItem iconCls="no"  text="关闭" handler="closeDig" />
</next:TopBar>
<next:ColumnLayout>
<next:Panel   border="true" width = "55%" columnWidth=".55" height="100%">
<next:Tree id="usertree" height="100%" width="100%" bodyBorder="2" autoScroll="true" lines="true" >
		<next:TreeDataSet dataset="stru" root="rootdata">
			<next:TreeLoader cmd="org.loushang.bsp.organization.cmd.StruQueryCommand"  method="getUserRoleTreeRoot" trigger="struLoaderTrigger">
				<next:treeRecord name="struRecord" idField="struId" fromBean="org.loushang.bsp.share.organization.bean.StruView"/>
				<next:TreeBaseparam name="parentId" value="getStruParent"></next:TreeBaseparam>
				<next:TreeBaseparam name="struId" value="getStruId"></next:TreeBaseparam>
				<next:TreeBaseparam name="struType" value="getStruType"></next:TreeBaseparam>
				<next:TreeBaseparam name="struTypeId" value="getStruTypeId"></next:TreeBaseparam>
				<next:TreeBaseparam name="isUseDataPermit" value="true"></next:TreeBaseparam>
			</next:TreeLoader>
			<next:TreeLoader cmd="org.loushang.bsp.permit.pap.user.cmd.UserQueryCommand" trigger="userLoaderTrigger" method="queryUserByOrgan">
				<next:treeRecord name="userRecord" idField="userId" fromBean="org.loushang.bsp.permit.pap.user.data.User">
				</next:treeRecord>
				<next:TreeBaseparam name="nodeType" value="getNodeType"></next:TreeBaseparam>
				<next:TreeBaseparam name="organId" value="getOrganId"></next:TreeBaseparam>
			</next:TreeLoader>
		</next:TreeDataSet>
		<next:TreeNodemodel recordType="struRecord">
			<next:TreeNodeAttribute name="text" mapping="organName"></next:TreeNodeAttribute>
			<next:TreeNodeAttribute name="icon" handler="getIcon" ></next:TreeNodeAttribute>
			<next:TreeNodeAttribute name="struPath" mapping="struId"></next:TreeNodeAttribute>
		</next:TreeNodemodel>
		<next:TreeNodemodel recordType="userRecord">
			<next:TreeNodeAttribute name="text" mapping="userId"></next:TreeNodeAttribute>
			<next:TreeNodeAttribute name="icon" handler="getIcon" ></next:TreeNodeAttribute>
			<next:TreeNodeAttribute name="showType" handler="getChoiceBox"></next:TreeNodeAttribute>
			<next:Listeners>
	   			<next:Listener eventName="checkchange" handler="checkedUserNode"></next:Listener>
			</next:Listeners>
		</next:TreeNodemodel>
	</next:Tree>
</next:Panel>
<next:Panel   border="false" width = "10%" columnWidth=".10" height="100%">
	<next:Html>
		<table style="width:100%">
			<tr>
		    <td height="80">
		    </td></tr>
			<tr><td>
			&nbsp;<input type="button" value="右移" onclick="right()">
			</td></tr>
			<tr>
		    <td height="20">
		    </td></tr>
			<tr><td>
			&nbsp;<input type="button" value="左移" onclick="left()">
			</td></tr>
		</table>
	</next:Html>
</next:Panel>
<next:Panel  border="true" width = "35%" columnWidth=".35" height="100%">
<next:EditGridPanel id="authorizedGrid" name="authorizedGrid" height="100%" dataset="authorizedDataSet">
	<next:Columns>
	    <next:CheckBoxColumn></next:CheckBoxColumn>
		<next:Column id="userId" header="授权用户" field="userId"   width ="100" editable="false">
			<next:TextField allowBlank="false" />
		</next:Column>
	</next:Columns>
</next:EditGridPanel>
</next:Panel>
</next:ColumnLayout>
</next:Panel>
</body>
</html>