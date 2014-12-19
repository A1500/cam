<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<html>
	<head><style>a{TEXT-DECORATION:none}</style>
		<title>监控任务查询</title>
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
	<model:dataset pageSize="10" id="monitorTaskDataset" cmd="org.loushang.workflow.tasklist.taskinfo.cmd.MonitorTaskQueryCmd" autoLoad="false" global="true">
		<model:record>
			<model:field name="assignmentId" type="string" />
			<model:field name="subject" type="string" />
			<model:field name="procDefName" type="string" />
			<model:field name="actDefName" type="string" />
			<model:field name="organName" type="string" />
			<model:field name="assCreateTime" type="string" />
			<model:field name="procCreateTime" type="string" />
			<model:field name="actLimitTime" type="string" />
			<model:field name="procLimitTime" type="string" />
		</model:record>
	</model:dataset>
</model:datasets>

<next:ViewPort>
	<next:BorderLayout>
		<next:Defaults>{collapsible:true,split:true,animFloat:true,autoHide:true,useSplitTips:true,bodyStyle:'padding:6px;'}</next:Defaults>
		<next:Center floatable="true" cmargins="0 0 0 0" margins="0 0 0 0" >
			<next:Panel>
			<next:AnchorLayout>
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
			<next:GridPanel id="monitorTaskGridPanel" name="monitorTaskGridPanel" anchor="100%" height="100%" dataset="monitorTaskDataset"     title="监控流程列表" notSelectFirstRow="true">
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
					<next:Column header="当前环节" field="actDefName" width="150" >
						<next:TextField allowBlank="false"/>
					</next:Column>	
					<next:Column id="id" header="当前环节处理人" field="organName"  width="100" >
						<next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column header="任务到达时间" field="assCreateTime" width="150" >
						<next:TextField allowBlank="false"/>
					</next:Column>					
					<next:Column header="环节限时时间" field="actLimitTime" width="150" >
						<next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column header="流程限时时间" field="procLimitTime" width="150" >
						<next:TextField allowBlank="false"/>
					</next:Column>	
				</next:Columns>
				<next:TopBar>
					<next:ToolBarItem symbol="->"></next:ToolBarItem>			
					<next:ToolBarItem iconCls="select"  text="查看" handler="handle"/>
					<next:ToolBarItem iconCls="detail"  text="查看流转状态" handler="showState"/>
				</next:TopBar>
				<next:BottomBar>
					<next:PagingToolBar displayMsg="从第{0}条到{1}条，一共{2}条" displayInfo="true" dataset="monitorTaskDataset"/>
				</next:BottomBar>
			</next:GridPanel>
			</next:AnchorLayout>
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
		monitorTaskDataset.setParameter("procTypeId",procTypeId);
	}
	if(exceptProcTypeIds !=""){
		monitorTaskDataset.setParameter("exceptProcTypeIds",exceptProcTypeIds);
	}
	monitorTaskDataset.load();
}
//监控任务查询
function query(){
			 	var monitorTaskDataset = L5.DatasetMgr.lookup("monitorTaskDataset");
			 	var subject=document.getElementById("subject").value;
			 	if(subject.indexOf("'")!=-1){
			 		  L5.Msg.alert("提示", "不接受单引号输入!");
			 		  return;
			 	}				 	
			 	if(subject!="") {
			 	monitorTaskDataset.setParameter("WF_SUBJECT",subject);
			 	}
			 	var procName=document.getElementById("procName").value;	
			 	if(procName.indexOf("'")!=-1){
			 		  L5.Msg.alert("提示", "不接受单引号输入!");
			 		  return;
			 	}	
			 	if(procName!="")
			 	{
			 		monitorTaskDataset.setParameter("PROC_DEF_NAME",procName);
				 }
			 	monitorTaskDataset.load();
			 }

			 //通过链接处理监控任务
			 function addLink(value,second,record)
			 {
				var assignmentId=record.get("assignmentId");
				return "<a href=\"javascript:dealMonitorTask('"+assignmentId+"')\">"+value+"</a>";
			 }
			 //通过按钮处理监控任务
			 function handle()
			 {
				var userGrid=L5.getCmp('monitorTaskGridPanel');
				var selected = userGrid.getSelectionModel().getSelections();
				if(selected.length!=1){
					alert("请选择一条记录进行处理!");
					return false;
				}
				var rec=selected[0];
				dealMonitorTask(rec.get("assignmentId"));
			 }
			 //处理监控任务
			 function dealMonitorTask(assignmentId)
			 {			
				var url="command/dispatcher/org.loushang.workflow.tasklist.forward.TaskListDispatcherCmd/monitorTaskForward";
				var query="?assignmentId="+assignmentId;
				L5.forward(url+query,"办理");
			 }
			 
			 //查看流程状态图
          function showState(){
	          var monitorTaskGridPanel=L5.getCmp("monitorTaskGridPanel");
	          showprocessstate(monitorTaskGridPanel,"monitor","jsp/workflow/tasklist/querymonitor.jsp");
          }
</script>
</html>