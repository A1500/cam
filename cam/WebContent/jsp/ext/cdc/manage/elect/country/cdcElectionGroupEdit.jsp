<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<script type="text/javascript">
</script>
<title>农村民主选举村民小组与代表信息</title>
<next:ScriptManager/>
<script type="text/javascript">
	var reportTime='<%=request.getParameter("reportTime")%>';
	var recordId='<%=request.getParameter("recordId")%>';
</script>
<script type="text/javascript" src="cdcElectionGroupEdit.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<jsp:include page="../../util/cdcOrgan.jsp" flush="true"/>
</head>
<body>
<model:datasets>
	<model:dataset id="electionGroupDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcElectionGroupQueryCmd" pageSize="20">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcElectionGroup"/>
	</model:dataset>
	<model:dataset id="electionGroup2DataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcElectionGroupQueryCmd" pageSize="20">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcElectionGroup"/>
	</model:dataset>
	<model:dataset id="electionGroup2DataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcElectionGroupQueryCmd" pageSize="20">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcElectionGroup"/>
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
<form id="form1" method="post" dataset="electionGroupDataSet" onsubmit="return false" class="L5form">
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
<legend>村民小组与代表信息</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:13%">村民代表人数：</td>
			<td class="FieldInput" style="width:14%"><input type="text" name = "村民代表人数"  id="delegateNum" field="delegateNum" maxlength="30" /></td>
			<td class="FieldLabel" style="width:16%">村民代表女性人数：</td>
			<td class="FieldInput" style="width:14%"><input type="text" name = "村民代表女性人数"  id="delegateFemaleNum" field="delegateFemaleNum" maxlength="30" /></td>
			<td class="FieldLabel" style="width:13%">村民代表党员人数：</td>
			<td class="FieldInput" style="width:15%"><input type="text" name = "村民代表党员人数"  id="delegatePartyNum" field="delegatePartyNum" maxlength="30" /></td>
		</tr>
		<tr>
			<td class="FieldLabel">村民代表少数民族数：</td>
			<td class="FieldInput"><input type="text" name = "村民代表少数民族数"  id="delegateFolkNum" field="delegateFolkNum" maxlength="30" /></td>
			<td class="FieldLabel">村民小组长人数：</td>
			<td class="FieldInput"><input type="text" name = "村民小组长人数"  id="headmanNum" field="headmanNum" maxlength="30" /></td>
			<td class="FieldLabel">村民小组长女性人数：</td>
			<td class="FieldInput"><input type="text" name = "村民小组长女性人数"  id="headmanFemaleNum" field="headmanFemaleNum" maxlength="30" /></td>
		</tr>
		<tr>
			<td class="FieldLabel">村民小组长党员数：</td>
			<td class="FieldInput"><input type="text" name = "村民小组长党员数"  id="headmanPartyNum" field="headmanPartyNum" maxlength="30" /></td>
			<td class="FieldLabel">村民小组长少数民族人数：</td>
			<td class="FieldInput" colspan="3"><input type="text" name = "村民小组长少数民族人数"  id="headmanFolkNum" field="headmanFolkNum" maxlength="30" /></td>
		</tr>
	</table>
</fieldset>
</form>
</next:Html>
</next:Panel>
</body>
</html>