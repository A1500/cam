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
	var reportDate='<%=request.getParameter("reportDate")%>';
	var organC='<%=request.getParameter("organC")%>';
</script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<jsp:include page="../../util/cdcOrgan.jsp" flush="true"/>
</head>
<body>
<model:datasets>
	<model:dataset id="electionNominateDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcElectionNominateQueryCmd" method="querySum" pageSize="20">
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
<next:Html>
<form id="form1" method="post" dataset="electionNominateDataSet" onsubmit="return false" class="L5form">
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
	electionNominateDataSet.setParameter("reportDate",reportDate);
	electionNominateDataSet.setParameter("ORGAN_CODE",organC);
	electionNominateDataSet.setParameter("REPORT_TYPE","C");
	electionNominateDataSet.load();
}
function undo(){
	var url = "jsp/ext/cdc/manage/elect/city/cdcElectionList.jsp";
	var data=new L5.Map();
	L5.forward(url,'',data);
}
</script>