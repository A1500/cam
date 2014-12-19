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
	<model:dataset id="electionCandidateDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcElectionCandidateQueryCmd" pageSize="1">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcElectionCandidate"/>
	</model:dataset>
	<model:dataset id="electionCandidate2DataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcElectionCandidateQueryCmd" pageSize="1">
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
<legend>正式候选人信息</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:13%">应选名额：</td>
			<td class="FieldInput" style="width:14%"><input type="text" name = "应选名额"  id="shouldNum" field="shouldNum" maxlength="30" style="width:80%"/></td>
			<td class="FieldLabel" style="width:13%">正式候选人人数：</td>
			<td class="FieldInput" style="width:14%"><input type="text" name = "正式候选人人数"  id="candidateNum" field="candidateNum" maxlength="30" style="width:80%"/></td>
			<td class="FieldLabel" style="width:13%">组织竞职演讲人数：</td>
			<td class="FieldInput" style="width:15%"><input type="text" name = "组织竞职演讲人数"  id="lectureNum" field="lectureNum" maxlength="30" style="width:80%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel">正式候选人女性人数：</td>
			<td class="FieldInput"><input type="text" name = "正式候选人女性人数"  id="femaleNum" field="femaleNum" maxlength="30" style="width:80%"/></td>
			<td class="FieldLabel">正式候选人党员人数：</td>
			<td class="FieldInput"><input type="text" name = "正式候选人党员人数"  id="partyNum" field="partyNum" maxlength="30" style="width:80%"/></td>
			<td class="FieldLabel">正式候选人少数民族人数：</td>
			<td class="FieldInput"><input type="text" name = "正式候选人少数民族人数"  id="folkNum" field="folkNum" maxlength="30" style="width:80%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel">村民预选产生人数：</td>
			<td class="FieldInput"><input type="text" name = "村民预选产生人数"  id="preelectionNum" field="preelectionNum" maxlength="30" style="width:80%"/></td>
			<td class="FieldLabel">提名预选产生人数：</td>
			<td class="FieldInput"><input type="text" name = "提名预选产生人数"  id="nominateNum" field="nominateNum" maxlength="30" style="width:80%"/></td>
			<td class="FieldLabel">直接提名产生人数</td>
			<td class="FieldInput"><input type="text" name = "直接提名产生人数"  id="directNum" field="directNum" maxlength="30" style="width:80%"/></td>
		</tr>
	</table>
</fieldset>
</form>
</next:Html>
</next:Panel>
</body>
</html>