<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.sorg.util.Activity"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>取缔非法社会组织待办任务</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript">
	var procTypeId ="somPenaltyForbid";
	var act="<%=request.getParameter("act")%>";
	//设置任务状态
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
</head>
<body>
<%--定义dataset--%>
<model:datasets>
	<model:dataset pageSize="10" id="daiBanDataset" cmd="com.inspur.cams.comm.workflow.taskinfo.cmd.TaskInfoQueryCmd" method="queryDaiBan" autoLoad="false" global="true">
		<model:record>
			<model:field name="TASK_STATE" type="string" />
		</model:record>
	</model:dataset>
	<model:dataset pageSize="10" id="yiBanTaskDataset" cmd="com.inspur.cams.comm.workflow.taskinfo.cmd.TaskInfoQueryCmd" method="queryYiBan" autoLoad="false" global="true">
		<model:record>
		</model:record>
	</model:dataset>
</model:datasets>

<%--定义界面--%>
<next:TabPanel id="tab" width="100%" height="100%">
	<next:Tabs>
		<next:Panel title="待办任务" width="100%">
			<next:Panel width="100%" border="0">
				<next:Html>			
					<fieldset style="overflow: visible;" class="GroupBox">
						<legend class="GroupBoxTitle">查询条件
							<img class="GroupBoxExpandButton" src="<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>" onclick="collapse(this);"/>									
						</legend>
						<div class="GroupBoxDiv" style="width: 100%;height: 100%;">	
							<form onsubmit="return false;" class="L5form">				
								<table  border="1" width="100%">
									<tr>
										<td class="FieldLabel" width="10%">标题：</td>
							            <td class="FieldInput" width="40%"><input type="text"  id="subjectDaiban" style="width:40%" /></td>
										<td class="FieldButton" width="10%"><button onclick="query()">查询</button></td>
									</tr>
								</table>
							</form>	
						</div>
					</fieldset>
				</next:Html>
			</next:Panel>
			<next:GridPanel id="daiBanTaskGridPanel" name="daiBanTaskGridPanel" width="100%" height="99.9%" dataset="daiBanDataset"     title="待办流程列表" notSelectFirstRow="true">
				<next:TopBar>
					<next:ToolBarItem symbol="->"></next:ToolBarItem>			
					<next:ToolBarItem iconCls="add"  text="办理" handler="forDeal"/>
					<next:ToolBarItem iconCls="detail"  text="查看流转状态" handler="showState"/>
				</next:TopBar>
				<next:Columns>
					<next:RowNumberColumn width="30"/>
					<next:RadioBoxColumn></next:RadioBoxColumn>
					<next:Column id="assignmentId" header="内码" field="ID" hidden="true"></next:Column>	
		        	<next:Column header="状态" field="TASK_STATE" width="40" renderer="setTaskState" align="center">
							<next:TextField allowBlank="false"/>
						</next:Column>	
		        	<next:Column id="subject" header="标题" field="SUBJECT" width="18%" ></next:Column>
		        	<next:Column id="procDefName" header="流程名称" field="PROC_DEF_NAME" width="18%" ></next:Column>
					<next:Column id="procCreateTime" header="流程发起时间" field="PROC_CREATE_TIME" width="12%" ></next:Column>
					<next:Column id="preActDefNames" header="发送环节" field="PRE_ACT_DEF_NAMES" width="8%" ></next:Column>
					<next:Column id="preOrganNames" header="发送人" field="PRE_ORGAN_NAMES" width="8%" ></next:Column>
					<next:Column id="actDefName" header="当前环节" field="ACT_DEF_NAME" width="8%" ></next:Column>
					<next:Column id="actLimitTime" header="环节限时时间" field="ACT_LIMIT_TIME" width="12%" ></next:Column>
					<next:Column id="actWarnTime" header="环节预警时间" field="ACT_WARN_TIME" width="12%" ></next:Column>
					<next:Column id="processId" header="processId" field="PROCESSID" hidden="true" ></next:Column>	
				</next:Columns>
				<next:BottomBar>
					<next:PagingToolBar dataset="daiBanDataset"/>
				</next:BottomBar>
			</next:GridPanel>
		</next:Panel>
		
		<next:Panel title="已办任务" width="100%">
			<next:Panel  width="100%" border="0">
				<next:Html>			
					<fieldset style="overflow: visible;" class="GroupBox">
						<legend class="GroupBoxTitle">查询条件
							<img class="GroupBoxExpandButton" src="<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>" onclick="collapse(this);"/>									
						</legend>
						<div class="GroupBoxDiv" style="width: 100%;height: 100%;">	
							<form onsubmit="return false;" class="L5form">				
								<table  border="1" width="100%">
									<tr>						
								 		<td class="FieldLabel" width="10%">标题：</td>
				                 		<td class="FieldInput" width="40%"><input type="text"  id="yibanSubject" style="width:40%" /></td>
										<td class="FieldButton" width="10%"><button onclick="queryyiban()">查询</button></td>
									</tr>
								</table>
							</form>	
						</div>
					</fieldset>
				</next:Html>
			</next:Panel>
			<next:GridPanel id="yiBanTaskGridPanel" name="yiBanTaskGridPanel" width="100%" height="99.9%" dataset="yiBanTaskDataset"  title="已办流程列表" notSelectFirstRow="true">
				<next:TopBar>	
					<next:ToolBarItem symbol="->"></next:ToolBarItem>		
					<next:ToolBarItem iconCls="select"  text="查看" handler="handleyiban"/>
					<next:ToolBarItem iconCls="detail"  text="查看流转状态" handler="showStateyiban"/>
				</next:TopBar>
				<next:Columns>
					<next:RowNumberColumn width="30"/>
					<next:RadioBoxColumn></next:RadioBoxColumn>
					<next:Column id="assignmentId" header="内码" field="ID" hidden="true" ></next:Column>						
		        	<next:Column id="subject" header="标题" field="SUBJECT" width="20%" ></next:Column>
		        	<next:Column id="procDefName" header="流程名称" field="PROC_DEF_NAME" width="20%" ></next:Column>
					<next:Column id="procCreateTime" header="流程发起时间" field="PROC_CREATE_TIME" width="12%" ></next:Column>
					<next:Column id="endTime" header="任务完成时间" field="END_TIME" width="12%" ></next:Column>
					<next:Column id="actDefName" header="当前环节" field="ACT_DEF_NAME" width="10%" ></next:Column>
					<next:Column id="activeOrganNames" header="当前环节处理人" field="ACTIVE_ORGAN_NAMES" width="13%" ></next:Column>
					<next:Column id="activeActDefNames" header="当前活动环节" field="ACTIVE_ACT_DEF_NAMES" width="10%" ></next:Column>
					<next:Column id="processId" header="processId" field="PROCESS_ID" hidden="true" ></next:Column>	
				</next:Columns>
				<next:BottomBar>
					<next:PagingToolBar dataset="yiBanTaskDataset"/>
				</next:BottomBar>
			</next:GridPanel>
		</next:Panel>
	</next:Tabs>
