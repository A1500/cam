
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ include file="/jsp/public/resources_jspdir.jsp" %>


<html>
	<head>
		<title>组织类型列表</title>
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
			//alert(messTypePrompt);
		</script>
		<next:ScriptManager />
		<script type="text/javascript" src="organtype_listform.js"></script>

	</head>
<body>

<model:datasets>
	<model:dataset id="parentOrganType" cmd="org.loushang.bsp.organization.cmd.OrganTypeQueryCommand"  autoLoad="true" sortField="ORGAN_TYPE" >
		<model:record>
			<model:field name="value" mapping="organType" type="string" />
			<model:field name="text" mapping="typeName" type="string" />
		</model:record>
	</model:dataset>
	<model:dataset id="ds" cmd="org.loushang.bsp.organization.cmd.OrganTypeQueryCommand" global="true" sortField="ORGAN_TYPE"  pageSize="-1">
		<model:record fromBean="org.loushang.bsp.share.organization.bean.OrganType"></model:record>
	</model:dataset>

</model:datasets>
<next:ViewPort>
<next:AnchorLayout>
<next:GridPanel border="false" id="editGridPanel" name="puborgantypeGrid" anchor="100% 70%" stripeRows="true" dataset="ds" notSelectFirstRow="true" autoScroll="true">
	<next:TopBar>
		<next:ToolBarItem symbol='<%=res.get("ORGANTYPE.gridTitle") %>' ></next:ToolBarItem>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem  iconCls="add" text="增加一级类型" handler="insertRoot"  />
		<next:ToolBarItem  iconCls="add" text="增加下级类型" handler="insertSub"  />
		<next:ToolBarItem  iconCls="remove" text='<%=res.get("BUT.REMOVE") %>' handler="del"  />
		<next:ToolBarItem iconCls="save"  text='<%=res.get("BUT.SAVE") %>' handler="save"/>
		<next:ToolBarItem iconCls="undo"  text='<%=res.get("BUT.UNDO") %>' handler="reset"/>
	</next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn width="30"/>
	    <next:CheckBoxColumn></next:CheckBoxColumn>
		<next:Column id="organ_Type" header='<%=res.get("ORGANTYPE.organType") %>'  field="organType"  width="150" sortable="true" >
			<next:TextField allowBlank="false" />
		</next:Column>

		<next:Column id="typeName" header='<%=res.get("ORGANTYPE.typeName") %>' field="typeName" width="200" sortable="true">
			<next:TextField allowBlank="false" />
		</next:Column>

		<next:Column id="parentType" header='<%=res.get("ORGANTYPE.parentType") %>' field="parentType" width="200" sortable="true" renderer="getParentTypeName">

		</next:Column>
			<next:Column id="inUse" header="inUse" field="inUse" width="100" hidden="true">
			<next:TextField allowBlank="false" />
		</next:Column>
	</next:Columns>
</next:GridPanel>
<next:Panel border="false" autoScroll="true" width="100%" height="100%">
<next:Panel id="update" border="false" autoScroll="true" height="100%" width="100%">
	<next:Html>
		<form id="editForm"   dataset="ds" onsubmit="return false" class="L5form">
		<fieldset>
		<legend>组织类型编辑</legend>
		<table border="1"  width="100%">
			<tr>
				<td  class="FieldLabel" ><%=res.get("ORGANTYPE.parentType") %></td>

				<td class="FieldInput" width="70%">
				<label id="parentTypeName" name="parentTypeName" field="parentType" renderer="getParentTypeName"/>
				</td>

				<input type="hidden" name="inUse" field="inUse"  />
			</tr>
	   		<tr>
				<td  class="FieldLabel" width="30%"><%=res.get("ORGANTYPE.organType") %></td>
				<td class="FieldInput" width="70%">
				<label id="organType" name="<%=res.get("ORGANTYPE.organType") %>" field="organType"/>
				</td>
			</tr>
			<tr>
				<td  class="FieldLabel" ><%=res.get("ORGANTYPE.typeName") %></td>
				<td class="FieldInput"><input type="text" name='<%=res.get("ORGANTYPE.typeName") %>' field="typeName" maxlength="20" /><font color="red">*</font> </td>
			</tr>
		</table></fieldset>
		</form>
   </next:Html>
</next:Panel>
<next:Panel id="insertRoot" border="false" hidden="true" autoScroll="true">
	<next:Html>
		<form id="editForm"   dataset="ds" onsubmit="return false"  class="L5form">
		<fieldset >
		<legend>组织类型编辑</legend>
		<table border="1"  width="100%" >
	   		<tr>
				<td  class="FieldLabel" width="30%">组织类型</td>

				<td class="FieldInput" width="70%"><input type="text" id="organType" name="organType" field="organType"  /> <font color="red">*必须为正整数</font></td>
			</tr>
			<tr>
				<td  class="FieldLabel" >组织类型名称</td>
				<td class="FieldInput"><input type="text" name="typeName" field="typeName" maxlength="20" /><font color="red">*</font> </td>
			</tr>
		</table></fieldset>
		</form>
   </next:Html>
</next:Panel>
<next:Panel id="insertSub"  hidden="true" border="false" autoScroll="true" autoHeight="true" autoWidth="true">
	<next:Html>
		<form id="editForm"   dataset="ds" onsubmit="return false"  class="L5form">
		<fieldset >
		<legend>组织类型编辑</legend>
		<table   width="100%" >
			<tr>
				<td  class="FieldLabel" ><%=res.get("ORGANTYPE.parentType") %></td>
				<td class="FieldInput" width="70%">
				<label type="text" id="parentTypeName" name="parentTypeName" field="parentType" renderer="getParentTypeName"/>
				</td>

				<input type="hidden" name="inUse" field="inUse"  />
			</tr>
	   		<tr>
				<td  class="FieldLabel" width="30%"><%=res.get("ORGANTYPE.organType") %></td>

				<td class="FieldInput" width="70%">
				<input type="text" name='<%=res.get("ORGANTYPE.organType") %>' field="organType"  label="fdssss"/><font color="red">*必须为正整数</font> 
				</td>
			</tr>
			<tr>
				<td  class="FieldLabel" ><%=res.get("ORGANTYPE.typeName") %></td>
				<td class="FieldInput">
				<input type="text" name='<%=res.get("ORGANTYPE.typeName") %>' field="typeName"  maxlength="20"/><font color="red">*</font> 
				</td>
			</tr>
		</table></fieldset>
		</form>
   </next:Html>
</next:Panel>
</next:Panel>
</next:AnchorLayout>
</next:ViewPort>
</body>
</html>
