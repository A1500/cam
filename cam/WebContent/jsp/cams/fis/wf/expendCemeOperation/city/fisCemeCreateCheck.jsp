<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>受理任务查询</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="fisCemeCreateCheck.js"></script>
<script type="text/javascript" src="../../ep.js"></script>
<script language="javascript">
	var procTypeId="fisCemeExpendCity";
	var organType = '<%=BspUtil.getOrganType()%>';
	var organName = '<%=BspUtil.getOrganName()%>';
	

	var act=" ";
	var procDefUniqueId="8a898ca2416d56a701416d6fc5310096";	
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
</script>
</head>
<body>
<model:datasets>
	<model:dataset pageSize="10" id="daiBanDataset" cmd="com.inspur.cams.fis.base.cmd.FisCemeWorkflowQueryCmd" method="queryDaiBanEx" autoLoad="false" global="true">
		<model:record>
			<model:field name="TASK_STATE" type="string" />
		</model:record>
	</model:dataset>
	<model:dataset pageSize="10" id="yiBanTaskDataset" cmd="com.inspur.cams.fis.base.cmd.FisCemeWorkflowQueryCmd" method="queryYiBanEx" autoLoad="false" global="true">
		<model:record>
		</model:record>
	</model:dataset>
	<model:dataset id="endTaskDataset" cmd="com.inspur.cams.fis.base.cmd.FisCemeWorkflowQueryCmd" method="queryEndEx" autoLoad="false" global="true">
	</model:dataset>
	<!-- 13:县级, 14:乡镇级, 15:村级 -->
	<model:dataset id="dominateState" enumName="FIS.FUNERALHOME.DOMINATION" autoLoad="true" global="true">
	</model:dataset>
	<!-- 上报状态新更 -->
	<model:dataset id="ReportStateNew" enumName="FIS.CEMECREATE.REPORT.STATUS" autoLoad="true" global="true">
	</model:dataset>
	<!-- 0:已受理,1:检查通过,2:整改,3:审批通过,4:审批不通过  -->
	<model:dataset id="applyState" enumName="FIS.APLLY.STATE" autoLoad="true" global="true">
	</model:dataset>
</model:datasets>

