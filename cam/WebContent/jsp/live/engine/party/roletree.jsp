<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="roletree.js"></script>
</head>
<body>
<model:datasets>
   	<model:dataset id="queryRole">
   		<model:record including="roleId,roleName">
	   		<model:field name="roleId" type="string"/>
	   		<model:field name="roleName" type="string"/>
   		</model:record>
   	</model:dataset>
</model:datasets>

<next:ViewPort>
<!-- 使用左右布局 -->
<next:BorderLayout>
	<next:Left  cmargins="5 0 0 0 0 " margins="5 0 0 0" split="true" floatable="true">
<!--角色树start-->
<next:Panel id="roleTitle" collapsible="false" width="250" height="100%" autoScroll="true">
	<next:Tree id="roletree"  width="100%"   border="false" lines="true" allowCheck="false" rootExpanded="true">
		<next:TreeDataSet dataset="rolestru" root="rootdatab">
			<next:TreeLoader cmd="org.loushang.live.contact.contactlist.search.queryparty.cmd.PartyQueryCmd"  method="getUserRoleTreeRoot" trigger="struLoaderTriggerb">
				<next:treeRecord name="struRecord" idField="struId" fromBean="org.loushang.bsp.share.organization.bean.StruView"/>
				<next:TreeBaseparam name="parentId" value="getStruParentb"></next:TreeBaseparam>
				<next:TreeBaseparam name="struId" value="getStruIdb"></next:TreeBaseparam>
				<next:TreeBaseparam name="struType" value="getStruTypeb"></next:TreeBaseparam>
				<next:TreeBaseparam name="struTypeId" value="getStruTypeIdb"></next:TreeBaseparam>
			</next:TreeLoader>
			<next:TreeLoader cmd="org.loushang.live.contact.contactlist.search.queryparty.cmd.PartyQueryCmd" method="queryRoleByOrgan" trigger="roleLoaderTriggerb">
				<next:treeRecord name="roleRecord" idField="roleId">
					<model:field name="roleId" type="string"/>
					<model:field name="roleName" type="string"/>
					<model:field name="relationId" type="string"/>
					<model:field name="organName" type="string"/>
					<model:field name="roleGroupId" type="string"/>
					<model:field name="roleGroupName" type="string"/>
					<model:field name="discription" type="string"/>
				</next:treeRecord>
				<next:TreeBaseparam name="nodeType" value="getNodeTypeb"></next:TreeBaseparam>
				<next:TreeBaseparam name="RELATION_ID@=" value="getStruIdb"></next:TreeBaseparam>
			</next:TreeLoader>
		</next:TreeDataSet>
		<next:TreeNodemodel recordType="struRecord">
			<next:TreeNodeAttribute name="text" mapping="organName"></next:TreeNodeAttribute>
			<next:TreeNodeAttribute name="disabled" handler="getStrudisabledb"></next:TreeNodeAttribute>
			<next:TreeNodeAttribute name="icon" handler="getIconb" ></next:TreeNodeAttribute>
			<next:TreeNodeAttribute name="struPath" mapping="struId"></next:TreeNodeAttribute>
			<next:Listeners>
				<next:Listener eventName="selected" handler="selectedStruNodeb"></next:Listener>
			</next:Listeners>
		</next:TreeNodemodel>
		<next:TreeNodemodel recordType="roleRecord">
			<next:TreeNodeAttribute name="text" mapping="roleName"></next:TreeNodeAttribute>
			<next:TreeNodeAttribute name="icon" handler="getIconb" ></next:TreeNodeAttribute>
			<next:TreeNodeAttribute name="leaf" handler="true"></next:TreeNodeAttribute>
			<next:TreeNodeAttribute name="showType" handler="checkbox"></next:TreeNodeAttribute>		
			<next:Listeners>
				<next:Listener eventName="selected" handler="selectedNodeb"></next:Listener>
			</next:Listeners>
		</next:TreeNodemodel>
	</next:Tree>
</next:Panel>
</next:Left>
<!--角色树end-->

<!--角色grid start-->
<next:Center floatable="true" margins="5 0 0 0">
<next:EditGridPanel id="roleGridPanel" name="roleCategoryGrid"   height="100%" dataset="queryRole" frame="true" autoScroll="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="select"  text='确定' handler="Evt_addrole_click"/>
		<next:ToolBarItem iconCls="delete"  text='关闭' handler="Evt_addundo_click"/>
	</next:TopBar>
	 <next:Columns>
		<next:RowNumberColumn width="30"/>
		<next:Column  header='角色代码' field="roleId" hidden="true">
		</next:Column>
		<next:Column  header='角色名称' editable="false" field="roleName"  width="150">
			<next:TextField allowBlank="false" blankText="true"/>
		</next:Column>																	
	</next:Columns>
</next:EditGridPanel>
<!--角色grid end-->
</next:Center>
</next:BorderLayout>
</next:ViewPort>
</body>
</html>