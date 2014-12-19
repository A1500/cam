<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>伤残人员明细查看</title>
<next:ScriptManager />
		<script>
			var peopleId = <%=request.getParameter("peopleId")%> ;
		</script>
<script type="text/javascript" src="disabilityDetail.js"></script>
</head>
<body>
<model:datasets>
	<!-- 伤残信息 -->
	<model:dataset id="BptPeopleDisabilityDataSet" cmd="com.inspur.cams.bpt.manage.cmd.BptPeopleDisabilityQueryCommand" method="queryPeopleDisabilityInfo" global="true">
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptPeopleDisability">
			<model:field name="disabilityTypeCode" type="string" />
			<model:field name="insanityFlag" type="string" />
			<model:field name="oldLonelyFlag" type="string" />
			<model:field name="orphanFlag" type="string" />
			<model:field name="workAbilityCode" type="string" />
			<model:field name="workAbilityDescribe" type="string" />
			<model:field name="viabilityCode" type="string" />
			<model:field name="supportPattern" type="string" />
			<model:field name="jobStatusDescribe" type="string" />
			<model:field name="bank" type="string"/>
			<model:field name="accountName" type="string"/>
			<model:field name="accountCode" type="string"/>
		</model:record>
	</model:dataset>
	<!-- 开户银行代码 -->
	<model:dataset id="BankEnum" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_BANK'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
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
	<!-- 伤残类别代码 -->
	<model:dataset id="DisabilityTypeCodeEnum"
		enumName="DISABILITY.TYPE.CODE" autoLoad="true" global="true"></model:dataset>
	<!-- 伤残业务类型 -->
	<model:dataset id="ServiceTypeDataSet"
		enumName="DISABILITY.SERVICE.TYPE" autoLoad="true" global="true"></model:dataset>
	<!-- 伤残性质 -->
	<model:dataset id="DisabilityCaseDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_DISABILITY_CASE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 伤残等级 -->
	<model:dataset id="DisabilityLevelDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_DISABILITY_LEVEL'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 伤残属别 -->
	<model:dataset id="DisabilityGenusDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_DISABILITY_GENUS'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 伤残时期 -->
	<model:dataset id="BptWarDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_BPT_WAR'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>

