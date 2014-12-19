<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="org.loushang.bsp.util.BspConfig"%>
<%@ include file="/jsp/public/resources_jspdir.jsp"%>
<%@page import="org.loushang.bsp.util.BspConstants"%>
<next:ScriptManager />

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title></title>
<script type="text/javascript">
</script>
<%
  String  ext_jsfile = BspConfig.getString("user_ext_jsfile_path");
  if(ext_jsfile==null||"".equals(ext_jsfile.trim()))
	  ext_jsfile = "../../../demo/userext/user_ext.js";
  String ext_dataset_file = BspConfig.getString("user_ext_dataset_file_path");
  if(ext_dataset_file==null)
	  ext_dataset_file="/jsp/bsp/demo/blank.jsp";
  String user_ext_jspfile=BspConfig.getString("user_ext_jspfile_path");
  if(user_ext_jspfile==null)
	  user_ext_jspfile="/jsp/bsp/demo/blank.jsp";
%>
<script type="text/javascript">
	var delwith = '<%=request.getParameter("delwith")%>';
	var queryEdit = '<%=request.getParameter("queryEdit")%>';
	var method = '<%=request.getParameter("method")%>';
	var idField='<%=request.getParameter("primeKey")%>';
		idField = decodeURIComponent(idField);
	var struId = '<%=request.getParameter("struId")%>';
		struId = decodeURIComponent(struId);
	var deptId = '<%=request.getParameter("deptId")%>';
		deptId = decodeURIComponent(deptId);
	var corpId = '<%=request.getParameter("corpId")%>';
		corpId = decodeURIComponent(corpId);
	var RES_PROMOT='<%=res.get("MSG.PROMOT")%>';
	var RES_UNKOWN_CMD='<%=res.get("MSG.UNKOWN_CMD")%>';
	var RES_SAVE='<%=res.get("MSG.SAVE")%>';
	var alert_pwd = '<%=res.get("PUB_USER.ALERT_PASSWORD_CONFORM")%>';
	var alert_not_null = '<%=res.get("PUB_USER.ALERT_NOT_NULL")%>';
	var PUB_USER_USERID = '<%=res.get("PUB_USER.USERID")%>';
	var PUB_USER_USERNAME = '<%=res.get("PUB_USER.USERNAME")%>';
	var PUB_USER_PASSWORD = '<%=res.get("PUB_USER.PASSWORD")%>';
	var PUB_USER_PASSWORDCONFIRM = '<%=res.get("PUB_USER.PASSWORDCONFIRM")%>';
	var caseSensitive = '<%=BspConstants.userId_Case_Sensitive%>';
</script>
<script type="text/javascript" src="user_edit.js"></script>
</head>
<body>
<div style="display: none"><xml id="datasetDiv"> <datasets>
<dataset id="userTypeDataSet" proxy="cmd" autoLoad="true"> <record>
<field name="value" mapping="userTypeCode" type="string" /> <field
	name="text" mapping="userTypeName" type="string" /> </record> <command>org.loushang.bsp.permit.pap.user.cmd.UserTypeQueryCmd</command>
</dataset> </datasets> </xml></div>
<model:datasets>
	<model:dataset id="userDataset" global="true">
		<model:record
			fromBean="org.loushang.bsp.eai.pap.user.data.UserView">
			<model:field name="passwordConfirm" type="string" />
			<model:field name="maxSessionNumber" mapping="maxSessionNumber"
				defaultValue="1" type="string" />
			<model:field name="accountStatus" mapping="accountStatus"
				defaultValue="11" type="string" />
			<model:field name="grantedRoles" type="string" />	
		</model:record>
	</model:dataset>
	
	<model:dataset id="ableRolesDs" pageSize="-1" global="true"
		cmd="org.loushang.bsp.eai.pap.user.cmd.UserQueryCommand"
		method="getUserAbleRoles" >
		<model:record fromBean="org.loushang.bsp.eai.pap.role.data.Role">
		<model:field name="roleInfo"  type="string" />
		</model:record>
	</model:dataset>
	<model:dataset id="appUserDataset" pageSize="10" global="true"
		cmd="org.loushang.bsp.eai.pap.user.cmd.UserSsoQueryCmd" method="execute">
		<model:record
			fromBean="org.loushang.bsp.eai.pap.user.data.UserSso">
			<model:field name="appName"  type="string" />
		</model:record>
	</model:dataset>
	<model:dataset id="assignedRoleDs" global="true"
		cmd="org.loushang.bsp.eai.pap.user.cmd.UserQueryCommand"
			method="getUserAssignedRoles">
			<model:record fromBean="org.loushang.bsp.eai.pap.role.data.Role">
			<model:field name="roleInfo"  type="string" />
			</model:record>
		</model:dataset>
