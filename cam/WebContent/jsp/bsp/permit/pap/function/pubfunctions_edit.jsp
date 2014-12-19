<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ include file="/jsp/public/resources_jspdir.jsp"%>
<html>
	<head>
		<title><%=res.get("PUB_FUNCTIONS.TITLE")%></title>
		<next:ScriptManager/>
		<script>
			var idField='<%=request.getParameter("primeKey")%>';
				idField = decodeURI(idField);
			var method='<%=request.getParameter("method")%>';
				method = decodeURI(method);
			var withMenu = '<%=request.getParameter("withMenu")%>';
				withMenu = decodeURI(withMenu);
			var pmenuId = '<%=request.getParameter("menuId")%>';
				pmenuId = decodeURI(pmenuId);	
			if(pmenuId === 'null'){
				pmenuId = null;		
			}
			var RES_PROMPT='<%=res.get("MSG.PROMOT")%>';
			var RES_NOCHANGE='<%=res.get("MSG.NOCHANGE")%>';
			var RES_TITLE='<%=res.get("TITLE")%>';
			var RES_SAVE='<%=res.get("MSG.SAVE")%>';
			var MSG_NO_NEED_SAVE = '<%=res.get("MSG.NO_NEED_SAVE")%>';
			var moduleCode = '<%=request.getParameter("moduleCode")%>';
				moduleCode = decodeURI(moduleCode);
			var moduleName = '<%=request.getParameter("moduleName")%>';
				moduleName = decodeURI(moduleName);
		</script>
		<script type="text/javascript" src="pubfunctions_edit.js"></script>
	</head>
<body>
<model:datasets>
	<model:dataset id="functionDataset" method="queryWithMenu" cmd="org.loushang.bsp.permit.pap.function.cmd.FunctionQueryCommand" global="true">
		<model:record fromBean="org.loushang.bsp.permit.pap.function.data.Function">
			<model:field name="moduleName" type="string" />
			<model:field name="menuId" type="string" />
		</model:record>
	</model:dataset>
</model:datasets>
<next:ViewPort>
<next:Panel  title='<%=res.get("PUB_FUNCTIONS.TITLE")%>' width="100%">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="save"  text='<%=res.get("BUT.SAVE")%>' handler="save"/>
		<next:ToolBarItem iconCls="undo"  text='<%=res.get("BUT.UNDO")%>' handler="undo"/>
	</next:TopBar>
	<next:Html>
		<form id="editForm"   dataset="functionDataset" onsubmit="return false" class="L5form">
		<table border="0"  width="100%" >

	   		<tr>
				<td  class="FieldLabel"  style="width:15%"><%=res.get("PUB_FUNCTIONS.FUNCTION_CODE")%></td>
				<td class="FieldInput"><input type="text" id="functionCodeFld" name=<%=res.get("PUB_FUNCTIONS.FUNCTION_CODE")%> field="functionCode"  onblur="testCode()"/><font id="functionHint" color="red">*</font> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" ><%=res.get("PUB_FUNCTIONS.FUNCTION_NAME")%></td>
				<td class="FieldInput"><input type="text" name=<%=res.get("PUB_FUNCTIONS.FUNCTION_NAME")%> field="functionName"  /><font color="red">*</font> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" ><%=res.get("PUB_FUNCTIONS.MODULE_CODE")%></td>
				<td class="FieldInput"><input type="text" name=<%=res.get("PUB_FUNCTIONS.MODULE_CODE")%> field="moduleName" disabled="disabled" /> </td>
			</tr>
				<tr id="hiddenTR" style="display:''">
				<td class="FieldLabel">同步菜单</td>
				<td class="FieldInput"><input id="checkbox0" type="checkbox" checked="checked"/></td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" ><%=res.get("PUB_FUNCTIONS.SEQ")%></td>
				<td class="FieldInput"><input type="text" id="seq" name=<%=res.get("PUB_FUNCTIONS.SEQ")%> field="seq"  /> 
				&nbsp;<font style="color:red;">只能输入整数值 </font> 
				</td>
			</tr>
		</table>
		</form>
   </next:Html>
</next:Panel>
</next:ViewPort>
</body>
</html>