</next:TabPanel>

<script type="text/javascript">
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
	daiBanDataset.setParameter("processType",procTypeId);	
	daiBanDataset.setParameter("actDefName",getActDefName());
	daiBanDataset.setParameter("tableName","SOM_PENALTY_APPLY");
	daiBanDataset.setParameter("tableKey","TASK_CODE");
	daiBanDataset.setParameter("applyShowColum","TASK_CODE");
	daiBanDataset.load();
	yiBanTaskDataset.setParameter("processType",procTypeId);	
	yiBanTaskDataset.setParameter("actDefName",getActDefName());
	yiBanTaskDataset.setParameter("tableName","SOM_PENALTY_APPLY");
	yiBanTaskDataset.setParameter("tableKey","TASK_CODE");
	yiBanTaskDataset.setParameter("applyShowColum","TASK_CODE");
	yiBanTaskDataset.load();
}
//待办任务查询
function query(){	
	var subjectDaiban=document.getElementById('subjectDaiban').value;
	if(subjectDaiban==''){
		daiBanDataset.setParameter("processType",procTypeId);	
		daiBanDataset.setParameter("actDefName",getActDefName());
		daiBanDataset.setParameter("tableName","SOM_PENALTY_APPLY");
		daiBanDataset.setParameter("tableKey","TASK_CODE");
		daiBanDataset.setParameter("applyShowColum","TASK_CODE");
		daiBanDataset.load();
	}else{
		daiBanDataset.setParameter("processType",procTypeId);	
		daiBanDataset.setParameter("actDefName",getActDefName());
		daiBanDataset.setParameter("tableName","SOM_PENALTY_APPLY");
		daiBanDataset.setParameter("tableKey","TASK_CODE");
		daiBanDataset.setParameter("applyShowColum","TASK_CODE");
		daiBanDataset.setParameter("mysetwhere","SUBJECT@LIKE:%"+subjectDaiban+"%");
		daiBanDataset.load();
	}
}
//通过按钮处理待办任务
function forDeal(){
	var userGrid=L5.getCmp('daiBanTaskGridPanel');
	var selected = userGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert("提示","请选择一条记录进行处理!");
		return false;
	}
	var rec=selected[0];
	var processId=rec.get("PROCESS_ID");
	var actDefUniqueId=rec.get("ACT_DEF_UNIQUE_ID");
	var assignmentId=rec.get("ID");	
	var url="";
	if(act=='p_reg'){	
		url="jsp/cams/sorg/penalty/forbid/penaltyForbidReg.jsp";
	}else if(act=='p_regCheck' || act=='p_regAudit'){
		url="jsp/cams/sorg/penalty/forbid/penaltyForbidRegDetail.jsp";
	}else if(act=='p_inv'){
		url="jsp/cams/sorg/penalty/forbid/penaltyForbidInv.jsp";
	}else if(act=='p_invEnd'){
		url="jsp/cams/sorg/penalty/forbid/penaltyForbidInvEnd.jsp";
	}else if(act=='p_forbid'){
		url="jsp/cams/sorg/penalty/forbid/penaltyForbid.jsp";
	}else if(act=='p_forbidCheck' || act=='p_forbidAudit'){
		url="jsp/cams/sorg/penalty/forbid/penaltyForbidDetail.jsp";
	}else if(act=='p_forbidInform'){
		url="jsp/cams/sorg/penalty/forbid/penaltyForbidInform.jsp";
	}else if(act=='p_final'){
		url="jsp/cams/sorg/penalty/forbid/penaltyForbidFinal.jsp";
	}else if(act=='p_finalCheck' || act=='p_finalAudit'){
		url="jsp/cams/sorg/penalty/forbid/penaltyForbidFinalDetail.jsp";
	}
	var query="?processId="+processId+"&actDefUniqueId="+actDefUniqueId+"&assignmentId="+assignmentId+"&act="+act+"&method=daiban";
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
	var assignmentId=selecteds[0].get("ID");
	var url='jsp/workflow/monitor/flowview.jsp?assignmentId='+assignmentId;
	var text = '流程状态';
	L5.forward(url,text);
}
//已办任务查询
function queryyiban(){	//要查询的流程类型或要过滤掉的流程类型
	var yibanSubject=document.getElementById('yibanSubject').value;
	if(yibanSubject==''){
		yiBanTaskDataset.setParameter("processType",procTypeId);	
		yiBanTaskDataset.setParameter("actDefName",getActDefName());
		yiBanTaskDataset.setParameter("tableName","SOM_PENALTY_APPLY");
		yiBanTaskDataset.setParameter("tableKey","TASK_CODE");
		yiBanTaskDataset.setParameter("applyShowColum","TASK_CODE");
		yiBanTaskDataset.load();
	}else {
		yiBanTaskDataset.setParameter("processType",procTypeId);	
		yiBanTaskDataset.setParameter("actDefName",getActDefName());
		yiBanTaskDataset.setParameter("tableName","SOM_PENALTY_APPLY");
		yiBanTaskDataset.setParameter("tableKey","TASK_CODE");
		yiBanTaskDataset.setParameter("applyShowColum","TASK_CODE");
		yiBanTaskDataset.setParameter("mysetwhere","SUBJECT@LIKE:%"+yibanSubject+"%");
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
	var processId=rec.get("PROCESS_ID");
	var actDefUniqueId=rec.get("ACT_DEF_UNIQUE_ID");
	var assignmentId=rec.get("ID");	
	var url="";
	if(act=='p_reg' || act=='p_regCheck' || act=='p_regAudit'){	
		url="jsp/cams/sorg/penalty/forbid/penaltyForbidRegDetail.jsp";
	}else if(act=='p_inv'){
		url="jsp/cams/sorg/penalty/forbid/penaltyForbidInvDetail.jsp";
	}else if(act=='p_invEnd'){
		url="jsp/cams/sorg/penalty/forbid/penaltyForbidInvEndDetail.jsp";
	}else if(act=='p_forbid' || act=='p_forbidCheck' || act=='p_forbidAudit'){
		url="jsp/cams/sorg/penalty/forbid/penaltyForbidDetail.jsp";
	}else if(act=='p_forbidInform'){
		url="jsp/cams/sorg/penalty/forbid/penaltyForbidInformDetail.jsp";
	}else if(act=='p_final' || act=='p_finalCheck' || act=='p_finalAudit'){
		url="jsp/cams/sorg/penalty/forbid/penaltyForbidFinalDetail.jsp";
	}
	var query="?processId="+processId+"&actDefUniqueId="+actDefUniqueId+"&assignmentId="+assignmentId+"&act="+act+"&method=yiban";
	L5.forward(url+query,"办理");
}
//查看流程状态图
function showStateyiban(){
	var yiBanTaskGridPanel=L5.getCmp("yiBanTaskGridPanel");
	var selecteds=yiBanTaskGridPanel.getSelectionModel().getSelections();
	if(selecteds.length!=1){
		L5.Msg.alert("提示","请选择一条您要查看的记录");
		return false;}
	var assignmentId=selecteds[0].get("ID");
	var url='jsp/workflow/monitor/flowview.jsp?assignmentId='+assignmentId;
	var text = '流程状态';
	L5.forward(url,text);
}
function getActDefName(){
	if(act=='p_reg'){
		return "<%=Activity.PENALTYACT_REG_CN%>";
	}else if(act=='p_regCheck'){
		return "<%=Activity.PENALTYACT_REG_CHECK_CN%>";
	}else if(act=='p_regAudit'){
		return "<%=Activity.PENALTYACT_REG_AUDIT_CN%>";
	}else if(act=='p_inv'){
		return "<%=Activity.PENALTYACT_INV_CN%>";
	}else if(act=='p_invEnd'){
		return "<%=Activity.PENALTYACT_INV_END_CN%>";
	}else if(act=='p_forbid'){
		return "<%=Activity.PENALTYACT_FORBID_CN%>";
	}else if(act=='p_forbidCheck'){
		return "<%=Activity.PENALTYACT_FORBID_CHECK_CN%>";
	}else if(act=='p_forbidAudit'){
		return "<%=Activity.PENALTYACT_FORBID_AUDIT_CN%>";
	}else if(act=='p_forbidInform'){
		return "<%=Activity.PENALTYACT_FORBID_INFORM_CN%>";
	}else if(act=='p_final'){
		return "<%=Activity.PENALTYACT_FINAL_CN%>";
	}else if(act=='p_finalCheck'){
		return "<%=Activity.PENALTYACT_FINAL_CHECK_CN%>";
	}else if(act=='p_finalAudit'){
		return "<%=Activity.PENALTYACT_FINAL_AUDIT_CN%>";
	}
}
</script>
</body>
</html>