<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="com.inspur.cams.comm.util.IdHelp"%>
<%
	String familyId = IdHelp.getUUID30();
	String peopleId = IdHelp.getUUID30();
%>
<html>
<head>
<title>在乡复员军人业务受理</title>
<next:ScriptManager />
		<script>
			var peopleId='<%=request.getParameter("peopleId")%>';
			var method='<%=request.getParameter("method")%>';
		</script>
<script type="text/javascript" src="demobilizedDetail.js"></script>
<script type="text/javascript" src="../comm/bptComm.js"></script>
</head>
<body>
<model:datasets>
	
	<!-- 在乡复员军人信息 -->
	<model:dataset id="PeopleDemobilizedDataset" cmd="com.inspur.cams.bpt.manage.cmd.BptPeopleDemobilizedQueryCommand" global="true" method="queryDemobilizedBptPeople">
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptPeopleDemobilized">
			<model:field name="insanityFlag" type="string"/>
			<model:field name="oldLonelyFlag" type="string"/>
			<model:field name="orphanFlag" type="string"/>
			<model:field name="workAbilityCode" type="string"/>
			<model:field name="workAbilityDescribe" type="string"/>
			<model:field name="viabilityCode" type="string"/>
			<model:field name="supportPattern" type="string"/>
			<model:field name="jobStatusDescribe" type="string"/>
			<model:field name="bank" type="string"/>
			<model:field name="accountName" type="string"/>
			<model:field name="accountCode" type="string"/>
		</model:record>
	</model:dataset>
	
	<!-- 是否精神病标志 -->
	<model:dataset id="InsanityFlagEnum" enumName="COMM.YESORNO"  autoLoad="true" global="true"></model:dataset>
	<!-- 孤老标志 -->
	<model:dataset id="OldLonelyFlagEnum" enumName="COMM.YESORNO"  autoLoad="true" global="true"></model:dataset>
	<!-- 孤儿标志 -->
	<model:dataset id="OrphanFlagEnum" enumName="COMM.YESORNO"  autoLoad="true" global="true"></model:dataset>
	<!-- 劳动能力代码 -->
	<model:dataset id="WorkAbilityCodeEnum" enumName="WORK.ABILITY.CODE"  autoLoad="true" global="true"></model:dataset>
	<!-- 优抚生活能力代码 -->
	<model:dataset id="ViabilityCodeEnum" enumName="VIABILITY.CODE"  autoLoad="true" global="true"></model:dataset>
	<!-- 优抚供养方式 -->
	<model:dataset id="SupportPatternEnum" enumName="SUPPORT.PATTERN"  autoLoad="true" global="true"></model:dataset>
	<!-- 开户银行代码 -->
	<model:dataset id="BankEnum" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_BANK'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 是否抗美援朝-->
	<model:dataset id="KoeanwarEnum" enumName="COMM.YESORNO"  autoLoad="true" global="true"></model:dataset>
	<!-- 属于时期-->
	<model:dataset id="warDs"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='dic_bpt_war'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
