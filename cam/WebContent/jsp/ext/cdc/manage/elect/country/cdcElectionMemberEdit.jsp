<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<script type="text/javascript">
</script>
<title>农村民主选举村委会成员组成信息</title>
<next:ScriptManager/>
<script type="text/javascript">
	var reportTime='<%=request.getParameter("reportTime")%>';
	var recordId='<%=request.getParameter("recordId")%>';
</script>
<script type="text/javascript" src="cdcElectionMemberEdit.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<jsp:include page="../../util/cdcOrgan.jsp" flush="true"/>
</head>
<body>
<model:datasets>
	<model:dataset id="electionMemberDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcElectionMemberQueryCmd" pageSize="20">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcElectionMember"/>
	</model:dataset>
	<model:dataset id="electionMember2DataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcElectionMemberQueryCmd" pageSize="20">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcElectionMember"/>
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
<form id="form1" method="post" dataset="electionMemberDataSet" onsubmit="return false" class="L5form">
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
<legend>村委会成员组成</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:13%">村委会主任人数：</td>
			<td class="FieldInput" style="width:14%"><input type="text" name = "村委会主任人数"  id="headNum" field="headNum" maxlength="30" style="width:80%"/></td>
			<td class="FieldLabel" style="width:13%">村委会主任党员人数：</td>
			<td class="FieldInput" style="width:14%"><input type="text" name = "村委会主任党员人数"  id="headPartyNum" field="headPartyNum" maxlength="30" style="width:80%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:13%">村委会副主任人数：</td>
			<td class="FieldInput" style="width:15%"><input type="text" name = "村委会副主任人数"  id="sheadNum" field="sheadNum" maxlength="30" style="width:80%"/></td>
			<td class="FieldLabel">村委会副主任党员人数：</td>
			<td class="FieldInput"><input type="text" name = "村委会副主任党员人数"  id="sheadPartyNum" field="sheadPartyNum" maxlength="30" style="width:80%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel">村委会委员人数：</td>
			<td class="FieldInput"><input type="text" name = "村委会委员人数"  id="memberNum" field="memberNum" maxlength="30" style="width:80%"/></td>
			<td class="FieldLabel">村委会委员党员人数：</td>
			<td class="FieldInput"><input type="text" name = "村委会委员党员人数"  id="headmanFemaleNum" field="memberPartyNum" maxlength="30" style="width:80%"/></td>
		</tr>
	</table>
</fieldset>
</form>
</next:Html>
</next:Panel>
</body>
</html>