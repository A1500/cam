<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>城市民主选举两委成员情况</title>
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
	<model:dataset id="electionCommitteeDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcElectionCommitteeQueryCmd" pageSize="20">
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
<next:TopBar>
	<next:ToolBarItem symbol="->"/>
</next:TopBar>
<next:Html>
<form id="form1" method="post" dataset="electionCommitteeDataSet" onsubmit="return false" class="L5form">
<fieldset id="cdcFieldset">
<legend>填报情况</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:18%">填报单位：</td>
			<td class="FieldInput" style="width:27%"><label field="organName"/></td>
			<td class="FieldLabel" style="width:13%">填报日期：</td>
			<td class="FieldInput" style="width:42%"><label field="reportDate" dataset="reportWorkDataSet"/></td>
		</tr>
	</table>
</fieldset>
<fieldset id="cdcFieldset">
<legend>当选两委成员</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:13%">总人数：</td>
			<td class="FieldInput" style="width:14%"><label id="cadreNum" field="cadreNum"  /></td>
			<td class="FieldLabel" style="width:13%">妇女人数：</td>
			<td class="FieldInput" style="width:14%"><label id="cadreFemaleNum" field="cadreFemaleNum"  /></td>
			<td class="FieldLabel" style="width:13%">党员人数：</td>
			<td class="FieldInput" style="width:15%"><label id="cadrePartyNum" field="cadrePartyNum"  /></td>
		</tr>
		<tr>
			<td class="FieldLabel">连选连任人数：</td>
			<td class="FieldInput"><label id="cadreSequenceNum" field="cadreSequenceNum"  /></td>
			<td class="FieldLabel">新当选人数：</td>
			<td class="FieldInput" colspan="3"><label id="cadreNewNum" field="cadreNewNum"  /></td>
		</tr>
		<tr>
			<td class="FieldLabel">30岁以下人数：</td>
			<td class="FieldInput"><label id="cadreThirtyNum" field="cadreThirtyNum"  /></td>
			<td class="FieldLabel">60岁以下人数：</td>
			<td class="FieldInput"><label id="cadreUsixtyNum" field="cadreUsixtyNum"  /></td>
			<td class="FieldLabel">60岁以上人数</td>
			<td class="FieldInput"><label id="cadreSixtyNum" field="cadreSixtyNum"  /></td>
		</tr>
		<tr>
			<td class="FieldLabel">大专及以上人数：</td>
			<td class="FieldInput"><label id="cadreCollegeNum" field="cadreCollegeNum"  /></td>
			<td class="FieldLabel">高中及以下人数：</td>
			<td class="FieldInput" colspan="3"><label id="cadreHightNum" field="cadreHightNum"  /></td>
		</tr>
	</table>
</fieldset>
<fieldset id="cdcFieldset">
<legend>两委成员情况</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:20%" colspan="2">两委交叉任职人数：</td>
			<td class="FieldInput" style="width:14%"><label id="cadreAcrossNum" field="cadreAcrossNum"  /></td>
			<td class="FieldLabel" style="width:16%">是否主任书记一人兼：</td>
			<td class="FieldInput" colspan="3"><label id="ifSideline" field="ifSideline"  dataset="YorN"/></td>
			
		</tr>
		<tr>
			<td class="FieldLabel" rowspan="3">来源：</td>
			<td class="FieldLabel">居民人数：</td>
			<td class="FieldInput"><label id="cadreResideNum" field="cadreResideNum"  /></td>
			<td class="FieldLabel">经济组织负责人数：</td>
			<td class="FieldInput"><label id="cadreEconomyNum" field="cadreEconomyNum"  /></td>
			<td class="FieldLabel" style="width:15%">产业协会负责人数：</td>
			<td class="FieldInput"><label id="cadreUnionNum" field="cadreUnionNum"  /></td>
		</tr>
			<tr>
			<td class="FieldLabel">返乡人数：</td>
			<td class="FieldInput"><label id="cadreBackNum" field="cadreBackNum"  /></td>
			<td class="FieldLabel">机关下派人数：</td>
			<td class="FieldInput"><label id="cadreDispatchNum" field="cadreDispatchNum"  /></td>
			<td class="FieldLabel" style="width:15%">高校毕业生人数：</td>
			<td class="FieldInput"><label id="cadreGradNum" field="cadreGradNum"  /></td>
		</tr>
			<tr>
			<td class="FieldLabel">大学生居官人数：</td>
			<td class="FieldInput"><label id="cadreStudentNum" field="cadreRetireNum"  /></td>
			<td class="FieldLabel">离岗退休人数：</td>
			<td class="FieldInput" colspan="3"><label id="cadreRetireNum" field="cadreRetireNum"  /></td>
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
	var reportWorkDataSet=L5.DatasetMgr.lookup("reportWorkDataSet");
	reportWorkDataSet.load();
	electionCommitteeDataSet.setParameter("RECORD_ID@=",'<%=request.getParameter("recordId")%>');
	electionCommitteeDataSet.on("load",function(){
		var nominate = electionCommitteeDataSet.getCurrent();
		if(nominate==null){
			electionCommitteeDataSet.newRecord({"organCode":organCode,"organName":organName,"parentCode":parentCode,
			"reportType":"C","recordId":recordId});
		}
	});
	electionCommitteeDataSet.load();
	reportWorkDataSet.load();
}
function returnBack(){
	history.go(-1);
}
</script>