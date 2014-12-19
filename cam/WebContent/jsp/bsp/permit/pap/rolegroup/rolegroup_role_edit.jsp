<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="org.loushang.next.skin.SkinUtils" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ include file="/jsp/public/resources_jspdir.jsp"%>
<html>
<head>
<title></title>
<next:ScriptManager/>
<script type="text/javascript" src="rolegroup_role_edit.js"></script>
<script type="text/javascript" src="function_tree_help.js"></script>
<script type="text/javascript">
var method = '<%=request.getParameter("method")%>';
var roleGroupId = '<%=request.getParameter("roleGroupId")%>';
var RES_PROMOT='<%=res.get("MSG.PROMOT")%>';
var RES_NOCHANGE='<%=res.get("MSG.NOCHANGE")%>';
var RES_SAVE='<%=res.get("MSG.SAVE")%>';
var RES_DELETE='<%=res.get("ASK.DELETE")%>';
var RES_UNVALIDATED='<%=res.get("MSG.UNVALIDATED")%>';
var ASK_SELETE_DELETE = '<%=res.get("UTIL.SELECT_DELETE")%>';
var ALERT_SELECT_ONE = '<%=res.get("ALETR_SELECT_ONE")%>';
var MENU_TREE_MANAGER = '<%=res.get("MENU_TREE_MANAGER")%>';
</script>
</head>
<body  style="width:100%">
<model:datasets>
	<model:dataset id="roleDataSet" cmd="org.loushang.bsp.permit.pap.role.cmd.RoleQueryCommand" method="execute"   global="true">
		<model:record fromBean="org.loushang.bsp.permit.pap.role.data.Role"></model:record>
	</model:dataset>
</model:datasets>
<next:Panel>
<next:BottomBar>
	<next:ToolBarItem  symbol="->"  />
	<next:ToolBarItem iconCls="submit"  text='<%=res.get("BUT.SAVE")%>' handler="submit_click"/>
</next:BottomBar>
<next:Html>
<form method="post" dataset="roleDataSet" onsubmit="return false" style="padding: 5px;" class="L5form">
	<table  width="100%">
		<tr>
			<td  class="FieldLabel" width="20%"><%=res.get("ROLE.NAME")%></td>
			<td class="FieldInput" ><input  type="text" name="roleName" field="roleName" id="roleName"/><font color="red">*</font></td>
		</tr>
		<tr>
			<td  class="FieldLabel" ><%=res.get("ROLE.DISCRIPTION")%></td>
			<td class="FieldInput" ><textarea rows="5" cols="100" name="discription" id="discription" field="discription" ></textarea></td>
		</tr>
	</table>
</form>
</next:Html>
</next:Panel>
<%@ include file="/jsp/bsp/permit/pap/rolegroup/function_tree_help.jsp"%>
</body>
</html>