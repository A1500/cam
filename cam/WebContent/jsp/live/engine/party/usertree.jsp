<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>

<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="usertree.js"></script>
</head>
<body>
<model:datasets>
	<model:dataset id="queryDepart">
		<model:record including="struId,organName,organType">
			<model:field name="struId" type="string" />
			<model:field name="organName" type="string" />
			<model:field name="organType" type="string" />
		</model:record>
	</model:dataset>
</model:datasets>
<next:ViewPort>
<!-- 使用左右布局 -->
<next:BorderLayout>
	<next:Left  cmargins="5 0 0 0 0 " margins="5 0 0 0" split="true" floatable="true">
		<next:Panel id="departmentTitle" width="250" height="100%"
			frame="false" autoScroll="true">
				<next:Tree id="departtree" width="100%" border="false" lines="true"
					allowCheck="true" rootExpanded="true">
					<next:TreeDataSet dataset="departstru" root="rootdataa">
						<next:TreeLoader
							cmd="org.loushang.live.contact.contactlist.search.queryparty.cmd.PartyQueryCmd"
							method="getUserRoleTreeRoot" trigger="struLoaderTriggera">
							<next:treeRecord name="struRecord" idField="struId"
								fromBean="org.loushang.bsp.share.organization.bean.StruView" />
							<next:TreeBaseparam name="parentId" value="getStruParenta"></next:TreeBaseparam>
							<next:TreeBaseparam name="struId" value="getStruIda"></next:TreeBaseparam>
							<next:TreeBaseparam name="struType" value="getStruTypea"></next:TreeBaseparam>
							<next:TreeBaseparam name="struTypeId" value="getStruTypeIda"></next:TreeBaseparam>
						</next:TreeLoader>
						<next:TreeLoader
							cmd="org.loushang.live.contact.contactlist.search.queryparty.cmd.PartyQueryCmd"
							trigger="userLoaderTriggera" method="queryParty">
							<next:treeRecord name="userRecord" idField="userId"
								fromBean="org.loushang.bsp.permit.pap.user.data.User">
							</next:treeRecord>
							<next:TreeBaseparam name="nodeType" value="getNodeTypea"></next:TreeBaseparam>
							<next:TreeBaseparam name="organId" value="getOrganIda"></next:TreeBaseparam>
							<next:TreeBaseparam name="struId" value="getStruIda"></next:TreeBaseparam>
						</next:TreeLoader>
					</next:TreeDataSet>

					<next:TreeNodemodel recordType="struRecord">
						<next:TreeNodeAttribute name="text" handler="userName"></next:TreeNodeAttribute>
						<next:TreeNodeAttribute name="disabled" handler="getStrudisableda"></next:TreeNodeAttribute>
						<next:TreeNodeAttribute name="icon" handler="getIcona"></next:TreeNodeAttribute>
						<next:TreeNodeAttribute name="struPath" mapping="struId"></next:TreeNodeAttribute>
						<next:TreeNodeAttribute name="showType" handler="checkbox"></next:TreeNodeAttribute>
						<next:TreeNodeAttribute name="changeParent" value="false"></next:TreeNodeAttribute>	
						<next:Listeners>
							<next:Listener eventName="selected" handler="selectedStruNodea"></next:Listener>
						</next:Listeners>
					</next:TreeNodemodel>

					<next:TreeNodemodel recordType="userRecord">
						<next:TreeNodeAttribute name="text" handler="userName"></next:TreeNodeAttribute>
						<next:TreeNodeAttribute name="icon" handler="getIcona"></next:TreeNodeAttribute>
						<next:TreeNodeAttribute name="showType" handler="checkbox"></next:TreeNodeAttribute>
						<next:TreeNodeAttribute name="leaf" handler="true"></next:TreeNodeAttribute>
						<next:TreeNodeAttribute name="changeParent" value="false"></next:TreeNodeAttribute>	
						<next:Listeners>
							<next:Listener eventName="selected" handler="selectedNodea"></next:Listener>
						</next:Listeners>
					</next:TreeNodemodel>
				</next:Tree>
		</next:Panel>
	</next:Left>
	<next:Center floatable="true" margins="5 0 0 0">
		<next:EditGridPanel id="departGridPanel" name="departCategoryGrid"
			height="100%" dataset="queryDepart" frame="true">
			<next:TopBar>
				<next:ToolBarItem symbol="->"></next:ToolBarItem>
				<next:ToolBarItem iconCls="select" text='确定'
					handler="Evt_adduser_click"></next:ToolBarItem>
				<next:ToolBarItem iconCls="delete" text='关闭'
					handler="Evt_adduser_cancel"></next:ToolBarItem>
			</next:TopBar>
			<next:Columns>
				<next:RowNumberColumn></next:RowNumberColumn>
				<next:Column header='代码' field="struId" hidden="true" />
				<next:Column header='名称' field="organName" editable="false"
					width="150">
					<next:TextField allowBlank="false" />
				</next:Column>
				<next:Column header='类型' field="organType" hidden="true" />
			</next:Columns>
		</next:EditGridPanel>
	</next:Center>
	</next:BorderLayout>
	</next:ViewPort>
</body>
</html>