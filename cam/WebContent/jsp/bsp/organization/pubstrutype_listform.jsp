
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ include file="/jsp/public/resources_jspdir.jsp"%>
<html>
<head>
<title>PUB_STRU_TYPE列表</title>
<script type="text/javascript">
			//ORGANTYPE.messType=确定
			var messType='<%=res.get("ORGAN.messType")%>';
			var messTypePrompt='<%=res.get("ORGAN.messTypePrompt")%>';
			//ORGANTYPE.Save.NoDataMess=没有需要保存的数据!
			var saveNoDataMess='<%=res.get("ORGAN.Save.NoDataMess")%>';
			var saveValidateMess='<%=res.get("ORGAN.Save.ValidateMess")%>';
			var saveValidateMessInputBigen='<%=res.get("ORGAN.Save.ValidateMessInputBigen")%>';
			var saveValidateMessInputEnd='<%=res.get("ORGAN.Save.ValidateMessInputEnd")%>';
			//ORGANTYPE.Save.SuccessMess="数据保存成功!
			var saveSuccessMess='<%=res.get("ORGAN.Save.SuccessMess")%>';
			//ORGANTYPE.Delete.PleaseSelectData=请选择要删除的记录！
			var deletePleaseSelectData='<%=res.get("ORGAN.Delete.PleaseSelectData")%>';
			//ORGANTYPE.Delete.SelectDataMess=你确定要删除吗？
			var deleteSelectDataMess='<%=res.get("ORGAN.Delete.SelectDataMess")%>';
			var msg_has_unlegal_char = '<%=res.get("MSG_HAS_UNLEGAL_CHAR")%>';
		</script>
<next:ScriptManager />
<script type="text/javascript" src="pubstrutype_listform.js"></script>
</head>
<body>
<model:datasets>
	<model:dataset id="ds"
		cmd="org.loushang.bsp.organization.cmd.PubStruTypeQueryCommand"
		method="query" global="true">
		<model:record
			fromBean="org.loushang.bsp.organization.data.StruTypeView">
		</model:record>
	</model:dataset>
</model:datasets>

<next:ViewPort>
<next:AnchorLayout>
<next:GridPanel notSelectFirstRow="true" id="editGridPanel" border="false"
	name="pubstrutypeGrid"  anchor="100% 70%" stripeRows="true"
	dataset="ds" >
	<next:TopBar>
		<next:ToolBarItem symbol='<%=res.get("StruType.gridTitle") %>'></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="edit" text="维护" handler="manager" />
		<next:ToolBarItem iconCls="add" text='<%=res.get("BUT.ADD") %>'
			handler="insert" />
		<next:ToolBarItem iconCls="delete" text='<%=res.get("BUT.REMOVE") %>'
			handler="del" />
		<next:ToolBarItem iconCls="save" text='<%=res.get("BUT.SAVE") %>'
			handler="save" />
		<next:ToolBarItem iconCls="undo" text='<%=res.get("BUT.UNDO") %>'
			handler="reset" />
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn width="30" />
		<next:CheckBoxColumn></next:CheckBoxColumn>
		<next:Column id="struType" header='<%=res.get("StruType.struType") %>'
			field="struType" width="80">
			<next:TextField allowBlank="false" />
		</next:Column>

		<next:Column id="typeName" header='<%=res.get("StruType.typeName") %>'
			field="typeName" width="160">
			<next:TextField allowBlank="false" />
		</next:Column>

		<next:Column id="rootId" header='<%=res.get("StruType.rootId") %>'
			field="rootId" width="160" hidden="true">
			<next:TextField allowBlank="false" />
		</next:Column>

		<next:Column id="rootName" header='<%=res.get("StruType.rootId") %>'
			field="rootName" width="160">
			<next:TextField allowBlank="false" />
		</next:Column>

		<next:Column id="isDefault" header="IS_DEFAULT" field="isDefault"
			width="80" hidden="true">
			<next:TextField allowBlank="false" />
		</next:Column>

		<next:Column id="note" header='<%=res.get("StruType.node") %>'
			field="note" width="280">
			<next:TextField />
		</next:Column>

		<next:Column id="inUse" header="IN_USE" field="inUse" width="80"
			hidden="true">
			<next:TextField allowBlank="false" />
		</next:Column>



	</next:Columns>

