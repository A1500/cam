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
	var reportDate='<%=request.getParameter("reportDate")%>';
	var organC='<%=request.getParameter("organC")%>';
</script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<jsp:include page="../../util/cdcOrgan.jsp" flush="true"/>
</head>
<body>
<model:datasets>
	<model:dataset id="electionMemberDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcElectionMemberQueryCmd" method="querySum" pageSize="20">
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
<next:Html>
<form id="form1" method="post" dataset="electionMemberDataSet" onsubmit="return false" class="L5form">
<fieldset id="cdcFieldset">
<legend>村委会组成党员比例统计</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:13%">村委会主任人数：</td>
			<td class="FieldInput" style="width:14%"><label id="headNum" field="headNum" maxlength="30" style="width:80%"/></td>
			<td class="FieldLabel" style="width:13%">村委会主任党员人数：</td>
			<td class="FieldInput" style="width:14%"><label id="headPartyNum" field="headPartyNum" maxlength="30" style="width:80%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:13%">村委会副主任人数</td>
			<td class="FieldInput" style="width:15%"><label id="sheadNum" field="sheadNum" maxlength="30" style="width:80%"/></td>
			<td class="FieldLabel">村委会副主任党员人数：</td>
			<td class="FieldInput"><label id="sheadPartyNum" field="sheadPartyNum" maxlength="30" style="width:80%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel">村委会委员人数：</td>
			<td class="FieldInput"><label id="memberNum" field="memberNum" maxlength="30" style="width:80%"/></td>
			<td class="FieldLabel">村委会委员党员人数：</td>
			<td class="FieldInput"><label id="headmanFemaleNum" field="memberPartyNum" maxlength="30" style="width:80%"/></td>
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
 	var electionMemberDataSet=L5.DatasetMgr.lookup("electionMemberDataSet");
	electionMemberDataSet.setParameter("reportDate",reportDate);
	electionMemberDataSet.setParameter("ORGAN_CODE",organC);
	electionMemberDataSet.setParameter("REPORT_TYPE","N");
	electionMemberDataSet.load();
}
</script>