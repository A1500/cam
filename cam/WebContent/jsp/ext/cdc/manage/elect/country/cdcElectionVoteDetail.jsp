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
	var recordId='<%=request.getParameter("recordId")%>';
	var organ_Code='<%=request.getParameter("organ_Code")%>';
</script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<jsp:include page="../../util/cdcOrgan.jsp" flush="true"/>
</head>
<body>
<model:datasets>
	<model:dataset id="electionVoteDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcElectionVoteQueryCmd" pageSize="20">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcElectionVote"/>
	</model:dataset>
	<model:dataset id="reportWorkDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcReportWorkQueryCmd" method="getDic" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"/>
		<model:params>
			<model:param name="reportType" value='R11'/>
			<model:param name="organType" value='N'/>
		</model:params>
	</model:dataset>
	<model:dataset id="OrgNameDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="false">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='COM_EXT_USER'></model:param>
			<model:param name="value" value='USER_ID'></model:param>
			<model:param name="text" value='USER_NAME'></model:param>
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
			<td class="FieldInput"  style="width:14%"><label field="organName"/></td>
			<td class="FieldLabel"  style="width:21%">填报日期：</td>
			<td class="FieldInput" ><label id="reportDate" field="reportDate" dataset="reportWorkDataSet"/></td>
		</tr>
	</table>
</fieldset>
<fieldset id="cdcFieldset">
<legend>投票方式、方法</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:18%">投票方式：</td>
			<td class="FieldInput" style="width:14%"><label field="voterManner" dataset="vtoerMannerDs"/></td>
			<td class="FieldLabel" style="width:18%">参加正式选举投票的村民总数：</td>
			<td class="FieldInput" style="width:14%"><label field="voterNum" renderer="rRender"/></td>
			<td class="FieldLabel" style="width:18%">委托投票人数：</td>
			<td class="FieldInput" style="width:14%"><label field="entrustNum" renderer="rRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel">使用流动票箱投票人数：</td>
			<td class="FieldInput"><label field="flowNum" renderer="gRender"/></td>
			<td class="FieldLabel">代写选票人数：</td>
			<td class="FieldInput"><label field="replaceNum" renderer="gRender"/></td>
			<td class="FieldLabel">设立分会场数：</td>
			<td class="FieldInput"><label field="subNum" renderer="gRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel">投票箱总数：</td>
			<td class="FieldInput"><label field="boxNum" renderer="gRender"/></td>
			<td class="FieldLabel">秘密写票处：</td>
			<td class="FieldInput" colspan="3"><label field="secretNum" renderer="gRender"/></td>
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
	var OrgNameDataset=L5.DatasetMgr.lookup("OrgNameDataset");
	OrgNameDataset.on("load",function() {
		orgName= OrgNameDataset.get("text");
		electionVoteDataSet.newRecord({"organCode":organ_Code,"organName":orgName,"parentCode":parentCode,
			"reportType":"N","recordId":recordId});
	});
	var electionVoteDataSet=L5.DatasetMgr.lookup("electionVoteDataSet");
	var reportWorkDataSet=L5.DatasetMgr.lookup("reportWorkDataSet");
	reportWorkDataSet.load();
	electionVoteDataSet.setParameter("RECORD_ID@=",'<%=request.getParameter("recordId")%>');
	electionVoteDataSet.on("load",function(){
		var nominate = electionVoteDataSet.getCurrent();
		if(nominate==null){
			OrgNameDataset.setParameter("filterSql","USER_ID='"+organ_Code+"'");
			OrgNameDataset.load();
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