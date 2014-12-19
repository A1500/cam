<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>农村民主监督情况填报</title>
<next:ScriptManager/>
</head>
<body>
<model:datasets>
	<model:dataset id="superviseDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcSuperviseReportQueryCmd" pageSize="20">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcSuperviseReport"/>
	</model:dataset>
	<model:dataset id="superviseInfoDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcSuperviseInfoQueryCmd" pageSize="20">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcSuperviseInfo"/>
	</model:dataset>
	<model:dataset id="reviewDs" cmd="com.inspur.cams.cdc.base.cmd.CdcSuperviseReviewInfoQueryCmd" pageSize="200">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcSuperviseReviewInfo"/>
	</model:dataset>
	<model:dataset id="reportWorkDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcReportWorkQueryCmd" method="getDic" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"/>
		<model:params>
			<model:param name="reportType" value='R15'/>
			<model:param name="organType" value='N'/>
		</model:params>
	</model:dataset>
	<model:dataset id="YorN" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="TimeDataset" enumName="CDC.PUBLISH_CYC" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="typeDataset" enumName="CDC.REVIEW_TYPE" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="resultDataset" enumName="CDC.REVIEW_RESULT" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="mannerDataset" enumName="CDC.MANNER" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:Panel width="100%" autoScroll="true">
<next:TopBar>
	<next:ToolBarItem symbol="->"/>
	<next:ToolBarItem iconCls="return" text="返回" handler="returnBack"/>
</next:TopBar>
<next:Html>
<form id="form1" method="post" dataset="superviseDataSet" onsubmit="return false" class="L5form">
<fieldset id="cdcFieldset">
<legend>填报情况</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel">填报单位：</td>
			<td class="FieldInput" colspan="3"><label field="organName"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">填报日期：</td>
			<td class="FieldInput" style="width:36%"><label field="reportDate" dataset="reportWorkDataSet"/></td>
			<td class="FieldLabel" style="width:16%">上报日期：</td>
			<td class="FieldInput" style="width:30%"><label field="submitDate"/></td>
		</tr>
	</table>
</fieldset>
</form>
<form id="form2" method="post" dataset="superviseInfoDataSet" onsubmit="return false" class="L5form">
<fieldset id="cdcFieldset">
<legend>民主监督情况</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:10%">村务公开程序</td>
			<td class="FieldLabel" style="width:15%">是否经村委会提出公开方案：</td>
			<td class="FieldInput" style="width:15%"><label field ="ifPublish" dataset="YorN"/></td>
			<td class="FieldLabel" style="width:15%">是否经村务监督委员会<br>审查、补充、完善：</td>
			<td class="FieldInput" style="width:15%"><label field ="ifAudit" dataset="YorN"/></td>
			<td class="FieldLabel" style="width:15%">是否经村党组织和村委会<br>联席会议讨论确定：</td>
			<td class="FieldInput" style="width:15%"><label field ="ifDiscuss" dataset="YorN"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" rowspan="2">公开内容</td>
			<td class="FieldLabel">党务公开：</td>
			<td class="FieldInput"><label field ="partCyc" dataset="TimeDataset"/></td>
			<td class="FieldLabel">政务公开：</td>
			<td class="FieldInput"><label field ="govCyc" dataset="TimeDataset"/></td>
			<td class="FieldLabel"></td>
			<td class="FieldInput"></td>
		</tr>
		<tr>
			<td class="FieldLabel">事务公开：</td>
			<td class="FieldInput"><label field ="affairCyc" dataset="TimeDataset"/></td>
			<td class="FieldLabel">财务公开：</td>
			<td class="FieldInput"><label field ="financeCyc" dataset="TimeDataset"/></td>
			<td class="FieldLabel"></td>
			<td class="FieldInput"></td>
		</tr>
		<tr>
			<td class="FieldLabel" rowspan="2">公开形式</td>
			<td class="FieldLabel">公开栏：</td>
			<td class="FieldInput"><label field ="formPlacard" dataset="YorN"/></td>
			<td class="FieldLabel">网络：</td>
			<td class="FieldInput"><label field ="formWeb" dataset="YorN"/></td>
			<td class="FieldLabel">民主听证会：</td>
			<td class="FieldInput"><label field ="formMeeting" dataset="YorN"/></td>
		</tr>
		<tr>
			<td class="FieldLabel">明白纸：</td>
			<td class="FieldInput"><label field ="formPaper" dataset="YorN"/></td>
			<td class="FieldLabel">其他：</td>
			<td class="FieldInput"><label field ="formOther" dataset="YorN"/></td>
			<td class="FieldLabel"></td>
			<td class="FieldInput"></td>
		</tr>
	</table>
</fieldset>
</form>
</next:Html>
</next:Panel>
<next:EditGridPanel id="grid" dataset="reviewDs" width="100%" stripeRows="true" height="99.9%">
	<next:Columns>
		<next:RowNumberColumn></next:RowNumberColumn>
		<next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column field="name" header="被评议人员姓名" width="200" sortable="false"/>
		<next:Column field="peopleType" header="类型" dataset ="typeDataset" width="100" sortable="false"/>
		<next:Column field="reviewDate" header="民主评议时间" width="90" sortable="false"/>
		<next:Column field="manner" header="评议方式" width="90" sortable="false" dataset="mannerDataset"/>
		<next:Column field="meetingShouldNum" header="应到人数" width="90" sortable="false"/>
		<next:Column field="meetingRealNum" header="实到人数" width="90" sortable="false"/>
		<next:Column field="excellentNum" header="优秀票数" width="90" sortable="false"/>
		<next:Column field="competentNum" header="称职票数" width="90" sortable="false"/>
		<next:Column field="uncompetentNum" header="不称职票数" width="90" sortable="false"/>
		<next:Column field="result" header="评议结果" dataset ="resultDataset" width="100" sortable="false"/>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="reviewDs"/>
	</next:BottomBar>
</next:EditGridPanel>
</body>
</html>
<script language="javascript">
function init(){
	var superviseDataSet=L5.DatasetMgr.lookup("superviseDataSet");
	var superviseInfoDataSet=L5.DatasetMgr.lookup("superviseInfoDataSet");
	var reviewDs=L5.DatasetMgr.lookup("reviewDs");
	superviseDataSet.setParameter("RECORD_ID@=",'<%=request.getParameter("recordId")%>');
	superviseInfoDataSet.setParameter("RECORD_ID@=",'<%=request.getParameter("recordId")%>');
	reviewDs.setParameter("RECORD_ID@=",'<%=request.getParameter("recordId")%>');
	superviseDataSet.load();
	superviseInfoDataSet.load();
	reviewDs.load();
}
function returnBack(){
	history.go(-1);
}
</script>