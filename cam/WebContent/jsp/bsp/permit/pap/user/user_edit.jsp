<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="org.loushang.bsp.util.BspConfig"%>
<%@ include file="/jsp/public/resources_jspdir.jsp"%>
<%@page import="org.loushang.bsp.util.BspConstants"%>
<%@page import="org.loushang.bsp.security.context.BspInfo"%>
<%@page import="org.loushang.bsp.security.context.GetBspInfo"%>
<next:ScriptManager />

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title></title>
<script type="text/javascript">
</script>
<%
  String loginUserId = GetBspInfo.getBspInfo().getUserId();
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
	//查询条件打开合并函数
	function collapse(element){
		var fieldsetParent=L5.get(element).findParent("fieldset");
		if(element.expand==null||element.expand==true){
			fieldsetParent.getElementsByTagName("div")[0].style.display="none";
			element.src = '<%=SkinUtils.getImage(request,"groupbox_expand.gif")%>';
			element.expand=false;
		}else{
			fieldsetParent.getElementsByTagName("div")[0].style.display="";
			element.src = "<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>";
			element.expand =true;
		}
	}
	var loginUserId='<%=loginUserId%>';
</script>

<script type="text/javascript" src="user_edit.js"></script>
<script type="text/javascript" src="<%=ext_jsfile%>"></script>
</head>
<body>
<div style="display: none"><xml id="datasetDiv"> <datasets>
<dataset id="userTypeDataSet" proxy="cmd" autoLoad="true"> <record>
<field name="value" mapping="userTypeCode" type="string" /> <field
	name="text" mapping="userTypeName" type="string" /> </record> <command>org.loushang.bsp.permit.pap.user.cmd.UserTypeQueryCmd</command>
