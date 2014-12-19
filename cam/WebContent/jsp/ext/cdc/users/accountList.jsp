<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.extuser.util.ExtBspInfo"%>
<html>
<head>
<title>街道账号管理</title>
<next:ScriptManager/>
<%
	String userName = ExtBspInfo.getUserInfo(request).getUserName();
	String userId= ExtBspInfo.getUserInfo(request).getAreaCode();
	//String peopleArea= ExtBspInfo.getUserInfo(request).getAreaCode();
%>
<script type="text/javascript" src="accountList.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript">
	var userId='<%=userId.substring(0,9)+"000"%>';
	var userName='<%=userName%>';
</script>
</head>
<body>
<model:datasets>
	<model:dataset id="ds" cmd="com.inspur.cams.comm.extuser.cmd.ComExtUserQueryCmd" global="true" pageSize="1000">
		<model:record fromBean="com.inspur.cams.comm.extuser.data.ComExtUser"/>
	</model:dataset>
</model:datasets>
<next:Panel width="100%" border="0">
	<next:Html>
	<fieldset style="overflow:visible;" class="GroupBox">
	<legend class="GroupBoxTitle">查询条件</legend>
		<form class="L5form">
			<table border="1" width="100%">
				<tr>
					<td class="FieldLabel" style="width:10%">社区账号：</td>
					<td class="FieldInput" style="width:12%"><input type="text" id = "query_Code" /></td>
					<td class="FieldLabel" style="width:10%">单位名称：</td>
					<td class="FieldInput" style="width:12%"><input type="text" id = "query_name" /></td>
					<td class="FieldButton" style="width:20%"><button onclick="query()">查询</button>&nbsp;&nbsp;&nbsp;&nbsp;<button type="reset">重置</button></td>
				</tr>
			</table>
		</form>
	</fieldset>
	</next:Html>
</next:Panel>
<next:EditGridPanel id="selectedGrid"  dataset="ds" width="100%" stripeRows="true" height="99.9%" >
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="export" text="导出Excel" handler="exportExcel()"></next:ToolBarItem>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn></next:RowNumberColumn>
		<next:CheckBoxColumn></next:CheckBoxColumn>
		<next:Column field="userId" header="社区账号" width="150" sortable="false"/>
		<next:Column field="userName" header="单位名称" width="150" sortable="false"/>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds"/>
	</next:BottomBar>
</next:EditGridPanel>
</body>
</html>