<next:TabPanel id="tab" activeTab="0" width="100%"  height="100%">
		<next:TopBar>
				<next:ToolBarItem symbol="->"/>
				<next:ToolBarItem iconCls="detail" text="下载操作手册" handler="download"/>
			</next:TopBar>
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
						<table border="1" width="100%">
						<tr>
						 	<td class="FieldLabel" style="width:20%">公墓名称：</td>
							<td class="FieldInput" style="width:30%"><input type="text"  id="name" class="TextEditor" title="公墓名称" style="width:90%" /></td>	
							<td class="FieldLabel" style="width:20%">主办单位:</td>
							<td class="FieldInput" style="width:30%"><input type="text"  id="organizer" class="TextEditor" title="主办单位" style="width:90%" /></td>
						</tr>
						<tr>
						 	<td class="FieldLabel" style="width:20%">主办级别：</td>
							<td class="FieldInput" style="width:30%"><select id="domination" field="domination" style="width:90%"><option dataset="dominateState">主办级别</option></select></td>	
							<td class="FieldLabel" style="width:20%">申请时间:</td>
							<td class="FieldInput" style="width:30%"><input type="text"  id="applyTime" class="TextEditor" title="申请时间" style="width:90%"  /></td>
						</tr>
						<tr>
							<td class="FieldButton" colspan="4"><button onclick="queryDB()">查询</button>&nbsp;&nbsp;&nbsp;&nbsp;<button type="reset">重置</button></td>
						</tr>
					</table>
				</form>
						</div>
					</fieldset>
				</next:Html>
			</next:Panel>
			<next:GridPanel id="daiBanTaskGridPanel" title="待办流程列表" name="daiBanTaskGridPanel" width="100%" height="100%" dataset="daiBanDataset"  notSelectFirstRow="true">
				<next:TopBar>
					<next:ToolBarItem symbol="->"></next:ToolBarItem>
					<next:ToolBarItem iconCls="edit" text="办理" handler="forAccept"/>
					<next:ToolBarItem iconCls="detail" text="查看流转状态" handler="showState"/>
				</next:TopBar>
				<next:Columns>
					<next:RowNumberColumn width="30"/>
					<next:RadioBoxColumn></next:RadioBoxColumn>
					<next:Column id="processId" header="流程实例ID" field="PROCESS_ID" hidden="true" ></next:Column>
					<next:Column id="assignmentId" header="内码" field="ID" hidden="true" ></next:Column>
		        	<next:Column header="状态" field="TASK_STATE" width="40" align="center" renderer="setTaskState"><!-- renderer="setTaskState" align="center"> -->
					<next:TextField allowBlank="false"/>
					</next:Column>	  
	
		 			<next:Column id="name" header="公墓名称" field="NAME" width="140" ></next:Column>
		 			<next:Column field="APPLY_STATE" header="业务状态" width="10%" sortable="false" dataset="applyState"/>
		 			<next:Column field="IS_REPORT" header="上报状态" width="10%" sortable="false" dataset="ReportStateNew"/>
					<next:Column field="CUR_ACTIVITY" header="当前环节" width="10%" sortable="false"/>
					<next:Column field="CUR_ORGAN" header="当前单位名称" width="10%" sortable="false"/>
					<next:Column field="REC_TIME" header="接收时间" width="10%" sortable="false" renderer="renderDate2"/>
					<next:Column field="COM_TIME" header="处理时间" width="10%" sortable="false"/>
					<next:Column field="FILL_ORGAN_NAME" header="发起单位" width="10%" sortable="false"/>
					<next:Column field="PROC_CREATE_TIME" header="发起时间" width="10%" sortable="false" renderer="renderDate"/>
					<next:Column id="actLimitTime" header="环节限时时间" field="ACT_LIMIT_TIME" width="120" renderer="renderDate" ></next:Column>
					<next:Column id="actWarnTime" header="环节预警时间" field="ACT_WARN_TIME" width="120" renderer="renderDate" ></next:Column>
					</next:Columns>
					<next:BottomBar>
					<next:PagingToolBar  dataset="daiBanDataset"/>
				</next:BottomBar>
			</next:GridPanel>
		</next:Panel>
		
		<next:Panel title="已办任务" width="100%" height="100%">
			<next:Panel width="100%" border="0">
				<next:Html>			
					<fieldset style="overflow: visible;" class="GroupBox">
						<legend class="GroupBoxTitle">查询条件
							<img class="GroupBoxExpandButton" src="<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>" onclick="collapse(this);"/>									
						</legend>
						<div class="GroupBoxDiv" style="width: 100%;height: 100%;">	
					<form class="L5form">
						<table border="1" width="100%">
						<tr>
						 	<td class="FieldLabel" style="width:20%">公墓名称：</td>
							<td class="FieldInput" style="width:30%"><input type="text"  id="nameYB" class="TextEditor" title="公墓名称" style="width:90%" /></td>	
							<td class="FieldLabel" style="width:20%">主办单位:</td>
							<td class="FieldInput" style="width:30%"><input type="text"  id="organizerYB" class="TextEditor" title="主办单位" style="width:90%" /></td>
						</tr>
						<tr>
						 	<td class="FieldLabel" style="width:20%">主办级别：</td>
							<td class="FieldInput" style="width:30%"><select id="dominationYB" field="domination" style="width:90%"><option dataset="dominateState">主办级别</option></select></td>	
							<td class="FieldLabel" style="width:20%">申请时间:</td>
							<td class="FieldInput" style="width:30%"><input type="text"  id="applyTimeYB" class="TextEditor" title="申请时间" style="width:90%"  /></td>
						</tr>
						<tr>
							<td class="FieldButton" colspan="4"><button onclick="queryyiban()">查询</button>&nbsp;&nbsp;&nbsp;&nbsp;<button type="reset">重置</button></td>
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
					<next:ToolBarItem iconCls="detail" text="查看公墓信息" handler="showCemeInfoYB"/>
					<next:ToolBarItem iconCls="detail" text="查看流转状态" handler="showStateyiban"/>
				</next:TopBar>
				<next:Columns>
					<next:RowNumberColumn width="30"/>
					<next:RadioBoxColumn></next:RadioBoxColumn>
					<next:Column id="processId" header="流程实例ID" field="PROCESS_ID" hidden="true" ></next:Column>							
					<next:Column id="assignmentId" header="内码" field="ID" hidden="true" ></next:Column>
		        	<next:Column id="name" header="公墓名称" field="NAME" width="140" ></next:Column>
		 			<next:Column field="APPLY_STATE" header="业务状态" width="10%" sortable="false" dataset="applyState"/>
		 			<next:Column field="IS_REPORT" header="上报状态" width="10%" sortable="false" dataset="ReportStateNew"/>
					<next:Column field="CUR_ACTIVITY" header="当前环节" width="10%" sortable="false"/>
					<next:Column field="CUR_ORGAN" header="当前单位名称" width="10%" sortable="false"/>
					<next:Column field="REC_TIME" header="接收时间" width="10%" sortable="false" renderer="renderDate2"/>
					<next:Column field="COM_TIME" header="处理时间" width="10%" sortable="false"/>
					<next:Column field="FILL_ORGAN_NAME" header="发起单位" width="10%" sortable="false"/>
					<next:Column field="PROC_CREATE_TIME" header="发起时间" width="10%" sortable="false" renderer="renderDate"/>
					</next:Columns>
					<next:BottomBar>
					<next:PagingToolBar  dataset="yiBanTaskDataset"/>
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
						<table border="1" width="100%">
						<tr>
						 	<td class="FieldLabel" style="width:20%">公墓名称：</td>
							<td class="FieldInput" style="width:30%"><input type="text"  id="nameEnd" class="TextEditor" title="公墓名称" style="width:90%" /></td>	
							<td class="FieldLabel" style="width:20%">主办单位:</td>
							<td class="FieldInput" style="width:30%"><input type="text"  id="organizerEnd" class="TextEditor" title="主办单位" style="width:90%" /></td>
						</tr>
						<tr>
						 	<td class="FieldLabel" style="width:20%">主办级别：</td>
							<td class="FieldInput" style="width:30%"><select id="dominationEnd" field="domination" style="width:90%"><option dataset="dominateState">主办级别</option></select></td>	
							<td class="FieldLabel" style="width:20%">申请时间:</td>
							<td class="FieldInput" style="width:30%"><input type="text"  id="applyTimeEnd" class="TextEditor" title="申请时间" style="width:90%"  /></td>
						</tr>
						<tr>
							<td class="FieldButton" colspan="4"><button onclick="queryEnd()">查询</button>&nbsp;&nbsp;&nbsp;&nbsp;<button type="reset">重置</button></td>
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
					<next:ToolBarItem iconCls="detail" text="查看公墓信息" handler="showCemeInfoEND"/>
					<next:ToolBarItem iconCls="detail"  text="查看流转状态" handler="showStateEnd"/>
				</next:TopBar>
				<next:Columns>
	   				<next:RowNumberColumn/>
	    			<next:RadioBoxColumn></next:RadioBoxColumn>
					<next:Column id="processId" header="流程实例ID" field="PROCESS_ID" hidden="true" ></next:Column>
					<next:Column id="assignmentId" header="内码" field="ID" hidden="true" ></next:Column>
		        	<next:Column id="name" header="公墓名称" field="NAME" width="140" ></next:Column>
	 				<next:Column field="APPLY_STATE" header="业务状态" width="10%" sortable="false" dataset="applyState"/>
	 				<next:Column field="IS_REPORT" header="上报状态" width="10%" sortable="false" dataset="ReportStateNew"/>
					<next:Column field="CUR_ACTIVITY" header="当前环节" width="10%" sortable="false"/>
					<next:Column field="CUR_ORGAN" header="当前单位名称" width="10%" sortable="false"/>
					<next:Column field="REC_TIME" header="接收时间" width="10%" sortable="false" renderer="renderDate2"/>
					<next:Column field="COM_TIME" header="处理时间" width="10%" sortable="false"/>
					<next:Column field="FILL_ORGAN_NAME" header="发起单位" width="10%" sortable="false"/>
					<next:Column field="PROC_CREATE_TIME" header="发起时间" width="10%" sortable="false" renderer="renderDate"/>
					</next:Columns>
					<next:BottomBar>
					<next:PagingToolBar dataset="endTaskDataset" />
				</next:BottomBar>
			</next:GridPanel>
		</next:Panel>			
	</next:Tabs>
</next:TabPanel>

</body>

</html>