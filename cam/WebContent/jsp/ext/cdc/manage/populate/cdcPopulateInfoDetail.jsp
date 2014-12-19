<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>社区人口状况明细</title>
<next:ScriptManager/>
</head>
<body>
<model:datasets>
	<model:dataset id="populateDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcPopulateInfoQueryCmd" pageSize="20">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcPopulateInfo"/>
	</model:dataset>
	<model:dataset id="reportWorkDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcReportWorkQueryCmd" method="getDic" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"/>
		<model:params>
			<model:param name="reportType" value='R01'/>
			<model:param name="organType" value='C'/>
		</model:params>
	</model:dataset>
</model:datasets>
<next:Panel width="99%">
<next:TopBar>
	<next:ToolBarItem symbol="->"/>
	<next:ToolBarItem iconCls="return" text="返回" handler="returnBack"/>
</next:TopBar>
<next:Html>
<form id="form1" method="post" dataset="populateDataSet" onsubmit="return false" class="L5form">
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
<legend>人口状况</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="text-align:center;width:18%" rowspan="5">人口状况</td>
			<td class="FieldLabel" style="width:13%">总户数：</td>
			<td class="FieldInput" style="width:14%"><label name = "总户数" id="populateNum" field="populateNum" maxlength="6" renderer="reRender"   /></td>
			<td class="FieldLabel" style="width:13%">总人口数：</td>
			<td class="FieldInput" style="width:14%"><label name = "总人口数" id="peopleNum" field="peopleNum" maxlength="6" renderer="peRender"  /></td>
			<td class="FieldLabel" style="width:13%">常住人口数：</td>
			<td class="FieldInput" style="width:14%"><label name = "常住人口数" id="residePeopleNum" field="residePeopleNum" maxlength="6" renderer="peRender"  /></td>
			
		</tr>
		<tr>
			
			<td class="FieldLabel">户籍人口数：</td>
			<td class="FieldInput"><label name = "户籍人口数" id="registeNum" field="registeNum" maxlength="6" renderer="peRender"  /></td>
			<td class="FieldLabel">流动人口数：</td>
			<td class="FieldInput" ><label name = "流动人口数" id="outsideNum" field="outsideNum" maxlength="6" renderer="peRender"  /></td>
			<td class="FieldLabel" >女性人口数：</td>
			<td class="FieldInput"  ><label name = "总人口数中女性人口数" id="femaleNum" field="femaleNum" maxlength="6" renderer="peRender"  /></td>
		</tr>
	</table>
</fieldset>
<fieldset name = "" id="cdcFieldset">
<legend>人户情况</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="text-align:center;width:18%" rowspan="2">人在户在</td>
			<td class="FieldLabel" style="width:13%">总人数：</td>
			<td class="FieldInput"><label name = "人在户在总人数" id="pipiNum" field="pipiNum"  maxlength="6" renderer="peRender"  /></td>
			<td class="FieldLabel" style="width:13%">儿童（14岁以下）人数:</td>
			<td class="FieldInput" ><label name = "儿童（14岁以下）人数" id="pipiFourteenNum" field="pipiFourteenNum"  maxlength="6" renderer="peRender" /></td>
			<td class="FieldLabel" style="width:13%">14-18岁人数:</td>
			<td class="FieldInput" ><label name = "14-18岁人数" id="pipiFeNum" field="pipiFeNum"  maxlength="6" renderer="peRender" /></td>
		</tr>
		<tr>
			<td class="FieldLabel">18-60岁人数:</td>
			<td class="FieldInput" ><label name = "18-60岁人数" id="pipiEsNum" field="pipiEsNum"  maxlength="6" renderer="peRender" /></td>
			<td class="FieldLabel">60岁以上人数:</td>
			<td class="FieldInput" colspan="3" ><label name = "60岁以上人数" id="pipiSixtyNum" field="pipiSixtyNum"  maxlength="6" renderer="peRender" /></td>
		</tr>
	
		<tr>
			<td class="FieldLabel" style="text-align:center;width:18%" rowspan="2" >人在户不在</td>
			<td class="FieldLabel">总人数：</td>
			<td class="FieldInput"><label name = "人在户不在总人数" id="pipoNum" field="pipoNum" maxlength="6" renderer="peRender"  /></td>
			<td class="FieldLabel">儿童（14岁以下）人数:</td>
			<td class="FieldInput" ><label name = "儿童（14岁以下）人数" id="pipiFourteenNum" field="pipiFourteenNum"  maxlength="6" renderer="peRender" /></td>
			<td class="FieldLabel">14-18岁人数:</td>
			<td class="FieldInput" ><label name = "14-18岁人数" id="pipoFeNum" field="pipoFeNum"  maxlength="6"  renderer="peRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel">18-60岁人数:</td>
			<td class="FieldInput" ><label name = "18-60岁人数" id="pipoEsNum" field="pipoEsNum"  maxlength="6" renderer="peRender" /></td>
			<td class="FieldLabel">60岁以上人数:</td>
			<td class="FieldInput" colspan="3" ><label name = "60岁以上人数" id="pipoSixtyNum" field="pipoSixtyNum"  maxlength="6" renderer="peRender" /></td>
		</tr>
	</table>
