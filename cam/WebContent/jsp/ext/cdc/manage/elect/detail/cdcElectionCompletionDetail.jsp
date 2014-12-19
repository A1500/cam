<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<script type="text/javascript">
</script>
<title>城市民主选举完成情况</title>
<next:ScriptManager/>
<script type="text/javascript">
	var reportDate='<%=request.getParameter("reportDate")%>';
	var organC='<%=request.getParameter("organC")%>';
</script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<jsp:include page="../../util/cdcOrgan.jsp" flush="true"/>
</head>
<body>
<model:datasets>
	<model:dataset id="electionInfoDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcElectionInfoQueryCmd" method="queryCompletionSum" pageSize="20">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcElectionInfo"/>
	</model:dataset>
	<model:dataset id="reportWorkDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcReportWorkQueryCmd" method="getDic" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"/>
		<model:params>
			<model:param name="reportType" value='R11'/>
			<model:param name="organType" value='C'/>
		</model:params>
	</model:dataset>
	<model:dataset id="YorN" enumName="COMM.YESORNO" autoLoad="true" global="true" />
	<model:dataset id="completeResultDataSet" enumName="CDC.ELECTION.COMPLETERESULT" autoLoad="true" global="true" />
	<model:dataset id="statusDataSet" enumName="CDC.STATUS" autoLoad="true" global="true"/>
</model:datasets>
<next:Panel width="99%" autoScroll="true">
<next:Html>
<form id="form1" method="post" dataset="electionInfoDataSet" onsubmit="return false" class="L5form">
<fieldset id="cdcFieldset">
<legend>选举完成情况</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:13%" colspan="2">换届选举居数：</td>
			<td class="FieldInput" style="width:14%"><label field ="IFELECTION" /></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:13%" rowspan="3">已完成选举居情况：</td>
			<td class="FieldLabel" style="width:13%">另行选举居数：</td>
			<td class="FieldInput" style="width:14%"><label field="ANOTHER"  /></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:13%">重新选举居数：</td>
			<td class="FieldInput" style="width:15%"><label field="AFRESH"  /></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:13%">一次性选举居数：</td>
			<td class="FieldInput" style="width:15%"><label field="ONCE"  /></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:13%" rowspan="2">选举整体情况：</td>
			<td class="FieldLabel" style="width:13%">已完成选举居数：</td>
			<td class="FieldInput" style="width:14%"><label field="COMPLETED"  /></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:13%">未完成选举居数：</td>
			<td class="FieldInput" style="width:15%"><label field="UNCOMPLETED"  /></td>
		</tr>
	</table>
</fieldset>
</form>
</next:Html>
</next:Panel>
</body>
</html>
<script language="javascript">
function init(){
 	var electionInfoDataSet=L5.DatasetMgr.lookup("electionInfoDataSet");
	electionInfoDataSet.setParameter("reportDate",reportDate);
	electionInfoDataSet.setParameter("ORGAN_CODE",organC);
	electionInfoDataSet.setParameter("REPORT_TYPE","C");
	electionInfoDataSet.load();
}
</script>