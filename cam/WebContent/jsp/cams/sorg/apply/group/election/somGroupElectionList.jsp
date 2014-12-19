<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.*"%>
<html>
<head>
<script type="text/javascript" src="somGroupElectionSession.js"></script>
<title>任务查询</title>
<next:ScriptManager></next:ScriptManager>
<%
	String act = request.getParameter("act");
	String checkPermit = request.getParameter("checkPermit");//用于标识，是否显示完成任务tab页
%>
<script language="javascript">
	var procTypeId="somGroupElection";
	var act='<%=act%>';
	var checkPermit='<%=checkPermit%>';
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
	<%
    String organArea=BspUtil.getCorpOrgan().getOrganCode();
    %>
	var organArea='<%=organArea%>';
	var nowTime='<%= DateUtil.getDay()%>';
</script>
</head>
<body>
<model:datasets>
	<model:dataset pageSize="10" id="daiBanDataset" cmd="com.inspur.cams.comm.workflow.taskinfo.cmd.TaskInfoQueryCmd" method="queryDaiBan" autoLoad="false" global="true">
		<model:record>
			<model:field name="TASK_STATE" type="string" />
		</model:record>
	</model:dataset>
	<model:dataset id="somElectionDataSet"cmd="com.inspur.cams.sorg.history.election.cmd.SomElectionQueryCmd" method="electionForQuery" global="true">
	</model:dataset>
	<model:dataset pageSize="10" id="yiBanTaskDataset" cmd="com.inspur.cams.comm.workflow.taskinfo.cmd.TaskInfoQueryCmd" method="queryYiBan" autoLoad="false" global="true">
		<model:record>
		</model:record>
	</model:dataset>
	<model:dataset id="somFlowAddDataset" cmd="com.inspur.cams.sorg.manage.cmd.SomFlowQueryCommand">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomFlow">
			<model:field name="opinionId" type="string" defaultValue="0"/>
		</model:record>
	</model:dataset>
	<model:dataset id="comm_yesorno" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
</model:datasets>