</model:datasets>
<next:ViewPort>
	<next:Panel id="allPanel" autoScroll="true" border="false">
		<next:TopBar>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem iconCls="save" id="saveBtn"
				text='<%=res.get("BUT.SAVE.ALL")%>' handler="save_click" />
			<next:ToolBarItem iconCls="undo" id="undoBtn"
				text='<%=res.get("BUT.UNDO.ALL")%>' handler="undo_click" />
		</next:TopBar>
		<next:TabPanel id="tabPanels" >
			<next:Tabs>
				<next:Panel autoScroll="true" width="90%"
					title='<%=res.get("USER.INFO") %>' height="100%">
					<next:Html>
						<form id="baseinfoForm" onsubmit="return false"
							dataset="userDataset" class="L5form"><input
							style="display: none;" id="o_passWord" type="password"
							name="o_passWord" />

						<fieldset style="overflow: visible;" class="GroupBox">
						<legend class="GroupBoxTitle"><%=res.get("USER.BASEINFO") %>
						</legend>
						<table width="100%">
							<tr>
								<td class="FieldLabel" style="width: 15%"><%=res.get("PUB_USER.USERID")%></td>
								<td class="FieldInput" style="width: 35%"><input
									id="userIdTxt" type="text" name="userId" field="userId" /><font
									color="red">*</font></td>
								<td class="FieldLabel" style="width: 15%"><%=res.get("PUB_USER.USERNAME")%></td>
								<td class="FieldInput"><input type="text" id="userName"
									name="userName" field="userName" /><font color="red">*</font>
								</td>
							</tr>
							<tr>
								<td class="FieldLabel"><%=res.get("PUB_USER.PASSWORD")%></td>
								<td class="FieldInput"><input id="passWord" type="password"
									name="passWord" field="passWord" onchange="ValidatePwd(this)" /><font
									color="red">*</font></td>
								<td class="FieldLabel"><%=res.get("PUB_USER.PASSWORDCONFIRM")%></td>
								<td class="FieldInput"><input id="passwordConfirm"
									type="password" name="passwordConfirm" field="passwordConfirm"
									onchange="ValidatePwdConfirm(this)" /><font color="red">*</font>
								</td>
							</tr>
							<tr>
								<td class="FieldLabel"><%=res.get("PUB_USER.ISSYS")%></td>
								<td class="FieldInput"><input type="checkbox" value="1"
									id="isSys" name="isSys" field="isSys" /></td>
								<td class="FieldLabel"><%=res.get("PUB_USER.ACCOUNT_STATUS")%></td>
								<td class="FieldInput"><input type="radio" id="isLocked"
									name="accountStatus" field="accountStatus" value="00" /><%=res.get("PUB_USER.ACCOUNT_STATUS_CLOCK")%>
								<input type="radio" id="isOpened" name="accountStatus" field="accountStatus"
									value="11" checked="checked" /><%=res.get("PUB_USER.ACCOUNT_STATUS_USER")%>
								</td>
							</tr>
						</table>
						</fieldset>
						<fieldset style="overflow: visible;" class="GroupBox">
						<legend class="GroupBoxTitle"><%=res.get("PUB_USER.EMPLOYEE_INFO") %>
						</legend>
						<table width="100%">
							<tr>
								<td class="FieldLabel" style="width: 15%"><%=res.get("PUB_USER.EMPLOYEE")%></td>
								<td class="FieldInput"><input type="text" id="employeeName"
									name="employeeName" field="employeeName" disabled="disabled" />
								<input id="employeeId" type="text" name="employeeId"
									field="employeeId" style="display: none;" /> <img
									src="<%=SkinUtils.getImage(request,"l5/help.gif")%>"
									style="cursor: hand" onclick="selectEmployee()" /></td>
							</tr>
							<tr>
								<td class="FieldLabel" style="width: 15%"><%=res.get("PUB_USER.COPRATION_NAME")%></td>
								<td class="FieldInput"><input type="text"
									id="corporationName" name="corporationName"
									field="corporationName" disabled="disabled" /> <input
									type="text" id="corporationId" name="corporationId"
									field="corporationId" style="display: none;"></input></td>
							</tr>
							<tr>
								<td class="FieldLabel" style="width: 15%"><%=res.get("PUB_USER.DEPARTMENT_NAME")%></td>
								<td class="FieldInput"><input type="text"
									id="departmentName" name="departmentName"
									field="departmentName" disabled="disabled"></input> <input
									type="text" id="departmentId" name="departmentId"
									field="departmentId" style="display: none;"></input></td>
							</tr>
						</table>
						</fieldset>
						</form>
						<jsp:include page="<%=user_ext_jspfile%>"></jsp:include>
						<form id="ipPolicy" onsubmit="return false" dataset="userDataset"
							class="L5form">
						<fieldset style="overflow: visible;" class="GroupBox">
						<legend class="GroupBoxTitle"><%=res.get("PUB_USER.USER_POLICY") %>
						</legend>
						<table width="100%">
							<tr>
								<td class="FieldLabel" style="width: 15%"><%=res.get("PUB_USER.MAX_SEIION_NUMBER")%></td>
								<td class="FieldInput"><input type="text" id="maxSessionNumber"
									name="maxSessionNumber" field="maxSessionNumber" value="1" /></td>
							</tr>
							<tr>
								<td class="FieldLabel" style="width: 15%"><%=res.get("PUB_USER.IS_USE_IP")%></td>
								<td class="FieldInput"><input type="checkbox" value="1"
									id="isUseIP" name="isUseIP" field="isUseIP" /></td>
							</tr>
							<tr>
								<td class="FieldLabel" style="width: 15%"><%=res.get("PUB_USER.IP_POLICY_VALUE")%></td>
								<td class="FieldInput"><textarea rows="5" cols="40"
									id="ipPolicyValue" name="ipPolicyValue" field="ipPolicyValue"></textarea>
								</td>
							</tr>
						</table>
						</fieldset>

						</form>
					</next:Html>
				</next:Panel>
					<next:Panel id="appUserPanel" width="100%" title='用户映射' height="100%" border="false" autoScroll="true">
					<next:EditGridPanel id="appUserEditPanel" dataset="appUserDataset" width="100%" border="false"
						height="100%" autoScroll="true">
						<next:TopBar>
							<next:ToolBarItem symbol="->"></next:ToolBarItem>
							<next:ToolBarItem iconCls="add" text='<%=res.get("BUT.ADD")%>' handler="addAppUser" />
							<next:ToolBarItem iconCls="remove" text='<%=res.get("BUT.REMOVE")%>' handler="removeAppUser" />
						</next:TopBar>
						<next:Columns>
						<next:RowNumberColumn width="60" />
		                <next:CheckBoxColumn ></next:CheckBoxColumn>
		                  <next:Column id="appCode" header="" field="appCode" width="160" hidden="true">
                            <next:TextField allowBlank="false" />
		                    </next:Column>
							<next:Column id="appName" header='应用名' field="appName" width="150" editable="setEditable">
								<next:TriggerField id="grid_app_name" hideTrigger="false"
									onTriggerClick="onSelectApp">
								</next:TriggerField>
							</next:Column>
							<next:Column id="appUserId" header="映射用户" field="appUserId" width="160">
                            <next:TextField allowBlank="false" />
		                    </next:Column>
		                    <next:Column id="certificate" header="凭证" field="certificate" width="160">
                            <next:TextField allowBlank="false" />
		                    </next:Column>
						</next:Columns>
						<next:BottomBar>
							<next:PagingToolBar dataset="appUserDataset" />
						</next:BottomBar>
					</next:EditGridPanel>
				</next:Panel>	
					
				<next:Panel id="roleEditPanel"
					title='<%=res.get("USER.GRANTROLE")%>' width="100%" height="100%">
						<next:TopBar>
						<next:ToolBarItem  text='未授予角色名称'/>
						<next:ToolBarItem  xtype="textfield" id="roleName" />
						<next:ToolBarItem text='查询' iconCls="query" handler="query" />
						<next:ToolBarItem text='置空' iconCls="undo" handler="undo" />
					</next:TopBar>
					<next:Html>
						<form onsubmit="return false" dataset="userDataset" class="L5form">
						<input type="hidden" systype="itemselector" id="grantRolecmp"
							field="grantedRoles">
						<div id="grantRoleDiv"></div>
						</form>
					</next:Html>
				</next:Panel>
			</next:Tabs>
		</next:TabPanel>
	</next:Panel>
</next:ViewPort>
</body>

</html>