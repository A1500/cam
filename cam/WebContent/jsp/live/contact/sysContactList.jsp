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
	<model:dataset id="userDataSet" pageSize="10" cmd="org.loushang.live.contact.contactlist.cmd.ContactListQueryCmd"
		method="queryContactList">
		<model:record
			fromBean="org.loushang.live.contact.privacy.data.User">
		</model:record>
	</model:dataset>
	<model:dataset id="userDataSetForUserInfo" pageSize="10" cmd="org.loushang.live.contact.contactlist.cmd.ContactListQueryCmd"
		method="getOtherUserInfo">
		<model:record
			fromBean="org.loushang.live.contact.privacy.data.User">
		</model:record>
	</model:dataset>
	<model:dataset id="contactAddrDs"
		cmd="org.loushang.live.contact.contactlist.cmd.ContactListQueryCmd" method="getOtherUserContactAddr"
		pageSize="10">
		<model:record
			fromBean="org.loushang.live.contact.privacy.data.ContactAddr">
		</model:record>
	</model:dataset>
	<model:dataset id="deliveryModeDs" cmd="org.loushang.live.contact.contactlist.cmd.ContactListQueryCmd" method="getDeliveryMode"  global="true"  autoLoad="true" >
		<model:record fromBean="org.loushang.live.common.deliverymode.DeliveryMode">
		</model:record>
	</model:dataset>
	<model:dataset id="groupDataSet" cmd="org.loushang.live.contact.contactlist.cmd.ContactListQueryCmd" method="querySysContGroup">
		<model:record
			fromBean="org.loushang.live.contact.contactlist.data.Group">
		</model:record>
	</model:dataset>
</model:datasets>
<next:ViewPort>
<!-- 使用左右布局 -->
<next:BorderLayout>
	<next:Left  cmargins="5 0 0 0 0 " margins="5 0 0 0" split="true" floatable="true">
	<next:Panel  id="leftPanel" collapsible="true"  title="我的联系人"  autoScroll="true" width="20%" border="false">
	<!--使用Tree组件-->
	<next:Tree name="strutree" id="strutree" border="false" collapsible="false" lines="true" frame="false" rootVisible="false">	
		<!--定义树的数据模型-->
		  <next:TreeDataSet dataset="struTreeDataset" root="rootdata">
			<!--定义数据加载器，cmd属性表示从后台某个command中获取数据-->
				<next:TreeLoader
					cmd="org.loushang.live.contact.contactlist.cmd.ContactListQueryCmd" method="querySysContGroup" trigger="start_group_tree">
					<!--定义TreeRecord 树的每个节点的记录-->
					<next:treeRecord name="groupRecord" idField="groupId"
						fromBean="org.loushang.live.contact.contactlist.data.Group">
					</next:treeRecord>
					<!--向后台请求数据时可以传递参数，可以配置多个TreeBaseParam-->
					<next:TreeBaseparam name="sort" value="function(){return 'INDEX_NO';}" />
					<next:TreeBaseparam name="SYS_GROUP" value="getSysGroup" />
				</next:TreeLoader>
				<next:TreeLoader
					cmd="org.loushang.live.contact.contactlist.cmd.ContactListQueryCmd" method="querySysContactListTree" trigger="start_contact_tree" >
					<!--定义TreeRecord 树的每个节点的记录-->
					<next:treeRecord name="contactRecord" idField="memberId"
						fromBean="org.loushang.live.contact.contactlist.data.ContactList">
					</next:treeRecord>
					<!--向后台请求数据时可以传递参数，可以配置多个TreeBaseParam-->
					<next:TreeBaseparam name="GROUP_ID" value="getStruParent" />
					<next:TreeBaseparam name="online" value="changeOnlineDisplayState" />
				</next:TreeLoader>
			</next:TreeDataSet>
		<!--TreeNodemodel将后台数据映射到树形节点上，一个后台业务模型对应一个TreeNodeModel -->
		<next:TreeNodemodel recordType="groupRecord">
			<!--设置每一个业务字段与树节点属性之间的映射关系-->
			<next:TreeNodeAttribute  name="text" mapping="groupName">
			</next:TreeNodeAttribute>
			<next:TreeNodeAttribute name="icon" handler="getIcon"></next:TreeNodeAttribute>
			<!--定义树节点的右键菜单-->
			<next:RightmouseMenu menuId="corp">
				<next:MenuItem text="添加分组" handler="addGroup"></next:MenuItem>
				<next:MenuItem text="添加联系人" handler="query_other_users"></next:MenuItem>
				<next:MenuItem text="创建联系人" handler="show_create_contact_win"></next:MenuItem>
				<next:MenuItem text="重命名" handler="renameGroup"></next:MenuItem>
				<next:MenuItem text="删除该组" handler="delGroup"></next:MenuItem>
				<next:MenuItem text="上移分组" handler="upGroup"></next:MenuItem>
				<next:MenuItem text="下移分组" handler="downGroup"></next:MenuItem>
			</next:RightmouseMenu>
			<!--定义树节点的监听事件-->
			<next:Listeners>
				<next:Listener eventName="selected" handler="selectedStru">
			</next:Listener>
			</next:Listeners>
		</next:TreeNodemodel>
		<next:TreeNodemodel recordType="contactRecord">
			<!--设置每一个业务字段与树节点属性之间的映射关系-->
			<next:TreeNodeAttribute  name="text" mapping="nickName">
			</next:TreeNodeAttribute>
			<next:TreeNodeAttribute name="icon" handler="getIcon"></next:TreeNodeAttribute>
			<!--定义树节点的右键菜单-->
			<next:RightmouseMenu menuId="corp2" trigger="out_menu">
			</next:RightmouseMenu>
			<!--定义树节点的监听事件-->
			<next:Listeners>
				<next:Listener eventName="selected" handler="selectedStru">
			</next:Listener>
			</next:Listeners>
		</next:TreeNodemodel>
	</next:Tree>
	</next:Panel>
	</next:Left>
	<next:Center floatable="true" margins="5 0 0 0">
			<next:Panel width="100%">
					<next:Html>
						<iframe id="nodeFrame" name="nodeFrame" height="100%" width="100%">
						</iframe>
					</next:Html>
			</next:Panel>
	</next:Center>
