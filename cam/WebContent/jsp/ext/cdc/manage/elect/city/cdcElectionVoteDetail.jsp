<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<script type="text/javascript">
</script>
<title>城市民主选举投票方式信息</title>
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
	<model:dataset id="electionVoteDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcElectionVoteQueryCmd" pageSize="20">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcElectionVote"/>
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
<form id="form1" method="post" dataset="electionVoteDataSet" onsubmit="return false" class="L5form">
<fieldset id="cdcFieldset">
<legend>填报情况</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:18%">填报单位：</td>
			<td class="FieldInput" style="width:27%"><label field="organName"/></td>
			<td class="FieldLabel" style="width:13%">填报日期：</td>
			<td class="FieldInput" style="width:42%"><label id="reportDate" field="reportDate" option dataset="reportWorkDataSet"/></td>
		</tr>
	</table>
</fieldset>
<fieldset id="cdcFieldset">
<legend>投票方式信息</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:13%" colspan="2">选民总数：</td>
			<td class="FieldInput" style="width:14%" colspan="3"><label id="voterNum" field="voterNum" maxlength="30" /></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:13%" rowspan="2">直接投票情况：</td>
			<td class="FieldLabel" style="width:15%">选举会场投票数：</td>
			<td class="FieldInput" style="width:15%"><label id="centerBoxNum" field="centerBoxNum" maxlength="30" /></td>
			<td class="FieldLabel" style="width:15%">流动票箱投票数：</td>
			<td class="FieldInput" style="width:15%"><label id="flowNum" field="flowNum" maxlength="30" /></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:15%">函投票数：</td>
			<td class="FieldInput" style="width:15%"><label id="subBoxNum" field="subBoxNum" maxlength="30" /></td>
			<td class="FieldLabel" style="width:15%">投票站投票数：</td>
			<td class="FieldInput" style="width:15%"><label id="stationVoteNum" field="stationVoteNum" maxlength="30" /></td>
		</tr>
		<tr>
			<td class="FieldLabel" >委托投票情况：</td>
			<td class="FieldLabel">选民委托投票数合计：</td>
			<td class="FieldInput" colspan="3"><label id="entrustNum" field="entrustNum" maxlength="30" /></td>
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

	var electionVoteDataSet=L5.DatasetMgr.lookup("electionVoteDataSet");
	var reportWorkDataSet=L5.DatasetMgr.lookup("reportWorkDataSet");
	reportWorkDataSet.load();
	electionVoteDataSet.setParameter("RECORD_ID@=",'<%=request.getParameter("recordId")%>');
	electionVoteDataSet.on("load",function(){
		var nominate = electionVoteDataSet.getCurrent();
		if(nominate==null){
			electionVoteDataSet.newRecord({"organCode":organCode,"organName":organName,"parentCode":parentCode,
			"reportType":"C","recordId":recordId});
		}
	});
	electionVoteDataSet.load();
	reportWorkDataSet.load();
}
function returnBack(){
	history.go(-1);
}
</script>