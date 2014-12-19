<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ include file="/jsp/public/resources_jspdir.jsp"%>
<html>
<head>
<title><%=res.get("PUB_DATA_TYPE.TITLE")%></title>
<next:ScriptManager />
<script type="text/javascript" src="pubdatatype_listform.js"></script>
<script language="javascript">
			var RES_PROMPT='<%=res.get("MSG.PROMOT")%>';
			var RES_NOCHANGE='<%=res.get("MSG.NOCHANGE")%>';
			var RES_SAVE='<%=res.get("MSG.SAVE")%>';
			var RES_DELETE='<%=res.get("ASK.DELETE")%>';
			var RES_UNVALIDATED='<%=res.get("MSG.UNVALIDATED")%>';
		</script>
<style type="text/css">
.FieldLabel{
	font:12px tahoma,arial,helvetica,sans-serif;
}
</style>
</head>
<body>

<model:datasets>
	<model:dataset id="dataTypeDs" enumName="BSP.DATATYPE_IS_ORGAN"
		 global="true" />
	<model:dataset id="inUseDs" enumName="BSP.IN_USE" autoLoad="true"
		global="true" />
	<model:dataset id="ds"  pageSize="-1"
		cmd="org.loushang.bsp.permit.pap.datatype.cmd.PubDataTypeQueryCommand"
		global="true">
		<model:record
			fromBean="org.loushang.bsp.permit.pap.datatype.dao.PubDataType"></model:record>
	</model:dataset>
</model:datasets>

<next:ViewPort><next:AnchorLayout>
<next:GridPanel id="editGridPanel" name="pubdatatypeGrid" anchor="100% 50%"
	stripeRows="true"  dataset="ds" stripeRows="true" border="false">
	<next:TopBar>
		<next:ToolBarItem symbol="->" />
		<next:ToolBarItem iconCls="add" text='<%=res.get("BUT.ADD")%>'
			handler="insert" />
		<next:ToolBarItem iconCls="remove" text='<%=res.get("BUT.REMOVE")%>'
			handler="del" />
		<next:ToolBarItem iconCls="save" text='<%=res.get("BUT.SAVE")%>'
			handler="save" />
		<next:ToolBarItem iconCls="undo" text='<%=res.get("BUT.UNDO")%>'
			handler="reset" />
	</next:TopBar>
	<next:Columns onRowSelect="RowSelect">
		<next:RowNumberColumn width="30" />	
		<next:CheckBoxColumn></next:CheckBoxColumn>
		<next:Column id="dataTypeName"
			header='<%=res.get("PUB_DATA_TYPE.DATA_TYPE_NAME")%>'
			field="dataTypeName" width="160">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="isOrgan"
			header='<%=res.get("PUB_DATA_TYPE.IS_ORGAN")%>' field="isOrgan"
			width="150" renderer="dataTypeRender">
			<next:TextField allowBlank="false" />
		</next:Column>

		<next:Column id="note" header='<%=res.get("PUB_DATA_TYPE.NOTE")%>'
			field="note" width="300">
			<next:TextField />
		</next:Column>

	</next:Columns>

</next:GridPanel>
<next:Panel anchor="100% 50%" border="false" autoScroll="true">
	<next:Html>
		<form id="editForm" dataset="ds" onsubmit="return false" class="L5form">
		<fieldset><legend>数据资源类型编辑</legend>

		<table  width="100%"  >
			<tr>
				<td class="FieldLabel"><%=res.get("PUB_DATA_TYPE.IS_ORGAN")%></td>
				<td class="FieldInput" ><select id="isOrgan_select"
					name="isOrgan" field="isOrgan" onchange="displayTable()">
					<option dataset="dataTypeDs"></option>
				</select><font color="red">*</font></td>
				<td class="FieldLabel" ><%=res.get("PUB_DATA_TYPE.DATA_TYPE_CODE")%></td>
				<td class="FieldInput"><input id="dataTypeCode_input" type="text"
					name="dataTypeCode" field="dataTypeCode"  /><font color="red">*</font>
				<img id="dataTypeCodeImg" src='<%=SkinUtils.getImage(request, "l5/help.gif")%>'
					style="cursor: hand;display:none" onclick="forHelp(this)" /></td>
			</tr>
			<tr>
				<td class="FieldLabel"><%=res.get("PUB_DATA_TYPE.DATA_TYPE_NAME")%></td>
				<td class="FieldInput"><input id="dataTypeName_input" type="text"
					name="dataTypeName" field="dataTypeName"  /><font color="red">*</font>
				</td>
				<td class="FieldLabel"><%=res.get("PUB_DATA_TYPE.NOTE")%></td>
				<td class="FieldInput" colspan="3"><input id="db_note"
					type="text" name="note" field="note" /></td>
			</tr>
			<tr id="sourceTableTr" style="display:none">
				<td class="FieldLabel"><%=res.get("PUB_DATA_TYPE.SOURCE_TABLE")%></td>
				<td class="FieldInput"><input type="text" name="sourceTable" id="sourceTable"
					field="sourceTable" /><font color="red">*</font></td>

				<td class="FieldLabel"><%=res.get("PUB_DATA_TYPE.SOURCE_TABLE_DES")%></td>
				<td class="FieldInput"><input type="text" name="sourceTableDes" id="sourceTableDes"
					field="sourceTableDes" /></td>
			</tr>
			<tr id="selColTr" style="display:none">
				<td class="FieldLabel"><%=res.get("PUB_DATA_TYPE.SEL_COL")%></td>
				<td class="FieldInput"><input type="text" name="selCol" id="selCol"
					field="selCol" /><font color="red">*</font></td>

				<td class="FieldLabel"><%=res.get("PUB_DATA_TYPE.SEL_COL_DES")%></td>
				<td class="FieldInput"><input type="text" name="selColDes" id="selColDes"
					field="selColDes" /><font color="red">*</font></td>
			</tr>
			<tr id="dispColTr" style="display:none">
				<td class="FieldLabel"><%=res.get("PUB_DATA_TYPE.DISP_COL")%></td>
				<td class="FieldInput"><input type="text" name="dispCol" id="dispCol"
					field="dispCol" /><font color="red">*</font></td>

				<td class="FieldLabel"><%=res.get("PUB_DATA_TYPE.DISP_COL_DES")%></td>
				<td class="FieldInput"><input type="text" name="dispColDes" id="dispColDes"
					field="dispColDes" /><font color="red">*</font></td>
			</tr>
			<tr id="isUseWhereTr" style="display:none">
				<td class="FieldLabel"><%=res.get("PUB_DATA_TYPE.IS_USE_WHERE")%></td>
				<td class="FieldInput">
				<input id="is_use_where_input" type="checkbox" onclick="onchecked(this)" >
				</input>
				<input type="text" id="rely_on_checkbox" name="whereCondition"
				 field="whereCondition" 
				onchange="check_correct(this)" style="display:none;width:80%" />
				</td>
				<td class="FieldLabel"></td>
				<td class="FieldInput" ></td>
			</tr>
	
		</table></fieldset>
		</form>
		
	</next:Html>
</next:Panel>
</next:AnchorLayout></next:ViewPort>
</body>
</html>
