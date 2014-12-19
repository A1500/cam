<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.extuser.util.ExtBspInfo"%>
<html>
<head>
<title>农村社区下辖村列表</title>
<next:ScriptManager></next:ScriptManager>
<%
	String organName = ExtBspInfo.getUserInfo(request).getUserName();
	String organId= ExtBspInfo.getUserInfo(request).getAreaCode();
	//String peopleArea= ExtBspInfo.getUserInfo(request).getAreaCode();
%>
<script type="text/javascript" src="villageList.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript">
	var userId='<%=request.getParameter("userId")%>';
	var userName='<%=request.getParameter("userName")%>';
	userName=decodeURIComponent(userName);
	var organId='<%=organId.substring(0,9)+"000"%>';
	var organName='<%=organName%>';
</script>
</head>
<body>
<model:datasets>
	<model:dataset id="ds" cmd="com.inspur.cams.comm.extuser.cmd.ComExtUserQueryCmd">
		<model:record fromBean="com.inspur.cams.comm.extuser.data.ComExtUser"/>
	</model:dataset>
	<model:dataset id="cityDs" cmd="com.inspur.cams.comm.diccity.cmd.DicCityQueryCommand" pageSize="15" method="queryCity">
	</model:dataset>
</model:datasets>
<next:ViewPort>
	<next:TabPanel width="100%" height="100%">
		<next:Tabs>
			<next:Panel title="农村社区管理" width="100%" height="100%" autoHeight="true" >
<next:Panel width="100%" border="0">
	<next:Html>
	<fieldset style="overflow:visible;" class="GroupBox">
	<legend class="GroupBoxTitle">查询条件</legend>
		<form class="L5form">
			<table border="1" width="100%">
				<tr>
					<td class="FieldLabel" style="width:10%">单位名称：</td>
					<td class="FieldInput" style="width:12%"><input type="text" id = "query_name" /></td>
					<td class="FieldButton" style="width:20%"><button onclick="query()">查询</button>&nbsp;&nbsp;&nbsp;&nbsp;<button type="reset">重置</button></td>
				</tr>
			</table>
		</form>
	</fieldset>
	</next:Html>
</next:Panel>
<next:EditGridPanel id="grid" dataset="ds" width="100%" stripeRows="true" height="100%" >
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="save" text="保存" handler="save"></next:ToolBarItem>
		<next:ToolBarItem iconCls="add" text="选择下辖村" handler="insert"></next:ToolBarItem>
		<next:ToolBarItem iconCls="delete" text="移除" handler="del"></next:ToolBarItem>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn></next:RowNumberColumn>
		<next:CheckBoxColumn></next:CheckBoxColumn>
		<next:Column field="userId" header="区划代码" width="150" sortable="false"/>
		<next:Column field="userName" header="单位名称" width="150" sortable="false"/>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds"/>
	</next:BottomBar>
</next:EditGridPanel>
</next:Panel>
</next:Tabs>
</next:TabPanel>
</next:ViewPort>
</body>
</html>
<!-- 选择下辖村窗口 -->
<next:Window id="villageWin" closeAction="hide" title="选择下辖村"
	height="550" width="400" modal="true" modal="true">
	<next:Panel width="98%" height="100%" border="0" autoScroll="true" autoHeight="true" >
		<next:Panel width="100%" border="0" autoScroll="true" autoHeight="true">
			<next:Html>
				<fieldset style="overflow: visible;" class="GroupBox"><legend
					class="GroupBoxTitle">查询条件</legend>
				<form class="L5form">
				<table border="1" width="100%">
					<tr>
						<td class="FieldLabel"><label>单位名称:</label></td>
						<td class="FieldInput"><input type="text" id="queryVillage" /></td>
						<td class="FieldButton"><button onclick="queryUser()">查询</button></td>
					</tr>
				</table>
				</form>
				</fieldset>
			</next:Html>
		</next:Panel>
		<next:GridPanel id="selectedGrid" dataset="cityDs"
			width="100%" stripeRows="true" height="440" notSelectFirstRow="true">
			<next:TopBar>
				<next:ToolBarItem symbol="下辖村信息"></next:ToolBarItem>
				<next:ToolBarItem symbol="->"></next:ToolBarItem>
				<next:ToolBarItem iconCls="add" text="添加" handler="addAgain"></next:ToolBarItem>
				<next:ToolBarItem iconCls="return" text="关闭" handler="closeWin"></next:ToolBarItem>
			</next:TopBar>
			<next:Columns>
				<next:RowNumberColumn></next:RowNumberColumn>
				<next:CheckBoxColumn></next:CheckBoxColumn>
				<next:Column field="ID" header="区划代码" width="150" sortable="false"/>
				<next:Column field="NAME" header="单位名称" width="150" sortable="false"/>
			</next:Columns>
			<next:BottomBar>
				<next:PagingToolBar dataset="cityDs" />
			</next:BottomBar>
		</next:GridPanel>
	</next:Panel>
</next:Window>