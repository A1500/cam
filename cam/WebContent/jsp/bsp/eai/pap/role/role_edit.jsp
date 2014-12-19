<%@page contentType="text/html; charset=UTF-8" %>
<%@ page import="org.loushang.next.skin.SkinUtils" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ include file="/jsp/public/resources_jspdir.jsp"%>
<%@page import="org.loushang.bsp.util.BspConfig"%>
<%@page import="org.loushang.bsp.util.uuid.UUIDGenerator"%>
<html>
	<head>
	<meta http-equiv="Content-Tres" content="text/html; charset=utf-8">
		<title><%=res.get("PUB_ROLE.TITLE")%></title>
		<next:ScriptManager/>
		<script>
		var pk='<%=request.getParameter("roleId")%>';
		var method='<%=request.getParameter("method")%>';
		if (method=="INSERT"){
				<%UUIDGenerator uuid = new UUIDGenerator();%>
				var newId = "<%=uuid.getNextSeqId(30)%>";
			}
		</script>
		<script type="text/javascript" src="role_edit.js"></script>
		</head>
<body>
<model:datasets>
	<model:dataset id="roleDataSet" pageSize="-1" global="true" >
		<model:record fromBean="org.loushang.bsp.eai.pap.role.data.Role" >
			<model:field name="organName" type="string"/>
			<model:field name="appName" type="string"/>
			<model:field name="roleGroupName" type="string"/>
		</model:record>
	</model:dataset>
</model:datasets>
<next:ViewPort>
<next:Panel id="totalPanel"  border="false" autoScroll="true"  width="100%" height="100%" >
<next:TopBar>
	<next:ToolBarItem symbol="->"></next:ToolBarItem>
	<next:ToolBarItem iconCls="save" id="saveBtn"  text='<%=res.get("BUT.SAVE")%>' handler="save"/>
	<next:ToolBarItem iconCls="undo" id="backBtn" text='<%=res.get("PUB_DATA_TYPE.BACK")%>' handler="backToRoles"/>
</next:TopBar>
<next:Html>
		<form id="editForm" onsubmit="return false" dataset="roleDataSet" class="L5form">
		<table    width="100%" >
	   		<tr>
				<td  class="FieldLabel" style="width:15%"><%=res.get("PUB_ROLE.ROLE_NAME")%></td>
				<td class="FieldInput"><input type="text" id="roleName" name="roleName" field="roleName" style="width:240" maxlength="20"/> <font color="red">*</font></td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" ><%=res.get("PUB_ROLE.RELATION_ID")%></td>
				<td class="FieldInput"><input  type="text" name="relationId" field="relationId"  style="display:none"/>
				<input  type="text" name="organName"  field="organName"  style="width:200" disabled="disabled" />
				<img src="<%=SkinUtils.getImage(request,"l5/help.gif")%>" style="cursor:hand" onclick="forHelp()"/>
				<font color="red">*</font>
				</td>
			</tr>
			<tr>
				<td  class="FieldLabel" >所属应用</td>
				<td class="FieldInput"><input  type="text" name="appCode" field="appCode"  style="width:260" style="display:none"/>
				<input  type="text" name="appName" field="appName"  style="width:200" disabled="disabled" />
				<img src="<%=SkinUtils.getImage(request,"l5/help.gif")%>" style="cursor:hand" onclick="forHelpApp()"/>
				<font color="red">*</font>
				</td>
			</tr>
			<tr id="roleGroupTr" style="display:none">
				<td  class="FieldLabel" ><%=res.get("PUB_ROLE.ROLE_GROUP_ID")%></td>
				<td class="FieldInput"><input type="text" name="roleGroupId" field="roleGroupName" style="width:240" disabled="disabled" />
				</td>
			</tr>
			<tr>
				<td  class="FieldLabel" ><%=res.get("PUB_ROLE.DESCRIPTION")%></td>
				<td class="FieldInput" rowspan="4"><textarea  id="discription" name="discription" field="discription" rows="4" cols="70" ></textarea></td>
			</tr>
		</table>
		</form>
</next:Html>
</next:Panel>
</next:ViewPort>
</body>
</html>