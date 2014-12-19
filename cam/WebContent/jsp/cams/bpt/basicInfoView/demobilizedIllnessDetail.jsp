<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>带病回乡退伍军人明细查看</title>
<next:ScriptManager />
<script>
			var peopleId = '<%=request.getParameter("peopleId")%>' ;
		</script>
<script type="text/javascript" src="demobilizedIllnessDetail.js"></script>
</head>
<body>
<model:datasets>
	<!-- 带病回乡退伍军人 -->
	<model:dataset id="DemobilizedIllnessDataset"
		cmd="com.inspur.cams.bpt.manage.cmd.BptPeopleDemobilizedIllnessQueryCommand"
		method="queryDemobilizedIllnessBPTPeople" global="true">
		<model:record
			fromBean="com.inspur.cams.bpt.base.data.BptPeopleDemobilizedIllness">
			<model:field name="demobilizedStateCode" type="string" />
			<model:field name="demobilizedNo" type="string" />

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
		</model:record>
	</model:dataset>
	<!-- 身体状况 -->
	<model:dataset id="PhysiclalStatusEnum" enumName="PHYSICLAL.STATUS"
		autoLoad="true" global="true"></model:dataset>
	<!-- 是否精神病标志 -->
	<model:dataset id="InsanityFlagEnum" enumName="COMM.YESORNO"
		autoLoad="true" global="true"></model:dataset>
	<!-- 孤老标志 -->
	<model:dataset id="OldLonelyFlagEnum" enumName="COMM.YESORNO"
		autoLoad="true" global="true"></model:dataset>
	<!-- 孤儿标志 -->
	<model:dataset id="OrphanFlagEnum" enumName="COMM.YESORNO"
		autoLoad="true" global="true"></model:dataset>
	<!-- 劳动能力代码 -->
	<model:dataset id="WorkAbilityCodeEnum" enumName="WORK.ABILITY.CODE"
		autoLoad="true" global="true"></model:dataset>
	<!-- 优抚生活能力代码 -->
	<model:dataset id="ViabilityCodeEnum" enumName="VIABILITY.CODE"
		autoLoad="true" global="true"></model:dataset>
	<!-- 优抚供养方式 -->
	<model:dataset id="SupportPatternEnum" enumName="SUPPORT.PATTERN"
		autoLoad="true" global="true"></model:dataset>
	<!-- 家庭经济状况 -->
	<model:dataset id="FamilyEconomicsEnum" enumName="FAMILY.ECONOMICS"
		autoLoad="true" global="true"></model:dataset>
	<!-- 开户银行代码 -->
	<model:dataset id="BankEnum" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_BANK'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 是否参战 -->
	<model:dataset id="isWarEnum" enumName="COMM.YESORNO" autoLoad="true"
		global="true"></model:dataset>
	<!-- 是否涉核 -->
	<model:dataset id="isInnuclearEnum" enumName="COMM.YESORNO"
		autoLoad="true" global="true"></model:dataset>
	<!-- 优抚对象状态 -->
	<model:dataset id="ObjectStateDataset" enumName="OBJECT.STATE"
		autoLoad="true" global="true"></model:dataset>
</model:datasets>

<next:Panel title="带病回乡退伍军人" autoHeight="true" autoWidth="true">
	<next:Html>
		<form id="editForm" dataset="DemobilizedIllnessDataset"
			onsubmit="return false" style="padding: 5px;" class="L5form">
		<table border="1" border="0" width="99%">
			<tr>
				<td class="FieldLabel">优抚对象状态：</td>
				<td class="FieldInput"><label name="demobilizedStateCode"
					field="demobilizedStateCode" dataset="ObjectStateDataset"></label></td>
				<td class="FieldLabel">生活补助证编号:</td>
				<td class="FieldInput"><label name="demobilizedNo"
					field="demobilizedNo" title="生活补助证编号"></label></td>
				<td class="FieldLabel" nowrap>批准日期：</td>
				<td class="FieldInput"><label name="approvalDate"
					field="approvalDate"></label></td>
			</tr>
			<tr>
				<td class="FieldLabel" nowrap>入伍时间：</td>
				<td class="FieldInput"><label name="conscriptDate"
					field="conscriptDate"></label></td>
				<td class="FieldLabel" nowrap>退伍时间：</td>
				<td class="FieldInput"><label name="decruitmentDate"
					field="decruitmentDate"></label></td>
				<td class="FieldLabel" nowrap>退伍证号：</td>
				<td class="FieldInput"><label name="asdpNo" field="asdpNo"></label></td>
			</tr>
			<tr>
				<td class="FieldLabel" nowrap>职务：</td>
				<td class="FieldInput"><label name="position" field="position"></label></td>
				<td class="FieldLabel" nowrap>是否参战：</td>
				<td class="FieldInput"><label name="isWar" field="isWar"
					dataset="isWarEnum"></label></td>
				<td class="FieldLabel" nowrap>是否参试：</td>
				<td class="FieldInput"><label name="isInnuclear"
					field="isInnuclear" dataset="isInnuclearEnum"></label></td>

			</tr>

			<tr>
				<td class="FieldLabel" nowrap>是否孤老：</td>
				<td class="FieldInput"><label name="oldLonelyFlag"
					field="oldLonelyFlag" dataset="OldLonelyFlagEnum"></label></td>

				<td class="FieldLabel" nowrap>是否精神病：</td>
				<td class="FieldInput"><label name="insanityFlag"
					field="insanityFlag" dataset="InsanityFlagEnum"></label></td>

				<td class="FieldLabel" nowrap>劳动能力：</td>
				<td class="FieldInput"><label name="workAbilityCode"
					field="workAbilityCode" dataset="WorkAbilityCodeEnum"></label></td>
			</tr>
			<tr>

				<td class="FieldLabel" nowrap>生活能力：</td>
				<td class="FieldInput"><label name="viabilityCode"
					field="viabilityCode" dataset="ViabilityCodeEnum"></label></td>

				<td class="FieldLabel" nowrap>供养方式：</td>
				<td class="FieldInput"><label name="supportPattern"
					field="supportPattern" dataset="SupportPatternEnum"></label></td>

				<td class="FieldLabel" nowrap>身体状况：</td>
				<td class="FieldInput"><label name="physiclalStatus"
					field="physiclalStatus" dataset="PhysiclalStatusEnum"></label></td>
			</tr>
			<tr>

				<td class="FieldLabel" nowrap>开户银行：</td>
				<td class="FieldInput"><label name="bank" field="bank"
					dataset="BankEnum"></label></td>
				<td class="FieldLabel" nowrap>开户名称：</td>
				<td class="FieldInput"><label name="accountName"
					field="accountName"></label></td>
				<td class="FieldLabel" nowrap>银行账号：</td>
				<td class="FieldInput"><label name="accountCode"
					field="accountCode" style="width: 200"></label></td>
			</tr>
			<tr>
				<td class="FieldLabel" nowrap>家庭经济状况：</td>
				<td class="FieldInput" colspan="5"><label
					name="familyEconomics" field="familyEconomics"
					dataset="FamilyEconomicsEnum"></label></td>
			</tr>
			<tr>
				<td class="FieldLabel" nowrap>在部队期间患病信息：</td>
				<td class="FieldInput" colspan="5"><label name="illessInfo"
					field="illessInfo"></label></td>
			</tr>

			<tr>
				<td class="FieldLabel" nowrap>备注：</td>
				<td class="FieldInput" colspan="5"><label name="note"
					field="note" style="width: 200" /></td>
			</tr>
		</table>
		</form>
	</next:Html>
</next:Panel>

</body>
</html>
