<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<script type="text/javascript">
</script>
<title>农村民主选举正式候选人信息</title>
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
</model:datasets>
<next:Panel width="99%" autoScroll="true">
<next:Html>
<form id="form1" method="post" dataset="electionCandidateDataSet" onsubmit="return false" class="L5form">
<fieldset id="cdcFieldset">
<legend>正式候选人信息</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:13%" rowspan="5" align="center">人员基本情况</td>
			<td class="FieldLabel" style="width:13%">应选名额：</td>
			<td class="FieldInput" style="width:14%"><label id="shouldNum" field="shouldNum" maxlength="30" style="width:80%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:13%">正式候选人人数：</td>
			<td class="FieldInput" style="width:14%"><label id="candidateNum" field="candidateNum" maxlength="30" style="width:80%"/></td>
		</tr>
		<tr>	
			<td class="FieldLabel">正式候选人女性人数</td>
			<td class="FieldInput"><label id="femaleNum" field="femaleNum" maxlength="30" style="width:80%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel">正式候选人党员人数：</td>
			<td class="FieldInput"><label id="partyNum" field="partyNum" maxlength="30" style="width:80%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel">正式候选人少数民族人数：</td>
			<td class="FieldInput"><label id="folkNum" field="folkNum" maxlength="30" style="width:80%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:13%" rowspan="3" align="center">候选人确定方式</td>
			<td class="FieldLabel">村民预选产生人数：</td>
			<td class="FieldInput"><label id="preelectionNum" field="preelectionNum" maxlength="30" style="width:80%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel">提名预选产生人数：</td>
			<td class="FieldInput"><label id="nominateNum" field="nominateNum" maxlength="30" style="width:80%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel">直接提名产生人数：</td>
			<td class="FieldInput"><label id="directNum" field="directNum" maxlength="30" style="width:80%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:13%" colspan="2" align="center">组织竞职演讲人数：</td>
			<td class="FieldInput" style="width:15%"><label id="lectureNum" field="lectureNum" maxlength="30" style="width:80%"/></td>
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
	electionCandidateDataSet.setParameter("REPORT_TYPE","N");
	electionCandidateDataSet.load();
}
</script>