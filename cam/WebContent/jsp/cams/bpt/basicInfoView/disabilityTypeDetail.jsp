<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>类别信息——伤残人员</title>
<next:ScriptManager />
		<script>
			var peopleId='<%=request.getParameter("peopleId")%>';
		</script>
<script type="text/javascript" src="disabilityTypeDetail.js"></script>
</head>
<body>
<model:datasets>

	<!-- 伤残信息 -->
	<model:dataset id="BptPeopleDisabilityDataSet" cmd="com.inspur.cams.bpt.manage.cmd.BptPeopleDisabilityQueryCommand" method="queryPeopleDisabilityInfo" global="true">
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptPeopleDisability">
			<model:field name="disabilityTypeCode" type="string" rule="require"/>
			<model:field name="insanityFlag" type="string" rule="require"/>
			<model:field name="oldLonelyFlag" type="string" rule="require"/>
			<model:field name="toWorkDate" type="string" />
			<model:field name="retiredDate" type="string" />
			<model:field name="orphanFlag" type="string" rule="require"/>
			<model:field name="workAbilityCode" type="string" rule="require"/>
			<model:field name="workAbilityDescribe" type="string" />
			<model:field name="viabilityCode" type="string" rule="require"/>
			<model:field name="supportPattern" type="string" rule="require"/>
			<model:field name="jobStatusDescribe" type="string" rule="require"/>
			<model:field name="bank" type="string"/>
			<model:field name="accountName" type="string" />
			<model:field name="accountCode" type="string" />
			<model:field name="disabilityStateCode" type="string" rule="require" rule="require"/>
			<model:field name="disabilityNo" type="string" rule="require" rule="require"/>
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
	<model:dataset id="InsanityFlagEnum" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	
	<!-- 孤老标志 -->
	<model:dataset id="OldLonelyFlagEnum" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	
	<!-- 孤儿标志 -->
	<model:dataset id="OrphanFlagEnum" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	
	<!-- 劳动能力代码 -->
	<model:dataset id="WorkAbilityCodeEnum" enumName="WORK.ABILITY.CODE" autoLoad="true" global="true"></model:dataset>
	
	<!-- 优抚生活能力代码 -->
	<model:dataset id="ViabilityCodeEnum" enumName="VIABILITY.CODE" autoLoad="true" global="true"></model:dataset>
	
	<!-- 优抚供养方式 -->
	<model:dataset id="SupportPatternEnum" enumName="SUPPORT.PATTERN" autoLoad="true" global="true"></model:dataset>
	 
	<!-- 伤残类别代码 -->
	<model:dataset id="DisabilityTypeCodeEnum" enumName="DISABILITY.TYPE.CODE" autoLoad="true" global="true"></model:dataset>
	
	<!-- 伤残业务类型 -->
	<model:dataset id="ServiceTypeDataSet" enumName="DISABILITY.SERVICE.TYPE" autoLoad="true" global="true"></model:dataset>
	
	<!-- 优抚对象状态 -->
	<model:dataset id="ObjectStateDataset" enumName="OBJECT.STATE" autoLoad="true" global="true"></model:dataset>
	
	<!-- 伤残性质 -->
	<model:dataset id="DisabilityCaseDataset" enumName="CASE.CODE" autoLoad="true" global="true"></model:dataset>
	<!-- 伤残等级 -->
	<model:dataset id="DisabilityLevelDataset" enumName="LEVEL.CODE" autoLoad="true" global="true"></model:dataset>
	<!-- 伤残属别 -->
	<model:dataset id="DisabilityGenusDataset" enumName="GENUS.CODE" autoLoad="true" global="true"></model:dataset>
	<!-- 伤残时期 -->
	<model:dataset id="BptWarDataset" enumName="WAR.CODE" autoLoad="true" global="true"></model:dataset>
<!-- 是否抗美援朝 -->
	<model:dataset id="isKoreaWarDataset" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
