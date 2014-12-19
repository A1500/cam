<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>城市民主决策列表</title>
<next:ScriptManager/>
<script type="text/javascript" src="cdcDecisionInfoList.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<jsp:include page="../util/cdcOrgan.jsp" flush="true"/>
<jsp:include page="../util/cdcReportNotice.jsp" flush="true"/>
</head>
<body>
<model:datasets>
	<model:dataset id="decisionDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcDecisionReportQueryCmd" >
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcDecisionReport">
		</model:record>
	</model:dataset>
	<model:dataset id="reportWorkDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcReportWorkQueryCmd" method="getDic" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"/>
		<model:params>
			<model:param name="reportType" value='R13'/>
			<model:param name="organType" value='C'/>
		</model:params>
	</model:dataset>
	<model:dataset id="insertDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcReportWorkQueryCmd" method="getDic" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"/>
		<model:params>
			<model:param name="reportType" value='R13'/>
			<model:param name="organType" value='C'/>
		</model:params>
	</model:dataset>
	<model:dataset id="OrgCodeDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="false">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='COM_EXT_USER'></model:param>
			<model:param name="value" value='USER_ID'></model:param>
			<model:param name="text" value='AREA_CODE'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="statusDataSet" enumName="CDC.STATUS" autoLoad="true" global="true"/>
</model:datasets>
<next:Panel width="100%" border="0">
	<next:Html>
	<fieldset style="overflow:visible;" class="GroupBox">
	<legend class="GroupBoxTitle">查询条件</legend>
		<form class="L5form">
			<table border="1" width="100%">
				<tr>
					<td class="FieldLabel" style="width:10%">填报日期：</td>
					<td class="FieldInput" style="width:12%"><select id="reportDate"><option dataset="reportWorkDataSet"/></select></td>
					<td class="FieldLabel" style="width:10%">填报状态：</td>
					<td class="FieldInput" style="width:12%"><select id="status" field="status"><option dataset="statusDataSet"/></select></td>
					<td class="FieldInput" style="width:37%"><button onclick="query()">查询</button>&nbsp;&nbsp;&nbsp;&nbsp;<button type="reset">重置</button></td>
				</tr>
			</table>
		</form>
	</fieldset>
	</next:Html>
</next:Panel>
<next:EditGridPanel id="grid" dataset="decisionDataSet" width="100%" stripeRows="true" height="99.9%">
	<next:TopBar>
		<next:ToolBarItem symbol="->"/>
		<next:ToolBarItem id="sum1" iconCls="add" text="汇总" handler="sumInsert"/>
		<next:ToolBarItem id="sum2" iconCls="undo" text="重新汇总" handler="sumRedo"/>
		<next:ToolBarItem id="sum3" iconCls="detail" text="明细" handler="sumDetail"/>
		<next:ToolBarItem id="detail1" iconCls="add" text="填报" handler="insert"/>
		<next:ToolBarItem id="detail2" iconCls="edit" text="修改" handler="update"/>
		<next:ToolBarItem id="detail3" iconCls="detail" text="明细" handler="detail"/>
		<next:ToolBarItem iconCls="upload" text="上报" handler="report"/>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn/>
		<next:RadioBoxColumn/>
		<next:Column field="organName" header="单位名称" width="15%" sortable="false" renderer="statusListRender"/>
		<next:Column field="meetingShouldNum" header="居民会议次数" width="10%" sortable="false" align="right"/>
		<next:Column field="meetingRealNum" header="居民会议参加人数" width="13%" sortable="false" align="right"/>
		<next:Column field="meetingAgreeNum" header="居民代表会议次数" width="15%" sortable="false" align="right"/>
		<next:Column field="meetingUnagreeNum" header="居民代表会议参加人数" width="15%" sortable="false" align="right"/>
		<next:Column field="reportDate" header="填报日期" width="10%" editable="true" sortable="true" align="center"><next:ComboBox dataset="reportWorkDataSet"/></next:Column>
		<next:Column field="status" header="填报状态" width="10%" editable="true" sortable="false" align="center"><next:ComboBox dataset="statusDataSet"/></next:Column>
		<next:Column field="submitDate" header="上报日期" width="10%" sortable="true" align="center"/>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="decisionDataSet"/>
	</next:BottomBar>
</next:EditGridPanel>
</body>
</html>