<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>社区自然状况填报</title>
<next:ScriptManager/>
</head>
<body>
<model:datasets>
	<model:dataset id="naturalReportDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcNatureReportQueryCmd" pageSize="20">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcNatureReport"/>
	</model:dataset>
	<model:dataset id="naturalDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcNatureInfoQueryCmd" pageSize="20">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcNatureInfo"/>
	</model:dataset>
	<model:dataset id="reportWorkDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcReportWorkQueryCmd" method="getDic" global="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"/>
		<model:params>
			<model:param name="reportType" value='R02'/>
			<model:param name="organType" value='N'/>
		</model:params>
	</model:dataset>
	<model:dataset id="livingStatusDataSet" enumName="CDC.LIVING.STATUS" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="geographyConditionDataSet" enumName="CDC.GEOGRAPHY.CONDITION" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:Panel width="100%" autoScroll="true">
<next:TopBar>
	<next:ToolBarItem symbol="->"/>
	<next:ToolBarItem iconCls="return" text="返回" handler="returnBack"/>
</next:TopBar>
<next:Html>
<form id="form2" method="post" dataset="naturalReportDataSet" onsubmit="return false" class="L5form">
<fieldset id="cdcFieldset">
<legend>填报情况</legend>
	<table width="100%">
		<tr>
			<tr>
			<td class="FieldLabel" style="width:18%">填报单位：</td>
			<td class="FieldInput" style="width:18%"><label field="organName"/></td>
			<td class="FieldLabel" style="width:16%">填报日期：</td>
			<td class="FieldInput" style="width:16%"><label field="reportDate" dataset="reportWorkDataSet"/><font color="red">*</font></td>
		</tr>
	</table>
</fieldset>
</form>
<form id="form1" method="post" dataset="naturalDataSet" onsubmit="return false" class="L5form">
<fieldset id="cdcFieldsets">
<legend>社区自然状况</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:18%">自然村个数：</td>
			<td class="FieldInput" style="width:18%"><label id="villageNum" field ="villageNum"   maxlength="30" style="width:90%" renderer="gRender" /></td>
			<td class="FieldLabel" style="width:16%">村民小组数：</td>
			<td class="FieldInput" style="width:16%"><label id="groupNum" field ="groupNum"   maxlength="30" style="width:90%" renderer="gRender" /></td>
		</tr>
		<tr>
			<td class="FieldLabel" >辖区总面积：</td>
			<td class="FieldInput" ><label id="totalArea" field ="totalArea"   maxlength="30" style="width:90%" renderer="kmRender"/></td>
			<td class="FieldLabel" >耕地面积：</td>
			<td class="FieldInput" ><label id="ploughArea" field ="ploughArea"   maxlength="30" renderer="jRender" style="width:90%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" >居住状况：</td>
			<td class="FieldInput" ><label id="resideStatus" field ="resideStatus" dataset = "livingStatusDataSet" /></td>
			<td class="FieldLabel" >宅基地总面积：</td>
			<td class="FieldInput" ><label id="houseArea" field ="houseArea"   maxlength="30" style="width:90%" renderer="jRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" >地理状况：</td>
			<td class="FieldInput" colspan="3"><label id="geographyStatus" field ="geographyStatus" dataset = "geographyConditionDataSet"/></td>
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
	var naturalReportDataSet=L5.DatasetMgr.lookup("naturalReportDataSet");
	var naturalDataSet=L5.DatasetMgr.lookup("naturalDataSet");
	var reportWorkDataSet=L5.DatasetMgr.lookup("reportWorkDataSet");
	reportWorkDataSet.load();
	naturalReportDataSet.setParameter("RECORD_ID@=",'<%=request.getParameter("recordId")%>');
	naturalReportDataSet.load();
	naturalDataSet.setParameter("RECORD_ID@=",'<%=request.getParameter("recordId")%>');
	naturalDataSet.load();
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
function gRender(val){
	if(val!="")
	return val+" 个";
}
function jRender(val){
	if(val!="")
	return val+" 亩";
}

function aRender(val){
	if(val!="")
	return val+" ㎡";
}
function kmRender(val){
	if(val!="")
	return val+" 平方公里";
}
</script>