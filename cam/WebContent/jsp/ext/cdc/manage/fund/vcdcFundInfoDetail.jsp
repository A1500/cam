<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>农村社区经费情况填报</title>
<next:ScriptManager/>
</head>
<body>
<model:datasets>
	<model:dataset id="fundDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcFundInfoQueryCmd" pageSize="20">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcFundInfo"/>
	</model:dataset>
	<model:dataset id="reportWorkDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcReportWorkQueryCmd" method="getDic" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"/>
		<model:params>
			<model:param name="reportType" value='R05'/>
			<model:param name="organType" value='C'/>
		</model:params>
	</model:dataset>
</model:datasets>
<next:Panel width="100%" autoScroll="true">
<next:TopBar>
	<next:ToolBarItem symbol="->"/>
	<next:ToolBarItem iconCls="return" text="返回" handler="returnBack"/>
</next:TopBar>
<next:Html>
<form id="form1" method="post" dataset="fundDataSet" onsubmit="return false" class="L5form">
<fieldset id="cdcFieldset">
<legend>填报情况</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel">填报单位：</td>
			<td class="FieldInput" colspan="3"><label field="organName"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:36%">填报日期：</td>
			<td class="FieldInput" style="width:20%"><label field="reportDate" dataset="reportWorkDataSet"/></td>
			<td class="FieldLabel" style="width:24%">上报日期：</td>
			<td class="FieldInput" style="width:20%"><label field="submitDate"/></td>
		</tr>
	</table>
</fieldset>
<fieldset id="cdcFieldset">
<legend>社区经费情况</legend>
	<table border="1"  width="100%" >
	   		<tr>
	   			<td class="FieldLabel" style="width:18%" rowspan="3" >社区年度办公经费</td>
				<td class="FieldLabel" style="width:18%" colspan="2" >办公经费总额</td>
				<td class="FieldInput" style="width:20%" colspan="3" ><label  field="offMon" renderer="reRender"/> </td>
			</tr>
	   		<tr>
	   			<td class="FieldLabel"  rowspan="2">办公经费来源</td>
				<td class="FieldLabel" >财政拨款</td>
				<td class="FieldInput" style="width:20%"><label id="offFinanceMon" field="offFinanceMon" renderer="reRender"/> </td>
			
				<td class="FieldLabel" style="width:24%">自筹</td>
				<td class="FieldInput" ><label id="offSelfMon" field="offSelfMon"  renderer="reRender"/> </td>
			</tr>
	   		<tr>
				<td class="FieldLabel" >社会捐助</td>
				<td class="FieldInput"><label id="offEnbowMon" field="offEnbowMon" renderer="reRender"/> </td>
			
				<td class="FieldLabel" >其他</td>
				<td class="FieldInput"><label id="offOtherMon" field="offOtherMon"  renderer="reRender"/> </td>
			</tr>
	   		<tr>
	   			<td class="FieldLabel" rowspan="5" >社区年度专项经费</td>
				<td class="FieldLabel" colspan="2">专项经费总额</td>
				<td class="FieldInput" colspan="3"><label id="sepMon" field="sepMon" renderer="reRender" /> </td>
			</tr>
	   		<tr>
	   			<td class="FieldLabel"  rowspan="2">专项经费来源</td>
				<td class="FieldLabel" >财政拨款</td>
				<td class="FieldInput"><label id="sepFinanceMon" field="sepFinanceMon"   renderer="reRender"/> </td>
			
				<td class="FieldLabel" >自筹</td>
				<td class="FieldInput"><label id="sepSelfMon" field="sepSelfMon"  renderer="reRender"/> </td>
			</tr>
	   		<tr>
				<td class="FieldLabel" >社会捐助</td>
				<td class="FieldInput"><label id="sepEnbowMon" field="sepEnbowMon"  renderer="reRender"/> </td>
			
				<td class="FieldLabel" >其他</td>
				<td class="FieldInput"><label id="sepOtherMon" field="sepOtherMon"  renderer="reRender"/> </td>
			</tr>
	   		<tr>
	   			<td class="FieldLabel"  rowspan="2">专项经费用途</td>
				<td class="FieldLabel" >基础设施建设</td>
				<td class="FieldInput"><label id="useBuildMon" field="useBuildMon"  renderer="reRender"/> </td>
			
				<td class="FieldLabel" >各项活动</td>
				<td class="FieldInput"><label id="useActionMon" field="useActionMon"  renderer="reRender"/> </td>
			</tr>
	   		<tr>
				<td class="FieldLabel" >购买服务</td>
				<td class="FieldInput"><label id="useServiceMon" field="useServiceMon"  renderer="reRender"/> </td>
			
				<td class="FieldLabel" >其他</td>
				<td class="FieldInput"><label id="useOtherMon" field="useOtherMon" renderer="reRender" /> </td>
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
	var ds=L5.DatasetMgr.lookup("fundDataSet");
	ds.setParameter("FUND_ID@=",'<%=request.getParameter("fundId")%>');
	ds.load();
}
function returnBack(){
	history.go(-1);
}
function reRender(val){
	if(val==''){
	return "0 万元";
	}
	return val+" 万元";
}
</script>