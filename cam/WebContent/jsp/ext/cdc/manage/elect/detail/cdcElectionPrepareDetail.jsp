<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>城市民主选举选举准备情况</title>
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
	<model:dataset id="electionPrepareDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcElectionPrepareQueryCmd" method="querySum" pageSize="20">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcElectionPrepare"/>
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
<form id="form1" method="post" dataset="electionPrepareDataSet" onsubmit="return false" class="L5form">
<fieldset id="cdcFieldset">
<legend>选民登记信息</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:13%">选民总数：</td>
			<td class="FieldInput" style="width:14%"><label id="villagerNum" field="villagerNum" maxlength="30" style="width:80%"/></td>
			<td class="FieldLabel" style="width:13%">本届登记选民数：</td>
			<td class="FieldInput" style="width:14%"><label id="joinVillagerNum" field="joinVillagerNum" maxlength="30" style="width:80%"/></td>
		</tr>
		<tr>	
			<td class="FieldLabel" style="width:13%">女性人数：</td>
			<td class="FieldInput" style="width:14%"><label id="eleFemaleNum" field="eleFemaleNum" maxlength="30" style="width:80%"/></td>
			<td class="FieldLabel" style="width:13%">少数民族人数：</td>
			<td class="FieldInput" style="width:14%"><label id="eleFolkNum" field="eleFolkNum" maxlength="30" style="width:80%"/></td>
		</tr>
	</table>
<fieldset id="cdcFieldset">
<legend>选举委员会</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:13%" colspan="2">总人数：</td>
			<td class="FieldInput" style="width:14%"><label id="eleComNum" field="eleComNum" maxlength="30" style="width:80%"/></td>
			<td class="FieldLabel" style="width:13%">党员人数：</td>
			<td class="FieldInput" style="width:14%"><label id="eleComPartyNum" field="eleComPartyNum" maxlength="30" style="width:80%"/></td>
		</tr>
		<tr>
			<td  rowspan="3" style="width:13%" class="FieldLabel">选举委员会产生方式</td>
			<td class="FieldLabel" style="width:14%">全体居民推选：</td>
			<td class="FieldInput" colspan="3" style="width:14%"><label id="meetingPeopleNum" field="sovietNum" maxlength="30" style="width:80%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:13%">户代表推选：</td>
			<td class="FieldInput" style="width:14%" colspan="3"><label id="sovietPeopleNum" field="joinSovietNum" maxlength="30" style="width:80%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:13%">居民小组代表推选：</td>
			<td class="FieldInput" style="width:14%" colspan="3"><label id="groupPeopleNum" field="groupNum" maxlength="30" style="width:80%"/></td>
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
 	var electionPrepareDataSet=L5.DatasetMgr.lookup("electionPrepareDataSet");
	electionPrepareDataSet.setParameter("reportDate",reportDate);
	electionPrepareDataSet.setParameter("ORGAN_CODE",organC);
	electionPrepareDataSet.setParameter("REPORT_TYPE","C");
	electionPrepareDataSet.load();
}
function undo(){
	var url = "jsp/ext/cdc/manage/elect/city/cdcElectionList.jsp";
	var data=new L5.Map();
	L5.forward(url,'',data);
}
</script>