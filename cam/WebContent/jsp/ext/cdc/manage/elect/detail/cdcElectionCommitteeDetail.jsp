<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<script type="text/javascript">
</script>
<title>城市民主选举两委成员情况</title>
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
	<model:dataset id="electionCommitteeDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcElectionCommitteeQueryCmd" method="querySum" pageSize="20">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcElectionCommittee"/>
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
<form id="form1" method="post" dataset="electionCommitteeDataSet" onsubmit="return false" class="L5form">
<fieldset id="cdcFieldset">
<legend>当选两委成员</legend>
<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:13%" rowspan="2">已当选居干部人数：</td>
			<td class="FieldLabel" style="width:13%">总人数：</td>
			<td class="FieldInput" style="width:14%"><label id="cadreNum" field="CADERNUM" maxlength="30" style="width:80%"/></td>
			<td class="FieldLabel" style="width:13%">妇女人数：</td>
			<td class="FieldInput" style="width:14%"><label id="cadreFemaleNum" field="CADREFEMALENUM" maxlength="30" style="width:80%"/></td>
			<td class="FieldLabel" style="width:13%">党员人数：</td>
			<td class="FieldInput" style="width:15%"><label id="cadrePartyNum" field="CADREPARTYNUM" maxlength="30" style="width:80%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel">连选连任人数：</td>
			<td class="FieldInput"><label id="cadreSequenceNum" field="CADRESEQUENCENUM" maxlength="30" style="width:80%"/></td>
			<td class="FieldLabel">新当选人数：</td>
			<td class="FieldInput" colspan="3"><label id="cadreNewNum" field="CADRENEWNUM" maxlength="30" style="width:80%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:13%" >年龄结构：</td>
			<td class="FieldLabel">30岁以下人数：</td>
			<td class="FieldInput"><label id="cadreThirtyNum" field="CADRETHIRTYNUM" maxlength="30" style="width:80%"/></td>
			<td class="FieldLabel">60岁以下人数：</td>
			<td class="FieldInput"><label id="cadreUsixtyNum" field="CADREUSIXTYNUM" maxlength="30" style="width:80%"/></td>
			<td class="FieldLabel">60岁以上人数</td>
			<td class="FieldInput"><label id="cadreSixtyNum" field="CADRESIXTYNUM" maxlength="30" style="width:80%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:13%" >文化结构：</td>
			<td class="FieldLabel">大专及以上人数：</td>
			<td class="FieldInput"><label id="cadreCollegeNum" field="CADRECOLLEGENUM" maxlength="30" style="width:80%"/></td>
			<td class="FieldLabel">高中及以下人数：</td>
			<td class="FieldInput" colspan="3"><label id="cadreHightNum" field="CADREHIGHTNUM" maxlength="30" style="width:80%"/></td>
		</tr>
	</table>
</fieldset>
<fieldset id="cdcFieldset">
<legend>两委成员情况</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:19%" colspan="2">两委交叉任职人数：</td>
			<td class="FieldInput" style="width:14%"><label id="cadreAcrossNum" field="CADREACROSSNUM" maxlength="30" style="width:80%"/></td>
			<td class="FieldLabel" style="width:17%">主任书记一人兼居数：</td>
			<td class="FieldInput" colspan="3"><label id="ifSideline" field="IFSIDELINE"/> </td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:8%" rowspan="3">来  源</td>
			<td class="FieldLabel" style="width:19.5%">两委居民人数：</td>
			<td class="FieldInput"><label id="cadreResideNum" field="CADRERESIDENUM" maxlength="30" style="width:80%"/></td>
			<td class="FieldLabel" style="width:17%">两委经济组织负责人数：</td>
			<td class="FieldInput"><label id="cadreEconomyNum" field="CADREECONOMYNUM" maxlength="30" style="width:80%"/></td>
			<td class="FieldLabel" style="width:17%">两委产业协会负责人数：</td>
			<td class="FieldInput"><label id="cadreUnionNum" field="CADREUNIONNUM" maxlength="30" style="width:80%"/></td>
		</tr>
			<tr>
			<td class="FieldLabel" style="width:19.5%">两委返乡人数：</td>
			<td class="FieldInput"><label id="cadreBackNum" field="CADREBACKNUM" maxlength="30" style="width:80%"/></td>
			<td class="FieldLabel">两委机关下派人数：</td>
			<td class="FieldInput"><label id="cadreDispatchNum" field="CADREDISPATCHNUM" maxlength="30" style="width:80%"/></td>
			<td class="FieldLabel" style="width:17%">两委高校毕业生人数：</td>
			<td class="FieldInput"><label id="cadreGradNum" field="CADREGRADNUM" maxlength="30" style="width:80%"/></td>
		</tr>
			<tr>
			<td class="FieldLabel" style="width:19.5%">两委大学生居官人数：</td>
			<td class="FieldInput"><label id="cadreStudentNum" field="CADRERETIRENUM" maxlength="30" style="width:80%"/></td>
			<td class="FieldLabel">两委离岗退休人数：</td>
			<td class="FieldInput" colspan="3"><label id="cadreRetireNum" field="CADRERETIRENUM" maxlength="30" style="width:80%"/></td>
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
 	var electionCommitteeDataSet=L5.DatasetMgr.lookup("electionCommitteeDataSet");
	electionCommitteeDataSet.setParameter("reportDate",reportDate);
	electionCommitteeDataSet.setParameter("ORGAN_CODE",organC);
	electionCommitteeDataSet.setParameter("REPORT_TYPE","C");
	electionCommitteeDataSet.load();
}
</script>