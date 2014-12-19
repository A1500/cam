<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next" %>
<%@ taglib uri="/tags/next-model" prefix="model" %>
<%@ page import="org.loushang.next.skin.SkinUtils;"%>
<html>
<head>
<title>民办非企业单位列表</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript">
	var procTypeId = 'somUngovPrepare';//流程类型ID	
</script>
</head>
<body>

<%--定义dataset--%>
<model:datasets>
	<!-- 待办任务 -->
	<model:dataset pageSize="10" id="daiBanDataset" cmd="org.loushang.workflow.tasklist.taskinfo.cmd.DaiBanTaskQueryCmd" autoLoad="false" global="true">
		<model:record>
			<model:field name="assignmentId" type="string" />
			<model:field name="subject" type="string" />
			<model:field name="activityId" type="string" />
			<model:field name="actDefUniqueId" type="string" />
			<model:field name="actDefName" type="string" />
			<model:field name="actLimitTime" type="string" />
			<model:field name="actWarnTime" type="string" />
			<model:field name="procDefName" type="string" />
			<model:field name="procCreateTime" type="string" />
			<model:field name="preActDefNames" type="string" />
			<model:field name="preOrganNames" type="string" />
			<model:field name="processId" type="string" />
		</model:record>
	</model:dataset>
	<!-- 已办任务 -->
	<model:dataset pageSize="10" id="yiBanTaskDataset" cmd="org.loushang.workflow.tasklist.taskinfo.cmd.YiBanTaskQueryCmd" autoLoad="false" global="true">
		<model:record>
			<model:field name="assignmentId" type="string" />
			<model:field name="subject" type="string" />
			<model:field name="activeActDefNames" type="string" />
			<model:field name="activeOrganNames" type="string" />
			<model:field name="actDefName" type="string" />
			<model:field name="endTime" type="string"/>
			<model:field name="procCreateTime" type="string" />
			<model:field name="procDefName" type="string" />
			<model:field name="processId" type="string" />
		</model:record>
	</model:dataset>
	<!-- 结束任务 -->
	<model:dataset pageSize="10" id="endTaskDataset" cmd="org.loushang.workflow.tasklist.taskinfo.cmd.EndTaskQueryCmd" autoLoad="false" global="true">
		<model:record>
			<model:field name="assignmentId" type="string" />
			<model:field name="subject" type="string" />
			<model:field name="endTime" type="string" />
			<model:field name="actDefName" type="string" />
			<model:field name="procDefName" type="string" />
			<model:field name="procCreateTime" type="string" />
			<model:field name="procEndTime" type="string" />
		</model:record>
	</model:dataset>
	
</model:datasets>	

