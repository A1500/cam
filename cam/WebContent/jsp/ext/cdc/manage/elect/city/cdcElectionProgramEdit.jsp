<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<script type="text/javascript">
</script>
<title>城市民主选举选举程序信息</title>
<next:ScriptManager/>
<script type="text/javascript">
	var reportTime='<%=request.getParameter("reportTime")%>';
	var recordId='<%=request.getParameter("recordId")%>';
</script>
<script type="text/javascript" src="cdcElectionProgramEdit.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<jsp:include page="../../util/cdcOrgan.jsp" flush="true"/>
</head>
<body>
<model:datasets>
	<model:dataset id="electionProgramDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcElectionProgramQueryCmd" pageSize="20">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcElectionProgram"/>
	</model:dataset>
	<model:dataset id="electionProgram2DataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcElectionProgramQueryCmd" pageSize="20">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcElectionProgram"/>
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
	<next:ToolBarItem iconCls="add" text="历史数据回填" id="backInsert" handler="forInsert"/>
	<next:ToolBarItem iconCls="save" text="保存" handler="save"/>
</next:TopBar>
<next:Html>
<form id="form1" method="post" dataset="electionProgramDataSet" onsubmit="return false" class="L5form">
<fieldset id="cdcFieldset">
<legend>填报情况</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:18%">填报单位：</td>
			<td class="FieldInput" style="width:27%"><label field="organName"/></td>
			<td class="FieldLabel" style="width:13%">填报日期：</td>
			<td class="FieldInput" style="width:42%"><label id="reportDate" field="reportDate" dataset="reportWorkDataSet"/></td>
		</tr>
	</table>
</fieldset>
<fieldset id="cdcFieldset">
<legend>选举程序信息</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:13%">是否召开选举大会集中投票：</td>
			<td class="FieldInput" style="width:14%"><select name = "是否召开选举大会集中投票"  id="ifMeeting" field ="ifMeeting"><option dataset = "YorN"></option> </select> </td>
			<td class="FieldLabel" style="width:13%">是否设投票中心：</td>
			<td class="FieldInput" style="width:14%"><select name = "是否设投票中心"  id="ifStation" field ="ifStation"><option dataset = "YorN"></option> </select> </td>
			<td class="FieldLabel" style="width:13%">是否设秘密写票处：</td>
			<td class="FieldInput" style="width:15%"><select name = "是否设秘密写票处"  id="ifSecret" field ="ifSecret"><option dataset = "YorN"></option> </select> </td>
		</tr>
		<tr>
			<td class="FieldLabel">是否设流动投票箱：</td>
			<td class="FieldInput"><select name = "是否设流动投票箱"  id="ifFlow" field ="ifFlow"><option dataset = "YorN"></option> </select> </td>
			<td class="FieldLabel">是否公开唱票：</td>
			<td class="FieldInput"><select name = "是否公开唱票"  id="ifPublic" field ="ifPublic"><option dataset = "YorN"></option> </select> </td>
			<td class="FieldLabel">是否当场公布选举结果：</td>
			<td class="FieldInput"><select name = "是否当场公布选举结果"  id="ifPublicResult" field ="ifPublicResult"><option dataset = "YorN"></option> </select> </td>
		</tr>
	</table>
</fieldset>
</form>
</next:Html>
</next:Panel>
</body>
</html>