</next:BorderLayout>
</next:ViewPort>
<next:Window id="query-users-win" title="查询联系人" resizable="false"
	width="380" height="370" closeAction="hide">
	<next:Html>
		<form id="queryForm" class="L5form">
		<fieldset style="width: 100%"><legend>查询条件</legend>
		<table width="100%">
			<tr>
				<td class="FieldLabel" width="30%"><label>账号:</label></td>
				<td class="FieldInput" width="70%"><input type="text"
					id="usersId" title="账号" style="width: 70%"/></td>
			</tr>
			<tr>
				<td class="FieldLabel" width="30%"><label>姓名:</label></td>
				<td class="FieldInput" width="70%"><input type="text"
					id="usersName" title="姓名" style="width: 70%"/></td>
			</tr>
			<tr>
				<td class="FieldButton" align="center" colspan="2">
					<button onclick="query()">查询</button>&nbsp;&nbsp;
					<button onclick="reset()">重置</button>&nbsp;&nbsp;					
					<button onclick="exit()">取消</button>
				</td>
			</tr>
		</table>
		</fieldset>
		</form>
	</next:Html>
</next:Window>	
<next:Window id="display-users-win" title="联系人列表" resizable="false"
	width="380" height="370" closeAction="hide">
	<next:GridPanel id="userGrid" name="userGrid" width="100%"
		stripeRows="true" height="275" dataset="userDataSet">
		<next:TopBar>
			<next:ToolBarItem text="以下是您查找到的信息:"></next:ToolBarItem>
		</next:TopBar>

		<next:Columns>
			<next:RowNumberColumn />
			<next:RadioBoxColumn></next:RadioBoxColumn>
			<next:Column header="账号" field="userId" width="160">
				<next:TextField />
			</next:Column>
			<next:Column header="姓名" field="userName" width="160">
				<next:TextField />
			</next:Column>
		</next:Columns>

		<next:BottomBar>
			<next:PagingToolBar dataset="userDataSet" />
		</next:BottomBar>
	</next:GridPanel>
	
	<next:Panel id="userpanel" name="userpanel" width="100%" height="50">
		<next:TopBar>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem iconCls="common-query" text="详细信息"
				handler="Evt_queryinfo_click"></next:ToolBarItem>
		</next:TopBar>
	</next:Panel>
	<next:Buttons>
		<next:ToolButton text="上一步" handler="Evt_butback_click"></next:ToolButton>
		<next:ToolButton text="加为好友" handler="Evt_butaddfriend_click"></next:ToolButton>
		<next:ToolButton text="关闭" handler="Evt_butclose_click"></next:ToolButton>
	</next:Buttons>