<%--定义界面--%>
<next:ViewPort>
	<next:TabPanel width="100%" height="100%">
		<next:Tabs>
			<next:Panel title="待办任务" width="100%" height="100%">	
				<next:Panel width="100%" border="0">	
					<next:Html>
					<fieldset style="overflow: visible;" class="GroupBox">
						<legend class="GroupBoxTitle">查询条件
							<img class="GroupBoxExpandButton" src="<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>" onclick="collapse(this);"/>									
						</legend>
						<div class="GroupBoxDiv" style="width: 100%;height: 100%;">	
							<form class="L5form">
								<table  border="1" width="100%">
									<tr>
									 	<td class="FieldLabel" style="width:10%">标题：</td>
						                <td class="FieldInput" style="width:40%"><input type="text" id="subjectDaiban" style="width:40%"/></td>
										<td class="FieldButton" style="width:10%"><button onclick="query()">查询</button></td>
									</tr>
								</table>
							</form>
						</div>
					</fieldset>
					</next:Html>
				</next:Panel>
				<next:GridPanel id="daiBanTaskGridPanel" title="待办流程列表" dataset="daiBanDataset" width="100%" height="100%" stripeRows="true" notSelectFirstRow="true">
					<next:TopBar>
						<next:ToolBarItem symbol="->"></next:ToolBarItem>	
						<next:ToolBarItem iconCls="add"  text="受理" handler="forNewBuild"/>
						<next:ToolBarItem iconCls="edit"  text="修改" handler="handle"/>
						<next:ToolBarItem iconCls="detail"  text="查看流转状态" handler="showState"/>
					</next:TopBar>					
					<next:Columns>
						<next:RowNumberColumn></next:RowNumberColumn>
						<next:RadioBoxColumn></next:RadioBoxColumn>
						<next:Column id="processId" header="流程实例ID" field="processId" hidden="true" ></next:Column>
						<next:Column id="assignmentId" header="内码" field="assignmentId" hidden="true" ></next:Column>
			        	<next:Column id="subject" header="标题" field="subject" width="20%" ></next:Column>
			        	<next:Column id="procDefName" header="流程名称" field="procDefName" width="20%" ></next:Column>
						<next:Column id="procCreateTime" header="流程发起时间" field="procCreateTime" width="14%" ></next:Column>
						<next:Column id="actDefName" header="当前环节" field="actDefName" width="14%" ></next:Column>
						<next:Column id="actLimitTime" header="环节限时时间" field="actLimitTime" width="14%" ></next:Column>
						<next:Column id="actWarnTime" header="环节预警时间" field="actWarnTime" width="14%" ></next:Column>
					</next:Columns>
					<next:BottomBar>
						<next:PagingToolBar dataset="daiBanDataset" />
					</next:BottomBar>
				</next:GridPanel>
			</next:Panel>
			<next:Panel title="已办任务" width="100%" height="100%">
				<next:Panel width="100%" border="0" >	
					<next:Html>			
					<fieldset style="overflow: visible;" class="GroupBox">
						<legend class="GroupBoxTitle">查询条件
							<img class="GroupBoxExpandButton" src="<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>" onclick="collapse(this);"/>									
						</legend>
						<div class="GroupBoxDiv" style="width: 100%;height: 100%;">	
							<form class="L5form">
								<table  border="1" width="100%">
									<tr>
									 	<td class="FieldLabel" style="width:10%">标题：</td>
						                <td class="FieldInput" style="width:40%"><input type="text"  id="yibanSubject" style="width:40%"/></td>
										<td class="FieldButton" style="width:10%"><button onclick="queryyiban()">查询</button></td>
									</tr>
								</table>
							</form>
						</div>
					</fieldset>
					</next:Html>
				</next:Panel>
				<next:GridPanel id="yiBanTaskGridPanel" title="已办流程列表" dataset="yiBanTaskDataset" width="100%" height="100%" stripeRows="true" notSelectFirstRow="true">
					<next:TopBar>		
						<next:ToolBarItem symbol="->"></next:ToolBarItem>		
						<next:ToolBarItem iconCls="select"  text="查看" handler="handleyiban"/>
						<next:ToolBarItem iconCls="detail"  text="查看流转状态" handler="showStateyiban"/>
					</next:TopBar>
					<next:Columns>
		   				<next:RowNumberColumn/>
		    			<next:RadioBoxColumn></next:RadioBoxColumn>
						<next:Column id="processId" header="流程实例ID" field="processId" hidden="true" ></next:Column>							
						<next:Column id="assignmentId" header="内码" field="assignmentId" hidden="true" ></next:Column>
				        <next:Column id="subject" header="标题" field="subject" width="20%" ></next:Column>
			        	<next:Column id="procDefName" header="流程名称" field="procDefName" width="20%" ></next:Column>
						<next:Column id="procCreateTime" header="流程发起时间" field="procCreateTime" width="12%" ></next:Column>
						<next:Column id="endTime" header="任务完成时间" field="endTime" width="12%" ></next:Column>
						<next:Column id="actDefName" header="当前环节" field="actDefName" width="10%" ></next:Column>
						<next:Column id="activeOrganNames" header="当前环节处理人" field="activeOrganNames" width="13%" ></next:Column>
						<next:Column id="activeActDefNames" header="当前活动环节" field="activeActDefNames" width="10%" ></next:Column>
					</next:Columns>
					<next:BottomBar>
						<next:PagingToolBar dataset="yiBanTaskDataset" />
					</next:BottomBar>
				</next:GridPanel>
			</next:Panel>
			<next:Panel title="结束任务" width="100%" height="100%">
				<next:Panel width="100%" border="0">	
					<next:Html>			
					<fieldset style="overflow: visible;" class="GroupBox">
						<legend class="GroupBoxTitle">查询条件
							<img class="GroupBoxExpandButton" src="<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>" onclick="collapse(this);"/>									
						</legend>
						<div class="GroupBoxDiv" style="width: 100%;height: 100%;">	
							<form class="L5form">
								<table  border="1" width="100%">
									<tr>
									 	<td class="FieldLabel" style="width:10%">标题：</td>
						                <td class="FieldInput" style="width:40%"><input type="text" id="endSubject" style="width:40%"/></td>
										<td class="FieldButton" style="width:10%"><button onclick="queryEnd()">查询</button></td>
									</tr>
								</table>
							</form>
						</div>
					</fieldset>
					</next:Html>
				</next:Panel>
				<next:GridPanel id="endTaskGridPanel" title="结束流程列表" dataset="endTaskDataset" width="100%" height="100%"  stripeRows="true" notSelectFirstRow="true">
					<next:TopBar>	
						<next:ToolBarItem symbol="->"></next:ToolBarItem>		
						<next:ToolBarItem iconCls="select"  text="查看" handler="handleEnd"/>
						<next:ToolBarItem iconCls="detail"  text="查看流转状态" handler="showStateEnd"/>
					</next:TopBar>
					<next:Columns>
		   				<next:RowNumberColumn/>
		    			<next:RadioBoxColumn></next:RadioBoxColumn>
						<next:Column id="processId" header="流程实例ID" field="processId" hidden="true" ></next:Column>					
						<next:Column id="assignmentId" header="内码" field="assignmentId" hidden="true" ></next:Column>
			        	<next:Column id="subject" header="标题" field="subject" width="20%" ></next:Column>
			        	<next:Column id="procDefName" header="流程名称" field="procDefName" width="20%" ></next:Column>
						<next:Column id="endTime" header="办理时间" field="endTime" width="14%" ></next:Column>
						<next:Column id="procCreateTime" header="流程发起时间" field="procCreateTime" width="14%" ></next:Column>
						<next:Column id="procEndTime" header="流程结束时间" field="procEndTime" width="14%" ></next:Column>
						<next:Column id="actDefName" header="已办环节" field="actDefName" width="14%" ></next:Column>		
					</next:Columns>
					<next:BottomBar>
						<next:PagingToolBar dataset="endTaskDataset" />
					</next:BottomBar>
				</next:GridPanel>
			</next:Panel>
		</next:Tabs>
	</next:TabPanel>
