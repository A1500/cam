<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>城市资产状况填报</title>
<next:ScriptManager/>
<script type="text/javascript" src="cdcEconomyInfoEdit.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript">
	var method='<%=request.getParameter("method")%>';
	var recordId='<%=request.getParameter("recordId")%>';
</script>
<jsp:include page="../util/cdcOrgan.jsp" flush="true"/>
</head>
<body>
<model:datasets>
	<model:dataset id="economyDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcEconomyInfoQueryCmd" >
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcEconomyInfo"/>
	</model:dataset>
	<model:dataset id="YorN" enumName="COMM.YESORNO" autoLoad="true" global="true" />
	<model:dataset id="reportWorkDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcReportWorkQueryCmd" method="getDic" global="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"/>
		<model:params>
			<model:param name="reportType" value='R03'/>
			<model:param name="organType" value='C'/>
		</model:params>
	</model:dataset>
</model:datasets>
<next:Panel width="100%" autoScroll="true">
<next:TopBar>
	<next:ToolBarItem symbol="->"/>
	<next:ToolBarItem iconCls="add" text="历史数据回填" id="backInsert" handler="forInsert"/>
	<next:ToolBarItem iconCls="save" text="保存" handler="save"/>
	<next:ToolBarItem iconCls="return" text="返回" handler="returnBack"/>
</next:TopBar>
<next:Html>
<form id="form1" method="post" dataset="economyDataSet" onsubmit="return false" class="L5form">
<fieldset id="cdcFieldset">
<legend>填报情况</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:18%">填报单位：</td>
			<td class="FieldInput" style="width:27%"><label field="organName"/></td>
			<td class="FieldLabel" style="width:13%">填报日期：</td>
			<td class="FieldInput" style="width:42%"><select id="reportDate" field="reportDate"><option dataset="reportWorkDataSet"/></select><font color="red">*</font></td>
		</tr>
	</table>
</fieldset>
<fieldset id="cdcFieldset">
<legend>资产状况</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="text-align:center;width:15%" rowspan="3">资产状况</td>
			<td class="FieldLabel" style="width:13%">收入总额：</td>
			<td class="FieldInput" style="width:15%"><input type="text" name = "收入总额" id="incomeMon" field="incomeMon" onchange="fornegcheck(this)" maxlength="30" />&nbsp;万元<font color="red">*</font></td>
			<td class="FieldLabel" style="width:13%">债权总额：</td>
			<td class="FieldInput" style="width:15%"><input type="text" name = "债权总额" id="claimMon" field="claimMon" onchange="fornegcheck(this)" maxlength="30" />&nbsp;万元<font color="red">*</font></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:13%">债务总额：</td>
			<td class="FieldInput" style="width:15%"><input type="text" name = "债务总额" id="debtMon" field="debtMon" onchange="fornegcheck(this)" maxlength="30" />&nbsp;万元<font color="red">*</font></td>
			<td class="FieldLabel">固定资产总值（除办公服务用房之外）：</td>
			<td class="FieldInput"><input type="text" id="fixedMon" name = "固定资产总值" field="fixedMon" maxlength="30" onchange="fordecimalcheck(this)" />&nbsp;万元<font color="red">*</font></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:13%" >是否负资产：</td>
			<td class="FieldInput" colspan="3" ><label field = "ifNegative" dataset = "YorN"  /></td>
		</tr>
	</table>
</fieldset>
</form>
</next:Html>
</next:Panel>
</body>
</html>