<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>农村民主决策汇总</title>
<next:ScriptManager/>
<script type="text/javascript" src="vcdcDecisionInfoSum.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript">
	var method='<%=request.getParameter("method")%>';
	var recordId='<%=request.getParameter("recordId")%>';
</script>
<jsp:include page="../util/cdcOrgan.jsp" flush="true"/>
<jsp:include page="../util/cdcSum.jsp" flush="true"/>
</head>
<body>
<model:datasets>
	<model:dataset id="sumDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcDecisionReportQueryCmd" pageSize="10">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcDecisionReport"/>
	</model:dataset>
	<model:dataset id="detailDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcDecisionReportQueryCmd" pageSize="200">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcDecisionReport">
			<model:field name="meetingRealPer" type="string"/>
			<model:field name="meetingAgreePer" type="string"/>
			<model:field name="meetingUnagreePer" type="string"/>
			<model:field name="meetingGiveupPer" type="string"/>
			<model:field name="sovietRealPer" type="string"/>
			<model:field name="sovietAgreePer" type="string"/>
			<model:field name="sovietUnagreePer" type="string"/>
			<model:field name="sovietGiveupPer" type="string"/>
			<model:field name="sovietFemalePer" type="string"/>
			<model:field name="refRealPer" type="string"/>
			<model:field name="refAgreePer" type="string"/>
			<model:field name="refUnagreePer" type="string"/>
			<model:field name="refGiveupPer" type="string"/>
		</model:record>
		<model:params>
			<model:param name="REPORT_TYPE" value='N'/>
		</model:params>
	</model:dataset>
	<model:dataset id="infoDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcDecisionInfoQueryCmd" >
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcDecisionInfo"/>
	</model:dataset>
	<model:dataset id="meetingTypeDs" enumName="CDC.MEETING.TYPE" autoLoad="true" global="true"/>
	<model:dataset id="cityDataSet" cmd="com.inspur.cams.comm.extuser.cmd.ComExtUserQueryCmd" method="getNongCunUser" pageSize="200">
		<model:record fromBean="com.inspur.cams.comm.extuser.data.ComExtUser"/>
	</model:dataset>
	<model:dataset id="reportWorkDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcReportWorkQueryCmd" method="getDic" global="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"/>
		<model:params>
			<model:param name="reportType" value='R13'/>
			<model:param name="organType" value='N'/>
		</model:params>
	</model:dataset>
	<model:dataset id="statusDataSet" enumName="CDC.STATUS" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:Panel width="100%" border="0">
<next:TopBar>
	<next:ToolBarItem symbol="->"></next:ToolBarItem>
	<next:ToolBarItem id="sumButton" iconCls="save" text="汇总" handler="save"></next:ToolBarItem>
	<next:ToolBarItem iconCls="return" text="返回" handler="returnBack"></next:ToolBarItem>
</next:TopBar>
<next:Html>
	<fieldset style="overflow:visible;" class="GroupBox">
	<legend class="GroupBoxTitle">汇总情况</legend>
		<form id="form1" method="post" dataset="sumDataSet" onsubmit="return false" class="L5form">
			<table width="100%">
				<tr>
					<td class="FieldLabel" style="width:18%">填报单位：</td>
					<td class="FieldInput" style="width:36%"><label field="organName"/></td>
					<td class="FieldLabel" style="width:16%">填报日期：</td>
					<td class="FieldInput" style="width:30%"><select id="reportDate" field="reportDate" onchange="getData()"><option dataset="reportWorkDataSet"/></select><font color="red">*</font></td>
				</tr>
			</table>
		</form>
	</fieldset>
</next:Html>
</next:Panel>
<next:EditGridPanel id="grid" dataset="detailDataSet" width="100%" stripeRows="true" height="99.9%" hasSum="true">
	<next:TopBar>
		<next:ToolBarItem iconCls="return" text="返回上级" handler="getUp"/>
		<next:ToolBarItem symbol="->"/>
		<next:ToolBarItem iconCls="detail" text="明细" handler="detail"/>
		<next:ToolBarItem id="auditButton" iconCls="delete" text="驳回" handler="audit"/>
	</next:TopBar>
	<next:Columns>
		<next:RadioBoxColumn/>
		<next:Column field="organName" header="单位名称" width="15%" sortable="false" renderer="statusRender"/>
		<next:Column field="meetingNum" header="村民会议次数" width="10%" sortable="false" align="right"/>
		<next:Column field="sovietNum" header="村民代表会议次数" width="15%" sortable="false" align="right"/>
		<next:Column field="refNum" header="村务公决次数" width="15%" sortable="false" align="right"/>
		<next:Column field="reportDate" header="填报日期" width="10%" editable="false" sortable="false" align="center"><next:ComboBox dataset="reportWorkDataSet"/></next:Column>
		<next:Column field="status" header="填报状态" width="10%" sortable="false" editable="false" align="center"><next:ComboBox dataset="statusDataSet"/></next:Column>
		<next:Column field="submitDate" header="上报日期" width="10%" sortable="false" align="center"/>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="detailDataSet"/>
	</next:BottomBar>
