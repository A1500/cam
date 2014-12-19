<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.IdHelp"%>
<html>
<head>
<title>参战人员信息</title>
<next:ScriptManager />
<script>
			var peopleId=<%=request.getParameter("peopleId")%>;
		</script>
<script type="text/javascript" src="bptwarUpdate.js"></script>
</head>
<body>
<model:datasets>
	<!-- 参战人员信息 -->
	<model:dataset id="dsWar" cmd="com.inspur.cams.bpt.manage.cmd.BptPeopleWarQueryCommand" global="true" method="queryPeopleWarInfo">
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptPeopleWar">
			<model:field name="warNo" type="string" />
			<model:field name="approveDate" type="string" />
			<model:field name="insanityFlag" type="string" />
			<model:field name="oldLonelyFlag" type="string" />
			<model:field name="orphanFlag" type="string" />
			<model:field name="workAbilityCode" type="string" />
			<model:field name="workAbilityDescribe" type="string" />
			<model:field name="viabilityCode" type="string" />
			<model:field name="supportPattern" type="string" />
			<model:field name="jobStatusDescribe" type="string" />
			<model:field name="bank" type="string" />
			<model:field name="accountName" type="string" />
			<model:field name="accountCode" type="string" />
			<model:field name="warStateCode" type="string" />
			 <model:field name="healthStateName" type="string"/>
		</model:record>
	</model:dataset>
	<!--生活状况代码-->
	<model:dataset id="dsLife" enumName="LIFE.LIFE_STATE_CODE" autoLoad="true"></model:dataset>
	<!-- 开户银行代码 -->
	<model:dataset id="BankEnum" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_BANK'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>

	<!--参战类别代码-->
	<model:dataset id="dsWarData" cmd="com.inspur.cams.bpt.manage.cmd.DicHealthQueryCommand" global="true" autoLoad="true" method="getAllWaraData">
		<model:record fromBean="com.inspur.cams.bpt.base.data.DicHealth">
			<model:field name="value" mapping="CODE" />
			<model:field name="text" mapping="NAME" />
		</model:record>
	</model:dataset>
	<!-- 优抚对象状态 -->
	<model:dataset id="ObjectStateDataset" enumName="OBJECT.STATE" autoLoad="true" global="true"></model:dataset>
	<!-- 优抚供养方式 -->
	<model:dataset id="SupportPatternEnum" enumName="SUPPORT.PATTERN" autoLoad="true" global="true"></model:dataset>
	<!-- 孤老标志 -->
	<model:dataset id="OldLonelyFlagEnum" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<!-- 孤儿标志 -->
	<model:dataset id="OrphanFlagEnum" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<!-- 劳动能力代码 -->
	<model:dataset id="WorkAbilityCodeEnum" enumName="WORK.ABILITY.CODE"
		autoLoad="true" global="true"></model:dataset>
	<!-- 优抚生活能力代码 -->
	<model:dataset id="ViabilityCodeEnum" enumName="VIABILITY.CODE"
		autoLoad="true" global="true"></model:dataset>
	<!-- 优抚供养方式 -->
	<model:dataset id="SupportPatternEnum" enumName="SUPPORT.PATTERN"
		autoLoad="true" global="true"></model:dataset>
	<!-- 健康状况 -->
	<model:dataset id="HealthDataset" enumName="HEALTH.TYPE"
		autoLoad="true" global="true"></model:dataset>
	<!-- 是否精神病标志 -->
	<model:dataset id="InsanityFlagEnum" enumName="COMM.YESORNO"
		autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:Panel title="参战基本信息" height="100%" width="100%" autoScroll="true">
	<next:Html>
		<form id="editForm" dataset="dsWar" onsubmit="return false"
			style="padding: 5px;" class="L5form">
		<table border="0" width="98%" align="left">
			<tr>
				<td class="FieldLabel" nowrap>优抚对象状态：</td>
				<td class="FieldInput"><label name="warStateCode"
					field="warStateCode" dataset="ObjectStateDataset" title="优抚对象状态"/></td>

				<td class="FieldLabel" nowrap>生活补助证编号：</td>
				<td class="FieldInput"><label name="warNo" field="warNo" title="生活补助证编号"/></td>

				<td class="FieldLabel" nowrap>批准日期：</td>
				<td class="FieldInput"><label name="approvalDate"
					field="approvalDate" title="批准日期"/></td>
			</tr>
			<tr>
				<td class="FieldLabel" nowrap>入伍（参加工作）时间：</td>
				<td class="FieldInput"><label name="conscriptcDate"
					field="conscriptcDate" title="入伍(参加工作)时间"/></td>

				<td class="FieldLabel" nowrap>退伍时间：</td>
				<td class="FieldInput"><label name="decruitmentDate"
					field="decruitmentDate" title="退伍时间"/></td>

				<td class="FieldLabel" nowrap>离退休时间：</td>
				<td class="FieldInput"><label name="retiredDate"
					field="retiredDate" title="离退休时间"/></td>
			</tr>
			<tr>
				<td class="FieldLabel" nowrap>退伍证号：</td>
				<td class="FieldInput"><label name="asdpNo" field="asdpNo" title="退伍证号"/></td>

				<td class="FieldLabel" nowrap>原部队代号：</td>
				<td class="FieldInput"><label name="forcesNo" field="forcesNo" title="原部队代号"/></td>

				<td class="FieldLabel" nowrap>职务（级别）：</td>
				<td class="FieldInput"><label name="position" field="position" title="职务(级别)"/></td>
			</tr>
			<tr>


				<td class="FieldLabel" nowrap>参战类别：</td>
				<td class="FieldInput"><label name="warTypeCode"
					field="warTypeCode" dataset="dsWarData" title="参战类别"/></td>

				<td class="FieldLabel" nowrap>是否孤老：</td>
				<td class="FieldInput"><label name="oldLonelyFlag"
					field="oldLonelyFlag" dataset="OldLonelyFlagEnum" title="是否孤老"/></td>

				<td class="FieldLabel" nowrap>是否精神病：</td>
				<td class="FieldInput"><label name="insanityFlag"
					field="insanityFlag" dataset="InsanityFlagEnum" title="是否精神病"/></td>
			</tr>
			<tr>

				<td class="FieldLabel" nowrap>劳动能力：</td>
				<td class="FieldInput"><label name="workAbilityCode"
					field="workAbilityCode" dataset="WorkAbilityCodeEnum" title="劳动能力"/></td>

				<td class="FieldLabel" nowrap>生活能力：</td>
				<td class="FieldInput"><label name="viabilityCode"
					field="viabilityCode" dataset="ViabilityCodeEnum" title="生活能力"/></td>


				<td class="FieldLabel" nowrap>供养方式：</td>
				<td class="FieldInput"><label name="supportPattern"
					field="supportPattern" dataset="SupportPatternEnum" title="供养方式"/></td>
			</tr>

			<tr>
				<td class="FieldLabel" nowrap>健康状况：</td>
							<td class="FieldInput" ><label type="text" id="healthStateName" name="healthStateName" field="healthStateName" title="健康状况" 
							   /><input type="hidden" id="healthStateCode"/></td>
				
				<td class="FieldLabel" nowrap>生活状况：</td>
				<td class="FieldInput" colspan="3"><label name="lifeStateCode"
					field="lifeStateCode" dataset="dsLife" title="生活状况"/></td>
			</tr>
			<tr>
				<td class="FieldLabel" nowrap>开户银行：</td>
				<td class="FieldInput"><label name="bank" field="bank"
					dataset="BankEnum" title="开户银行"/></td>
				<td class="FieldLabel" nowrap>开户名称：</td>
				<td class="FieldInput"><label name="accountName"
					field="accountName" title="开户名称"/></td>
				<td class="FieldLabel" nowrap>银行账号：</td>
				<td class="FieldInput" colspan="5"><label name="accountCode"
					field="accountCode" title="银行账号"/></td>
			</tr>
			<tr>
				<td class="FieldLabel" nowrap>备注(基本信息)：</td>
				<td class="FieldInput" colspan="5"><label name="note"
					field="note" title="备注(类别信息)"/></td>

			</tr>
		</table>
		</form>
	</next:Html>
</next:Panel>


</body>
</html>
