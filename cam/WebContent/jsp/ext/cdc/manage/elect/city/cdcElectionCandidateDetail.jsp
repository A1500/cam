<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>城市民主选举正式候选人信息</title>
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
			<model:param name="organType" value='C'/>
		</model:params>
	</model:dataset>
	<model:dataset id="YorN" enumName="COMM.YESORNO" autoLoad="true" global="true" />
	<model:dataset id="electionMannerDs" enumName="CDC.ELECTION_MANNER_CITY" autoLoad="true" global="true" />
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
<fieldset id="cdcFieldset">
<legend>候选人确定方式</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:13%">应选名额：</td>
			<td class="FieldInput" style="width:14%"><label id="shouldNum" field="shouldNum" maxlength="30" style="width:80%"/></td>
			<td class="FieldLabel" style="width:13%">确定方式：</td>
			<td class="FieldInput" style="width:14%"><label id="confirm" field="confirm"  style="width:80%" dataset = "electionMannerDs"/></td>
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
			<td class="FieldLabel" style="width:13%">是否组织竞职演讲：</td>
			<td class="FieldInput" style="width:14%" colspan="3" ><label id="ifLecture" field="ifLecture" dataset = "YorN"/></td>
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
			"reportType":"C","recordId":recordId});
		}
	});
	electionCandidateDataSet.load();
	reportWorkDataSet.load();
}
function returnBack(){
	history.go(-1);
}
</script>