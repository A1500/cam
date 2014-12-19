<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>结束任务</title>
<next:ScriptManager></next:ScriptManager>
<script language="javascript" type="text/javascript">
function init(){
	endTaskDataset.setParameter("processType",parent.procTypeId);	
	endTaskDataset.setParameter("actDefName",parent.getActDefName());
	endTaskDataset.setParameter("tableName","SOM_APPLY");
	endTaskDataset.setParameter("tableKey","TASK_CODE");
	endTaskDataset.setParameter("applyShowColum","TASK_CODE,ACCEPT_TIME");
	endTaskDataset.load();
	L5.QuickTips.init();
}
//查询结束任务
function queryEnd(){
	var endSubject=document.getElementById("endSubject").value;
	if(endSubject==''){
		endTaskDataset.setParameter("processType",parent.procTypeId);	
		endTaskDataset.setParameter("actDefName",parent.getActDefName());
		endTaskDataset.setParameter("tableName","SOM_APPLY");
		endTaskDataset.setParameter("tableKey","TASK_CODE");
		endTaskDataset.setParameter("applyShowColum","TASK_CODE,ACCEPT_TIME");
		endTaskDataset.load();	
	}else {
		endTaskDataset.setParameter("processType",parent.procTypeId);	
		endTaskDataset.setParameter("actDefName",parent.getActDefName());
		endTaskDataset.setParameter("tableName","SOM_APPLY");
		endTaskDataset.setParameter("tableKey","TASK_CODE");
		endTaskDataset.setParameter("applyShowColum","TASK_CODE,ACCEPT_TIME");
		endTaskDataset.setParameter("mysetwhere","SUBJECT@LIKE:%"+endSubject+"%");
		endTaskDataset.load();	
	}
}
//查看结束任务
function handleEnd(){
	var userGrid=L5.getCmp("endTaskGridPanel");
	var selected = userGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert("提示","请选择一条记录进行处理!");
		return false;
	}
	var rec=selected[0];
	var processId=rec.get("PROCESS_ID");
	var actDefUniqueId=rec.get("ACT_DEF_UNIQUE_ID");
	var assignmentId=rec.get("ID");
	var url="jsp/cams/sorg/apply/fund/nameApproval/somFundNameApprovalDetail.jsp?method=end&processId="+processId+"&actDefUniqueId="+actDefUniqueId+"&assignmentId="+assignmentId;
	L5.forward(url);
}
//查看流程状态图
function showStateEnd(){
   var endTaskGridPanel=L5.getCmp("endTaskGridPanel");
   var selecteds=endTaskGridPanel.getSelectionModel().getSelections();
   if(selecteds.length!=1){
      L5.Msg.alert("提示","请选择一条您要查看的记录");
	  return false;
	}
   var assignmentId=selecteds[0].get("ID");
   var url="jsp/workflow/monitor/flowview.jsp?assignmentId="+assignmentId;
   var text = "流程状态";
   L5.forward(url,text);
}
</script>
</head>
<body>
<model:datasets>
	<model:dataset id="endTaskDataset" cmd="com.inspur.cams.comm.workflow.taskinfo.cmd.TaskInfoQueryCmd" method="queryEnd"  global="true">
	</model:dataset>
</model:datasets>
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
			<next:Column id="processId" header="流程实例ID" field="PROCESS_ID" hidden="true" ></next:Column>					
			<next:Column id="assignmentId" header="内码" field="ID" hidden="true" ></next:Column>
        	<next:Column id="subject" header="标题" field="SUBJECT" width="150" ></next:Column>
        	<next:Column id="procDefName" header="流程名称" field="PROC_DEF_NAME" width="150" ></next:Column>
			<next:Column id="endTime" header="办理时间" field="END_TIME" width="150" ></next:Column>
			<next:Column id="procCreateTime" header="流程发起时间" field="ACCEPT_TIME" width="150" ></next:Column>
			<next:Column id="procEndTime" header="流程结束时间" field="PROC_END_TIME" width="150" ></next:Column>
			<next:Column id="actDefName" header="已办环节" field="ACT_DEF_NAME" width="150" ></next:Column>		
		</next:Columns>
		<next:BottomBar>
			<next:PagingToolBar dataset="endTaskDataset" />
		</next:BottomBar>
	</next:GridPanel>
</next:Panel>
</body>
</html>