<next:TabPanel id="tab" activeTab="0" width="100%" height="100%" >
	<next:Tabs>
		<next:Panel title="待办任务" width="100%" height="100%" >
			<next:Panel width="100%" border="0">
				<next:Html>			
					<fieldset style="overflow: visible;" class="GroupBox">
						<legend class="GroupBoxTitle">查询条件
							<img class="GroupBoxExpandButton" src="<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>" onclick="collapse(this);"/>									
						</legend>
						<div class="GroupBoxDiv" style="width:100%;height:100%;">	
							<form onsubmit="return false;" class="L5form">
								<table border="1" width="100%">
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
			<next:GridPanel id="daiBanTaskGridPanel" title="待办流程列表" name="daiBanTaskGridPanel" width="100%" height="100%" dataset="daiBanDataset" notSelectFirstRow="true">
				<next:TopBar>
					<next:ToolBarItem symbol="->"></next:ToolBarItem>
					<next:ToolBarItem iconCls="add" text="办理" handler="forDeal"/>
					<next:ToolBarItem iconCls="detail" text="查看流转状态" handler="showState"/>
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
					<next:PagingToolBar  dataset="daiBanDataset"/>
				</next:BottomBar>
			</next:GridPanel>
		</next:Panel>
		<% if(!act.equals("inform")){%>
		<next:Panel title="已办任务" width="100%" height="100%" >
			<next:Panel width="100%" border="0">
				<next:Html>			
					<fieldset style="overflow: visible;" class="GroupBox">
						<legend class="GroupBoxTitle">查询条件
							<img class="GroupBoxExpandButton" src="<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>" onclick="collapse(this);"/>									
						</legend>
						<div class="GroupBoxDiv" style="width: 100%;height:100%;">
							<form onsubmit="return false;" class="L5form">
								<table border="1" width="100%">
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
			<next:GridPanel id="yiBanTaskGridPanel" title="已办流程列表" name="yiBanTaskGridPanel" width="100%" height="100%" dataset="yiBanTaskDataset" notSelectFirstRow="true">
				<next:TopBar>
					<next:ToolBarItem symbol="->"></next:ToolBarItem>
					<next:ToolBarItem iconCls="select" text="查看" handler="handleyiban"/>
					<next:ToolBarItem iconCls="detail" text="查看流转状态" handler="showStateyiban"/>
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
					<next:PagingToolBar  dataset="yiBanTaskDataset"/>
				</next:BottomBar>
			</next:GridPanel>
		</next:Panel>
		<%}%>
		<% if(act.equals("inform")){%>
			<next:Panel title='完结任务' width='100%' height='100%'>
				<next:Panel >
					<next:Html>
						<form class="L5form">
						<fieldset><legend>查询条件</legend>
						<table width="100%">
							<tr>
								<td class="FieldLabel" style="width:20%"><label>社会团体名称：</label></td>
								<td class="FieldInput" style="width:20%"><input style='width:90%'  type="text" id="sorgName"/></td>
								<td class="FieldLabel" style="width:20%"><label>登记证号：</label></td>
								<td class="FieldInput" style="width:20%"><input style='width:90%'  type="text" id="sorgCode" /></td>
								<td class="FieldButton" style="width:20%">
									<button onclick="queryElectionDealed()">查询</button>
									<button type="reset">重置</button>
								</td>
							</tr>
						</table>
						</fieldset>
						</form>
					</next:Html>
				</next:Panel>
				
				<next:EditGridPanel title="换届查询列表" id="organGrid" dataset="somElectionDataSet" height="100%" notSelectFirstRow="true">
					<next:TopBar>
						<next:ToolBarItem symbol="->"></next:ToolBarItem>
					</next:TopBar>
					<next:Columns>
						<next:RowNumberColumn/>
						<next:RadioBoxColumn></next:RadioBoxColumn>
						<next:Column header="社会组织名称"  field="SORG_NAME" sortable="true" editable="false"width="20%" ><next:TextField></next:TextField></next:Column>
						<next:Column header="登记证号"  field="SORG_CODE" sortable="true" editable="false"width="10%" ><next:TextField></next:TextField></next:Column>
						<next:Column header="换届时间" field="MEETING_DATE" sortable="true" align="center" editable="false" width="10%"><next:TextField/></next:Column>
						<next:Column header="规定完成时间" field="FINISHDATE" sortable="true" align="center"editable="false" width="10%"><next:TextField/></next:Column>
						<next:Column header="是否已办理章程核准" field="RULE"  renderer="changeRule" sortable="true"align="center" editable="false" width="15%"><next:TextField /></next:Column>
						<next:Column header="是否已办理会费备案" field="FEE"  renderer="changeFee" sortable="true" align="center"editable="false" width="15%"><next:TextField /></next:Column>
						<next:Column header="是否已办理负责人备案" field="DUTY" renderer="changeDuty" sortable="true" align="center"editable="false" width="15%"><next:TextField /></next:Column>
					</next:Columns> 
					<next:BottomBar>
						<next:PagingToolBar dataset="somElectionDataSet" />
					</next:BottomBar>
				</next:EditGridPanel>
			</next:Panel>
		<%}%>
	</next:Tabs>
</next:TabPanel>

