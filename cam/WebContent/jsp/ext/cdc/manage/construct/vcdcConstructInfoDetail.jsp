<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>农村社区规划填报</title>
<next:ScriptManager/>
</head>
<body>
<model:datasets>
	<model:dataset id="infoDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcConstructInfoQueryCmd" pageSize="20">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcConstructInfo"/>
	</model:dataset>
	<model:dataset id="reportDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcConstructReportQueryCmd" pageSize="20">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcConstructReport"/>
	</model:dataset>
	<model:dataset id="reportWorkDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcReportWorkQueryCmd" method="getDic" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"/>
		<model:params>
			<model:param name="reportType" value='R22'/>
			<model:param name="organType" value='N'/>
		</model:params>
	</model:dataset>
	<model:dataset id="YorN" enumName="COMM.YESORNO" autoLoad="true" global="true" />
</model:datasets>
<next:Panel width="100%" autoScroll="true">
<next:TopBar>
	<next:ToolBarItem symbol="->"/>
	<next:ToolBarItem iconCls="return" text="返回" handler="returnBack"/>
</next:TopBar>
<next:Html>
<form id="form1" method="post" dataset="reportDataSet" onsubmit="return false" class="L5form">
<fieldset id="cdcFieldset">
<legend>填报情况</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" >填报单位：</td>
			<td class="FieldInput" ><label field="organName"/></td>
			<td class="FieldLabel" >填报日期：</td>
			<td class="FieldInput" ><label field="reportDate"  dataset="reportWorkDataSet"/></td>
		</tr>
	</table>
</fieldset>
</form>
<form id="form2" method="post" dataset="infoDataSet" onsubmit="return false" class="L5form">
<fieldset id="cdcFieldset">
<legend>社区规划情况</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel"  rowspan="6">建设规划：</td>
			<td class="FieldLabel" colspan="2">是否集中居住：</td>
			<td class="FieldInput" style="width: 10%"><label name = "是否集中居住" id = "ifCollect" field = "ifCollect" option dataset = "YorN" /> </td>
			<td class="FieldLabel" >规划集中居住区面积：</td>
			<td class="FieldInput" style="width: 10%"><label name = "规划集中居住区面积"  id="planArea" field="planArea"  renderer="aRender" /></td>
			<td class="FieldLabel" >已建成集中居住区面积：</td>
			<td class="FieldInput" style="width: 10%"><label name = "已建成集中居住区面积" id="alreadyArea" field="alreadyArea"  renderer="aRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel"  colspan="2">计划入住户数：</td>
			<td class="FieldInput" ><label name = "计划入住户数" id="populateNum" field="populateNum" renderer="hRender" /></td>
			<td class="FieldLabel" >已入住户数：</td>
			<td class="FieldInput" colspan="3"><label name = "已入住户数" id="alreadyPopulateNum" field="alreadyPopulateNum"  renderer="hRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel"  colspan="2">计划入住人数：</td>
			<td class="FieldInput" ><label name = "计划入住人数" id="peopleNum" field="peopleNum" renderer="peRender"  /></td>
			<td class="FieldLabel" >已入住人数：</td>
			<td class="FieldInput" ><label name = "已入住人数" id="alreadyPeopleNum" field="alreadyPeopleNum" renderer="peRender"   /></td>
			<td class="FieldLabel" ></td>
			<td class="FieldInput" ></td>
		</tr>
		<tr>
			<td class="FieldLabel"  colspan="2">投入资金：</td>
			<td class="FieldInput" colspan="5"><label name = "投入资金" id="investMon" field="investMon" renderer="reRender" /></td>
		</tr>
		<tr>
			<td class="FieldLabel"  rowspan="2">资金来源：</td>
			<td class="FieldLabel"  >财政投入：</td>
			<td class="FieldInput" ><label name = "财政投入" id="investFinanceMon" field="investFinanceMon" renderer="reRender"  /></td>
			<td class="FieldLabel" >开发商：</td>
			<td class="FieldInput" ><label name = "开发商" id="investDeveloperMon" field="investDeveloperMon" renderer="reRender" /></td>
			<td class="FieldLabel" >银行贷款：</td>
			<td class="FieldInput" ><label name = "银行贷款" id="investBankMon" field="investBankMon" renderer="reRender"  /></td>
		</tr>
		<tr>
			<td class="FieldLabel"  >村集体投入：</td>
			<td class="FieldInput" ><label name = "村集体投入" id="investResiderMon" field="investResiderMon" renderer="reRender" /></td>
			<td class="FieldLabel" >其他：</td>
			<td class="FieldInput" ><label name = "其他" id="investOtherMon" field="investOtherMon" renderer="reRender"  /></td>
			<td class="FieldLabel" ></td>
			<td class="FieldInput" ></td>
		</tr>
		<tr>
			<td class="FieldLabel"  rowspan="3">服务中心建设规划：</td>
			<td class="FieldLabel"  colspan="2">建筑面积：</td>
			<td class="FieldInput" ><label name = "建筑面积" id="serviceArea" field="serviceArea" renderer="aRender" /></td>
			<td class="FieldLabel" >是否在中心村：</td>
			<td class="FieldInput" ><label name = "是否在中心村" id = "serviceIfCollect" field = "serviceIfCollect" dataset = "YorN" /></td>
			<td class="FieldLabel" >投入资金：</td>
			<td class="FieldInput" ><label name = "投入资金" id="serviceMon" field="serviceMon" renderer="reRender"  /></td>
		</tr>
		<tr>
			<td class="FieldLabel"  rowspan="2">资金来源：</td>
			<td class="FieldLabel"  >财政投入：</td>
			<td class="FieldInput" ><label name = "财政投入" id="serviceFinanceMon" field="serviceFinanceMon" renderer="reRender"  /></td>
			<td class="FieldLabel" >自筹：</td>
			<td class="FieldInput" ><label name = "自筹" id="serviceSelfMon" field="serviceSelfMon" renderer="reRender"  /></td>
			<td class="FieldLabel" ></td>
			<td class="FieldInput" ></td>
		</tr>
		<tr>
			<td class="FieldLabel"  >社会捐赠：</td>
			<td class="FieldInput" ><label name = "社会捐赠" id="serviceEndowMon" field="serviceEndowMon" renderer="reRender"  /></td>
			<td class="FieldLabel" >其他：</td>
			<td class="FieldInput" ><label name = "其他" id="serviceOtherMon" field="serviceOtherMon" renderer="reRender"  /></td>
			<td class="FieldLabel" ></td>
			<td class="FieldInput" ></td>
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
	var infoDataSet=L5.DatasetMgr.lookup("infoDataSet");
	infoDataSet.setParameter("RECORD_ID@=",'<%=request.getParameter("recordId")%>');
	infoDataSet.load();
	var reportDataSet=L5.DatasetMgr.lookup("reportDataSet");
	reportDataSet.setParameter("RECORD_ID@=",'<%=request.getParameter("recordId")%>');
	reportDataSet.load();
}
function returnBack(){
	history.go(-1);
}
function reRender(val){
	if(val!="")
	return val+" 万元";
}
function mRender(val){
	if(val!="")
	return val+" 元";
}
function hRender(val){
	if(val!="")
	return val+" 户";
}
function aRender(val){
	if(val!="")
	return val+" ㎡";
}
function peRender(val){
	if(val !="")
	return val+" 人";
}
</script>