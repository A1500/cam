<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ include file="/jsp/public/resources_jspdir.jsp"%>
<html>
<next:ScriptManager/>
<script type="text/javascript">
  var userId='<%=request.getParameter("userId")%>';
</script>
<head>
<title>用户映射查询</title>
<script type="text/javascript" src="role_assigned.js"></script>
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
	<model:dataset id="ableRolesDs" pageSize="-1" global="true"
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
				<next:ToolBarItem text='查询' iconCls="query" handler="query" />
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
</body>
</html>
