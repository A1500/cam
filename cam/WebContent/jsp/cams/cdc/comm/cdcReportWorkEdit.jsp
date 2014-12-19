<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>填报工作</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="cdcReportWork.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript">
	var method='<%=request.getParameter("method")%>';
	var workId='<%=request.getParameter("workId")%>';
</script>
</head>
<body>
<model:datasets>
	<model:dataset id="reportWorkDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcReportWorkQueryCmd" pageSize="200">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcReportWork"/>
	</model:dataset>
	<model:dataset id="reportDataSet" enumName="CDC.REPORT_ID" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:Panel width="100%" autoScroll="true">
<next:TopBar>
	<next:ToolBarItem symbol="->"/>
	<next:ToolBarItem iconCls="save" text="保存" handler="save"/>
	<next:ToolBarItem iconCls="return" text="返回" handler="returnBack"/>
</next:TopBar>
<next:Html>
<form id="form1" method="post" dataset="reportWorkDataSet" onsubmit="return false" class="L5form">
	<input type="hidden" id="workId" field=""workId""/>
<fieldset>
	<legend>填报工作</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:18%">填报内容：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="填报内容" id="reportDesc" field="reportDesc" maxlength="50" style="width:90%"/><font color="red">*</font></td>
			<td class="FieldLabel" style="width:18%">填报报表：</td>
			<td class="FieldInput" style="width:36%">
				<select id="reportId" field="reportId" onchange="reportIdChenges()">
					<option dataset="reportDataSet"/>
				</select><font color="red">*</font>
			</td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:16%">填报日期：</td>
			<td class="FieldInput" style="width:30%"><input type="text" name="填报日期" id="reportDate" field="reportDate" maxlength="30" style="width:90%"/><font color="red">*</font></td>
			<td class="FieldLabel" >农村民主选举界次：</td>
			<td class="FieldInput" ><input id ="jieci" type="text" field = "countryElectionSeason" /></td>
		</tr>
	</table>
</fieldset>
</form>
</next:Html>
</next:Panel>
</body>
</html>