</body>
<script language="javascript" type="text/javascript">
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
	if(checkPermit==1){
		var showServiceTab = L5.getCmp("tab");//tabPanel外面的panel 
		showServiceTab.hideTabStripItem(1);
	}
	daiBanDataset.setParameter("processType",procTypeId);	
	daiBanDataset.setParameter("actDefName",getActDefName());
	daiBanDataset.setParameter("tableName","SOM_APPLY");
	daiBanDataset.setParameter("tableKey","TASK_CODE");
	daiBanDataset.setParameter("applyShowColum","TASK_CODE");
	daiBanDataset.load();
	yiBanTaskDataset.setParameter("processType",procTypeId);	
	yiBanTaskDataset.setParameter("actDefName",getActDefName());
	yiBanTaskDataset.setParameter("tableName","SOM_APPLY");
	yiBanTaskDataset.setParameter("tableKey","TASK_CODE");
	yiBanTaskDataset.setParameter("applyShowColum","TASK_CODE");
	yiBanTaskDataset.load();
	if(act=='inform'){
	 	//通知申请人列表中查询备案相关事项加载方法
		somElectionDataSet.setParameter("applyType","009");
		somElectionDataSet.setParameter("sorgType","S");
		somElectionDataSet.setParameter("domicileCode",organArea);
		somElectionDataSet.load();
	}
}
//待办任务查询
function query(){
	var subjectDaiban=document.getElementById('subjectDaiban').value;
	if(subjectDaiban==''){
		daiBanDataset.setParameter("processType",procTypeId);	
		daiBanDataset.setParameter("actDefName",getActDefName());
		daiBanDataset.setParameter("tableName","SOM_APPLY");
		daiBanDataset.setParameter("tableKey","TASK_CODE");
		daiBanDataset.setParameter("applyShowColum","TASK_CODE");
		daiBanDataset.load();
	}else{
		daiBanDataset.setParameter("processType",procTypeId);	
		daiBanDataset.setParameter("actDefName",getActDefName());
		daiBanDataset.setParameter("tableName","SOM_APPLY");
		daiBanDataset.setParameter("tableKey","TASK_CODE");
		daiBanDataset.setParameter("applyShowColum","TASK_CODE");
		daiBanDataset.setParameter("mysetwhere","SUBJECT@LIKE:%"+subjectDaiban+"%");
		daiBanDataset.load();
	}
}
//查看待办流程图
function showState(){
	var daiBanTaskGridPanel=L5.getCmp("daiBanTaskGridPanel");
	var selecteds=daiBanTaskGridPanel.getSelectionModel().getSelections();
	if(selecteds.length!=1){
		L5.Msg.alert("提示","请选择一条您要查看的记录");
		return false;
	}
	var assignmentId=selecteds[0].get("ID");
	var url='jsp/workflow/monitor/flowview.jsp?assignmentId='+assignmentId;
	L5.forward(url);
}
//已办任务查询
function queryyiban(){
	var yibanSubject=document.getElementById('yibanSubject').value;
	if(yibanSubject==''){
		yiBanTaskDataset.setParameter("processType",procTypeId);	
		yiBanTaskDataset.setParameter("actDefName",getActDefName());
		yiBanTaskDataset.setParameter("tableName","SOM_APPLY");
		yiBanTaskDataset.setParameter("tableKey","TASK_CODE");
		yiBanTaskDataset.setParameter("applyShowColum","TASK_CODE");
		yiBanTaskDataset.load();
	}else {
		yiBanTaskDataset.setParameter("processType",procTypeId);	
		yiBanTaskDataset.setParameter("actDefName",getActDefName());
		yiBanTaskDataset.setParameter("tableName","SOM_APPLY");
		yiBanTaskDataset.setParameter("tableKey","TASK_CODE");
		yiBanTaskDataset.setParameter("applyShowColum","TASK_CODE");
		yiBanTaskDataset.setParameter("mysetwhere","SUBJECT@LIKE:%"+yibanSubject+"%");
		yiBanTaskDataset.load();	
	}
}
//查看已办任务
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
	var url='jsp/cams/sorg/apply/group/election/somGroupElectionDetail.jsp?taskCode='+rec.get("TASK_CODE")+"&method=yiban&act="+act+'&processId='+processId+"&actDefUniqueId="+actDefUniqueId+"&assignmentId="+assignmentId;
	L5.forward(url);
}
//查看已办流程图
function showStateyiban(){
	var yiBanTaskGridPanel=L5.getCmp("yiBanTaskGridPanel");
	var selecteds=yiBanTaskGridPanel.getSelectionModel().getSelections();
	if(selecteds.length!=1){
		L5.Msg.alert("提示","请选择一条您要查看的记录");
		return false;
	}
	var assignmentId=selecteds[0].get("ID");
	var url='jsp/workflow/monitor/flowview.jsp?assignmentId='+assignmentId;
	L5.forward(url);
}
function getActDefName(){
	if(act=='auditReport'){
		return "名称核准";
	}else if(act=='accept'){
		return "受理";
	}else if(act=='watch'){
		return "现场勘查";
	}else if(act=='examin'){
		return "初审";
	}else if(act=='check'){
		return "审核";
	}else if(act=='audit'){
		return "批准";
	}else if(act=='inform'){
		return "通知申请人";
	}else if(act=='supply'){
		return "补齐补正";
	}
}
//办理页面
function forDeal(){
	var userGrid=L5.getCmp('daiBanTaskGridPanel');
	var selecteds=userGrid.getSelectionModel().getSelections();
	if(selecteds.length!=1){
		L5.Msg.alert("提示","请选择一条您要查看的记录");
		return false;
	}
	var rec=selecteds[0];
	var processId=rec.get("PROCESS_ID");
	var actDefUniqueId=rec.get("ACT_DEF_UNIQUE_ID");
	var assignmentId=rec.get("ID");
	var url;
	if(act == 'supply'){
		var url='jsp/cams/sorg/apply/group/election/somGroupElectionEdit.jsp?method=UPDATE&act='+act+'&taskCode='+rec.get("TASK_CODE")+'&processId='+processId+"&actDefUniqueId="+actDefUniqueId+"&assignmentId="+assignmentId;
	}else{
		var url='jsp/cams/sorg/apply/group/election/somGroupElectionDetail.jsp?taskCode='+rec.get("TASK_CODE")+"&method=daiban&act="+act+'&processId='+processId+"&actDefUniqueId="+actDefUniqueId+"&assignmentId="+assignmentId;
	}
	L5.forward(url);
}
</script>
</html>