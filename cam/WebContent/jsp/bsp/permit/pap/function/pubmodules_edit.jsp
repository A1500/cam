
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ include file="/jsp/public/resources_jspdir.jsp"%>
<html>
	<head>
		<title><%=res.get("PUB_MODULES.TITLE")%></title>
		<next:ScriptManager/>
		<script>
			var idField='<%=request.getParameter("primeKey")%>';
				idField = decodeURI(idField);
			var method='<%=request.getParameter("method")%>';
			var appCode = '<%=request.getParameter("appCode")%>';
				appCode = decodeURI(appCode);
			var appName = '<%=request.getParameter("appName")%>';
				appName = decodeURI(appName);
				appName = (appName == 'null')?'':appName;
			var parentModuleCode = '<%=request.getParameter("parentModuleCode")%>';
				parentModuleCode = decodeURI(parentModuleCode);
			var parentModuleName = '<%=request.getParameter("parentModuleName")%>';
				parentModuleName = decodeURI(parentModuleName);
			var withMenu = '<%=request.getParameter("withMenu")%>';
				withMenu = decodeURI(withMenu);
				
			var pmenuId = '<%=request.getParameter("menuId")%>';
				pmenuId = decodeURI(pmenuId);	
			if(pmenuId === ""|| pmenuId ==='null' ||pmenuId === undefined){
				pmenuId = null;		
			}
			var RES_PROMPT='<%=res.get("MSG.PROMOT")%>';
			var RES_NOCHANGE='<%=res.get("MSG.NOCHANGE")%>';
			var RES_TITLE='<%=res.get("TITLE")%>';
			var RES_SAVE='<%=res.get("MSG.SAVE")%>';
			var MSG_NO_NEED_SAVE = '<%=res.get("MSG.NO_NEED_SAVE")%>';
			

		</script>
		<script type="text/javascript" src="pubmodules_edit.js"></script>
	</head>
<body>
<model:datasets>
	<model:dataset id="moduleDataset" method="queryWithMenu" cmd="org.loushang.bsp.permit.pap.function.cmd.ModuleQueryCommand"
	   global="true" >
		<model:record fromBean="org.loushang.bsp.permit.pap.function.data.Module" >
			<model:field name="appName" type="string" />
			<model:field name="parentModuleName" type="string" />
		</model:record>
	</model:dataset>
</model:datasets>
<next:ViewPort><next:AnchorLayout>
<next:Panel  title='<%=res.get("PUB_MODULES.TITLE")%>'  border="false" anchor="100% 99%" >
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="save"  text='<%=res.get("BUT.SAVE")%>' handler="save"/>
		<next:ToolBarItem iconCls="undo"  text='<%=res.get("BUT.UNDO")%>' handler="undo"/>
	</next:TopBar>
	<next:Html>
		<form id="editForm"   dataset="moduleDataset" onsubmit="return false" class="L5form">
		<table   width="100%" >

	   		<tr>
				<td class="FieldLabel" style="width:15%" ><%=res.get("PUB_MODULES.MODULE_CODE")%></td>
				<td class="FieldInput"><input type="text" id="moduleCodeFld" name=<%=res.get("PUB_MODULES.MODULE_CODE")%> field="moduleCode" onblur="testCode()" /><font id="moduleHint" color="red">*</font> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" ><%=res.get("PUB_MODULES.MODULE_NAME")%></td>
				<td class="FieldInput"><input type="text" name=<%=res.get("PUB_MODULES.MODULE_NAME")%> field="moduleName"  /><font color="red">*</font> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" ><%=res.get("PUB_MODULES.PARENT_MODULE")%></td>
				<td class="FieldInput"><input id="parentModuleId" field="parentModuleName" type="text" name=<%=res.get("PUB_MODULES.PARENT_MODULE")%>  disabled="disabled"/> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" ><%=res.get("PUB_MODULES.IS_LEAF")%></td>
				<td class="FieldInput">
					<input type="checkbox" id="isLeafFld" name=<%=res.get("PUB_MODULES.IS_LEAF")%> field="isLeafModule" value="1" />
				</td>
			</tr>
	   		
			<tr id="hiddenTR" style="display:''">
				<td class="FieldLabel">同步菜单</td>
				<td class="FieldInput"><input id="checkbox0" type="checkbox" checked="checked" /></td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" ><%=res.get("PUB_MODULES.APP_ID")%></td>
				<td class="FieldInput"><input type="text" name=<%=res.get("PUB_MODULES.APP_ID")%> field="appName" disabled="disabled"/> </td>
			</tr>
			<tr>
				<td  class="FieldLabel" ><%=res.get("PUB_MODULES.SEQ")%></td>
				<td class="FieldInput"><input type="text" id="seq" name=<%=res.get("PUB_MODULES.SEQ")%> field="seq"  />&nbsp;<font style="color:red;">只能输入整数值 </font>
				</td>
			</tr>
		</table>
		</form>
   </next:Html>
</next:Panel>
</next:AnchorLayout> </next:ViewPort>
</body>
</html>
