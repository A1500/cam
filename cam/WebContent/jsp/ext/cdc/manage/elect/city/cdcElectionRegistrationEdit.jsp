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
	var reportTime='<%=request.getParameter("reportTime")%>';
	var recordId='<%=request.getParameter("recordId")%>';
</script>
<script type="text/javascript" src="cdcElectionPrepareEdit.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<jsp:include page="../../util/cdcOrgan.jsp" flush="true"/>
</head>
<body>
<model:datasets>
	<model:dataset id="electionPrepareDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcElectionPrepareQueryCmd" pageSize="1">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcElectionPrepare"/>
	</model:dataset>
	<model:dataset id="electionPrepare2DataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcElectionPrepareQueryCmd" pageSize="1">
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
	<next:ToolBarItem iconCls="add" text="历史数据回填" id="backInsert" handler="forInsert"/>
	<next:ToolBarItem iconCls="save" text="保存" handler="save"/>
</next:TopBar>
<next:Html>
<form id="form1" method="post" dataset="electionPrepareDataSet" onsubmit="return false" class="L5form">
<fieldset id="cdcFieldset">
<legend>填报情况</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel"  style="width:18%">填报单位：</td>
			<td class="FieldInput"  style="width:14%"><label field="organName"/></td>
			<td class="FieldLabel"  style="width:18%">填报日期：</td>
			<td class="FieldInput"  style="width:14%"><label id="reportDate" field="reportDate" dataset="reportWorkDataSet"/></td>
		</tr>
	</table>
</fieldset>
<fieldset id="cdcFieldset">
<legend>选举准备信息</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel"  style="width:18%">选民总数：</td>
			<td class="FieldInput"  style="width:14%"><input type="text" name = "选民总数"  id="villagerNum" field="villagerNum" maxlength="30" /></td>
			<td class="FieldLabel"  style="width:18%">本届登记选民登记总数：</td>
			<td class="FieldInput" 	style="width:14%"><input type="text" name = "本届登记选民登记总数"  id="joinVillagerNum" field="joinVillagerNum" maxlength="30" /></td>
		</tr>
	</table>
</fieldset>
<fieldset id="cdcFieldset">
<legend>居民选举委员会信息</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:18%">产生方式：</td>
			<td class="FieldInput" style="width:30%" colspan="3"><select id = "electionManner" field = "electionManner"><option dataset="electionMannerDs"></option></select> </td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">总人数：</td>
			<td class="FieldInput" style="width:14%"><input type="text" name = "总人数"  id="eleComNum" field="eleComNum" maxlength="30" /></td>
			<td class="FieldLabel" style="width:18%">党员人数：</td>
			<td class="FieldInput" style="width:14%" ><input type="text" name = "党员人数"  id="eleComPartyNum" field="eleComPartyNum" maxlength="30" /></td>
		</tr>
	</table>
</fieldset>
</form>
</next:Html>
</next:Panel>
</body>
</html>