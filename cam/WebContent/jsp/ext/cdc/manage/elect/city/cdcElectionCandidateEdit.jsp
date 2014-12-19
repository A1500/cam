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
	var reportTime='<%=request.getParameter("reportTime")%>';
	var recordId='<%=request.getParameter("recordId")%>';
</script>
<script type="text/javascript" src="cdcElectionCandidateEdit.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<jsp:include page="../../util/cdcOrgan.jsp" flush="true"/>
</head>
<body>
<model:datasets>
	<model:dataset id="electionCandidateDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcElectionCandidateQueryCmd" pageSize="20">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcElectionCandidate"/>
	</model:dataset>
	<model:dataset id="electionCandidate2DataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcElectionCandidateQueryCmd" pageSize="20">
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
	<model:dataset id="electionMannerDs" enumName="CDC.ELECTION_MANNER_CITY" autoLoad="true" global="true" />
</model:datasets>
<next:Panel width="99%" autoScroll="true">
<next:TopBar>
	<next:ToolBarItem symbol="->"/>
	<next:ToolBarItem iconCls="add" text="历史数据回填" id="backInsert" handler="forInsert"/>
	<next:ToolBarItem iconCls="save" text="保存" handler="save"/>
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
			<td class="FieldInput" style="width:42%"><label id="reportDate" field="reportDate" dataset="reportWorkDataSet"/></td>
		</tr>
	</table>
</fieldset>
<fieldset id="cdcFieldset">
<legend>候选人确定方式</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:13%">应选名额：</td>
			<td class="FieldInput" style="width:14%"><input type="text" name = "应选名额" onchange="forcheck(this)"  id="shouldNum" field="shouldNum" maxlength="30" style="width:80%"/></td>
			<td class="FieldLabel" style="width:13%">确定方式：</td>
			<td class="FieldInput" style="width:14%"><select id="confirm" field="confirm"  style="width:80%"><option dataset = "electionMannerDs"></option> </select></td>
		</tr>
	</table>
</fieldset>
<fieldset id="cdcFieldset">
<legend>候选人人员基本情况</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:13%">总人数：</td>
			<td class="FieldInput" style="width:14%"><input type="text" name = "总人数" onchange="forcheck(this)" id="candidateNum" field="candidateNum" maxlength="30" style="width:80%"/></td>
			<td class="FieldLabel" style="width:13%">女性人数：</td>
			<td class="FieldInput" style="width:14%"><input type="text" name = "女性人数" onchange="forcheck(this)" id="femaleNum" field="femaleNum" maxlength="30" style="width:80%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:13%">党员人数：</td>
			<td class="FieldInput" style="width:14%"><input type="text" name = "党员人数" onchange="forcheck(this)" id="partyNum" field="partyNum" maxlength="30" style="width:80%"/></td>
			<td class="FieldLabel" style="width:13%">少数民族人数：</td>
			<td class="FieldInput" style="width:14%"><input type="text" name = "少数民族人数" onchange="forcheck(this)" id="folkNum" field="folkNum" maxlength="30" style="width:80%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:13%">是否组织竞职演讲：</td>
			<td class="FieldInput" style="width:14%" colspan="3" ><select id="ifLecture" field="ifLecture" style="width:27%" ><option dataset = "YorN"></option>  </select></td>
		</tr>
	</table>
</fieldset>
</form>
</next:Html>
</next:Panel>
</body>
</html>