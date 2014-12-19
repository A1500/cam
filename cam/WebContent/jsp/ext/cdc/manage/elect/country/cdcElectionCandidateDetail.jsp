<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>农村民主选举正式候选人信息</title>
<next:ScriptManager/>
<script type="text/javascript">
	var recordId='<%=request.getParameter("recordId")%>';
</script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<jsp:include page="../../util/cdcOrgan.jsp" flush="true"/>
</head>
<body>
<model:datasets>
	<model:dataset id="electionCandidateDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcElectionCandidateQueryCmd" pageSize="20">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcElectionCandidate"/>
	</model:dataset>
	<model:dataset id="reportWorkDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcReportWorkQueryCmd" method="getDic" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"/>
		<model:params>
			<model:param name="reportType" value='R11'/>
			<model:param name="organType" value='N'/>
		</model:params>
	</model:dataset>
	<model:dataset id="YorN" enumName="COMM.YESORNO" autoLoad="true" global="true" />
	<model:dataset id="statusDataSet" enumName="CDC.STATUS" autoLoad="true" global="true"/>
</model:datasets>
<next:Panel width="99%" autoScroll="true">
<next:TopBar>
	<next:ToolBarItem symbol="->"/>
</next:TopBar>
<next:Html>
<form id="form1" method="post" dataset="electionCandidateDataSet" onsubmit="return false" class="L5form">
<fieldset id="cdcFieldset">
<legend>填报情况</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:18%">填报单位：</td>
			<td class="FieldInput" style="width:27%"><label field="organName"/></td>
			<td class="FieldLabel" style="width:13%">填报日期：</td>
			<td class="FieldInput" style="width:42%"><label field="reportDate"  dataset="reportWorkDataSet" /></td>
		</tr>
	</table>
</fieldset>
<fieldset id="cdcFieldset">
<legend>正式候选人信息</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:13%">应选名额：</td>
			<td class="FieldInput" style="width:14%"><label field="shouldNum"  style="width:80%"/></td>
			<td class="FieldLabel" style="width:13%">正式候选人人数：</td>
			<td class="FieldInput" style="width:14%"><label field="candidateNum"  style="width:80%"/></td>
			<td class="FieldLabel" style="width:13%">组织竞职演讲人数</td>
			<td class="FieldInput" style="width:15%"><label field="lectureNum"  style="width:80%" /></td>
		</tr>
		<tr>
			<td class="FieldLabel">正式候选人女性人数</td>
			<td class="FieldInput"><label field="femaleNum"  style="width:80%"/></td>
			<td class="FieldLabel">正式候选人党员人数：</td>
			<td class="FieldInput"><label field="partyNum"  style="width:80%"/></td>
			<td class="FieldLabel">正式候选人少数民族人数：</td>
			<td class="FieldInput"><label field="folkNum"  style="width:80%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel">村民预选产生人数：</td>
			<td class="FieldInput"><label field="preelectionNum"  style="width:80%"/></td>
			<td class="FieldLabel">提名预选产生人数：</td>
			<td class="FieldInput"><label field="nominateNum"  style="width:80%"/></td>
			<td class="FieldLabel">直接提名产生人数</td>
			<td class="FieldInput"><label field="directNum"  style="width:80%"/></td>
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
	var electionCandidateDataSet=L5.DatasetMgr.lookup("electionCandidateDataSet");
	var reportWorkDataSet=L5.DatasetMgr.lookup("reportWorkDataSet");
	reportWorkDataSet.load();
	electionCandidateDataSet.setParameter("RECORD_ID@=",'<%=request.getParameter("recordId")%>');
	electionCandidateDataSet.on("load",function(){
		var nominate = electionCandidateDataSet.getCurrent();
		if(nominate==null){
			electionCandidateDataSet.newRecord({"organCode":organCode,"organName":organName,"parentCode":parentCode,
			"reportType":"N","recordId":recordId});
		}
	});
	electionCandidateDataSet.load();
	reportWorkDataSet.load();
}
function returnBack(){
	history.go(-1);
}
</script>