<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<%@ page import="com.inspur.cams.comm.util.IdHelp"%>

<html>
<head>
<title>殡葬业务公墓信息表列表</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="fisCemeLogoffApprovalList.js"></script>
<script type="text/javascript" src="../ep.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript">
	var organCode = '<%=BspUtil.getOrganCode()%>' ;
	var organType = '<%=BspUtil.getOrganType()%>';
	var organName = '<%=BspUtil.getOrganName()%>';
</script>
<script language="javascript">
	var procTypeId="fidCemeLoginoff";
	//var act="现场勘查";
	var procDefUniqueId="8a898ca14061f783014061f9bf8b0023";	
	
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
	function collapse(element){
		var fieldsetParent=L5.get(element).findParent("fieldset");
		if(element.expand==null||element.expand==true){	
			fieldsetParent.getElementsByTagName("div")[0].style.display="none";
			element.src = '<%=SkinUtils.getImage(request,"groupbox_expand.gif")%>';
			element.expand=false;
		}else{
			fieldsetParent.getElementsByTagName("div")[0].style.display="";
			element.src = '<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>';
			element.expand =true;
		}
	}
</script>
</head>
<body>
<model:datasets>
	<model:dataset id="fisCemeInfoDs" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
			<model:params>
			<model:param name="dic" value="FIS_CEME_INFO"></model:param>
			<model:param name="value" value="RECORD_ID"></model:param>
			<model:param name="text" value="NAME"></model:param>
			</model:params>
	</model:dataset>
	<model:dataset pageSize="10" id="daiBanDataset" cmd="com.inspur.cams.fis.base.cmd.FisCemeWorkflowQueryCmd" method="queryDaiBan" autoLoad="false" global="true">
		<model:record >
		   <model:field name="TASK_STATE" type="string" />
		</model:record>
	</model:dataset>
	<model:dataset pageSize="10" id="yiBanDataset" cmd="com.inspur.cams.fis.base.cmd.FisCemeWorkflowQueryCmd" method="queryYiBan" autoLoad="false" global="true">
		<model:record>
		</model:record>
	</model:dataset>
	<model:dataset pageSize="10" id="banjieDataset" cmd="com.inspur.cams.fis.base.cmd.FisCemeWorkflowQueryCmd" method="queryEnd" autoLoad="false" global="true">
		<model:record>
		</model:record>
	</model:dataset>
	<model:dataset id="fisCemeLogoffDs" cmd="com.inspur.cams.fis.base.cmd.FisCemeLogoffQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.fis.base.data.FisCemeLogoff"/>
	</model:dataset>
	<model:dataset id="fisCemeApplyState" enumName="FIS.CEME.CHECK.STATUS" global="true" autoLoad="true">
	</model:dataset>
	<model:dataset id="fisCemeIsReport" enumName="FIS.CEME.REPORT.STATUS" global="true" autoLoad="true">
	</model:dataset>
	<model:dataset id="fisCemeInfoDataSet" cmd="com.inspur.cams.fis.base.cmd.FisCemeInfoQueryCmd" pageSize="200">
		<model:record fromBean="com.inspur.cams.fis.base.data.FisCemeInfo"/>
	</model:dataset>
</model:datasets>
<next:ViewPort>
<next:TabPanel>
    <next:TopBar>
       <next:ToolBarItem symbol="->"></next:ToolBarItem>
       <next:ToolBarItem handler="download" iconCls="detail" text="下载操作手册"></next:ToolBarItem>
    </next:TopBar>	
