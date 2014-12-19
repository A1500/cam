<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>农村经济基本情况</title>
<next:ScriptManager/>
</head>
<body>
<model:datasets>
	<model:dataset id="infoDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcFinanceInfoQueryCmd" pageSize="20">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcFinanceInfo"/>
	</model:dataset>
	<model:dataset id="reportWorkDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcReportWorkQueryCmd" method="getDic" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"/>
		<model:params>
			<model:param name="reportType" value='R19'/>
			<model:param name="organType" value='N'/>
		</model:params>
	</model:dataset>
</model:datasets>
<next:Panel width="100%" autoScroll="true">
<next:TopBar>
	<next:ToolBarItem symbol="->"/>
	<next:ToolBarItem iconCls="return" text="返回" handler="returnBack"/>
</next:TopBar>
<next:Html>
<form id="form1" method="post" dataset="infoDataSet" onsubmit="return false" class="L5form">
<fieldset id="cdcFieldset">
<legend>填报情况</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel">填报单位：</td>
			<td class="FieldInput" colspan="3"><label field="organName"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">填报日期：</td>
			<td class="FieldInput" style="width:36%"><label field="reportDate" dataset="reportWorkDataSet"/></td>
			<td class="FieldLabel" style="width:16%">上报日期：</td>
			<td class="FieldInput" style="width:30%"><label field="submitDate"/></td>
		</tr>
	</table>
</fieldset>
<fieldset id="cdcFieldset">
<legend>经济基本情况</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:18%">年度：</td>
			<td class="FieldInput" style="width:36%"><label id="yearly" field="yearly"  /></td>
			<td class="FieldLabel" style="width:16%"></td>
			<td class="FieldInput" style="width:30%"></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">生产总值：</td>
			<td class="FieldInput" style="width:36%"><label id="gdpMon" field="gdpMon" renderer="reRender" /></td>
			<td class="FieldLabel" style="width:16%">农业产值：</td>
			<td class="FieldInput" style="width:36%"><label id="agricultureMon" field="agricultureMon" renderer="reRender" /></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">人均收入：</td>
			<td class="FieldInput" style="width:36%"><label id="personMon" field="personMon" renderer="peRender" /></td>
			<td class="FieldLabel" style="width:16%">财政收入：</td>
			<td class="FieldInput" style="width:36%"><label id="financeMon" field="financeMon" renderer="reRender" /></td>
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
	var ds=L5.DatasetMgr.lookup("infoDataSet");
	ds.setParameter("FINANCEID@=",'<%=request.getParameter("recordId")%>');
	ds.load();
}
function returnBack(){
	history.go(-1);
}
function reRender(val){
	if(val ==""){
		return "0 万元";
	}else{
		return val+" 万元";
	}
}
function peRender(val){
	if(val ==""){
		return "0 元";
	}else{
		return val+" 元";
	}
}
</script>