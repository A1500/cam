
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ include file="/jsp/public/resources_jspdir.jsp"%>


<html>
	<head>
		<title><%=res.get("PUB_APP.TITLE")%></title>
		<next:ScriptManager/>
		<script>
			var idField='<%=request.getParameter("primeKey")%>';
				idField = decodeURI(idField);
			var method='<%=request.getParameter("method")%>';
				method = decodeURI(method);
			var RES_PROMPT='<%=res.get("MSG.PROMOT")%>';
			var RES_NOCHANGE='<%=res.get("MSG.NOCHANGE")%>';
			
			var RES_UNKOWN_CMD='<%=res.get("MSG.UNKOWN_CMD")%>';
			var RES_SAVE='<%=res.get("MSG.SAVE")%>';
			var MSG_NO_NEED_SAVE='<%=res.get("MSG.NO_NEED_SAVE")%>';
			var recordId = '<%=request.getParameter("record")%>';
				recordId = decodeURI(recordId);
			
		</script>
		<script type="text/javascript" src="pubapp_edit.js"></script>
	</head>
<body>

<div style="display:none">
<xml id="datasetDiv">
	<datasets>
		<dataset id="tpDataset" proxy="enum" >
			<enum>BSP.TRANSPORTPROTOCOLS</enum>
		</dataset>
	</datasets>
</xml>
</div>
<model:datasets>
	<model:dataset id="appDataset" method="queryWithMenu" cmd="org.loushang.bsp.permit.pap.function.cmd.AppQueryCommand" global="true">
		<model:record fromBean="org.loushang.bsp.permit.pap.function.data.App" ></model:record>
	</model:dataset>
</model:datasets>
<next:ViewPort>
<next:Panel  title='<%=res.get("PUB_APP.TITLE")%>' width="100%">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="save"  text='<%=res.get("BUT.SAVE")%>' handler="save"/>
		<next:ToolBarItem iconCls="undo"  text='<%=res.get("BUT.UNDO")%>' handler="undo"/>
	</next:TopBar>
	<next:Html>
		<form id="editForm" onsubmit="return false" dataset="appDataset" class="L5form">
		<table border="0"  width="100%" >
		<tr>
			<td  class="FieldLabel" style="width:15%">应用编码</td>
			<td class="FieldInput"><input type="text" id="appCodeFld" name="应用编码" field="appCode"  onblur="testCode()"  />
			<font id="appHint" color="red">*</font></td>
	    </tr>	
		<tr>
				<td  class="FieldLabel" style="width:15%"><%=res.get("PUB_APP.APP_NAME")%></td>
				<td class="FieldInput"><input type="text" name="<%=res.get("PUB_APP.APP_NAME")%>" field="appName"  />
				<font id="functionHint" color="red">*</font></td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" ><%=res.get("PUB_APP.TP")%></td>
				<td class="FieldInput">
					<select name=<%=res.get("PUB_APP.TP")%> field="transport"  >
						<option dataset="tpDataset"></option>
					</select>
					<font id="functionHint" color="red">*</font>
				</td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" ><%=res.get("PUB_APP.SERVER")%></td>
				<td class="FieldInput"><input type="text" name=<%=res.get("PUB_APP.SERVER")%> field="serverHost"  />
				 <font id="functionHint" color="red">*</font>
				 </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" ><%=res.get("PUB_APP.PORT")%></td>
				<td class="FieldInput"><input type="text" name=<%=res.get("PUB_APP.PORT")%> field="port"  /> 
				<font id="functionHint" color="red">*</font>
				</td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" ><%=res.get("PUB_APP.CONTEXT")%></td>
				<td class="FieldInput"><input type="text" name=<%=res.get("PUB_APP.CONTEXT")%> field="context"  /> 
				<font id="functionHint" color="red">*</font>
				</td>
			</tr>
			<tr>
				<td  class="FieldLabel" ><%=res.get("PUB_FUNCTIONS.SEQ")%></td>
				<td class="FieldInput"><input type="text" id="seq" name=<%=res.get("PUB_FUNCTIONS.SEQ")%> field="seq"  /> 
				&nbsp;<font style="color:red;">只能输入整数值 </font>
				</td>
			</tr>
			<tr id="hiddenTR" style="display:''">
				<td class="FieldLabel">同步菜单</td>
				<td class="FieldInput"><input id="checkbox0" type="checkbox" checked="checked" /></td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" ><%=res.get("PUB_APP.NOTE")%></td>
				<td class="FieldInput" rowspan="4"><textarea name=<%=res.get("PUB_APP.NOTE")%> field="note" rows="3" cols="80"/> </td>
			</tr>
		</table>
		</form>
   </next:Html>
</next:Panel>
</next:ViewPort>
</body>
</html>
