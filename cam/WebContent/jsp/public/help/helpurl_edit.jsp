<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils" %>
<%@ include file="/jsp/public/resources_jspdir.jsp" %>
<%
    String isLocal = request.getParameter("isLocal");
    if ("true".equals(isLocal) || "1".equals(isLocal)){
    	isLocal = "1";        // true for local
    } else {
    	isLocal = "0";        // false for remote
    }
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>新增通用帮助</title>
<script type="text/javascript">
	var isLocal = '<%=isLocal%>';
	var method = '<%=request.getParameter("method")%>';
	var idField = '<%=request.getParameter("moduleCode")%>';
	idField = decodeURIComponent(idField);
	var RES_PROMOT = '<%=res.get("MSG.PROMOT")%>';
	var RES_UNKOWN_CMD = '<%=res.get("MSG.UNKOWN_CMD")%>';
	var RES_SAVE = '<%=res.get("MSG.SAVE")%>';
	var selectdel = '<%=res.get("MSG.SEL_DEL_RECORD")%>';//请选择要删除的记录!
	var REQUIRE_MODULECODE = '<%=res.get("HELP.REQUIRE_MODULECODE")%>';
	var HELP_LIST = '<%=res.get("HELP.LIST_TITLE")%>';
	var HELP_SAME_URL_CODE = '<%=res.get("HELP.SAME_URL_CODE")%>';
</script>
<next:ScriptManager/>
<script type="text/javascript" src="helpurl_edit.js"></script>
</head>
<body style="overflow-y:scroll;">
<model:datasets>
	<model:dataset id="useStatusDs" enumName="CMHELP.BOOL"  autoLoad="true" global="true" ></model:dataset>
	<model:dataset id="helpModuleDs" cmd="org.loushang.util.help.cmd.HelpModuleQueryCommand" global="true" pageSize="-1">
		<model:record fromBean="org.loushang.util.help.data.HelpModule"></model:record>
	</model:dataset>
	<model:dataset id="helpUrlDs" cmd="org.loushang.util.help.cmd.HelpUrlQueryCommand" global="true" pageSize="10">
		<model:record fromBean="org.loushang.util.help.data.HelpUrl"></model:record>
	</model:dataset>
</model:datasets>

<!-- 添加空的viewPort原因是：兼容firefox里面EditGridPanel的height=100% -->
<next:ViewPort>
	<next:Panel id="allPanel"  autoScroll="true" border="false">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="return" id="retBtn"  text='<%=res.get("BUT.RETURN")%>' handler="ret_click"/>
		<next:ToolBarItem iconCls="save" id="saveBtn"  text='<%=res.get("BUT.SAVE.ALL")%>' handler="save_click"/>
		<next:ToolBarItem iconCls="undo" id="undoBtn" text='<%=res.get("BUT.UNDO.ALL")%>' handler="undo_click"/>
	</next:TopBar>
		<next:Html>
		<form onsubmit="return false" dataset="helpModuleDs" class="L5form">
			<table width="100%">
		   		<tr>
					<td class="FieldLabel" style="width:15%"><%=res.get("HELP.MODULE_CODE")%></td>
					<td class="FieldInput" style="width:35%">
					    <input id="moduleCode" type="text" field="moduleCode" title="<%=res.get("HELP.MODULE_CODE")%>"/><font color="red">*</font>
					</td>
					<td class="FieldLabel" style="width:15%" ><%=res.get("HELP.MODULE_NAME")%></td>
					<td class="FieldInput"><input type="text" id="moduleName" name="moduleName" field="moduleName"/></td>
				</tr>
				<tr >
					<td class="FieldLabel" ><%=res.get("HELP.MODULE_ISLOCAL")%></td>
					<td class="FieldInput">
					    <select id="isLocal" field="isLocal" disabled="disabled">
					        <option dataset="useStatusDs"></option>
					    </select>
					</td>
					<td class="FieldLabel" ></td>
					<td class="FieldInput"></td>
				</tr>
				<%-- 只有在远程通用帮助时才输出以下内容 --%>
		   		<% if (!"1".equals(isLocal) && !"true".equals(isLocal)){ %>
		   		<tr>
					<td class="FieldLabel" style="width:15%"><%=res.get("HELP.MODULE_TRANSPORT")%></td>
					<td class="FieldInput"><input  type="text" id="transport" name="transport" field="transport" /><font color="red">*</font></td>
					<td class="FieldLabel" style="width:15%"><%=res.get("HELP.MODULE_HOST")%></td>
					<td class="FieldInput"><input id="host"  type="text" name="host" field="host"  /><font color="red">*</font></td>
				</tr>
				<tr>
					<td class="FieldLabel" style="width:15%"><%=res.get("HELP.MODULE_PORT")%></td>
					<td class="FieldInput">
					    <input type="text" id="port" name="port" field="port" /><font color="red">*</font>
					</td>
					<td class="FieldLabel" style="width:15%"><%=res.get("HELP.MODULE_WEBCONTENT")%></td>
					<td class="FieldInput">
					    <input type="text" id="webContent" name="webContent" field="webContent" /><font color="red">*</font>
					</td>
				</tr>
				<% } %>
				<tr>
					<td class="FieldLabel" style="width:15%"><%=res.get("HELP.MODULE_NOTE")%></td>
					<td rowspan="4" colspan="3" class="FieldInput">
					    <textarea id="note" name="note" field="note" rows="3" cols="80"></textarea>
					</td>
				</tr>
			</table>
		</form>
		</next:Html>
	</next:Panel>

	<next:EditGridPanel title='<%=res.get("HELP.TITLE_URL")%>' id="helpUrlGrid" dataset="helpUrlDs" border="false" height="100%">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="add" text='<%=res.get("HELP.ADD_URL")%>' handler="addUrl" />
		<next:ToolBarItem iconCls="remove" text='<%=res.get("HELP.DEL_URL")%>' handler="removeUrl" />
	</next:TopBar>
		<next:Columns>
			<next:Column header='<%=res.get("HELP.URL_CODE")%>' width="100" field="helpCode" editable="isNewUrl">
				<next:TextField />
			</next:Column>
			<next:Column header='<%=res.get("HELP.URL_NAME")%>' field="helpName" width="150">
				<next:TextField />
			</next:Column>
			<next:Column header='<%=res.get("HELP.URL_URL")%>' field="url" width="250">
				<next:TextField />
			</next:Column>
			<next:Column header='<%=res.get("HELP.URL_DESCRIPTION")%>' field="description" width="550">
				<next:TextField />
			</next:Column>
		</next:Columns>
		<next:BottomBar>
			<next:PagingToolBar dataset="helpUrlDs"/>
		</next:BottomBar>
	</next:EditGridPanel>
</next:ViewPort>

</body>
</html>