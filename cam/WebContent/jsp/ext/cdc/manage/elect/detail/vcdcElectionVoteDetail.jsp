<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<script type="text/javascript">
</script>
<title>农村民主选举投票方式信息</title>
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
	<model:dataset id="electionVoteDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcElectionSumQueryCmd" method="query" pageSize="20"/>
	<model:dataset id="reportWorkDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcReportWorkQueryCmd" method="getDic" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"/>
		<model:params>
			<model:param name="reportType" value='R11'/>
			<model:param name="organType" value='N'/>
		</model:params>
	</model:dataset>
	<model:dataset id="YorN" enumName="COMM.YESORNO" autoLoad="true" global="true" />
	<model:dataset id="statusDataSet" enumName="CDC.STATUS" autoLoad="true" global="true"/>
	<model:dataset id="vtoerMannerDs" enumName="CDC.VOTER_MANNER" autoLoad="true" global="true"/>
</model:datasets>
<next:Panel width="99%" autoScroll="true">
<next:TopBar>
	<next:ToolBarItem symbol="->"/>
</next:TopBar>
<next:Html>
<form id="form1" method="post" dataset="electionVoteDataSet" onsubmit="return false" class="L5form">
<fieldset id="cdcFieldset">
<legend>正式选举</legend>
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
<legend>投票方式、方法</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel">一次投票个数：</td>
			<td class="FieldInput"><label field="VOTER_MANNER_ONE" renderer="gRender"/></td>
			<td class="FieldLabel">分次投票个数：</td>
			<td class="FieldInput" colspan="3"><label field="VOTER_MANNER_TWO" renderer="gRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel">参加正式选举投票的村民总数：</td>
			<td class="FieldInput"><label field="VOTER_NUM" renderer="rRender"/></td>
			<td class="FieldLabel">委托投票人数：</td>
			<td class="FieldInput" colspan="3"><label field="ENTRUST_NUM" renderer="rRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">使用流动票箱投票人数：</td>
			<td class="FieldInput" style="width:14%"><label field="FLOW_NUM" renderer="gRender"/></td>
			<td class="FieldLabel" style="width:18%">代写选票人数：</td>
			<td class="FieldInput" style="width:14%"><label field="REPLACE_NUM" renderer="gRender"/></td>
			<td class="FieldLabel" style="width:18%">设立分会场数：</td>
			<td class="FieldInput" style="width:14%"><label field="SUB_NUM" renderer="gRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel">投票箱总数：</td>
			<td class="FieldInput"><label field="BOX_NUM" renderer="gRender"/></td>
			<td class="FieldLabel">秘密写票处：</td>
			<td class="FieldInput" colspan="3"><label field="SECRET_NUM" renderer="gRender"/></td>
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
	electionVoteDataSet.setParameter("tableName","CDC_ELECTION_VOTE_SUM");
	electionVoteDataSet.setParameter("organCode",organC);
	electionVoteDataSet.setParameter("reportDate",reportDate);
	electionVoteDataSet.on("load",function(){
		var nominate = electionVoteDataSet.getCurrent();
		if(nominate==null){
			electionVoteDataSet.newRecord({"ORGAN_NAME":organC,"REPORT_DATE":reportDate});
		}
	});
	electionVoteDataSet.load();
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
function gRender(val){
	if(val!=""){
		return val+" 个";
	}
}
</script>