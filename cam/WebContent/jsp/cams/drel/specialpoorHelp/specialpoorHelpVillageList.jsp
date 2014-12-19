<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>帮包村信息表列表</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript">
	var defOrgan = "";
</script>
<script type="text/javascript" src="specialpoorHelpVillageList.js"></script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
</head>
<body>
<model:datasets>
	<model:dataset id="specialpoorHelpVillageDataSet"
		cmd="com.inspur.cams.drel.special.cmd.SpecialpoorHelpVillageQueryCmd"
		pageSize="20" sortField="HELP_VILLAGE_CODE">
		<model:record
			fromBean="com.inspur.cams.drel.special.data.SpecialpoorHelpVillage" />
	</model:dataset>
	<!-- 是否 -->
	<model:dataset id="commYesOrNoDS" enumName="COMM.YESORNO"
		autoLoad="true" global="true">
	</model:dataset>
</model:datasets>
<next:Panel width="100%" border="0">
	<next:Html>
		<fieldset style="overflow: visible;" class="GroupBox"><legend
			class="GroupBoxTitle">查询条件</legend>
		<form class="L5form">
		<table border="1" width="100%">
			<tr>
				<td class="FieldLabel">帮包村代码:</td>
				<td class="FieldInput"><input type="text" id="qHelpVillageCode"
					class="TextEditor" title="帮包村代码" /></td>
				<td class="FieldLabel">帮包村名称:</td>
				<td class="FieldInput"><input type="text" id="qHelpVillageName"
					class="TextEditor" title="帮包村名称" style="width: 200" /></td>
				<td class="FieldButton" style="width: 20%">
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
<next:EditGridPanel id="grid" dataset="specialpoorHelpVillageDataSet"
	width="100%" stripeRows="true" height="99.9%">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="add" text="增加" handler="insert"></next:ToolBarItem>
		<next:ToolBarItem iconCls="edit" text="修改" handler="update"></next:ToolBarItem>
		<next:ToolBarItem iconCls="detail" text="明细" handler="detail"></next:ToolBarItem>
		<next:ToolBarItem iconCls="delete" text="删除" handler="del"></next:ToolBarItem>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn></next:RowNumberColumn>
		<next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column field="helpVillageCode" header="帮包村代码" width="135"
			sortable="false" />
		<next:Column field="helpVillageName" header="帮包村名称" width="220"
			sortable="false" />
		<next:Column field="helpVillageFlag" header="是否有效" width="80"
			sortable="false" dataset="commYesOrNoDS" align="center" />
		<next:Column field="supportUnitCode" header="帮扶单位代码" width="30%"
			sortable="false" hidden="true" />
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="specialpoorHelpVillageDataSet" />
	</next:BottomBar>
</next:EditGridPanel>
</body>
</html>