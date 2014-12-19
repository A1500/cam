<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>农村社区规划填报</title>
<next:ScriptManager/>
<script type="text/javascript" src="vcdcConstructInfoEdit.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript">
	var method='<%=request.getParameter("method")%>';
	var recordId='<%=request.getParameter("recordId")%>';
</script>
<jsp:include page="../util/cdcOrgan.jsp" flush="true"/>
</head>
<body>
<model:datasets>
	<model:dataset id="infoDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcConstructInfoQueryCmd" pageSize="20">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcConstructInfo"/>
	</model:dataset>
	<model:dataset id="reportDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcConstructReportQueryCmd" pageSize="20">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcConstructReport"/>
	</model:dataset>
	<model:dataset id="reportWorkDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcReportWorkQueryCmd" method="getDic" global="true">
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
	<next:ToolBarItem iconCls="add" text="历史数据回填" id="backInsert" handler="forInsert"/>
	<next:ToolBarItem iconCls="save" text="保存" handler="save"/>
	<next:ToolBarItem iconCls="return" text="返回" handler="returnBack"/>
</next:TopBar>
<next:Html>
<form id="form1" method="post" dataset="reportDataSet" onsubmit="return false" class="L5form">
<fieldset id="cdcFieldset">
<legend>填报情况</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:18%">填报单位：</td>
			<td class="FieldInput" style="width:36%"><label field="organName"/></td>
			<td class="FieldLabel" style="width:16%">填报日期：</td>
			<td class="FieldInput" style="width:30%"><select id="reportDate" field="reportDate"><option dataset="reportWorkDataSet"/></select><font color="red">*</font></td>
		</tr>
	</table>
