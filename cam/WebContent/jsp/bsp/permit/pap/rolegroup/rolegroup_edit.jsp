<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="org.loushang.next.skin.SkinUtils" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ include file="/jsp/public/resources_jspdir.jsp"%>
<html>
<head>
<title></title>
<next:ScriptManager/>
<script type="text/javascript" src="rolegroup_edit.js"></script>
<script type="text/javascript">
var method = '<%=request.getParameter("method")%>';
var corpName='<%=request.getParameter("corpName")%>';
    corpName=decodeURI(corpName);
var corpId='<%=request.getParameter("corpId")%>';
    corpId=decodeURI(corpId);
var roleGroupId = '<%=request.getParameter("roleGroupId")%>';
	roleGroupId = decodeURI(roleGroupId);
var roleGroupName = '<%=request.getParameter("roleGroupName")%>';
	roleGroupName = decodeURI(roleGroupName);
var RES_PROMOT='<%=res.get("MSG.PROMOT")%>';
var RES_NOCHANGE='<%=res.get("MSG.NOCHANGE")%>';
var RES_SAVE='<%=res.get("MSG.SAVE")%>';
var RES_DELETE='<%=res.get("ASK.DELETE")%>';
var RES_UNVALIDATED='<%=res.get("MSG.UNVALIDATED")%>';
var ASK_SELETE_DELETE = '<%=res.get("UTIL.SELECT_DELETE")%>';
var ALERT_SELECT_ONE = '<%=res.get("ALETR_SELECT_ONE")%>';
var MENU_TREE_MANAGER = '<%=res.get("MENU_TREE_MANAGER")%>';
var query_title ='<%=res.get("ROLEGROUP.TITLE")%>';
</script>
</head>
<body  style="width:100%">
<model:datasets>
	<model:dataset id="roleGroupDataSet" cmd="org.loushang.bsp.permit.pap.rolegroup.cmd.RoleGroupQueryCmd" global="true">
		<model:record fromBean="org.loushang.bsp.permit.pap.rolegroup.data.RoleGroup">
			<model:field name="useCorporation" type="string"/>
			<model:field name="useCorporationName" type="string"/>
		</model:record>
	</model:dataset>
</model:datasets>
<next:ViewPort>
<next:AnchorLayout>
<next:Panel anchor="100%">
<next:TopBar>
	<next:ToolBarItem  symbol="->"  />
	<next:ToolBarItem iconCls="save"  text="保存转到角色列表" handler="next_click"/>
	<next:ToolBarItem iconCls="save"  text="保存" handler="end_click"/>
	<next:ToolBarItem iconCls="undo"  text='<%=res.get("BUT_BACK")%>' handler="cancel_click"/>
</next:TopBar>
<next:Html>
<form method="post" dataset="roleGroupDataSet" onsubmit="return false" style="padding: 5px;" class="L5form">
	<table >
		<tr>
			<td  class="FieldLabel" width="20%"><%=res.get("ROLEGROUP.NAME")%></td>
			<td class="FieldInput" ><input  type="text" name=<%=res.get("ROLEGROUP.NAME")%> field="roleGroupName" id="roleGroupName"/><font color="red">*</font></td>
		</tr>
		<tr>
			<td  class="FieldLabel" ><%=res.get("ROLEGROUP.CORPORATION")%></td>
			<td class="FieldInput" ><input type="text"  name=<%=res.get("ROLEGROUP.CORPORATION")%> id="corporationName" disabled="disabled"/>
					<input type="text" style="display: none;"  name=<%=res.get("ROLEGROUP.CORPORATION")%> id="corporation" field="corporation" /><font color="red">*</font>
			<img src="<%=SkinUtils.getImage(request,"l5/help.gif")%>"  style="cursor:hand" onclick="forHelp()" />
			</td>
		</tr>
		<tr>
			<td  class="FieldLabel" >应用范围</td>
			<td class="FieldInput" ><input style="width: 200;" type="text"  name=<%=res.get("ROLEGROUP.USE_CORPORATION")%> field="useCorporationName" id="useCorporationName" ondblclick="clear_click(this)" disabled="disabled"/><input type="text" style="display: none;"  name="useCorporation" id="useCorporation" field="useCorporation" />
			<img src="<%=SkinUtils.getImage(request,"l5/help.gif")%>"  style="cursor:hand" onclick="forHelpUse()" />
			</td>
		</tr>
		<tr>
			<td  class="FieldLabel" ><%=res.get("ROLEGROUP.DESCRIPTION")%></td>
			<td class="FieldInput" ><textarea rows="5" cols="100" name=<%=res.get("ROLEGROUP.DESCRIPTION")%> id="description" field="description" ></textarea> </td>
		</tr>
	</table>
</form>
</next:Html>
</next:Panel>
</next:AnchorLayout>
</next:ViewPort>
</body>
</html>