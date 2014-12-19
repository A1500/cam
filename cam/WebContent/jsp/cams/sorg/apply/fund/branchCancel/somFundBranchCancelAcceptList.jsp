<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="org.loushang.next.skin.SkinUtils" %>
<%@ taglib uri="/tags/next-web" prefix="next" %>
<%@ taglib uri="/tags/next-model" prefix="model" %>
<html>
<head>
<title>基金会分支/代表机构列表</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript">
	var procTypeId = "somFundBranchCancel";
	var act="受理";
	var procDefUniqueId="402881ec320a604801320a67245a0035";	
	function setTaskState(value,a,rec)
	{
		var imagePath=L5.webPath+"/jsp/workflow/tasklist/images/";
		var image="";
		//正常状态
		if(value=="0")
		{
			image="normal.png";
		}
		//预警状态
		else if(value=="1")
		{
			image="warn.png";
		}
		//超时状态
		else if(value=="2")
		{
			image="limit.png";
		}
	
		return '<img src="'+imagePath+image+'" />';
	}	
</script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
</head>
<body>

<model:datasets>
	<model:dataset pageSize="10" id="daiBanDataset" cmd="com.inspur.cams.comm.workflow.taskinfo.cmd.TaskInfoQueryCmd" method="queryDaiBan"  global="true">
		<model:record>
			<model:field name="TASK_STATE" type="string" />
		</model:record>
	</model:dataset>
	<model:dataset pageSize="10" id="yiBanTaskDataset" cmd="com.inspur.cams.comm.workflow.taskinfo.cmd.TaskInfoQueryCmd" method="queryYiBan"  global="true">
	</model:dataset>
	<model:dataset id="endTaskDataset" cmd="com.inspur.cams.comm.workflow.taskinfo.cmd.TaskInfoQueryCmd" method="queryEnd"  global="true">
	</model:dataset>	
