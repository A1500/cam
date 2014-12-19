<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>帮扶关系表列表</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="specialpoorSupportRefList.js"></script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
</head>
<body>
<model:datasets>
	<model:dataset id="specialpoorSupportRefDataSet"
		cmd="com.inspur.cams.drel.special.cmd.SpecialpoorSupportRefQueryCmd"
		pageSize="10" method="querySpecialpoorSupportRef">
		<model:record
			fromBean="com.inspur.cams.drel.special.data.SpecialpoorSupportRef" />
	</model:dataset>
</model:datasets>
<next:Panel width="100%" border="0">
	<next:Html>
		<fieldset style="overflow: visible;" class="GroupBox"><legend
			class="GroupBoxTitle">查询条件</legend>
		<form class="L5form">
		<table border="1" width="100%">
			<tr>
				<td class="FieldLabel">帮包单位代码:</td>
				<td class="FieldInput"><input type="text" id="qSupportUnitCode"
					class="TextEditor" title="帮包单位代码" /></td>
				<td class="FieldLabel">帮包单位名称:</td>
				<td class="FieldInput"><input type="text" id="qSupportUnitName"
					class="TextEditor" title="帮包单位名称" style="width: 200" /></td>
			</tr>
			<tr>
				<td class="FieldLabel" colspan="4" align="right">
				<button onclick="query()">查询</button>
				&nbsp;&nbsp;&nbsp;&nbsp;
				<button type="reset">重置</button>
				</td>
			</tr>
		</table>
		</form>
		</fieldset>
	</next:Html>
</next:Panel>

<next:GridPanel id="gridPanel" name="gridPanel" width="100%"
	height="100%" dataset="specialpoorSupportRefDataSet">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="维护" iconCls="edit" handler="update"></next:ToolBarItem>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn />
		<next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column header="帮扶单位" field="SUPPORT_UNIT_NAME" width="220">
			<next:TextField editable="false" />
		</next:Column>
		<next:Column header="帮包村" field="HELP_VILLAGE_NAME" width="530">
			<next:TextField editable="false" />
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="specialpoorSupportRefDataSet" />
	</next:BottomBar>
</next:GridPanel>
</body>
</html>