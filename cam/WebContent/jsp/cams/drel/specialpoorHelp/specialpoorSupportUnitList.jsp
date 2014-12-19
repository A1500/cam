<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>特殊困难帮扶单位信息表列表</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="specialpoorSupportUnitList.js"></script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
</head>
<body>
<model:datasets>
	<model:dataset id="specialpoorSupportUnitDataSet"
		cmd="com.inspur.cams.drel.special.cmd.SpecialpoorSupportUnitQueryCmd"
		sortField="SUPPORT_UNIT_TYPE_CODE,SUPPORT_UNIT_SN" pageSize="20">
		<model:record
			fromBean="com.inspur.cams.drel.special.data.SpecialpoorSupportUnit" />
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
				<td class="FieldButton" style="width: 20%" colspan="4">
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
<next:EditGridPanel id="grid" dataset="specialpoorSupportUnitDataSet"
	width="100%" stripeRows="true" height="99.9%">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="add" text="增加" handler="insert"></next:ToolBarItem>
		<next:ToolBarItem iconCls="edit" text="修改" handler="update"></next:ToolBarItem>
		<next:ToolBarItem iconCls="detail" text="明细" handler="detail"></next:ToolBarItem>
		<next:ToolBarItem iconCls="delete" text="删除" handler="del"></next:ToolBarItem>
		<next:ToolBarItem iconCls="export" text="导出Excel" handler="exportExcel"></next:ToolBarItem>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn></next:RowNumberColumn>
		<next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column field="supportUnitCode" header="帮扶单位代码" width="100"
			sortable="false" />
		<next:Column field="supportUnitName" header="帮扶单位名称" width="150"
			sortable="false" />
		<next:Column field="supportUnitTypeName" header="单位类型名称" width="100"
			sortable="false" />
		<next:Column field="supportCountyCode" header="帮扶区县代码" width="100"
			sortable="false" />
		<next:Column field="supportCountyName" header="帮扶区县名称" width="100"
			sortable="false" />
		<next:Column field="supportTownCode" header="帮扶镇级代码" width="100"
			sortable="false" />
		<next:Column field="supportTownName" header="帮扶镇级名称" width="100"
			sortable="false" />
		<next:Column field="supportVillageName" header="帮扶村名称" width="180"
			sortable="false" />
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="specialpoorSupportUnitDataSet" />
	</next:BottomBar>
</next:EditGridPanel>
</body>
</html>