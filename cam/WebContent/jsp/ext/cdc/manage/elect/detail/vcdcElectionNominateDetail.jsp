<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<script type="text/javascript">
</script>
<title>农村民主选举提名方式信息</title>
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
	<model:dataset id="electionNominateDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcElectionSumQueryCmd" method="query" pageSize="20"/>
	<model:dataset id="peopleDs" cmd="com.inspur.cams.cdc.base.cmd.CdcElectionMemberQueryCmd" pageSize="20">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcElectionMember"/>
	</model:dataset>
	<model:dataset id="reportWorkDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcReportWorkQueryCmd" method="getDic" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"/>
		<model:params>
			<model:param name="reportType" value='R11'/>
			<model:param name="organType" value='N'/>
		</model:params>
	</model:dataset>
	<!-- 民族 -->
	<model:dataset id="NationDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_NATION'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset> 
	<model:dataset id="YorN" enumName="COMM.YESORNO" autoLoad="true" global="true" />
	<model:dataset id="sexDataSet" enumName="COMM.SEX" autoLoad="true" global="true"/>
	<model:dataset id="politicalDataSet" enumName="CDC.POLITICAL" autoLoad="true" global="true"/>
	<model:dataset id="educationDataSet" enumName="CDC.EDUCATION" autoLoad="true" global="true"/>
	<model:dataset id="statusDataSet" enumName="CDC.STATUS" autoLoad="true" global="true"/>
	<model:dataset id="candidateMannerDs" enumName="CDC.CANDIDATE_MANNER" autoLoad="true" global="true"/>
	<model:dataset id="nomMannerDs" enumName="CDC.NOM_MANNER" autoLoad="true" global="true"/>
	<model:dataset id="nomSourceDs" enumName="CDC.NOM_SOURCE" autoLoad="true" global="true"/>
</model:datasets>
<next:Panel width="99%" autoScroll="true">
<next:TopBar>
	<next:ToolBarItem symbol="->"/>
</next:TopBar>
<next:Html>
<form id="form1" method="post" dataset="electionNominateDataSet" onsubmit="return false" class="L5form">
<fieldset id="cdcFieldset">
<legend>候选人的产生</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel"  style="width:18%">填报单位：</td>
			<td class="FieldInput"  style="width:14%"><label field="ORGAN_NAME"/></td>
			<td class="FieldLabel"  style="width:21%">填报日期：</td>
			<td class="FieldInput" ><label id="reportDate" field="REPORT_DATE" dataset="reportWorkDataSet"/></td>
		</tr>
	</table>
</fieldset>
<fieldset id="cdcFieldset">
<legend>候选人的产生</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel">应选名额：</td>
			<td class="FieldInput"><label field="NOM_NUM" renderer="mRender"/></td>
			<td class="FieldLabel">候选人人数：</td>
			<td class="FieldInput" colspan="3"><label field="NOM_DIFF_NUM" renderer="rRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel">女性人数：</td>
			<td class="FieldInput"><label field="NOM_FEMALE_NUM" renderer="rRender"/></td>
			<td class="FieldLabel">党员人数：</td>
			<td class="FieldInput"><label field="NOM_PARTY_NUM" renderer="rRender"/></td>
			<td class="FieldLabel">少数民族人数：</td>
			<td class="FieldInput"><label field="NOM_FOLK_NUM" renderer="rRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel">预选产生人数：</td>
			<td class="FieldInput"><label field="CANDIDATE_MANNER3" renderer="rRender"/></td>
			<td class="FieldLabel">提名（预选）产生的人数：</td>
			<td class="FieldInput"><label field="CANDIDATE_MANNER2" renderer="rRender"/></td>
			<td class="FieldLabel">村民直接提名产生的人数：</td>
			<td class="FieldInput"><label field="CANDIDATE_MANNER1" renderer="rRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">原村委会成员：</td>
			<td class="FieldInput" style="width:14%"><label field="SRC1_NUM" renderer="rRender"/></td>
			<td class="FieldLabel" style="width:18%">原村党组织成员：</td>
			<td class="FieldInput" style="width:14%"><label field="SRC2_NUM" renderer="rRender"/></td>
			<td class="FieldLabel" style="width:18%">村民选举委员会成员：</td>
			<td class="FieldInput" style="width:14%"><label field="SRC3_NUM" renderer="rRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel">村民：</td>
			<td class="FieldInput"><label field="SRC4_NUM" renderer="rRender"/></td>
			<td class="FieldLabel">其他：</td>
			<td class="FieldInput" colspan="3"><label field="SRC5_NUM" renderer="rRender"/></td>
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
	electionNominateDataSet.setParameter("tableName","CDC_ELECTION_NOMINATE_SUM");
	electionNominateDataSet.setParameter("organCode",organC);
	electionNominateDataSet.setParameter("reportDate",reportDate);
	var reportWorkDataSet=L5.DatasetMgr.lookup("reportWorkDataSet");
	reportWorkDataSet.load();
	electionNominateDataSet.on("load",function(){
		var nominate = electionNominateDataSet.getCurrent();
		if(nominate==null){
			electionNominateDataSet.newRecord({"ORGAN_NAME":organC,"REPORT_DATE":reportDate});
		}
	});
	electionNominateDataSet.load();
	reportWorkDataSet.load();
}
function returnBack(){
	history.go(-1);
}
function rRender(val){
	if(val!=""){
		return val+" 人";
	}
}
function mRender(val){
	if(val!=""){
		return val+" 名";
	}
}
</script>