<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<html>
	<head><style>a{TEXT-DECORATION:none}</style>
		<title>已办任务查询</title>
		<next:ScriptManager></next:ScriptManager>
		<script type="text/javascript" src="tasklistcommon.js"></script>
	</head>
<%
	//指定流程类型查询
	String procTypeId = request.getParameter("procTypeId");
	if(procTypeId==null){
		procTypeId ="";
	}
	//指定过滤流程类型查询	
	String exceptProcTypeIds = request.getParameter("exceptProcTypeIds");
	if(exceptProcTypeIds==null){
		exceptProcTypeIds="";
	}
%>
<body>

<model:datasets>
	<model:dataset pageSize="10" id="yiBanTaskDataset" cmd="org.loushang.workflow.tasklist.taskinfo.cmd.YiBanTaskQueryCmd" method="queryDefaultYiBanTaskGroupByProcessId" autoLoad="false" global="true">
		<model:record>
			<model:field name="assignmentId" type="string" />
			<model:field name="subject" type="string" />
			<model:field name="procDefName" type="string" />
			<model:field name="actDefName" type="string" />
			<model:field name="assEndTime" type="string" />
			<model:field name="activeActDefNames" type="string" />
			<model:field name="activeOrganNames" type="string" />
			<model:field name="procCreateTime" type="string" />
		</model:record>
	</model:dataset>
</model:datasets>

<next:ViewPort>
	<next:BorderLayout>
		<next:Defaults>{collapsible:true,split:true,animFloat:true,autoHide:true,useSplitTips:true,bodyStyle:'padding:6px;'}</next:Defaults>
		<next:Center floatable="true" cmargins="0 0 0 0" margins="0 0 0 0" >
			<next:Panel>
			<next:Panel width="100%" border="0" bodyStyle="padding-bottom:10px;padding-top:0px;">
				<next:Html>			
				<fieldset style="overflow: visible;" class="GroupBox">
					<legend class="GroupBoxTitle">查询条件
						<img class="GroupBoxExpandButton" src="<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>" onclick="collapse(this);"/>									
					</legend>
					<div class="GroupBoxDiv" style="width: 100%;height: 100%;">	
						<form onsubmit="return false;" class="L5form">				
							<table  border="1" width="100%">
								<tr>
									<td class="FieldLabel" width="15%">标题：</td>
									<td class="FieldInput"><input type="text"  id="subject" class="TextEditor" title="标题"  size="40"/></td>
									<td class="FieldLabel" width="15%">流程名称：</td>
									<td class="FieldInput"><input type="text"  id="procName" class="TextEditor" title="流程名称"  size="40"/></td>
									<td class="FieldButton" width="15%"><button onclick="query()">查询</button> </td>
								</tr>
							</table>
						</form>		
					</div>
				</fieldset>
				</next:Html>
			</next:Panel>			
			<next:GridPanel id="yiBanTaskGridPanel" name="yiBanTaskGridPanel" width="100%" height="100%" dataset="yiBanTaskDataset"     title="已办流程列表" notSelectFirstRow="true">
				<next:Columns>
	   				<next:RowNumberColumn width="30"/>
	    			<next:RadioBoxColumn></next:RadioBoxColumn>
					<next:Column id="assignmentId" header="内码" field="assignmentId" width="50" hidden="true" >
					<next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column header="标题" field="subject" width="150" renderer="addLink">
						<next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column header="流程名称" field="procDefName" width="150" renderer="addLink">
						<next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column header="流程发起时间" field="procCreateTime" width="150" >
						<next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column header="已办环节" field="actDefName" width="150" >
						<next:TextField allowBlank="false"/>
					</next:Column>	
					<next:Column  header="办理时间" field="assEndTime"  width="150" >
						<next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column header="当前活动环节" field="activeActDefNames" width="150" >
						<next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column header="当前活动环节处理人" field="activeOrganNames" width="150" >
						<next:TextField allowBlank="false"/>
					</next:Column>												
				</next:Columns>
				<next:TopBar>	
					<next:ToolBarItem symbol="->"></next:ToolBarItem>		
					<next:ToolBarItem iconCls="select"  text="查看" handler="handle"/>
					<next:ToolBarItem iconCls="detail"  text="查看流转状态" handler="showState"/>
				</next:TopBar>
				<next:BottomBar>
					<next:PagingToolBar displayMsg="从第{0}条到{1}条，一共{2}条" displayInfo="true" dataset="yiBanTaskDataset"/>
				</next:BottomBar>
			</next:GridPanel>
			</next:Panel>
		</next:Center>
	</next:BorderLayout>
</next:ViewPort>
</body>
<script language="javascript"  type="text/javascript" >
//查询条件面板打开合并函数
function collapse(element){
	var fieldsetParent=L5.get(element).findParent("fieldset");
	if(element.expand==null||element.expand==true){	
		fieldsetParent.getElementsByTagName("div")[0].style.display="none";
		element.src = '<%=SkinUtils.getImage(request,"groupbox_expand.gif")%>';
		element.expand=false;
	}else{
		fieldsetParent.getElementsByTagName("div")[0].style.display="";
		element.src = "<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>";
		element.expand =true;
	}
}

function init(){
	//要查询的流程类型或要过滤掉的流程类型
	var procTypeId ="<%=procTypeId%>";
	var exceptProcTypeIds="<%=exceptProcTypeIds%>";
	if(procTypeId !=""){
		yiBanTaskDataset.setParameter("procTypeId",procTypeId);
	}
	if(exceptProcTypeIds !=""){
		yiBanTaskDataset.setParameter("exceptProcTypeIds",exceptProcTypeIds);
	}
	yiBanTaskDataset.load();
}

//已办任务查询
function query()
{
	//要查询的流程类型或要过滤掉的流程类型
	var procTypeId ="<%=procTypeId%>";
	var exceptProcTypeIds="<%=exceptProcTypeIds%>";
	if(procTypeId !=""){
		yiBanTaskDataset.setParameter("procTypeId",procTypeId);
	}
	if(exceptProcTypeIds !=""){
		yiBanTaskDataset.setParameter("exceptProcTypeIds",exceptProcTypeIds);
	}
	var subject=document.getElementById("subject").value;
	var procName=document.getElementById("procName").value;			 	
	if(subject!=""){
	  yiBanTaskDataset.setParameter("WF_SUBJECT",subject);
	}
	if(procName!="")
	{
		yiBanTaskDataset.setParameter("PROC_DEF_NAME",procName);
	}
	yiBanTaskDataset.load();
}

//通过链接处理已办任务
function addLink(value,second,record)
{
	var assignmentId=record.get("assignmentId");
	return "<a href=\"javascript:dealYiBanTask('"+assignmentId+"')\">"+value+"</a>";
}

//通过按钮处理已办任务
function handle()
{
	var userGrid=L5.getCmp('yiBanTaskGridPanel');
	var selected = userGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		alert("请选择一条记录进行处理!");
		return false;
	}
	var rec=selected[0];
	dealYiBanTask(rec.get("assignmentId"));
}

//处理已办任务
function dealYiBanTask(assignmentId)
{			
	var url="command/dispatcher/org.loushang.workflow.tasklist.forward.TaskListDispatcherCmd/yiBanTaskForward";
	var query="?assignmentId="+assignmentId;
	L5.forward(url+query,"办理");
}

//查看流程状态图
function showState()
{
   var yiBanTaskGridPanel=L5.getCmp("yiBanTaskGridPanel");
   showprocessstate(yiBanTaskGridPanel,"yiban","jsp/workflow/tasklist/queryyibangroupbyprocessId.jsp");
}
</script>
</html>