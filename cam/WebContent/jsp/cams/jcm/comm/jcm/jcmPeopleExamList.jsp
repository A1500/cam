<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>人员培训信息（多条记录过程）列表</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="jcmPeopleExamList.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
</head>
<body>
<model:datasets>
	<model:dataset id="jcmPeopleExamDataSet" cmd="com.inspur.cams.jcm.cmd.JcmPeopleExamQueryCmd" pageSize="200">
		<model:record fromBean="com.inspur.cams.jcm.data.JcmPeopleExam"/>
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
<next:EditGridPanel id="grid" dataset="jcmPeopleExamDataSet" width="100%" stripeRows="true" height="99.9%">
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
		<next:Column field="peopleExamId" header="培训主键" width="30%" sortable="false"/>
		<next:Column field="peopleId" header="人员主键" width="30%" sortable="false"/>
		<next:Column field="examYear" header="培训年度" width="30%" sortable="false"/>
		<next:Column field="examContent" header="培训内容" width="30%" sortable="false"/>
		<next:Column field="examTime" header="培训时间" width="30%" sortable="false"/>
		<next:Column field="examPlace" header="培训地点" width="30%" sortable="false"/>
		<next:Column field="isExam" header="是否考试" width="30%" sortable="false"/>
		<next:Column field="examRuslut" header="考试结果" width="30%" sortable="false"/>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="jcmPeopleExamDataSet"/>
	</next:BottomBar>
</next:EditGridPanel>
</body>
</html>