</next:EditGridPanel>

<next:Window id="detailWin" title="明细" resizable="false" width="800" height="400" modal="true" closeAction="hide" autoScroll="true">
	<next:Panel>
		<next:Html>
			<form id="form1" method="post" dataset="detailDataSet" onsubmit="return false" class="L5form">
			<fieldset id="cdcFieldset">
			<legend>填报情况</legend>
				<table width="100%">
					<tr>
						<td class="FieldLabel">填报单位：</td>
						<td class="FieldInput" colspan="3"><label field="organName"/></td>
					</tr>
					<tr>
						<td class="FieldLabel" style="width:18%">填报日期：</td>
						<td class="FieldInput" style="width:35%"><label field="reportDate" dataset="reportWorkDataSet"/></td>
						<td class="FieldLabel" style="width:15%">上报日期：</td>
						<td class="FieldInput" style="width:30%"><label field="submitDate"/></td>
					</tr>
				</table>
			</fieldset>
			<fieldset id="cdcFieldset">
			<legend>民主决策情况</legend>
			<table width="100%">
				<tr>
					<td class="FieldLabel" style="width: 12%">村民会议次数：</td>
					<td class="FieldInput" style="width: 16%"><label
						id="meetingNum" field="meetingNum" renderer="cRender" /></td>
				</tr>
				<tr>
					<td class="FieldLabel" style="width: 12%">村民代表会议次数：</td>
					<td class="FieldInput" style="width: 16%"><label
						id="meetingNum" field="sovietNum" renderer="cRender" /></td>
				</tr>
				<tr>
					<td class="FieldLabel" style="width: 12%">村民公决次数：</td>
					<td class="FieldInput" style="width: 16%"><label
						id="meetingNum" field="refNum" renderer="cRender" /></td>
				</tr>
			</table>
			</fieldset>
			</form>
		</next:Html>
	</next:Panel>
	<next:GridPanel id="infogrid" dataset="infoDataSet" width="800" stripeRows="true" height="300" autoScroll="true" hasSum="true">
	<next:Columns>
		<next:RowNumberColumn />
		<next:Column field="meetingType" header="类型" dataset= "meetingTypeDs" width="90" sortable="false" align="right"/>
		<next:Column field="meetingContent" header="主题内容" width="90" sortable="false" align="right"/>
		<next:Column field="shouldNum" header="应到人数" width="75" editable="false" sortable="false" align="center"></next:Column>
		<next:Column field="realNum" header="实到人数" width="75" sortable="false"  align="center"></next:Column>
		<next:Column field="femaleNum" header="妇女人数" width="75" sortable="false" align="center"/>
		<next:Column field="agreeNum" header="同意人数" width="75" sortable="false" align="right"/>
		<next:Column field="unagreeNum" header="不同意人数" width="75" sortable="false" align="right"/>
		<next:Column field="giveupNum" header="弃权人数" width="75" sortable="false" align="right"/>
		<next:Column field="meetingDate" header="会议时间" width="75" sortable="false" align="right"/>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="infoDataSet"/>
	</next:BottomBar>
</next:GridPanel>
</next:Window>
<next:Window id="rejectWin" title="驳回原因" resizable="false" width="400" height="200" modal="true" closeAction="hide" autoScroll="true">
<next:Html>
<form id="form1" method="post" dataset="detailDataSet" onsubmit="return false" class="L5form">
	<fieldset>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:30%">驳回原因：</td>
			<td class="FieldInput" style="width:70%" ><textArea style="height:110;width:100%" id="reason"></textArea></td>
		</tr>
	</table>
	</fieldset>
</form>
</next:Html>
<next:Buttons>
		<next:ToolButton text="确定" handler="confirmReject"></next:ToolButton>
		<next:ToolButton text="取消" handler="closeWin"></next:ToolButton>
</next:Buttons>
</next:Window>
</body>
</html>