</fieldset>
<fieldset name = "" id="cdcFieldset">
<legend>其他情况</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel">党员数：</td>
			<td class="FieldInput"><label name = "党员人数" id="partyNum" field="partyNum" maxlength="6" renderer="peRender"  /></td>
			<td class="FieldLabel" style="width:13%">低保户数：</td>
			<td class="FieldInput" style="width:14%"><label name = "低保户数" id="lowestSafeguardNum" field="lowestSafeguardNum"  maxlength="6" renderer="reRender" /></td>
			<td class="FieldLabel" style="width:13%">五保户数：</td>
			<td class="FieldInput" style="width:14%"><label name = "五保户数" id="fiveSafeguardNum" field="fiveSafeguardNum"  maxlength="6" renderer="reRender" /></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:13%">残疾人数：</td>
			<td class="FieldInput" style="width:15%"><label name = "残疾人数" id="handicappedNum" field="handicappedNum"  maxlength="6" renderer="peRender" /></td>
			<td class="FieldLabel">优抚对象人数：</td>
			<td class="FieldInput"><label name = "优抚对象人数" id="preferentialNum" field="preferentialNum"  maxlength="6" renderer="peRender" /></td>
			<td class="FieldLabel">失业人员数：</td>
			<td class="FieldInput"><label name = "失业人员数" id="loseWorkNum" field="loseWorkNum" maxlength="6" renderer="peRender"  /></td>
		</tr>
		<tr>
			<td class="FieldLabel">在社区交纳养老保险人数：</td>
			<td class="FieldInput"><label name = "交纳养老保险人数" id="agedInsuranceNum" field="agedInsuranceNum"  maxlength="6" renderer="peRender" /></td>
			<td class="FieldLabel">离退休人数：</td>
			<td class="FieldInput"><label name = "离退休人数" id="retireNum" field="retireNum" maxlength="6" renderer="peRender"  /></td>
			<td class="FieldLabel">返乡大学生人数：</td>
			<td class="FieldInput"><label name = "返乡大学生人数" id="backStudentNum" field="backStudentNum"  maxlength="6" renderer="peRender" /></td>
		</tr>
		<tr>
			<td class="FieldLabel">外籍人员人数：</td>
			<td class="FieldInput"><label name = "外籍人员人数" id="foreignerNum" field="foreignerNum"  maxlength="6" renderer="peRender" /></td>
			<td class="FieldLabel">归侨归眷人数：</td>
			<td class="FieldInput"><label name = "归侨归眷人数" id="backNum" field="backNum" maxlength="6"  renderer="peRender" /></td>
			<td class="FieldLabel">社区矫正对象人数：</td>
			<td class="FieldInput"><label name = "社区矫正对象人数" id="correctNum" field="correctNum" maxlength="6" renderer="peRender" /></td>
		</tr>
		<tr>
			<td class="FieldLabel">禁毒对象人数：</td>
			<td class="FieldInput"><label name = "禁毒对象人数" id="drugNum" field="drugNum" maxlength="6" renderer="peRender"  /></td>
			<td class="FieldLabel">反邪教重点对象人数：</td>
			<td class="FieldInput" colspan="3"><label name = "反邪教重点对象人数" id="heresyNum" field="heresyNum" maxlength="6" renderer="peRender" /></td>
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
	var ds=L5.DatasetMgr.lookup("populateDataSet");
	ds.setParameter("RECORD_ID@=",'<%=request.getParameter("recordId")%>');
	ds.load();
}
function returnBack(){
	history.go(-1);
}
function reRender(val){
	if(val!="")
	return val+" 户";
}
function peRender(val){
	if(val!="")
	return val+" 人";
}
</script>