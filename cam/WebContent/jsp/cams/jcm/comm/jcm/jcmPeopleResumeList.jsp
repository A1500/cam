<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>人员简历信息(多条记录)列表</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="jcmPeopleResumeList.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
</head>
<body>
<model:datasets>
	<model:dataset id="jcmPeopleResumeDataSet" cmd="com.inspur.cams.jcm.cmd.JcmPeopleResumeQueryCmd" pageSize="200">
		<model:record fromBean="com.inspur.cams.jcm.data.JcmPeopleResume"/>
	</model:dataset>
</model:datasets>
<next:Panel width="100%" border="0">
	<next:Html>
	<fieldset style="overflow:visible;" class="GroupBox">
	<legend class="GroupBoxTitle">查询条件</legend>
		<form class="L5form">
			<table border="1" width="100%">
				<tr>
					<td class="FieldButton" style="width:20%"><button onclick="query()">查询</button>&nbsp;&nbsp;&nbsp;&nbsp;<button type="reset">重置</button></td>
				</tr>
			</table>
		</form>
	</fieldset>
	</next:Html>
</next:Panel>
<next:EditGridPanel id="grid" dataset="jcmPeopleResumeDataSet" width="100%" stripeRows="true" height="99.9%">
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
		<next:Column field="peopleId" header="人员主键" width="30%" sortable="false"/>
		<next:Column field="resumeId" header="j简历主键" width="30%" sortable="false"/>
		<next:Column field="timeInfo" header="时间段" width="30%" sortable="false"/>
		<next:Column field="unit" header="单位" width="30%" sortable="false"/>
		<next:Column field="duitInfo" header="任职情况" width="30%" sortable="false"/>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="jcmPeopleResumeDataSet"/>
	</next:BottomBar>
</next:EditGridPanel>
</body>
</html>