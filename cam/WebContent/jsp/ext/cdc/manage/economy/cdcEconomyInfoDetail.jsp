<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>城市资产状况明细</title>
<next:ScriptManager/>
</head>
<body>
<model:datasets>
	<model:dataset id="economyDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcEconomyInfoQueryCmd" pageSize="20">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcEconomyInfo"/>
	</model:dataset>
	<model:dataset id="reportWorkDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcReportWorkQueryCmd" method="getDic" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"/>
		<model:params>
			<model:param name="reportType" value='R03'/>
			<model:param name="organType" value='C'/>
		</model:params>
	</model:dataset>
</model:datasets>
<next:Panel width="100%">
<next:TopBar>
	<next:ToolBarItem symbol="->"/>
	<next:ToolBarItem iconCls="return" text="返回" handler="returnBack"/>
</next:TopBar>
<next:Html>
<form id="form1" method="post" dataset="economyDataSet" onsubmit="return false" class="L5form">
<fieldset id="cdcFieldset">
<legend>填报情况</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel">填报单位：</td>
			<td class="FieldInput" colspan="3"><label field="organName"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">填报日期：</td>
			<td class="FieldInput" style="width:27%"><label field="reportDate" dataset="reportWorkDataSet"/></td>
			<td class="FieldLabel" style="width:13%">上报日期：</td>
			<td class="FieldInput" style="width:42%"><label field="submitDate"/></td>
		</tr>
	</table>
</fieldset>
<fieldset id="cdcFieldset">
<legend>资产状况</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="text-align:center;width:18%" rowspan="4">资产状况</td>
			<td class="FieldLabel" style="width:13%">收入总额：</td>
			<td class="FieldInput" style="width:14%"><label field="incomeMon" renderer="reRender"/></td>
			<td class="FieldLabel" style="width:13%">债权总额：</td>
			<td class="FieldInput" style="width:14%"><label field="claimMon" renderer="reRender"/></td>
			<td class="FieldLabel" style="width:13%">债务总额：</td>
			<td class="FieldInput" style="width:15%"><label field="debtMon" renderer="reRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel">固定资产总值（除办公服务用房之外）：</td>
			<td class="FieldInput" colspan="5"><label field="fixedMon" renderer="reRender"/></td>
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
	var ds=L5.DatasetMgr.lookup("economyDataSet");
	ds.setParameter("RECORD_ID@=",'<%=request.getParameter("recordId")%>');
	ds.load();
}
function returnBack(){
	history.go(-1);
}
function reRender(val){
	if(val!="")
	return val+" 万元";
}
function peRender(val){
	if(val!="")
	return val+" 元";
}
</script>