</model:datasets>
<next:Panel  title="在乡复员军人"  autoWidth="true" autoWidth="true">
<next:TopBar >
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="undo" text="返回" handler="returnClick" />
	</next:TopBar>
	<next:Html>
		<form id="editForm"  dataset="PeopleDemobilizedDataset"  onsubmit="return false" style="padding: 5px;" class="L5form">
		<table border="1"  align="center">
		    <tr>
				<td  class="FieldLabel" nowrap>入伍时间：</td>
				<td class="FieldInput"><input type="text" name="conscriptDate" field="conscriptDate" format="Y-m-d" style="width: 100px;" maxlength="10" disabled="disabled" onpropertychange="changeDateStyle(this)" /><img  src="../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" > </td>
				<td  class="FieldLabel" nowrap>复员时间：</td>
				<td class="FieldInput"><input type="text" name="decruitmentDate" field="decruitmentDate" format="Y-m-d" style="width: 100px;" maxlength="10" disabled="disabled" onpropertychange="changeDateStyle(this)" /><img  src="../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" > </td>
			    <td  class="FieldLabel" nowrap>原部队代号：</td><td class="FieldInput"><input type="text" name="forcesNo" field="forcesNo" disabled="disabled" /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" nowrap>属于时期：</td>
				<td class="FieldInput"><select name="belongDate" field="belongDate" disabled="disabled"><option dataset="warDs"></option></select><font color="red">*</font></td>
			    <td  class="FieldLabel" nowrap>是否抗美援朝：</td>
			    <td class="FieldInput"><select name="isKoeanwar" field="isKoeanwar" disabled="disabled"><option dataset="KoeanwarEnum"></option></select><font color="red">*</font></td>
				<td  class="FieldLabel" nowrap>职务：</td><td class="FieldInput"><input type="text" name="position" field="position" disabled="disabled"/></td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" nowrap>复员证号：</td><td class="FieldInput"><input type="text" name="asdpNo" field="asdpNo" disabled="disabled"/></td>
				<td  class="FieldLabel" nowrap>是否精神病：</td>
				<td class="FieldInput"><select name="insanityFlag" field="insanityFlag" disabled="disabled"><option dataset="InsanityFlagEnum"></option></select><font color="red">*</font></td>
				<td  class="FieldLabel" nowrap>孤老标志：</td>
				<td class="FieldInput"><select name="oldLonelyFlag" field="oldLonelyFlag" disabled="disabled"><option dataset="OldLonelyFlagEnum"></option></select><font color="red">*</font></td>
			</tr>
			<tr>
				<td  class="FieldLabel" nowrap>孤儿标志：</td>
				<td class="FieldInput"><select name="orphanFlag" field="orphanFlag" disabled="disabled"><option dataset="OrphanFlagEnum"></option></select><font color="red">*</font></td>
				<td  class="FieldLabel" nowrap>劳动能力：</td>
				<td class="FieldInput"><select name="workAbilityCode" field="workAbilityCode" disabled="disabled"><option dataset="WorkAbilityCodeEnum"></option></select><font color="red">*</font></td>
				<td  class="FieldLabel"nowrap>优抚供养方式：</td>
				<td class="FieldInput"><select name="supportPattern" field="supportPattern" disabled="disabled"><option dataset="SupportPatternEnum"></option></select><font color="red">*</font></td>
			</tr>
	   		<tr>
				<td class="FieldLabel" nowrap>优抚生活能力：</td>
				<td class="FieldInput"><select name="viabilityCode" field="viabilityCode" disabled="disabled"><option dataset="ViabilityCodeEnum"></option></select><font color="red">*</font></td>
				<td class="FieldLabel" nowrap>开户银行：</td>
				<td class="FieldInput"><select name="bank" field="bank" disabled="disabled"><option dataset="BankEnum"></option></select></td>
				<td  class="FieldLabel" nowrap>开户名称：</td>
				<td class="FieldInput"><input type="text" name="accountName" field="accountName" disabled="disabled"/> </td>	
			</tr>
			<tr>
				<td  class="FieldLabel" nowrap>银行账号：</td>
				<td class="FieldInput"><input type="text" name="accountCode" field="accountCode" disabled="disabled"></input></td>
				<td  class="FieldLabel" nowrap>批准日期：</td>
				<td class="FieldInput"><input type="text" name="approvalDate" field="approvalDate" format="Y-m-d" style="width: 100px;" maxlength="10"  disabled="disabled" onpropertychange="changeDateStyle(this)" /><img  src="../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" > </td>
				<td  class="FieldLabel" nowrap>注销日期：</td>
				<td class="FieldInput"><input type="text" name="cancellationDate" field="cancellationDate" format="Y-m-d" style="width: 100px;" maxlength="10"  disabled="disabled" onpropertychange="changeDateStyle(this)" /><img  src="../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" > </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" nowrap>劳动能力描述：</td>
				<td  class="FieldInput" colspan="5"><textarea rows="3" cols="155" name="workAbilityDescribe" field="workAbilityDescribe" disabled="disabled"></textarea></td>
			</tr>
			<tr>
				<td  class="FieldLabel" nowrap>就业情况描述：</td>
				<td class="FieldInput" colspan="5"><textarea rows="3" cols="155" name="jobStatusDescribe" field="jobStatusDescribe" disabled="disabled"></textarea></td>
			</tr>
			<tr>
				<td  class="FieldLabel" nowrap>备注：</td>
				<td class="FieldInput" colspan="5"><textarea rows="3" cols="155" name="note" field="note"  disabled="disabled"></textarea></td>
			</tr>
								<!--录入人ID-->
								<input type="hidden" name="regId" field="regId">
								<!--录入时间-->
								<input type="hidden" name="regTime" field="regTime">
								<!--修改人ID-->
								<input type="hidden" name="modId" field="modId">
								<!--修改时间-->
								<input type="hidden" name="modTime" field="modTime">			
		</table>
		</form>
   </next:Html>
</next:Panel>
			
</body>
</html>
