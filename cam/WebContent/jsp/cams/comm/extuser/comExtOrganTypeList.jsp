<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="comExtOrganTypeList.js"></script>
</head>
<body>
<model:datasets>
	<model:dataset id="comExtOrganType" autoLoad="true" cmd="com.inspur.cams.comm.extuser.cmd.ComExtOrganQueryCmd" pageSize="65535" >
		<model:record fromBean="com.inspur.cams.comm.extuser.data.ComExtOrganType">
			<model:field name="code" type="string" rule="require|length{2}"/>
			<model:field name="name" type="string" rule="require|length{100}|custom{fn:checkQuotein,min:2}"/>
		</model:record>
	</model:dataset>
</model:datasets>
<next:Panel width="100%" border="0">
	<next:Html>
		<form class="L5form">
		<fieldset><legend>查询条件</legend>
		<table width="100%">
			<tr>
				<td class="FieldLabel">单位类型：</td>
				<td class="FieldInput"><input type="text" id="code"/></td>
				<td class="FieldLabel">单位类型名称：</td>
				<td class="FieldInput"><input type="text" id="name"/></td>
				<td class="FieldButton"><button onclick="forQuery()">查询</button></td>
				<td class="FieldButton"><button type="reset">重置</button></td>
			</tr>
		</table>
		</fieldset>
		</form>
	</next:Html>
</next:Panel>

<next:EditGridPanel id="hlistPanel" dataset="somBorgList" height="100%"  width="100%">
	<next:TopBar>
		<next:ToolBarItem text='' id="displayItem"/>
		<next:ToolBarItem symbol="单位类型管理"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="保存" iconCls="add" handler="newBorg"></next:ToolBarItem>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn/>
			<next:CheckBoxColumn></next:CheckBoxColumn>
			<next:Column header="主管单位级别" field="borgLevel" width="15%" editable="false" dataset="borgLevel"><next:TextField/></next:Column>
			<next:Column header="主管单位类型"  field="borgType" width="15%"><next:TextField/></next:Column>
			<next:Column header="主管单位名称" field="borgName" width="20%"><next:TextField/></next:Column>
	</next:Columns>
</next:EditGridPanel>
</body>
</html>