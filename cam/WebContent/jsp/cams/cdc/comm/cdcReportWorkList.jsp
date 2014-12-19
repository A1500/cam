<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>填报工作列表</title>
<next:ScriptManager/>
<script type="text/javascript" src="cdcReportWorkList.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
</head>
<body>
<model:datasets>
	<model:dataset id="reportWorkDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcReportWorkQueryCmd" sortField="createTime" sortDirection="desc" pageSize="200">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcReportWork"/>
	</model:dataset>
	<model:dataset id="reportDataSet" enumName="CDC.REPORT_ID" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="workStatusDataSet" enumName="CDC.WORK_STATUS" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:Panel width="100%" border="0">
	<next:Html>
	<fieldset style="overflow:visible;" class="GroupBox">
	<legend class="GroupBoxTitle">查询条件</legend>
		<form class="L5form">
			<table border="1" width="100%">
				<tr>
					<td class="FieldLabel" style="width:10%">填报内容：</td>
					<td class="FieldInput" style="width:15%"><input type="text" id="reportDesc" style="width:80%"/></td>
					<td class="FieldLabel" style="width:10%">填报报表：</td>
					<td class="FieldInput" style="width:15%">
						<select id="reportId" field="reportId">
							<option dataset="reportDataSet"/>
						</select></td>
					<td class="FieldLabel" style="width:10%">填报日期：</td>
					<td class="FieldInput" style="width:15%"><input type="text" id="reportDate" style="width:80%"/></td>
				</tr>
				<tr>
					<td class="FieldLabel">工作状态：</td>
					<td class="FieldInput">
						<select id="status" field="status">
							<option dataset="workStatusDataSet"/>
						</select></td>
					<td class="FieldInput" colspan="4"><button onclick="query()">查询</button>&nbsp;&nbsp;&nbsp;&nbsp;<button type="reset">重置</button></td>
				</tr>
			</table>
		</form>
	</fieldset>
	</next:Html>
</next:Panel>
<next:EditGridPanel id="grid" dataset="reportWorkDataSet" width="100%" stripeRows="true" height="99.9%">
	<next:TopBar>
		<next:ToolBarItem symbol="->"/>
		<next:ToolBarItem iconCls="add" text="增加" handler="insert"/>
		<next:ToolBarItem iconCls="edit" text="修改" handler="update"/>
		<next:ToolBarItem iconCls="detail" text="明细" handler="detail"/>
		<next:ToolBarItem iconCls="select" text="开展工作" handler="start"/>
		<next:ToolBarItem iconCls="delete" text="结束工作" handler="stop"/>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn/>
		<next:RadioBoxColumn/>
		<next:Column field="reportDesc" header="填报内容" width="25%" sortable="false"/>
		<next:Column field="reportId" header="填报报表" width="15%" editable="false" sortable="true"><next:ComboBox dataset="reportDataSet"/></next:Column>
		<next:Column field="reportDate" header="填报日期" width="10%" sortable="true"/>
		<next:Column field="status" header="工作状态" width="10%" editable="false" sortable="true" align="center"><next:ComboBox dataset="workStatusDataSet"/></next:Column>
		<next:Column field="organName" header="发起单位名称" width="15%" editable="false" sortable="false"/>
		<next:Column field="createTime" header="创建时间" width="20%" sortable="true" align="center"/>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="reportWorkDataSet"/>
	</next:BottomBar>
</next:EditGridPanel>
</body>
</html>