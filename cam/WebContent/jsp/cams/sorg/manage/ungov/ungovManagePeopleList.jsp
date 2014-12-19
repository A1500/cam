<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>民办非企业单位负责人备案管理</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="ungovManagePeopleList.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript">
	<%
		String morgArea=BspUtil.getOrganCode();
	%>
	var morgArea='<%=morgArea%>';
</script>
</head>
<body>

<model:datasets>
	<model:dataset id="somOrganDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomOrganQueryCmd" pageSize="20">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOrgan"/>
	</model:dataset>
	<model:dataset id="yesornoDataSet" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
</model:datasets>

<next:Panel width="100%" border="0">
	<next:Html>
	<fieldset style="overflow:visible;" class="GroupBox">
	<legend class="GroupBoxTitle">查询条件</legend>
		<form class="L5form">
			<table border="1" width="100%">
				<tr>
					<td class="FieldLabel" style="width:15%">单位名称：</td>
					<td class="FieldInput" style="width:25%"><input type="text" id="cnName" style="width:80%"/></td>
					<td class="FieldLabel" style="width:15%">登记证号：</td>
					<td class="FieldInput" style="width:25%"><input type="text" id="sorgCode" style="width:80%"/></td>
					<td class="FieldButton" style="width:20%">
						<button onclick="queryItem()">查询</button>&nbsp;&nbsp;&nbsp;&nbsp;
						<button type="reset">重置</button>
					</td>
				</tr>
			</table>
		</form>
	</fieldset>
	</next:Html>
</next:Panel>
<next:EditGridPanel id="grid" dataset="somOrganDataSet" width="100%" stripeRows="true" height="99.9%">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="add" text="换届备案" handler="insert"></next:ToolBarItem>
		<next:ToolBarItem iconCls="edit" text="负责人管理" handler="update"></next:ToolBarItem>
		<next:ToolBarItem iconCls="detail" text="查看" handler="detail"></next:ToolBarItem>
		<next:ToolBarItem iconCls="detail" text="查看历史" handler="his"></next:ToolBarItem>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn></next:RowNumberColumn>
		<next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column field="cnName" header="民办非企业单位名称" width="30%" sortable="false"></next:Column>
		<next:Column field="sorgCode" header="登记证号" width="15%" sortable="false"></next:Column>
		<next:Column field="morgName" header="登记管理机关" width="30%" sortable="false"></next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="somOrganDataSet"/>
	</next:BottomBar>
</next:EditGridPanel>
</body>
</html>