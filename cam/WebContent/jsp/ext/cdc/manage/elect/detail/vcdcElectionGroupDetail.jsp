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
	var reportDate='<%=request.getParameter("reportDate")%>';
	var organC='<%=request.getParameter("organC")%>';
</script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<jsp:include page="../../util/cdcOrgan.jsp" flush="true"/>
</head>
<body>
<model:datasets>
	<model:dataset id="electionGroupDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcElectionGroupQueryCmd" method="querySum" pageSize="20">
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
<next:Html>
<form id="form1" method="post" dataset="electionGroupDataSet" onsubmit="return false" class="L5form">
<fieldset id="cdcFieldset">
<legend>村民小组与代表信息</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:13%" rowspan="2">村民代表：</td>
			<td class="FieldLabel" style="width:13%">总人数：</td>
			<td class="FieldInput" style="width:14%"><label id="delegateNum" field="delegateNum" maxlength="30" style="width:80%"/></td>
			<td class="FieldLabel" style="width:13%">女性人数：</td>
			<td class="FieldInput" style="width:14%"><label id="delegateFemaleNum" field="delegateFemaleNum" maxlength="30" style="width:80%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:13%">村民代表党员人数</td>
			<td class="FieldInput" style="width:15%"><label id="delegatePartyNum" field="delegatePartyNum" maxlength="30" style="width:80%"/></td>
			<td class="FieldLabel">村民代表少数民族数：</td>
			<td class="FieldInput"><label id="delegateFolkNum" field="delegateFolkNum" maxlength="30" style="width:80%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:13%" rowspan="2">村民小组长：</td>
			<td class="FieldLabel">村民小组长人数：</td>
			<td class="FieldInput"><label id="headmanNum" field="headmanNum" maxlength="30" style="width:80%"/></td>
			<td class="FieldLabel">村民小组长女性人数：</td>
			<td class="FieldInput"><label id="headmanFemaleNum" field="headmanFemaleNum" maxlength="30" style="width:80%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel">村民小组长党员数：</td>
			<td class="FieldInput"><label id="headmanPartyNum" field="headmanPartyNum" maxlength="30" style="width:80%"/></td>
			<td class="FieldLabel">村民小组长少数民族人数：</td>
			<td class="FieldInput"><label id="headmanFolkNum" field="headmanFolkNum" maxlength="30" style="width:80%"/></td>
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
 	var electionGroupDataSet=L5.DatasetMgr.lookup("electionGroupDataSet");
	electionGroupDataSet.setParameter("reportDate",reportDate);
	electionGroupDataSet.setParameter("ORGAN_CODE",organC);
	electionGroupDataSet.setParameter("REPORT_TYPE","N");
	electionGroupDataSet.load();
}
</script>