<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<script type="text/javascript">
</script>
<title>农村民主选举选举准备情况</title>
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
	<model:dataset id="electionPrepareDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcElectionSumQueryCmd" method="query" pageSize="20"/>
	<model:dataset id="reportWorkDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcReportWorkQueryCmd" method="getDic" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"/>
		<model:params>
			<model:param name="reportType" value='R11'/>
			<model:param name="organType" value='N'/>
		</model:params>
	</model:dataset>
	<model:dataset id="YorN" enumName="COMM.YESORNO" autoLoad="true" global="true" />
	<model:dataset id="statusDataSet" enumName="CDC.STATUS" autoLoad="true" global="true"/>
	<!-- 性别 -->
	<model:dataset id="sexDataSet" enumName="COMM.SEX" autoLoad="true" global="true"/>
	<model:dataset id="ecAuditDs" enumName="CDC.ELECTION_ECONOMY_AUDIT" autoLoad="true" global="true"/>
	<model:dataset id="electionMannerDs" enumName="CDC.ELECTION_MANNER" autoLoad="true" global="true"/>
</model:datasets>
<next:Panel width="99%" autoScroll="true">
<next:TopBar>
	<next:ToolBarItem symbol="->"/>
</next:TopBar>
<next:Html>
<form id="form1" method="post" dataset="electionPrepareDataSet" onsubmit="return false" class="L5form">
<fieldset id="cdcFieldset">
<legend>选举准备情况</legend>
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
<legend>选举情况</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel">村民总数：</td>
			<td class="FieldInput"><label field="PEOPLE_NUM" renderer="rRender"/></td>
			<td class="FieldLabel">张榜公布登记参加选举的村民总数：</td>
			<td class="FieldInput" colspan="3"><label field="ELE_PEOPLE_NUM" renderer="rRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">村民选举委员会职数：</td>
			<td class="FieldInput" style="width:14%"><label field="ELE_COM_NUM" renderer="rRender"/></td>
			<td class="FieldLabel" style="width:18%">党员人数：</td>
			<td class="FieldInput" style="width:14%"><label field ="ELE_COM_PARTY_NUM" renderer="rRender"/></td>
			<td class="FieldLabel" style="width:18%">妇女成员人数：</td>
			<td class="FieldInput" style="width:14%"><label field="ELE_COM_FEMALE_NUM" renderer="rRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel">村民会议推选产生村数：</td>
			<td class="FieldInput"><label field="ELECTION_MANNER1" renderer="gRender"/></td>
			<td class="FieldLabel">村民代表会议推选产生村数：</td>
			<td class="FieldInput"><label field="ELECTION_MANNER2" renderer="gRender"/></td>
			<td class="FieldLabel">村民小组会议推选产生村数：</td>
			<td class="FieldInput"><label field="ELECTION_MANNER3" renderer="gRender"/></td>
		</tr>
	</table>
</fieldset>
<fieldset id="cdcFieldset">
<legend>难点村情况</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel">难点村个数：</td>
			<td class="FieldInput" colspan="5"><label field="DIFF_NUM" renderer="gRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">未换届选举</td>
			<td class="FieldInput" style="width:14%"><label field="DIFF_REASON1" renderer="gRender"/></td>
			<td class="FieldLabel" style="width:18%">班子不健全</td>
			<td class="FieldInput" style="width:14%"><label field="DIFF_REASON2" renderer="gRender"/></td>
			<td class="FieldLabel" style="width:18%">班子软弱涣散</td>
			<td class="FieldInput" style="width:14%"><label field="DIFF_REASON3" renderer="gRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel">干群关系紧张</td>
			<td class="FieldInput"><label field="DIFF_REASON4" renderer="gRender"/></td>
			<td class="FieldLabel">村务不公开管理混乱</td>
			<td class="FieldInput"><label field="DIFF_REASON5" renderer="gRender"/></td>
			<td class="FieldLabel">经济薄弱无人干</td>
			<td class="FieldInput"><label field="DIFF_REASON6" renderer="gRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel">经济发达竞争激烈</td>
			<td class="FieldInput"><label field="DIFF_REASON7" renderer="gRender"/></td>
			<td class="FieldLabel">干部驾驭能力差</td>
			<td class="FieldInput"><label field="DIFF_REASON8" renderer="gRender"/></td>
			<td class="FieldLabel">遗留问题未解决</td>
			<td class="FieldInput"><label field="DIFF_REASON9" renderer="gRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel">拆迁合并改制</td>
			<td class="FieldInput"><label field="DIFF_REASON10" renderer="gRender"/></td>
			<td class="FieldLabel">干部作风简单霸道</td>
			<td class="FieldInput"><label field="DIFF_REASON11" renderer="gRender"/></td>
			<td class="FieldLabel">群体上访不断</td>
			<td class="FieldInput"><label field="DIFF_REASON12" renderer="gRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel">宗族派性严重</td>
			<td class="FieldInput"><label field="DIFF_REASON13" renderer="gRender"/></td>
			<td class="FieldLabel">其他</td>
			<td class="FieldInput" colspan="3"><label field="DIFF_REASON14" renderer="gRender"/></td>
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
	electionPrepareDataSet.setParameter("tableName","CDC_ELECTION_PREPARE_SUM");
	electionPrepareDataSet.setParameter("organCode",organC);
	electionPrepareDataSet.setParameter("reportDate",reportDate);
	var reportWorkDataSet=L5.DatasetMgr.lookup("reportWorkDataSet");
	reportWorkDataSet.load();
	electionPrepareDataSet.on("load",function(){
		var nominate = electionPrepareDataSet.getCurrent();
		if(nominate==null){
			electionPrepareDataSet.newRecord({"ORGAN_NAME":organC,"REPORT_DATE":reportDate});
		}
	});
	electionPrepareDataSet.load();
}
function rRender(val){
	if(val!=""){
		return val+" 人";
	}
}
function gRender(val){
	if(val!=""){
		return val+" 个";
	}
}
</script>