</dataset> </datasets> </xml></div>
<jsp:include page="<%=ext_dataset_file%>"></jsp:include>
<model:datasets>
	<model:dataset id="dataTypeDataset" pageSize="-1"
		cmd="org.loushang.bsp.permit.pap.datatype.cmd.PubDataTypeQueryCommand"
		global="true" autoLoad="true">
		<model:record
			fromBean="org.loushang.bsp.permit.pap.datatype.dao.PubDataType">
			<model:field name="value" mapping="dataTypeCode" type="string" />
			<model:field name="text" mapping="dataTypeName" type="string" />
		</model:record>
	</model:dataset>
	<model:dataset id="struTypeDataset" pageSize="-1"
		cmd="org.loushang.bsp.organization.cmd.PubStruTypeQueryCommand"
		global="true">
		<model:record>
			<model:field name="value" mapping="struType" type="string" />
			<model:field name="text" mapping="typeName" type="string" />
		</model:record>
	</model:dataset>
	<model:dataset id="scopeTypeDataset" pageSize="-1"
		enumName="BSP.USERDATAPERMIT_SCOPETYPE" global="true" autoLoad="true"></model:dataset>
	<model:dataset id="isDefaultDataset" pageSize="-1"
		enumName="BSP.IS_DEFAULT" global="true" autoLoad="true"></model:dataset>
	<model:dataset id="userDataset" global="true">
		<model:record
			fromBean="org.loushang.bsp.permit.pap.user.data.UserView">
			<model:field name="passwordConfirm" type="string" />
			<model:field name="grantedRoles" type="string" />
			<model:field name="maxSessionNumber" mapping="maxSessionNumber"
				defaultValue="1" type="string" />
			<model:field name="accountStatus" mapping="accountStatus"
				defaultValue="11" type="string" />
		</model:record>
	</model:dataset>
	<model:dataset id="ableRolesDataset" pageSize="-1" global="true"
		cmd="org.loushang.bsp.permit.pap.user.cmd.UserQueryCommand"
		method="getUserAbleRoles" >
		<model:record fromBean="org.loushang.bsp.permit.pap.role.data.Role">
		</model:record>
	</model:dataset>

	<model:dataset id="assignedRoleDs" global="true"
		cmd="org.loushang.bsp.permit.pap.user.cmd.UserQueryCommand"
			method="getUserAssignedRoles">
			<model:record fromBean="org.loushang.bsp.permit.pap.role.data.Role">
			</model:record>
		</model:dataset>

	<model:dataset id="dataPermitDataset" pageSize="10" global="true"
		cmd="org.loushang.bsp.permit.pap.user.cmd.UserQueryCommand"
		method="queryUserDataPermit">
		<model:record
			fromBean="org.loushang.bsp.permit.pap.user.data.UserDataPermit">
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
		<next:TabPanel id="tabPanels">
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
									id="userIdTxt" type="text" name="userId" field="userId"  maxlength="30"/><font
									color="red">*</font></td>
								<td class="FieldLabel" style="width: 15%"><%=res.get("PUB_USER.USERNAME")%></td>
								<td class="FieldInput"><input type="text" id="userName"
									name="userName" field="userName"  maxlength="30"/><font color="red">*</font>
								</td>
							</tr>
							<tr>
								<td class="FieldLabel"><%=res.get("PUB_USER.PASSWORD")%></td>
								<td class="FieldInput"><input id="passWord" type="password"
									name="passWord" field="passWord" onblur="ValidatePwd(this)" maxlength="120"/><font
									color="red">*</font></td>
								<td class="FieldLabel"><%=res.get("PUB_USER.PASSWORDCONFIRM")%></td>
								<td class="FieldInput"><input id="passwordConfirm"
									type="password" name="passwordConfirm" field="passwordConfirm"
									onblur="ValidatePwdConfirm(this)" maxlength="120" /><font color="red">*</font>
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
									id="isUseIP" name="isUseIP" field="isUseIP" onclick="onchecked(this)" /></td>
							</tr>
							<tr>
								<td class="FieldLabel" style="width: 15%" style="display:none" id="iplable"><%=res.get("PUB_USER.IP_POLICY_VALUE")%></td>
								<td class="FieldInput" id="ipvalueinput" style="display:none"><textarea rows="5" cols="60" style="display:none"
									id="ipPolicyValue" name="ipPolicyValue" field="ipPolicyValue" ></textarea>
									<font color="red"><br>IP策略规则：
										<br>1.	允许使用通配符“*”，例如：10.162.12.*；
										<br>2.	两个IP用“-”隔开表示IP范围段，例如：10.162.11-10.162.11.69；
										<br>3.	禁止某IP用“-”开头，例如：-10.162.12.12-10.162.12.56；
										<br>4.	各个IP间用“；”隔开，例如：-10.162.11.210;10.162.12.124；
									</font>
								</td>
							</tr>
						</table>
						</fieldset>

						</form>
					</next:Html>

				</next:Panel>
				<next:Panel id="roleEditPanel"
					title='<%=res.get("USER.GRANTROLE")%>' width="100%" height="100%"
					autoScroll="true">
					<next:Html>
						<form onsubmit="return false" dataset="userDataset" class="L5form">
						<input type="hidden" systype="itemselector" id="grantRolecmp"
							field="grantedRoles">
						<div id="grantRoleDiv"></div>
						</form>
					</next:Html>
				</next:Panel>
				<next:Panel id="dataPermitPanel" width="100%"
					title='<%=res.get("USER.DATAREF")%>' height="100%" border="false"
					autoScroll="true" >
					<next:Panel border="false" width="100%">
						<next:Html>
							<form onsubmit="return false;" class="L5form">
							<fieldset style="overflow: visible;"><legend
								class="GroupBoxTitle"><%=res.get("PUB_USER.SEARCH")%> <img
								class="GroupBoxExpandButton"
								src="<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>"
								onclick="collapse(this);" /> </legend>
							<div>
							<table width="100%">
								<tr>
									<td class="FieldLabel"><%=res.get("PUB_USER_DATA_PERMIT.DATA_TYPE_CODE")%>：</td>
									<td class="FieldInput"><select id="datatype">
										<option dataset="dataTypeDataset">
									</select></td>
									<td class="FieldLabel"><%=res.get("PUB_USER_DATA_PERMIT.OBJECT_VALUE")%>：</td>
									<td class="FieldInput"><input type="text" id="objectvalue"
										class="TextEditor"  style="display: none;" /><input type="text" id="objectname"
										class="TextEditor" disabled="disabled" /> <img
										src="<%=SkinUtils.getImage(request,"l5/help.gif")%>"
										style="cursor: hand" onclick="forHelpObjectValue()" /></td>
									<td class="FieldLabel"><button onclick="query()"><%=res.get("BUT.QUERY")%></button></td>
								</tr>
							</table>
							</div>
							</fieldset>
							</form>
						</next:Html>
					</next:Panel>
					<next:EditGridPanel id="datPermitEditPanel"
						dataset="dataPermitDataset" width="100%" border="false"
						height="100%" autoScroll="true">
						<next:Columns>
                        <next:CheckBoxColumn></next:CheckBoxColumn>
							<next:Column
								header='<%=res.get("PUB_USER_DATA_PERMIT.DATA_TYPE_CODE")%>'
								width="100" field="dataTypeCode">
								<next:ComboBox dataset="dataTypeDataset"
									id="datatypecodecombobox" triggerAction="all" typeAble="false"></next:ComboBox>
							</next:Column>
							<next:Column id="objectName"
								header='<%=res.get("PUB_USER_DATA_PERMIT.OBJECT_VALUE")%>'
								field="objectName" width="180">
								<next:TriggerField id="grid_objectValue" hideTrigger="false" readOnly="true" enableKeyEvents="true"
									onTriggerClick="onSelectObjectValue">
								</next:TriggerField>
							</next:Column>
							<next:Column
								header='<%=res.get("PUB_USER_DATA_PERMIT.IS_DEFAULT")%>'
								field="isDefault">
								<next:ComboBox dataset="isDefaultDataset" id="isdefaultcombobox" triggerAction="all" typeAble="false"></next:ComboBox>
							</next:Column>

							<next:Column
								header='<%=res.get("PUB_USER_DATA_PERMIT.SCOPE_TYPE")%>'
								field="scopeType" hidden="true">
								<next:ComboBox dataset="scopeTypeDataset" id="scopetypecombox"></next:ComboBox>
							</next:Column>
							<next:Column
								header='<%=res.get("PUB_USER_DATA_PERMIT.SCOPE_VALUE")%>'
								field="scopeName" width="190" editable="ableSelectScopeValue" hidden="true">
								<next:TriggerField id="grid_scopeValue" hideTrigger="false"
									onTriggerClick="onSelectScopeValue">
								</next:TriggerField>
							</next:Column>
							<next:Column
								header='<%=res.get("PUB_USER_DATA_PERMIT.START_TIME")%>'
								width="200" field="startTime">
								<next:DateTimeField format="Ymd H:i:s"></next:DateTimeField>
							</next:Column>
							<next:Column
								header='<%=res.get("PUB_USER_DATA_PERMIT.END_TIME")%>'
								width="200" field="endTime">
								<next:DateTimeField format="Ymd H:i:s"></next:DateTimeField>
							</next:Column>
						</next:Columns>
						<next:TopBar>
							<next:ToolBarItem symbol="->"></next:ToolBarItem>
							<next:ToolBarItem iconCls="add" text='<%=res.get("BUT.ADD")%>'
								handler="addDataRef" />
							<next:ToolBarItem iconCls="remove"
								text='<%=res.get("BUT.REMOVE")%>' handler="removeDataRef" />
						</next:TopBar>
						<next:BottomBar>
							<next:PagingToolBar dataset="dataPermitDataset" />
						</next:BottomBar>
					</next:EditGridPanel>
				</next:Panel>
			</next:Tabs>
		</next:TabPanel>
	</next:Panel>
</next:ViewPort>
</body>

</html>