</model:datasets>

			<next:Panel title="伤残信息" autoHeight="true" autoWidth="true">
				<next:Html>
					<fieldset>
					<form id="BptPeopleDisabilityForm" method="post"
						dataset="BptPeopleDisabilityDataSet" onsubmit="return false"
						style="padding: 5px;" class="L5form">
					<table border="1" width="80%">

						<tr>
							<td class="FieldLabel" style="width: 15%" nowrap="nowrap">入伍（参加工作）时间：</td>
							<td class="FieldInput" style="width: 35%"><label name="relationshipType" field="conscriptDate" /></td>
								
							<td class="FieldLabel" style="width: 15%" nowrap="nowrap">退伍（离退休）时间：</td>
							<td class="FieldInput" style="width: 35%"><label name="veteransDate" field="veteransDate" /></td>
						</tr>

						<tr>
							<td class="FieldLabel" style="width: 15%">伤残时期：</td>
							<td class="FieldInput" style="width: 35%"><label name="disabilityWarCode" field="disabilityWarCode" dataset="BptWarDataset"></label></td>
							
							<td class="FieldLabel" style="width: 15%">伤残等级：</td>
							<td class="FieldInput" style="width: 35%"><label name="disabilityLevelCode" field="disabilityLevelCode" dataset="DisabilityLevelDataset"></label></td>
						</tr>

						<tr>
							<td class="FieldLabel" style="width: 15%">伤残属别：</td>
							<td class="FieldInput" style="width: 35%"><label name="disabilityGenusCode" field="disabilityGenusCode" dataset="DisabilityGenusDataset"></label></td>

							<td class="FieldLabel" style="width: 15%">伤残类别：</td>
							<td class="FieldInput" style="width: 35%"><label name="disabilityTypeCode" field="disabilityTypeCode" dataset="DisabilityTypeCodeEnum"></label></td>
						</tr>
						
						<tr>
							<td class="FieldLabel" style="width: 15%">伤残性质：</td>
							<td class="FieldInput" style="width: 35%" colspan="3">
									<label name="disabilityCaseCode" field="disabilityCaseCode" dataset="DisabilityCaseDataset"></label></td>
						</tr>

						<tr>
							<td class="FieldLabel">致残时所在单位：</td>
							<td class="FieldInput"><label name="uinitOfDisability" field="uinitOfDisability" /></td>

							<td class="FieldLabel" style="width: 15%">致残时间：</td>
							<td class="FieldInput" style="width: 35%"><label name="disabilityDate" field="disabilityDate" /></td>
						</tr>
						
						<tr>
							<td class="FieldLabel" style="width: 15%">致残地点：</td>
							<td class="FieldInput" style="width: 35%"><label name="disabilityAdd" field="disabilityAdd" /></td>
							
							<td class="FieldLabel" style="width: 15%">致残情况：</td>
							<td class="FieldInput" style="width: 35%"><label name="disabilityBody" field="disabilityBody" /></td>
						</tr>
						
						<tr>
							<td class="FieldLabel">是否精神病：</td>
							<td class="FieldInput"><label name="insanityFlag" field="insanityFlag" dataset="InsanityFlagEnum"></label></td>
							
							<td class="FieldLabel">优抚供养方式：</td>
							<td class="FieldInput"><label name="supportPattern" field="supportPattern" dataset="SupportPatternEnum"></label></td>
						</tr>
						
						<tr>
							<td class="FieldLabel" style="width: 15%">致残原因：</td>
							<td class="FieldInput" style="width: 35%" colspan="3"><label
								rows="3" cols="122%" name="disabilityReason"
								field="disabilityReason"></label></td>

						</tr>
						<tr>
							<td class="FieldLabel">孤老标志：</td>
							<td class="FieldInput"><label name="oldLonelyFlag" field="oldLonelyFlag" dataset="OldLonelyFlagEnum"></label></td>
							<td class="FieldLabel">孤儿标志：</td>
							<td class="FieldInput"><label name="orphanFlag" field="orphanFlag" dataset="OrphanFlagEnum"></label></td>
						</tr>
						<tr>
							<td class="FieldLabel">劳动能力：</td>
							<td class="FieldInput"><label name="workAbilityCode" field="workAbilityCode" dataset="WorkAbilityCodeEnum"></label></td>

							<td class="FieldLabel">优抚生活能力：</td>
							<td class="FieldInput"><label name="viabilityCode" field="viabilityCode" dataset="ViabilityCodeEnum"></label></td>
						</tr>
						<tr>
							<td class="FieldLabel">劳动能力描述：</td>
							<td class="FieldInput" colspan="3"><label rows="2"
								cols="122%" name="workAbilityDescribe"
								field="workAbilityDescribe"></label></td>
						</tr>
						
						<tr>
							<td class="FieldLabel">就业情况描述：</td>
							<td class="FieldInput" colspan="3"><label rows="2"
								cols="122%" name="jobStatusDescribe" field="jobStatusDescribe"></label></td>
						</tr>

						<tr>
							<td  class="FieldLabel" >开户银行：</td>
							<td class="FieldInput"><label name="bank" field="bank" dataset="BankEnum"></label></td>
							
							<td  class="FieldLabel" >开户名称：</td>
							<td class="FieldInput"><label name="accountName" field="accountName" /> </td>
						</tr>
						
						<tr>
							<td  class="FieldLabel" >银行账号：</td>
							<td class="FieldInput" colspan="3"><label type="text" name="accountCode" field="accountCode" style="width:500" ></input></td>
						</tr>

						<tr>
							<td class="FieldLabel" style="width: 15%">备注：</td>
							<td class="FieldInput" style="width: 35%" colspan="3"><label
								rows="3" cols="122%" name="note" field="note"></label></td>
						</tr>

					</table>
					</form>
					</fieldset>
				</next:Html>
			</next:Panel>
</body>
</html>
