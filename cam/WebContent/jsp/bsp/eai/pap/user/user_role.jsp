<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ include file="/jsp/public/resources_jspdir.jsp"%>
<html>
<next:ScriptManager/>
<script type="text/javascript">
  var selectNodeId='<%=request.getParameter("userId")%>';
</script>
<head>
<title>用户映射查询</title>
<script type="text/javascript" src="user_role.js"></script>
<script type="text/javascript">
			var messType="确定";
			var messTypePrompt="提示";
			var saveNoDataMess="没有需要保存的数据!";
			var saveValidateMess='<%=res.get("ORGAN.Save.ValidateMess")%>';
			var saveValidateMessInputBigen='<%=res.get("ORGAN.Save.ValidateMessInputBigen")%>';
			var saveValidateMessInputEnd='<%=res.get("ORGAN.Save.ValidateMessInputEnd")%>';
			var saveSuccessMess="数据保存成功!";
			var deletePleaseSelectData="请选择要删除的记录！";
			var deleteSelectDataMess="你确定要删除吗？";
		</script>
</head>
<body>
<model:datasets>
	<model:dataset id="userDs"
		cmd="org.loushang.bsp.eai.pap.user.cmd.UserQueryCommand"
		method="queryUserByappUserId" global="true" pageSize="10">
		<model:record fromBean="org.loushang.bsp.eai.pap.user.data.UserView">
		  <model:field name="grantedRoles" type="string" />	
		  <model:field name="appName" type="string" />
		  <model:field name="appUserId" type="string" />
		</model:record>
	</model:dataset>
	<model:dataset id="ableRolesDs" pageSize="-1"
		cmd="org.loushang.bsp.eai.pap.user.cmd.UserQueryCommand"
		method="getUserAbleRoles">
		<model:record fromBean="org.loushang.bsp.eai.pap.role.data.Role">
		<model:field name="roleInfo" type="string" />	
		</model:record>
	</model:dataset>
	<model:dataset id="assignedRoleDs" global="true"
	cmd="org.loushang.bsp.eai.pap.user.cmd.UserQueryCommand"
		method="getUserAssignedRoles">
		<model:record fromBean="org.loushang.bsp.eai.pap.role.data.Role">
		<model:field name="roleInfo" type="string" />
		</model:record>
	</model:dataset>
</model:datasets>
<next:ViewPort id="cards">
	<next:CardLayout>
		<next:EditGridPanel id="userGrid" stripeRows="true"
				dataset="userDs" height="100%" autoScroll="true" width="100%">
			<next:ExtendConfig>
						tbar:[
						{text: '映射用户',id: 'query_name_label' },
                    	{xtype: 'textfield',id: 'appUserId',style:'width:90px;'},
                    	{iconCls:'query',text:'查询',handler:query},
                    	'->',
						{iconCls:'edit',text:'角色分配',handler:assignedRole}
						]
			</next:ExtendConfig>
			<next:Columns>
				<next:RowNumberColumn width="30" />
				<next:RadioBoxColumn></next:RadioBoxColumn>
				<next:Column header="用户ID" field="userId" width="120">
					<next:TextField allowBlank="false" editable="false" />
				</next:Column>
				<next:Column header="用户名称" field="userName" width="120">
					<next:TextField editable="false" />
				</next:Column>
				<next:Column header="映射用户" field="appUserId" width="120">
				<next:TextField editable="false" />
				</next:Column>
				<next:Column header="应用名" field="appName" width="120">
				<next:TextField editable="false" />
		       </next:Column>
				<next:Column header="所属部门" field="departmentName" width="120">
					<next:TextField editable="false" />
				</next:Column>
				<next:Column header="所属单位" field="corporationName" width="150">
					<next:TextField editable="false" />
				</next:Column>
				<next:Column header="" field="grantedRoles" width="240" hidden="true">
					<next:TextField editable="false" disabled="disabled"/>
				</next:Column>
			</next:Columns>
			<next:BottomBar>
				<next:PagingToolBar dataset="userDs"></next:PagingToolBar>
			</next:BottomBar>
		</next:EditGridPanel>
		<next:Panel id="rolePanel"  height="100%"  width="100%" autoScroll="true">
				<next:ExtendConfig>
						tbar:[
                    	'->',
                    	{iconCls:'save',text:'保存',handler:save},
						{iconCls:'undo',text:'返回',handler:back2list}
						]
				</next:ExtendConfig>
				<next:Panel id="roleEditPanel"  title='角色分配' >
				<next:TopBar>
				<next:ToolBarItem  text='未授予角色名称'/>
				<next:ToolBarItem  xtype="textfield" id="roleName" />
				<next:ToolBarItem text='查询' iconCls="query" handler="queryRole" />
				<next:ToolBarItem text='置空' iconCls="undo" handler="undo" />
			    </next:TopBar>
					<next:Html>
					    <form onsubmit="return false" dataset="userDs" class="L5form">
						<input type="hidden" systype="itemselector" id="grantRolecmp"
							field="grantedRoles">
						<div id="grantRoleDiv" align="center" ></div>
					</next:Html>
			   </next:Panel>
		</next:Panel>
	</next:CardLayout>
</next:ViewPort>
</body>
</html>
