<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>农村社区自然状况填报</title>
<next:ScriptManager/>
<script type="text/javascript" src="vcdcNaturalInfoEdit.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript">
	var method='<%=request.getParameter("method")%>';
	var recordId='<%=request.getParameter("recordId")%>';
</script>
<jsp:include page="../util/cdcOrgan.jsp" flush="true"/>
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
	<next:ToolBarItem iconCls="add" text="历史数据回填" id="backInsert" handler="forInsert"/>
	<next:ToolBarItem iconCls="save" text="保存" handler="save"/>
	<next:ToolBarItem iconCls="return" text="返回" handler="returnBack"/>
</next:TopBar>
<next:Html>
<form id="form2" method="post" dataset="naturalReportDataSet" onsubmit="return false" class="L5form">
<fieldset id="cdcFieldset">
<legend>填报情况</legend>
	<table width="100%">
		<tr>
			<tr>
			<td class="FieldLabel" style="width:17%">填报单位：</td>
			<td class="FieldInput" style="width:17%"><label field="organName"/></td>
			<td class="FieldLabel" style="width:16%">填报日期：</td>
			<td class="FieldInput" style="width:16%"><select id="reportDate" field="reportDate"><option dataset="reportWorkDataSet"/></select><font color="red">*</font></td>
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
			<td class="FieldInput" style="width:18%"><input type="text" name = "自然村个数" id="villageNum" field ="villageNum" onchange="forcheck(this)" maxlength="30" />&nbsp;个 <font color="red">*</font> </td>
			<td class="FieldLabel" style="width:16%">村民小组数：</td>
			<td class="FieldInput" style="width:16%"><input type="text" name = "村民小组数" id="groupNum" field ="groupNum" onchange="forcheck(this)"  maxlength="30" />&nbsp;个 <font color="red">*</font></td>
		</tr>
		<tr>
			<td class="FieldLabel" >辖区总面积：</td>
			<td class="FieldInput" ><input type="text" name = "辖区总面积" id="totalArea" field ="totalArea" onchange="fordecimalcheck(this)"  maxlength="30" />&nbsp;平方公里 <font color="red">*</font></td>
			<td class="FieldLabel" >耕地面积：</td>
			<td class="FieldInput" ><input type="text" name = "耕地面积" id="ploughArea" field ="ploughArea" onchange="fordecimalcheck(this)"  maxlength="30" />&nbsp;亩 <font color="red">*</font></td>
		</tr>
		<tr>
			<td class="FieldLabel" >居住状况：</td>
			<td class="FieldInput" ><select name = "居住状况" id="resideStatus" field ="resideStatus"><option dataset = "livingStatusDataSet"></option></select> <font color="red">*</font></td>
			<td class="FieldLabel">宅基地总面积：</td>
			<td class="FieldInput"><input type="text" name = "宅基地总面积" id="houseArea" field ="houseArea" onchange="fordecimalcheck(this)"  maxlength="30" />&nbsp;亩 <font color="red">*</font></td>
		</tr>
		<tr>
			<td class="FieldLabel" >地理状况：</td>
			<td class="FieldInput" colspan="3"><select name = "地理状况" id="geographyStatus" field ="geographyStatus"><option dataset = "geographyConditionDataSet"></option> </select> <font color="red">*</font></td>
		</tr>
	</table>
</fieldset>
</form>
</next:Html>
</next:Panel>
</body>
</html>