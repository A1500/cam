<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.portal.widget.PortalUtil" %>
<%
String webPath=PortalUtil.webPath(request);

%>
<html>
	<head>
		<style>a{TEXT-DECORATION:none}</style>
		<title>待办任务</title>
		<next:ScriptManager></next:ScriptManager>
		    <script type="text/javascript" src="<%=webPath %>/jsp/portal/js/Portlet.js"></script>
	</head>
	
<body>
<model:datasets>
 		<model:dataset id="defaultSubjectDaiBanDataset"	cmd="org.loushang.workflow.tasklist.taskinfo.cmd.DaiBanTaskQueryCmd" method="queryDaiBanTaskPortalInfo" autoLoad="false" global="true">
			<model:record >
				<model:field name="assignmentId" type="string" />
				<model:field name="subject" type="string" />
				<model:field name="procDefName" type="string" />	
				<model:field name="procCreateTime" type="string" />
			</model:record>
		</model:dataset>
		
</model:datasets>
<next:ViewPort>
	<next:BorderLayout>
		<next:Center>
<next:GridPanel id="defaultSubjectDefPanel" name="defaultSubjectDefPanel" anchor="100%" height="100%" dataset="defaultSubjectDaiBanDataset" frame="true" notSelectFirstRow="true">
				<next:Columns>
	   				<next:RowNumberColumn width="30"/>
					<next:Column header="委派实例id" field="assignmentId" width="10" hidden="true">
					</next:Column>
					<next:Column header="标题" field="subject" width="30%" renderer="addLink">
					</next:Column>
					<next:Column header="流程名称" field="procDefName" width="30%" renderer="addLink">
					</next:Column>
					<next:Column header="流程创建时间" field="procCreateTime" width="40%" >
					</next:Column>
				</next:Columns>
				<next:BottomBar>
					<next:PagingToolBar displayMsg="从第{0}条到{1}条，一共{2}条" displayInfo="true" dataset="defaultSubjectDaiBanDataset"/>
				</next:BottomBar>
</next:GridPanel>
	</next:Center>
	</next:BorderLayout>
</next:ViewPort>
</body>
<script type="text/javascript">
function init(){
	defaultSubjectDaiBanDataset.load();
}
//通过链接处理待办任务
function addLink(value,second,record)
{
	var assignmentId=record.get("assignmentId");
	return "<a href=\"javascript:dealDaiBanTask('"+assignmentId+"')\">"+value+"</a>";
}
//处理待办任务
function dealDaiBanTask(assignmentId)
{			
	var url="command/dispatcher/org.loushang.workflow.tasklist.forward.TaskListDispatcherCmd/daiBanTaskForward";
	var query="?assignmentId="+assignmentId;
	parent.L5.detailContent(url+query,"待办任务办理");
}

</script>