</model:datasets>

			<next:Panel height="100%" autoScroll="true" width="100%">
				<next:Html>
					<fieldset>
					<form id="BptPeopleDisabilityForm" method="post"
						dataset="BptPeopleDisabilityDataSet" onsubmit="return false"
						style="padding: 5px;" class="L5form">
					<table border="1" width="98%">
						<tr>
							
							<td class="FieldLabel" >伤残类别：</td>
							<td class="FieldInput" ><label name="disabilityTypeCode" field="disabilityTypeCode" dataset="DisabilityTypeCodeEnum"></label></td>
							
							<td class="FieldLabel" >伤残等级：</td>
							<td class="FieldInput" ><label name="disabilityLevelCode" field="disabilityLevelCode" dataset="DisabilityLevelDataset"></label></td>
							
							<td class="FieldLabel" >伤残性质：</td>
							<td class="FieldInput" ><label name="disabilityCaseCode" field="disabilityCaseCode" dataset="DisabilityCaseDataset"></label></td>
						</tr>
						
						<tr>
							<td class="FieldLabel" >优抚对象状态：</td>
							<td class="FieldInput" ><label name="disabilityStateCode" field="disabilityStateCode" dataset="ObjectStateDataset"></label></td>
							
							<td class="FieldLabel" >证书编号：</td>
							<td class="FieldInput" ><label name="disabilityNo" field="disabilityNo"/></td>
						
							<td  class="FieldLabel" >批准日期：</td>
							<td class="FieldInput"><label name="approveDate" field="approveDate"/></td>
						</tr>

						<tr>
							<td class="FieldLabel"  nowrap="nowrap">入伍(参加工作)时间：</td>
							<td class="FieldInput" ><label name="relationshipType" field="conscriptDate" /></td>
								
							<td class="FieldLabel"  nowrap="nowrap">退伍时间：</td>
							<td class="FieldInput" ><label name="veteransDate" field="veteransDate"/></td>
						
							<td class="FieldLabel"  nowrap="nowrap">离退休时间：</td>
							<td class="FieldInput" ><label name="retiredDate" field="retiredDate"/></td>
						</tr>
						<tr>
							<td class="FieldLabel" >伤残时期：</td>
							<td class="FieldInput" >
							<input type="hidden"
								name="disabilityWarCode" field="disabilityWarCode" dataset="BptWarDataset"  onchange="KoreaWar(this)" />
							<label name="disabilityWarCode" field="disabilityWarCode" dataset="BptWarDataset"></label></td>
							<td class="FieldLabel" id="k1">是否抗美援朝：</td>
							<td class="FieldInput" id="k2">
							<label name="isKoreaWar" field="isKoreaWar" dataset="isKoreaWarDataset"></label>
							</td>
							<td class="FieldLabel" >伤残属别：</td>
							<td class="FieldInput" colspan="3"><label name="disabilityGenusCode" field="disabilityGenusCode" dataset="DisabilityGenusDataset"></label></td>
							
						</tr>
						<tr>
							<td class="FieldLabel" >致残时间：</td>
							<td class="FieldInput"><label name="disabilityDate" field="disabilityDate"/></td>
							
							<td class="FieldLabel" nowrap="nowrap">致残时所在单位：</td>
							<td class="FieldInput" colspan="3"><label name="uinitOfDisability" field="uinitOfDisability"/></td>
							
						</tr>
						
						<tr>
							<td class="FieldLabel" >致残地点：</td>
							<td class="FieldInput" colspan="5"><label name="disabilityAdd" field="disabilityAdd"/></td>
						</tr>
						
						<tr>		
							<td class="FieldLabel" >致残情况：</td>
							<td class="FieldInput" colspan="5"><label name="disabilityBody" field="disabilityBody"/></td>
						</tr>
								
						<tr>
							<td class="FieldLabel" >致残原因：</td>
							<td class="FieldInput"  colspan="5"><label name="disabilityReason" field="disabilityReason"></label></td>

						</tr>
						
						<tr>
							<td class="FieldLabel">是否孤老:</td>
							<td class="FieldInput"><label name="oldLonelyFlag" field="oldLonelyFlag" dataset="OldLonelyFlagEnum"></label></td>
							
							<td class="FieldLabel">是否孤儿:</td>
							<td class="FieldInput"><label name="orphanFlag" field="orphanFlag" dataset="OldLonelyFlagEnum"></label></td>
							
							<td class="FieldLabel">是否精神病：</td>
							<td class="FieldInput"><label name="insanityFlag" field="insanityFlag" dataset="InsanityFlagEnum"></label></td>
						</tr>
						
						<tr>
							<td class="FieldLabel">劳动能力：</td>
							<td class="FieldInput"><label name="workAbilityCode" field="workAbilityCode" dataset="WorkAbilityCodeEnum"></label></td>

							<td class="FieldLabel">生活能力：</td>
							<td class="FieldInput"><label name="viabilityCode" field="viabilityCode" dataset="ViabilityCodeEnum"></label></td>
							
							<td class="FieldLabel" nowrap="nowrap">供养方式：</td>
							<td class="FieldInput"><label name="supportPattern" field="supportPattern" dataset="SupportPatternEnum"></label></td>
						
						</tr>
						<tr>
							<td  class="FieldLabel" >开户银行：</td>
							<td class="FieldInput"><label name="bank" field="bank" dataset="BankEnum"></label></td>
							
							<td  class="FieldLabel" >开户名称：</td>
							<td class="FieldInput"><label name="accountName" field="accountName"/> </td>

							<td  class="FieldLabel" >银行账号：</td>
							<td class="FieldInput"  ><label name="accountCode" field="accountCode"></label></td>
						</tr>
						
						<tr>
							<td class="FieldLabel">备注：</td>
							<td class="FieldInput" colspan="5"><label name="note" field="note"></label></td>
						</tr>

					</table>
					</form>
					</fieldset>
				</next:Html>
			</next:Panel>
</body>
</html>
