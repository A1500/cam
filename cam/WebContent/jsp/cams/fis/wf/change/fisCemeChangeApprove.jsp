<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>受理任务查询</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="fisCemeChangeApprove.js"></script> 
<script type="text/javascript" src="../ep.js"></script>
<script language="javascript">
	var organCode = '<%=BspUtil.getOrganCode()%>' ;
	var organType = '<%=BspUtil.getOrganType()%>';
	var organName = '<%=BspUtil.getOrganName()%>';
	var procTypeId="fisCemeChange";
	var act="";
	var actId="<%=request.getParameter("actId")%>";
	var procDefUniqueId="8a898c9a40665123014066bc8ce90004";	
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
</script>
</head>
<body>
<model:datasets>
	<model:dataset pageSize="10" id="daiBanDataset" cmd="com.inspur.cams.fis.base.cmd.FisCemeWorkflowQueryCmd" method="queryDaiBan" autoLoad="false" global="true">
		<model:record>
			<model:field name="TASK_STATE" type="string" />
		</model:record>
	</model:dataset>
	<model:dataset pageSize="10" id="yiBanTaskDataset" cmd="com.inspur.cams.fis.base.cmd.FisCemeWorkflowQueryCmd" method="queryYiBan" autoLoad="false" global="true">
		<model:record>
	</model:record>
	</model:dataset>
	<model:dataset id="endTaskDataset" cmd="com.inspur.cams.fis.base.cmd.FisCemeWorkflowQueryCmd" method="queryEnd" autoLoad="false" global="true">
	</model:dataset>
	
	<model:dataset id="cataLogCodeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value="FIS_CEME_INFO"></model:param>
			<model:param name="value" value="RECORD_ID"></model:param>
			<model:param name="text" value="NAME"></model:param>
		</model:params>
	</model:dataset>
	
	<!--字典表将RECORD_ID转为NAME -->
	<model:dataset id="fisCemeInfoDs" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
			<model:params>
			<model:param name="dic" value="FIS_CEME_INFO"></model:param>
			<model:param name="value" value="RECORD_ID"></model:param>
			<model:param name="text" value="NAME"></model:param>
			</model:params>
	</model:dataset>
	<!-- 业务状态 -->
	<model:dataset id="cemeState" enumName="FIS.CEME.CHECK.STATUS" global="true" autoLoad="true"></model:dataset>
	<!-- 上报状态 -->
	<model:dataset id="fisCemeIsReport" enumName="FIS.CEME.REPORT.STATUS" global="true" autoLoad="true"></model:dataset>
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
							<form onsubmit="return false;" class="L5form">
								<table border="1" width="100%">
									<tr>
									 	<td class="FieldLabel" style="width:10%">公墓名称：</td>
						                <td class="FieldInput" style="width:40%"><input type="text" id="subjectDaiban" style="width:40%"/></td>
										<td class="FieldButton" style="width:10%"><button onclick="query()">查询</button></td>
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
					<next:ToolBarItem iconCls="detail" text="明细" handler="handledaiban"/>
					<next:ToolBarItem iconCls="detail" text="流程图" handler="showState"/>
				</next:TopBar>
				<next:Columns>
					<next:RowNumberColumn width="30"/>
					<next:RadioBoxColumn></next:RadioBoxColumn>
					<next:Column field="RECORD_ID" header="公墓记录编码" width="10%" sortable="false" hidden="true"/>
	   				<next:Column field="CEME_APPLY_ID" header="业务审批编码" width="10%" sortable="false" hidden="true"/>
	   				<next:Column field="RECORD_ID" header="公墓名称" width="10%" sortable="false" dataset="fisCemeInfoDs"/>
					<next:Column field="APPLY_STATE" header="业务状态" width="10%" sortable="false" dataset="cemeState"/>
			 		<next:Column field="IS_REPORT" header="上报状态" width="10%" sortable="false" dataset="fisCemeIsReport"/>
					<next:Column field="CUR_ACTIVITY" header="当前环节" width="10%" sortable="false"/>
					<next:Column field="CUR_ORGAN" header="当前单位" width="10%" sortable="false"/>
					<next:Column field="REC_TIME" header="接收时间" width="15%" sortable="false" renderer="renderDate"/>
					<next:Column field="COM_TIME" header="处理时间" width="15%" sortable="false" renderer="renderDate"/>
					<next:Column field="FILL_ORGAN_NAME" header="发起单位" width="10%" sortable="false" />
					<next:Column field="REC_TIME" header="发起时间" width="10%" sortable="false" renderer="renderDate"/>	
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
							<form onsubmit="return false;" class="L5form">
								<table border="1" width="100%">
									<tr>
									 	<td class="FieldLabel" style="width:10%">公墓名称：</td>
						                <td class="FieldInput" style="width:40%"><input type="text"  id="yibanSubject" style="width:40%"/></td>
										<td class="FieldButton" style="width:10%"><button onclick="queryyiban()">查询</button></td>
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
					<next:ToolBarItem iconCls="detail" text="明细" handler="handleyiban"/>
					<next:ToolBarItem iconCls="detail" text="流程明细" handler="showStateyiban"/>
				</next:TopBar>
				<next:Columns>
					<next:RowNumberColumn width="30"/>
					<next:RadioBoxColumn></next:RadioBoxColumn>
					<next:Column field="RECORD_ID" header="公墓记录编码" width="10%" sortable="false" hidden="true"/>
	   				<next:Column field="CEME_APPLY_ID" header="业务审批编码" width="10%" sortable="false" hidden="true"/>
	   				<next:Column field="RECORD_ID" header="公墓名称" width="10%" sortable="false" dataset="fisCemeInfoDs"/>
					<next:Column field="APPLY_STATE" header="业务状态" width="10%" sortable="false" dataset="cemeState"/>
			 		<next:Column field="IS_REPORT" header="上报状态" width="10%" sortable="false" dataset="fisCemeIsReport"/>
					<next:Column field="CUR_ACTIVITY" header="当前环节" width="10%" sortable="false"/>
					<next:Column field="CUR_ORGAN" header="当前单位" width="10%" sortable="false"/>
					<next:Column field="REC_TIME" header="接收时间" width="15%" sortable="false" renderer="renderDate"/>
					<next:Column field="COM_TIME" header="处理时间" width="15%" sortable="false" renderer="renderDate"/>
					<next:Column field="FILL_ORGAN_NAME" header="发起单位" width="10%" sortable="false"/>
					<next:Column field="REC_TIME" header="发起时间" width="10%" sortable="false" renderer="renderDate"/>	
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
							<table  border="1" width="100%">
								<tr>
								 	<td class="FieldLabel" style="width:10%">公墓名称：</td>
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
					<next:ToolBarItem iconCls="detail"  text="明细" handler="handleEnd"/>
					<next:ToolBarItem iconCls="detail"  text="流程明细" handler="showStateEnd"/>
				</next:TopBar>
				<next:Columns>
	   				<next:RowNumberColumn/>
	    			<next:RadioBoxColumn></next:RadioBoxColumn>
					<next:Column field="RECORD_ID" header="公墓记录编码" width="10%" sortable="false" hidden="true"/>
	   				<next:Column field="CEME_APPLY_ID" header="业务审批编码" width="10%" sortable="false" hidden="true"/>
	   				<next:Column field="RECORD_ID" header="公墓名称" width="10%" sortable="false" dataset="fisCemeInfoDs"/>
					<next:Column field="APPLY_STATE" header="业务状态" width="10%" sortable="false" dataset="cemeState"/>
			 		<next:Column field="IS_REPORT" header="上报状态" width="10%" sortable="false" dataset="fisCemeIsReport"/>
					<next:Column field="CUR_ACTIVITY" header="当前环节" width="10%" sortable="false"/>
					<next:Column field="CUR_ORGAN" header="当前单位" width="10%" sortable="false"/>
					<next:Column field="REC_TIME" header="接收时间" width="15%" sortable="false" renderer="renderDate"/>
					<next:Column field="COM_TIME" header="处理时间" width="15%" sortable="false" renderer="renderDate"/>
					<next:Column field="FILL_ORGAN_NAME" header="发起单位" width="10%" sortable="false"/>
					<next:Column field="REC_TIME" header="发起时间" width="10%" sortable="false" renderer="renderDate"/>
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