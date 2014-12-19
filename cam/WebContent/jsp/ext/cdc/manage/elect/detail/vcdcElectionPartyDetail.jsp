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
	<model:dataset id="partyDs" cmd="com.inspur.cams.cdc.base.cmd.CdcElectionSumQueryCmd" method="query" pageSize="20"/>
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
	<model:dataset id="statusDataSet" enumName="CDC.STATUS" autoLoad="true" global="true"/>
	<model:dataset id="YorN" enumName="COMM.YESORNO" autoLoad="true" global="true" />
	<model:dataset id="sexDataSet" enumName="COMM.SEX" autoLoad="true" global="true"/>
	<model:dataset id="politicalDataSet" enumName="CDC.POLITICAL" autoLoad="true" global="true"/>
	<model:dataset id="educationDataSet" enumName="CDC.EDUCATION" autoLoad="true" global="true"/>
	<model:dataset id="dutyDs" enumName="CDC.DUTY.TYPE" autoLoad="true" global="true"/>
	<model:dataset id="partySourceDs" enumName="CDC.PARTY_SOURCE" autoLoad="true" global="true"/>
</model:datasets>
<next:Panel width="99%" autoScroll="true">
<next:TopBar>
	<next:ToolBarItem symbol="->"/>
</next:TopBar>
<next:Html>
<form id="form1" method="post" dataset="partyDs" onsubmit="return false" class="L5form">
<fieldset id="cdcFieldset">
<legend>村党组织成员情况</legend>
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
<legend>村党组织情况</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:18%">本村中共党员人数：</td>
			<td class="FieldInput" style="width:14%"><label field="PARTY_NUM" renderer="rRender"/></td>
			<td class="FieldLabel" style="width:18%">其中妇女党员人数：</td>
			<td class="FieldInput" style="width:14%"><label field="FEMALE_NUM" renderer="rRender"/></td>
			<td class="FieldLabel" style="width:18%">其中少数民族党员人数：</td>
			<td class="FieldInput" style="width:14%"><label field="FOLK_NUM" renderer="rRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel">党组织成员人数：</td>
			<td class="FieldInput"><label field="PARTY_MEMBER_NUM" renderer="rRender"/></td>
			<td class="FieldLabel">初次当选人数：</td>
			<td class="FieldInput"><label field="FIRST_NUM" renderer="rRender"/></td>
			<td class="FieldLabel">连选连任人数：</td>
			<td class="FieldInput"><label field="REDUTY_NUM" renderer="rRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel">兼任村委会主任人数：</td>
			<td class="FieldInput"><label field="DUTY1_NUM" renderer="rRender"/></td>
			<td class="FieldLabel">兼任村委会副主任人数：</td>
			<td class="FieldInput"><label field="DUTY2_NUM" renderer="rRender"/></td>
			<td class="FieldLabel">兼任村委会委员人数：</td>
			<td class="FieldInput"><label field="DUTY3_NUM" renderer="rRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel">村妇代会主任人数：</td>
			<td class="FieldInput"><label field="SRC1_NUM" renderer="rRender"/></td>
			<td class="FieldLabel">村团组织书记人数：</td>
			<td class="FieldInput"><label field="SRC2_NUM" renderer="rRender"/></td>
			<td class="FieldLabel">合作经济组织负责人人数：</td>
			<td class="FieldInput"><label field="SRC3_NUM" renderer="rRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel">产业协会负责人人数：</td>
			<td class="FieldInput"><label field="SRC4_NUM" renderer="rRender"/></td>
			<td class="FieldLabel">外出务工经商人数：</td>
			<td class="FieldInput"><label field="SRC5_NUM" renderer="rRender"/></td>
			<td class="FieldLabel">上级下派机关干部人数：</td>
			<td class="FieldInput"><label field="SRC6_NUM" renderer="rRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel">离退休干部人数：</td>
			<td class="FieldInput"><label field="SRC7_NUM" renderer="rRender"/></td>
			<td class="FieldLabel">大学生村官人数：</td>
			<td class="FieldInput"><label field="SRC8_NUM" renderer="rRender"/></td>
			<td class="FieldLabel">社会公开招考（聘）人数：</td>
			<td class="FieldInput"><label field="SRC9_NUM" renderer="rRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel">“三高三强”人才数：</td>
			<td class="FieldInput" colspan="5"><label field="SRC10_NUM" renderer="rRender"/></td>
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
	var partyDs=L5.DatasetMgr.lookup("partyDs");
	partyDs.setParameter("tableName","CDC_ELECTION_PARTY_SUM");
	partyDs.setParameter("organCode",organC);
	partyDs.setParameter("reportDate",reportDate);
	var reportWorkDataSet=L5.DatasetMgr.lookup("reportWorkDataSet");
	reportWorkDataSet.load();
	partyDs.on("load",function(){
		var nominate = partyDs.getCurrent();
		if(nominate==null){
			partyDs.newRecord({"ORGAN_NAME":organC,"REPORT_DATE":reportDate});
		}
	});
	partyDs.load();
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
</script>