<%@ page contentType="text/html; charset=utf-8" %>
<!--导入Loushang5标签-->
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>系统联系人管理</title>
	<!--导入Loushang5公用的js文件-->
	<next:ScriptManager/>
<!--导入业务开发的js文件-->
<script type="text/javascript" src="sysContactList.js"></script>
</head>
<body>

<model:datasets>
	<model:dataset id="userDs">
	   	<model:record including="userId,userName,userType">
	   		<model:field name="userId" type="string"/>
	   		<model:field name="userName" type="string"/>
	   		<model:field name="userType" type="string"/>
	   	</model:record>
	</model:dataset>	   
</model:datasets>

<next:ViewPort>
<!-- 使用左右布局 -->
<next:BorderLayout>
	<next:Left  cmargins="5 0 0 0 0 " margins="5 0 0 0" split="true" floatable="true">
<next:Panel height="100%"  width="250">
	<next:Tree name="strutree" id="strutree" collapsible="false" width="250" height="100%" autoScroll="true" rootExpanded="true" allowCheck="true">
	<next:TreeDataSet dataset="struTreeDataset" root="rootdata">
		<next:TreeLoader cmd="org.loushang.live.contact.contactlist.cmd.ContactListQueryCmd" method="querySysContGroup" trigger="start_group_tree">
			<next:treeRecord name="groupRecord" idField="groupId" fromBean="org.loushang.live.contact.contactlist.data.Group"/>
			<next:TreeBaseparam name="sort" value="function(){return 'INDEX_NO';}" />
			<next:TreeBaseparam name="SYS_GROUP" value="getSysGroup" />
		</next:TreeLoader>
		<next:TreeLoader cmd="org.loushang.live.contact.contactlist.cmd.ContactListQueryCmd" method="querySysContactListTree" trigger="start_contact_tree" >
			<next:treeRecord name="contactRecord" idField="memberId" fromBean="org.loushang.live.contact.contactlist.data.ContactList"/>
			<next:TreeBaseparam name="GROUP_ID" value="getStruParent" />
			<next:TreeBaseparam name="online" value="changeOnlineDisplayState" />
		</next:TreeLoader>
	</next:TreeDataSet>
	<next:TreeNodemodel recordType="groupRecord">
		<next:TreeNodeAttribute  name="text" mapping="groupName"/>
		<next:TreeNodeAttribute name="icon" handler="getIcon"/>
		<next:TreeNodeAttribute name="showType" handler="checkbox"/>
		<next:TreeNodeAttribute name="changeParent" value="false"></next:TreeNodeAttribute>	
		<next:Listeners>
			<next:Listener eventName="selected" handler="selectedStru"/>
		</next:Listeners>
	</next:TreeNodemodel>
	<next:TreeNodemodel recordType="contactRecord">
		<next:TreeNodeAttribute  name="text" mapping="nickName"/>
		<next:TreeNodeAttribute name="icon" handler="getIcon"/>
		<next:TreeNodeAttribute name="showType" handler="checkbox"/>
		<next:TreeNodeAttribute name="changeParent" value="false"></next:TreeNodeAttribute>	
		<next:Listeners>
			<next:Listener eventName="selected" handler="selectedStru"/>
		</next:Listeners>
	</next:TreeNodemodel>
</next:Tree>
</next:Panel>
</next:Left>

<next:Center floatable="true" margins="5 0 0 0">	
<next:EditGridPanel id="userGridPanel" name="userGridPanel"  height="100%" dataset="userDs" frame="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="select" text='确定' handler="Evt_adduser_click"></next:ToolBarItem>
		<next:ToolBarItem iconCls="delete" text='关闭' handler="Evt_adduser_cancel"></next:ToolBarItem>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn></next:RowNumberColumn>
		<next:Column  header='代码' field="userId" hidden="true"/>
		<next:Column  header='联系人昵称' field="userName" editable="false" width="150">
			<next:TextField allowBlank="false" />
		</next:Column>	
		<next:Column  header='类型' field="userType" hidden="true"/>
	</next:Columns>
</next:EditGridPanel>
</next:Center>
</next:BorderLayout>
</next:ViewPort>
</body>
</html>
