<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<script type="text/javascript">
</script>
<title>城市民主选举选举准备情况</title>
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
	<model:dataset id="electionPrepareDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcElectionPrepareQueryCmd" pageSize="20">
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
	<model:dataset id="electionMannerDs" enumName="CDC.ELECTION_MANNER_CITY" autoLoad="true" global="true" />
</model:datasets>
<next:Panel width="99%" autoScroll="true">
<next:TopBar>
	<next:ToolBarItem symbol="->"/>
</next:TopBar>
<next:Html>
<form id="form1" method="post" dataset="electionPrepareDataSet" onsubmit="return false" class="L5form">
<fieldset id="cdcFieldset">
<legend>填报情况</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:18%">填报单位：</td>
			<td class="FieldInput" style="width:27%"><label field="organName"/></td>
			<td class="FieldLabel" style="width:13%">填报日期：</td>
			<td class="FieldInput" style="width:42%"><label id="reportDate" field="reportDate"  dataset="reportWorkDataSet"/></td>
		</tr>
	</table>
</fieldset>
<fieldset id="cdcFieldset">
<legend>选举准备信息</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:18%">选民总数：</td>
			<td class="FieldInput" style="width:14%"><label id="villagerNum" field="villagerNum" maxlength="30" /></td>
			<td class="FieldLabel" style="width:18%">本届登记选民登记总数：</td>
			<td class="FieldInput" style="width:14%"><label id="joinVillagerNum" field="joinVillagerNum" maxlength="30" /></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">女性人数：</td>
			<td class="FieldInput" style="width:14%"><label id="eleFemaleNum" field="eleFemaleNum" maxlength="30" /></td>
			<td class="FieldLabel" style="width:18%">少数民族人数：</td>
			<td class="FieldInput" style="width:14%"><label id="eleFolkNum" field="eleFolkNum" maxlength="30" /></td>
		</tr>
	</table>
</fieldset>
<fieldset id="cdcFieldset">
<legend>选举委员会信息</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:18%">产生方式：</td>
			<td class="FieldInput" style="width:30%" colspan="3"><label id = "electionManner" field = "electionManner" dataset="electionMannerDs"></label> </td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">总人数：</td>
			<td class="FieldInput" style="width:14%"><label id="eleComNum" field="eleComNum" maxlength="30" /></td>
			<td class="FieldLabel" style="width:18%">党员人数</td>
			<td class="FieldInput" style="width:14%"><label id="eleComPartyNum" field="eleComPartyNum" maxlength="30" /></td>
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
	var reportWorkDataSet=L5.DatasetMgr.lookup("reportWorkDataSet");
	reportWorkDataSet.load();
	electionPrepareDataSet.setParameter("RECORD_ID@=",'<%=request.getParameter("recordId")%>');
	electionPrepareDataSet.on("load",function(){
		var nominate = electionPrepareDataSet.getCurrent();
		if(nominate==null){
			electionPrepareDataSet.newRecord({"organCode":organCode,"organName":organName,"parentCode":parentCode,
			"reportType":"C","recordId":recordId});
		}
	});
	electionPrepareDataSet.load();
	reportWorkDataSet.load();
}
function returnBack(){
	history.go(-1);
}
</script>