<next:Tabs>
  <next:Panel title="待办任务" width="100%" height="100%">
	<next:Panel width="100%" autoHeight="true" titleCollapse="true" collapsible="true" >
		<next:Html><center>		 
		<fieldset  style="width:98%;overflow: visible;" class="GroupBox">
		<legend class="GroupBoxTitle">
			查询条件 <img class="GroupBoxExpandButton"
				src="<%=SkinUtils.getImage(request,
							"groupbox_collapse.gif")%>"
				onclick="collapse(this)" />
		</legend>
		<div>
			<form style="width: 98%; height: 100%;" class="L5form">
				<table  border="1" width="100%">
					<tr>
					 	<td class="FieldLabel" style="width:10%">公墓名称</td>
		                <td class="FieldInput" style="width:20%"><input id="dbName" style="width:80%"/></td>
		                <td class="FieldLabel" style="width:10%">发起单位</td>
		                <td class="FieldInput" style="width:20%"><input id="dbFillName" style="width:80%"/></td>							               
		                <td class="FieldButton" style="width:30%"><button onclick="query()">查询</button>&nbsp;&nbsp;&nbsp;
						<button type="reset">重置</button></td>
					</tr>
				</table>
			</form>
		</div>
		</fieldset>
		</center></next:Html>
	</next:Panel>
	<next:GridPanel id="daiBanGridPanel" title="待办任务列表" dataset="daiBanDataset" width="100%" height="100%" stripeRows="true" notSelectFirstRow="true">
		<next:TopBar>
		     <next:ToolBarItem symbol="->"></next:ToolBarItem>
		     <next:ToolBarItem iconCls="edit" text="办理" handler="handle"></next:ToolBarItem>
		     <next:ToolBarItem iconCls="detail" text="明细" handler="showDetail"></next:ToolBarItem>
		     <next:ToolBarItem iconCls="detail" text="流程图" handler="showState"></next:ToolBarItem>
		</next:TopBar>
		<next:Columns>
	 		<next:RowNumberColumn/>
	 		<next:RadioBoxColumn/>
	 		<next:Column field="TASK_STATE" header="状态" width="5%" sortable="false" renderer="setTaskState" align="center"/>
	 		<next:Column field="RECORD_ID" header="公墓名称" width="10%" sortable="false" dataset="fisCemeInfoDs"/>
	 		<next:Column field="APPLY_STATE" header="业务状态" width="10%" sortable="false" dataset="fisCemeApplyState"/>
	 		<next:Column field="IS_REPORT" header="上报状态" width="10%" sortable="false" dataset="fisCemeIsReport"/>
			<next:Column field="CUR_ACTIVITY" header="当前环节" width="10%" sortable="false"/>
			<next:Column field="CUR_ORGAN" header="当前单位名称" width="10%" sortable="false"/>
			<next:Column field="REC_TIME" header="接收时间" width="10%" sortable="false"/>
			<next:Column field="FILL_ORGAN_NAME" header="发起单位" width="10%" sortable="false"/>
			<next:Column field="PROC_CREATE_TIME" header="发起时间" width="10%" sortable="false" renderer="renderDate"/>
		</next:Columns>
		<next:BottomBar>
			<next:PagingToolBar dataset="daiBanDataset" />
		</next:BottomBar>
	</next:GridPanel>
	</next:Panel>
	
	<next:Panel title="已办任务" width="100%" height="100%">
	<next:Panel width="100%" autoHeight="true" titleCollapse="true" collapsible="true" >	
		<next:Html><center>		 
		<fieldset  style="width:98%;overflow: visible;" class="GroupBox">
		<legend class="GroupBoxTitle">
			查询条件 <img class="GroupBoxExpandButton"
				src="<%=SkinUtils.getImage(request,
							"groupbox_collapse.gif")%>"
				onclick="collapse(this)" />
		</legend>
		<div>
			<form style="width: 98%; height: 100%;" class="L5form">
				<table  border="1" width="100%">
					<tr>
					 	<td class="FieldLabel" style="width:10%">公墓名称</td>
		                <td class="FieldInput" style="width:20%"><input id="ybName" style="width:80%"/></td>	
		                <td class="FieldLabel" style="width:10%">发起单位</td>
		                <td class="FieldInput" style="width:20%"><input id="ybFillName" style="width:80%"/></td>					               
		                <td class="FieldButton" style="width:30%"><button onclick="queryYiban()">查询</button>&nbsp;&nbsp;&nbsp;
						<button type="reset">重置</button></td>
					</tr>
				</table>
			</form>
		</div>
		</fieldset>
		</center></next:Html>
	</next:Panel>
	<next:GridPanel id="yiBanGridPanel" title="已办任务列表" dataset="yiBanDataset" width="100%" height="100%" stripeRows="true" notSelectFirstRow="true">
		<next:TopBar>
		     <next:ToolBarItem symbol="->"></next:ToolBarItem>
		     <next:ToolBarItem iconCls="detail" text="查看" handler="handleyiban"></next:ToolBarItem>
		     <next:ToolBarItem iconCls="detail" text="流程图" handler="showStateyiban"></next:ToolBarItem>
		</next:TopBar>
		<next:Columns>
	 		<next:RowNumberColumn/>
	 		<next:RadioBoxColumn/>
	 		<next:Column field="RECORD_ID" header="公墓名称" width="10%" sortable="false" dataset="fisCemeInfoDs"/>
	 		<next:Column field="APPLY_STATE" header="业务状态" width="10%" sortable="false" dataset="fisCemeApplyState"/>
	 		<next:Column field="IS_REPORT" header="上报状态" width="10%" sortable="false" dataset="fisCemeIsReport"/>
			<next:Column field="CUR_ACTIVITY" header="当前环节" width="10%" sortable="false"/>
			<next:Column field="CUR_ORGAN" header="当前单位名称" width="10%" sortable="false"/>
			<next:Column field="REC_TIME" header="接收时间" width="10%" sortable="false"/>
			<next:Column field="END_TIME" header="处理时间" width="10%" sortable="false" renderer="renderDate"/>
			<next:Column field="FILL_ORGAN_NAME" header="发起单位" width="10%" sortable="false"/>
			<next:Column field="PROC_CREATE_TIME" header="发起时间" width="10%" sortable="false" renderer="renderDate"/>
		</next:Columns>
		<next:BottomBar>
			<next:PagingToolBar dataset="yiBanDataset" />
		</next:BottomBar>
	</next:GridPanel>
	</next:Panel>
	
		<next:Panel title="办结任务" width="100%" height="100%">
	<next:Panel width="100%" autoHeight="true" titleCollapse="true" collapsible="true" >	
		<next:Html><center>		 
		<fieldset  style="width:98%;overflow: visible;" class="GroupBox">
		<legend class="GroupBoxTitle">
			查询条件 <img class="GroupBoxExpandButton"
				src="<%=SkinUtils.getImage(request,
							"groupbox_collapse.gif")%>"
				onclick="collapse(this)" />
		</legend>
		<div>
			<form style="width: 98%; height: 100%;" class="L5form">
				<table  border="1" width="100%">
					<tr>
					 	<td class="FieldLabel" style="width:10%">公墓名称</td>
		                <td class="FieldInput" style="width:20%"><input id="bjName" style="width:80%"/></td>
		                <td class="FieldLabel" style="width:10%">发起单位</td>
		                <td class="FieldInput" style="width:20%"><input id="bjFillName" style="width:80%"/></td>						               
		                <td class="FieldButton" style="width:30%"><button onclick="queryEnd()">查询</button>&nbsp;&nbsp;&nbsp;
						<button type="reset">重置</button></td>
					</tr>
				</table>
			</form>
		</div>
		</fieldset>
		</center></next:Html>
	</next:Panel>
	<next:GridPanel id="banjieGridPanel" title="办结任务列表" dataset="banjieDataset" width="100%" height="100%" stripeRows="true" notSelectFirstRow="true">
		<next:TopBar>
		     <next:ToolBarItem symbol="->"></next:ToolBarItem>
		     <next:ToolBarItem iconCls="detail" text="查看" handler="handleEnd"></next:ToolBarItem>
		     <next:ToolBarItem iconCls="detail" text="流程图" handler="showStateEnd"></next:ToolBarItem>
		</next:TopBar>
		<next:Columns>
	 		<next:RowNumberColumn/>
	 		<next:RadioBoxColumn/>
	 		<next:Column field="RECORD_ID" header="公墓名称" width="10%" sortable="false" dataset="fisCemeInfoDs"/>
	 		<next:Column field="APPLY_STATE" header="业务状态" width="10%" sortable="false" dataset="fisCemeApplyState"/>
	 		<next:Column field="IS_REPORT" header="上报状态" width="10%" sortable="false" dataset="fisCemeIsReport"/>
			<next:Column field="CUR_ACTIVITY" header="当前环节" width="10%" sortable="false"/>
			<next:Column field="CUR_ORGAN" header="当前单位" width="10%" sortable="false"/>
			<next:Column field="REC_TIME" header="接收时间" width="10%" sortable="false"/>
			<next:Column field="END_TIME" header="处理时间" width="10%" sortable="false" renderer="renderDate"/>
			<next:Column field="FILL_ORGAN_NAME" header="发起单位" width="10%" sortable="false"/>
			<next:Column field="PROC_CREATE_TIME" header="发起时间" width="10%" sortable="false" renderer="renderDate"/>
		</next:Columns>
		<next:BottomBar>
			<next:PagingToolBar dataset="banjieDataset" />
		</next:BottomBar>
	</next:GridPanel>
	</next:Panel>
	</next:Tabs>
</next:TabPanel>
</next:ViewPort>
</body>
</html>