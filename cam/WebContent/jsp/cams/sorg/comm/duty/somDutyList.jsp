<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>

<html>
<!-- 社会组织职务管理-->
<head>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="somDutyList.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js") %>'></script>
</head>
<body>
<model:datasets>
	<model:dataset id="somDutyDS" cmd="com.inspur.cams.sorg.base.cmd.DicSomDutyQueryCmd" sortField="code">
		<model:record  fromBean="com.inspur.cams.sorg.base.data.DicSomDuty">
			<model:field name="code" type="string" rule="require|length{5}|number"/>
			<model:field name="name" type="string" rule="require|length{50}"/>
		</model:record>
	</model:dataset>
</model:datasets>

<next:Panel width="100%" border="0">
	<next:Html>
		<form class="L5form">
		<fieldset><legend>查询条件</legend>
		<table width="100%">
			<tr>
				<td class="FieldLabel" width="15%"><label>职务编码：</label></td>
				<td class="FieldInput" width="25%"><input type="text" id="dutyCode" /></td>
				<td class="FieldLabel" width="15%"><label>职务名称：</label></td>
				<td class="FieldInput" width="25%"><input type="text" id="dutyName" /></td>
				<td class="FieldButton" width="20%">
				<button onclick="forQuery();">查询</button>
				<button type="reset"">重置</button>
				</td>
			</tr>
		</table>
		</fieldset>
		</form>
	</next:Html>
</next:Panel>

<next:EditGridPanel id="dutyPanel" dataset="somDutyDS" height="99.9%"  width="100%" autoScroll="true">
	<next:TopBar>
		<next:ToolBarItem text='' id="displayItem"/>
		<next:ToolBarItem symbol="社会组织职务管理"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="增加" iconCls="add" handler="addDuty"></next:ToolBarItem>
		<next:ToolBarItem text="保存" iconCls="save" handler="saveDuty"></next:ToolBarItem>
		<next:ToolBarItem text="删除" iconCls="remove" handler="deleteDuty" ></next:ToolBarItem>
		<next:ToolBarItem text="取消" iconCls="undo" handler="undoDuty" ></next:ToolBarItem>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn/>
		<next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column header="职务编码"  id="code" field="code"  width="20%" sortable="true" editable="editableCode"><next:TextField allowBlank="false"/></next:Column>
		<next:Column header="职务名称"  id="name" field="name" width="20%" sortable="true" editable="editableName"><next:TextField allowBlank="false"/></next:Column>
	</next:Columns>	
	<next:BottomBar>
		<next:PagingToolBar dataset="somDutyDS" />
	</next:BottomBar>
</next:EditGridPanel>
</body>
</html>