</next:GridPanel>
<next:Panel border="false">
	<next:Panel id="detail" border="false" >
		<next:Html>
			<form id="editForm" dataset="ds" onsubmit="return false" class="L5form">
			<fieldset><legend>
			<%=res.get("StruType.editTitle")%>
			</legend>
			<table border="0" width="100%">

				<tr>
					<td class="FieldLabel"><%=res.get("StruType.struType")%></td>
					<td class="FieldInput"><input type="text"
						name='<%=res.get("StruType.struType")%>' field="struType"
						readonly="readonly"  disabled /><font color="red">*</font></td>

					<td class="FieldLabel"><%=res.get("StruType.typeName")%></td>
					<td class="FieldInput"><input type="text"
						name='<%=res.get("StruType.typeName")%>' field="typeName"
						size="30" /><font color="red">*</font></td>
				</tr>
				<tr>
					<td class="FieldLabel"><%=res.get("StruType.rootId")%></td>
					<td class="FieldInput"><input type="text" id="rootName"
						name="rootName" field="rootName" readonly="readonly" disabled/> <font
						color="red">*</font></td>
					<input type="hidden" name="rootId" field="rootId" />
					<td class="FieldLabel"><%=res.get("StruType.node")%></td>
					<td class="FieldInput"><input type="text"
						name='<%=res.get("StruType.node")%>' field="note" style="width:300"
						maxlength="200" /></td>
					<input type="hidden" name="isDefault" field="isDefault" />
					<input type="hidden" name="inUse" field="inUse" />
				</tr>
			</table>
			</fieldset>
			</form>
		</next:Html>
	</next:Panel>
	<next:Panel id="insert"  border="false" hidden="true">
		<next:Html>
			<form id="editForm" dataset="ds" onsubmit="return false" class="L5form">
			<fieldset><legend>
			组织结构类型增加
			</legend>
			<table border="1" width="100%">
				<tr>
					<td class="FieldLabel"><%=res.get("StruType.struType")%></td>
					<td class="FieldInput"><input type="text"
						name='<%=res.get("StruType.struType")%>' field="struType" 
						 onchange="checkSpecialChar(this)"/><font
						color="red">*</font></td>

					<td class="FieldLabel"><%=res.get("StruType.typeName")%></td>
					<td class="FieldInput"><input type="text"
						name='<%=res.get("StruType.typeName")%>' field="typeName"
						size="30" /><font color="red">*</font></td>
				</tr>
				<tr>
					<td class="FieldLabel"><%=res.get("StruType.rootId")%></td>
					<input type="hidden" id="rootIdinput" name="rootId" field="rootId" />
					<td class="FieldInput"><input type="text" id="rootNameinput"
						name="rootName" field="rootName" readonly="readonly" /> <font
						color="red">*</font> <img
						src="<%=SkinUtils.getImage(request, "l5/help.gif")%>"
						style="cursor: hand" onclick="selectRootId()" /></td>

					<td class="FieldLabel"><%=res.get("StruType.node")%></td>
					<td class="FieldInput"><input type="text"
						name='<%=res.get("StruType.node")%>' field="note" style="width:300"
						maxlength="200" /></td>
					<input type="hidden" name="isDefault" field="isDefault" />
					<input type="hidden" name="inUse" field="inUse" />
				</tr>
			</table></fieldset>
			</form>
		</next:Html>
	</next:Panel>
</next:Panel></next:AnchorLayout>
</next:ViewPort>
</body>
</html>