</fieldset>
</form>
<form id="form2" method="post" dataset="infoDataSet" onsubmit="return false" class="L5form">
<fieldset id="cdcFieldset">
<legend>社区规划情况</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel"  rowspan="6" nowrap="nowrap">建设规划：</td>
			<td class="FieldLabel" colspan="2">是否集中居住：</td>
			<td class="FieldInput" style="width: 20%" ><select name = "是否集中居住" id = "ifCollect" field = "ifCollect" ><option dataset = "YorN"></option> </select><font color="red">*</font>  </td>
			<td class="FieldLabel" nowrap="nowrap">规划集中居住区面积：</td>
			<td class="FieldInput" style="width: 20%" ><input type="text" name = "规划集中居住区面积"  id="planArea" field="planArea"  maxlength="30" onchange="fordecimalcheck(this)" />&nbsp;㎡ <font color="red">*</font> </td>
			<td class="FieldLabel" nowrap="nowrap">已建成集中居住区面积：</td>
			<td class="FieldInput" style="width: 20%" ><input type="text" name = "已建成集中居住区面积" id="alreadyArea" field="alreadyArea"  maxlength="30" onchange="fordecimalcheck(this)" />&nbsp;㎡ <font color="red">*</font></td>
		</tr>
		<tr>
			<td class="FieldLabel"  colspan="2">计划入住户数：</td>
			<td class="FieldInput" style="width: 20%" ><input type="text" name = "计划入住户数" id="populateNum" field="populateNum"  maxlength="30" onchange="forcheck(this)" />&nbsp;户 <font color="red">*</font></td>
			<td class="FieldLabel" >已入住户数：</td>
			<td class="FieldInput" colspan="3" style="width: 20%" ><input type="text" name = "已入住户数" id="alreadyPopulateNum" field="alreadyPopulateNum"  maxlength="30" onchange="forcheck(this)" />&nbsp;户 <font color="red">*</font></td>
	
		</tr>
		<tr>
			<td class="FieldLabel"  colspan="2">计划入住人数：</td>
			<td class="FieldInput" style="width: 20%" ><input type="text" name = "计划入住人数" id="peopleNum" field="peopleNum"  maxlength="30" onchange="forcheck(this)" />&nbsp;人 <font color="red">*</font></td>
			<td class="FieldLabel" >已入住人数：</td>
			<td class="FieldInput" colspan="3" style="width: 20%" ><input type="text" name = "已入住人数" id="alreadyPeopleNum" field="alreadyPeopleNum"  maxlength="30" onchange="forcheck(this)" />&nbsp;人 <font color="red">*</font></td>
		</tr>
		<tr>
			<td class="FieldLabel"  colspan="2">投入资金：</td>
			<td class="FieldInput" style="width: 20%" colspan="5"><label  id="investMon" field="investMon" maxlength="30"  renderer="reRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel"  rowspan="2" nowrap="nowrap">资金来源：</td>
			<td class="FieldLabel"  >财政投入：</td>
			<td class="FieldInput" style="width: 20%" ><input type="text" name = "财政投入" id="investFinanceMon" field="investFinanceMon" maxlength="30" onchange="forInvestCheck(this)" />&nbsp;万元 <font color="red">*</font></td>
			<td class="FieldLabel" >开发商：</td>
			<td class="FieldInput" style="width: 20%" ><input type="text" name = "开发商投入" id="investDeveloperMon" field="investDeveloperMon" maxlength="30" onchange="forInvestCheck(this)" />&nbsp;万元 <font color="red">*</font></td>
			<td class="FieldLabel" >银行贷款：</td>
			<td class="FieldInput" style="width: 20%" style="width: 20"><input type="text" name = "银行贷款" id="investBankMon" field="investBankMon" maxlength="30" onchange="forInvestCheck(this)"  />&nbsp;万元 <font color="red">*</font></td>
		</tr>
		<tr>
			<td class="FieldLabel"  nowrap="nowrap">村集体投入：</td>
			<td class="FieldInput" style="width: 20%"><input type="text" name = "村集体投入" id="investResiderMon" field="investResiderMon" maxlength="30" onchange="forInvestCheck(this)" />&nbsp;万元 <font color="red">*</font></td>
			<td class="FieldLabel" >其他：</td>
			<td class="FieldInput" colspan="3" style="width: 20%"><input type="text" name = "其他投入" id="investOtherMon" field="investOtherMon" maxlength="30" onchange="forInvestCheck(this)" />&nbsp;万元 <font color="red">*</font></td>
		</tr>
		<tr>
			<td class="FieldLabel"  rowspan="3" nowrap="nowrap">服务中心建设规划：</td>
			<td class="FieldLabel"  colspan="2">投入资金：</td>
			<td class="FieldInput" style="width: 20%"><label field="serviceMon" renderer="reRender" /></td>
			<td class="FieldLabel" nowrap="nowrap">是否在中心村：</td>
			<td class="FieldInput" style="width: 20%"><select name = "是否在中心村" id = "serviceIfCollect" field = "serviceIfCollect" ><option dataset = "YorN"></option> </select> <font color="red">*</font></td>
			<td class="FieldLabel" >建筑面积：</td>
			<td class="FieldInput" style="width: 20%"><input type="text" name = "建筑面积" id="serviceArea" field="serviceArea" maxlength="30" onchange="fordecimalcheck(this)" />&nbsp;㎡ <font color="red">*</font></td>
		</tr>
		<tr>
			<td class="FieldLabel"  rowspan="2" nowrap="nowrap">资金来源：</td>
			<td class="FieldLabel"  >财政投入：</td>
			<td class="FieldInput" style="width: 20%"><input type="text" name = "财政投入" id="serviceFinanceMon" field="serviceFinanceMon" maxlength="30" onchange="forServiceCheck(this)" />&nbsp;万元 <font color="red">*</font></td>
			<td class="FieldLabel" >自筹：</td>
			<td class="FieldInput" colspan="3" style="width: 20%"><input type="text" name = "自筹" id="serviceSelfMon" field="serviceSelfMon" maxlength="30" onchange="forServiceCheck(this)" />&nbsp;万元 <font color="red">*</font></td>
		</tr>
		<tr>
			<td class="FieldLabel"  >社会捐赠：</td>
			<td class="FieldInput" style="width: 20%"><input type="text" name = "社会捐赠" id="serviceEndowMon" field="serviceEndowMon" maxlength="30" onchange="forServiceCheck(this)" />&nbsp;万元 <font color="red">*</font></td>
			<td class="FieldLabel" >其他：</td>
			<td class="FieldInput" colspan="3" style="width: 20%"><input type="text" name = "其他" id="serviceOtherMon" field="serviceOtherMon" maxlength="30" onchange="forServiceCheck(this)" />&nbsp;万元 <font color="red">*</font></td>
		</tr>
	</table>
</fieldset>
</form>
</next:Html>
</next:Panel>
</body>
</html>