<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<script type="text/javascript">
</script>
<title>城市民主选举情况</title>
<next:ScriptManager/>
<script type="text/javascript">
	var method='<%=request.getParameter("method")%>';
	var recordId='<%=request.getParameter("recordId")%>';
	var reportTime='<%=request.getParameter("reportTime")%>';
</script>
<script type="text/javascript" src="cdcElectionInfoEdit.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<jsp:include page="../../util/cdcOrgan.jsp" flush="true"/>
</head>
<body>
<model:datasets>
	<model:dataset id="electionInfoDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcElectionInfoQueryCmd" pageSize="20">
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
<next:TopBar>
	<next:ToolBarItem symbol="->"/>
	<next:ToolBarItem iconCls="return" text="返回" handler="returnBack"/>
</next:TopBar>
<next:Html>
<form id="form1" method="post" dataset="electionInfoDataSet" onsubmit="return false" class="L5form">
<fieldset id="cdcFieldset">
<legend>填报情况</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:18%">填报单位：</td>
			<td class="FieldInput" style="width:27%"><label field="organName"/></td>
			<td class="FieldLabel" style="width:13%">填报日期：</td>
			<td class="FieldInput" style="width:42%"><select id="reportDate" field="reportDate"><option dataset="reportWorkDataSet"/></select><font color="red">*</font></td>
		</tr>
	</table>
</fieldset>
<fieldset id="cdcFieldset">
<legend>选举情况</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:13%">是否参加换届选举：</td>
			<td class="FieldInput"  colspan="3" ><select name = "是否参加换届选举" id="ifElection" field="ifElection" onchange="electionChanges()"> <option dataset="YorN"></option>  </select><font color="red">*</font></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:13%">选举年份：</td>
			<td class="FieldInput" style="width:14%"><input type="text" name = "选举年份"  id="yearly" field="yearly" maxlength="4"  /></td>
			<td class="FieldLabel" style="width:13%">选举届次：</td>
			<td class="FieldInput" style="width:15%"><input type="text" name = "选举届次"  id="season" field="season" maxlength="30"  /></td>
			</tr>
		<tr>
			<td class="FieldLabel">是否完成选举：</td>
			<td class="FieldInput"><select name = "是否完成选举"  id="ifComplete" field="ifComplete" onchange="completeChanges()"> <option dataset="YorN"></option></select></td>
			<td class="FieldLabel">完成情况：</td>
			<td class="FieldInput"><select name = "完成情况"  id="completeResult" field="completeResult"  disabled="disabled"> <option dataset="completeResultDataSet"></option></select></td>
		</tr>
	</table>
</fieldset>
			<div style="float: right;"><button onclick="save()" title="">下一步</button></div>
</form>
</next:Html>
</next:Panel>
</body>
</html>