</next:Window>
<next:Window id="query-userinfo-win" title="详细信息" resizable="false"
	width="380" height="370" closeAction="hide">
	<next:Panel>
		<next:Html>
			<form id="getInfo" class="L5form" dataset="userDataSet">
			<fieldset style="width: 100%"><legend>个人信息</legend>
			<table width="100%">
				<tr>
					<td class="FieldLabel"><label>账号:</label></td>
					<td class="FieldLabel"><input type="text" field="userId"
						name="userId" class="TextEditor" disabled="disabled" /></td>
					<td class="FieldLabel"><label>姓名:</label></td>
					<td class="FieldLabel"><input type="text" field="userName"
						name="userName" class="TextEditor" disabled="disabled" /></td>
				</tr>
				<tr>
					<td class="FieldLabel"><label>性别:</label></td>
					<td class="FieldLabel"><input type="text" field="gender"
						name="gender" class="TextEditor" disabled="disabled" /></td>
					<td class="FieldLabel"><label>生日:</label></td>
					<td class="FieldLabel"><input type="text" field="birthday"
						name="birthdy" class="TextEditor" disabled="disabled" /></td>
				</tr>
			</table>
			</fieldset>
			</form>
		</next:Html>
	</next:Panel>
	<next:GridPanel id="contactAddrGrid" name="addrGrid" width="100%"
		hidden="false" height="200" dataset="contactAddrDs">
		<next:TopBar>
			<next:ToolBarItem text="联系方式"></next:ToolBarItem>
		</next:TopBar>
		<next:Columns>
			<next:RowNumberColumn />
			<next:Column hidden="true" field="addrId" header="联系方式编号">
				<next:TextField />
			</next:Column>
			<next:Column header="联系方式" field="deliveryMode" width="100" align="center" renderer="changeDisplay">
				<next:TextField ></next:TextField>
			</next:Column>
			<next:Column header="联系地址" field="deliveryAddr" width="160" align="center">
				<next:TextField allowBlank="false" />
			</next:Column>		
		</next:Columns>
	</next:GridPanel>
	<next:Buttons>
		<next:ToolButton text="加为好友" handler="Evt_butaddfriend2_click"></next:ToolButton>
		<next:ToolButton text="关闭" handler="Evt_butclose2_click"></next:ToolButton>
	</next:Buttons>
</next:Window>
<next:Window id="create_contact_win" title="创建联系人" resizable="false"
	width="380" height="370" closeAction="hide">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="save" text='保存' handler="creat_contact" />
		<next:ToolBarItem iconCls="undo" text='取消' handler="exit_create_contact_win" />
	</next:TopBar>
	<next:Panel width="100%">
	<next:Html>
		<form id="queryForm" class="L5form">
		<fieldset style="width: 100%"><legend>请输入要创建的联系人信息</legend>
		<table width="100%">
			<tr>
				<td class="FieldLabel" width="30%"><label>姓名(名称):</label></td>
				<td class="FieldInput" width="70%"><input type="text"
					id="name" title="姓名(名称)" /></td>
			</tr>
			<tr>
				<td class="FieldLabel" width="30%"><label>昵称:</label></td>
				<td class="FieldInput" width="70%"><input type="text"
					id="nickName" title="昵称" /></td>
			</tr>
		</table>
		</fieldset>
		</form>
	</next:Html>
	</next:Panel>
	<next:EditGridPanel id="contactAddrGrid" name="addrGrid" width="100%" stripeRows="true"
		hidden="false" height="215" dataset="deliveryModeDs">	
		<next:TopBar>
			<next:ToolBarItem text="联系方式"></next:ToolBarItem>
		</next:TopBar>	
		<next:Columns>
			<next:RowNumberColumn width="25"/>
			<next:Column hidden="true" field="addrId" header="联系方式编号">
				<next:TextField />
			</next:Column>
			<next:Column header="联系方式"  field="deliveryName" width="100" align="center">
				<next:TextField editable="false"></next:TextField>
			</next:Column>
			<next:Column header="联系地址" field="deliveryMode" width="235"
				align="center" id="address">
				<next:TextField allowBlank="false" />
			</next:Column>
		</next:Columns>
	</next:EditGridPanel>
</next:Window>
</body>
</html>
