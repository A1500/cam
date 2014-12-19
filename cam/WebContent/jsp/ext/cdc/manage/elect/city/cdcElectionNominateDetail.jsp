<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<script type="text/javascript">
</script>
<title>城市民主选举提名方式信息</title>
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
	<model:dataset id="electionNominateDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcElectionNominateQueryCmd" pageSize="20">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcElectionNominate"/>
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
<next:TopBar>
	<next:ToolBarItem symbol="->"/>
</next:TopBar>
<next:Html>
<form id="form1" method="post" dataset="electionNominateDataSet" onsubmit="return false" class="L5form">
<fieldset id="cdcFieldset">
<legend>填报情况</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:18%">填报单位：</td>
			<td class="FieldInput" style="width:27%"><label field="organName"/></td>
			<td class="FieldLabel" style="width:13%">填报日期：</td>
			<td class="FieldInput" style="width:42%"><label id="reportDate" field="reportDate"  dataset="reportWorkDataSet"/></td>
		</tr>
	</table>
</fieldset>
<fieldset id="cdcFieldset">
<legend>初步候选人信息</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:20%">总人数：</td>
			<td class="FieldInput" style="width:30%"><label id="nomJoinNum" field="nomJoinNum" maxlength="30" /></td>
			<td class="FieldLabel" style="width:20%">女性人数：</td>
			<td class="FieldInput" style="width:30%"><label id="prenomNum" field="prenomNum" maxlength="30" /></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:20%">党员人数：</td>
			<td class="FieldInput" style="width:30%"><label  id="prenomDiffNum" field="prenomDiffNum" maxlength="30" /></td>
			<td class="FieldLabel" style="width:20%">少数民族人数：</td>
			<td class="FieldInput" style="width:30%"><label  id="prenomJoinNum" field="prenomJoinNum" maxlength="30" /></td>
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

	var electionNominateDataSet=L5.DatasetMgr.lookup("electionNominateDataSet");
	var reportWorkDataSet=L5.DatasetMgr.lookup("reportWorkDataSet");
	reportWorkDataSet.load();
	electionNominateDataSet.setParameter("RECORD_ID@=",'<%=request.getParameter("recordId")%>');
	electionNominateDataSet.on("load",function(){
		var nominate = electionNominateDataSet.getCurrent();
		if(nominate==null){
			electionNominateDataSet.newRecord({"organCode":organCode,"organName":organName,"parentCode":parentCode,
			"reportType":"C","recordId":recordId});
		}
	});
	electionNominateDataSet.load();
	reportWorkDataSet.load();
}
function returnBack(){
	history.go(-1);
}
</script>