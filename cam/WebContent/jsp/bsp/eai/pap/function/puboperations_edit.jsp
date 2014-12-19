<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ include file="/jsp/public/resources_jspdir.jsp"%>
<html>
	<head>
		<title><%=res.get("PUB_OPERATIONS.TITLE")%></title>
		<next:ScriptManager/>
		<script>
			var idField='<%=request.getParameter("primeKey")%>';
				idField = decodeURI(idField);
			var method='<%=request.getParameter("method")%>';
				method = decodeURI(method);
			var RES_PROMPT='<%=res.get("MSG.PROMOT")%>';
			var RES_NOCHANGE='<%=res.get("MSG.NOCHANGE")%>';
            var RES_UNKOWN_CMD='<%=res.get("MSG.UNKOWN_CMD")%>';
			var MSG_NO_NEED_SAVE = '<%=res.get("MSG.NO_NEED_SAVE")%>';

			var RES_TITLE='<%=res.get("TITLE")%>';
			var RES_SAVE='<%=res.get("MSG.SAVE")%>';
			var RES_JSP_ONLY = '<%=res.get("MSG.JSP_ONLY")%>';
			var functionCode = '<%=request.getParameter("functionCode")%>';
				functionCode = decodeURI(functionCode);
			var functionName = '<%=request.getParameter("functionName")%>';
			  	functionName=decodeURI(functionName);
		</script>
		<script type="text/javascript" src="puboperations_edit.js"></script>
		<style  type="text/css">
			.heavyfont{
				font-weight:bold
			}
		</style>
	</head>
<body >
<div style="display:none">
<xml id="datasetDiv" >
	<datasets>
		<dataset id="accessTypeDst" proxy="enum" autoLoad="true">
			<enum>BSP.ACCESSTYPE</enum>
		</dataset>
	</datasets>
</xml>
</div>

<model:datasets>
	<model:dataset id="operationDataset" cmd="org.loushang.bsp.eai.pap.function.cmd.OperationQueryCommand" global="true">
		<model:record fromBean="org.loushang.bsp.eai.pap.function.data.Operation">
			<model:field name="functionName" type="string" />
		</model:record>
	</model:dataset>
	<model:dataset id="urlDataset" cmd="org.loushang.bsp.eai.pap.function.cmd.UrlQueryCommand" global="true" pageSize="-1" sortField="seq">
		<model:record fromBean="org.loushang.bsp.eai.pap.function.data.Url">
			<model:field name="functionName" type="string" />
			<model:field name="operationName" type="string" />
		</model:record>
		</model:dataset>
		<model:dataset id="operationTypeDst" cmd="org.loushang.bsp.permit.pap.function.cmd.OperationTypeQueryCommand" global="true" autoLoad="true">
			<model:record>
				<model:field name="value" mapping="operationTypeCode" type="string"/>
				<model:field name="text" mapping="operationTypeName" type="string"/>
			</model:record>
		</model:dataset>
</model:datasets>
<next:ViewPort>
<next:Panel  title='<%=res.get("PUB_OPERATIONS.TITLE")%>' width="100%" height="50%" autoScroll="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="save"  text='<%=res.get("BUT.SAVE")%>' handler="save"/>
		<next:ToolBarItem iconCls="undo"  text='<%=res.get("BUT.UNDO")%>' handler="undo"/>
	</next:TopBar>
	<next:Html>
		<form id="editForm"   dataset="operationDataset" onsubmit="return false" class="L5form">
		<table border="0"  width="100%" >
	   		<tr>
				<td  class="FieldLabel" style="width:15%"><%=res.get("PUB_OPERATIONS.OPERATION_CODE")%></td>
				<td class="FieldInput"><input type="text" id="operationCodeFld" name=<%=res.get("PUB_OPERATIONS.OPERATION_CODE")%> field="operationCode" onchange="testCode()"  /><font id="operationHint" color="red">*</font> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" ><%=res.get("PUB_OPERATIONS.OPERATION_NAME")%></td>
				<td class="FieldInput"><input type="text" name=<%=res.get("PUB_OPERATIONS.OPERATION_NAME")%> field="operationName"  /><font color="red">*</font> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" ><%=res.get("PUB_OPERATIONS.FUNCTION_CODE")%></td>
				<td class="FieldInput"><input type="text"  name=<%=res.get("PUB_OPERATIONS.FUNCTION_CODE")%> field="functionName" disabled="disabled" /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" ><%=res.get("PUB_OPERATIONS.OPERATION_TYPE")%></td>
				<td class="FieldInput">
					<select name=<%=res.get("PUB_OPERATIONS.OPERATION_TYPE")%> field="operationTypeCode" >
						<option dataset="operationTypeDst"  disabled="disabled" ></option>
					</select>
					<font color="red">*</font>
				</td>
			</tr>
			<tr>
				<td  class="FieldLabel" ><%=res.get("PUB_OPERATIONS.IS_DEFAULT")%></td>
				<td class="FieldInput"><input id="isDefaultOpr" type="checkbox" name=<%=res.get("PUB_OPERATIONS.IS_DEFAULT")%> field="isDefault" value="1"/> </td>
			</tr>
		</table>
		</form>
   </next:Html>
</next:Panel>
</next:ViewPort>
<next:EditGridPanel  id="urlGridPanel"  name="urlGrid" width="100%" height="100%" dataset="urlDataset" title='<%=res.get("PUB_URLS.TITLE")%>' autoScroll="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->" >	</next:ToolBarItem>
		<next:ToolBarItem  iconCls="edit" text="设为默认" handler="setDefault"  />
		<next:ToolBarItem  iconCls="add" text='<%=res.get("BUT.ADD")%>' handler="insertUrl"  />
		<next:ToolBarItem  iconCls="remove" text='<%=res.get("BUT.REMOVE")%>' handler="delUrl"  />
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn width="30"/>
		<next:Column id="urlName" header='<%=res.get("PUB_URLS.URL_NAME")%>'   field="urlName" width="150"
		 renderer="brushDefaultUrl()" >
			<next:TextField allowBlank="false"  />
		</next:Column>
		<next:Column id="urlContent" header='<%=res.get("PUB_URLS.URL_CONTENT")%>'   field="urlContent" width="350" >
			<next:TextField  allowBlank="false" />
		</next:Column>
		<next:Column id="accessType" header='<%=res.get("PUB_URLS.ACCESS_TYPE")%>'  field="accessType" >
			<next:ComboBox  dataset="accessTypeDst"  >
			</next:ComboBox>
		</next:Column>
		<next:Column id="note" header='<%=res.get("BTN.URL_COMMENT")%>' field="note"   width="200" >
			<next:TextField  allowBlank="false" />
		</next:Column>
	</next:Columns>
</next:EditGridPanel>

</body>
</html>