</next:ViewPort>

<script type="text/javascript">
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
	daiBanDataset.setParameter("procTypeId",procTypeId+"') and act_def_name in('申请名称核准");	
	daiBanDataset.load();
	yiBanTaskDataset.setParameter("procTypeId",procTypeId+"') and act_def_name in('申请名称核准");
	yiBanTaskDataset.load();
	endTaskDataset.setParameter("procTypeId",procTypeId+"') and  not exists(select * from wf_end_task c where c.process_id=WF_END_TASK.process_id and c.create_time>WF_END_TASK.create_time) and proc_def_unique_id in ('402881e5321877c401321892d9880009");	
	endTaskDataset.load();
}

//待办任务查询
function query(){
	var subjectDaiban=document.getElementById('subjectDaiban').value;
	if(subjectDaiban==''){
		daiBanDataset.setParameter("procTypeId",procTypeId+"') and act_def_name in('申请名称核准");
		daiBanDataset.load();	
	}else {
		daiBanDataset.setParameter("procTypeId",procTypeId+"') and subject like '%"+subjectDaiban+"%' and act_def_name in('申请名称核准");	
		daiBanDataset.load();	
	}
}
//受理按钮
function forNewBuild(){
	var url="jsp/cams/sorg/apply/ungov/prepare/somUngovPrepareInsert.jsp";
	L5.forward(url,"民办非企业单位登记立项录入页面");
	
}
//通过按钮处理待办任务
function handle(){
	var userGrid=L5.getCmp('daiBanTaskGridPanel');
	var selected = userGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert("提示","请选择一条记录进行处理!");
		return false;
	}
	var rec=selected[0];
	dealDaiBanTask(rec.get("assignmentId"),rec.get("processId"));
}
//处理待办任务
function dealDaiBanTask(assignmentId,processId){			
	var url="command/dispatcher/org.loushang.workflow.tasklist.forward.TaskListDispatcherCmd/daiBanTaskForward";
	var query="?assignmentId="+assignmentId+"&processId="+processId;
	L5.forward(url+query,"办理");
}
//查看流程状态图
function showState(){
   var daiBanTaskGridPanel=L5.getCmp("daiBanTaskGridPanel");
   var selecteds=daiBanTaskGridPanel.getSelectionModel().getSelections();
   if(selecteds.length!=1){
     L5.Msg.alert("提示","请选择一条您要查看的记录");
	  return false;
	}
   var assignmentId=selecteds[0].get("assignmentId");
   var url='jsp/workflow/monitor/flowview.jsp?assignmentId='+assignmentId;
   var text = '流程状态';
   L5.forward(url,text);
}


