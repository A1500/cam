<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<script type="text/javascript">
</script>
<title>城市民主选举正式候选人信息</title>
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
	<model:dataset id="electionCandidateDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcElectionCandidateQueryCmd" method="querySum" pageSize="20">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcElectionCandidate"/>
	</model:dataset>
	<model:dataset id="reportWorkDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcReportWorkQueryCmd" method="getDic" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"/>
		<model:params>
			<model:param name="reportType" value='R11'/>
			<model:param name="organType" value='C'/>
		</model:params>
	</model:dataset>
	<model:dataset id="YorN" enumName="COMM.YESORNO" autoLoad="true" global="true" />
	<model:dataset id="statusDataSet" enumName="CDC.STATUS" autoLoad="true" global="true"/>
</model:datasets>
<next:Panel width="99%" autoScroll="true">
<next:Html>
<form id="form1" method="post" dataset="electionCandidateDataSet" onsubmit="return false" class="L5form">
<fieldset id="cdcFieldset">
<legend>候选人确定方式</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:13%" colspan="2">应选名额：</td>
			<td class="FieldInput" style="width:14%" ><label id="shouldNum" field="shouldNum" maxlength="30" style="width:80%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:13%" rowspan="3">确定方式(居数)：</td>
			<td class="FieldLabel" style="width:13%" >全体居民推选：</td>
			<td class="FieldInput" style="width:20%"><label id="directNum"  field="directNum"  style="width:80%" /></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:13%" >户代表推选：</td>
			<td class="FieldInput" style="width:20%"><label id="confirm" field="confirm"  style="width:80%" /></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:13%" >居民小组代表推选：</td>
			<td class="FieldInput" style="width:20%"><label id="preelectionNum" field="preelectionNum"  style="width:80%" /></td>
			
		</tr>
	</table>
</fieldset>
<fieldset id="cdcFieldset">
<legend>候选人人员基本情况</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:13%">总人数：</td>
			<td class="FieldInput" style="width:14%"><label id="candidateNum" field="candidateNum" maxlength="30" style="width:80%"/></td>
			<td class="FieldLabel" style="width:13%">女性人数：</td>
			<td class="FieldInput" style="width:14%"><label id="femaleNum" field="femaleNum" maxlength="30" style="width:80%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:13%">党员人数：</td>
			<td class="FieldInput" style="width:14%"><label id="partyNum" field="partyNum" maxlength="30" style="width:80%"/></td>
			<td class="FieldLabel" style="width:13%">少数民族人数：</td>
			<td class="FieldInput" style="width:14%"><label id="folkNum" field="folkNum" maxlength="30" style="width:80%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:13%">组织竞职演讲居数：</td>
			<td class="FieldInput" style="width:14%" colspan="3" ><label id="ifLecture" field="ifLecture"/></td>
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
	electionCandidateDataSet.setParameter("reportDate",reportDate);
	electionCandidateDataSet.setParameter("ORGAN_CODE",organC);
	electionCandidateDataSet.setParameter("REPORT_TYPE","C");
	electionCandidateDataSet.load();
}
</script>