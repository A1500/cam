<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>受理任务查询</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="fisCemeAcceptanceHandle.js"></script>
<script language="javascript">
	var procTypeId="fisCemeAcceptanceMunicipal";
	var organType = '<%=BspUtil.getOrganType()%>';
	var organTest = '<%=BspUtil.getCorpOrgan().getOrganName()%>';
	var act=" ";
	var procDefUniqueId="8a898ca241b690630141b6cf54e80022";	
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
	<model:dataset pageSize="10" id="daiBanDataset" cmd="com.inspur.cams.fis.base.cmd.FisCemeWorkflowQueryCmd" method="queryDaiBanYS" autoLoad="false" global="true">
		<model:record>
			<model:field name="TASK_STATE" type="string" />
		</model:record>
	</model:dataset>
	<model:dataset pageSize="10" id="yiBanTaskDataset" cmd="com.inspur.cams.fis.base.cmd.FisCemeWorkflowQueryCmd" method="queryYiBanYS" autoLoad="false" global="true">
		<model:record>
		</model:record>
	</model:dataset>
	<model:dataset id="endTaskDataset" cmd="com.inspur.cams.fis.base.cmd.FisCemeWorkflowQueryCmd" method="queryEndYS" autoLoad="false" global="true">
	</model:dataset>
	<!-- 13:县级, 14:乡镇级, 15:村级 -->
	<model:dataset id="dominateState" enumName="FIS.FUNERALHOME.DOMINATION" autoLoad="true" global="true">
	</model:dataset>
		<!-- 业务状态  -->
	<model:dataset id="applyState" enumName="FIS.CEMEACCEPTANCE.STATE" autoLoad="true" global="true">
	</model:dataset>
	<!-- 上报状态新更 -->
	<model:dataset id="ReportStateNew" enumName="FIS.CEMECREATE.REPORT.STATUS" autoLoad="true" global="true">
	</model:dataset>
</model:datasets>

<next:TabPanel id="tab" activeTab="0" width="100%"  height="100%">
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
						<td class="FieldLabel" style="width:10%">发起单位:</td>
							<td class="FieldInput" style="width:20%"><input type="text"  id="fillOrganName" class="TextEditor" title="发起单位" style="width:80%" /></td>
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
					<next:ToolBarItem iconCls="add" text="办理" handler="forAccept"/>
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
							<td class="FieldLabel" style="width:10%">发起单位:</td>
							<td class="FieldInput" style="width:20%"><input type="text"  id="fillOrganNameYB" class="TextEditor" title="发起单位" style="width:80%" /></td>
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
					<next:ToolBarItem iconCls="detail" text="查看公墓信息" handler="handleyiban"/>
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
							<td class="FieldLabel" style="width:10%">发起单位:</td>
							<td class="FieldInput" style="width:20%"><input type="text"  id="fillOrganNameEnd" class="TextEditor" title="发起单位" style="width:80%" /></td>
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
					<next:ToolBarItem iconCls="detail"  text="查看公墓信息" handler="handleEnd"/>
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