//已办任务查询
function queryyiban(){	
	var yibanSubject=document.getElementById('yibanSubject').value;
	if(yibanSubject==''){
		yiBanTaskDataset.setParameter("procTypeId",procTypeId+"') and act_def_name in('申请名称核准");	
		yiBanTaskDataset.load();	
	}else {
		yiBanTaskDataset.setParameter("procTypeId",procTypeId+"') and subject like '%"+yibanSubject+"%' and act_def_name in('申请名称核准");	
		yiBanTaskDataset.load();	
	}
}
//通过按钮处理已办任务
function handleyiban(){
	var userGrid=L5.getCmp('yiBanTaskGridPanel');
	var selected = userGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert("提示","请选择一条记录进行处理!");
		return false;
	}
	var rec=selected[0];
	dealYiBanTask(rec.get("assignmentId"),rec.get("processId"));
}

//处理已办任务
function dealYiBanTask(assignmentId,processId){			
	var url="command/dispatcher/org.loushang.workflow.tasklist.forward.TaskListDispatcherCmd/yiBanTaskForward";
	var query="?assignmentId="+assignmentId+"&processId="+processId+"&method=yiban";
	L5.forward(url+query,"办理");
}

//查看流程状态图
function showStateyiban(){
   var yiBanTaskGridPanel=L5.getCmp("yiBanTaskGridPanel");
   var selecteds=yiBanTaskGridPanel.getSelectionModel().getSelections();
   if(selecteds.length!=1){
     L5.Msg.alert("提示","请选择一条您要查看的记录");
	  return false;
	}
   var assignmentId=selecteds[0].get("assignmentId");
   var url='jsp/workflow/monitor/flowview.jsp?assignmentId='+assignmentId;
   var text = '流程状态';
   L5.forward(url,text);
}


//结束任务查询
function queryEnd(){
	var endSubject=document.getElementById('endSubject').value;
	if(endSubject==''){
		endTaskDataset.setParameter("procTypeId",procTypeId+"') and  not exists(select * from wf_end_task c where c.process_id=WF_END_TASK.process_id and c.create_time>WF_END_TASK.create_time) and proc_def_unique_id in ('402881e5321877c401321892d9880009");	
		endTaskDataset.load();	
	}else {
		endTaskDataset.setParameter("procTypeId",procTypeId+"') and  not exists(select * from wf_end_task c where c.process_id=WF_END_TASK.process_id and c.create_time>WF_END_TASK.create_time) and subject like '%"+endSubject+"%' and proc_def_unique_id in ('402881e5321877c401321892d9880009");	
		endTaskDataset.load();	
	}
}
//通过按钮处理办结任务
function handleEnd(){
	var userGrid=L5.getCmp('endTaskGridPanel');
	var selected = userGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert("提示","请选择一条记录进行处理!");
		return false;
	}
	var rec=selected[0];
	dealendTask(rec.get("assignmentId"));
}
//处理办结任务
function dealendTask(assignmentId){			
	var url="command/dispatcher/org.loushang.workflow.tasklist.forward.TaskListDispatcherCmd/endTaskForward";
	var query="?assignmentId="+assignmentId+"&method=yiban";
	L5.forward(url+query,"办理");
}
//查看流程状态图
function showStateEnd(){
   var endTaskGridPanel=L5.getCmp("endTaskGridPanel");
   var selecteds=endTaskGridPanel.getSelectionModel().getSelections();
   if(selecteds.length!=1){
     L5.Msg.alert("提示","请选择一条您要查看的记录");
	  return false;
	}
   var assignmentId=selecteds[0].get("assignmentId");
   var url='jsp/workflow/monitor/flowview.jsp?assignmentId='+assignmentId;
   var text = '流程状态';
   L5.forward(url,text);
}
</script>
</body>
</html>