</model:datasets>	

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
						<next:ToolBarItem iconCls="add"  text="受理" handler="forAccept"/>
						<next:ToolBarItem iconCls="edit"  text="修改" handler="forUpdate"/>
						<next:ToolBarItem iconCls="detail"  text="查看流转状态" handler="showState"/>
					</next:TopBar>					
					<next:Columns>
						<next:RowNumberColumn width="30"/>
						<next:RadioBoxColumn></next:RadioBoxColumn>
						<next:Column id="processId" header="流程实例ID" field="PROCESS_ID" hidden="true" ></next:Column>
						<next:Column id="assignmentId" header="内码" field="ID" hidden="true" ></next:Column>
			        	<next:Column header="状态" field="TASK_STATE" width="40" renderer="setTaskState" align="center">
								<next:TextField allowBlank="false"/>
							</next:Column>	
			        	<next:Column id="subject" header="标题" field="SUBJECT" width="150" ></next:Column>
			        	<next:Column id="procDefName" header="流程名称" field="PROC_DEF_NAME" width="150" ></next:Column>
						<next:Column id="procCreateTime" header="流程发起时间" field="ACCEPT_TIME" width="150" ></next:Column>
						<next:Column id="actDefName" header="当前环节" field="ACT_DEF_NAME" width="150" ></next:Column>
					</next:Columns>
					<next:BottomBar>
						<next:PagingToolBar dataset="daiBanDataset"/>
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
						<next:RowNumberColumn width="30"/>
						<next:RadioBoxColumn></next:RadioBoxColumn>
						<next:Column id="processId" header="流程实例ID" field="PROCESS_ID" hidden="true" ></next:Column>							
						<next:Column id="assignmentId" header="内码" field="ID" hidden="true" ></next:Column>
				        <next:Column id="subject" header="标题" field="SUBJECT" width="150" ></next:Column>
			        	<next:Column id="procDefName" header="流程名称" field="PROC_DEF_NAME" width="150" ></next:Column>
						<next:Column id="procCreateTime" header="流程发起时间" field="ACCEPT_TIME" width="150" ></next:Column>
						<next:Column id="endTime" header="任务完成时间" field="END_TIME" width="150" ></next:Column>
						<next:Column id="actDefName" header="当前环节" field="ACT_DEF_NAME" width="150" ></next:Column>
						<next:Column id="activeOrganNames" header="当前环节处理人" field="ACTIVE_ORGAN_NAMES" width="150" ></next:Column>
						<next:Column id="activeActDefNames" header="当前活动环节" field="ACTIVE_ACT_DEF_NAMES" width="150" ></next:Column>
					</next:Columns>
					<next:BottomBar>
						<next:PagingToolBar dataset="yiBanTaskDataset"/>
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
						                <td class="FieldInput" style="width:40%"><input type="text"  id="endSubject" style="width:40%"/></td>
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
						<next:PagingToolBar dataset="endTaskDataset"/>
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
//初始化
function init(){
	daiBanDataset.setParameter("processType",procTypeId);	
	daiBanDataset.setParameter("actDefName",act);
	daiBanDataset.setParameter("tableName","SOM_APPLY");
	daiBanDataset.setParameter("tableKey","TASK_CODE");
	daiBanDataset.setParameter("applyShowColum","TASK_CODE,ACCEPT_TIME");
	daiBanDataset.load();
	yiBanTaskDataset.setParameter("processType",procTypeId);	
	yiBanTaskDataset.setParameter("actDefName",act);
	yiBanTaskDataset.setParameter("tableName","SOM_APPLY");
	yiBanTaskDataset.setParameter("tableKey","TASK_CODE");
	yiBanTaskDataset.setParameter("applyShowColum","TASK_CODE,ACCEPT_TIME");
	yiBanTaskDataset.load();
	endTaskDataset.setParameter("processType",procTypeId);	
	endTaskDataset.setParameter("actDefName",act);
	endTaskDataset.setParameter("tableName","SOM_APPLY");
	endTaskDataset.setParameter("tableKey","TASK_CODE");
	endTaskDataset.setParameter("applyShowColum","TASK_CODE,ACCEPT_TIME");
	endTaskDataset.load();
}
//查询待办任务
function query(){
	var subjectDaiban=document.getElementById('subjectDaiban').value;
	if(subjectDaiban==''){
		daiBanDataset.setParameter("processType",procTypeId);	
		daiBanDataset.setParameter("actDefName",act);
		daiBanDataset.setParameter("tableName","SOM_APPLY");
		daiBanDataset.setParameter("tableKey","TASK_CODE");
		daiBanDataset.setParameter("applyShowColum","TASK_CODE,ACCEPT_TIME");
		daiBanDataset.load();
	}else{
		daiBanDataset.setParameter("processType",procTypeId);	
		daiBanDataset.setParameter("actDefName",act);
		daiBanDataset.setParameter("tableName","SOM_APPLY");
		daiBanDataset.setParameter("tableKey","TASK_CODE");
		daiBanDataset.setParameter("applyShowColum","TASK_CODE,ACCEPT_TIME");
		daiBanDataset.setParameter("mysetwhere","SUBJECT@LIKE:%"+subjectDaiban+"%");
		daiBanDataset.load();
	}
}
//查看流程状态图
function showState(){
   var daiBanTaskGridPanel=L5.getCmp("daiBanTaskGridPanel");
   var selecteds=daiBanTaskGridPanel.getSelectionModel().getSelections();
   if(selecteds.length!=1){
      L5.Msg.alert("提示","请选择一条您要查看的记录");
	  return false;
	}
   var assignmentId=selecteds[0].get("ID");
   var url="jsp/workflow/monitor/flowview.jsp?backUrl=jsp/workflow/tasklist/querydaiban.jsp&assignmentId="+assignmentId;
   var text = "流程状态";
   L5.forward(url,text);
}
//查询已办任务
function queryyiban(){	
	var yibanSubject=document.getElementById('yibanSubject').value;
	if(yibanSubject==''){
		yiBanTaskDataset.setParameter("processType",procTypeId);	
		yiBanTaskDataset.setParameter("actDefName",act);
		yiBanTaskDataset.setParameter("tableName","SOM_APPLY");
		yiBanTaskDataset.setParameter("tableKey","TASK_CODE");
		yiBanTaskDataset.setParameter("applyShowColum","TASK_CODE,ACCEPT_TIME");
		yiBanTaskDataset.load();
	}else {
		yiBanTaskDataset.setParameter("processType",procTypeId);	
		yiBanTaskDataset.setParameter("actDefName",act);
		yiBanTaskDataset.setParameter("tableName","SOM_APPLY");
		yiBanTaskDataset.setParameter("tableKey","TASK_CODE");
		yiBanTaskDataset.setParameter("applyShowColum","TASK_CODE,ACCEPT_TIME");
		yiBanTaskDataset.setParameter("mysetwhere","SUBJECT@LIKE:%"+yibanSubject+"%");
		yiBanTaskDataset.load();	
	}
}
//查看已办任务
function handleyiban(){
	var userGrid=L5.getCmp("yiBanTaskGridPanel");
	var selected = userGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert("提示","请选择一条记录进行处理!");
		return false;
	}
	var rec=selected[0];
	var processId=rec.get("PROCESS_ID");
	var actDefUniqueId=rec.get("ACT_DEF_UNIQUE_ID");
	var assignmentId=rec.get("ID");
	var url="jsp/cams/sorg/apply/fund/branchCancel/somFundBranchCancelDeal.jsp?processId="+processId+"&actDefUniqueId="+actDefUniqueId+"&assignmentId="+assignmentId;
	url+="&method=yiban";
	L5.forward(url);
}
//查看流程状态图
function showStateyiban(){
   var yiBanTaskGridPanel=L5.getCmp("yiBanTaskGridPanel");
   var selecteds=yiBanTaskGridPanel.getSelectionModel().getSelections();
   if(selecteds.length!=1){
      L5.Msg.alert("提示","请选择一条您要查看的记录");
	  return false;
	}
   var assignmentId=selecteds[0].get("ID");
   var url="jsp/workflow/monitor/flowview.jsp?backUrl=jsp/workflow/tasklist/queryyiban.jsp&assignmentId="+assignmentId;
   var text = "流程状态";
   L5.forward(url,text);
}
//查询结束任务
function queryEnd(){
	var endSubject=document.getElementById("endSubject").value;
	if(endSubject==''){
		endTaskDataset.setParameter("processType",procTypeId);	
		endTaskDataset.setParameter("actDefName",act);
		endTaskDataset.setParameter("tableName","SOM_APPLY");
		endTaskDataset.setParameter("tableKey","TASK_CODE");
		endTaskDataset.setParameter("applyShowColum","TASK_CODE,ACCEPT_TIME");
		endTaskDataset.load();	
	}else {
		endTaskDataset.setParameter("processType",procTypeId);	
		endTaskDataset.setParameter("actDefName",act);
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
	var assignmentId=rec.get("ID");
	var url="jsp/cams/sorg/apply/fund/branchCancel/somFundBranchCancelDeal.jsp?assignmentId="+assignmentId;
	url+="&method=end";
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
   var url="jsp/workflow/monitor/flowview.jsp?backUrl=jsp/workflow/tasklist/queryend.jsp&assignmentId="+assignmentId;
   var text = "流程状态";
   L5.forward(url,text);
}
//受理按钮
function forAccept(){
	var url="jsp/cams/sorg/apply/fund/branchCancel/somFundBranchCancelAccept.jsp?method=INSERT";
	L5.forward(url,"基金会分支/代表机构注销登记录入");	
}
//修改按钮
function forUpdate(){
	var userGrid=L5.getCmp("daiBanTaskGridPanel");
	var selected = userGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert("提示","请选择一条记录进行处理!");
		return false;
	}
	var rec=selected[0];
	var processId=rec.get("PROCESS_ID");
	var actDefUniqueId=rec.get("ACT_DEF_UNIQUE_ID");
	var assignmentId=rec.get("ID");
	var url="jsp/cams/sorg/apply/fund/branchCancel/somFundBranchCancelAccept.jsp?processId="+processId+"&actDefUniqueId="+actDefUniqueId+"&assignmentId="+assignmentId;
	url+="&method=UPDATE";
	L5.forward(url);
}
</script>

</body>
</html>