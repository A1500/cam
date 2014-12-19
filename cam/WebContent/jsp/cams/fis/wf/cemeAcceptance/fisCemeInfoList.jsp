<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<%@ page import="com.inspur.cams.comm.util.IdHelp"%>
<%@ page import="com.inspur.cams.comm.util.DateUtil"%>

<html>
<head>
<title>殡葬业务公墓信息表列表</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="fisCemeInfoList.js"></script>
<script type="text/javascript" src="../ep.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
</head>
<body>
<script type="text/javascript">
   
	var organCode = '<%=BspUtil.getOrganCode()%>' ;
	var organType = '<%=BspUtil.getOrganType()%>';
	var organName = '<%=BspUtil.getOrganName()%>';
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

<model:datasets>
	<model:dataset id="fisCemeApplyInfoDataSet" cmd="com.inspur.cams.fis.base.cmd.FisCemeApplyInfoQueryCmd"  method="queryYS" pageSize="10">
		<model:record fromBean="com.inspur.cams.fis.base.data.FisCemeApplyInfo"/>
	</model:dataset>
	<model:dataset id="fisCemeDataSet" cmd="com.inspur.cams.fis.base.cmd.FisCemeInfoQueryCmd" pageSize="20">
		<model:record fromBean="com.inspur.cams.fis.base.data.FisCemeInfo"/>
	</model:dataset>
		<model:dataset pageSize="10" id="workflowDs" cmd="com.inspur.cams.fis.base.cmd.FisCemeWorkflowQueryCmd" method="queryCreateFlow" autoLoad="false" global="true">
	</model:dataset>
	<!-- 0:已受理,1:检查通过,2:整改,3:审批通过,4:审批不通过  -->
	<model:dataset id="applyState" enumName="FIS.CEMEACCEPTANCE.STATE" autoLoad="true" global="true">
	</model:dataset>
		<!-- 13:县级, 14:乡镇级, 15:村级 -->
	<model:dataset id="dominateState" enumName="FIS.FUNERALHOME.DOMINATION" autoLoad="true" global="true">
	</model:dataset>
	<!-- 上报状态 -->
	<model:dataset id="ReportState" enumName="FIS.CEME.ISREPORT" autoLoad="true" global="true">
	</model:dataset>
	<!-- 上报状态新更 -->
	<model:dataset id="ReportStateNew" enumName="FIS.CEMECREATE.REPORT.STATUS" autoLoad="true" global="true">
	</model:dataset>

</model:datasets>
		<next:Panel title="公墓验收受理任务查询" width="100%" border="0" autoHeight="true" titleCollapse="true" collapsible="true" >
			<next:TopBar>
				<next:ToolBarItem symbol="->"/>
				<next:ToolBarItem iconCls="detail" text="下载操作手册" />
			</next:TopBar>
			<next:Html>
			<fieldset style="overflow:visible;" class="GroupBox">
			<legend class="GroupBoxTitle">查询条件</legend>
				<form class="L5form">
					<table border="1" width="100%">
						<tr>
						 	<td class="FieldLabel" style="width:10%">公墓名称：</td>
							<td class="FieldInput" style="width:20%"><input type="text"  id="name" class="TextEditor" title="公墓名称" style="width:80%" /></td>	
							<td class="FieldLabel" style="width:10%">发起单位:</td>
							<td class="FieldInput" style="width:20%"><input type="text"  id="fillOrganName" class="TextEditor" title="发起单位" style="width:80%" /></td>
							<td class="FieldButton" style="width:30%"><button onclick="querys()">查询</button>&nbsp;&nbsp;&nbsp;&nbsp;<button type="reset">重置</button></td>
						</tr>

					</table>
				</form>
			</fieldset>
			</next:Html>
		</next:Panel>
		<next:EditGridPanel title="公墓验收受理任务列表" id="grid" dataset="fisCemeApplyInfoDataSet" width="100%" stripeRows="true" height="99.9%">
            <next:TopBar>
				<next:ToolBarItem symbol="->"></next:ToolBarItem>
				<next:ToolBarItem iconCls="add" text="增加" handler="insert" id="insert"></next:ToolBarItem>
				<next:ToolBarItem iconCls="edit" text="修改" handler="update"></next:ToolBarItem>
				<next:ToolBarItem iconCls="delete" text="删除" handler="del"></next:ToolBarItem>
				<next:ToolBarItem iconCls="select" text="提交" handler="submit"></next:ToolBarItem>
				<next:ToolBarItem iconCls="detail" text="明细" handler="detail"></next:ToolBarItem>
				<next:ToolBarItem iconCls="detail" text="流程明细" handler="detailWF"></next:ToolBarItem>
			</next:TopBar>
				<next:Columns>
				   		<next:RowNumberColumn/>
				   		<next:RadioBoxColumn/>
				   		
				   		<next:Column field="NAME" header="公墓名称" width="10%" sortable="false" />
						<next:Column field="APPLY_STATE" header="业务状态" width="10%" sortable="false" dataset="applyState" />
						<next:Column field="IS_REPORT" header="上报状态" width="10%" sortable="false" dataset="ReportStateNew"/>
				   		<next:Column field="CUR_ACTIVITY" header="当前环节" width="10%" sortable="false"/>
						<next:Column field="CUR_ORGAN" header="当前单位" width="10%" sortable="false"/>
						<next:Column field="REC_TIME" header="接受时间" width="10%" sortable="false" renderer="renderDate" />
						<next:Column field="COM_TIME" header="处理时间" width="10%" sortable="false" renderer="renderDate" />
						<next:Column field="FILL_ORGAN_NAME" header="发起单位" width="10%" sortable="false"/>
						<next:Column field="CREATE_TIME" header="发起时间" width="10%" sortable="false" renderer="renderDate" />
						<!--公墓名称、业务状态、上报状态、当前环节、当前单位、接收时间、处理时间、发起单位、发起时间；-->
				</next:Columns>
			<next:BottomBar>
				<next:PagingToolBar dataset="fisCemeApplyInfoDataSet"/>
			</next:BottomBar>
		</next:EditGridPanel>

</body>
</html>