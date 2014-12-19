<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<script type="text/javascript">
</script>
<title>农村民主选举列表</title>
<next:ScriptManager/>
<script type="text/javascript" src="cdcElectionList.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<jsp:include page="../../util/cdcOrgan.jsp" flush="true"/>
</head>
<body>
<model:datasets>
	<model:dataset id="electionInfoDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcElectionInfoQueryCmd" method="queryInfos" pageSize="20">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcElectionInfo"/>
	</model:dataset>
	<model:dataset id="reportWorkDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcReportWorkQueryCmd" method="getDic" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"/>
		<model:params>
			<model:param name="reportType" value='R11'/>
			<model:param name="organType" value='N'/>
		</model:params>
	</model:dataset>
	<model:dataset id="insertDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcReportWorkQueryCmd" method="getDic" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"/>
		<model:params>
			<model:param name="reportType" value='R11'/>
			<model:param name="organType" value='N'/>
		</model:params>
	</model:dataset>
	<model:dataset id="YorN" enumName="COMM.YESORNO" autoLoad="true" global="true" />
	<model:dataset id="statusDataSet" enumName="CDC.STATUS" autoLoad="true" global="true"/>
	<model:dataset id="completeResultDataSet" enumName="CDC.ELECTION.COMPLETERESULT" autoLoad="true" global="true" />
</model:datasets>
<next:Panel width="100%" border="0">
	<next:Html>
	<fieldset style="overflow:visible;" class="GroupBox">
	<legend class="GroupBoxTitle">查询条件</legend>
		<form class="L5form">
			<table border="1" width="100%">
				<tr>
					<td class="FieldLabel" style="width:10%">填报日期：</td>
					<td class="FieldInput" style="width:12%"><select id="reportDate" field="reportDate"><option dataset="reportWorkDataSet"/></select></td>
					<td class="FieldLabel" style="width:10%">填报状态：</td>
					<td class="FieldInput" style="width:12%"><select id="status" field="status"><option dataset="statusDataSet"/></select></td>
					<td class="FieldLabel" style="width:10%" id = "xzqh1">行政区划：</td>
					<td class="FieldInput" style="width:20%" id = "xzqh2"> <input type="text" id="domicileName" onclick="func_ForDomicileSelect()" style="width: 99%" readonly="readonly"/>
						<input type="hidden" id="domicileCode"/><input type="hidden" id="leve"/></td>
					<td class="FieldInput" style="width:37%"><button onclick="query()">查询</button>&nbsp;&nbsp;&nbsp;&nbsp;<button type="reset">重置</button></td>
				</tr>
			</table>
		</form>
	</fieldset>
	</next:Html>
</next:Panel>
<next:EditGridPanel title="民主选举填报情况" id="grid" dataset="electionInfoDataSet" width="100%" stripeRows="true" height="99.9%">
	<next:TopBar>
		<next:ToolBarItem symbol="->"/>
		<next:ToolBarItem id="sum" iconCls="add" text="汇总本级数据" hidden="true" handler="sum" />
		<next:ToolBarItem id="detail1" iconCls="add" text="填报" handler="insert"/>
		<next:ToolBarItem id="detail2" iconCls="edit" text="修改选举基本信息" handler="updateInfo"/>
		<next:ToolBarItem id="detail3" iconCls="edit" text="填写选举详细信息" handler="update"/>
		<next:ToolBarItem id="detail4" iconCls="detail" text="明细" handler="detail"/>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn/>
		<next:RadioBoxColumn/>
		<next:Column field="organName" header="单位名称" width="10%" sortable="false"/>
		<next:Column field="ifElection" header="是否换届选举" width="12%" sortable="true" dataset="YorN" align="right" />
		<next:Column field="ifComplete" header="是否完成选举" width="12%" sortable="true" dataset="YorN" align="right" />
		<next:Column field="completeResult" header="选举完成情况" width="12%" sortable="true" align="right" dataset="completeResultDataSet" />
		<next:Column field="reportDate" header="填报日期" width="15%" editable="true" sortable="true" align="center"dataset="reportWorkDataSet"/>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="electionInfoDataSet"/>
	</next:BottomBar>
</next:EditGridPanel>
</body>
</html>